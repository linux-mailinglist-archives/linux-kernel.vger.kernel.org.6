Return-Path: <linux-kernel+bounces-188283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2963D8CE004
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 05:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82B61B22B33
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 03:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BB03A1DC;
	Fri, 24 May 2024 03:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Nay1t1nv"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB3B39856;
	Fri, 24 May 2024 03:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716523001; cv=none; b=GhdfEcC5ExnRySrDpeqdXJIVWCEq5hNVur6UOlD9PcaQUpEIsQfZSMQUg3kRm2UKXt7wJylDjJTCOr2GB0TC+zp8NQDOaSPwwZPgdgzEm3uDq6tm5RPI+Bw3Pi6sVL2IB+a7KaSl/5rfLCQUxM6cQ/lSrpGDLu/5VKun/nku9e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716523001; c=relaxed/simple;
	bh=YB30c9j9nZ2DNLT/qxTyLM4z8aXnA/O5kc/gEoh1ISA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J7JRC7V8SeKNsSw2DCvOHWw2yXRkCW/dbVxMoP3r8fn2AGAeZqys+pEW8UpFxXREKjTPfmbaFZ5pLFgNch2OG2VCBGRhZZAczP12gO9BEfhiV7m39zVSadF6eLxVT4AbH/vONlK8ZXOWsrQTDmmY1CYbvyxsejkXNwx2RnRsWl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Nay1t1nv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44NNPD7a007621;
	Fri, 24 May 2024 03:56:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kuFj87uQ2GZUYPO9TpgRF7gxUCcV/IpcQsFMQyniBtI=; b=Nay1t1nv+l2AhfFg
	hDNODA2flMdCJBfzm+9okbwjjT5QscfTyS02XaCYczmlBQOi1tphU7e7U1wEjDa4
	uTPMDuk1NPQeNRNG9N7NR257QPR5GxpqIMcw6jtDtPXMdBAIosXdzTLunjBaXbAA
	Lf/LD99RRz4pmJhRARGG5KORTNaEgbTJdQpSvh42s2uGX40Ytn9Xja1Ze3e8drDn
	QkqIT4F8kYke5VmR7Hc+Hbd2aBFmNpDg7fRMpUAuWhgyI2NTqYoG9zAL/5LDnBVM
	urwEmyh57j21t1HDriuuofocL2tNpOZeKpGlkpvrZX4oyX2gsu8Y6aljOxJmi8Lb
	mxebOg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yaa9ts49k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 May 2024 03:56:27 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44O3uQNd007877
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 May 2024 03:56:26 GMT
Received: from hu-mohs-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 23 May 2024 20:56:21 -0700
From: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami
	<bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela
	<perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_rohkumar@quicinc.com>,
        <quic_pkumpatl@quicinc.com>,
        Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Subject: [PATCH v5 1/7] ASoC: dt-bindings: document wcd937x Audio Codec
Date: Fri, 24 May 2024 09:25:29 +0530
Message-ID: <20240524035535.3119208-2-quic_mohs@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240524035535.3119208-1-quic_mohs@quicinc.com>
References: <20240524035535.3119208-1-quic_mohs@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hR8EzQVQBJh93z_KRM9nWvdnfslYc2mx
X-Proofpoint-ORIG-GUID: hR8EzQVQBJh93z_KRM9nWvdnfslYc2mx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_15,2024-05-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 adultscore=0 suspectscore=0 phishscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405240026

From: Prasad Kumpatla <quic_pkumpatl@quicinc.com>

Document the Qualcomm WCD9370/WCD9375 Audio Codec and the
Soundwire devices than can be found on Qualcomm QCM6490 based platforms.

The Qualcomm WCD9370/WCD9375 Audio Codec communicates
with the host SoC over 2 Soundwire links to provide:
- 3 TX ADC paths with 4 differential AMIC inputs
- 6 DMIC inputs that are shared with AMIC input
- 4 Microphone BIAS
- RX paths with 4 PAs – HPHL/R, EAR and AUX
- Stereo Headphone output
- MBHC engine for Headset Detection

Signed-off-by: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
Co-developed-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
---
 .../bindings/sound/qcom,wcd937x-sdw.yaml      | 91 +++++++++++++++++++
 .../bindings/sound/qcom,wcd937x.yaml          | 82 +++++++++++++++++
 2 files changed, 173 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd937x-sdw.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd937x.yaml

diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd937x-sdw.yaml b/Documentation/devicetree/bindings/sound/qcom,wcd937x-sdw.yaml
new file mode 100644
index 000000000000..d3cf8f59cb23
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,wcd937x-sdw.yaml
@@ -0,0 +1,91 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/qcom,wcd937x-sdw.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SoundWire Slave devices on WCD9370/WCD9375
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+description: |
+  Qualcomm WCD9370/WCD9375 Codec is a standalone Hi-Fi audio codec IC.
+  It has RX and TX Soundwire slave devices. This bindings is for the
+  slave devices.
+
+properties:
+  compatible:
+    const: sdw20217010a00
+
+  reg:
+    maxItems: 1
+
+  qcom,tx-port-mapping:
+    description: |
+      Specifies static port mapping between device and host tx ports.
+      In the order of the device port index which are adc1_port, adc23_port,
+      dmic03_mbhc_port, dmic46_port.
+      Supports maximum 4 tx soundwire ports.
+
+      WCD9370 TX Port 1 (ADC1)               <=> SWR2 Port 2
+      WCD9370 TX Port 2 (ADC2, 3)            <=> SWR2 Port 2
+      WCD9370 TX Port 3 (DMIC0,1,2,3 & MBHC) <=> SWR2 Port 3
+      WCD9370 TX Port 4 (DMIC4,5,6,7)        <=> SWR2 Port 4
+
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 4
+    maxItems: 4
+    items:
+      enum: [1, 2, 3, 4]
+
+  qcom,rx-port-mapping:
+    description: |
+      Specifies static port mapping between device and host rx ports.
+      In the order of device port index which are hph_port, clsh_port,
+      comp_port, lo_port, dsd port.
+      Supports maximum 5 rx soundwire ports.
+
+      WCD9370 RX Port 1 (HPH_L/R)       <==>    SWR1 Port 1 (HPH_L/R)
+      WCD9370 RX Port 2 (CLSH)          <==>    SWR1 Port 2 (CLSH)
+      WCD9370 RX Port 3 (COMP_L/R)      <==>    SWR1 Port 3 (COMP_L/R)
+      WCD9370 RX Port 4 (LO)            <==>    SWR1 Port 4 (LO)
+      WCD9370 RX Port 5 (DSD_L/R)       <==>    SWR1 Port 5 (DSD)
+
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 5
+    maxItems: 5
+    items:
+      enum: [1, 2, 3, 4, 5]
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    soundwire@3210000 {
+        reg = <0x03210000 0x2000>;
+        #address-cells = <2>;
+        #size-cells = <0>;
+        wcd937x_rx: codec@0,4 {
+            compatible = "sdw20217010a00";
+            reg = <0 4>;
+            qcom,rx-port-mapping = <1 2 3 4 5>;
+        };
+    };
+
+    soundwire@3230000 {
+        reg = <0x03230000 0x2000>;
+        #address-cells = <2>;
+        #size-cells = <0>;
+        wcd937x_tx: codec@0,3 {
+            compatible = "sdw20217010a00";
+            reg = <0 3>;
+            qcom,tx-port-mapping = <2 2 3 4>;
+        };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd937x.yaml b/Documentation/devicetree/bindings/sound/qcom,wcd937x.yaml
new file mode 100644
index 000000000000..de397d879acc
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,wcd937x.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/qcom,wcd937x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm WCD9370/WCD9375 Audio Codec
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+description:
+  Qualcomm WCD9370/WCD9375 Codec is a standalone Hi-Fi audio codec IC.
+  It has RX and TX Soundwire slave devices.
+
+allOf:
+  - $ref: dai-common.yaml#
+  - $ref: qcom,wcd93xx-common.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - const: qcom,wcd9370-codec
+      - items:
+          - const: qcom,wcd9375-codec
+          - const: qcom,wcd9370-codec
+
+  vdd-px-supply:
+    description: A reference to the 1.8V I/O supply
+
+required:
+  - compatible
+  - vdd-px-supply
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    codec {
+        compatible = "qcom,wcd9370-codec";
+        pinctrl-names = "default", "sleep";
+        pinctrl-0 = <&wcd_reset_n>;
+        pinctrl-1 = <&wcd_reset_n_sleep>;
+        reset-gpios = <&tlmm 83 GPIO_ACTIVE_HIGH>;
+        vdd-buck-supply = <&vreg_l17b_1p8>;
+        vdd-rxtx-supply = <&vreg_l18b_1p8>;
+        vdd-px-supply = <&vreg_l18b_1p8>;
+        vdd-mic-bias-supply = <&vreg_bob>;
+        qcom,micbias1-microvolt = <1800000>;
+        qcom,micbias2-microvolt = <1800000>;
+        qcom,micbias3-microvolt = <1800000>;
+        qcom,micbias4-microvolt = <1800000>;
+        qcom,rx-device = <&wcd937x_rx>;
+        qcom,tx-device = <&wcd937x_tx>;
+        #sound-dai-cells = <1>;
+    };
+
+    /* ... */
+
+    soundwire@3210000 {
+        reg = <0x03210000 0x2000>;
+        #address-cells = <2>;
+        #size-cells = <0>;
+        wcd937x_rx: codec@0,4 {
+            compatible = "sdw20217010a00";
+            reg = <0 4>;
+            qcom,rx-port-mapping = <1 2 3 4 5>;
+        };
+    };
+
+    soundwire@3230000 {
+        reg = <0x03230000 0x2000>;
+        #address-cells = <2>;
+        #size-cells = <0>;
+        wcd937x_tx: codec@0,3 {
+            compatible = "sdw20217010a00";
+            reg = <0 3>;
+            qcom,tx-port-mapping = <1 2 3 4>;
+        };
+    };
+...
-- 
2.25.1


