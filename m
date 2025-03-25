Return-Path: <linux-kernel+bounces-575343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D852AA7001E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96B16189DDA5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FCA267B70;
	Tue, 25 Mar 2025 12:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F5w7HHvw"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5839267B16
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 12:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905844; cv=none; b=U+rQXMhGBDC/AVJfCkEgd4lLMwYLwr5hGHr/nHLzyyfc1Vaj94PVSTXowTiXzwXKTtVYJOtl+P1fCN8RaHqkuSavRAVRYlaZ/Lew4KKGYVDtwLASWLyIzC/16JSW50ync8z2Ou+54OzCPvagSKcazlYWFFJ7u4sexc1xN/bkJ60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905844; c=relaxed/simple;
	bh=qilpJ4cjtgqnPO881wZb0am06aM3yLc86r4tD6NpndY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Br7A6/hDFHfxqxMxrJVzhjNF/mIrLpzX+NQyZcj/I0Fw5AS1MPnoIwDbED/xn20anYyE74C9sQrD6+z2rUHo2omPnnpFSdbVhfk9H4GJnKRbQwNDWC26Kpijq9YLnDmakor7QFD+1h1yYHxFV8HEBEQl2UOhR5y5QzghlcJy+/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F5w7HHvw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52P5vV6n002243
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 12:30:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=kPZJqI1uck7
	luBRZQDPnKRItuLHLZb+DfwEFnWKYwSI=; b=F5w7HHvwDkZ3EyRhcsddClWWlmL
	De0g3Jcbk4D4bVmXNhtsmorgoOqS6m9lVda2Je1j83GIh7fHQ1jn0DXMeaVrg3J5
	GN9j2GX7oFp4n9gZ/6JmvG380HDgEeN3xBkwFP04iMlm5L96mperhwyBook28AhN
	ioSV92aMVC7ly/oVzEk/NJh8xajXKEIRlgAhDOORBgDFCEE8LNotrBaG5R7OaKBa
	dVW7g/IhoRkJdCRMj4adIcBk5eLLwRpSB/7/7dJ5fmkXp7hbw3iSjalRWMkF1y3f
	85oROW7yZJqge/mnpf6M70z05UxJb9xefOf4HFMZqHS0iph0KJczU6KhjYA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45hn9wfs8d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 12:30:41 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-225429696a9so144978635ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 05:30:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742905836; x=1743510636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kPZJqI1uck7luBRZQDPnKRItuLHLZb+DfwEFnWKYwSI=;
        b=TrzS+72XdqzByKP1cwrmbzN3lGYeeZe7IbQqiYgA4QEoCSJFSxJog7UvjJ3dFuoFz0
         PLnu++4bZUWPk/Nug8MLu7Qn1IdYSXyQJl017dIHcIFv1GFYqo4dsSXig4+XXEYUbtD5
         ncGBEDug3uyF96Rb0Q84grVd4BYvCn36nGvHEiVP6hEXb91ZDA37Z/6yFDQmFfqsGHgB
         vht1goGgoKsuAZjVeviMvMPUY+gWRYvlsELETO0CYmpxgG8F5FohxbliUcEUEOtHT4+x
         ZEzFQgvTSK7JvreBzrYv7Xoo6B58mxy2SeXlBzGlhviCwEX/9npv6QGZUY4He3xUe3ru
         +ikA==
X-Forwarded-Encrypted: i=1; AJvYcCXzMhsa9M14lmw9DSKGdliiRM0f2fSSknY0O1pTmhGX3s4YAIKD5NXObz1M7GBmllw/WGKI4DN/ix09qPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU2BAghsKFjMJJ6Mvh8ZI6vdRhOrhCRy9O2wpn+YD0qrBGaAhG
	dTfilj2RDsb2U3emTmLRuY+KcObk6Pcxq5c4WoADtOGZrJO8CbiHG/UGo+3IItaJurxkDGWHXsz
	CpvJ+JekFHTgZGSeiLOjeGf5w81aUg1h2qTvtD6wZT9LKrIRPDahdrty8vD9Cfr8=
