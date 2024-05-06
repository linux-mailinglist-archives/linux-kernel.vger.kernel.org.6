Return-Path: <linux-kernel+bounces-169583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 336768BCAD0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 11:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B0EF1C203B3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 09:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A55614265F;
	Mon,  6 May 2024 09:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7GuATFY"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AB114264D;
	Mon,  6 May 2024 09:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714988235; cv=none; b=AUtSpPofbFWdHvLZcXwHzTxnrc/6vdRzT62Mbwk3QbR/zxzs8BnlsHsqQpeXepzhoB3tY3F5cR+YyXyVHrAqfaVr5hpXk1mLhRxA04SMnibl5z+FMm6eaqH4lI/W+gbdP2EbyxXEMih2YW0C+UbeEgF0J2jw2tyeEx9w54ty8f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714988235; c=relaxed/simple;
	bh=+CRjCu5/qMbviqrE7tKv0CDQlxSHs+JH5lEn/bmXM3Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uQv4X9UGOPkQx6Kf2o6RYK6s70Q0zlk8zKdJyaXSVREzj3CDMiV2yzE+ytTd8xxoXEID0BBr9HrSp3bAsZ6SP+YOSoFtuaA5qdO/I5o9cTuLQAwVV2qIxb/ZyOAcb1Oi8Bb6z9Eh3AAau5bNwLQXsKgq84mz6Sl/6cpfdOAh5g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I7GuATFY; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a5200afe39eso415561066b.1;
        Mon, 06 May 2024 02:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714988232; x=1715593032; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZmGdmY8DE6zqLCMf8fCUqWkVhIJWW+2eyn2qqAadLp0=;
        b=I7GuATFYn9G8q3ZvRZZZ6aoyJQLBvRrN4avARTQPK1+OQHvAuFkb2UdFGogh1yOza+
         5D8CZ/2koRo17oZh42dbzi49W1/q6HpQiWgjcdGZ7K3vcK4QwRFkqzJCBO8z39M2iLBJ
         RxlqqEqAcdadyxQyjWhPVVNtLEaUTngmAAAniVswVTiBPXBnQ553W8qiXz6qwfx/g8Zi
         PwPL/G66rMfaa7aLe66N6fRt3ScLaoMEAbNmcIwtzCLzdS84z1ULWN55GY5aJ9z+Tvc/
         1Dobbk+YSKB6RQh4T1k5q1p1v8ZgczkzdOJGClNG6fQj9pwTPtn/HrmfnhhB3jwqH/zK
         CENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714988232; x=1715593032;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZmGdmY8DE6zqLCMf8fCUqWkVhIJWW+2eyn2qqAadLp0=;
        b=C2Fkl1YmGrS3a4zoceAV3UDCaCHUVJ6NbMkikPNoXSaU5SpGAUcw2ri0spNF8iZxEA
         OvD8dyHMNGgc/kBTWoBfSCT0Vf83SItAdibDUMRCJ6d9jJED8gTGHGu21j4eUipVDg5r
         Rd2KrDVhWQYfWutyr0FdIHFI5Xt/IdWIay2C0F6aN4D2x8nqF1VbuVcoUIXXGgDePoiK
         mA8197eBKFZtVXkLqR2R2P2hRCUB2gz3cuWjlHEdOErbESCAYScqENnJ3f2rkU2+4p3I
         wSBFcm52ZxwLkGtRrPwLfoFKjlcZEJqbeNGIALfWYfCev7chGHpbqDKwU/b6rJX2JRrY
         xzMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIL1C8p+HnRwxUe3f71M7Mo+wO9Xo0sVJGIvFpZoL+Y7KEWdioFhlqtGi8YWl3Ltt6pgGh2uMS4Y9D8Ngg5Pulaca1aLZyHnN41u+UanLTR4A/hsJ58NvEUspNuEOFvCFinwbdkPD+/A==
X-Gm-Message-State: AOJu0Yzi9CdO5uQrsKzVMQuTD5s8ktwuAIrGyy0jauSZRnKqiUtELJI5
	vaUi6/GymRNOy7SwF1aCniI2S0NT77QXkq7m5pasWvaTLv5Ph35ZOaS8kPOpGBg=
X-Google-Smtp-Source: AGHT+IFTy2eBX+SCcZX80gxFh0M8yziHMdYiwC7RP5+Th3wIlkpQvWMdH63lC5HB6XaT4i46Tq/YEA==
X-Received: by 2002:a50:c319:0:b0:56f:e7b9:e67d with SMTP id a25-20020a50c319000000b0056fe7b9e67dmr9422796edb.12.1714988232147;
        Mon, 06 May 2024 02:37:12 -0700 (PDT)
