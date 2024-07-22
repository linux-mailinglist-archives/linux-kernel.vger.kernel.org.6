Return-Path: <linux-kernel+bounces-258713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF3B938C05
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C35D281972
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A4F14F10F;
	Mon, 22 Jul 2024 09:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="d7T/15Iq"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A547913D899
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721640294; cv=none; b=WZzJEZhRVR5+rymDGZB+q3YB4ewC+MsbClJGSEzMnyghDz0kK1gfB175Ra981Mrh/nA5nnj4n3fRBPz0B3C4zk83aGPOBpr0Jio328cJu0qcu4e4RpM9j8CiT2JHYCF/wshuMrCmXD8hdUdeYwhsza+NvIfJ+sa4VFnYjQWCwhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721640294; c=relaxed/simple;
	bh=5z8J3jCaMgq+XDqQ05huL8lSlwbo57cCYj7szikNg0w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=uIoMZlVnlQ0XIJ2On70B7bhBJCmMIzw/9veSYp4PyF56ONWxsNkdGLti22rFdTMR0fMlCGcMWm9ECN6zHLG5VIRFq62W9YUXwocQgxjH9xR+1o4m3YW/GIMnHOHtZTQN/pI4Rt8zWQMYIFCrwxscjbr1gkZWsJ4ztIsmDXhKDkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=d7T/15Iq; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7037c464792so2306304a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 02:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1721640292; x=1722245092; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LwMtkumDOAcsN4lhSlus+4X6amT7wl8ZjMu53GJ7yCY=;
        b=d7T/15IqLBpQ95xWWXcZKfDuwd3sTM3L7+ZGrqDBjtCTbM53kGsldvUVLbbd0Z1XmY
         2Inx/QMioLvUurPQ93M+HJ9ltlGP0aHer3J0pKO+2Lz/h0ckY8V6yLpghsqadTyRPsJU
         QNaZs5kRptddngooGZmzXLxnAaOPHxJaL9LQoRH06rlDuVDiQqmlfzqO3nE9euA7444m
         SDLIRcQ7bSmBoPba0bx82pE1ES/mRD1LwD/ej3VdZ1iGdmGfPRFuKUjX+r+l4I4lV6V6
         zJpnT/lrEz57CnAIXzMktH4DLp0LQ1Iq9wnICk4IozXm+9w7MWzQcIm2w0Q8j7DtT6gn
         flQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721640292; x=1722245092;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LwMtkumDOAcsN4lhSlus+4X6amT7wl8ZjMu53GJ7yCY=;
        b=eq9VgMfVlEqMSxQwgTfU7U1oyVylXlJSg2O5y3wuYHnqbZ8wSgmlz4P7or2CaAGalF
         p11p9StVUWBR4/yBlo1IHePg1GVCHJ9LTsvyaIkiLvHbVoa8dfvK7gMkC2liZCcFvjPf
         Ra/lm5/UT1pRK30jxHCjAHtYfrqbHcerR4EyYR+bGB5qSTV0xa04b7FOjLLeDsAQQYtt
         2d9QSbpsDny3FIeYxkhlzXT5gZDXDssi7IznDmOz93RXSY0MSJAyLxDBDj6f1TSUpX2C
         c4hzTBCO9Y7W+7/gn9YLFZkS0t0rpC7e4eAnvKx5Jya+ablTz6ybMGFaEpLp3jWcXao1
         S7FA==
X-Forwarded-Encrypted: i=1; AJvYcCUC8dQjwCv/cFI6aj2+yela5vKESISdKBZVGSVSLDyPtsId1tZMQz+9Nfy9hGijTmPmsOEGITf4F+VO/Ynl77R6BfdopdFSNvx/5yjy
X-Gm-Message-State: AOJu0YxK3uv3P1IRkrZGfqC7MARmNOvmfoYF5JX/lwwkbQSkHCl6rRtP
	8FgnpW94HZOrIkKfAmz8IoAehWVtZoqLojZ2lCP3+DE0ARV2XeqP5sSAUYuk8Rk=
X-Google-Smtp-Source: AGHT+IHkMmiH7CaJ/wWByiowS0sGdlHfkVI1a7RgoAb/wvbSEO4CaVFFvhQTZbT+KFwx627lM1ZaCA==
X-Received: by 2002:a05:6830:6881:b0:703:6988:dbed with SMTP id 46e09a7af769-708fdbf0792mr10341664a34.34.1721640291747;
        Mon, 22 Jul 2024 02:24:51 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d26efe61dsm1639901b3a.149.2024.07.22.02.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 02:24:51 -0700 (PDT)
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
Subject: [PATCH v3 2/2] drm/panel: boe-th101mb31ig002 : using drm_connector_helper_get_modes_fixed()
Date: Mon, 22 Jul 2024 17:24:28 +0800
Message-Id: <20240722092428.24499-3-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240722092428.24499-1-lvzhaoxiong@huaqin.corp-partner.google.com>
References: <20240722092428.24499-1-lvzhaoxiong@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Use public functions( drm_connector_helper_get_modes_fixed()) to
get porch parameters.

Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
---
Changes between V3 and V2:
-  1. Keep bpc settings and drm_connector_set_panel_orientation() function..
v2: https://lore.kernel.org/all/20240716121112.14435-3-lvzhaoxiong@huaqin.corp-partner.google.com/
---
 .../drm/panel/panel-boe-th101mb31ig002-28a.c    | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c b/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
index d4e4abd103bb..8e5edda32731 100644
--- a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
+++ b/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
@@ -16,6 +16,7 @@
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_modes.h>
 #include <drm/drm_panel.h>
+#include <drm/drm_probe_helper.h>
 
 struct boe_th101mb31ig002;
 
@@ -313,29 +314,15 @@ static int boe_th101mb31ig002_get_modes(struct drm_panel *panel,
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
+	drm_connector_helper_get_modes_fixed(connector, desc_mode);
 
 	return 1;
 }
-- 
2.17.1


