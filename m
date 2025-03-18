Return-Path: <linux-kernel+bounces-566215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF791A674F9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CAF819A1769
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E287220DD64;
	Tue, 18 Mar 2025 13:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LqcDrKJW"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F57020D50F
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 13:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742304160; cv=none; b=kJpFv9Yzvsj1ZGN1SnEJQc7qnQcjJebS7PZ0G9nIlI9I2nN+F5XN3IIYz2S/5mY7a3fZMt66AQQFt8yyeHwslps8yBXfQLPgpCsNaVSe5AUOVYmHZuH9X/CfmVokwPbFWvm6Z8jUlo5nE0ok/YcdwoE32EPso1oD0PSgM5Qyttk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742304160; c=relaxed/simple;
	bh=rGO8ljRJj2lTMiYab3pEL79ThIPqrqw2LC84J1Wlwas=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m8cmvIfqJb4kTT8mm6nK/0fyulOcS6TJoPZ3lcbTlybL6ZWGM2JAMJXRYH4KPzbdDxoM+aYI1lqlNh/mqNJxxq9N4KEerF9lAZ5fWlgNP/lPCFXwhY6DJvnWRFSCQBGvstfu7bmWfWgtwO2SE4dft1QPWeQdrXPo3rSps5ZLONY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LqcDrKJW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52IAaWva028624
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 13:22:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	L8yxRMa5j4oUptRKWHe6HWZoaMIYXuESwxb2I3uAvtU=; b=LqcDrKJWDWR39x5w
	dVWo3BD5DFu3bY8ZR9VASJLckV5qn4RXK3z4sIA1mJ06roz1cXizmhhClfLVj1+Q
	VdNGhjQ/zXoMEBHIqAc1PFZ23YULE9Cr3ztRPcy+82NQ31acR64XepBBwS2bFFVC
	QJc0dGbMmixU+54RDONmm81JCebs+8n75f3kQ0TKJOkvZoFa7rx4nkE14VSDSkRE
	gJGugN/R9k7ba61Km/ivRAUE7SavwcYjL8dnw2Ij4olj2Xn1rxit/cZ0muM6eIVr
	SOBodE/Lqyiv/nMFzA433N8szA1u8Ip3V3qbmIp8xKYlipCvltL8xhR67TpS7K/h
	yn0aVw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45exwtj1gs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 13:22:34 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4766afee192so175377021cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 06:22:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742304140; x=1742908940;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L8yxRMa5j4oUptRKWHe6HWZoaMIYXuESwxb2I3uAvtU=;
        b=J9ZRgbh1l1dgr6GWS3+E5noZKGGjLHB6bzMXwxrN5Y0KixyMz2KfNPPdlOZ1q9RYi/
         K/guFCmvVuOrwP9biOXkaju6vRsikcilcZAI6LRZKl9Z3jpztdhCAVOk+IZm5NPaRUsW
         GGPNZD6bueNiHWisyiZf8AXOS5qX5jelviRal2EWT8kJ76zFkAkx916dehylBwaeym3z
         WLtJ4iesN9CVSQhWdY2BXR6l0iw6wHivQYKhahvadjRQBEelO9eX5bD8Jy/n8W+vxixC
         yg7s3+uBM6pdd9F1nsfZAwsaba9U4s9Bq0YfxDr1l+Jsx+BzAofzBTh8wJysSm8Xc3WT
         TB3A==
X-Forwarded-Encrypted: i=1; AJvYcCXQowA1JjRCT4o9KJZDqXt7ZCQW7+rCFYjLMPExhVOGtdwQTNMaSWR3WHfqkuM5HbMwjjErrQBYEdqaDtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU1Q9mnoOda5fp8hfcq7TELyp3A0h26XSounxTYAsKLxj34sdW
	nVBYK/UIDLS/2pu0k2kSxa7iQbFJcn/9h+dbY10AhBQ1J//omZKTTY3e8t2iapgvH3hi+OCwkF9
	Yt0RHCvtrP3t0S9VF7CCgmvW9H90M02KpZtnp+mdF8G9+EMciqBj2jbDhOimDMog=
