Return-Path: <linux-kernel+bounces-234828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD3291CB35
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 07:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E5391C21ABC
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 05:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7834A22EED;
	Sat, 29 Jun 2024 05:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="LgVPg2P8"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EA618EAB;
	Sat, 29 Jun 2024 05:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719637895; cv=none; b=bwfVJ2T7ltoE3fBkzreWY5ZdLdT20qlf7Scjd1M/KEv5k+VvkUon9XfrX9q0q+b5tFe6icxpWtA4LOVjjmXvX0qPNVEq7nbbh6R1eCmAofYjiwpWVDDzPNASFUH3GNEBvnSFP4lKXo2v/L2zOXZRYjEYda3uXf7GytMJ06EeFrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719637895; c=relaxed/simple;
	bh=PepY8FutcEHTK64vBI/TVsIZxKttZLcTWh3fPowGdjk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GHhf0VgtxdzqQVldxthcLUg02HXH9w3rXZkTueX7IufvzEvCFWJylx6qZxiGN45dyMI6nIHb8105VGc1CQFTiwM62oeXmV1yybgWnPwzkICSex4OLpl29LFO/YJL/JkZB4nu3lmN5hUG3L4HTrsKFm/FmX6eYQA8swWIZgfW29k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=LgVPg2P8; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1719637891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WHRekKF7eXGmvHSc7nEn4oAgdoP45m8Dm3JiZHGZGlQ=;
	b=LgVPg2P8Cimn62bziz6ZB8CW9s1+VTQQJXA42TzQIFFRS4V4ITGeYdu9X/ieiA2QiCMQFH
	lLQis3OSGFOVmXZEbQ7SperH7aNsutnxc8MEBIfCvg/OrOgKPN1nsF8rLTDo1AuB/OxXSJ
	URIWXe8XmcuaOUWySy6g+yFHkTCE1Z1cmahP3/0QldcvIMtkYMiC+TjsE84U65f4JPUBfb
	YQuKTpu8/EAOrFKeNrXsY4jwOZflwDyv56+rwKEwYIR1eGIYO6Q2tusJOo9NLZyVGO1Kx/
	NI9p7YmA52lpt91NwkzaoRlE349sPGkyimTQER3eroiRvCwQxLrN2TnCwfVPmA==
To: linux-rockchip@lists.infradead.org
Cc: heiko@sntech.de,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	Diederik de Haas <didi.debian@cknow.org>,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH] arm64: dts: rockchip: Add optional GPU OPP voltage ranges to RK356x SoC dtsi
Date: Sat, 29 Jun 2024 07:11:24 +0200
Message-Id: <446399362bd2dbeeaecd8351f68811165429749a.1719637113.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Add optional support for voltage ranges to the GPU OPPs defined in the SoC
dtsi for RK356x.  These voltage ranges are useful for RK356x-based boards that
are designed to use the same power supply for the GPU and NPU portions of the
SoC, which is described further in the following documents from Rockchip:

  - Rockchip RK3566 Hardware Design Guide, version 1.1.0, page 37
  - Rockchip RK3568 Hardware Design Guide, version 1.2, page 78

The values for the exact GPU OPP voltages and the lower limits for the GPU
OPP voltage ranges differ from the values found in the vendor kernel source
(cf. downstream commit f8b9431ee38e ("arm64: dts: rockchip: rk3568: support
adjust opp-table by otp")). [1][2]  However, our values have served us well
so far, so let's keep them for now, until we actually start supporting the
CPU and GPU binning, together with the related voltage adjustments.

No functional changes are introduced, which was validated by decompiling and
comparing all affected dtb files before and after these changes.

[1] https://github.com/rockchip-linux/kernel/commit/f8b9431ee38ed561650be7092ab93f564598daa9
[2] https://raw.githubusercontent.com/rockchip-linux/kernel/f8b9431ee38ed561650be7092ab93f564598daa9/arch/arm64/boot/dts/rockchip/rk3568.dtsi

Suggested-by: Diederik de Haas <didi.debian@cknow.org>
Helped-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 38 ++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index d8543b5557ee..febda473dc38 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -1,5 +1,11 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
+ * The defined GPU OPPs optionally support voltage ranges, which are useful
+ * for RK356x-based boards that are designed to use the same power supply for
+ * the GPU and NPU portions of the SoC.  To use GPU OPPs with voltage ranges
+ * on such boards, define the RK356X_GPU_NPU_SHARED_REGULATOR macro in the
+ * descendant board dts(i) file, before including this file.
+ *
  * Copyright (c) 2021 Rockchip Electronics Co., Ltd.
  */
 
@@ -193,6 +199,7 @@ scmi_clk: protocol@14 {
 	gpu_opp_table: opp-table-1 {
 		compatible = "operating-points-v2";
 
+#ifndef RK356X_GPU_NPU_SHARED_REGULATOR
 		opp-200000000 {
 			opp-hz = /bits/ 64 <200000000>;
 			opp-microvolt = <825000>;
@@ -222,6 +229,37 @@ opp-800000000 {
 			opp-hz = /bits/ 64 <800000000>;
 			opp-microvolt = <1000000>;
 		};
+#else
+		opp-200000000 {
+			opp-hz = /bits/ 64 <200000000>;
+			opp-microvolt = <825000 825000 1000000>;
+		};
+
+		opp-300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			opp-microvolt = <825000 825000 1000000>;
+		};
+
+		opp-400000000 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-microvolt = <825000 825000 1000000>;
+		};
+
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <825000 825000 1000000>;
+		};
+
+		opp-700000000 {
+			opp-hz = /bits/ 64 <700000000>;
+			opp-microvolt = <900000 900000 1000000>;
+		};
+
+		opp-800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <1000000 1000000 1000000>;
+		};
+#endif /* RK356X_GPU_NPU_SHARED_REGULATOR */
 	};
 
 	hdmi_sound: hdmi-sound {

