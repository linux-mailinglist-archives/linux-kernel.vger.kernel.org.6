Return-Path: <linux-kernel+bounces-438690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C14C9EA468
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 02:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA4221882049
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 01:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AF070823;
	Tue, 10 Dec 2024 01:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJuyM3De"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4D219F117;
	Tue, 10 Dec 2024 01:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733794238; cv=none; b=gg6WlJdmGd8MkeMxfenfw3paF99CncqJSXT1/wYwNYENDpC/AeLhoX4hw6S8nk/xPqHX6IsBV13pMvELwDlEyrEdQwYhBnX00AbSk+RoXRpG61bf+bY+9svnRDlCJhDtXi3jjiXWUlGyAxN0Q3rhPvyOSCf3rqpDDxJKMkQSpvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733794238; c=relaxed/simple;
	bh=cDexXHX4GzgWdDmlf1YRfDkxlON8YYEX9HpLDOcY0BM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hDovkf67g778o5VIEgdfFKwYLeb8+yjwiaWRaifo+P3oZPoqRD+eWGHMXk/b46kU9RxvsT/WFZ7kZKlcfBRE5rLHkn6qjXyE+Ra2pC47FNGRjPPfLbfhqdVffGJxgdJxaFXCW6t6S7gZmgh3BqqbKOPB6eWDwZzrzE/1Hch0C1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJuyM3De; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6d88d3d1eb6so48207106d6.0;
        Mon, 09 Dec 2024 17:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733794235; x=1734399035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fC9D6bBSfVEUhHq7Trd28DiW5CSpsRgZ8oSjVO7Uwcc=;
        b=lJuyM3DevFopQ+QTJ/Zzko32N/AswveCgMBUwTb0WY4qGd3PXNh2G6rsCQnj4NxEq4
         pCQVmZaDXJyGb0Ba3bLkvbvjdu6dTr3fbvJaa65OXDrzYdnUGsJMQrxPStsgP/2WBmcA
         UYTAZbII7khphho9J48QZyB4poWerc4ZkDTRZOI8eWKGly6epVwoCca8wRIkyAFLSAnv
         n6dbF4h9DOjbHk8Ri01yrq+Z1x+OKmQLI/Op0+ev3SWyzwZj/NEh71H85h+dugoKivyI
         jWGJcMU38vDjwW1elNd9XkmcN6qrYJMCAD9zE+4CzArL4vlJ8gVjMA8LtpC5lqaP4qfG
         VMZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733794235; x=1734399035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fC9D6bBSfVEUhHq7Trd28DiW5CSpsRgZ8oSjVO7Uwcc=;
        b=LqtVIx1Jr6D4k3x1gMwjLWZMxZB9Fn2XcaAV9REYgWSEKVczabPReErBdvqBZ8+Wt6
         DZwsdw7u+mfBwHD1hp5DaS2YbkkpPai84NW/nV2SsgOhfpya/89o6+7vxpgpFnpc5/L7
         SUws8VSkTmI1eX+qsAJ3ejkrQ4CF+dc8v/6Gj6UtN47lS/uDoRG2LXBqk09SbR2vHIux
         U6ScJeELnh30pxHvffYD3UyZhuUuE8pJONrbSJKSxHSU0Hf/RAVQ9qWSw+oLkmn1KDmF
         BW6VGqnegDXvg+KWFJGpSlp5vORLVmdqyBzYkvN+UppOBk6JQw1MoEhQ9egpfhLn0jpX
         cLjw==
X-Forwarded-Encrypted: i=1; AJvYcCU4oWWm667m/LfZQ1/p1cNTr7IVMTw2ax/GEYWRHH++B13GPlyZinCGC843XZUzWBBQiSfLbohPM5hO@vger.kernel.org, AJvYcCW6EKUSro99FCcm5n+4J1rVDhEz/0koXSgbuc4i+5clsXub05CxYvUqeBJUhcl1SsnV7/jI/oYVJ1EmZtmA@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz9/GReB9U5dfS7H6HNAjPibcC17kNL23HX3KULhpRLRIzKWbw
	AB+bBFa932olqMMA3DxhFHLm0zYEmt1fR019mNV96iFUEaWUbV3x
X-Gm-Gg: ASbGnctKMuGPRt2Y3QRw3qzFTTGD6kXnAeMKUr+U0Qtc1o4UIGVzkFW12mWnjLjPsEu
	nyFRP7Rq9l6umAsfWx2bPCOoyr8KwJWNHZSXt2t+65Pzh7VWxFoyoNqkAizdwxxP/htfuczfpCC
	RsSHrfG7fQx1+ukxi+WGgiW439OQNBGFA875QpMEi80e+WWIgKEUKWf6c4Oa68JgL0bFdMXwHYU
	57jzZxOyByhrAWkRtDi4oAvZb1R3Pyo0jd1c/KWxMW3jPLdkMyihJxOmQqaBHUXDw==
