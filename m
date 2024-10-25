Return-Path: <linux-kernel+bounces-382229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C69439B0B40
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39BBE1F2200B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52845216E0C;
	Fri, 25 Oct 2024 17:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="ttlZGNZV"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E52224DB0
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 17:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729876580; cv=none; b=UKNffLrQY8UR3lGlGeVvw064muG9rMMTzgJWwCoEIpTXaHxv49JM7Ho/kYYGqI4A3fuGCyOMCxTZQ/hdgcS7NbjnzTJeGU5e/sLdAXK8fu8DpXaBM0ePwNpsrOyBwibsIqzdWgMiVWIJSApLFaTyL366Sbq6i0uW64MFo96E5kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729876580; c=relaxed/simple;
	bh=UWJvMv3Z0a1PpjzyOCbjoPTg3oDPbd1fp/cxOBSwg9c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NNr3L1WPhoPwveebtI1CDa42r1+2lXf1kp4CjJ3/kRuUVN9WxwmNVT+lbswlyDudcKfNwiRRqmWTz/sctK1E9UB7GrEkCqUzXS4CPZKsGQCvSXjypmlEj0c30ArKZ0TFSBTB9x4R772khQTOrvneisEUFkXZkyK0anYbz43ZOiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=ttlZGNZV; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43158625112so22707395e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 10:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1729876576; x=1730481376; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QATmMbNk3c4g4hXx1UR19WiwFTrUbM+WoGxURwc9BNY=;
        b=ttlZGNZVB0Ams2NBquHqNmmwhH2GPS2xxMSvClEwatkCAy98C8hAa9vgvRVCQof+fW
         kblThihRuEMi4SiKp6jeboYyp5rAA7TXXBgw4YJp4r0dtq6GJe2uRZvpumiiH+1PoaFX
         cnMExDFQj7OHPDdhVKPeA/nGKLJXHXtznyhBgMw6eSDsg4LLS3kmhYOoW4SKfU4j1rkV
         slAZNqP1IgMXmh/NHPa/2ndn6LMRyUbBe6W4LomXg1ErtX2bPvWa1dz2kJ7oWUSlYjOF
         OlfrqdujKiZ5xbSjAgPRiY0gj72f2eKFqx4LyxQVaxU6pUcltNKM2H5QUAj5/N4kU839
         pmeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729876576; x=1730481376;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QATmMbNk3c4g4hXx1UR19WiwFTrUbM+WoGxURwc9BNY=;
        b=ZjHSec+JbJpJ4I1UZFZC6K4DtR4AokmIR/ry1eduLlPh3CduAObySQN3Pr4kROwLYE
         Ri9OeILg3j3ExYBQ6PvzPHrF6nsDtdr7GEbAwBen4BUmt8fK92ynIH2L1Pq1s1vlc159
         9lV4ZCR1MIDcsacggoNKDCZtYBVwVMqeB5LV+sz3+KKVRTR8Td6Zb/ZO7euT466P49Bc
         ofsORtMqYi7f+VczVHGVYfYdwgZm02U/cDVoilGGfiEDJm/0yRAUXnW+igQyIFfmGDCq
         JnudDCYb4i8mljfrdhVzn4HNfXYMDn0FciaTswWGJgO2Ds99czNXEqohyagCTwDxFc0o
         KhcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVp1SPFkyaZMw6WzV940hfboyVvnnCUeKDDTF9E0giC7zRdVQaCpopIbOXuQeyttevnaqjktk4JmC2D5Mc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpXV/QUzOdsj1+9+xlO8b0zLtQ5HVi2pmQ6f84dHoi58IHnpIS
	MUEFfwncXFfWxKmdEXv4fxPGa/cFUgQ6HS0+Ji0BAYZxcnpjNYBQU3S31KDKTgA=
X-Google-Smtp-Source: AGHT+IE/VfikFrZHBGY91VEfdMxjOv4Me9kCVd0mDGc13MQEknYwxLSPdeWAl2uAqA6slK2aB7I+ww==
X-Received: by 2002:adf:fa83:0:b0:37c:d299:b5f0 with SMTP id ffacd0b85a97d-3806120c614mr82922f8f.59.1729876575760;
        Fri, 25 Oct 2024 10:16:15 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38058b91f50sm2013649f8f.94.2024.10.25.10.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 10:16:15 -0700 (PDT)
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Fri, 25 Oct 2024 18:15:46 +0100
Subject: [PATCH v2 15/36] drm/vc4: txp: Add byte enable toggle bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-drm-vc4-2712-support-v2-15-35efa83c8fc0@raspberrypi.com>
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

The MOPLET doesn't have the BYTE_ENABLE field to set, but the TXP and
MOP do, so let's add a boolean to control whether or not we need to set
it.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 drivers/gpu/drm/vc4/vc4_drv.h | 1 +
 drivers/gpu/drm/vc4/vc4_txp.c | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index e08c90245f94..27deb4cde02d 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -538,6 +538,7 @@ struct vc4_crtc_data {
 
 struct vc4_txp_data {
 	struct vc4_crtc_data	base;
+	unsigned int has_byte_enable:1;
 };
 
 extern const struct vc4_txp_data bcm2835_txp_data;
diff --git a/drivers/gpu/drm/vc4/vc4_txp.c b/drivers/gpu/drm/vc4/vc4_txp.c
index 6fe378b454ca..eaf30b2cfb5b 100644
--- a/drivers/gpu/drm/vc4/vc4_txp.c
+++ b/drivers/gpu/drm/vc4/vc4_txp.c
@@ -287,6 +287,7 @@ static void vc4_txp_connector_atomic_commit(struct drm_connector *conn,
 	struct drm_connector_state *conn_state = drm_atomic_get_new_connector_state(state,
 										    conn);
 	struct vc4_txp *txp = connector_to_vc4_txp(conn);
+	const struct vc4_txp_data *txp_data = txp->data;
 	struct drm_gem_dma_object *gem;
 	struct drm_display_mode *mode;
 	struct drm_framebuffer *fb;
@@ -309,9 +310,11 @@ static void vc4_txp_connector_atomic_commit(struct drm_connector *conn,
 		return;
 
 	ctrl = TXP_GO | TXP_EI |
-	       VC4_SET_FIELD(0xf, TXP_BYTE_ENABLE) |
 	       VC4_SET_FIELD(txp_fmts[i], TXP_FORMAT);
 
+	if (txp_data->has_byte_enable)
+		ctrl |= VC4_SET_FIELD(0xf, TXP_BYTE_ENABLE);
+
 	if (fb->format->has_alpha)
 		ctrl |= TXP_ALPHA_ENABLE;
 	else
@@ -492,6 +495,7 @@ const struct vc4_txp_data bcm2835_txp_data = {
 		.hvs_available_channels = BIT(2),
 		.hvs_output = 2,
 	},
+	.has_byte_enable = true,
 };
 
 static int vc4_txp_bind(struct device *dev, struct device *master, void *data)

-- 
2.34.1


