Return-Path: <linux-kernel+bounces-356632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B647499645E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 11:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E832F1C21F7E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 09:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F988188906;
	Wed,  9 Oct 2024 09:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Z/4AAVJ8"
Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com [203.205.221.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99BAEADC
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 09:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728464647; cv=none; b=gnv7mpAAGTvwCnbeBFf3qKMwP+cK8BHCtBMmEqrucge3o44/a3sWZItz4SHT+w3L+IA3PAUutQRj2nxN6HHtQCwohlXDP2O+S7sg+EbKzssV6rOH3L+jfpV0+WhpGgpx6ekBMpo0dJpYRE+lptF8VAbontOkzrcIbdN+8ZOx4rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728464647; c=relaxed/simple;
	bh=U6gTVCR1SWTecSiJAAHM+y+OKQr6E2+zzUL4EqKAKQs=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=ojf4JATQt5p4n62+bG0TwO22L88yP+SOebxDNSJWORMb9KkW0yk2OH7+GPGjcR7yDnemU9mFqEek24UEekEM+ephyqjg7NZLkAvGHzOL3wMZRRzZG0XzwXo0mxXYxAAg39jnJkALiuRfNh3bAyj5eY3DBta6HosgrKTKsliRSQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Z/4AAVJ8; arc=none smtp.client-ip=203.205.221.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1728464643; bh=znLFiy+Gufz/jmUYElMhphI9lilg+HPkttgJBBSJ1Zg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z/4AAVJ8lid8NDsE1d9831TxSvJwFgL8b8LukcCkNNmAgbype6yhDhUHK0/JHte+D
	 711UPai+sII+vy1gK0utk88hPBBneokO6y/wTqLP5hu3m8hFEdZzfjzF64HxwvFjFV
	 omtLr/5Lcht95M1b2tHzMeuhN/y3sdQHsu0LiZeU=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 101B3450; Wed, 09 Oct 2024 17:04:01 +0800
X-QQ-mid: xmsmtpt1728464641tfqymlxz3
Message-ID: <tencent_A51B5C25CDBA1CBBBA33419EFB1B3B4B6508@qq.com>
X-QQ-XMAILINFO: Mv8oRO7AAqEFCi8/+23yj9RvGTM4xhOcV9cFi0S3fEc6ZyVRH0eL6FyG6prOdZ
	 2jlu2tEv8IWL/Dw65ctrVUyEJaNJxSRXJ7SYWZe8/Xr1GuTu+vVy2fmvYOoUMM6YcfTtxuzlyBRM
	 t9kynckh7qbH4rb7Cc5NnppQfpmRoTu27GWzs0tQnTBKqNgl/EHkl5YCwlzNUGH1kuZptqnzI9+Z
	 npHozYWIwbXci4k31GI3Ox2OlO0T6vHxvoMwN66mR3AQD0qIzIDG8Ky+XGM0tESpbAvKyY/DhDZ2
	 rRRg5E4VyBORDh2kr1iceD8uZ8UikI7WFns4VZ6HUSL80n68l6oux77xSHJkmF96cCq7vYiqFT5b
	 kqhuAKvyssVpSV+ZbVDVH2z9jb05vb1DqA1QFNFpoM52KaP6uR8RNWAQvVf8W2KWYutXNd3iMqWW
	 q2V03ik8lmAF7ZTxg0IFGokNw6nQ7e5mv2EFzlbO5n5hG4mdt1UUIfVZiwNTve8Wolh2U3o30jc0
	 zoDFYtTOP+O9EEIN4tUrHqadJORw6UqQplvW4Rzof0OV+lPHVpZVT0MjLY+Gi86es8DGT4lf3bpm
	 8CUFJ8nJm9VqtFJwRzGTVnrHxhGGsW20t4LJ0O45wlD466c10v4NjU6um8XKIkBC0XdAXFnyG+6W
	 0klfunbiBgR05AknL06ZIxUXMI1m2qqWoqkSWGcf04qtOVzfO/JH7wnrjYRxpU08X5LYSt6XG/2l
	 /7fXN6Z7J51CopLBRoR3PinJ001GF1lorrsnjRYWXe1F4KYl7daNyCZ5hlLoa8sqq4C2w6rT4r1l
	 HCoSBniyeq7u0HxwZCYYgxMAelY2fO/EkUAHhkdIWfZjWGdsiQQQlx9BnvRUyrzfv4VauyFOJUA/
	 SufmHquoEQ4SXyanEiO4P8LvbiS7dmR2ox0I0I1ScE5dRb5P5oeW66GUFVi1hjqHyEw/1DVuaTNI
	 KoSJ7RwymVRL4tF+iqe2RUt+CMEVTbrd9r6+9LdJNEyLe8qz7x52TeMHk5Y0JodEOXtPs+hp6UKc
	 67S/yJ2QlzmSOHiOqh
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+1f8ca5ee82576ec01f12@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [usb?] possible deadlock in chaoskey_open
Date: Wed,  9 Oct 2024 17:04:02 +0800
X-OQ-MSGID: <20241009090401.1236433-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <6705f457.050a0220.3f80e.0021.GAE@google.com>
References: <6705f457.050a0220.3f80e.0021.GAE@google.com>
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


