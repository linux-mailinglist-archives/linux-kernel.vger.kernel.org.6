Return-Path: <linux-kernel+bounces-395892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E33469BC494
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 06:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD13EB21CDF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 05:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146BF1B4F02;
	Tue,  5 Nov 2024 05:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="qC6wYHK3"
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BA83D9E
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 05:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730783524; cv=none; b=fv3qDkxI5H3aJ6DYyqHjvz7ylEsYeFXZzdekNkfBte7RF+FroW1HMb+GoZbf7FZfeRXdHWj7eiEvpfIm63s4tff3kodjmgDqMNJyEX1K2ymGwVOc1Qbwb0k1zyG5GoAu8JxXCv55wO44Q38S0e6V91tIY8qtwssAj6Xwb9bS+EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730783524; c=relaxed/simple;
	bh=ldStJo010qqTlagNeG6L/VN2O4aHXCpM2z6OG2PJNTw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=XyALIRnZj1md0M7wtrcDrrrv21p7Al8xKpZGPD1KANzTa28z/kYYIDoAILKyf0QG6NYBzS8Fl6PHsfK2JJ5oYJ+brQUWRiqcMyf2HR3dZ615dMIOOqleDT958x5GgXJBfTbVgkwbJgy4+Vr2irAgPArBhMT7oTdguj1RDnHCZ9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=qC6wYHK3; arc=none smtp.client-ip=203.205.221.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1730783510; bh=fZqCJDON1onUfVpEG8p0irECz1DbeLi+hzuVvvGDRRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=qC6wYHK3Ad4daz+u8WPDfl7+RfZLkW6SNHgcdm9bUgrY92d9l7y/89e0LPvdir9et
	 dHNPyOxznSZTwqbfTexcuabbgH1YurPFx1rX9Waz+mlPhMLF/VtixJIxDqDt5lXkC9
	 pA9OIZGM6dW5/9gYENhZ81ZI6TRgBfAtMqKYVd2s=
Received: from pek-lxu-l1.wrs.com ([111.198.227.254])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id E41C8C6; Tue, 05 Nov 2024 13:03:36 +0800
X-QQ-mid: xmsmtpt1730783016tcfxqz66g
Message-ID: <tencent_803620964836C04B48745176CF66C03C1709@qq.com>
X-QQ-XMAILINFO: NyTsQ4JOu2J2NKP0ku038bOwjY2UOdGvJSReZBeoDGQLJ6BymUeWQOPhjfbJqZ
	 jmP+ymq49riSmCQfQw8PbhCnXYWpfllVmsYzePOIj+RyP3qIrQMwn/VIzyiio8fYGg3Inbb7xW0M
	 ssuRfZYEt0v5pDL2WocJpR2kRtyVuAgjQAF0+BelIfYpCX7/f8S0MDawAAnzHTogRiaKWoirEWWH
	 qMdaNc6WTLbPMJuZl8lgfcgvdCNxj19SpeKJBZOqeWEp8YglL65nejAQ66TyO2oZa2hxMhcdeCC5
	 ZUX3g67y8a9DtxDbD0noBHnECFw7ElkMlqgYSyQ/uwrZOEd07RI1Q+zzreSoYr/lhz8zFZbgPCTH
	 Vs58yvXRsmxY2cESYZI2+/o0Z1bMsXritLLzYVids6nEi91lInylbGq8HWH+vG397Giux05KbNwL
	 YCZ543nASTG/nxsQHc096RvE6Pbhc6j/O0zatgtfZA6FDTYe0g7QIoskmyIYMS2O2tZE8ObL47Zv
	 XlkhBqO2z6jdyfF9TyxZHChaTWVG2qagJc0hOad3Rj4rpxfRf2t1q6H1kmnwdI+CbshjjeG5kxS6
	 Jy3NMHP/+fYyS2+q5aoqbNQm6bk43T+vEnDQWZ//lekC89SciIJFPcaIN3Z4dBEiho4EcfoI+beR
	 ZCHTZTcMFSfSTv45RrX0IG9cu3H0jaNw3y+DOrqZ5wo/aKzihU9/KlfIoRetBiAfLGrkhrbWWcmB
	 Tj4hf8jzQxkk7ZoUKMZnS9TW9QU+56XW40bMFxurStyNVNALdLc2MeomuuszVWgy/SC3VsabSK+O
	 w8i12MyZWVX0Md6lYWl1GKILJu+8ezLa26WprEMrgX9A2H+YACTmbZXfMMut+oQNsH56alsNfj31
	 QLmCIb4CzNH/nKr9FhwnZ94xiLH+UYQU8pV82DANz2qV4nGVFfeRxwMza8vgYrw8YIOWGMLLPbkg
	 jnUJF/z4c=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+73582d08864d8268b6fd@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [sound?] INFO: task hung in snd_card_free
Date: Tue,  5 Nov 2024 13:03:37 +0800
X-OQ-MSGID: <20241105050336.1584061-2-eadavis@qq.com>
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
index 114fb87de990..84b88b1192d0 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -186,6 +186,7 @@ int snd_card_new(struct device *parent, int idx, const char *xid,
 		return -ENOMEM;
 
 	err = snd_card_init(card, parent, idx, xid, module, extra_size);
+	printk("err: %d, card: %p, %s\n", err, card, __func__);
 	if (err < 0)
 		return err; /* card is freed by error handler */
 
@@ -580,11 +581,14 @@ EXPORT_SYMBOL_GPL(snd_card_disconnect_sync);
 static int snd_card_do_free(struct snd_card *card)
 {
 	card->releasing = true;
+	printk("0card: %p, %s\n", card, __func__);
 #if IS_ENABLED(CONFIG_SND_MIXER_OSS)
 	if (snd_mixer_oss_notify_callback)
 		snd_mixer_oss_notify_callback(card, SND_MIXER_OSS_NOTIFY_FREE);
 #endif
+	printk("1card: %p, %s\n", card, __func__);
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
 
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 96a412beab2d..9e5a0eb43fec 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -523,9 +523,9 @@ static void batadv_check_known_mac_addr(const struct net_device *net_dev)
 					net_dev->dev_addr))
 			continue;
 
-		pr_warn("The newly added mac address (%pM) already exists on: %s\n",
+		pr_warn_ratelimited("The newly added mac address (%pM) already exists on: %s\n",
 			net_dev->dev_addr, hard_iface->net_dev->name);
-		pr_warn("It is strongly recommended to keep mac addresses unique to avoid problems!\n");
+		pr_warn_ratelimited("It is strongly recommended to keep mac addresses unique to avoid problems!\n");
 	}
 	rcu_read_unlock();
 }


