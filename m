Return-Path: <linux-kernel+bounces-575344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F418A6FFDF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68C7E16FEB4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014DA267B85;
	Tue, 25 Mar 2025 12:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LvU8TgVN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CEA257AFF
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 12:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905845; cv=none; b=d8etnJK7IQwVQdKabLncgoBB7+q2lY4xZVBUn2c51X0sbj0OefAVoJiY83D15AYIWI6/XoTfMpLI1FK9Q1gDcj1a/r3EXbgHKkKX5LLt+bdZ0pOeYvjokU2NhGI/aj7l24n6jCEQUTjuNcTG+Kt2PxlXqjWXnG6ldTF9KH8/Fj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905845; c=relaxed/simple;
	bh=C6NTSl0+Rao98kSjPlvJlJr9IoIUUdvL89mpuJUpsPw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VEuA+yVfWXTyfx1Jwofwkup+BZ0GWnKAslUgVTE4hS6PjYGLaTR1uPRvvWuM5fv+OVxC3I9klLtAuCigoJTmX/hpQ432CXkfUc7gHxucVdrEAlHaPuhLhO1AyxM0InfFfB5FJeyKb05/4M8BfiofLNzvech1eQZt8c4ED7Mvmqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LvU8TgVN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52P5vXGn032652
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 12:30:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Djrd/4JquWX
	DbU+icEttWqizSKPX1yxwU0bvPWCgU/w=; b=LvU8TgVNJsQgO4qNIXXeQyYTk0o
	g41uEQteuyHtcgDITr2HwMbcs4g7kouzJPWmO+2pI6/sZySrhtUkv94xrAfi9SD0
	1iAjuAZXSSfrFE1m6BA7aQV6K+evsHUcaYQcBKCtTYwQPqDUyqSSHy3K1qFOR3wE
	ZFac0vkKUioFTWz8jvrnLtyqCTi6z/D6ltBvLlyyW+mKEAGrNyp36VyavVllM5D0
	ReE1j7LpUmSPAG4CVSkb2Vj7PR6q8YCP/rBnv3WKJQRHOeAi7RlbPKFmUwtcEslm
	PISAvteaO0j4CzzrF4QZc5h7F7TIffW4OH+453Zyu0AX3NsovLtRHyJy3uw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45kmd31fuv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 12:30:42 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2240a96112fso153049905ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 05:30:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742905835; x=1743510635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Djrd/4JquWXDbU+icEttWqizSKPX1yxwU0bvPWCgU/w=;
        b=K5d2g2LEuVnrA+NeNsiOigIy4jEGy6riW/YUoiL32dh1VMZlA3ZG14SO9bzi5Rf1Pz
         2mk8dKA2GyJJGOGnZYvAX31fRXsJ8JW/wKM4I8s9W1zONV+Qmu/Fmjw1rI0nKpdZJiNA
         /VrlKb1ogOqhfJo94tR4QOESdqtdtfHhgDdHEoMMyhr3EaTB6WXDBb7shZ1jGhx3UyJa
         tMBUOZWB+ZvAxJy98Wdq4Nmj0feEfmYM9D+SiiR1Juj7zllhwk5VrfkOGnt9dBl5sN1n
         3o+itDohKIS8Z1saEipcwmFZ9At60gftMC7B6qAbcxZlzh0z02iqk3i9A6tGZHiOEgDr
         JC7g==
X-Forwarded-Encrypted: i=1; AJvYcCWNIKGC9+u0t0PHq0WVLGwFWZd/Gf46tsteIvv+dNu47+AhvAJss/N/dEGe1jwYiHU/daiGXl1ZMdDq1bk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrq4e3wEzRpaAHbIEKvuOQKjkL1WYA7DuRQxaUshkiWhHPjhga
	1EY3FWFjy7L7JnnqFbSEtOR1dOH4RV9RNUMYcO1C4pG6IL92BImUcsiZzC7v8nOsgnILuKvk4A3
	xeEPNDz8ACsHkcKlMP8Fic0XOWBxjGYWeMPzcc7FqB3Dk2zQUfeWG7qW7JKEJWTU=
X-Gm-Gg: ASbGncuRoUGYnLwUPjp7Z+4ocBJ0nsALXyTt+z+t0cPtAQ6bQOknNJU3YRphhVRkvqO
	Hz0uDLhFrnVCnBaKkl4drOd+rb4ZVBjaHZOUAv3eRFrkAIMlDahq6V/DGnb0+9ZiXTKOWD2EeNf
	xWmucO1uv0gWD1Jocv3Pb9yz7R5+9XBGZ3i987LNXYj3I7VIvVxoPA8/PDjsCIdTwNc3ubKKorj
	sp20IPuvfYJavejclsjIAZ0hdssTABnb71eKRrVPMlE0Zw7kKN5omRg1JdVlpL5DJJT2tPGd90g
	tTwoSQ4xYvqK0ZgETjd5Rf27Iyd5HMqzasefTKPL4C6E
X-Received: by 2002:a05:6a00:a90:b0:736:5664:53f3 with SMTP id d2e1a72fcca58-739059ffb6bmr24496349b3a.15.1742905834134;
        Tue, 25 Mar 2025 05:30:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1+SzHyug7TlpcnU1WYoJKsScRaV4mu1kQkM4jvBkv9SbhqL2kTaoaLZnX/fcxB9EwTIMLnA==
X-Received: by 2002:a05:6a00:a90:b0:736:5664:53f3 with SMTP id d2e1a72fcca58-739059ffb6bmr24495709b3a.15.1742905828883;
        Tue, 25 Mar 2025 05:30:28 -0700 (PDT)
Received: from hu-prashk-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390618e4b6sm9987391b3a.180.2025.03.25.05.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 05:30:28 -0700 (PDT)
From: Prashanth K <prashanth.k@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prashanth K <prashanth.k@oss.qualcomm.com>
Subject: [PATCH v1 1/5] arm64: dts: qcom: sm8150: Add snps,dis_u3_susphy_quirk
Date: Tue, 25 Mar 2025 18:00:15 +0530
Message-Id: <20250325123019.597976-2-prashanth.k@oss.qualcomm.com>
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
X-Proofpoint-GUID: aeBmnc98JqTpYIYD3GWYAa3C3jRQgTdl
X-Proofpoint-ORIG-GUID: aeBmnc98JqTpYIYD3GWYAa3C3jRQgTdl
X-Authority-Analysis: v=2.4 cv=P646hjAu c=1 sm=1 tr=0 ts=67e2a1f2 cx=c_pps a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=2mEde68aHbpXMYUSS8oA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_05,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 phishscore=0 mlxlogscore=822 priorityscore=1501 bulkscore=0
 mlxscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
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
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 4dbda54b47a5..4477ec14ab1d 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -3657,6 +3657,7 @@ usb_1_dwc3: usb@a600000 {
 				interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
 				iommus = <&apps_smmu 0x140 0>;
 				snps,dis_u2_susphy_quirk;
+				snps,dis_u3_susphy_quirk;
 				snps,dis_enblslpm_quirk;
 				snps,dis-u1-entry-quirk;
 				snps,dis-u2-entry-quirk;
@@ -3736,6 +3737,7 @@ usb_2_dwc3: usb@a800000 {
 				interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
 				iommus = <&apps_smmu 0x160 0>;
 				snps,dis_u2_susphy_quirk;
+				snps,dis_u3_susphy_quirk;
 				snps,dis_enblslpm_quirk;
 				snps,dis-u1-entry-quirk;
 				snps,dis-u2-entry-quirk;
-- 
2.25.1


