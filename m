Return-Path: <linux-kernel+bounces-253496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4915893221B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 10:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 516031C21C3F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 08:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BBD37143;
	Tue, 16 Jul 2024 08:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SG71J53R"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AB21B947;
	Tue, 16 Jul 2024 08:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721119395; cv=none; b=H41HqGoE8eBFY0uPHunKHH6LHx2TqqBMhZuJsIW033weGgyLx3UMT796KuHEz7nlZU/O/FKwMjKCcRUM9v4xvbH1qIP7d4h2VrV44UnT4g65JEoAITNz4Oa6nMUUKmVWQK1xV7jOPx63E+jQgIZAyCZOO1fQ8m4h8yBAgrt/DQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721119395; c=relaxed/simple;
	bh=Uw/F0DbEZSqJmWYuXKrW6Ozq6TNy0tQgMaER1kemwMQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cUy5Gyui0guIeiuuqCvrtEKWv0yo5m96IAJwJnIyDLON+Z0hvyT+RQqe1P1QjDkTOu4a5bO0jETVZqXML2nMHz88jb5NZADHDOm40k90D+ryIpkPRnPqftLHNISwkWVvW+N/7qD6U1eA/Oa1ZjCPNUjLN+AycfZqlC+wro3KzlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SG71J53R; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46G8gpVk088643;
	Tue, 16 Jul 2024 03:42:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1721119371;
	bh=X/II/tDwcqDm+ACxmq420acPWMQXXwNmqt5JFPW4HUk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=SG71J53R0RI+AfjkDQkAnpQvstd2FKMNEeLiVVXxDJjIf2OORyXGXTp7QKp8Nb9S3
	 rua/ClTWE/adrCVs51WKl+zogP5gwt9Ws52Jk2jxeFb6wskBQDXJ+R790UAtV2pmRd
	 dcgP6Xwk3B5r0eLkbJFnx+4nOc6v1NwNkO+zlmPs=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46G8gpYO105323
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 16 Jul 2024 03:42:51 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 16
 Jul 2024 03:42:50 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 16 Jul 2024 03:42:50 -0500
Received: from localhost (uda0496377.dhcp.ti.com [172.24.227.31])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46G8go4P118682;
	Tue, 16 Jul 2024 03:42:50 -0500
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
Subject: [PATCH v3 1/4] dt-bindings: display: ti,am65x-dss: Re-indent the example
Date: Tue, 16 Jul 2024 14:12:45 +0530
Message-ID: <20240716084248.1393666-2-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240716084248.1393666-1-a-bhatia1@ti.com>
References: <20240716084248.1393666-1-a-bhatia1@ti.com>
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


