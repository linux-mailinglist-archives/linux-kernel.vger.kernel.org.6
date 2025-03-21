Return-Path: <linux-kernel+bounces-570986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C94CA6B79B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 10:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1859C17EB4C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 09:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0482A214A7A;
	Fri, 21 Mar 2025 09:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="gduAHBk4"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9455A215078;
	Fri, 21 Mar 2025 09:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742549696; cv=none; b=pjQylMsb3HY61vmpOQdc1Xqcb/mYCTFqaM5SOJ8qkubON93bYFz2pr/xFY3hOLdT7dLl7gJCKs+B1eiLKePpj2XCchsyMRT8dN5UG87WbW5sktL1Fouc3fsGTVOYavFKHMTqEL9qWQzv5fStpHGiyjUWZRXEz/SZ/CiOnVdkeKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742549696; c=relaxed/simple;
	bh=UqY2D0wkm102XJ0ymHX2ONI5obBB6nSiwLlmcfPIIuA=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=lfRWG0ifrrdDHlUdqvGbnlFKKshITOtV0rQEodFdTOxx3n5ktG9RcFqIZaj2wDumBL/LCONpzHdKFSv4VMtNjF1hOthAjueaX9MYfhBGNK1kr629f6EAdf8TfT5AkgRVxPp0H1wCAVjFWmVMSKDih/b7P3vFL2SLLglkMamrCN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=gduAHBk4; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52L6aNsT022716;
	Fri, 21 Mar 2025 10:34:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=Zsmdh6nu+UJnS8Y882xvMr
	X/hRslcMdqQk91zAyTeUM=; b=gduAHBk4A5DkYZP8H9MJxdny5IxbEc+HE0AKO7
	hSvYtEzqqlETpW4tCPVZwQO9wsFZrIGWfZ3jHkhldYWox/DjoXvlBPWS96uYVbBM
	jRhvgaNf1XeocXPkJvKQaO75AU2GRIzFPyfLB9qiiiRn3R8tPFtpy1OFOH1fAV8G
	avNooEz47mic31BbnHb2JU2/teejiD6YiLtPsLaQXNcMlRRxNlWE+w9SWy4fNaiD
	WjBJnn9lS1U02xLvOEGMvgJTkTILGt+gewTpr8qGmGjw2qSGa8xthbQh0BDXgE+0
	0SRAhEG3lPgO9Q3bJe4xF5zs70gZeW/mEsrkbDc9lwewCnpA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 45ght64hse-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 10:34:29 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 4CFBA40059;
	Fri, 21 Mar 2025 10:33:16 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BA87F7B7160;
	Fri, 21 Mar 2025 10:32:25 +0100 (CET)
Received: from localhost (10.252.27.50) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Mar
 2025 10:32:25 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH v6 0/7] Add STM32MP25 SPI NOR support
Date: Fri, 21 Mar 2025 10:32:20 +0100
Message-ID: <20250321-upstream_ospi_v6-v6-0-37bbcab43439@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACQy3WcC/x3MSwqAMAwA0atI1hZq/OJVRErRqFmopdEiFO9uc
 fkWMxGEPJNAn0XwFFj4PBKaPINps8dKiudkQI21LlGr28nlye7mFMcmNGquSrRd0WKha0iZ87T
 w8y+H8X0/Axy0L2IAAAA=
X-Change-ID: 20250320-upstream_ospi_v6-d432a8172105
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon
	<will@kernel.org>
CC: <christophe.kerello@foss.st.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Patrice Chotard
	<patrice.chotard@foss.st.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SAFCAS1NODE2.st.com (10.75.90.13) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_03,2025-03-20_01,2024-11-22_01

This series adds SPI NOR support for STM32MP25 SoCs from STMicroelectronics.

On STM32MP25 SoCs family, an Octo Memory Manager block manages the muxing,
the memory area split, the chip select override and the time constraint
between its 2 Octo SPI children.

Due to these depedencies, this series adds support for:
  - Octo Memory Manager driver.
  - Octo SPI driver.
  - yaml schema for Octo Memory Manager and Octo SPI drivers.

The device tree files adds Octo Memory Manager and its 2 associated Octo
SPI chidren in stm32mp251.dtsi and adds SPI NOR support in stm32mp257f-ev1
board.
    
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>

