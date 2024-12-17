Return-Path: <linux-kernel+bounces-448916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E288B9F4723
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BD3916EE0E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9571F1F4726;
	Tue, 17 Dec 2024 09:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="o9R7OUFn"
Received: from mxout2.routing.net (mxout2.routing.net [134.0.28.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606F71DED4E;
	Tue, 17 Dec 2024 09:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734426791; cv=none; b=B4OFXu2aAULLVIzixScp4cM8dXapkK5fvmsy68lRFm8sFeCNG232w393YH01xluZOtmJajKDkDqp3aoLVCK7Z+0YUONjb1kRz/MVdFi+/FV80jZ0iRyzI6s63zeFTzSSfXgFCpHwEsXGYBrrKHil5grRMOXchkVrlrWj81OIfnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734426791; c=relaxed/simple;
	bh=AM7sOwEkT9PTDT/kiYKzXUnS4sDd1xjFclaxCEOhyRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=km8BxrRsFLd4xzphujjOrIR+yuyZd2ptpTJLCOmbjF6tHfjn7gfsFwNrQ3nQLl7kC0SKKlHg32/rKWmSPcIOmBBFggWBlBJYwAl545FD05rOFRi0k01ivDLqoKQmq9bs4J6UNCy8Sa8CNgEWqYYAd/rM/EA+av56tq6PFpwF33U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=o9R7OUFn; arc=none smtp.client-ip=134.0.28.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
	by mxout2.routing.net (Postfix) with ESMTP id 607356027E;
	Tue, 17 Dec 2024 09:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1734426785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D/D20bTymHHn1mnpHZj8wgSerQH7Hot7Hk9YwwO4W1k=;
	b=o9R7OUFnndhDeZfElaT5RaoSYKfiNDP18JC4uqYuTnEzqkL7nnx04t/oCZskzO2rKPLee8
	s9Xm2vRZyyWVZTgMj1uANurYsJBZEHS0VEacOm+T3gwkrhm3u//GeA5ImrWCMaY15Kicez
	G819Q0Gp73ipiOdxdW/0pfEMKt9SFCs=
Received: from frank-u24.. (fttx-pool-217.61.150.187.bambit.de [217.61.150.187])
	by mxbox2.masterlogin.de (Postfix) with ESMTPSA id B47641004DD;
	Tue, 17 Dec 2024 09:13:04 +0000 (UTC)
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
Subject: [PATCH v3 19/22] arm64: dts: mediatek: mt7988a-bpi-r4: Enable t-phy for ssusb1
Date: Tue, 17 Dec 2024 10:12:33 +0100
Message-ID: <20241217091238.16032-20-linux@fw-web.de>
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
X-Mail-ID: 3cf734aa-7404-4242-b717-0eb736b215c1

From: Frank Wunderlich <frank-w@public-files.de>

Bananapi R4 uses t-phy for usb. Enable its node at board level.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts | 4 ++++
 arch/arm64/boot/dts/mediatek/mt7988a.dtsi                | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
index 0dc1fd9265c6..129031b0d784 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
@@ -306,6 +306,10 @@ &serial0 {
 	status = "okay";
 };
 
+&tphy {
+	status = "okay";
+};
+
 &watchdog {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
index c0a49f68834a..0766ca0dd3f6 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
@@ -525,7 +525,7 @@ pcie_intc1: interrupt-controller {
 			};
 		};
 
-		t-phy@11c50000 {
+		tphy: t-phy@11c50000 {
 			compatible = "mediatek,mt7986-tphy",
 				     "mediatek,generic-tphy-v2";
 			#address-cells = <2>;
-- 
2.43.0


