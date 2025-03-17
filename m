Return-Path: <linux-kernel+bounces-564816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC99EA65B48
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E9D91895F53
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9F91DDA2D;
	Mon, 17 Mar 2025 17:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SfmNeVzL"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF231D63CD
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 17:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742233498; cv=none; b=HcHLK56QAtL2j8HGi68yB3vRisUdyr0ePSG77Xx757q40ggR5Fq4k0vNKWqgOpUOGkWcBzawgRghK7TWjRvDU4hLHPw4OO8FDYq20nNXPU5peB8LlV5GPaHMGx5lXcnqG3NYQMtk8afJzGuGe3y/tzsPzvZA2pcE3UVhNzG4lZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742233498; c=relaxed/simple;
	bh=GGq/9ihy3yPuzqQSqDIFv8MiEa9/Oun5e7X6iSFdWZM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h5SCYzIDtzNqB1Gv7Rm5EjRLGSBDt3KIcbww040V/EnFeWvjbBHv+PPsPuLCU2l1YCuds0HOdRF7ARgT436wmPFdLmQ07CeqfXZ+0qHEFZKdXobcle+xeZq07DCEqkDFie242E1z3v+4cozfAqCF+ksGDfVrUiVqlQ7PbDQl1Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SfmNeVzL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52HAniEt000505
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 17:44:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GFn8jUQoU8QET0Q7Y2/H3zZJ8p6JHV7h1jOFwob8Aj4=; b=SfmNeVzLG4UDcuTC
	nRUsPCZJizAmFUG4D3puygisgNUP7p+B0pUrfLWbbfX8W9FdMbKA/cCciKm3WBle
	CJuqXf1wIP3+WLN5/lnAUVIih/QlCi99dXi05yceVM5waPktSUMfHQkNK/0CFdJR
	pshSteSDeh2HKpulRqtO15hcVejDj8+XwjEbRNZP/4pMEYcteOFrCTugS374Dd4h
	F/oHVMROom/3bqv72e1DzLwSZ69yFNRcFfJ6GLxhbnXEodRw76Y+N8CrLgiSGwGU
	VvA/49d1rumsOqdw+wdgIenthSV4T6rnXjRB8FW8WT5zAkaXoeKpXwxEUZ+AEHtr
	1B3S+Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45d1sxwg5v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 17:44:55 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4767348e239so101482281cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:44:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742233494; x=1742838294;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GFn8jUQoU8QET0Q7Y2/H3zZJ8p6JHV7h1jOFwob8Aj4=;
        b=vWdMnlGPJs6eL+T6Eg5Yag23A0Rk947VLhX12DjoCTeEIF7ZyVJfrX6a/Wqc+01AMt
         Srn9rh8rehmZ97P7tSA0rbIuuKtnSVjmjOlW2Q4AWOY3ItVhDRm3yTmXM+DYp9h16xTN
         jUIrAm1vV3zL4fhPafgA5Rre+B+tULpi+wJkcCuewLHNTicYV3S/bTtBcW7H3MQlrhP8
         BwNIoXXfKOihl1V/qddyFB+ekHb6ok91EloWBTWAfWNq523qGxXSNmXHpASNfgZ+vztC
         aeGaOGkvRp8grmqCXl3xpGtdjRS7jkYPSfaoSYk6ufJqFKBsDgyqxKZUwV/XYMN+sJHz
         aq4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUmV8qlOqjNs+lnO6bfQFTlGjWr/0kPGrr8S4SS9fFbiyNiurhVGMR/uiLuVXEq5e0Na2jTJW1Q1U6NmU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeER76zLd1I+AIbwDDRGDqt43SYpoQ7k3bI31KfwR+VcB+cIMN
	Wk0HTcFsqqEeS5DevIzhD3z0Sr4dVowURomkRYiAsuqYXXhB3fdYhA50Ur6XOh8izP5J41M/062
	YoAZ9EALHUKnkL4Kmspbg6YVHl5kkSIXCWXkRm2CIstG9DkdrOD8ri+JdfqfgyQU=
X-Gm-Gg: ASbGncsaqFgWh+bFtXt2XK88Ogc1qDWKeTngMUI4xQ2IsnymKllXtB5pRzR+GIsb307
	THbrPwGdHBFimhteFIe/pUjng4YYbecWLEWiZYxsoSJleyX2rxRdoopQnR1yms+Smzda6VxX5MD
	LcwMEQRmvSQPiUigOwd92lfK0N/9Bd4JN3YY9x6UZIKgiQZF85aEKFxbd15FVbFsJQroILIdwH/
	Dh6RMdknYsxluBbrHxdyWK4D4xc+KvIMLADXr1uR1dw1aNOAehMDfPhFLDIvOqsQLXd8EBCzU0+
	gDXUKy/uD8XmUdu0rpSVK49hBRPKCap6Q5eXm0eZ0fedQcNELgC3uJ2ZrzWHoRaLO1Hjle1A3a9
	hFjIiLE93WYRYbx8nUXrRe+0+/EXM
