Return-Path: <linux-kernel+bounces-303510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AAA960D21
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 16:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04E401C22AF8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5AA1C463D;
	Tue, 27 Aug 2024 14:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Z4BxGOTa"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE81F1C4621;
	Tue, 27 Aug 2024 14:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724767588; cv=none; b=c+qfc9IOFgT+WJAjm5k3VD1B87ljaKnKzVyGYsu/Fk3WtdWPjsDBbEeOksRZqbyQ27NNIIhZZWMUye9HNLtWkaGFWqetS8PTfx+w5rL3cqPkpPPcjFjmavIPpWklCWnWDLNR7B4D4QS2Bece3jwHS+t2hg1xDd5G4wj8Nl/CpOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724767588; c=relaxed/simple;
	bh=U8QN6gVKd/SxRU8bMKA0/+0cjy9rK2099iErsHWuwgs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R7b2FoPM5LkAme9pDuIcyLZlBQ9UZlGywNC/qmUriIq4pCghwVam4vJTOw4HJi2w8t32AaY3ExRYDK2QfOU+7FO6tsZ1IaFrnZGEN+boWPSTupxy9qx7EeJOVRPGq9MgEQa5paxE/XUC8+EXYwq5iFq3Edr+YfsHdZZnZ+jmv/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Z4BxGOTa; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47RBUL10022292;
	Tue, 27 Aug 2024 16:06:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=Ff8eTytbmxual/Q6Fz+3og
	SbrU6ts/Ud/smwAdcvD1s=; b=Z4BxGOTafsPvaVeoMcVA4HSIvefTkhCk69F49t
	e6HP6gA6/fLH0WjKPX7Fzfala5tzrjPk2DyhXPaoQXCaOsEiDWXEGB0Uk+7xvQ5W
	npDoh3j5usl1HoVSHRJknTs1ya8yrbW2lpN3f8SMjSq5jEgeCLUp+v0MwVAnKGhs
	9Bnhy94N+hLZICXYZsfeDtFBC3NyrsL7BHFDqXVTC9VLWECprh3UOCzUcd/lz/GJ
	T2ErZgkVe1Uc4X8eSy9oh9RZE6B2RXWjeQezOhrzVd/R0R6FPLmoK5AacpCvqVJX
	EgQpEsjlZO9WeJLbhai9PLDSjtf0m0slx3gNg1z905Cp7dnQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 419e00rmq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 16:06:03 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id EDC9B40044;
	Tue, 27 Aug 2024 16:05:57 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 435F926C44C;
	Tue, 27 Aug 2024 16:04:58 +0200 (CEST)
Received: from localhost (10.48.86.237) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 27 Aug
 2024 16:04:58 +0200
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
Subject: [PATCH v3] dt-bindings: display: st,stm32-ltdc: Document stm32mp25 compatible
Date: Tue, 27 Aug 2024 16:04:55 +0200
Message-ID: <20240827140455.115182-1-yannick.fertre@foss.st.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_08,2024-08-27_01,2024-05-17_01

Add "st,stm32mp25-ltdc" compatible for SOC MP25. This new SOC introduce
new clocks (bus, ref & lvds). Bus clock was separated from lcd clock.
New sources are possible for lcd clock (lvds / ref).

Signed-off-by: Yannick Fertre <yannick.fertre@foss.st.com>
---

Changes in v3: Add max/min Items fields.
'make dt_binding_check' command fails on previous patch, rework fiedls mas/min items
of properties clocks & clock-names.

Changes in v2: Rework clock property.

 .../bindings/display/st,stm32-ltdc.yaml       | 28 +++++++++++++++----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml b/Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml
index d6ea4d62a2cf..940127820de3 100644
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
@@ -24,12 +26,12 @@ properties:
     minItems: 1
 
   clocks:
-    maxItems: 1
+    minItems: 1
+    maxItems: 4
 
   clock-names:
-    items:
-      - const: lcd
-
+    minItems: 1
+    maxItems: 4
   resets:
     maxItems: 1
 
@@ -51,6 +53,22 @@ required:
   - resets
   - port
 
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
+          minItems: 2
+    else:
+      properties:
+        clocks:
+          minItems: 1
+
 additionalProperties: false
 
 examples:
-- 
2.34.1


