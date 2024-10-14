Return-Path: <linux-kernel+bounces-363916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4174F99C8D1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B94EDB2A263
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059571AB6C2;
	Mon, 14 Oct 2024 11:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Jnd1lvck"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08EA1AAE34
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 11:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728904283; cv=none; b=SkQqbfL+OIErgBm1DM4CYReYEKankVsLaAb30hgt7daI7madPs/bhGPm6v/XVQVqQlDN6znwaKoww2nNYeVLkKXQlmF5FMm0qhrxkpE4V+h9V06g2W2L120DwGHfLg+nx2Z5NPozqa3TYflKkD0534n9Uez7zDKa4TGxi/btJDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728904283; c=relaxed/simple;
	bh=yGsDpf79W0Mo+BjcukkVMuQgz+N9KOlWxc92NPDnqTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jHb6toicV0J0yVHpyhH/U/DT4kbZ8FkE7HzduXyNqMsT9cfHYqSOjhaavxvTLhl5Z/yw/adHHLvScEqOjrKsPLKcApJeExUX2fYdqmZhY6BeqYD3TJE9lLaS1V9mqDRqpAqV/O8iCGzFdj6d8WGUIZh+b5nIW1W0tPK9mY+K0Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Jnd1lvck; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20c7edf2872so30859085ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 04:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728904281; x=1729509081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FkghV/5ttd0WEHIT0bzLSGy7WYCQ+WZI8ud8NY6MHoo=;
        b=Jnd1lvckuho4++149K7KuiktDxuWVu/11kDSbyyBz5K4YZVBXEtiG+TX6OZY84nhK3
         bbzqSm+RTixTh/Rt7O3mMrOgRZoJRFOkld+v9z5McFygSEorVIa7oWwTTl1MoRHzY4jG
         hR6XPmfYUpr8Q2g5rV7SO9Ud5H1sn2DzYhfj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728904281; x=1729509081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FkghV/5ttd0WEHIT0bzLSGy7WYCQ+WZI8ud8NY6MHoo=;
        b=g31z6LK+638lJDKSLmA9lK4sP1fh8DxQfUP0ZHEPQsLUF+Xi9fZ1zERTjbZav+k5A7
         lfGauXhi/Chwuz1x0ozPQWYY4vvL2BpOj6vOdK3JTTPyRauUXVw0RdKAOv3Zdhc4mYd0
         iQV45U6hG6K5YjTIup9jTZU83QI/KoJAPfaOd5axdvbDstNNC55NiuML3W037tDmlWKv
         8Mjgy8WqOlW0V+PSwNdnkyibWYh5f0tZO1Qlaq+MAlTk5d49RenhrjUSFjPB7BJEIVRl
         Ax6/BB12tFuOLcLpqhzSo0Mk5ttYVisrPr2ekobrtHqdEoCuDW1Kc5+hhZ5qoE+BxAA4
         EhmQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7gNTej+T77AP6hq75q2P1k1RuU7YdXXK6BUkI6+4W5jYcUNlR9IbG4qY96eBgW88JevIx49JqsOfthMs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7PA85iGmN6PDQlv2uaL6jBJZf+V9zxTHlUFJV+A+CL5xXnRjG
	GyXNDiHXMsi2Rv1jOLhvwF7X8HfDgeTPa29Et5gHVOJmzdc7/cGEgRWs1izGDQ==
X-Google-Smtp-Source: AGHT+IFD/L/UxhmqAna8jISuEc+twRQsxJJY8QOemrVaeu+o5vzIXS4uSFcy/BW2Cy0JRyagrA7whQ==
X-Received: by 2002:a17:903:110e:b0:205:5d71:561e with SMTP id d9443c01a7336-20ca0402291mr171066115ad.26.1728904281409;
        Mon, 14 Oct 2024 04:11:21 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:4907:d52a:1a1a:58d0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bc3e6fcsm63858285ad.118.2024.10.14.04.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 04:11:20 -0700 (PDT)
