Return-Path: <linux-kernel+bounces-548647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B02E8A5477C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3E971721A1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2E7204699;
	Thu,  6 Mar 2025 10:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O2uuy2j8"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081421FFC73
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 10:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741256094; cv=none; b=sOyG90bjuUDCqpfeZsRnBuJjJJg/L24jKd/jLeS5sSZpuQfss5Ky0HXBFpS2Oin52R9Ny442Lfmz4vvOt1wWjJUGOgngT0zdHYBLoh+W8rp8B0Vr7p2vMKHDfv3j58KCh4ZAxx5R1u07XY9++cRsyzVi4BJ11excV9rIhnLHyPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741256094; c=relaxed/simple;
	bh=Vvq/ZZDjfMZAs8pqbpzmzzCwlz4eGfr090WjM1dsT+I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dXqX1NRteF61cLELGgDzS07x/a1YxbETNKqvU8UJ9P3+3KfihYVgWu3VgM5pTRR7m9FFHffz7F2s1wuHaGwwPcpunOqz6LQ58hkHBneJNa8iGr7rnE6WZKRcykO7oP6Y6l3brazp/WYy00ldYIu3xKFFICJHjUVH8ZDW/xGeB1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O2uuy2j8; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e549af4927so733703a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 02:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741256090; x=1741860890; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PkEq7z1q0YiYub9Ku1p0lF3+8XZaxzvZ7wbudwieneg=;
        b=O2uuy2j8d252RLUYlveVxw2qcUe5SmJly0uHPBjcDGJMwt9NhoJlHdDtMf4ZKXTQ9f
         nZM4Cqq4vvwn3SEZHHMhYovcvIXwHvB03yTcEWUc8trtx2j6HfOAURH1MJUQpOWCw+vX
         Gv1cRDBi9B1/FgvlktF8/Qub2UPWnz2kex+QzWvfoDtgA1jgqA0eZuJaNok5CWg5GL9a
         kVsyow+rini2kX5+WkGbYeK6DACoVJ4UlFW6BNViw6QwGeRhAlhsJ0gKZiyRiKOg8AKl
         6kon2Q/mxr1avIn6e4cyXzOmDaXxzWVPbt2FrhwAxbzZkjmDf18G6FEU2ZmRjGfeeDYk
         7nLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741256090; x=1741860890;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PkEq7z1q0YiYub9Ku1p0lF3+8XZaxzvZ7wbudwieneg=;
        b=eT+6vcVlwZs0HRR12xD12RQdQAhaMrlE0xLWjA9wP3OtD+MAk9JXQ1hcx9b7xacf9b
         vxEa690LzGJw9QJE5Ul/9lG6af95EGFoPg3jtZ+kTEbZKHI9Rcz7qxZz7v9J2ILHKOZ0
         OAVH/W65+IU+UHitN15BRZ4AiZF/tVCgRh9kF/LEB1Iuh+d8siaIJsBZIHtACypIBxmE
         ho2sBFfEDEPVMBM4DAtVnPJfqdKNZ7h2BLf5X1S+KJsaVfYMAyij4s8taSWUFtKrVUUA
         9BW2SFDucXdU7FkMxj2io97KwDI/hzwRD+9sksEjjuY+8Kb3fG24Hte1O2HJSwBN753d
         6mTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAsK4BocDrJUcIm+KF0cG+/TlgQAXcTEKDe5jahQZLHgxZf7YMUMi+WDoajObWibMrgaHYVzW6IC0vWaM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3iloFweJI43jFhZJa0KjhVvmIg+T2t1RQ8Omn2D8jstQIH/iY
	4f3NlSJl/tAhEJQAKfxCmdjGtKq119S6zxq3sFvWVyhtjt5lp+f2zqqn7fE1DS8=
X-Gm-Gg: ASbGncttJVffZFJ+MN/Xezb+ZhKsUy2ma1hp+rQWqOVPu68fNo5mRscUWHB7UFbLGVU
	ueOdrPRvE4o6DQLh1SShoEum92OsFfqoGEQB3oyrW0Ko5WFuLKZ/fOqy5181U6sPst9uxfLic7r
	yIUI7A3l0Ix4Lkg+CGGPUq7hgClwYfkS2tFXjx0Wl4P7JKndO2mIbk2JYNs6MR39iFg27LitpB9
	HxeYL3kkLKEHW+vXniOpVBO5IufCWZ4+yTuLGJf5nO9pNWmSfV1Fyic4LWZG3h6FdbcwasS9jrI
	M/vlPFtnJvPeTHIwHIsgUe8ODRb3n2ZYR2fWA4YKxJmgZnW7AKByLZocyh9+EaJ+Z5xRRhLDR7b
	SQjc34br841A1UdDQi5MpEDj/TA+b
