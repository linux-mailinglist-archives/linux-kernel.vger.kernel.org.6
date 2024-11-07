Return-Path: <linux-kernel+bounces-400215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D481D9C0A7C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 16:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56DBF1C226F7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E992144C6;
	Thu,  7 Nov 2024 15:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="dqTLO5o5"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B501DFDAD;
	Thu,  7 Nov 2024 15:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730994901; cv=none; b=WQvt5/zbnLbXqVAEqlqSGQ1MTxyAqCjCkF/dRPHt+3ChY77aL6hDVrf4wEhH4ztJ6yI2XjWWote3JWXp7Ynz/s6IIglezeohtqlhJE0O5nDy0MQimNiv3fV/4/qdrlDA4UQ6VCdHlm2kKDuPmAv6G+mTihgAkNDhNfUSGxtb9aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730994901; c=relaxed/simple;
	bh=i05yoQ81D9So2rHWrDdV0mDezvBKpfjM8FU6238MQOk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VQOysJoYRsX3twW0bSVmk+p4gG1tVTwGnf9FuIUqmwK+Pi3jd14cRrDvV+AHVV799Hl5F28kDXIl6/NpI5riDN5i4DKGAP2o0CztVc/8hkvY27KafVQdX9R1iNHji8cs0yf14Ez1JMY/SFS+NL//QhApU0QTIbUIVm+Ar9so73g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=dqTLO5o5; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7Ap0oi001233;
	Thu, 7 Nov 2024 16:54:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	DdQ63519VTwDDYOb2ko9io8ZGiOolYAXq3k/7DS5g7Q=; b=dqTLO5o5EoF+cjp9
	WQj/kqPQSsBdtHKkEjAJ2ge82+b0WHRCd26G5Oaao5bHaTmeVUnfa76STxJXqwtC
	mnZzHEFhfsVOM6Q/2FjGZlN6lL8QtkmzBd1Mf4o55TTiKnYKX3J5tR8sTwUuInMf
	ajeGPPzxNSjCLtWluzu6s1HCUBmfi2ne61uYhNzocSqmmhQIPdzrCbZ46/gqhX3b
	ZHMQhBM/j3gTetLawEjT7zuELoP4NOhjFitIDFAnY8jLRBKx/+kVLqA5NR4H6dfz
	Yj7tfN00ZzoG0ovrRo0v49mYKTQJ+ovPF92qFY2XmBIZi4tVUOyU38rQUs968DZw
	gQ7MlQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 42r9765y3j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 16:54:43 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 07AA140048;
	Thu,  7 Nov 2024 16:53:49 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A95982B7342;
	Thu,  7 Nov 2024 16:52:01 +0100 (CET)
Received: from localhost (10.48.86.132) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 7 Nov
 2024 16:52:01 +0100
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
Subject: [PATCH 1/2] ASoC: dt-bindings: add stm32mp25 support for sai
Date: Thu, 7 Nov 2024 16:51:41 +0100
Message-ID: <20241107155143.1340523-2-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241107155143.1340523-1-olivier.moysan@foss.st.com>
References: <20241107155143.1340523-1-olivier.moysan@foss.st.com>
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

Add STM32MP25 support for STM32 SAI peripheral,
through "st,stm32mp25-sai" compatible.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 .../bindings/sound/st,stm32-sai.yaml          | 26 ++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/st,stm32-sai.yaml b/Documentation/devicetree/bindings/sound/st,stm32-sai.yaml
index 68f97b462598..4a7129d0b157 100644
--- a/Documentation/devicetree/bindings/sound/st,stm32-sai.yaml
+++ b/Documentation/devicetree/bindings/sound/st,stm32-sai.yaml
@@ -20,6 +20,7 @@ properties:
     enum:
       - st,stm32f4-sai
       - st,stm32h7-sai
+      - st,stm32mp25-sai
 
   reg:
     items:
@@ -43,9 +44,11 @@ properties:
     const: 1
 
   clocks:
+    minItems: 1
     maxItems: 3
 
   clock-names:
+    minItems: 1
     maxItems: 3
 
   access-controllers:
@@ -156,7 +159,13 @@ allOf:
           items:
             - const: x8k
             - const: x11k
-    else:
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: st,stm32mph7-sai
+    then:
       properties:
         clocks:
           items:
@@ -170,6 +179,21 @@ allOf:
             - const: x8k
             - const: x11k
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: st,stm32mp25-sai
+    then:
+      properties:
+        clocks:
+          items:
+            - description: pclk feeds the peripheral bus interface.
+
+        clock-names:
+          items:
+            - const: pclk
+
 additionalProperties: false
 
 examples:
-- 
2.25.1


