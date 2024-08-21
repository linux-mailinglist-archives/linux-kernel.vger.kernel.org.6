Return-Path: <linux-kernel+bounces-295369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E770959A2F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7155AB2821D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459891BA271;
	Wed, 21 Aug 2024 11:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="w1mvVPiH"
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0722E1B654E;
	Wed, 21 Aug 2024 10:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724237999; cv=none; b=WgoA5Eyg4ks1MhsS/DT7n8Xrl40EwXOD1R+YPR5m8GnrY6kHatRh1CKwoIyVeUmM6x7GkQ/Eji3l4CNS7glX9m89e+uGftiGtWk43BjmEwl7fxTa1Q6EUu8aIPCfdA7tT/yjbQHgMjDBbYLR/O1cLk3V2HOqT+JjkJwRk4Xxi8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724237999; c=relaxed/simple;
	bh=S+h5jXrA7YMUAbkYheYPZ9pn05AyL6g6Zi2qsKGDVp4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PDRcPpP2cLIDuMDizbM4WWoShlsF8lqqSElki6++NEPZiCGCNxJ+dkB8nOxVoJ1eryA3RimUI4azaUYXobKbjNg7cIb6A48dnUcwafaBDL05S3Ihn1NEgrMDaWrbI0X368/6ExedcCs1JY2lGAC20snvqkDuNCUsnTbTBjT+wdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=w1mvVPiH; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C42A71483DF4;
	Wed, 21 Aug 2024 12:59:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1724237993; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=o6Z9plrI34xx6HsJ1k36/QnTasThr1NJXWR2tkzloNs=;
	b=w1mvVPiHQU/BhJcC0MaXV+zMyRmOFakVw3bunQ4cbbERulGd1H7d/xRMeBq6SaT8H4s5Dg
	pNMpkNsa3nro5C7xDKJnJeiNHqygYOFhZ3kM5Slw3XpRWbOWHDd4LUO4MRkfcZxTXsW88V
	6LUVecQXAKE04lKOUBmRs7sPSTbItbYQs/kG36kT0iqix49X4A5Qu40fM0Xn/w1U8QbjDx
	8eH7uaOvJeE5Gn5uyUywMCeog5I2e7v89pIk2VU4CalSK5PbM5c80CGtOhFrj9tFkNm1Dp
	ZcnRhIGBZ4i9RivwmNLWqSin2IYB7DIvbzA6GPuGmzUthpHNxXB91p8cfKbtNQ==
From: Alexander Dahl <ada@thorsis.com>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Christian Melki <christian.melki@t2data.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 05/12] ARM: dts: microchip: sam9x60: Add OTPC node
Date: Wed, 21 Aug 2024 12:59:36 +0200
Message-Id: <20240821105943.230281-6-ada@thorsis.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240821105943.230281-1-ada@thorsis.com>
References: <20240821105943.230281-1-ada@thorsis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

See datasheet (DS60001579G) sections "7. Memories" and "23. OTP Memory
Controller (OTPC)" for reference.

Signed-off-by: Alexander Dahl <ada@thorsis.com>
---
 arch/arm/boot/dts/microchip/sam9x60.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/sam9x60.dtsi b/arch/arm/boot/dts/microchip/sam9x60.dtsi
index 291540e5d81e..2159a6817f44 100644
--- a/arch/arm/boot/dts/microchip/sam9x60.dtsi
+++ b/arch/arm/boot/dts/microchip/sam9x60.dtsi
@@ -14,6 +14,7 @@
 #include <dt-bindings/clock/at91.h>
 #include <dt-bindings/mfd/at91-usart.h>
 #include <dt-bindings/mfd/atmel-flexcom.h>
+#include <dt-bindings/nvmem/microchip,sama7g5-otpc.h>
 
 / {
 	#address-cells = <1>;
@@ -156,6 +157,13 @@ sdmmc1: sdio-host@90000000 {
 			status = "disabled";
 		};
 
+		otpc: efuse@eff00000 {
+			compatible = "microchip,sam9x60-otpc", "syscon";
+			reg = <0xeff00000 0xec>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+
 		apb {
 			compatible = "simple-bus";
 			#address-cells = <1>;
-- 
2.39.2


