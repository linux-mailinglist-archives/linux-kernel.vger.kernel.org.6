Return-Path: <linux-kernel+bounces-548301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E0AA54320
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 07:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 003DC188EE94
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 06:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF9A1A727D;
	Thu,  6 Mar 2025 06:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=g-sokol-info.20230601.gappssmtp.com header.i=@g-sokol-info.20230601.gappssmtp.com header.b="V/B60e5W"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1C81A2C25
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 06:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741244189; cv=none; b=W5VfZ3rYRWtc+g3HGoUQb4U/B35Eegb1CqYTVTKmOHfHiTSxlp5Scg1BOVdUA9DrJSu8ely3hQDOUC9yuZV1FXlA+dM7ErqVeKhg79Ldv/Z9cHVnq79HNxBjxAzbHaDtcSC7l4vgaGV1VTy0bcUzDqZ+ihaLEf913Eqp7My2qHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741244189; c=relaxed/simple;
	bh=R8mD42C8JSzeDOw/OyH96NT7Zu4tAstbJIMNxeeoAvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HJcMgJjUc0DSMzpqASgB3d74BOObx4ZSzr3dgnHoQLL5ncBkhaHLWl4iA/48wSfGTY+Zxq0RR1MhAqamoA0oDsT03rifJG7dHuYzeLl20IkH+JryHYi6uofgM5hPrKye+2KP2Ie865jWAmMHiYqurWBbKjeRVOzdNpDHhjqQqb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=g-sokol.info; spf=none smtp.mailfrom=g-sokol.info; dkim=pass (2048-bit key) header.d=g-sokol-info.20230601.gappssmtp.com header.i=@g-sokol-info.20230601.gappssmtp.com header.b=V/B60e5W; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=g-sokol.info
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=g-sokol.info
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-54964606482so359564e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 22:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g-sokol-info.20230601.gappssmtp.com; s=20230601; t=1741244186; x=1741848986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19askMh4Gm0YmwCpt25BNi0LwkLNtJtl5vhunDMvF40=;
        b=V/B60e5W1bAx3Zsncnyt8QW1XB11gcmdmWpuX/vrJCjdjKf2qI1B9k5pxdPKwzdDIL
         r0G3dh0byWrv/Smj00xJFy7HrFyo87zzjFN8Zb1vwZ1dsgNdBNr729s4nCcaD+ru3NmJ
         08Rh5SIjQSbf5l35J8K4aqsG4ssNNVuNxJiLFSSpjVfoLQWgkbNcxQDUYUPKizeMb4QG
         3tos6e+oAViHfMuIcS8GkQG9V1w/iZ5irUikGuKH1AV4DcNOX0yIdAyvWunV8gTxyNk5
         aZaEBnzwy0VL7Sq6/SCS7bA5JvVuLtZZ2q1P7QdHDcmzq6IQemOTrTt6ZOneRvSnpRvM
         Y6Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741244186; x=1741848986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=19askMh4Gm0YmwCpt25BNi0LwkLNtJtl5vhunDMvF40=;
        b=tAudjl9tUSlpUTATr2SyAAFaF4qqpv5QQsvVoD1Y0orfXat4+svb2CvqRL18fw6a8I
         CSEamThLGqyokpk5YidYHZ0XEHg+Fq+IBVMZUu0OeCdpljKRduNnRNAd3EwdMgcejLgS
         G/p9ujiZqLumjQyEwNkaqbv+y/sk/N1uAvriaSPcZ77T/8VtuHYsvfe0NEdgYT4IjtV2
         RqcPlknWcOE/WFfJAIV3Y97pPtmFyJXn2OuzYnwMecOOqjxt3eeNPXNyN/cDekofPfpg
         JGt3J5D5R3TEEHDTRMxE2J6DI3/rz2ymhowZEwfBm+r+yzlQhjwHgAhU3+mBiiApRBPU
         h6hQ==
X-Gm-Message-State: AOJu0Yzx3LHeiCT3wzoZNiq0zACGh12mpn5TKpWDzdk/v53nuEDntZ9h
	CQx2S8VNlRCyu8ea/cN/bkmqzEarO9Y6QLLOCZjfV15WT5jcF6eWaX3C+Jpla6M=
