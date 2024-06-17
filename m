Return-Path: <linux-kernel+bounces-218136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F3490B9A7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 20:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5865D1C24893
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F330198A06;
	Mon, 17 Jun 2024 18:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8LAbYWn"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961EA197A89;
	Mon, 17 Jun 2024 18:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718648971; cv=none; b=nyjoKydtoTdzB2xTgf4nZDH5qChzU8C00ZLzQ+OTAcR1MmJkKdIXdpoiQKtpi2vfgYy3LHvr25WVcoaxPJNKNy+hA+mXxAHBldAdHeu4ykepL95z6mCkaZeZHq8EahyuIwguHckAYL2R9wkuJ18qImAcNXn2C0T0Lw8bWjNaQhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718648971; c=relaxed/simple;
	bh=RcpwIjmnR3ZB6lo2LEJCkEMEywnrfAp8940slGy+YX8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UVvkR9AfrlvzPDhOObXWIbTu6tCqIejokUzvxpJ9Lv4/bVq9DWZnkcsmgvodKeG5K+3R8DQim2EnfjF0g3lMDgY6XdZ/ZV+0kJBK6yB0K+4nrZjBWSYsW7nYRl8XIZnTl1bzqFf2jC1Dg/MrzXrR79RQZCEzbkfZDdZ1SmYpRqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8LAbYWn; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a6f85f82ffeso169042666b.0;
        Mon, 17 Jun 2024 11:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718648968; x=1719253768; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2X2WIsak2atiEiHDdvF6RWJsXkV1zq+NhgYFvPOjT68=;
        b=O8LAbYWnOlCvz7KL/xYTscOilcdLe4cObJvadWiNyz3wzDQPez8wT+B3coJKM49TPt
         3lF1PE5f+83FfKsTwHQCBMwYIl0KYcXl0yJP5IpMUL+3DZMkB+DBnsve77CrofooxEIt
         le9bc0GZ2ZQzz8lYp1Sx7AJIO/IuukwwVs2DVqf9y5QEv8qK2spobV4esECJOE0bUAln
         8IA09/R0RyZfgYZUPxfCA+uxjLECDGqQXI+LopxXxttapBPE3mdCcbROI8FnnaupREed
         cjP4YRCC5b1s9OfEAeblILuNRwe5hpDmE9Tj0SptyRSSSh8Tn/xynALL2uYoqgyt2A10
         6J1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718648968; x=1719253768;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2X2WIsak2atiEiHDdvF6RWJsXkV1zq+NhgYFvPOjT68=;
        b=DMY3VHRV4M4qM+CFzmFTsTW9eoj6VQEomj2tAH/Y+srfVtfVwu35iO6mB46+YzeObs
         lGyM9XKgJokP33F/7LoQNtk0k785BkPhH2vvJME8CPv3sCw0RGyAM+p75BKfJ1/J5siK
         OjMdQTYE/oufJujXRwtT57LzNkE5iqECsySrB9Nye7aO0IoGzI9Y+5ZGzblOMFv4shEH
         DoRwuu/hrE+pXrN/YZrtK41cQZt0W8k3oMxF6nc6iBfRsERvimW874IQiotwzs+rjCon
         ttmNnbg6t5d+uTFb4LIj5FOOr+c5iDsosiR2gmAmZSqNBETtNy+D6ro8pPH2MjC4v1h/
         +NtA==
X-Forwarded-Encrypted: i=1; AJvYcCVMkvVWOJ6dkzqHC385ZdI1JHm4GKdjEfd7yF738zYRJ46NKrCc+4x3A4oZpIvDB1wlWcqmA5MwuUufdBW8GnyqSy4lOOD883+QOz0tuBJNNgN7RcK2g/fSkVH36iVzKLxUyx8nmQ4KYA==
X-Gm-Message-State: AOJu0YwNcZS+PdLzx8KyZrhgzkCpOTUk3sMSyxbDCoKKy7akJGYMpz9M
	h7mOt28VGVZYIv8BXsW9OZPN6XCP3MllMdcBm1fqjA0RU07vTyFJsPbecWPeUrTn7Q==
X-Google-Smtp-Source: AGHT+IEcKf9ojnPn5YIlp3N2ikFO56e3roYuTKmZx16sk9mDhWUzy5UpZZ7PtHOykON1A5MyEIXOeQ==
X-Received: by 2002:a17:906:6889:b0:a6c:8b01:3f78 with SMTP id a640c23a62f3a-a6f60cf3871mr665133566b.9.1718648967677;
        Mon, 17 Jun 2024 11:29:27 -0700 (PDT)
Received: from latitude-fedora.lan ([2001:8f8:183b:6864::d35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f8a6e58bdsm115397666b.187.2024.06.17.11.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 11:29:27 -0700 (PDT)
From: Alexey Charkov <alchark@gmail.com>
Date: Mon, 17 Jun 2024 22:28:51 +0400
Subject: [PATCH v5 1/8] arm64: dts: rockchip: add thermal zones information
 on RK3588
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240617-rk-dts-additions-v5-1-c1f5f3267f1e@gmail.com>
References: <20240617-rk-dts-additions-v5-0-c1f5f3267f1e@gmail.com>
In-Reply-To: <20240617-rk-dts-additions-v5-0-c1f5f3267f1e@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718648960; l=4812;
 i=alchark@gmail.com; s=20240125; h=from:subject:message-id;
 bh=RcpwIjmnR3ZB6lo2LEJCkEMEywnrfAp8940slGy+YX8=;
 b=t0aimbVHoYZS+Tv6Rzg+QZCtIdY2IvOFNcU16ePc3fJvrwMLGRHzh65G5oZ7/UWW3XGtZhs6q
 xzrMfFXQdCeD94mc8Moc+eLIfTzcOBvkx1I4S7yuqqK37c19baZKRg/
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
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi | 147 ++++++++++++++++++++++++++
 1 file changed, 147 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
index 629049f3dc16..574359279867 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
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
2.45.2


