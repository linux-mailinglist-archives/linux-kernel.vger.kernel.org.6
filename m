Return-Path: <linux-kernel+bounces-330231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F031979B41
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 08:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1121AB211B9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 06:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C203F446D1;
	Mon, 16 Sep 2024 06:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="ABc0NoJ3"
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4222D047;
	Mon, 16 Sep 2024 06:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726468971; cv=none; b=c0gdTJd+aKcodKlA3v1WhQMUdrI9j/m31VXyFSUmzPBwmI87FaqztpZaJqGkB9albAn6wCkpprzSzIA9/O4rxhzWTVGqJIr5O5Dyl+FjiWUxLEiPcJ8x9Ec2Psnj55toQmyTfE3xHG/1E8xLQNM9bWhOpB/UWMKFJ/YegQQ2L7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726468971; c=relaxed/simple;
	bh=acmHz7viakAbVQ5XSqj/oDtOIQpt7a4aUGaN043kfCc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ipdVekWsdVeGUglbhxLuc8yGS5zJrjWA5qicVoYQfAeoQIXa4RGEOccO3f0ki6OFugc4jQBs8VAUgov0ZVkSpAyw+VK5GcuQVQFF4v/SjSz+gIZ6OrXv4UgspQD85fznGqSW5CkdtazXzWe0zi+W790vOzcUBmPNWRjf69frAwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=ABc0NoJ3; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3A0D01489674;
	Mon, 16 Sep 2024 08:42:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1726468959; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=tGte9B0qtik8uIU9EEhLnC03OKDoHN27OfxODB6xwnk=;
	b=ABc0NoJ3ZFz+wQTrtP1AMU0Jmkmmvez2QOej1pRbaR3KegmYCQqhNlbBBSo1uvFT3GoyXX
	8Z8bhq/wQSQpySfay9QHKhYKN2wl7VubU99TXTAL4IqaPw7ANoBNRWe0l14UHr4TpIj7yL
	MyEWn+JO7K1dFdqXU9ryohBL7suJXqikcrY6+KHmTyTI6xvYGSKpEV5cJiBnOtitPm4/uV
	CeW4El/5O3K8FCIOYtqj98sE5jklqU55s+97E3ZfhtARdkSItP74leJGh9TjpicuPYTW91
	SSmuwayaZkRQabRLI27kf3nyBjIn48ab7KALVS7KOTbDjiTl+cqyTVlzyyPoNg==
From: Alexander Dahl <ada@thorsis.com>
To: Conor Dooley <conor+dt@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Microchip (AT91) SoC support),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ARM: dts: microchip: Add trng labels for all at91 SoCs
Date: Mon, 16 Sep 2024 08:42:32 +0200
Message-Id: <20240916064233.697215-1-ada@thorsis.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

SAM9X60 and SAMA7G5 already have those labels.  Add it for the other SoC
families so it can be referenced in board files.

Signed-off-by: Alexander Dahl <ada@thorsis.com>
---
 arch/arm/boot/dts/microchip/at91sam9g45.dtsi | 2 +-
 arch/arm/boot/dts/microchip/sama5d2.dtsi     | 2 +-
 arch/arm/boot/dts/microchip/sama5d3.dtsi     | 2 +-
 arch/arm/boot/dts/microchip/sama5d4.dtsi     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/microchip/at91sam9g45.dtsi b/arch/arm/boot/dts/microchip/at91sam9g45.dtsi
index 325c63a53118..02bd5a1833e8 100644
--- a/arch/arm/boot/dts/microchip/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/microchip/at91sam9g45.dtsi
@@ -753,7 +753,7 @@ macb0: ethernet@fffbc000 {
 				status = "disabled";
 			};
 
-			trng@fffcc000 {
+			trng: trng@fffcc000 {
 				compatible = "atmel,at91sam9g45-trng";
 				reg = <0xfffcc000 0x100>;
 				interrupts = <6 IRQ_TYPE_LEVEL_HIGH 0>;
diff --git a/arch/arm/boot/dts/microchip/sama5d2.dtsi b/arch/arm/boot/dts/microchip/sama5d2.dtsi
index 5f8e297e19ed..2fefe3efa769 100644
--- a/arch/arm/boot/dts/microchip/sama5d2.dtsi
+++ b/arch/arm/boot/dts/microchip/sama5d2.dtsi
@@ -1019,7 +1019,7 @@ AT91_XDMAC_DT_PER_IF(1) |
 				};
 			};
 
-			trng@fc01c000 {
+			trng: trng@fc01c000 {
 				compatible = "atmel,at91sam9g45-trng";
 				reg = <0xfc01c000 0x100>;
 				interrupts = <47 IRQ_TYPE_LEVEL_HIGH 0>;
diff --git a/arch/arm/boot/dts/microchip/sama5d3.dtsi b/arch/arm/boot/dts/microchip/sama5d3.dtsi
index d4fc0c1dfc10..8335e0c8066f 100644
--- a/arch/arm/boot/dts/microchip/sama5d3.dtsi
+++ b/arch/arm/boot/dts/microchip/sama5d3.dtsi
@@ -419,7 +419,7 @@ tdes: crypto@f803c000 {
 				clock-names = "tdes_clk";
 			};
 
-			trng@f8040000 {
+			trng: trng@f8040000 {
 				compatible = "atmel,at91sam9g45-trng";
 				reg = <0xf8040000 0x100>;
 				interrupts = <45 IRQ_TYPE_LEVEL_HIGH 0>;
diff --git a/arch/arm/boot/dts/microchip/sama5d4.dtsi b/arch/arm/boot/dts/microchip/sama5d4.dtsi
index 58ceed997889..20b8a9b123e1 100644
--- a/arch/arm/boot/dts/microchip/sama5d4.dtsi
+++ b/arch/arm/boot/dts/microchip/sama5d4.dtsi
@@ -658,7 +658,7 @@ macb1: ethernet@fc028000 {
 				status = "disabled";
 			};
 
-			trng@fc030000 {
+			trng: trng@fc030000 {
 				compatible = "atmel,at91sam9g45-trng";
 				reg = <0xfc030000 0x100>;
 				interrupts = <53 IRQ_TYPE_LEVEL_HIGH 0>;

base-commit: 98f7e32f20d28ec452afb208f9cffc08448a2652
-- 
2.39.5


