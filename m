Return-Path: <linux-kernel+bounces-560732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A72A608DD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 07:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 220CF3BCA2E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 06:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B77F1632E4;
	Fri, 14 Mar 2025 06:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g1kMUQdc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1357D1624FC
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 06:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741932570; cv=none; b=iHyV8ukEHIXIizIXrQ0C5iijo78wIe9Oh3MGObnLAMiyXcZjOa1dSfWQymLXxYe4Ex1VF6z1cuReIwhCcK7WTkpCJeRfIRK5DXYh3g/IPZWQJrPzIvDn2OJaU7Rotr1WqWkaZ9vDNCIytLyeQqBDw67q/u26QFJE7PQAzcS0XGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741932570; c=relaxed/simple;
	bh=fR3qQKGpGRxj1T6vPpbffnYHS20YwtNTdXiSdKBpWug=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=es9JJjo+t0twrmO9gnvqRCRiTTNFwGrSckJGQp/snn1iNYmuaPkEIUJVm5TORiqn1ggdnHV/6VW4BuxV6F//VhL+4oiThGuWT38ma8pCujNhdMB8f8Oc3TJH2hfmAEBclxdsUcUv/xzAlvS0ihnASGtqHrxNE+sMPFTDXqHXG8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g1kMUQdc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DKD2Wm027243
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 06:09:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BAFb1O+Dpw71ujShOY3u1RWTe/53Rsuu84mfXeGabe0=; b=g1kMUQdcqMAybrFS
	15GvE6JaxHBE5W65B5Fv8RhwbVVBdkNQmpiUAKlEuLQ24c37qZKaxW6tsMf9JEbn
	bGaD9RfgzU3SKXA0YwEVk6AwXWPcN9v4LFTKelQ0b5GGwBx7JP5mt1PUAopkGbr+
	DkyKUTLcOvO/2WzcUwuJY9PbgWHIQeuD+ZI1F8RZhwF+Jd76frO0vWlfw9iJvmB4
	ktRIPr3faHxl9/9Ih+q8BdtwBFDcv0PmL11jsp7+Pf0rZiYIZuWXSRxO123R9/is
	YE1xciPaY2Se+6Pu5BdSEarjTsjHg2vwAeQci8tIxOvvUkCFJ6ANvApyRf/ryzBN
	mCHTQg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45c67314qe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 06:09:28 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e6bb677312so27387686d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 23:09:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741932567; x=1742537367;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BAFb1O+Dpw71ujShOY3u1RWTe/53Rsuu84mfXeGabe0=;
        b=oC4z+nzYWJgF32qKwUBgSc5UVAzO7Y7MMkSyVNg5bPvD9vLDjJVhCgmKmy+9SozYlf
         nvgJV8+6MOBXjKyv/3Ym5+eYo5YQx2TH4vjmtqSohwpisAiUfd/wprJ5L0BGoWoZN9X3
         y25q6LnvQcD6izYdtqztYYa/tyjW25pddR7+4E4F8Wt5qPLJ2/1BYdsEDa4SiyHVuKpF
         MKHXYQlLg3Mso8XRfZf03UO4NYS6Pd5zri8qjr+Wgb2EvrhnyTGZo6LmAhO4KlswQkpT
         5sVGX63MSVALl9VYCaKf14LLkkXhF+c+3ydHcaZdxY+e+vZsvHJe2gVxbf5Zqaaqz7yo
         DV5g==
X-Forwarded-Encrypted: i=1; AJvYcCVldDeFan2mt0n0OnZSi3Vu3V9PmaOuzrWkK9l6oin4bLqmIMebx7l/2mQmMqpuIqYCDeir9fptIHLyW7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAbLWRZCL8Kcu9nVAU74R+dHQSWflcZifUSwKRwYML9Ikber2b
	4DNZIB7F2AaEF+6VvSZ/Q/PoBJYoB+OM1As8g2OSEzFxzr+2P4MTfwPGh1cGBe7qcE5jNoVEmdG
	EolwkiAMmwjgwspOUifkzEWMoG9r4I+GEgclFqNXcq7bBKEWirbtzn8EdfmiFkkI=
