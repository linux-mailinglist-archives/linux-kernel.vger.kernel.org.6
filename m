Return-Path: <linux-kernel+bounces-187374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FDB8CD0E6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 13:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4063E1F22461
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98982145B15;
	Thu, 23 May 2024 11:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dawR48G5"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD251448E1;
	Thu, 23 May 2024 11:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716462631; cv=none; b=RQ7xnNq8DzZkD4dlgRvU79PwVlAljeKScfSAoZDlVptTRQJzF6a+18V1OSmv5NTixj79wceRGvSN80Og1aC7bhSA2bBBk1W0WKYzbOkIdtNk/kTJHvS9pj4FRIu6W7pawbTiywnRiO634uJgE8XGilH/sltx0SrTJArGqW4dvEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716462631; c=relaxed/simple;
	bh=993E6Og7q7rp4w6jikosHoILPHeQ0Bn8iFFZ7MQLNq4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G6evxZXjrEls6UAARD8zZZ8owffxxi5LXCVhhL70nOcfanFfdpqj+Kz8fNB406PmF3fLl6YLRAwbfqdzFAZ6NcFZrRMOSZWgo87W2mieu4ioWfycbuxk/lgdd1uHiuseiUTNGQqPNMjHUS4H+7u2w99+wJtyY9wWECfmFw3EK+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dawR48G5; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44NBAEJE087367;
	Thu, 23 May 2024 06:10:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716462614;
	bh=IhXMjns6cBU5P/4SY9BY7kWj8Gws83AomFhTo1xso74=;
	h=From:To:CC:Subject:Date;
	b=dawR48G5/IdVAbp7t2C1NwLtFtSTHGreZmDJIXGpJXInhyzhRti1yExL7+jMIKPDd
	 MKJCcvsmSVNDdfQKTSo9D3l2AowebiQI5Lw6QAhl1bnXm1tNnmP4CQlJE+hx3jW3dU
	 pEn9yfnxlT+OnlHJvQVVYQmCzU8NaoGZOBJcapqc=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44NBAED7051169
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 23 May 2024 06:10:14 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 23
 May 2024 06:10:13 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 23 May 2024 06:10:13 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44NBA9Ea082115;
	Thu, 23 May 2024 06:10:10 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <francesco@dolcini.it>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <danishanwar@ti.com>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v3 0/3] Add PCIe DT support for TI's J784S4 SoC
Date: Thu, 23 May 2024 16:40:05 +0530
Message-ID: <20240523111008.4057988-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

TI's J784S4 has two x4 Lane and two x2 Lane Gen3 PCIe Controllers.
This series adds the device-tree nodes for all 4 PCIe instances in the
SoC file. The Board (J784S4-EVM) has only PCIe0 and PCIe1 instances of
PCIe brought out, due to which only those PCIe instances are being
enabled in the board file. The device-tree overlay to enable PCIe0 and
PCIe1 in Endpoint mode of operation is also included in this series.

v2:
https://lore.kernel.org/r/20240520101149.3243151-1-s-vadapalli@ti.com/
Changes since v2:
- Rebased on linux-next tagged next-20240523.
- Based on feedback from Francesco Dolcini <francesco@dolcini.it> at:
  https://lore.kernel.org/r/20240521200909.GA3707@francesco-nb/
  the device-tree nodes for PCIe2 and PCIe3 instances of PCIe have been
  added.

v1:
https://lore.kernel.org/r/20240129114749.1197579-1-s-vadapalli@ti.com
Changes since v1:
- Rebased series on linux-next tagged next-20240520.
- All dependencies mentioned in v1 series have been met. This series has
  no further dependencies for functionality.
- Added "pcie0_ctrl" and "pcie1_ctrl" nodes within the System Controller
  node (scm_conf). This enables reusing the existing
  "ti,syscon-pcie-ctrl" property without having to map the entire System
  Controller region for configuring the PCIe specific registers within
  "scm_conf". This change is also done in the "overlay" file in patch
  3/3 w.r.t. providing the phandle to the pcie0_ctrl and pcie1_ctrl
  nodes to the "ti,syscon-pcie-ctrl" property in the overlay.

Logs:
https://gist.github.com/Siddharth-Vadapalli-at-TI/cbf5255b72d7805e86331150a8b2b5c5

Regards,
Siddharth.

Siddharth Vadapalli (3):
  arm64: dts: ti: k3-j784s4-main: Add PCIe nodes
  arm64: dts: ti: k3-j784s4-evm: Enable PCIe0 and PCIe1 in RC Mode
  arm64: dts: ti: k3-j784s4-evm: Add overlay for PCIe0 and PCIe1 EP Mode

 arch/arm64/boot/dts/ti/Makefile               |   7 +-
 .../dts/ti/k3-j784s4-evm-pcie0-pcie1-ep.dtso  |  79 ++++++++++
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts      |  46 ++++++
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi    | 136 ++++++++++++++++++
 4 files changed, 267 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-evm-pcie0-pcie1-ep.dtso

-- 
2.40.1


