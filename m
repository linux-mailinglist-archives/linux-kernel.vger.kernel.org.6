Return-Path: <linux-kernel+bounces-564815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 469EFA65B47
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D79817D8EC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435591B042E;
	Mon, 17 Mar 2025 17:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PAPAce49"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018C71C8602
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 17:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742233494; cv=none; b=kVdz2HBL3whLjIb0tzB4jduDvyePkuXiSZFdKkhWwLj2EQEJ690hJFgF/T2Cq/YmY6v3in78eUfGlwiXP/05ABYlJJaJEs6CchKiOPoE54+1usy/YSMme/7O8quS03jpmtPBLHpi7frmM0qtVybL+A7djUYLO+9xW5mLAW6KRf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742233494; c=relaxed/simple;
	bh=rj/BQJOxWu1x2bPq88z2kFa6I0Eut5zPlFs23aO1bN8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tYp2XPwZesxomK5oBmIf4i8VariaA/NGOn3X6Z5dHkf1qGms9Ho1dw7XxTBnCXSD24MMIydVC3bGAGT6SkFQrqOLGSYw5vd3kCDqh984alXTD2+LY/6YYgwRTbPZsOpjJA6QyVU1wMNPnFVRPQmO/Pf+RmoWCntmFt1UevdoQs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PAPAce49; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52HANnr5008664
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 17:44:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gkl6eCmRuyDLWawoZFLZ9C1YgB9c1AFZt2R9KV8uAUk=; b=PAPAce49r6m/dx1o
	gOOuGj4sVr3R7poy0Oh8gllfRrNCw9k0EK0d9O0jPTx6opekgaE9U4n85FLkvWTF
	RFV+lznhDsUjOvelGP1CeyEbiC15GH7FCoqOvyPCbsqrx+hhgK0cbdAVNDFAzDFY
	olaXqNBcuWyFR1TYYEXYsypQhUeXfPebHOuN/UNCzUAy0wyoMFVhe7H756fxfRbk
	A6qi6SLdk9kWqS5qqIeGowTElQPWSZbVd2t1nHVqG9gkzEuA79QgMKOFx13prxqb
	GIyRC1JxIo4h37z8kGxmfTbgPfz8eD7HTY9z8097h1TGoLlPSKalV4BmMfCvxcYy
	HPBoEg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45d1tx5fat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 17:44:51 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4769a8d15afso97753921cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:44:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742233491; x=1742838291;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gkl6eCmRuyDLWawoZFLZ9C1YgB9c1AFZt2R9KV8uAUk=;
        b=l94iq+k02uUyjZPgnNj4lgkLP9rEejCLtAPf40y29GgivESXjSznvFsnHR164vbb02
         HAImUvIyQCuq36v3uItIhIHmJi4iLjY/oz/IxIBfmBfg4c4xWYWX8rPaYVJglrfdDTk/
         xkyPd/Td0bH1kujdHZGujWas2kWep97PzHlq2mYkYVCfk4suFSvhLqvd4A97MHVoMKFP
         LhmGm+IHI778cR0HKR44nFhJvTUoHb19S3zvbzORSy8b3w2/nb8UTwG8L8TfejL3rU1M
         lNBYuEwIMbWRDuMP1uKwNN4OsckGnC5MaEJt3jNV/hAKhNzOVW2cEcIq0Ez4qTSaosJ2
         ipgw==
X-Forwarded-Encrypted: i=1; AJvYcCW5OWx9QvJEgb8Cljw6uwUpMMeX6IzVI6Yji+2T1wwDBn6SBuv6ctuh92n8FGjKgnRpg7/CZWjMpHi6wDM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd1PWsyGWqAs7y2DTSA2w9OSP5y/yZ/yyEbbXMkC7dJIKgQx48
	mR3+F17Vnp+DS31nSW5ZqfEovntPPFMUzv6Uz4wI4S3Td1TTIo20QxwcVPczFMqgztYxCMoNqMz
	b3Gxj9TAOh0+kuUoO/8axfMzramNGWOdg+EDhY9bV6VB2ZGl4gB4O/yT7YxfD/bs=