From: Fei Shao <fshao@chromium.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>
Cc: Fei Shao <fshao@chromium.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v4 3/9] arm64: dts: mediatek: mt8188: Add MIPI DSI nodes
Date: Mon, 14 Oct 2024 19:09:25 +0800
Message-ID: <20241014111053.2294519-4-fshao@chromium.org>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
In-Reply-To: <20241014111053.2294519-1-fshao@chromium.org>
References: <20241014111053.2294519-1-fshao@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add two MIPI DSI nodes and the associated PHY nodes to support DSI
panels.
Individual board device tree should enable the nodes as needed.

Signed-off-by: Fei Shao <fshao@chromium.org>
---

(no changes since v3)

Changes in v3:
- add the secondary MIPI DSI

 arch/arm64/boot/dts/mediatek/mt8188.dtsi | 51 ++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
index 23101d316c4e..bd36320bc60c 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -1839,6 +1839,26 @@ pcieport: pcie-phy@0 {
 			};
 		};
 
+		mipi_tx_config0: dsi-phy@11c80000 {
+			compatible = "mediatek,mt8188-mipi-tx", "mediatek,mt8183-mipi-tx";
+			reg = <0 0x11c80000 0 0x1000>;
+			clocks = <&clk26m>;
+			clock-output-names = "mipi_tx0_pll";
+			#clock-cells = <0>;
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+
+		mipi_tx_config1: dsi-phy@11c90000 {
+			compatible = "mediatek,mt8188-mipi-tx", "mediatek,mt8183-mipi-tx";
+			reg = <0 0x11c90000 0 0x1000>;
+			clocks = <&clk26m>;
+			clock-output-names = "mipi_tx0_pll";
+			#clock-cells = <0>;
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+
 		i2c1: i2c@11e00000 {
 			compatible = "mediatek,mt8188-i2c";
 			reg = <0 0x11e00000 0 0x1000>,
@@ -2224,10 +2244,41 @@ larb19: smi@1a010000 {
 			mediatek,smi = <&vdo_smi_common>;
 		};
 
+		disp_dsi0: dsi@1c008000 {
+			compatible = "mediatek,mt8188-dsi";
+			reg = <0 0x1c008000 0 0x1000>;
+			clocks = <&vdosys0 CLK_VDO0_DSI0>,
+				 <&vdosys0 CLK_VDO0_DSI0_DSI>,
+				 <&mipi_tx_config0>;
+			clock-names = "engine", "digital", "hs";
+			interrupts = <GIC_SPI 644 IRQ_TYPE_LEVEL_HIGH 0>;
+			phys = <&mipi_tx_config0>;
+			phy-names = "dphy";
+			power-domains = <&spm MT8188_POWER_DOMAIN_VDOSYS0>;
+			resets = <&vdosys0 MT8188_VDO0_RST_DSI0>;
+			status = "disabled";
+		};
+
+		disp_dsi1: dsi@1c012000 {
+			compatible = "mediatek,mt8188-dsi";
+			reg = <0 0x1c012000 0 0x1000>;
+			clocks = <&vdosys0 CLK_VDO0_DSI1>,
+				 <&vdosys0 CLK_VDO0_DSI1_DSI>,
+				 <&mipi_tx_config1>;
+			clock-names = "engine", "digital", "hs";
+			interrupts = <GIC_SPI 654 IRQ_TYPE_LEVEL_HIGH 0>;
+			phys = <&mipi_tx_config1>;
+			phy-names = "dphy";
+			power-domains = <&spm MT8188_POWER_DOMAIN_VDOSYS0>;
+			resets = <&vdosys0 MT8188_VDO0_RST_DSI1>;
+			status = "disabled";
+		};
+
 		vdosys0: syscon@1c01d000 {
 			compatible = "mediatek,mt8188-vdosys0", "syscon";
 			reg = <0 0x1c01d000 0 0x1000>;
 			#clock-cells = <1>;
+			#reset-cells = <1>;
 			mboxes = <&gce0 0 CMDQ_THR_PRIO_4>;
 			mediatek,gce-client-reg = <&gce0 SUBSYS_1c01XXXX 0xd000 0x1000>;
 		};
-- 
2.47.0.rc1.288.g06298d1525-goog


