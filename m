Return-Path: <linux-kernel+bounces-523317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4791FA3D502
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DB41168DDB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3DE1F03F0;
	Thu, 20 Feb 2025 09:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eEtFgbJQ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B5F1E9B19
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 09:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740044534; cv=none; b=ezqqROA8Zrq6osT+2rYp7Q/EA9/iGIzvmaZfdDefs20NFxAdGMVzdh2qOk4rh+LQh0O4rydAsV3/G9A9lxrDkdF/CbRUCqmaFPioGN7UA5ibAmUG4Ipz34Xu69EvNi8a1nBuSNlT1NMI00QvS2WBF+DR40uYYzwdCW32qavRonQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740044534; c=relaxed/simple;
	bh=ySYv5oAl7rxrIABHsrIW5uaZdj2vv/AflGOAoDAa3zg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=PrNeTKXDv9LdXwbGUCt/kgZH2s0CyO7zSZttCnKubz6bHa18AT7vB9JOs62EZUoT8fKg97AwOcSkc0JUmQfHuRctBbZKQ8wHgio2tXLHioqrodHVhc4IeL7mcT6uoKutSvvgyHF/RL/+TZGqJEVy2AbumYW5xKGruzT8IFEvXQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eEtFgbJQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51K6X42K016354;
	Thu, 20 Feb 2025 09:42:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/cL+CCL0X6aLAARkr+HxhuD5UGrruT/1yZpL7/mWVpg=; b=eEtFgbJQon3LcR7i
	p1N/eQY5fLN5h8Q7WQphphqa0ds1ni8UnS9z+oN7vgb8/ewjmG6stjcfzjAMAbO0
	9ozQydMTWNIo70UPsF3Bg4nACZIktrHtKKmzbFrvt0ekjogRl5cQi9uqwIhDWvWP
	uCZrXU7mUmSDlINwR8dSmByk0Mni9JQgFNyUZzIRmsROXwpKtm2mOoKuZQo37LxC
	6k/VMfPt9tggZqAcIprw0t0mMYeM+8GluYWzSDjFTR7gWVUztiIfQ3DPkbDx1NwG
	hP7LNixapAkTyl/sbDElecl0yijkglIvP4lqW2LWjvBPHf+22RNPMbNTu5afDA+E
	gWKm9w==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy15kt5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 09:42:02 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51K9g1lI030703
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 09:42:01 GMT
Received: from yuanfang4-gv.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 20 Feb 2025 01:41:57 -0800
From: Yuanfang Zhang <quic_yuanfang@quicinc.com>
Date: Thu, 20 Feb 2025 17:41:21 +0800
Subject: [PATCH 1/5] dt-bindings: arm: Add Coresight device Trace NOC
 definition
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250220-trace-noc-driver-v1-1-15d78bd48e12@quicinc.com>
References: <20250220-trace-noc-driver-v1-0-15d78bd48e12@quicinc.com>
In-Reply-To: <20250220-trace-noc-driver-v1-0-15d78bd48e12@quicinc.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach
	<mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>
CC: <kernel@quicinc.com>, <linux-kernel@vger.kernel.org>,
        <coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740044514; l=3425;
 i=quic_yuanfang@quicinc.com; s=20241209; h=from:subject:message-id;
 bh=ySYv5oAl7rxrIABHsrIW5uaZdj2vv/AflGOAoDAa3zg=;
 b=kNpXKjVZm3sWvTm6+whK99Vpp1bChLTJJTBc2mWwEZQAqp/NxvC8OGiOeOdbPyP7C/m1v/knE
 FFifJhSb12/Dchh+hWyQU3+geEPRL4XYJ1ZRItwBpjrpvmX61kHfvff
X-Developer-Key: i=quic_yuanfang@quicinc.com; a=ed25519;
 pk=ZrIjRVq9LN8/zCQGbDEwrZK/sfnVjwQ2elyEZAOaV1Q=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: o-2xbyZZdlH3QH4FqLvNvhGgRSauWbfR
X-Proofpoint-ORIG-GUID: o-2xbyZZdlH3QH4FqLvNvhGgRSauWbfR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_04,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 clxscore=1015
 suspectscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=3 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502100000 definitions=main-2502200070

Adds new coresight-tnoc.yaml file describing the bindings required
to define Trace NOC in the device trees.

Signed-off-by: Yuanfang Zhang <quic_yuanfang@quicinc.com>
---
 .../bindings/arm/qcom,coresight-tnoc.yaml          | 107 +++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-tnoc.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-tnoc.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..b8c1aaf014fb483fd960ec55d1193fb3f66136d2
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/qcom,coresight-tnoc.yaml
@@ -0,0 +1,107 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/qcom,coresight-tnoc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Ttrace NOC(Network On Chip)
+
+maintainers:
+  - yuanfang Zhang <quic_yuanfang@quicinc.com>
+
+description:
+  The Trace NoC is an integration hierarchy which is a replacement of Dragonlink tile configuration.
+  It brings together debug component like TPDA, funnel and interconnect Trace Noc which collects trace
+  from subsystems and transfers to QDSS sink.
+
+  It sits in the different subsystem of SOC and aggregates the trace and transports it to Aggregation TNoC
+  or to QDSS trace sink eventually. Trace NoC embeds bridges for all the interfaces(APB, ATB, QPMDA & NTS).
+
+  Trace NoC can take inputs from different trace sources i.e. ATB, QPMDA.
+
+# Need a custom select here or 'arm,primecell' will match on lots of nodes
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - qcom,coresight-tnoc
+  required:
+    - compatible
+
+properties:
+  $nodename:
+    pattern: "^tn(@[0-9a-f]+)$"
+  compatible:
+    items:
+      - const: qcom,coresight-tnoc
+      - const: arm,primecell
+
+  reg:
+    minItems: 1
+    maxItems: 2
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: apb_pclk
+
+  in-ports:
+    description: |
+      Input connections from subsystem to TNoC
+    $ref: /schemas/graph.yaml#/properties/ports
+
+  out-ports:
+    description: |
+      Output connections from the TNoC to Aggreg TNoC or to legacy CoreSight trace bus.
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port:
+        description: |
+          Output connections from the TNoC to Aggreg TNoC or to legacy CoreSight trace bus.
+        $ref: /schemas/graph.yaml#/properties/port
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - in-ports
+  - out-ports
+
+additionalProperties: false
+
+examples:
+  - |
+    tn@109ab000  {
+      compatible = "qcom,coresight-tnoc", "arm,primecell";
+      reg = <0x0 0x109ab000  0x0 0x4200>;
+
+      clocks = <&aoss_qmp>;
+      clock-names = "apb_pclk";
+
+      in-ports {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        port@0 {
+          reg = <0>;
+
+          tn_ag_in_tpdm_gcc: endpoint {
+            remote-endpoint = <&tpdm_gcc_out_tn_ag>;
+          };
+        };
+      };
+
+      out-ports {
+        port {
+          tn_ag_out_funnel_in1: endpoint {
+            remote-endpoint = <&funnel_in1_in_tn_ag>;
+          };
+        };
+      };
+    };
+...

-- 
2.34.1


