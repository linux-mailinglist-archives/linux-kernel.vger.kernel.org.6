Return-Path: <linux-kernel+bounces-521181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DDDA3B6BF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 10:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3063162870
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51B21DC747;
	Wed, 19 Feb 2025 08:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ru22cKO3"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B64C1DC9AD
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 08:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739955454; cv=none; b=QFiaMS2a1wLTYjcdBhiYBWlNsOF90F7aYKWwZ6wSHPcI1Y81x12bSOpnlPWh1wFDIOU0FX+SLL8xd2U9y+jgiiN+kzFpTqMhoZwzztqF2QM6UIIVnHIug5RDUomqjtbMX4YMKSxgNIqFgEGDG3UvVMNDRwR6Yz7k3rMiCjQDS0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739955454; c=relaxed/simple;
	bh=5feNgE4Z0VyR3BH4VrqG8+EjOe3cq6YlQsxGTVhOkJE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ypuhu5L3YfJuuMzD/PaAMZv/F0mBSQtnFe17dIInDc51xs0fbhAKeWUMZsguDJ8K6geqevV1UJGVcdz7D8v0VqmfKsQ393hWrUCGeAzVlTbWvChuJO15ls6Wames1iUeYBRJLTnxPri0EVst9UoPcT7PdUgIx8zbvQKAAkQtX1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ru22cKO3; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43937d315abso8576655e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 00:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739955450; x=1740560250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PRDH7JUOK4Qt3XrdNtvjAwI3P3XDa0EtyA9y0a/Ff1Y=;
        b=Ru22cKO3w1Sh0ozJfXUZIxGEOZn4+WRiegUhdLUzv2SHaFP8p12AXeoJt68okNKW6A
         W9aV0Rzg2wjDmUQjOw26HUNTSeey2bztSRGjvHR6LAKVwWUbBRdxSSUy/YCZvm2PvLSh
         8AxjQs47pPn2IF+q3RXiJzQV6r+t3ROMLtfydeefkYWdOAxjeyl+tEKrngfWEAFtBQta
         zgQOv0FtTv0p6dYtbQmulhW1qP1MseQuOVWjrKUGUBvykDVkmYCQ4M//yrpxpnVsHrL8
         uvlHiVMFAw3MioS7ChN0kG1IkalZF5dUYOPH/vPEibB5ORqsTPsyf/8loUePcefk1yzJ
         AIhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739955450; x=1740560250;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PRDH7JUOK4Qt3XrdNtvjAwI3P3XDa0EtyA9y0a/Ff1Y=;
        b=dXWNJ19Ey/v9xwhGrPR3EcacUTPmw/qVVoGfmr3Hj07b5ccLKRuBu0J0DozCvv5Bdz
         3N1wgEpNgax+4iyDbYBiqYGhi23hxCLfnN9pJUy8hAKxJXqobxPmGlujdv2XXuNa47Mv
         K8GXZFXFvsoCfL/UyO+pUZt2Yt9+aRp/HyCcin/pjdtS69fHjP2uRVmL25Yy1VkFDVO5
         bdmJ+ZbBpc6nOKxQ8RyLLNvLElafbesjwheca1MXMLdgLqu5Ig0XMZDWlF5dhrg7Vm2i
         ZkiblI7x7WdQby8PB7Z0SXmtEmVRnvTH/GH7DpDcx0Rt9ZCc8ASvDsHaEGI3dYIkNoE6
         KpiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpa6P6Gg0GIv60dq4L95c/UTN/p07kwuo213EFcuoL7xMG+xrU58AgYDGnGfiThxqwHlYHcHs8uni6XyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU/uLFq5E7vbBgyUXWh9TNtR/hSzUnCZzOPbZT/6nMx/41HqS6
	JG/IXSL6kpE4oA7Lmw6rxh9nvDoPIqBlUkPlvV9vqOKBk9e6fFTlJY07got5P3Y=
X-Gm-Gg: ASbGncuc1EJ/UdApQgELm1HID3gmNc4twlSMjoADf/5B6VxYLNVQtD8jDXg3MCKTKfb
	yN+dgoGNZ5R3CS2WWysDqbjXS7L9i5REIYzDRbElLE62qsuQACppOumml+DQJnHlX1DOnW/ctfP
	oZ1/Nf9XshIHxPlh1nQnrUrQWcD5gZRTIQCqO7iLBfA58S8CeYDsFNXm/il9Li7DJpDTw0+J/XV
	yNyn7p0mKDBENwRmAqhPmpK9tjK6S5qky21ugkJcaaCI5gbsa8yWPzpDf26j39CchZiK3iqyHH8
	LZgR9tT9TXI+cfx4NP9oIoMET4asLw==
X-Google-Smtp-Source: AGHT+IGb1jEC7y+Y7Rl+PioMxXoJSfQnw0OF7LzA+zc795fUjhCn+RhDum3IRhMvx+QUGzwJ/XfnIA==
X-Received: by 2002:a05:600c:2d04:b0:439:84d3:f7fd with SMTP id 5b1f17b1804b1-43984d3fb0bmr37040725e9.4.1739955449623;
        Wed, 19 Feb 2025 00:57:29 -0800 (PST)
