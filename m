Return-Path: <linux-kernel+bounces-188799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3A88CE721
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 16:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 859EB282478
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 14:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1D912E1E4;
	Fri, 24 May 2024 14:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gpdaIOqf"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D8012DD8A
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 14:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716561128; cv=none; b=i0+k0b8zSia/BErjwzgWDbn0i0kO0eTIX8UWl9S9UlGLhYqCtcWLBFQ9/tmulixH91la6t1APgxCSHslop5aX8ir8r1gu/dBTQsEhAY9zQbEc7PlLGV0pLos+DoqPI1/QjpJREp8jFFzSbpkxPS9PY7thuBhVkuM58cSXmNnW6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716561128; c=relaxed/simple;
	bh=ihEpBfOoTIzhcY5yCWLCSgakPGdyeqFhOmNtZbrClHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G8g+6eaEdQjQCGDKLfZyaqmSONUPBjJkM7F37LdZ5BHh4UkXzkOHEalcYq4BfdvwQ2UqguFSzBr5SKstUJUMlLbKD6EBVN98Yt2/VpTL8pzPfrbm22kaDmjSDcCgp1boqv9qP1FneLmXgaOrE/uLOn7YBsWA5ChXUzMTqDD5354=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gpdaIOqf; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3504f34a086so6124066f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 07:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716561125; x=1717165925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/J4OrAZncZpQuvGizXTDM9c24jSIJESkYwIXxao8DRY=;
        b=gpdaIOqfeDPXOPjjpojLfbIERjFDk3AzLAw8GuvXFpv/4vv6KCp0MLA6trPVlcLx4y
         swgXtCQ8xLJjbZ0O6jprO8T8hiPvg4G/hg5OnEcWHdZKcieWPuYtpISckI5Im19+1KHL
         0Qi45ybTs0VM9SGfocw4iy5BbG9RtxJcBJyPQ7W7MMB4p0VaadHB5R7fT2jmhgVjhlm1
         RoDCSNmj6TwFzOCwIhXzf8Azvl6fy7FdMD52ZpYfTVrLBIeM338Y17eR2Ex94RPKWPb2
         gianLWs3o/SZx8CVyd+C62TST0ahlttt1XajQyUoRM7XokZhNVs0p2B3bAPb0wxudpKR
         9jkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716561125; x=1717165925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/J4OrAZncZpQuvGizXTDM9c24jSIJESkYwIXxao8DRY=;
        b=N1IQRoGRfHfYa5oWdze8uKtmkOlRWlMnJkT4VdqVYH4i6yqKcJ2hILYVcjsHa/oQnK
         TONMlXnJZeUEwlhz3wDTkRphZCUPfox95CaeISCWac7qEQvU2gjADXYQnKiMrfAHPde4
         33D3bnao2o6mGfGRkxGXUL05h1vmGwDtC7+qDZbTfvzSRShcPGrmCsW7GXYbCgHIraFl
         O5EmMLWe021ov6QDhWB9yTXWl6vZWdzv9UN/voR1So0pQeuVgwbyAUOug67OzIcQRhH8
         xq6oMo/HUggoXqnHx09VSPKumgPv/rwnsm7ck4HqqMJGH6U3wdiF6JEMlm+bvd3GXXXw
         YQhg==
X-Forwarded-Encrypted: i=1; AJvYcCVeU5f9jnXneyTOsFEVIbDZ6h82anDhqo6VQc77Ahpy4uLQpNqXON4W4dUHDNGME2fX7rMuaqMKrAv70n3sHEdChXfc7MevFBhtWx4Z
X-Gm-Message-State: AOJu0YzAlUJzFHUwLQlQvcf5DyMK/f/ghkYEQLNrJtvs39ljiQil2+qY
	6/PaNQTBZurwEJFOKgPqSv6xww65K3T3HacTE1kQrLTlzVO2RawUjkcrJMvuXhketDtqXHtiNLh
	DDzM=
