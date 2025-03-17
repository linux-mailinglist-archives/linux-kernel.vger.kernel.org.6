Return-Path: <linux-kernel+bounces-564819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 582D3A65B55
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8405018991B6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBA41E5208;
	Mon, 17 Mar 2025 17:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J4Cqq/sa"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECFC1E1E03
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 17:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742233507; cv=none; b=tBSKY0dPr6WZrHYWvfvfQhXKPPNMTi+eO54CsCkLzM6anYsCy6irFOR3W/v38J7r0eBfnZn/rdwKLySAvZxK5epYojgwXB66dBERzc7nRnnsYfZL6LNvDo86sLYEund2crlm1DaOqaW9fv2i+iFVWaYrAVb5RTvRMGBwU7sh7BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742233507; c=relaxed/simple;
	bh=jexDBYn9BNqo5ubVBhdyniVFq50lVyAorid4LoYZ4a8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y7KT2w9Hos/cEo5u/TuoxD6gNGVFZJZDTRXpju6KYJboRdgVOas4Z3OArLxj3K7G47P4gObdo2nWJFRk2Js+gviGrB/Q0iMFn6L+UayDWDfQX8G4aebygemWeB/Bl+/gFi2TtQWNxi7APYw0fICQhdejhTohpzlhi6b+ZS+uxuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J4Cqq/sa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52HA4YAk025359
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 17:45:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PZ4TVLTWNx/gGQLOA3+7bg0q2y6wNvK2yyuXjQgEGjk=; b=J4Cqq/saBNeR6xDU
	KdCrWM3ZHY8mdkcj8vR59Q2rf5RCerBW1LVUBGyUnw7p5x5hwGkiWW0Ft3ULr7+i
	ui7YSWnnOTNLdtFFkles5Wx936lVAAv3SFsjtB/ZUxr6xYWv3cs4UFu+udQVBJZO
	beYFqSey1eR3oJUhDVaLAMgko4kGN5UmuXl2t2Fh1T/TwrpJqyx/BQRciq8azisX
	VEtchdXjufztadLVxnngZIRxAYbLKpKzkVsVgjyqonsQMmG/torf1UhCsof+Jn1/
	w8FzLXig7wzvX6FiSreKYG19M7m89rhcZjjioFTj6fjcyz73JUPQ5wC2/91mhUJl
	L6gpTA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45d1s3wjwy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 17:45:03 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e8f9057432so102273026d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742233502; x=1742838302;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PZ4TVLTWNx/gGQLOA3+7bg0q2y6wNvK2yyuXjQgEGjk=;
        b=cJcP3Mu5C80wH7m3pwTxuXjsxhlG4LxEdvmZjx9x0M5t3VuPoXPMG4vhJYZj97CZxD
         D2hlXfn8Y9gJ1DTDnF6Y3Gfxoz4KBfqN6GfTkRWQVlGqTOrPPn63gWVC0zWE1kmieoSw
         xU4nuji/sS+6h6g5fEa0KOd2XFnm76He1hu4DC7TpxhLU2iPC0n51GIaRbPCNcgJ1W22
         vGamDG7S9SOEyh5b0Le026k0GvRdJ25rLRL6WM6VGTR9+0jdYPPSXm2uYp0A6jnmiI+1
         mdtw35EZLgoNomXu6otREuw66rXJ1ae/Y5hPS02p2Xxtn7LqyF4hEd7vW6uAhxJ27dtE
         yPsA==
X-Forwarded-Encrypted: i=1; AJvYcCXfeKLfdC+rdtECL5FxI36wfzCACC3IhC+6NBXRhfnQGpRFdFhbZNHoSSMQdTKkIb6bi8DFF1jLQMgTDs4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx22ZFZCtGcr8+vOMf4uHlEC/W5/Sh+GHWVhaFyugqNv9aZJDES
	aTquxPeX+XpNoeXnF9dtLkPAmN/PCkeYqYceV7EEtvI872tb65HtUjaUS7Azu5qXEFyu1/MA3tL
	LNgy/x4trVa8K+z8x2nsUvpAsfiwv0MdWIT8qGjFyn4ZynhzefuyixW6yOytyHB8=
X-Gm-Gg: ASbGncsL/UsOzOD9xhQCXv9HGk+K+GQv2rmlLC7hkTbLyAaTpgr6f1jKe2CC6NY2+yq
	4FQK+h8qgCkqzs9VwztBegUXKuwn2fMv1YspchYaHhomvD5LC0qQZzpPzmOF0FAVzPXa/UvCIMO
	MxhcVkRzBLheKRcGmFgt+oLEA6plbv62EFKkl6nAX7F67UUxY5+eVcBfPHBKTmbqxZpZZ9Qu3Rn
	zb7hK1kM8np/jPpmwlMDeOPur+SyRP9avmYCn9JHNPsB6j30otNWPjRjpqX67rE4ZB2nkH9rdj6
	So27Zx9C8bh8toIca62G3iOkbzvIKzBrCcy/wud3iyIswUqiXnbJapUmy0PCb47WJ/TsJbTHpCz
	stTjkv2JkO2E2k/eTaQMwBx8pYDTa
