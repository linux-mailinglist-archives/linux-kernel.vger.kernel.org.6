Return-Path: <linux-kernel+bounces-174473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEACC8C0F4A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 14:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FEAE28301F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 12:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F62F15250F;
	Thu,  9 May 2024 12:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFgScjXV"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC3E14C596;
	Thu,  9 May 2024 12:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715256449; cv=none; b=eOslDjA0kQR5Gh2+xKjQoPkNb8PpuY8YJNSlN9v1wdyH/6lLSI02Fo0o0SqvdLGanZ2paVLWzDOuVMAmItMOl+avCJRKFK4L4C2E4TnZEaBGDyhQ+XtFSI8wslJImYfmpXDif9o3jxuwMRXVCBA0KSOEST47Qw+1f4oCHvgLkEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715256449; c=relaxed/simple;
	bh=FVF1vPUJcgITD5TmHRdOszxgJ3LOiez8Bu93Wt/3l4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g+rttXlHMKGot8Ipf90/LN23koqtE0n49/5dCQ9qN4SmJ9uCDe9GCpYMBfEW4AQ3XwTxi1vDu80U3H9wvVapUDcgD0/+kYQ4l8SCE8Zx/05dXKZTNeQFVVQl1tCV6DZHnGGK2Q2AjoM5Jg+wi2SD1bmsFoF9s26z93tf7eLLKzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFgScjXV; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41ba1ba55ffso4446815e9.1;
        Thu, 09 May 2024 05:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715256446; x=1715861246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q+bLe4/l+mvEUfFbA3v+BR5qf/S1rNc4PFO2a3ch0KQ=;
        b=bFgScjXVta7aePnZodtBZ5bGhSmEsn4UYiY8HXIpM1wlaw6iGmgHQi7xswDo9nPZUo
         tgaMOSxybpWUN3EaVJZ3N2hA1sQ3j1X/UsKz/fb1GxKtYI7+o4gRyG8EEkX9uw3dnpwC
         gp3OcZQ8Z6BKIl2ZBksamAx8HG5y3guZkctro9maYUZAwUmTnvqFvrBommCT/YLdMqQe
         mbnfDF3k/Dh5QolmmTePL49Gr+HnkQUL42GhQbCMbK67mkuYc/m8SenPeaoQ3RwFWBiJ
         7rvNyGfP72sxHFd0GdIr3goQQiH5cfJtEw8g1S/OvumrFuGLzRahRNsqrARSZ+IngDmy
         gyMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715256446; x=1715861246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q+bLe4/l+mvEUfFbA3v+BR5qf/S1rNc4PFO2a3ch0KQ=;
        b=gL1Bg0IUcQFqlL3mlFhgBp9ImWTb00R1RDYJvP6rb1ksdSUxMbzLs/CtqIGCYsc+oT
         VX/uqztq9R1O8j3kZzKM0FvzdIw5qblniwhs2Nmw4NTc/ArKPlLPXNvwHbRp72NGy4Wt
         josZ15jP4SvUL5mst1ZTAjFZrKGASR78XLJ5ERMzqTUvezmqQthRVtAEbwF8QMYDbVvg
         mSxuArzR+27XboNUPmQWkgVERoIhz+SKdBXnnTxtalwX65OMQij0AXUNg/hYUCvayTy8
         JrWUV59bqDCgsnh4O7SP6KGo+aPU6QGcempkzkQl+Tk6v3sviZ0OtnmMt2usrDGHCa5O
         ZGHg==
X-Forwarded-Encrypted: i=1; AJvYcCUGAtfcGy8Hly/20DU52N5Qde8vnKP9ngoIweXdqr6EefTTJO6Znjlj8NVA6iPA43+XvRBCZoH0qDwc3WhcVE6ikrWr8cTWTXLiNpVKUT6OOc10S+IHho0KDwuF3JnMRNWlfw4oWLJUFKe1adS2Nc+SJgpkGlEUKJClK1mT6BMbPi1HLw==
X-Gm-Message-State: AOJu0YwKaJ82WegX6/lZKy63NlGUTBjTaaW2i2QZfB4AY0z/I/GT6E7F
	PibEx9KmLLQCQZfrfM29wlx+4L5v557uMtkMysCk8gbnHUdk09s=
X-Google-Smtp-Source: AGHT+IHtoArrqD0dnvqLAhLONFA8xc0foDIiP2c2dDm/g4xMVPSUsPLYrXXxqeAb6C9ioPtRQlXv6w==
X-Received: by 2002:a05:600c:354a:b0:41b:f24a:b590 with SMTP id 5b1f17b1804b1-41fbc91f3e4mr21505645e9.3.1715256446176;
        Thu, 09 May 2024 05:07:26 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:b44:d8c3:6fa8:c46f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccce1912sm24112005e9.11.2024.05.09.05.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 05:07:25 -0700 (PDT)
From: Alex Bee <knaerzche@gmail.com>
To: Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v2 5/7] drm/rockchip: dsi: Add support for RK3128
Date: Thu,  9 May 2024 14:07:13 +0200
Message-ID: <20240509120715.86694-6-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240509120715.86694-1-knaerzche@gmail.com>
References: <20240509120715.86694-1-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DesignWare MIPI DSI controller found RK3128 SoCs supports up to 4 DSI
data lanes. Similar to PX30/RK356x/RV1126 it uses an external D-PHY.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
changes since v1:
 - none

 .../gpu/drm/rockchip/dw-mipi-dsi-rockchip.c   | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
index 6ed64cc35275..17fd5260218a 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
@@ -153,6 +153,11 @@
 #define PX30_DSI_TURNDISABLE		BIT(5)
 #define PX30_DSI_LCDC_SEL		BIT(0)
 
+#define RK3128_GRF_LVDS_CON0		0x0150
+#define RK3128_DSI_FORCETXSTOPMODE	GENMASK(13, 10)
+#define RK3128_DSI_FORCERXMODE		BIT(9)
+#define RK3128_DSI_TURNDISABLE		BIT(8)
+
 #define RK3288_GRF_SOC_CON6		0x025c
 #define RK3288_DSI0_LCDC_SEL		BIT(6)
 #define RK3288_DSI1_LCDC_SEL		BIT(9)
@@ -1518,6 +1523,18 @@ static const struct rockchip_dw_dsi_chip_data px30_chip_data[] = {
 	{ /* sentinel */ }
 };
 
+static const struct rockchip_dw_dsi_chip_data rk3128_chip_data[] = {
+	{
+		.reg = 0x10110000,
+		.lanecfg1_grf_reg = RK3128_GRF_LVDS_CON0,
+		.lanecfg1 = HIWORD_UPDATE(0, RK3128_DSI_TURNDISABLE |
+					     RK3128_DSI_FORCERXMODE |
+					     RK3128_DSI_FORCETXSTOPMODE),
+		.max_data_lanes = 4,
+	},
+	{ /* sentinel */ }
+};
+
 static const struct rockchip_dw_dsi_chip_data rk3288_chip_data[] = {
 	{
 		.reg = 0xff960000,
@@ -1695,6 +1712,9 @@ static const struct of_device_id dw_mipi_dsi_rockchip_dt_ids[] = {
 	{
 	 .compatible = "rockchip,px30-mipi-dsi",
 	 .data = &px30_chip_data,
+	}, {
+	 .compatible = "rockchip,rk3128-mipi-dsi",
+	 .data = &rk3128_chip_data,
 	}, {
 	 .compatible = "rockchip,rk3288-mipi-dsi",
 	 .data = &rk3288_chip_data,
-- 
2.43.2


