Return-Path: <linux-kernel+bounces-284038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7958B94FC41
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 05:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F4691C2239C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 03:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779DA1BC44;
	Tue, 13 Aug 2024 03:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2HNcqMf"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9291CFBE;
	Tue, 13 Aug 2024 03:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723519905; cv=none; b=tpNNFEBX6qsZ5pzvcSsXzlVuyUOeh/3wpcdLa0Nqp2/Kx4Lb2WG3GHzsDQ/Dx3zO5h9ufeeAeCMSgFpusODmsXOWp3hJWy7I5jRUq/3ngRTdgeWHpfKDl1JDmLSHEAVb6iK27zhY8Ni8LJbrh3nE33IPuPeRuWqzI77gU+Gbq8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723519905; c=relaxed/simple;
	bh=aKzZIN0iIRassxmT9CC6FvjRTeaUct6v2D98UzpTGuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GEtft60e/I5Rb+MS+QoMePnpqcad6OTXcP9NBFH+9G4Ej08gBu9ANDfwms68LCkS2tDPvpSo343E+JYu/1OIXulpZaub6NcdkdAHevyt9K1ww8t/7p/PzFEP5+8dblxAlj7DfFuAFJ3md+QwKLdoQe9DPN6XrQIskANrNXp/e74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L2HNcqMf; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-822eb80f6e4so1716696241.2;
        Mon, 12 Aug 2024 20:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723519901; x=1724124701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8iMGTj1Q5yafnUYTIS0rxZ2lNHqTiuecbtpPpvA/5a8=;
        b=L2HNcqMfodiODLEhteikjOlqRSFpaKstlEF9jcQxW0DI/XMQd7YxP6B5BxmoEIcsC5
         ESbYWuE6HeJTFptp0izNmNOVByKg2I2JCuRdulonDRtl9T/NuTIamdMdExNWMgp0Ca4v
         5Ks/AQ8FQXkt6ZL6TaHampC6LUPPmEU/j5EclmU6LbYIONydY6JuRzBYJEbcKYs7oiVj
         xIhAwC/uqOmwyk0oaZbo9z4eGMRf8L6qDGxRsYCQBUbzhGrk1nNrjNM+pQ9KvtOu7BoK
         ABkHFhaU8NOsHilPmjkFFpcdwm8/UV9E3WOxQGQ3qbpXdRQNDT9ihBqX/hMCy/IbGxON
         Z5vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723519901; x=1724124701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8iMGTj1Q5yafnUYTIS0rxZ2lNHqTiuecbtpPpvA/5a8=;
        b=ZPkPsLZh2EjjL7fLa4berjytbYXu01YEy7teqXU1h279Pzy0QhR3eVztojbdGXjV1l
         h6vDP4zhyQphNUhhpp/ZdoX1d2SSfbv0bfX33o0uaVmMC138O4pyl1WuQXttNyDZN1MY
         p18vB+e/AWiK21ySFsV4JPCELVEIYuAae8s+E5JIl6UqtN6No1ValX/HA3OxY9yW244w
         qn/4sfZgwMLEDFjHs7z7VzkwrARFRbhywk+8qEQN8u5guEZMe3qc3I4UBseqncyar+xK
         nVBn/JxjjNhji/+GarpUCcHkJE80QToix85bxYZMCBVR45IyTCKp7095B1nccQetAmYZ
         W2Og==
X-Forwarded-Encrypted: i=1; AJvYcCVFakvTdCkyLH+6mOZBW6gO8HtK+n4BFkoc1Ex7VlvEaIYonoGhV8VGzM3NfGbiC4Sg6pB+06CmwEZ43qz0b2c5cIKSbw84flivDfkv
X-Gm-Message-State: AOJu0YwNnMKhCCBBHPE8p2AkrLzpHJfE9NU8a0b1GxpBndL8LP9qVU6A
	TLZ8d8FiC/DIP/2KPImhl1CvJaqswbAtA/km3J8pRiu/2+i+dy8lbU2IyJu2
X-Google-Smtp-Source: AGHT+IFS4RkV8eZqedneJKWtFPHPwpDunHF3XS8Gj8ps6gQvsO5Nd9TeQLjp6CmXUm9orbQ4I7n3oA==
X-Received: by 2002:a05:6102:291e:b0:492:9e3a:9f48 with SMTP id ada2fe7eead31-4974392f219mr3001262137.2.1723519900152;
        Mon, 12 Aug 2024 20:31:40 -0700 (PDT)
Received: from fedora.. ([2800:e6:4001:fca7:b7e8:4418:a953:72f2])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-84136709160sm905492241.24.2024.08.12.20.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 20:31:39 -0700 (PDT)
From: =?UTF-8?q?Juan=20Jos=C3=A9=20Arboleda?= <soyjuanarbol@gmail.com>
To: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: perex@perex.cz,
	tiwai@suse.com,
	=?UTF-8?q?Juan=20Jos=C3=A9=20Arboleda?= <soyjuanarbol@gmail.com>
Subject: [PATCH 2/2] ALSA: usb-audio: reduce checkpatch issues in quirks-table.h
Date: Mon, 12 Aug 2024 22:31:28 -0500
Message-ID: <6dabfd5c05c04b0e4fc00a708cc65d691af4e267.1723518816.git.soyjuanarbol@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1723518816.git.soyjuanarbol@gmail.com>
References: <cover.1723518816.git.soyjuanarbol@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Reduced checkpatch errors from 185 to 2, and warnings from 4 to 1 in
sound/usb/quirks-table.h.

Remaining issues were reviewed and considered non-blocking.

