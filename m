Return-Path: <linux-kernel+bounces-346236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A143698C192
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68653280DF1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62311C9EC1;
	Tue,  1 Oct 2024 15:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="DUNQDw/f"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774A91C7B64;
	Tue,  1 Oct 2024 15:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727796421; cv=none; b=XzqKca1Aaq5OePnO9szy25tbfEsWS3G9U13kIuQlLc7WlyVP96b+gzgUi0Mh67757N2fQN1vBkBnYBYDYknKdiWF3KrrEUK6oGmGzecCoFTJ2URHCBvKK8Vo5zSt+oX9xtEQZfLv/reLxQMa3pX1zwdISO24v61Cn2sliaoBkC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727796421; c=relaxed/simple;
	bh=q8peYuCA9ELeZXvqZ+MhkE6uSrbOTpu0c7mXlAKH/I4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K5qODRz0HxU+2vR9aZ/zA8GCZ9RHlbVuDdCU6yYqt5/dpfRyly2IgQ4uidlD6ZSs/GJLOLB7tHyjLIWdZERrJrZIfsDrC+dsXUKLZT/XAzqjdx6lYap7RiJJZnGfdBgYuM8pDhleQdLTfjlccRywj73xSGXpsh4wIiUHOb4XgF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=DUNQDw/f; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727796420; x=1759332420;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=q8peYuCA9ELeZXvqZ+MhkE6uSrbOTpu0c7mXlAKH/I4=;
  b=DUNQDw/fe+T95BqEiJ4KVOgPllHc1vdP/lE89uOY5oCsh/RukcZlIfrK
   KkvsSy8o7w1eZwNUvwm8X1Ovmrw7fFHvR5aDN0wFZ8WOD/+O8A2NMLNTR
   TJzyl9a822KfLSgTlUzJR1KChP6LFBDtsrxJsR06grZVIUBtNRvdlcBg2
   naxb+47Eci6dVBVSqUqzOFh5+f4fmJ3j4cPw3pwvUvMSeCtIW9kTIAIW8
   ar2hp5QW9nnBu70GtfgHDDW6d7QnqKAf0jyn4h/cgjCeFEWdirWu6yLw/
   0kbqEGPbHgSlZGymOxR7oCUv/1TTl94zbBMBgDjzfAa2ExTWr+FrPb0uO
   Q==;
X-CSE-ConnectionGUID: ko6XxiKESViquwXo4N5vaw==
X-CSE-MsgGUID: 7q+vKAFHS4yifazB6rSLSg==
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="32453835"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Oct 2024 08:26:59 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 1 Oct 2024 08:26:33 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 1 Oct 2024 08:26:31 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<alexandre.belloni@bootlin.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Andrei Simion <andrei.simion@microchip.com>
Subject: [PATCH v2 0/4] Cosmetic Work for ARM/Microchip (AT91)
Date: Tue, 1 Oct 2024 18:25:37 +0300
Message-ID: <20241001152541.91945-1-andrei.simion@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch series updates node names and labels in the Microchip ARM DTS
files to align with Device Tree specificatios

changelog:
v1 -> v2:
- drop patch : Rename the usb node
- add patch : ARM: dts: microchip: aks-cdu: Add label for LED sub nodes

Andrei Simion (4):
  ARM: dts: microchip: Rename the eeprom nodename
  ARM: dts: microchip: Rename the pmic node
  ARM: dts: microchip: Rename LED sub nodes name
  ARM: dts: microchip: aks-cdu: Add label for LED sub nodes

 arch/arm/boot/dts/microchip/aks-cdu.dts              | 12 ++++++++----
 arch/arm/boot/dts/microchip/animeo_ip.dts            |  8 ++++----
 arch/arm/boot/dts/microchip/at91-kizbox2-common.dtsi |  2 +-
 arch/arm/boot/dts/microchip/at91-sam9x60ek.dts       |  6 +++---
 arch/arm/boot/dts/microchip/at91-sama5d27_som1.dtsi  |  2 +-
 .../arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi |  2 +-
 .../boot/dts/microchip/at91-sama5d29_curiosity.dts   |  2 +-
 arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts     |  2 +-
 arch/arm/boot/dts/microchip/at91-sama5d2_ptc_ek.dts  |  2 +-
 .../arm/boot/dts/microchip/at91-sama5d2_xplained.dts |  2 +-
 .../arm/boot/dts/microchip/at91-sama5d3_xplained.dts |  2 +-
 arch/arm/boot/dts/microchip/at91-sama7g5ek.dts       |  2 +-
 arch/arm/boot/dts/microchip/at91rm9200ek.dts         |  6 +++---
 arch/arm/boot/dts/microchip/at91sam9260ek.dts        |  6 +++---
 arch/arm/boot/dts/microchip/at91sam9261ek.dts        |  6 +++---
 arch/arm/boot/dts/microchip/at91sam9263ek.dts        |  6 +++---
 arch/arm/boot/dts/microchip/at91sam9g20ek.dts        |  4 ++--
 .../arm/boot/dts/microchip/at91sam9g20ek_common.dtsi |  2 +-
 arch/arm/boot/dts/microchip/sama5d34ek.dts           |  2 +-
 arch/arm/boot/dts/microchip/sama5d3xcm_cmp.dtsi      |  2 +-
 20 files changed, 41 insertions(+), 37 deletions(-)


base-commit: 77df9e4bb2224d8ffbddec04c333a9d7965dad6c
-- 
2.34.1


