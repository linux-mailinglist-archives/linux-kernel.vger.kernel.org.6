Return-Path: <linux-kernel+bounces-314724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDC496B7A2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 12:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F3591C246A5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B271CF5E3;
	Wed,  4 Sep 2024 10:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="ZYqANC6y"
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FC21CEE99
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 10:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725444033; cv=none; b=djTYpb8lmTVH36/ZVfaqJYCqZeYYGZ4qb2jn+tnMeOcZw8sNRzZAyOYJUbD55iYAZrXuJbgk5kGNmk160ZpMBxl+3yKNMOlvMbWzBw5F4YCLhGnELbXULsogXllAhLnTVsq3J8WV4dBG9Z69EOeXz85DOFD1nLq1i91RTDtF6l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725444033; c=relaxed/simple;
	bh=L7JPxl8R9FZ+yWGawfiXacqspkxD3trGrjXuYvfK+Z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K+KkfLVMqq5hEwfwG/2x+rtzUu6905hLhd9DLUL2AxsnVHTSO3gw1hRZoZ9miTt2PPlCq6BoftvViBcVqO9JAk605UQmEabBVZUpgwsUaKpglcHgPwwD9tYETsXIgCa2IxtqxiPnJ43ZjSe9P77S/CaCbMFBbsxSSTz6EQ1gl6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=ZYqANC6y; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202409041000237f8959c77759adf746
        for <linux-kernel@vger.kernel.org>;
        Wed, 04 Sep 2024 12:00:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=DgtS7ahOE4MmAw5xSeUX02j6OJr0If6h53x4evkGsRY=;
 b=ZYqANC6yv53JMNQc1BESjX33GDse/bTga2qA6nyBOhYUH17sQrE0BTlAckXT8emomitcMx
 jOcH6EeqSlZzHtpGieD8TVnC9h5cBdVn5XOQiEzZV4LU73kQc/Bsvg02VxQx3HHSEndaE3GC
 oNwpas0zDHc5gWoB30bEgWc772QAaIMu8iaUF38MHyGsqzjL2I0UDjQx9Pwjlt4x8S30CbQE
 1rUcWYkToCHNXqAUbLBemGeNcngesgijSM98UTwZJGMzdp19UO62bahlha3tXPDEfO+Usyx3
 zLDgcXWJQ8LGdWuCCj9/EGFEZNCMnJn5LgTzWrmLRC7IrvS0khKvou9g==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Nishanth Menon <nm@ti.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Bao Cheng Su <baocheng.su@siemens.com>,
	Hua Qian Li <huaqian.li@siemens.com>,
	Diogo Ivo <diogo.ivo@siemens.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v4 2/7] dt-bindings: PCI: ti,am65: Extend for use with PVU
Date: Wed,  4 Sep 2024 12:00:11 +0200
Message-ID: <28d31a14fe9cc1867f023ebaddd6074459d15e40.1725444016.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1725444016.git.jan.kiszka@siemens.com>
References: <cover.1725444016.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

The PVU on the AM65 SoC is capable of restricting DMA from PCIe devices
to specific regions of host memory. Add the optional property
"memory-regions" to point to such regions of memory when PVU is used.

Since the PVU deals with system physical addresses, utilizing the PVU
with PCIe devices also requires setting up the VMAP registers to map the
Requester ID of the PCIe device to the CBA Virtual ID, which in turn is
mapped to the system physical address. Hence, describe the VMAP
registers which are optionally unless the PVU shall used for PCIe.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>
CC: "Krzysztof Wilczyński" <kw@linux.com>
CC: Bjorn Helgaas <bhelgaas@google.com>
CC: linux-pci@vger.kernel.org
---
 .../bindings/pci/ti,am65-pci-host.yaml        | 52 ++++++++++++++-----
 1 file changed, 40 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
index 0a9d10532cc8..d8182bad92de 100644
--- a/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
@@ -19,16 +19,6 @@ properties:
       - ti,am654-pcie-rc
       - ti,keystone-pcie
 
-  reg:
-    maxItems: 4
-
-  reg-names:
-    items:
-      - const: app
-      - const: dbics
-      - const: config
-      - const: atu
-
   interrupts:
     maxItems: 1
 
@@ -84,12 +74,48 @@ if:
       enum:
         - ti,am654-pcie-rc
 then:
+  properties:
+    reg:
+      minItems: 4
+      maxItems: 6
+
+    reg-names:
+      minItems: 4
+      items:
+        - const: app
+        - const: dbics
+        - const: config
+        - const: atu
+        - const: vmap_lp
+        - const: vmap_hp
+
+    memory-region:
+      minItems: 1
+      description: |
+        phandle to one or more restricted DMA pools to be used for all devices
+        behind this controller. The regions should be defined according to
+        reserved-memory/shared-dma-pool.yaml.
+      items:
+        maxItems: 1
+
   required:
     - dma-coherent
     - power-domains
     - msi-map
     - num-viewport
 
+else:
+  properties:
+    reg:
+      maxItems: 4
+
+    reg-names:
+      items:
+        - const: app
+        - const: dbics
+        - const: config
+        - const: atu
+
 unevaluatedProperties: false
 
 examples:
@@ -104,8 +130,10 @@ examples:
         reg =  <0x5500000 0x1000>,
                <0x5501000 0x1000>,
                <0x10000000 0x2000>,
-               <0x5506000 0x1000>;
-        reg-names = "app", "dbics", "config", "atu";
+               <0x5506000 0x1000>,
+               <0x2900000 0x1000>,
+               <0x2908000 0x1000>;
+        reg-names = "app", "dbics", "config", "atu", "vmap_lp", "vmap_hp";
         power-domains = <&k3_pds 120 TI_SCI_PD_EXCLUSIVE>;
         #address-cells = <3>;
         #size-cells = <2>;
-- 
2.43.0


