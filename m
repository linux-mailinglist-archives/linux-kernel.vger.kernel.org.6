Return-Path: <linux-kernel+bounces-447198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C47669F2ECE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00111165330
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 11:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CEF204566;
	Mon, 16 Dec 2024 11:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EBPASI8/"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0444203D7A;
	Mon, 16 Dec 2024 11:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734347059; cv=none; b=J6IJDzKdi8TmL7FgU/We/DvMaX2eHihTO6/ruYKuDtIDIAAyTj3vS1WxTxIJMQyb9fa6W3M8649Dr/oAUFThkO/k1Hzs3Qmf0DrizK8OZsnoFEHLY4roV6aCzZ2IrhSr7ynSfIL/wSiJMoo4tfHCFpVpyEdtoH1o9WhZTsUuf4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734347059; c=relaxed/simple;
	bh=O5tvJjzwpXEbc1L9F89eUbm7qHfZbrgZq+jNEg9s7Sg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ovQNt9TTEqYVNrsU9briu1XmnvUZPdMQQg2FHVo5VSck5ZX5FOLSnaO7ZAnMXdwc7W0vovtxSLJy29tem1L740BTXOW7Ff8HsNx3fP1LAqP486nsE9VCk6EbD3ticBf/tlt3kF8Zx3kRYq5sU9w/OcqsUNbgFGjiGr0sMqiuemo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EBPASI8/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG8V7Nx023533;
	Mon, 16 Dec 2024 11:04:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:date:from:in-reply-to:message-id:references:subject:to; s=
	qcppdkim1; bh=mx5BZi4mi+n3KbU4u7wvp/XoKJISRhtinLOb3YVHni0=; b=EB
	PASI8/wcimLo86k5QX9TdQOdicXozBvwEcsAy3ncElD3On6+h7XqXTF0CYJLD4+m
	qZSc1rOoPmwVKLU6FeVmUnrteFseXmgXpbGxa/W6jPN4UsEgaldjKbTFtGJb55vs
	wSkXuQJOgIorQdPde5tqLo50hRvUC50GlXiLZwt7GjFFaPhhZ/z8Oh3eUP9xHSaE
	FsF1SlN+2dF59iE3aHVyKjH/qkQoOShzhNAd59wKi3xxJpP+bHusGbz+MpOZ2Niw
	Unnan/m4x5Hh2HrIJ4SubcLoJQ/aVBEya6A4ugal/8KFYBtmBh+hEIWEaMaF4SGG
	OFFfOlUJJk3AV1chqwWQ==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43jgrr8dpe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 11:04:04 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGB419W011377;
	Mon, 16 Dec 2024 11:04:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 43h33kna30-1;
	Mon, 16 Dec 2024 11:04:01 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4BGB41XA011358;
	Mon, 16 Dec 2024 11:04:01 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-pkumpatl-hyd.qualcomm.com [10.213.109.81])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 4BGB41sJ011355;
	Mon, 16 Dec 2024 11:04:01 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 3914174)
	id A27B65000AD; Mon, 16 Dec 2024 16:34:00 +0530 (+0530)
From: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
To: Fabio Estevam <festevam@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_mohsquicinc.com@qualcomm.com,
        kernel@quicinc.com, Prasad Kumpatla <quic_pkumpatl@quicinc.com>
Subject: [PATCH v1 1/2] ASoC: dt-bindings: Add support for master clock frequency
Date: Mon, 16 Dec 2024 16:33:40 +0530
Message-Id: <20241216110341.3707-2-quic_pkumpatl@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241216110341.3707-1-quic_pkumpatl@quicinc.com>
References: <20241216110341.3707-1-quic_pkumpatl@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: PtrvrEhidO9E561uj1OuwzGwsn6jyy9Q
X-Proofpoint-GUID: PtrvrEhidO9E561uj1OuwzGwsn6jyy9Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 adultscore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412160093
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Introduce a property specifies the frequency of the master clock
provided to the codec slave. The slave has the capability to adjust
the frequency according to user needs in the defined range.

Also fixed yamllint check errors.

Signed-off-by: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
---
 .../devicetree/bindings/sound/fsl,sgtl5000.yaml | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl,sgtl5000.yaml b/Documentation/devicetree/bindings/sound/fsl,sgtl5000.yaml
index c6ab1ca16763..2512cad10961 100644
--- a/Documentation/devicetree/bindings/sound/fsl,sgtl5000.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,sgtl5000.yaml
@@ -44,14 +44,14 @@ properties:
       values of 2k, 4k or 8k. If set to 0 it will be off. If this node is not
       mentioned or if the value is unknown, then micbias resistor is set to
       4k.
-    enum: [ 0, 2, 4, 8 ]
+    enum: [0, 2, 4, 8]
 
   micbias-voltage-m-volts:
     description: The bias voltage to be used in mVolts. The voltage can take
       values from 1.25V to 3V by 250mV steps. If this node is not mentioned
       or the value is unknown, then the value is set to 1.25V.
     $ref: /schemas/types.yaml#/definitions/uint32
-    enum: [ 1250, 1500, 1750, 2000, 2250, 2500, 2750, 3000 ]
+    enum: [1250, 1500, 1750, 2000, 2250, 2500, 2750, 3000]
 
   lrclk-strength:
     description: |
@@ -64,7 +64,7 @@ properties:
         2 =		3.33 mA		5.74 mA		8.03  mA
         3 =		4.99 mA		8.61 mA		12.05 mA
     $ref: /schemas/types.yaml#/definitions/uint32
-    enum: [ 0, 1, 2, 3 ]
+    enum: [0, 1, 2, 3]
 
   sclk-strength:
     description: |
@@ -77,12 +77,20 @@ properties:
         2 =		3.33 mA		5.74 mA		8.03  mA
         3 =		4.99 mA		8.61 mA		12.05 mA
     $ref: /schemas/types.yaml#/definitions/uint32
-    enum: [ 0, 1, 2, 3 ]
+    enum: [0, 1, 2, 3]
 
   port:
     $ref: audio-graph-port.yaml#
     unevaluatedProperties: false
 
+  mclk-rate:
+    description: |
+      Master clock rate in Hz. This property specifies the frequency
+      of the master clock provided to the codec slave.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 8000000
+    maximum: 27000000
+
 required:
   - compatible
   - reg
@@ -108,6 +116,7 @@ examples:
             micbias-voltage-m-volts = <2250>;
             VDDA-supply = <&reg_3p3v>;
             VDDIO-supply = <&reg_3p3v>;
+            mclk-rate = <12288000>;
         };
     };
 ...
-- 
2.17.1


