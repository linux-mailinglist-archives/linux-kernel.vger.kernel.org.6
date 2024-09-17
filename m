Return-Path: <linux-kernel+bounces-331376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC0B97AC08
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 09:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 457421F22D8F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 07:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E65514C5AA;
	Tue, 17 Sep 2024 07:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="IhEVbcjA"
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10DA130AC8;
	Tue, 17 Sep 2024 07:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726558047; cv=none; b=Cu22P7m3S+KsqfFihngX/jcmrYftSWZRzo9hSQbRfgvnzKHcnVND7HkERDjA91ercHqZovO8VaeyV3h3J9H09lqWqJjGPbu8pU+NPQG9ZxmxiR9KIxDzblcmekVrS0FU2/QT5/7W1YA/e0BpxctDPbip0R2SsZ8RzRNl/EJg7y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726558047; c=relaxed/simple;
	bh=xc07ubxxAH5r7SoSr/r7hT0VUdV5lSf/A2AE89JdQl0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ap5D2PMnIyTIJXOpSB9aRK6Wiu0ED+kjMoPeAikLw+Oamf8jszfegNwnY6nsWP+rHXEZqKr6i1A76AW/IHjCAQELMxQqS0WPMSTi+kM4aM3vdeKu4nfrE99a3nZO1mTdSkGrs3jM9T11XlF+VEZ6LDFeM14Ntc4BHAGl9dJ9OkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=IhEVbcjA; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 29C4D1486580;
	Tue, 17 Sep 2024 09:27:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1726558037; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=rJ+cDWcprSHtS+uTixdcYhWilE5D7onDRSm5UnVvA/8=;
	b=IhEVbcjAcRWT+HiFMkn8YC7qRB++8mOVG0r/XKONOx/pW6JyAqyW4rH9IdpsomT0BIefWV
	x3M7phjv7Gl15heG7DCQeqWejRhh9+9VU9hWZRmb4ZVrekT/JmJE277a3jgrMX1f2DxL1D
	XPQ9bHPm9TcQSPNX1xMBnXLu3SwMtP2zBHLWCQ7DvYfX2XmxrKExWGgqk4rRq6+q5TmlQN
	InEfTa19FFC8BLsKc4er91HhGMXU3zXsqcdlxMEmQx5j415+HlREycUUQuz25nrMQNzLnY
	oXk0ZOxLgRfEHPoVyXFQdvPIRpbKgBR72J4gHbqYR9rVdOuQzopY5dI5oEfI1A==
From: Alexander Dahl <ada@thorsis.com>
To: Conor Dooley <conor+dt@kernel.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Microchip (AT91) SoC support),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/2] ARM: dts: microchip: Add trng labels for all at91 SoCs
Date: Tue, 17 Sep 2024 09:27:09 +0200
Message-Id: <20240917072710.125435-2-ada@thorsis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240917072710.125435-1-ada@thorsis.com>
References: <20240917072710.125435-1-ada@thorsis.com>
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
-- 
2.39.5


