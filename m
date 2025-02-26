Return-Path: <linux-kernel+bounces-533135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAACA45606
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 07:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED2C6188715B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 06:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFBD269896;
	Wed, 26 Feb 2025 06:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BH6DQXoY"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4E4267B77
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 06:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740552701; cv=none; b=FjuJUa6DSIM1W8wYqP+8bjhTCG3TNfN7Ork2yimaVvcntIUDBSaXdqAWrn0BLIi5jMh1954U9zjhu5+kvWr9968JEDjZV/5ctJuKg9FSNmPHlFIQeH+3okAEwAiS5aAwdoIHU8YY5HoEk/GWT/MphOFc6yruZK3nCcTTeGizgD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740552701; c=relaxed/simple;
	bh=Nr2XquDEcWIZ32z5BYr9PlI+GG2FDN7caaV4ha/WbSw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WWEqF1hmxscvqfRtPNophosUL0K/een3wLT998ToB2xx2vJ7stnMUvisrewoczJcSD06fvGj5DdvMBLYbrlP12eReyekbFDk5S21KbZOsbCKfqV9Bs2AmnFIBtWuchdn9xYe4MKrP+AloxaisR+aW97cHijQ3+wSyFN6w1d3JCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BH6DQXoY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PMWmIj021388
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 06:51:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=FiRAMpMCidsWJ+AiRYeRMK
	aPo0YDrXFe78L3MNnq64k=; b=BH6DQXoYwvAs0OqRJ//NyeFaXkOod3Pk5PLbPP
	Fcjd8aCvQXTSR1JR22/unUxXZeNyLtuGPphtKhhrR4fMJKxglsJD4gJjvIZZX4AY
	opOhqg5KaGAfsvm/rtWY34q//o4EgTwlECFINJKy6s064AzQOElr6nrxYQl5VOTo
	aAtFEDVDf6kTl+RP6LcRtbqpG7RWSbVQhi31SOdzvZXuKnhI68uIFv0zGe+2lRSx
	AETZ1CTkNp6lIy0gl7+Vwikitj3ehmqQxXHbDiDETzjJkhpZ5W31jpV+c4r/MGuw
	RMZ+/1XF0sL7UKxv8nH5TT5TFHGUnt95U1Tv7OlK0yRSTR/Q==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451prkh0ma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 06:51:38 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-220ee2e7746so131324535ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 22:51:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740552697; x=1741157497;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FiRAMpMCidsWJ+AiRYeRMKaPo0YDrXFe78L3MNnq64k=;
        b=IJoYH9yXmgvxMxiNRcU0xh+p+UDrFNZaqkl7qqKzXBWj9vMEJ/oTET+rsv4G7Ql12/
         we0+kW1Pp0ZoAO7RGa8i6W9ku+rlVL+hng7JyeB0zkfJY4NzhqIp1lXnljhoYxN4vEpK
         cp72mmcvYFBhiNn+YacquRFhVdG5dr2C6Vl6CIESH21OHAZ//DWClEV46CEz7yU4PLRN
         45DaGM8Jt+92rNzLmJXtZG3XILiWLax13ayqtq4o/KsFj1sWql8gDsWtNNippFAUFJAc
         Film1/JCo4EFEQfWbbIU/KkfLjfR2CSgkrCmDIOJ1DxVzVCAlYbqEYg6tbxrANLe6/2G
         bD8g==
X-Forwarded-Encrypted: i=1; AJvYcCVP4ZMA8Zuy1DA6qr8ev4g83QKZL1sXa2cnU4azXrwlzdX7wxQTZWZXdlt6+kcMgledaT0ktr5v96WwBzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLabXnGR9gU1ZeX5shoaOuAr062nz0DC2HJ2465zzVX4PrXb+2
	twVru6vXPDrdoHUSTKlhtZpbJOJ5E2xMtGumYy4G0pU3fMzX+kQ56O2F3NqcLyRA79UzcNSuIKD
	wTZcgB5K5ZVSdET/KIzIniu1mwAZLFh8pgIPeNYU+wpYLri9a7coELalPEQf8IDs=
X-Gm-Gg: ASbGncuQ+iyp/hZd00CCxRzG3088/UxKGVZmd7ri0f3T2SjWiWPVZsS/2yiUJKha0St
	2wt4iBASxdnGRmoupfgB7lHzgyRD9zaROY2gEWmxsJPEcYNp9HL+4WqMv6PZw1C4t/PGKUEEzir
	B3jXbCVlLnakj5Dv0Kk9H1h4NH65UyKCTWVr8thtSWekYR0miXfaK/+mtsuMMBHMe/VosUMIYAX
	lHrEk6/k0DQAqvZVcF/+4hfOFcLCyGEo48oBjLkKqtvDDLRXxpbPgsvfQQy6SegP10UaJdz07vU
	HOZxDCVCA1VVdjqIGDcn1uf61w/EKw==