X-Gm-Gg: ASbGncvCjU+EQke3xQU7gl+KZoI5pLadLRVHuSOY/PTXagXBicYp57FXV/fTmTIN9Xn
	s0A04e+FftAusWMYoH36iEzFFs3agK5Yv9tsJzZL63I9GJqW1sKam7TqtXKArDfVPv+9MnDAq3u
	FEplwaK32yiPbo8ekTIwP5vQzFllmGP6poD7F4FueEBhNI/YlNK3M0O/O/2zCQJEyDHy29rDyMQ
	/zOpiRAg5LOQvbUpis2MiT7xtdQNJoL3mvwx16V4WrHpqdabeF/A0z4pCGs1P1p5CSFyZoaHn/8
	EFPbXcm/OaICJjJGaLnIfQov9Fs0y6ZNAil30mUwswMH
X-Received: by 2002:a05:6a00:8017:b0:736:4536:26cc with SMTP id d2e1a72fcca58-73905a2786bmr29132411b3a.23.1742905836248;
        Tue, 25 Mar 2025 05:30:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcDgZuM5dlRYn7F5OTGm0QqT+WC/cQOltrUZIrZSAh8E4Gc4dpW0xBXL4OpnIbD0hldQ5kFw==
X-Received: by 2002:a05:6a00:8017:b0:736:4536:26cc with SMTP id d2e1a72fcca58-73905a2786bmr29132315b3a.23.1742905835547;
        Tue, 25 Mar 2025 05:30:35 -0700 (PDT)
Received: from hu-prashk-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390618e4b6sm9987391b3a.180.2025.03.25.05.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 05:30:35 -0700 (PDT)
From: Prashanth K <prashanth.k@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prashanth K <prashanth.k@oss.qualcomm.com>
Subject: [PATCH v1 3/5] arm64: dts: qcom: sm8450: Add snps,dis_u3_susphy_quirk
Date: Tue, 25 Mar 2025 18:00:17 +0530
Message-Id: <20250325123019.597976-4-prashanth.k@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250325123019.597976-1-prashanth.k@oss.qualcomm.com>
References: <20250325123019.597976-1-prashanth.k@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: iM05OUo51xig-n4Zuitgui28FKmk-E4e
X-Proofpoint-ORIG-GUID: iM05OUo51xig-n4Zuitgui28FKmk-E4e
X-Authority-Analysis: v=2.4 cv=CPoqXQrD c=1 sm=1 tr=0 ts=67e2a1f1 cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=1HEuz3GWIXJSLhVaKDMA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_05,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=883
 spamscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503250088

During device mode initialization on certain QC targets, before the
runstop bit is set, sometimes it's observed that the GEVNTADR{LO/HI}
register write fails. As a result, GEVTADDR registers are still 0x0.
Upon setting runstop bit, DWC3 controller attempts to write the new
events to address 0x0, causing an SMMU fault and system crash.

This was initially observed on SM8450 and later reported on few
other targets as well. As suggested by Qualcomm HW team, clearing
the GUSB3PIPECTL.SUSPHY bit resolves the issue by preventing register
write failures. Address this by setting the snps,dis_u3_susphy_quirk
to keep the GUSB3PIPECTL.SUSPHY bit cleared. This change was tested
on multiple targets (SM8350, SM8450 QCS615 etc.) for over an year
and hasn't exhibited any side effects.

Signed-off-by: Prashanth K <prashanth.k@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 0b36f4cd4497..58c98bffee17 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -5461,6 +5461,7 @@ usb_1_dwc3: usb@a600000 {
 				interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
 				iommus = <&apps_smmu 0x0 0x0>;
 				snps,dis_u2_susphy_quirk;
+				snps,dis_u3_susphy_quirk;
 				snps,dis_enblslpm_quirk;
 				snps,dis-u1-entry-quirk;
 				snps,dis-u2-entry-quirk;
-- 
2.25.1