X-Received: by 2002:a05:622a:114b:b0:476:6215:eafc with SMTP id d75a77b69052e-476fc99009fmr8243191cf.22.1742233494502;
        Mon, 17 Mar 2025 10:44:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFx2iqeGGhoECD06EGgynljrm1UFU3tlDa0Y7tDDJEaoK3LeQgEoilub/oM8WSkmjHqhW0GDg==
X-Received: by 2002:a05:622a:114b:b0:476:6215:eafc with SMTP id d75a77b69052e-476fc99009fmr8242831cf.22.1742233494160;
        Mon, 17 Mar 2025 10:44:54 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f0e9985sm16687121fa.29.2025.03.17.10.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 10:44:52 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 17 Mar 2025 19:44:38 +0200
Subject: [PATCH 3/9] dt-bindings: soc: qcom: add Smart Peripheral System
 Interrupt Controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-fix-nexus-4-v1-3-655c52e2ad97@oss.qualcomm.com>
References: <20250317-fix-nexus-4-v1-0-655c52e2ad97@oss.qualcomm.com>
In-Reply-To: <20250317-fix-nexus-4-v1-0-655c52e2ad97@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linux.dev>, Kumar Gala <galak@codeaurora.org>,
        Andy Gross <agross@codeaurora.org>,
        "Ivan T. Ivanov" <ivan.ivanov@linaro.org>,
        Andy Gross <andy.gross@linaro.org>, Georgi Djakov <djakov@kernel.org>,
        David Heidelberg <david@ixit.cz>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1553;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=GGq/9ihy3yPuzqQSqDIFv8MiEa9/Oun5e7X6iSFdWZM=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBn2F+GFIxO2iAYR/ha0nJwD2Eg1yX3HfVf70gE9
 iv5i7HiwYyJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ9hfhgAKCRCLPIo+Aiko
 1S3ZCACUOskqPOEvLD+01HgOWPYEMTBKeOD3R8D5mw/V1g4VsuJsnarn4H9Wn4AS5RFONL1lwek
 ArrfaM0aKFgphWcaMu0v+84IJxdrqpynpdcxZDrDeUletCeEgDgh3Jqw/IHoqKqTzcksEsnwlgQ
 Kl5BGF4KL5oypxeoqSomLu+wfO+5Bihbdp5YygDCa6keiQ8FQr8sep9fQRASPw2SGtM9cMbUDV/
 3rRhy+mv6Lp0znl4g6MlbyFhDy0YcCxyCVXD4dqumtoX7Ck5anXlMjCnyNQRCa3nqltK16L3GHg
 2sUeDfKK1geSSi38zzbQA3vQseK4c9ri/3i6FkMudcyxOdvx
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: 5vAnKZue9M00TN3IwKlVXMEUNMBZJUqX
X-Proofpoint-ORIG-GUID: 5vAnKZue9M00TN3IwKlVXMEUNMBZJUqX
X-Authority-Analysis: v=2.4 cv=XKcwSRhE c=1 sm=1 tr=0 ts=67d85f97 cx=c_pps a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=pxxQaWppw0d4f0HdsPoA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_07,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1015 phishscore=0
 impostorscore=0 adultscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 spamscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503170128

Add schema to properly describe the SPS SIC block present on APQ8064 and
several similar platforms.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../devicetree/bindings/soc/qcom/qcom,sps-sic.yaml | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,sps-sic.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,sps-sic.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..ccacf6f45955177dd9302107e09897bfa2f1fd78
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,sps-sic.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/qcom/qcom,sps-sic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Smart Peripheral System Interrupt Controller
+
+maintainers:
+  - Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
+  - Bjorn Andersson <andersson@kernel.org>
+
+description:
+  Smart Peripheral System (SPS) Interrupt Controller (SIC)
+
+properties:
+  compatible:
+    items:
+      - const: qcom,apq8064-sps-sic
+      - const: syscon
+
+  reg:
+    items:
+      - description: SPS SIC register block
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    interrupt-controller@12100000 {
+        compatible = "qcom,apq8064-sps-sic", "syscon";
+        reg = <0x12100000 0x10000>;
+    };
+...

-- 
2.39.5


