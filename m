Return-Path: <linux-kernel+bounces-174571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A918C10ED
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 16:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2C2028419A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 14:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34EF515FCE8;
	Thu,  9 May 2024 14:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyxXXVLi"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB32F15ECFF;
	Thu,  9 May 2024 14:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715263626; cv=none; b=jp8FT76fS37CQXX6Kq9oCSnttqIdrO+Zdb6c3oqMSJZ6LlnR6d0k4xfPhHqaknD6cWNDx9VB/ZlCXl/NI+CHC2THHY+omHtAH9/rybrw809ylasNUOJRrpIFG0X6mraBzkgwtTs2yZPGyUxlkSllI2yv4JdpPkQxItaXbrQAhHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715263626; c=relaxed/simple;
	bh=w3PWZL8h5EAfK1fTlHXEzBZ7j3f7NIkCbUbKhL34M7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iIeMJn9+BGRc1oY2ezmtia5alA0Wd/GtLIZzS3/S0K0FTv52RUPLzgnhH8uYthrbln8truPpEY8Jg7JQnDTuhu3cFupjQtBFa1xLCMWCpxG5qQERvcGI5OKCmELdlwcbUfjKHnj4ac+kJI+dlwFCX5hI7W2MTtaxPwOIGET/Pjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QyxXXVLi; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-34ddc9fe497so499439f8f.3;
        Thu, 09 May 2024 07:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715263623; x=1715868423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gG8NnG9MCxt3FCrGHfY+CHmnXlhVbyAkGBrDmW81e5k=;
        b=QyxXXVLiy73/GZgGbNqg9Hm7OBK8aIQZ8BUcoyQO/d/Y3Yz1Mjxt9N7NvtlmSl7mQm
         GOGguMsNn5SWF4vlA0lsiYqPciEvTQ6CQr60CD61+lm+8d5nq0e1LrDcCCVhLqst3FOY
         pRIaLCZV3sIwnOJryCSnWcDlhAU7gFjUr+R0SVeiX6EqC+o5Hu2ZNbPPsM84IgvReKF0
         ayTqkQ9UHqC19UCBYi6dkk6xZ8ZAuHq6h9zJS9vXfYVniDsC6bXYANtCJ96ZUOdlWabv
         CXUd6pwe3lZeje/iG5yd6FeLN2iyMKCPneCfcktjrEsmr3PfLExmegE3hxVjITFXF9+f
         Ha0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715263623; x=1715868423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gG8NnG9MCxt3FCrGHfY+CHmnXlhVbyAkGBrDmW81e5k=;
        b=gveAwVxtzJk7+kLA/sjtiuBE0mjLX4qiJ32NvygS5j6ub6jE3grpJgftqIj9qc4BWP
         Xg10vVC53Iy9EIWPpqbbwMocyDJ47AoO1muIdI2ul2ZLLsbYb6SkB87EjZFRibXxG3OH
         647rBfuqNgRZaLg/iLI4DayOSQ6+TYf8WDgVjMHA8g/b027PO3vWBvGHG7VVbiklTbQw
         yRLVwzNSarWADWJ7ozPYIvzuX4wNXQjM5Rc0lzaYBYSs+2osVDC0V90KLuPh6HaIXzLh
         r4TiQdKuWb3rPbdbSJgHu3T36lVfScsyZ/XdPyyWvpVDDyjoPYf2PhFLKWZQ0RswYK6r
         y3Zg==
X-Forwarded-Encrypted: i=1; AJvYcCV0Ep4zQDHsZJiRSC0F2pzXZVTt6ZsJYLV2siMqf4Eyk21dvgObI6D4/MJIcsX0VtvoyCk/Ja9APy5E48g877KbFEXm0qJDc5CbMIGni812IV3WjkFyZMssGYqPvZWhUsiuou4TkZZ+Ogp2fbApaJzxec8XvB1UrCx5ITLuYwx7himR/A==
X-Gm-Message-State: AOJu0Yz9HX5ae7wuGgH+gQxrQMuD5K/9Sn2R5eLwVTGglQ0Xfd9nvDAG
	hGu0I8GrFB5iviTBJtHp4lgVTGd4JUI/tWVtgDG8aBE3Ha3Slhw=
X-Google-Smtp-Source: AGHT+IF638N9r8RenDUS5cIi1bm0ckYuTr7cNtt0tRexV/Fy7f9WgU1uTe9kWso6VR3HVhKQKBvSlQ==
X-Received: by 2002:a5d:68c8:0:b0:34a:d1d4:cb3c with SMTP id ffacd0b85a97d-34fca6233aamr5597109f8f.39.1715263623270;
        Thu, 09 May 2024 07:07:03 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:b44:d8c3:6fa8:c46f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baad058sm1793311f8f.66.2024.05.09.07.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 07:07:02 -0700 (PDT)
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
Subject: [PATCH v3 5/7] drm/rockchip: dsi: Add support for RK3128
Date: Thu,  9 May 2024 16:06:51 +0200
Message-ID: <20240509140653.168591-6-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240509140653.168591-1-knaerzche@gmail.com>
References: <20240509140653.168591-1-knaerzche@gmail.com>
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
index 4cc8ed8f4fbd..58a44af0e9ad 100644
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
@@ -1493,6 +1498,18 @@ static const struct rockchip_dw_dsi_chip_data px30_chip_data[] = {
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
@@ -1670,6 +1687,9 @@ static const struct of_device_id dw_mipi_dsi_rockchip_dt_ids[] = {
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


