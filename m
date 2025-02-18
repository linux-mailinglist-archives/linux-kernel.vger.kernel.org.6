Return-Path: <linux-kernel+bounces-518707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E23A3939A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 07:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DC783B32BC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 06:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B101B4F04;
	Tue, 18 Feb 2025 06:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GMWFFY7C"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F631465A1
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 06:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739861950; cv=none; b=ujljgQ2f4Ng2+CwlAlor5muj6l155ACB6mq+DaZsPJw9voTKJMYiuyjBgxYgtAEyKe8+MuVK1RnIlAeDkYhQ/tPq6wpJOZ3nHZTjh6EkdVfoLOUF6Gvdv7phGsWS5t307xm1Hz40M09IzU8Es3bfs7wF0FbmLweqz9cGNKrGbIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739861950; c=relaxed/simple;
	bh=1k9BCUkbzWXoR++auGEENP1hdbsmmSYBGTZt+PC2E2g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bg06IeDtMrkXm/anI1t4I7dG5yQpmG09hOJ4nd8pUxFms1j1FeKPIrdMm0RK9hXcAaFHL3eBYQ09nRPvUNp0BeIntY/RNYMspQqw7r6uP0WrDvIuEIjM2dOfYVNYLPfwLRjlCPk9/8bF/A0CGJ0FkDEqj5lNcSEEHIUahMqtROw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GMWFFY7C; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51I1e6DX025455
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 06:59:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=sPShBOsY5VLSNLF1J4MNJY
	N36AkDL1uBQgmSPpIg7MQ=; b=GMWFFY7C8RrOBTI7ZtJN+d+xoTl80XO1xDU0Fo
	wJDu9fnLEUZ9hT20NgLojmoxVGlbWuU+cc0SvxVcBjbVVaGPI37LIjfeIiCLdj8I
	H8LkNZ6+JlTnUhovckO8g1tJeCmyPaskgcdUQodVJJ6istQAqz4fKpVYRtDlRLQj
	D+/mLiJptJTcjENg8qNp9OcjGOqn+R4VRmFNvIG2SYfyPwcP0CHRLQx3bYjGtKKm
	r5cMxld3CnDJE2RH5m04mqCsWsM5egqqJH89ygI1KrwvwgLh7YuBXsyqsQOch4sH
	U3Jut82l957S5b3MHo4+Rg1e8C5cF7J62YPBmBTNvDY9eVWg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44ut7vux8d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 06:59:07 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-220e1593b85so89732165ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 22:59:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739861946; x=1740466746;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sPShBOsY5VLSNLF1J4MNJYN36AkDL1uBQgmSPpIg7MQ=;
        b=tJQmGtWwTyyAvVtzsd/Z7eCWeqk5kxAsIjKRbteWj/8DuyL7GYUMK2hqH1LGb5ja9D
         D8MpQv1yFL934Zk9afrxxo3fmuPewDo8qZcmKzpPNWuP+7R//0/TdP2HiOCuvae4PZr8
         Nf9yyKbvf5zes/3XgHlG2Ae0LWDWPy784Hc5fHfU5iznpIsGB9PLU/FjIZd9udXSUnXL
         SkkGsmkyTqMVDcurTcsvX6HnV6c50IUYLIIXPOYitjwxRkS4uM9QYOQtQk+xV6wU/j2y
         Xq3NhgwOHRAwX1KLVJRMDJAh5/TiIVpkYUJKlvpMK2skrVcbw2xBFajp+9E8BE2Fzvyi
         9aCw==
X-Forwarded-Encrypted: i=1; AJvYcCX30Lvq4H1954xsK/bxkb8uwU17ATpxRlCCfBjgnQWl27N2k5y+RJqHssF/UuZui1fgheZLk0RcDcqMosE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC8wcQEnTFUtih7QGUtaaMcH8bCGXIZ8siPkm29vZMzN7aO6Ia
	97JOryB/Eutifk/C6sK7tcN+mSA8lMajuqLg6JXN1Y6v9USNgLnQ4HXX4/Ac7OmN67TODMzag8o
	NK/bkx+7HTGvFKY0Rf8SIWzqz6/3z4BOaokmA1KUBItDkvqRbbiLkVv6aEYOIqTg=