X-Received: by 2002:ad4:5f46:0:b0:6d4:238e:35b0 with SMTP id 6a1803df08f44-6eaea9fac05mr187988556d6.17.1742233502179;
        Mon, 17 Mar 2025 10:45:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbtkhZoh7ZKjpQve+rs4/e9Pgietbgyg5OyGK6q/QtHdKWWg1YEVRp+W9jdcYyAx96l9bmHw==
X-Received: by 2002:ad4:5f46:0:b0:6d4:238e:35b0 with SMTP id 6a1803df08f44-6eaea9fac05mr187988106d6.17.1742233501747;
        Mon, 17 Mar 2025 10:45:01 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f0e9985sm16687121fa.29.2025.03.17.10.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 10:44:59 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 17 Mar 2025 19:44:41 +0200
Subject: [PATCH 6/9] ARM: dts: qcom: apq8064 merge hw splinlock into
 corresponding syscon device
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-fix-nexus-4-v1-6-655c52e2ad97@oss.qualcomm.com>
References: <20250317-fix-nexus-4-v1-0-655c52e2ad97@oss.qualcomm.com>
In-Reply-To: <20250317-fix-nexus-4-v1-0-655c52e2ad97@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linux.dev>, Kumar Gala <galak@codeaurora.org>,
        Andy Gross <agross@codeaurora.org>,
        "Ivan T. Ivanov" <ivan.ivanov@linaro.org>,
        Andy Gross <andy.gross@linaro.org>, Georgi Djakov <djakov@kernel.org>,
        David Heidelberg <david@ixit.cz>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1360;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=jexDBYn9BNqo5ubVBhdyniVFq50lVyAorid4LoYZ4a8=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBn2F+HrvJahQkZGPwOjUg+kkUB7W4G48kd9aCWw
 r7W1ash9DeJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ9hfhwAKCRCLPIo+Aiko
 1RTFCACyTCsSbBBguAPI+l9LhhuDNYE3CZwWSivzYEB+8936g5PZxR2jhNUfSJYvtsA7/yTN3EN
 etytkcTaqPPy14Y3mJaIxfR1Grm1XTWQaIRWHOY6s1K1RiutiCO98ZTLqaLIerm89N7XZEehCSy
 OcXVKt64FJU0PZIABwDELDc8yJs8DNqZqBH98+8e9Aw0DBFnKMJVLwVehz+dcp20QkHJxtmD1UO
 TaBEK9puloembdOTAJ2jlWX4HTi07+l4KPJ1sPmVREy3IUSRwOpslwJggxzH9h7003j1ueEAvUw
 HBoBovqszxUPCunPJADDKteSoyLz9dbcuNk/Vfs3ozzeykV3
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=WbQMa1hX c=1 sm=1 tr=0 ts=67d85f9f cx=c_pps a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=rbKIQ1AqokDPPu1yVMsA:9 a=QEXdDO2ut3YA:10 a=FZlSnJes_g73BORgF-R2:22
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: 2BstFNaKmQobtdM_BNf-KF3KgZqwR6pH
X-Proofpoint-ORIG-GUID: 2BstFNaKmQobtdM_BNf-KF3KgZqwR6pH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_07,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=550 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503170128

Follow up the expected way of describing the SFPB hwspinlock and merge
hwspinlock node into corresponding syscon node, fixing several dt-schema
warnings.

Fixes: 24a9baf933dc ("ARM: dts: qcom: apq8064: Add hwmutex and SMEM nodes")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm/boot/dts/qcom/qcom-apq8064.dtsi | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
index ba99e794dcd2236f65f2f3d8c49213cfdaee5f6e..3728875a5506397b36a4c0d6a5ad12c067bbdd8c 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
@@ -213,12 +213,6 @@ sleep_clk: sleep_clk {
 		};
 	};
 
-	sfpb_mutex: hwmutex {
-		compatible = "qcom,sfpb-mutex";
-		syscon = <&sfpb_wrapper_mutex 0x604 0x4>;
-		#hwlock-cells = <1>;
-	};
-
 	smem {
 		compatible = "qcom,smem";
 		memory-region = <&smem_region>;
@@ -305,9 +299,10 @@ tlmm_pinmux: pinctrl@800000 {
 			pinctrl-0 = <&ps_hold_default_state>;
 		};
 
-		sfpb_wrapper_mutex: syscon@1200000 {
-			compatible = "syscon";
+		sfpb_mutex: hwmutex@1200000 {
+			compatible = "qcom,sfpb-mutex";
 			reg = <0x01200000 0x8000>;
+			#hwlock-cells = <1>;
 		};
 
 		intc: interrupt-controller@2000000 {

-- 
2.39.5


