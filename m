Return-Path: <linux-kernel+bounces-566213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF73A674FF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 605E48814FA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F55820E70B;
	Tue, 18 Mar 2025 13:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EIt/uQwp"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4369B20E318
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 13:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742304139; cv=none; b=l3uDIXHBEAJ68NQH3qJRR0mRRgCpX3DX1qexzVxds4v+O84nx5DcDcOgyVuUS8Huurs5NqEIXWGUHtpxw/axhqEIrucxL4JZu9LB5RP+0y5cpgl/aGsGwQ3aclonaEQaTT8s8n7BhVCSPGu7NjNrek4+mG9CLQGF3KA5FN/PW8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742304139; c=relaxed/simple;
	bh=A5b+7PiOzdnEsoIXhJtEDtIF4/+zzwMq2jbAcRXdx6A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QqqyWbJYsNNjktJbOO4rCBij0xuwkO5/BYbfngtW5ETMyMmoirc0OTZrVygH0WIvC8G0zlsRVijoxDhk+GMQVP4YFfdUsDO6AM3zw8awICCrxOXZzMHVQHnG1ADCag/SVS0wT98rn5BpSZcXJk4NOkj32Cax830yn49kjfsXMgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EIt/uQwp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52ICeFbT030598
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 13:22:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	90Qa8a9JOpfX6xK3iRiQYBwU2Lz8sFA7p1khs43FFPw=; b=EIt/uQwplWImJTR8
	9zCTrhS/qn82m3ayFhZvwjwBOyGJllUs94349vVEZZ4WpiezGeTrlxwrgEhlUPI3
	uoHOiCUwLh7qOAJhRgLzJefe15yvBE7JAMfLUR5M6oQov8V7Do0lLgc1gD5WW8GJ
	44Srqgdv8zgxmKOq3LEaSnEybTtBZfDGLe41LTglVDxahqnO3ZFH5q+Jl2wsxQOo
	9lkx5FjbsD5TvIkr0HSmD637LXhLN6CEblgV8J87pskJT4OQXxZkyBRD3VKlrD6p
	JkJFF+XC6IgaDHJgUM9it2UXjKjR03ov2/b6UF/DakvjqKXqLyH46AGlltGkPoyj
	CWA5Ig==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45f91t04cd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 13:22:13 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4769273691dso119269511cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 06:22:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742304132; x=1742908932;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=90Qa8a9JOpfX6xK3iRiQYBwU2Lz8sFA7p1khs43FFPw=;
        b=t9gHOfrW/+cYKUJ7MK9eo8Gswvj78kDxceG6EQGN3NGZdOFfvqUgYWCkFGSbwUfi7l
         O1dKWcOCpp9yaJfI51PwNE+tM9a7/sBNuxMqc71f3/E0T2ydFXCLg9nY6fIkhC3bzt1x
         DHfi/GgS6gpUqyDUX0y/x1hj3+ocMlw5wPCWm03/LbXK1ssetT4b9DCwFEYxAa+cPr1r
         vuOcj1+O4TbP7MEHoFOMIWEUcEu67zNvhun4QgdaFM/b3hyESaStyID2kqLmHbEcAWGT
         /u1GtyqvQ8sO+rd7TRazQhx+kzQH/RxvPuTwa7/AIB8pXVB+Z1krm4rcTu6PHXXbNAFi
         3keQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtB9acpkgarZmxfz/pT4ch6IZoUnyozUyB3MSuGQtsvrEp0Vyv8wDs2cHT25dO/hP13HA4/oOQuh3sl+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4mIujhB7h7dIdG8d6fAWmEJbHfDmJ9v51PMfnz7xLMwSa+ymC
	3MgXgs0znTelUoap1gSk9br0XRDFtclZx67dPip0NGMIrPXKG1Ph2928Iqpl/e1WzuHigXTmyDZ
	Uehfr+rCNuQ0971yShgs8pPr3LCDwLevStZx3Y3KXUgZSuN6APsBeF13zPdZ2l/Y=
