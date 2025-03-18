Return-Path: <linux-kernel+bounces-566216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A610A6750C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEBE38838B6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CDF20F086;
	Tue, 18 Mar 2025 13:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hLi/SnNi"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB7420D4E2
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 13:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742304162; cv=none; b=Y0qSsqu+PvgUjDs2VwbD4NwqJclhQf4nmfIwTQB52Ct8716gTMlvOD9sLccyNwPZEKbjv75C93Eu6uV8a750V54dyQWWxrsmbGn5uOOprDM3FDNp7xwCwJp/bIn+2WFgQNke1B7mpskmq9Z4pyqwmLpAxc6HAXVetWiIJblxs1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742304162; c=relaxed/simple;
	bh=euC9lx8IKVS/A4UdhCZ5+fvdurao8cR4qkRb3bHColg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VEd8v9GVa5tjW0s7QzFiSmFzFkf8Mz5SsRkVrl+TRLafQSsFbJCkrTodQkksTEBtWBgcIVp+l1CeBRRTaKj/NZh/QzEmboBV2IoRxLzJhsD57zWE8mtAAfihAiCA6wAHe6ARlLgk1ZJs8/+FlT1D3qLFi00/qFmqa5rOXjyEP78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hLi/SnNi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52IATKOG022924
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 13:22:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n7IO4GSFLKL+RE89vjiv//aIMcE3MIuPp86OVbDzpdo=; b=hLi/SnNipXI9DgKB
	IRef0gKYJGkf1DaVVKyHOJ97drZXpJM+D4XKvKeE0oGZT1oGxAiDjFtwq1Kdq7CR
	HSbiWUshVDNUfxy4XqTykBY3LTYN0XHldgOH07fk98WpcturGnBoETEcM37ZskCc
	rju/gp6rD2BuyWxxVvzq3LvYgDyyX4e4M1WF/LuwHREql5UtY+QbhVy4Bmik8ZSj
	qwNFWG9Y/LQgCsoIcgypBjt4+A6jWYOHctL6h9oyElxTR7oP0mSOPt2WGNjT9nNn
	/4OCYlQXkpdZt1GrmejwK1vJqHOu0GODXxHk8K+Im3j2Dq3BGw8MaJYa0hqMP6Ed
	yjdPDw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45exwx1y8g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 13:22:40 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4768eed4649so104336321cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 06:22:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742304138; x=1742908938;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n7IO4GSFLKL+RE89vjiv//aIMcE3MIuPp86OVbDzpdo=;
        b=DzzfZqEIRJ53eKi5aEb0p8cyXSR/8q+6ku2n5+Uci6bi7zT2q0FWvNkxszDfAB9CSL
         Hr6oLcWjuzEOV9r1sVUGMa8rd4nM/43X/1m6/0/LDPo5ZEAgQe1H8NRF/zggWRqJeaIr
         BRqNmoBybXu0E1CoRlEj2VU1wvDFhrwRvcFiYsFDzHO0lOLTJy/1QT9yUcGSLXsJ4Iee
         D3bYFORUtfsZdv3CVbP+6zzszwhc+caBHCs1wHATXg6Gt7JCXXC3aLmuyGPKYUQoziPv
         kSClMDUQJ6exE2YhwiE8GL12jB8btshZ3EyqhrTA7zZMeAXaODaP1tI85UyPPmk/Cv6J
         6soA==
X-Forwarded-Encrypted: i=1; AJvYcCV6nsoCFR7BFhVIbeRHr4jHOtn/z9gsH4XhQwgV5b2Uw1NUsrKeY9rVbdUZjmDegG3KAqYC5zlGZnzw6Sc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHZDmJVbKiOMB2epjv9WiDkH1kCdZYeWMmNug9TDF0UA5aZJ+3
	zHUx4ZXv98sASNPep3fL6q/W9GKcjibT0b5edb2aRoTmyb/aHA2i8WzWFC6c5PSQ/EgrGjzbIcn
	eNj0NcWNyibxcm1zkGVhUsOxsRzS5HTNnMn84Rvr+h1/ke9ii4jA9fDW6wG4rF9k=
