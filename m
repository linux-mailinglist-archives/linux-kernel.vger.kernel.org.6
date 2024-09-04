Return-Path: <linux-kernel+bounces-315286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 307E096C070
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C24DC284C9C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AA41DA2E0;
	Wed,  4 Sep 2024 14:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YzNyxemH"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBC11DA101
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 14:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460157; cv=none; b=qXGO3A8hG1qV3HitcosrjQSPRlrgRmOerFcDYJ8+Ina7sZjxzwSmcBU1EcMHUdag2/V80oPbgrGBgqURloQ4bvAgUkuekY8hU1ehvSAxqniHTD/ilhvCXHlOSAXfpJ13pFHvhB43PgZHC7GyAYCKiPXgkCSiVcswycjaiPSb3Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460157; c=relaxed/simple;
	bh=DUsXXa5FiNORdo8iDN46e3V4kbEpOfJ5I1Oiq0le1iI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BY2SJtqwKW+db//8LUXFZQnekE4dE9n6JyY0LICVig6aEajU0pkbxxGFfrDdoVkyLZz/3S1onFnzrFQkWa6lOJC37GR95dDqNu0R70dE2q7r3EIiEg3gfQzmlua48ziclbN9DXyOaDRHetgkFLAlGlmmsPtL93FmlehEdtZYrxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YzNyxemH; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-715cc93694fso5639579b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 07:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725460155; x=1726064955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2wagnvc93xdBl6hG/s4kAM1tDGElsqmf7qECrntbOAA=;
        b=YzNyxemHRAAtzB7k30Dx9Rc7sHmpjD7njf+FJg5szMKdiEztrwGj6eJdAWTlBYL54c
         OpBXIUPd50QnERU8wA8b19j0WEuyLn8iPkdn68WDdIHDAR+cxZ8WVu3ckvYruCHPlhAW
         cenBd0aAWf54N2hEpmtEzOBy6HeF68h3PchtuLti5qupZZHIjtY5KE2fdA6Zu3Cf1cOG
         NiCZICjTcE0CsEI56RIHewI56LZbU+RZjFB+EqmSpINBTfjI95+YKt2JOwDHYw471PHq
         P17S1RihJTMWcEYntVUQyAkyPe+qLIfr5YlzZ4Ae+Tm/zanodmtuJsihZz3g4ZEBEEPf
         K6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725460155; x=1726064955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2wagnvc93xdBl6hG/s4kAM1tDGElsqmf7qECrntbOAA=;
        b=FV7KaD5fiEi3S3+Y2EkgLdmK2aYZI40ktxmYfb/iMsfM1RtFuDWE7+rRxfnZbSM3WH
         6vd/BUTjxKEpeMDtljUx2DuQdR+zrCcmacHUIysKjUpETQRJidt8ywrLvTAg0Q1IRQCE
         Wz6M1rqQ61xK+4jyKnY8gr+T/WVvU/ee+SSE+KkEB5UqdgALisvZ2dkRM0IxB06YLbiJ
         d0Lje+hm3oP1sEV5CnXE18ZNIjP13ltn06QThafbkrp2eR5SdzEswNerW7vxCVO60qaJ
         7CDNsqb25vR8tsR+TlUKcVSvgx8gmjaQgTfF4f0pTjtpt+5/1Ykn29OqA759opy+a8ZU
         iUjA==
X-Forwarded-Encrypted: i=1; AJvYcCXAx6K1/Bw7BPcOrxZfMMbWHHmsbKCsylpdV5KG/7M35StjDCM6QlLH6cEllDs5ADGHYcu6PKN8LssAFYk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5wqRSwwRdVyS4RgyTXBauQiN/YQC6NWsqI/iqc4+4s5iF/BK+
	aK90oSORtvZ68jBmDYEiMs9muFRANeIlFTD5knRvAb6IXs0St8N0
X-Google-Smtp-Source: AGHT+IFHSl3cs8LGLZK5K6yC6s8qFdueGpXSBHVjJWHT3BmFX4+NBM+gdIg+sZFHWkmTj0niEul1LQ==
X-Received: by 2002:a05:6a00:4f93:b0:70d:11d9:8a3c with SMTP id d2e1a72fcca58-7173c5c237emr12770548b3a.26.1725460155079;
        Wed, 04 Sep 2024 07:29:15 -0700 (PDT)
Received: from localhost.localdomain ([103.149.249.231])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-717785b4de5sm1663296b3a.190.2024.09.04.07.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 07:29:14 -0700 (PDT)
From: Jianhua Lu <lujianhua000@gmail.com>
To: Jianhua Lu <lujianhua000@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm: panel: nt36523: use devm_mipi_dsi_* function to register and attach dsi
Date: Wed,  4 Sep 2024 22:29:07 +0800
Message-ID: <20240904142907.367786-1-lujianhua000@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch to devm_mipi_dsi_* function, we don't need to detach and
unregister dsi manually any more.

Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
---
 drivers/gpu/drm/panel/panel-novatek-nt36523.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36523.c b/drivers/gpu/drm/panel/panel-novatek-nt36523.c
index 18bd2ee71201..04f1d2676c78 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt36523.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt36523.c
@@ -1095,18 +1095,6 @@ static int nt36523_unprepare(struct drm_panel *panel)
 static void nt36523_remove(struct mipi_dsi_device *dsi)
 {
 	struct panel_info *pinfo = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(pinfo->dsi[0]);
-	if (ret < 0)
-		dev_err(&dsi->dev, "failed to detach from DSI0 host: %d\n", ret);
-
-	if (pinfo->desc->is_dual_dsi) {
-		ret = mipi_dsi_detach(pinfo->dsi[1]);
-		if (ret < 0)
-			dev_err(&pinfo->dsi[1]->dev, "failed to detach from DSI1 host: %d\n", ret);
-		mipi_dsi_device_unregister(pinfo->dsi[1]);
-	}
 
 	drm_panel_remove(&pinfo->panel);
 }
@@ -1251,7 +1239,7 @@ static int nt36523_probe(struct mipi_dsi_device *dsi)
 		if (!dsi1_host)
 			return dev_err_probe(dev, -EPROBE_DEFER, "cannot get secondary DSI host\n");
 
-		pinfo->dsi[1] = mipi_dsi_device_register_full(dsi1_host, info);
+		pinfo->dsi[1] = devm_mipi_dsi_device_register_full(dev, dsi1_host, info);
 		if (IS_ERR(pinfo->dsi[1])) {
 			dev_err(dev, "cannot get secondary DSI device\n");
 			return PTR_ERR(pinfo->dsi[1]);
@@ -1288,7 +1276,7 @@ static int nt36523_probe(struct mipi_dsi_device *dsi)
 		pinfo->dsi[i]->format = pinfo->desc->format;
 		pinfo->dsi[i]->mode_flags = pinfo->desc->mode_flags;
 
-		ret = mipi_dsi_attach(pinfo->dsi[i]);
+		ret = devm_mipi_dsi_attach(dev, pinfo->dsi[i]);
 		if (ret < 0)
 			return dev_err_probe(dev, ret, "cannot attach to DSI%d host.\n", i);
 	}
-- 
2.46.0


