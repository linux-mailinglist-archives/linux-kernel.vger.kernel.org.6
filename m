Return-Path: <linux-kernel+bounces-211409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A23905147
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 13:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 656741F22233
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 11:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95EF16F28C;
	Wed, 12 Jun 2024 11:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Wqg/Q0xR"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C905016F0FE;
	Wed, 12 Jun 2024 11:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718191400; cv=none; b=fiSiIbozkYA0zP4lDBGs4aMqKbB5JwJEkZ+r3U9CembkDXKqPNlPT2YhlQzNzItm+TpHf7QUw9hGnq7Wic8CdZdYQpmikh+cGilR2YiO4cDmX0AX/xmrGQy1KTl2KEv0zzRSP14Nnc49cbGqRsh0Q/oxsenqrwUq74NmUgrEhLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718191400; c=relaxed/simple;
	bh=534oH8+Q1AHlG524zRYiQIfuf0EB8t3AqqP1TBBPJ2k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mgrMjklfsNTVfvJHcEop7qXqxjsExb3fRImrQl6Q2LDwRKkiPyHSDqc+64U6bleINj18FG/ha7MzTomAkTeww+aCSd7D+enBqIyePIunVRtw+6Mnr8xOsH3w96u7n3VZOXF2x4kW6GjBB0adbosb5Lxgm1RYpswrQyKv58ncSiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Wqg/Q0xR; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45CBN4WU082591;
	Wed, 12 Jun 2024 06:23:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718191384;
	bh=f4tmQ06PUN/lPqgTx/FqLaVS5S8nfGaFloq2iBvKEdo=;
	h=From:To:CC:Subject:Date;
	b=Wqg/Q0xR5e+k7rFjgpgpbP8cgAvYFgWCRiYjV4uyaxJbJdtAMXj504ed8SfjuIH1k
	 KlY+oKmm9eDX9tPupF0UmdhI6SC+Bb/GezOrtCu3lsg4wHxcDtRSGoj5ZxKBdQH9tR
	 qciiniVP6vbOD4QPO9/9SkE/INL+TeFMqsjRUPC8=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45CBN45T125625
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Jun 2024 06:23:04 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Jun 2024 06:23:04 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Jun 2024 06:23:03 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [10.24.69.66])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45CBMxe2120263;
	Wed, 12 Jun 2024 06:23:00 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <j-choudhary@ti.com>, <vaishnav.a@ti.com>,
        <afd@ti.com>, <u-kumar1@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] Add Remoteproc Support for TI's J722S SoCs
Date: Wed, 12 Jun 2024 16:52:57 +0530
Message-ID: <20240612112259.1131653-1-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello All,

The K3 J722S SoCs have one single-core Arm Cortex-R5F processor in each
of the WAKEUP, MCU and MAIN voltage domain, and two C71x DSP subsystems
in MAIN voltage domain. Thus, this series adds the DT Nodes and memory
carveout regions to add remoteproc support in J722S SoCs.

Note: This series is dependent on the following series that introduces
k3-j722s-main.dtsi file:
https://lore.kernel.org/linux-arm-kernel/20240604085252.3686037-4-s-vadapalli@ti.com/

v2: Changelog:
1) Addressed Andrew's comments to refactor remotecore nodes into
k3-j722s-main.dtsi file.
2) Squashed Patch 2 and 3 from V1 into Patch 2 in V2 as they were doing
the same logical thing.
3) The DTBs check warnings from V1 are automatically fixed after a
dt-binding patch[0] was merged in linux-next.

Link to v1:
https://lore.kernel.org/all/20240607090433.488454-1-b-padhi@ti.com/

[0]: https://lore.kernel.org/all/20240604171450.2455-1-hnagalla@ti.com/

Apurva Nandan (2):
  arm64: dts: ti: k3-j722s-main: Add R5F and C7x remote processor nodes
  arm64: dts: ti: k3-j722s-evm: Add memory carveouts for R5F and C7x

 arch/arm64/boot/dts/ti/k3-j722s-evm.dts   | 140 ++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi |  61 ++++++++++
 2 files changed, 201 insertions(+)

-- 
2.34.1


