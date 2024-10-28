Return-Path: <linux-kernel+bounces-384447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6AF9B2A32
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 516121C215DD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D891922CB;
	Mon, 28 Oct 2024 08:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="uBdPpJS1"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA65190470
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 08:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730104057; cv=none; b=QZp0rnWZd6CvLr1+XJYDOH7zCG1axBIK20rNRaqp3PpqIekl3zRnDdpmUtsvCwtiMixa3HJJuggDxk9uLL/wd6fuBsDtVZvU0Qw1or5kiGTpYigQJF6+Ot5rca12vrrr2hBUIZxgFCLN0KPzgx3PjFl8y/9pqQHf5FXouOlvkYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730104057; c=relaxed/simple;
	bh=/MolAkoM8WLlXdJHUkJ7B8oxsQcE/UeueF73xVVv6zY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NLL7uYvBpyid6E0/4cGHvxNoBRzka1kike34HzFqdrxzXIbEcATl12ONqX9zf2E5wTImp2ct7Nd9e6Wj5PmIIl+roleSFa56+op+VQsp8gn+Yi/TQiGrA5vqtPUamkDFuXPcHExWx/BWxu+Ov2BlyBJipGGtZ/XUPkMKBHnqCLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=uBdPpJS1; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7181caa08a3so2201609a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 01:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1730104053; x=1730708853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JUnDdF1NqKOBG1QC1W/FMRUH7DBiKtvIz//4z8kfSg0=;
        b=uBdPpJS12QJVTMOARepckytuXfCLErVohp2e875ZR4IMmLrdlYMHxdMC/S6OrNosAP
         A+BSMwZL7F+cn8baEfj2ViVXijSzWf38eulEdMY/5owKxZo6PdjQNhVGXxfcB7Evy3LA
         NvnaHMLkRQi/n1XJqkxkfK40Pwj5OPiqBki3Usx6ddgm3+AyE4GqjO/jo9IK8I+Ah/xP
         yWYwysebzXxJNM4X5HyztVsBCbppkMLLqy+bsHHlYkcAUwkug2FQsTvFii5X+abl+8kR
         5/VYNjC0nc2nzReZQHozURUpDIUNXfzor3fRlmGrQmFJSj8meEmwiO0xf+OQp1uxrPfZ
         1iig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730104053; x=1730708853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JUnDdF1NqKOBG1QC1W/FMRUH7DBiKtvIz//4z8kfSg0=;
        b=iJggBSiRcT6bZiIMMd4t7DAN3C11l27oF9STc0Ik5oa9y6Y2c3JRGFJwWNWJuIN/B5
         VNsE+V3SQsquPzFkkN/dJV51pj5azgCvqZquclLErYlNfSAuoqXdQQvkG4YLDaAiE48+
         atXdNVD8LrqQz7W6ORWQynSQAnZVigEn18XNLi7L59Vevp9QDI/6T3qgReAbOONRMzU+
         uV9+tunihMJWRCd0DkCWn83Vjdyq5mKhaNzgE1teTg96UDPjUyML/OU7YZhs+QQTIpet
         iVBCZuOwB3Al0k2W/H0cn80Pws4/aDFH7VR6RVrxNseJs5pKE2rnTQTjxFdbnCZs4+Me
         Me9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWGMv0lIyHFUzB6EkvZ+z2aXWywtdtc6QUupP51kJjaIWXHpbqI0HFXMkEj+10bCkvhInW8ONEON8//gB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXcTzZKnUm9znD3nH3LAZxG9A8mv4356VFffXCbUO+t68hcILm
	Ev2zl3pxqqJHVcPE2h51wmVKCgrHo2XM3qYocjlPscXFDaKZlYUIcuxJYem2Szo=
X-Google-Smtp-Source: AGHT+IGPk4YXrutX/vs8AXtEdItCylcwMp3wJPOtQTv6GW7g//NaYI/dS10bOiYT0NqDk06ZhYnIQQ==
X-Received: by 2002:a05:6870:1614:b0:277:7147:26ff with SMTP id 586e51a60fabf-29051d728ebmr4639045fac.35.1730104052900;
        Mon, 28 Oct 2024 01:27:32 -0700 (PDT)
