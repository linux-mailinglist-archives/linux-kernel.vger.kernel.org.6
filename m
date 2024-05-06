Return-Path: <linux-kernel+bounces-169587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B118BCADB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 11:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC6251C21CF7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 09:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0175B184F;
	Mon,  6 May 2024 09:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yxtw0ROf"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A785143892;
	Mon,  6 May 2024 09:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714988250; cv=none; b=Hxy52QDtPTH48N/mcZxt4aU5Su7lTtPZfilEpmTE3447eUhd+EJZZp11cR31pnmM620tC7KJnjbRLkO8/Fx9UK7stBG8dGCNcvvTNWJG+R6WAS3BH+h1syHuQYFDrprQ8O5OfoyCIc+hqwyG8dvyUqqtgB5MbdQEMKyn6SFkuD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714988250; c=relaxed/simple;
	bh=hRIkjs6ilNO5CkTYJyMd31t+JYZiL+ZsbuuDrU+GbqI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kZu/CWsARmkKfA7Sew3f5kZPZZ8qE33QcqUbRJ6HDHrStSSjqOZpTuW2r5ml/zuAuYxwOMEh9TfljIOZSO4kJ5PoIOoXTE73zA/q7OM6IW0IsWjNOq1bJStCmGu7oPABC33/ppfVQc4xC2D0hg/y71oLwLZy8IuVMxp8ozixlxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yxtw0ROf; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a59cdf7cd78so171182366b.0;
        Mon, 06 May 2024 02:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714988247; x=1715593047; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YwJQ8VUdBqnfny8gTVz/c10Fv5YxuURKySJ0zdXA/+A=;
        b=Yxtw0ROfMjjwlnqtFzIH3nXb1zs6MPxduC0Xcttn6UFqv7eoQxdEYUbNpPNPPwwIfE
         Hg1nnBXbptdbKX5vXOm8Pkw5LGaNMTMangyOYanBX3erVXojFbH522yAwMOIJ7D7dIPp
         IFntmbk0jLlggab4lQm2UbWV9sH/Ni343+vb09x2hO1frRhsOjnMvwgWM08Rybf0xyHq
         TMmh0fJJrMrJcEStobCBIoPDIhKciRyVu5g+YwaXCOXFpG4nfTA2C8UEwH9oUmL+lr1M
         BWaZvRbHpaWCbXjJsx75tcqVDFTI3vCGC0V/G1T+ro4Xl/kqVSiwg02Rsi9jZniUOWaY
         TVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714988247; x=1715593047;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YwJQ8VUdBqnfny8gTVz/c10Fv5YxuURKySJ0zdXA/+A=;
        b=DSuw2T3AnddrDr6xxgmQwzyDMEwmtRciID6jsdUqk36aXddcJubwwe7EtGianGHmEI
         U76M78qXW5nvR91BJAxHL0rveKSjQNRikl76jag5KlZFnQ/j1NKdpL01m/hjw05qiluM
         X3D3KxB46ibMZwufgye+ZY6fzwHSEBNj9+wdpxfLrXmKeB3/teLhdnbRK6RNeKScUU0Z
         Pe0ONtESat9HGeVGeoeftejRZ/hYdD1xwjgjGrrdtBHZy/Tytn3mzSpaduiTiUtMgbnt
         HsgVIKTaedas+hcDWtadOYb3hSAzTIqrU0MxPClNklEdGs2aRZfTwRzxkpv9Q/4QoIYU
         MCXg==
X-Forwarded-Encrypted: i=1; AJvYcCXy0XkbxE2cSnaBKfWse/OmGxoMhi9j0f3dwvS4K3spGbyovgJ23dM0k+szgmneL/rDjK/0A6zWNmVkQzHbzFvBAbBb4kiGLcPqpUsMC5FxLbV70LFIagd9vFFN7U3+V7o4iTZQsMffFg==
X-Gm-Message-State: AOJu0YxW59blUdXNXcEJvVnzIc93KCUlVJj3+gor1M7Lo9pYqsEd6xcv
	XPxBNjK9pNG3/tgzvNbbuiprSrxj+rb4vaiq+t1jz+1CQb84Vmc6
