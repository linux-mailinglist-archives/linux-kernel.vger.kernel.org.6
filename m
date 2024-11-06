Return-Path: <linux-kernel+bounces-397613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A209BDE07
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 05:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33C50B21F02
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 04:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EDA18FDA7;
	Wed,  6 Nov 2024 04:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9GLejpu"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2ACC13541B
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 04:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730868242; cv=none; b=ZCHFMhTbuGAdTwRq0Su+axphtRKcotSMU1/I3DuW8tHoU2cBkprLSVmGn/Ng6ycJSpNxv9HUqsC82D+CYe+jGIxFaeqRodRlhoDmDx2lTG2/N5WWyz0Rk2QKTdTiEkv2WVEoDRN1gCd+haFMpUFGre649gIcDlqg9QT8/vzIHYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730868242; c=relaxed/simple;
	bh=v0mj4iHS2AcJjyQzUT0HHHbN8oGmEGeWY237yo/EC5A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=U0Thdn2z+/+utH1bI6gMrpvtJ45H3Nb8QTSGXtuXkwpLicuB/HTgxTzNIswUr3iqRDQ6THUbYnz+pQAhARiDuzboVM0eAT2yTIZzSvPc1WrowJnGRVOREO9pb0JJxoiUzrkBj1uXEUiXYBSCC0PR8wiV7u423OfhoPt1Teka0SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C9GLejpu; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e292926104bso5439511276.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 20:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730868240; x=1731473040; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1hG81OY+sK0KIH9hrfg0FWPMZMNmu51liLPWxMDxEMo=;
        b=C9GLejpupPnNO+3Rh8ih4s5mKIMTd1q150BA0kGvQ03yHpEP6ASeDdOfX2SKcwFfTT
         3yorpkFA6rYRxwRho3v/KLDqo7ud0Vv1lffF56eYgrTW/WxB10aBzWa//ahliDJVqlLq
         ZumPhRw8t6+aRkS4AEt73eB52Bzfsj1L/0I+Su6xpdD1GZvC+8hMH2a+NsDWL3bFo4z7
         6/r/Y6DYGiVDIjjHd0xpc0IWgxJFRmyzZzJ2ecF76ZhoA44M5LkzMBT6BhAeJ33Qmucw
         sXC8PnVaFAncm5mD/J6F+JytCpjdODxlyPgh1WwfQATDOOeybZ5/422lndGcRO1FrsEH
         0UVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730868240; x=1731473040;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1hG81OY+sK0KIH9hrfg0FWPMZMNmu51liLPWxMDxEMo=;
        b=dnAuLwlSWgSv+6K64PWCKgCmc24Qt7paIGWBR0RnbeDnB2IDXwCTV270UOcOmZQm9Z
         FL2+9tYwm12Z32URGfsxox3uuRk01l2dUpmTq4GioQ1iKYk8cmTZxfswP22GXPBfos19
         F2+Q0/yUtC2bIE2TNhAJBdzC5euAFy8LWBkD8vaFB7xFFEYDyS2fYo+5Z3X0DegpSRoC
         M3ATfjo7hCCTIU5HnVQxHVcmHEJH54L+MOdbo+ucxfGy+EocZiAdWaYWzNxJAg51GsuM
         aZYbL5zQSds6nVS0mkV1gQZToUw7BH6rFe7gU6LYFOis9Fv8BX4jaKLahbBOHRUlFTnj
         7qkw==
X-Forwarded-Encrypted: i=1; AJvYcCVeuBS343GK6l3Qkq/8m8trU/lvRkXrCLQOlK0FwmjvfL0xEDeJc8/5sa89saqQ3fDwqJpiquOe8q0OE2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5lXCDqrrFC72fBJNTevYaU86ql7HCHxY0Ab9YgipAqqKf9Urp
	LsknBIPU2o7yfoT/5wtErsiw+ef/YHtmmYvdO6nGiFo3Gi7HhuOz
