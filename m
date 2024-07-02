Return-Path: <linux-kernel+bounces-237944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A219240E5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 16:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 361FF1C22096
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 14:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8EB1B5837;
	Tue,  2 Jul 2024 14:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rh/fce74"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9821DFE1
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 14:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719930626; cv=none; b=ZZ67zepZYLqR8PyMTYrtjGguO8cCoMKma3R8dkp0YwjFxd+foPL8oPw/m8cDH6Iab4tx8+TandC70TZuQkO5L4bCLB+YGVQhOqWZ0ndzY2/sLrIDGfax4dwfu2Qd73uXvk48iHCw2Kukvu/oB6GpmJidx+eHWneBsyfX8hpvtKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719930626; c=relaxed/simple;
	bh=FhmBEv4n6GCtWVckiSV6OyglfPfjQhvssRH6Q+m+080=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ftxlxVjFSKH6zOcl8Ekmb2fxi/UDkfaXmVA5Mn1SlHy/o/vAiVSQECK46HwFao40ThxhPWz5+EtqkMV9CZiX+iPFoQ3W/mQlLPqB4CE0puw7mPxnsItJfAQjuGZpGv/WEvnl196eeeU1MRMTwPUgkOh+fWLV7OX1PJ43C8TIzTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rh/fce74; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719930623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9uqCNpuUurhHnKN6EfvlxVvWT4Bm5hlRiNW9ttyGiSk=;
	b=Rh/fce74kRsGNaZnjW5iBnzKKgQ9M05rBHMa4p5Rqln0ZSyTE9ZFCM4NFcTyPqIyn/qPbJ
	cTKXDruCDBAjIAX8PMIyMVEybS9KAVEPjBQio2ZcQVFTJP0hVVQ/L8IcIEIluLXUnxFsbP
	D+0LwdXYkVqimCMlCIXLYjB8rDRtSok=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-Ll-RoEFxNc-VfkoAYSymIA-1; Tue, 02 Jul 2024 10:30:21 -0400
X-MC-Unique: Ll-RoEFxNc-VfkoAYSymIA-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-52cdbeaafcdso3949657e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 07:30:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719930620; x=1720535420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9uqCNpuUurhHnKN6EfvlxVvWT4Bm5hlRiNW9ttyGiSk=;
        b=EAQBnWFzL+C525ZgfeViOW+pVrV93PI8OLo3aSXcP6Xrr0n2cz81dSFQxQe88z5FIB
         Q1rj9OwwZt7TSprzdF0asQQ7cFN0QC+dHvGljV0nxB/R4nfB+UGaLW6d7T2eI8Lji30f
         FK3SYY9intZb79EU//Gwni1YtLnFjL2McDWTR6vF13Z8oBZddxjtb0XT42/KCvXdf6kt
         rLAftRvV1bXHFzd2B4sUmiY3ulWRrHKtGbRpZqiU2RG2i08Fy7y8FY4TKb/WeA5eK+yf
         LmtmvSCJwYb+wRaMpLhEucXC9gy/C/q7rcJJyESEyLHXjZyRy/1cxPtJKSLI++UeFnuC
         nsEA==
X-Forwarded-Encrypted: i=1; AJvYcCXb/blRoxIGlvXbE0TYWhsRkMwX9NDdNvk2tVq3aiuik2AG79/2aFoQH5+Q0xh01VJ4yWs+BlAF2jXWnr9JYdLDwBL+mxE86kvKYoho
X-Gm-Message-State: AOJu0Yx6FsBTJrDjVwyO9lALU4UGNStMKp3etrUPY8di5qprJSagTtfk
	GYU/ocDuAbQwb6D01c4HcZ1mogdL5TEXolZHBMXzzUG+hMmaanNXC2wNZfjdIBW2zXIwZdJXCid
	tRjCrDk253KgHduD9wdrSa5AGRW3Hj+MgYlzUfAFgiU8qg8EsADp95lA/XDP0og==
