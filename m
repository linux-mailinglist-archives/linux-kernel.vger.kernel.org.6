Return-Path: <linux-kernel+bounces-170360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 767AC8BD5AB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 21:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0543D281998
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 19:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAD6157E62;
	Mon,  6 May 2024 19:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gW+Ned99"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CD515B114;
	Mon,  6 May 2024 19:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715024645; cv=none; b=FtjGIwh+GFxiunuoYlKn694bJoSgSA8cbbBoiirY754YNemdo5p6nUIPNYG1grKAhBX5QKGHaovPcU+Kv66mpSoGmyqir6HEYEZIvsrfehQY2Y+ZvhxWvlTaLZhjCtuh+tN4r5f8Fqsb32yqDSsh9xMQKDD9wumhb8RHuPxWbHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715024645; c=relaxed/simple;
	bh=91okPIgE1f7hjlZSo4vi6q4Pavv/7dZEBf88/PtHfNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GA1eT+l1R3+NthF+K1St8WgKrNxcAdMq0qLr9yault3cBsjqiw+4lfUO7TuuOb697y5W84SyGGn1ZVPVXtfJyvktMqpVebHPKDO61BauD+hIq44/F8djxCigK/yHDFcECWkibpmBPRmbyjG30sh28VjUCePFhi+kLnde5a4crzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gW+Ned99; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a59a609dd3fso378547366b.0;
        Mon, 06 May 2024 12:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715024642; x=1715629442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o57hgKIjAk0UpXtlYxOCbQQvJBzOwu3W7y/5J4X3WHA=;
        b=gW+Ned99KSVMEjBe+zEbixyGBi4PyAsBnXPBL0B/IfyiU4djFxOnhZLmUu5CYQN5aY
         CshVVO9JRT6bo/Os3DlTt6+nn2d/YjM8w2uZxRzHsxRu5cM6h4o8JYBbMcrqBzujbIg5
         +XTAEN1LscOvJLZROl0ln1VCpmP1u1cJgjnx4FaVRzlhtstjSr7nJ1WqQFiQvRZbYsiW
         omTPM/kGoivJY+5WC0xhjxCEQvcNSMcwe4olqeHKmTqmD8vm5luCfUSHBH0Cwls3JE9L
         BGBbDHi1labnx0LvNmYHE1YOsy5JmwrWxUPn4d0PHhV22qQH6pTyszE1iXTSkyTVLbug
         YGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715024642; x=1715629442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o57hgKIjAk0UpXtlYxOCbQQvJBzOwu3W7y/5J4X3WHA=;
        b=PAJhA1oXTjg/lgfxsZsLrr9sYM3ICHEp1/KXhd28+P7tVq3iPQmFtIQawtzwTk9py1
         BW+AFo2FwavwK+qR3n4q32iSZej+gXaqlWf3ysNJ1P3t/x0YNMe+3pjWtd+eOEHoWY5b
         bGcL6nqv2IvV39JFnpp554oGz21tfos31Hrl0hhMpXv/KuDw8r38IDgkQd4aefucYGAC
         ukQKeRaVI18UISY1G0vvzzqJo7AeTIQqA9BmbxAonmNBABMigFPu5XgqKKr+s1grlK+j
         r5WWgBjjgqPNKtkO/PiCvahyDzTuvfSryIfsZICb6ghr228XLwyY6yEhmKrPtjUdUZhV
         KJCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzsxTjCJzBwgU64wpYUHF2A2+LptBboNFrAyNzuutnguRjucfvCI1ZZve7wRLkXMtXqoYKmuYsdLi6Zhl2OU4BlAc9rbRz71F+TeM8fvysCO8PguJnBXT0Zs+HuO/micdrp4nkSL/B7PUk+Dx39D/H66b2P6NCcWm/j4u14xs4LO+LSg==
X-Gm-Message-State: AOJu0YwGUnTK4eTCCt+TW8GZyhklZPZnSGWcTo9YymtPZoETz8vx+kff
	vuZpQAPYxBEi3odyXd9fhZFKTBsa4pROCe0X52OfSyddGgj69ZcK5arO
X-Google-Smtp-Source: AGHT+IH0d83c7xTax7fuIOWVQkoiDle9wGyhCdq0/Z1yJWMYOpdTGsFWFrlzxl7C3Qi6XsSYe60iZA==
X-Received: by 2002:a17:906:fa9a:b0:a55:5520:f43f with SMTP id a640c23a62f3a-a59e4cea3e4mr46264666b.10.1715024641987;
        Mon, 06 May 2024 12:44:01 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:1c62:e77:6753:5729])
        by smtp.gmail.com with ESMTPSA id f13-20020a1709067f8d00b00a59d146f034sm1367321ejr.132.2024.05.06.12.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 12:44:01 -0700 (PDT)
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
Subject: [PATCH 5/7] drm/rockchip: dsi: Add support for RK3128
Date: Mon,  6 May 2024 21:43:40 +0200
Message-ID: <20240506194343.282119-6-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240506194343.282119-1-knaerzche@gmail.com>
References: <20240506194343.282119-1-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DesignWare MIPI DSI controller found RK3128 SoCs supports up to 4 dsi
data lanes. Similar to PX30/RK356x/RV1126 it uses an external DPHY.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
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


