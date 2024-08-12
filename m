Return-Path: <linux-kernel+bounces-282483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A3C94E497
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 04:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 638CBB212F1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 02:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFFB6A33F;
	Mon, 12 Aug 2024 02:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="wpIwxb4e"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7BA3FD4;
	Mon, 12 Aug 2024 02:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723428029; cv=none; b=Bpm4T0Yhha8ARJh+MiTTcanPP1k9ytMfo+6TOasmVOJPI18cwjvs9U+cUU74qj24OuWwpWEOhIop/ofYQOdSEZiwkGzIG2CrllD4/zkad6utbkCYtahby2PJl+s1lm6zZqbLQoyKNzsADj8kNuxuIchBQX1SpO8G2QCclIaYbJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723428029; c=relaxed/simple;
	bh=LTqswOMYIvuMSo69TxBE4FFx+VdMdKLPpGZu0+5lvU0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ooNXn/Elf9o+j6qdZG750pIwG0G1yJljg5VMWeXF5rTxBqtFAfR7YiMXGdNslHiSBnfnGt6HUZQuVlmHDaU6pLUZkKoy1uN9Bow4+kAmX5wuUYJ2qAbz+XmLHtzc3uhvTidGLy0M/I1IlaY3GyQ8pksK/FZ9bHSQGEJRp7cvo10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=wpIwxb4e; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1723428025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RKcmkKHprKaGo3TWBWY608Q1owHtNCcC2SHOqOY293I=;
	b=wpIwxb4eGG3D+c3GHnXUf2CVr2ZT5w5LkFjXVbn6V+OdSXmxFIYnbfF7h/0LsrPP4zw0lr
	1ioc2dY0WgyiIUs571TB5lTB0FbbBkluaAwCU+hR3uVzQYRDcbk/xt6Wp1WuGwq5o8fDIC
	NXZswVRI0U1qFgTCfdGgnsiJ24zqaitL0yMrOLttPSkRLp2DlHkseCGX3WbdNy4GgEwWXW
	s7YcdmGWaSbZayrdsswAwDQQR8L5TLP7t+gYYlVrpuIsHQ2fNB6GE5tm+Cr7S9RgqRwk9Q
	D11j34PSBO++joPeH7pImp0P9Zhd6fhzgVZH+SDGwYh29uHZYirse4erlMYR4w==
To: linux-sunxi@lists.linux.dev
Cc: wens@csie.org,
	jernej.skrabec@gmail.com,
	samuel@sholland.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	uwu@icenowy.me,
	wenst@chromium.org,
	broonie@kernel.org
Subject: [PATCH] arm64: dts: allwinner: Add GPU thermal trips to the SoC dtsi for A64
Date: Mon, 12 Aug 2024 04:00:20 +0200
Message-Id: <a17e0df64c5b976b47f19c5a29c02759cd9e5b8c.1723427375.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Add thermal trips for the two GPU thermal sensors found in the Allwinner A64.
There's only one GPU OPP defined since the commit 1428f0c19f9c ("arm64: dts:
allwinner: a64: Run GPU at 432 MHz"), so defining only the critical thermal
trips makes sense for the A64's two GPU thermal zones.

Having these critical thermal trips defined ensures that no hot spots develop
inside the SoC die that exceed the maximum junction temperature.  That might
have been possible before, although quite unlikely, because the CPU and GPU
portions of the SoC are packed closely inside the SoC, so the overheating GPU
would inevitably result in the heat soaking into the CPU portion of the SoC,
causing the CPU thermal sensor to return high readings and trigger the CPU
critical thermal trips.  However, it's better not to rely on the heat soak
and have the critical GPU thermal trips properly defined instead.

While there, remove a few spotted comments that are rather redundant, because
it's pretty much obvious what units are used in those places.

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 22 ++++++++++++++-----
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index e868ca5ae753..bc5d3a2e6c98 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -212,7 +212,6 @@ timer {
 
 	thermal-zones {
 		cpu_thermal: cpu0-thermal {
-			/* milliseconds */
 			polling-delay-passive = <0>;
 			polling-delay = <0>;
 			thermal-sensors = <&ths 0>;
@@ -236,40 +235,51 @@ map1 {
 
 			trips {
 				cpu_alert0: cpu-alert0 {
-					/* milliCelsius */
 					temperature = <75000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
 				cpu_alert1: cpu-alert1 {
-					/* milliCelsius */
 					temperature = <90000>;
 					hysteresis = <2000>;
 					type = "hot";
 				};
 
 				cpu_crit: cpu-crit {
-					/* milliCelsius */
 					temperature = <110000>;
 					hysteresis = <2000>;
 					type = "critical";
 				};
 			};
 		};
 
 		gpu0_thermal: gpu0-thermal {
-			/* milliseconds */
 			polling-delay-passive = <0>;
 			polling-delay = <0>;
 			thermal-sensors = <&ths 1>;
+
+			trips {
+				gpu0_crit: gpu0-crit {
+					temperature = <110000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
 		};
 
 		gpu1_thermal: gpu1-thermal {
-			/* milliseconds */
 			polling-delay-passive = <0>;
 			polling-delay = <0>;
 			thermal-sensors = <&ths 2>;
+
+			trips {
+				gpu1_crit: gpu1-crit {
+					temperature = <110000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
 		};
 	};
 

