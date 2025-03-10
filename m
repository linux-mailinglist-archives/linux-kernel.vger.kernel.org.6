Return-Path: <linux-kernel+bounces-554283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E5DA595C0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46F49188A717
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CE022A7EA;
	Mon, 10 Mar 2025 13:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="logU9zsE"
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com [185.132.180.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936CC228C86;
	Mon, 10 Mar 2025 13:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.180.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741612286; cv=none; b=lFOv1wy463dGn7/UNob+d50hT3Kv57k0LwsRtGH7kmUzCIgHCMTMKair1oFCF0RKA2bDdyqP6DpfGiJB5z07BCzUO1HXtJ/X2PMHO835krnNTNGBZeixSTP/oHV2RombceFWiPOVjqwIxi0lwN6QPiLkToZAK5Bp/MjbqW4aZJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741612286; c=relaxed/simple;
	bh=KKty/LtT9UqdHLXxGRnsqLqdJeH3S4Er+6EHu3y9Zbw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=EqWZ5AXSsWmWtTC2fvMKDhs3nMpfJo4LXWnbgKch3knXq6d4KKbcxW76Sw16p1F8c7ATPfTSvR6Y4pB2++8j1byo/CEmgP+/6IErbhCc0SU49sXnTLuTSUTB9m5hW+rOVOQ9fiErYEYZuHcOcCA52VetBYl5zXgfFtw3Hh+GtkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=logU9zsE; arc=none smtp.client-ip=185.132.180.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
	by mx07-00376f01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52A7GhJp014277;
	Mon, 10 Mar 2025 13:10:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=dk201812; bh=E
	rv9LdfWXRruYcMWdXdGFio9I0kq3vytpq7g57HI5ew=; b=logU9zsEwuGfNKGAO
	8TpvfjIs4I/LxQLsqq4qjLUQfJaLezJfTjVCUINxYwjMTLOgJ7fr4gJVUr2ycb/7
	7BHMAvN+G0TtzGOQnZqfK6E6K7R5vfTYn2iqdZPohBom+1vUCgND8rAaAyc2jBYd
	iCqCBqt13hdU8VslYyDXvPkLqCJbaMjhWie04AbJl4/1yho4Olbw3F81hGKarKcx
	osM8sjwA0iBOouL4wH3xs6EMukbmsMPlrt6PTCJPVvK6s6ucW6Hu3aW2cXOvxY7T
	m65VjI2tjW0fpaUXO4TsLGUk9/I0Henerat3u4gru1qA+6wS8LsYB75urjMF2p+B
	JGJvA==
Received: from hhmail05.hh.imgtec.org (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
	by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 458ev09ert-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 10 Mar 2025 13:10:45 +0000 (GMT)
Received: from Matts-MacBook-Pro.local (172.25.0.133) by
 HHMAIL05.hh.imgtec.org (10.100.10.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 10 Mar 2025 13:10:44 +0000
From: Matt Coster <matt.coster@imgtec.com>
Date: Mon, 10 Mar 2025 13:10:26 +0000
Subject: [PATCH v3 02/18] dt-bindings: gpu: img: Add BXS-4-64 devicetree
 bindings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250310-sets-bxs-4-64-patch-v1-v3-2-143b3dbef02f@imgtec.com>
References: <20250310-sets-bxs-4-64-patch-v1-v3-0-143b3dbef02f@imgtec.com>
In-Reply-To: <20250310-sets-bxs-4-64-patch-v1-v3-0-143b3dbef02f@imgtec.com>
To: Frank Binns <frank.binns@imgtec.com>,
        Matt Coster
	<matt.coster@imgtec.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter
	<simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Vignesh
 Raghavendra" <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Randolph Sapp <rs@ti.com>, Darren Etheridge <detheridge@ti.com>,
        "Alessio
 Belle" <alessio.belle@imgtec.com>,
        Alexandru Dadu <alexandru.dadu@imgtec.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2589;
 i=matt.coster@imgtec.com; h=from:subject:message-id;
 bh=KKty/LtT9UqdHLXxGRnsqLqdJeH3S4Er+6EHu3y9Zbw=;
 b=owGbwMvMwCFWuUfy8817WRsYT6slMaSfe3JBTCRtscJvYanlpTXTN3Q5Jl+fcTneI/XausymT
 /PmFM/Z11HKwiDGwSArpsiyY4XlCrU/aloSN34Vw8xhZQIZwsDFKQAT2TSJ4X9A2fmLH1Zw/XkT
 sX/m7kez04/k/fFreXD5TTnTxzw1vUVtjAwd5xYVmJUtanztlSBg3HIqrTRPUjy6Nnf71IkbvNb
 IL+cFAA==
X-Developer-Key: i=matt.coster@imgtec.com; a=openpgp;
 fpr=05A40CFCE7269D61D97100A1747F0A9036F90DFA
X-EXCLAIMER-MD-CONFIG: 15a78312-3e47-46eb-9010-2e54d84a9631
X-Authority-Analysis: v=2.4 cv=CeII5Krl c=1 sm=1 tr=0 ts=67cee4d5 cx=c_pps a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17 a=ETbM1kImDFEA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=r_1tXGB3AAAA:8 a=awpMPMrdKjxrl4mvOKAA:9
 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: lDjXnp8MGupV4CI2cD-7xZW9a6K6Ivtv
X-Proofpoint-ORIG-GUID: lDjXnp8MGupV4CI2cD-7xZW9a6K6Ivtv

Unlike AXE-1-16M, BXS-4-64 uses two power domains.

Like the existing AXE-1-16M integration, BXS-4-64 uses the single clock
integration in the TI k3-j721s2.

Signed-off-by: Matt Coster <matt.coster@imgtec.com>
---
Changes in v3:
- Include adding the second power domain so it's in context
- Remove unnecessary example
- Link to v2: https://lore.kernel.org/r/20241118-sets-bxs-4-64-patch-v1-v2-8-3fd45d9fb0cf@imgtec.com
Changes in v2:
- Use normal reg syntax for 64-bit values
- Link to v1: https://lore.kernel.org/r/20241105-sets-bxs-4-64-patch-v1-v1-8-4ed30e865892@imgtec.com
---
 .../devicetree/bindings/gpu/img,powervr-rogue.yaml | 34 +++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
index 5c16b2881447c9cda78e5bb46569e2f675d740c4..d9409d33154d429019776ddbf9d123b33f8c9740 100644
--- a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
+++ b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
@@ -18,6 +18,11 @@ properties:
               - ti,am62-gpu
           - const: img,img-axe-1-16m
           - const: img,img-rogue
+      - items:
+          - enum:
+              - ti,j721s2-gpu
+          - const: img,img-bxs-4-64
+          - const: img,img-rogue
 
       # This legacy combination of compatible strings was introduced early on
       # before the more specific GPU identifiers were used.
@@ -49,6 +54,7 @@ properties:
   power-domain-names:
     items:
       - const: a
+      - const: b
 
   dma-coherent: true
 
@@ -74,12 +80,38 @@ allOf:
         - power-domains
         - power-domain-names
 
+  # Cores with one power domain
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: img,img-axe-1-16m
+    then:
+      properties:
+        power-domain-names:
+          minItems: 1
+          maxItems: 1
+
+  # Cores with two power domains
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: img,img-bxs-4-64
+    then:
+      properties:
+        power-domain-names:
+          minItems: 2
+          maxItems: 2
+
   # Vendor integrations using a single clock domain
   - if:
       properties:
         compatible:
           contains:
-            const: ti,am62-gpu
+            anyOf:
+              - const: ti,am62-gpu
+              - const: ti,j721s2-gpu
     then:
       properties:
         clocks:

-- 
2.48.1


