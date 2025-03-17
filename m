Return-Path: <linux-kernel+bounces-564166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBE5A64F44
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 13:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCC1F3A5C8C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB6923BCF3;
	Mon, 17 Mar 2025 12:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iLDBHDrg"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4B721931C
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742215142; cv=none; b=OPqX2zZdNrDLHAVpv/zlfnEaUuMVJ+BelsUBWn0DWJpAcVEWtHwb7s5yymIv6WgMH/q2oPhD/HKSMPc85GjHGk2VjNA5TmncW40nn6E0emJAB8LUtB2GWKRr+71Onnw2y3OgJ+Pg/g7Z8DAFCAYu2Ls7M5Q7MxQWzAnMvkxV+Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742215142; c=relaxed/simple;
	bh=/hxF+PEemszqvjTSxb9E/nvqVqQPHkD9b6GWzowCc2M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jB5EKKUHgP/URgPzvzbfg5tsLZHilb/u531CKJ1wXjY2UheLIJiGMYoDd3q6ep2ii197J5TUUlpdrHOqABvBGfLhlgEqpZuTFWKDQSKRIwMOCx4xDm5EiVEbLefftiVuzgzXBEreLKK3eDXRSBY/QM4egiEGjnGnhs2+csZZR7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iLDBHDrg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52H9DEPj019140
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 12:38:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=5O/HC5QkEwB/sgub+YeiIq
	IBm/Db37yAGEHWZ6B6amE=; b=iLDBHDrgkkVOdcd03giavkO3H/mCXLhP1dkGu0
	ZbBUSsTae7CIzuYnLL3j4LhaNkW8+VdG59Tt/Dre3MiLFc56sdEQtWTdfUFCaODR
	sJOgGExdANEXmw44IpxTfruCLPXuGHhKRQJeOI8qIy6uVIP5H9u8lsDizGUyEHWv
	XDq2xqaAi1LzHGyDWszHkpQAtULqzT3hai6/JoQin3KR8O6fa/ZB2uObr14rxHyV
	6zJIPnygZ4qsF7dDRGzfCfBL+KeeKEthKn/NOepyQkgfaL9Nj+RXHHPnI+pyre+m
	+Sx4PSCLajWu8okAFQJzg9Dg2KCUFyINGsnu2Ysaoz1lWChA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45d2u9vq8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 12:38:58 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2241aad40f3so71520895ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 05:38:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742215138; x=1742819938;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5O/HC5QkEwB/sgub+YeiIqIBm/Db37yAGEHWZ6B6amE=;
        b=ejLl3/aetTP3NJPfkDyOcJ13lL/I3CKeSqOJhvXl35sBGIowIwzZ4SUHw5ooQU4Teo
         fisoxDafsOmw5JgWmfKjsit/LzBkttUSnF6KH4b3bt3Jx8fP8pu4h8CauuLJoBFOVyMm
         U8ncxa+kxJJsIhPpn+Z2mkFY7ud54u9LdkNSzhyVkMWv8/R9pl9g2gpgyRb7zySztVwG
         nPO3z7k1hPSUEMnBrBDEXo2ReWtscmavTbniOtDWu3ycZ8RvnT9tQDXudIIHY9pgIm03
         reqfl3+kMACKwotl3Blc68w9E1ChoYLPl108y6dbwJBANccR1dN3mFmajVq1x0OqEFr4
         hVEw==
X-Forwarded-Encrypted: i=1; AJvYcCXiAMJCoKufZkiFiFxaxwA73lNqu5JV/hvmHSrk8XqzIsmOQspTixaKONhLLP+2juGZWNaKTEwJCC51TwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfUf/rBcuAVUWuLfHAVCJk2DkOZsWzozC7f+zojsGN8Y3N1gKf
	7MMfvYgjiQ0TPLa1JmRmO3Tvz89aj0iZdUSESwGnOjcG6Lks2vYBogbhpJOM1s0gC17Z6BROOSa
	oojGc202E7pm/45g3yPI5xZuhRFERvLR3YNBxGStA2rqlSwtW188cEBpiWAYZnG0=
