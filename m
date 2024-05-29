Return-Path: <linux-kernel+bounces-194040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2448D35CD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 13:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 060311C23574
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 11:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6E4180A67;
	Wed, 29 May 2024 11:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pnDzIFap"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B5A1802DE;
	Wed, 29 May 2024 11:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716983518; cv=none; b=YhTJiPCuR6qvK+3hz/AJsQW7GT0WMsKrgGXGilNOZbvSFUbeB0eeXC03e5D+m4ClnDzYa2zDIMQkg7g784ao2lsjjnNqk3iw9D2oWV0h5cGIuZEfG9Qio7zOZ2MKSiKYX1pMhtUMYkKz/ixBbhG7l60KLg/IGYyM1ceDTp2X7iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716983518; c=relaxed/simple;
	bh=xIwg1qqzs0kY43s0qXigUIBlgh3WObwY03gKkYlKbio=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J08CYAEJYVI9Sczeo9kL6KUl7QFpRTfOfzP389iV77OttGYsYjyyy66/6LxbLIXj3I78OhtWDuEVWphvVg0JKb/iYuaYMvbVMGc+Gu80pN0axyhvF65VUV8LA0RH11TrPJ+VX12RiQvB0WNQBv1SyqbPDUTbgMznRle3vpeXpVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=pnDzIFap; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44TBprZT078778;
	Wed, 29 May 2024 06:51:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716983513;
	bh=Mg/AWyHtv9LVUEi96xCOIi4DqSntbZDmVYBl7E9icqE=;
	h=From:To:CC:Subject:Date;
	b=pnDzIFapdXxLVDbd3AOmgCAkW8S0qNwCT3WHUvDMyq8VHJY6TpoUIrEE8iD8PJYJC
	 vC0U1EjbLsWqIpPIGVvrs6VknC08FPdvEKPyEjguHxF/7xLd3MNq30BlzW5ZliBCB5
	 HfRL699hli4UN48UqoVsVjRMAezYDzOwQsoJ/zsg=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44TBprKw007683
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 29 May 2024 06:51:53 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 29
 May 2024 06:51:52 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 29 May 2024 06:51:52 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44TBpqLo009965;
	Wed, 29 May 2024 06:51:52 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 44TBppJf008838;
	Wed, 29 May 2024 06:51:52 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Suman Anna <s-anna@ti.com>, MD Danish Anwar <danishanwar@ti.com>,
        Conor
 Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob
 Herring <robh@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, <srk@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, <r-gunasekaran@ti.com>,
        Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2] dt-bindings: soc: ti: pruss: Add documentation for PA_STATS support
Date: Wed, 29 May 2024 17:21:49 +0530
Message-ID: <20240529115149.630273-1-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add documentation for pa-stats node which is syscon regmap for
PA_STATS registers. This will be used to dump statistics maintained by
ICSSG firmware.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
Changes from v1 to v2:
*) Added ^ in pa-stats as suggested by Krzysztof Kozlowski
   <krzk@kernel.org>
*) Moved additionalProperties: false to right after after type:object as
   suggested by Krzysztof Kozlowski <krzk@kernel.org>
*) Updated description of pa-stats to explain the purpose of PA_STATS
   module in context of ICSSG.

v1 https://lore.kernel.org/all/20240430121915.1561359-1-danishanwar@ti.com/

 .../devicetree/bindings/soc/ti/ti,pruss.yaml  | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
index c402cb2928e8..3cb1471cc6b6 100644
--- a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
+++ b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
@@ -278,6 +278,26 @@ patternProperties:
 
     additionalProperties: false
 
+  ^pa-stats@[a-f0-9]+$:
+    description: |
+      PA-STATS sub-module represented as a SysCon. PA_STATS is a set of
+      registers where different statistics related to ICSSG, are dumped by
+      ICSSG firmware. This syscon sub-module will help the device to
+      access/read/write those statistics.
+
+    type: object
+
+    additionalProperties: false
+
+    properties:
+      compatible:
+        items:
+          - const: ti,pruss-pa-st
+          - const: syscon
+
+      reg:
+        maxItems: 1
+
   interrupt-controller@[a-f0-9]+$:
     description: |
       PRUSS INTC Node. Each PRUSS has a single interrupt controller instance
-- 
2.34.1


