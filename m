Return-Path: <linux-kernel+bounces-390614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 582929B7C3F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 14:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89D4C1C213AE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 13:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B8519F13B;
	Thu, 31 Oct 2024 13:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lmeesBD6"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4DA19AD7E
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 13:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730383152; cv=none; b=Mkog9vpzJOg+UsSOqMzlo/48zYGkKqKmiFj4wa3rqCmujkURKf4Stl7mgUdJWpSQK5+HGgCs40QSTs4EghsAxu2Arz+B2C2JxnvAwzsRtwdV9d2Iy7fOp0Gxdn75GZsuQkueFoIAPwe0uh+fA/qvQd/vpDT+DLdvr+1z/PW9j3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730383152; c=relaxed/simple;
	bh=K2hujl7eH7Z87W+bsWlOEkHehHy88v30Yt97H2HxtzM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mVIenNFpJ80yoUYLxE08VGN6wT94YIQcR+ZK1xR0iJAbbEsKAELDPaxcv6PQWCdB7B1ps2xEl7xLh/2LJTfTfEscK6WbXeJZlrfWubp/uk22Qz4BHmLQ2n2xb7ObIpOG7Xus90sC6he1ALeYtvQa/3fOp3sB4FmTZgXxu0k5LVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lmeesBD6; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b1539faa0bso62534385a.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 06:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730383149; x=1730987949; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Uo59+S8n8ihDV0tvqD+LlqwcUibHQwQasTadU8egHQ=;
        b=lmeesBD6NHsnatc+0tswx3hHCgf1WhRk1Tr82aYHWgClv+Hvqf8FLOnWq4IieNXPRS
         NPRWny5o9JLbKT+9g0J2juwTxYXYR32NbMkebSY7o104TTw3fac9GWxGWGiALKpau+Wz
         yozqP9AtrjI8hE+vhTBFndP1WNLkuy4w10fmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730383149; x=1730987949;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Uo59+S8n8ihDV0tvqD+LlqwcUibHQwQasTadU8egHQ=;
        b=Ji3pwMZrSO81PGRDDrTG6o69jtiQd4ZP2BFjS9vOYaj5UBmJMhEPtMcTscMYsGx+z3
         ShwzlgcEgOiFYUYCYHfR9MCfG+zzaUm2oYG1igEmaIW8zHeSin9GOyZXb2rU7pJPx9tF
         U5exYPa+9i3Taa8ZlAaZmpNJWYSeObApCWs2iZFKyl9oCk0woXbzRmXi4zC4vqM579k0
         r1nVdopuexZdNSR5DySI3Jd9jqcUYemYOV49DtjiQT0qa+hXyj+07/BdOcxcafoOBr4L
         +r4qO2bdcBIPqmbsR/ZM8frMBbq9c1YOCCOAr9tykgGowTc5CbQPKSW27rV1ii90PWVV
         87FQ==
X-Forwarded-Encrypted: i=1; AJvYcCVi8nr4sPCTUKu2gF3chVZPBsxGgEq51XXqRPFE/24v5c8lwpWm4HXkaSUEZBtqcjR1TTuhCBUN9mU4wcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKmyeK/WOSkJkSj5CP99wFqd2Fqpc68CwDMMGY9pzxzaphlnz7
	nK3HtfVfQlAut9h1SKkilo1xWClpDtRVMzot7+Tulx5aNbUpzsxePdiLWKY8pJwFqk0+yKUavok
	=
X-Google-Smtp-Source: AGHT+IHvMX/Q5VI9TzkiDp9lLETctTVq9aQXYlohWs8bV7Xxcdz8KXczIh48FHNrlokJ68ljbM297A==
X-Received: by 2002:a05:620a:46a9:b0:7b1:4f5c:6e86 with SMTP id af79cd13be357-7b2f24db173mr403627785a.17.1730383149659;
        Thu, 31 Oct 2024 06:59:09 -0700 (PDT)
Received: from denia.c.googlers.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f39fab52sm71090385a.50.2024.10.31.06.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 06:59:09 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 31 Oct 2024 13:59:08 +0000
Subject: [PATCH] media: uvcvideo: Fix crash during unbind if gpio unit is
 in use
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241031-uvc-crashrmmod-v1-1-059fe593b1e6@chromium.org>
X-B4-Tracking: v=1; b=H4sIACuNI2cC/x3MQQqAIBBA0avErBOaFKGuEi1Ep5yFFSNJEN49a
 fkW/7+QSZgyzN0LQoUzn0cD9h346I6dFIdmGIfR4KBR3cUrLy5HSekMylobSG9+QoPQokto4+c
 fLmutHykjgwBgAAAA
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

We used the wrong device for the device managed functions. We used the
usb device, when we should be using the interface device.

If we unbind the driver from the usb interface, the cleanup functions
are never called. In our case, the IRQ is never disabled.

If an IRQ is triggered, it will try to access memory sections that are
already free, causing an OOPS.

Luckily this bug has small impact, as it is only affected by devices
with gpio units and the user has to unbind the device, a disconnect will
not trigger this error.

Cc: stable@vger.kernel.org
Fixes: 2886477ff987 ("media: uvcvideo: Implement UVC_EXT_GPIO_UNIT")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_driver.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index a96f6ca0889f..1100d3ed342e 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -1295,14 +1295,14 @@ static int uvc_gpio_parse(struct uvc_device *dev)
 	struct gpio_desc *gpio_privacy;
 	int irq;
 
-	gpio_privacy = devm_gpiod_get_optional(&dev->udev->dev, "privacy",
+	gpio_privacy = devm_gpiod_get_optional(&dev->intf->dev, "privacy",
 					       GPIOD_IN);
 	if (IS_ERR_OR_NULL(gpio_privacy))
 		return PTR_ERR_OR_ZERO(gpio_privacy);
 
 	irq = gpiod_to_irq(gpio_privacy);
 	if (irq < 0)
-		return dev_err_probe(&dev->udev->dev, irq,
+		return dev_err_probe(&dev->intf->dev, irq,
 				     "No IRQ for privacy GPIO\n");
 
 	unit = uvc_alloc_new_entity(dev, UVC_EXT_GPIO_UNIT,
@@ -1333,7 +1333,7 @@ static int uvc_gpio_init_irq(struct uvc_device *dev)
 	if (!unit || unit->gpio.irq < 0)
 		return 0;
 
-	return devm_request_threaded_irq(&dev->udev->dev, unit->gpio.irq, NULL,
+	return devm_request_threaded_irq(&dev->intf->dev, unit->gpio.irq, NULL,
 					 uvc_gpio_irq,
 					 IRQF_ONESHOT | IRQF_TRIGGER_FALLING |
 					 IRQF_TRIGGER_RISING,

---
base-commit: c7ccf3683ac9746b263b0502255f5ce47f64fe0a
change-id: 20241031-uvc-crashrmmod-666de3fc9141

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


