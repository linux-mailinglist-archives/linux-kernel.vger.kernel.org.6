Return-Path: <linux-kernel+bounces-548300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 347ABA5431F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 07:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5869B16D03F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 06:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9D31A23BC;
	Thu,  6 Mar 2025 06:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=g-sokol-info.20230601.gappssmtp.com header.i=@g-sokol-info.20230601.gappssmtp.com header.b="C7kBcNzH"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902763FB9C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 06:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741244186; cv=none; b=rpBt+vGN0RcB1b70/4fRLhdoulJFpULaF3vgJw+x1YMxEZGVQuXW3QqG/O4Cmx1cZi24adXqQ3ydc3IfcsfTy15a/wsqI8IxwF8uhrkH375A90XN9kd2TKAUOi9GQvB4E1mhYP3jJzPHRylh/qHf/Kl/lA/0zRWe2nkpvgvZ0zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741244186; c=relaxed/simple;
	bh=84F6xy6gw1rvRcDsIfhxQ100b6HsmDruweAtANwXhto=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WBp29jguCBEqtU3Gglr8TRSmOv1O1ZFqURvXj5gomp6LlmEsLHsEQlgF7HZBnpu/u+J0Zd8Qk+ulS6dQ8jknQQql3WaHy2zpn45HmGi1jKN9D4rXADQwl+vxvoAguy6C223bnDXIPcy4DwVXHcu/c/SvMMiNf9qXHHovoQzIRYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=g-sokol.info; spf=none smtp.mailfrom=g-sokol.info; dkim=pass (2048-bit key) header.d=g-sokol-info.20230601.gappssmtp.com header.i=@g-sokol-info.20230601.gappssmtp.com header.b=C7kBcNzH; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=g-sokol.info
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=g-sokol.info
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5494bc4d741so327774e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 22:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g-sokol-info.20230601.gappssmtp.com; s=20230601; t=1741244182; x=1741848982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9J1UAFxuft6AB5He5eDNnL2NYFVVFehRdJNW0D9EciM=;
        b=C7kBcNzHSF7Q3vticWxLpqr56/RuXeskgx7hqSWgajARqfSou2I+JDAl2KDVgPNwUi
         5gEOCeeT+i1d070izS4Oq77tHjs6hHw+GMTpgR3AL9AMy/YoYn2mVYQbNqzwkzoj5vqD
         RP7jZydA0JECPhhB/Vd5IkJPyM5GBssXxtfJ9rQH2U3H0L+4afYDs/gNiKfjVesPRHQL
         fxu8e7xoR+zNTbWeU2aQykxT0td0ndT4mfjwy2N1+hBaDwz0RbXBgLefTBxGruOLvAXa
         7zVt7g1Yn49GQpAxzzJ4sJ9e+GHctXqLtJuel0DKVRQaRtV9cAb9j3dp60/ArL3pliLe
         PyRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741244182; x=1741848982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9J1UAFxuft6AB5He5eDNnL2NYFVVFehRdJNW0D9EciM=;
        b=IDEzeNcpHEvsYxegxEjD3rRuDJLoZ0DjAkFfMv477p05t16X4WEm3DaNtI+9SwUi9S
         I27vFAVIeke9IfAaCQkvnNf8gycMnKf5Xrc0vv17BnBY3EyMjYHg6TPJIi7/fljy5AUo
         q3Pw0S8DZ1PMnqtluggNNBZQMqoZkb0svfV7jKFc4JVfXu77mCgZZMJNvWbZAkk7RbYE
         9sqglVnSeitWZixp5WDu34jyRTPcTi/6k4v3mvLOmASyM+yoGbGawZW/s+Yt1Lnty8xb
         AK6A9Cueo10HzG4Y61Z5aSMI+LGRYLTX4A2/StipsyqD+nziRlcxnEtDHPOpc7aEJXp6
         +ELg==
X-Gm-Message-State: AOJu0YxH4mDSRxlWvMSPVQAgVR6dInvRIYSEzoBVZDe5lEP+smcDbYKp
	Gj3eCqXCBCh6ZLUZ5vf9AWQAFYegDTfMkv/lf+AZ5VfVMhOOvRBEG0S2R0i2WM0=
