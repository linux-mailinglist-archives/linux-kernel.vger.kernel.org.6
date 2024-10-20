Return-Path: <linux-kernel+bounces-373123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 803569A5280
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 07:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EF351F21ED5
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 05:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B097489;
	Sun, 20 Oct 2024 05:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="mG184FrM"
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF3D322E
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 05:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729400455; cv=none; b=sGW6mWtIoD1r9Rd+ME7gk0pmI2DIJvg/8TVEGiEplaENxCg1EBMIpBKsGKMSLRsTqX2xheANDheZFeSYPQ6CdmRUyss4PPz+ben/RlXlK2D7akYp83HYECjkrD90ABWlE3uD7HziLjSwJ/62ZQT5XTaYTn1qJSwmVrMzftQxTXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729400455; c=relaxed/simple;
	bh=rJlwgCzcuawhqgsCy5Mk45PD8DAtXQfa/5g0kjlouME=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=kiHIIQXABrxD5ogVdmoAeDtiTGPsJSPcH9qdpUOce9gMFKw5m1I9VIcIFyGwzJqGmItNWY5gwEZgr+CnkWWOw4vMSl66Mi6+AwxdWjIwJRoiUFW7CKOXfYDS3KhSydw0Fy5kQ3/aPRk5AF5bViH9HoqqB0F33vd4X7gL8N8pbKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=mG184FrM; arc=none smtp.client-ip=203.205.221.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1729400448; bh=gsb2WBPn8DCCWviJr1e0m09zoekMTXoMr5wARom7/uo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mG184FrM6R3rmpylYSXQmpqIAHH/3etlzfX+MELFmqNK3/GP5S0/wTEdjbJp9CwR/
	 QGENOnU07cVbkhqHp+9kixIRoiIEUD2FyW4btF7ecx9FlukiRMBhgJD16wu6FCeXgE
	 J7RVZbKTzSDstchlaHIuTvlIotUAmKb+1CMZKA94=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id 2E06E09; Sun, 20 Oct 2024 13:00:46 +0800
X-QQ-mid: xmsmtpt1729400446t7r7zxoef
Message-ID: <tencent_3D5A3D31368C961236E64AB074D777FD6609@qq.com>
X-QQ-XMAILINFO: OLnGMPzD2sDVZQZCZrQIWCE2u2y1nLde/0ekXjj8giqFgwzdRO+hOdfsUs3hJT
	 mBYnBmXowmCUyGJTVD6KXFj5C4JcZSRSwwmjEYucM7aGa7LxG/7wfKrkbG3gNjwpqfsI4GroIKN/
	 dfhXoObrCAS9j6k2E1yckBBQllkBQjY+iyliEQQtPoY+Gv6CLFItV1ioeUb+bpaoYCtMeZYK9hhP
	 XIZLSGsPsXVdbH6kLEKKESFZzM5ryd2PaZ3CctQ/9apMAY0V7TL2gySnWNfKNNVdo0ZpK5l+c7FA
	 2UAUyHMB32KqYp5y3ZjVKdFm13hZ84jQ2KXwknZe1R+nFEshUM4Vo4BN7HxmlNl/XmhHCE2MC9wX
	 SINifBO/qYRGYvjNRkscZpZVl/9qOxiQTsi22UpSDwylq67yF8w6BiDNVrnPovDcpOAudPSE0dcR
	 ihP6zdx0LCX4f9jU1g75I396AJofRE5VxmTIJQ9AKd3sDhiUDJQLoQfWSG1tFD5fIAWaYJFBZswS
	 83aqo+QxvlFLD6vPVQUUd8cQDotihUNdfxLOn9jx0Wp44he5YFccPpUToGj+E0ytt1zOUw1iSTTp
	 Z3RpR73f3XlRzVea8OakZP4dAuSeIzlOpsi+/+NDH0JAowg4/zLyG2Si9U05uZyD+eARLej1o+MR
	 E5LHXuGBzDUjOnX+JiD1rmJLJKXLIAfarcWcleXQ3XjMy3HebjMeirho0TZgUxX+qV/s5hYXlA9d
	 j1x8hPJ0TYLQGvswgTvEFe7gQbUivB9LOso+IbbJbOAaYPesYVBOhVjNZRsNXwXLAhwvjinyq5De
	 Aq1zzlMFXPdJWwFFwtvOlfq741iws87B/9fxTsy3mcRDRXPARAsM1mDMWj5UH4G4S87XEw0/EHCV
	 FzVl8zwtfyjD6VCumtG3Jj89ida5JTDJBPOT02yg/FppUVD673z6idyO9ISsSSoPT8SGT9oktX
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+4125a3c514e3436a02e6@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] KASAN: null-ptr-deref Write in xfs_filestream_select_ag (2)
Date: Sun, 20 Oct 2024 13:00:46 +0800
X-OQ-MSGID: <20241020050045.2405611-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <6712b052.050a0220.10f4f4.001a.GAE@google.com>
References: <6712b052.050a0220.10f4f4.001a.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

can't pick any perpag

#syz test

diff --git a/fs/xfs/xfs_filestream.c b/fs/xfs/xfs_filestream.c
index e3aaa0555597..dd8f193a3957 100644
--- a/fs/xfs/xfs_filestream.c
+++ b/fs/xfs/xfs_filestream.c
@@ -165,6 +165,10 @@ xfs_filestream_pick_ag(
 
 	trace_xfs_filestream_pick(pag, pino, free);
 	args->pag = pag;
+
+	if (!args->pag)
+		return -ENOSPC;
+
 	return 0;
 
 }