X-Gm-Gg: ASbGncsZ8EhjdbIevaitRPVLwsKdRzCEx9Wy5yUKT9c8MPn/8mw1xUQQWJDXt7DyvNA
	hFded6pGMsgeWdKRFq1SwE+e5eVvlCceiFb/liL9CMVrwYIOTzB4KcAZNu6rPQaL00UjXXhff83
	DUxAqDSQYJlw9OZ4J7JJix61RvHHJ7Iozoq+SqvsvP09hGTEB7lGZV1WMX8jwWbbEz5+xTuRJQP
	R4f0OxnwveeARptph+ubrzACWtr/hcD26kFl5h/UIv9GY1hHvKBYIq5r3E1gEAmYCzW2N3cOQrK
	MbPdLioRBXRf2Qd+sYW15T0QlZGO5LOVpccVRjWwFL9fRFpdbgxLeewSZ5lWeqmuhpqsexSOOEG
	eXz18V7T16rv9JyZSeH6Bhi+4gRBF
X-Received: by 2002:a05:622a:13ce:b0:476:a74d:f23b with SMTP id d75a77b69052e-476c81edf41mr217060271cf.48.1742304132084;
        Tue, 18 Mar 2025 06:22:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3cOhI/uaSCyn0dHPO8pflDCmqzgUPHvz/xK7Lgn/iw9/ohToEyaGvfEydfUSRss7Lc4O3yg==
X-Received: by 2002:a05:622a:13ce:b0:476:a74d:f23b with SMTP id d75a77b69052e-476c81edf41mr217059861cf.48.1742304131746;
        Tue, 18 Mar 2025 06:22:11 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba8a79c4sm1664831e87.226.2025.03.18.06.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 06:22:10 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 18 Mar 2025 15:21:59 +0200
Subject: [PATCH v2 06/10] ARM: dts: qcom: apq8064: add missing clocks to
 the timer node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-fix-nexus-4-v2-6-bcedd1406790@oss.qualcomm.com>
References: <20250318-fix-nexus-4-v2-0-bcedd1406790@oss.qualcomm.com>
In-Reply-To: <20250318-fix-nexus-4-v2-0-bcedd1406790@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Lee Jones <lee@kernel.org>, Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linux.dev>, David Heidelberg <david@ixit.cz>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=945;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=A5b+7PiOzdnEsoIXhJtEDtIF4/+zzwMq2jbAcRXdx6A=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBn2XN1GNH7XEZ/cKYsIbOrr56agd3ol4ShkdTzA
 NU7LHgC1bGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ9lzdQAKCRCLPIo+Aiko
 1QSVCACCx/SRir78Lqxpwe2gj/DnNHmZ78WE7r/CnzspxSjw6HD62EeTXRvoWunYl67EbK+lxae
 64Mnsdd3r+qo/eI9qE+skbsKEG32/VGJy+58d/98ZTbBcy923r08CiicvsR+kDNCcdNHobyjaI3
 u+qm3Utr1pOvTz+Lh0RrCNCd3Zb8wmb3Vmomvo9w341VTwIIG2PXGmLs7RBm1Ppm3uhUYhcYza1
 0r6Wd/Qgq8ripF/dL25lQlAAIFSPt/IJzptrL24gjyLddCjdBadIdNqM78ErystrwTtLVpfSffV
 WUWaN337ADz2EGHX3c7Pxfz3ePYNK2SHrpSHBmbjiW4RzhUM
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: fbsRYU_r1BFQz7BeTuxnZhp2xRuORJ9Y
X-Authority-Analysis: v=2.4 cv=Xrz6OUF9 c=1 sm=1 tr=0 ts=67d97385 cx=c_pps a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=ZANWpg7mVWKCtM2BIo8A:9 a=QEXdDO2ut3YA:10 a=mjqSHpV9Z7kWhFShES6D:22
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: fbsRYU_r1BFQz7BeTuxnZhp2xRuORJ9Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_06,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 mlxlogscore=858 clxscore=1015 mlxscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0 spamscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503180099

In order to fix DT schema warning and describe hardware properly, add
missing sleep clock to the timer node.

Fixes: f335b8af4fd5 ("ARM: dts: qcom: Add initial APQ8064 SoC and IFC6410 board device trees")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm/boot/dts/qcom/qcom-apq8064.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
index 5f1a6b4b764492486df1a2610979f56c0a37b64a..ba99e794dcd2236f65f2f3d8c49213cfdaee5f6e 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
@@ -326,6 +326,8 @@ timer@200a000 {
 				     <GIC_PPI 3 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_EDGE_RISING)>;
 			reg = <0x0200a000 0x100>;
 			clock-frequency = <27000000>;
+			clocks = <&sleep_clk>;
+			clock-names = "sleep";
 			cpu-offset = <0x80000>;
 		};
 

-- 
2.39.5


