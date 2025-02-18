Return-Path: <linux-kernel+bounces-518686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B473CA39343
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 06:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 375441706AE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 05:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83521B415E;
	Tue, 18 Feb 2025 05:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FnIx+RHE"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A671B21B8
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 05:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739857974; cv=none; b=iDw43efgEcryjkpnuExtBgqbjkccwkV41mg47UMukl1ZWgwkDSW7wbbfHmrEGAvsCSuPZnZ8Kc8RW0UEAMlecTr1Epp/X3BNByW93rbzprUrNa49OCVFcceDMezSYzBksKzbBvl/0JpULE6KHMqGenxTacrI0TbOvRYWXPtFmbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739857974; c=relaxed/simple;
	bh=OUNgeBG9Yaj+w1qNJC8+eYpKidf1r39gmgSZpgb8UuI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=S+KNLsBtRua+tHAMW2R1w+d2/+Z27eIrN7iF3hB1rVWKrWixe1hXpIki8QxFvlC3VYNvITVKFnr09N2fwbmiaDMRrgR309x/De4g5MOHsFeb1T+d7a/fZx6H6KmswUW5xp0S5seEsvQA5PC+M/RWA3/XmKa/9Uq8JZBtEJ16XNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FnIx+RHE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51I2Hivm027323
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 05:52:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=8y/PCaTCRg8VuI/K8qxbSF
	0ICUfYwKH3o2vnyNihc+M=; b=FnIx+RHErlZr+3VgJrn0odKWnHTkOGvqsjnbYZ
	jmfr18Hrn8mG6nsgWysEnJe/OSpaj6+DaRHm1Q2OP9pOtn54lb80JFzv2Ykngg0x
	gyUDfu6tc+GXYI56xwUVXXMlN9uZ7Tr4JquEX876pLdsQlzD48Tahra5EE9ojHcQ
	R5fY/UXB7BdGyy6jl2NDH1radTw3x1ZXG1K93IyrJYeG1afcPHqPsiFarSmADvXk
	fCuZu8LScruZB3ZWYoKcGTJ+L2b4fPKgQ38hYQwWVCk/ur+rbcQTBOOnhij9x40E
	2nHez7CuAxBd5FFpbnyFkELEpClVvyrmraVGzz4JS9khfXBQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44ut7skrvf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 05:52:51 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2fbfa786a1aso16075307a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 21:52:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739857963; x=1740462763;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8y/PCaTCRg8VuI/K8qxbSF0ICUfYwKH3o2vnyNihc+M=;
        b=nXXONCifHcK86VrR+JfvLk9XvUXSu7Tv5W1+Z8tpbgs8ZPMRs5FAiDXAjglPHIEHvp
         9TXAcqVLupiEB2K8fi7MQWjQvx03QhgAbD/2T3qR8WOdpUEaA6CTYrZZ/HirDr4jc4Za
         1uk7eG1apctIR1kAMcKqNfqWhHROFRIm906FZ3X4rEAv0TPnOu/dSjnOTIE18raPH4/G
         O6tD6V5EaeWbZEJGnX2Sx4TuJ8XbHF9tAvqy5I6A0OozAoWTeEtoH7dghWU3DkR6JMOm
         It3O0WWVSptR6A7CsbFPr6KEAG22HrHt/CkXMz2N9oicqob4uvmmmq+ZBZB8t3gnlmfv
         iLUw==
X-Forwarded-Encrypted: i=1; AJvYcCUj2Zx3r4i063lD+oOj3mCaai3+w9M0wlQTrslGcsk9qimqITXEJMpXa3Ux4KEjQrx9lTN7jXFUk6hznh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhGeVCnVHorUphpXNeDB8ynRZ8ghgNsoduh9Y/KWI3A4e9Mg6n
	vrbIQFJhrJ+2UxSNLPrv6Gn6OwqdvEcqNic1/zeCxNuWd2b0psqmKQWgrQEeU6DhGvnnE08Ei1d
	tn0gwWp1zIlYmp2xVA90M76KZygS5RnDtzYCbi2Vm/C7eve0d+qpaM+lRUHtPCnS+w8jryyI=
