Return-Path: <linux-kernel+bounces-250684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C9392FB1C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 15:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E280C1F23263
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 13:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D850716F849;
	Fri, 12 Jul 2024 13:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="x559r/oe"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2F6179AA;
	Fri, 12 Jul 2024 13:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720790276; cv=none; b=gTeds2HHGHbpvMixttnJHoAo9PXoQ/AIzlQHcSrgL+90y5osLnClrnYAOxIuoulc8g4k05eCm6hmBNzS2tEU90sO0w99qp5D1id/ns65lRcIVmcXDujFp/UywtWdP3Q2DCbI/GA8W+Ykwg0dwUcQyFDdxbJqlhpyoT5crmIRQ6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720790276; c=relaxed/simple;
	bh=ewGQKC9ANPMxT9I5iskSAjtMvBqKRiomquLrkvI5Avc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jnxrDmNeI2KjcrpQBLrY8HfMHXJT/TtsMKKm+D7m/Acqk0iEu0YdC3xX2lhID/JTnfBjPw6A4QVEMUxurto+rN2CyQMEsIzZPUzXpKZ6Q9oBja8g7vGBX5Nn8ad82MoJl4hFkXjR+j3TAZW2Ojn8zJbZs9CT1aEUUFtWGGAC2yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=x559r/oe; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46C8X9Vj004034;
	Fri, 12 Jul 2024 15:17:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=GPNNdFG7/0l0CF7aIlpKbg
	MiRxXwV7FSN15i1F01Eo4=; b=x559r/oengxe8fA9Gxt2xYzs2RTPLZiAxGcCKP
	i4WTo+O7D9N+Hb+n3MB4DS/JwuQUxl7xz9sslfRzDJi+bXhxse8yv44ubCDiEZhF
	oG2BW/V0zektHpuMb+rET1zI7rL6+EgvoMWRWrGkSmVk45vSNhcmN2+Ft0NKYwsQ
	86GzbibjScvDRz/knnwvADVUop6aiu02VTuN4OmDi3WfQwnKTSfipdom3rGG9NEt
	tKzzFBkxzYfEk2jP9/MD1BuFQZ7lxZk+0JjZKDK6F4V/RXZ/LIEvroNdoXDKTaBN
	zE3fdvDlpeEKnVyrP0vkBa0kR0mOXGAQ0CJTwqpVGTH4M1sQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 406whg9qj0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 15:17:28 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9F5224002D;
	Fri, 12 Jul 2024 15:17:24 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EA15F20D3F5;
	Fri, 12 Jul 2024 15:16:26 +0200 (CEST)
Received: from localhost (10.252.16.177) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 12 Jul
 2024 15:16:26 +0200
From: Yannick Fertre <yannick.fertre@foss.st.com>
To: Yannick Fertre <yannick.fertre@foss.st.com>,
        Raphael Gallais-Pou
	<raphael.gallais-pou@foss.st.com>,
        Philippe Cornu
	<philippe.cornu@foss.st.com>,
        David Airlie <airlied@gmail.com>, Daniel Vetter
	<daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] dt-bindings: display: st,stm32-ltdc: Document stm32mp25 compatible
Date: Fri, 12 Jul 2024 15:16:24 +0200
Message-ID: <20240712131624.98898-1-yannick.fertre@foss.st.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_09,2024-07-11_01,2024-05-17_01

Add "st,stm32mp25-ltdc" compatible for SOC MP25. This new SOC introduces
new clocks (bus, ref & lvds). Bus clock was separated from lcd clock.
New sources are possible for lcd clock (lvds / ref).

Signed-off-by: Yannick Fertre <yannick.fertre@foss.st.com>
---
 .../bindings/display/st,stm32-ltdc.yaml       | 29 +++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml b/Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml
index d6ea4d62a2cf..680669c44b80 100644
--- a/Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml
+++ b/Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml
@@ -12,7 +12,9 @@ maintainers:
 
 properties:
   compatible:
-    const: st,stm32-ltdc
+    enum:
+      - st,stm32-ltdc
+      - st,stm32mp25-ltdc
 
   reg:
     maxItems: 1
@@ -24,7 +26,9 @@ properties:
     minItems: 1
 
   clocks:
-    maxItems: 1
+    minItems: 1
+    items:
+      description: Lcd Clock
 
   clock-names:
     items:
@@ -42,6 +46,27 @@ properties:
       - for internal dpi input of the MIPI DSI host controller.
       Note: These 2 endpoints cannot be activated simultaneously.
 
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - st,stm32mp25-ltdc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: bus clock
+            - description: reference clock
+            - description: lvds clock
+        clock-names:
+          items:
+            - const: bus
+            - const: ref
+            - const: lvds
+
 required:
   - compatible
   - reg
-- 
2.34.1


