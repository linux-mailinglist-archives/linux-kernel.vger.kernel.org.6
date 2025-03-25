Return-Path: <linux-kernel+bounces-575339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3C1A6FFC5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76E4D17556F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81262571B5;
	Tue, 25 Mar 2025 12:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P64RQMdU"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7672AA95E
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 12:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905830; cv=none; b=NTyWjyMct4bxf4ieMreF8SNUatGSJii8ipriwfkUr3AQ2HCfTVjJX2qhZ+/1by64z4hTFidKHo2R2k34+omgOEdtdm0y2ww/fphSd4w5Kv0Un9ytsRqMmQ6N5rLNW8ngCvM2QDYjX1WN7GQff/P0Rd0hZ4ordnOcXO42clkqoco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905830; c=relaxed/simple;
	bh=/HrP3iXRFnTbX0yCFuBkoG+qDDgKxJzYpbb3ZXru4sk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A9NonPI+6wyV+aRalbketBG7vunj0HCSTYRbe8rH3llqbJ2uiPNOnHBqwjcCdUAcCzBjb/Zwgn1kv5K+0dLm21ygR0lWnLnzSYvyWAW2r94ZXYMaW7OE9Kjjev7Q83pT33WdSjqh40YpFZWTwGdfH8xpI+rEwq7U4w8UDfBnVX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P64RQMdU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52P5vXlH002343
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 12:30:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=3aowXoeM2vXkzmO5GPnuAiNRRKtfTBOA+fe
	icqOTZfc=; b=P64RQMdUV1OdtXRckW8K7Ci7BVM4zx/+C/i3f73dxRdvVSaSlPk
	IV9cACgUCqjZw9LwclonQoyFHSnc7iABcKWP+A6djG4Q9zgqb5CKc3A1v+Hu1Zvg
	f1CWA5rt3hT4sspuG9VSj0ZQvP/Oh/HirCPrp7rCAJp4cWqIXAVK6QaBwGWcg3rl
	Ipi93tWLwyDx2Vr/0yn0s0FuBY7r9/QpYhvYcJIQdS66tfLHxeGrQcNt0SgC2fn3
	DA0jROHjLtgXasN4k1KT2lLmkTRSdraWN0GFeJraIlDIpI4W5QT5WfYmABJwLVkj
	BM6mE8ybaJWmjOUewI5SVxe3pG65YKjzlGw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45kmd4hfjc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 12:30:27 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2242ade807fso157563565ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 05:30:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742905826; x=1743510626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3aowXoeM2vXkzmO5GPnuAiNRRKtfTBOA+feicqOTZfc=;
        b=mA9xosRXqhWm1i1TlGcrUjKo6l9plokh5ppl7nGhzQrfAWfGBi6fEKLy9FyrKiQ3TC
         GShwqKiF1pTyBXqBs2tOIL393jASRdKcLYUOlJyqUv4Z99Oc7tkguM6Uq7qfLzgV3vQp
         F+qlbFXf/46yo0jKQ4qtStA5lF67CoB1uTnxNecnSMqbmHHz4cVwYc1tW/nHo8oeuQwC
         EQDRg5gPoMUa9CDO3qiXMU50UWXbRCzznhl6/MJnpl3/EWTJboxnsYHMw+SEx1/RKSth
         30HH03g8+5VFucGuPx0nyLV7HZpf3YgWmY7lyv8fpx1qHQNUMhk3PvBJaJWOr0ZwUiMM
         iMFw==
X-Forwarded-Encrypted: i=1; AJvYcCXV3rEASotrrPlKmkRlSWF8ls9kXjiH7QwgU+JrsteGS25xtMvZ0s9z67/47oo0N/Vz/+hsWMNhI9LYNuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVzgI54A9p0H6SMVZB46iMLzcEGw+tAyKeE7swiPqo9vgjbjsm
	SlVkLlscVcprG/rCJ0+Uu4F+mCrn528t2SU9LIeo+G8+gbpe/jcLvBmESHQdeRH3354bywy9qTn
	49HU736XBTfLKgeaZwiF4mfJLVQLDGd7pYxjV+Yy3fHMFnGepHr3OWNu1aCJSKAc=