X-Gm-Gg: ASbGncskl076zD4SwLV1xcAZk3aNOQAN0VF2HzWi++tvI76cFeHy2tJwW9MzWDzxlFH
	PEgPDQTmPF3cBV2GzdXZhyksC/J0vNNWMCdqeif/rHMtveWI4zeM/Fi/4UvdhinVkPOlkfB67vT
	H/mMQvNfV9LaD0VNnGrbz7DmvXDStbxOKlqJA8NCe1YU7Bopl90CWDW9eEzsUp3vAL1a6fY88rT
	wxPv+aHLuamgfesJh5bM5SjHVDHi2Em996pMwDpc9E2EvAGz9WbSS9vPvwMjq8Zqfdz2i8GXB7W
	aSBy0Jsnp3wJcIqXlpQSApyUfm/XBvYasaeEmsTQ1PQ7oPV4Cn9Ll+9Nf8NtChZkZ+OAAI1ssHN
	Ez5pVcKaT+XH/BCM=
X-Google-Smtp-Source: AGHT+IEhsVNR3gSbh61Y1tznp41FObkjySBY+/3RpLVfhfSe2tySyMT9ruiLPFVJ6YBni9BkickxLQ==
X-Received: by 2002:a05:6512:114b:b0:549:70ea:27a1 with SMTP id 2adb3069b0e04-5497d3531demr2193555e87.23.1741244185749;
        Wed, 05 Mar 2025 22:56:25 -0800 (PST)
Received: from localhost.localdomain (185-11-210-173.s1networks.fi. [185.11.210.173])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498ae59398sm85905e87.92.2025.03.05.22.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 22:56:25 -0800 (PST)
From: Grigorii Sokolik <g.sokol99@g-sokol.info>
To: jikos@kernel.org,
	jkosina@suse.com,
	jkosina@suse.cz,
	benjamin.tissoires@redhat.com,
	bentiss@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-input@vger.gernel.org,
	Grigorii Sokolik <g.sokol99@g-sokol.info>
Subject: [PATCH 2/2] HID: hid-apple: Apple Magic Keyboard a3118 USB-C support
Date: Thu,  6 Mar 2025 08:56:08 +0200
Message-ID: <20250306065608.531205-2-g.sokol99@g-sokol.info>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306065608.531205-1-g.sokol99@g-sokol.info>
References: <20250306065608.531205-1-g.sokol99@g-sokol.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Apple Magic Keyboard 2024 model (with USB-C port) device ID (0321)
to those recognized by the hid-apple driver. Keyboard is otherwise
compatible with the existing implementation for its earlier 2021 model.

Signed-off-by: Grigorii Sokolik <g.sokol99@g-sokol.info>
---
 drivers/hid/hid-apple.c | 5 +++++
 drivers/hid/hid-ids.h   | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 3c3f67d0bf..daf4c505e7 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -475,6 +475,7 @@ static int hidinput_apple_event(struct hid_device *hid, struct input_dev *input,
 			table = magic_keyboard_2015_fn_keys;
 		else if (hid->product == USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2021 ||
 			 hid->product == USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2024 ||
+			 hid->product == USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2024_V2 ||
 			 hid->product == USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_FINGERPRINT_2021 ||
 			 hid->product == USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_2021)
 			table = apple2021_fn_keys;
@@ -1155,6 +1156,10 @@ static const struct hid_device_id apple_devices[] = {
 		.driver_data = APPLE_HAS_FN | APPLE_ISO_TILDE_QUIRK | APPLE_RDESC_BATTERY },
 	{ HID_BLUETOOTH_DEVICE(BT_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2024),
 		.driver_data = APPLE_HAS_FN | APPLE_ISO_TILDE_QUIRK },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2024_V2),
+		.driver_data = APPLE_HAS_FN | APPLE_ISO_TILDE_QUIRK | APPLE_RDESC_BATTERY },
+	{ HID_BLUETOOTH_DEVICE(BT_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2024_V2),
+		.driver_data = APPLE_HAS_FN | APPLE_ISO_TILDE_QUIRK },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_FINGERPRINT_2021),
 		.driver_data = APPLE_HAS_FN | APPLE_ISO_TILDE_QUIRK | APPLE_RDESC_BATTERY },
 	{ HID_BLUETOOTH_DEVICE(BT_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_FINGERPRINT_2021),
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 4f583d6f2e..953850f043 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -185,6 +185,7 @@
 #define USB_DEVICE_ID_APPLE_IRCONTROL5	0x8243
 #define USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2021   0x029c
 #define USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2024   0x0320
+#define USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2024_V2   0x0320
 #define USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_FINGERPRINT_2021   0x029a
 #define USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_2021   0x029f
 #define USB_DEVICE_ID_APPLE_TOUCHBAR_BACKLIGHT 0x8102
-- 
2.48.1


