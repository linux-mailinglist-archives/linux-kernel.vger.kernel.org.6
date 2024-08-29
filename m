Return-Path: <linux-kernel+bounces-306195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5B9963B06
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 08:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C137C1C24042
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 06:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127B915C120;
	Thu, 29 Aug 2024 06:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="azTZXJOw"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3D6158541;
	Thu, 29 Aug 2024 06:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724911787; cv=none; b=ML5PcgEIwQHT6I9jiBoiYanwsBz2xwQouie4z11RL2UGx1sCUfZbF7VW/W6UrsIH9gHa374zpcUxvSgbsQxGEk06Bg/AcHrc5OEISGlGGsHQuSREtXGAxogktAkd77TvIj5eMT8Cnbe8KlUPPFpGUf+btof3faUECqf/4EetXAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724911787; c=relaxed/simple;
	bh=GQkNWluE4Yum3sxtquyh8Yn4fcPJka2uCoYU0wdH/2k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pAF3/Fhv2XsrNXzpGOAbJgKlK6P+J8msFL+ffLWJibrX3Evp1TkfpR65uogN6DIpjbUcG/BDGTKpMhrjjycajInWYtTf258mIewOtyJcCrgVc4QTZ4M78vcwqTTG0Vc2XtzoDX5a59JhDtEpuD95w1EEkLLDK4dPPy1/JhDCdY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=azTZXJOw; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47T69bBo046248;
	Thu, 29 Aug 2024 01:09:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724911777;
	bh=Gy0jgFxTDIUQhAWoIr3XRLjpuQETE0i5KWeKsQ0IZNA=;
	h=From:To:CC:Subject:Date;
	b=azTZXJOwjjDOG4fSYfw6tZYyRV0b13bBWumypq2fxZYT+/GkV9hsfFk4ZDovJoK/y
	 zcFiAPg+ZJiBwjyptaLaUMD6zgO+Pc9GM0DTRzm1NXQBd/A2mgSteE/Cn38brKYnqx
	 NSNvqW/KbNf8GlKwk4fdhH9lpQMaXLHcGEzD9o5Y=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47T69bdF048456
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 Aug 2024 01:09:37 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 29
 Aug 2024 01:09:36 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 29 Aug 2024 01:09:36 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.227.151])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47T69XCI126434;
	Thu, 29 Aug 2024 01:09:33 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <u-kumar1@ti.com>, <j-choudhary@ti.com>, <vaishnav.a@ti.com>, <afd@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v4 0/2] Add Remoteproc Support for TI's J722S SoCs
Date: Thu, 29 Aug 2024 11:39:30 +0530
Message-ID: <20240829060932.3441295-1-b-padhi@ti.com>
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


