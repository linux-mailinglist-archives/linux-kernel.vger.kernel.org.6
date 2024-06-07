Return-Path: <linux-kernel+bounces-205441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE188FFBEE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 08:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EC5E1F229B9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1AF14F12A;
	Fri,  7 Jun 2024 06:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Rx79y2CB"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDA31BC2F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 06:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717740692; cv=none; b=tAAp/i2Ln9glbUwk5Ua55rxRLDako4vAyOioqbyiMBEUsyHN76XW/xzVtpqJQZtmWkQGcb+iFbjIyxbFnizby9hKcBHKzAGFnrr+6hfQ2pVlNzoSbTgTMkcHx3YYaUkVFdhkhK7UOaKWvKKNWZIWOa0uMszuEirjUNjC7587RhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717740692; c=relaxed/simple;
	bh=1GET/gPqYBfB2KGkVJyl6Vq7slwREOU1B0dY2YzUfbI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FGaE3OqLdVPrJxfBXWFZ9j928BY7wF+YC18G7sidfV0SYcXXKXbd4UFNVTW5zDwrr/A45/rINbVsvDW3NVrJfEOIPWhi2yFH/YLp5+zBvScTN47KLfbjiOg1DVoM+wLCgfMpNKHsneKEGtWF1nufgJ4pc9Cucmd59AV/qJwtQ4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Rx79y2CB; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4576B2Mg072051;
	Fri, 7 Jun 2024 01:11:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717740662;
	bh=VMAL1sqTsUTjaa+9dpj5ylbrniRaOR8tVqnEOplb/3U=;
	h=From:To:CC:Subject:Date;
	b=Rx79y2CBGvKQVR22ea7TV6NMUfmTRSKlnr1NKO0lAmFD004LDiYnvoKnfzoP4Q7rl
	 Edh2KTPmt4JcQPK4TXdaJnYCWNEVWBrYuywSdGmKyfteGjRP+ZmfkQN/Bs5G24o3AP
	 BLwKmnK2esQXzrsVNBTXO22yQe7ReRW9csNZ3XOw=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4576B2jx074791
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 7 Jun 2024 01:11:02 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 7
 Jun 2024 01:11:02 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 7 Jun 2024 01:11:02 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4576AuAq003568;
	Fri, 7 Jun 2024 01:10:57 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <quic_bjorande@quicinc.com>,
        <geert+renesas@glider.be>, <krzysztof.kozlowski@linaro.org>,
        <konrad.dybcio@linaro.org>, <dmitry.baryshkov@linaro.org>,
        <neil.armstrong@linaro.org>, <arnd@arndb.de>,
        <m.szyprowski@samsung.com>, <nfraprado@collabora.com>,
        <u-kumar1@ti.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <praneeth@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH] arm64: defconfig: Enable USB2 PHY Driver
Date: Fri, 7 Jun 2024 11:40:56 +0530
Message-ID: <20240607061056.708946-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Ravi Gunasekaran <r-gunasekaran@ti.com>

The USB controller on TI SoCs such as AM65x needs the
USB2 PHY driver to communicate with VBUS/ID comparator.
So enable the OMAP USB2 PHY driver.

Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on linux-next tagged next-20240607.

Regards,
Siddharth.

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 6308e8818257..f92e35ea96c4 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1065,6 +1065,7 @@ CONFIG_USB_MTU3=y
 CONFIG_USB_MUSB_HDRC=y
 CONFIG_USB_MUSB_SUNXI=y
 CONFIG_USB_DWC3=y
+CONFIG_OMAP_USB2=m
 CONFIG_USB_DWC2=y
 CONFIG_USB_CHIPIDEA=y
 CONFIG_USB_CHIPIDEA_UDC=y
-- 
2.40.1


