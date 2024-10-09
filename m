Return-Path: <linux-kernel+bounces-356584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E339963AD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 10:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C54EDB283EC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 08:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2951917C9;
	Wed,  9 Oct 2024 08:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="AvpR/iFf"
Received: from out203-205-221-242.mail.qq.com (out203-205-221-242.mail.qq.com [203.205.221.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9DF186E39
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 08:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728463537; cv=none; b=tM5sZK+R0g+x1arVBEoDVg71FRlFJ2reDhLNb+HLEYHR2FeefskGPhtC0UChKkNim6XdG42sOIalJpKR0rTL8GcreM3yTmUKCwPEF+5zqS6OC2YFDAezegugfn+Dt2LCGGhD8NM+lgF2H3SlgQoy8sfoXzVEDrYnmO9cPRr/lRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728463537; c=relaxed/simple;
	bh=dUqjSUjqB/n/llU6r5QMLiTG16V3Hd20G8RiK2oLizo=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=YhTcRrrWuMVIEZY9jLTw/bRJj/7OYvEaCfN3Fuwl2rbspk/wwALfzAV+N8IQdrP6E5aGmLEl1MBlql3rWdMnvKzx/vFbFjMVfcxfijbjtmdDiKX6wb8rsYneXuOJGbExgCNsjV0BBMOm74YwHwu4TdicCqZFIcqVFwLx4Aosk18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=AvpR/iFf; arc=none smtp.client-ip=203.205.221.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1728463527; bh=zsGbU4egY3J7HI4TYM66msMk7fjnGTq9IHTedECqG+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AvpR/iFf8Tc6KRQr8Aten8OL8Y811+WuRZNK1zYM1udUC4Xf/fKSyPhuK3ZvFNXGb
	 21QPyNQ5XH2DEUoOtf+6gPAlMXiGozuUbtRTrPgibpBba6s8d6Kc8EZtND65FHKwyc
	 xNiomC/R8eQNVf7WSIDo/mNkmCsGYngV+GAaUhN4=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 9313183B; Wed, 09 Oct 2024 16:36:49 +0800
X-QQ-mid: xmsmtpt1728463009tire9eeli
Message-ID: <tencent_BE79CA6D3C2FA56CF897FCEA4AED62CD6C0A@qq.com>
X-QQ-XMAILINFO: OZZSS56D9fAjI3hLXCGw24m5qHWZavMAwSUaQafxSAlIqVjZnMlzY3np4vNmqJ
	 s0crEf49f+ZBqBz3njel66y6UWP2A602ZRbTGlvEvdlhBRn2ABJmeAKdA+jwuqfTphM3NLkGzTO3
	 1tsEBHpEscAhPWDOnxz9GLbWddPfK8/uqqB7y/9j89Ajbnr2zJTswHHMMB01fhJZ5vxIdbKiyG7n
	 d2z0E+asvaxqm+JvCZ1Kw66B0Et1EZ5x2SDH6D//ncTASvApaPa2GmZ6MH2C6lg5HDcKiM8WQ4e/
	 cKHi7/IvC5idvkehrPLB9jhbVP1T5EQeTsrQhejUSYQxg4MdTeaU0w3b55vyHoG/xClj9ZxU1BJf
	 blsJY/NpL22bvPZlixfvFVm9xSmQYEfX9paWHiNhR4iDUIiR9L0Fq5ZD356nfh2j1lEQNQNIpx74
	 NaUzew3ZwtdpHthBbTR32q/pkioXEaedqeY7qa4vdppD8mxqQLz5rMTOPfne/9cm6tlgBtvyYKZE
	 Zajfl22+VjBFxg/5qAD4PPga8fvcxVWUokPZxnuzcyh6PPatGObwyOrfl0pVKiWf8e0othkTFDOj
	 n1vsVgiyNNz/eL3LXjMFSBpbKGjxNjNmvCLSlAeLDE410tRLSFHH9XO7vQyj7+K32sAkYkLpGKbY
	 jKdZI6KT+bZSVioELgNL/f5jKbAi8TLS09UZ3AWgkgBkpHhv+kVtAsBOtUVEvTinsX2c5Pego430
	 CiZXutq12OinvcQYB8pleIJ2uh/IjmrY3QPmCsjyEdIjHrR7JNe9/nn0WHAGjPVPEXq1t3QtDkKW
	 ZMJWXIIzcWebgnfrOHyU8TdIITHukOl4yvzW3FXCBx6+iqkiWb0xeNysqYWVzyv9Uwx+gebRRP3L
	 oMlDq/qjlsSu2tvSaWW6x7yT5lbsoRETqZlvhyQMHslU881zCX8EvUuX/C2fsplw==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+5f1ce62e956b7b19610e@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [usb?] possible deadlock in chaoskey_open
Date: Wed,  9 Oct 2024 16:36:49 +0800
X-OQ-MSGID: <20241009083649.1211187-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <6705f1c8.050a0220.22840d.000c.GAE@google.com>
References: <6705f1c8.050a0220.22840d.000c.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

delay get the chaoskey_list_lock, avoid to circular locking dependency

#syz test

diff --git a/drivers/usb/misc/chaoskey.c b/drivers/usb/misc/chaoskey.c
index e8b63df5f975..17e29c6e878b 100644
--- a/drivers/usb/misc/chaoskey.c
+++ b/drivers/usb/misc/chaoskey.c
@@ -232,10 +232,10 @@ static void chaoskey_disconnect(struct usb_interface *interface)
 	if (dev->hwrng_registered)
 		hwrng_unregister(&dev->hwrng);
 
-	mutex_lock(&chaoskey_list_lock);
 	usb_deregister_dev(interface, &chaoskey_class);
 
 	usb_set_intfdata(interface, NULL);
+	mutex_lock(&chaoskey_list_lock);
 	mutex_lock(&dev->lock);
 
 	dev->present = false;


