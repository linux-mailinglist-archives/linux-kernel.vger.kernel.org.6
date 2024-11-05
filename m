Return-Path: <linux-kernel+bounces-396342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A58DE9BCBE6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 12:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 368951F243F4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 11:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AABD1D4612;
	Tue,  5 Nov 2024 11:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="VVZuVpHN"
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69271D45FB
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 11:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730806152; cv=none; b=ApgM+lCDXhFJfeTBQMp3umZhe7rTUiUYXt6v8HPbjhL2TP3Cb6CfgO5UJk2vxfs48IhAdGGht8gPUHM+Y5QoHHqSQEa+pmC04fo9OfBjUgIY8fYUPALOF3KPdPXr4MhyW4lLopld4cr1EAbqWng9PtreH/gYBszycuGWvjosf6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730806152; c=relaxed/simple;
	bh=xU+H3PD5W709qvJOPn/QIopO21Gx7ertBzrNwuKd2SQ=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=qotEX4/p+lKPVHkUYIlW3CqJ+fxwp0RjMgCvTUuVk1TRvdjCJWazFE5JIf3RVrx1aTWuPe5YTg3djoXm8gGr9cTNW3kF2HH/9COOfF9sxOuOcVfJjZFbVZ5WHfP74lYFy0rDeIBQdBSD1d1v1/O0HlLPMmx+cDF2kOhCcAMa3pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=VVZuVpHN; arc=none smtp.client-ip=43.163.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1730806141; bh=16gX/pqFgSbVF4vuhqDLM/LHMor6C67mdIc7PSVwoiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VVZuVpHN63ZwGRfuWlYRL3m8NUBv0xqE9JaDM1bWd1422BeT8g4vg/EIVv26Ye+L1
	 uHqXiYeYPiQxZnwqp3TtF5pqPAm4G9qYfUbnWvPo/i5veddjzyWJxASyP57wg4oR+i
	 0wKxPg6T0etjegQ0ZDy6l8soJ32me1I9d2gbR5Bo=
Received: from pek-lxu-l1.wrs.com ([111.198.227.254])
	by newxmesmtplogicsvrszc16-0.qq.com (NewEsmtp) with SMTP
	id 5B6A2825; Tue, 05 Nov 2024 19:22:54 +0800
X-QQ-mid: xmsmtpt1730805774tc9b7cw34
Message-ID: <tencent_58E8CAEE52CF6C78226FB82CE56EDC94940A@qq.com>
X-QQ-XMAILINFO: MyIXMys/8kCtGGpVwAypGJHEuQQlSv2dVOCulLg6C82nYZYR/G+4z99fJcqBUF
	 wgdgU4V2GobMX84NFbvRaqoFRYoJZh6zFQpbFCdu/10zGAlyfehfALGUSO+fq6B9KY3Ot4qC07QW
	 p5FuB4RywRWWG+Nk9PoZ3lERJGypgi+8yQn+4XqiYqlExhiD2EXOouOA+DByeq92Mld9oAEXPolj
	 JQoMMKFXg3/Uyunj4B0WzWYVizcEqfMARp0JNf62c1fx/GVl8Sq4Qko1Kv+pu3F0DmVhrowzlfWi
	 Ttaa7lgMtIYoYTpBlupzKxziDrbFQs/cdO1MxcCtealH9uHb14j9PEe+Ry6XNMjYj2+jVYrgQNWB
	 EsmwiRIMuQ9uBRgmxSqvvHFuMF4IGb8l4kTdtPIoMrZVdC3qxO0vGdufT/3MzNxQh4NOsnUycjBU
	 RbP2aEjBbn5tEyfgii+PK5BsE/qMgHylTcemrPGTd/DextDSq9nVMHGV5CExdQpORJsXFG0q7sB6
	 qnHIwCoM3xIdaiKepLXxntDeNuLtmOQEdXEMd7EaISXgxtAzWRQDLtOilmjphKGeO2f2LZ8Dyu4v
	 b2ZAAPSkhFGW/xIXleFvQ5eI8SGMwv9XEiSZYES/6QkiVkRHN6Jc/S4EuFVGBFX5rQoUXUWlBvfh
	 Dq/3VK7dUrAc0KLOZXdFPO5jZTofCay66jVUhGeMDlvnqwpUROlo5lyDXblC6wA+Dpb93B9hlpFR
	 7t5jFm9NT7tj7Xc81sTknzRb2zz8rrrXzH1n0OYEno2cSz1T3KlqDGOdRm19zYJ3RybPJqi5BNCf
	 EeZMT4s7iM2FN5sEzv7jg9xeEIkSWD3JgfBh4B/TRO8PIFrt/z8mW6LsOWDKMbl8sqIfwjWzoLbq
	 JcUSbv3qErCdgHfbsCGd12d1E/4gfkfjgOV1r1xUVTUEGO3nFkcKM=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+73582d08864d8268b6fd@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [sound?] INFO: task hung in snd_card_free
