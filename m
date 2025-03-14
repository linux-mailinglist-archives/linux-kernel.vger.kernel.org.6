Return-Path: <linux-kernel+bounces-560731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5699A608D9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 07:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26A5117F8B8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 06:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987B414884C;
	Fri, 14 Mar 2025 06:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ht9t/N2v"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7218F15A850
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 06:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741932566; cv=none; b=snlBSaGZNrv8f+R4dXWim8OEGbnCHUxrNulQ8MsLfaB0lAh/YbY8PVmAC0h4hAl0h0m+Lr6NRmOjVuIP5ghRnFRIJtLK+53SKpnnM0uxLdIP/zjMwcd8+++9iDDMcz6NaR+l4i0JvY7WxNtPg2hXBJFWqtKEI2fkzfhI/2AI2fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741932566; c=relaxed/simple;
	bh=m+kBNHyiJhrtTwoJkF8m714SATfNjGL68rhyPmmLBbA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DuJPH8MD2ZGtzhjQVi+vTiZDhy2OgQr0Jln5JASJ7/x7YgI4Kq1L4QiFrSnTeMz2bZrtgOQO1ljcNSmO1R6XHGhHt/P7oi6n5rA6XuCf8ZwAzRyfHU0QpZvWEVBvbH013xbDiS3eP/yEt6u9ao0xuavDqFpM66ZcJSgczLffITY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ht9t/N2v; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DL6lax028128
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 06:09:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AGVPApRnv/m9P6KivA3acYjlWKhzKhS23njLJHpDY38=; b=ht9t/N2vrwazGsIO
	SKv/5nTOfmyws0IP+io2QjYroBsDjo1F0Dfj2S5JzCgK2FWGAWnkfUYxqkY7H6u1
	y6UbN/rZi3d0uZMAhkJ23Xbk1brUIGWYHxSII9JuhvDtR+sYN5ifQiv3rAwwh+TP
	8KtbRvxfzoIqPZn491kGZBOB/hm2azsimE6Vj2UGe5a2O67HEEPHJPlcil/wa5h7
	W3/PiooKTC0c/hPEeElYojWiJAoABEW1Rwj3nef1VFN5f7LLIatiHdzaN+4cTU27
	a1e1hgONAPyI1Olg3I/aQEWixy2w6RX4WBwo8lFZvlH2DsFOjXbrbGmPma8fi2mc
	NDfGkg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2q06hn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 06:09:24 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4768f9fea35so44593991cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 23:09:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741932563; x=1742537363;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AGVPApRnv/m9P6KivA3acYjlWKhzKhS23njLJHpDY38=;
        b=PKX0FpjCoEks4owOFx3/PAf3jwyfAOFBrbkx/pE3trft+xjs4mAFb/SAddGuMABc2y
         O+0jdZxTdXTT1Ep3Q57LH1wueEPJ3ThHzqeawP+9zL3qh7SzoHYI6NdVxosZR0gSYESN
         juGrBdPDRzEHRydcf2B82jKdfxzNiikyEMOysiE/Z+atAwdytiRccdSEMyYw7awpcnwn
         cB0fAAopfodlQAY1lUvhHEg9VgsjDDQALsg6CUulYWZuhZXlWZS2ILDuH+JNSY78An+G
         mT+l6tUf2mpYLtpohyob32CQFdBXJ8Hwcm+qWO8OktEos0vPy8canFPXW+757m6WWLgm
         erZA==
X-Forwarded-Encrypted: i=1; AJvYcCWGXyVg8voG/HCxDh3PGlAiN/wjOQdXfG9T1nIvig1CYVQRuoh3C13iQKGLRczRTZCTHa04Vc8wGylC9vs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaR6eLESrlc67FQmvpDamBuf62pNIEWeThEbl9mFp0Ed98wpiI
	TRIkVGjJJOr0OYwrvI+a2ghS2P64YHTSqdl2vKs6Ejs6HrxxQMwSg7yZudpiymSbz4v07ZREbfk
	AVs6YKADaMcBUFpp/kvq1PuwxeSbORX8dXjFAlrxvcQQUyQPklG45jvgiSYdtxZg=
