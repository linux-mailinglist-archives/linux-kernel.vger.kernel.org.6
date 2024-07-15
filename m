Return-Path: <linux-kernel+bounces-253034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 749DF931B94
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 22:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9D1D1F22781
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 20:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EEF13C83D;
	Mon, 15 Jul 2024 20:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZMB/0K5k"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECCA13C690;
	Mon, 15 Jul 2024 20:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721074233; cv=none; b=C3scWKK9EplmgBi27hK2ivtM7Lmz8QgAJk6kry/q6mtYs7u9KS2yT6e0LWWJb+6m+vV8TA3b2w2aiqq7wH07pQQjvEKElbf1dH2bHF6eLfrMyj1br7BguWlqNjE3hPWqGCsp9RFABmFK2Tj9WEAhLpa5MqGSgCVA2Gm8e7alS8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721074233; c=relaxed/simple;
	bh=Uw/F0DbEZSqJmWYuXKrW6Ozq6TNy0tQgMaER1kemwMQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CcIwEt9Lw+GOyH4+2sXV1ncSzZ3oqMBRBbz8fxjRBsxJ6eXKlx88irxR3KfgLbUYIDIsyL0SHrh3daBV1EayNhqaCNR+ChWeXNVUW3AM5rrHhisFFHj8lb3huJS3XDjFQPinrH3I7ghBEEs/9/ysn3OpAQYcyLShuwCUh2SlU0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZMB/0K5k; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46FK9uBq114567;
	Mon, 15 Jul 2024 15:09:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1721074196;
	bh=X/II/tDwcqDm+ACxmq420acPWMQXXwNmqt5JFPW4HUk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ZMB/0K5khzZZ/z6QCls7EaSmwbKqMb7lMwmQGwQ3fqiqqWNC8Hjqd/H7vSG6TP6ga
	 bQFAg+QWTXiv6VwdsUnlRcdsfwRTSdRtGrihx85kAwnLKyND3vyQVgLpDd+ogU8Jr/
	 Z0+c7UcbkJTYPqCcSe76bFKVObpmXf0iseK6hq+o=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46FK9uFP119940
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 15 Jul 2024 15:09:56 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 15
 Jul 2024 15:09:56 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 15 Jul 2024 15:09:56 -0500
Received: from localhost (uda0496377.dhcp.ti.com [172.24.227.31])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46FK9tFx047182;
	Mon, 15 Jul 2024 15:09:55 -0500
From: Aradhya Bhatia <a-bhatia1@ti.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Jyri Sarha
	<jyri.sarha@iki.fi>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie
	<airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: DRI Development List <dri-devel@lists.freedesktop.org>,
        Devicetree List
	<devicetree@vger.kernel.org>,
        Linux Kernel List
	<linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>, Vignesh
 Raghavendra <vigneshr@ti.com>,
        Praneeth Bajjuri <praneeth@ti.com>, Udit Kumar
	<u-kumar1@ti.com>,
        Francesco Dolcini <francesco@dolcini.it>,
        Alexander
 Sverdlin <alexander.sverdlin@siemens.com>,
        Randolph Sapp <rs@ti.com>, Devarsh
 Thakkar <devarsht@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>, Jai Luthra
	<j-luthra@ti.com>,
        Aradhya Bhatia <a-bhatia1@ti.com>
Subject: [PATCH v2 1/4] dt-bindings: display: ti,am65x-dss: Re-indent the example
Date: Tue, 16 Jul 2024 01:39:50 +0530
Message-ID: <20240715200953.1213284-2-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240715200953.1213284-1-a-bhatia1@ti.com>
References: <20240715200953.1213284-1-a-bhatia1@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Reduce tab size from 8 spaces to 4 spaces to make the bindings
consistent, and easy to expand.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
---
 .../bindings/display/ti/ti,am65x-dss.yaml     | 54 +++++++++----------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
index 55e3e490d0e6..399d68986326 100644
--- a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
+++ b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
@@ -142,32 +142,32 @@ examples:
     #include <dt-bindings/soc/ti,sci_pm_domain.h>
 
     dss: dss@4a00000 {
-            compatible = "ti,am65x-dss";
-            reg =   <0x04a00000 0x1000>, /* common */
-                    <0x04a02000 0x1000>, /* vidl1 */
-                    <0x04a06000 0x1000>, /* vid */
-                    <0x04a07000 0x1000>, /* ovr1 */
-                    <0x04a08000 0x1000>, /* ovr2 */
-                    <0x04a0a000 0x1000>, /* vp1 */
-                    <0x04a0b000 0x1000>, /* vp2 */
-                    <0x04a01000 0x1000>; /* common1 */
-            reg-names = "common", "vidl1", "vid",
-                    "ovr1", "ovr2", "vp1", "vp2", "common1";
-            ti,am65x-oldi-io-ctrl = <&dss_oldi_io_ctrl>;
-            power-domains = <&k3_pds 67 TI_SCI_PD_EXCLUSIVE>;
-            clocks =        <&k3_clks 67 1>,
-                            <&k3_clks 216 1>,
-                            <&k3_clks 67 2>;
-            clock-names = "fck", "vp1", "vp2";
-            interrupts = <GIC_SPI 166 IRQ_TYPE_EDGE_RISING>;
-            ports {
-                    #address-cells = <1>;
-                    #size-cells = <0>;
-                    port@0 {
-                            reg = <0>;
-                            oldi_out0: endpoint {
-                                    remote-endpoint = <&lcd_in0>;
-                            };
-                    };
+        compatible = "ti,am65x-dss";
+        reg = <0x04a00000 0x1000>, /* common */
+              <0x04a02000 0x1000>, /* vidl1 */
+              <0x04a06000 0x1000>, /* vid */
+              <0x04a07000 0x1000>, /* ovr1 */
+              <0x04a08000 0x1000>, /* ovr2 */
+              <0x04a0a000 0x1000>, /* vp1 */
+              <0x04a0b000 0x1000>, /* vp2 */
+              <0x04a01000 0x1000>; /* common1 */
+        reg-names = "common", "vidl1", "vid",
+                "ovr1", "ovr2", "vp1", "vp2", "common1";
+        ti,am65x-oldi-io-ctrl = <&dss_oldi_io_ctrl>;
+        power-domains = <&k3_pds 67 TI_SCI_PD_EXCLUSIVE>;
+        clocks =        <&k3_clks 67 1>,
+                        <&k3_clks 216 1>,
+                        <&k3_clks 67 2>;
+        clock-names = "fck", "vp1", "vp2";
+        interrupts = <GIC_SPI 166 IRQ_TYPE_EDGE_RISING>;
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            port@0 {
+                reg = <0>;
+                oldi_out0: endpoint {
+                    remote-endpoint = <&lcd_in0>;
+                };
             };
+        };
     };
-- 
2.34.1