X-Gm-Gg: ASbGnctkmyeFZjbMIvrFGQCoTISA5nahG76/BQEKYJfL7uolmqxKigja9Nc3xntdzR2
	GYxyvPmJ6zKmNyxI+DhBbTk0GqFt6Sr93dE6NncyV7YWpESY1+YJaT4bMsJ+wBb63II9oQ3EidR
	cXZ+LyKGVmVMzQG67mQ2TwEiqsL7oCrX3fNC32vhlhgcdaAtHSGmMV3wSZ+2UHkQ19fd/tUhMwW
	HIM22nQox9w3xMhn2N/6fHOMA9Dizy0ht34HrXa567eOeYpy8yyppLcyl/O99OuHLemvru6MZ2O
	c9yCp+Dyq9cNTPedNqBzNR1sdJwn8hXCKIbzdk5TWuvP8rVFrp2cMzfjjtfuiOQMzlBgYNbqYKm
	TFSMXXjMMM1NaJx1gKDouLmT7AjBj
X-Received: by 2002:a05:622a:5793:b0:474:fa6b:c402 with SMTP id d75a77b69052e-476fcecd39dmr48511411cf.18.1742304137598;
        Tue, 18 Mar 2025 06:22:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKpVjZU2/I87t1KC+ZmwZYuLeZn6cRvCjLGhHZX7oBvEfdheyousKKIxayf6GNx8oPkiFQ+Q==
X-Received: by 2002:a05:622a:5793:b0:474:fa6b:c402 with SMTP id d75a77b69052e-476fcecd39dmr48511101cf.18.1742304137251;
        Tue, 18 Mar 2025 06:22:17 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba8a79c4sm1664831e87.226.2025.03.18.06.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 06:22:15 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 18 Mar 2025 15:22:01 +0200
Subject: [PATCH v2 08/10] ARM: dts: qcom: apq8064: use new compatible for
 SFPB device
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-fix-nexus-4-v2-8-bcedd1406790@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=782;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=euC9lx8IKVS/A4UdhCZ5+fvdurao8cR4qkRb3bHColg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBn2XN1nSWhjjLdnnXpPzLp1PCByMmTFxTcDQMxT
 coRRyEqPtGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ9lzdQAKCRCLPIo+Aiko
 1Y19B/4oz0SL/S+qapQnn843C0bdimTThUshN1ijFu4oJQkCKffFEqAgetU1nZhHUhmeKcbCKDW
 2sLuRIW8bwouTGzUF8TknWW5JJkb+no5lAEVSnaYAeNE3VaZYdV0yz/NMYezXfs58JeGWoCC4e8
 s5SidFCWQe1cmq06LwCjhckq0Knb4UUUCGRdaoJn+qhIX2IJs/7eOuCDCufDsVfLqSnnvbLYBow
 NOV9CYr7L+oV0XyNDUl2o5amELlZ1HaDdMtTiQXCwSzO4O84HesESI3z5rC3D4nTBpEWqDR1u9w
 2vBt4hKxclxTvhfCa0U5VeSH0slZ/CPJhgMUHQfgqUkGCSoL
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: FZAgC6qOFxMBEf94k47Zg9INSRncLd3n
X-Authority-Analysis: v=2.4 cv=INICChvG c=1 sm=1 tr=0 ts=67d973a0 cx=c_pps a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=vGl9qbW8TQSvOBFUlmcA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: FZAgC6qOFxMBEf94k47Zg9INSRncLd3n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_06,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=751 impostorscore=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503180100

Use new SoC-specific compatible for the SFPB device node in addition to
the "syscon" compatible.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm/boot/dts/qcom/qcom-apq8064.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
index 41f8dcde20819b3134c38dcb3e45b9e5cc24920f..a5aad4f145dd368aabed44cf520ffc037018b37e 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
@@ -1086,7 +1086,7 @@ opp-27000000 {
 		};
 
 		mmss_sfpb: syscon@5700000 {
-			compatible = "syscon";
+			compatible = "qcom,apq8064-mmss-sfpb", "syscon";
 			reg = <0x5700000 0x70>;
 		};
 

-- 
2.39.5