X-Gm-Gg: ASbGnctaumOIK7CpJdWxC8B+VPA/f94xnr3LhctNIdY4a8Wk3/mHG28pP1AjaP/2/E4
	1AlPUQYXaIJ/bnEfpvW6On0YqPYMnqLVbuNtPFKLGqrv+u3Xvcqlcog4Zsb908G49xlaKPmarOH
	p1qO/PTyCL+KFvPqOAH6SCfLfNBzodEFlRcw6FGgbFkLYS5w3GMimxP+jJ9gpEwm7Ds2iJj5y9y
	d9HRhYmjexpFfPt7cR3NeK108yANXQA4KJBINFCZx30wDPbS1UGFrFnKd/qhIOVJ1iyj5CyRwkc
	KA90Uc/IGJmt7ZnSUQWWTS7u5+phm2ainIpfiIN2du8X7JLinB99YB2a97fc8UgDzugBtCws/n5
	iPMd51omEhT/n+aYLzP95pnUmEO1C
X-Received: by 2002:ac8:5fc1:0:b0:476:a03b:96e7 with SMTP id d75a77b69052e-476c81de5d5mr17607031cf.51.1741932563356;
        Thu, 13 Mar 2025 23:09:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+n1SUt3ZgWbjBVBsan3UxzAZliUmUbhM/LGRIG/kEjkmc4qgG0/uQ1PciTX5CcH0qlwakMQ==
X-Received: by 2002:ac8:5fc1:0:b0:476:a03b:96e7 with SMTP id d75a77b69052e-476c81de5d5mr17606821cf.51.1741932563035;
        Thu, 13 Mar 2025 23:09:23 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba864fc9sm416071e87.140.2025.03.13.23.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 23:09:21 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 14 Mar 2025 08:09:06 +0200
Subject: [PATCH v2 02/10] dt-bindings: display/msm: dsi-controller-main:
 describe SAR2130P
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-sar2130p-display-v2-2-31fa4502a850@oss.qualcomm.com>
References: <20250314-sar2130p-display-v2-0-31fa4502a850@oss.qualcomm.com>
In-Reply-To: <20250314-sar2130p-display-v2-0-31fa4502a850@oss.qualcomm.com>
To: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Bjorn Andersson <andersson@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1325;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=PNM3/R9939920NNRFa+kSPKtbONWgfGTtTNO9ijO+vE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBn08gGLHauS/kbPNT1IjIi4HWBO66PbJY3yYljy
 k7mnK8wyUqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ9PIBgAKCRCLPIo+Aiko
 1XCDB/9C9EqdRpyEiVH9DTNw4lOwlcIzfsKfOlndFaAglZwn453xFx3QqoOzkdMmXny2vZD3b7r
 2xJGe+JOVOfEL64u+8osiwklNvu7rg1wlUT1asglG63bGWZOzaSbG5LKmeNttnIZwfRf+vG47WR
 TEgrOvXAXW5x21m/qxkOJe8MLQViXZFZ79YhJ7SZdG0i3iw/Ax+4eS/fqMi5mx9iHzreSUgWBaO
 NX63a0+4pjs/VpcZ9qwG1LNmtUFJ3jtZEbqd2gBANpWKNjSAyQEhycrd+iQT0q5lw0/a6wPBDzq
 2fyMTWMyC9XItTvu11hl74MFrtsmDBOJNVFeJ+gvu0WfIeN3
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=P506hjAu c=1 sm=1 tr=0 ts=67d3c814 cx=c_pps a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=KKAkSRfTAAAA:8 a=93dKIss0COAcHyiF0SEA:9 a=QEXdDO2ut3YA:10 a=eRSyEd_ZPWdY3HzJaUvg:22
 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: TDR0oIEVo7mzZbVgsLEri-YeB0qwu6GR
X-Proofpoint-ORIG-GUID: TDR0oIEVo7mzZbVgsLEri-YeB0qwu6GR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_02,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxscore=0 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=863 lowpriorityscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503140047

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Describe MIPI DSI controller present on Qualcomm SAR2130P platform.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
index 2aab33cd0017cd4a0c915b7297bb3952e62561fa..a3e05e34bf14dd5802fc538ca8b69846384f8742 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
@@ -23,6 +23,7 @@ properties:
               - qcom,msm8996-dsi-ctrl
               - qcom,msm8998-dsi-ctrl
               - qcom,qcm2290-dsi-ctrl
+              - qcom,sar2130p-dsi-ctrl
               - qcom,sc7180-dsi-ctrl
               - qcom,sc7280-dsi-ctrl
               - qcom,sdm660-dsi-ctrl
@@ -314,6 +315,7 @@ allOf:
           contains:
             enum:
               - qcom,msm8998-dsi-ctrl
+              - qcom,sar2130p-dsi-ctrl
               - qcom,sc7180-dsi-ctrl
               - qcom,sc7280-dsi-ctrl
               - qcom,sdm845-dsi-ctrl

-- 
2.39.5