X-Received: by 2002:a05:6512:3092:b0:52e:767a:ada7 with SMTP id 2adb3069b0e04-52e82702ed0mr5685160e87.50.1719930620242;
        Tue, 02 Jul 2024 07:30:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmlYVq/dsNEdP0OinVSOmSriUPk64RTurOHtSTtqwDzvFrRNvhz09uiyE6K1dnU5LneVtrcQ==
X-Received: by 2002:a05:6512:3092:b0:52e:767a:ada7 with SMTP id 2adb3069b0e04-52e82702ed0mr5685140e87.50.1719930619750;
        Tue, 02 Jul 2024 07:30:19 -0700 (PDT)
Received: from toolbox.fritz.box ([193.138.7.148])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab0ba7esm1792343e87.55.2024.07.02.07.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 07:30:19 -0700 (PDT)
From: Sebastian Wick <sebastian.wick@redhat.com>
To: dri-devel@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	linux-kernel@vger.kernel.org,
	Pekka Paalanen <pekka.paalanen@collabora.com>
Subject: [PATCH v2] drm/drm_connector: Document Colorspace property variants
Date: Tue,  2 Jul 2024 16:30:16 +0200
Message-ID: <20240702143017.2429975-1-sebastian.wick@redhat.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The initial idea of the Colorspace prop was that this maps 1:1 to
InfoFrames/SDP but KMS does not give user space enough information nor
control over the output format to figure out which variants can be used
for a given KMS commit. At the same time, properties like Broadcast RGB
expect full range quantization range being produced by user space from
the CRTC and drivers to convert to the range expected by the sink for
the chosen output format, mode, InfoFrames, etc.

This change documents the reality of the Colorspace property. The
Default variant unfortunately is very much driver specific and not
reflected by the EDID. The BT2020 variants are in active use by generic
compositors which have expectations from the driver about the
conversions it has to do when selecting certain output formats.

Everything else is also marked as undefined. Coming up with valid
behavior that makes it usable from user space and consistent with other
KMS properties for those variants is left as an exercise for whoever
wants to use them.

v2:
 * Talk about "pixel operation properties" that user space configures
 * Mention that user space is responsible for checking the EDID for sink
   support
 * Make it clear that drivers can choose between RGB and YCbCr on their
   own

Signed-off-by: Sebastian Wick <sebastian.wick@redhat.com>
Reviewed-by: Pekka Paalanen <pekka.paalanen@collabora.com>
---
 drivers/gpu/drm/drm_connector.c | 79 +++++++++++++++++++++++++--------
 include/drm/drm_connector.h     |  8 ----
 2 files changed, 61 insertions(+), 26 deletions(-)

diff --git ./drivers/gpu/drm/drm_connector.c ../drivers/gpu/drm/drm_connector.c
index ab6ab7ff7ea8..b4f4d2f908d1 100644
--- ./drivers/gpu/drm/drm_connector.c
+++ ../drivers/gpu/drm/drm_connector.c
@@ -2315,24 +2315,67 @@ EXPORT_SYMBOL(drm_mode_create_aspect_ratio_property);
  * DOC: standard connector properties
  *
  * Colorspace:
