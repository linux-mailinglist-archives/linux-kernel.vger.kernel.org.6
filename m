Return-Path: <linux-kernel+bounces-356640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5259B996476
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 11:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83FD01C249B9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 09:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5197D1898ED;
	Wed,  9 Oct 2024 09:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="VVtIpDP/"
Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com [203.205.221.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D882B188719
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 09:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728464926; cv=none; b=tbqL7OjVda8Mx9JNMGhvt4JayvzjVMtiUcQbjVwnNLClz1oRaswWHeKaqwgzWA3P4EnGrGZG6n0SYCg/OrkhYDjPu3O/HmMTw0f6McUSF8eYuuKLatJ6YGaS0mvdgn1LsGbtmcd2UtXDXxBkilvi8qH7ODKTMKwQUxyVf9wgBsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728464926; c=relaxed/simple;
	bh=U6gTVCR1SWTecSiJAAHM+y+OKQr6E2+zzUL4EqKAKQs=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=TzosJIKK1+meIEGmjon8mqz3mk740UagDEqSyb0vRpe9XkfV58ZCUXpCqErgmJ+MuZ7zBtC3H9EhwAwLqTXr7vMpd4kZNaISGBiJiz+brW1NaFzS453nM+kCjOakjRDQVyIKh1ps8u7UP9pCI4hNcQlKYmOEfLs4WUYFCyUZGos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=VVtIpDP/; arc=none smtp.client-ip=203.205.221.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1728464622; bh=znLFiy+Gufz/jmUYElMhphI9lilg+HPkttgJBBSJ1Zg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VVtIpDP/GaVw+o4dCOZ8xBn2NNeaLQo3MxhtYmk7h74JBbzCvgzJVD1kXG8N5WszY
	 4gDROc7/hsqMwZlYtXXjvX58c9XBR8AvTOH/EgBMnOs+eF0ESDqxv8PpS4VE4N6U1l
	 ITQgSr6jzocHTshVg923WHkbVHjnmzUZtCU1RjFY=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id E8A02C6; Wed, 09 Oct 2024 17:03:40 +0800
X-QQ-mid: xmsmtpt1728464620tln0v0ahp
Message-ID: <tencent_49BA6FBB7033A99E361BD24B1D1B94254108@qq.com>
X-QQ-XMAILINFO: OLnGMPzD2sDVRZ0x7vVEtZeTtGr6VJZv0OIPJ1KF0YbrbT/BblKtHWph9taRS4
	 YDHXfjUIsgl26BR50FUKKETrPKZvlJIrUVlHia1NdnyD0Ar3kOmqM5yD1W3t/qOGp04nHOGvPT0Q
	 Q61WHzRiRzgR22qk4/rJYtb7DlKQNUHX/LrqF9FZQ0bU1y4MZ3lPppS/ou/SXTb4Wm8fhytGEGoc
	 T6ncuIQavWIXm0Xzat8BQ39zPgwr7GH/A+Jz6+qyMtS6bqtebrCrrxbD/DhOk6hGlHsYnWCbAvjM
	 Xi0aUE2H0PKybDWkBYDzT5a0toxTOc8rVGFMrvGN+dSnJcXAJlWNZaDw7K6T13fGf0CXtYUd4IfI
	 WMeERWYaQqcNAnruX+H3Bn9MNjGsyL2TUb1QJ0Y4k6p0Y3tzJ0b1l3bykt1gnHyegeW0SQtoYq5s
	 BrCE5eREnNqV5h9GwqhmfuHMJHnKgxMeYM7vCdjQJ9/jOZWgHiF6i/Z5DW37x8IGtyOBoVhToKyx
	 w/ta3X/ZM0kVrUR8oPTDu/dcYObVvZH0gbocUZBH6lZadVEbSsEwI1Cspc8FkpmSiyOHMTdrXQcG
	 thHXHNY8JFudLLnMtUMYY6BHXepTZFhvW4/MPpMcXftxwG28Zg1if3lV+Iaz4A9gL0faXzuW+JOK
	 X9Ft74gJN2HXjcQgElpGUxJERXlMAUM/jwS9/5dSEGeNXDpkfnBKHGkGmo3/PdcHeIpOY6SN2mpC
	 AIFxy+pY6fzPU8CGuluTQTpXBx8UrEc3EQVot6jigGgbcPa8dup0qZlx50hLDoKTwecieaq2Iw5m
	 KwJRDD2YfEQB14al8y+H3JjHWsZM2hMc39TIdgfwiwkNM+Tc6JTRnXkRQq71AeGi/51bAYkNEUig
	 tzCZ0xm9FE4msbEE6zGO7c7nv06/2F7PF/5frQkWszA7RaBv3J77emkz+r3CCbgflfFbpYFg28h1
	 DTyyAl4CiOa4bSihCsSQSRbH1NfyPEAQoSLFDSzL+8KZyFRJ38eb9ooKZ/7SXiQS064/VAHYLVFI
	 76TrD3JSik5LguzEBO
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+5f1ce62e956b7b19610e@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [usb?] possible deadlock in chaoskey_open
Date: Wed,  9 Oct 2024 17:03:41 +0800
X-OQ-MSGID: <20241009090340.1236040-2-eadavis@qq.com>
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
chaoskey_release has a wrong logic lock for chaoskey_list_lock, it need unlock.

#syz test

diff --git a/drivers/usb/misc/chaoskey.c b/drivers/usb/misc/chaoskey.c
index e8b63df5f975..225863321dc4 100644
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
@@ -319,7 +319,7 @@ static int chaoskey_release(struct inode *inode, struct file *file)
 bail:
 	mutex_unlock(&dev->lock);
 destruction:
-	mutex_lock(&chaoskey_list_lock);
+	mutex_unlock(&chaoskey_list_lock);
 	usb_dbg(interface, "release success");
 	return rv;
 }


