Return-Path: <linux-kernel+bounces-303688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B59A9613BE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 18:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3AC01F23E1C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 16:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F531C8FBB;
	Tue, 27 Aug 2024 16:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="GvIGcWWa"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C2F1CCB34
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 16:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724775171; cv=none; b=DExF8qSX9FOvAcz99FjLFht0QLUuq/1AGkKArOTGtrYAJISU4V8GSChI9t/EpPxxqSKgOl5yGIviNJuFsdbOCyiq8CvNiVR5tn4FJYgPjYWn9Z9MIA0hhMHJfRXGxe1reN9tLipFP3879PU3q6Tg0AtoLU3C4HO4NvMxtkFTFmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724775171; c=relaxed/simple;
	bh=bRCtWPtAP2r01rn+8erIzrRLQcz21OzRWT7kG3+Duwk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bzl9xAgCR7L5DzQ443OMtCFr6Z4S/Do7wqeU+s851WUw18m8K+3dVc6fM/PvdS9d+Cp5fCt/Xv4awKrg4agO1zi/pkl3IYFhGd562uKzPNVwYJoq+/EON6u/DTwoLAqOyBqVqoHemxRVoG7R/UipmzM4XYh2sGRNqXymwlTTPQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=GvIGcWWa; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-534366c1aa2so4849551e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 09:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1724775168; x=1725379968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9b40ZG6wtpXNDRIbJ+N027Dbp0WF4n42iEPhKoROnQ8=;
        b=GvIGcWWaUXsj/i9KetouLMlnYGOL0gestCHP7kj+y3Au1+PlJ17uF/vEye7uhWbCVQ
         Of5dvTQQ/RwZ5UyrsaPv6YDCwGxlc+DSlWUxuNP719nr0bjZ2SycqLYZ2LsU5dsNmovK
         g/3qEce1d3LtRFpDtFwv+p1qb4G/WCr3yrWWPFVYPfNRZ5BoYv4CDbH+oJ4P7jcAVNN9
         wz//THF63N+4mTEdhXN4it2g0/Di0abmR0isNOALbdHxPyQ375uTIwkqURuTQWEKDFPB
         tULSEDH9LNjfIuwUwQwb1XBY01ob85LsLyQvIyNtmP3ft0kXyQR+hO0eQn+Lp6TdbTTc
         kZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724775168; x=1725379968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9b40ZG6wtpXNDRIbJ+N027Dbp0WF4n42iEPhKoROnQ8=;
        b=Jmg5GMXJaODrf2IWpIzUlADNI5OAwY6+AFZhTesAnau6rS+rSoW3fcBEgi68gGT7JZ
         QK4RbBh8TsR5/o7EIjChLhN8s2Yh70AN4eNJHXNHIXZJ8//kFCBKPUYnWqHLgfZ97Lvr
         VEZQLvp0o7ntNdc/CZrDkByKF11dyvRMSEged/5iTOkMk2tHigqVH49iIW0q3B0Rj7G1
         Ri+M6wm3CNAh53+sei3hcQZ7Jt79tpopGg2QhuM/7Om1dtyZSeb7AOwcNMjzN53kd420
         e1ctW/3RTNldONvc5fkkh2876MJ9CoD1G253p3RoWXCfysYsaU6t38JDAnxVg7aHTFLh
         D3YA==
X-Forwarded-Encrypted: i=1; AJvYcCUXdupRsA8aHUgz5WyF/TRlJKN2M24UByXL1y8Aftuj1cptyIGFcw9DENiNh5CGqjKHzlOulUUJt79qTsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWBR2nLtmytNGhotTsEoyH6LvxHE2/j7nYlBgC4rbRvzj6TBJI
	cg7i/oibYOSTypjrUnBIn7ezXnKU2PxPIl17Y4OnrUUgPtqyCGRtEvmWdJe0mWM=
X-Google-Smtp-Source: AGHT+IGztyO/vXFJhZ5is4NuBcc0I5gssmVDfjip0FHP6sjWxirKEM36B5impi0ie7i98OY5jl3r6g==
X-Received: by 2002:a05:6512:e89:b0:52e:767a:ada7 with SMTP id 2adb3069b0e04-53438868d57mr9236836e87.50.1724775167458;
        Tue, 27 Aug 2024 09:12:47 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e54b50dbsm127893966b.93.2024.08.27.09.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 09:12:47 -0700 (PDT)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: manikandan.m@microchip.com,
	dharma.b@microchip.com,
	andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se,
	jernej.skrabec@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	hari.prasathge@microchip.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 2/3] drm/bridge: microchip-lvds: Drop unused headers
Date: Tue, 27 Aug 2024 19:12:22 +0300
Message-Id: <20240827161223.4152195-3-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240827161223.4152195-1-claudiu.beznea@tuxon.dev>
References: <20240827161223.4152195-1-claudiu.beznea@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop unused headers. With this code becomes simpler.

Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
 drivers/gpu/drm/bridge/microchip-lvds.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/bridge/microchip-lvds.c b/drivers/gpu/drm/bridge/microchip-lvds.c
index 027292ab0197..f04831106eea 100644
--- a/drivers/gpu/drm/bridge/microchip-lvds.c
+++ b/drivers/gpu/drm/bridge/microchip-lvds.c
@@ -8,25 +8,16 @@
  */
 
 #include <linux/clk.h>
-#include <linux/component.h>
 #include <linux/delay.h>
 #include <linux/jiffies.h>
-#include <linux/mfd/syscon.h>
+#include <linux/of.h>
 #include <linux/of_graph.h>
-#include <linux/pinctrl/devinfo.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
-#include <linux/regmap.h>
-#include <linux/reset.h>
 
-#include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_of.h>
 #include <drm/drm_panel.h>
-#include <drm/drm_print.h>
-#include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
 
 #define LVDS_POLL_TIMEOUT_MS 1000
 
-- 
2.39.2


