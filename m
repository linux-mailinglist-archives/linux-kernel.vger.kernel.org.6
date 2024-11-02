Return-Path: <linux-kernel+bounces-393583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 508859BA2A3
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 23:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDD461F2296F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 22:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35FB158A33;
	Sat,  2 Nov 2024 22:01:02 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7308614E
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 22:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730584862; cv=none; b=vCUlYYvkZWijVpvuP6GHyDw5mb6basq6eoUyfYOW0fludeGBlUCx/Lfqo88otQlPJGCEYt+KtHxhwU13jrZT8STM394JJt2a/JzLPy5SjsvaDaXkMzgoxPESw+RNl4HAGu5q/WIh42azWHGHl2gshujPEXN8S6DS8fwXBjbjFOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730584862; c=relaxed/simple;
	bh=m6O7JVK2Y4NC2c2KWZjmfat94ZO0QYtS8+D81hBby60=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RQx+CjYatmE19mHkdS0+T6BkeAFt8Y1cmN7PMjrF/6wvmENcSlruB+SDriPZPZuOXxE1tLipQNovNyzzEfnkBC1LlE4k5BfunCjD9T5gVOy//9SMgyweI+6ajBrkASdVHy5tQ0+OiIWXnYFvBl1yJjLDwbzdxNn+nO4xFMBq82o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a6c48f1312so4540075ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2024 15:01:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730584859; x=1731189659;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v8tbj7e9k237S9KGvUBtD9qU/B90mL+uE91vmCaf7MQ=;
        b=Bb8/GnCO2FAfjffo6axtp1kz5XdUZXlxWWrxwWqx8Nqx9QyLmfsHXN1To5KA7MY3Rf
         0BfIH3UYOX+7Ms1cjVXjedJ/DXF9PS+hKBX+9f0VHMmAbE4lm6KF1M+YJV+v6SU7Rkem
         YZ0J4TQUk2ZDVLgPNNsvK+yV1ponh3bRWOsOsKPXIfWadihse9PxaGtQ17VY658Md3LL
         A9d7tiyjvX+E6TtBvLlzOHjPE3cYIbfPB6QGhfqxtMQkYA9fzNk+vbu5Pv3SgIPkNPc5
         25tUOULkPIehPQdLnlxAXyA+QMML1SKnBccOE7Uof7vKp0XZQo2BRZ8w6+Q4M8SgCBj/
         hc4Q==
X-Gm-Message-State: AOJu0YxHGT0AU6vFabBS6otdI2IIB/oIf3h2wIyt5er5ctLcI3Aysaz4
	9ko8JNXY+1SlMIgbhUPFmqch1zdW+sW3wBIji+jml38eh7EcO1/SFqnCbCWQskJE7Vcyd+aG4iz
	bu4lt7dAUXcAU1PHzmolrKp0LHRkJMV93JYdPEMgk33b0IKP7aM9GO8U=
X-Google-Smtp-Source: AGHT+IEP6+rDKbplC5ep0NypEj4o99iM1dTORM/McG7tQQMcgDXy2dOuyj7U2Vd64CeGuCr28DWUQhh8oMqWhOvLPwAsT5X1Jafg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:152e:b0:3a6:b445:dc9c with SMTP id
 e9e14a558f8ab-3a6b445decemr58449385ab.3.1730584859431; Sat, 02 Nov 2024
 15:00:59 -0700 (PDT)
Date: Sat, 02 Nov 2024 15:00:59 -0700
In-Reply-To: <0000000000003c68f3061fd2c285@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6726a11b.050a0220.35b515.0189.GAE@google.com>
Subject: Re: [syzbot] [PATCH] usb: raw_gadget: Fix a KASAN double-free bug in raw_release
From: syzbot <syzbot+3e563d99e70973c0755c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH] usb: raw_gadget: Fix a KASAN double-free bug in raw_release
Author: marcus.yu.56@gmail.com