X-Gm-Gg: ASbGncvzMVXZZ+MCxJLuvaJohGhbU6G8gtLmoAVGqMC8nq2JhteK8If5ZYs9Blxv24m
	S7qKlKu1IqZuPsR98gAlxpXB1F9hSuVJ+AVCZb3k+4FtZbnqTfkN5iraOXUGgthiGSz7GxPWAru
	eILt6GS9eVE9/vaUCv2fCFuXemEHxgfAhzSCA6z4sxd+SCSYGMlF03n4amaMoFHdiuTQ17XVCKr
	BR6S2xiEm4cn/QeAuiXEWQ2hz0OdSeGz4DZgoojcJBw1mz003jwz7AOBoZ3GW1Jcad0cz3nJ/pV
	VsSusTPCaK44iME/e2o=
X-Received: by 2002:a17:90b:3ec5:b0:2ee:d63f:d77 with SMTP id 98e67ed59e1d1-2fc40f0e8a3mr19003257a91.9.1739857963333;
        Mon, 17 Feb 2025 21:52:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrPhFKUnWnGuRnxsogYFBCvCkW8IkxawKxO8olNqU7YqWZjZGaLhP0OfZuR3+wWGio5vXsyg==
X-Received: by 2002:a17:90b:3ec5:b0:2ee:d63f:d77 with SMTP id 98e67ed59e1d1-2fc40f0e8a3mr19003223a91.9.1739857962891;
        Mon, 17 Feb 2025 21:52:42 -0800 (PST)
Received: from [10.213.103.17] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fc13ab07d6sm9145057a91.2.2025.02.17.21.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 21:52:42 -0800 (PST)
From: Maulik Shah <maulik.shah@oss.qualcomm.com>
Date: Tue, 18 Feb 2025 11:21:48 +0530
Subject: [PATCH] arm64: dts: qcom: sm8750: Add RPMh sleep stats
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-sm8750_stats-v1-1-8902e213f82d@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAPMftGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDI0Nz3eJcC3NTg/jiksSSYl2jVIMU8yRDy2QjYxMloJaCotS0zAqwcdG
 xtbUAtCO2x14AAAA=
X-Change-ID: 20250217-sm8750_stats-2e0d7b19c234
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_lsrao@quicinc.com,
        Maulik Shah <maulik.shah@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739857959; l=1001;
 i=maulik.shah@oss.qualcomm.com; s=20240109; h=from:subject:message-id;
 bh=OUNgeBG9Yaj+w1qNJC8+eYpKidf1r39gmgSZpgb8UuI=;
 b=yTIGDrwcxGB+ErvGVYneeBSikR3BaiY7iLOf1Obb7uKOzIhCLdxh7HtRZq3Ik3D7YsTkcDunO
 4eDjWFm76JYCXT1A/8m1UHAlN4Q/LWfRwE+M2Wh6NseDfkYeb8hVtnd
X-Developer-Key: i=maulik.shah@oss.qualcomm.com; a=ed25519;
 pk=bd9h5FIIliUddIk8p3BlQWBlzKEQ/YW5V+fe759hTWQ=
X-Proofpoint-GUID: yvSkdeVDNgoaki6EcbHNexhmSOdh6Aal
X-Proofpoint-ORIG-GUID: yvSkdeVDNgoaki6EcbHNexhmSOdh6Aal
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_02,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=714
 clxscore=1011 priorityscore=1501 adultscore=0 spamscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502180043

Add RPMh stats to read low power statistics for various subsystem
and SoC sleep modes.

Signed-off-by: Maulik Shah <maulik.shah@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8750.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/qcom/sm8750.dtsi
index 3bbd7d18598ee0a3a0d5130c03a3166e1fc14d82..7b692e1798496292b2f457ab61c63d3b0bb648af 100644
--- a/arch/arm64/boot/dts/qcom/sm8750.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8750.dtsi
@@ -1978,6 +1978,11 @@ pdc: interrupt-controller@b220000 {
 			interrupt-controller;
 		};
 
+		sram@c3f0000 {
+			compatible = "qcom,rpmh-stats";
+			reg = <0x0 0x0c3f0000 0x0 0x400>;
+		};
+
 		spmi_bus: spmi@c400000 {
 			compatible = "qcom,spmi-pmic-arb";
 			reg = <0x0 0x0c400000 0x0 0x3000>,

---
base-commit: 0ae0fa3bf0b44c8611d114a9f69985bf451010c3
change-id: 20250217-sm8750_stats-2e0d7b19c234

Best regards,
-- 
Maulik Shah <maulik.shah@oss.qualcomm.com>


