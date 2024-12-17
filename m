Return-Path: <linux-kernel+bounces-448901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B799F46FE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F239188D2CD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D252F1E1A18;
	Tue, 17 Dec 2024 09:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="YqXjivKp"
Received: from mxout1.routing.net (mxout1.routing.net [134.0.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8713E1DFDBB;
	Tue, 17 Dec 2024 09:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734426780; cv=none; b=G5PgBwg/4YYJamkMlBkO25RriazHsv9ll8KbExyTcdoqKkADiiip4WElrto77FoetTyV1w1SosDOrQis27MxXFYf/tybFSW4yiKTfWIsGUCsNWxPJTIvKZzWbT9b6cNb7SeR/BuU3cpcIWCZbzrCX1LvyJJCwQl3fKnnS+hlGZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734426780; c=relaxed/simple;
	bh=j9wVTqWw9/Iq5QYAQvEvVkfy5QqA6kCyqrqLXeuDL64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PO7FILqO1dN91XZRVvBhvMg6dRhQlvQoYMtdSmLWTJPsbYGaZE7+uN1nPpifHsjuhUfcKGnMroI+fwQaf3zyAvjL7b2c0sgiTa28cdUbZBM7L5eFWvMddnL/Kwe1JDbUIAxJUXEdJnBg6Pn6Mraj/YiqBHg1D6QY3q+bKtk5Ng8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=YqXjivKp; arc=none smtp.client-ip=134.0.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
	by mxout1.routing.net (Postfix) with ESMTP id EAE04402B4;
	Tue, 17 Dec 2024 09:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1734426775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jsuZqQ/JNf9mBqEmyBoioMuI4QEZbD0mlGv4gUBUgMo=;
	b=YqXjivKpS8MbPf+wjamGMTitdGmHLBeyWuMLI8+U9pVC8+tPAQHRx1vzJnmcrK6I0IES6q
	YHJHj5QZD8cMpwuQzB5ks1/h/waazZv4NOWgojG47lGw1Wy73TMBj1W04dqsIG+8VxNH/O
	20RfE+4D21WnvjylKJuP+cikuowoKjM=
Received: from frank-u24.. (fttx-pool-217.61.150.187.bambit.de [217.61.150.187])
	by mxbox2.masterlogin.de (Postfix) with ESMTPSA id 4CE5E100532;
	Tue, 17 Dec 2024 09:12:54 +0000 (UTC)
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
Subject: [PATCH v3 05/22] arm64: dts: mediatek: mt7988: Add missing clock-div property for i2c
Date: Tue, 17 Dec 2024 10:12:19 +0100
Message-ID: <20241217091238.16032-6-linux@fw-web.de>
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
X-Mail-ID: f46f7446-c2e1-4dc4-982c-d9d600d29033

From: Frank Wunderlich <frank-w@public-files.de>

I2C binding requires clock-div property.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Fixes: 660c230bf302 ("arm64: dts: mediatek: mt7988: add I2C controllers")
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
index 0e75a8692879..16b28fcf1e3c 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
@@ -230,6 +230,7 @@ i2c@11003000 {
 			reg = <0 0x11003000 0 0x1000>,
 			      <0 0x10217080 0 0x80>;
 			interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
+			clock-div = <1>;
 			clocks = <&infracfg CLK_INFRA_I2C_BCK>,
 				 <&infracfg CLK_INFRA_66M_AP_DMA_BCK>;
 			clock-names = "main", "dma";
@@ -243,6 +244,7 @@ i2c@11004000 {
 			reg = <0 0x11004000 0 0x1000>,
 			      <0 0x10217100 0 0x80>;
 			interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
+			clock-div = <1>;
 			clocks = <&infracfg CLK_INFRA_I2C_BCK>,
 				 <&infracfg CLK_INFRA_66M_AP_DMA_BCK>;
 			clock-names = "main", "dma";
@@ -256,6 +258,7 @@ i2c@11005000 {
 			reg = <0 0x11005000 0 0x1000>,
 			      <0 0x10217180 0 0x80>;
 			interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
+			clock-div = <1>;
 			clocks = <&infracfg CLK_INFRA_I2C_BCK>,
 				 <&infracfg CLK_INFRA_66M_AP_DMA_BCK>;
 			clock-names = "main", "dma";
-- 
2.43.0


