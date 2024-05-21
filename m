Return-Path: <linux-kernel+bounces-185060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D0C8CB001
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 16:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 894351C23D79
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 14:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A536C7FBD1;
	Tue, 21 May 2024 14:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zPiPBYBF"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798E97C6C1
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 14:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716300354; cv=none; b=iKxZtugb6DSHeOQQK88cuNWwqR27i66SBX0qy5KQAJKLwXzDq0zBqYdRleBY6mSNhn7++ATHyBVAfTLLQRObG9904QHr6iAGpIWm17eKmUy4eZ1wrlmCDgu9pdqnUUKlIQn3/p3nORTsjKU0fcuzeHLP7i7Dp/+hrjS4lGB28Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716300354; c=relaxed/simple;
	bh=oh/IWUYJN506nkVHYYkdx0rnWmNdZnY9KqDIe+ywqmE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TCYM+hFSiI1E6x6WfXpkcmQJBBWT3C216H7OyKCm5/NUXdSyLd+RmDyTLUqIH3Dt8cR7jcuOi2o/maWrTce9auL0e3Nnri9jnmgIdY7dSSug8GmBETirVVzJyONdt6p4uXW1H0nXwYya3nxaXgcVWry4g0ViJiN7HIwoLWEhE4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zPiPBYBF; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4200ee78f33so32867275e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 07:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716300350; x=1716905150; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vHecXF3avei0wMYvVe2nNfqZkGUZuu/4Qjpac4gEU9U=;
        b=zPiPBYBFamcO1ewspdb3rHljNuRPwGZy5PJijxDlygEVQx/rI95R5i1LwU0Lm7y2I5
         kLql4+JbL52ZSnPXKjvLnDPVl+ckWS2/zq5iQVGKauKqyY5l1Lye2ynpKCBWYdb2IlwB
         CPduYuJRdqbUBgSAKcWoMXnJqXPvvc428An4crAZqr39CuABjfxnLHWw4yds6bscNNe2
         DoCK/5JKLagcvV8CboMFezy1kFccw+jAP0WXk7xebHfFdBvgAMoh+DPcG1q7oNUeZJiU
         fqUc7w3AOuwCTU9oEOIb8UPgjNndi0xCXOvGfNR5G708k5xOVrKsIpu8yHKXw0avMtaJ
         Nb1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716300350; x=1716905150;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vHecXF3avei0wMYvVe2nNfqZkGUZuu/4Qjpac4gEU9U=;
        b=v94BgHnJcqMGqMBmvQMESummPNMto4RJAGq5ac9wnKkhVHfQjpHc8OvjWtzRdSi/ao
         KF+dA5+ymEWpWwKlXTKS58tY4tTSxomNAxdk9Zx9dsEpk7FEgx3sJ9daSjeHEbs7hshV
         cIeiOTZA7+gS/hJi9JB5EOmw62H58WMc3WWJ4ORHpGlReHpTtyr0u+huslYr47N7z34O
         cLJOkSFgVqhglHiayK+EVs4dmMnNCFrbIWrxEJjccq6rjBU/DogLDRUYivUvXv0Rrr8G
         J/nfcFRrf2k4HR++eXYxBoNweNQRshsBXznBRiMWzU7tZ4MN3HV8K6903x2UZcCNEZjR
         NxEA==
X-Forwarded-Encrypted: i=1; AJvYcCU5mKUoh/7j/Qacox30LYPdBa+ptRuogmWbDrQsL1BpKj9MGkJkmAvnguMumAb9ehFUq+z2SfusHijarjPdiLvLB4x2gI9gDDd+Zbnm
X-Gm-Message-State: AOJu0YxWOENwN90KjfnvoAYfRXMZdRX6R39b2RVkJJpv7o+tB4TfOgrj
	eU1vuvPAAPih3/gvvG4pwbHIWezvrVLlpLkT9SAGWaX9SOmFi6CpZcrAPJLWwKTy/VGjkN8s/jM
	2
X-Google-Smtp-Source: AGHT+IEpb8MyeTzvBtss6nYLtF7rnc8CbH7L10ib6Pkq0/qhNpBIeWifkP0ySE/ilYKRkV6wAkXsAQ==
X-Received: by 2002:a05:600c:45c5:b0:41b:a8e8:3ff6 with SMTP id 5b1f17b1804b1-41fea93a4cfmr221282735e9.11.1716300350613;
        Tue, 21 May 2024 07:05:50 -0700 (PDT)