X-Received: by 2002:a17:902:f706:b0:215:b058:289c with SMTP id d9443c01a7336-22320061fd6mr33779315ad.8.1740552697265;
        Tue, 25 Feb 2025 22:51:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHV35z8kbWqbSL9vh/1yfYoUXaFR7vWmBJtbtyfB+VFciOqC8XT2KD2pNgEqDPEDsoJaF+wug==
X-Received: by 2002:a17:902:f706:b0:215:b058:289c with SMTP id d9443c01a7336-22320061fd6mr33779145ad.8.1740552696890;
        Tue, 25 Feb 2025 22:51:36 -0800 (PST)
Received: from [10.213.103.17] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a0aec2dsm25207555ad.221.2025.02.25.22.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 22:51:36 -0800 (PST)
From: Maulik Shah <maulik.shah@oss.qualcomm.com>
Date: Wed, 26 Feb 2025 12:21:27 +0530
Subject: [PATCH v2] arm64: dts: qcom: sm8750: Fix cluster hierarchy for
 idle states
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-sm8750_cluster_idle-v2-1-ef0ac81e242f@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAO65vmcC/32NUQ6CMBBEr0L225K2Wqh+eQ9DCJatbAJUu0A0h
 LtbOYA/k7xJ5s0KjJGQ4ZKtEHEhpjAm0IcMXNeMDxTUJgYttZFaWcGDLY2sXT/zhLGmtkdReDw
 ai3frSoS0fEb09N6ttypxRzyF+NlPFvVr//sWJZQwRp9bL6UvTvoamPPX3PQuDEOeAqpt277mM
 dBovQAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740552692; l=3306;
 i=maulik.shah@oss.qualcomm.com; s=20240109; h=from:subject:message-id;
 bh=Nr2XquDEcWIZ32z5BYr9PlI+GG2FDN7caaV4ha/WbSw=;
 b=ZT/bM7gO9LUVNNS40pPZ5AyoHIVjlAU0uvW2M5t5IO6XhJ8jPDotS7MoBj36K7mPsdsfAb7B4
 sKLUdVl3tRvC6qZhZnP5ZAZlnf86hMFVm+G6OAAbYfsD4TzneZ+zenr
X-Developer-Key: i=maulik.shah@oss.qualcomm.com; a=ed25519;
 pk=bd9h5FIIliUddIk8p3BlQWBlzKEQ/YW5V+fe759hTWQ=
X-Proofpoint-GUID: RrqdXwqWYakRPKUioxobqYvkAwyUayw0
X-Proofpoint-ORIG-GUID: RrqdXwqWYakRPKUioxobqYvkAwyUayw0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_08,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 adultscore=0 phishscore=0 mlxlogscore=691 mlxscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502260053

SM8750 have two different clusters. cluster0 have CPU 0-5 as child and
cluster1 have CPU 6-7 as child. Each cluster requires its own idle state
and power domain in order to achieve complete domain sleep state.

However only single cluster idle state is added mapping CPU 0-7 to the
same power domain. Fix this by correctly mapping each CPU to respective
cluster power domain and make cluster1 power domain use same domain idle
state as cluster0 since both use same idle state parameters.

Fixes: 068c3d3c83be ("arm64: dts: qcom: Add base SM8750 dtsi")
Signed-off-by: Maulik Shah <maulik.shah@oss.qualcomm.com>
---
Changes in v2:
- Use single cluster domain idle state and point cluster0/1 to use same
- Link to v1: https://lore.kernel.org/r/20250218-sm8750_cluster_idle-v1-1-5529df00f642@oss.qualcomm.com
---
 arch/arm64/boot/dts/qcom/sm8750.dtsi | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/qcom/sm8750.dtsi
index 3bbd7d18598ee0a3a0d5130c03a3166e1fc14d82..d08a2dbeb0f7924662c9a1de61df95561397c2a3 100644
--- a/arch/arm64/boot/dts/qcom/sm8750.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8750.dtsi
@@ -233,53 +233,59 @@ psci {
 
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
+			domain-idle-states = <&cluster_cl5>;
+			power-domains = <&system_pd>;
+		};
+
+		cluster1_pd: power-domain-cluster1 {
 			#power-domain-cells = <0>;
 			domain-idle-states = <&cluster_cl5>;
 			power-domains = <&system_pd>;

---
base-commit: e5d3fd687aac5eceb1721fa92b9f49afcf4c3717
change-id: 20250218-sm8750_cluster_idle-6fe358eb8c7e

Best regards,
-- 
Maulik Shah <maulik.shah@oss.qualcomm.com>


