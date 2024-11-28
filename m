Return-Path: <linux-kernel+bounces-424776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 766F89DB93C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 15:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFA3EB20FA2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 14:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3715A1AB52B;
	Thu, 28 Nov 2024 14:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dcWV03/i"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC283145A0F;
	Thu, 28 Nov 2024 14:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732802920; cv=none; b=N4PD4a4dEWBp6yRqI0gck86FVvqFJRJYlpxneiGZda09PIlBHosMXgV56YhLh0t2yjZZ9c5qvipBTkFWlw5d2rB4NYw+CfBjB94IRBTWNS3SzGK2RlmITorc1VCMevbu6+g+79fnT/2ciFskXhyZLBnuYfzp9i1VP6ORbyjbgVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732802920; c=relaxed/simple;
	bh=0ulj7edbSk0O1IV/CRCpQmp0lsdiWE4+qWFQa0Lynbw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jc3n6V22aghXBEMd2cSGh3KXnWnI1DPNLphgVCAerDdp1axGZ7Nn2sP/NHrA753OvXJ6WAAa3c+KMKGUQ2DTd0qpLG+w8SmiwsraVTRTtFBXnarXJbJM6mOXTNT086wp8/Prbk/rYZYH27rLUPuOD1ZRgHVOIkBd/QXf/Y5Eqdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dcWV03/i; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4ASE8UdD1171256
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Nov 2024 08:08:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1732802910;
	bh=pKkjyiFM8kQqUBx2zf57P1oCYH46iFzIJ7Um2K6g6p0=;
	h=From:To:CC:Subject:Date;
	b=dcWV03/ilYOQqteGmDYMbQm4y2WXmQc+Pn18DYKqugc3le+jrZ9jZeDqjDgT/Vewk
	 EcltJWqGDfAjh6fDSOVoVEKpMFpmS1uRBcEnrXs6JfBMRUWVX4BJOFILSsop1Ot5EX
	 NagJQFO8gZPROnCzXQ4iG/3coY/EINc/WKfoevZo=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4ASE8Ua4013188
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 28 Nov 2024 08:08:30 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 28
 Nov 2024 08:08:30 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 28 Nov 2024 08:08:30 -0600
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4ASE8Qcd019782;
	Thu, 28 Nov 2024 08:08:27 -0600
From: Neha Malcom Francis <n-francis@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>, <n-francis@ti.com>
Subject: [PATCH 0/2] Add support for K3 BIST
Date: Thu, 28 Nov 2024 19:38:23 +0530
Message-ID: <20241128140825.263216-1-n-francis@ti.com>
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

BIST (Built-In Self Test) is an IP responsible for triggering hardware
circuitry tests on both logic as well as memory blocks. This driver is
currently being upstreamed in U-Boot [1] and triggers these tests on
cores. This patch series adds the dt-binding as well as a node for BIST
on J784S4.

[1] https://lore.kernel.org/all/613efa0b-f785-444c-8769-ea40ac94d6f9@ti.com/T/

Neha Malcom Francis (2):
  dt-bindings: misc: bist: Add BIST dt-binding for TI K3 devices
  arm64: dts: ti: k3-j784s4-main: Add PBIST_14 node

 .../bindings/misc/ti,j784s4-bist.yaml         | 66 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi    | 11 ++++
 2 files changed, 77 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/ti,j784s4-bist.yaml

-- 
2.34.1


