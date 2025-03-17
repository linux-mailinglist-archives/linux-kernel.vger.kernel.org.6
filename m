Return-Path: <linux-kernel+bounces-564821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE3EA65B58
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4270F3AA464
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A3F1F582C;
	Mon, 17 Mar 2025 17:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SUyJSoRU"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47FF1A01D4
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 17:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742233513; cv=none; b=Vt4VBokY+eituqvtFvnXNok53AHqL/FewHyYijqVhSfDrT4HODSnqviVbXcDhFVTL3WTj7pm5on77hXOc9Tqgh4GNKIRn1nvUtiZeCkwasvTQHgzFuR+UBss4UuqefO1ekNbfgYsmzyMMnZ9xmk/VQOinyEjph2w/+L3KdKlZvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742233513; c=relaxed/simple;
	bh=6oexzQF1OoJvGK82ren40uxDYNIho3CwgfGuz5+Kfjg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WNzXxTk3IIDtNQ1Vc/dUuP98W7HhUixgDUVwl5IbNXNAKlTta2PAkYH/1YZRwpGeYJ8UozknjFdANLW2/RBxPfXnSslint3ly5nQGYFCcEjDXOlwW7IJw0dC9IcF7MVGGWbLKEDGJlzFDGvZVjWTwaKvj6Ffl5mdYe+w7iv+Lk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SUyJSoRU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52HAQm7d013188
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 17:45:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oI8X4OOQjroDHAkkPzLdr0WBC9OWilOtC8rBPPB07GM=; b=SUyJSoRUOxH9Kzpb
	Vvl8fhigo+vUcfa6LVVdpCqsTjSjyAoWgmMxNRx6jSDXAAZctIvwbBpbVrAoWGrr
	r/q/T9uzD7BqenFSjgCusCLpOp1le3Oj/6uJaDrJOzw1ZyC+3v3tsiowaBTLRXc/
	oTDN7qBiBNksunyEKo71xIl2M3wCmYritX7XvF4EpH1XrHOjQtSpKkW7/fFrxjWi
	bX7T9eKtMmEPST43Kt8ywg9cFUk2CYXsYOA22HQuUfSAJJkzV/Ev+bNfTvzmW279
	SZ0JTyCJbINoeGBmLVx+29PJosRBgfgLoFsR3fx78612V6jCvp+uYODMCRVFVanN
	1B8HyQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45d1sxwg87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 17:45:10 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e2378169a4so107266786d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:45:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742233509; x=1742838309;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oI8X4OOQjroDHAkkPzLdr0WBC9OWilOtC8rBPPB07GM=;
        b=PCJK84mlhvPE0x757ymmyLHKD3+PNMoFJWyvu5vu0AltUvR0edsJrBtfm3KlxVtf3f
         l19yfgNVWSxcIhnrfEtm8LJPt7YEGv//MwicAdjXBy9+fwQ/XIHnjmR2eb+BQ0pHJyKY
         Gz2h9+fjjHMR5OYZwTm5JKwVQRXJI7O4/xLXIGyT4aqhMmFuq3lQ1R1xu6SZXlrRhUfv
         oxMxiRCpABgrdmTKXM9ZS8hgsGG/ygRw3U0hHrh5+4meskDigpJx14tL/575KtcuIZJR
         YLWdzkkrLrkxWiER+aRtNXF9bvtbJfQ72RHTmov96iSD8cLA2uaNaTeCxWfaqnsIyFjv
         FLdQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4/1ktkX7AoDVS4g7aPCS4WyjMXSEDMYaeeX5QK6+IrPKEtFgMMA6/5Dl+1c/4+grCC0YCetZ7my9Qrn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YywnjOVVuHuULlIFiEkkIkPF//3iekMcTrz23RyzhWfJtKCo9rt
	0mi+LO+KdB+RlujJv/NCoXvZ5Z4eE4k7efCxQzDm4qsHNplf6QG1AHCVOJ3rE5SW1emjKiW5Ijc
	Vyhi4BGYfSsX6Yv7KsWU23+JJ5zbxW/PKltRnEa0Jmfo+jmfKFtyTBh7um2I6dgU=
