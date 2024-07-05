Return-Path: <linux-kernel+bounces-241985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF8B928230
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 08:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECDD928642D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 06:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A775143C75;
	Fri,  5 Jul 2024 06:39:35 +0000 (UTC)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AC9143C67
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 06:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720161574; cv=none; b=el/c1Rhjq13hofKczl4GU6m8/Gz7EA70zcKBcbCKg5ax4vypDCWJnbs9E/rt1fQcCpLj4Y8aq/wxVvOKom0ZcqvUI2c71WYh4LnViEwleFmR3mNKVdlwCZeIrV1Cr4zvrqGYB3zaZQWEKCqiuhYrKWqiKFH9ceMSYtZEGq06PsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720161574; c=relaxed/simple;
	bh=T6WXve0n+9VmVGeDaboQtLJzrhucQ2UYIegpdvEOqWw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eiuIT073LqsysAO573XrzR+ZFvn9mRZGralme+eVn3RXnLd2Opo8MfwmnjpwiHQpKofVJ/Y64ayVn109D7UFZGJXLRmvyLSm8zS7faueoPyEAnBVE147wMRrWb60klqIm/hUjEVDAK1amDzwhQ4yUpZ9V3LVhCDf0oUYtvZNiKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtp78t1720161421tw7m3sff
X-QQ-Originating-IP: LYIHzovVFZOArs2YxlwrPYbU/gSDF54QBMa15JEv6mY=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 05 Jul 2024 14:37:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 18219518563782160415
From: tuhaowen <tuhaowen@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: alexander.deucher@amd.com,
	huangbibo@uniontech.com,
	linux-kernel@vger.kernel.org,
	sudipm.mukherjee@gmail.com,
	tuhaowen@uniontech.com,
	wangyuli@uniontech.com
Subject: Re: Re: [PATCH] dev/parport: fix the array out-of-bounds risk
Date: Fri,  5 Jul 2024 14:36:58 +0800
Message-Id: <20240705063658.8782-1-tuhaowen@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <2024070413-obsessive-stack-7c62@gregkh>
References: <2024070413-obsessive-stack-7c62@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

On Thu, Jul 04, 2024 at 06:07:47PM +0800, Greg Kroah-Hartman wrote:

> Usually because no one actually has this hardware anymore :)
> 
> Can you also properly test the buffer size when writing into it so that
> even if the math is incorrect, it will not overflow?


As of now, I have encountered these three devices: BUNET BU1L02,
EB-LINK EB-2C1B01, and SYBA FG-EMT03A-N. When these PCIe to parallel
port cards are installed, the system experiences abnormal reboots.
I am not sure if there are other devices with these issues.

Below is the stack trace I encountered during the actual issue:

[ 66.575408s] [pid:5118,cpu4,QThread,4]Kernel panic - not syncing: stack-protector:
Kernel stack is corrupted in: do_hardware_base_addr+0xcc/0xd0 [parport]
[ 66.575408s] [pid:5118,cpu4,QThread,5]CPU: 4 PID: 5118 Comm:
QThread Tainted: G S W O 5.10.97-arm64-desktop #7100.57021.2
[ 66.575439s] [pid:5118,cpu4,QThread,6]TGID: 5087 Comm: EFileApp
[ 66.575439s] [pid:5118,cpu4,QThread,7]Hardware name: HUAWEI HUAWEI QingYun
PGUX-W515x-B081/SP1PANGUXM, BIOS 1.00.07 04/29/2024
[ 66.575439s] [pid:5118,cpu4,QThread,8]Call trace:
[ 66.575469s] [pid:5118,cpu4,QThread,9] dump_backtrace+0x0/0x1c0
[ 66.575469s] [pid:5118,cpu4,QThread,0] show_stack+0x14/0x20
[ 66.575469s] [pid:5118,cpu4,QThread,1] dump_stack+0xd4/0x10c
[ 66.575500s] [pid:5118,cpu4,QThread,2] panic+0x1d8/0x3bc
[ 66.575500s] [pid:5118,cpu4,QThread,3] __stack_chk_fail+0x2c/0x38
[ 66.575500s] [pid:5118,cpu4,QThread,4] do_hardware_base_addr+0xcc/0xd0 [parport]


The array buffer size is 20 bytes.
When executing code in a 64-bit CPU environment,
up to 44 bytes of data will be written into this array
(the size of "%lu\t%lu\n" is 21 + 1 + 21 + 1).

This modification will resolve the current issue without introducing new problems.

Thanks,

Haowen.Tu

