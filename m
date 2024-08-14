Return-Path: <linux-kernel+bounces-285901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFEA95140D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 07:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DDF0B21987
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 05:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C71638DCD;
	Wed, 14 Aug 2024 05:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="XgXyP/p0"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804982E651;
	Wed, 14 Aug 2024 05:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723614727; cv=none; b=rvHmjia7cl93ffZh322DOPrgLEekQq0++6k4w6vmakvgNRAJe24599Mk4HPxEKwXo2R+tbQQLmh1ebVYMma5gMztm0TC3pLCxzEnLjD/JQTqG/FoE2QOsU0dW4aVf7XSndYWthIqmaOom5bKEoKDjrpVSiYgoBhliecskCMe72A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723614727; c=relaxed/simple;
	bh=vKr4njxChGH7XymCEP/EvWnV1ETj2mdqrmr2lPkEq8o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WZOsNqI7kH/5zbMD+9zr6YoSuuL2lhAScXv2l935M6sqVexGSiDSeF0tOy8A/wtqncxxlSbqbv01mkgdvoL5E85jKCV2+9JzYxuVSSIqYFXMgmuYMw7oQwPTen1bpsU6dt9ESfIXU+WLgx7gls+04yyYrwnPYiF7XV9KIy/5OjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=XgXyP/p0; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1723614721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=smGTUgrDMJsloxjngBCXgAlvZKKZjQGim339zUexF1w=;
	b=XgXyP/p0+7MLyRshVqDrXy0f9+MDty5oQdFOYTohZtW9svCGfsIb7J+SAVxrJtWoUc8GOu
	J5+KiIErgtUJ4ou6eYjS3/u9Rd8WMZ/bkrB01Ev8QdIBgVfjeAXn69Hw2DiudNQmnQa9uN
	+j78IWV6XOlwnrzNSulgKAVkG3pAF3KQjN1LO0j/SCfxpFrGvWWPf8ULyP1gAO8DKCqIx4
	wTBAYanJonrEOy1eII9amsYKTOvDpCsmuTsvMLy5j9wBUy0eXkuvz1SX/s5JoNXtMU0BD1
	b2I3KUF9lVYsyA/PPSNpJdvIh7GXI60U2nVkjBqQSFruFwekwI1aD7pw36c5tg==
To: linux-sunxi@lists.linux.dev
Cc: wens@csie.org,
	jernej.skrabec@gmail.com,
	samuel@sholland.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: allwinner: a64: Move CPU OPPs to the SoC dtsi file
Date: Wed, 14 Aug 2024 07:51:54 +0200
Message-Id: <92ebc9cba6eb669df73efd478e4f5745056a4ce5.1723614345.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Move the Allwinner A64 CPU OPPs to the A64 SoC dtsi file and, consequently,
adjust the contents of the affected board dts(i) files appropriately, to
"encapsulate" the CPU OPPs into the SoC dtsi file.

Moving the CPU OPPs to the SoC dtsi file, instead of requiring the board
dts(i) files to include both the SoC dtsi file and the CPU OPP dtsi file,
reduces the possibility for incomplete SoC data inclusion and improves the
overall hierarchical representation of data.  Moreover, the CPU OPPs are
not used anywhere but together with the SoC dtsi file, which additionally
justifies the folding of the CPU OPPs into the SoC dtsi file.

No functional changes are introduced, which was validated by decompiling and
comparing all affected board dtb files before and after these changes.  When
compared with the decompiled original dtb files, the updated dtb files have
some of their blocks shuffled around a bit and some of their phandles have
different values, as a result of the changes to the order in which the
building blocks from the parent dtsi files are included into them, but they
still effectively remain the same as the originals.

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---