X-Gm-Gg: ASbGncsZHBlhPu4uRhP4DT/ZU5qbCzQMIUfQaAo4SzZGRq0nePmrlBmNuT7JHWOd02K
	5M3WrvasYpWq780UzN+go/w0mxfD17RknznkbzfGCXcN3fxAEJhC0iIown6B2HS8Q1jhanPiZe/
	QihgN0ZmmwfHz9DqKmJyRbEWSTRmLDuchJ7KGNKzqOdlV+e+49P7Y+FYJtM6B5iI1Kibe1nWVHO
	eo0tEmdzm33JEDjWsV95kRxTc2EwKi1DD7qTTYlPbrTBQ/B6RseDjcffIsyNg/32f0O0Ia/q7lo
	S6JieIoJecCL7qxcV5k=
X-Received: by 2002:a17:902:ce0d:b0:21f:61a5:67a5 with SMTP id d9443c01a7336-221040b1342mr207349745ad.42.1739861945775;
        Mon, 17 Feb 2025 22:59:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqYOO4wAMcDFAf+d9a59DE0KSOadLoeto01ufkmNN6EUdIvlPkaMu/Hx2gS8aJoeu1AQFQhQ==
X-Received: by 2002:a17:902:ce0d:b0:21f:61a5:67a5 with SMTP id d9443c01a7336-221040b1342mr207349575ad.42.1739861945423;
        Mon, 17 Feb 2025 22:59:05 -0800 (PST)
Received: from [10.213.103.17] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d556dc4bsm82065915ad.188.2025.02.17.22.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 22:59:05 -0800 (PST)
From: Maulik Shah <maulik.shah@oss.qualcomm.com>
Date: Tue, 18 Feb 2025 12:28:55 +0530
Subject: [PATCH] arm64: dts: qcom: sm8750: Fix cluster hierarchy for idle
 states
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-sm8750_cluster_idle-v1-1-5529df00f642@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAK4vtGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDI0ML3eJcC3NTg/jknNLiktSi+MyUnFRds7RUY1OL1CSLZPNUJaDOgqL
 UtMwKsKnRsbW1AA5NFPplAAAA
X-Change-ID: 20250218-sm8750_cluster_idle-6fe358eb8c7e
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jishnu Prakash <quic_jprakash@quicinc.com>,
        Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_lsrao@quicinc.com,
        Maulik Shah <maulik.shah@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739861941; l=3606;
 i=maulik.shah@oss.qualcomm.com; s=20240109; h=from:subject:message-id;
 bh=1k9BCUkbzWXoR++auGEENP1hdbsmmSYBGTZt+PC2E2g=;
 b=IVJFvD/M+jTTLQ1DOtvVjF5uoKRqWb4MxF3dlQOEaU6YLqTctjvdxJEz+3264GsnLhxHJ9as5
 XqhwyCNi8CqA7ui4jxh5fwejc5DuqVHzTWTaCT/uX0S2VxaAjWslA1c
X-Developer-Key: i=maulik.shah@oss.qualcomm.com; a=ed25519;
 pk=bd9h5FIIliUddIk8p3BlQWBlzKEQ/YW5V+fe759hTWQ=
X-Proofpoint-GUID: 8hYvRQDBNHkZTM7Mcit2bU_w9JVfZ_MY
X-Proofpoint-ORIG-GUID: 8hYvRQDBNHkZTM7Mcit2bU_w9JVfZ_MY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_02,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 mlxscore=0 mlxlogscore=696
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502180052

SM8750 have two different clusters. cluster0 have CPU 0-5 as child and
cluster1 have CPU 6-7 as child. Each cluster requires its own idle state
and power domain in order to achieve complete domain sleep state.

However only single cluster idle state is added mapping CPU 0-7 to the
same power domain. Fix this by correctly mapping each CPU to respective
cluster power domain and add domain idle state for cluster1.

