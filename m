Return-Path: <linux-kernel+bounces-396135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2BB9BC85D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B267DB22217
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 08:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E461CEEB8;
	Tue,  5 Nov 2024 08:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="y3mhPEmT"
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473271C4A18
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 08:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730796883; cv=none; b=TSb/h/vnqsHTP02erFWBoA2RasKtpOLcdv8ylpPfm95+CMbOXV/eKcDe5FWVhdhjJyIyavqlDf6Ha/xQ2QJC8Qd4+yDup95N7Mz+Hvl4PwmLG1uIHL27fcsQg1cKqlmjZesiqYt9IJqeydDuAFP44YhGASNVibqop9bWCzKsteE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730796883; c=relaxed/simple;
	bh=CvhNLvomh8rN0oR98CfGI7iRdWS9DAYIOCsnyQRoapo=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=i/GwSfqwKeW7dhwiXG2SmAvxqUQvGfaLWcIhMf3wvLsjZbhCOeYDD4l1RLoLxq1xca5odB6JffVHVBU6I6VRmOnpCrSxuoJ5pvgyS2dg0DI11ppM4ULj++kHxltUqPf45OOdQNEyQe8aCG6Tz7/woTy8S76eu1zWK56USOMWsmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=y3mhPEmT; arc=none smtp.client-ip=43.163.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1730796860; bh=l3JvvFtW1iqZVDFnXtYZBFgI4xPS4PxbpKJVqgykrEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=y3mhPEmTAh3zTn7p9n3iCrPStZoujiuiuwKP3MgP2kmmMzUR3HtJmGikPxAaE4lKX
	 Vu9WXcIZVNLUlwJaA64n2JHwySN9lFCNBDyJqfZOU/zXCvhkA6Kr4lhMx7/j9F8Nn2
	 wdg8ywo/DeIAoL+SbOu5s6xZCCfCtoj57kYv7n10=
Received: from pek-lxu-l1.wrs.com ([111.198.227.254])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id D931FAF3; Tue, 05 Nov 2024 16:54:19 +0800
X-QQ-mid: xmsmtpt1730796859tff9v9rwb
Message-ID: <tencent_BAECB2CD2C7B7E6C742CD56CA897E4E9B20A@qq.com>
X-QQ-XMAILINFO: NKv2G1wnhDBnqRB1Nzj+yferRNmbZwCuA165KFHW1l38s1hbpo6517nZbLgKLd
	 tlzHziAf4nCOJnXNd2iC+qilRnj+0mQsN3J7Ypky2u6EjwzemOk+2eeBCK+QxZZx/FNQqPCKITkP
	 8Sb5AHYJ1bBAH/ba/IXOd9xjYFb4r0T8vkmE1eFL8/2vVQafbvYd4Xt4Vnc2X0xxnyrk77IypyaY
	 sZsbMo2gY2m4y9HleTsL3dNEX0ULI/KwUJcma5TsU4JqF9Kb9DcnXJO0ORTsObSX5phlinuS1AoV
	 pbGy3kbB4BVq0Vxv3YajSAgytHft1mRR7TFQzRkWs38TZM0+DscbKLi8YM59AjPCqRLQACWH48EN
	 KBWqSg6s0II/uhZvVS9O3je/SVIL1iJeSPE7Y70+vHldeN/go0N6sVaXgxlTjmcGYUyYEQHAzgAz
	 tiKNMSouKci8cgl8SulFAzryt9etghr61KAU0VCZv5FAJInstJGUVBiYlSroq/Y7do34vcQPmR5J
	 E7wAULfuKiwslpW4QrJAEFqj3wzyeeTjmTvNRZ/MgQdFOwGlMMSFz4H27WLzjPPwQVDPLSwe5nD0
	 gcQ1KvmIzZMsZUEjvYaEmbJJIPUL52bnwbNd3jtSu1j6m8UW5UPUAJM2axZ/fIWtfz0fKP6Fowwf
	 eA64yDIqrEbazeJfdM70PB5vaqADCYU9C8OiLAfRKnXfzRYjeRqLnqGjediabaA1MuMAQ+V+QYyd
	 bsKIeSS2oO7cCBAGkEISUGLy0U/bq+TIJnhYduf3HZv6VPRfh5SCaYNVmwhhVSuzo53E8xZPE051
	 vBkVjPhlLka4SQSnz6OeUSEtNtoVGNPzASh5387ONZnPJkzF2oz2nlrF4/aOHdRaThjRYwpJAMdD
	 Pk48sg+cwmuTlmJwD6UrtW10hlSsIAZfWNapkiz0D6NkFa8zqjtQzUJij6kR09FQ==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+73582d08864d8268b6fd@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [sound?] INFO: task hung in snd_card_free
