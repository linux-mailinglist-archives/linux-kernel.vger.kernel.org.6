Return-Path: <linux-kernel+bounces-535191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB88A46FFF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81E3C3AC4C7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 00:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1ED214F9F9;
	Thu, 27 Feb 2025 00:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j3l93BQs"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FF070814
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 00:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740615118; cv=none; b=GOi/o10kv5kYMKZ8Nsat+dwR53lnYLFv6m76LWtdsMXpo5yvCMHqvTCkV0wZTZeioIrAngVf6ziJUf/32z/hC2VQ05z0TzERI0ojLGnsuvD1BTLoenjQKknpSkrzkvBYn8FvcsliLIY/lV2rQ6DiTC8F387Ukzr1yHVJbBydOfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740615118; c=relaxed/simple;
	bh=QZCpZlu53quw6nL6TnKxy5fmS1nRzhqSoUP2GUKX9/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P6JU1jcDP81Q9Mx/KANAU3wCQsi15AgeuMZ175EVdIWj5NLH9Ce2IIHos32PDogXtSx7dj6S4iH1PycrKr3gTTUjqst6/OGDnb+7Hza5MUcQhh/02x7BIs7iPmEWE6yh7OqHL4r8wnkg7Jzl9nlIOnXi1HCFasUg28K2pCw7DHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j3l93BQs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QK588x015362
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 00:11:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7sVaiMs2t/yghLl4ZXum6gfPzebES0AYVlGI7YtV98s=; b=j3l93BQsPmbKgFo8
	yXqGtSddVGsD3+Stq+UeW0xH4AKzvjwA4bdIfSWE6zbZUL0gwx915eoV2KtYNSuo
	jXSIl0bkL2+Af50RjhkVJ+DycC/hGN4T7gxs/+FQlnBKeAe4JWVELod8X1+ZtWtI
	qOZSPYR9aGMIStZh9dIznfdKKcVO0w2CZKKyLdQW8bMRCyj15NBSg32IbzLbE3nR
	HfHbNtDOcXpQ/2orUSvShYze+OXYE7rdJG9r0Mt93UmJ1jqqAOYEpQO1rw8BRN36
	JptxV6cGBRO96m/1LucfmdIYqMkaHOG5QXabwHQnxgGNsmyngzN+Pe/03rQfx/pi
	m/5DIA==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451prnkpqs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 00:11:54 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3f3fbe101f7so341612b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 16:11:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740615114; x=1741219914;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7sVaiMs2t/yghLl4ZXum6gfPzebES0AYVlGI7YtV98s=;
        b=jDHrs5Kkqk/zFzoYp4VNrJysN1Rn6UOhMEIoWxKCrUwoIbhnAtpUduKgbnIpFdnXw6
         VS0rxTfeNCTUyqbPGxsqGbRD8Jy2zPSv/MHvNnoe93Mj2O6tOMgDoDNhK9TtVua+KE/K
         khTtpmPhy96n744zXm0z8z5qpjFGMT/FS7LCCFD9edRsmRzDLgrzAFAebCmTLnj7OnqY
         R8p5gQ+TugeXD58cPAgq9NE53rLHt+zMbEIMhkFjKm3gmQZ9gKTukrl4GTDRsrhknELj
         rFqaXtGOdd20AHHimEYOtdL6hRtcWxhBb9TbqhyFomV2frv36KFsp/buAd8XxBYLPWxJ
         2AMw==
X-Forwarded-Encrypted: i=1; AJvYcCXIQZZXOxFir4RI3A+CeD8RkPLo/AayK1Bp3O3L98+bY7w53XS9Pz8+YB5nyvhOFm63/hMG9anecu0H9GY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR/mfVgtED9ZRavq3bkg/YJLlrTyo50U6V2r0qPLBJbfqqHU+2
	qHwoaV6BqcLl332G3M21Wo0IzOmTYqE8Z15MLzDDytsaCEulYUtX06OPk9xbcAGvlmfdcrh4RFe
	Hj5GLWr3mSyGdlzHPXTuernBMTJVk3lDRU+mvZIcV/mecv4i1RYBqn3MyjOVb1dc=
