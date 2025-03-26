Return-Path: <linux-kernel+bounces-577198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC14FA719B6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CC6816F563
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409B71F5616;
	Wed, 26 Mar 2025 14:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="L8oXOrmj"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0871F4E41;
	Wed, 26 Mar 2025 14:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743001093; cv=none; b=H11W56zB2lgoXzWQxJG5BK0oE2Et0KEfctdraNGISpBG9/8gEsiP7NP6vNQmkJL2YZIxT7iymrnVuxaF9KnWlrg2sPc3rNIT6XZ7uOZuFmdvKNg/crCool+NiSTLib3Rzuff0ij/s4+sBGHiFFqkpEl2qxJPkU59JFozlPvbDek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743001093; c=relaxed/simple;
	bh=Wn7Qb1SQGz8Zryi8HLrCbCFNQ5T1GsiTic8f0hyyvHA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=McECqhi6EwL/NyrJ4NildqGbotIGDqaiMD5dAeo0TOJbSLhOdljX4chmNGZbrwPzHvgiOEaz+PUZeMs1uNc2Wzfdiz2FGdS6ruKRdUbn41qgpKBaeVS5sdgqzgClN4OyV/63hNukyODAVnYd+Jxy8/KCdQ/A6UOR8dZmZxvPz8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=L8oXOrmj; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52QEvdKk1586306
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Mar 2025 09:57:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1743001059;
	bh=5/m2Zukb6dg9jgdXSIpG/BHqhzwwA9cDdERdnkfjlOg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=L8oXOrmjhNyCfFMqLH0alein0rCFa0rg0onPFFfvOYAjVUumBrRLJA2ZBKzxEOCh+
	 dUMfC7InHoc9T2O7LcHtUHd1AlJFRzy8pDT+GxBbAPePA0fzq8fhw6UMdx215Xmbum
	 xpHzTvNsRqEZmIwuILLU4FiWdgC1Fr1qGxsrI138=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52QEvdRc020884
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 26 Mar 2025 09:57:39 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 26
 Mar 2025 09:57:38 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 26 Mar 2025 09:57:38 -0500
Received: from localhost (ti.dhcp.ti.com [172.24.227.95] (may be forged))
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52QEvbHK045780;
	Wed, 26 Mar 2025 09:57:38 -0500
From: Devarsh Thakkar <devarsht@ti.com>
To: <jyri.sarha@iki.fi>, <tomi.valkeinen@ideasonboard.com>,
        <airlied@gmail.com>, <maarten.lankhorst@linux.intel.com>,
        <mripard@kernel.org>, <tzimmermann@suse.de>,
        <dri-devel@lists.freedesktop.org>, <simona@ffwll.ch>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <praneeth@ti.com>, <vigneshr@ti.com>, <aradhya.bhatia@linux.dev>,
        <s-jain1@ti.com>, <r-donadkar@ti.com>, <j-choudhary@ti.com>,
        <h-shenoy@ti.com>, <devarsht@ti.com>
Subject: [PATCH v4 1/3] dt-bindings: display: ti,am65x-dss: Add support for AM62L DSS
Date: Wed, 26 Mar 2025 20:27:34 +0530
Message-ID: <20250326145736.3659670-2-devarsht@ti.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250326145736.3659670-1-devarsht@ti.com>
References: <20250326145736.3659670-1-devarsht@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The DSS controller on TI's AM62L SoC is an update from that on TI's
AM625/AM65x/AM62A7 SoC. The AM62L DSS [1] only supports a single display
pipeline using a single overlay manager, single video port and a single
video lite pipeline which does not support scaling.

The output of video port is routed to SoC boundary via DPI interface and
the DPI signals from the video port are also routed to DSI Tx controller
present within the SoC.

[1]: Section 11.7 (Display Subsystem and Peripherals)
Link : https://www.ti.com/lit/pdf/sprujb4

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Jayesh Choudhary <j-choudhary@ti.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
V4:
- No change

V3:
- Remove AM62A references as suggested
- Add Reviewed-by

V2: 
- Add Reviewed-by
- s/ti,am62l,dss/ti,am62l-dss

 .../bindings/display/ti/ti,am65x-dss.yaml     | 21 ++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
index 31c4ffcb599c..a5b13cb7bc73 100644
--- a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
+++ b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
@@ -12,18 +12,25 @@ maintainers:
   - Tomi Valkeinen <tomi.valkeinen@ti.com>
 
 description: |
-  The AM625 and AM65x TI Keystone Display SubSystem with two output
+  The AM625 and AM65x TI Keystone Display SubSystem has two output
   ports and two video planes. In AM65x DSS, the first video port
   supports 1 OLDI TX and in AM625 DSS, the first video port output is
   internally routed to 2 OLDI TXes. The second video port supports DPI
   format. The first plane is full video plane with all features and the
   second is a "lite plane" without scaling support.
+  The AM62L display subsystem has a single output port which supports DPI
+  format but it only supports single video "lite plane" which does not support
+  scaling. The output port is routed to SoC boundary via DPI interface and same
+  DPI signals are also routed internally to DSI Tx controller present within the
+  SoC. Due to clocking limitations only one of the interface i.e. either DSI or
+  DPI can be used at once.
 
 properties:
   compatible:
     enum:
       - ti,am625-dss
       - ti,am62a7-dss
+      - ti,am62l-dss
       - ti,am65x-dss
 
   reg:
@@ -91,6 +98,8 @@ properties:
           For AM625 DSS, the internal DPI output port node from video
           port 1.
           For AM62A7 DSS, the port is tied off inside the SoC.
+          For AM62L DSS, the DSS DPI output port node from video port 1
+          or DSI Tx controller node connected to video port 1.
 
       port@1:
         $ref: /schemas/graph.yaml#/properties/port
@@ -123,6 +132,16 @@ allOf:
         ports:
           properties:
             port@0: false
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ti,am62l-dss
+    then:
+      properties:
+        ports:
+          properties:
+            port@1: false
 
 required:
   - compatible
-- 
2.39.1


