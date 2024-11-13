Return-Path: <linux-kernel+bounces-407441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B7E9C6D73
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 12:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C087B285481
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 11:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751E31FF604;
	Wed, 13 Nov 2024 11:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jS5UytQ2"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FFD1FF03A;
	Wed, 13 Nov 2024 11:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731496212; cv=none; b=a8/hClJxHWw8F/H68oXLl21Lv8o3S3MI9vUNj72lnhEs3ylKH+N6pHEJ3JZ1pr5GxzIrYqCYoUPbhYwn3Cbp+6nAVMx02Y6P+x8ZHyWMNmbbtBMcNwN9RuaYrUX1x6Lq3jiiaCSo9wcmB+BCHx6kq1O+ZSpXylQn2fcnePYJo60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731496212; c=relaxed/simple;
	bh=UPOgGrkHsdv9Jez1sNwUNEQxHY04KsMHI/we/kWelf4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rJX1cu+ZuPn8bxZ8pT/k/x5pCB/X74GiC8IGQgp5z7PtFD4h/0pP2FmES8qtZbUrWWi7JIfa0kXtcSqDKgtpRQRL2RR0pY2bUACuTS38oYIPXjxkrUxHf++7y7oyfvtHp85xxXs/eUoFV0asIotMyNbZTnCQjsNY6uUgeG3TjIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jS5UytQ2; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4ADBA1x62828090
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 05:10:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1731496201;
	bh=d0Qg6SopdbWfAUe/2/gabBwX3iGckX9jWfCECo4NOGQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=jS5UytQ2SJ4Qmx4cY5gzqqznH9hp1GN9h5T9B6EDamIHmNMe3Z9QCskN7jP1oZsFv
	 aMMiqROJTXYrRymkTAK0m6whJig0nU4yFm+oyboXxMCAnEUuvuv/KZ0e6DWtt91gSe
	 LJ5TGo8XdDHwWiMopr4IhTv4z1N+JbyO8lDz5yoI=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4ADBA1sC070529
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 13 Nov 2024 05:10:01 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 13
 Nov 2024 05:10:01 -0600
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 13 Nov 2024 05:10:01 -0600
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4ADBA1e8124239;
	Wed, 13 Nov 2024 05:10:01 -0600
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 4ADBA0gG021259;
	Wed, 13 Nov 2024 05:10:00 -0600
From: MD Danish Anwar <danishanwar@ti.com>
To: <conor+dt@kernel.org>, <krzk+dt@kernel.org>, <robh@kernel.org>,
        <ssantosh@kernel.org>, <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <s-anna@ti.com>, <kristo@kernel.org>,
        <srk@ti.com>, Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH v3 1/2] dt-bindings: soc: ti: pruss: Add clocks for ICSSG
Date: Wed, 13 Nov 2024 16:39:54 +0530
Message-ID: <20241113110955.3876045-2-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241113110955.3876045-1-danishanwar@ti.com>
References: <20241113110955.3876045-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The ICSSG module has 7 clocks for each instance.

These clocks are ICSSG0_CORE_CLK, ICSSG0_IEP_CLK, ICSSG0_ICLK,
ICSSG0_UART_CLK, RGMII_MHZ_250_CLK, RGMII_MHZ_50_CLK and RGMII_MHZ_5_CLK
These clocks are described in AM64x TRM Section 6.4.3 Table 6-398.

Add these clocks to the dt binding of ICSSG.

Link: https://www.ti.com/lit/pdf/spruim2 (AM64x TRM)
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
index 3cb1471cc6b6..927b3200e29e 100644
--- a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
+++ b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
@@ -92,6 +92,16 @@ properties:
     description: |
       This property is as per sci-pm-domain.txt.
 
+  clocks:
+    items:
+      - description: ICSSG_CORE Clock
+      - description: ICSSG_IEP Clock
+      - description: ICSSG_RGMII_MHZ_250 Clock
+      - description: ICSSG_RGMII_MHZ_50 Clock
+      - description: ICSSG_RGMII_MHZ_5 Clock
+      - description: ICSSG_UART Clock
+      - description: ICSSG_ICLK Clock
+
 patternProperties:
 
   memories@[a-f0-9]+$:
-- 
2.34.1