Received: from krzk-bin.. ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4399beadf31sm10007375e9.0.2025.02.19.00.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 00:57:29 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-fsd@tesla.com,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] arm64: dts: exynos: gs101: Change labels to lower-case
Date: Wed, 19 Feb 2025 09:57:25 +0100
Message-ID: <20250219085726.70824-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DTS coding style expects labels to be lowercase.  No functional impact.
Verified with comparing decompiled DTB (dtx_diff and fdtdump+diff).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 22 ++++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index 813f96089578..80c1af3a8836 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -73,7 +73,7 @@ cpu0: cpu@0 {
 			compatible = "arm,cortex-a55";
 			reg = <0x0000>;
 			enable-method = "psci";
-			cpu-idle-states = <&ANANKE_CPU_SLEEP>;
+			cpu-idle-states = <&ananke_cpu_sleep>;
 			capacity-dmips-mhz = <250>;
 			dynamic-power-coefficient = <70>;
 		};
@@ -83,7 +83,7 @@ cpu1: cpu@100 {
 			compatible = "arm,cortex-a55";
 			reg = <0x0100>;
 			enable-method = "psci";
-			cpu-idle-states = <&ANANKE_CPU_SLEEP>;
+			cpu-idle-states = <&ananke_cpu_sleep>;
 			capacity-dmips-mhz = <250>;
 			dynamic-power-coefficient = <70>;
 		};
@@ -93,7 +93,7 @@ cpu2: cpu@200 {
 			compatible = "arm,cortex-a55";
 			reg = <0x0200>;
 			enable-method = "psci";
-			cpu-idle-states = <&ANANKE_CPU_SLEEP>;
+			cpu-idle-states = <&ananke_cpu_sleep>;
 			capacity-dmips-mhz = <250>;
 			dynamic-power-coefficient = <70>;
 		};
@@ -103,7 +103,7 @@ cpu3: cpu@300 {
 			compatible = "arm,cortex-a55";
 			reg = <0x0300>;
 			enable-method = "psci";
-			cpu-idle-states = <&ANANKE_CPU_SLEEP>;
+			cpu-idle-states = <&ananke_cpu_sleep>;
 			capacity-dmips-mhz = <250>;
 			dynamic-power-coefficient = <70>;
 		};
@@ -113,7 +113,7 @@ cpu4: cpu@400 {
 			compatible = "arm,cortex-a76";
 			reg = <0x0400>;
 			enable-method = "psci";
-			cpu-idle-states = <&ENYO_CPU_SLEEP>;
+			cpu-idle-states = <&enyo_cpu_sleep>;
 			capacity-dmips-mhz = <620>;
 			dynamic-power-coefficient = <284>;
 		};
@@ -123,7 +123,7 @@ cpu5: cpu@500 {
 			compatible = "arm,cortex-a76";
 			reg = <0x0500>;
 			enable-method = "psci";
-			cpu-idle-states = <&ENYO_CPU_SLEEP>;
+			cpu-idle-states = <&enyo_cpu_sleep>;
 			capacity-dmips-mhz = <620>;
 			dynamic-power-coefficient = <284>;
 		};
@@ -133,7 +133,7 @@ cpu6: cpu@600 {
 			compatible = "arm,cortex-x1";
 			reg = <0x0600>;
 			enable-method = "psci";
-			cpu-idle-states = <&HERA_CPU_SLEEP>;
+			cpu-idle-states = <&hera_cpu_sleep>;
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <650>;
 		};
@@ -143,7 +143,7 @@ cpu7: cpu@700 {
 			compatible = "arm,cortex-x1";
 			reg = <0x0700>;
 			enable-method = "psci";
-			cpu-idle-states = <&HERA_CPU_SLEEP>;
+			cpu-idle-states = <&hera_cpu_sleep>;
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <650>;
 		};
@@ -151,7 +151,7 @@ cpu7: cpu@700 {
 		idle-states {
 			entry-method = "psci";
 
-			ANANKE_CPU_SLEEP: cpu-ananke-sleep {
+			ananke_cpu_sleep: cpu-ananke-sleep {
 				idle-state-name = "c2";
 				compatible = "arm,idle-state";
 				arm,psci-suspend-param = <0x0010000>;
@@ -160,7 +160,7 @@ ANANKE_CPU_SLEEP: cpu-ananke-sleep {
 				min-residency-us = <2000>;
 			};
 
-			ENYO_CPU_SLEEP: cpu-enyo-sleep {
+			enyo_cpu_sleep: cpu-enyo-sleep {
 				idle-state-name = "c2";
 				compatible = "arm,idle-state";
 				arm,psci-suspend-param = <0x0010000>;
@@ -169,7 +169,7 @@ ENYO_CPU_SLEEP: cpu-enyo-sleep {
 				min-residency-us = <2500>;
 			};
 
-			HERA_CPU_SLEEP: cpu-hera-sleep {
+			hera_cpu_sleep: cpu-hera-sleep {
 				idle-state-name = "c2";
 				compatible = "arm,idle-state";
 				arm,psci-suspend-param = <0x0010000>;
-- 
2.43.0


