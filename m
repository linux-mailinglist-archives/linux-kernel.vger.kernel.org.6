Return-Path: <linux-kernel+bounces-248385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CA292DC7F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 01:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A016A1C226EB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 23:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E72157480;
	Wed, 10 Jul 2024 23:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3sYo3Ee"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A6113C679;
	Wed, 10 Jul 2024 23:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720653436; cv=none; b=OSQKzxGGRVlC2vbGm0qLxg2bW+Gr3FHKGSUMWx8w7JobKwH0wPLDQMOcfgJD8p0JTqhCAXF6tLCbhyaGNzNtKzjcC0fyluAazJH3h318UFFFCv2+lrqsjEmc1aR9+mUxSO3QH8pAfWnD+zaTSFd1WsjGYmnq0uIYqp/NSJAiG6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720653436; c=relaxed/simple;
	bh=UvnaxlqmvLPi8Lr06uQh+kZE7yBmnckwmYquWml+mFU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=rbBnwuPaM3gv/RfIIFqckzIhafEq7x/Zlyr/KDdUyyuMPkqlK9kSPunqdmCovtNiWd5bgn5TcyRBpFvU7cOV9mcYr7+yFYCTJTt6QKrufmR33nrzowwnoMJ1wrvB87h6S7bBDKR3neZXwLmTRZ4SaipqqzeDT6Fvft2IPoyAaAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3sYo3Ee; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fbc3a9d23bso1948245ad.1;
        Wed, 10 Jul 2024 16:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720653434; x=1721258234; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQWSgKIn8SEmuSNSdTgDWNDQAMDWOagG0JDZoov0LeU=;
        b=h3sYo3EeMMxrd8tQNFdADJIl2MZL5g8XcibMpYdGUPCBYh/llbk8nxTdl9YdGPbrHj
         xM8MgDduxBbX9UI4xMgpMPcBa4meBj8TIxzVIlHAW0XvxSAIpvJrxWHbW1KUUdm2usYg
         7Kr1V+e1vJyYIIdPH2AqJg+J5dsHX230h1Ar0oi7geI3Q742VyhYmtdtRCVmSZ93svsm
         Pvq+FXjpne1YntqFFVsnhSmKDPBekXzojTcIVI+A+HpjL/qdYAt0KrzDz/TK6TchwKmd
         561mLaiyKX3O4nxuXYEHTwNkhubrW24EtA64VtxSe9e28IDm/ObsgrGMTRqNC/vLeTzx
         uZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720653434; x=1721258234;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PQWSgKIn8SEmuSNSdTgDWNDQAMDWOagG0JDZoov0LeU=;
        b=u9c0JLZzqyKEQdFzKAMavS9nsaq9N1IPzYNVO/2vjVbxUw45Mxpq4KrrJvtidF1+3j
         MKGlGboVJSgD2wAgESL0VK0taAU1gbgMeScjEnc/S8t9p4JDn0XNMHS8p4CTVbHEr6lU
         pSzAedCQXV0q9uHvHG38SvwoDKAkQ8r50zx1qRDmIlEpcaVhcUd+p3pwnGm8jSAOWwQO
         fPw2Qo+y/cT7JOFI8dU7VzArdL7H4KNjKwtvZMIGHTUKsITGoX3UpMeJyhxFPpWI5U2n
         AueZzsUj7pZoAGVrLOWkGktY9Kzfk/Y3l0oocar5u3tcV8OLiTvH54sm2lnbvC4Iwonj
         mYUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVU7DLw2Q0gKE4sSaq7V680IPq/NlVVoAzPopI67TWBDFbh2WcuAq8jXxgWprmBs1owDMA1BcERbJ5fruE3h/0AKMtP7AGNlYHCUsDNc/9VYJjETiv71Njj4C1A4+eeBUGCBz009Jb5
X-Gm-Message-State: AOJu0YxqboRM/7ohnxxiM6Owdm1T7L06Qpnyp8byuuKAFUAPBBEbh//o
	9cLTpFyJbCxIDOdNZOz/XZMLlXnQSAS7mGaGI2HpJI62FTRnNUvQ
X-Google-Smtp-Source: AGHT+IF0369HLlf0s7HuwPmn5hGEIVx0M9loDIYoTAscU8I/4tLonBO2sWtXOaotBw0tCDfUpnNMbw==
X-Received: by 2002:a17:902:ec8a:b0:1fb:35c7:8ea4 with SMTP id d9443c01a7336-1fbb6d25092mr56341335ad.2.1720653434291;
        Wed, 10 Jul 2024 16:17:14 -0700 (PDT)
Received: from localhost.localdomain ([46.232.120.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ad1e47sm38492715ad.282.2024.07.10.16.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 16:17:13 -0700 (PDT)
From: ryan <ryanzhou54@gmail.com>
To: jikos@kernel.org
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ryan <ryanzhou54@gmail.com>
Subject: [PATCH] hid: usbhid: Enable remote wake-up based on device configuration
Date: Thu, 11 Jul 2024 07:16:06 +0800
Message-Id: <20240710231606.3029-1-ryanzhou54@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

According to the USB protocol, the host should automatically
adapt the remote wake-up function based on the configuration
descriptor reported by the device, rather than only the default
keyboard support. Therefore, it's necessary to support other hid
devices, such as digital headsets,mice,etc.

Signed-off-by: ryan <ryanzhou54@gmail.com>
---
 drivers/hid/usbhid/hid-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index a90ed2ceae84..d2901ad9a871 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -1179,16 +1179,16 @@ static int usbhid_start(struct hid_device *hid)
 	/* Some keyboards don't work until their LEDs have been set.
 	 * Since BIOSes do set the LEDs, it must be safe for any device
 	 * that supports the keyboard boot protocol.
-	 * In addition, enable remote wakeup by default for all keyboard
-	 * devices supporting the boot protocol.
 	 */
 	if (interface->desc.bInterfaceSubClass == USB_INTERFACE_SUBCLASS_BOOT &&
 			interface->desc.bInterfaceProtocol ==
 				USB_INTERFACE_PROTOCOL_KEYBOARD) {
 		usbhid_set_leds(hid);
-		device_set_wakeup_enable(&dev->dev, 1);
 	}
 
+	if (dev->actconfig->desc.bmAttributes & USB_CONFIG_ATT_WAKEUP)
+		device_set_wakeup_enable(&dev->dev, 1);
+
 	mutex_unlock(&usbhid->mutex);
 	return 0;
 
-- 
2.17.1


