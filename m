Return-Path: <linux-kernel+bounces-308626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61538965FA5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D800B282898
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51E918FDCD;
	Fri, 30 Aug 2024 10:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NRWVImWb"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296A117B4F9;
	Fri, 30 Aug 2024 10:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725015212; cv=none; b=SiOhhujogsS9WXzM0dXILuxdaw9VOXK3xp2InHCcA7B74fchVamoYfQEquy4WXKA0zEMvxDHDeGBaALo9Masai7xWPXznibxsUPxQsvYvi5rvP4IedIinrkTdaNGjqjEglOOp/IZ362EG/awfop2ExdHqIBjaIXd+pVf56ToC4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725015212; c=relaxed/simple;
	bh=O9KGuHA2ZA1Eb8lRka+CR0EIeZxGOlxwyRPT8n1DNts=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AZ+uaKMWjTJZ2ASNLOdcu+QiJz3A+FnNtlOyPb/c9gji5gomFnsiYfzHihUITG1ElbZSWx9S0ICArTfTsR/pFkBNCHqBXGl8xkO6/N1cTYwk7ACQ9B4bSPY8R87G4+OIlrPhu8TsMGfETCW7zJNZBggNu3rCxFwb5X/WfTeBDw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NRWVImWb; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47UArMIc101755;
	Fri, 30 Aug 2024 05:53:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725015202;
	bh=KUOgx+nr0Fdd/U00rm4qzZJfvik05ytOlpn9p/ouBH8=;
	h=From:To:CC:Subject:Date;
	b=NRWVImWbs7jZ12VLz4r/DKXBGPc8M0cu20KRKBPDV+v3Z156O5hiYonuviIyP77TQ
	 6K853QRxazjjAm68VhX+HX8PEgNWvKaw1SOdnsFlHq76kyANFBBEIujPajRucveRbb
	 X8Ae5HLweEExBElldZspQhgYsmOmm9JfGgYxnus4=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47UArMRk012191
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 30 Aug 2024 05:53:22 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 30
 Aug 2024 05:53:22 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 30 Aug 2024 05:53:21 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47UArHDB009586;
	Fri, 30 Aug 2024 05:53:18 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <vkoul@kernel.org>, <kishon@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
CC: <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <nm@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH] dt-bindings: phy: cadence-sierra: Allow PHY types QSGMII and SGMII
Date: Fri, 30 Aug 2024 16:23:16 +0530
Message-ID: <20240830105316.1824319-1-s-vadapalli@ti.com>
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

The Sierra SERDES can be configured for QSGMII and SGMII protocols. Hence,
update the bindings to treat "PHY_TYPE_QSGMII" and "PHY_TYPE_SGMII" as
valid values for the "cdns,phy-type" property.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on linux-next tagged next-20240830.

Regards,
Siddharth.

 Documentation/devicetree/bindings/phy/phy-cadence-sierra.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-sierra.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-sierra.yaml
index 37f028f7a095..137ac5703853 100644
--- a/Documentation/devicetree/bindings/phy/phy-cadence-sierra.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-cadence-sierra.yaml
@@ -96,7 +96,7 @@ patternProperties:
           Specifies the type of PHY for which the group of PHY lanes is used.
           Refer include/dt-bindings/phy/phy.h. Constants from the header should be used.
         $ref: /schemas/types.yaml#/definitions/uint32
-        enum: [2, 4]
+        enum: [2, 4, 8, 9]
 
       cdns,num-lanes:
         description:
-- 
2.40.1


