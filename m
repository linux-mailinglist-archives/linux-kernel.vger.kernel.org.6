Return-Path: <linux-kernel+bounces-215775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDF29096DE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 10:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 020FC1F2492E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 08:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E96438DD6;
	Sat, 15 Jun 2024 08:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lnqYIkkC"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177FE18037;
	Sat, 15 Jun 2024 08:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718439401; cv=none; b=glWXRspSfR0P3fjriPOihsKOwH+m9oQoLiB9S3NtFI7Gq9ooDfUXsmZFxfpgZEqBEfD9fuaB9RrIiGY0pW6xZhN4gNLCnS2O5y/1f6eLcaKKe2HnEvRX3I+h6LRHp97XARzi1ZhxDo4i/qThsXF0DNL8OB+e3No8BWfYIqCOz2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718439401; c=relaxed/simple;
	bh=dUexP38crW4PGLu1FqbaeYNsUjEP9Z6NRgcFO78qlIE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nKRegndOCBSdVCMHXsvIVgygo4s2MA87Uo+p6vs2KloiMUs+BBjShv8F19VqhpqszLvzfE+V0fkk/p4ZFM19anLp52Vf6m4KJAbFjyEy4tg5f601vPzlsSWyqiLI7juQ680OVTubWJgOUz000BMuzG4VSUIk3hqTC8ERvdUJZcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lnqYIkkC; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45F8GSPU102747;
	Sat, 15 Jun 2024 03:16:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718439388;
	bh=ToP5EKkVGa1u0JhGEFQvR0WDOaWbVtUSajWl2oNi+AY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=lnqYIkkCZ2qbWhWBtGWK8YtyvYuNl0AKhwbVx+PKwMntSU7fw1LMi0S/UqgI2YrBA
	 KVB+ap587R+rZnndBv0UzjglzkQUbeifBBHgbmR8Grbpm/COGnmv/K4W8O+LNj30wZ
	 uAlsi5Z0+pxU3OgEat5+6+BJZOCd2sFJz1uxSTo8=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45F8GSvm084490
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 15 Jun 2024 03:16:28 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 15
 Jun 2024 03:16:27 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 15 Jun 2024 03:16:27 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45F8G1QZ024463;
	Sat, 15 Jun 2024 03:16:23 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <afd@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <rogerq@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>,
        <danishanwar@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v7 5/8] arm64: dts: ti: k3-serdes: Add SERDES0/SERDES1 lane-muxing macros for J722S
Date: Sat, 15 Jun 2024 13:45:57 +0530
Message-ID: <20240615081600.3602462-6-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240615081600.3602462-1-s-vadapalli@ti.com>
References: <20240615081600.3602462-1-s-vadapalli@ti.com>
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
v6:
https://lore.kernel.org/r/20240612132409.2477888-7-s-vadapalli@ti.com/
No changes since v6.

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


