Return-Path: <linux-kernel+bounces-382228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CAC9B0B3A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 195B41C2288A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6192D216DEA;
	Fri, 25 Oct 2024 17:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="eA++Rmc9"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940C5224D9A
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 17:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729876579; cv=none; b=DNMah+nJ8U2SPzASJh1IOa7nS1+8VTXWaj0zZ4y34HqAG+lp1apZOLLNCmPYTWVvseSu+lG3rsbdlHMINM7x4gTKBho1PFbhiIzgLM9BGL5c2QwHMRa2jqgXGhlSTykJcR9iiPog+l4PSpqlZxBEHPO2ytkl8tdVov2vGbbBR6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729876579; c=relaxed/simple;
	bh=HzQCBtQCnxLWR4MqnTAho9PePXTWdc9dHx/+VUH7KOw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Do/zHk6xbBozNKIxPeq4nAQYPCTUcKuMogynGGdNHgb1sVCyMwtDOP9XRqtY5laSse+TqxO1sNcJqklgQk3rHy7ktL0IYinnx+S0Nga2wWD7aPtaHpNqj5LtS4l890vgBpFkVkwgQ8oiTwB3rCp1B9I2XVfLPgipBaWXl7qaORg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=eA++Rmc9; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37f52925fc8so1553000f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 10:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1729876575; x=1730481375; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7dnZzxFDSzNZ2XOSUDTFMzhrUG7dVfBzR4nm1WX8rOk=;
        b=eA++Rmc9Cr3PuXdV9NRYMWMpBZZu2OmYUoUBTEQa0PdVJlEsCHA0K83L4KG+qmHIfH
         rcsDAkMczlZu6aCcVt2Tv3kZj3ytGuf5BHbF1aWP/XM8o3ivHy1iNGyIz3KtWEvgPQTv
         mG3idPc2FthMP20xMHPKZCRG9Xm26kvb6lU4r+3Q1X7wprW8oyhmuxRCgaTHqYUzIhrg
         VqMOnsjrtgm/thShwrBSU4UAez63PclHm26SbsJG0WCdiUVHYTu8mMxaAxFdp+uS660Y
         qhio0RWopb22W2XewFUsOY9qAZ2IZ4p7ef3wFl+OgBLDr7RK2ptlkQTehvt/nmVPZa5X
         2lCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729876575; x=1730481375;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7dnZzxFDSzNZ2XOSUDTFMzhrUG7dVfBzR4nm1WX8rOk=;
        b=TWjXeEgaWMwZ9+vCDT0YL6jP5BgYHgmxwOH7dTpreQxAms4dQeHb1Gnb92fl4ujDCS
         CfITsf3+khx9jcuYK9V3NmPIeypCUD3pC5I01sTphb/wOhhO9Ec5PVo+lGkIlctX43MJ
         JGd++b2MM/cANNELiLs8gqau5kORkrWpsWE4pLcizSdZ8+udXAYH4IwsTEXQGFJwv1qp
         SJFqwsp3Z2599oY8x9z3V7/kD8r6P7KQHDnk56CnNV/6GgFuz0cpERimwwU5vVjjFc3L
         iFOcIPcAgFY84cim9HzmoC4aYOaXYhUQoZleapp0erQLJ7f1HbcSiQnbGRYBb0lAb5Id
         xCzw==
X-Forwarded-Encrypted: i=1; AJvYcCW3On9r8hpjlYZNuy0qLN+A0B2FNxeds8IVBFpsxgXarNgMevCvNoZ0L86ZywwHw6sxQcz2X2sAxqtWKp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUKTsmQxUIesqerh3k2tZ4z1xb0iul3ANRyI1U6cYjCf5flkq4
	SC0hFSjBJFt/rR8fIFBk1bT9csAtAvkR/zMxfw5OwB8ZxZbjMRe3+VdxtmiVkTs=
