Return-Path: <linux-kernel+bounces-304867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C38962605
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 13:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21A081C22908
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9E816EB53;
	Wed, 28 Aug 2024 11:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TBfjxxK/"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CFC15ECDF;
	Wed, 28 Aug 2024 11:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724844466; cv=none; b=RTwTKu8tOqO5taWdHY3dMe83cXLYKRZ2t3FHEWt5feqBHsuKoOJuEetZ6p91+YbkwH2sTnGaw5K6EbUQVBnDeO7auLTqpr+9RKIpqx9s+AeLdGXMGji3nb4IzNjw6BWQ/82iJcbQeMxC34f8mevHXas3ig+s3w9C1JgcdciUKVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724844466; c=relaxed/simple;
	bh=921Gu2m0OE0sOph8TYDD7nGRGyn7sSqlRXoNAgkkmGc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nStrq3dZCGs4jWRDSkViH36RKu47HL8QfRVehdbuVTCD45pszBl+Ljxcrm6eaf6rABqvQsMG1cvW/82ChrIgFMi03hUcRRP4FzrKBayGqCpZ6eGNUSLvsgenDU3RPJejZsGBZazCai6DcUj9L+boLMURK9o4B9ic+wASoJ7GVMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=TBfjxxK/; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47SBRJRA108700;
	Wed, 28 Aug 2024 06:27:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724844439;
	bh=OiPkBEEP9Xv40rrT6c0x34d/Af13Zfh8YxHZdYecy6s=;
	h=From:To:CC:Subject:Date;
	b=TBfjxxK/9mLVOs77FRe9I8SmF4RzhjsrNCFyH/97zl8kQZnCBT8ELLN8uFiY7Al/3
	 +3L8n56m1BtrDkUtDn87l+r3aMCPxNNs+tfS2TBtbiGJTWqWBGzCYjaXXgxpls5LR0
	 N/jJt1UA6dUv3+4uc0NnRWE1Alu/hxSPTSs/LUVQ=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47SBRIpX064355
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 28 Aug 2024 06:27:18 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 Aug 2024 06:27:18 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 Aug 2024 06:27:18 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.227.151])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47SBRE6F008364;
	Wed, 28 Aug 2024 06:27:15 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <u-kumar1@ti.com>, <j-choudhary@ti.com>, <vaishnav.a@ti.com>, <afd@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 0/2] Add Remoteproc Support for TI's J722S SoCs
Date: Wed, 28 Aug 2024 16:57:11 +0530
Message-ID: <20240828112713.2668526-1-b-padhi@ti.com>
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

 arch/arm64/boot/dts/ti/k3-j722s-evm.dts   | 153 ++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi |  61 +++++++++
 2 files changed, 214 insertions(+)

-- 
2.34.1