X-Google-Smtp-Source: AGHT+IGl5bNbGtIncVQHCuVr3453VDHFLfzpkdJaqPBXiJN/wYUafW4SauUKLhdoaGhtK9C1HFhj4w==
X-Received: by 2002:a50:ab1a:0:b0:572:a16f:29b with SMTP id s26-20020a50ab1a000000b00572a16f029bmr5508587edc.16.1714988246738;
        Mon, 06 May 2024 02:37:26 -0700 (PDT)
Received: from [172.30.32.119] ([2001:8f8:183b:f2c::d35])
        by smtp.gmail.com with ESMTPSA id f6-20020a056402160600b005722ce89ae2sm4983647edv.38.2024.05.06.02.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 02:37:26 -0700 (PDT)
From: Alexey Charkov <alchark@gmail.com>
Date: Mon, 06 May 2024 13:36:36 +0400
Subject: [PATCH v4 5/6] arm64: dts: rockchip: Add CPU/memory regulator
 coupling for RK3588
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240506-rk-dts-additions-v4-5-271023ddfd40@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714988224; l=5927;
 i=alchark@gmail.com; s=20240125; h=from:subject:message-id;
 bh=hRIkjs6ilNO5CkTYJyMd31t+JYZiL+ZsbuuDrU+GbqI=;
 b=XVssbaVtYFgNJD/XqYSrTYailN5Ixj2qPGOg//g6Locd7JznRCRUL/ireurFFFp18tnJlooDf
 tXw2RHepzHuAmunHqLkS8cBfLNJvwfiLch3E3gsH6QRKwVokgZS+b30
X-Developer-Key: i=alchark@gmail.com; a=ed25519;
 pk=xRO8VeD3J5jhwe0za0aHt2LDumQr8cm0Ls7Jz3YGimk=

RK3588 chips allow for their CPU cores to be powered by a different
supply vs. their corresponding memory interfaces, and two of the
boards currently upstream do that (EVB1 and QuartzPro64).

The voltage of the memory interface though has to match that of the
CPU cores that use it, which downstream kernels achieve by the means
of a custom cpufreq driver which adjusts both at the same time.

It seems that regulator coupling is a more appropriate generic
interface for it, so this patch introduces coupling to affected
device trees to ensure that memory interface voltage is also updated
whenever cpufreq switches between CPU OPPs.

Note that other boards, such as Radxa Rock 5B, define both the CPU
and memory interface regulators as aliases to the same DT node, so
this doesn't apply there.

Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts    | 12 ++++++++++++
 arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts | 12 ++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
