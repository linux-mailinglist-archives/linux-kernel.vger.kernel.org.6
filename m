Return-Path: <linux-kernel+bounces-352149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B070991AB4
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 22:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51C7E1C214AA
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 20:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E1715B992;
	Sat,  5 Oct 2024 20:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c711vinD"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCC018E1F;
	Sat,  5 Oct 2024 20:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728160752; cv=none; b=XQMT8u4SC0exGKInhv//nKFO06nmOId5cgIa5Bzr/W8ZOmRHoOnWELr7HysxfLkaM8elhZWL8HHDw1dwXXTG+jmpNY7/4LnVdRmkDda4vnoe9maFJSMzM6LqhJMKDxROQwK1CatFFSxR5l4758OjVIwFv2VJhTp5pvjCbXYYMlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728160752; c=relaxed/simple;
	bh=uZIG2g5H3fcROmvrzeDnkk4LAPZQVL5AHTFmJTgPvfs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=df+PdaOz/m+lcQTGrXlUL65z3mUDDuyJ8T/JPUbxGPI7WMXODf3d1tJL5+sAnE9M1oA6UKljQXWBxRvF/soqULsctvzX2ILJAFN6SXFMXdoHuTzOl2wzt4OAAKeJwyOydSubwjL9qf+nw3NQTKJ93qdC18E9Z0CMbXfMX7yGI2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c711vinD; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c8856e3e99so487522a12.3;
        Sat, 05 Oct 2024 13:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728160747; x=1728765547; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NllHm6AGAuqG5BTOd+WVXVEN5jdUGG5S6fiI7T3iMI0=;
        b=c711vinDI9A1rBfb5jjgyqsqrMvNkhkMc4QHr9Jvyxr2Dp5hW5i41RLXiH2JHUicQ5
         /3B+w6qb2MKBlIy5xjEsZj5eeEv3PsLbvUT4qLkMdNBrBh6LB4nOBHmxk50QjPZme0MI
         tkgVJb/UO5HU6UAmgKJZJdNJAxtjuwzRB9KiHOKA0c1Yk9GW8XvU0RMtOq2u3dYRojjq
         7RGdAwIsfn5GcPfuQn3zmkGzex2idSF1IUIt3eRdAfO/G/9sAVojiNkxH3gi4atWcvP9
         WQOK5sVbySTvaqfFnTpHMmj18bzeaqRpDK/4NgMah6tfUrUikMTWwDp+VSlDYI8HHRH7
         QVNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728160747; x=1728765547;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NllHm6AGAuqG5BTOd+WVXVEN5jdUGG5S6fiI7T3iMI0=;
        b=lF9R0tuYXrvSXlDRw6eGYa7ekGt0vRxJiZdfk7QZd6YOAK2Bo884od5IDCvul93yFx
         62QraztF77U/t24wCuNLZvIFT8r0aGBJPk5+IQhAWfcZHCVoqZ9+wTfzpUuSzjpXK7ES
         qmVs52+a/jBWg+lmx2d9GQ3/KfQ27eahqfpTiShTu+bp2NQE2Bd4sPGzj/waR7Ji4TfV
         dGGPRv/uoYCR9z0cdEQ6ywZCOWR4pLISwE6RxeOx1iJvNkfXOYM3+DAkPnbKEa+DWPkf
         Pc6dDXnZyNea5Pc0Agd64sBebrL7JNZRb6grjfMdUskNBL49vcsWRMo0jMu3BWVwzH0V
         zluQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXejwBPk+difVGRqRQ1R7c1ZrZzd+0UG7ljEIf32A9bChk3r8UpFQ8rxdlWRfpf3Ij78ZAG73JS1Ha@vger.kernel.org, AJvYcCVlnK7OqdogQOkp2REo05zp32k6t4FqjBXAd+H+f4hEtEgD+4NmKW5Ssjx6Vv05dlEAUEnIvWpG+EHVsJ+F@vger.kernel.org
X-Gm-Message-State: AOJu0YzUSfrER4syGgsH/IL0Si1rq91Y5nA8zPY5THX5s3VPlid4chvs
	rBzPdDBjEC18y1NzU3lcy/1WYmER1MkGgmtkVriJt0H8QLsp0cjenFEAQw==
X-Google-Smtp-Source: AGHT+IEpZHE/mfnX9blLuW278jH7wBwuj6xyQTeAiQV0v+ODW3cPJgqiMe9s/hbp9QkXGImgUw9K6A==
X-Received: by 2002:a17:906:99c1:b0:a8b:6ee7:ba1a with SMTP id a640c23a62f3a-a991c04d5abmr328791666b.9.1728160746458;
        Sat, 05 Oct 2024 13:39:06 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:1:32d0:42ff:fe10:6983? ([2a02:a449:4071:1:32d0:42ff:fe10:6983])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9937615e85sm142041966b.175.2024.10.05.13.39.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Oct 2024 13:39:05 -0700 (PDT)
Message-ID: <cfc3cfe1-086b-48f1-9b89-f17c9391d3cc@gmail.com>
Date: Sat, 5 Oct 2024 22:39:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 1/2] ARM: dts: rockchip: fix nodename regulators
To: heiko@sntech.de
Cc: robh@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The nodename for fixed-regulators has changed to
pattern: '^regulator(-[0-9]+v[0-9]+|-[0-9a-z-]+)?$'

Fix all Rockchip DT regulator nodenames.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

regulator: dt-bindings: fixed-regulator: Add a preferred node name
https://lore.kernel.org/r/20240426215147.3138211-1-robh@kernel.org

Some rk3288-veyron regulators are skipped for now.
---
 arch/arm/boot/dts/rockchip/rk3036-kylin.dts   |  2 +-
 .../boot/dts/rockchip/rk3066a-bqcurie2.dts    |  4 +--
 .../boot/dts/rockchip/rk3066a-marsboard.dts   |  6 ++--
 arch/arm/boot/dts/rockchip/rk3066a-mk808.dts  | 12 ++++----
 .../boot/dts/rockchip/rk3066a-rayeager.dts    | 16 +++++------
 arch/arm/boot/dts/rockchip/rk3128-evb.dts     |  4 +--
 .../arm/boot/dts/rockchip/rk3128-xpi-3128.dts | 28 +++++++++----------
 .../boot/dts/rockchip/rk3188-bqedison2qc.dts  | 14 +++++-----
 arch/arm/boot/dts/rockchip/rk3188-px3-evb.dts |  2 +-
 .../boot/dts/rockchip/rk3188-radxarock.dts    |  8 +++---
 arch/arm/boot/dts/rockchip/rk3228-evb.dts     |  2 +-
 arch/arm/boot/dts/rockchip/rk3229-evb.dts     | 16 +++++------
 arch/arm/boot/dts/rockchip/rk3229-xms6.dts    | 16 +++++------
 .../boot/dts/rockchip/rk3288-evb-act8846.dts  |  4 +--
 arch/arm/boot/dts/rockchip/rk3288-evb.dtsi    |  8 +++---
 .../rockchip/rk3288-firefly-reload-core.dtsi  |  2 +-
 .../dts/rockchip/rk3288-firefly-reload.dts    | 18 ++++++------
 .../arm/boot/dts/rockchip/rk3288-firefly.dtsi | 16 +++++------
 arch/arm/boot/dts/rockchip/rk3288-miqi.dts    |  8 +++---
 .../boot/dts/rockchip/rk3288-phycore-rdk.dts  |  6 ++--
 .../boot/dts/rockchip/rk3288-phycore-som.dtsi |  6 ++--
 .../arm/boot/dts/rockchip/rk3288-popmetal.dts | 10 +++----
 arch/arm/boot/dts/rockchip/rk3288-r89.dts     |  8 +++---
 .../boot/dts/rockchip/rk3288-rock2-som.dtsi   |  4 +--
 .../boot/dts/rockchip/rk3288-rock2-square.dts |  6 ++--
 arch/arm/boot/dts/rockchip/rk3288-tinker.dtsi |  4 +--
 .../boot/dts/rockchip/rk3288-veyron-brain.dts |  6 ++--
 .../rockchip/rk3288-veyron-chromebook.dtsi    | 10 +++----
 .../dts/rockchip/rk3288-veyron-fievel.dts     | 10 +++----
 .../dts/rockchip/rk3288-veyron-mickey.dts     |  4 +--
 arch/arm/boot/dts/rockchip/rk3288-veyron.dtsi |  8 +++---
 .../boot/dts/rockchip/rk3288-vmarc-som.dtsi   |  2 +-
 arch/arm/boot/dts/rockchip/rk3288-vyasa.dts   | 18 ++++++------
 .../rockchip-radxa-dalang-carrier.dtsi        |  8 +++---
 .../arm/boot/dts/rockchip/rv1108-elgin-r1.dts |  2 +-
 arch/arm/boot/dts/rockchip/rv1108-evb.dts     |  2 +-
 .../dts/rockchip/rv1126-edgeble-neu2-io.dts   |  6 ++--
 .../dts/rockchip/rv1126-edgeble-neu2.dtsi     |  2 +-
 38 files changed, 154 insertions(+), 154 deletions(-)

