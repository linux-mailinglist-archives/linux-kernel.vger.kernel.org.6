Return-Path: <linux-kernel+bounces-535185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D286DA46FEB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CF39188CEA1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 00:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4A917597;
	Thu, 27 Feb 2025 00:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jbjZqZ2g"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C229510F4
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 00:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740615110; cv=none; b=rCpTRMD6ki62QKwl98WY1ea7zmlWdnz2b0n1DpQfx4ayrsoH4vV3nR1TinChgXFWjShd9xtae6ItUyKgw9adK2LnVYJTDeZsjY6P6izk5NJqjypo7htZCZAjeHsMgXspewq0Fve0CMQxzThaAdVuXCIKHogjXztajGOvHx37Gzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740615110; c=relaxed/simple;
	bh=NY6q0RklBTW1DFQ11MvB1hWCU0MKqqj+mmVufAIP3j8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pYbivJAND4/Vq79rRWd6OMR3xP7tcZxPU7hmbJ6ndbbnVZ90xdS/EX06citmw1nj8LQfBdiKvstDf8h0gbtN+RNwLhdkHwnZbbXA+1NQ0VvSdqrsD92MtS7YMif3jtoLgTEahJ2Thap2ALWm3ZKTD8I7t8KoghwjTsJYZyR196w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jbjZqZ2g; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QM4KbU005715
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 00:11:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HhnNU//Z0QVpICTnI2AsRyugIObg7UO7vAC1/hup27w=; b=jbjZqZ2gEgo6/p2Z
	ds7dNKYtNolT9+XmjxmDjJZW1fDiuMcenSpy52I2ggiLs3D3dgSIDO0HLiQrx00r
	gV/9I2YMyUEc7lAQAaF4MOfF5Lay5xPNTF+kzhFicJeBLeTwba1pWiCt1fHc7W2m
	KQPNuzxQoNoaALR029Zwb83OcBpuvICIb9O7ogCRcaQ1fuDqCWkXr9hjhi4gxgTE
	hh2uGX2ezNS9yiCRmWJN92jAGX04Rcq1vnJpdM2AvR3NP9ks7tohoIrVq20sptiw
	HiO4Khz3LDrw2fUQZj/gPw7hydJMpzToz+bvhtVaYqrbi+nsuiIVvwXm6h1v0MRB
	1Fc6/w==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 452be6g7va-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 00:11:47 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3f3fbe10227so302706b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 16:11:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740615107; x=1741219907;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HhnNU//Z0QVpICTnI2AsRyugIObg7UO7vAC1/hup27w=;
        b=LFzBDxHdbKDLdYPYAlNkN796ZTUmGAcKUJPFQTUX77FNQ7OCkYeYjr70giki/xexeT
         EVMOpmPsOrJmnKtfSmsbjXVA63fMGg8cl48wPIWpdZpIVEECRnJ/Skq1NlX39eUeG/fT
         iCfek/4p7OqW0EqjXSovvDr5mSwqFFdLQxVerM+AB0WmZyMfhQ5HZvn8F8Q3IOAjqN+K
         0UuTcaydO9zuBXyQFIFVYN5vKbcuEToDzGK5nRhrz3iame1zx09zEmZW6vSm5TOOZfTk
         rrOIyfDzgpFcBSuDtnExKVDacXwB0d4iXJsCVuimXhV8nguWNt44LuoFOImcStnQ0WEG
         9gtg==
X-Forwarded-Encrypted: i=1; AJvYcCW/3b8UAbcKKBWObrGLLnvVOLOThbzlusXk1eQ7i3zxv++xlTqn6DMEI9GATOFcU5fm79aB0bbprOYJmVI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw955D17xQGa6FkL++HMEc+PLOn7cdQdiZkoMVV0UwepjKMfyTB
	1nweiPqvNlSYaiOZ19W8yq4EJ7CyYrPw6USEDxZoAnvBQblb8LG3OWq4ZHLsXO13uo9zSi6nMoE
	kgTW6O3dM52ii2pfCkaHBMWEnR2Gb8JfNTU4ffjQ2prwrUrBJxlB4fsQzZSEAy7Y=
