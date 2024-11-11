Return-Path: <linux-kernel+bounces-404058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4419C3EA1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 13:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43AEF281136
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 12:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A37F19DFAC;
	Mon, 11 Nov 2024 12:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="M/fXTtJO"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1398819C555;
	Mon, 11 Nov 2024 12:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731329303; cv=none; b=j5gARm+NaYngRh5bOr6czAR+VSAE1ZsJ3IpDGA5NNNqPBV8ZadQrJJttHSVtS4AhuAdM5eAbC/gnbqj43n4kqU9sXNeO47ErCZTLc/e+ce4Wi1a2nrAsTtu322H7e9C68Gy3uiRpPD92JGyXxB6x+GCwECy+vEgaqtf6w0alBe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731329303; c=relaxed/simple;
	bh=R+pokW4B2SbOO7WgR5kp00klRH776j1VLb+yHkPzbe8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fnDexWVDXmajYUqOC0wga4U8YbRh7wlpwWijKjHPxeSYu0RlbJ8v1TRbfoNvb4RoR7YFvftWKwdr1QXwZfcsVlIHj3ZGzF8sZIertwq6ukAAUGtdg+AV4ablDxhRcJks+lZBb1PoK1rI3OWQCHJoIGanmbWLd7jYJoM3XvCHZpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=M/fXTtJO; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AB8qswY009133;
	Mon, 11 Nov 2024 04:48:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=v
	Xl2QMoB+B6TMz0cDEVl3sfLgHRRa5J7avFcSwL+N84=; b=M/fXTtJO3ODfK/4H9
	OEFKxZ06trbcbioRJxHasXcCWyFAPBO+Vwc3WPCDdqAy5gV61ro2TOjvgyCzqrCo
	8vsi+yNYi47TwkQ0PI2usukLOGSs2mC7/FPyNyjdZOh0eLjockGpNtPBJPOLH7Od
	VVP0sP0cZLxM/g7lnzuCgWyKejllFc38j9C8m8htA6PLhqrJc7Vny/Ry+qxk2mCp
	57moocmIEbsEBkV9yXD6rZm0Wh1LAtCDS/TJT61SfLlMw14xgr14Wg9tLWSmUBPW
	UpwEVk8hnHEIo2hUI1gyWGwkuR9U2rQ6EB89Fdwwmdhcl3PL5Oh/MSN1cGyEjgsB
	E/8gQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 42uet6ga5s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Nov 2024 04:48:03 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 11 Nov 2024 04:48:02 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 11 Nov 2024 04:48:02 -0800
Received: from virtx40.. (unknown [10.28.34.196])
	by maili.marvell.com (Postfix) with ESMTP id C27363F70AE;
	Mon, 11 Nov 2024 04:47:57 -0800 (PST)
From: Linu Cherian <lcherian@marvell.com>
To: <suzuki.poulose@arm.com>, <mike.leach@linaro.org>, <james.clark@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <coresight@lists.linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <devicetree@vger.kernel.org>, <sgoutham@marvell.com>,
        <gcherian@marvell.com>, Linu Cherian <lcherian@marvell.com>
Subject: [PATCH v11 1/8] dt-bindings: arm: coresight-tmc: Add "memory-region" property
Date: Mon, 11 Nov 2024 18:17:39 +0530
Message-ID: <20241111124746.2210378-2-lcherian@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241111124746.2210378-1-lcherian@marvell.com>
References: <20241111124746.2210378-1-lcherian@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: xc-C8RqtKEdTlxFrAFI26BKBl8YoA5Gb
X-Proofpoint-ORIG-GUID: xc-C8RqtKEdTlxFrAFI26BKBl8YoA5Gb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

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
Changelog from v10:
No changes.

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