Fixes: 068c3d3c83be ("arm64: dts: qcom: Add base SM8750 dtsi")
Signed-off-by: Maulik Shah <maulik.shah@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8750.dtsi | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/qcom/sm8750.dtsi
index 3bbd7d18598ee0a3a0d5130c03a3166e1fc14d82..3af928be5b68b47988dd55f4add8e3712f07d5ab 100644
--- a/arch/arm64/boot/dts/qcom/sm8750.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8750.dtsi
@@ -178,7 +178,15 @@ cluster1_c4: cpu-sleep-1 {
 		};
 
 		domain-idle-states {
-			cluster_cl5: cluster-sleep-0 {
+			cluster0_cl5: cluster-sleep-0 {
+				compatible = "domain-idle-state";
+				arm,psci-suspend-param = <0x01000054>;
+				entry-latency-us = <2150>;
+				exit-latency-us = <1983>;
+				min-residency-us = <9144>;
+			};
+
+			cluster1_cl5: cluster-sleep-1 {
 				compatible = "domain-idle-state";
 				arm,psci-suspend-param = <0x01000054>;
 				entry-latency-us = <2150>;
@@ -233,55 +241,61 @@ psci {
 
 		cpu_pd0: power-domain-cpu0 {
 			#power-domain-cells = <0>;
-			power-domains = <&cluster_pd>;
+			power-domains = <&cluster0_pd>;
 			domain-idle-states = <&cluster0_c4>;
 		};
 
 		cpu_pd1: power-domain-cpu1 {
 			#power-domain-cells = <0>;
-			power-domains = <&cluster_pd>;
+			power-domains = <&cluster0_pd>;
 			domain-idle-states = <&cluster0_c4>;
 		};
 
 		cpu_pd2: power-domain-cpu2 {
 			#power-domain-cells = <0>;
-			power-domains = <&cluster_pd>;
+			power-domains = <&cluster0_pd>;
 			domain-idle-states = <&cluster0_c4>;
 		};
 
 		cpu_pd3: power-domain-cpu3 {
 			#power-domain-cells = <0>;
-			power-domains = <&cluster_pd>;
+			power-domains = <&cluster0_pd>;
 			domain-idle-states = <&cluster0_c4>;
 		};
 
 		cpu_pd4: power-domain-cpu4 {
 			#power-domain-cells = <0>;
-			power-domains = <&cluster_pd>;
+			power-domains = <&cluster0_pd>;
 			domain-idle-states = <&cluster0_c4>;
 		};
 
 		cpu_pd5: power-domain-cpu5 {
 			#power-domain-cells = <0>;
-			power-domains = <&cluster_pd>;
+			power-domains = <&cluster0_pd>;
 			domain-idle-states = <&cluster0_c4>;
 		};
 
 		cpu_pd6: power-domain-cpu6 {
 			#power-domain-cells = <0>;
-			power-domains = <&cluster_pd>;
+			power-domains = <&cluster1_pd>;
 			domain-idle-states = <&cluster1_c4>;
 		};
 
 		cpu_pd7: power-domain-cpu7 {
 			#power-domain-cells = <0>;
-			power-domains = <&cluster_pd>;
+			power-domains = <&cluster1_pd>;
 			domain-idle-states = <&cluster1_c4>;
 		};
 
-		cluster_pd: power-domain-cluster {
+		cluster0_pd: power-domain-cluster0 {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&cluster0_cl5>;
+			power-domains = <&system_pd>;
+		};
+
+		cluster1_pd: power-domain-cluster1 {
 			#power-domain-cells = <0>;
-			domain-idle-states = <&cluster_cl5>;
+			domain-idle-states = <&cluster1_cl5>;
 			power-domains = <&system_pd>;
 		};
 

---
base-commit: e5d3fd687aac5eceb1721fa92b9f49afcf4c3717
change-id: 20250218-sm8750_cluster_idle-6fe358eb8c7e

Best regards,
-- 
Maulik Shah <maulik.shah@oss.qualcomm.com>