X-Gm-Gg: ASbGnctp9YyNuv2Lna7BmZXu6yM7sbB8DT4HvJrzRNubKkXiHFcg/iuhaVk8iMctm1X
	QJJhxUT11XHlezR/Ar0xTdgNGNxU8bMDCkxoeAxl/wuDz6Y66dT8KlelkmjjUEE6Jy/vmK2X1V/
	KojK+2if17LRxPh0cwDTpcLa/g1quj1rjU1RYJ92qyjFVObhgjR0Zw/H3+YV4QN11dZPDVTie2g
	he1nNFqtr1rOfWgdkjKKPjKj/iaNyS2XZOPto4ko44xDaoecFcHk6j9LajOcJCjFRJSbKxlidD0
	88CP5EfNiu5Ugtcdo79z06geuD10zrvqZ40gGRS/8byZCqddfwlMWlvipSQDZemZOHAr6EB/Hbj
	HyrBY6KH4u1Pra6akFBcBpnW91IiD
X-Received: by 2002:a05:622a:4085:b0:476:7e6b:d297 with SMTP id d75a77b69052e-476fca3d2a2mr8052021cf.41.1742233490836;
        Mon, 17 Mar 2025 10:44:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtySEefB1iOeyT733dBNs8KEWKeAXOCDLMFnWYda2WB1QcKMY7zPQ3rW2qWeoF354/mVSvgA==
X-Received: by 2002:a05:622a:4085:b0:476:7e6b:d297 with SMTP id d75a77b69052e-476fca3d2a2mr8051571cf.41.1742233490507;
        Mon, 17 Mar 2025 10:44:50 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f0e9985sm16687121fa.29.2025.03.17.10.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 10:44:48 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 17 Mar 2025 19:44:37 +0200
Subject: [PATCH 2/9] dt-bindings: display/msm: describe SFPB device
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-fix-nexus-4-v1-2-655c52e2ad97@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1641;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=rj/BQJOxWu1x2bPq88z2kFa6I0Eut5zPlFs23aO1bN8=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBn2F+G9FSkklxSck1lzwxO6ehX+nVPI1iidJgA6
 N2c8I+iNHWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ9hfhgAKCRCLPIo+Aiko
 1UOGB/95qSO6E2NvcbCeLrIUgq6EANBxwKNBqmIXmTRZpZnEoOjlOZCYhFXYj1K0XPoozhl/FUR
 lWFwmc8hho8gsrf55Ye3kQvvKHx/3952yP2YjyeFPadbEPIiBHlNI8Bb5jB2w0U+p+U0PRtdR+h
 bn5/r+gCSYhjyNEgqdEirdooWPaKTlOMMJvOVl9DZ31hIYQOwB/XL6UQCUfSE5Wt8ubPOauWj0a
 vwDT9zwYZVym3kPkzCpAkd0TxC2DeL/2MZw1z/oE288vEvM4XR5eRTKpwJa6yPWCupFadzNWVLY
 l3ZUJEHsPJ+kvFImYOeywVGicR92vlMQHhy321qaRklhSjLm
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=W/I4VQWk c=1 sm=1 tr=0 ts=67d85f93 cx=c_pps a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=zTbJe62L20pqPav009EA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: 2_knsF_y20J6JqPoAtoh0jhGgdwfp7tN
X-Proofpoint-ORIG-GUID: 2_knsF_y20J6JqPoAtoh0jhGgdwfp7tN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_07,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 impostorscore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503170128

Add DT schema for the MultiMedia SubSystem System FPB device, which
provides several registers to control interface between multimedia
devices (primarily display) and system busses.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../devicetree/bindings/display/msm/qcom,sfpb.yaml | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sfpb.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sfpb.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..7ca105c97edd2f305527c58ae89b9b0cf22d3c8c
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sfpb.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/msm/qcom,sfpb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm MultiMedia SubSystem System FPB
+
+maintainers:
+  - Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
+  - Rob Clark <robdclark@gmail.com>
+
+description:
+  The SFPB provides several registers controlling the multimedia attachment to
+  the system busses.
+
+properties:
+  compatible:
+    items:
+      - const: qcom,apq8064-mmss-sfpb
+      - const: syscon
+
+  reg:
+    items:
+      - description: SFPB register block
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    syscon@5700000 {
+        compatible = "qcom,apq8064-mmss-sfpb", "syscon";
+        reg = <0x5700000 0x70>;
+    };
+...

-- 
2.39.5


