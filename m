Return-Path: <linux-kernel+bounces-169588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAA08BCADE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 11:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 277471F22C17
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 09:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1412C143C52;
	Mon,  6 May 2024 09:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/fX1ec0"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB03143C4E;
	Mon,  6 May 2024 09:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714988254; cv=none; b=gj77vSJHiejJ+UIKHSBhcyBIag+OTx2zaQbailWYYjFFKpHkefNZHkSPiENRoJeerHPKzj03/yOmma9YRGc450VgXAPa6qFBNt/5EuGf6UsYE41xFXuB5OENlvwuJKzDk8TYKX8Xk512z5hTeR1FbyNvrnPvTaEXIqd3XeDRc4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714988254; c=relaxed/simple;
	bh=u0gM6tgf6YzJQvPrv4bbdJjzpHgMPBoZnVPNA5o69i0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pk9yxcyb37ZXS/ZQYiV051dae2XZsvzVtDf2pbEjwcYn5FX8nZMZfVr9aw5cRJ6SRFz8WXJYXxBckWNyBNC22h/bNjQFuF175FTRpEdgkuX3C8dVzH7C2qLC+h2Tur7KxMOMAfz4v0Urf80i/fEuX29cpSA2kJVTLKi1j01HTgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/fX1ec0; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51f12ccff5eso2214630e87.1;
        Mon, 06 May 2024 02:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714988250; x=1715593050; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YJ/i9aSextJBDewJyOG1hC8/ORRuaV5BU0FGPlg+ibI=;
        b=E/fX1ec0Fq/l31TjR9Ntkh9oo5wpKXV7hCsv9Q3svGHOEX7Nm5RI082TnuNkHRiCbc
         j5iQ6IBJBr4cKsdYivVeLfHU3P3YZMzskk9wuAncZp7D9r04nwXZBVdVGiPm1YpPYfY2
         N2jf4VX1TM8AIV2yGM1qD2se3MInBJobK8dkgUxYif7uDxhf9MEn7chX0JdgssOB9Rd8
         FKinJfpiXb1Pm+Aw+EBlJr/WqfIeQXKFXFKTd6DsR8fwnyLkaRMLvZsGGudxLUYViaRa
         ODI5RHCqbRkCFVzA34x0nhfb+GCWdoiKd8xgTgVlz6unHoLNc7me+xKJ08/NxF1+qW3J
         RV+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714988250; x=1715593050;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YJ/i9aSextJBDewJyOG1hC8/ORRuaV5BU0FGPlg+ibI=;
        b=owHOUD3J+Nmvrhn5oEgEyp2n3JnFmwouAV2ZETuZ/bAe7U1frhTBX2ExR4VTQ6YAJ1
         dPh0MEpRcJfvYy6BVjoSuBJ1tl5sqLhEcYmzTrcKb0MySv3mf1xdDhThu1lt9SNumYN5
         QWVaWXw3XAvCOxjGgZWnCEPnV+FEsFuqRrMBJmtIwCOCCq0AgmGCZhqLu4qexfceGbBy
         30273xSHevADArHbdaU6EOOlN/UsQj/V5BpXZvg2keVwc1tpSotN5zxXfv2W9YWZ7Pej
         DJPxyKIdHKsUCELDXRpm8K49/KwzNg1j/KtpPxGwj58iSbcgNjZZ47DjJ2MgwBiwlx35
         CBvg==
X-Forwarded-Encrypted: i=1; AJvYcCVeNYSo8sOyEqrHfKM+NhHeb4GZVtxP78krRpv+3oG0bFi87cVD9ezdTR9ljmHZNgpiUp9wRY6PB56CVFkOy10BuBzpe4z2mRZPiNWllxUqYGz2vYnQMdEz7LJTLijkDAIX8TtzQTh9uQ==
X-Gm-Message-State: AOJu0YygBmuKU5B2jrZ907A4Xkbr/uhY+FukhKnyOiQbPI+Fal3zDPZo
	5uhO8mIp+oX0hMkgQ2MeQDRY9BR6rEN1qwvLfSjqnywCzxgMVMhV
