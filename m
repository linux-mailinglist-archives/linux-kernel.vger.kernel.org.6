Return-Path: <linux-kernel+bounces-448906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8479F470C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FAFD16E903
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239701EE017;
	Tue, 17 Dec 2024 09:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="rHKXUuF+"
Received: from mxout3.routing.net (mxout3.routing.net [134.0.28.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E2F1E32C3;
	Tue, 17 Dec 2024 09:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734426783; cv=none; b=mvbJQth9PZgubyr+03w4SHWAE8p6MQnD4lKVA5zQtXX4ae59nFPS2aSL/w1HfJ/cIV1IlRLsdmoWambL1h5LhHapkXyuSvPFfu4m3Wvws66/cdyOfMBC8t4tI/U5ehYZZXS1TYhx1g0ShQKkIxWUk5tiITWrXy0ftOXvYb5A/q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734426783; c=relaxed/simple;
	bh=QMG+NnE9LgcXIOd4zyEzYP9uzo3JgttnGP6vsd128g8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nDiQYIzo2NFBf8o96jg2HVEf48DfNODo7bQP1wR2flSzUD2lbHL2inlUF+UWNtn9mXLOi5rKUxQhNhqPlAEmuNqVZaeswQwxZWirUTqIwK1rYShty1HKKuerPWZW/C/rE2t0TlCQO5cZyqtlN9a7fkcahYyrF6X1jkP3Nn1HwEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=rHKXUuF+; arc=none smtp.client-ip=134.0.28.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
	by mxout3.routing.net (Postfix) with ESMTP id 44D9D605CB;
	Tue, 17 Dec 2024 09:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1734426780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bZ2NeLem4bD+EDYnXYd1hKRZi160E0NguADTNZ2M05k=;
	b=rHKXUuF+sXun7jD4Uyjd8Su2uYF9DlyGmHVnSTym95a/bXTxHRoZagfjfnBlP5B8oxYLRK
	R/Oo1v7OEzaeuvlMUts9o7rh5k5uuVxqxaWSbGE49XnkXo+bzRXlOop6eCdL01UzzFz7dz
	67IoVWNtxuy8k9akFB2uZx9uMexcaNs=
Received: from frank-u24.. (fttx-pool-217.61.150.187.bambit.de [217.61.150.187])
	by mxbox2.masterlogin.de (Postfix) with ESMTPSA id 8B01E1004DD;
	Tue, 17 Dec 2024 09:12:59 +0000 (UTC)
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
Subject: [PATCH v3 12/22] arm64: dts: mediatek: mt7988a-bpi-r4: Add fixed regulators for 1v8 and 3v3
Date: Tue, 17 Dec 2024 10:12:26 +0100
Message-ID: <20241217091238.16032-13-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241217091238.16032-1-linux@fw-web.de>
References: <20241217091238.16032-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: a377f675-dd7e-4756-8999-0e894da03674

From: Frank Wunderlich <frank-w@public-files.de>

Add regulator nodes used for mmc to Bananapi R4 board.
This board has 1 MMC controller used for SDMMC and eMMC where only one can
be used at one time, selected by hardware switches. SD uses 3v3 for both
supplies and emmc uses both regulators.
So defining both regulators in board dts and referencing them in the dt
overlay.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
v3:
- change title to include prefix for r4
v2:
- move mmc regulators to board dts of bpi-r4
---
 .../dts/mediatek/mt7988a-bananapi-bpi-r4.dts   | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
index d914eae2b524..df53512c6890 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
@@ -8,6 +8,24 @@ / {
 	compatible = "bananapi,bpi-r4", "mediatek,mt7988a";
 	model = "Banana Pi BPI-R4";
 	chassis-type = "embedded";
+
+	reg_1p8v: regulator-1p8v {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-1.8V";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
 };
 
 &pio {
-- 
2.43.0


