Return-Path: <linux-kernel+bounces-400121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D849C093D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91AE41C23784
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 14:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80812212EEF;
	Thu,  7 Nov 2024 14:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="GCsEjwdq"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF5E2E3EB;
	Thu,  7 Nov 2024 14:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730990978; cv=none; b=h0GT6CvnVHuaQlLN/jZwBqzWgdTGp/arab965n2anxhtWiK6inDQisuDy6hglbJHX1k27t3qlY18+1MGCy0oO/V+KsfDWuAIxebzf9pzVfXebQ9YVNmgsUuAo4BMl2KGwmGjyCaZV/yi4nhX7lUfAMz2JNhRFoZgxIPptrf4i0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730990978; c=relaxed/simple;
	bh=Og9Cq+YtUzlHc2Mr11Pi9BaT1pTr/Dz0WHnePkmxvzE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b6BWwXlonOkC4LEeAuOKHlq08mlEFthJA3AdwfIusLcz8WL022myNkbSZLNhfsKRXjDZuOkrJVNKoddXFrpMk0G8HVurZBYKitAMoE1FnTz7znZ77s454KZ8OT8gRx4s/dr3mjXr43Pll0cmESJXUFMXOvm+0EPh+czra+cOZyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=GCsEjwdq; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7BPOxb001277;
	Thu, 7 Nov 2024 15:49:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	ienHGXKCWAz/ANukHZpdgkhnrKTvDCmbAMpuaZRiPmI=; b=GCsEjwdqoQWsIWta
	2m5eWnfgDeOV9wLIgabL+vUnYSe6hYGROVrGv3zcvyPY8khtzjGMErbUO9E84dRj
	AzcjJLlLSeP1w8G5aW36WtSoLmLm4admIo7aHBHomAw9XJ69HvNIpp50Z7mAkBlP
	mYIoBPrTb4IO2Z4/M3Awr5TZekUP9QTFhkTJYlQZS3wO7xHQ5QlmmBUMtQI6ZGEA
	8RxhxM1tmne2dTCua5NUrROqBWwgUww4TNE9Z3vB0UbMcN/VnGNW8SkpEMou3v4V
	1CuTODTNpq7av7riP8K+0cEOLV4YrhI9EUzzTk8HWLXmBfpZ4PZGZpg3TQmH6I+9
	QNu0rA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 42r9765p3p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 15:49:18 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 74DCA40047;
	Thu,  7 Nov 2024 15:48:21 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8D1D22BA0A8;
	Thu,  7 Nov 2024 15:47:37 +0100 (CET)
Received: from localhost (10.48.86.132) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 7 Nov
 2024 15:47:37 +0100
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
Subject: [PATCH v2 1/2] ASoC: dt-bindings: add stm32mp25 support for i2s
Date: Thu, 7 Nov 2024 15:47:11 +0100
Message-ID: <20241107144712.1305638-2-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241107144712.1305638-1-olivier.moysan@foss.st.com>
References: <20241107144712.1305638-1-olivier.moysan@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Add STM32MP25 support for STM32 I2S peripheral,
through "st,stm32mp25-i2s" compatible.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 .../bindings/sound/st,stm32-i2s.yaml          | 36 +++++++++++++++++--
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml b/Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml
index 8978f6bd63e5..b4f44f9c7c7d 100644
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
@@ -33,6 +31,7 @@ properties:
       - description: clock feeding the internal clock generator.
       - description: I2S parent clock for sampling rates multiple of 8kHz.
       - description: I2S parent clock for sampling rates multiple of 11.025kHz.
+    minItems: 2
 
   clock-names:
     items:
@@ -40,6 +39,7 @@ properties:
       - const: i2sclk
       - const: x8k
       - const: x11k
+    minItems: 2
 
   interrupts:
     maxItems: 1
@@ -79,6 +79,36 @@ required:
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
+          minItems: 4
+
+        clock-names:
+          minItems: 4
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
+          maxItems: 2
+
+        clock-names:
+          maxItems: 2
+
 unevaluatedProperties: false
 
 examples:
-- 
2.25.1


