Return-Path: <linux-kernel+bounces-427504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E84C9E022C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 13:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39728169BE0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 12:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C940F1FC7C5;
	Mon,  2 Dec 2024 12:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="po4mQBHY"
Received: from mxout4.routing.net (mxout4.routing.net [134.0.28.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29401FF5F5;
	Mon,  2 Dec 2024 12:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733142379; cv=none; b=hYl6JaXEDbp1CEXnSCkKBcFeg7yGPRPIzz1kz7RXLbapx7v3hR83asdlQ8jo02z0K7GM/A//6iAMfo3GKnJgVYVrskidRN6FmehrnKHUdXlgc8Xg8l8kNPwP3dWdLQ3T/RfiOee8KMuJX+TNFoa/VqT1Fmm51ve1wgOzj8oFrsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733142379; c=relaxed/simple;
	bh=ENgHeENLle3FC10bHq75cMGr5V+eE8NmP73tZiYxnpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K2NorhTw81UnG3ReuBPhQr2qt8kL2Y2RCXQMcTfupAjSb0+U6VVRsJbdDl5txg124yVPsfdW8jVLYMnbqm/PYFud1BB//wiPfbk9sH2uEjkdgxZiB20NInnPwhddqtNZw/yE8GEEWxAFw4l23pXDQ5PF77kuEGqpwguMsp1e5z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=po4mQBHY; arc=none smtp.client-ip=134.0.28.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
	by mxout4.routing.net (Postfix) with ESMTP id F1D62100943;
	Mon,  2 Dec 2024 12:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1733142376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lGxVt+qQLZJkkFVJS2L97CoPUefk9As7+zZxbYek0c8=;
	b=po4mQBHYl7lFfmFdq5DxcaZX8ZmcVwp9Bgw8a4GYvmCyzvdvRW9/h3NRb+9B7q7Oevt5oT
	mL/G+xE1mR6NsgUFStHYiQNXOUedUweP2q/G96sv3yM5PnRYyJi+fVC9MWW18jK4vXVGKW
	C3MMHecOcjWjaiCvPXAaOmaB2a4stPs=
Received: from frank-u24.. (fttx-pool-217.61.149.104.bambit.de [217.61.149.104])
	by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 48496360211;
	Mon,  2 Dec 2024 12:26:15 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 09/18] arm64: dts: mediatek: mt7988: add operating-points
Date: Mon,  2 Dec 2024 13:25:50 +0100
Message-ID: <20241202122602.30734-10-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241202122602.30734-1-linux@fw-web.de>
References: <20241202122602.30734-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: dca3eac9-8f12-478a-ae0e-dd080f463b3a

From: Frank Wunderlich <frank-w@public-files.de>

Add operating points defining frequency/voltages of cpu cores.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
changes:
v2:
- drop cpu-labels for now
---
 arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 38 +++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
index 2af440510c86..5609e3619be9 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
@@ -21,6 +21,10 @@ cpu@0 {
 			reg = <0x0>;
 			device_type = "cpu";
 			enable-method = "psci";
+			clocks = <&mcusys CLK_MCU_ARM_DIV_SEL>,
+				 <&topckgen CLK_TOP_XTAL>;
+			clock-names = "cpu", "intermediate";
+			operating-points-v2 = <&cluster0_opp>;
 		};
 
 		cpu@1 {
@@ -28,6 +32,10 @@ cpu@1 {
 			reg = <0x1>;
 			device_type = "cpu";
 			enable-method = "psci";
+			clocks = <&mcusys CLK_MCU_ARM_DIV_SEL>,
+				 <&topckgen CLK_TOP_XTAL>;
+			clock-names = "cpu", "intermediate";
+			operating-points-v2 = <&cluster0_opp>;
 		};
 
 		cpu@2 {
@@ -35,6 +43,10 @@ cpu@2 {
 			reg = <0x2>;
 			device_type = "cpu";
 			enable-method = "psci";
+			clocks = <&mcusys CLK_MCU_ARM_DIV_SEL>,
+				 <&topckgen CLK_TOP_XTAL>;
+			clock-names = "cpu", "intermediate";
+			operating-points-v2 = <&cluster0_opp>;
 		};
 
 		cpu@3 {
@@ -42,6 +54,32 @@ cpu@3 {
 			reg = <0x3>;
 			device_type = "cpu";
 			enable-method = "psci";
+			clocks = <&mcusys CLK_MCU_ARM_DIV_SEL>,
+				 <&topckgen CLK_TOP_XTAL>;
+			clock-names = "cpu", "intermediate";
+			operating-points-v2 = <&cluster0_opp>;
+		};
+
+		cluster0_opp: opp-table-0 {
+			compatible = "operating-points-v2";
+			opp-shared;
+
+			opp-800000000 {
+				opp-hz = /bits/ 64 <800000000>;
+				opp-microvolt = <850000>;
+			};
+			opp-1100000000 {
+				opp-hz = /bits/ 64 <1100000000>;
+				opp-microvolt = <850000>;
+			};
+			opp-1500000000 {
+				opp-hz = /bits/ 64 <1500000000>;
+				opp-microvolt = <850000>;
+			};
+			opp-1800000000 {
+				opp-hz = /bits/ 64 <1800000000>;
+				opp-microvolt = <900000>;
+			};
 		};
 	};
 
-- 
2.43.0