X-Gm-Gg: ASbGncsCW6R0/uIJq8APPQKYuDOv/n6ftRlGDx+JGKLxjXlAoFE0IgYzahTy3Srp/it
	EvjfkqKlLJXhlNcQmgrk/+S1U1TZJPzxIanbcwMShgMmcC1n6lmgFJlzES5hVj0mPsyvQ6oaoqV
	pTcPaEzQdh1PvQrLmV+KLcYmOwXla07doYwVLKWMnDSSYY+NhIRDRJUcPCS+isSRz7dE1zeF+Wg
	31v8dbyRPKOwC4Y75KrEO5L5Ur871uVXpPEHVHER1k09GNb3uA5MKUTahd6VrtRp30bFN9rZLNp
	rjsiVJhQsFMXHxnyplczzebutu0prdt/U92QgQ9Of4GXFNSc0JgfvZOE/4i5bS1XCFVEmmpK8eL
	kYCAUl7hVq2HD/Ns=
X-Received: by 2002:a05:6808:634c:b0:3f5:505c:42b4 with SMTP id 5614622812f47-3f5505c43e3mr166290b6e.2.1740615106553;
        Wed, 26 Feb 2025 16:11:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEIz3PhfTQ8trw45/Hg7ib0OGOdAf0FZIp5F7yCFN2NUXMO3o0AdgsE/cojmHcTVANmOIrQ1g==
X-Received: by 2002:a05:6808:634c:b0:3f5:505c:42b4 with SMTP id 5614622812f47-3f5505c43e3mr166269b6e.2.1740615106149;
        Wed, 26 Feb 2025 16:11:46 -0800 (PST)