Signed-off-by: Juan José Arboleda <soyjuanarbol@gmail.com>
---
 sound/usb/quirks-table.h | 382 ++++++++++++++++++++-------------------
 1 file changed, 193 insertions(+), 189 deletions(-)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 24e6f68e2f1e..ac3c1dd19204 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -38,7 +38,7 @@
 /* FTDI devices */
 {
 	USB_DEVICE(0x0403, 0xb8d8),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		/* .vendor_name = "STARR LABS", */
 		/* .product_name = "Starr Labs MIDI USB device", */
 		.ifnum = 0,
@@ -175,7 +175,7 @@
 
 #define YAMAHA_DEVICE(id, name) { \
 	USB_DEVICE(0x0499, id), \
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) { \
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) { \
 		.vendor_name = "Yamaha", \
 		.product_name = name, \
 		.ifnum = QUIRK_ANY_INTERFACE, \
@@ -184,7 +184,7 @@
 }
 #define YAMAHA_INTERFACE(id, intf, name) { \
 	USB_DEVICE_VENDOR_SPEC(0x0499, id), \
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) { \
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) { \
 		.vendor_name = "Yamaha", \
 		.product_name = name, \
 		.ifnum = intf, \
@@ -276,7 +276,7 @@ YAMAHA_DEVICE(0x105c, NULL),
 YAMAHA_DEVICE(0x105d, NULL),
 {
 	USB_DEVICE(0x0499, 0x1503),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		/* .vendor_name = "Yamaha", */
 		/* .product_name = "MOX6/MOX8", */
 		.ifnum = QUIRK_ANY_INTERFACE,
@@ -302,7 +302,7 @@ YAMAHA_DEVICE(0x105d, NULL),
 },
 {
 	USB_DEVICE(0x0499, 0x1507),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		/* .vendor_name = "Yamaha", */
 		/* .product_name = "THR10", */
 		.ifnum = QUIRK_ANY_INTERFACE,
@@ -328,7 +328,7 @@ YAMAHA_DEVICE(0x105d, NULL),
 },
 {
 	USB_DEVICE(0x0499, 0x1509),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		/* .vendor_name = "Yamaha", */
 		/* .product_name = "Steinberg UR22", */
 		.ifnum = QUIRK_ANY_INTERFACE,
@@ -358,7 +358,7 @@ YAMAHA_DEVICE(0x105d, NULL),
 },
 {
 	USB_DEVICE(0x0499, 0x150a),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		/* .vendor_name = "Yamaha", */
 		/* .product_name = "THR5A", */
 		.ifnum = QUIRK_ANY_INTERFACE,
@@ -384,7 +384,7 @@ YAMAHA_DEVICE(0x105d, NULL),
 },
 {
 	USB_DEVICE(0x0499, 0x150c),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		/* .vendor_name = "Yamaha", */
 		/* .product_name = "THR10C", */
 		.ifnum = QUIRK_ANY_INTERFACE,
@@ -449,7 +449,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
  */
 {
 	USB_DEVICE(0x0582, 0x0000),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "Roland",
 		.product_name = "UA-100",
 		.ifnum = QUIRK_ANY_INTERFACE,
@@ -458,7 +458,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			{
 				.ifnum = 0,
 				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = & (const struct audioformat) {
+				.data = &(const struct audioformat) {
 					.formats = SNDRV_PCM_FMTBIT_S16_LE,
 					.channels = 4,
 					.iface = 0,
@@ -475,7 +475,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			{
 				.ifnum = 1,
 				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = & (const struct audioformat) {
+				.data = &(const struct audioformat) {
 					.formats = SNDRV_PCM_FMTBIT_S16_LE,
 					.channels = 2,
 					.iface = 1,
@@ -492,7 +492,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			{
 				.ifnum = 2,
 				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
+				.data = &(const struct snd_usb_midi_endpoint_info) {
 					.out_cables = 0x0007,
 					.in_cables  = 0x0007
 				}
@@ -505,7 +505,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 {
 	USB_DEVICE(0x0582, 0x0002),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "EDIROL",
 		.product_name = "UM-4",
 		.ifnum = QUIRK_ANY_INTERFACE,
@@ -522,7 +522,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			{
 				.ifnum = 2,
 				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
+				.data = &(const struct snd_usb_midi_endpoint_info) {
 					.out_cables = 0x000f,
 					.in_cables  = 0x000f
 				}
@@ -535,7 +535,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 {
 	USB_DEVICE(0x0582, 0x0003),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "Roland",
 		.product_name = "SC-8850",
 		.ifnum = QUIRK_ANY_INTERFACE,
@@ -552,7 +552,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			{
 				.ifnum = 2,
 				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
+				.data = &(const struct snd_usb_midi_endpoint_info) {
 					.out_cables = 0x003f,
 					.in_cables  = 0x003f
 				}
@@ -565,7 +565,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 {
 	USB_DEVICE(0x0582, 0x0004),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "Roland",
 		.product_name = "U-8",
 		.ifnum = QUIRK_ANY_INTERFACE,
@@ -582,7 +582,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			{
 				.ifnum = 2,
 				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
+				.data = &(const struct snd_usb_midi_endpoint_info) {
 					.out_cables = 0x0005,
 					.in_cables  = 0x0005
 				}
@@ -594,10 +594,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	}
 },
 {
-	/* Has ID 0x0099 when not in "Advanced Driver" mode.
-	 * The UM-2EX has only one input, but we cannot detect this. */
+	/*
+	 * Has ID 0x0099 when not in "Advanced Driver" mode.
+	 * The UM-2EX has only one input, but we cannot detect this.
+	 */
 	USB_DEVICE(0x0582, 0x0005),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "EDIROL",
 		.product_name = "UM-2",
 		.ifnum = QUIRK_ANY_INTERFACE,
@@ -614,7 +616,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			{
 				.ifnum = 2,
 				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
+				.data = &(const struct snd_usb_midi_endpoint_info) {
 					.out_cables = 0x0003,
 					.in_cables  = 0x0003
 				}
@@ -627,7 +629,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 {
 	USB_DEVICE(0x0582, 0x0007),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "Roland",
 		.product_name = "SC-8820",
 		.ifnum = QUIRK_ANY_INTERFACE,
@@ -644,7 +646,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			{
 				.ifnum = 2,
 				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
+				.data = &(const struct snd_usb_midi_endpoint_info) {
 					.out_cables = 0x0013,
 					.in_cables  = 0x0013
 				}
@@ -657,7 +659,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 {
 	USB_DEVICE(0x0582, 0x0008),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "Roland",
 		.product_name = "PC-300",
 		.ifnum = QUIRK_ANY_INTERFACE,
@@ -674,7 +676,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			{
 				.ifnum = 2,
 				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
+				.data = &(const struct snd_usb_midi_endpoint_info) {
 					.out_cables = 0x0001,
 					.in_cables  = 0x0001
 				}
@@ -688,7 +690,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* has ID 0x009d when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x0009),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "EDIROL",
 		.product_name = "UM-1",
 		.ifnum = QUIRK_ANY_INTERFACE,
@@ -705,7 +707,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			{
 				.ifnum = 2,
 				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
+				.data = &(const struct snd_usb_midi_endpoint_info) {
 					.out_cables = 0x0001,
 					.in_cables  = 0x0001
 				}
@@ -718,7 +720,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 {
 	USB_DEVICE(0x0582, 0x000b),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "Roland",
 		.product_name = "SK-500",
 		.ifnum = QUIRK_ANY_INTERFACE,
@@ -735,7 +737,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			{
 				.ifnum = 2,
 				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
+				.data = &(const struct snd_usb_midi_endpoint_info) {
 					.out_cables = 0x0013,
 					.in_cables  = 0x0013
 				}
@@ -747,10 +749,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	}
 },
 {
-	/* thanks to Emiliano Grilli <emillo@libero.it>
-	 * for helping researching this data */
+	/*
+	 * thanks to Emiliano Grilli <emillo@libero.it>
+	 * for helping researching this data
+	 */
 	USB_DEVICE(0x0582, 0x000c),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "Roland",
 		.product_name = "SC-D70",
 		.ifnum = QUIRK_ANY_INTERFACE,
@@ -767,7 +771,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			{
 				.ifnum = 2,
 				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
+				.data = &(const struct snd_usb_midi_endpoint_info) {
 					.out_cables = 0x0007,
 					.in_cables  = 0x0007
 				}
@@ -788,7 +792,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * the 96kHz sample rate.
 	 */
 	USB_DEVICE(0x0582, 0x0010),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "EDIROL",
 		.product_name = "UA-5",
 		.ifnum = QUIRK_ANY_INTERFACE,
@@ -811,12 +815,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* has ID 0x0013 when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x0012),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "Roland",
 		.product_name = "XV-5050",
 		.ifnum = 0,
 		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		.data = &(const struct snd_usb_midi_endpoint_info) {
 			.out_cables = 0x0001,
 			.in_cables  = 0x0001
 		}
@@ -825,12 +829,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* has ID 0x0015 when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x0014),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "EDIROL",
 		.product_name = "UM-880",
 		.ifnum = 0,
 		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		.data = &(const struct snd_usb_midi_endpoint_info) {
 			.out_cables = 0x01ff,
 			.in_cables  = 0x01ff
 		}
@@ -839,7 +843,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* has ID 0x0017 when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x0016),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "EDIROL",
 		.product_name = "SD-90",
 		.ifnum = QUIRK_ANY_INTERFACE,
@@ -856,7 +860,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			{
 				.ifnum = 2,
 				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
+				.data = &(const struct snd_usb_midi_endpoint_info) {
 					.out_cables = 0x000f,
 					.in_cables  = 0x000f
 				}
@@ -870,7 +874,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* has ID 0x001c when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x001b),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "Roland",
 		.product_name = "MMP-2",
 		.ifnum = QUIRK_ANY_INTERFACE,
@@ -887,7 +891,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			{
 				.ifnum = 2,
 				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
+				.data = &(const struct snd_usb_midi_endpoint_info) {
 					.out_cables = 0x0001,
 					.in_cables  = 0x0001
 				}
@@ -901,12 +905,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* has ID 0x001e when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x001d),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "Roland",
 		.product_name = "V-SYNTH",
 		.ifnum = 0,
 		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		.data = &(const struct snd_usb_midi_endpoint_info) {
 			.out_cables = 0x0001,
 			.in_cables  = 0x0001
 		}
@@ -915,12 +919,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* has ID 0x0024 when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x0023),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "EDIROL",
 		.product_name = "UM-550",
 		.ifnum = 0,
 		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		.data = &(const struct snd_usb_midi_endpoint_info) {
 			.out_cables = 0x003f,
 			.in_cables  = 0x003f
 		}
@@ -933,7 +937,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * and no MIDI.
 	 */
 	USB_DEVICE(0x0582, 0x0025),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "EDIROL",
 		.product_name = "UA-20",
 		.ifnum = QUIRK_ANY_INTERFACE,
@@ -946,7 +950,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			{
 				.ifnum = 1,
 				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = & (const struct audioformat) {
+				.data = &(const struct audioformat) {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 2,
 					.iface = 1,
@@ -963,7 +967,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			{
 				.ifnum = 2,
 				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = & (const struct audioformat) {
+				.data = &(const struct audioformat) {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 2,
 					.iface = 2,
@@ -980,7 +984,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			{
 				.ifnum = 3,
 				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
+				.data = &(const struct snd_usb_midi_endpoint_info) {
 					.out_cables = 0x0001,
 					.in_cables  = 0x0001
 				}
@@ -994,12 +998,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* has ID 0x0028 when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x0027),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "EDIROL",
 		.product_name = "SD-20",
 		.ifnum = 0,
 		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		.data = &(const struct snd_usb_midi_endpoint_info) {
 			.out_cables = 0x0003,
 			.in_cables  = 0x0007
 		}
@@ -1008,12 +1012,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* has ID 0x002a when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x0029),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "EDIROL",
 		.product_name = "SD-80",
 		.ifnum = 0,
 		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		.data = &(const struct snd_usb_midi_endpoint_info) {
 			.out_cables = 0x000f,
 			.in_cables  = 0x000f
 		}
@@ -1026,7 +1030,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * but offers only 16-bit PCM and no MIDI.
 	 */
 	USB_DEVICE_VENDOR_SPEC(0x0582, 0x002b),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "EDIROL",
 		.product_name = "UA-700",
 		.ifnum = QUIRK_ANY_INTERFACE,
@@ -1053,12 +1057,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* has ID 0x002e when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x002d),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "Roland",
 		.product_name = "XV-2020",
 		.ifnum = 0,
 		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		.data = &(const struct snd_usb_midi_endpoint_info) {
 			.out_cables = 0x0001,
 			.in_cables  = 0x0001
 		}
@@ -1067,12 +1071,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* has ID 0x0030 when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x002f),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "Roland",
 		.product_name = "VariOS",
 		.ifnum = 0,
 		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		.data = &(const struct snd_usb_midi_endpoint_info) {
 			.out_cables = 0x0007,
 			.in_cables  = 0x0007
 		}
@@ -1081,12 +1085,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* has ID 0x0034 when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x0033),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "EDIROL",
 		.product_name = "PCR",
 		.ifnum = 0,
 		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		.data = &(const struct snd_usb_midi_endpoint_info) {
 			.out_cables = 0x0003,
 			.in_cables  = 0x0007
 		}
@@ -1098,12 +1102,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * later revisions use IDs 0x0054 and 0x00a2.
 	 */
 	USB_DEVICE(0x0582, 0x0037),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "Roland",
 		.product_name = "Digital Piano",
 		.ifnum = 0,
 		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		.data = &(const struct snd_usb_midi_endpoint_info) {
 			.out_cables = 0x0001,
 			.in_cables  = 0x0001
 		}
@@ -1116,12 +1120,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * and no MIDI.
 	 */
 	USB_DEVICE_VENDOR_SPEC(0x0582, 0x003b),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "BOSS",
 		.product_name = "GS-10",
 		.ifnum = QUIRK_ANY_INTERFACE,
 		.type = QUIRK_COMPOSITE,
-		.data = & (const struct snd_usb_audio_quirk[]) {
+		.data = &(const struct snd_usb_audio_quirk[]) {
 			{
 				.ifnum = 1,
 				.type = QUIRK_AUDIO_STANDARD_INTERFACE
@@ -1143,12 +1147,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* has ID 0x0041 when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x0040),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "Roland",
 		.product_name = "GI-20",
 		.ifnum = 0,
 		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		.data = &(const struct snd_usb_midi_endpoint_info) {
 			.out_cables = 0x0001,
 			.in_cables  = 0x0001
 		}
@@ -1157,12 +1161,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* has ID 0x0043 when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x0042),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "Roland",
 		.product_name = "RS-70",
 		.ifnum = 0,
 		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		.data = &(const struct snd_usb_midi_endpoint_info) {
 			.out_cables = 0x0001,
 			.in_cables  = 0x0001
 		}
@@ -1171,7 +1175,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* has ID 0x0049 when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x0047),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		/* .vendor_name = "EDIROL", */
 		/* .product_name = "UR-80", */
 		.ifnum = QUIRK_ANY_INTERFACE,
@@ -1195,12 +1199,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* has ID 0x004a when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x0048),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		/* .vendor_name = "EDIROL", */
 		/* .product_name = "UR-80", */
 		.ifnum = 0,
 		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		.data = &(const struct snd_usb_midi_endpoint_info) {
 			.out_cables = 0x0003,
 			.in_cables  = 0x0007
 		}
@@ -1209,7 +1213,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* has ID 0x004e when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x004c),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "EDIROL",
 		.product_name = "PCR-A",
 		.ifnum = QUIRK_ANY_INTERFACE,
@@ -1232,12 +1236,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* has ID 0x004f when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x004d),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "EDIROL",
 		.product_name = "PCR-A",
 		.ifnum = 0,
 		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		.data = &(const struct snd_usb_midi_endpoint_info) {
 			.out_cables = 0x0003,
 			.in_cables  = 0x0007
 		}
@@ -1249,7 +1253,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * is standard compliant, but has only 16-bit PCM.
 	 */
 	USB_DEVICE(0x0582, 0x0050),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "EDIROL",
 		.product_name = "UA-3FX",
 		.ifnum = QUIRK_ANY_INTERFACE,
@@ -1271,7 +1275,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 {
 	USB_DEVICE(0x0582, 0x0052),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "EDIROL",
 		.product_name = "UM-1SX",
 		.ifnum = 0,
@@ -1280,7 +1284,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 {
 	USB_DEVICE(0x0582, 0x0060),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "Roland",
 		.product_name = "EXR Series",
 		.ifnum = 0,
@@ -1290,7 +1294,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* has ID 0x0066 when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x0064),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		/* .vendor_name = "EDIROL", */
 		/* .product_name = "PCR-1", */
 		.ifnum = QUIRK_ANY_INTERFACE,
@@ -1313,12 +1317,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* has ID 0x0067 when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x0065),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		/* .vendor_name = "EDIROL", */
 		/* .product_name = "PCR-1", */
 		.ifnum = 0,
 		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		.data = &(const struct snd_usb_midi_endpoint_info) {
 			.out_cables = 0x0001,
 			.in_cables  = 0x0003
 		}
@@ -1327,12 +1331,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* has ID 0x006e when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x006d),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "Roland",
 		.product_name = "FANTOM-X",
 		.ifnum = 0,
 		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		.data = &(const struct snd_usb_midi_endpoint_info) {
 			.out_cables = 0x0001,
 			.in_cables  = 0x0001
 		}
@@ -1345,7 +1349,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * offers only 16-bit PCM at 44.1 kHz and no MIDI.
 	 */
 	USB_DEVICE_VENDOR_SPEC(0x0582, 0x0074),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "EDIROL",
 		.product_name = "UA-25",
 		.ifnum = QUIRK_ANY_INTERFACE,
@@ -1372,12 +1376,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* has ID 0x0076 when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x0075),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "BOSS",
 		.product_name = "DR-880",
 		.ifnum = 0,
 		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		.data = &(const struct snd_usb_midi_endpoint_info) {
 			.out_cables = 0x0001,
 			.in_cables  = 0x0001
 		}
@@ -1386,12 +1390,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* has ID 0x007b when not in "Advanced Driver" mode */
 	USB_DEVICE_VENDOR_SPEC(0x0582, 0x007a),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "Roland",
 		/* "RD" or "RD-700SX"? */
 		.ifnum = 0,
 		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		.data = &(const struct snd_usb_midi_endpoint_info) {
 			.out_cables = 0x0003,
 			.in_cables  = 0x0003
 		}
@@ -1400,12 +1404,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* has ID 0x0081 when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x0080),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "Roland",
 		.product_name = "G-70",
 		.ifnum = 0,
 		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		.data = &(const struct snd_usb_midi_endpoint_info) {
 			.out_cables = 0x0001,
 			.in_cables  = 0x0001
 		}
@@ -1414,12 +1418,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* has ID 0x008c when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x008b),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "EDIROL",
 		.product_name = "PC-50",
 		.ifnum = 0,
 		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		.data = &(const struct snd_usb_midi_endpoint_info) {
 			.out_cables = 0x0001,
 			.in_cables  = 0x0001
 		}
@@ -1431,7 +1435,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * is standard compliant, but has only 16-bit PCM and no MIDI.
 	 */
 	USB_DEVICE(0x0582, 0x00a3),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "EDIROL",
 		.product_name = "UA-4FX",
 		.ifnum = QUIRK_ANY_INTERFACE,
@@ -1458,7 +1462,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* Edirol M-16DX */
 	USB_DEVICE(0x0582, 0x00c4),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.ifnum = QUIRK_ANY_INTERFACE,
 		.type = QUIRK_COMPOSITE,
 		.data = (const struct snd_usb_audio_quirk[]) {
@@ -1473,7 +1477,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			{
 				.ifnum = 2,
 				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
+				.data = &(const struct snd_usb_midi_endpoint_info) {
 					.out_cables = 0x0001,
 					.in_cables  = 0x0001
 				}
@@ -1490,7 +1494,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * offers only 16-bit PCM at 44.1 kHz and no MIDI.
 	 */
 	USB_DEVICE_VENDOR_SPEC(0x0582, 0x00e6),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "EDIROL",
 		.product_name = "UA-25EX",
 		.ifnum = QUIRK_ANY_INTERFACE,
@@ -1517,10 +1521,10 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* Edirol UM-3G */
 	USB_DEVICE_VENDOR_SPEC(0x0582, 0x0108),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.ifnum = 0,
 		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		.data = &(const struct snd_usb_midi_endpoint_info) {
 			.out_cables = 0x0007,
 			.in_cables  = 0x0007
 		}
@@ -1529,7 +1533,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* BOSS ME-25 */
 	USB_DEVICE(0x0582, 0x0113),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.ifnum = QUIRK_ANY_INTERFACE,
 		.type = QUIRK_COMPOSITE,
 		.data = (const struct snd_usb_audio_quirk[]) {
@@ -1544,7 +1548,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			{
 				.ifnum = 2,
 				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
+				.data = &(const struct snd_usb_midi_endpoint_info) {
 					.out_cables = 0x0001,
 					.in_cables  = 0x0001
 				}
@@ -1558,7 +1562,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* only 44.1 kHz works at the moment */
 	USB_DEVICE(0x0582, 0x0120),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		/* .vendor_name = "Roland", */
 		/* .product_name = "OCTO-CAPTURE", */
 		.ifnum = QUIRK_ANY_INTERFACE,
@@ -1567,7 +1571,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			{
 				.ifnum = 0,
 				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = & (const struct audioformat) {
+				.data = &(const struct audioformat) {
 					.formats = SNDRV_PCM_FMTBIT_S32_LE,
 					.channels = 10,
 					.iface = 0,
@@ -1585,7 +1589,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			{
 				.ifnum = 1,
 				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = & (const struct audioformat) {
+				.data = &(const struct audioformat) {
 					.formats = SNDRV_PCM_FMTBIT_S32_LE,
 					.channels = 12,
 					.iface = 1,
@@ -1603,7 +1607,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			{
 				.ifnum = 2,
 				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
+				.data = &(const struct snd_usb_midi_endpoint_info) {
 					.out_cables = 0x0001,
 					.in_cables  = 0x0001
 				}
@@ -1625,7 +1629,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* only 44.1 kHz works at the moment */
 	USB_DEVICE(0x0582, 0x012f),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		/* .vendor_name = "Roland", */
 		/* .product_name = "QUAD-CAPTURE", */
 		.ifnum = QUIRK_ANY_INTERFACE,
@@ -1634,7 +1638,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			{
 				.ifnum = 0,
 				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = & (const struct audioformat) {
+				.data = &(const struct audioformat) {
 					.formats = SNDRV_PCM_FMTBIT_S32_LE,
 					.channels = 4,
 					.iface = 0,
@@ -1652,7 +1656,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			{
 				.ifnum = 1,
 				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = & (const struct audioformat) {
+				.data = &(const struct audioformat) {
 					.formats = SNDRV_PCM_FMTBIT_S32_LE,
 					.channels = 6,
 					.iface = 1,
@@ -1670,7 +1674,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			{
 				.ifnum = 2,
 				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
+				.data = &(const struct snd_usb_midi_endpoint_info) {
 					.out_cables = 0x0001,
 					.in_cables  = 0x0001
 				}
@@ -1691,7 +1695,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 {
 	USB_DEVICE(0x0582, 0x0159),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		/* .vendor_name = "Roland", */
 		/* .product_name = "UA-22", */
 		.ifnum = QUIRK_ANY_INTERFACE,
@@ -1708,7 +1712,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			{
 				.ifnum = 2,
 				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
+				.data = &(const struct snd_usb_midi_endpoint_info) {
 					.out_cables = 0x0001,
 					.in_cables = 0x0001
 				}
@@ -1723,19 +1727,19 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 /* UA101 and co are supported by another driver */
 {
 	USB_DEVICE(0x0582, 0x0044), /* UA-1000 high speed */
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.ifnum = QUIRK_NODEV_INTERFACE
 	},
 },
 {
 	USB_DEVICE(0x0582, 0x007d), /* UA-101 high speed */
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.ifnum = QUIRK_NODEV_INTERFACE
 	},
 },
 {
 	USB_DEVICE(0x0582, 0x008d), /* UA-101 full speed */
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.ifnum = QUIRK_NODEV_INTERFACE
 	},
 },
@@ -1761,12 +1765,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * compliant USB MIDI ports for external MIDI and controls.
 	 */
 	USB_DEVICE_VENDOR_SPEC(0x06f8, 0xb000),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "Hercules",
 		.product_name = "DJ Console (WE)",
 		.ifnum = 4,
 		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		.data = &(const struct snd_usb_midi_endpoint_info) {
 			.out_cables = 0x0001,
 			.in_cables = 0x0001
 		}
@@ -1776,12 +1780,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 /* Midiman/M-Audio devices */
 {
 	USB_DEVICE_VENDOR_SPEC(0x0763, 0x1002),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "M-Audio",
 		.product_name = "MidiSport 2x2",
 		.ifnum = QUIRK_ANY_INTERFACE,
 		.type = QUIRK_MIDI_MIDIMAN,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		.data = &(const struct snd_usb_midi_endpoint_info) {
 			.out_cables = 0x0003,
 			.in_cables  = 0x0003
 		}
@@ -1789,12 +1793,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 {
 	USB_DEVICE_VENDOR_SPEC(0x0763, 0x1011),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "M-Audio",
 		.product_name = "MidiSport 1x1",
 		.ifnum = QUIRK_ANY_INTERFACE,
 		.type = QUIRK_MIDI_MIDIMAN,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		.data = &(const struct snd_usb_midi_endpoint_info) {
 			.out_cables = 0x0001,
 			.in_cables  = 0x0001
 		}
@@ -1802,12 +1806,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 {
 	USB_DEVICE_VENDOR_SPEC(0x0763, 0x1015),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "M-Audio",
 		.product_name = "Keystation",
 		.ifnum = QUIRK_ANY_INTERFACE,
 		.type = QUIRK_MIDI_MIDIMAN,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		.data = &(const struct snd_usb_midi_endpoint_info) {
 			.out_cables = 0x0001,
 			.in_cables  = 0x0001
 		}
@@ -1815,12 +1819,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 {
 	USB_DEVICE_VENDOR_SPEC(0x0763, 0x1021),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "M-Audio",
 		.product_name = "MidiSport 4x4",
 		.ifnum = QUIRK_ANY_INTERFACE,
 		.type = QUIRK_MIDI_MIDIMAN,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		.data = &(const struct snd_usb_midi_endpoint_info) {
 			.out_cables = 0x000f,
 			.in_cables  = 0x000f
 		}
@@ -1833,12 +1837,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * Thanks to Olaf Giesbrecht <Olaf_Giesbrecht@yahoo.de>
 	 */
 	USB_DEVICE_VER(0x0763, 0x1031, 0x0100, 0x0109),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "M-Audio",
 		.product_name = "MidiSport 8x8",
 		.ifnum = QUIRK_ANY_INTERFACE,
 		.type = QUIRK_MIDI_MIDIMAN,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		.data = &(const struct snd_usb_midi_endpoint_info) {
 			.out_cables = 0x01ff,
 			.in_cables  = 0x01ff
 		}
@@ -1846,12 +1850,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 {
 	USB_DEVICE_VENDOR_SPEC(0x0763, 0x1033),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "M-Audio",
 		.product_name = "MidiSport 8x8",
 		.ifnum = QUIRK_ANY_INTERFACE,
 		.type = QUIRK_MIDI_MIDIMAN,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		.data = &(const struct snd_usb_midi_endpoint_info) {
 			.out_cables = 0x01ff,
 			.in_cables  = 0x01ff
 		}
@@ -1859,12 +1863,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 {
 	USB_DEVICE_VENDOR_SPEC(0x0763, 0x1041),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "M-Audio",
 		.product_name = "MidiSport 2x4",
 		.ifnum = QUIRK_ANY_INTERFACE,
 		.type = QUIRK_MIDI_MIDIMAN,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		.data = &(const struct snd_usb_midi_endpoint_info) {
 			.out_cables = 0x000f,
 			.in_cables  = 0x0003
 		}
@@ -1872,12 +1876,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 {
 	USB_DEVICE_VENDOR_SPEC(0x0763, 0x2001),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "M-Audio",
 		.product_name = "Quattro",
 		.ifnum = QUIRK_ANY_INTERFACE,
 		.type = QUIRK_COMPOSITE,
-		.data = & (const struct snd_usb_audio_quirk[]) {
+		.data = &(const struct snd_usb_audio_quirk[]) {
 			/*
 			 * Interfaces 0-2 are "Windows-compatible", 16-bit only,
 			 * and share endpoints with the other interfaces.
@@ -1923,7 +1927,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			{
 				.ifnum = 9,
 				.type = QUIRK_MIDI_MIDIMAN,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
+				.data = &(const struct snd_usb_midi_endpoint_info) {
 					.out_cables = 0x0001,
 					.in_cables  = 0x0001
 				}
@@ -1936,12 +1940,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 {
 	USB_DEVICE_VENDOR_SPEC(0x0763, 0x2003),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "M-Audio",
 		.product_name = "AudioPhile",
 		.ifnum = 6,
 		.type = QUIRK_MIDI_MIDIMAN,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		.data = &(const struct snd_usb_midi_endpoint_info) {
 			.out_cables = 0x0001,
 			.in_cables  = 0x0001
 		}
@@ -1949,12 +1953,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 {
 	USB_DEVICE_VENDOR_SPEC(0x0763, 0x2008),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "M-Audio",
 		.product_name = "Ozone",
 		.ifnum = 3,
 		.type = QUIRK_MIDI_MIDIMAN,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		.data = &(const struct snd_usb_midi_endpoint_info) {
 			.out_cables = 0x0001,
 			.in_cables  = 0x0001
 		}
@@ -1962,12 +1966,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 {
 	USB_DEVICE_VENDOR_SPEC(0x0763, 0x200d),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "M-Audio",
 		.product_name = "OmniStudio",
 		.ifnum = QUIRK_ANY_INTERFACE,
 		.type = QUIRK_COMPOSITE,
-		.data = & (const struct snd_usb_audio_quirk[]) {
+		.data = &(const struct snd_usb_audio_quirk[]) {
 			{
 				.ifnum = 0,
 				.type = QUIRK_IGNORE_INTERFACE
@@ -2007,7 +2011,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			{
 				.ifnum = 9,
 				.type = QUIRK_MIDI_MIDIMAN,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
+				.data = &(const struct snd_usb_midi_endpoint_info) {
 					.out_cables = 0x0001,
 					.in_cables  = 0x0001
 				}
@@ -2020,12 +2024,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 {
 	USB_DEVICE(0x0763, 0x2019),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		/* .vendor_name = "M-Audio", */
 		/* .product_name = "Ozone Academic", */
 		.ifnum = QUIRK_ANY_INTERFACE,
 		.type = QUIRK_COMPOSITE,
-		.data = & (const struct snd_usb_audio_quirk[]) {
+		.data = &(const struct snd_usb_audio_quirk[]) {
 			{
 				.ifnum = 0,
 				.type = QUIRK_AUDIO_STANDARD_INTERFACE
@@ -2041,7 +2045,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			{
 				.ifnum = 3,
 				.type = QUIRK_MIDI_MIDIMAN,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
+				.data = &(const struct snd_usb_midi_endpoint_info) {
 					.out_cables = 0x0001,
 					.in_cables  = 0x0001
 				}
@@ -2200,12 +2204,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 {
 	USB_DEVICE_VENDOR_SPEC(0x0763, 0x2080),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		/* .vendor_name = "M-Audio", */
 		/* .product_name = "Fast Track Ultra", */
 		.ifnum = QUIRK_ANY_INTERFACE,
 		.type = QUIRK_COMPOSITE,
-		.data = & (const struct snd_usb_audio_quirk[]) {
+		.data = &(const struct snd_usb_audio_quirk[]) {
 			{
 				.ifnum = 0,
 				.type = QUIRK_AUDIO_STANDARD_MIXER,
@@ -2213,7 +2217,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			{
 				.ifnum = 1,
 				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = & (const struct audioformat) {
+				.data = &(const struct audioformat) {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 8,
 					.iface = 1,
@@ -2237,7 +2241,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			{
 				.ifnum = 2,
 				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = & (const struct audioformat) {
+				.data = &(const struct audioformat) {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 8,
 					.iface = 2,
@@ -2267,12 +2271,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 {
 	USB_DEVICE_VENDOR_SPEC(0x0763, 0x2081),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		/* .vendor_name = "M-Audio", */
 		/* .product_name = "Fast Track Ultra 8R", */
 		.ifnum = QUIRK_ANY_INTERFACE,
 		.type = QUIRK_COMPOSITE,
-		.data = & (const struct snd_usb_audio_quirk[]) {
+		.data = &(const struct snd_usb_audio_quirk[]) {
 			{
 				.ifnum = 0,
 				.type = QUIRK_AUDIO_STANDARD_MIXER,
@@ -2280,7 +2284,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			{
 				.ifnum = 1,
 				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = & (const struct audioformat) {
+				.data = &(const struct audioformat) {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 8,
 					.iface = 1,
@@ -2304,7 +2308,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			{
 				.ifnum = 2,
 				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = & (const struct audioformat) {
+				.data = &(const struct audioformat) {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 8,
 					.iface = 2,
@@ -2336,7 +2340,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 /* Casio devices */
 {
 	USB_DEVICE(0x07cf, 0x6801),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "Casio",
 		.product_name = "PL-40R",
 		.ifnum = 0,
@@ -2346,7 +2350,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* this ID is used by several devices without a product ID */
 	USB_DEVICE(0x07cf, 0x6802),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "Casio",
 		.product_name = "Keyboard",
 		.ifnum = 0,
@@ -2363,12 +2367,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	.idVendor = 0x07fd,
 	.idProduct = 0x0001,
 	.bDeviceSubClass = 2,
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "MOTU",
 		.product_name = "Fastlane",
 		.ifnum = QUIRK_ANY_INTERFACE,
 		.type = QUIRK_COMPOSITE,
-		.data = & (const struct snd_usb_audio_quirk[]) {
+		.data = &(const struct snd_usb_audio_quirk[]) {
 			{
 				.ifnum = 0,
 				.type = QUIRK_MIDI_RAW_BYTES
@@ -2387,12 +2391,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 /* Emagic devices */
 {
 	USB_DEVICE(0x086a, 0x0001),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "Emagic",
 		.product_name = "Unitor8",
 		.ifnum = 2,
 		.type = QUIRK_MIDI_EMAGIC,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		.data = &(const struct snd_usb_midi_endpoint_info) {
 			.out_cables = 0x80ff,
 			.in_cables  = 0x80ff
 		}
@@ -2400,12 +2404,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 {
 	USB_DEVICE(0x086a, 0x0002),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "Emagic",
 		/* .product_name = "AMT8", */
 		.ifnum = 2,
 		.type = QUIRK_MIDI_EMAGIC,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		.data = &(const struct snd_usb_midi_endpoint_info) {
 			.out_cables = 0x80ff,
 			.in_cables  = 0x80ff
 		}
@@ -2413,12 +2417,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 {
 	USB_DEVICE(0x086a, 0x0003),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "Emagic",
 		/* .product_name = "MT4", */
 		.ifnum = 2,
 		.type = QUIRK_MIDI_EMAGIC,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		.data = &(const struct snd_usb_midi_endpoint_info) {
 			.out_cables = 0x800f,
 			.in_cables  = 0x8003
 		}
@@ -2428,7 +2432,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 /* KORG devices */
 {
 	USB_DEVICE_VENDOR_SPEC(0x0944, 0x0200),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "KORG, Inc.",
 		/* .product_name = "PANDORA PX5D", */
 		.ifnum = 3,
@@ -2438,7 +2442,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 
 {
 	USB_DEVICE_VENDOR_SPEC(0x0944, 0x0201),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "KORG, Inc.",
 		/* .product_name = "ToneLab ST", */
 		.ifnum = 3,
@@ -2448,7 +2452,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 
 {
 	USB_DEVICE_VENDOR_SPEC(0x0944, 0x0204),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "KORG, Inc.",
 		/* .product_name = "ToneLab EX", */
 		.ifnum = 3,
@@ -2459,7 +2463,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 /* AKAI devices */
 {
 	USB_DEVICE(0x09e8, 0x0062),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "AKAI",
 		.product_name = "MPD16",
 		.ifnum = 0,
@@ -2470,10 +2474,10 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* Akai MPC Element */
 	USB_DEVICE(0x09e8, 0x0021),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.ifnum = QUIRK_ANY_INTERFACE,
 		.type = QUIRK_COMPOSITE,
-		.data = & (const struct snd_usb_audio_quirk[]) {
+		.data = &(const struct snd_usb_audio_quirk[]) {
 			{
 				.ifnum = 0,
 				.type = QUIRK_IGNORE_INTERFACE
@@ -2493,10 +2497,10 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* Steinberg MI2 */
 	USB_DEVICE_VENDOR_SPEC(0x0a4e, 0x2040),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.ifnum = QUIRK_ANY_INTERFACE,
 		.type = QUIRK_COMPOSITE,
-		.data = & (const struct snd_usb_audio_quirk[]) {
+		.data = &(const struct snd_usb_audio_quirk[]) {
 			{
 				.ifnum = 0,
 				.type = QUIRK_AUDIO_STANDARD_INTERFACE
@@ -2526,10 +2530,10 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* Steinberg MI4 */
 	USB_DEVICE_VENDOR_SPEC(0x0a4e, 0x4040),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.ifnum = QUIRK_ANY_INTERFACE,
 		.type = QUIRK_COMPOSITE,
-		.data = & (const struct snd_usb_audio_quirk[]) {
+		.data = &(const struct snd_usb_audio_quirk[]) {
 			{
 				.ifnum = 0,
 				.type = QUIRK_AUDIO_STANDARD_INTERFACE
@@ -2560,7 +2564,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 /* TerraTec devices */
 {
 	USB_DEVICE_VENDOR_SPEC(0x0ccd, 0x0012),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "TerraTec",
 		.product_name = "PHASE 26",
 		.ifnum = 3,
@@ -2569,7 +2573,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 {
 	USB_DEVICE_VENDOR_SPEC(0x0ccd, 0x0013),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "TerraTec",
 		.product_name = "PHASE 26",
 		.ifnum = 3,
@@ -2578,7 +2582,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 {
 	USB_DEVICE_VENDOR_SPEC(0x0ccd, 0x0014),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "TerraTec",
 		.product_name = "PHASE 26",
 		.ifnum = 3,
@@ -2587,7 +2591,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 {
 	USB_DEVICE(0x0ccd, 0x0035),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "Miditech",
 		.product_name = "Play'n Roll",
 		.ifnum = 0,
@@ -2602,7 +2606,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 /* Novation EMS devices */
 {
 	USB_DEVICE_VENDOR_SPEC(0x1235, 0x0001),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "Novation",
 		.product_name = "ReMOTE Audio/XStation",
 		.ifnum = 4,
@@ -2611,7 +2615,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 {
 	USB_DEVICE_VENDOR_SPEC(0x1235, 0x0002),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "Novation",
 		.product_name = "Speedio",
 		.ifnum = 3,
@@ -2620,7 +2624,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 {
 	USB_DEVICE(0x1235, 0x000a),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		/* .vendor_name = "Novation", */
 		/* .product_name = "Nocturn", */
 		.ifnum = 0,
@@ -2629,7 +2633,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 {
 	USB_DEVICE(0x1235, 0x000e),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		/* .vendor_name = "Novation", */
 		/* .product_name = "Launchpad", */
 		.ifnum = 0,
@@ -2714,7 +2718,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 {
 	USB_DEVICE(0x1235, 0x0018),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "Novation",
 		.product_name = "Twitch",
 		.ifnum = QUIRK_ANY_INTERFACE,
@@ -2723,7 +2727,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			{
 				.ifnum = 0,
 				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = & (const struct audioformat) {
+				.data = &(const struct audioformat) {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 4,
 					.iface = 0,
@@ -2754,7 +2758,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 {
 	USB_DEVICE_VENDOR_SPEC(0x1235, 0x4661),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "Novation",
 		.product_name = "ReMOTE25",
 		.ifnum = 0,
@@ -2826,7 +2830,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 /* Miditech devices */
 {
 	USB_DEVICE(0x4752, 0x0011),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "Miditech",
 		.product_name = "Midistart-2",
 		.ifnum = 0,
@@ -2838,7 +2842,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* this ID used by both Miditech MidiStudio-2 and CME UF-x */
 	USB_DEVICE(0x7104, 0x2202),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.ifnum = 0,
 		.type = QUIRK_MIDI_CME
 	}
@@ -3298,7 +3302,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * enabled in create_standard_audio_quirk().
 	 */
 	USB_DEVICE(0x1686, 0x00dd),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.ifnum = QUIRK_ANY_INTERFACE,
 		.type = QUIRK_COMPOSITE,
 		.data = (const struct snd_usb_audio_quirk[]) {
@@ -3333,7 +3337,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 		       USB_DEVICE_ID_MATCH_INT_SUBCLASS,
 	.bInterfaceClass = USB_CLASS_AUDIO,
 	.bInterfaceSubClass = USB_SUBCLASS_MIDISTREAMING,
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.ifnum = QUIRK_ANY_INTERFACE,
 		.type = QUIRK_MIDI_STANDARD_INTERFACE
 	}
@@ -3342,10 +3346,10 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 /* Rane SL-1 */
 {
 	USB_DEVICE(0x13e5, 0x0001),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.ifnum = QUIRK_ANY_INTERFACE,
 		.type = QUIRK_AUDIO_STANDARD_INTERFACE
-        }
+	}
 },
 
 /* disabled due to regression for other devices;
@@ -3406,7 +3410,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 
 {
 	/*
-	 * Bower's & Wilkins PX headphones only support the 48 kHz sample rate
+	 * Bower's &Wilkins PX headphones only support the 48 kHz sample rate
 	 * even though it advertises more. The capture interface doesn't work
 	 * even on windows.
 	 */
-- 
2.46.0


