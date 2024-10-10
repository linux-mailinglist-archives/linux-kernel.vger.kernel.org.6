Return-Path: <linux-kernel+bounces-359360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 276FC998A9F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 16:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB539282458
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318F81F12F3;
	Thu, 10 Oct 2024 14:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WLgcEIbK"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17FF1CB324
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 14:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728571754; cv=none; b=Fy3art7YQ7BZRRkciR+3ZbxhX+RJuzhQO2+31w4oFuTNlHpeZuK9gjcljSRJaGNruQgV8zebzbR/Pil26c1T6Ybus2cc12Smf+mSguySwBW+Ku2PVY9Fn4rDGrm0qzy7Yh94Yr1q/ZVaoY9m2IK7JkecmU7cWYD1IZ7DEa4QGEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728571754; c=relaxed/simple;
	bh=OQyrZsUKQZ2ayKGypwUUCQcAuV3x6EurjA0rjeyZoK8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IhL2e9Naalp0ZvRE2rsH0eL9VRRc8s/pQkJRf+TrkWUelcGvBp17Ip9lqZFh04eVV8TvKGoyvTYXb4WAl5TjBI0+GWts/oHR9W1ghBYWiz0BeIovpYs0Qq7fq8oERPAERjaLBBkRfcDPWa/e73UwKwoUiNkCJfn70tPjlHSNf/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WLgcEIbK; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49AEmpuP021072;
	Thu, 10 Oct 2024 09:48:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1728571731;
	bh=WGpzSHyv4hN94fLKBm9CwNkrtkCZrpk5DG6ytNR+FeA=;
	h=From:To:CC:Subject:Date;
	b=WLgcEIbKXfLnZ91cTr+LOArvhXCMZ86zG+YbXXv+i2efsHub0aMPmcuYov6ABwANB
	 MkC4rpgRFPo//yKSe91dKc+CZEsiFjQlRj5+nKgVvtu9zX9nS/KVuJoKiX14c5xDNA
	 IonJzatIK9xEAkVJmC7RZenBD9GRwyyQfo9udjJQ=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49AEmpCK026303
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 10 Oct 2024 09:48:51 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 10
 Oct 2024 09:48:50 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 10 Oct 2024 09:48:50 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49AEmk7F011103;
	Thu, 10 Oct 2024 09:48:47 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <vkoul@kernel.org>, <kishon@kernel.org>, <thomas.richard@bootlin.com>,
        <krzysztof.kozlowski@linaro.org>, <rogerq@kernel.org>,
        <florian.fainelli@broadcom.com>, <c-vankar@ti.com>, <afd@ti.com>
CC: <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH] phy: ti: gmii-sel: Enable USXGMII mode for J7200
Date: Thu, 10 Oct 2024 20:18:45 +0530
Message-ID: <20241010144845.2555983-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

TI's J7200 SoC supports USXGMII mode with the CPSW5G instance's MAC Port1.
Add USXGMII mode to the extra_modes member of J7200's SoC data.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on linux-next tagged next-20241010.

Regards,
Siddharth.

 drivers/phy/ti/phy-gmii-sel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/ti/phy-gmii-sel.c b/drivers/phy/ti/phy-gmii-sel.c
index 103b266fec77..e0ca59ae3153 100644
--- a/drivers/phy/ti/phy-gmii-sel.c
+++ b/drivers/phy/ti/phy-gmii-sel.c
@@ -230,7 +230,8 @@ static const
 struct phy_gmii_sel_soc_data phy_gmii_sel_cpsw5g_soc_j7200 = {
 	.use_of_data = true,
 	.regfields = phy_gmii_sel_fields_am654,
-	.extra_modes = BIT(PHY_INTERFACE_MODE_QSGMII) | BIT(PHY_INTERFACE_MODE_SGMII),
+	.extra_modes = BIT(PHY_INTERFACE_MODE_QSGMII) | BIT(PHY_INTERFACE_MODE_SGMII) |
+		       BIT(PHY_INTERFACE_MODE_USXGMII),
 	.num_ports = 4,
 	.num_qsgmii_main_ports = 1,
 };
-- 
2.40.1