Received: from [192.168.86.65] (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f5507c40c6sm33988b6e.45.2025.02.26.16.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 16:11:45 -0800 (PST)
From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Date: Wed, 26 Feb 2025 16:17:48 -0800
Subject: [PATCH v4 1/7] dt-bindings: usb: Introduce qcom,snps-dwc3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-dwc3-refactor-v4-1-4415e7111e49@oss.qualcomm.com>
References: <20250226-dwc3-refactor-v4-0-4415e7111e49@oss.qualcomm.com>
In-Reply-To: <20250226-dwc3-refactor-v4-0-4415e7111e49@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Saravana Kannan <saravanak@google.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Frank Li <Frank.li@nxp.com>
Cc: linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=19806;
 i=bjorn.andersson@oss.qualcomm.com; h=from:subject:message-id;
 bh=NY6q0RklBTW1DFQ11MvB1hWCU0MKqqj+mmVufAIP3j8=;
 b=owEBgwJ8/ZANAwAIAQsfOT8Nma3FAcsmYgBnv684yeDODheDdv3y6tYmZKLsafd5FARDd3bP7
 5/dE/PCc5SJAkkEAAEIADMWIQQF3gPMXzXqTwlm1SULHzk/DZmtxQUCZ7+vOBUcYW5kZXJzc29u
 QGtlcm5lbC5vcmcACgkQCx85Pw2ZrcWsUBAAzgsDxzWGJiOj6V7uyqNsa2QVS8A50Ew87tfjodA
 2zfGuer2Nm3LwITmALzBwKIMvplFTIwQa108ha4/hczLofKAtOmmkOt2Bn5Fr0P9WaHcvo2TjQy
 H+QLmAZdCZhlEI120Gf4CMEnsRsSVFYVIkw4IfyUOjq8dasNUuAo2BSYt/17esvjke2EBPl8fP3
 IWEdDl+iXxDiMyrjE+Gefwun1dUvQ56KUYmg7LRRy+tpyvj5b9cPyGiKMNt/99+bvHRCJlekBOY
 aOE33h087kED1R31q0sW4Gvu62fiV22r/4UW9oxMgmJqAf2aGC3qgPS2xH3y4R6MNrnHUHaUKc0
 ScDtmyXx/p/btxGo1LMsT5rTPxU83RJla+C1ht6ykGIJNzE6OdPo0vsdeYhtkX0g7TwDISZb90k
 lfPD1gRtBCjmJstOVECExsin3NAHJC/v63r98RzEbFwnnOf4byw7g2hWSxIBCzqLqfGCkTn4/Gs
 K2KnsXbsG+ShTydZ0T0Cak1BGcWMaZvI2S5an4JVGdeo7p5cn20pa9Dy0+5s0mHyhX3JViCHAnQ
 SWBsSidtCZ1ab2vTECJB9g3rHWXpQRaQqELvOCCLJcSv1LAo1ASmGPg3ru6PX852bme9ldxbO9/
 Vw3Q/p9Gnmaci4jI1BuXLKs7lZ7WO/bGErTCN/eyopEM=
X-Developer-Key: i=bjorn.andersson@oss.qualcomm.com; a=openpgp;
 fpr=05DE03CC5F35EA4F0966D5250B1F393F0D99ADC5
X-Proofpoint-GUID: rUsqy_9WIcFoa0--_-AgK41-RsTr8MKv
X-Proofpoint-ORIG-GUID: rUsqy_9WIcFoa0--_-AgK41-RsTr8MKv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_07,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 impostorscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502270000

The Qualcomm USB glue is not separate of the Synopsys DWC3 core and
several of the snps,dwc3 properties (such as clocks and reset) conflicts
in expectation with the Qualcomm integration.

Using the newly split out Synopsys DWC3 core properties, describe the
Qualcomm USB block in a single block. The new binding is a copy of
qcom,dwc3 with the needed modifications.

It would have been convenient to retain the two structures with the same
compatibles, but as there exist no way to select a binding based on the
absence of a subnode/patternProperty, a new generic compatible is
introduced to describe this binding.

To avoid redefining all the platform-specific compatibles, "select" is
used to tell the DeviceTree validator which binding to use solely on the
generic compatible. (Otherwise if the specific compatible matches during
validation, the generic one must match as well)

Mark qcom,dwc3 deprecated, to favor expressing future platforms using
the new combined binding.

Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
---
 .../devicetree/bindings/usb/qcom,dwc3.yaml         |  13 +-
 .../devicetree/bindings/usb/qcom,snps-dwc3.yaml    | 619 +++++++++++++++++++++
 2 files changed, 631 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
index a2b3cf625e5b..6d818e6dddbc 100644
--- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
@@ -4,11 +4,22 @@
 $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Qualcomm SuperSpeed DWC3 USB SoC controller
+title: Legacy Qualcomm SuperSpeed DWC3 USB SoC controller
 
 maintainers:
   - Wesley Cheng <quic_wcheng@quicinc.com>
 
+# Use the combined qcom,snps-dwc3 instead
+deprecated: true
+
+select:
+  properties:
+    compatible:
+      contains:
+        const: qcom,dwc3
+  required:
+    - compatible
+
 properties:
   compatible:
     items:
diff --git a/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml
new file mode 100644
index 000000000000..37af52e01803
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml
@@ -0,0 +1,619 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/qcom,snps-dwc3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SuperSpeed DWC3 USB SoC controller
+
+maintainers:
+  - Wesley Cheng <quic_wcheng@quicinc.com>
+
+description:
+  Describes the Qualcomm USB block, based on Synopsys DWC3.
+
+select:
+  properties:
+    compatible:
+      contains:
+        const: qcom,snps-dwc3
+  required:
+    - compatible
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - qcom,ipq4019-dwc3
+          - qcom,ipq5018-dwc3
+          - qcom,ipq5332-dwc3
+          - qcom,ipq5424-dwc3
+          - qcom,ipq6018-dwc3
+          - qcom,ipq8064-dwc3
+          - qcom,ipq8074-dwc3
+          - qcom,ipq9574-dwc3
+          - qcom,msm8953-dwc3
+          - qcom,msm8994-dwc3
+          - qcom,msm8996-dwc3
+          - qcom,msm8998-dwc3
+          - qcom,qcm2290-dwc3
+          - qcom,qcs404-dwc3
+          - qcom,qcs615-dwc3
+          - qcom,qcs8300-dwc3
+          - qcom,qdu1000-dwc3
+          - qcom,sa8775p-dwc3
+          - qcom,sar2130p-dwc3
+          - qcom,sc7180-dwc3
+          - qcom,sc7280-dwc3
+          - qcom,sc8180x-dwc3
+          - qcom,sc8180x-dwc3-mp
+          - qcom,sc8280xp-dwc3
+          - qcom,sc8280xp-dwc3-mp
+          - qcom,sdm660-dwc3
+          - qcom,sdm670-dwc3
+          - qcom,sdm845-dwc3
+          - qcom,sdx55-dwc3
+          - qcom,sdx65-dwc3
+          - qcom,sdx75-dwc3
+          - qcom,sm4250-dwc3
+          - qcom,sm6115-dwc3
+          - qcom,sm6125-dwc3
+          - qcom,sm6350-dwc3
+          - qcom,sm6375-dwc3
+          - qcom,sm8150-dwc3
+          - qcom,sm8250-dwc3
+          - qcom,sm8350-dwc3
+          - qcom,sm8450-dwc3
+          - qcom,sm8550-dwc3
+          - qcom,sm8650-dwc3
+          - qcom,x1e80100-dwc3
+      - const: qcom,snps-dwc3
+
+  reg:
+    description: Offset and length of register set for QSCRATCH wrapper
+    maxItems: 1
+
+  power-domains:
+    description: specifies a phandle to PM domain provider node
+    maxItems: 1
+
+  required-opps:
+    maxItems: 1
+
+  clocks:
+    description: |
+      Several clocks are used, depending on the variant. Typical ones are::
+       - cfg_noc:: System Config NOC clock.
+       - core:: Master/Core clock, has to be >= 125 MHz for SS operation and >=
+                60MHz for HS operation.
+       - iface:: System bus AXI clock.
+       - sleep:: Sleep clock, used for wakeup when USB3 core goes into low
+                 power mode (U3).
+       - mock_utmi:: Mock utmi clock needed for ITP/SOF generation in host
+                     mode. Its frequency should be 19.2MHz.
+    minItems: 1
+    maxItems: 9
+
+  clock-names:
+    minItems: 1
+    maxItems: 9
+
+  iommus:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  interconnects:
+    maxItems: 2
+
+  interconnect-names:
+    items:
+      - const: usb-ddr
+      - const: apps-usb
+
+  interrupts:
+    description: |
+      Different types of interrupts are used based on HS PHY used on target:
+        - dwc_usb3: Core DWC3 interrupt
+        - pwr_event: Used for wakeup based on other power events.
+        - hs_phy_irq: Apart from DP/DM/QUSB2 PHY interrupts, there is
+                       hs_phy_irq which is not triggered by default and its
+                       functionality is mutually exclusive to that of
+                       {dp/dm}_hs_phy_irq and qusb2_phy_irq.
+        - qusb2_phy: SoCs with QUSB2 PHY do not have separate DP/DM IRQs and
+                      expose only a single IRQ whose behavior can be modified
+                      by the QUSB2PHY_INTR_CTRL register. The required DPSE/
+                      DMSE configuration is done in QUSB2PHY_INTR_CTRL register
+                      of PHY address space.
+        - {dp/dm}_hs_phy_irq: These IRQ's directly reflect changes on the DP/
+                               DM pads of the SoC. These are used for wakeup
+                               only on SoCs with non-QUSB2 targets with
+                               exception of SDM670/SDM845/SM6350.
+        - ss_phy_irq: Used for remote wakeup in Super Speed mode of operation.
+    minItems: 3
+    maxItems: 19
+
+  interrupt-names:
+    minItems: 3
+    maxItems: 19
+
+  qcom,select-utmi-as-pipe-clk:
+    description:
+      If present, disable USB3 pipe_clk requirement.
+      Used when dwc3 operates without SSPHY and only
+      HS/FS/LS modes are supported.
+    type: boolean
+
+  wakeup-source: true
+
+# Required child node:
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+  - interrupt-names
+
+allOf:
+  - $ref: snps,dwc3-common.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,ipq4019-dwc3
+              - qcom,ipq5332-dwc3
+    then:
+      properties:
+        clocks:
+          maxItems: 3
+        clock-names:
+          items:
+            - const: core
+            - const: sleep
+            - const: mock_utmi
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,ipq8064-dwc3
+    then:
+      properties:
+        clocks:
+          items:
+            - description: Master/Core clock, has to be >= 125 MHz
+                for SS operation and >= 60MHz for HS operation.
+        clock-names:
+          items:
+            - const: core
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,ipq9574-dwc3
+              - qcom,msm8953-dwc3
+              - qcom,msm8996-dwc3
+              - qcom,msm8998-dwc3
+              - qcom,qcs8300-dwc3
+              - qcom,sa8775p-dwc3
+              - qcom,sc7180-dwc3
+              - qcom,sc7280-dwc3
+              - qcom,sdm670-dwc3
+              - qcom,sdm845-dwc3
+              - qcom,sdx55-dwc3
+              - qcom,sdx65-dwc3
+              - qcom,sdx75-dwc3
+              - qcom,sm6350-dwc3
+    then:
+      properties:
+        clocks:
+          maxItems: 5
+        clock-names:
+          items:
+            - const: cfg_noc
+            - const: core
+            - const: iface
+            - const: sleep
+            - const: mock_utmi
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,ipq6018-dwc3
+    then:
+      properties:
+        clocks:
+          minItems: 3
+          maxItems: 4
+        clock-names:
+          oneOf:
+            - items:
+                - const: core
+                - const: sleep
+                - const: mock_utmi
+            - items:
+                - const: cfg_noc
+                - const: core
+                - const: sleep
+                - const: mock_utmi
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,ipq8074-dwc3
+              - qcom,qdu1000-dwc3
+    then:
+      properties:
+        clocks:
+          maxItems: 4
+        clock-names:
+          items:
+            - const: cfg_noc
+            - const: core
+            - const: sleep
+            - const: mock_utmi
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,ipq5018-dwc3
+              - qcom,msm8994-dwc3
+              - qcom,qcs404-dwc3
+    then:
+      properties:
+        clocks:
+          maxItems: 4
+        clock-names:
+          items:
+            - const: core
+            - const: iface
+            - const: sleep
+            - const: mock_utmi
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sc8280xp-dwc3
+              - qcom,sc8280xp-dwc3-mp
+              - qcom,x1e80100-dwc3
+              - qcom,x1e80100-dwc3-mp
+    then:
+      properties:
+        clocks:
+          maxItems: 9
+        clock-names:
+          items:
+            - const: cfg_noc
+            - const: core
+            - const: iface
+            - const: sleep
+            - const: mock_utmi
+            - const: noc_aggr
+            - const: noc_aggr_north
+            - const: noc_aggr_south
+            - const: noc_sys
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sdm660-dwc3
+    then:
+      properties:
+        clocks:
+          minItems: 4
+          maxItems: 5
+        clock-names:
+          oneOf:
+            - items:
+                - const: cfg_noc
+                - const: core
+                - const: iface
+                - const: sleep
+                - const: mock_utmi
+            - items:
+                - const: cfg_noc
+                - const: core
+                - const: sleep
+                - const: mock_utmi
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,qcm2290-dwc3
+              - qcom,qcs615-dwc3
+              - qcom,sar2130p-dwc3
+              - qcom,sc8180x-dwc3
+              - qcom,sc8180x-dwc3-mp
+              - qcom,sm6115-dwc3
+              - qcom,sm6125-dwc3
+              - qcom,sm8150-dwc3
+              - qcom,sm8250-dwc3
+              - qcom,sm8450-dwc3
+              - qcom,sm8550-dwc3
+              - qcom,sm8650-dwc3
+    then:
+      properties:
+        clocks:
+          minItems: 6
+        clock-names:
+          items:
+            - const: cfg_noc
+            - const: core
+            - const: iface
+            - const: sleep
+            - const: mock_utmi
+            - const: xo
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sm8350-dwc3
+    then:
+      properties:
+        clocks:
+          minItems: 5
+          maxItems: 6
+        clock-names:
+          minItems: 5
+          items:
+            - const: cfg_noc
+            - const: core
+            - const: iface
+            - const: sleep
+            - const: mock_utmi
+            - const: xo
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,ipq5018-dwc3
+              - qcom,ipq6018-dwc3
+              - qcom,ipq8074-dwc3
+              - qcom,msm8953-dwc3
+              - qcom,msm8998-dwc3
+    then:
+      properties:
+        interrupts:
+          minItems: 3
+          maxItems: 4
+        interrupt-names:
+          items:
+            - const: dwc_usb3
+            - const: pwr_event
+            - const: qusb2_phy
+            - const: ss_phy_irq
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,msm8996-dwc3
+              - qcom,qcs404-dwc3
+              - qcom,sdm660-dwc3
+              - qcom,sm6115-dwc3
+              - qcom,sm6125-dwc3
+    then:
+      properties:
+        interrupts:
+          minItems: 4
+          maxItems: 5
+        interrupt-names:
+          items:
+            - const: dwc_usb3
+            - const: pwr_event
+            - const: qusb2_phy
+            - const: hs_phy_irq
+            - const: ss_phy_irq
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,ipq5332-dwc3
+    then:
+      properties:
+        interrupts:
+          maxItems: 4
+        interrupt-names:
+          items:
+            - const: dwc_usb3
+            - const: pwr_event
+            - const: dp_hs_phy_irq
+            - const: dm_hs_phy_irq
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,x1e80100-dwc3
+    then:
+      properties:
+        interrupts:
+          maxItems: 5
+        interrupt-names:
+          items:
+            - const: dwc_usb3
+            - const: pwr_event
+            - const: dp_hs_phy_irq
+            - const: dm_hs_phy_irq
+            - const: ss_phy_irq
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,ipq4019-dwc3
+              - qcom,ipq8064-dwc3
+              - qcom,msm8994-dwc3
+              - qcom,qcs615-dwc3
+              - qcom,qcs8300-dwc3
+              - qcom,qdu1000-dwc3
+              - qcom,sa8775p-dwc3
+              - qcom,sc7180-dwc3
+              - qcom,sc7280-dwc3
+              - qcom,sc8180x-dwc3
+              - qcom,sc8280xp-dwc3
+              - qcom,sdm670-dwc3
+              - qcom,sdm845-dwc3
+              - qcom,sdx55-dwc3
+              - qcom,sdx65-dwc3
+              - qcom,sdx75-dwc3
+              - qcom,sm4250-dwc3
+              - qcom,sm6350-dwc3
+              - qcom,sm8150-dwc3
+              - qcom,sm8250-dwc3
+              - qcom,sm8350-dwc3
+              - qcom,sm8450-dwc3
+              - qcom,sm8550-dwc3
+              - qcom,sm8650-dwc3
+    then:
+      properties:
+        interrupts:
+          minItems: 5
+          maxItems: 6
+        interrupt-names:
+          items:
+            - const: dwc_usb3
+            - const: pwr_event
+            - const: hs_phy_irq
+            - const: dp_hs_phy_irq
+            - const: dm_hs_phy_irq
+            - const: ss_phy_irq
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sc8180x-dwc3-mp
+              - qcom,x1e80100-dwc3-mp
+    then:
+      properties:
+        interrupts:
+          minItems: 11
+          maxItems: 11
+        interrupt-names:
+          items:
+            - const: dwc_usb3
+            - const: pwr_event_1
+            - const: pwr_event_2
+            - const: hs_phy_1
+            - const: hs_phy_2
+            - const: dp_hs_phy_1
+            - const: dm_hs_phy_1
+            - const: dp_hs_phy_2
+            - const: dm_hs_phy_2
+            - const: ss_phy_1
+            - const: ss_phy_2
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sc8280xp-dwc3-mp
+    then:
+      properties:
+        interrupts:
+          minItems: 19
+          maxItems: 19
+        interrupt-names:
+          items:
+            - const: dwc_usb3
+            - const: pwr_event_1
+            - const: pwr_event_2
+            - const: pwr_event_3
+            - const: pwr_event_4
+            - const: hs_phy_1
+            - const: hs_phy_2
+            - const: hs_phy_3
+            - const: hs_phy_4
+            - const: dp_hs_phy_1
+            - const: dm_hs_phy_1
+            - const: dp_hs_phy_2
+            - const: dm_hs_phy_2
+            - const: dp_hs_phy_3
+            - const: dm_hs_phy_3
+            - const: dp_hs_phy_4
+            - const: dm_hs_phy_4
+            - const: ss_phy_1
+            - const: ss_phy_2
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-sdm845.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        usb@a600000 {
+            compatible = "qcom,sdm845-dwc3", "qcom,snps-dwc3";
+            reg = <0 0x0a600000 0 0x100000>;
+
+            clocks = <&gcc GCC_CFG_NOC_USB3_PRIM_AXI_CLK>,
+                     <&gcc GCC_USB30_PRIM_MASTER_CLK>,
+                     <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>,
+                     <&gcc GCC_USB30_PRIM_SLEEP_CLK>,
+                     <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>;
+            clock-names = "cfg_noc",
+                          "core",
+                          "iface",
+                          "sleep",
+                          "mock_utmi";
+
+            assigned-clocks = <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
+                          <&gcc GCC_USB30_PRIM_MASTER_CLK>;
+            assigned-clock-rates = <19200000>, <150000000>;
+
+            interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 489 IRQ_TYPE_EDGE_BOTH>,
+                         <GIC_SPI 488 IRQ_TYPE_EDGE_BOTH>,
+                         <GIC_SPI 486 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "dwc_usb3", "pwr_event", "hs_phy_irq",
+                          "dp_hs_phy_irq", "dm_hs_phy_irq", "ss_phy_irq";
+
+            power-domains = <&gcc USB30_PRIM_GDSC>;
+
+            resets = <&gcc GCC_USB30_PRIM_BCR>;
+
+            iommus = <&apps_smmu 0x740 0>;
+            snps,dis_u2_susphy_quirk;
+            snps,dis_enblslpm_quirk;
+            phys = <&usb_1_hsphy>, <&usb_1_ssphy>;
+            phy-names = "usb2-phy", "usb3-phy";
+        };
+    };
+...

-- 
2.45.2


