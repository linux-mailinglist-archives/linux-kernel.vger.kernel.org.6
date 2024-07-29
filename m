Return-Path: <linux-kernel+bounces-265173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8349793ED90
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 08:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41443281026
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 06:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C5E84DE0;
	Mon, 29 Jul 2024 06:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZVnpsQXM"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F6164D;
	Mon, 29 Jul 2024 06:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722235225; cv=none; b=eHxTqcYR0WDRluz0EyL/QrfQKgWob6sNsHYWDIxffRmUXwJfUpnUR+8fWMC15e9igWSSZfKTKvTmO/u//CInTCH9T6bburZno4J424pQKiONoaKIvuLKjvzdSHlxXgpzQmSc8DTsB2EY0VodBE5mDAHuOMZUXY39Nlxl3MO8IDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722235225; c=relaxed/simple;
	bh=a99jbsDVfgeTc2MdUT3Lg0p6OXzFeZkjRJ8ktTYnmY4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=muzQF5LDW4+DpV1zns/4egWUfXNEmLR5PUZbBNoKChHE6Mh6pe6Kevqi+ktwBJ+pu5Y2PT7jT249pTYSeqB7A0+z6lXt19UYFf0sd57zuOD2Z+d94zXz64A2kxvyiXYL8hnJieNcfDDPVxB/AE2LteAtvqn9FGK8ZJVbJNk0dpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZVnpsQXM; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46T6eHJG114240;
	Mon, 29 Jul 2024 01:40:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722235217;
	bh=OP5Y1xSavSMvddNO5CRaAcRmVaS3+7inY/Rfp9dfFZc=;
	h=From:To:CC:Subject:Date;
	b=ZVnpsQXMXtm20ljpPMkJS9JUvBLtHYHDSujcsjH1my3npI7od6WNr5oa997ZOyQ1M
	 uROKWcMk/3cvDg3mjMrEZDnpiITelfRqxPtFzOWzZeUAurzUQVzZbayObem+Pa9z4C
	 +YlagS74bIRLzy7lGzL4wY0TpIR6G8XJZtj4CWVw=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46T6eHDs102437
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Jul 2024 01:40:17 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Jul 2024 01:40:17 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Jul 2024 01:40:17 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46T6eD5A010045;
	Mon, 29 Jul 2024 01:40:14 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <lee@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v2] dt-bindings: mfd: syscon: Add ti,j784s4-acspcie-proxy-ctrl compatible
Date: Mon, 29 Jul 2024 12:10:12 +0530
Message-ID: <20240729064012.1915674-1-s-vadapalli@ti.com>
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

The ACSPCIE_PROXY_CTRL registers within the CTRL_MMR space of TI's J784S4
SoC are used to drive the reference clock to the PCIe Endpoint device via
the PAD IO Buffers. Add the compatible for allowing the PCIe driver to
obtain the regmap for the ACSPCIE_CTRL register within the System
Controller device-tree node in order to enable the PAD IO Buffers.

The Technical Reference Manual for J784S4 SoC with details of the
ASCPCIE_CTRL registers is available at:
https://www.ti.com/lit/zip/spruj52

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Hello,

This patch is based on linux-next tagged next-20240729.
v1: https://lore.kernel.org/r/20240715120936.1150314-2-s-vadapalli@ti.com/
Changes since v1:
- Rebased patch on next-20240729.
- Separated this patch from the series.
- Collected Acked-by tag from:
  Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
  https://lore.kernel.org/r/04d94188-5e30-4cab-b534-e97c0b2a61f3@kernel.org/

NOTE: Though it was mentioned on 25th July 2024 that this patch was applied:
https://lore.kernel.org/r/172190301400.925833.12525656543896105526.b4-ty@kernel.org/
since I did not find the commit in the MFD tree and the Linux-Next tree,
I am reposting this patch.

Regards,
Siddharth.

 Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 9dc594ea3654..13cbc6fe996e 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -113,6 +113,7 @@ select:
           - ti,am625-dss-oldi-io-ctrl
           - ti,am62p-cpsw-mac-efuse
           - ti,am654-dss-oldi-io-ctrl
+          - ti,j784s4-acspcie-proxy-ctrl
           - ti,j784s4-pcie-ctrl
           - ti,keystone-pllctrl
   required:
-- 
2.40.1


