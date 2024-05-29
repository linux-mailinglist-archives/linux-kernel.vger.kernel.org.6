Return-Path: <linux-kernel+bounces-193482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA018D2CCD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 07:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C58ED28CEBF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 05:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8702A1667C4;
	Wed, 29 May 2024 05:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WPUbosEu"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A75D160796
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 05:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716962294; cv=none; b=iNOmCxEaZRjWfhTr7go8+3ebvZPkGTTvxcpSrO6SSSbzpc/PdmpZNbCICvYgdscHymq1bvSNxgAlH2Lh/qUYppHRAtr9pqGDrsjs5VAA+/w+Qhgzn+CrR/5lCnjVcCcsKGI1N5w8lboh0ZFbt1XmO7sNbxpfEGeEE5aocNqaXus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716962294; c=relaxed/simple;
	bh=a3KSQk0QjrMowRJps3c/VMw7Rsw51+L1udfOQ253okM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fmbr92u69G572wFw7mF02JET0+1jKLQ6jDkHjNrWmE9oCH/pqN+1B5eLkTat4/bjZvpL1c5J2dVruFPDLbjZrYwXj5dqFgtP0SKOhuJ5mWLSE0qTBF2a+rfc53Zr1R/KgEWaoLRnzncw7FnbSim0Zkj8CJBZza3rhlgVBAcgTQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WPUbosEu; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4211a86f124so14281385e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 22:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716962290; x=1717567090; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kQYjDJKjiuUGN1IdrBorFo2itihiB9FUhURZkClhppI=;
        b=WPUbosEuINUDBl3rVkt/nGEnWAhtx2VY+fHcbfNp1XQOG+7t3Sc+832dHrW5LJSDwe
         tcoo1idvHhEyFkl33wZV7uoBbQqV2ZVx8WHWnrVCu5UNFHI/WAvkNSNJXhbmMjM38D6z
         ffJoImkdvQhQJti0RJAbpHIyQmeb6BYpekkjE5gB9B+UlG8wQCEu+soK+1GRn43KNdeD
         jG84Z09KIdXO5u1FnBFz5cCbEctQYov+ymCD2pqT9d4g02Z5hMETGIqqNetTgClr4gpz
         cuiTS8FPa2eZgJsyacDF7GFDrHoXmqll2vfkWz2BIajOPvMMH/XUM7njM4LQAWv+fF8V
         eHLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716962290; x=1717567090;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kQYjDJKjiuUGN1IdrBorFo2itihiB9FUhURZkClhppI=;
        b=DmIukxPvdF5jzNB9RPJAYCBCnmKx06AaiNbTXNAxBH8KR6pRz13pq2EENbRc/Y1JSC
         IMQH2aqwnt4On7ihN4kANYPrzitXKKtb19xo7yZ42eqew98S7mFJnbLGT7toSANVirDe
         VUMFQLi4aVxXnVd3Dhn7qa42meYNf66fgJjKSgmDyFQ1tlWfVYBgKqEJ8k1E/oxD1a1Y
         5RUOVzUSdxS05fTKzIpi8vXlnNL8L5ALo2ZNpNDUCn7Rn1KD6fLrEkE/5xz+1ivNeO9B
         2+qI4C/mkBLGTbxIxMYCXAotvYjawqSK9/9ylQyEA97Pf0DZifR6TUJxAFnbphjLXYkr
         rGdQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+Gj1Rtv1P68yJphUiz0jpM6PTiZaHKvyOor49W4xKQphH388AOJlwr/bGH0Q4v0XjeaK16PDVUu8bt9YStgN3Rn3cytqr+1Gnnxzr
X-Gm-Message-State: AOJu0Yx/6NxSG1SLigdCA1d8kFbWXAEwxdXcMMdJz5PsQNmC+T/mX3OD
	4CQ+VYmKmdLXDhMVVzLQrQCnmfeWm27Rt8RjSPZxtDolQWL0QH6Q7kOQjrqWvcc=
X-Google-Smtp-Source: AGHT+IEjKcWC8j65Qa4iu3hgjuBfnHXwDmNvqgeJYYoLOah3bC1halpC3GpvR6NNFUNx4Dba6IiX9g==
X-Received: by 2002:a05:600c:2205:b0:420:1fd2:e611 with SMTP id 5b1f17b1804b1-42108a1c508mr107000355e9.27.1716962290056;
        Tue, 28 May 2024 22:58:10 -0700 (PDT)
Received: from [127.0.1.1] ([84.102.31.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4210896676bsm169075435e9.4.2024.05.28.22.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 22:58:09 -0700 (PDT)
From: Julien Panis <jpanis@baylibre.com>
Date: Wed, 29 May 2024 07:57:59 +0200
Subject: [PATCH v6 4/6] arm64: dts: mediatek: mt8186: add default thermal
 zones
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-mtk-thermal-mt818x-dtsi-v6-4-0c71478a9c37@baylibre.com>
References: <20240529-mtk-thermal-mt818x-dtsi-v6-0-0c71478a9c37@baylibre.com>
In-Reply-To: <20240529-mtk-thermal-mt818x-dtsi-v6-0-0c71478a9c37@baylibre.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Nicolas Pitre <npitre@baylibre.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, 
 Julien Panis <jpanis@baylibre.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716962279; l=7777;
 i=jpanis@baylibre.com; s=20230526; h=from:subject:message-id;
 bh=sG5Ze//7RlqRD8XfjGttbCgM09mHkLhEkzGoVC5Po1o=;
 b=wVQnyGHe1Ma8jwdKe2e2HxTlRKjrpLCLCtxc0O/kxW+HBvskAOmmztbqtkorg9PPckRQrLWRI
 JbVGuQhbKDCA97bWkDQSka5YMLTbrTCZM+ukjWJrvCmHZJXubKU0q0u
X-Developer-Key: i=jpanis@baylibre.com; a=ed25519;
 pk=8eSM4/xkiHWz2M1Cw1U3m2/YfPbsUdEJPCWY3Mh9ekQ=

From: Nicolas Pitre <npitre@baylibre.com>

Inspired by the vendor kernel but adapted to the upstream thermal
driver version.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 297 +++++++++++++++++++++++++++++++
 1 file changed, 297 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
index caec83f5eece..95fe5a05f0d7 100644
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
@@ -2197,4 +2199,299 @@ larb19: smi@1c10f000 {
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
+		gpu-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
+			thermal-sensors = <&lvts MT8186_GPU>;
+
+			trips {
+				gpu_alert0: trip-alert0 {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				gpu_alert1: trip-alert1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+
+				gpu_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpu_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
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


