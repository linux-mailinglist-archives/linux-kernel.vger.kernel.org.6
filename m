Return-Path: <linux-kernel+bounces-564813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BA7A65B33
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DAB37AA248
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332BD1B4240;
	Mon, 17 Mar 2025 17:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ib+nkGDX"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFE51B07AE
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 17:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742233488; cv=none; b=WZGJS8+AOdDjEptdijzcgg6iOquPqDOEJ/uN4/iAOR6cF6zkA10aqVes01HiF46ohlO7rEZAhBE9c/tg8E7UUX/tpUNzMTRYI313+TjA4Bd3hy4z3aOXJ/TQHnTzmH1X4wg0UWo4d3mvNVqqK/xcjfsr5cJ6TZwYXlbDQvNgcmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742233488; c=relaxed/simple;
	bh=WXxJVR7u/eEtq0VSMR7e9vL+o9y/vFO1lbnUevsiJCM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sJIWNb5EA6gwwr/XHP12QWDC38q7k4IC9sF6dCoJ872S6/U8WNvz9Sd+wusoFSaau7HW020klkabyM5BOk47tMy4NbZUgPzFOKtd6umakFjfZYVSAq3+O+DmklbhVreymIpS+wLBQGgJDUCkaCqdkSVnCuUrV0Ayp1sPmgLIpvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ib+nkGDX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52HAQm7Y013188
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 17:44:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=zBUsExIYKuDXmKfSyZ4/x5
	2vF/DMlL74oBtWZxSet6s=; b=ib+nkGDXhDhWrobH8BbDmoviUA3JDACnfQOOhZ
	/ePw/HhpiLikp8nH/uge02lZoZP6jYe57jXQiZItgLvRugfteG0baVtbbVFfd9JC
	w9N6awNVkyUz+QSm8FjtlX+raILx9C9h3KFYAMqmD5k+z2F98X5bBum8sLdUlErZ
	4StwKS6aZmsKzLbBSrRE3hzkgoiMbinP2Sez+rZtdBtTBHbE3kGMWeRqwFoaQwTQ
	KWfzcEHls427Ha13cmUP2fkdRf/gLGQ00lvVMWn4pzH+1bDhc8vcIT2/DadEESYC
	fg7y7NF4S+GagRqqNak6avWkteLOiTJjiKuE8Y24Z78VcYCA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45d1sxwg4r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 17:44:44 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c54e8ad9b3so1027440885a.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:44:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742233483; x=1742838283;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zBUsExIYKuDXmKfSyZ4/x52vF/DMlL74oBtWZxSet6s=;
        b=NPTetQb6e9HqqZ4jy3XhN7m2RSpSXAkgu3amHqx8ry+Ee0XVKDsYt9fsDLmK6yFxbe
         mkpYvwVqw0X0z46FipdbAoHadaq0O6avpkbYURtkIsdG9DyknL+6KdCqOKxTtUo61oFn
         iT2zgr+OeyLNXuj+Kz72jiLsLBEchdILeJBgeNeGEn7Zltjwx9CGGW4ONF1UUH3MDToy
         93oleJIYAi6iShSoBOKKWNV94op8O+rUAgZTTWjDnkTBf6YTWUWKiEGdHYysoFswEnJX
         if+NOruXcut/thaW/Q0L9Drn+7WWEwY4Mfe7PVwJG3+vHD5rBdqPRKF+K+XgYF1UQke/
         tWiA==
X-Forwarded-Encrypted: i=1; AJvYcCWXDcPiS4XtXwT3SmME4A0jAUGvU8y77k4UqopJNr9My5PO1EstdldkAclWcR6tTzgkCJYKULThqUhhd7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVSCHp44/VGn8F9JyHMmFygHPA0goLWigMTZ73fRIO+LEERxsM
	JTi0VXRGXX85vuk5oTpvchf2a1bvEzwEJ1jz1Q6xBeeAvDQHX3TeLM0qcaLDMIQXKtTzBRNuRZt
	VEJvo1uBNB26+2S3v5S5MUQPzpxCl8ETMdlYaAi+rhbCjrIEdbedv32Jq8O5Gi5k=
X-Gm-Gg: ASbGnctlOqlB95I235/bd9VNWX+VfujlqvylEM8hLVMKwx6ehhryqdjnPxnYTAZ6kvG
	w4bjcjNEnubD0G4itbkVudbSky25Nmfc8EeWBcRWQNzgu34DvfbfS+/Jg5llVrYgWsHo3GprpI5
	9ODerW8GlQdPBUubLjv3oQJLzTw8sy3dVjM9Ub0ICGiI+Ad92MHgtUFTUdYTkz+YWPhtCH8uCcc
	8LdnuecfpI9t6ktKtpPRxPikzUaCRUwfbPFuh6YYdVFPMFIRWhzjhl4lowBEGZ5+G4DGoM7uAnu
	StS8Nrw9L7F6+7rb48SvOAZjbopHHehTswc6NkFklzq9yNBUwWKHYlPYqsc4w0PcqJjHlAQ40ei
	mFEqHrUstNFiUKzGwnUsocmdJEg8o