Date: Tue,  5 Nov 2024 16:54:19 +0800
X-OQ-MSGID: <20241105085418.1805422-2-eadavis@qq.com>
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
debug: why card_dev not release ?
debug: why snd ctl not release ?

#syz test

diff --git a/sound/core/control.c b/sound/core/control.c
index 0ddade871b52..5a0d46e757ba 100644
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
@@ -133,6 +138,8 @@ static int snd_ctl_release(struct inode *inode, struct file *file)
 	kfree(ctl);
 	module_put(card->module);
 	snd_card_file_remove(card, file);
+	printk("card: %p, %s\n", card, __func__);
+	snd_card_unref(card);
 	return 0;
 }
 
@@ -2316,6 +2323,7 @@ static int snd_ctl_dev_disconnect(struct snd_device *device)
 		}
 	}
 
+	printk("card: %p, %s\n", card, __func__);
 	call_snd_ctl_lops(card, ldisconnect);
 	return snd_unregister_device(card->ctl_dev);
 }
@@ -2339,6 +2347,7 @@ static int snd_ctl_dev_free(struct snd_device *device)
 		xa_destroy(&card->ctl_hash);
 #endif
 	}
+	printk("card: %p, %s\n", card, __func__);
 	put_device(card->ctl_dev);
 	return 0;
 }
diff --git a/sound/core/init.c b/sound/core/init.c
index 114fb87de990..876cd1b80029 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -387,8 +387,10 @@ struct snd_card *snd_card_ref(int idx)
 
 	guard(mutex)(&snd_card_mutex);
 	card = snd_cards[idx];
-	if (card)
+	if (card) {
+		printk("card: %p, dev: %p, %s\n", card, &card->card_dev, __func__);
 		get_device(&card->card_dev);
+	}
 	return card;
 }
 EXPORT_SYMBOL_GPL(snd_card_ref);
@@ -537,6 +539,11 @@ void snd_card_disconnect(struct snd_card *card)
 		synchronize_irq(card->sync_irq);
 
 	snd_info_card_disconnect(card);
+	struct device *child = device_find_any_child(&card->card_dev);
+	if (child) {
+		printk("child: %p, %s\n", child, __func__);
+		put_device(child);
+	}
 #ifdef CONFIG_SND_DEBUG
 	debugfs_remove(card->debugfs_root);
 	card->debugfs_root = NULL;
@@ -544,6 +551,8 @@ void snd_card_disconnect(struct snd_card *card)
 
 	if (card->registered) {
 		device_del(&card->card_dev);
+		printk("card: %p, dev: %p, kref: %d, %s\n", card, &card->card_dev,
+			kref_read(&card->card_dev.kobj.kref), __func__);
 		card->registered = false;
 	}
 
@@ -580,6 +589,7 @@ EXPORT_SYMBOL_GPL(snd_card_disconnect_sync);
 static int snd_card_do_free(struct snd_card *card)
 {
 	card->releasing = true;
+	printk("card: %p, %s\n", card, __func__);
 #if IS_ENABLED(CONFIG_SND_MIXER_OSS)
 	if (snd_mixer_oss_notify_callback)
 		snd_mixer_oss_notify_callback(card, SND_MIXER_OSS_NOTIFY_FREE);
@@ -615,6 +625,7 @@ void snd_card_free_when_closed(struct snd_card *card)
 		return;
 
 	snd_card_disconnect(card);
+	printk("card: %p, kref: %d, %s\n", card, kref_read(&card->card_dev.kobj.kref), __func__);
 	put_device(&card->card_dev);
 	return;
 }
@@ -643,6 +654,7 @@ void snd_card_free(struct snd_card *card)
 	 * may call snd_card_free() twice due to its nature, we need to have
 	 * the check here at the beginning.
 	 */
+	printk("card: %p, rl: %d, %s\n", card, card->releasing, __func__);
 	if (card->releasing)
 		return;
 
@@ -1074,6 +1086,7 @@ int snd_card_file_add(struct snd_card *card, struct file *file)
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


