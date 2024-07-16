Return-Path: <linux-kernel+bounces-253748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2D7932650
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 14:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C6C1282CD9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 12:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7654219AD7B;
	Tue, 16 Jul 2024 12:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="JafaLfzm"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D2819AA49
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 12:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721131896; cv=none; b=RxGW5AAjJ9jmbQ/TbtFsHo07YosbPaLklapJYz0BcbvLGWuo6WxmtZ7ARUYXXqIk7RK5OEsLZRihYAYe3OSKk7FJbLcjbK/I/Nlfkg91isbutsO81smld0wkA1ITvRhFoFXi/fvgZeN8OWylxjRy4VI58dnOX8/uRMPJsono6F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721131896; c=relaxed/simple;
	bh=5CBB6v5QaY78wD6pH3DO3qUvRe+dZn3w4kNcQb79/aI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=efQ0Z1SM8cena9HiH8uWJQZiZXvWoJwUK2CxeWOkvaDRvWheFTXujOhCP5YtkJOsPaz522LGbxouzINYd0CDiqqgiZ2Qs0e9HOmt5lBv7o8lolHNNiPxrT8nCHWxXEsl/QR1L2XZ0QMe3agz5bNEFTNN2RJtYdUD4s1PCj5Ytjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=JafaLfzm; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70b12572bd8so3696092b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 05:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1721131893; x=1721736693; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ctnk4Qig36T6nuqfFemKrVj0VTPFOFW8uO+7ZSbbM1w=;
        b=JafaLfzm15espuJqtAYvK+VTaWHSWIxdgK6yrDzWDCRK6flwRk78djecJzKaqtMyHn
         K4X665kj6PXyKC7E9mdvrUgfsqtoY+LfnWxwWAutiyGB3kvutzg0bJumiIK/tHvbckQF
         lScScmlsBxl53SbBp2URTnflAx0N6EDfHWz6eq2PLswK7AuZEtN+7IOjRqte9bvgSY2y
         BAmg5BOuGvRfR3cgYWRQrId+z3VHBS9xSJmbjVKtdP27OnfArRqUfedBBwjDZXuhdjPS
         Iu9JsR+0FAmADmaC0VVbw0i5g8mZ4snU1mCGLJ68hmBXhnunehrtzuvm+kjebpfTPL+Q
         qJgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721131893; x=1721736693;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ctnk4Qig36T6nuqfFemKrVj0VTPFOFW8uO+7ZSbbM1w=;
        b=IH5mQFNGCk1NXlNwxPBw/m/ogOVpzms0F6ujITChjQokKJ4BbMnUNHDNKwALW2XQN7
         0UaHm6oqE6KPnLvT+ZpFVM+Oj+e3QvIyxSy7uwh9t0isfIqASNp7fDX5uNcgfZiid9Kk
         0jsGFQ+4DMBcxLDp7KEpZIDR1j9bnHMvzZNzZJJVMGwaNYm3W4mlJaRHHo8lq4RYH0Hp
         lZT26LhbFakFaAVTKWjPgTfoQsBkJ5iA/K2cMOSXf4mjJLNnEYI/oU7sF4VLRSqtitSp
         BNsYtf0shMEpqF6u3vM8WC8a8kummyHT6KFMLQjxBvF6OHwl5mPVAGx5SgqY3FB6vfXx
         fkVA==
X-Forwarded-Encrypted: i=1; AJvYcCW16tfWZEKaD2bUdPOWRY3BQsgNiwrGr9kDhtG77xeYWElfDsb56ZSyP5RyhPKMF5rfHfl0g+yucl8MUHVYav3h6MStmodqXOPNWNtl
X-Gm-Message-State: AOJu0YxmYINl06ijCHNfXgjHTaaqMHciywSbf0XkaB5H1/KAcGsCtr4i
	JWxKa6E9xjMt0bLcY2IQ0akH/JcTO1x6GsH17L0sTsYG65GsaFLiCuiamOUPMjw=
X-Google-Smtp-Source: AGHT+IHm5RsQCEppC5izT7ZdsLIybhwjJpUCuQ5C82fMYEhLvy546hF8MA0rbBuj+iMezEQ+roGyiw==
X-Received: by 2002:a05:6a00:3cd2:b0:706:700c:7864 with SMTP id d2e1a72fcca58-70c1fb112a0mr2261549b3a.4.1721131893327;
        Tue, 16 Jul 2024 05:11:33 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7eccc48bsm6114065b3a.203.2024.07.16.05.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 05:11:32 -0700 (PDT)
From: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
To: neil.armstrong@linaro.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	airlied@gmail.com,
	mripard@kernel.org,
	dianders@chromium.org,
	hsinyi@google.com,
	awarnecke002@hotmail.com,
	quic_jesszhan@quicinc.com,
	dmitry.baryshkov@linaro.org
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Subject: [PATCH v2 2/2] drm/panel: boe-th101mb31ig002 : using drm_connector_helper_get_modes_fixed()
Date: Tue, 16 Jul 2024 20:11:12 +0800
Message-Id: <20240716121112.14435-3-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240716121112.14435-1-lvzhaoxiong@huaqin.corp-partner.google.com>
References: <20240716121112.14435-1-lvzhaoxiong@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Use public functions(drm_connector_helper_get_modes_fixed()) to
get porch parameters.

Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
---
 .../drm/panel/panel-boe-th101mb31ig002-28a.c  | 26 ++-----------------
 1 file changed, 2 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c b/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
index d4e4abd103bb..4a61a11099b6 100644
--- a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
+++ b/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
@@ -16,6 +16,7 @@
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_modes.h>
 #include <drm/drm_panel.h>
+#include <drm/drm_probe_helper.h>
 
 struct boe_th101mb31ig002;
 
@@ -313,31 +314,8 @@ static int boe_th101mb31ig002_get_modes(struct drm_panel *panel,
 						      struct boe_th101mb31ig002,
 						      panel);
 	const struct drm_display_mode *desc_mode = ctx->desc->modes;
-	struct drm_display_mode *mode;
 
-	mode = drm_mode_duplicate(connector->dev, desc_mode);
-	if (!mode) {
-		dev_err(panel->dev, "Failed to add mode %ux%u@%u\n",
-			desc_mode->hdisplay, desc_mode->vdisplay,
-			drm_mode_vrefresh(desc_mode));
-		return -ENOMEM;
-	}
-
-	drm_mode_set_name(mode);
-
-	connector->display_info.bpc = 8;
-	connector->display_info.width_mm = mode->width_mm;
-	connector->display_info.height_mm = mode->height_mm;
-
-	/*
-	 * TODO: Remove once all drm drivers call
-	 * drm_connector_set_orientation_from_panel()
-	 */
-	drm_connector_set_panel_orientation(connector, ctx->orientation);
-
-	drm_mode_probed_add(connector, mode);
-
-	return 1;
+	return drm_connector_helper_get_modes_fixed(connector, desc_mode);
 }
 
 static enum drm_panel_orientation
-- 
2.17.1


