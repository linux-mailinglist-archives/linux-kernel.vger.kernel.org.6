Return-Path: <linux-kernel+bounces-259624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A91D59399B1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 08:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 298441F22564
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 06:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA921428E2;
	Tue, 23 Jul 2024 06:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="BS71e/hR"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC37F14036E
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 06:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721715997; cv=none; b=k0Acp5VOZb5G5C9JYZ8C3GP2nKoO2342NmUE0Hl0+qzJDXpT6C2J8r17ixLBZoGjuj8uvAhzGp4UTuNSS5k3W0NkgQdOm7/WAoLgniHoIoGOzE3Y6gkXZ+ZG08AEBhh6i8gRzdOLBGXUQDLtY4QFHzjsAAyMJHbYF8l/n5WDK4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721715997; c=relaxed/simple;
	bh=IOlFdcG+Qc+uHnT45i1vLJl0/ZkiTyUuqIT6O9QcgxM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=mWnBNLPC1gDsYiOFIJ1ObFz7ND0T2umtAQCC2ztkFMj1ZtmVf1s4m2aC80XLrKUAVkh7ZvI3ZZiU6bqFH7EIP/SBvQky9iHeurlY1MnF8KN2Q2P/aGcY8C0VvbNH3r3yPOLZt7pAr3vqJ+amyKpnq5EhOkXfeGS/kGNRflfZv3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=BS71e/hR; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fd9e6189d5so12773515ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 23:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1721715995; x=1722320795; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a4U/lX5wwRXFBYNa5qyfaellagLlJY0UfTFYRgdibjk=;
        b=BS71e/hRiXrVMwNqWpo/3z/NzDEWuPu202a+NbPrCqcZyNR6Edk9Mp+N9TvFFlAGeZ
         CkArcuvLQPhDQ6m1my2qX9HERfjqPYQ5kr7UWFPlZZ7BV0bYIzATCmkFCfAq7T+RT0xW
         bangmuH6pBJ9HsSs5BOYXXQ4SlPyPlqen6QRHIg/iZOi3xPSNz0ZMI1fn/fN/rhcyAe4
         OHUimvMy3As5FBVg5+/eyqwHeDmoEjewTDQKAqdKBvk/ITnn82trPR4jUpQDAXjRHtAx
         T/UYp0kUJB05WxBduMWsv+7hSenrTOUaNhWqP8VJRmC0ecdqtPtjN+8COmXkJGy5PXpp
         9fwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721715995; x=1722320795;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a4U/lX5wwRXFBYNa5qyfaellagLlJY0UfTFYRgdibjk=;
        b=GpczT+ZJs3YbJUGhv7HLe3sdSQxq7P4dCzpX0437mAG5m+guV/63VzqGH4yYaI2xtQ
         Hk5bq6NVidplUfpVC9w085impdtjo82u480ZX5nCeUoZIIYPI8kKkMO14i762HmaN8Yu
         Ovj3qWpeFVYLqXpmqnArvcrPC18DMmh5rxB/ZPvAdrcQXoBd5H5Qi/cjV0MYoF+qV55z
         6imm7JEiJjQBJ6NPiX+TkQMGiR09kSzssSiW/q/6HXDCjN9t7sBAep55RiwcgX4VVLmP
         oqgeYP22KHTbnw/aZPw6omiq3wQhTS096OOv7Xtd9lAMX1ynOImoEAeMzrjWBaGw9tP7
         5K6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXhmdcUUjMe04s3q0K1QVqxAF6MT97LzWIYS0RgEp/Sq6WLTi0wGC2bZL2L8J8KPRCN5PSecEOidXugR2ohQxv16+zosS6qBU3PhhE3
X-Gm-Message-State: AOJu0YwO1SoKujvthbryDCwbwvvfLwAiiQeymXrckYQlnlY1f4Zv8fEf
	zQeRueEg/93GOokJhnEvuFKHai5xt6U5XRNWM6Kv76/si8sE9PxgRUeeONet4cw=
X-Google-Smtp-Source: AGHT+IHVekg2SGD27MeBu8a61N2QblO1dxpPiH7hnQpFqY1dwa+oz13T7HNCePcM1CZMQrcn7ELDFg==
X-Received: by 2002:a17:903:2306:b0:1fd:69d6:856d with SMTP id d9443c01a7336-1fd74598718mr72102175ad.17.1721715995165;
        Mon, 22 Jul 2024 23:26:35 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f25ab47sm66351465ad.45.2024.07.22.23.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 23:26:34 -0700 (PDT)
From: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
To: neil.armstrong@linaro.org,
	quic_jesszhan@quicinc.com,
	sam@ravnborg.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	dianders@chromium.org,
	hsinyi@google.com,
	awarnecke002@hotmail.com,
	dmitry.baryshkov@linaro.org
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Subject: [PATCH v4 2/2] drm/panel: boe-th101mb31ig002 : using drm_connector_helper_get_modes_fixed()
Date: Tue, 23 Jul 2024 14:26:15 +0800
Message-Id: <20240723062615.14796-3-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240723062615.14796-1-lvzhaoxiong@huaqin.corp-partner.google.com>
References: <20240723062615.14796-1-lvzhaoxiong@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Use public functions( drm_connector_helper_get_modes_fixed()) to
get porch parameters.

Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
---
Changes between V4 and V3:
-  1.Modify the return value, return drm_connector_helper_get_modes_fixed(connector, desc_mode).
v3: https://lore.kernel.org/all/20240722092428.24499-3-lvzhaoxiong@huaqin.corp-partner.google.com/

Changes between V3 and V2:
-  1. Keep bpc settings and drm_connector_set_panel_orientation() function..
v2: https://lore.kernel.org/all/20240716121112.14435-3-lvzhaoxiong@huaqin.corp-partner.google.com/
---
 .../drm/panel/panel-boe-th101mb31ig002-28a.c  | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c b/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
index d4e4abd103bb..0b87f1e6ecae 100644
--- a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
+++ b/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
@@ -16,6 +16,7 @@
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_modes.h>
 #include <drm/drm_panel.h>
+#include <drm/drm_probe_helper.h>
 
 struct boe_th101mb31ig002;
 
@@ -313,31 +314,15 @@ static int boe_th101mb31ig002_get_modes(struct drm_panel *panel,
 						      struct boe_th101mb31ig002,
 						      panel);
 	const struct drm_display_mode *desc_mode = ctx->desc->modes;
-	struct drm_display_mode *mode;
-
-	mode = drm_mode_duplicate(connector->dev, desc_mode);
-	if (!mode) {
-		dev_err(panel->dev, "Failed to add mode %ux%u@%u\n",
-			desc_mode->hdisplay, desc_mode->vdisplay,
-			drm_mode_vrefresh(desc_mode));
-		return -ENOMEM;
-	}
-
-	drm_mode_set_name(mode);
 
 	connector->display_info.bpc = 8;
-	connector->display_info.width_mm = mode->width_mm;
-	connector->display_info.height_mm = mode->height_mm;
-
 	/*
 	 * TODO: Remove once all drm drivers call
 	 * drm_connector_set_orientation_from_panel()
 	 */
 	drm_connector_set_panel_orientation(connector, ctx->orientation);
 
-	drm_mode_probed_add(connector, mode);
-
-	return 1;
+	return drm_connector_helper_get_modes_fixed(connector, desc_mode);
 }
 
 static enum drm_panel_orientation
-- 
2.17.1