Date: Tue,  5 Nov 2024 19:22:55 +0800
X-OQ-MSGID: <20241105112254.1946968-2-eadavis@qq.com>
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

#syz test

diff --git a/sound/core/control.c b/sound/core/control.c
index 0ddade871b52..b9b9dde9807a 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -82,6 +82,7 @@ static int snd_ctl_open(struct inode *inode, struct file *file)
 	scoped_guard(write_lock_irqsave, &card->controls_rwlock)
 		list_add_tail(&ctl->list, &card->ctl_files);
 	snd_card_unref(card);
+	printk("card: %p, dev: %p, %s\n", card, &card->card_dev, __func__);
 	return 0;
 
       __error:
@@ -91,6 +92,7 @@ static int snd_ctl_open(struct inode *inode, struct file *file)
       __error1:
 	if (card)
 		snd_card_unref(card);
+	printk("err: %d, card: %p, %s\n", err, card, __func__);
       	return err;
 }
 
@@ -113,6 +115,9 @@ static int snd_ctl_release(struct inode *inode, struct file *file)
 	struct snd_kcontrol *control;
 	unsigned int idx;
 
+	if (!file->private_data)
+		return 0;
+
 	ctl = file->private_data;
 	file->private_data = NULL;
 	card = ctl->card;
@@ -133,6 +138,7 @@ static int snd_ctl_release(struct inode *inode, struct file *file)
 	kfree(ctl);
 	module_put(card->module);
 	snd_card_file_remove(card, file);
+	printk("card: %p, %s\n", card, __func__);
 	return 0;
 }
 
@@ -2316,6 +2322,7 @@ static int snd_ctl_dev_disconnect(struct snd_device *device)
 		}
 	}
 
+	printk("card: %p, %s\n", card, __func__);
 	call_snd_ctl_lops(card, ldisconnect);
 	return snd_unregister_device(card->ctl_dev);
 }
@@ -2339,6 +2346,7 @@ static int snd_ctl_dev_free(struct snd_device *device)
 		xa_destroy(&card->ctl_hash);
 #endif
 	}
+	printk("card: %p, %s\n", card, __func__);
 	put_device(card->ctl_dev);
 	return 0;
 }
diff --git a/sound/core/init.c b/sound/core/init.c
index 114fb87de990..70145add5ace 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -544,6 +544,8 @@ void snd_card_disconnect(struct snd_card *card)
 
 	if (card->registered) {
 		device_del(&card->card_dev);
+		printk("card: %p, dev: %p, kref: %d, %s\n", card, &card->card_dev,
+			kref_read(&card->card_dev.kobj.kref), __func__);
 		card->registered = false;
 	}
 
@@ -580,6 +582,7 @@ EXPORT_SYMBOL_GPL(snd_card_disconnect_sync);
 static int snd_card_do_free(struct snd_card *card)
 {
 	card->releasing = true;
+	printk("card: %p, %s\n", card, __func__);
 #if IS_ENABLED(CONFIG_SND_MIXER_OSS)
 	if (snd_mixer_oss_notify_callback)
 		snd_mixer_oss_notify_callback(card, SND_MIXER_OSS_NOTIFY_FREE);
@@ -615,6 +618,7 @@ void snd_card_free_when_closed(struct snd_card *card)
 		return;
 
 	snd_card_disconnect(card);
+	printk("card: %p, kref: %d, %s\n", card, kref_read(&card->card_dev.kobj.kref), __func__);
 	put_device(&card->card_dev);
 	return;
 }
@@ -643,6 +647,7 @@ void snd_card_free(struct snd_card *card)
 	 * may call snd_card_free() twice due to its nature, we need to have
 	 * the check here at the beginning.
 	 */
+	printk("card: %p, rl: %d, %s\n", card, card->releasing, __func__);
 	if (card->releasing)
 		return;
 
@@ -1074,6 +1079,7 @@ int snd_card_file_add(struct snd_card *card, struct file *file)
 		return -ENODEV;
 	}
 	list_add(&mfile->list, &card->files_list);
+	printk("card: %p, dev: %p, %s\n", card, &card->card_dev, __func__);
 	get_device(&card->card_dev);
 	return 0;
 }
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
index 96a412beab2d..efd775aaa684 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -509,6 +509,7 @@ batadv_hardif_is_iface_up(const struct batadv_hard_iface *hard_iface)
 static void batadv_check_known_mac_addr(const struct net_device *net_dev)
 {
 	const struct batadv_hard_iface *hard_iface;
+	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL * 5, 1);
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
@@ -523,9 +524,11 @@ static void batadv_check_known_mac_addr(const struct net_device *net_dev)
 					net_dev->dev_addr))
 			continue;
 
+		if (__ratelimit(&rs)) {
 		pr_warn("The newly added mac address (%pM) already exists on: %s\n",
 			net_dev->dev_addr, hard_iface->net_dev->name);
 		pr_warn("It is strongly recommended to keep mac addresses unique to avoid problems!\n");
+		}
 	}
 	rcu_read_unlock();
 }