#syz test

syzkaller reported a double free bug
(https://syzkaller.appspot.com/bug?extid=3e563d99e70973c0755c) in
raw_release.

I suspect this is because a race between raw_release and
raw_ioctl_run. While kref_get in raw_ioctl_run is protected by
the spin lock, all kref_put in raw_release are not under the
lock. This makes it possible that a kref_put might occur during
kref_get, which is specifically prohibited by the kref
documentation[1].

The fix is to ensure that all kref_put calls are made under lock
and that we only call kfree(dev) after releasing the lock.

[1] https://docs.kernel.org/core-api/kref.html

Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
Reported-by: syzbot+3e563d99e70973c0755c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3e563d99e70973c0755c
Fixes: f2c2e717642c ("usb: gadget: add raw-gadget interface")
---
 drivers/usb/gadget/legacy/raw_gadget.c | 44 ++++++++++++++------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/legacy/raw_gadget.c
index 112fd18d8c99..0c01d491d489 100644
--- a/drivers/usb/gadget/legacy/raw_gadget.c
+++ b/drivers/usb/gadget/legacy/raw_gadget.c
@@ -225,7 +225,6 @@ static void dev_free(struct kref *kref)
 		kfree(dev->eps[i].ep->desc);
 		dev->eps[i].state = STATE_EP_DISABLED;
 	}
-	kfree(dev);
 }
 
 /*----------------------------------------------------------------------*/
@@ -330,7 +329,8 @@ static void gadget_unbind(struct usb_gadget *gadget)
 
 	set_gadget_data(gadget, NULL);
 	/* Matches kref_get() in gadget_bind(). */
-	kref_put(&dev->count, dev_free);
+	if (kref_put(&dev->count, dev_free))
+		kfree(dev);
 }
 
 static int gadget_setup(struct usb_gadget *gadget,
@@ -443,34 +443,38 @@ static int raw_open(struct inode *inode, struct file *fd)
 static int raw_release(struct inode *inode, struct file *fd)
 {
 	int ret = 0;
+	int freed = 0;
 	struct raw_dev *dev = fd->private_data;
 	unsigned long flags;
-	bool unregister = false;
 
 	spin_lock_irqsave(&dev->lock, flags);
 	dev->state = STATE_DEV_CLOSED;
-	if (!dev->gadget) {
-		spin_unlock_irqrestore(&dev->lock, flags);
-		goto out_put;
-	}
-	if (dev->gadget_registered)
-		unregister = true;
+	if (!dev->gadget)
+		goto out_put_locked;
+	if (!dev->gadget_registered)
+		goto out_put_locked;
 	dev->gadget_registered = false;
 	spin_unlock_irqrestore(&dev->lock, flags);
 
-	if (unregister) {
-		ret = usb_gadget_unregister_driver(&dev->driver);
-		if (ret != 0)
-			dev_err(dev->dev,
-				"usb_gadget_unregister_driver() failed with %d\n",
-				ret);
-		/* Matches kref_get() in raw_ioctl_run(). */
-		kref_put(&dev->count, dev_free);
-	}
+	ret = usb_gadget_unregister_driver(&dev->driver);
+	if (ret != 0)
+		dev_err(dev->dev,
+			"usb_gadget_unregister_driver() failed with %d\n",
+			ret);
+
+	spin_lock_irqsave(&dev->lock, flags);
+	/* Matches kref_get() in raw_ioctl_run(). */
+	freed = kref_put(&dev->count, dev_free);
+	if (freed)
+		goto out_free_dev;
 
-out_put:
+out_put_locked:
 	/* Matches dev_new() in raw_open(). */
-	kref_put(&dev->count, dev_free);
+	freed = kref_put(&dev->count, dev_free);
+out_free_dev:
+	spin_unlock_irqrestore(&dev->lock, flags);
+	if (freed)
+		kfree(dev);
 	return ret;
 }
 
-- 
2.47.0