Changes in v6:
  - Update MAINTAINERS file.
  - Remove previous patch 1/8 and 2/8, merged by Mark Brown in spi git tree.
  - Fix Signed-off-by order for patch 3.
  - OMM driver:
    - Add dev_err_probe() in error path.
    - Rename stm32_omm_enable_child_clock() to stm32_omm_toggle_child_clock().
    - Reorder initialised/non-initialized variable in stm32_omm_configure()
          and stm32_omm_probe().
    - Move pm_runtime_disable() calls from stm32_omm_configure() to
      stm32_omm_probe().
    - Update children's clocks and reset management.
    - Use of_platform_populate() to probe children.
    - Add missing pm_runtime_disable().
    - Remove useless stm32_omm_check_access's first parameter.
  - Update OMM's dt-bindings by adding OSPI's clocks and resets.
  - Update stm32mp251.dtsi by adding OSPI's clock and reset in OMM's node.

Changes in v5:
  - Add Reviewed-by Krzysztof Kozlowski for patch 1 and 3.

Changes in v4:
  - Add default value requested by Krzysztof for st,omm-req2ack-ns,
    st,omm-cssel-ovr and st,omm-mux properties in st,stm32mp25-omm.yaml
  - Remove constraint in free form test for st,omm-mux property.
  - Fix drivers/memory/Kconfig by replacing TEST_COMPILE_ by COMPILE_TEST.
  - Fix SPDX-License-Identifier for stm32-omm.c.
  - Fix Kernel test robot by fixing dev_err() format in stm32-omm.c.
  - Add missing pm_runtime_disable() in the error handling path in
    stm32-omm.c.
  - Replace an int by an unsigned int in stm32-omm.c
  - Remove uneeded "," after terminator in stm32-omm.c.
  - Update cover letter description to explain dependecies between
Octo Memory Manager and its 2 Octo SPI children.

Changes in v3:
  - Squash defconfig patches 8 and 9.
  - Update STM32 Octo Memory Manager controller bindings.
  - Rename st,stm32-omm.yaml to st,stm32mp25-omm.yaml.
  - Update STM32 OSPI controller bindings.
  - Reorder DT properties in .dtsi and .dts files.
  - Replace devm_reset_control_get_optional() by
    devm_reset_control_get_optional_exclusive() in stm32_omm.c.
  - Reintroduce region-memory-names management in stm32_omm.c.
  - Rename stm32_ospi_tx_poll() and stm32_ospi_tx() to respectively to
    stm32_ospi_poll() and stm32_ospi_xfer() in spi-stm32-ospi.c.
  - Set SPI_CONTROLLER_HALF_DUPLEX in controller flags in spi-stm32-ospi.c.

Changes in v2:
  - Move STM32 Octo Memory Manager controller driver and bindings from
    misc to memory-controllers.
  - Update STM32 OSPI controller bindings.
  - Update STM32 Octo Memory Manager controller bindings.
  - Update STM32 Octo Memory Manager driver to match bindings update.
  - Update DT to match bindings update.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
Patrice Chotard (7):
      MAINTAINERS: add entry for STM32 OCTO MEMORY MANAGER driver
      dt-bindings: memory-controllers: Add STM32 Octo Memory Manager controller
      memory: Add STM32 Octo Memory Manager driver
      arm64: dts: st: Add OMM node on stm32mp251
      arm64: dts: st: Add ospi port1 pinctrl entries in stm32mp25-pinctrl.dtsi
      arm64: dts: st: Add SPI NOR flash support on stm32mp257f-ev1 board
      arm64: defconfig: Enable STM32 Octo Memory Manager and OcstoSPI driver

 .../memory-controllers/st,stm32mp25-omm.yaml       | 227 ++++++++++
 MAINTAINERS                                        |   6 +
 arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi      |  51 +++
 arch/arm64/boot/dts/st/stm32mp251.dtsi             |  54 +++
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts         |  32 ++
 arch/arm64/configs/defconfig                       |   2 +
 drivers/memory/Kconfig                             |  17 +
 drivers/memory/Makefile                            |   1 +
 drivers/memory/stm32_omm.c                         | 474 +++++++++++++++++++++
 9 files changed, 864 insertions(+)
---
base-commit: 88424abd55ab36c3565898a656589a0a25ecd92f
change-id: 20250320-upstream_ospi_v6-d432a8172105

Best regards,
-- 
Patrice Chotard <patrice.chotard@foss.st.com>