X-Google-Smtp-Source: AGHT+IFCKj2pq8XeDS8Y3FzCUKaVouktrLJTGeT9YfniOKJ5yXmCDzg766BhAVtXMdougnVYNmAMyw==
X-Received: by 2002:a5d:400a:0:b0:355:21d:ab9d with SMTP id ffacd0b85a97d-3552fdfd70emr1644022f8f.65.1716561124742;
        Fri, 24 May 2024 07:32:04 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a090c2bsm1719611f8f.59.2024.05.24.07.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 07:32:03 -0700 (PDT)
From: Alexandre Bailon <abailon@baylibre.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH v3 6/6] ARM64: mt8195: Use thermal aggregation for big and little cpu
Date: Fri, 24 May 2024 16:31:50 +0200
Message-ID: <20240524143150.610949-7-abailon@baylibre.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20240524143150.610949-1-abailon@baylibre.com>
References: <20240524143150.610949-1-abailon@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This uses the thermal aggregation for the mt8195 to get the maximal
temperature of big and little cpu clusters.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 212 +++--------------------
 1 file changed, 27 insertions(+), 185 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 5d8b68f86ce4..8aa2bf142622 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -3600,50 +3600,31 @@ dp_tx: dp-tx@1c600000 {
 	};
 
 	thermal_zones: thermal-zones {
-		cpu0-thermal {
+		cpu-little {
 			polling-delay = <1000>;
-			polling-delay-passive = <250>;
-			thermal-sensors = <&lvts_mcu MT8195_MCU_LITTLE_CPU0>;
+			polling-delay-passive = <100>;
+			thermal-sensors = <&lvts_mcu MT8195_MCU_LITTLE_CPU0>,
+					  <&lvts_mcu MT8195_MCU_LITTLE_CPU1>,
+					  <&lvts_mcu MT8195_MCU_LITTLE_CPU2>,
+					  <&lvts_mcu MT8195_MCU_LITTLE_CPU3>;
+			sustainable-power = <1500>;
+			aggregation = "max";
 
 			trips {
-				cpu0_alert: trip-alert {
-					temperature = <85000>;
+				cpu_little_threshold: trip-point {
+					temperature = <68000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu0_crit: trip-crit {
-					temperature = <100000>;
-					hysteresis = <2000>;
-					type = "critical";
-				};
-			};
-
-			cooling-maps {
-				map0 {
-					trip = <&cpu0_alert>;
-					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-								<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-								<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-								<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-				};
-			};
-		};
-
-		cpu1-thermal {
-			polling-delay = <1000>;
-			polling-delay-passive = <250>;
-			thermal-sensors = <&lvts_mcu MT8195_MCU_LITTLE_CPU1>;
-
-			trips {
-				cpu1_alert: trip-alert {
+				cpu_little_target: target {
 					temperature = <85000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu1_crit: trip-crit {
-					temperature = <100000>;
+				cpu_little_soc_max_crit: soc-max-crit {
+					temperature = <115000>;
 					hysteresis = <2000>;
 					type = "critical";
 				};
@@ -3651,7 +3632,7 @@ cpu1_crit: trip-crit {
 
 			cooling-maps {
 				map0 {
-					trip = <&cpu1_alert>;
+					trip = <&cpu_little_target>;
 					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
 								<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
 								<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
@@ -3660,170 +3641,31 @@ map0 {
 			};
 		};
 
-		cpu2-thermal {
+		cpu-big {
 			polling-delay = <1000>;
 			polling-delay-passive = <250>;
-			thermal-sensors = <&lvts_mcu MT8195_MCU_LITTLE_CPU2>;
+			thermal-sensors = <&lvts_mcu MT8195_MCU_BIG_CPU0>,
+					  <&lvts_mcu MT8195_MCU_BIG_CPU1>,
+					  <&lvts_mcu MT8195_MCU_BIG_CPU2>,
+					  <&lvts_mcu MT8195_MCU_BIG_CPU3>;
+			sustainable-power = <1500>;
+			aggregation = "max";
 
 			trips {
-				cpu2_alert: trip-alert {
-					temperature = <85000>;
+				cpu_big_threshold: trip-point {
+					temperature = <68000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu2_crit: trip-crit {
-					temperature = <100000>;
-					hysteresis = <2000>;
-					type = "critical";
-				};
-			};
-
-			cooling-maps {
-				map0 {
-					trip = <&cpu2_alert>;
-					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-								<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-								<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-								<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-				};
-			};
-		};
-
-		cpu3-thermal {
-			polling-delay = <1000>;
-			polling-delay-passive = <250>;
-			thermal-sensors = <&lvts_mcu MT8195_MCU_LITTLE_CPU3>;
-
-			trips {
-				cpu3_alert: trip-alert {
-					temperature = <85000>;
-					hysteresis = <2000>;
-					type = "passive";
-				};
-
-				cpu3_crit: trip-crit {
-					temperature = <100000>;
-					hysteresis = <2000>;
-					type = "critical";
-				};
-			};
-
-			cooling-maps {
-				map0 {
-					trip = <&cpu3_alert>;
-					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-								<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-								<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-								<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-				};
-			};
-		};
-
-		cpu4-thermal {
-			polling-delay = <1000>;
-			polling-delay-passive = <250>;
-			thermal-sensors = <&lvts_mcu MT8195_MCU_BIG_CPU0>;
-
-			trips {
-				cpu4_alert: trip-alert {
+				cpu_big_target: target {
 					temperature = <85000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu4_crit: trip-crit {
-					temperature = <100000>;
-					hysteresis = <2000>;
-					type = "critical";
-				};
-			};
-
-			cooling-maps {
-				map0 {
-					trip = <&cpu4_alert>;
-					cooling-device = <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-								<&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-								<&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-								<&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-				};
-			};
-		};
-
-		cpu5-thermal {
-			polling-delay = <1000>;
-			polling-delay-passive = <250>;
-			thermal-sensors = <&lvts_mcu MT8195_MCU_BIG_CPU1>;
-
-			trips {
-				cpu5_alert: trip-alert {
-					temperature = <85000>;
-					hysteresis = <2000>;
-					type = "passive";
-				};
-
-				cpu5_crit: trip-crit {
-					temperature = <100000>;
-					hysteresis = <2000>;
-					type = "critical";
-				};
-			};
-
-			cooling-maps {
-				map0 {
-					trip = <&cpu5_alert>;
-					cooling-device = <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-								<&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-								<&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-								<&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-				};
-			};
-		};
-
-		cpu6-thermal {
-			polling-delay = <1000>;
-			polling-delay-passive = <250>;
-			thermal-sensors = <&lvts_mcu MT8195_MCU_BIG_CPU2>;
-
-			trips {
-				cpu6_alert: trip-alert {
-					temperature = <85000>;
-					hysteresis = <2000>;
-					type = "passive";
-				};
-
-				cpu6_crit: trip-crit {
-					temperature = <100000>;
-					hysteresis = <2000>;
-					type = "critical";
-				};
-			};
-
-			cooling-maps {
-				map0 {
-					trip = <&cpu6_alert>;
-					cooling-device = <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-								<&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-								<&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-								<&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-				};
-			};
-		};
-
-		cpu7-thermal {
-			polling-delay = <1000>;
-			polling-delay-passive = <250>;
-			thermal-sensors = <&lvts_mcu MT8195_MCU_BIG_CPU3>;
-
-			trips {
-				cpu7_alert: trip-alert {
-					temperature = <85000>;
-					hysteresis = <2000>;
-					type = "passive";
-				};
-
-				cpu7_crit: trip-crit {
-					temperature = <100000>;
+				cpu_big_soc_max_crit: soc-max-crit {
+					temperature = <115000>;
 					hysteresis = <2000>;
 					type = "critical";
 				};
@@ -3831,7 +3673,7 @@ cpu7_crit: trip-crit {
 
 			cooling-maps {
 				map0 {
-					trip = <&cpu7_alert>;
+					trip = <&cpu_big_target>;
 					cooling-device = <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
 								<&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
 								<&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-- 
2.44.1