X-Gm-Gg: ASbGnctFy/cDpDRZ6WRKeD/Z7uIELYypkefsgrmjGahApiH+//LGOSIYA3wzNXE72vh
	up3teF07W5hCq4ox7Tcz2q3sdIMD0P58NhrIK6aXij1sIqGE/e59yZk983jBRIAMdWfg/M2oC0n
	reeh15Ku+6xw/jUk5x5nN+QxkBo24BD4UkxYbp1ZysePnaExm7In8pWKMKiUOOEAiYbZgbSLVp3
	dwOQIzT/2HxsUTPtaDu66ZYfOdlReFk325NPYaJCjUkta2if84UnfNndn2C+5Ln9CNAOqBuFLIg
	PprKfjwKiLoJOPG4pAAIL4+Tl/Ns0uiaaXwINJ5zlHlSGY9Zfx+O2LXB/tiTq06RCvxTY3MlqkK
	q2yoxtxYrgRn+Yu//8Wjx4JUuttAZ
X-Received: by 2002:ac8:5802:0:b0:476:7e72:3538 with SMTP id d75a77b69052e-476c81d8e94mr316429181cf.50.1742304140070;
        Tue, 18 Mar 2025 06:22:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwyFkJjOgyoKomBt2wYBMfOH/z1hPsNpjFOhgy61zIEiVBQ6NRmiZvk/992/PdhTpr5TKEQQ==
X-Received: by 2002:ac8:5802:0:b0:476:7e72:3538 with SMTP id d75a77b69052e-476c81d8e94mr316428741cf.50.1742304139749;
        Tue, 18 Mar 2025 06:22:19 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba8a79c4sm1664831e87.226.2025.03.18.06.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 06:22:18 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 18 Mar 2025 15:22:02 +0200
Subject: [PATCH v2 09/10] ARM: dts: qcom: apq8064: use new compatible for
 SPS SIC device
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-fix-nexus-4-v2-9-bcedd1406790@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=918;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=rGO8ljRJj2lTMiYab3pEL79ThIPqrqw2LC84J1Wlwas=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBn2XN2VlgxbD3pLVZFmEWmBFECbSfg1LbnAQwzl
 9Crg6fK9pCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ9lzdgAKCRCLPIo+Aiko
 1QPGCACpysEPjxlYldEhFTaYVNzCM1Sc/vDP7O+jCuj3Hs3CN+4o0HMa4k9V/p38QfeW2BEmEcG
 KVmH1uIBVD0ss2Uwy/8iqXQc4dzUNB188/NwxH2Hs3u08DTqhf3GzbwXko7/g21D1pJkxlGEvCs
 G4SvhXRsBAcgzprYbN4GYTpmjFfATfjXT5U3xNQzvEQvsIFNBoFteNlP7Y8gzUx1xgpZKR6QNxM
 nQOLiBulGpduDFsPUDpB/nL5JoeSZs4qoXbW+jeeQG3FIDmki0o7XYO+jhYEZSmPzSTeARYxw0Y
 Yiz1ZcvjNRLgxItgEP/f8Vt83nPbP7PnEfcBnPbwYzMN6FfC
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: NifZ_vrMttdL7HR-iGmhpcEZWvHKamtS
X-Proofpoint-ORIG-GUID: NifZ_vrMttdL7HR-iGmhpcEZWvHKamtS
X-Authority-Analysis: v=2.4 cv=UoJjN/wB c=1 sm=1 tr=0 ts=67d9739a cx=c_pps a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=p_EMIZExALG5VSdhSekA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_06,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=589
 phishscore=0 adultscore=0 clxscore=1015 spamscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503180100

Use new SoC-specific compatible to the SPS SIC in addition to the
"syscon" compatible and rename the node to follow the purpose of it.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm/boot/dts/qcom/qcom-apq8064.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
index a5aad4f145dd368aabed44cf520ffc037018b37e..b6533630e347c8fc5e3f0791778cd05760b3f3c8 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
@@ -402,8 +402,8 @@ saw3_vreg: regulator {
 			};
 		};
 
-		sps_sic_non_secure: sps-sic-non-secure@12100000 {
-			compatible = "syscon";
+		sps_sic_non_secure: interrupt-controller@12100000 {
+			compatible = "qcom,apq8064-sps-sic", "syscon";
 			reg = <0x12100000 0x10000>;
 		};
 

-- 
2.39.5