X-Google-Smtp-Source: AGHT+IEI7rQ3/6JmC7Ey/LXHmWRI+aFB+MmdUlzaX2WeIrpvnl3a7QR9s4neykygAoY1TgiG6q3iiw==
X-Received: by 2002:a05:6902:705:b0:e33:1505:d846 with SMTP id 3f1490d57ef6-e331505da22mr13334189276.22.1730868239828;
        Tue, 05 Nov 2024 20:43:59 -0800 (PST)
Received: from gmail.com ([24.130.68.0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee455a73d2sm10215726a12.46.2024.11.05.20.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 20:43:59 -0800 (PST)
Date: Tue, 5 Nov 2024 20:43:57 -0800
From: Chang Yu <marcus.yu.56@gmail.com>
To: syzbot+3e563d99e70973c0755c@syzkaller.appspotmail.com
Cc: syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: raw_gadget: Add debug logs to a troubleshoot a
 double-free bug in raw_release.
Message-ID: <Zyr0DaD6yG6WDHXz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

#syz test

syzkaller reported a double free bug
(https://syzkaller.appspot.com/bug?extid=3e563d99e70973c0755c) in
raw_release.

From the stack traces it looks like either raw_release was invoked
twice or there were some between kref_get in raw_ioctl_run and
kref_put raw_release. But these should not be possible. We need
more logs to understand the cause.

Make raw_release and raw_ioctl_run report the ref count before
and after get/put to help debug this.

Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
Reported-by: syzbot+3e563d99e70973c0755c@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=3e563d99e70973c0755c
---
 drivers/usb/gadget/legacy/raw_gadget.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/legacy/raw_gadget.c
index 112fd18d8c99..ac4e319c743f 100644
--- a/drivers/usb/gadget/legacy/raw_gadget.c
+++ b/drivers/usb/gadget/legacy/raw_gadget.c
@@ -194,6 +194,8 @@ static struct raw_dev *dev_new(void)
 		return NULL;
 	/* Matches kref_put() in raw_release(). */
 	kref_init(&dev->count);
+	dev_dbg(dev->dev, "%s kref count initialized: %d\n",
+		__func__, kref_read(&dev->count));
 	spin_lock_init(&dev->lock);
 	init_completion(&dev->ep0_done);
 	raw_event_queue_init(&dev->queue);
@@ -464,13 +466,21 @@ static int raw_release(struct inode *inode, struct file *fd)
 			dev_err(dev->dev,
 				"usb_gadget_unregister_driver() failed with %d\n",
 				ret);
+		dev_dbg(dev->dev, "%s kref count before unregister driver put: %d\n",
+				__func__, kref_read(&dev->count));
 		/* Matches kref_get() in raw_ioctl_run(). */
 		kref_put(&dev->count, dev_free);
+		dev_dbg(dev->dev, "%s kref count after unregister driver put: %d\n",
+				__func__, kref_read(&dev->count));
 	}
 
 out_put:
+	dev_dbg(dev->dev, "%s kref count before final put: %d\n",
+			__func__, kref_read(&dev->count));
 	/* Matches dev_new() in raw_open(). */
 	kref_put(&dev->count, dev_free);
+	dev_dbg(dev->dev, "%s kref count after final put: %d\n",
+			__func__, kref_read(&dev->count));
 	return ret;
 }
 
@@ -603,8 +613,12 @@ static int raw_ioctl_run(struct raw_dev *dev, unsigned long value)
 	}
 	dev->gadget_registered = true;
 	dev->state = STATE_DEV_RUNNING;
+	dev_dbg(dev->dev, "%s kref count before get: %d\n",
+			__func__, kref_read(&dev->count));
 	/* Matches kref_put() in raw_release(). */
 	kref_get(&dev->count);
+	dev_dbg(dev->dev, "%s kref count after get: %d\n",
+			__func__, kref_read(&dev->count));
 
 out_unlock:
 	spin_unlock_irqrestore(&dev->lock, flags);
-- 
2.47.0


