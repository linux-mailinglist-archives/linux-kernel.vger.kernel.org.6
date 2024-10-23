Return-Path: <linux-kernel+bounces-378513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD5F9AD1B4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 18:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97BF51C22A2A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 16:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358A71E22FE;
	Wed, 23 Oct 2024 16:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="HdDumYZO"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D521E412A
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 16:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729702231; cv=none; b=Unh6GMD4620wrVGzAANNBCNOWdWK/bAitLSAv1yB+j25/dEX3BmhiKXDT7+sauxqnLkS9L/rU2j7o7uTJVX2vua3pgJxhk8S35hJJwOJNfnG02bl4bof7QDJ5mbj3nf2wbcp5vKRlJFc+yGEiHmxmAkK0/ILa6WzPdUJt4beqHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729702231; c=relaxed/simple;
	bh=R9RFlDE7CyX8MJ0zzwylUHAIJONhAEoeNvhpIVWQ/rg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KhNz4Lrc7FUbdoxQky9AeACJE14g3x/lVKKerIAp6EGHJ+kiNTTWk2DPkUTqGvPHOCDOXydKd7MaKPetuxqem0UcTEc2HvhdX5l0QRY4fV6yvTxlTnoOe7wpK/VbhUVWF+kYgIFvT/abKFnjHGpAmISZ4igTOv6yg6oLnq2NuEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=HdDumYZO; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4314fa33a35so72279585e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 09:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1729702227; x=1730307027; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HIP++Qp2TfBreng6r9lHSlSqd+05ynFmHtOfFUyYoyw=;
        b=HdDumYZOpCN4yg16gSynPKMlYM5Fuekx46ab+giL19MgxFh0Hc7N9QWzU0/dS0v8e5
         jly3GmJieP79nvUjDEQHz1Do/tw4Y4cxtXVawrWRsYcmvdzijqelZF3j27nWLCkUJgee
         ujNY3pfieUPmUwWkFbNybQXWYfEsTmA1ZI0Yk4LROiMNnsnQ0xI0i4M0OJvWkBkPJD2W
         v7rwwtPC7ru4qySdo+Ruqydmv5GZap5+5ZsQOZmGRAEyXFsDLDE8upegjKRwJgMWD5Nf
         xh6DqtVrAM0WtTx4rFyIqJP+GqmCrPmQAzQC3xgHE1oCwqEd20zVlG3SrVAf6YjRrrpr
         BmZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729702227; x=1730307027;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HIP++Qp2TfBreng6r9lHSlSqd+05ynFmHtOfFUyYoyw=;
        b=ZkZ3UNk/3OwlomW5ac5RrsFClDDcC1izQYdfh4jD5/kGXobX0bzer0X2pjzWexdyGR
         8IWDgdF9ts2vti7BK/hM6qeCFw1vGbKEA/icZ6lTNv0k9tfnyH8kW7jw3FaOUc+VzAVT
         uzoSUoi+zSLayN820xNZc8MjqBKa55Nec6xOt6k7c0tHtQthWUdNxPeIkpeLQmiXMPSv
         QOXrhvPBybpcs6AsG6V+B2GHo+cLHi8Um59ye3gA2OlEvvFpIfFaIdpx40MR1iUsKP0u
         geSdq4zxvpmZim1xs6QekuLJB9X/RHFNPy51VrpCo+X6FTwz18h7rn29oa0daQcwmIWR
         y+iQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPi9vydgoI3lcezTUTeJJnjLChKR9Z8A1pAo7uMrADd7kTgUb8xRhdADAwyhwsNAKsxV5kB3aDWcAyJmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRomiEwxuXCCA5vlywCx9AmkBhg3bPxz/T4Z91z188KWJWkpHQ
	s5Fsa8TBqn733Q4imrZBN60ucofXt71bJCeny+DhdUgwli+OEChqX70D7N4T2Ns=
X-Google-Smtp-Source: AGHT+IFv4syC1FFikZ8gruyh5lMTHnF9kDQfrU5MuNhEjDl7pLUYMo9HHAxXod5ZqqEK/UZfyyrovw==
X-Received: by 2002:a05:600c:4ecb:b0:42f:8287:c24d with SMTP id 5b1f17b1804b1-4318415cfccmr28210645e9.21.1729702227166;
        Wed, 23 Oct 2024 09:50:27 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43186c50445sm21642035e9.39.2024.10.23.09.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 09:50:26 -0700 (PDT)
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Wed, 23 Oct 2024 17:50:16 +0100
Subject: [PATCH 19/37] drm/vc4: txp: Move the encoder type in the variant
 structure
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-drm-vc4-2712-support-v1-19-1cc2d5594907@raspberrypi.com>
References: <20241023-drm-vc4-2712-support-v1-0-1cc2d5594907@raspberrypi.com>
In-Reply-To: <20241023-drm-vc4-2712-support-v1-0-1cc2d5594907@raspberrypi.com>
To: Maxime Ripard <mripard@kernel.org>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>
X-Mailer: b4 0.14.1

From: Maxime Ripard <mripard@kernel.org>

We'll have multiple TXP instances in the BCM2712, so we can't use a
single encoder type anymore. Let's tie the encoder type to the
compatible.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 drivers/gpu/drm/vc4/vc4_drv.h | 1 +
 drivers/gpu/drm/vc4/vc4_txp.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index 34e72e711a17..70b7a771ff47 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -538,6 +538,7 @@ struct vc4_crtc_data {
 
 struct vc4_txp_data {
 	struct vc4_crtc_data	base;
+	enum vc4_encoder_type encoder_type;
 	unsigned int high_addr_ptr_reg;
 	unsigned int has_byte_enable:1;
 	unsigned int size_minus_one:1;
diff --git a/drivers/gpu/drm/vc4/vc4_txp.c b/drivers/gpu/drm/vc4/vc4_txp.c
index c2726ccde1cf..ecd2fc5edf45 100644
--- a/drivers/gpu/drm/vc4/vc4_txp.c
+++ b/drivers/gpu/drm/vc4/vc4_txp.c
@@ -515,6 +515,7 @@ const struct vc4_txp_data bcm2835_txp_data = {
 		.hvs_available_channels = BIT(2),
 		.hvs_output = 2,
 	},
+	.encoder_type = VC4_ENCODER_TYPE_TXP,
 	.has_byte_enable = true,
 };
 
@@ -558,7 +559,7 @@ static int vc4_txp_bind(struct device *dev, struct device *master, void *data)
 		return ret;
 
 	vc4_encoder = &txp->encoder;
-	txp->encoder.type = VC4_ENCODER_TYPE_TXP;
+	txp->encoder.type = txp_data->encoder_type;
 
 	encoder = &vc4_encoder->base;
 	encoder->possible_crtcs = drm_crtc_mask(&vc4_crtc->base);

-- 
2.34.1