X-Gm-Gg: ASbGncunznP00MTPoGuCZMCs++6d3GT0erDQaA7AJrQa9tb1ZyrhhvT7zjDMHrZWEqn
	vLlOJWH/GURGXBhTpv/hH6FtpSFQZjerVlgXZyxs6NDpnXvsQFgBl7cIKPKFvxKIeF4NlvOgzO0
	sF3u0Pb5KRrIpAdLGskHyMXwVzczemnSsrY8wGZIrH5E5mE1WKtFotiW9fZb5dpUvX6c57vpyL4
	UgIYlfcuhiblp7DIVoAyv/YEp9EAU2+J/z3s8MEfnis5Mly25xTYT1jAZ6pSgXSowzD13Vvq4hB
	abGFFaStY7pg8R4HNvOXJUha6CX0W2VtKGrcztkLTGnmIlS3TZHkE0zn8wUDDMdmpSxQc/Dl89i
	w+5555jnJkG04+fc=
X-Google-Smtp-Source: AGHT+IFvVfRLJSn5mQdzcVB2sUFONLX0Xfg8aHov4Ik+qJ2iXLUu/+JXjO/C2S56dl+Sg0B7Ar2yjw==
X-Received: by 2002:a05:6512:1248:b0:549:4bf7:6463 with SMTP id 2adb3069b0e04-5497d389d13mr2515113e87.44.1741244180973;
        Wed, 05 Mar 2025 22:56:20 -0800 (PST)
Received: from localhost.localdomain (185-11-210-173.s1networks.fi. [185.11.210.173])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498ae59398sm85905e87.92.2025.03.05.22.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 22:56:20 -0800 (PST)
From: Grigorii Sokolik <g.sokol99@g-sokol.info>
To: jikos@kernel.org,
	jkosina@suse.com,
	jkosina@suse.cz,
	benjamin.tissoires@redhat.com,
	bentiss@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-input@vger.gernel.org,
	Ievgen Vovk <YevgenVovk@ukr.net>
Subject: [PATCH 1/2] HID: hid-apple: Apple Magic Keyboard a3203 USB-C support (backporting)
Date: Thu,  6 Mar 2025 08:56:07 +0200
Message-ID: <20250306065608.531205-1-g.sokol99@g-sokol.info>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ievgen Vovk <YevgenVovk@ukr.net>

Backporting of Ievgen Vovk's commit 2813e00dcd748cef47d2bffaa04071de93fddf00
From 6.14-rc5 to 6.13

Signed-off-by Grigorii Sokolik <g.sokol99@g-sokol.info>
---
[PATCH] HID: hid-apple: Apple Magic Keyboard a3203 USB-C support
Add Apple Magic Keyboard 2024 model (with USB-C port) device ID (0320)
to those recognized by the hid-apple driver. Keyboard is otherwise
compatible with the existing implementation for its earlier 2021 model.

Signed-off-by: Ievgen Vovk <YevgenVovk@ukr.net>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
---
 drivers/hid/hid-apple.c | 5 +++++
 drivers/hid/hid-ids.h   | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 7e1ae2a2bc..3c3f67d0bf 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -474,6 +474,7 @@ static int hidinput_apple_event(struct hid_device *hid, struct input_dev *input,
 			 hid->product == USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_2015)
 			table = magic_keyboard_2015_fn_keys;
 		else if (hid->product == USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2021 ||
+			 hid->product == USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2024 ||
 			 hid->product == USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_FINGERPRINT_2021 ||
 			 hid->product == USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_2021)
 			table = apple2021_fn_keys;
@@ -1150,6 +1151,10 @@ static const struct hid_device_id apple_devices[] = {
 		.driver_data = APPLE_HAS_FN | APPLE_ISO_TILDE_QUIRK | APPLE_RDESC_BATTERY },
 	{ HID_BLUETOOTH_DEVICE(BT_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2021),
 		.driver_data = APPLE_HAS_FN | APPLE_ISO_TILDE_QUIRK },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2024),
+		.driver_data = APPLE_HAS_FN | APPLE_ISO_TILDE_QUIRK | APPLE_RDESC_BATTERY },
+	{ HID_BLUETOOTH_DEVICE(BT_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2024),
+		.driver_data = APPLE_HAS_FN | APPLE_ISO_TILDE_QUIRK },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_FINGERPRINT_2021),
 		.driver_data = APPLE_HAS_FN | APPLE_ISO_TILDE_QUIRK | APPLE_RDESC_BATTERY },
 	{ HID_BLUETOOTH_DEVICE(BT_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_FINGERPRINT_2021),
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 1f47fda809..4f583d6f2e 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -184,6 +184,7 @@
 #define USB_DEVICE_ID_APPLE_IRCONTROL4	0x8242
 #define USB_DEVICE_ID_APPLE_IRCONTROL5	0x8243
 #define USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2021   0x029c
+#define USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2024   0x0320
 #define USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_FINGERPRINT_2021   0x029a
 #define USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_2021   0x029f
 #define USB_DEVICE_ID_APPLE_TOUCHBAR_BACKLIGHT 0x8102
-- 
2.48.1


