Return-Path: <linux-kernel+bounces-197832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2918D6FC3
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 14:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BAA1282544
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 12:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074B7152786;
	Sat,  1 Jun 2024 12:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rrG/Jc7W"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E111115218E;
	Sat,  1 Jun 2024 12:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717244188; cv=none; b=fprkObnnztju4BNNSx0CyY6cbigT4IBEITizJZKafO3rfmLxAmwHuzJUuZznfN7ruzQvGMov5LC6ky1nFnIGBJeg5ZKY9/HcKeREj3b+jMv5UfvhhvcT+5od1CQq20mxz3vNazLoTeebYHRwau4C+rlzkopFksrjc7eID2KRJgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717244188; c=relaxed/simple;
	bh=yQDbUupnjaibcLMKIaOjuICn86fSYihVhq/gscyf5wE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hFdVZHUin+Ih+Zx6ERnfzAG2ziA3CWAc4IKM53bJYYPfXEf7ovGiRtykmSKg5wRta4cT8QiWf7lnAtLqD1GYmeW/oMVeX3W2GjGaJ+j1NV62oZMCH/sbLMl2Ijdzg97AUCrCXItHmO/8rM9j9ZLcNpmtromAoG7jSPP7eMkSV+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rrG/Jc7W; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 451CGMSv024787;
	Sat, 1 Jun 2024 07:16:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717244182;
	bh=H04MciwvQkqXdeK3r1sVJaJISF2/zqLrsqaTKdhCOds=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=rrG/Jc7WD4KLiIuNT38t87+VAvSfi7WByX3zZrmGwVHTWH8CIGUN3qCT+wCvRwbEO
	 nPt9JKs7nMs+d+jqBpMvf2nvaZ76NXoI3PiGSpWhUOV+iOtGvOYNdNwy4B+XqVD/eY
	 MC+HvHSct4uqZBwDxOrFZ5Lmb4P/ofJqAu+i2VfY=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 451CGLxT001084
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 1 Jun 2024 07:16:22 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 1
 Jun 2024 07:16:21 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 1 Jun 2024 07:16:21 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 451CFtkJ009323;
	Sat, 1 Jun 2024 07:16:17 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <afd@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <rogerq@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>,
        <danishanwar@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v4 5/7] arm64: dts: ti: k3-serdes: Add SERDES0/SERDES1 lane-muxing macros for J722S
Date: Sat, 1 Jun 2024 17:45:52 +0530
Message-ID: <20240601121554.2860403-6-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240601121554.2860403-1-s-vadapalli@ti.com>
References: <20240601121554.2860403-1-s-vadapalli@ti.com>
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
v3:
https://lore.kernel.org/r/20240524090514.152727-4-s-vadapalli@ti.com/
and
https://lore.kernel.org/r/20240524090514.152727-6-s-vadapalli@ti.com/
Changes since v3:
- Above changes have been squashed into this patch.

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