X-Gm-Gg: ASbGncuDDv2P4G27pqpGgGOu66auHFVszq8rKmm3TJhqWuAIxUd4xxC5jWPcMZaBhD1
	tZ/2juT6WoR+ZYJ9qKSlQZNe/ulg0bfb05phe0vaEktT54EunwfncKrtg7tx1WtYvtsCar+e6jf
	rYg7NxyFTh9O5x9zF+t+JMsy2SEyLboBbgc3VsjGJS0RsuAOQwWIx8I8zr0pZOmH4l6Cl+uatwD
	oC9qW/OExEKJsW+aWJ41332eNyTmsppEGDuXc1cj8FVQG7akLkiEAzYtro4CY0mpMghZOd0/eoo
	miNcWauDdjMaAI8+S/KHziR0K+mjug==
X-Received: by 2002:a17:903:2a86:b0:220:e924:99dd with SMTP id d9443c01a7336-225e0afb7c8mr177068045ad.34.1742215137841;
        Mon, 17 Mar 2025 05:38:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4/yCRYwOwoAwMt7RTrFKhfYHdnSIaSN5evYwfdr8Bx5AnBOwhQ+5deFWmfGIJynOjD7eqrA==
X-Received: by 2002:a17:903:2a86:b0:220:e924:99dd with SMTP id d9443c01a7336-225e0afb7c8mr177067775ad.34.1742215137496;
        Mon, 17 Mar 2025 05:38:57 -0700 (PDT)
Received: from [10.213.103.17] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd4da0sm73665165ad.222.2025.03.17.05.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 05:38:57 -0700 (PDT)
From: Maulik Shah <maulik.shah@oss.qualcomm.com>
Date: Mon, 17 Mar 2025 18:08:41 +0530
Subject: [PATCH] arm64: dts: qcom: qcs8300: Add RPMh sleep stats
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-add_qcom_stats-v1-1-016ae05ac4b0@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIANEX2GcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDY0Nz3cSUlPjC5Pzc+OKSxJJi3WSjRANTM5Mky8TERCWgpoKi1LTMCrC
 B0bG1tQDQj/p+YAAAAA==
X-Change-ID: 20250317-add_qcom_stats-c2a0564b9aaa
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Maulik Shah <maulik.shah@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742215134; l=998;
 i=maulik.shah@oss.qualcomm.com; s=20240109; h=from:subject:message-id;
 bh=/hxF+PEemszqvjTSxb9E/nvqVqQPHkD9b6GWzowCc2M=;
 b=ApMoYnW2DQV1NW+U+vWoQ5oTv6C65GgCV7GpBXOInpSuvH1UYme9IF0ESNY7tMH6xCZTGsdbt
 VB+xtAkISSxBg1E8phnEycIJ4ilasWGDWOpcW1GLHx5zG2O5Pz3A1pL
X-Developer-Key: i=maulik.shah@oss.qualcomm.com; a=ed25519;
 pk=bd9h5FIIliUddIk8p3BlQWBlzKEQ/YW5V+fe759hTWQ=
X-Authority-Analysis: v=2.4 cv=JsfxrN4C c=1 sm=1 tr=0 ts=67d817e2 cx=c_pps a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=ILUfUccxcQ_60TC8cKoA:9 a=QEXdDO2ut3YA:10
 a=MJ4Y7Fliwi6_CFRlaTST:22 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: arS2ELJ9GyanOxM_mXoPSNIcFPlJKb3P
X-Proofpoint-ORIG-GUID: arS2ELJ9GyanOxM_mXoPSNIcFPlJKb3P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_05,2025-03-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=853 impostorscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503170093

Add RPMh stats to read low power statistics for various subsystem
and SoC sleep modes.

Signed-off-by: Maulik Shah <maulik.shah@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs8300.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs8300.dtsi b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
index cdd412706b5b7bd2a953d20bfa9562043b20a18d..35b202a6b323de525aa8c4cad7595a8eee43326b 100644
--- a/arch/arm64/boot/dts/qcom/qcs8300.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
@@ -4262,6 +4262,11 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
 			#clock-cells = <0>;
 		};
 
+		sram@c3f0000 {
+			compatible = "qcom,rpmh-stats";
+			reg = <0x0 0x0c3f0000 0x0 0x400>;
+		};
+
 		spmi_bus: spmi@c440000 {
 			compatible = "qcom,spmi-pmic-arb";
 			reg = <0x0 0x0c440000 0x0 0x1100>,

---
base-commit: da920b7df701770e006928053672147075587fb2
change-id: 20250317-add_qcom_stats-c2a0564b9aaa

Best regards,
-- 
Maulik Shah <maulik.shah@oss.qualcomm.com>