Received: from [127.0.1.1] (abordeaux-651-1-78-161.w90-5.abo.wanadoo.fr. [90.5.97.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42015deac1asm342085945e9.17.2024.05.21.07.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 07:05:50 -0700 (PDT)
From: Julien Panis <jpanis@baylibre.com>
Date: Tue, 21 May 2024 16:05:36 +0200
Subject: [PATCH v4 2/4] arm64: dts: mediatek: mt8186: add default thermal
 zones
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240521-mtk-thermal-mt818x-dtsi-v4-2-b91ee678411c@baylibre.com>
References: <20240521-mtk-thermal-mt818x-dtsi-v4-0-b91ee678411c@baylibre.com>
In-Reply-To: <20240521-mtk-thermal-mt818x-dtsi-v4-0-b91ee678411c@baylibre.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Nicolas Pitre <npitre@baylibre.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Julien Panis <jpanis@baylibre.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716300346; l=7629;
 i=jpanis@baylibre.com; s=20230526; h=from:subject:message-id;
 bh=lc2XS6xk5Qc4U1MdpeHWgGtSLQNLO7fOSfRbIiHv4Bo=;
 b=j/OiVunLGWMoUT//PdjJqT1DUCI6v0ClYa2rjLSUwwPSdgYMGOJOTJWFvWpofKQZgqZ+3jH8m
 kwW4yhLBMPrAab6ZMKEKf9VIiYvg+qoLhFiFSpEsZqK+IvKfT8b8woO
X-Developer-Key: i=jpanis@baylibre.com; a=ed25519;
 pk=8eSM4/xkiHWz2M1Cw1U3m2/YfPbsUdEJPCWY3Mh9ekQ=

From: Nicolas Pitre <npitre@baylibre.com>

Inspired by the vendor kernel but adapted to the upstream thermal
driver version.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 290 +++++++++++++++++++++++++++++++
 1 file changed, 290 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
index caec83f5eece..ac49a33d1b54 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
@@ -13,6 +13,8 @@
 #include <dt-bindings/power/mt8186-power.h>
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/reset/mt8186-resets.h>
+#include <dt-bindings/thermal/thermal.h>
+#include <dt-bindings/thermal/mediatek,lvts-thermal.h>
 
 / {
 	compatible = "mediatek,mt8186";
@@ -2197,4 +2199,292 @@ larb19: smi@1c10f000 {
 			power-domains = <&spm MT8186_POWER_DOMAIN_IPE>;
 		};
 	};
+
+	thermal_zones: thermal-zones {
+		cpu-little0-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <150>;
+			thermal-sensors = <&lvts MT8186_LITTLE_CPU0>;
+
+			trips {
+				cpu_little0_alert0: trip-alert0 {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu_little0_alert1: trip-alert1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+
+				cpu_little0_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_little0_alert0>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cpu-little1-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <150>;
+			thermal-sensors = <&lvts MT8186_LITTLE_CPU1>;
+
+			trips {
+				cpu_little1_alert0: trip-alert0 {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu_little1_alert1: trip-alert1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+
+				cpu_little1_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_little1_alert0>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cpu-little2-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <150>;
+			thermal-sensors = <&lvts MT8186_LITTLE_CPU2>;
+
+			trips {
+				cpu_little2_alert0: trip-alert0 {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu_little2_alert1: trip-alert1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+
+				cpu_little2_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_little2_alert0>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cam-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
+			thermal-sensors = <&lvts MT8186_CAM>;
+
+			trips {
+				cam_alert0: trip-alert0 {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cam_alert1: trip-alert1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+
+				cam_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		nna-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
+			thermal-sensors = <&lvts MT8186_NNA>;
+
+			trips {
+				nna_alert0: trip-alert0 {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				nna_alert1: trip-alert1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+
+				nna_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		adsp-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
+			thermal-sensors = <&lvts MT8186_ADSP>;
+
+			trips {
+				adsp_alert0: trip-alert0 {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				adsp_alert1: trip-alert1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+
+				adsp_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		mfg-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
+			thermal-sensors = <&lvts MT8186_MFG>;
+
+			trips {
+				mfg_alert0: trip-alert0 {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				mfg_alert1: trip-alert1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+
+				mfg_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-big0-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <100>;
+			thermal-sensors = <&lvts MT8186_BIG_CPU0>;
+
+			trips {
+				cpu_big0_alert0: trip-alert0 {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu_big0_alert1: trip-alert1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+
+				cpu_big0_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_big0_alert0>;
+					cooling-device = <&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cpu-big1-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <100>;
+			thermal-sensors = <&lvts MT8186_BIG_CPU1>;
+
+			trips {
+				cpu_big1_alert0: trip-alert0 {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu_big1_alert1: trip-alert1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+
+				cpu_big1_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_big1_alert0>;
+					cooling-device = <&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+	};
 };

-- 
2.37.3