- *     This property helps select a suitable colorspace based on the sink
- *     capability. Modern sink devices support wider gamut like BT2020.
- *     This helps switch to BT2020 mode if the BT2020 encoded video stream
- *     is being played by the user, same for any other colorspace. Thereby
- *     giving a good visual experience to users.
- *
- *     The expectation from userspace is that it should parse the EDID
- *     and get supported colorspaces. Use this property and switch to the
- *     one supported. Sink supported colorspaces should be retrieved by
- *     userspace from EDID and driver will not explicitly expose them.
- *
- *     Basically the expectation from userspace is:
- *      - Set up CRTC DEGAMMA/CTM/GAMMA to convert to some sink
- *        colorspace
- *      - Set this new property to let the sink know what it
- *        converted the CRTC output to.
- *      - This property is just to inform sink what colorspace
- *        source is trying to drive.
+ *	This property is used to inform the driver about the color encoding
+ *	user space configured the pixel operation properties to produce.
+ *	The variants set the colorimetry, transfer characteristics, and which
+ *	YCbCr conversion should be used when necessary.
+ *	The transfer characteristics from HDR_OUTPUT_METADATA takes precedence
+ *	over this property.
+ *	User space always configures the pixel operation properties to produce
+ *	full quantization range data (see the Broadcast RGB property).
+ *
+ *	Drivers inform the sink about what colorimetry, transfer
+ *	characteristics, YCbCr conversion, and quantization range to expect
+ *	(this can depend on the output mode, output format and other
+ *	properties). Drivers also convert the user space provided data to what
+ *	the sink expects.
+ *
+ *	User space has to check if the sink supports all of the possible
+ *	colorimetries that the driver is allowed to pick by parsing the EDID.
+ *
+ *	For historical reasons this property exposes a number of variants which
+ *	result in undefined behavior.
+ *
+ *	Default:
+ *		The behavior is driver-specific.
+ *	BT2020_RGB:
+ *	BT2020_YCC:
+ *		User space configures the pixel operation properties to produce
+ *		RGB content with Rec. ITU-R BT.2020 colorimetry, Rec.
+ *		ITU-R BT.2020 (Table 4, RGB) transfer characteristics and full
+ *		quantization range.
+ *		User space can use the HDR_OUTPUT_METADATA property to set the
+ *		transfer characteristics to PQ (Rec. ITU-R BT.2100 Table 4) or
+ *		HLG (Rec. ITU-R BT.2100 Table 5) in which case, user space
+ *		configures pixel operation properties to produce content with
+ *		the respective transfer characteristics.
+ *		User space has to make sure the sink supports Rec.
+ *		ITU-R BT.2020 R'G'B' and Rec. ITU-R BT.2020 Y'C'BC'R
+ *		colorimetry.
+ *		Drivers can configure the sink to use an RGB format, tell the
+ *		sink to expect Rec. ITU-R BT.2020 R'G'B' colorimetry and convert
+ *		to the appropriate quantization range.
+ *		Drivers can configure the sink to use a YCbCr format, tell the
+ *		sink to expect Rec. ITU-R BT.2020 Y'C'BC'R colorimetry, convert
+ *		to YCbCr using the Rec. ITU-R BT.2020 non-constant luminance
+ *		conversion matrix and convert to the appropriate quantization
+ *		range.
+ *		The variants BT2020_RGB and BT2020_YCC are equivalent and the
+ *		driver chooses between RGB and YCbCr on its own.
+ *	SMPTE_170M_YCC:
+ *	BT709_YCC:
+ *	XVYCC_601:
+ *	XVYCC_709:
+ *	SYCC_601:
+ *	opYCC_601:
+ *	opRGB:
+ *	BT2020_CYCC:
+ *	DCI-P3_RGB_D65:
+ *	DCI-P3_RGB_Theater:
+ *	RGB_WIDE_FIXED:
+ *	RGB_WIDE_FLOAT:
+ *	BT601_YCC:
+ *		The behavior is undefined.
  *
  * Because between HDMI and DP have different colorspaces,
  * drm_mode_create_hdmi_colorspace_property() is used for HDMI connector and
diff --git ./include/drm/drm_connector.h ../include/drm/drm_connector.h
index c754651044d4..e3fa43291f44 100644
--- ./include/drm/drm_connector.h
+++ ../include/drm/drm_connector.h
@@ -471,14 +471,6 @@ enum drm_privacy_screen_status {
  *
  * DP definitions come from the DP v2.0 spec
  * HDMI definitions come from the CTA-861-H spec
- *
- * A note on YCC and RGB variants:
- *
- * Since userspace is not aware of the encoding on the wire
- * (RGB or YCbCr), drivers are free to pick the appropriate
- * variant, regardless of what userspace selects. E.g., if
- * BT2020_RGB is selected by userspace a driver will pick
- * BT2020_YCC if the encoding on the wire is YUV444 or YUV420.
   *
  * @DRM_MODE_COLORIMETRY_DEFAULT:
  *   Driver specific behavior.
-- 
2.45.1


