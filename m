Return-Path: <linux-kernel+bounces-193727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A028B8D3137
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C93FB2BDC9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B0016EBE7;
	Wed, 29 May 2024 08:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wf5DmHRW"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900A7168C3D;
	Wed, 29 May 2024 08:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716971006; cv=none; b=qdgm2IgEe6wFyq7Oz4QcdxSyAcuZXXrMK6MTtf00UPIoyOOphY4jypgebDSL3+xUpegOyspCtPIx13V9axqDSUI23NVCtm5fkd7KCKgymdSkJ/qha/b5MqNecARCwjrh1n5SlC7YF77yKfwxWShU4IuvSeY84dPjeI1QPHa+7/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716971006; c=relaxed/simple;
	bh=mawRK5aA/EMwju15c9CJjjLslMegigQKs81Kuy+CIzg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uv+i2gUQ6GmWpRMnhR7d7PmOgxHyJnrNp8WHVt3a0P2ExX4ZH4gTIwxvLZp4YFR7qrqwJIphlKzjKO8Fj9j/CEsxKHkEqIl7PqVPDtceLbFRyQJxZeHBd5plPa+ZfjJqcSkUkcqEQzD0THWF1PwqkOEXS53A9jmYm/SD6NAdaHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wf5DmHRW; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44T8N5jP028176;
	Wed, 29 May 2024 03:23:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716970985;
	bh=GA84cJ8nNnm/xjeHKTyGRus4Kr3hXRBkbAwrEXa69NI=;
	h=From:To:CC:Subject:Date;
	b=wf5DmHRWdAUIVyzyR3VzxbjbUXqYbnyu5p5it8WEZaNoZjbhR/txYWd4abn8aD6OF
	 /DJb6ncZpbD2OR1OQt/+qOCH0Q+Fban0n4+LE3ba0qNLCXPIlLwqBLC5+BEa1Fie/7
	 ha6ZHxGXzmMKqS6MbJrRvVOPc/jblFuJyyLeDFoQ=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44T8N5r9048695
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 29 May 2024 03:23:05 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 29
 May 2024 03:23:04 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 29 May 2024 03:23:04 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44T8N0d6084708;
	Wed, 29 May 2024 03:23:00 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <francesco@dolcini.it>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <sabiya.d@ti.com>,
        <u-kumar1@ti.com>, <danishanwar@ti.com>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v4 0/4] Add PCIe DT support for TI's J784S4-EVM and AM69-SK
Date: Wed, 29 May 2024 13:52:55 +0530
Message-ID: <20240529082259.1619695-1-s-vadapalli@ti.com>
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

TI's J784S4 SoC has two x4 Lane and two x2 Lane Gen3 PCIe Controllers.
This series adds the device-tree nodes for all 4 PCIe instances in the
SoC file (k3-j784s4-main.dtsi). The J784S4-EVM board has only PCIe0 and
PCIe1 instances of PCIe brought out while the AM69-SK board has PCIe0,
PCIe1 and PCIe3 instances of PCIe brought out. The device-tree overlay
to enable PCIe0 and PCIe1 in Endpoint mode of operation on J784S4-EVM is
also included in this series.

v3:
https://lore.kernel.org/r/20240523111008.4057988-1-s-vadapalli@ti.com/
Changes since v3:
- Rebased on linux-next tagged next-20240528.
- Added ranges for PCIe2 and PCIe3 in k3-j784s4.dtsi which was missed in
  v3 series.
- Added new patch in this series for enabling PCIe on AM69-SK board.

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

Test Logs:
1. J784S4-EVM PCIe0 and PCIe1 in RC Mode with NVMe SSD connected to PCIe0:
https://gist.github.com/Siddharth-Vadapalli-at-TI/af94b2da5dd0613de8a238e37f70eb7e
2. J784S4-EVM PCIe0 as Endpoint and AM69-SK PCIe0 acting as RC:
https://gist.github.com/Siddharth-Vadapalli-at-TI/1d305c5145bdc34975615e15fe0f433c
3. J784S4-EVM PCIe1 as Endpoint and AM69-SK PCIe0 acting as RC:
https://gist.github.com/Siddharth-Vadapalli-at-TI/3129da32c9984f4f02351ca03105e49e
4. AM69-SK PCIe0, PCIe1 and PCIe3 in RC Mode with NVMe SSD connected to
PCIe0:
https://gist.github.com/Siddharth-Vadapalli-at-TI/5571eb0a0273501fcc214519beab6713

Regards,
Siddharth.

Dasnavis Sabiya (1):
  arm64: dts: ti: k3-am69-sk: Add PCIe support

Siddharth Vadapalli (3):
  arm64: dts: ti: k3-j784s4-main: Add PCIe nodes
  arm64: dts: ti: k3-j784s4-evm: Enable PCIe0 and PCIe1 in RC Mode
  arm64: dts: ti: k3-j784s4-evm: Add overlay for PCIe0 and PCIe1 EP Mode

 arch/arm64/boot/dts/ti/Makefile               |   7 +-
 arch/arm64/boot/dts/ti/k3-am69-sk.dts         |  60 ++++++++
 .../dts/ti/k3-j784s4-evm-pcie0-pcie1-ep.dtso  |  79 ++++++++++
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts      |  46 ++++++
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi    | 136 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j784s4.dtsi         |  10 +-
 6 files changed, 336 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-evm-pcie0-pcie1-ep.dtso

-- 
2.40.1