X-Gm-Gg: ASbGncuKOdZ8mfhbVbjgMckV3121gUpz9/FIPIdGCt0lx0cE6XhY7QiDMqp2yj18B+V
	SQ5slCpCxnCNmh+wsKuDe+3dYaUaQOn1JFyCiz+/e6n7k1Tnd5kxIKuJ8SU6zTuzADVQbTGhbDf
	PRACoD2UzZ3bY+2CzBOR+CTji6U3o5bug0SnHumwDfIecPZR363pdiCCGsjmLoQwZyWcEMRH1fl
	9pWfrgTwm6utakouNcY7O2BR7j5BaE+mRfulJrPH+Uatx9nLsxnK+HG4VTywSkFbYfcVw/6bDrZ
	Ggqdbpyh6PNtFLWfFnnSIVh7xVjKzONQvk3GjDFNNlkG392c4aLMttsPwHIJpjPtGY2pkeEPFvd
	VHkYCfrghOh84mkQ=
X-Received: by 2002:a05:6808:2f1b:b0:3f4:1d3:b64e with SMTP id 5614622812f47-3f547e3a51cmr3153559b6e.28.1740615113516;
        Wed, 26 Feb 2025 16:11:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEz12bIBQsr4nK93FSyPKMSCUl2KIJYpv2rvkY4dotioPJA0yGhdMzQznWTdCf6EYAGzyKhQQ==
X-Received: by 2002:a05:6808:2f1b:b0:3f4:1d3:b64e with SMTP id 5614622812f47-3f547e3a51cmr3153538b6e.28.1740615113147;
        Wed, 26 Feb 2025 16:11:53 -0800 (PST)
