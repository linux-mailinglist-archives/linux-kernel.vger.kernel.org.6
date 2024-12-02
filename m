Return-Path: <linux-kernel+bounces-427505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1EF9E0312
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7881EB3A609
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 12:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CA7203704;
	Mon,  2 Dec 2024 12:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="MQoQcayH"
Received: from mxout2.routing.net (mxout2.routing.net [134.0.28.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45ED201273;
	Mon,  2 Dec 2024 12:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733142381; cv=none; b=iEqLfckjgULDXnq65SUa03wDBp/Gd+P/yNCfvrcPonC7yilRM+EPt0OAgfpMsOiBoGMT/MKcRu8D54prTjA3LY7kzwglGbjhw79Vdfw3XNRJgWTRzuPBtG0FY2IiF2GKOat41tjsZGDgstThNtcf+8cjLreLIPbT9yBrAFbDnqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733142381; c=relaxed/simple;
	bh=vMk9LDnD938NDeSb5AMgNvWTbz9zZrpJj/Y3IFlZ3aI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jjq+Xe7BmGnP21beo2fmUi5M8MehXotNvHQ+CdzQldMkhncrADvVwecWRc3h35/6ydMtNAx/trDwVjrltrG3/6bZqnato9F9UJSzhwQ6ataGXl/UfJetIzsGCkBTVvNqLSFWCUftPTR0GtoJ+SOGolaiNFYvGiWa3LkehIjFsEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=MQoQcayH; arc=none smtp.client-ip=134.0.28.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
	by mxout2.routing.net (Postfix) with ESMTP id 1C20B60473;
	Mon,  2 Dec 2024 12:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1733142378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ufaR+T2J5dHCsyUEG18rn+qRf8TnwgZpnHT8JFBy00=;
	b=MQoQcayHUt9U+r0GqmPlWNHiI7Xo7LVFkTl7GDeyfv/CYdJgWvigs81e7Gj8LU1x+0m8yC
	f2dAkRzzQ83s8IpWB/VlSNPzFLEwQLxs8aeLYEFmRwRFBxUEagYpcI68KcEv1B1x1r0yGi
	39UpIAXI/fgmMOXWFP4KmE68YSNCqMY=
Received: from frank-u24.. (fttx-pool-217.61.149.104.bambit.de [217.61.149.104])
	by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 8B9FF360211;
	Mon,  2 Dec 2024 12:26:17 +0000 (UTC)
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
Subject: [PATCH v2 13/18] arm64: dts: mediatek: mt7988: add i2c to bpi-r4 board
Date: Mon,  2 Dec 2024 13:25:54 +0100
Message-ID: <20241202122602.30734-14-linux@fw-web.de>
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
X-Mail-ID: 8adef2c0-690e-4a13-a2ba-5a41995967bc

From: Frank Wunderlich <frank-w@public-files.de>

Add basic i2c nodes to bananapi R4 board.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 .../boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts    | 12 ++++++++++++
 arch/arm64/boot/dts/mediatek/mt7988a.dtsi            |  6 +++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
index 1c2a806f6f6c..13ca016d6a67 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
@@ -61,6 +61,18 @@ cpu_trip_active_low: active-low {
 	};
 };
 
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins>;
+	status = "okay";
+};
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_1_pins>;
+	status = "okay";
+};
+
 &pio {
 	mdio0_pins: mdio0-pins {
 		mux {
diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
index 956f2be600a2..eebbdfe55774 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
@@ -269,7 +269,7 @@ serial@11000200 {
 			status = "disabled";
 		};
 
-		i2c@11003000 {
+		i2c0: i2c@11003000 {
 			compatible = "mediatek,mt7981-i2c";
 			reg = <0 0x11003000 0 0x1000>,
 			      <0 0x10217080 0 0x80>;
@@ -283,7 +283,7 @@ i2c@11003000 {
 			status = "disabled";
 		};
 
-		i2c@11004000 {
+		i2c1: i2c@11004000 {
 			compatible = "mediatek,mt7981-i2c";
 			reg = <0 0x11004000 0 0x1000>,
 			      <0 0x10217100 0 0x80>;
@@ -297,7 +297,7 @@ i2c@11004000 {
 			status = "disabled";
 		};
 
-		i2c@11005000 {
+		i2c2: i2c@11005000 {
 			compatible = "mediatek,mt7981-i2c";
 			reg = <0 0x11005000 0 0x1000>,
 			      <0 0x10217180 0 0x80>;
-- 
2.43.0


