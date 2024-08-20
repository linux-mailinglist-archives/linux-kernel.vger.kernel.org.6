Return-Path: <linux-kernel+bounces-294030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 324CB9587F6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 15:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3D1928375A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 13:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1701922E8;
	Tue, 20 Aug 2024 13:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="PRIIenkp"
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112951922D4;
	Tue, 20 Aug 2024 13:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724160465; cv=none; b=ikCMHAoS3xH5S7hzTPSLRREzPjQZFyyKZwEOd40ol8a1K2nTG1zA4WiCkC4rv9Os/PEa1OOCUMrL09zn0+bofVhmwFXSQlOkPgbfknZDffhas7mUIPhZ5uVX1DQpLFX3fXbp5zHRpHkEVNkIvey+TXLyOLuEShEtpN2s6BBxOLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724160465; c=relaxed/simple;
	bh=hz3RzcXSp8C+lSShIolLGyjnUumMNWDXWqmvHVrL+pU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YUOWQ6HOJEtlBt5rpWY+0brz2gdhOmAWK/2NJaLJg4DzT0IPXib7ETRSHbMqYQue+eC6rbagfAByxxJqoE9EXWyNAyG8ctmUffNNNrs8yyl7sSN36AIuEQEzkKWs3UFSeLfMokD+b1E9aOVXnqJe8FgA6/yo4noPPujgwy4mxAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=PRIIenkp; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DFFCA1487C87;
	Tue, 20 Aug 2024 15:27:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1724160458; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=PCgOO1pDrOpwZlB5bNP2nFUn2U1YS3vBwTENcvdvGqc=;
	b=PRIIenkpiA/BzaDGYlkixkxD6Y4j7zmqlahg0ShcVd7leunmMSzKK9j2tPBOWW4TKzWF4B
	cnoDVlpL5FVGwVONrXTlrqJPzbZTxTatUobnUZRGLt4cNEEozvuRV9Nw3ds4jZm7y/R7pb
	noE2GbWRZhH7a9eWQJyNaM4Y/+feO9KTP+DPPtMu8+2oSKD21hkNmX9E0zkGj1L3x8Tvm+
	95HUTPbmUfA8bgOBInK+vq3ox+JPhBw1aRTdrbwuqWGEHiGejy4gMeOKtiSisnY4zzEp0E
	WPgIMjKA4TsR/1Ihe04fxXOZpzY3Tlt5INun0RCHqrDQweGf7/b2f0ZvsS1Ofg==
From: Alexander Dahl <ada@thorsis.com>
To: linux-clk@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ARM: dts: microchip: sam9x60: Fix rtc/rtt clock parent
Date: Tue, 20 Aug 2024 15:27:30 +0200
Message-Id: <20240820132730.357347-1-ada@thorsis.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The RTC and RTT peripherals use the "timing domain slow clock (TD_SLCK),
sourced from the 32.768 kHz crystal oscillator.

(The Monitoring domain slow clock (MD_SLCK) is sourced from an internal
RC oscillator which is most probably not precise enough for real time
clock purposes.)

Fixes: 1e5f532c2737 ("ARM: dts: at91: sam9x60: add device tree for soc and board")
Fixes: 5f6b33f46346 ("ARM: dts: sam9x60: add rtt")
Signed-off-by: Alexander Dahl <ada@thorsis.com>
---
 arch/arm/boot/dts/microchip/sam9x60.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/microchip/sam9x60.dtsi b/arch/arm/boot/dts/microchip/sam9x60.dtsi
index 291540e5d81e..d077afd5024d 100644
--- a/arch/arm/boot/dts/microchip/sam9x60.dtsi
+++ b/arch/arm/boot/dts/microchip/sam9x60.dtsi
@@ -1312,7 +1312,7 @@ rtt: rtc@fffffe20 {
 				compatible = "microchip,sam9x60-rtt", "atmel,at91sam9260-rtt";
 				reg = <0xfffffe20 0x20>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
-				clocks = <&clk32k 0>;
+				clocks = <&clk32k 1>;
 			};
 
 			pit: timer@fffffe40 {
@@ -1338,7 +1338,7 @@ rtc: rtc@fffffea8 {
 				compatible = "microchip,sam9x60-rtc", "atmel,at91sam9x5-rtc";
 				reg = <0xfffffea8 0x100>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
-				clocks = <&clk32k 0>;
+				clocks = <&clk32k 1>;
 			};
 
 			watchdog: watchdog@ffffff80 {

base-commit: 47ac09b91befbb6a235ab620c32af719f8208399
-- 
2.39.2


