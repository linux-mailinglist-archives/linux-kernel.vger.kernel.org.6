Return-Path: <linux-kernel+bounces-386698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A0E9B4717
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E00D9B22683
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFC8205E25;
	Tue, 29 Oct 2024 10:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="DdGus3Q3"
Received: from mxout1.routing.net (mxout1.routing.net [134.0.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9182205147;
	Tue, 29 Oct 2024 10:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730198398; cv=none; b=MBitMXbtnJNET7tKperzKEDtdkCdafyDKa+OOnW03DM+tZYj/5eC7IeV/LAL9tEvdm5HkEZOpvwaKT0UbaNd1O6Rglk5IX5WhvMGmfbM+RcY2XGc/SC7UW1yo4gfB/767+smYjYMw3hMYCE6t8NVaFzX+lIxm6xoh1xFwtmmdaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730198398; c=relaxed/simple;
	bh=fYqMVYDiz9oOKhL3cqeIHsxYcUtuK9DoE2PMWL2Lc+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A9BXYVdAcs/GsQrPlrkQHYEe1SSZArw4rpnd8ICmzjRELghmvt94X/3SfUXEK1uJJSJdELiMQlhg/+BtLIj0tDz15tPIilsl2XHqbxtpPNlrTy0+mHBLO0lwiglt+IJXMaw7WN8CmM2gcqGqCOp8FWAFMti+Yh0pwTVT8VM28vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=DdGus3Q3; arc=none smtp.client-ip=134.0.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
	by mxout1.routing.net (Postfix) with ESMTP id C62984070F;
	Tue, 29 Oct 2024 10:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1730198391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CkpUh/XPSwiAqciWUfYgDTDUp1kYHTLS66y+Kq607kQ=;
	b=DdGus3Q3+7b7nRhcxiapQHFi9SiYsFuppqE5lcCPIJte2EFFmye6Kiuut6MfiYzJ/ew/iZ
	nQN2FCFfQOSENatE2fEZTsHmEQagyl2E/wq290kUOCiIt8YV+TgdqgFtg3MDeMar0RP469
	RHOLWWLpcoH23Onh4hSkpopH0Z5PFE0=
Received: from frank-u24.. (fttx-pool-80.245.73.173.bambit.de [80.245.73.173])
	by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 327F136037C;
	Tue, 29 Oct 2024 10:39:51 +0000 (UTC)
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
Subject: [RFC v1 14/14] arm64: dts: mediatek: mt7988: add operating-points
Date: Tue, 29 Oct 2024 11:39:33 +0100
Message-ID: <20241029103937.45852-15-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241029103937.45852-1-linux@fw-web.de>
References: <20241029103937.45852-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 72750c8e-3dcc-4bb0-bbdf-e9206e8bffeb

From: Frank Wunderlich <frank-w@public-files.de>

Add operating points defining frequency/voltages of cpu cores.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 45 +++++++++++++++++++++--
 1 file changed, 41 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
index e037854666c1..25669d498617 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
@@ -16,32 +16,69 @@ cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu@0 {
+		cpu0: cpu@0 {
 			compatible = "arm,cortex-a73";
 			reg = <0x0>;
 			device_type = "cpu";
 			enable-method = "psci";
+			clocks = <&mcusys CLK_MCU_ARM_DIV_SEL>,
+				 <&topckgen CLK_TOP_XTAL>;
+			clock-names = "cpu", "intermediate";
+			operating-points-v2 = <&cluster0_opp>;
 		};
 
-		cpu@1 {
+		cpu1: cpu@1 {
 			compatible = "arm,cortex-a73";
 			reg = <0x1>;
 			device_type = "cpu";
 			enable-method = "psci";
+			clocks = <&mcusys CLK_MCU_ARM_DIV_SEL>,
+				 <&topckgen CLK_TOP_XTAL>;
+			clock-names = "cpu", "intermediate";
+			operating-points-v2 = <&cluster0_opp>;
 		};
 
-		cpu@2 {
+		cpu2: cpu@2 {
 			compatible = "arm,cortex-a73";
 			reg = <0x2>;
 			device_type = "cpu";
 			enable-method = "psci";
+			clocks = <&mcusys CLK_MCU_ARM_DIV_SEL>,
+				 <&topckgen CLK_TOP_XTAL>;
+			clock-names = "cpu", "intermediate";
+			operating-points-v2 = <&cluster0_opp>;
 		};
 
-		cpu@3 {
+		cpu3: cpu@3 {
 			compatible = "arm,cortex-a73";
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
+			opp00 {
+				opp-hz = /bits/ 64 <800000000>;
+				opp-microvolt = <850000>;
+			};
+			opp01 {
+				opp-hz = /bits/ 64 <1100000000>;
+				opp-microvolt = <850000>;
+			};
+			opp02 {
+				opp-hz = /bits/ 64 <1500000000>;
+				opp-microvolt = <850000>;
+			};
+			opp03 {
+				opp-hz = /bits/ 64 <1800000000>;
+				opp-microvolt = <900000>;
+			};
 		};
 	};
 
-- 
2.43.0


