Return-Path: <linux-kernel+bounces-343722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBF9989EB8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7055F1F2174A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD8F18990E;
	Mon, 30 Sep 2024 09:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XirWzPnN"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EE417CA03;
	Mon, 30 Sep 2024 09:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727689922; cv=none; b=BJ12j2pNX016uYEvBw2OilmqvyTx7pCY4wcLqtFzl7nwC0ZdidYl6yCjifBFYxZpfzP7DwnJhbHaPBe03B4zGlB2Udc5501DUubz6Zc48qmeDS9J95lxni0x67gkMQu5FKjVMZFpLWSG4zSKhs9jjP08wdVTFJTHST1CKo13zZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727689922; c=relaxed/simple;
	bh=oRlBfXRJJuP0y/ycSpQbeUMSQ4iHyDfEbLPz4DY3yNQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GlgGhRQZJVril6oqiaHcXXp5gc9C2mzy+Ea2RDk1e2s4B8ttDO/rXwlNAe6uTB0ZIPj/5tD6ENwz5CAGAj+MI1a0lzjQ6FjpNoT934fGxOpR9zwQc7wr6i6/3KbPSMhsoVSyjUE7GAwRRzwoCSEOSJ6jXG52TIQyLfQDH5mF4co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XirWzPnN; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48U9ppeU056451;
	Mon, 30 Sep 2024 04:51:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1727689911;
	bh=FpjCUlqj/npY/3KoH9Yoyz6bWbmAqbUo8uX4w3FlqoY=;
	h=From:To:CC:Subject:Date;
	b=XirWzPnNML7Q5EMq5/2rLvm2QQtzFylDneewUWSr0i716snU7PsVizW0KS2MCF8Po
	 T72pEDTXJg6PWPGdWY12qWtm5YwDFr1B+EVIBWEz23KsMqmTvf7l4fmKbrfLSeyCfI
	 sTIEWvZHX/MaspsZU6V12gxWXwsWbt7IRBFP3lEo=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48U9ppoT018783;
	Mon, 30 Sep 2024 04:51:51 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 30
 Sep 2024 04:51:51 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 30 Sep 2024 04:51:50 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48U9pkBw042299;
	Mon, 30 Sep 2024 04:51:46 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <vkoul@kernel.org>, <kishon@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
CC: <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <conor.dooley@microchip.com>, <nm@ti.com>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v2] dt-bindings: phy: cadence-sierra: Allow PHY types QSGMII and SGMII
Date: Mon, 30 Sep 2024 15:21:45 +0530
Message-ID: <20240930095145.3004053-1-s-vadapalli@ti.com>
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

The Sierra SERDES can be configured for QSGMII and SGMII protocols. Hence,
update the bindings to treat "PHY_TYPE_QSGMII" and "PHY_TYPE_SGMII" as
valid values for the "cdns,phy-type" property.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---

Hello,

This patch is based on linux-next tagged next-20240930.

v1:
https://lore.kernel.org/r/20240830105316.1824319-1-s-vadapalli@ti.com/
Changes since v1:
- Rebased patch on next-20240930.
- Collected Acked-by tag from Conor Dooley <conor.dooley@microchip.com>

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