X-Gm-Gg: ASbGncvmUY4JuBBbhwBSew0uza7l1fyIqqhroYZ8CTN6baAukrFjO0npE+j3DHZZ/BG
	VpDGUmeZiLr8heMI1BGKkDGK0c4EfK1paVOq7U76saCs+ZMBhgMUNbQkcsXOYKkJ3B1PTkw5qT8
	TluF7RwUa1a2MoDdglrpW4nO0nLB8wz9JHlUdMOiSDjDGTFZR7KwV3okk2w7D8BPlClnLeG0cUZ
	ZUkJ/Ldqyn6KZ2AtqtZjjeeKBTwMUAcYug9oNcjUDomF22S/uUa2Fc13GAmJMSv1eCqOHTtVn7o
	6C7cWUpSbxqFKSWb4IWJEaKKWlerTrHZ9K6JRDfXXk66pusL4F5IHffzEbnsYrBNFTQG8iufICH
	JcQBYSUEeifTy99h7+nG8pL8mifhm
X-Received: by 2002:a05:6214:1d04:b0:6e8:fb94:b9bf with SMTP id 6a1803df08f44-6eaea9ee3femr18760696d6.4.1741932567080;
        Thu, 13 Mar 2025 23:09:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcEa9Bc266rkd2ufdSrH8URTSt0lvVJ8rYD1A4CatJi7rKwY9bNrmzWb340X/FvEigsaAADQ==
X-Received: by 2002:a05:6214:1d04:b0:6e8:fb94:b9bf with SMTP id 6a1803df08f44-6eaea9ee3femr18760376d6.4.1741932566765;
        Thu, 13 Mar 2025 23:09:26 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba864fc9sm416071e87.140.2025.03.13.23.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 23:09:24 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 14 Mar 2025 08:09:07 +0200
Subject: [PATCH v2 03/10] dt-bindings: display/msm: dsi-phy-7nm: describe
 SAR2130P
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-sar2130p-display-v2-3-31fa4502a850@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=939;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=azlck2n2u+qrgsVJ0BAEOEuqH2At8nKdcftYTsEljlc=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ/rlE2xpFfY7J55afOHaOk75u4wJM7Vmfn2Tzptv+fXHQ
 e5PC/cs6mQ0ZmFg5GKQFVNk8SlomRqzKTnsw46p9TCDWJlApjBwcQrARISl2f/HFLg9zFjh9/3j
 l6lpXunJ9YFcvwUSXKYlFYuXsrTG+vlEyUm6Ho8P/6xrJd5etletKXnebQ/2hWuCDO9N3GLf/fm
 p9Qvuuev1TX0mnuh/MCdlPnu8Kv+WzVcyHpdm6Iny/77XzzejZf20Xln29ccdPS402nXsEPseeU
 ioYH5945MF3DyXp8nL28k9n7SrdqJMv7NU+dLbFe8mWQfKVfwsUzox0X7R2RzmpZJvDi6x+8+co
 Onq8kCA8Yvr75cl/9iMSjoc2Dev3+HHdELR4DZzuOJkrpBb4Z/ZWerY13SqXyv/YpPxoo6V0aGA
 zeecwgLeSNV/xR/1PKw4VsbXSp/n7jef3sIgVrhPp/YpAA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=a5Iw9VSF c=1 sm=1 tr=0 ts=67d3c818 cx=c_pps a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=KKAkSRfTAAAA:8 a=5g6dqdCWcepBQtZB-T0A:9 a=QEXdDO2ut3YA:10 a=eRSyEd_ZPWdY3HzJaUvg:22
 a=iYH6xdkBrDN1Jqds4HTS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: -vqtkH2Zx5sR_hX_FADSWr97q53FO-XH
X-Proofpoint-ORIG-GUID: -vqtkH2Zx5sR_hX_FADSWr97q53FO-XH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_02,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=923
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503140047

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Describe MIPI DSI PHY present on Qualcomm SAR2130P platform.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml b/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml
index 321470435e654f1d569fc54f6a810e3f70fb168c..f79be422b8892484216b407f7385789764c2de1b 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml
@@ -17,6 +17,7 @@ properties:
     enum:
       - qcom,dsi-phy-7nm
       - qcom,dsi-phy-7nm-8150
+      - qcom,sar2130p-dsi-phy-5nm
       - qcom,sc7280-dsi-phy-7nm
       - qcom,sm6375-dsi-phy-7nm
       - qcom,sm8350-dsi-phy-5nm

-- 
2.39.5


