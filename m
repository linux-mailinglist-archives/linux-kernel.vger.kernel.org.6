Return-Path: <linux-kernel+bounces-382237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB489B0B5B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 046BBB22D32
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EC7229B31;
	Fri, 25 Oct 2024 17:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="T7HRAHIN"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A2622443A
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 17:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729876587; cv=none; b=U9xmHtywqxx5lxHnLzAAuSOwp+JC+M0QYKq5LMidwUgClUMMDdTUYwl52IF1sK4U2SuYKm4UqI4Hwy6yuCmIHGQkvLJIPzkfvLmpl0LnB5RSAG0jRUEtzY7QwoH1HkN/WJjOxV66wp0BUBVUqiag6QVzfFAn+3We3TBmY3ypv8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729876587; c=relaxed/simple;
	bh=7jLpEAJMVrLhmXPp9ULrFW+zzw3Aoy+OpTHf16ixobE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ctsT8B9DbyaoLySCmflbRP3/rijfrqaw0lQJ2jVtj2r2KsiB9bbVUqlT09+nlqCcK9KXTog/0QYCEFiCUV48QDxmNt1lxRBQWjUtgOJt0oDtQ+gabH8PmBzQkG8XEAOqI5AUjJQ2p+VBHhYx/wXOokZ6WA3YNlJHR3tPH6CwhwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=T7HRAHIN; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4316cce103dso29104485e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 10:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1729876581; x=1730481381; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=045viQzx57IhwQQsyT6qqiu42hT8ZIqMYzIaAsSMK5k=;
        b=T7HRAHINzktXA1XrsAaYbiGJuoeS5NR4yxGnYpZq8ZP+Bx2pBgTcgJEABmrW7gFV/7
         p5/8+qYfu7PYdAmAMLJJj4ZOhDQfmhi5sXJfeec5sCVlepzniuIyb8+3QahiUuOiI7SY
         rGowXAoeV3e482CRQxLtv2AqLOeCsHmALrVk0CbPN6c9w4pe7QhdI5TQg8y3ZDI6DQm2
         3gMgsoHI3QASwQjlJAXGjBkh1qMjY+uZ9V6KLiopSgZRQkoGbuf0vLoiPcOSvV+XCrOT
         yGgmkUFLZd/CsE27XjheclWY7lZXAZGLBkeYUa6uphRTEVPAoHd10Sik+TnXIu2owMkQ
         stYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729876581; x=1730481381;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=045viQzx57IhwQQsyT6qqiu42hT8ZIqMYzIaAsSMK5k=;
        b=ic8qFd2mc0j+PEgXjEwRKNV0v4IxqusQ0BWk8Rf50s+DGc6QAeru9mTg3Vc6+Nq0PK
         qbDLJ6oGvgN8f9s6trp7ui0ECSFdzprskasedcFUxvQghtb1K3uyDcmtxWfpv+JjOIrH
         V2l3RDg38sY2/5f2usx7XMyhXMoUDj2U1BH07XlvPpdsPcxMeEEsIpeL8U+NfZPDSysA
         kN7kkMeXaWKWg5wtClzM3nxmI4592YH1JrnKq1rRceLHvo61ZwxOmtg9fBTOzQLzpFJ0
         9dS8CqczlCsCj7NtvhBvcXiLp4eBFh0X1PH4hopcrhOoqMUDocQprAcHeHBk7I626q/R
         CDrg==
X-Forwarded-Encrypted: i=1; AJvYcCV5Kca/FWDOu+Ucr+Ogty7k69NNrei/QkSX7gYoGs1bqRE+OuD9lb0BL7mkbOyENrdPfd5Az0PQpj2hJvc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg1X2az6pvOVCHLT/tN93EKwOO5TN2HiLi+vEJzVWzX8NtN9E1
	RTlPVTE6gKhKvBzpftgQND5yhQdIaHTe+l+egpoNQJN+W2JjpZOgizYoU4Trom8=
X-Google-Smtp-Source: AGHT+IFq8aW9+AJOypAF2zuR/gJf+QmQVgnYrUJ9N0n4pCykY2oKrjKRG8wAcTrjRRvZiRW4wqZj4Q==
X-Received: by 2002:a5d:61d2:0:b0:37c:cc4b:d1d6 with SMTP id ffacd0b85a97d-380611a495cmr139300f8f.27.1729876580783;
        Fri, 25 Oct 2024 10:16:20 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38058b91f50sm2013649f8f.94.2024.10.25.10.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 10:16:20 -0700 (PDT)
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Fri, 25 Oct 2024 18:15:51 +0100
Subject: [PATCH v2 20/36] drm/vc4: txp: Add support for BCM2712 MOP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-drm-vc4-2712-support-v2-20-35efa83c8fc0@raspberrypi.com>
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

The BCM2712 has an evolution of what used to be called TXP in the
earlier SoCs, but is now called MOP.

There's a few differences still, so we can add a new compatible to deal
with them easily.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 drivers/gpu/drm/vc4/vc4_txp.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_txp.c b/drivers/gpu/drm/vc4/vc4_txp.c
index 2979d141f3bb..0fb8a57652b5 100644
--- a/drivers/gpu/drm/vc4/vc4_txp.c
+++ b/drivers/gpu/drm/vc4/vc4_txp.c
@@ -386,6 +386,7 @@ static const struct drm_connector_funcs vc4_txp_connector_funcs = {
 static void vc4_txp_encoder_disable(struct drm_encoder *encoder)
 {
 	struct drm_device *drm = encoder->dev;
+	struct vc4_dev *vc4 = to_vc4_dev(drm);
 	struct vc4_txp *txp = encoder_to_vc4_txp(encoder);
 	int idx;
 
@@ -404,7 +405,8 @@ static void vc4_txp_encoder_disable(struct drm_encoder *encoder)
 		WARN_ON(TXP_READ(TXP_DST_CTRL) & TXP_BUSY);
 	}
 
-	TXP_WRITE(TXP_DST_CTRL, TXP_POWERDOWN);
+	if (vc4->gen < VC4_GEN_6_C)
+		TXP_WRITE(TXP_DST_CTRL, TXP_POWERDOWN);
 
 	drm_dev_exit(idx);
 }
@@ -508,6 +510,20 @@ static irqreturn_t vc4_txp_interrupt(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static const struct vc4_txp_data bcm2712_mop_data = {
+	.base = {
+		.name = "mop",
+		.debugfs_name = "mop_regs",
+		.hvs_available_channels = BIT(2),
+		.hvs_output = 2,
+	},
+	.encoder_type = VC4_ENCODER_TYPE_TXP0,
+	.high_addr_ptr_reg = TXP_DST_PTR_HIGH_MOP,
+	.has_byte_enable = true,
+	.size_minus_one = true,
+	.supports_40bit_addresses = true,
+};
+
 const struct vc4_txp_data bcm2835_txp_data = {
 	.base = {
 		.name = "txp",
@@ -613,6 +629,7 @@ static void vc4_txp_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id vc4_txp_dt_match[] = {
+	{ .compatible = "brcm,bcm2712-mop", .data = &bcm2712_mop_data },
 	{ .compatible = "brcm,bcm2835-txp", .data = &bcm2835_txp_data },
 	{ /* sentinel */ },
 };

-- 
2.34.1