X-Google-Smtp-Source: AGHT+IGmDp3zClvpYcSZX9BMZ5alfu+DnAeI8C/Ka2kdqS+p80hCz9EVcR9O2B0IHmViYyKyuGF0Gg==
X-Received: by 2002:a19:381a:0:b0:51d:3b87:70a6 with SMTP id f26-20020a19381a000000b0051d3b8770a6mr7073690lfa.13.1714988250256;
        Mon, 06 May 2024 02:37:30 -0700 (PDT)
Received: from [172.30.32.119] ([2001:8f8:183b:f2c::d35])
        by smtp.gmail.com with ESMTPSA id f6-20020a056402160600b005722ce89ae2sm4983647edv.38.2024.05.06.02.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 02:37:29 -0700 (PDT)
From: Alexey Charkov <alchark@gmail.com>
Date: Mon, 06 May 2024 13:36:37 +0400
Subject: [PATCH v4 6/6] arm64: dts: rockchip: Add OPP data for CPU cores on
 RK3588
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240506-rk-dts-additions-v4-6-271023ddfd40@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714988225; l=7420;
 i=alchark@gmail.com; s=20240125; h=from:subject:message-id;
 bh=u0gM6tgf6YzJQvPrv4bbdJjzpHgMPBoZnVPNA5o69i0=;
 b=NfzFHVbPxKtMkrjMx7ITPK0l9dIz6TK3LMlotIOo6u548b6Xuf0R6hhxasx1fOlIhVYKEcYv/
 J0vR7Nvg0SADzl2KsFF5wijg/ZINprMkziy6RTlh00QO7fHZLtRxYeE
X-Developer-Key: i=alchark@gmail.com; a=ed25519;
 pk=xRO8VeD3J5jhwe0za0aHt2LDumQr8cm0Ls7Jz3YGimk=

By default the CPUs on RK3588 start up in a conservative performance
mode. Add frequency and voltage mappings to the device tree to enable
dynamic scaling via cpufreq.

OPP values are adapted from Radxa's downstream kernel for Rock 5B [1],
stripping them down to the minimum frequency and voltage combinations
as expected by the generic upstream cpufreq-dt driver, and also dropping
those OPPs that don't differ in voltage but only in frequency (keeping
the top frequency OPP in each case).

Note that this patch ignores voltage scaling for the CPU memory
interface which the downstream kernel does through a custom cpufreq
driver, and which is why the downstream version has two sets of voltage
values for each OPP (the second one being meant for the memory
interface supply regulator). This is done instead via regulator
coupling between CPU and memory interface supplies on affected boards.

This has been tested on Rock 5B with u-boot 2023.11 compiled from
Collabora's integration tree [2] with binary bl31 and appears to be
stable both under active cooling and passive cooling (with throttling)

