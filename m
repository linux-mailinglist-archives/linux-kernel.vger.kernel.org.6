Return-Path: <linux-kernel+bounces-429943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 298A19E2A31
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 19:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69686B837A7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475ED1FC100;
	Tue,  3 Dec 2024 17:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EPLRIGlq"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013C41F76AC;
	Tue,  3 Dec 2024 17:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733247095; cv=none; b=RKsTRzRFm2mASAgiGcbGL71iG7IQc9xJ9Fo4/PjX+ptETLGRtcdBy2lNZ9Eg19VYlpR1q9PymU6oG1wsNaNi4SRstzWrPzaCbbb9T0k/5Psx9cyLQ2ruDtbGXs/zznGtxovfiZA1J4MV3YM1rb2ZPdE1HmalaNI9hSHf/e3TGJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733247095; c=relaxed/simple;
	bh=imjulwoRiA8aa2hU0EXgqu0DGBARmGnHLzsElo9S1Ag=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GbyLwPzLJ4yVxrmtY0m8yvoNTzzpXTL6VAaSBOea/5evReCp/yW1aH2gA25PS5MO8OQnPRZnbEOAbcMOxBJdDFb2svWySzH2oBgbf0MosgdLVrnmWyz3GSaRKhTMzeXnNd/v0LGAyco86Qy788YmJWIjRQKPsBovYwFGM0/lYYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=EPLRIGlq; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4B3HVFjl1647614
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 3 Dec 2024 11:31:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1733247076;
	bh=pnb86O08snZJxBvF7Q9B/HnxlE8/fHHTr3MMXko/bgQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=EPLRIGlq7SSV3emVzW+YVQQzfscOGbeP49OCo563WNJFi2oUf6yrH0GtnZIOx29E5
	 LT0kxsSgBjAB9dmNTEqUESAlZgBA9QXrIaFK88J64Gy03vzJ46qtIRSwDmg2S71Yaf
	 02YK47vB7Edj090iQ4ouJC/imSiUAWX1qlV+T1lA=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B3HVFq8069938;
	Tue, 3 Dec 2024 11:31:15 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Dec 2024 11:31:15 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Dec 2024 11:31:15 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B3HVEpQ094200;
	Tue, 3 Dec 2024 11:31:15 -0600
From: Andrew Davis <afd@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Rob
 Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 3/4] dt-bindings: soc: ti: ti,j721e-system-controller: Add PCIe ctrl property
Date: Tue, 3 Dec 2024 11:31:12 -0600
Message-ID: <20241203173113.90009-3-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241203173113.90009-1-afd@ti.com>
References: <20241203173113.90009-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Add a pattern property for pcie-ctrl which can be part of this controller.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 .../bindings/soc/ti/ti,j721e-system-controller.yaml         | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/ti/ti,j721e-system-controller.yaml b/Documentation/devicetree/bindings/soc/ti/ti,j721e-system-controller.yaml
index 9ba9cb100ab30..ead0679b30e3f 100644
--- a/Documentation/devicetree/bindings/soc/ti/ti,j721e-system-controller.yaml
+++ b/Documentation/devicetree/bindings/soc/ti/ti,j721e-system-controller.yaml
@@ -74,6 +74,12 @@ patternProperties:
     description:
       This is the ICSSG control region.
 
+  "^pcie-ctrl@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/mfd/syscon.yaml#
+    description:
+      This is the PCIe control region.
+
 required:
   - compatible
   - reg
-- 
2.39.2


