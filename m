Return-Path: <linux-kernel+bounces-395810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7F49BC350
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 03:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9714C281818
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 02:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091BB3F9D2;
	Tue,  5 Nov 2024 02:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="jXNf7Iqo"
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D10B3FB1B
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 02:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730774615; cv=none; b=czFn8GRqzT+1f4YupsyED4A/Ipn6jsa4IjeTOTbrqLfVxokFiHlu4s/Wurnh2saSdbYtAolJfkEBcz896s8g3vmii9PVYueVPEy6i/EU+Zn/dK+nTvnc7MxCQHfSU4F4e1bQrXSLUdEc+U4vve3Os1uQcnRSdqq6Ta3kA8pYxyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730774615; c=relaxed/simple;
	bh=ZJR/srUi5Ox4DyjXn2LLp2qWWlMAQuTVdYurJeWaGuw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=jW9PN8fGFopCEqYgrfDoyCifNU3ngFDtGjGlzOdZkZaloJJ/9YQoFpO1Aer8V/EsUBFk8QCqJog2LtNuBa5Fa60rKwJP8XIn+gO7sePD4cUCB4K1P5/Qor1xzSWmj8l6CznLMCnehi0M2yGN9LuxUixNHCsB2xPrBTTmUR9Xc0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=jXNf7Iqo; arc=none smtp.client-ip=43.163.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1730774274; bh=hhxrsqPnDvg8YMxEcz5WDsQNb1RTwbK3KSbmEkgxQRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jXNf7IqoH1wp8c/AirY8ZzOHyUs0zZKYL/S7ZPgm1cClb3yBe2vob91QVLx/3xXT9
	 ei9qn75e4JkCAAssadGS1hwIHZUT0rGGs/Q9bTui3HpS2l3ojngHkn0oKYh3eE0fda
	 rIfGErYkgPBbzUMgw9q5/sVIERfIoNrD7GBDmY8Y=
Received: from pek-lxu-l1.wrs.com ([111.198.227.254])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 97422E07; Tue, 05 Nov 2024 10:37:52 +0800
X-QQ-mid: xmsmtpt1730774272tq02brzrj
Message-ID: <tencent_D1C2975036F44A4274C57781667C3C9B3609@qq.com>
X-QQ-XMAILINFO: MyirvGjpKb1jhjE6VrM0t1A9C9Pl2Vpkix3Hr73SdTLNfZpRmMcJaB5eGVYccK
	 W+HsXzPrjW1jf8V4dOi/s0QBKi7fZtalQdMt5uQ9AV8RKH/D8GLCotNhj9jI2nzPrKz5aJndXurt
	 EWa/c/8pMKNBWOtBoPlcGVfx8Q+IOMpx+zPTuC4lEM5QL7gNmP4LlEWvLE85b7XwCLnrDEOE78o1
	 uRWbopJ+3AbNM5vmxTo3892T4x3PTs3nheh+r67UjbFjMr1uu8v+VDzSuhkujgQSEjy/NDH+GEHb
	 Mg75Qw7hE7ZdsGl/DYqlGczSmdzvenlKpVTYsyD9a+Fy5Y7V+c9EHZnZWvS5udv6FitbfhlMwPmS
	 eivYxzV2Ui118z/YjeXkrgzwKNT2WiWNMreiGxIouAlLiBH12eaMAKf20Re+2IKGX7bd5YF0/Dbx
	 iYK0XFXZRHWtsEvq2pwCWgZLu0g91jxkKglJSq6Oc7tIsnqk0rUiULGLVXH8fnuSqxK5FMsg0sAQ
	 uq6koVT7Lgat79BGrq8XDLQtuWOxrXJjguSfg2CZucPxslOrH7vvxmt/lLegRBUQ9h5AeH5DCtNx
	 kIBMqUn2iUI+OA3uvp5D/pd66pLzxftIUYcydE0nQKNzQ0ifV81EBIkK9GG+dNMo/55iXIyE2NBn
	 DnUvOT/k631iXUYi3vGtjXA4xM9KQi38nxnZGg9e5MxZdescv9e70vv1uv7EodwIpN3fd9XdEufm
	 vVjEuKM+ewtD++QP4gf5n+Xu4mV/RbsCXxv+NzGBWOKMOnKHhW20ZN1x73XUrThyc5Ncdy69yJcD
	 Q5OFDH+ARWY4Gxsa2pR7tVMy1kV+vqiAEJSCXAigdaofiv9xzPN9lkI37nVMvf5WwcpQaf2UVAZE
	 GxAVc8VMkQZeWQjNwbmjYbEZfURNTMNg==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+73582d08864d8268b6fd@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [sound?] INFO: task hung in snd_card_free
Date: Tue,  5 Nov 2024 10:37:53 +0800
X-OQ-MSGID: <20241105023752.1443749-2-eadavis@qq.com>
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

diff --git a/sound/usb/usx2y/usbusx2y.c b/sound/usb/usx2y/usbusx2y.c
index 2f9cede242b3..43301e02557a 100644
--- a/sound/usb/usx2y/usbusx2y.c
+++ b/sound/usb/usx2y/usbusx2y.c
@@ -150,6 +150,7 @@ static int snd_usx2y_card_used[SNDRV_CARDS];
 
 static void snd_usx2y_card_private_free(struct snd_card *card);
 static void usx2y_unlinkseq(struct snd_usx2y_async_seq *s);
+static DEFINE_MUTEX(devices_mutex);
 
 /*
  * pipe 4 is used for switching the lamps, setting samplerate, volumes ....
@@ -407,9 +408,12 @@ static void snd_usx2y_disconnect(struct usb_interface *intf)
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
@@ -423,6 +427,7 @@ static void snd_usx2y_disconnect(struct usb_interface *intf)
 	if (usx2y->us428ctls_sharedmem)
 		wake_up(&usx2y->us428ctls_wait_queue_head);
 	snd_card_free(card);
+	mutex_unlock(&devices_mutex);
 }
 
 static int snd_usx2y_probe(struct usb_interface *intf,
@@ -432,15 +437,18 @@ static int snd_usx2y_probe(struct usb_interface *intf,
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
@@ -449,10 +457,13 @@ static int snd_usx2y_probe(struct usb_interface *intf,
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
 


