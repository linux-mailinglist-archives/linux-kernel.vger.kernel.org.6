Return-Path: <linux-kernel+bounces-211560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39ABD9053BD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E019F2839FA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 13:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA79017E473;
	Wed, 12 Jun 2024 13:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sm7zEfkD"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9734B17E440;
	Wed, 12 Jun 2024 13:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718198689; cv=none; b=EV+Pkd6lfQdaW76k3+GBmQhDrg9y203izk5LFjE2uj3I12dh2jA8FIoXeZqxganfnd/J8/uudv+cY3uhmlexzicIqrEPb/3S8d3LBPHxZHYnNVs0H0421hQBWcNEXIyc+OPvxinL0XpjZESFrvq18QN9cP1Agaeme8ukGiKkVZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718198689; c=relaxed/simple;
	bh=a2mhhNhwhru4Qr/OnKO5CIu+Icy7g6+F7q+OVRZkWE4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pci/iwXRLuecFmhu6vFzzhqw64/HgwNye7r9IGehM4eyS8xTJ8PXGw+MCw6lkUIfwavI9sNx6MmpoRNokBkJWKDO3QCqDHxOoS8eLOrmnr1hwEhny35wFBg6tbr8djPxyF1EqQ2T13nATjKSsmTaYWZeE3DeBzNFL/2MD/nmc0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=sm7zEfkD; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45CDOfpF079277;
	Wed, 12 Jun 2024 08:24:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718198681;
	bh=4isp7/3bMlnEnXlgtEaJaWiCfyzYElSDJiQ9Orlzc/M=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=sm7zEfkD4HmXOnTayhTjrfB54IoJjWG3DM+v2fPvS+58Dmz0RvRmdWVAFsgkB9lUo
	 cyLT2850SV1L+2C0sMcKL7Q4Nfzwjr4oMNkvKrwUH2ibXkxZNz3Xcqg68v7M9aY2L4
	 I9spoQoZtWKVx5dhvy8Alewp+I/T6SrzlIpgaPkg=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45CDOf1O065614
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Jun 2024 08:24:41 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Jun 2024 08:24:41 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Jun 2024 08:24:41 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45CDOAmw046478;
	Wed, 12 Jun 2024 08:24:37 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <afd@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <rogerq@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>,
        <danishanwar@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v6 6/8] arm64: dts: ti: k3-serdes: Add SERDES0/SERDES1 lane-muxing macros for J722S
Date: Wed, 12 Jun 2024 18:54:07 +0530
Message-ID: <20240612132409.2477888-7-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240612132409.2477888-1-s-vadapalli@ti.com>
References: <20240612132409.2477888-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The SERDES0 and SERDES1 instances of SERDES on J722S are single lane
SERDES which are individually muxed across different peripherals.

LANE0 of SERDES0 is muxed between USB and CPSW while LANE0 of SERDES1 is
muxed between PCIe and CPSW.

Define the lane-muxing macros to be used as the idle state values.

Co-developed-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
---
v5:
https://lore.kernel.org/r/20240604085252.3686037-6-s-vadapalli@ti.com/
Changes since v5:
- Collected Reviewed-by tag from Roger Quadros <rogerq@kernel.org>

 arch/arm64/boot/dts/ti/k3-serdes.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-serdes.h b/arch/arm64/boot/dts/ti/k3-serdes.h
index a011ad893b44..ef3606068140 100644
--- a/arch/arm64/boot/dts/ti/k3-serdes.h
+++ b/arch/arm64/boot/dts/ti/k3-serdes.h
@@ -201,4 +201,12 @@
 #define J784S4_SERDES4_LANE3_USB		0x2
 #define J784S4_SERDES4_LANE3_IP4_UNUSED		0x3
 
+/* J722S */
+
+#define J722S_SERDES0_LANE0_USB			0x0
+#define J722S_SERDES0_LANE0_QSGMII_LANE2	0x1
+
+#define J722S_SERDES1_LANE0_PCIE0_LANE0		0x0
+#define J722S_SERDES1_LANE0_QSGMII_LANE1	0x1
+
 #endif /* DTS_ARM64_TI_K3_SERDES_H */
-- 
2.40.1


