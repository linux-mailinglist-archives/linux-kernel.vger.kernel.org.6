Return-Path: <linux-kernel+bounces-395867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 681349BC428
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 04:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8ED1B2214C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 03:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5360018C35C;
	Tue,  5 Nov 2024 03:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="xFKlUrAj"
Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com [203.205.221.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1C2282F1
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 03:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730779160; cv=none; b=nk6Fkan5cLN+L+zjptT09wpU7S32bKlUcUGX6dXg8N4YY7+D6QGQmsNYgpE7OYBojNLjew+TLBy4gFsOZ2Stq5BM0qasl+i8pX6VI+QE4+C8Oox1ykUTrEi6DcGtN16VIqqFJO+puEnjQkgFZm67hRQJWIso7jDDwTcE09tG9Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730779160; c=relaxed/simple;
	bh=9qVRmi4/CzzR42AmnNcJUpOeU+CDfEQ0HC50jaJpTO4=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=ibd+8anN9ayej1mSMI9RirhSWnhE9qelFKjJLh9qrWhQpmEnGPf13WrZlYMeGtc7Er4IyjInUSEdQaKIOaJmwaHoHV4R2nweSECkjiQeiu4Z5lVWDNsgC7uqGtn9eYX/MJuVI9h5YgBXf0CLhK9Q2iRzwAgZqRFpd6ZrlJIOw8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=xFKlUrAj; arc=none smtp.client-ip=203.205.221.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1730779148; bh=rhhEfLktbQ7P0JBQRXR4Th5mxXrysl8lKvklkNP4Aps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=xFKlUrAjFLpMKnkw793EOjsl0rtfhWAh/7LGmykPj/v+WapwGinanJJdDeb+p66A0
	 IJgfzzhQmg/HTqH04oz71HwW1jxY++hJnlSmNzdA1slJvOk4bX7OU9zLVEmHYg5Wym
	 iS4+xqIGGuY1n5UPwur5zh0V7ZU4wKN+R/x0fabE=
Received: from pek-lxu-l1.wrs.com ([111.198.227.254])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id EC620A35; Tue, 05 Nov 2024 11:59:06 +0800
X-QQ-mid: xmsmtpt1730779146tb0k6uh1u
Message-ID: <tencent_31F4971436464B9475FB763166423D473709@qq.com>
X-QQ-XMAILINFO: M6I+dON63j22SKczlbDSAQIocyizs3fqkfMA6v9IkMrhogXTb2t9fHXxSfMJaa
	 +PoSnWys22uXaz4UyRfWzalk5JWZfR3uBynLdD/3eF5ChjC+LZRWwYni6IfaEUK0bBP7QIv+npc3
	 mqMLLDAGklEM7lKluo1YeK9PzJOvK0tcdMWfOuazsYuyNVU0dW8mzemhe8Yex7BFIDIeq7S33efM
	 Q6pxFEa6/uEnX0UcWl15wlsNoJhqElRItJfB6+0Y9KMi79frdLyO6MZxP2Z0bQN4y92Uae7DYeL/
	 4XHLwa+U98MBfZgbhd1xMcLtxmRpPvPmk1sDz/hw4mNjkOcxOEcBHt+hOW74MhnrTvkvxyt44t5h
	 GqYLjPdQDCVM+f1bDC5ovjy1K0uKWxyNzl9Of8AZADFwJIhpKjgsiw8dPwH0rrqllyAcFzY8vweh
	 CfQV1bfBZbe7kFXN2d2RCwpIGwNHUIkwDUZtxJuCWuoZBFZlQOys5FrxvzcRSEHIbPvZyYONFhf2
	 Uh1xivF2ahEV/Hq2Y/anxjz+H1ehj35vTpU+evs1jJ0b7n6DaaMFwAGRg+Lz+1igI+HLRSp4YUOS
	 7ImicyNYbkFV+UQmT0bB0FhtuYctYddPCNoa+RIuW1Of/kopUUuYrBnkvowUH6tU7CqfZd3E5hXa
	 ONvEs9v0CjMdtLSpmwPokTPxGl9UN5Ugeh4e2J0u66B88S7IrYfi+o2GgktYSMKc+AEMuuoE+kUL
	 5FyPPZOvqB5Cx0oQlJc5sWTCq0dvz6p0V1uXFZhMjuFTAmireuqhbnF/YM7x9So5wqeSqR6S0Qb3
	 +Qb9QOThR0GDEJ8/G+DSv9kPzqkAKaVN8befYONFxJ6DbLqAWJ3Lr27/vztFa7oMFEWTWgvNzDNF
	 ZieuGiLn67xAc5tc0VwlxFNUQ9Zw3tI19xJzrszhC/EI12e2lxpgQ=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+73582d08864d8268b6fd@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [sound?] INFO: task hung in snd_card_free
Date: Tue,  5 Nov 2024 11:59:07 +0800
X-OQ-MSGID: <20241105035906.1521324-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <6726bf35.050a0220.35b515.018b.GAE@google.com>
References: <6726bf35.050a0220.35b515.018b.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sound card of usx2y's probe and disconnect need to be protected under mutex.
debug: where hung in snd_card_do_free?

#syz test

diff --git a/sound/core/info.c b/sound/core/info.c
index 1f5b8a3d9e3b..e584f3eb742b 100644
--- a/sound/core/info.c
+++ b/sound/core/info.c
@@ -566,7 +566,9 @@ int snd_info_card_free(struct snd_card *card)
 {
 	if (!card)
 		return 0;
+	printk("card: %p, %s\n", card, __func__);
 	snd_info_free_entry(card->proc_root);
+	printk("2card: %p, %s\n", card, __func__);
 	card->proc_root = NULL;
 	return 0;
 }
diff --git a/sound/core/init.c b/sound/core/init.c
index 114fb87de990..900ae1e7fc22 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -186,6 +186,7 @@ int snd_card_new(struct device *parent, int idx, const char *xid,
 		return -ENOMEM;
 
 	err = snd_card_init(card, parent, idx, xid, module, extra_size);
+	printk("err: %d, card: %p, %s\n", err, card, __func__);
 	if (err < 0)
 		return err; /* card is freed by error handler */
 
@@ -584,7 +585,9 @@ static int snd_card_do_free(struct snd_card *card)
 	if (snd_mixer_oss_notify_callback)
 		snd_mixer_oss_notify_callback(card, SND_MIXER_OSS_NOTIFY_FREE);
 #endif
+	printk("card: %p, %s\n", card, __func__);
 	snd_device_free_all(card);
+	printk("2card: %p, %s\n", card, __func__);
 	if (card->private_free)
 		card->private_free(card);
 	if (snd_info_card_free(card) < 0) {
diff --git a/sound/usb/usx2y/usbusx2y.c b/sound/usb/usx2y/usbusx2y.c
index 2f9cede242b3..129210a81545 100644
--- a/sound/usb/usx2y/usbusx2y.c
+++ b/sound/usb/usx2y/usbusx2y.c
@@ -150,6 +150,7 @@ static int snd_usx2y_card_used[SNDRV_CARDS];
 
 static void snd_usx2y_card_private_free(struct snd_card *card);
 static void usx2y_unlinkseq(struct snd_usx2y_async_seq *s);
+static DEFINE_MUTEX(devices_mutex);
 
 /*
  * pipe 4 is used for switching the lamps, setting samplerate, volumes ....
@@ -392,6 +393,7 @@ static void snd_usx2y_card_private_free(struct snd_card *card)
 {
 	struct usx2ydev *usx2y = usx2y(card);
 
+	printk("card: %p, %s\n", card, __func__);
 	kfree(usx2y->in04_buf);
 	usb_free_urb(usx2y->in04_urb);
 	if (usx2y->us428ctls_sharedmem)
@@ -407,9 +409,12 @@ static void snd_usx2y_disconnect(struct usb_interface *intf)
 	struct usx2ydev *usx2y;
 	struct list_head *p;
 
+	mutex_lock(&devices_mutex);
 	card = usb_get_intfdata(intf);
-	if (!card)
+	if (!card) {
+		mutex_unlock(&devices_mutex);
 		return;
+	}
 	usx2y = usx2y(card);
 	usx2y->chip_status = USX2Y_STAT_CHIP_HUP;
 	usx2y_unlinkseq(&usx2y->as04);
@@ -423,6 +428,7 @@ static void snd_usx2y_disconnect(struct usb_interface *intf)
 	if (usx2y->us428ctls_sharedmem)
 		wake_up(&usx2y->us428ctls_wait_queue_head);
 	snd_card_free(card);
+	mutex_unlock(&devices_mutex);
 }
 
 static int snd_usx2y_probe(struct usb_interface *intf,
@@ -432,15 +438,18 @@ static int snd_usx2y_probe(struct usb_interface *intf,
 	struct snd_card *card;
 	int err;
 
+	mutex_lock(&devices_mutex);
 	if (le16_to_cpu(device->descriptor.idVendor) != 0x1604 ||
 	    (le16_to_cpu(device->descriptor.idProduct) != USB_ID_US122 &&
 	     le16_to_cpu(device->descriptor.idProduct) != USB_ID_US224 &&
-	     le16_to_cpu(device->descriptor.idProduct) != USB_ID_US428))
-		return -EINVAL;
+	     le16_to_cpu(device->descriptor.idProduct) != USB_ID_US428)) {
+		err = -EINVAL;
+		goto out;
+	}
 
 	err = usx2y_create_card(device, intf, &card);
 	if (err < 0)
-		return err;
+		goto out;
 	err = usx2y_hwdep_new(card, device);
 	if (err < 0)
 		goto error;
@@ -449,10 +458,13 @@ static int snd_usx2y_probe(struct usb_interface *intf,
 		goto error;
 
 	dev_set_drvdata(&intf->dev, card);
+	mutex_unlock(&devices_mutex);
 	return 0;
 
- error:
+error:
 	snd_card_free(card);
+out:
+	mutex_unlock(&devices_mutex);
 	return err;
 }
 