Received: from [192.168.86.65] (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f5507c40c6sm33988b6e.45.2025.02.26.16.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 16:11:52 -0800 (PST)
From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Date: Wed, 26 Feb 2025 16:17:54 -0800
Subject: [PATCH v4 7/7] arm64: dts: qcom: sc8280x: Flatten the USB nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-dwc3-refactor-v4-7-4415e7111e49@oss.qualcomm.com>
References: <20250226-dwc3-refactor-v4-0-4415e7111e49@oss.qualcomm.com>
In-Reply-To: <20250226-dwc3-refactor-v4-0-4415e7111e49@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Saravana Kannan <saravanak@google.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Frank Li <Frank.li@nxp.com>
Cc: linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13628;
 i=bjorn.andersson@oss.qualcomm.com; h=from:subject:message-id;
 bh=QZCpZlu53quw6nL6TnKxy5fmS1nRzhqSoUP2GUKX9/c=;
 b=owEBgwJ8/ZANAwAIAQsfOT8Nma3FAcsmYgBnv684HKcj/LU0YRimWXlZfb1oENn1uGyR9QiHP
 XsReIu6WwaJAkkEAAEIADMWIQQF3gPMXzXqTwlm1SULHzk/DZmtxQUCZ7+vOBUcYW5kZXJzc29u
 QGtlcm5lbC5vcmcACgkQCx85Pw2ZrcVggg/9HcXAYm1W+vm4lNilU8Ehnfpa4mENzQW+vaCfJrp
 3QjWETR5BVYQEDD34Jwi4gn05OeV8r/m4M174d7ZZITe40/q+4LOy3cYOkGWtGimmCJ5R3hiOnf
 caCg1TxsSFiwUbDgJxwFswATsFiRR/D9vOFq2slk6npxEFpBRzQIsyMJAh8YAH8JCpg1KeOFpGt
 dpIkd6guBufBtB5251JjHPBYMOHSILvKFlq5fiBsMSOGCKueC9Rszdll3kEWy6suyDEgEhmzXg0
 n9agYZjKa/qTG/VmfOJZFpBYawTQZZS/5suPBnC5RsEBND9eybeHbSScP8GD7L6PNElNPk5WRbG
 roM/uz9Ua2wiRBSU2liyPiHPLZtDP76nEMOA4lieRJSRk2F1PSdGezK5RHOSRI5fMO4A/xC7AXr
 SZRkQHELwVUQbuSZSRrIQOHvkr3mV79CkSSyyxbfkZ8A3bqQR47d2oyhFOJ16Kf2F5FG8sbkt/1
 oymLVDaejE68XudZqMwv4mUZe40QUls52jcpNbtE3GoHDcPOMIe9wMshFB+cAWPjHljurqIxPI/
 ISy1Tv/wOh/m9kG7/Ar6lDELOeQSNV1fstKbAxMCZXvH1g0ckAQh17KrBtlPLhXrQZKnbCw7dEd
 BX7mTtua7Hs9+m4Pm1ZadQjISFom5xvS+qtQkhTS3fm4=
X-Developer-Key: i=bjorn.andersson@oss.qualcomm.com; a=openpgp;
 fpr=05DE03CC5F35EA4F0966D5250B1F393F0D99ADC5
X-Proofpoint-GUID: RrX2uq31eQDAw1_5cXxeECMcwprambCr
X-Proofpoint-ORIG-GUID: RrX2uq31eQDAw1_5cXxeECMcwprambCr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_07,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502270000

Transition the three USB controllers found in sc8280xp to the newly
introduced, flattened representation of the Qualcomm USB block, i.e.
qcom,snps-dwc3, to show the end result.

The reg and interrupts properties from the usb child node are merged
with their counterpart in the outer node, remaining properties and child
nodes are simply moved.

Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sa8295p-adp.dts           |  12 +-
 arch/arm64/boot/dts/qcom/sa8540p-ride.dts          |   5 +-
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts          |  12 +-
 .../boot/dts/qcom/sc8280xp-huawei-gaokun3.dts      |  10 +-
 .../dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts     |  11 +-
 .../boot/dts/qcom/sc8280xp-microsoft-arcata.dts    |  10 +-
 .../boot/dts/qcom/sc8280xp-microsoft-blackrock.dts |  18 +--
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi             | 157 ++++++++++-----------
 8 files changed, 95 insertions(+), 140 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
index 2fd1dafe63ce..3d84cbf5af31 100644
--- a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
+++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
@@ -631,12 +631,10 @@ &ufs_card_phy {
 };
 
 &usb_0 {
-	status = "okay";
-};
-
-&usb_0_dwc3 {
 	/* TODO: Define USB-C connector properly */
 	dr_mode = "peripheral";
+
+	status = "okay";
 };
 
 &usb_0_hsphy {
@@ -655,12 +653,10 @@ &usb_0_qmpphy {
 };
 
 &usb_1 {
-	status = "okay";
-};
-
-&usb_1_dwc3 {
 	/* TODO: Define USB-C connector properly */
 	dr_mode = "host";
+
+	status = "okay";
 };
 
 &usb_1_hsphy {
diff --git a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
index 177b9dad6ff7..7be803fb7cbe 100644
--- a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
@@ -466,11 +466,8 @@ &ufs_mem_phy {
 };
 
 &usb_0 {
-	status = "okay";
-};
-
-&usb_0_dwc3 {
 	dr_mode = "peripheral";
+	status = "okay";
 };
 
 &usb_0_hsphy {
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
index 75adaa19d1c3..05fe5793f1f1 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
@@ -795,11 +795,9 @@ &ufs_mem_phy {
 };
 
 &usb_0 {
-	status = "okay";
-};
-
-&usb_0_dwc3 {
 	dr_mode = "host";
+
+	status = "okay";
 };
 
 &usb_0_dwc3_hs {
@@ -832,11 +830,9 @@ &usb_0_qmpphy_out {
 };
 
 &usb_1 {
-	status = "okay";
-};
-
-&usb_1_dwc3 {
 	dr_mode = "host";
+
+	status = "okay";
 };
 
 &usb_1_dwc3_hs {
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-huawei-gaokun3.dts b/arch/arm64/boot/dts/qcom/sc8280xp-huawei-gaokun3.dts
index 09b95f89ee58..300c7dc999a4 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-huawei-gaokun3.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-huawei-gaokun3.dts
@@ -997,11 +997,8 @@ bluetooth {
 };
 
 &usb_0 {
-	status = "okay";
-};
-
-&usb_0_dwc3 {
 	dr_mode = "host";
+	status = "okay";
 };
 
 &usb_0_hsphy {
@@ -1026,11 +1023,8 @@ &usb_0_qmpphy_dp_in {
 };
 
 &usb_1 {
-	status = "okay";
-};
-
-&usb_1_dwc3 {
 	dr_mode = "host";
+	status = "okay";
 };
 
 &usb_1_hsphy {
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index f3190f408f4b..1b9501cc82f4 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -1343,11 +1343,9 @@ bluetooth {
 };
 
 &usb_0 {
-	status = "okay";
-};
-
-&usb_0_dwc3 {
 	dr_mode = "host";
+
+	status = "okay";
 };
 
 &usb_0_dwc3_hs {
@@ -1380,11 +1378,8 @@ &usb_0_qmpphy_out {
 };
 
 &usb_1 {
-	status = "okay";
-};
-
-&usb_1_dwc3 {
 	dr_mode = "host";
+	status = "okay";
 };
 
 &usb_1_dwc3_hs {
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-arcata.dts b/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-arcata.dts
index ae5daeac8fe2..82672f441ea2 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-arcata.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-arcata.dts
@@ -749,11 +749,8 @@ embedded-controller {
 };
 
 &usb_0 {
-	status = "okay";
-};
-
-&usb_0_dwc3 {
 	dr_mode = "host";
+	status = "okay";
 };
 
 &usb_0_dwc3_hs {
@@ -786,11 +783,8 @@ &usb_0_qmpphy_out {
 };
 
 &usb_1 {
-	status = "okay";
-};
-
-&usb_1_dwc3 {
 	dr_mode = "host";
+	status = "okay";
 };
 
 &usb_1_dwc3_hs {
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-blackrock.dts b/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-blackrock.dts
index fa9d94105052..eeb69cfd4422 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-blackrock.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-blackrock.dts
@@ -982,11 +982,9 @@ bluetooth {
 };
 
 &usb_0 {
-	status = "okay";
-};
-
-&usb_0_dwc3 {
 	dr_mode = "host";
+
+	status = "okay";
 };
 
 &usb_0_dwc3_hs {
@@ -1019,11 +1017,9 @@ &usb_0_qmpphy_out {
 };
 
 &usb_1 {
-	status = "okay";
-};
-
-&usb_1_dwc3 {
 	dr_mode = "host";
+
+	status = "okay";
 };
 
 &usb_1_dwc3_hs {
@@ -1059,12 +1055,10 @@ &usb_2 {
 	pinctrl-0 = <&usb2_en_state>;
 	pinctrl-names = "default";
 
-	status = "okay";
-};
-
-&usb_2_dwc3 {
 	phys = <&usb_2_hsphy0>, <&usb_2_qmpphy0>;
 	phy-names = "usb2-0", "usb3-0";
+
+	status = "okay";
 };
 
 &usb_2_hsphy0 {
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 01501acb1790..3dea86b0e13d 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -3457,12 +3457,9 @@ system-cache-controller@9200000 {
 			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-		usb_2: usb@a4f8800 {
-			compatible = "qcom,sc8280xp-dwc3-mp", "qcom,dwc3";
-			reg = <0 0x0a4f8800 0 0x400>;
-			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges;
+		usb_2: usb@a400000 {
+			compatible = "qcom,sc8280xp-dwc3-mp", "qcom,snps-dwc3";
+			reg = <0 0x0a400000 0 0x10000>;
 
 			clocks = <&gcc GCC_CFG_NOC_USB3_MP_AXI_CLK>,
 				 <&gcc GCC_USB30_MP_MASTER_CLK>,
@@ -3480,7 +3477,8 @@ usb_2: usb@a4f8800 {
 					  <&gcc GCC_USB30_MP_MASTER_CLK>;
 			assigned-clock-rates = <19200000>, <200000000>;
 
-			interrupts-extended = <&intc GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
+			interrupts-extended = <&intc GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
 					      <&intc GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
 					      <&intc GIC_SPI 857 IRQ_TYPE_LEVEL_HIGH>,
 					      <&intc GIC_SPI 856 IRQ_TYPE_LEVEL_HIGH>,
@@ -3499,7 +3497,8 @@ usb_2: usb@a4f8800 {
 					      <&pdc 16 IRQ_TYPE_LEVEL_HIGH>,
 					      <&pdc 17 IRQ_TYPE_LEVEL_HIGH>;
 
-			interrupt-names = "pwr_event_1", "pwr_event_2",
+			interrupt-names = "dwc_usb3",
+					  "pwr_event_1", "pwr_event_2",
 					  "pwr_event_3", "pwr_event_4",
 					  "hs_phy_1",	 "hs_phy_2",
 					  "hs_phy_3",	 "hs_phy_4",
@@ -3509,6 +3508,7 @@ usb_2: usb@a4f8800 {
 					  "dp_hs_phy_4", "dm_hs_phy_4",
 					  "ss_phy_1",	 "ss_phy_2";
 
+			iommus = <&apps_smmu 0x800 0x0>;
 			power-domains = <&gcc USB30_MP_GDSC>;
 			required-opps = <&rpmhpd_opp_nom>;
 
@@ -3518,35 +3518,28 @@ usb_2: usb@a4f8800 {
 					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_USB3_MP 0>;
 			interconnect-names = "usb-ddr", "apps-usb";
 
+			phys = <&usb_2_hsphy0>, <&usb_2_qmpphy0>,
+			       <&usb_2_hsphy1>, <&usb_2_qmpphy1>,
+			       <&usb_2_hsphy2>,
+			       <&usb_2_hsphy3>;
+			phy-names = "usb2-0", "usb3-0",
+				    "usb2-1", "usb3-1",
+				    "usb2-2",
+				    "usb2-3";
+
 			wakeup-source;
 
+			dr_mode = "host";
+
+			snps,dis-u1-entry-quirk;
+			snps,dis-u2-entry-quirk;
+
 			status = "disabled";
+		};
 
-			usb_2_dwc3: usb@a400000 {
-				compatible = "snps,dwc3";
-				reg = <0 0x0a400000 0 0xcd00>;
-				interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
-				iommus = <&apps_smmu 0x800 0x0>;
-				phys = <&usb_2_hsphy0>, <&usb_2_qmpphy0>,
-				       <&usb_2_hsphy1>, <&usb_2_qmpphy1>,
-				       <&usb_2_hsphy2>,
-				       <&usb_2_hsphy3>;
-				phy-names = "usb2-0", "usb3-0",
-					    "usb2-1", "usb3-1",
-					    "usb2-2",
-					    "usb2-3";
-				dr_mode = "host";
-				snps,dis-u1-entry-quirk;
-				snps,dis-u2-entry-quirk;
-			};
-		};
-
-		usb_0: usb@a6f8800 {
-			compatible = "qcom,sc8280xp-dwc3", "qcom,dwc3";
-			reg = <0 0x0a6f8800 0 0x400>;
-			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges;
+		usb_0: usb@a600000 {
+			compatible = "qcom,sc8280xp-dwc3", "qcom,snps-dwc3";
+			reg = <0 0x0a600000 0 0x20000>;
 
 			clocks = <&gcc GCC_CFG_NOC_USB3_PRIM_AXI_CLK>,
 				 <&gcc GCC_USB30_PRIM_MASTER_CLK>,
@@ -3564,17 +3557,20 @@ usb_0: usb@a6f8800 {
 					  <&gcc GCC_USB30_PRIM_MASTER_CLK>;
 			assigned-clock-rates = <19200000>, <200000000>;
 
-			interrupts-extended = <&intc GIC_SPI 804 IRQ_TYPE_LEVEL_HIGH>,
+			interrupts-extended = <&intc GIC_SPI 803 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 804 IRQ_TYPE_LEVEL_HIGH>,
 					      <&intc GIC_SPI 805 IRQ_TYPE_LEVEL_HIGH>,
 					      <&pdc 14 IRQ_TYPE_EDGE_BOTH>,
 					      <&pdc 15 IRQ_TYPE_EDGE_BOTH>,
 					      <&pdc 138 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "pwr_event",
+			interrupt-names = "dwc_usb3",
+					  "pwr_event",
 					  "hs_phy_irq",
 					  "dp_hs_phy_irq",
 					  "dm_hs_phy_irq",
 					  "ss_phy_irq";
 
+			iommus = <&apps_smmu 0x820 0x0>;
 			power-domains = <&gcc USB30_PRIM_GDSC>;
 			required-opps = <&rpmhpd_opp_nom>;
 
@@ -3584,45 +3580,40 @@ usb_0: usb@a6f8800 {
 					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_USB3_0 0>;
 			interconnect-names = "usb-ddr", "apps-usb";
 
+			phys = <&usb_0_hsphy>, <&usb_0_qmpphy QMP_USB43DP_USB3_PHY>;
+			phy-names = "usb2-phy", "usb3-phy";
+
 			wakeup-source;
 
-			status = "disabled";
+			snps,dis-u1-entry-quirk;
+			snps,dis-u2-entry-quirk;
 
-			usb_0_dwc3: usb@a600000 {
-				compatible = "snps,dwc3";
-				reg = <0 0x0a600000 0 0xcd00>;
-				interrupts = <GIC_SPI 803 IRQ_TYPE_LEVEL_HIGH>;
-				iommus = <&apps_smmu 0x820 0x0>;
-				phys = <&usb_0_hsphy>, <&usb_0_qmpphy QMP_USB43DP_USB3_PHY>;
-				phy-names = "usb2-phy", "usb3-phy";
-				snps,dis-u1-entry-quirk;
-				snps,dis-u2-entry-quirk;
+			status = "disabled";
 
-				ports {
-					#address-cells = <1>;
-					#size-cells = <0>;
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
 
-					port@0 {
-						reg = <0>;
+				port@0 {
+					reg = <0>;
 
-						usb_0_dwc3_hs: endpoint {
-						};
+					usb_0_dwc3_hs: endpoint {
 					};
+				};
 
-					port@1 {
-						reg = <1>;
+				port@1 {
+					reg = <1>;
 
-						usb_0_dwc3_ss: endpoint {
-							remote-endpoint = <&usb_0_qmpphy_usb_ss_in>;
-						};
+					usb_0_dwc3_ss: endpoint {
+						remote-endpoint = <&usb_0_qmpphy_usb_ss_in>;
 					};
 				};
 			};
 		};
 
-		usb_1: usb@a8f8800 {
-			compatible = "qcom,sc8280xp-dwc3", "qcom,dwc3";
-			reg = <0 0x0a8f8800 0 0x400>;
+		usb_1: usb@a800000 {
+			compatible = "qcom,sc8280xp-dwc3", "qcom,snps-dwc3";
+			reg = <0 0x0a800000 0 0x10000>;
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges;
@@ -3643,17 +3634,20 @@ usb_1: usb@a8f8800 {
 					  <&gcc GCC_USB30_SEC_MASTER_CLK>;
 			assigned-clock-rates = <19200000>, <200000000>;
 
-			interrupts-extended = <&intc GIC_SPI 811 IRQ_TYPE_LEVEL_HIGH>,
+			interrupts-extended = <&intc GIC_SPI 810 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 811 IRQ_TYPE_LEVEL_HIGH>,
 					      <&intc GIC_SPI 790 IRQ_TYPE_LEVEL_HIGH>,
 					      <&pdc 12 IRQ_TYPE_EDGE_BOTH>,
 					      <&pdc 13 IRQ_TYPE_EDGE_BOTH>,
 					      <&pdc 136 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "pwr_event",
+			interrupt-names = "dwc_usb3",
+					  "pwr_event",
 					  "hs_phy_irq",
 					  "dp_hs_phy_irq",
 					  "dm_hs_phy_irq",
 					  "ss_phy_irq";
 
+			iommus = <&apps_smmu 0x860 0x0>;
 			power-domains = <&gcc USB30_SEC_GDSC>;
 			required-opps = <&rpmhpd_opp_nom>;
 
@@ -3663,37 +3657,32 @@ usb_1: usb@a8f8800 {
 					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_USB3_1 0>;
 			interconnect-names = "usb-ddr", "apps-usb";
 
+			phys = <&usb_1_hsphy>, <&usb_1_qmpphy QMP_USB43DP_USB3_PHY>;
+			phy-names = "usb2-phy", "usb3-phy";
+
 			wakeup-source;
 
-			status = "disabled";
+			snps,dis-u1-entry-quirk;
+			snps,dis-u2-entry-quirk;
 
-			usb_1_dwc3: usb@a800000 {
-				compatible = "snps,dwc3";
-				reg = <0 0x0a800000 0 0xcd00>;
-				interrupts = <GIC_SPI 810 IRQ_TYPE_LEVEL_HIGH>;
-				iommus = <&apps_smmu 0x860 0x0>;
-				phys = <&usb_1_hsphy>, <&usb_1_qmpphy QMP_USB43DP_USB3_PHY>;
-				phy-names = "usb2-phy", "usb3-phy";
-				snps,dis-u1-entry-quirk;
-				snps,dis-u2-entry-quirk;
+			status = "disabled";
 
-				ports {
-					#address-cells = <1>;
-					#size-cells = <0>;
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
 
-					port@0 {
-						reg = <0>;
+				port@0 {
+					reg = <0>;
 
-						usb_1_dwc3_hs: endpoint {
-						};
+					usb_1_dwc3_hs: endpoint {
 					};
+				};
 
-					port@1 {
-						reg = <1>;
+				port@1 {
+					reg = <1>;
 
-						usb_1_dwc3_ss: endpoint {
-							remote-endpoint = <&usb_1_qmpphy_usb_ss_in>;
-						};
+					usb_1_dwc3_ss: endpoint {
+						remote-endpoint = <&usb_1_qmpphy_usb_ss_in>;
 					};
 				};
 			};

-- 
2.45.2