diff --git a/arch/arm/boot/dts/rockchip/rk3036-kylin.dts b/arch/arm/boot/dts/rockchip/rk3036-kylin.dts
index e32c73d32f0a..44675a2fc4cb 100644
--- a/arch/arm/boot/dts/rockchip/rk3036-kylin.dts
+++ b/arch/arm/boot/dts/rockchip/rk3036-kylin.dts
@@ -80,7 +80,7 @@ simple-audio-card,codec {
 		};
 	};

-	vcc_sys: vsys-regulator {
+	vcc_sys: regulator-vsys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_sys";
 		regulator-min-microvolt = <5000000>;
diff --git a/arch/arm/boot/dts/rockchip/rk3066a-bqcurie2.dts b/arch/arm/boot/dts/rockchip/rk3066a-bqcurie2.dts
index f924d4d64c3d..c227691013ea 100644
--- a/arch/arm/boot/dts/rockchip/rk3066a-bqcurie2.dts
+++ b/arch/arm/boot/dts/rockchip/rk3066a-bqcurie2.dts
@@ -22,7 +22,7 @@ memory@60000000 {
 		reg = <0x60000000 0x40000000>;
 	};

-	vdd_log: vdd-log {
+	vdd_log: regulator-vdd-log {
 		compatible = "pwm-regulator";
 		pwms = <&pwm3 0 1000>;
 		regulator-name = "vdd_log";
@@ -34,7 +34,7 @@ vdd_log: vdd-log {
 		status = "okay";
 	};

-	vcc_sd0: fixed-regulator {
+	vcc_sd0: regulator-fixed {
 		compatible = "regulator-fixed";
 		regulator-name = "sdmmc-supply";
 		regulator-min-microvolt = <3000000>;
diff --git a/arch/arm/boot/dts/rockchip/rk3066a-marsboard.dts b/arch/arm/boot/dts/rockchip/rk3066a-marsboard.dts
index f6e8d49a02ef..ada7dbfc06a5 100644
--- a/arch/arm/boot/dts/rockchip/rk3066a-marsboard.dts
+++ b/arch/arm/boot/dts/rockchip/rk3066a-marsboard.dts
@@ -19,7 +19,7 @@ memory@60000000 {
 		reg = <0x60000000 0x40000000>;
 	};

-	vdd_log: vdd-log {
+	vdd_log: regulator-vdd-log {
 		compatible = "pwm-regulator";
 		pwms = <&pwm3 0 1000>;
 		regulator-name = "vdd_log";
@@ -31,7 +31,7 @@ vdd_log: vdd-log {
 		status = "okay";
 	};

-	vcc_sd0: sdmmc-regulator {
+	vcc_sd0: regulator-sdmmc {
 		compatible = "regulator-fixed";
 		regulator-name = "sdmmc-supply";
 		regulator-min-microvolt = <3000000>;
@@ -41,7 +41,7 @@ vcc_sd0: sdmmc-regulator {
 		vin-supply = <&vcc_io>;
 	};

-	vsys: vsys-regulator {
+	vsys: regulator-vsys {
 		compatible = "regulator-fixed";
 		regulator-name = "vsys";
 		regulator-min-microvolt = <5000000>;
diff --git a/arch/arm/boot/dts/rockchip/rk3066a-mk808.dts b/arch/arm/boot/dts/rockchip/rk3066a-mk808.dts
index 4de9a45c4883..25c0bcf85a56 100644
--- a/arch/arm/boot/dts/rockchip/rk3066a-mk808.dts
+++ b/arch/arm/boot/dts/rockchip/rk3066a-mk808.dts
@@ -61,21 +61,21 @@ hdmi_con_in: endpoint {
 		};
 	};

-	vcc_2v5: vcc-2v5 {
+	vcc_2v5: regulator-vcc-2v5 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_2v5";
 		regulator-min-microvolt = <2500000>;
 		regulator-max-microvolt = <2500000>;
 	};

-	vcc_io: vcc-io {
+	vcc_io: regulator-vcc-io {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_io";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 	};

-	vcc_host: usb-host-regulator {
+	vcc_host: regulator-usb-host {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PA6 GPIO_ACTIVE_HIGH>;
@@ -89,7 +89,7 @@ vcc_host: usb-host-regulator {
 		vin-supply = <&vcc_io>;
 	};

-	vcc_otg: usb-otg-regulator {
+	vcc_otg: regulator-usb-otg {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PA5 GPIO_ACTIVE_HIGH>;
@@ -103,7 +103,7 @@ vcc_otg: usb-otg-regulator {
 		vin-supply = <&vcc_io>;
 	};

-	vcc_sd: sdmmc-regulator {
+	vcc_sd: regulator-sdmmc {
 		compatible = "regulator-fixed";
 		gpio = <&gpio3 RK_PA7 GPIO_ACTIVE_LOW>;
 		pinctrl-0 = <&sdmmc_pwr>;
@@ -115,7 +115,7 @@ vcc_sd: sdmmc-regulator {
 		vin-supply = <&vcc_io>;
 	};

-	vcc_wifi: sdio-regulator {
+	vcc_wifi: regulator-sdio {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio3 RK_PD0 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/boot/dts/rockchip/rk3066a-rayeager.dts b/arch/arm/boot/dts/rockchip/rk3066a-rayeager.dts
index 29d8e5bf88f5..b0b029f14643 100644
--- a/arch/arm/boot/dts/rockchip/rk3066a-rayeager.dts
+++ b/arch/arm/boot/dts/rockchip/rk3066a-rayeager.dts
@@ -42,7 +42,7 @@ key-power {
 		};
 	};

-	vdd_log: vdd-log {
+	vdd_log: regulator-vdd-log {
 		compatible = "pwm-regulator";
 		pwms = <&pwm3 0 1000>;
 		regulator-name = "vdd_log";
@@ -54,7 +54,7 @@ vdd_log: vdd-log {
 		status = "okay";
 	};

-	vsys: vsys-regulator {
+	vsys: regulator-vsys {
 		compatible = "regulator-fixed";
 		regulator-name = "vsys";
 		regulator-min-microvolt = <5000000>;
@@ -64,7 +64,7 @@ vsys: vsys-regulator {
 	};

 	/* input for 5V_STDBY is VSYS or DC5V, selectable by jumper J4 */
-	vcc_stdby: stdby-regulator {
+	vcc_stdby: regulator-stdby {
 		compatible = "regulator-fixed";
 		regulator-name = "5v_stdby";
 		regulator-min-microvolt = <5000000>;
@@ -73,7 +73,7 @@ vcc_stdby: stdby-regulator {
 		regulator-boot-on;
 	};

-	vcc_emmc: emmc-regulator {
+	vcc_emmc: regulator-emmc {
 		compatible = "regulator-fixed";
 		regulator-name = "emmc_vccq";
 		regulator-min-microvolt = <3000000>;
@@ -81,7 +81,7 @@ vcc_emmc: emmc-regulator {
 		vin-supply = <&vsys>;
 	};

-	vcc_sata: sata-regulator {
+	vcc_sata: regulator-sata {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio4 RK_PC6 GPIO_ACTIVE_HIGH>;
@@ -94,7 +94,7 @@ vcc_sata: sata-regulator {
 		vin-supply = <&vcc_stdby>;
 	};

-	vcc_sd: sdmmc-regulator {
+	vcc_sd: regulator-sdmmc {
 		compatible = "regulator-fixed";
 		gpio = <&gpio3 RK_PA7 GPIO_ACTIVE_LOW>;
 		pinctrl-names = "default";
@@ -106,7 +106,7 @@ vcc_sd: sdmmc-regulator {
 		vin-supply = <&vcc_io>;
 	};

-	vcc_host: usb-host-regulator {
+	vcc_host: regulator-usb-host {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PA6 GPIO_ACTIVE_HIGH>;
@@ -119,7 +119,7 @@ vcc_host: usb-host-regulator {
 		vin-supply = <&vcc_stdby>;
 	};

-	vcc_otg: usb-otg-regulator {
+	vcc_otg: regulator-usb-otg {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PA5 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/boot/dts/rockchip/rk3128-evb.dts b/arch/arm/boot/dts/rockchip/rk3128-evb.dts
index c7ab7fcdb436..3d27d921de76 100644
--- a/arch/arm/boot/dts/rockchip/rk3128-evb.dts
+++ b/arch/arm/boot/dts/rockchip/rk3128-evb.dts
@@ -24,7 +24,7 @@ memory@60000000 {
 		reg = <0x60000000 0x40000000>;
 	};

-	vcc5v0_otg: vcc5v0-otg-regulator {
+	vcc5v0_otg: regulator-vcc5v0-otg {
 		compatible = "regulator-fixed";
 		gpio = <&gpio0 26 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
@@ -34,7 +34,7 @@ vcc5v0_otg: vcc5v0-otg-regulator {
 		regulator-max-microvolt = <5000000>;
 	};

-	vcc5v0_host: vcc5v0-host-regulator {
+	vcc5v0_host: regulator-vcc5v0-host {
 		compatible = "regulator-fixed";
 		gpio = <&gpio2 23 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/rockchip/rk3128-xpi-3128.dts b/arch/arm/boot/dts/rockchip/rk3128-xpi-3128.dts
index 21c1678f4e91..21f824b09191 100644
--- a/arch/arm/boot/dts/rockchip/rk3128-xpi-3128.dts
+++ b/arch/arm/boot/dts/rockchip/rk3128-xpi-3128.dts
@@ -38,7 +38,7 @@ button-recovery {
 		};
 	};

-	dc_5v: dc-5v-regulator {
+	dc_5v: regulator-dc-5v {
 		compatible = "regulator-fixed";
 		regulator-name = "DC_5V";
 		regulator-min-microvolt = <5000000>;
@@ -62,7 +62,7 @@ hdmi_connector_in: endpoint {
 	 * This is a vbus-supply, which also supplies the GL852G usb hub,
 	 * thus has to be always-on
 	 */
-	host_pwr_5v: host-pwr-5v-regulator {
+	host_pwr_5v: regulator-host-pwr-5v {
 		compatible = "regulator-fixed";
 		gpio = <&gpio3 RK_PC4 GPIO_ACTIVE_HIGH>;
 		startup-delay-us = <1500>;
@@ -111,7 +111,7 @@ led-spd {
 		};
 	};

-	mcu3v3: mcu3v3-regulator {
+	mcu3v3: regulator-mcu3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "MCU3V3";
 		regulator-min-microvolt = <3300000>;
@@ -121,7 +121,7 @@ mcu3v3: mcu3v3-regulator {
 		regulator-boot-on;
 	};

-	vcc_ddr: vcc-ddr-regulator {
+	vcc_ddr: regulator-vcc-ddr {
 		compatible = "regulator-fixed";
 		regulator-name = "VCC_DDR";
 		regulator-min-microvolt = <1500000>;
@@ -131,7 +131,7 @@ vcc_ddr: vcc-ddr-regulator {
 		regulator-boot-on;
 	};

-	vcc_io: vcc-io-regulator {
+	vcc_io: regulator-vcc-io {
 		compatible = "regulator-fixed";
 		regulator-name = "VCC_IO";
 		regulator-min-microvolt = <3300000>;
@@ -141,7 +141,7 @@ vcc_io: vcc-io-regulator {
 		regulator-boot-on;
 	};

-	vcc_lan: vcc-lan-regulator {
+	vcc_lan: regulator-vcc-lan {
 		compatible = "regulator-fixed";
 		regulator-name = "VCC_LAN";
 		regulator-min-microvolt = <3300000>;
@@ -151,7 +151,7 @@ vcc_lan: vcc-lan-regulator {
 		regulator-boot-on;
 	};

-	vcc_sd: vcc-sd-regulator {
+	vcc_sd: regulator-vcc-sd {
 		compatible = "regulator-fixed";
 		gpio = <&gpio1 RK_PB6 GPIO_ACTIVE_LOW>;
 		startup-delay-us = <500>;
@@ -163,7 +163,7 @@ vcc_sd: vcc-sd-regulator {
 		pinctrl-0 = <&sdmmc_pwren>;
 	};

-	vcc_sys: vcc-sys-regulator {
+	vcc_sys: regulator-vcc-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "VCC_SYS";
 		regulator-min-microvolt = <5000000>;
@@ -173,7 +173,7 @@ vcc_sys: vcc-sys-regulator {
 		regulator-boot-on;
 	};

-	vcc33_hdmi: vcc33-hdmi-regulator {
+	vcc33_hdmi: regulator-vcc33-hdmi {
 		compatible = "regulator-fixed";
 		regulator-name = "VCC33_HDMI";
 		regulator-min-microvolt = <3300000>;
@@ -183,7 +183,7 @@ vcc33_hdmi: vcc33-hdmi-regulator {
 		regulator-boot-on;
 	};

-	vcca_33: vcca-33-regulator {
+	vcca_33: regulator-vcca-33 {
 		compatible = "regulator-fixed";
 		regulator-name = "VCCA_33";
 		regulator-min-microvolt = <3300000>;
@@ -193,7 +193,7 @@ vcca_33: vcca-33-regulator {
 		regulator-boot-on;
 	};

-	vdd_11: vdd-11-regulator {
+	vdd_11: regulator-vdd-11 {
 		compatible = "regulator-fixed";
 		regulator-name = "VDD_11";
 		regulator-min-microvolt = <1100000>;
@@ -203,7 +203,7 @@ vdd_11: vdd-11-regulator {
 		regulator-boot-on;
 	};

-	vdd11_hdmi: vdd11-hdmi-regulator {
+	vdd11_hdmi: regulator-vdd11-hdmi {
 		compatible = "regulator-fixed";
 		regulator-name = "VDD11_HDMI";
 		regulator-min-microvolt = <1100000>;
@@ -213,7 +213,7 @@ vdd11_hdmi: vdd11-hdmi-regulator {
 		regulator-boot-on;
 	};

-	vdd_arm: vdd-arm-regulator {
+	vdd_arm: regulator-vdd-arm {
 		compatible = "pwm-regulator";
 		regulator-name = "VDD_ARM";
 		pwms = <&pwm1 0 25000 1>;
@@ -231,7 +231,7 @@ vdd_arm: vdd-arm-regulator {
 	 * driver does not implement regulator support we have to make
 	 * sure here that the voltage never drops below 1050 mV.
 	 */
-	vdd_log: vdd-log-regulator {
+	vdd_log: regulator-vdd-log {
 		compatible = "pwm-regulator";
 		regulator-name = "VDD_LOG";
 		pwms = <&pwm2 0 25000 1>;
diff --git a/arch/arm/boot/dts/rockchip/rk3188-bqedison2qc.dts b/arch/arm/boot/dts/rockchip/rk3188-bqedison2qc.dts
index 9312be362a7a..edc2b7f9112d 100644
--- a/arch/arm/boot/dts/rockchip/rk3188-bqedison2qc.dts
+++ b/arch/arm/boot/dts/rockchip/rk3188-bqedison2qc.dts
@@ -130,7 +130,7 @@ sdio_pwrseq: sdio-pwrseq {
 		reset-gpios = <&gpio3 RK_PD0 GPIO_ACTIVE_LOW>;
 	};

-	avdd_cif: cif-avdd-regulator {
+	avdd_cif: regulator-cif-avdd {
 		compatible = "regulator-fixed";
 		regulator-name = "avdd-cif";
 		regulator-min-microvolt = <2800000>;
@@ -142,7 +142,7 @@ avdd_cif: cif-avdd-regulator {
 		vin-supply = <&vcc28_cif>;
 	};

-	vcc_5v: vcc-5v-regulator {
+	vcc_5v: regulator-vcc-5v {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc-5v";
 		regulator-min-microvolt = <5000000>;
@@ -154,7 +154,7 @@ vcc_5v: vcc-5v-regulator {
 		vin-supply = <&vsys>;
 	};

-	vcc_lcd: lcd-regulator {
+	vcc_lcd: regulator-lcd {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc-lcd";
 		gpio = <&gpio0 RK_PB0 GPIO_ACTIVE_LOW>;
@@ -164,7 +164,7 @@ vcc_lcd: lcd-regulator {
 		vin-supply = <&vcc_io>;
 	};

-	vcc_otg: usb-otg-regulator {
+	vcc_otg: regulator-usb-otg {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc-otg";
 		regulator-min-microvolt = <5000000>;
@@ -177,7 +177,7 @@ vcc_otg: usb-otg-regulator {
 		vin-supply = <&vcc_5v>;
 	};

-	vcc_sd: sdmmc-regulator {
+	vcc_sd: regulator-sdmmc {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc-sd";
 		regulator-min-microvolt = <3300000>;
@@ -189,7 +189,7 @@ vcc_sd: sdmmc-regulator {
 		vin-supply = <&vcc_io>;
 	};

-	vccq_emmc: emmc-vccq-regulator {
+	vccq_emmc: regulator-emmc-vccq {
 		compatible = "regulator-fixed";
 		regulator-name = "vccq-emmc";
 		regulator-min-microvolt = <2800000>;
@@ -198,7 +198,7 @@ vccq_emmc: emmc-vccq-regulator {
 	};

 	/* supplied from the bq24196 */
-	vsys: vsys-regulator {
+	vsys: regulator-vsys {
 		compatible = "regulator-fixed";
 		regulator-name = "vsys";
 		regulator-min-microvolt = <5000000>;
diff --git a/arch/arm/boot/dts/rockchip/rk3188-px3-evb.dts b/arch/arm/boot/dts/rockchip/rk3188-px3-evb.dts
index 0a1ae689b162..32f36d7a7d28 100644
--- a/arch/arm/boot/dts/rockchip/rk3188-px3-evb.dts
+++ b/arch/arm/boot/dts/rockchip/rk3188-px3-evb.dts
@@ -39,7 +39,7 @@ key-power {
 		};
 	};

-	vcc_sys: vsys-regulator {
+	vcc_sys: regulator-vsys {
 		compatible = "regulator-fixed";
 		regulator-name = "vsys";
 		regulator-min-microvolt = <5000000>;
diff --git a/arch/arm/boot/dts/rockchip/rk3188-radxarock.dts b/arch/arm/boot/dts/rockchip/rk3188-radxarock.dts
index 118deacd38c4..1f31c0a6774f 100644
--- a/arch/arm/boot/dts/rockchip/rk3188-radxarock.dts
+++ b/arch/arm/boot/dts/rockchip/rk3188-radxarock.dts
@@ -78,7 +78,7 @@ ir_recv: ir-receiver {
 		pinctrl-0 = <&ir_recv_pin>;
 	};

-	vcc_otg: usb-otg-regulator {
+	vcc_otg: regulator-usb-otg {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio2 RK_PD7 GPIO_ACTIVE_HIGH>;
@@ -91,7 +91,7 @@ vcc_otg: usb-otg-regulator {
 		regulator-boot-on;
 	};

-	vcc_sd0: sdmmc-regulator {
+	vcc_sd0: regulator-sdmmc {
 		compatible = "regulator-fixed";
 		regulator-name = "sdmmc-supply";
 		regulator-min-microvolt = <3300000>;
@@ -103,7 +103,7 @@ vcc_sd0: sdmmc-regulator {
 		vin-supply = <&vcc_io>;
 	};

-	vcc_host: usb-host-regulator {
+	vcc_host: regulator-usb-host {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PA3 GPIO_ACTIVE_HIGH>;
@@ -116,7 +116,7 @@ vcc_host: usb-host-regulator {
 		regulator-boot-on;
 	};

-	vsys: vsys-regulator {
+	vsys: regulator-vsys {
 		compatible = "regulator-fixed";
 		regulator-name = "vsys";
 		regulator-min-microvolt = <5000000>;
diff --git a/arch/arm/boot/dts/rockchip/rk3228-evb.dts b/arch/arm/boot/dts/rockchip/rk3228-evb.dts
index 69a5e239ed1a..a450cf31a0be 100644
--- a/arch/arm/boot/dts/rockchip/rk3228-evb.dts
+++ b/arch/arm/boot/dts/rockchip/rk3228-evb.dts
@@ -17,7 +17,7 @@ memory@60000000 {
 		reg = <0x60000000 0x40000000>;
 	};

-	vcc_phy: vcc-phy-regulator {
+	vcc_phy: regulator-vcc-phy {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		regulator-name = "vcc_phy";
diff --git a/arch/arm/boot/dts/rockchip/rk3229-evb.dts b/arch/arm/boot/dts/rockchip/rk3229-evb.dts
index 5c3d08e3eea3..c35757d2b5dc 100644
--- a/arch/arm/boot/dts/rockchip/rk3229-evb.dts
+++ b/arch/arm/boot/dts/rockchip/rk3229-evb.dts
@@ -18,7 +18,7 @@ memory@60000000 {
 		reg = <0x60000000 0x40000000>;
 	};

-	dc_12v: dc-12v-regulator {
+	dc_12v: regulator-dc-12v {
 		compatible = "regulator-fixed";
 		regulator-name = "dc_12v";
 		regulator-always-on;
@@ -34,7 +34,7 @@ ext_gmac: ext_gmac {
 		#clock-cells = <0>;
 	};

-	vcc_host: vcc-host-regulator {
+	vcc_host: regulator-vcc-host {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio3 RK_PC4 GPIO_ACTIVE_HIGH>;
@@ -46,7 +46,7 @@ vcc_host: vcc-host-regulator {
 		vin-supply = <&vcc_sys>;
 	};

-	vcc_phy: vcc-phy-regulator {
+	vcc_phy: regulator-vcc-phy {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		regulator-name = "vcc_phy";
@@ -57,7 +57,7 @@ vcc_phy: vcc-phy-regulator {
 		vin-supply = <&vccio_1v8>;
 	};

-	vcc_sys: vcc-sys-regulator {
+	vcc_sys: regulator-vcc-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_sys";
 		regulator-always-on;
@@ -67,7 +67,7 @@ vcc_sys: vcc-sys-regulator {
 		vin-supply = <&dc_12v>;
 	};

-	vccio_1v8: vccio-1v8-regulator {
+	vccio_1v8: regulator-vccio-1v8 {
 		compatible = "regulator-fixed";
 		regulator-name = "vccio_1v8";
 		regulator-min-microvolt = <1800000>;
@@ -76,7 +76,7 @@ vccio_1v8: vccio-1v8-regulator {
 		vin-supply = <&vcc_sys>;
 	};

-	vccio_3v3: vccio-3v3-regulator {
+	vccio_3v3: regulator-vccio-3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "vccio_3v3";
 		regulator-min-microvolt = <3300000>;
@@ -85,7 +85,7 @@ vccio_3v3: vccio-3v3-regulator {
 		vin-supply = <&vcc_sys>;
 	};

-	vdd_arm: vdd-arm-regulator {
+	vdd_arm: regulator-vdd-arm {
 		compatible = "pwm-regulator";
 		pwms = <&pwm1 0 25000 1>;
 		pwm-supply = <&vcc_sys>;
@@ -96,7 +96,7 @@ vdd_arm: vdd-arm-regulator {
 		regulator-boot-on;
 	};

-	vdd_log: vdd-log-regulator {
+	vdd_log: regulator-vdd-log {
 		compatible = "pwm-regulator";
 		pwms = <&pwm2 0 25000 1>;
 		pwm-supply = <&vcc_sys>;
diff --git a/arch/arm/boot/dts/rockchip/rk3229-xms6.dts b/arch/arm/boot/dts/rockchip/rk3229-xms6.dts
index 7bfbfd11fb55..28333449c43a 100644
--- a/arch/arm/boot/dts/rockchip/rk3229-xms6.dts
+++ b/arch/arm/boot/dts/rockchip/rk3229-xms6.dts
@@ -20,7 +20,7 @@ memory@60000000 {
 		reg = <0x60000000 0x40000000>;
 	};

-	dc_12v: dc-12v-regulator {
+	dc_12v: regulator-dc-12v {
 		compatible = "regulator-fixed";
 		regulator-name = "dc_12v";
 		regulator-always-on;
@@ -51,7 +51,7 @@ sdio_pwrseq: sdio-pwrseq {
 		              <&gpio2 29 GPIO_ACTIVE_LOW>;
 	};

-	vcc_host: vcc-host-regulator {
+	vcc_host: regulator-vcc-host {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio3 RK_PC4 GPIO_ACTIVE_HIGH>;
@@ -63,7 +63,7 @@ vcc_host: vcc-host-regulator {
 		vin-supply = <&vcc_sys>;
 	};

-	vcc_phy: vcc-phy-regulator {
+	vcc_phy: regulator-vcc-phy {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		regulator-name = "vcc_phy";
@@ -74,7 +74,7 @@ vcc_phy: vcc-phy-regulator {
 		vin-supply = <&vccio_1v8>;
 	};

-	vcc_sys: vcc-sys-regulator {
+	vcc_sys: regulator-vcc-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_sys";
 		regulator-always-on;
@@ -84,7 +84,7 @@ vcc_sys: vcc-sys-regulator {
 		vin-supply = <&dc_12v>;
 	};

-	vccio_1v8: vccio-1v8-regulator {
+	vccio_1v8: regulator-vccio-1v8 {
 		compatible = "regulator-fixed";
 		regulator-name = "vccio_1v8";
 		regulator-min-microvolt = <1800000>;
@@ -93,7 +93,7 @@ vccio_1v8: vccio-1v8-regulator {
 		vin-supply = <&vcc_sys>;
 	};

-	vccio_3v3: vccio-3v3-regulator {
+	vccio_3v3: regulator-vccio-3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "vccio_3v3";
 		regulator-min-microvolt = <3300000>;
@@ -102,7 +102,7 @@ vccio_3v3: vccio-3v3-regulator {
 		vin-supply = <&vcc_sys>;
 	};

-	vdd_arm: vdd-arm-regulator {
+	vdd_arm: regulator-vdd-arm {
 		compatible = "pwm-regulator";
 		pwms = <&pwm1 0 25000 1>;
 		pwm-supply = <&vcc_sys>;
@@ -113,7 +113,7 @@ vdd_arm: vdd-arm-regulator {
 		regulator-boot-on;
 	};

-	vdd_log: vdd-log-regulator {
+	vdd_log: regulator-vdd-log {
 		compatible = "pwm-regulator";
 		pwms = <&pwm2 0 25000 1>;
 		pwm-supply = <&vcc_sys>;
diff --git a/arch/arm/boot/dts/rockchip/rk3288-evb-act8846.dts b/arch/arm/boot/dts/rockchip/rk3288-evb-act8846.dts
index 8a635c243127..e1821fadbe7a 100644
--- a/arch/arm/boot/dts/rockchip/rk3288-evb-act8846.dts
+++ b/arch/arm/boot/dts/rockchip/rk3288-evb-act8846.dts
@@ -7,7 +7,7 @@ / {
 	model = "Rockchip RK3288 EVB ACT8846";
 	compatible = "rockchip,rk3288-evb-act8846", "rockchip,rk3288";

-	vcc_lcd: vcc-lcd {
+	vcc_lcd: regulator-vcc-lcd {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio7 RK_PA3 GPIO_ACTIVE_HIGH>;
@@ -17,7 +17,7 @@ vcc_lcd: vcc-lcd {
 		vin-supply = <&vcc_io>;
 	};

-	vcc_wl: vcc-wl {
+	vcc_wl: regulator-vcc-wl {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio7 RK_PB1 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/boot/dts/rockchip/rk3288-evb.dtsi b/arch/arm/boot/dts/rockchip/rk3288-evb.dtsi
index 382d2839cf47..11bb970c6112 100644
--- a/arch/arm/boot/dts/rockchip/rk3288-evb.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3288-evb.dtsi
@@ -129,7 +129,7 @@ key-power {
 	};

 	/* This turns on USB vbus for both host0 (ehci) and host1 (dwc2) */
-	vcc_host: vcc-host-regulator {
+	vcc_host: regulator-vcc-host {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PB6 GPIO_ACTIVE_HIGH>;
@@ -140,7 +140,7 @@ vcc_host: vcc-host-regulator {
 		regulator-boot-on;
 	};

-	vcc_phy: vcc-phy-regulator {
+	vcc_phy: regulator-vcc-phy {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PA6 GPIO_ACTIVE_HIGH>;
@@ -153,7 +153,7 @@ vcc_phy: vcc-phy-regulator {
 		regulator-boot-on;
 	};

-	vcc_sys: vsys-regulator {
+	vcc_sys: regulator-vsys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_sys";
 		regulator-min-microvolt = <5000000>;
@@ -167,7 +167,7 @@ vcc_sys: vsys-regulator {
 	 * vcc_io directly.  Those boards won't be able to power cycle SD cards
 	 * but it shouldn't hurt to toggle this pin there anyway.
 	 */
-	vcc_sd: sdmmc-regulator {
+	vcc_sd: regulator-sdmmc {
 		compatible = "regulator-fixed";
 		gpio = <&gpio7 RK_PB3 GPIO_ACTIVE_LOW>;
 		pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/rockchip/rk3288-firefly-reload-core.dtsi b/arch/arm/boot/dts/rockchip/rk3288-firefly-reload-core.dtsi
index 36efa36b7190..59029483741b 100644
--- a/arch/arm/boot/dts/rockchip/rk3288-firefly-reload-core.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3288-firefly-reload-core.dtsi
@@ -21,7 +21,7 @@ ext_gmac: external-gmac-clock {
 	};


-	vcc_flash: flash-regulator {
+	vcc_flash: regulator-flash {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_flash";
 		regulator-min-microvolt = <1800000>;
diff --git a/arch/arm/boot/dts/rockchip/rk3288-firefly-reload.dts b/arch/arm/boot/dts/rockchip/rk3288-firefly-reload.dts
index a5a0826341e6..a55270672732 100644
--- a/arch/arm/boot/dts/rockchip/rk3288-firefly-reload.dts
+++ b/arch/arm/boot/dts/rockchip/rk3288-firefly-reload.dts
@@ -85,7 +85,7 @@ spdif_out: spdif-out {
 		#sound-dai-cells = <0>;
 	};

-	vcc_host_5v: usb-host-regulator {
+	vcc_host_5v: regulator-usb-host {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PB6 GPIO_ACTIVE_HIGH>;
@@ -98,7 +98,7 @@ vcc_host_5v: usb-host-regulator {
 		vin-supply = <&vcc_5v>;
 	};

-	vcc_5v: vcc_sys: vsys-regulator {
+	vcc_5v: vcc_sys: regulator-vsys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_5v";
 		regulator-min-microvolt = <5000000>;
@@ -107,7 +107,7 @@ vcc_5v: vcc_sys: vsys-regulator {
 		regulator-boot-on;
 	};

-	vcc_sd: sdmmc-regulator {
+	vcc_sd: regulator-sdmmc {
 		compatible = "regulator-fixed";
 		gpio = <&gpio7 RK_PB3 GPIO_ACTIVE_LOW>;
 		pinctrl-names = "default";
@@ -119,7 +119,7 @@ vcc_sd: sdmmc-regulator {
 		vin-supply = <&vcc_io>;
 	};

-	vcc_otg_5v: usb-otg-regulator {
+	vcc_otg_5v: regulator-usb-otg {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PB4 GPIO_ACTIVE_HIGH>;
@@ -132,7 +132,7 @@ vcc_otg_5v: usb-otg-regulator {
 		vin-supply = <&vcc_5v>;
 	};

-	dovdd_1v8: dovdd-1v8-regulator {
+	dovdd_1v8: regulator-dovdd-1v8 {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PB3 GPIO_ACTIVE_HIGH>;
@@ -144,7 +144,7 @@ dovdd_1v8: dovdd-1v8-regulator {
 		vin-supply = <&vcc_io>;
 	};

-	vcc28_dvp: vcc28-dvp-regulator {
+	vcc28_dvp: regulator-vcc28-dvp {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PB3 GPIO_ACTIVE_HIGH>;
@@ -156,7 +156,7 @@ vcc28_dvp: vcc28-dvp-regulator {
 		vin-supply = <&vcc_io>;
 	};

-	af_28: af_28-regulator {
+	af_28: regulator-af-28 {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PB3 GPIO_ACTIVE_HIGH>;
@@ -168,7 +168,7 @@ af_28: af_28-regulator {
 		vin-supply = <&vcc_io>;
 	};

-	dvdd_1v2: af_28-regulator {
+	dvdd_1v2: regulator-dvdd-1v2 {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio7 RK_PB4 GPIO_ACTIVE_HIGH>;
@@ -180,7 +180,7 @@ dvdd_1v2: af_28-regulator {
 		vin-supply = <&vcc_io>;
 	};

-	vbat_wl: wifi-regulator {
+	vbat_wl: regulator-wifi {
 		compatible = "regulator-fixed";
 		regulator-name = "vbat_wl";
 		regulator-min-microvolt = <3300000>;
diff --git a/arch/arm/boot/dts/rockchip/rk3288-firefly.dtsi b/arch/arm/boot/dts/rockchip/rk3288-firefly.dtsi
index 3836c61cfb76..187d4f0a52eb 100644
--- a/arch/arm/boot/dts/rockchip/rk3288-firefly.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3288-firefly.dtsi
@@ -25,7 +25,7 @@ button-recovery {
 		};
 	};

-	dovdd_1v8: dovdd-1v8-regulator {
+	dovdd_1v8: regulator-dovdd-1v8 {
 		compatible = "regulator-fixed";
 		regulator-name = "dovdd_1v8";
 		regulator-min-microvolt = <1800000>;
@@ -79,7 +79,7 @@ power_led: led-1 {
 		};
 	};

-	vbat_wl: vcc_sys: vsys-regulator {
+	vbat_wl: vcc_sys:  regulator-vsys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_sys";
 		regulator-min-microvolt = <5000000>;
@@ -88,7 +88,7 @@ vbat_wl: vcc_sys: vsys-regulator {
 		regulator-boot-on;
 	};

-	vcc_sd: sdmmc-regulator {
+	vcc_sd: regulator-sdmmc {
 		compatible = "regulator-fixed";
 		gpio = <&gpio7 RK_PB3 GPIO_ACTIVE_LOW>;
 		pinctrl-names = "default";
@@ -100,7 +100,7 @@ vcc_sd: sdmmc-regulator {
 		vin-supply = <&vcc_io>;
 	};

-	vcc_flash: flash-regulator {
+	vcc_flash: regulator-flash {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_flash";
 		regulator-min-microvolt = <1800000>;
@@ -108,7 +108,7 @@ vcc_flash: flash-regulator {
 		vin-supply = <&vcc_io>;
 	};

-	vcc_5v: usb-regulator {
+	vcc_5v: regulator-usb {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_5v";
 		regulator-min-microvolt = <5000000>;
@@ -118,7 +118,7 @@ vcc_5v: usb-regulator {
 		vin-supply = <&vcc_sys>;
 	};

-	vcc_host_5v: usb-host-regulator {
+	vcc_host_5v: regulator-usb-host {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PB6 GPIO_ACTIVE_HIGH>;
@@ -131,7 +131,7 @@ vcc_host_5v: usb-host-regulator {
 		vin-supply = <&vcc_5v>;
 	};

-	vcc_otg_5v: usb-otg-regulator {
+	vcc_otg_5v: regulator-usb-otg {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PB4 GPIO_ACTIVE_HIGH>;
@@ -148,7 +148,7 @@ vcc_otg_5v: usb-otg-regulator {
 	 * A TT8142 creates both dovdd_1v8 and vcc28_dvp, controlled
 	 * by the dvp_pwr pin.
 	 */
-	vcc28_dvp: vcc28-dvp-regulator {
+	vcc28_dvp: regulator-vcc28-dvp {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PB3 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/boot/dts/rockchip/rk3288-miqi.dts b/arch/arm/boot/dts/rockchip/rk3288-miqi.dts
index db1eb648e0e1..dd42f8d31f70 100644
--- a/arch/arm/boot/dts/rockchip/rk3288-miqi.dts
+++ b/arch/arm/boot/dts/rockchip/rk3288-miqi.dts
@@ -37,7 +37,7 @@ work_led: led-0 {
 		};
 	};

-	vcc_flash: flash-regulator {
+	vcc_flash: regulator-flash {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_flash";
 		regulator-min-microvolt = <1800000>;
@@ -45,7 +45,7 @@ vcc_flash: flash-regulator {
 		vin-supply = <&vcc_io>;
 	};

-	vcc_host: usb-host-regulator {
+	vcc_host: regulator-usb-host {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PB6 GPIO_ACTIVE_HIGH>;
@@ -58,7 +58,7 @@ vcc_host: usb-host-regulator {
 		vin-supply = <&vcc_sys>;
 	};

-	vcc_sd: sdmmc-regulator {
+	vcc_sd: regulator-sdmmc {
 		compatible = "regulator-fixed";
 		gpio = <&gpio7 RK_PB3 GPIO_ACTIVE_LOW>;
 		pinctrl-names = "default";
@@ -70,7 +70,7 @@ vcc_sd: sdmmc-regulator {
 		vin-supply = <&vcc_io>;
 	};

-	vcc_sys: vsys-regulator {
+	vcc_sys: regulator-vsys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_sys";
 		regulator-min-microvolt = <5000000>;
diff --git a/arch/arm/boot/dts/rockchip/rk3288-phycore-rdk.dts b/arch/arm/boot/dts/rockchip/rk3288-phycore-rdk.dts
index 1a5156951492..10ce0554d4fc 100644
--- a/arch/arm/boot/dts/rockchip/rk3288-phycore-rdk.dts
+++ b/arch/arm/boot/dts/rockchip/rk3288-phycore-rdk.dts
@@ -35,7 +35,7 @@ button-1 {
 		};
 	};

-	vcc_host0_5v: usb-host0-regulator {
+	vcc_host0_5v: regulator-usb-host0 {
 		compatible = "regulator-fixed";
 		gpio = <&gpio2 13 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
@@ -47,7 +47,7 @@ vcc_host0_5v: usb-host0-regulator {
 		vin-supply = <&vdd_in_otg_out>;
 	};

-	vcc_host1_5v: usb-host1-regulator {
+	vcc_host1_5v: regulator-usb-host1 {
 		compatible = "regulator-fixed";
 		gpio = <&gpio2 0 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
@@ -59,7 +59,7 @@ vcc_host1_5v: usb-host1-regulator {
 		vin-supply = <&vdd_in_otg_out>;
 	};

-	vcc_otg_5v: usb-otg-regulator {
+	vcc_otg_5v: regulator-usb-otg {
 		compatible = "regulator-fixed";
 		gpio = <&gpio2 12 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/rockchip/rk3288-phycore-som.dtsi b/arch/arm/boot/dts/rockchip/rk3288-phycore-som.dtsi
index e43887c9635f..12ab10c4adde 100644
--- a/arch/arm/boot/dts/rockchip/rk3288-phycore-som.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3288-phycore-som.dtsi
@@ -46,7 +46,7 @@ user_led: led-0 {
 		};
 	};

-	vdd_emmc_io: vdd-emmc-io {
+	vdd_emmc_io: regulator-vdd-emmc-io {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_emmc_io";
 		regulator-min-microvolt = <1800000>;
@@ -54,7 +54,7 @@ vdd_emmc_io: vdd-emmc-io {
 		vin-supply = <&vdd_3v3_io>;
 	};

-	vdd_in_otg_out: vdd-in-otg-out {
+	vdd_in_otg_out: regulator-vdd-in-otg-out {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_in_otg_out";
 		regulator-always-on;
@@ -63,7 +63,7 @@ vdd_in_otg_out: vdd-in-otg-out {
 		regulator-max-microvolt = <5000000>;
 	};

-	vdd_misc_1v8: vdd-misc-1v8 {
+	vdd_misc_1v8: regulator-vdd-misc-1v8 {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_misc_1v8";
 		regulator-always-on;
diff --git a/arch/arm/boot/dts/rockchip/rk3288-popmetal.dts b/arch/arm/boot/dts/rockchip/rk3288-popmetal.dts
index fd90f3b8fc32..560bc23c33b1 100644
--- a/arch/arm/boot/dts/rockchip/rk3288-popmetal.dts
+++ b/arch/arm/boot/dts/rockchip/rk3288-popmetal.dts
@@ -47,7 +47,7 @@ ir: ir-receiver {
 		pinctrl-0 = <&ir_int>;
 	};

-	vcc_flash: flash-regulator {
+	vcc_flash: regulator-flash {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_flash";
 		regulator-min-microvolt = <1800000>;
@@ -55,7 +55,7 @@ vcc_flash: flash-regulator {
 		vin-supply = <&vcc_io>;
 	};

-	vcc_sd: sdmmc-regulator {
+	vcc_sd: regulator-sdmmc {
 		compatible = "regulator-fixed";
 		gpio = <&gpio7 RK_PB3 GPIO_ACTIVE_LOW>;
 		pinctrl-names = "default";
@@ -67,7 +67,7 @@ vcc_sd: sdmmc-regulator {
 		vin-supply = <&vcc_io>;
 	};

-	vcc_sys: vsys-regulator {
+	vcc_sys: regulator-vsys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_sys";
 		regulator-min-microvolt = <5000000>;
@@ -80,7 +80,7 @@ vcc_sys: vsys-regulator {
 	 * A PT5128 creates both dovdd_1v8 and vcc28_dvp, controlled
 	 * by the dvp_pwr pin.
 	 */
-	vcc18_dvp: vcc18-dvp-regulator {
+	vcc18_dvp: regulator-vcc18-dvp {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc18-dvp";
 		regulator-min-microvolt = <1800000>;
@@ -88,7 +88,7 @@ vcc18_dvp: vcc18-dvp-regulator {
 		vin-supply = <&vcc28_dvp>;
 	};

-	vcc28_dvp: vcc28-dvp-regulator {
+	vcc28_dvp: regulator-vcc28-dvp {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PC1 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/boot/dts/rockchip/rk3288-r89.dts b/arch/arm/boot/dts/rockchip/rk3288-r89.dts
index 633e5a032463..40c65dbfb1cd 100644
--- a/arch/arm/boot/dts/rockchip/rk3288-r89.dts
+++ b/arch/arm/boot/dts/rockchip/rk3288-r89.dts
@@ -48,7 +48,7 @@ ir: ir-receiver {
 		pinctrl-0 = <&ir_int>;
 	};

-	vcc_host: vcc-host-regulator {
+	vcc_host: regulator-vcc-host {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PB6 GPIO_ACTIVE_HIGH>;
@@ -59,7 +59,7 @@ vcc_host: vcc-host-regulator {
 		regulator-boot-on;
 	};

-	vcc_otg: vcc-otg-regulator {
+	vcc_otg: regulator-vcc-otg {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PB4 GPIO_ACTIVE_HIGH>;
@@ -70,7 +70,7 @@ vcc_otg: vcc-otg-regulator {
 		regulator-boot-on;
 	};

-	vcc_sdmmc: sdmmc-regulator {
+	vcc_sdmmc: regulator-sdmmc {
 		compatible = "regulator-fixed";
 		regulator-name = "sdmmc-supply";
 		regulator-min-microvolt = <3300000>;
@@ -80,7 +80,7 @@ vcc_sdmmc: sdmmc-regulator {
 		vin-supply = <&vcc_io>;
 	};

-	vcc_sys: sys-regulator {
+	vcc_sys: regulator-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "sys-supply";
 		regulator-min-microvolt = <5000000>;
diff --git a/arch/arm/boot/dts/rockchip/rk3288-rock2-som.dtsi b/arch/arm/boot/dts/rockchip/rk3288-rock2-som.dtsi
index 76363b8afcb9..30f914f22a50 100644
--- a/arch/arm/boot/dts/rockchip/rk3288-rock2-som.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3288-rock2-som.dtsi
@@ -23,7 +23,7 @@ ext_gmac: external-gmac-clock {
 		clock-output-names = "ext_gmac";
 	};

-	vcc_flash: flash-regulator {
+	vcc_flash: regulator-flash {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_flash";
 		regulator-min-microvolt = <1800000>;
@@ -32,7 +32,7 @@ vcc_flash: flash-regulator {
 		vin-supply = <&vcc_io>;
 	};

-	vcc_sys: vsys-regulator {
+	vcc_sys: regulator-vsys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_sys";
 		regulator-min-microvolt = <5000000>;
diff --git a/arch/arm/boot/dts/rockchip/rk3288-rock2-square.dts b/arch/arm/boot/dts/rockchip/rk3288-rock2-square.dts
index 13cfdaa95cc7..58a7270b87da 100644
--- a/arch/arm/boot/dts/rockchip/rk3288-rock2-square.dts
+++ b/arch/arm/boot/dts/rockchip/rk3288-rock2-square.dts
@@ -70,7 +70,7 @@ simple-audio-card,dai-link@1 {  /* S/PDIF - S/PDIF */
 		};
 	};

-	sata_pwr: sata-prw-regulator {
+	sata_pwr: regulator-sata-prw {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 13 GPIO_ACTIVE_HIGH>;
@@ -108,7 +108,7 @@ sdio_pwrseq: sdio-pwrseq {
 		reset-gpios = <&gpio4 RK_PD4 GPIO_ACTIVE_LOW>;
 	};

-	vcc_usb_host: vcc-host-regulator {
+	vcc_usb_host: regulator-vcc-host {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PB6 GPIO_ACTIVE_HIGH>;
@@ -117,7 +117,7 @@ vcc_usb_host: vcc-host-regulator {
 		regulator-name = "vcc_host";
 	};

-	vcc_sd: sdmmc-regulator {
+	vcc_sd: regulator-sdmmc {
 		compatible = "regulator-fixed";
 		gpio = <&gpio7 RK_PB3 GPIO_ACTIVE_LOW>;
 		pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/rockchip/rk3288-tinker.dtsi b/arch/arm/boot/dts/rockchip/rk3288-tinker.dtsi
index 09618bb7d872..8e27a20f2845 100644
--- a/arch/arm/boot/dts/rockchip/rk3288-tinker.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3288-tinker.dtsi
@@ -85,7 +85,7 @@ simple-audio-card,cpu {
 		};
 	};

-	vcc_sys: vsys-regulator {
+	vcc_sys: regulator-vsys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_sys";
 		regulator-min-microvolt = <5000000>;
@@ -94,7 +94,7 @@ vcc_sys: vsys-regulator {
 		regulator-boot-on;
 	};

-	vcc_sd: sdmmc-regulator {
+	vcc_sd: regulator-sdmmc {
 		compatible = "regulator-fixed";
 		gpio = <&gpio7 11 GPIO_ACTIVE_LOW>;
 		pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/rockchip/rk3288-veyron-brain.dts b/arch/arm/boot/dts/rockchip/rk3288-veyron-brain.dts
index aa33d09184ad..ade9cc291813 100644
--- a/arch/arm/boot/dts/rockchip/rk3288-veyron-brain.dts
+++ b/arch/arm/boot/dts/rockchip/rk3288-veyron-brain.dts
@@ -14,11 +14,11 @@ / {
 	compatible = "google,veyron-brain-rev0", "google,veyron-brain",
 		     "google,veyron", "rockchip,rk3288";

-	vcc33_sys: vcc33-sys {
+	vcc33_sys: regulator-vcc33-sys {
 		vin-supply = <&vcc_5v>;
 	};

-	vcc33_io: vcc33_io {
+	vcc33_io: regulator-vcc33-io {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc33_io";
 		regulator-always-on;
@@ -28,7 +28,7 @@ vcc33_io: vcc33_io {
 	};

 	/* This turns on vbus for host2 and otg (dwc2) */
-	vcc5_host2: vcc5-host2-regulator {
+	vcc5_host2: regulator-vcc5-host2 {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PB4 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/boot/dts/rockchip/rk3288-veyron-chromebook.dtsi b/arch/arm/boot/dts/rockchip/rk3288-veyron-chromebook.dtsi
index 092316be67f7..3677571b4d82 100644
--- a/arch/arm/boot/dts/rockchip/rk3288-veyron-chromebook.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3288-veyron-chromebook.dtsi
@@ -43,23 +43,23 @@ switch-lid {
 	};

 	/* A non-regulated voltage from power supply or battery */
-	vccsys: vccsys {
+	vccsys: regulator-vccsys {
 		compatible = "regulator-fixed";
 		regulator-name = "vccsys";
 		regulator-boot-on;
 		regulator-always-on;
 	};

-	vcc33_sys: vcc33-sys {
+	vcc33_sys: regulator-vcc33-sys {
 		vin-supply = <&vccsys>;
 	};

-	vcc_5v: vcc-5v {
+	vcc_5v: regulator-vcc-5v {
 		vin-supply = <&vccsys>;
 	};

 	/* This turns on vbus for host1 (dwc2) */
-	vcc5_host1: vcc5-host1-regulator {
+	vcc5_host1: regulator-vcc5-host1 {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PB3 GPIO_ACTIVE_HIGH>;
@@ -71,7 +71,7 @@ vcc5_host1: vcc5-host1-regulator {
 	};

 	/* This turns on vbus for otg for host mode (dwc2) */
-	vcc5v_otg: vcc5v-otg-regulator {
+	vcc5v_otg: regulator-vcc5v-otg {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PB4 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/boot/dts/rockchip/rk3288-veyron-fievel.dts b/arch/arm/boot/dts/rockchip/rk3288-veyron-fievel.dts
index 309b122b4d0d..6a0844e16279 100644
--- a/arch/arm/boot/dts/rockchip/rk3288-veyron-fievel.dts
+++ b/arch/arm/boot/dts/rockchip/rk3288-veyron-fievel.dts
@@ -18,7 +18,7 @@ / {
 		     "google,veyron-fievel-rev0", "google,veyron-fievel",
 		     "google,veyron", "rockchip,rk3288";

-	vccsys: vccsys {
+	vccsys: regulator-vccsys {
 		compatible = "regulator-fixed";
 		regulator-name = "vccsys";
 		regulator-boot-on;
@@ -29,14 +29,14 @@ vccsys: vccsys {
 	 * vcc33_pmuio and vcc33_io is sourced directly from vcc33_sys,
 	 * enabled by vcc_18
 	 */
-	vcc33_io: vcc33-io {
+	vcc33_io: regulator-vcc33-io {
 		compatible = "regulator-fixed";
 		regulator-always-on;
 		regulator-boot-on;
 		regulator-name = "vcc33_io";
 	};

-	vcc5_host1: vcc5-host1-regulator {
+	vcc5_host1: regulator-vcc5-host1 {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio5 RK_PC2 GPIO_ACTIVE_HIGH>;
@@ -47,7 +47,7 @@ vcc5_host1: vcc5-host1-regulator {
 		regulator-boot-on;
 	};

-	vcc5_host2: vcc5-host2-regulator {
+	vcc5_host2: regulator-vcc5-host2 {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio5 RK_PB6 GPIO_ACTIVE_HIGH>;
@@ -58,7 +58,7 @@ vcc5_host2: vcc5-host2-regulator {
 		regulator-boot-on;
 	};

-	vcc5v_otg: vcc5v-otg-regulator {
+	vcc5v_otg: regulator-vcc5v-otg {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PB4 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/boot/dts/rockchip/rk3288-veyron-mickey.dts b/arch/arm/boot/dts/rockchip/rk3288-veyron-mickey.dts
index ffd1121d19be..d665c3e8862c 100644
--- a/arch/arm/boot/dts/rockchip/rk3288-veyron-mickey.dts
+++ b/arch/arm/boot/dts/rockchip/rk3288-veyron-mickey.dts
@@ -18,11 +18,11 @@ / {
 		     "google,veyron-mickey-rev0", "google,veyron-mickey",
 		     "google,veyron", "rockchip,rk3288";

-	vcc_5v: vcc-5v {
+	vcc_5v: regulator-vcc-5v {
 		vin-supply = <&vcc33_sys>;
 	};

-	vcc33_io: vcc33_io {
+	vcc33_io: regulator-vcc33-io {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc33_io";
 		regulator-always-on;
diff --git a/arch/arm/boot/dts/rockchip/rk3288-veyron.dtsi b/arch/arm/boot/dts/rockchip/rk3288-veyron.dtsi
index d838bf0d5d9a..260d6c92cfd1 100644
--- a/arch/arm/boot/dts/rockchip/rk3288-veyron.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3288-veyron.dtsi
@@ -75,7 +75,7 @@ sdio_pwrseq: sdio-pwrseq {
 		reset-gpios = <&gpio4 RK_PD4 GPIO_ACTIVE_LOW>;
 	};

-	vcc_5v: vcc-5v {
+	vcc_5v: regulator-vcc-5v {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_5v";
 		regulator-always-on;
@@ -84,7 +84,7 @@ vcc_5v: vcc-5v {
 		regulator-max-microvolt = <5000000>;
 	};

-	vcc33_sys: vcc33-sys {
+	vcc33_sys: regulator-vcc33-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc33_sys";
 		regulator-always-on;
@@ -93,7 +93,7 @@ vcc33_sys: vcc33-sys {
 		regulator-max-microvolt = <3300000>;
 	};

-	vcc50_hdmi: vcc50-hdmi {
+	vcc50_hdmi: regulator-vcc50-hdmi {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc50_hdmi";
 		regulator-always-on;
@@ -101,7 +101,7 @@ vcc50_hdmi: vcc50-hdmi {
 		vin-supply = <&vcc_5v>;
 	};

-	vdd_logic: vdd-logic {
+	vdd_logic: regulator-vdd-logic {
 		compatible = "pwm-regulator";
 		regulator-name = "vdd_logic";

diff --git a/arch/arm/boot/dts/rockchip/rk3288-vmarc-som.dtsi b/arch/arm/boot/dts/rockchip/rk3288-vmarc-som.dtsi
index 793951655b73..44a9efc68f42 100644
--- a/arch/arm/boot/dts/rockchip/rk3288-vmarc-som.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3288-vmarc-som.dtsi
@@ -11,7 +11,7 @@
 / {
 	compatible = "vamrs,rk3288-vmarc-som", "rockchip,rk3288";

-	vccio_flash: vccio-flash-regulator {
+	vccio_flash: regulator-vccio-flash {
 		compatible = "regulator-fixed";
 		regulator-name = "vccio_flash";
 		regulator-min-microvolt = <1800000>;
diff --git a/arch/arm/boot/dts/rockchip/rk3288-vyasa.dts b/arch/arm/boot/dts/rockchip/rk3288-vyasa.dts
index b156a83eb7d7..1954475c69b6 100644
--- a/arch/arm/boot/dts/rockchip/rk3288-vyasa.dts
+++ b/arch/arm/boot/dts/rockchip/rk3288-vyasa.dts
@@ -19,7 +19,7 @@ memory {
 		device_type = "memory";
 	};

-	dc12_vbat: dc12-vbat {
+	dc12_vbat: regulator-dc12-vbat {
 		compatible = "regulator-fixed";
 		regulator-name = "dc12_vbat";
 		regulator-min-microvolt = <12000000>;
@@ -28,7 +28,7 @@ dc12_vbat: dc12-vbat {
 		regulator-boot-on;
 	};

-	vboot_3v3: vboot-3v3 {
+	vboot_3v3: regulator-vboot-3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "vboot_3v3";
 		regulator-min-microvolt = <3300000>;
@@ -38,7 +38,7 @@ vboot_3v3: vboot-3v3 {
 		vin-supply = <&dc12_vbat>;
 	};

-	vcc_sys: vsys-regulator {
+	vcc_sys: regulator-vsys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_sys";
 		regulator-min-microvolt = <3700000>;
@@ -48,7 +48,7 @@ vcc_sys: vsys-regulator {
 		vin-supply = <&dc12_vbat>;
 	};

-	vboot_5v: vboot-5v {
+	vboot_5v: regulator-vboot-5v {
 		compatible = "regulator-fixed";
 		regulator-name = "vboot_sv";
 		regulator-min-microvolt = <5000000>;
@@ -58,7 +58,7 @@ vboot_5v: vboot-5v {
 		vin-supply = <&dc12_vbat>;
 	};

-	v3g_3v3: v3g-3v3 {
+	v3g_3v3: regulator-v3g-3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "v3g_3v3";
 		regulator-min-microvolt = <3300000>;
@@ -68,7 +68,7 @@ v3g_3v3: v3g-3v3 {
 		vin-supply = <&dc12_vbat>;
 	};

-	vsus_5v: vsus-5v {
+	vsus_5v: regulator-vsus-5v {
 		compatible = "regulator-fixed";
 		regulator-name = "vsus_5v";
 		regulator-min-microvolt = <5000000>;
@@ -78,7 +78,7 @@ vsus_5v: vsus-5v {
 		vin-supply = <&vcc_io>;
 	};

-	vcc50_hdmi: vcc50-hdmi {
+	vcc50_hdmi: regulator-vcc50-hdmi {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc50_hdmi";
 		enable-active-high;
@@ -90,7 +90,7 @@ vcc50_hdmi: vcc50-hdmi {
 		vin-supply = <&vsus_5v>;
 	};

-	vusb1_5v: vusb1-5v {
+	vusb1_5v: regulator-vusb1-5v {
 		compatible = "regulator-fixed";
 		regulator-name = "vusb1_5v";
 		enable-active-high;
@@ -102,7 +102,7 @@ vusb1_5v: vusb1-5v {
 		vin-supply = <&vsus_5v>;
 	};

-	vusb2_5v: vusb2-5v {
+	vusb2_5v: regulator-vusb2-5v {
 		compatible = "regulator-fixed";
 		regulator-name = "vusb2_5v";
 		enable-active-high;
diff --git a/arch/arm/boot/dts/rockchip/rockchip-radxa-dalang-carrier.dtsi b/arch/arm/boot/dts/rockchip/rockchip-radxa-dalang-carrier.dtsi
index da1d548b7330..cf5e2ed356ef 100644
--- a/arch/arm/boot/dts/rockchip/rockchip-radxa-dalang-carrier.dtsi
+++ b/arch/arm/boot/dts/rockchip/rockchip-radxa-dalang-carrier.dtsi
@@ -23,7 +23,7 @@ sdio_pwrseq: sdio-pwrseq {
 		pinctrl-0 = <&wifi_enable_h>;
 	};

-	vcc12v_dcin: vcc12v-dcin-regulator {
+	vcc12v_dcin: regulator-vcc12v-dcin {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc12v_dcin";
 		regulator-always-on;
@@ -32,7 +32,7 @@ vcc12v_dcin: vcc12v-dcin-regulator {
 		regulator-max-microvolt = <12000000>;
 	};

-	vcc5v0_sys: vcc5v0-sys-regulator {
+	vcc5v0_sys: regulator-vcc5v0-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_sys";
 		regulator-always-on;
@@ -42,7 +42,7 @@ vcc5v0_sys: vcc5v0-sys-regulator {
 		vin-supply = <&vcc12v_dcin>;
 	};

-	vbus_host: vbus-host {
+	vbus_host: regulator-vbus-host {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
 		pinctrl-0 = <&usb1_en_oc>;
@@ -51,7 +51,7 @@ vbus_host: vbus-host {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vbus_typec: vbus-typec {
+	vbus_typec: regulator-vbus-typec {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
 		pinctrl-0 = <&usb0_en_oc>;
diff --git a/arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dts b/arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dts
index 89ca2f8d3809..3c64f0cca9eb 100644
--- a/arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dts
+++ b/arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dts
@@ -25,7 +25,7 @@ chosen {
 		stdout-path = "serial2:1500000n8";
 	};

-	vcc_sys: vsys-regulator {
+	vcc_sys: regulator-vsys {
 		compatible = "regulator-fixed";
 		regulator-name = "vsys";
 		regulator-min-microvolt = <5000000>;
diff --git a/arch/arm/boot/dts/rockchip/rv1108-evb.dts b/arch/arm/boot/dts/rockchip/rv1108-evb.dts
index ef150f4ee99d..0b04a8325d54 100644
--- a/arch/arm/boot/dts/rockchip/rv1108-evb.dts
+++ b/arch/arm/boot/dts/rockchip/rv1108-evb.dts
@@ -60,7 +60,7 @@ backlight: backlight {
 		pwms = <&pwm0 0 25000 0>;
 	};

-	vcc_sys: vsys-regulator {
+	vcc_sys: regulator-vsys {
 		compatible = "regulator-fixed";
 		regulator-name = "vsys";
 		regulator-min-microvolt = <5000000>;
diff --git a/arch/arm/boot/dts/rockchip/rv1126-edgeble-neu2-io.dts b/arch/arm/boot/dts/rockchip/rv1126-edgeble-neu2-io.dts
index 7707d1b01440..d4e93d7c57a6 100644
--- a/arch/arm/boot/dts/rockchip/rv1126-edgeble-neu2-io.dts
+++ b/arch/arm/boot/dts/rockchip/rv1126-edgeble-neu2-io.dts
@@ -21,7 +21,7 @@ chosen {
 		stdout-path = "serial2:1500000n8";
 	};

-	vcc12v_dcin: vcc12v-dcin-regulator {
+	vcc12v_dcin: regulator-vcc12v-dcin {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc12v_dcin";
 		regulator-always-on;
@@ -30,7 +30,7 @@ vcc12v_dcin: vcc12v-dcin-regulator {
 		regulator-max-microvolt = <12000000>;
 	};

-	vcc5v0_sys: vcc5v0-sys-regulator {
+	vcc5v0_sys: regulator-vcc5v0-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_sys";
 		regulator-always-on;
@@ -40,7 +40,7 @@ vcc5v0_sys: vcc5v0-sys-regulator {
 		vin-supply = <&vcc12v_dcin>;
 	};

-	v3v3_sys: v3v3-sys-regulator {
+	v3v3_sys: regulator-v3v3-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "v3v3_sys";
 		regulator-always-on;
diff --git a/arch/arm/boot/dts/rockchip/rv1126-edgeble-neu2.dtsi b/arch/arm/boot/dts/rockchip/rv1126-edgeble-neu2.dtsi
index 7ea8d7d16f5f..5c1b60deb51b 100644
--- a/arch/arm/boot/dts/rockchip/rv1126-edgeble-neu2.dtsi
+++ b/arch/arm/boot/dts/rockchip/rv1126-edgeble-neu2.dtsi
@@ -11,7 +11,7 @@ aliases {
 		mmc0 = &emmc;
 	};

-	vccio_flash: vccio-flash-regulator {
+	vccio_flash: regulator-vccio-flash {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PB3 GPIO_ACTIVE_HIGH>;
--
2.39.2