index 7c3696a3ad3a..00f660d50127 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
@@ -878,6 +878,8 @@ regulators {
 			vdd_cpu_big1_s0: dcdc-reg1 {
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-coupled-with = <&vdd_cpu_big1_mem_s0>;
+				regulator-coupled-max-spread = <10000>;
 				regulator-min-microvolt = <550000>;
 				regulator-max-microvolt = <1050000>;
 				regulator-ramp-delay = <12500>;
@@ -890,6 +892,8 @@ regulator-state-mem {
 			vdd_cpu_big0_s0: dcdc-reg2 {
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-coupled-with = <&vdd_cpu_big0_mem_s0>;
+				regulator-coupled-max-spread = <10000>;
 				regulator-min-microvolt = <550000>;
 				regulator-max-microvolt = <1050000>;
 				regulator-ramp-delay = <12500>;
@@ -902,6 +906,8 @@ regulator-state-mem {
 			vdd_cpu_lit_s0: dcdc-reg3 {
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-coupled-with = <&vdd_cpu_lit_mem_s0>;
+				regulator-coupled-max-spread = <10000>;
 				regulator-min-microvolt = <550000>;
 				regulator-max-microvolt = <950000>;
 				regulator-ramp-delay = <12500>;
@@ -926,6 +932,8 @@ regulator-state-mem {
 			vdd_cpu_big1_mem_s0: dcdc-reg5 {
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-coupled-with = <&vdd_cpu_big1_s0>;
+				regulator-coupled-max-spread = <10000>;
 				regulator-min-microvolt = <675000>;
 				regulator-max-microvolt = <1050000>;
 				regulator-ramp-delay = <12500>;
@@ -939,6 +947,8 @@ regulator-state-mem {
 			vdd_cpu_big0_mem_s0: dcdc-reg6 {
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-coupled-with = <&vdd_cpu_big0_s0>;
+				regulator-coupled-max-spread = <10000>;
 				regulator-min-microvolt = <675000>;
 				regulator-max-microvolt = <1050000>;
 				regulator-ramp-delay = <12500>;
@@ -963,6 +973,8 @@ regulator-state-mem {
 			vdd_cpu_lit_mem_s0: dcdc-reg8 {
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-coupled-with = <&vdd_cpu_lit_s0>;
+				regulator-coupled-max-spread = <10000>;
 				regulator-min-microvolt = <675000>;
 				regulator-max-microvolt = <950000>;
 				regulator-ramp-delay = <12500>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts b/arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts
index b4f22d95ac0e..baeb08d665c7 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts
@@ -832,6 +832,8 @@ vdd_cpu_big1_s0: dcdc-reg1 {
 				regulator-name = "vdd_cpu_big1_s0";
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-coupled-with = <&vdd_cpu_big1_mem_s0>;
+				regulator-coupled-max-spread = <10000>;
 				regulator-min-microvolt = <550000>;
 				regulator-max-microvolt = <1050000>;
 				regulator-ramp-delay = <12500>;
@@ -845,6 +847,8 @@ vdd_cpu_big0_s0: dcdc-reg2 {
 				regulator-name = "vdd_cpu_big0_s0";
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-coupled-with = <&vdd_cpu_big0_mem_s0>;
+				regulator-coupled-max-spread = <10000>;
 				regulator-min-microvolt = <550000>;
 				regulator-max-microvolt = <1050000>;
 				regulator-ramp-delay = <12500>;
@@ -858,6 +862,8 @@ vdd_cpu_lit_s0: dcdc-reg3 {
 				regulator-name = "vdd_cpu_lit_s0";
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-coupled-with = <&vdd_cpu_lit_mem_s0>;
+				regulator-coupled-max-spread = <10000>;
 				regulator-min-microvolt = <550000>;
 				regulator-max-microvolt = <950000>;
 				regulator-ramp-delay = <12500>;
@@ -884,6 +890,8 @@ vdd_cpu_big1_mem_s0: dcdc-reg5 {
 				regulator-name = "vdd_cpu_big1_mem_s0";
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-coupled-with = <&vdd_cpu_big1_s0>;
+				regulator-coupled-max-spread = <10000>;
 				regulator-min-microvolt = <675000>;
 				regulator-max-microvolt = <1050000>;
 				regulator-ramp-delay = <12500>;
@@ -898,6 +906,8 @@ vdd_cpu_big0_mem_s0: dcdc-reg6 {
 				regulator-name = "vdd_cpu_big0_mem_s0";
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-coupled-with = <&vdd_cpu_big0_s0>;
+				regulator-coupled-max-spread = <10000>;
 				regulator-min-microvolt = <675000>;
 				regulator-max-microvolt = <1050000>;
 				regulator-ramp-delay = <12500>;
@@ -924,6 +934,8 @@ vdd_cpu_lit_mem_s0: dcdc-reg8 {
 				regulator-name = "vdd_cpu_lit_mem_s0";
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-coupled-with = <&vdd_cpu_lit_s0>;
+				regulator-coupled-max-spread = <10000>;
 				regulator-min-microvolt = <675000>;
 				regulator-max-microvolt = <950000>;
 				regulator-ramp-delay = <12500>;

-- 
2.45.0