X-Google-Smtp-Source: AGHT+IEljNAVBvyvJhfVHfvliBl66vtZbHIQPQl7CHgoQDBd6uJthPJkN2CurCsM+FLREOa8EJMyWQ==
X-Received: by 2002:a05:6214:c82:b0:6d8:b5dd:7699 with SMTP id 6a1803df08f44-6d92131428amr19515826d6.17.1733794235614;
        Mon, 09 Dec 2024 17:30:35 -0800 (PST)
Received: from master-x64.sparksnet ([204.111.53.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8f429a79csm36834346d6.72.2024.12.09.17.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 17:30:34 -0800 (PST)
From: Peter Geis <pgwipeout@gmail.com>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Peter Geis <pgwipeout@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Diederik de Haas <didi.debian@cknow.org>,
	Dragan Simic <dsimic@manjaro.org>,
	Johan Jonker <jbx6244@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Levin Du <djw@t-chip.com.cn>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH 5/6] arm64: dts: rockchip: correct rk3328-roc regulator map
Date: Tue, 10 Dec 2024 01:30:09 +0000
Message-Id: <20241210013010.81257-6-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241210013010.81257-1-pgwipeout@gmail.com>
References: <20241210013010.81257-1-pgwipeout@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rk3328-roc-cc input power is sourced from a micro-usb port, while
the rk3328-roc-pc input power is sourced from a usb-c port. Both inputs
are 5vdc only. Remove the 12v input from the device tree.

While we are at it, add missing voltages and supply to vcc_phy, missing
voltages to vcc_host1_5v, and standardize the order of regulator
properties among the fixed regulators.

Fixes: 2171f4fdac06 ("arm64: dts: rockchip: add roc-rk3328-cc board")
Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---

 arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi | 23 +++++++++++++-------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi b/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi
index f782c8220dd3..6984387ff8b3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi
@@ -24,22 +24,23 @@ gmac_clkin: external-gmac-clock {
 		#clock-cells = <0>;
 	};
 
-	dc_12v: regulator-dc-12v {
+	/* fed from passive usb input connector */
+	dc_5v: regulator-dc-5v {
 		compatible = "regulator-fixed";
-		regulator-name = "dc_12v";
+		regulator-name = "dc_5v";
 		regulator-always-on;
 		regulator-boot-on;
-		regulator-min-microvolt = <12000000>;
-		regulator-max-microvolt = <12000000>;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
 	};
 
 	vcc_sd: regulator-sdmmc {
 		compatible = "regulator-fixed";
+		regulator-name = "vcc_sd";
 		gpio = <&gpio0 RK_PD6 GPIO_ACTIVE_LOW>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&sdmmc0m1_pin>;
 		regulator-boot-on;
-		regulator-name = "vcc_sd";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		vin-supply = <&vcc_io>;
@@ -50,22 +51,25 @@ vcc_sdio: regulator-sdmmcio {
 		states = <1800000 0x1>, <3300000 0x0>;
 		regulator-name = "vcc_sdio";
 		regulator-type = "voltage";
+		regulator-always-on;
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <3300000>;
-		regulator-always-on;
 		vin-supply = <&vcc_sys>;
 	};
 
 	vcc_host1_5v: vcc_otg_5v: regulator-vcc-host1-5v {
 		compatible = "regulator-fixed";
+		regulator-name = "vcc_host1_5v";
 		enable-active-high;
 		pinctrl-names = "default";
 		pinctrl-0 = <&usb20_host_drv>;
-		regulator-name = "vcc_host1_5v";
 		regulator-always-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
 		vin-supply = <&vcc_sys>;
 	};
 
+	/* sourced from usb input through 3A fuse */
 	vcc_sys: regulator-vcc-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_sys";
@@ -73,7 +77,7 @@ vcc_sys: regulator-vcc-sys {
 		regulator-boot-on;
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
-		vin-supply = <&dc_12v>;
+		vin-supply = <&dc_5v>;
 	};
 
 	vcc_phy: regulator-vcc-phy {
@@ -81,6 +85,9 @@ vcc_phy: regulator-vcc-phy {
 		regulator-name = "vcc_phy";
 		regulator-always-on;
 		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc_io>;
 	};
 
 	leds {
-- 
2.39.5