X-Google-Smtp-Source: AGHT+IEcenJXCCsPX8fwCFChlhI8lsHvDUUR4lKpJP1AeP2qAkwJ1RuV+lWKabRvAciorFjPsTy0lA==
X-Received: by 2002:a05:6402:2714:b0:5de:de2c:ea90 with SMTP id 4fb4d7f45d1cf-5e59f37da2dmr5692667a12.11.1741256090167;
        Thu, 06 Mar 2025 02:14:50 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c74a6af7sm708972a12.33.2025.03.06.02.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 02:14:49 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 06 Mar 2025 10:14:47 +0000
Subject: [PATCH 2/3] arm64: dts: exynos: gs101-pixel-common: add the
 MAX77759 PMIC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250306-b4-max77759-mfd-dts-v1-2-9fe8b0eb8123@linaro.org>
References: <20250306-b4-max77759-mfd-dts-v1-0-9fe8b0eb8123@linaro.org>
In-Reply-To: <20250306-b4-max77759-mfd-dts-v1-0-9fe8b0eb8123@linaro.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

Also add the subnodes for the GPIO expander and NVMEM, and define the
NVMEM layout.

The NVMEM layout is declared such that it matches downstream's
open-coded configuration [1].

The pinctrl nodes are kept sorted by the 'samsung,pins' property rather
than node name, as I think that makes it easier to look at and to add
new nodes unambiguously in the future.

Link: https://android.googlesource.com/kernel/google-modules/bms/+/96e729a83817/max77759_maxq.c#67 [1]
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 .../boot/dts/exynos/google/gs101-pixel-common.dtsi | 61 ++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101-pixel-common.dtsi b/arch/arm64/boot/dts/exynos/google/gs101-pixel-common.dtsi
index b25230495c64dce60916b7cd5dcb9a7cce5d0e4e..f67fa1e84d994de4d40f29a2d437ab6401ac133d 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101-pixel-common.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101-pixel-common.dtsi
@@ -188,6 +188,60 @@ usbc0_role_sw: endpoint {
 			};
 		};
 	};
+
+	pmic@66 {
+		compatible = "maxim,max77759";
+		reg = <0x66>;
+
+		pinctrl-0 = <&if_pmic_int>;
+		pinctrl-names = "default";
+		interrupts-extended = <&gpa8 3 IRQ_TYPE_LEVEL_LOW>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
+		gpio {
+			compatible = "maxim,max77759-gpio";
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			/*
+			 * "Human-readable name [SIGNAL_LABEL]" where the
+			 * latter comes from the schematic
+			 */
+			gpio-line-names = "OTG boost [OTG_BOOST_EN]",
+					  "max20339 IRQ [MW_OVP_INT_L]";
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		nvmem-0 {
+			compatible = "maxim,max77759-nvmem";
+
+			nvmem-layout {
+				compatible = "fixed-layout";
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				reboot-mode@0 {
+					reg = <0x0 0x4>;
+				};
+
+				boot-reason@4 {
+					reg = <0x4 0x4>;
+				};
+
+				shutdown-user-flag@8 {
+					reg = <0x8 0x1>;
+				};
+
+				rsoc@a {
+					reg = <0xa 0x2>;
+				};
+			};
+		};
+	};
 };
 
 &pinctrl_far_alive {
@@ -211,6 +265,13 @@ typec_int: typec-int-pins {
 		samsung,pin-pud = <GS101_PIN_PULL_UP>;
 		samsung,pin-drv = <GS101_PIN_DRV_2_5_MA>;
 	};
+
+	if_pmic_int: if-pmic-int-pins {
+		samsung,pins = "gpa8-3";
+		samsung,pin-function = <GS101_PIN_FUNC_EINT>;
+		samsung,pin-pud = <GS101_PIN_PULL_UP>;
+		samsung,pin-drv = <GS101_PIN_DRV_2_5_MA>;
+	};
 };
 
 &pinctrl_gpio_alive {

-- 
2.49.0.rc0.332.g42c0ae87b1-goog