Received: from [172.30.32.119] ([2001:8f8:183b:f2c::d35])
        by smtp.gmail.com with ESMTPSA id f6-20020a056402160600b005722ce89ae2sm4983647edv.38.2024.05.06.02.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 02:37:11 -0700 (PDT)
From: Alexey Charkov <alchark@gmail.com>
Date: Mon, 06 May 2024 13:36:32 +0400
Subject: [PATCH v4 1/6] arm64: dts: rockchip: add thermal zones information
 on RK3588
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240506-rk-dts-additions-v4-1-271023ddfd40@gmail.com>
References: <20240506-rk-dts-additions-v4-0-271023ddfd40@gmail.com>
In-Reply-To: <20240506-rk-dts-additions-v4-0-271023ddfd40@gmail.com>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Dragan Simic <dsimic@manjaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
 Chen-Yu Tsai <wens@kernel.org>, Diederik de Haas <didi.debian@cknow.org>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Alexey Charkov <alchark@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714988224; l=4796;
 i=alchark@gmail.com; s=20240125; h=from:subject:message-id;
 bh=+CRjCu5/qMbviqrE7tKv0CDQlxSHs+JH5lEn/bmXM3Y=;
 b=EzL8gJdaHg+A1S3Q8nrUlNLWmEKSCa0G7Sxga0J9K3BPOvz6Ld9L11TR3dmiltGPq92SM/bLY
 N9PjqYnNTheAGDY2BCBsg8YbcF95OobZ1LadcHzT2Pj+MPWM0QHIerj
X-Developer-Key: i=alchark@gmail.com; a=ed25519;
 pk=xRO8VeD3J5jhwe0za0aHt2LDumQr8cm0Ls7Jz3YGimk=

This includes the necessary device tree data to allow thermal
monitoring on RK3588(s) using the on-chip TSADC device, along with
trip points for automatic thermal management.

Each of the CPU clusters (one for the little cores and two for
the big cores) get a passive cooling trip point at 85C, which
will trigger DVFS throttling of the respective cluster upon
reaching a high temperature condition.

All zones also have a critical trip point at 115C, which will
trigger a reset.

Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 147 ++++++++++++++++++++++++++++++
 1 file changed, 147 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index 6ac5ac8b48ab..ef06c1f742e8 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -10,6 +10,7 @@
 #include <dt-bindings/reset/rockchip,rk3588-cru.h>
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/ata/ahci.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	compatible = "rockchip,rk3588";
@@ -2368,6 +2369,152 @@ pwm15: pwm@febf0030 {
 		status = "disabled";
 	};
 
+	thermal_zones: thermal-zones {
+		/* sensor near the center of the SoC */
+		package_thermal: package-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tsadc 0>;
+
+			trips {
+				package_crit: package-crit {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		/* sensor between A76 cores 0 and 1 */
+		bigcore0_thermal: bigcore0-thermal {
+			polling-delay-passive = <100>;
+			polling-delay = <0>;
+			thermal-sensors = <&tsadc 1>;
+
+			trips {
+				bigcore0_alert: bigcore0-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				bigcore0_crit: bigcore0-crit {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+			cooling-maps {
+				map0 {
+					trip = <&bigcore0_alert>;
+					cooling-device =
+						<&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu_b1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		/* sensor between A76 cores 2 and 3 */
+		bigcore2_thermal: bigcore2-thermal {
+			polling-delay-passive = <100>;
+			polling-delay = <0>;
+			thermal-sensors = <&tsadc 2>;
+
+			trips {
+				bigcore2_alert: bigcore2-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				bigcore2_crit: bigcore2-crit {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+			cooling-maps {
+				map0 {
+					trip = <&bigcore2_alert>;
+					cooling-device =
+						<&cpu_b2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu_b3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		/* sensor between the four A55 cores */
+		little_core_thermal: littlecore-thermal {
+			polling-delay-passive = <100>;
+			polling-delay = <0>;
+			thermal-sensors = <&tsadc 3>;
+
+			trips {
+				littlecore_alert: littlecore-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				littlecore_crit: littlecore-crit {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+			cooling-maps {
+				map0 {
+					trip = <&littlecore_alert>;
+					cooling-device =
+						<&cpu_l0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu_l1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu_l2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu_l3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		/* sensor near the PD_CENTER power domain */
+		center_thermal: center-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tsadc 4>;
+
+			trips {
+				center_crit: center-crit {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		gpu_thermal: gpu-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tsadc 5>;
+
+			trips {
+				gpu_crit: gpu-crit {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		npu_thermal: npu-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tsadc 6>;
+
+			trips {
+				npu_crit: npu-crit {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+	};
+
 	tsadc: tsadc@fec00000 {
 		compatible = "rockchip,rk3588-tsadc";
 		reg = <0x0 0xfec00000 0x0 0x400>;

-- 
2.45.0