Notes:
    These changes follow the general approach used for the Rockchip RK3588
    and RK3399 SoCs, which was introduced and described further in commits
    def88eb4d836 ("arm64: dts: rockchip: Prepare RK3588 SoC dtsi files for
    per-variant OPPs") [1] and 296602b8e5f7 ("arm64: dts: rockchip: Move
    RK3399 OPPs to dtsi files for SoC variants"), [2] respectively.  Please
    see those commits for a more detailed explanation.
    
    [1] https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git/commit/?h=for-next&id=def88eb4d8365a4aa064d28405d03550a9d0a3be
    [2] https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git/commit/?h=for-next&id=296602b8e5f715d6a0ccdcd37d57170c2c81d5e4

 .../allwinner/sun50i-a64-amarula-relic.dts    |  2 -
 .../dts/allwinner/sun50i-a64-bananapi-m64.dts |  2 -
 .../dts/allwinner/sun50i-a64-cpu-opp.dtsi     | 75 -------------------
 .../dts/allwinner/sun50i-a64-nanopi-a64.dts   |  2 -
 .../dts/allwinner/sun50i-a64-olinuxino.dts    |  2 -
 .../dts/allwinner/sun50i-a64-orangepi-win.dts |  2 -
 .../boot/dts/allwinner/sun50i-a64-pine64.dts  |  2 -
 .../dts/allwinner/sun50i-a64-pinebook.dts     |  2 -
 .../dts/allwinner/sun50i-a64-pinephone.dtsi   |  2 -
 .../boot/dts/allwinner/sun50i-a64-pinetab.dts |  2 -
 .../boot/dts/allwinner/sun50i-a64-sopine.dtsi |  2 -
 .../boot/dts/allwinner/sun50i-a64-teres-i.dts |  2 -
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 66 +++++++++++++++-
 .../allwinner/sun50i-h64-remix-mini-pc.dts    |  2 -
 14 files changed, 63 insertions(+), 102 deletions(-)
 delete mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-cpu-opp.dtsi

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
index 8233582f6288..1590a455683f 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
@@ -5,8 +5,6 @@
 /dts-v1/;
 
 #include "sun50i-a64.dtsi"
-#include "sun50i-a64-cpu-opp.dtsi"
-
 #include <dt-bindings/gpio/gpio.h>
 
 / {
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
index d1f415acd7b5..869fd4a50582 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
@@ -4,8 +4,6 @@
 /dts-v1/;
 
 #include "sun50i-a64.dtsi"
-#include "sun50i-a64-cpu-opp.dtsi"
-
 #include <dt-bindings/gpio/gpio.h>
 
 / {
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-cpu-opp.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-cpu-opp.dtsi
deleted file mode 100644
index e39db51eb448..000000000000
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-cpu-opp.dtsi
+++ /dev/null
@@ -1,75 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2020 Vasily khoruzhick <anarsoul@gmail.com>
- */
-
-/ {
-	cpu0_opp_table: opp-table-cpu {
-		compatible = "operating-points-v2";
-		opp-shared;
-
-		opp-648000000 {
-			opp-hz = /bits/ 64 <648000000>;
-			opp-microvolt = <1040000>;
-			clock-latency-ns = <244144>; /* 8 32k periods */
-		};
-
-		opp-816000000 {
-			opp-hz = /bits/ 64 <816000000>;
-			opp-microvolt = <1100000>;
-			clock-latency-ns = <244144>; /* 8 32k periods */
-		};
-
-		opp-912000000 {
-			opp-hz = /bits/ 64 <912000000>;
-			opp-microvolt = <1120000>;
-			clock-latency-ns = <244144>; /* 8 32k periods */
-		};
-
-		opp-960000000 {
-			opp-hz = /bits/ 64 <960000000>;
-			opp-microvolt = <1160000>;
-			clock-latency-ns = <244144>; /* 8 32k periods */
-		};
-
-		opp-1008000000 {
-			opp-hz = /bits/ 64 <1008000000>;
-			opp-microvolt = <1200000>;
-			clock-latency-ns = <244144>; /* 8 32k periods */
-		};
-
-		opp-1056000000 {
-			opp-hz = /bits/ 64 <1056000000>;
-			opp-microvolt = <1240000>;
-			clock-latency-ns = <244144>; /* 8 32k periods */
-		};
-
-		opp-1104000000 {
-			opp-hz = /bits/ 64 <1104000000>;
-			opp-microvolt = <1260000>;
-			clock-latency-ns = <244144>; /* 8 32k periods */
-		};
-
-		opp-1152000000 {
-			opp-hz = /bits/ 64 <1152000000>;
-			opp-microvolt = <1300000>;
-			clock-latency-ns = <244144>; /* 8 32k periods */
-		};
-	};
-};
-
-&cpu0 {
-	operating-points-v2 = <&cpu0_opp_table>;
-};
-
-&cpu1 {
-	operating-points-v2 = <&cpu0_opp_table>;
-};
-
-&cpu2 {
-	operating-points-v2 = <&cpu0_opp_table>;
-};
-
-&cpu3 {
-	operating-points-v2 = <&cpu0_opp_table>;
-};
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
index dec9960a7440..e3b1943f7f63 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
@@ -4,8 +4,6 @@
 /dts-v1/;
 
 #include "sun50i-a64.dtsi"
-#include "sun50i-a64-cpu-opp.dtsi"
-
 #include <dt-bindings/gpio/gpio.h>
 
 / {
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
index fd3794678c33..f1a4a9ab295b 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
@@ -4,8 +4,6 @@
 /dts-v1/;
 
 #include "sun50i-a64.dtsi"
-#include "sun50i-a64-cpu-opp.dtsi"
-
 #include <dt-bindings/gpio/gpio.h>
 
 / {
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
index c8303a66438d..f3c9a3534612 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
@@ -5,8 +5,6 @@
 /dts-v1/;
 
 #include "sun50i-a64.dtsi"
-#include "sun50i-a64-cpu-opp.dtsi"
-
 #include <dt-bindings/gpio/gpio.h>
 
 / {
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
index 09e71fd60785..4f65eec043d0 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
@@ -4,8 +4,6 @@
 /dts-v1/;
 
 #include "sun50i-a64.dtsi"
-#include "sun50i-a64-cpu-opp.dtsi"
-
 #include <dt-bindings/gpio/gpio.h>
 
 / {
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
index 379c2c8466f5..a06a0b34bd3f 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
@@ -5,8 +5,6 @@
 /dts-v1/;
 
 #include "sun50i-a64.dtsi"
-#include "sun50i-a64-cpu-opp.dtsi"
-
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/gpio-keys.h>
 #include <dt-bindings/input/input.h>
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
index 6eab61a12cd8..0e38cd02a90a 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
@@ -4,8 +4,6 @@
 // Copyright (C) 2020 Ondrej Jirman <megous@megous.com>
 
 #include "sun50i-a64.dtsi"
-#include "sun50i-a64-cpu-opp.dtsi"
-
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/leds/common.h>
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
index f5fb1ee32dad..4a49f137885b 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
@@ -7,8 +7,6 @@
 /dts-v1/;
 
 #include "sun50i-a64.dtsi"
-#include "sun50i-a64-cpu-opp.dtsi"
-
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/pwm/pwm.h>
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
index 6d78a1c98f10..4ba5c11e6870 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
@@ -4,8 +4,6 @@
 //   Copyright (c) 2016 ARM Ltd.
 
 #include "sun50i-a64.dtsi"
-#include "sun50i-a64-cpu-opp.dtsi"
-
 #include <dt-bindings/gpio/gpio.h>
 
 &codec_analog {
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
index b407e1dd08a7..61ccd90bae01 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
@@ -5,8 +5,6 @@
 /dts-v1/;
 
 #include "sun50i-a64.dtsi"
-#include "sun50i-a64-cpu-opp.dtsi"
-
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/pwm/pwm.h>
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index e868ca5ae753..f842e64562b7 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -1,7 +1,10 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-// Copyright (C) 2016 ARM Ltd.
-// based on the Allwinner H3 dtsi:
-//    Copyright (C) 2015 Jens Kuske <jenskuske@gmail.com>
+/*
+ * Copyright (C) 2016 ARM Ltd.
+ * based on the Allwinner H3 dtsi:
+ *    Copyright (C) 2015 Jens Kuske <jenskuske@gmail.com>
+ * Copyright (C) 2020 Vasily khoruzhick <anarsoul@gmail.com>
+ */
 
 #include <dt-bindings/clock/sun50i-a64-ccu.h>
 #include <dt-bindings/clock/sun6i-rtc.h>
@@ -54,6 +57,7 @@ cpu0: cpu@0 {
 			clocks = <&ccu CLK_CPUX>;
 			clock-names = "cpu";
 			#cooling-cells = <2>;
+			operating-points-v2 = <&cpu_opp_table>;
 			i-cache-size = <0x8000>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -71,6 +75,7 @@ cpu1: cpu@1 {
 			clocks = <&ccu CLK_CPUX>;
 			clock-names = "cpu";
 			#cooling-cells = <2>;
+			operating-points-v2 = <&cpu_opp_table>;
 			i-cache-size = <0x8000>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -88,6 +93,7 @@ cpu2: cpu@2 {
 			clocks = <&ccu CLK_CPUX>;
 			clock-names = "cpu";
 			#cooling-cells = <2>;
+			operating-points-v2 = <&cpu_opp_table>;
 			i-cache-size = <0x8000>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -105,6 +111,7 @@ cpu3: cpu@3 {
 			clocks = <&ccu CLK_CPUX>;
 			clock-names = "cpu";
 			#cooling-cells = <2>;
+			operating-points-v2 = <&cpu_opp_table>;
 			i-cache-size = <0x8000>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -124,6 +131,59 @@ l2_cache: l2-cache {
 		};
 	};
 
+	cpu_opp_table: opp-table-cpu {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-648000000 {
+			opp-hz = /bits/ 64 <648000000>;
+			opp-microvolt = <1040000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp-816000000 {
+			opp-hz = /bits/ 64 <816000000>;
+			opp-microvolt = <1100000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp-912000000 {
+			opp-hz = /bits/ 64 <912000000>;
+			opp-microvolt = <1120000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp-960000000 {
+			opp-hz = /bits/ 64 <960000000>;
+			opp-microvolt = <1160000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp-1008000000 {
+			opp-hz = /bits/ 64 <1008000000>;
+			opp-microvolt = <1200000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp-1056000000 {
+			opp-hz = /bits/ 64 <1056000000>;
+			opp-microvolt = <1240000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp-1104000000 {
+			opp-hz = /bits/ 64 <1104000000>;
+			opp-microvolt = <1260000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp-1152000000 {
+			opp-hz = /bits/ 64 <1152000000>;
+			opp-microvolt = <1300000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+	};
+
 	de: display-engine {
 		compatible = "allwinner,sun50i-a64-display-engine";
 		allwinner,pipelines = <&mixer0>,
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h64-remix-mini-pc.dts b/arch/arm64/boot/dts/allwinner/sun50i-h64-remix-mini-pc.dts
index ce90327e1b2e..19cb74cf1f57 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h64-remix-mini-pc.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h64-remix-mini-pc.dts
@@ -4,8 +4,6 @@
 /dts-v1/;
 
 #include "sun50i-a64.dtsi"
-#include "sun50i-a64-cpu-opp.dtsi"
-
 #include <dt-bindings/gpio/gpio.h>
 
 / {

