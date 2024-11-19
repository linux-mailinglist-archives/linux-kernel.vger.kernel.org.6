Return-Path: <linux-kernel+bounces-414584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EB19D2A5C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 17:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA22B283B3B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 16:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933001D0943;
	Tue, 19 Nov 2024 16:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="kgJ7KmAu"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782E2145FFF;
	Tue, 19 Nov 2024 16:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732032047; cv=none; b=NvKP04YTBwoBXbnmB/RKbP0zKI6lqy7X/YIHH6YvP6t7ygilWVk/xSQ5h7ZFnVCfgTRD3iLQxiS/qhKURaCS6IQ85qiN2OiDT7jtGAsv/uXxcUoyUvBNdcgrWFzYv03CSFZbDNOaX07TrvlJ6cEbEWVcrKIf0Y4J/htH5tw5ERs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732032047; c=relaxed/simple;
	bh=gsWw2pf7NLkSqETGrHgG7uVkA3SCZQaKx+obLvvQtEI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZE22CBXBeGJCWVipcZF5SbUCFFAqCaHxZTuvv4F3Enaa6ce63X2PuJI39NvUtxpuaGjesMZ09iKJgRQcd2J6dcWVYv6VyYiM6n3P2aaosvgaaxHb+rgCRXaAhYXJtjk8CNf6Zz7KY5SamHaZNc4N+FX8IFXmDPg4x/6ihKwLlQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=kgJ7KmAu; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1732032047; x=1763568047;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gsWw2pf7NLkSqETGrHgG7uVkA3SCZQaKx+obLvvQtEI=;
  b=kgJ7KmAuqDreZfbysVigk69FaW7Ir7VuLCL8mOmnHSt0Mfp++rofcfsn
   xE2H6Q641DLqOI7oNq8mTYxUUGW90qbsEaPes9KLOD5aI9vEel4NMn9z7
   p1srdzzYPHVwAeZOeD4q4RF+3LwELYmq9/kDQOWG/COXQneqMqb1hM93+
   yAHZ7BjtctOAVBlVGecMhURy5K+eN/IN7zar8uO65Px9MMhLmXIh9p2h6
   JeHLiXy7Irm7SZ0iBB801FpAKsC92z61EMIeCeEqAtV99mr//1A18a3IC
   5lFVY/Pt8UtJJ9yMZchE2P7C97c7E9zBL1HISV14tY0QwqhBoRK5Rc9io
   A==;
X-CSE-ConnectionGUID: 4O9knxboR1CTZIJk2gLi+Q==
X-CSE-MsgGUID: usIpRQTCTEe6UmfpC0mRew==
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="265672313"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Nov 2024 09:00:46 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Nov 2024 09:00:05 -0700
Received: from ROB-ULT-M91496.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 19 Nov 2024 09:00:03 -0700
From: <cristian.birsan@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Cristian Birsan
	<cristian.birsan@microchip.com>
Subject: [PATCH 0/2] ARM: dts: microchip: Add no-1-8-v property to sdmmc0 node
Date: Tue, 19 Nov 2024 18:01:05 +0200
Message-ID: <20241119160107.598411-1-cristian.birsan@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Cristian Birsan <cristian.birsan@microchip.com>

Add no-1-8-v property to sdmmc0 node to keep VDDSDMMC power rail at 3.3V.
This property will stop the LDO regulator from switching to 1.8V when the
MMC core detects an UHS SD Card. VDDSDMMC power rail is used by all the
SDMMC interface pins in GPIO mode (PA0 - PA13).

PA6 and PA10 GPIOs are used to enable the power switch controlling USB
Vbus for the USB Host.

Cristian Birsan (2):
  ARM: dts: microchip: sama5d29_curiosity: Add no-1-8-v property to
    sdmmc0 node
  ARM: dts: microchip: sama5d27_wlsom1_ek: Add no-1-8-v property to
    sdmmc0 node

 arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts | 1 +
 arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts | 1 +
 2 files changed, 2 insertions(+)


base-commit: 158f238aa69d91ad74e535c73f552bd4b025109c
-- 
2.34.1


