Return-Path: <linux-kernel+bounces-373156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4506A9A530C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 10:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A894E1F22983
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 08:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A30D2A1BF;
	Sun, 20 Oct 2024 08:07:21 +0000 (UTC)
Received: from mail115-69.sinamail.sina.com.cn (mail115-69.sinamail.sina.com.cn [218.30.115.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3EA23CE
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 08:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729411641; cv=none; b=uzy33ilpesC449XiNlKXP3lTj0gfn/DFyRttDXVYlwhcX3wUtjludw8VuefsgQS4+xxYsoMdXiTmxmM6WMGUm4s46Nhwt8j+Zv0DHswKpipsmayMMkQ3+UCeBPmOdu2VwgrMOOkomnVc3RL5oDaBfL2r3IkZwLAehHhBkAJ/76c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729411641; c=relaxed/simple;
	bh=/8pvhc03WCENtS+Mx8YeWDkxyX+w+90CdadY7Vz40Ko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hqsFjtWcM8NljpBOJBfIUzZLGnD6HTQZdxfiC0T/NDN+BBej50qtwaIOjh5Hn0BmwpuL71GSWnN8KYo23z53+4JXXzepkx3N9yxwMUFWAUbdJHSSx/V8hPX6jisTASmGtm35wel1PoW9cgNdYAFSq0ftv+A8lNdqBUQabSibjlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.9.146])
	by sina.com (10.185.250.22) with ESMTP
	id 6714BA2C00004027; Sun, 20 Oct 2024 16:07:12 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5870587602685
X-SMAIL-UIID: B45C02E3AC8542DABDAD9F6F47EC593D-20241020-160712-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+9446d5e0d25571e6a212@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [media?] WARNING in uvc_status_unregister
Date: Sun, 20 Oct 2024 16:06:58 +0800
Message-Id: <20241020080658.2124-1-hdanton@sina.com>
In-Reply-To: <6714a6cc.050a0220.10f4f4.002b.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 19 Oct 2024 23:44:28 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    15e7d45e786a Add linux-next specific files for 20241016
> git tree:       linux-next
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10560240580000

#syz test

--- x/drivers/media/usb/uvc/uvc_status.c
+++ y/drivers/media/usb/uvc/uvc_status.c
@@ -372,6 +372,8 @@ int uvc_status_resume(struct uvc_device
 
 void uvc_status_suspend(struct uvc_device *dev)
 {
+	if (!dev->int_urb)
+		return;
 	guard(mutex)(&dev->status_lock);
 
 	if (dev->status_users)
--