X-Received: by 2002:a05:620a:248f:b0:7be:73f6:9e86 with SMTP id af79cd13be357-7c59b8aaa1cmr52553885a.20.1742233483585;
        Mon, 17 Mar 2025 10:44:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhfiwtI1vGLjeE5IzqOgUZWulx8wY4QyIkbO2lD/DD4nMJ83CYnPPjC1rh3t6m36OU8cMz5g==
X-Received: by 2002:a05:620a:248f:b0:7be:73f6:9e86 with SMTP id af79cd13be357-7c59b8aaa1cmr52549885a.20.1742233483171;
        Mon, 17 Mar 2025 10:44:43 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f0e9985sm16687121fa.29.2025.03.17.10.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 10:44:41 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH 0/9] ARM: qcom: fix APQ8064 schema warnings
Date: Mon, 17 Mar 2025 19:44:35 +0200
Message-Id: <20250317-fix-nexus-4-v1-0-655c52e2ad97@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAINf2GcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDY0Nz3bTMCt281IrSYl0T3ZQUg7RU46TkREsLcyWgjoKiVKA02LTo2Np
 aAAds/vRdAAAA
X-Change-ID: 20250317-fix-nexus-4-dd0fe3bca987
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1703;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=WXxJVR7u/eEtq0VSMR7e9vL+o9y/vFO1lbnUevsiJCM=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBn2F+GxcQJgJPjISwSlnyJbUcpp+Z/ZtkHrXc+i
 O+VklGUppyJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ9hfhgAKCRCLPIo+Aiko
 1dhVB/9g6cVCpjmDg/J9cGILVCTRjkxcPbPm8giIi6XatiuGR56vsEsIU5fB1ko9soln8IvtOUW
 hvgRPcnX9nEblDDmkVgd2oEMoBbCe5Lnt01zbQfEBxaz9pbvF4WWM1/JSPEfwwuXWUS9H74b13H
 s3Yy9+fSI1T3s2xptLOYackhkkS9r4AdQ6yZpzFk+EJYIi0phcak/5+w8g8U2Jduh3DJsyVBu3S
 9otEv2EiIOabC/zYtEHlKY+iaxwJE6jTLfWMIUdB2qagGZiEhyKFX38LZrGtmAe9B9juuxj9er1
 pc7jED0X7+aHUn7Z4pWgEiSrF/GrWumv3k/pANwWAPIOY1vA
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: tqZxEr2Vr5kNrHyDxgvkMPUEPdz3wH8T
X-Proofpoint-ORIG-GUID: tqZxEr2Vr5kNrHyDxgvkMPUEPdz3wH8T
X-Authority-Analysis: v=2.4 cv=XKcwSRhE c=1 sm=1 tr=0 ts=67d85f8c cx=c_pps a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Xd_227E7yWZRqRJlnwUA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_07,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=607 priorityscore=1501 clxscore=1015 phishscore=0
 impostorscore=0 adultscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 spamscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503170128

Rob's bot has reported [1] several warnings for Nexus 4 submisson,
however none of those warnings are specific to that device. Fix all
those warnings for all APQ8064 platforms by extending existing schemas,
adding missing schemas and making APQ8064 DT follow all the schema
files.

[1]: https://lore.kernel.org/linux-arm-msm/174221818190.3957236.3364090534153729086.robh@kernel.org/

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Dmitry Baryshkov (9):
      dt-bindings: soc: qcom,rpm: add missing clock-controller node
      dt-bindings: display/msm: describe SFPB device
      dt-bindings: soc: qcom: add Smart Peripheral System Interrupt Controller
      dt-bindings: arm: qcom,coresight-static-replicator: add optional clocks
      ARM: dts: qcom-apq8064: add missing clocks to the timer node
      ARM: dts: qcom: apq8064 merge hw splinlock into corresponding syscon device
      ARM: dts: qcom: apq8064: use new compatible for SFPB device
      ARM: dts: qcom: apq8064: use new compatible for SPS SIC device
      ARM: dts: qcom: apq8064: move replicator out of soc node

 .../arm/arm,coresight-static-replicator.yaml       | 10 +++
 .../devicetree/bindings/display/msm/qcom,sfpb.yaml | 39 ++++++++++
 .../devicetree/bindings/soc/qcom/qcom,rpm.yaml     |  8 ++
 .../devicetree/bindings/soc/qcom/qcom,sps-sic.yaml | 38 ++++++++++
 arch/arm/boot/dts/qcom/qcom-apq8064.dtsi           | 85 +++++++++++-----------
 5 files changed, 136 insertions(+), 44 deletions(-)
---
base-commit: 2bb3cf7805af73af62ebfcbb55e350549b6a0912
change-id: 20250317-fix-nexus-4-dd0fe3bca987

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


