Return-Path: <linux-kernel+bounces-309141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AA69666AA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 18:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 843501C23345
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 16:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0F413635B;
	Fri, 30 Aug 2024 16:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wHioC93j"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C4913BAE2;
	Fri, 30 Aug 2024 16:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725034680; cv=none; b=YW4EpvxtQhtSSVvZNvM4GdLETQU+IdoxrqkYAkY/bBA5xsUMtXEBi9RUqP6rnNuq9sg8F01DrhdlIXXZvvcTG21VWYiUJFL57r0Gotkouu2iV7B+IlT1N7tGuddyOjnaWm6H9TyELY13BspaZeMJ7IsxDwgszCZreCv4ICgsZ/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725034680; c=relaxed/simple;
	bh=ATJQNG8rM8U+FSMFMTLa7/k6xzhzPq1LljJusJ9izkg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IlvxB5ix2dz7QveDxd2vUrUloe+a90kuGB8QeekALdGvl5cdrgyTpo8AhZA5/pEfO6v5+dngHPGiRXZYdDB6wkz7G41+70KXYQS7tW398Oj3nEggJkEvjGAi20//xDQqSai0n/Wi+U/SaK3phxBygvYRdV7YL5FjbZgaCTc7aac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wHioC93j; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47UGHljs011668;
	Fri, 30 Aug 2024 11:17:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725034667;
	bh=bd6znF1DBuXuP06gRhAIUJqJAdeFMRW6+u3yW+JnL2o=;
	h=From:To:CC:Subject:Date;
	b=wHioC93j+bkMlBOe7g8V19sg0mbhV9tpgdmzoFOYqP4t46h8VGzzIqLkURXucB8x4
	 +QXH6/Tk4HRZjV2FbgzLgcrnEZiGXbZmOuO6ABQaJC0stU00U4Wq5PdXIvJijXh0uy
	 5rnK0o3lX3DGOKJcjDZR5Frn0hqP5vUy9ZK4s1xE=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47UGHlVR064110;
	Fri, 30 Aug 2024 11:17:47 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 30
 Aug 2024 11:17:47 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 30 Aug 2024 11:17:46 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.227.151])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47UGHhRa103243;
	Fri, 30 Aug 2024 11:17:43 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <u-kumar1@ti.com>, <j-choudhary@ti.com>, <vaishnav.a@ti.com>, <afd@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v5 0/2] Add Remoteproc Support for TI's J722S SoCs
Date: Fri, 30 Aug 2024 21:47:40 +0530
Message-ID: <20240830161742.925145-1-b-padhi@ti.com>
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
in MAIN voltage domain. Thus, this series adds the DT Nodes for the
remote processors to add support for IPC.

This series also enables IPC on the J722S-EVM platform based on the
above SoC by adding the mailbox instances, shared memory carveouts and
reserving the conflicting timer nodes (as they are used by remoteproc
firmware).

v5: Changelog:
- Collected Reviewed-by tags from Udit and Andrew given in v4 version
of patch ("arm64: dts: ti: k3-j722s-main: Add R5F and C7x remote
processor nodes")
 
* Udit
1) Updated commit message to correctly reflect the host core name (A53
not A72) in patch "arm64: dts: ti: k3-j722s-evm: Enable Inter-Processor
Communication" 
2) Updated mbox DT node label and name to "mbox_wkup_r5_0" from
"mbox_r5_0" for clarity in patch "arm64: dts: ti: k3-j722s-evm: Enable
Inter-Processor Communication"

Link to v4:
https://lore.kernel.org/all/20240829060932.3441295-1-b-padhi@ti.com/

v4: Changelog:
* Nishanth:
1) Fixed DT node properties order to put standard properties before vendor
specific properties in patch "arm64: dts: ti: k3-j722s-main: Add R5F
and C7x remote processor nodes"
2) Put "status" property at the end in extended DT nodes and preceded
child nodes with a single blank line wherever applicable in patch
"arm64: dts: ti: k3-j722s-evm: Enable Inter-Processor Communication"
following kernel DTS coding style.

Link to v3:
https://lore.kernel.org/all/20240828112713.2668526-1-b-padhi@ti.com/

v3: Changelog:
1) Reserved conflicting Timer Nodes in k3-j722s-evm.dts file to avoid remotecore
boot failures.

Link to v2:
https://lore.kernel.org/all/20240612112259.1131653-1-b-padhi@ti.com/

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
  arm64: dts: ti: k3-j722s-evm: Enable Inter-Processor Communication

 arch/arm64/boot/dts/ti/k3-j722s-evm.dts   | 157 ++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi |  61 +++++++++
 2 files changed, 218 insertions(+)

-- 
2.34.1


