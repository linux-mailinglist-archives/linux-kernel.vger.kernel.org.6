Return-Path: <linux-kernel+bounces-283227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB8394EEDE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 15:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 163761F21130
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 13:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35021849CB;
	Mon, 12 Aug 2024 13:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="urNmxNPn"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636A317F389;
	Mon, 12 Aug 2024 13:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723470778; cv=none; b=niAQuGbxpMFakCiwNIIlBMQR9zpDgINgV1cSMNuV80Od9/9mw0g8WTGV/HetgfUf+/hlXVmixNF2SNspqXxDTw1tzrIxkkhCALva0Ben6WbLbI9eEOY/gAcUY7JpA8i7yBdK/eSGyzPH7WVdYDe7chLVsnou7SucNWw/eM+kK08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723470778; c=relaxed/simple;
	bh=HX8L5Xz5+6AFfuzNrgZvttKdITdkSvfTq8Y7KblzC1Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Wfh2EeGIw+WUt8JDuNSDRpfMfYaFH0Jo4pZ3O01lmTTIGN7jFAY5Vwse88RkZvLS0t3qDHiz/dbuRY1PopngNpx9dNesamSe7gYArLTrxZM52FbhWuPTVP2/606rEefMAMbEtWsr9E7wI6IUCGtog1aOjBGENll2Yre5TiK2qwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=urNmxNPn; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723470776; x=1755006776;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HX8L5Xz5+6AFfuzNrgZvttKdITdkSvfTq8Y7KblzC1Q=;
  b=urNmxNPn/ltqpq7OmMcgVRAObanf+DTwdl4yBJwmKJuyufnR9RJ8V3n0
   Jr86rnx33LSkGTvUqvDeImlI7u6Sfm6dZwcoAIrh0D2zN0jw7eDslY6Ie
   OPlxA0SPJg7+WjKYRHqWpekcVsmPWuS9mngWB87CAfk69BQ5Ke4CG0kH/
   MvqEiCprfRxKmV92m32TmPiZMOKWbBzhGpEg5JEKyUW8sbBpRx37nAjhx
   8E1Qp/6x1s/JA90baqs39eTvsIyROZdF7rFIHN0hMgvXrPJWWUfrrRXcl
   NKfOy418qYOGDVMNMk2t/EDIEJdvEkF6HPYAO1MzkYdfVu1F+vbd6Uun/
   g==;
X-CSE-ConnectionGUID: PBrTB/MiTDi13LaLj3S1lQ==
X-CSE-MsgGUID: cNWintu3SVyu3OAkIhnpKQ==
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="33289887"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Aug 2024 06:52:55 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Aug 2024 06:52:37 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 12 Aug 2024 06:52:35 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
	<nicolas.ferre@microchip.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<robh@kernel.org>, <alexandre.belloni@bootlin.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Andrei Simion <andrei.simion@microchip.com>
Subject: [PATCH v2 0/7] Add input voltage suppliers for PMIC MCP16502 regulators
Date: Mon, 12 Aug 2024 16:52:24 +0300
Message-ID: <20240812135231.43744-1-andrei.simion@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

In this series of patches, support for the *-supply property [1]  is added
(correlated with supply_name [2]) from the core regulator.
Link [1]: https://github.com/torvalds/linux/blob/master/drivers/regulator/core.c#L471
Link [2]: https://github.com/torvalds/linux/blob/master/drivers/regulator/core.c#L2064

I modified the mcp16502.c driver and the dts that use this PMIC.
We added these improvements to provide a complete description of the board power scheme.

Snippet (as an example) from /sys/kernel/debug/regulator/regulator_summary
(for at91-sama7g5ek):
 # cat regulator_summary
 regulator                      use open bypass  opmode voltage current     min     max
---------------------------------------------------------------------------------------
 regulator-dummy                  1    0      0 unknown     0mV     0mA     0mV     0mV
 5V_MAIN                          6    6      0 unknown  5000mV     0mA  5000mV  5000mV
    VDD_IO                        5    4      0  normal  3300mV     0mA  3300mV  3300mV
       e1208000.mmc-vqmmc         1                                 0mA     0mV     0mV
       e1208000.mmc-vmmc          1                                 0mA  3300mV  3400mV
       e1204000.mmc-vmmc          1                                 0mA  3300mV  3400mV
       VDDOUT25                   3    2      0 unknown  2500mV     0mA  2500mV  2500mV
          e1000000.adc-vref       1                                 0mA     0mV     0mV
          e1000000.adc-vddana     1                                 0mA     0mV     0mV
    VDD_DDR                       1    0      0  normal  1350mV     0mA  1350mV  1350mV
    VDD_CORE                      1    0      0  normal  1150mV     0mA  1150mV  1150mV
    VDD_OTHER                     2    1      0  normal  1050mV     0mA  1050mV  1250mV
       cpu0-cpu                   1                                 0mA  1050mV  1225mV
    LDO1                          2    1      0 unknown  1800mV     0mA  1800mV  1800mV
       e1204000.mmc-vqmmc         1                                 0mA     0mV     0mV
    LDO2

-------------------------------------------------------------------------------------------

Changelog:

v1 -> v2:
 - drop (lvin|pvin[1-4])-supply from each regulators sub-node
 - add voltage input supply documentation in the yaml schema
 - add lvin-supply, pvin[1-4]-supply to PMIC node

Andrei Simion (7):
  regulator: mcp16502: Add supplier for regulators
  regulator: dt-bindings: microchip,mcp16502: Add voltage input supply
    documentation
  ARM: dts: microchip: at91-sama7g5ek: Add reg_5v to supply PMIC nodes
  ARM: dts: microchip: at91-sama7g54_curiosity: Add reg_5v to supply
    PMIC nodes
  ARM: dts: microchip: at91-sama5d2_icp: Add reg_5v to supply PMIC nodes
  ARM: dts: microchip: at91-sama5d27_wlsom1: Add reg_5v to supply PMIC
    nodes
  ARM: dts: microchip: sama5d29_curiosity: Add reg_5v to supply PMIC
    nodes

 .../regulator/microchip,mcp16502.yaml         | 20 +++++++++++++++++++
 .../dts/microchip/at91-sama5d27_wlsom1.dtsi   | 13 ++++++++++++
 .../dts/microchip/at91-sama5d29_curiosity.dts | 13 ++++++++++++
 .../boot/dts/microchip/at91-sama5d2_icp.dts   | 13 ++++++++++++
 .../dts/microchip/at91-sama7g54_curiosity.dts | 13 ++++++++++++
 .../arm/boot/dts/microchip/at91-sama7g5ek.dts | 13 ++++++++++++
 drivers/regulator/mcp16502.c                  | 17 ++++++++--------
 7 files changed, 94 insertions(+), 8 deletions(-)


base-commit: 9e6869691724b12e1f43655eeedc35fade38120c
-- 
2.34.1