X-Gm-Gg: ASbGncu1fxUaa3C5dDd4lBsRy69y/2x9qudSk/WKCWcyj/66j8AwMgRSm3r7a+Sbl0w
	bplq25mByNSDQAYZwGfVEpc3hpZOPfdAVO2XKKd7umPTSuSm9oUXtZw8JfFoum8DYF+g9p/N34D
	VqmfHyO2c8Se0bN8TtAgWtnFabLv/OUNdd/j7LS/a2oHj0VUL1rUwcZ63Gj/mlQW2RyObEeqNc0
	RbPN9NOAm2NQehHHMELJrY4juDazVU+0sOb9GotfMbwAmuj6A1o/DWoPKXuy3fWtS4RmcGE4v76
	Lv7DpPd9OfvhG6uNCvHmr1Y0hKP0ltVtKC564z3rZbWv09WAMO63BPzGQqTOWlVP+ojN3o75uOP
	yGHiCqzGnvPrYzZx/6lKJibjU842x
X-Received: by 2002:a05:6214:1d22:b0:6e8:feae:9291 with SMTP id 6a1803df08f44-6eaeaa5f7efmr173160856d6.24.1742233509616;
        Mon, 17 Mar 2025 10:45:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxv7impz0+MvxZjln6Fe8dQxZU/4AX0gumYPVdGY1SSFXkkPRf0pdd6esVsnXV/XW4UYLO+w==
X-Received: by 2002:a05:6214:1d22:b0:6e8:feae:9291 with SMTP id 6a1803df08f44-6eaeaa5f7efmr173160326d6.24.1742233509287;
        Mon, 17 Mar 2025 10:45:09 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f0e9985sm16687121fa.29.2025.03.17.10.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 10:45:07 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 17 Mar 2025 19:44:43 +0200
Subject: [PATCH 8/9] ARM: dts: qcom: apq8064: use new compatible for SPS
 SIC device
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-fix-nexus-4-v1-8-655c52e2ad97@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=918;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=6oexzQF1OoJvGK82ren40uxDYNIho3CwgfGuz5+Kfjg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBn2F+HXznEfgII3QjF7M+kfeptlRMJIBFPK5UQ8
 bqCCEPsXrCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ9hfhwAKCRCLPIo+Aiko
 1cB0CACrq2R9bp0kI2bQnj3zv7W6gk+12hq0bs1B/+7+e66Y7Lz958tNrpNvJa13mFJIHrAoNOM
 +i6M1wRCOLbjcrzQ5baxlxr0w+n6u4wiQO9ersrC5DWyYfyZ5ecbTXmUuEyxjitF7nlf68Edtl8
 sez4B9QeWD6QBqVHUmjMD7rPi6W6CLpcFq5cykUj6Y5kZ0Igln8VM3noGo4IUh/wYMkNm96P8oD
 Ai9GhmZhg1Wfa2pno8y3oMqRKl2oWz3K5Pc9m5oBiHCAFN8UyOV648S2i4DY8N0nz8jpyhcAhH7
 M9l5Fs2iqflxej5NdQoJrkjozsJ0jSNT0KdDtGwKwllGKgrZ
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: eYPJs493MSVSIyjfz3eUcU9VcNqtANEB
X-Proofpoint-ORIG-GUID: eYPJs493MSVSIyjfz3eUcU9VcNqtANEB
X-Authority-Analysis: v=2.4 cv=XKcwSRhE c=1 sm=1 tr=0 ts=67d85fa6 cx=c_pps a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=p_EMIZExALG5VSdhSekA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_07,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=520 priorityscore=1501 clxscore=1015 phishscore=0
 impostorscore=0 adultscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 spamscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503170128

Use new SoC-specific compatible to the SPS SIC in addition to the
"syscon" compatible and rename the node to follow the purpose of it.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm/boot/dts/qcom/qcom-apq8064.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
index 522387700fc8ce854c0995636998d2d4237e33df..a106f9f984fcb51dea1fff1515e6f290b36ccf99 100644
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


