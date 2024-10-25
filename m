Return-Path: <linux-kernel+bounces-382244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C68C89B0B73
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAEFF1C21366
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C5522CC4A;
	Fri, 25 Oct 2024 17:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="GOQxvUU8"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7745C226B6F
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 17:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729876594; cv=none; b=QUSUoVmRKtiFUmeBcmPt5Et8Zmlcp7D3ZO0HDt/9SLWoSuja1ewV4aKTg4oId7vC1i9YsiAjW1SdHGDfKehnRRDi4d3B/PxppP+/MhDuJKuhKh6FgWbG17wz3tCUAw7GBREADVe87Q81pPSmumOaZVYVr0G8skgnN9tBv0ar9vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729876594; c=relaxed/simple;
	bh=8pKCgnrveM4lke8y9auZuEMqMV0HyweQ1m8QIRmnZ4g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MrOxI6c5Q+zUmTdRPntNNosC121hEoDObKGlcrQu2cnNYrEzRd5ii1gUyIZfoQYZFTs+lg9sE7L0DH02D0xudDSzvPYghkAxABsT5PYcbIputWP6EBZygtBzTKh+ffqk6oQ1RkiPvu7ix4zMEFUPYEVEZXPzme4pzRRtMtXw5Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=GOQxvUU8; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d70df0b1aso1770576f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 10:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1729876588; x=1730481388; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ucVW7j3VRo2xghhoJqgDsgYFtjK370Q9Kpp51qjXUY=;
        b=GOQxvUU8F8mEP3lyd810QdzFXCl2FUCcJPygu3fmmZYuWDdSbg1iqg7eDixL5PUHZ/
         v6z1UQyDTsguZGsUC8lKqPpS/YJna6JoNrCXWGzN/oTU2kOTHpnfwjEcC+jLdWui10wt
         7FWsWN2s2VYFxPpgw3COBRK+EcjZ4tkL3Czfa4TL59Ktw782JjjS4w6r7xRUgqxHXZRm
         oat/DShaZbgtPunhFgrv5Vlkz5/BPmCZ6LStffCmqupAjNr8WyJZRbHloVbJBQyltnPa
         iFi29i+hC/7rUAZmATFOUbp8AkdrSZWVf4VeTGe4gIWrOleDch7KWVmlsdIx6jQlxmPW
         lXTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729876588; x=1730481388;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ucVW7j3VRo2xghhoJqgDsgYFtjK370Q9Kpp51qjXUY=;
        b=LxJGZp2gqfeLE3nxR5nuqAZoqvo/+x7xTY/otkOqWFJboMcyacxEpbWdNBgL8Nxnh7
         Q2Ul2lzoIqlW4iqdgQ0B4kO+TMNuydwYUBfBPeAVXXOQjBJXaSQsKjXTOtquhu2yRhgJ
         XoXH3G01HFxgCt9/Fwd/eGLHYNKZuCIDdNbmr0x5a4CKggSNC1XVyVtFsL9UmUtl0J4i
         WRk3i27L4KcOqSOt8D1sJ2BbLIpfDMZoEagRHVTpqI/etfE+7c1cVNVh/TC3IUpqWgaJ
         K6IcV8Y77uI9umUyNzxwZEqnnwp34orVhS9ZHZYL5E/DXhJsHuhSrt85JrgEXjtBzp0J
         orkg==
X-Forwarded-Encrypted: i=1; AJvYcCWKD0bbCXmpsDOHH1vwktWIo2MWkcTjjOs0atE9diI19Yr4tue4lAsURWEN0RHLgkMe0DmjZ08ylgr7fno=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp60HAIxzWXmfR4B3EvHKi1pwptTsSL5em8vJN1EHWCiJ/AbC3
	X+tV7VkU572NZ/c1AutHYMiEs2UQPTjxYPtkZDq3EaXhbOaRNvkWPxE5XnDG7d4=
X-Google-Smtp-Source: AGHT+IHith+nby6S+6PBCDtMGCYXz8WWaZpZndzlrwLswYlE/kRFwhddJaPxJNnioSkaK9oic7PjTw==
X-Received: by 2002:adf:9bd4:0:b0:37d:4e74:687 with SMTP id ffacd0b85a97d-380611e1392mr111135f8f.41.1729876588429;
        Fri, 25 Oct 2024 10:16:28 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38058b91f50sm2013649f8f.94.2024.10.25.10.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 10:16:28 -0700 (PDT)
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Fri, 25 Oct 2024 18:15:59 +0100
Subject: [PATCH v2 28/36] drm/vc4: Drop planes that are completely
 off-screen or 0 crtc size
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-drm-vc4-2712-support-v2-28-35efa83c8fc0@raspberrypi.com>
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

It is permitted for a plane to be configured such that none
of it is on-screen via either negative dest rectangle X,Y
offset, or an offset that is greater than the crtc dimensions.

These planes were resized via drm_atomic_helper_check_plane_state
such that the source rectangle had a zero width or height, but
they still created a dlist entry even though they contributed
no pixels. In the case of vc6_plane_mode_set, that it could result
in negative values being written into registers, which caused
incorrect behaviour.

Drop planes that result in a source width or height of 0 pixels
or an on-screen size of 0 pixels to avoid the incorrect rendering.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/vc4/vc4_plane.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_plane.c b/drivers/gpu/drm/vc4/vc4_plane.c
index c084967d3527..94737c587f20 100644
--- a/drivers/gpu/drm/vc4/vc4_plane.c
+++ b/drivers/gpu/drm/vc4/vc4_plane.c
@@ -1230,6 +1230,13 @@ static int vc4_plane_mode_set(struct drm_plane *plane,
 	if (ret)
 		return ret;
 
+	if (!vc4_state->src_w[0] || !vc4_state->src_h[0] ||
+	    !vc4_state->crtc_w || !vc4_state->crtc_h) {
+		/* 0 source size probably means the plane is offscreen */
+		vc4_state->dlist_initialized = 1;
+		return 0;
+	}
+
 	width = vc4_state->src_w[0] >> 16;
 	height = vc4_state->src_h[0] >> 16;
 
@@ -1753,6 +1760,15 @@ static int vc6_plane_mode_set(struct drm_plane *plane,
 	if (ret)
 		return ret;
 
+	if (!vc4_state->src_w[0] || !vc4_state->src_h[0] ||
+	    !vc4_state->crtc_w || !vc4_state->crtc_h) {
+		/* 0 source size probably means the plane is offscreen.
+		 * 0 destination size is a redundant plane.
+		 */
+		vc4_state->dlist_initialized = 1;
+		return 0;
+	}
+
 	width = vc4_state->src_w[0] >> 16;
 	height = vc4_state->src_h[0] >> 16;
 
@@ -2135,6 +2151,10 @@ static int vc4_plane_atomic_check(struct drm_plane *plane,
 	if (ret)
 		return ret;
 
+	if (!vc4_state->src_w[0] || !vc4_state->src_h[0] ||
+	    !vc4_state->crtc_w || !vc4_state->crtc_h)
+		return 0;
+
 	ret = vc4_plane_allocate_lbm(new_plane_state);
 	if (ret)
 		return ret;

-- 
2.34.1


