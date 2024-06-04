Return-Path: <linux-kernel+bounces-200286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0428FAE1A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 10:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8F091F27133
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 08:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C8B1442F6;
	Tue,  4 Jun 2024 08:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="M35XJqsj"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75184143C55;
	Tue,  4 Jun 2024 08:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717491208; cv=none; b=gAdXsVWCu0w1U+T+7T/jFPxmmiGTQ4DW9Hn770InQYWfFj/8pExtmJ3XQiiZKXS6S0LoGUORTuCaksl/4sGqcyfHMNmgQwErorLMp8yZv3voUI19T8+T/LN9XDgAyb6NcGiZ642IFDo4cyOVABCPTA7WbKgNuWAlLRsW/k7Vnas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717491208; c=relaxed/simple;
	bh=hOptQPKCRBaU50AovYzINhj1F0zsK8GV1tpsJ5h++qE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=blQSiB20wE7x87slcyqKhkCBvFCivD+ivPghkkJZ/ZMwRokeLXL74qSlJ2yPo4777evjYL1Cn7hqP9zcfeUH3JsSTunO6VSE8NJyTVc2z6f/TMR3DZ7jznWoRHFB4kbQIEWHrxwqmLAZuU96Hh3fjC2GO4LCAKjd3AMTbOGbaPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=M35XJqsj; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4548rKqM056337;
	Tue, 4 Jun 2024 03:53:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717491200;
	bh=ZTsbZfu8/YTvTzsrJnQEvxfQtqxK+nv3kaQq41L7VPQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=M35XJqsjMWMG1BgXsW8Cotok28+qKjuuKCNO64RIQvUbVsFeWdqxkOIDGEx9s05eA
	 9D+QKZVQqTfPP/TZTHV2zOvDQ38cA5HVdEp3uhJaiFIoca4myXFyF3xN1QoupuCAIP
	 lI4sHB7CcKdNaHvB/i+a4kHWyfhKstfGU+nuxTXM=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4548rKN3038151
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 4 Jun 2024 03:53:20 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 4
 Jun 2024 03:53:19 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 4 Jun 2024 03:53:19 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4548qqQm066926;
	Tue, 4 Jun 2024 03:53:15 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <afd@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <rogerq@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>,
        <danishanwar@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v5 5/7] arm64: dts: ti: k3-serdes: Add SERDES0/SERDES1 lane-muxing macros for J722S
Date: Tue, 4 Jun 2024 14:22:50 +0530
Message-ID: <20240604085252.3686037-6-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240604085252.3686037-1-s-vadapalli@ti.com>
References: <20240604085252.3686037-1-s-vadapalli@ti.com>
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
---
v4:
https://lore.kernel.org/r/20240601121554.2860403-6-s-vadapalli@ti.com/
No changes since v4.

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


