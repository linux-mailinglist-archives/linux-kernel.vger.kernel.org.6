Return-Path: <linux-kernel+bounces-396008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B1D9BC69D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 08:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74E961F21AD4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 07:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA60418BC37;
	Tue,  5 Nov 2024 07:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="AwCNNRR2"
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5EB1DC074
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 07:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730790140; cv=none; b=p939cUDpBz5Pl31hOgoXgaO2ToxLKdh1ywmne7SRUSZlOqglmB3ek8/2PELoaaQATFH3HXwVMsLYU5+McYhM4aqMfL5o0SoA214g3f8Guy06CJr4rHmhrlYwB09/8TZsln/6nEF7vzualz8nKpjWhn8phcnNSgl82XV3L0Oqt34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730790140; c=relaxed/simple;
	bh=8muJy3YvIT5WjW/NgzmrMXEnMgQAB0gYlC2wNCDdCSc=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Z3CO5tcLwTLuGCM/WGlYfUSAr0jvutCVnZ7eO9nRGO/gNk5GrPjXigKpVhQ0PzOcvsIDGmRqmdj45qhPRHkOwPb70B9gD5zhNImqNupNtAvPX6pqFX62kAxat1SS3S2dp5muS0xCBhxJS/R+EOz+h0IhKZAAe/qNxKHFNlAAnFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=AwCNNRR2; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1730789831; bh=WvUS2KVss320OxM9F5xH8bWcdOdcnd7Gph6Z1sllEcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AwCNNRR2zUj026vbanV17xcsQzx2Gws6SzFFwQn2DUmMcHrtg8ftgA18axRSW7zEu
	 iyNNo1JD9sb8w7zyNe0H0+kiES1lMVwUYOpCRXZcIQBAJz+mGAbVwLO5rTgmeazUYi
	 f0ohAZSRdp3BAp3WEmzc9AXNmrI85Ikd52LsY9TU=
Received: from pek-lxu-l1.wrs.com ([111.198.227.254])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id E4932C62; Tue, 05 Nov 2024 14:57:09 +0800
X-QQ-mid: xmsmtpt1730789829tkz3004zk
Message-ID: <tencent_EE9DA7FFC6DD52DFC65889ABEEEC6EC64C06@qq.com>
X-QQ-XMAILINFO: NyTsQ4JOu2J2NKP0ku038bMp6pLfLjny4KR8Hs0R4iOwjhuplmyaq/TREUxIN5
	 lY36nfzoxJ4n2JjyB0l+mQGlEOKpwx44fVE7+9Nbq8Ypcf7MBSzJ82wPkNw9ZMmBWt2Orsth/tCB
	 +nof11AtdB2J4uIMcYfGL6ytXV4ckepllLoPs1UgGLieFkHNvlYwquJ6TQjq9/3ou4MpfMswSjGl
	 NgM5CXE7cNKeFL8e8kbeAx+YijIezPxrJ/1YXhakVwwzuzxji5TOP+TAHAfaXAqaH69k6DKhNMKb
	 0UaxJvSbIkRplJiJmK708MhlQ9DMdEJg5GR9M/Lk8fLqovF36tEUQ/XTGOwc6hqYwFIwAjgXt+Fj
	 haFKpikCyJdbG6gH/b27GAAGgvM58IbtVizcI69Q+3OlZu7Uopdq+9+x/LxtWTjU3nK5cPK9o7yi
	 8lN1sikRxBbd6tGhcq5WLCz7l5g2X6mdxKoIZFQW5Ls2YkT13zly6fb0CpRkP0LB1t1f/T7LbpUn
	 Zu8Mq7Nu3TpYgR0zbEdQZ4C6p2zihNl16XFKz1cfJLdJcBk6Z3Ns/gumnQ0+RASEC7bL2nw0kild
	 aYPDAlL1YvxHpHKVT0Mtgk33b0Fp3jbzYzmo07LeV+nPQDHSVq3hR1YpCcZXdfIh9pLVcSpTo2I6
	 EycIMFFkkBnhwe9a9Dp7CNAnyqpGyHyAnv08WlKAkcfeY+oNn9JVH3amSXkd1ZNOZlQUbLP99JG1
	 hPxNDJjPycNxzojKIag3gJK6I19tFhS6tYaPCZ2MryzJ7E6BjpkOIVRHeL0O2QiR/o2+7W1OBb2D
	 g67brFKOlNQvkOtJPfsDcHrm4+xReEAiCZ2xiGIaaf29olfhgYfwSIwStjFeox00mLG+yRAAP5Lv
	 OeZg63BQraaZ7eRPlq9oGdQtO9A6yGcwiAEvnXgzmb5ela0/fXRFg=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+73582d08864d8268b6fd@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [sound?] INFO: task hung in snd_card_free
Date: Tue,  5 Nov 2024 14:57:09 +0800
X-OQ-MSGID: <20241105065708.1691008-2-eadavis@qq.com>
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
dubug: why card_dev not release ?

#syz test


diff --git a/sound/core/init.c b/sound/core/init.c
index 114fb87de990..35717e1d0049 100644
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
@@ -495,6 +497,7 @@ void snd_card_disconnect(struct snd_card *card)
 	if (!card)
 		return;
 
+	printk("card: %p, %s\n", card, __func__);
 	scoped_guard(spinlock, &card->files_lock) {
 		if (card->shutdown)
 			return;
@@ -544,6 +547,8 @@ void snd_card_disconnect(struct snd_card *card)
 
 	if (card->registered) {
 		device_del(&card->card_dev);
+		printk("card: %p, kref: %d, %s\n", card, kref_read(&card->card_dev.kobj.kref), __func__);
+		put_device(&card->card_dev);
 		card->registered = false;
 	}
 
@@ -580,6 +585,7 @@ EXPORT_SYMBOL_GPL(snd_card_disconnect_sync);
 static int snd_card_do_free(struct snd_card *card)
 {
 	card->releasing = true;
+	printk("card: %p, %s\n", card, __func__);
 #if IS_ENABLED(CONFIG_SND_MIXER_OSS)
 	if (snd_mixer_oss_notify_callback)
 		snd_mixer_oss_notify_callback(card, SND_MIXER_OSS_NOTIFY_FREE);
@@ -615,6 +621,7 @@ void snd_card_free_when_closed(struct snd_card *card)
 		return;
 
 	snd_card_disconnect(card);
+	printk("card: %p, kref: %d, %s\n", card, kref_read(&card->card_dev.kobj.kref), __func__);
 	put_device(&card->card_dev);
 	return;
 }
@@ -643,6 +650,7 @@ void snd_card_free(struct snd_card *card)
 	 * may call snd_card_free() twice due to its nature, we need to have
 	 * the check here at the beginning.
 	 */
+	printk("card: %p, rl: %d, %s\n", card, card->releasing, __func__);
 	if (card->releasing)
 		return;
 
@@ -1074,6 +1082,7 @@ int snd_card_file_add(struct snd_card *card, struct file *file)
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