X-Gm-Gg: ASbGncvx4ciVI39iWsYG2jE+q5NxEoiC94TVlVNGg8sE2ZWFjSI1YznyWXcBzc63PEm
	vX32fZ3gQg0f/KX0z992aRYatHyb4+3zZsMTltMjMujo1cORNkqOFOdNkqMfptvQCOJZXEgf8SY
	UkJtdmO4ncU+26t9N+6DKw38slqVIdBsnoPgtolb4karLhem3npzN1HKJU84Ku3wETQSKBW5joB
	q1oBw9FObN96z5iVXfYZewvTW5UQbnhNX7OActP1gmLPCNtdBlrVJzAn3cvBDBVI6ZF7S6UfO06
	zaUT4K6k4T7/Cbk7Tv0oJ6q2Okj35qKtwZYwY0tGiz7O
X-Received: by 2002:a05:6a00:b84:b0:736:5b85:a911 with SMTP id d2e1a72fcca58-7390598e30cmr32350951b3a.8.1742905826290;
        Tue, 25 Mar 2025 05:30:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUaP/3gTLNur6saCYHGHl+3SX9tZjQxxQncUBNKoOTE3PO3CfIu3oe05QxFaw8RHX2kA0xGA==
X-Received: by 2002:a05:6a00:b84:b0:736:5b85:a911 with SMTP id d2e1a72fcca58-7390598e30cmr32350900b3a.8.1742905825712;
        Tue, 25 Mar 2025 05:30:25 -0700 (PDT)
Received: from hu-prashk-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390618e4b6sm9987391b3a.180.2025.03.25.05.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 05:30:25 -0700 (PDT)
From: Prashanth K <prashanth.k@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prashanth K <prashanth.k@oss.qualcomm.com>
Subject: [PATCH v1 0/5] Add snps,dis_u3_susphy_quirk for some QC targets
Date: Tue, 25 Mar 2025 18:00:14 +0530
Message-Id: <20250325123019.597976-1-prashanth.k@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: knI1kDhewlBni84z-2ecTocWR9ruYSPK
X-Proofpoint-GUID: knI1kDhewlBni84z-2ecTocWR9ruYSPK
X-Authority-Analysis: v=2.4 cv=QLZoRhLL c=1 sm=1 tr=0 ts=67e2a1e3 cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=1HEuz3GWIXJSLhVaKDMA:9 a=324X-CrmTo6CU4MGRt3R:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_05,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 mlxlogscore=675 mlxscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 bulkscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503250087

During device mode initialization on certain QC targets, before the
runstop bit is set, sometimes it's observed that the GEVNTADR{LO/HI}
register write fails. As a result, GEVTADDR registers are still 0x0.
Upon setting runstop bit, DWC3 controller attempts to write the new
events to address 0x0, causing an SMMU fault and system crash. More
info about the crash at [1].

This was initially observed on SM8450 and later reported on few
other targets as well. As suggested by Qualcomm HW team, clearing
the GUSB3PIPECTL.SUSPHY bit resolves the issue by preventing register
write failures. Address this by setting the snps,dis_u3_susphy_quirk
to keep the GUSB3PIPECTL.SUSPHY bit cleared. This change was tested
on multiple targets (SM8350, SM8450 QCS615 etc.) for over an year
and hasn't exhibited any side effects.

[1]: https://lore.kernel.org/all/fa94cbc9-e637-ba9b-8ec8-67c6955eca98@quicinc.com/

Prashanth K (3):
  arm64: dts: qcom: sm8150: Add snps,dis_u3_susphy_quirk
  arm64: dts: qcom: sm8350: Add snps,dis_u3_susphy_quirk
  arm64: dts: qcom: sm8450: Add snps,dis_u3_susphy_quirk

Pratham Pratap (2):
  arm64: dts: qcom: qcs615: Add snps,dis_u3_susphy_quirk
  arm64: dts: qcom: qdu1000: Add snps,dis_u3_susphy_quirk

 arch/arm64/boot/dts/qcom/qcs615.dtsi  | 2 ++
 arch/arm64/boot/dts/qcom/qdu1000.dtsi | 1 +
 arch/arm64/boot/dts/qcom/sm8150.dtsi  | 2 ++
 arch/arm64/boot/dts/qcom/sm8350.dtsi  | 2 ++
 arch/arm64/boot/dts/qcom/sm8450.dtsi  | 1 +
 5 files changed, 8 insertions(+)

-- 
2.25.1


