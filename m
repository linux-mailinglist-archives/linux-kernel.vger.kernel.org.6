Return-Path: <linux-kernel+bounces-212036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C45905A53
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 20:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A65F11F224E2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE43183061;
	Wed, 12 Jun 2024 18:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QCdTbmGh"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8E41822D5
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 18:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718215497; cv=none; b=Iyvh9Jtwjf+0K3cgE7+4WztvkjhIiuuOAP4Sv1zSEMubrjkKdyhyRYo71zcBeZQrGYjv2lDOwS4DLy778GvBNBfxWlAUoy/PgeEjZ5v8a5TMzs1Lj9cqGDig9JtkcLV1O8a2PYMkMt5fqfHYgjqfgN5na88++TH/0LjSD120px4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718215497; c=relaxed/simple;
	bh=dFn5z5vyRgzrtdFYpRlXpNJabtvUhGHB6/rVF68SWB8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iXhd/v7vMii+Ks6Ch+vH2yLiD7cqDTxROOy+bbVfiYm8DcvKYlUgldGpSIwVfaPfT+rQXJx11nt5BFoLqP8QhdmQfT+cie7u8Aej1RmDfuZt9Y/SDhuqB+0PCh4Ol3DxZr6Es3qhS/U1314T8ujd0uvL2Ku0gEMLNypZRCxoVAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QCdTbmGh; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-371cc143f6aso484595ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 11:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718215495; x=1718820295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cGLk/OMcBRjBjppSq5kcqwVIND0/RXijKiorHpLiyN0=;
        b=QCdTbmGhOmAcvA/8/9ES99bUZ1FCtYvMmOk7oluayCuofCjHtAdaIRRhRP56mwuKln
         s3U1ttNl/hsBRcqIh/dycYaHFx9VLHDTV8Y5Vt+dSKRFj8TYRUOUmKc0qhItLha7hjm5
         CW/9FepdqizM0uGdI8L7SjhYkJt/1ZSxsRPFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718215495; x=1718820295;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cGLk/OMcBRjBjppSq5kcqwVIND0/RXijKiorHpLiyN0=;
        b=IpvQDd8I7hO1J0tRxhzEvzhqH5w2d8QpYvlyAbZRHLtJnYnd297DTKCO6KYNUXYuOz
         S1fKPGSXwLYJDSQXZ0/YtGfJvsA0csV6nepiQ1aoa+/HphToeCnt0efbjB7+x2HEmxzP
         6At+fr6nTSzZBOjoCYOYAmAbxlN9k5QE5uLyjmbbbFu9bZk9Fm2Hh15jVE0juAeq2tQm
         nzZJrsUyOsVuc9hN+mku55dji6T0qrZJwO9OXi1t8tQNojhqqjpBIa1e8fLoNs/BneyL
         ONn7uziHmc0XsQeskENIM2fl2yXxFORP8T5BdNlzLpX/EVxL+T7p1/qLMvsoOmANGbON
         vGkg==
X-Forwarded-Encrypted: i=1; AJvYcCVKf6uIzJgGOGUNXkr+aYInvpODywwb5XMQEh84mv+v2HkTbcAh6j8G5qvEOqarNjX3nFd5qhWvHuuxeq8jCL+rPO3ISEuh2FDcUq1J
X-Gm-Message-State: AOJu0YzKPneGLFtd119pcq1fC+RNnM/BAAGijMSbOco8fSkC7Kvasz4y
	3JfgMXxcmzbUNJLrlp5XI6WT8VHp+umChTMfFhfHOvDRF/svOqVCkBU6TfaN2g==
X-Google-Smtp-Source: AGHT+IHsB4v7LqoJ57mEJVyYDJIaRFk8bzEhFib1t5I1fEjH2G8m5We1R5lTyptZEifb4qZ89Cgsbw==
X-Received: by 2002:a05:6e02:1a86:b0:375:c394:4344 with SMTP id e9e14a558f8ab-375cd1e44famr26980645ab.21.1718215494896;
        Wed, 12 Jun 2024 11:04:54 -0700 (PDT)
Received: from localhost (113.176.132.34.bc.googleusercontent.com. [34.132.176.113])
        by smtp.gmail.com with UTF8SMTPSA id e9e14a558f8ab-375a8ac5419sm14516575ab.21.2024.06.12.11.04.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 11:04:54 -0700 (PDT)
From: Matthias Kaehlcke <mka@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jameson Thies <jthies@google.com>,
	Benson Leung <bleung@google.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] usb: misc: onboard_usb_dev: Add match function
Date: Wed, 12 Jun 2024 18:04:48 +0000
Message-ID: <20240612180448.1.I805556c176c626872c15ce001f0e8198e1f95ae1@changeid>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a match function for the onboard_usb_dev driver. Primary
matching is still done through the VID:PID pair, as usual for
USB devices. The new match function checks in addition whether
the device has a device tree node, which is a needed for using
the onboard_usb_dev driver.

Remove the check for a device tree node from _probe(), the new
match functions prevents devices without DT node from probing.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

 drivers/usb/misc/onboard_usb_dev.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/misc/onboard_usb_dev.c b/drivers/usb/misc/onboard_usb_dev.c
index f2bcc1a8b95f..56710e6b1653 100644
--- a/drivers/usb/misc/onboard_usb_dev.c
+++ b/drivers/usb/misc/onboard_usb_dev.c
@@ -454,16 +454,18 @@ static struct onboard_dev *_find_onboard_dev(struct device *dev)
 	return onboard_dev;
 }
 
+static bool onboard_dev_usbdev_match(struct usb_device *udev)
+{
+	/* Onboard devices using this driver must have a device tree node */
+	return !!udev->dev.of_node;
+}
+
 static int onboard_dev_usbdev_probe(struct usb_device *udev)
 {
 	struct device *dev = &udev->dev;
 	struct onboard_dev *onboard_dev;
 	int err;
 
-	/* ignore supported devices without device tree node */
-	if (!dev->of_node)
-		return -ENODEV;
-
 	onboard_dev = _find_onboard_dev(dev);
 	if (IS_ERR(onboard_dev))
 		return PTR_ERR(onboard_dev);
@@ -513,6 +515,7 @@ MODULE_DEVICE_TABLE(usb, onboard_dev_id_table);
 
 static struct usb_device_driver onboard_dev_usbdev_driver = {
 	.name = "onboard-usb-dev",
+	.match = onboard_dev_usbdev_match,
 	.probe = onboard_dev_usbdev_probe,
 	.disconnect = onboard_dev_usbdev_disconnect,
 	.generic_subclass = 1,
-- 
2.45.2.627.g7a2c4fd464-goog