X-Google-Smtp-Source: AGHT+IFDbWZLs/VvibvWZkwt87XWxzo90576NNCfQK9i5q2/H1vvN4cuvfjgITpZV+qwWj/4uAridw==
X-Received: by 2002:a5d:43c7:0:b0:37d:32ba:ee76 with SMTP id ffacd0b85a97d-3806120db6amr90981f8f.57.1729876574913;
        Fri, 25 Oct 2024 10:16:14 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38058b91f50sm2013649f8f.94.2024.10.25.10.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 10:16:14 -0700 (PDT)
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Fri, 25 Oct 2024 18:15:45 +0100
Subject: [PATCH v2 14/36] drm/vc4: txp: Rename TXP data structure
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-drm-vc4-2712-support-v2-14-35efa83c8fc0@raspberrypi.com>
References: <20241025-drm-vc4-2712-support-v2-0-35efa83c8fc0@raspberrypi.com>
In-Reply-To: <20241025-drm-vc4-2712-support-v2-0-35efa83c8fc0@raspberrypi.com>
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

The TXP data structure has a name too generic for the multiple variants
we'll have to support. Let's rename it to mention the SoC it applies to.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 drivers/gpu/drm/vc4/tests/vc4_mock.c | 4 ++--
 drivers/gpu/drm/vc4/vc4_drv.h        | 2 +-
 drivers/gpu/drm/vc4/vc4_txp.c        | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/vc4/tests/vc4_mock.c b/drivers/gpu/drm/vc4/tests/vc4_mock.c
index c7b91c87f1bc..372482fcd6c7 100644
--- a/drivers/gpu/drm/vc4/tests/vc4_mock.c
+++ b/drivers/gpu/drm/vc4/tests/vc4_mock.c
@@ -51,7 +51,7 @@ struct vc4_mock_desc {
 
 static const struct vc4_mock_desc vc4_mock =
 	VC4_MOCK_DESC(
-		VC4_MOCK_CRTC_DESC(&vc4_txp_data.base,
+		VC4_MOCK_CRTC_DESC(&bcm2835_txp_data.base,
 				   VC4_MOCK_OUTPUT_DESC(VC4_ENCODER_TYPE_TXP,
 							DRM_MODE_ENCODER_VIRTUAL,
 							DRM_MODE_CONNECTOR_WRITEBACK)),
@@ -77,7 +77,7 @@ static const struct vc4_mock_desc vc4_mock =
 
 static const struct vc4_mock_desc vc5_mock =
 	VC4_MOCK_DESC(
-		VC4_MOCK_CRTC_DESC(&vc4_txp_data.base,
+		VC4_MOCK_CRTC_DESC(&bcm2835_txp_data.base,
 				   VC4_MOCK_OUTPUT_DESC(VC4_ENCODER_TYPE_TXP,
 							DRM_MODE_ENCODER_VIRTUAL,
 							DRM_MODE_CONNECTOR_WRITEBACK)),
diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index 1ed1fb5aa7e8..e08c90245f94 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -540,7 +540,7 @@ struct vc4_txp_data {
 	struct vc4_crtc_data	base;
 };
 
-extern const struct vc4_txp_data vc4_txp_data;
+extern const struct vc4_txp_data bcm2835_txp_data;
 
 struct vc4_pv_data {
 	struct vc4_crtc_data	base;
diff --git a/drivers/gpu/drm/vc4/vc4_txp.c b/drivers/gpu/drm/vc4/vc4_txp.c
index dcb1b3fd37de..6fe378b454ca 100644
--- a/drivers/gpu/drm/vc4/vc4_txp.c
+++ b/drivers/gpu/drm/vc4/vc4_txp.c
@@ -485,7 +485,7 @@ static irqreturn_t vc4_txp_interrupt(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-const struct vc4_txp_data vc4_txp_data = {
+const struct vc4_txp_data bcm2835_txp_data = {
 	.base = {
 		.name = "txp",
 		.debugfs_name = "txp_regs",
@@ -588,7 +588,7 @@ static void vc4_txp_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id vc4_txp_dt_match[] = {
-	{ .compatible = "brcm,bcm2835-txp", .data = &vc4_txp_data },
+	{ .compatible = "brcm,bcm2835-txp", .data = &bcm2835_txp_data },
 	{ /* sentinel */ },
 };
 

-- 
2.34.1


