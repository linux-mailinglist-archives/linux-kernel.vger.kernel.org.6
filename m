Return-Path: <linux-kernel+bounces-170361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB5A8BD5AE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 21:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 923D0B21DAD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 19:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB20D15CD41;
	Mon,  6 May 2024 19:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbNTBhA0"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0B015B148;
	Mon,  6 May 2024 19:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715024646; cv=none; b=KdphKRaH9dJnkxeT4/jUT+bdKaeVNb9MRA5Rvs2WLIysaaGEu1y2LmyB5hdoaupd6RtqkUE0cO7D1NS9v9ye38STVE4LT/yjVKcsQKtUUO0XEz6z2sOr9p6bxmsnhUvyTqep7ofViNHl1aphpREem+M9/o2u2DP6oVbDV6JBpqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715024646; c=relaxed/simple;
	bh=LLeIBmxwK4RPKjPw0WCpx9wI7MnhMjy1XdXRdQZFEQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TRp4dH6iPbz13HYs/+pLEnDQ+fXpOzZXs2zA8mTFwwH2UDbopMesyVhVx3OG969mVRElDhgZ+DRTg3MAEuWxtcl5qnHG3LV4AVyMOt4G+DmKbRbPj13HvTVjSBtaYJDY4u8ewdJfPfox7HRh6mXNDULde8rGIlDXm6voAnbpf8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FbNTBhA0; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a59b178b75bso370859666b.0;
        Mon, 06 May 2024 12:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715024643; x=1715629443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cEUTDPQIQ4fyK+f9Y09kmkHPYR/zl3Q/hqRXE0mT1cg=;
        b=FbNTBhA0XWZ956CsPXXuAf68HfAP1Dryplr6BwT8jeZyHR8YuZWioo5iGCyh3gP4KL
         6eOCeQmo5s2epSM+j1JFSoLyK6lZSRITbTWLW/X2AlCVqA3WIbFo/eJTyp2tA75Q8A5b
         u50/Dqe3P31wsAx0Eq8TfU0GtqCD8NelqOARRPCv1SHQvQ69xfNeVTFbAn8gZXhAwtWp
         4rEkDs3dahR072nZoDYestvPsnh55sjJT4TXURE+pWX2BqggY497tTz39www7Z39ImZB
         6azEgeSebxOCGBvWoRto9P6xSb4zh6I4i+01SM66ee1knd1fISH/0h+Jyr9fTPNH7Amm
         3mtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715024643; x=1715629443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cEUTDPQIQ4fyK+f9Y09kmkHPYR/zl3Q/hqRXE0mT1cg=;
        b=k60j82ZTsJ5Q1/qY9eYNZZPhLFqc+ovadMJ54T8lQ3DHv9S9gHBWCk418FyXcxk5cV
         eTSfiafxD0gbvb9CIpQjO/3PkfCAbgFa81GI3KQa09suwxtzCGb/dNLK2uTqIEdkbVSw
         qrLRmMacQT1/uhaOocF734zXI/+Y0tBP4AySmpQxdis3fsPtuDDm8gsJpiTToJGf+RwA
         u8WOjB+9rQQBzS05/7h/Y4Xyxvfl3maFgD7cZaUjUVl6duiax9aDS5DT187HImOJKS/S
         JEoQOgUcIil0ZcY3OrNvDrgiiQFakjKbfv0LQ95dge5x/g30sX5D5cXPfu7Gc1PwsFqC
         zW5A==
X-Forwarded-Encrypted: i=1; AJvYcCWexNvqr2MNGBXi92F/lo0A5p8zkFTwPnjRFvMvELpRPKh+aF4F9NJ6IaXhTvmunNNgAM6iIkKDdWWB3462lC+2bWvqO4+epXv6Nt+CttsWZR8TNOwDNfx7ynQpGIEgDhATv8jp2iKZ0WrYEho/4vId7AIeWpLmIcJVhPvJNk7xdRjpZg==
X-Gm-Message-State: AOJu0Yz4oCrIWtiaw47JX5svkmJD9lwrN8AIqm1pc3uMuXYeINE2vNpt
	sTmtJvurECaHjRsocB5e8MlMSXh7YduvKmZ60pbUc/pSPEFyMb4=
X-Google-Smtp-Source: AGHT+IHbkPsuTTfkRPHSR+oNWlUo2rEkFOv/8jNjCTm2kYGpQR0wP36J0oX9tZl1Xf2xBVWgIuha0g==
X-Received: by 2002:a17:907:908f:b0:a59:9edf:14b6 with SMTP id ge15-20020a170907908f00b00a599edf14b6mr5458036ejb.45.1715024642757;
        Mon, 06 May 2024 12:44:02 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:1c62:e77:6753:5729])
        by smtp.gmail.com with ESMTPSA id f13-20020a1709067f8d00b00a59d146f034sm1367321ejr.132.2024.05.06.12.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 12:44:02 -0700 (PDT)
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
Subject: [PATCH 6/7] ARM: dts: rockchip: Add DPHY for RK3128
Date: Mon,  6 May 2024 21:43:41 +0200
Message-ID: <20240506194343.282119-7-knaerzche@gmail.com>
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

The InnoSilicon DPHY found in RK3128 SoCs supports DSI/LVDS/TTL with a
maximum transfer rate of 1 Gbps per lane. While at it also add the newly
exported PCLK_MIPIPHY clock id to RK3128_PD_VIO powerdomain as the phy is
part of it.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 arch/arm/boot/dts/rockchip/rk3128.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/rockchip/rk3128.dtsi b/arch/arm/boot/dts/rockchip/rk3128.dtsi
index fb98873fd94e..d16a9d03ba2b 100644
--- a/arch/arm/boot/dts/rockchip/rk3128.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3128.dtsi
@@ -216,6 +216,7 @@ power-domain@RK3128_PD_VIO {
 					 <&cru ACLK_LCDC0>,
 					 <&cru HCLK_LCDC0>,
 					 <&cru PCLK_MIPI>,
+					 <&cru PCLK_MIPIPHY>,
 					 <&cru ACLK_RGA>,
 					 <&cru HCLK_RGA>,
 					 <&cru ACLK_VIO0>,
@@ -496,6 +497,18 @@ hdmi_out: port@1 {
 		};
 	};
 
+	dphy: phy@20038000 {
+		compatible = "rockchip,rk3128-dsi-dphy";
+		reg = <0x20038000 0x4000>;
+		clocks = <&cru SCLK_MIPI_24M>, <&cru PCLK_MIPIPHY>;
+		clock-names = "ref", "pclk";
+		resets = <&cru SRST_MIPIPHY_P>;
+		reset-names = "apb";
+		power-domains = <&power RK3128_PD_VIO>;
+		#phy-cells = <0>;
+		status = "disabled";
+	};
+
 	timer0: timer@20044000 {
 		compatible = "rockchip,rk3128-timer", "rockchip,rk3288-timer";
 		reg = <0x20044000 0x20>;
-- 
2.43.2


