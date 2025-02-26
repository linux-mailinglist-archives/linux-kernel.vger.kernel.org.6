Return-Path: <linux-kernel+bounces-533868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A29EFA45F92
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50DB91884516
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2470821884A;
	Wed, 26 Feb 2025 12:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ix60J3aH"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B8D2153FD;
	Wed, 26 Feb 2025 12:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740573784; cv=none; b=bOsnK+DoCT1O7p8w50VFs46B7FZzTNQ/bm2CflcWJGqpClxWA2p0fyF/FF2ipk3aQg3RyzwirFsBCTmtvbofB12V50Gqg1QPA0n6ziUcZ/ws+8Egt5hhq3VZwHFSD5lREGNKpgOx7CFLWm32Xjgvo8IadZQyff6pmnMU5bwry7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740573784; c=relaxed/simple;
	bh=xP4uAYRHIg+KETbtRfnQNNjoI1lhhYCCtKTZ8Xhh5/g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MaEGCn6DdUUK7r3T8ppiBDw2lPqPuH7LXcSeJW9RBuFJSHSeGrLuthT6LFkgniGrKF4Y/0jzuijKgoQm/j2hPG1RPKcqbTqqw6istjT103gSW6hNdT4bNalXqe7pALkt2mjkvcYIKjg167wYgHVFg4Vmps/hyHTIH3HlqsPhrj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ix60J3aH; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51QCgogd1545393
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 06:42:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1740573770;
	bh=IckXbOF2nRYQWb48QXUhy/93/4hHgPTjFS69MgYdTaQ=;
	h=From:To:CC:Subject:Date;
	b=ix60J3aHGe5NRwygp6sRd0V6N5MtG4wYWGUlkoVADem3cVXwAiREbxsUnoCurA5k3
	 ahvhxy6WfdPVce7xiSE2DaxrUGiDVoTe3S1uFWNXykRDJkcwylJEF0hLIqmMLOioC6
	 998BGxjlt/HBGXHqQj7g7cxw1uc03V/PMwQLkgtc=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51QCgolN090066
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 26 Feb 2025 06:42:50 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 26
 Feb 2025 06:42:49 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 26 Feb 2025 06:42:49 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.113])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51QCgkI0094589;
	Wed, 26 Feb 2025 06:42:46 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v2 0/3] PCIe NTB and USB Overlays for J721E, J742S2 and J784S4
Date: Wed, 26 Feb 2025 18:12:42 +0530
Message-ID: <20250226124245.9856-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hello,

This series adds the device-tree overlays for PCIe NTB (Non-Transparent-
Bridge) functionality on J721E, J742S2 and J784S4 SoCs which have
at-least two instances of PCIe that are required for NTB.

The device-tree overlay for switching from Type-C USB interface to Type-A
USB interface on J742S2-EVM and J784S4-EVM is also included in this series.

Series is based on linux-next tagged next-20250226.

v1 of this series is at:
https://patchwork.kernel.org/project/linux-arm-kernel/cover/20250202093636.2699064-1-s-vadapalli@ti.com/
Changes since v1:
- s/epf_bus/epf-bus in the first and second patch of this series since
  node names shouldn't contain underscores.

Regards,
Siddharth.

Siddharth Vadapalli (3):
  arm64: dts: ti: k3-j721e-evm: Add overlay for PCIe NTB functionality
  arm64: dts: ti: k3-j784s4-j742s2-evm: Add overlay for PCIe NTB
  arm64: dts: ti: k3-j784s4-j742s2-evm: Add overlay to enable USB0
    Type-A

 arch/arm64/boot/dts/ti/Makefile               | 18 ++++
 .../boot/dts/ti/k3-j721e-evm-pcie-ntb.dtso    | 91 ++++++++++++++++++
 .../dts/ti/k3-j784s4-j742s2-evm-pcie-ntb.dtso | 92 +++++++++++++++++++
 .../ti/k3-j784s4-j742s2-evm-usb0-type-a.dtso  | 29 ++++++
 4 files changed, 230 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-evm-pcie-ntb.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-pcie-ntb.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-usb0-type-a.dtso

-- 
2.34.1