Received: from localhost.localdomain ([2a11:3:200::401b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7205791e451sm5195419b3a.24.2024.10.28.01.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 01:27:32 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
To: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	rafal@milecki.pl,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Michael Zhu <michael.zhu@starfivetech.com>,
	Drew Fustini <drew@beagleboard.org>,
	Alexandru Stan <ams@frame.work>,
	Daniel Schaefer <dhs@frame.work>,
	Sandie Cao <sandie.cao@deepcomputing.io>,
	Yuning Liang <yuning.liang@deepcomputing.io>,
	Huiming Qiu <huiming.qiu@deepcomputing.io>,
	Alex Elder <elder@riscstar.com>,
	linux@frame.work,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Guodong Xu <guodong@riscstar.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>
Subject: [PATCH v7 1/5] riscv: dts: starfive: jh7110-common: revised device node
Date: Mon, 28 Oct 2024 16:25:49 +0800
Message-Id: <20241028082553.1989797-2-guodong@riscstar.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028082553.1989797-1-guodong@riscstar.com>
References: <20241028082553.1989797-1-guodong@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Earlier this year a new DTSI file was created to define common
properties for the StarFive VisionFive 2 and Milk-V Mars boards,
both of which use the StarFive JH7110 SoC.  The Pine64 Star64
board has also been added since that time.

Some of the nodes defined in "jh7110-common.dtsi" are enabled in
that file because all of the boards including it "want" them
enabled.

An upcoming patch enables another JH7110 board, but for that
board not all of these common nodes should be enabled.  Prepare
for supporting the new board by avoiding enabling these nodes in
"jh7110-common.dtsi", and enable them instead in these files:
   jh7110-milkv-mars.dts
   jh7110-pine64-star64.dts
   jh7110-starfive-visionfive-2.dtsi

Signed-off-by: Alex Elder <elder@riscstar.com>
Signed-off-by: Guodong Xu <guodong@riscstar.com>
Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
v7: Add Emil's Reviewed-by
    Fixed a typo in description
v6: New patch

 .../boot/dts/starfive/jh7110-common.dtsi      |  5 -----
 .../boot/dts/starfive/jh7110-milkv-mars.dts   | 17 ++++++++++++++++
 .../dts/starfive/jh7110-pine64-star64.dts     | 17 ++++++++++++++++
 .../jh7110-starfive-visionfive-2.dtsi         | 20 +++++++++++++++++++
 4 files changed, 54 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
index c7771b3b6475..9e77f79ec162 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
@@ -176,7 +176,6 @@ csi2rx_to_camss: endpoint {
 &gmac0 {
 	phy-handle = <&phy0>;
 	phy-mode = "rgmii-id";
-	status = "okay";
 
 	mdio {
 		#address-cells = <1>;
@@ -196,7 +195,6 @@ &i2c0 {
 	i2c-scl-falling-time-ns = <510>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c0_pins>;
-	status = "okay";
 };
 
 &i2c2 {
@@ -311,7 +309,6 @@ &pcie1 {
 &pwmdac {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pwmdac_pins>;
-	status = "okay";
 };
 
 &qspi {
@@ -350,13 +347,11 @@ uboot@100000 {
 &pwm {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pwm_pins>;
-	status = "okay";
 };
 
 &spi0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&spi0_pins>;
-	status = "okay";
 
 	spi_dev0: spi@0 {
 		compatible = "rohm,dh2228fv";
diff --git a/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts b/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
index 5cb9e99e1dac..66ad3eb2fd66 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
+++ b/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
@@ -15,6 +15,11 @@ &gmac0 {
 	starfive,tx-use-rgmii-clk;
 	assigned-clocks = <&aoncrg JH7110_AONCLK_GMAC0_TX>;
 	assigned-clock-parents = <&aoncrg JH7110_AONCLK_GMAC0_RMII_RTX>;
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
 };
 
 &pcie0 {
@@ -35,3 +40,15 @@ &phy0 {
 	rx-internal-delay-ps = <1500>;
 	tx-internal-delay-ps = <1500>;
 };
+
+&pwm {
+	status = "okay";
+};
+
+&pwmdac {
+	status = "okay";
+};
+
+&spi0 {
+	status = "okay";
+};
diff --git a/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts b/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
index b720cdd15ed6..dbc8612b8464 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
+++ b/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
@@ -18,6 +18,7 @@ &gmac0 {
 	starfive,tx-use-rgmii-clk;
 	assigned-clocks = <&aoncrg JH7110_AONCLK_GMAC0_TX>;
 	assigned-clock-parents = <&aoncrg JH7110_AONCLK_GMAC0_RMII_RTX>;
+	status = "okay";
 };
 
 &gmac1 {
@@ -39,6 +40,10 @@ phy1: ethernet-phy@1 {
 	};
 };
 
+&i2c0 {
+	status = "okay";
+};
+
 &pcie1 {
 	status = "okay";
 };
@@ -63,3 +68,15 @@ &phy1 {
 	motorcomm,tx-clk-10-inverted;
 	motorcomm,tx-clk-100-inverted;
 };
+
+&pwm {
+	status = "okay";
+};
+
+&pwmdac {
+	status = "okay";
+};
+
+&spi0 {
+	status = "okay";
+};
diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
index 18f38fc790a4..ef93a394bb2f 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
@@ -13,6 +13,10 @@ aliases {
 	};
 };
 
+&gmac0 {
+	status = "okay";
+};
+
 &gmac1 {
 	phy-handle = <&phy1>;
 	phy-mode = "rgmii-id";
@@ -29,6 +33,10 @@ phy1: ethernet-phy@1 {
 	};
 };
 
+&i2c0 {
+	status = "okay";
+};
+
 &mmc0 {
 	non-removable;
 };
@@ -40,3 +48,15 @@ &pcie0 {
 &pcie1 {
 	status = "okay";
 };
+
+&pwm {
+	status = "okay";
+};
+
+&pwmdac {
+	status = "okay";
+};
+
+&spi0 {
+	status = "okay";
+};
-- 
2.34.1


