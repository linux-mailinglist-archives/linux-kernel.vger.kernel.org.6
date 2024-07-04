Return-Path: <linux-kernel+bounces-241326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BBC9279C6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4101B25D00
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E7B1B3742;
	Thu,  4 Jul 2024 15:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ySjRizQV"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9891AED21;
	Thu,  4 Jul 2024 15:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720106107; cv=none; b=HSGs1TjS+MldhaE/gcR0PFC4nOjnk6NyZsWqTSjzkaZpV9UX8B4nh8obXVXb4UykaWDbIN/KqIeiH2QIiJ0HQTuePuvUgLL8oZNMoUE1dCXId6P+UN6JTZRXjo4t33K3h3aonPz60XJ1eJWIOwTY027EPOQnOciXFepfvgSk0XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720106107; c=relaxed/simple;
	bh=090C6fObsPMHQlArbVV/KRIGFjL2wBY0XbhN4XnQPZ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S2HyZYCHIDLNaOQ7FMF/xqikddflQsE6QK61VTl5bEEbrxokY8/osTw+Bbwl4cS+/eN4AfJAK5adcQ4/yCMM/evBdYkKxeSuqbFSDWrWi3hSXqmagLyFMI1JxIBUKhraGjDcd+Dxjq5dLvEw9ZLOQj8Fn5M1jWSq+zzjPGTnkwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=fail smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ySjRizQV; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720106105; x=1751642105;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=090C6fObsPMHQlArbVV/KRIGFjL2wBY0XbhN4XnQPZ0=;
  b=ySjRizQVEUwtDrnWcS3h2LfWsYU+sSAMQzSjxFs3EbnMT5PVVF/hdmg6
   MuhXK8grnVsni6W3SQphim9tM5d/bf7JtaAl7bv06/2j/eN1FpllioK/Z
   jtu7IvOSd0NaVoRU+vrbsoULT3B82BzZ/c/BvtrjYX3uT4UBa1g933qjA
   5BDo3pWsalzW8gKgnv0ehQjs4emZqMTu+3I9N0AkhNocSv1y6Q02heWH6
   1MAgbRy2DMcFpfRo5xJvdQUPkig5eF0+4qcxcQnixujG1MtB1CWDVxDcP
   ua7TxwehlO4RFhksYCmOMIZAjzmshR2E+oCpBkgY1UvbttSjCm3ii06I6
   w==;
X-CSE-ConnectionGUID: yuRgZFa1RACzV38HdxMQZg==
X-CSE-MsgGUID: ilCO3uieRUet8LfhjHMplg==
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="31482012"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2024 08:15:04 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jul 2024 08:14:41 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 4 Jul 2024 08:14:38 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Andrei Simion <andrei.simion@microchip.com>
Subject: [PATCH 1/7] ARM: dts: microchip: at91-sama5d2_xplained: Align the eeprom nodename
Date: Thu, 4 Jul 2024 18:14:05 +0300
Message-ID: <20240704151411.69558-2-andrei.simion@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240704151411.69558-1-andrei.simion@microchip.com>
References: <20240704151411.69558-1-andrei.simion@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Align the eeprom nodename according to device tree specification
and at24.yaml.

Signed-off-by: Andrei Simion <andrei.simion@microchip.com>
---
 arch/arm/boot/dts/microchip/at91-sama5d2_xplained.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/microchip/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/microchip/at91-sama5d2_xplained.dts
index 6680031387e8..4bab3f25b855 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d2_xplained.dts
@@ -411,7 +411,7 @@ i2c1: i2c@fc028000 {
 				scl-gpios = <&pioA PIN_PD5 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 				status = "okay";
 
-				at24@54 {
+				eeprom@54 {
 					compatible = "atmel,24c02";
 					reg = <0x54>;
 					pagesize = <16>;
-- 
2.34.1