[1] https://github.com/radxa/kernel/blob/stable-5.10-rock5/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
[2] https://gitlab.collabora.com/hardware-enablement/rockchip-3588/u-boot

Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 122 ++++++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index 57c2d998ae75..85c25d5efdad 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -97,6 +97,7 @@ cpu_l0: cpu@0 {
 			clocks = <&scmi_clk SCMI_CLK_CPUL>;
 			assigned-clocks = <&scmi_clk SCMI_CLK_CPUL>;
 			assigned-clock-rates = <816000000>;
+			operating-points-v2 = <&cluster0_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP>;
 			i-cache-size = <32768>;
 			i-cache-line-size = <64>;
@@ -116,6 +117,7 @@ cpu_l1: cpu@100 {
 			enable-method = "psci";
 			capacity-dmips-mhz = <530>;
 			clocks = <&scmi_clk SCMI_CLK_CPUL>;
+			operating-points-v2 = <&cluster0_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP>;
 			i-cache-size = <32768>;
 			i-cache-line-size = <64>;
@@ -135,6 +137,7 @@ cpu_l2: cpu@200 {
 			enable-method = "psci";
 			capacity-dmips-mhz = <530>;
 			clocks = <&scmi_clk SCMI_CLK_CPUL>;
+			operating-points-v2 = <&cluster0_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP>;
 			i-cache-size = <32768>;
 			i-cache-line-size = <64>;
@@ -154,6 +157,7 @@ cpu_l3: cpu@300 {
 			enable-method = "psci";
 			capacity-dmips-mhz = <530>;
 			clocks = <&scmi_clk SCMI_CLK_CPUL>;
+			operating-points-v2 = <&cluster0_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP>;
 			i-cache-size = <32768>;
 			i-cache-line-size = <64>;
@@ -175,6 +179,7 @@ cpu_b0: cpu@400 {
 			clocks = <&scmi_clk SCMI_CLK_CPUB01>;
 			assigned-clocks = <&scmi_clk SCMI_CLK_CPUB01>;
 			assigned-clock-rates = <816000000>;
+			operating-points-v2 = <&cluster1_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP>;
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
@@ -194,6 +199,7 @@ cpu_b1: cpu@500 {
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
 			clocks = <&scmi_clk SCMI_CLK_CPUB01>;
+			operating-points-v2 = <&cluster1_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP>;
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
@@ -215,6 +221,7 @@ cpu_b2: cpu@600 {
 			clocks = <&scmi_clk SCMI_CLK_CPUB23>;
 			assigned-clocks = <&scmi_clk SCMI_CLK_CPUB23>;
 			assigned-clock-rates = <816000000>;
+			operating-points-v2 = <&cluster2_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP>;
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
@@ -234,6 +241,7 @@ cpu_b3: cpu@700 {
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
 			clocks = <&scmi_clk SCMI_CLK_CPUB23>;
+			operating-points-v2 = <&cluster2_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP>;
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
@@ -348,6 +356,120 @@ l3_cache: l3-cache {
 		};
 	};
 
+	cluster0_opp_table: opp-table-cluster0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-1008000000 {
+			opp-hz = /bits/ 64 <1008000000>;
+			opp-microvolt = <675000 675000 950000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <712500 712500 950000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-1416000000 {
+			opp-hz = /bits/ 64 <1416000000>;
+			opp-microvolt = <762500 762500 950000>;
+			clock-latency-ns = <40000>;
+			opp-suspend;
+		};
+		opp-1608000000 {
+			opp-hz = /bits/ 64 <1608000000>;
+			opp-microvolt = <850000 850000 950000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-1800000000 {
+			opp-hz = /bits/ 64 <1800000000>;
+			opp-microvolt = <950000 950000 950000>;
+			clock-latency-ns = <40000>;
+		};
+	};
+
+	cluster1_opp_table: opp-table-cluster1 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <675000 675000 1000000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-1416000000 {
+			opp-hz = /bits/ 64 <1416000000>;
+			opp-microvolt = <725000 725000 1000000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-1608000000 {
+			opp-hz = /bits/ 64 <1608000000>;
+			opp-microvolt = <762500 762500 1000000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-1800000000 {
+			opp-hz = /bits/ 64 <1800000000>;
+			opp-microvolt = <850000 850000 1000000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-2016000000 {
+			opp-hz = /bits/ 64 <2016000000>;
+			opp-microvolt = <925000 925000 1000000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-2208000000 {
+			opp-hz = /bits/ 64 <2208000000>;
+			opp-microvolt = <987500 987500 1000000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-2400000000 {
+			opp-hz = /bits/ 64 <2400000000>;
+			opp-microvolt = <1000000 1000000 1000000>;
+			clock-latency-ns = <40000>;
+		};
+	};
+
+	cluster2_opp_table: opp-table-cluster2 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <675000 675000 1000000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-1416000000 {
+			opp-hz = /bits/ 64 <1416000000>;
+			opp-microvolt = <725000 725000 1000000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-1608000000 {
+			opp-hz = /bits/ 64 <1608000000>;
+			opp-microvolt = <762500 762500 1000000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-1800000000 {
+			opp-hz = /bits/ 64 <1800000000>;
+			opp-microvolt = <850000 850000 1000000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-2016000000 {
+			opp-hz = /bits/ 64 <2016000000>;
+			opp-microvolt = <925000 925000 1000000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-2208000000 {
+			opp-hz = /bits/ 64 <2208000000>;
+			opp-microvolt = <987500 987500 1000000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-2400000000 {
+			opp-hz = /bits/ 64 <2400000000>;
+			opp-microvolt = <1000000 1000000 1000000>;
+			clock-latency-ns = <40000>;
+		};
+	};
+
 	display_subsystem: display-subsystem {
 		compatible = "rockchip,display-subsystem";
 		ports = <&vop_out>;

-- 
2.45.0


