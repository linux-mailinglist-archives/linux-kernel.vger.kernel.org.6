Return-Path: <linux-kernel+bounces-196241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F6C8D594F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 06:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 797BB1C235CA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 04:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506287B3E1;
	Fri, 31 May 2024 04:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="S4Cf+SMR"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3122E187554;
	Fri, 31 May 2024 04:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717129694; cv=none; b=iUUWRwoXRmqCtLH+znSUMdfKh4p2Giy/iRNcz7cfBaskFf9jyUUaZs1JMdPBIX0/+GBtlyvmsO6fBBLsBgS2G3iHwY0/xFkcaRk3P7438f+3AaoHFzJUA8k5xZ+1wPW5Agfv7LFdQgokMqlSUxZLp8S7GtVY9lQ1K8nwlJ8UJLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717129694; c=relaxed/simple;
	bh=MXIzVq0dIhtRg32LkPd8K+sI/KI97awMjyylhz3JFG4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MmkV3nYlLDTpmRBJo2U1yGfpU3d+c0EmFUXgbJ+X4bc/7nyU1Jxsnq+CP4TIUATlUQNxC8JhxRxepJCxtB0t8c+q6141oaTrfb5GR8EbRezaAinTdFUUnhpx7Soesyat2vBqFteujazebEM7+O+0HGs4T3yYcks/usSAshzIreA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=S4Cf+SMR; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44UHMRI6026563;
	Thu, 30 May 2024 21:28:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=h
	hicOWMHKa1J/H/XNJ6E6RZzHWAH/BnUWB/xcC7KnOc=; b=S4Cf+SMR/5oKE8QPx
	gPmh4y0f2paPz6xsJ4P9VnfCJYe93z1SUu5XTQ9eR4Ku3f8Edq26aguYyfcnXMUK
	eQklHS0OP6XjAh2Xx+s8Td8S1BQVr7hTb1bC1hfz+3uNrmuUjr9NXOr8ukuEAM02
	NT4swB5irPsT/l72YXFj6O9nWbFAsNb3DEnJPc5bdM847IONYg9JtZr7b3ulfQKT
	UEYFa/YSoqZgudCna8/16spjAccWPxhrycCAtJoaeTxDEUDAmLzKSHCYyookxkvx
	42M/aTah0gGSCUSPFkfoJRLZhtcqqdMmiDpcQseF1GXBwP37uRHMB5tiTP9EcbjT
	g8Esg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3yewt3a0vk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 May 2024 21:28:02 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 30 May 2024 21:28:01 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 30 May 2024 21:28:01 -0700
Received: from virtx40.. (unknown [10.28.34.196])
	by maili.marvell.com (Postfix) with ESMTP id 99D1C3F7085;
	Thu, 30 May 2024 21:27:57 -0700 (PDT)
From: Linu Cherian <lcherian@marvell.com>
To: <suzuki.poulose@arm.com>, <mike.leach@linaro.org>, <james.clark@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <coresight@lists.linaro.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <sgoutham@marvell.com>,
        <gcherian@marvell.com>, Linu Cherian <lcherian@marvell.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v8 1/7] dt-bindings: arm: coresight-tmc: Add "memory-region" property
Date: Fri, 31 May 2024 09:57:39 +0530
Message-ID: <20240531042745.494222-2-lcherian@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531042745.494222-1-lcherian@marvell.com>
References: <20240531042745.494222-1-lcherian@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 78w7haN8_V3iAbsh_xc1vl49rVmKgg17
X-Proofpoint-GUID: 78w7haN8_V3iAbsh_xc1vl49rVmKgg17
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_21,2024-05-30_01,2024-05-17_01

memory-region 0: Reserved trace buffer memory

  TMC ETR: When available, use this reserved memory region for
  trace data capture. Same region is used for trace data
  retention after a panic or watchdog reset.

  TMC ETF: When available, use this reserved memory region for
  trace data retention synced from internal SRAM after a panic or
  watchdog reset.

memory-region 1: Reserved meta data memory

  TMC ETR, ETF: When available, use this memory for register
  snapshot retention synced from hardware registers after a panic
  or watchdog reset.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Linu Cherian <lcherian@marvell.com>
---
 .../bindings/arm/arm,coresight-tmc.yaml       | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml
index cb8dceaca70e..4787d7c6bac2 100644
--- a/Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml
@@ -101,6 +101,29 @@ properties:
           and ETF configurations.
         $ref: /schemas/graph.yaml#/properties/port
 
+  memory-region:
+    items:
+      - description: Reserved trace buffer memory for ETR and ETF sinks.
+          For ETR, this reserved memory region is used for trace data capture.
+          Same region is used for trace data retention as well after a panic
+          or watchdog reset.
+          This reserved memory region is used as trace buffer or used for trace
+          data retention only if specifically selected by the user in sysfs
+          interface.
+          The default memory usage models for ETR in sysfs/perf modes are
+          otherwise unaltered.
+
+          For ETF, this reserved memory region is used by default for
+          retention of trace data synced from internal SRAM after a panic
+          or watchdog reset.
+      - description: Reserved meta data memory. Used for ETR and ETF sinks
+          for storing metadata.
+
+  memory-region-names:
+    items:
+      - const: tracedata
+      - const: metadata
+
 required:
   - compatible
   - reg
@@ -115,6 +138,9 @@ examples:
     etr@20070000 {
         compatible = "arm,coresight-tmc", "arm,primecell";
         reg = <0x20070000 0x1000>;
+        memory-region = <&etr_trace_mem_reserved>,
+                       <&etr_mdata_mem_reserved>;
+        memory-region-names = "tracedata", "metadata";
 
         clocks = <&oscclk6a>;
         clock-names = "apb_pclk";
-- 
2.34.1


