Return-Path: <linux-kernel+bounces-312472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF13E969718
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 514541F2249A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417C52139AC;
	Tue,  3 Sep 2024 08:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iyxhHipF"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C9C1D0485;
	Tue,  3 Sep 2024 08:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725352295; cv=none; b=URq2lmPCWdvUuEwx+Mr5P2nYUsxj/PKOIqtEppyTVVS9hqQ25m+16Q8N/1Zy+1PcOAP3OyndhfExP+b+CKQScDtaHTvdZaWSsxKu+wJH8dMcSRxLLF9cNEkTvZ1p3KAwBuzdtDYlZ0+EDlQ3DKTlkBpTNYp319sB68Op0Zw29EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725352295; c=relaxed/simple;
	bh=jk1+gsXZIcguCKGXkSDts4AlsEhDcorJkvUbsJhFuj0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gzWazoQKJmEKTSeaT4ygB008HDCN+dLis0zbO3AXL7RuiWV+K54u1R3JVCgX6uzNuDDoEsAeTnli386eg4PhlIigF1TCsNlZTfEGuEkYhbafnzsk6WqCQsnbUk/zhYJ9jYPfTQlB1bjwfbYtj5f33etxRIbD79CpXKIisEzgLVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=iyxhHipF; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4838VFVq012845;
	Tue, 3 Sep 2024 03:31:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725352275;
	bh=r/ew5NOkndZuuSGNjvFeQtkZxHPlPPdvrvcAeP2sPk0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=iyxhHipF1DQ0ReaLJvbtU/7qwSw1BGXTTuacfNUnJrpm8Si0ASDZJfq/51w450eSx
	 wbeyOfcEo531rhHlj4Q33fr0avviu8QKc3jIg3pcgtgZH0XgAKuxhuUdQs5o7eReEc
	 u01Mo1iOYwinUPkEQ5WV/Rfaixeh5k3slOc42YH0=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4838VFgC017237
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 3 Sep 2024 03:31:15 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Sep 2024 03:31:15 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Sep 2024 03:31:15 -0500
Received: from uda0490681.. ([10.24.69.142])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4838V7kV085647;
	Tue, 3 Sep 2024 03:31:12 -0500
From: Vaishnav Achath <vaishnav.a@ti.com>
To: <tglx@linutronix.de>, <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <xen-devel@lists.xenproject.org>,
        <u-kumar1@ti.com>, <vaishnav.a@ti.com>
Subject: [RFC DONOTMERGE PATCH 1/1] arm64: dts: ti: k3-am62p-main: Add interrupts property for DMSS INTA
Date: Tue, 3 Sep 2024 14:01:07 +0530
Message-ID: <20240903083107.3562816-2-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903083107.3562816-1-vaishnav.a@ti.com>
References: <20240903083107.3562816-1-vaishnav.a@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The interrupt aggregator in DMSS for TI K3 devices currently uses a
custom vendor property "ti,interrupt-ranges" to specify the interrupt
source to parent mapping. As per interrupt controller bindings [1],
it is mandatory for Nodes that describe devices which generate
interrupts to contain an "interrupts" property, an "interrupts-extended"
property, or both. Add interrupts property to the Interrupt aggregator
node so that the mapping is specified in a standard manner.

1 - https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/interrupt-controller/interrupts.txt

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---

DONOTMERGE - while adding the interrupts property helps to conform to the
bindings, it is difficult to maintain the long list and this is not the only
platform affected, if this is the direction to fix it, I will fix for all K3
platforms together, more details on RFC in cover letter.

 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi | 35 +++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
index 420c77c8e9e5..0c7912d177fe 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
@@ -40,6 +40,41 @@ &oc_sram {
 
 &inta_main_dmss {
 	ti,interrupt-ranges = <5 69 35>;
+	interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
 };
 
 &main_pmx0 {
-- 
2.34.1


