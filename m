Return-Path: <linux-kernel+bounces-398465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 502709BF1A8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 16:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE633B255E1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FDA2036E2;
	Wed,  6 Nov 2024 15:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="srEb3s2i"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659AF202F8A;
	Wed,  6 Nov 2024 15:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730906959; cv=none; b=MvmNWqPzi8xaYbV8suhpUWJoA5nQx+UCIh2M/v8k3BAd0wIQR4UrSnCfwup4FO0y7ePinPRMSrpKCF0SdSHCKdzhrm8xA7jVZdGg1fo3Xgh7hrb/G2G3tR5ZuQpqn3qvYcuhmhvw5nAXj3G2QPdrsQdpqjGVb93ULS01menLoVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730906959; c=relaxed/simple;
	bh=zj989CJlmIdfkLgwwIuZOhnOoy+Tct/CfqFYGX2PBbs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hTs7XgEyIvFEtikUe8Ww3AKQQJxE+A8Ae6xjdyRiLNjTKm8yQZhlWNjEXIs2+AiV78MrQQIyj3BcaK7CHAUL3PlSI8MASjf/PBWzLRES8Qj2E8QDjZE0Nrf+6O5jFz9SKqbcy4MZauERzutKpzH8++03MO2zxzveZMVJ3w3SJbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=srEb3s2i; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6B4fQS016086;
	Wed, 6 Nov 2024 16:28:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	6v690GD1bQoY7uAmDqlHHIVXU8KeGeFlzk0ZkeLKKY8=; b=srEb3s2iU8rQBYHd
	x5/+cPGt89UP8l6ajUXOm1j2Jyfr9WR6Pa+09jc7KcO7wl6Lsvk5p8eHq/78isSK
	R4/+9Wla7GbRiR9qKTecn9EJxbkHsqKUhyiCF5PqTIE6E7o0BXUsL0lFxYSy7JX8
	a9RXi1lM3tr8GXoch8Gw3dmfwEBZj4KR48NdHWgfkCJjxf6BE9JkW/zpvj5/+wuJ
	ZppFlAhnpRTmi/RpgLcMjudMB7HfsCL0iE7DWty41G1hHjiZdwYzAoLiyklZBv0m
	IrDTTpXYEYdviFrJUauTjTGKyH0VlXmPngw1sxd0aXLqZDgJZKymhsFbsgeDnF8B
	One9Ig==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 42nywnfar5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 16:28:47 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 87C2E40045;
	Wed,  6 Nov 2024 16:27:33 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 821392656DF;
	Wed,  6 Nov 2024 16:25:35 +0100 (CET)
Received: from localhost (10.252.15.15) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 6 Nov
 2024 16:25:35 +0100
From: Olivier Moysan <olivier.moysan@foss.st.com>
To: Olivier Moysan <olivier.moysan@foss.st.com>,
        Arnaud Pouliquen
	<arnaud.pouliquen@foss.st.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime
 Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: <linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] ASoC: dt-bindings: add stm32mp25 support for i2s
Date: Wed, 6 Nov 2024 16:25:27 +0100
Message-ID: <20241106152528.939232-2-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241106152528.939232-1-olivier.moysan@foss.st.com>
References: <20241106152528.939232-1-olivier.moysan@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Add STM32MP25 support for STM32 I2S peripheral,
through "st,stm32mp25-i2s" compatible.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 .../bindings/sound/st,stm32-i2s.yaml          | 60 +++++++++++++++----
 1 file changed, 47 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml b/Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml
index 8978f6bd63e5..8f08f1f28a1b 100644
--- a/Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml
+++ b/Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml
@@ -13,13 +13,11 @@ description:
   The SPI/I2S block supports I2S/PCM protocols when configured on I2S mode.
   Only some SPI instances support I2S.
 
-allOf:
-  - $ref: dai-common.yaml#
-
 properties:
   compatible:
     enum:
       - st,stm32h7-i2s
+      - st,stm32mp25-i2s
 
   "#sound-dai-cells":
     const: 0
@@ -28,18 +26,12 @@ properties:
     maxItems: 1
 
   clocks:
-    items:
-      - description: clock feeding the peripheral bus interface.
-      - description: clock feeding the internal clock generator.
-      - description: I2S parent clock for sampling rates multiple of 8kHz.
-      - description: I2S parent clock for sampling rates multiple of 11.025kHz.
+    minItems: 2
+    maxItems: 4
 
   clock-names:
-    items:
-      - const: pclk
-      - const: i2sclk
-      - const: x8k
-      - const: x11k
+    minItems: 2
+    maxItems: 4
 
   interrupts:
     maxItems: 1
@@ -79,6 +71,48 @@ required:
   - dmas
   - dma-names
 
+allOf:
+  - $ref: dai-common.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: st,stm32h7-i2s
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: clock feeding the peripheral bus interface.
+            - description: clock feeding the internal clock generator.
+            - description: I2S parent clock for sampling rates multiple of 8kHz.
+            - description: I2S parent clock for sampling rates multiple of 11.025kHz.
+
+        clock-names:
+          items:
+            - const: pclk
+            - const: i2sclk
+            - const: x8k
+            - const: x11k
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: st,stm32mp25-i2s
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: clock feeding the peripheral bus interface.
+            - description: clock feeding the internal clock generator.
+
+        clock-names:
+          items:
+            - const: pclk
+            - const: i2sclk
+
 unevaluatedProperties: false
 
 examples:
-- 
2.25.1


