Return-Path: <linux-kernel+bounces-575342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DF0A6FFD6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A2BA175C64
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5114267B17;
	Tue, 25 Mar 2025 12:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qf+BZY1Q"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06A9267B15
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 12:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905844; cv=none; b=nNEN5WAwHVJ6X8SSNoydUyyLHn+ydFNHvkUJ4CjJxu+wiA0fIBKeu5oUSPqcBCKUPYnB/gDnb6sAwCtmn5hqwget1WFoyKsIiZLN71jnI//imq4ISyyCqnahxCSu0gSzO6YchpqeM4WlVupUscwqS8JzNRoKmfLwn7Fe+DammZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905844; c=relaxed/simple;
	bh=ByapJwSaA2JYsoTiCefCg7xWdc4BAw+unYZtlLMXgXc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QmY3C81FXSdXzCGSDrILDPCuOkyrOFrwSLf7KBzqs2zDfVv+Fk3oNvQu2WGOvoU9p3wrehpr1Wrl52M7X1OYLLkLhpnZZqvPKaj3ZgE4hlyC7/XhKzaZh4/7Y3ncOtOdsn3RPfZ+u1G5fs9zBjO7LFd7qSpr8H+qnEbXH7jAWU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Qf+BZY1Q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52P5vVeY008305
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 12:30:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=c4cq5PoeUBT
	cNntuXgA7GanwXybPSAE6G2RvKQ8Ix2E=; b=Qf+BZY1QkL1WcKl23uKV7ZgMd4x
	tDxHOc0s0gHSInMrJ0OKi6Tmtncd4igBZ73aIHx7uLJEVA33SJrkXCUrSReCLxsi
	5Ben+vnxK0eCTuH6vfO369c5Ak/e1QBoZjpgQNKvl+WQYlbgl0M+nOpD4g3vkt8k
	2396zDHSE41TmceC4cLPddq/0LAC2pxm3bHnPZKNlxbEzYB2HzmjpronV4Hrvjtm
	R/g8RUhqjNDzJ+LOhipu0/Mv9ZjLE2krnnXLYzIsHkJtvQcRGsJKnqAInV0SVkei
	yC18CGrx+CN8rzdcA16ocloZnK5GxXVcPb7YsW97I3BbW/xQgsooZXTn2rw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45kjjf1qeg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 12:30:40 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2242f3fd213so88164435ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 05:30:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742905840; x=1743510640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c4cq5PoeUBTcNntuXgA7GanwXybPSAE6G2RvKQ8Ix2E=;
        b=evM397OLzlFMVV/CMJ7fPvHE9D1Ij1snrBIDYmwuCeLbKumeTEQDGYlwNNjt8tCXqD
         JhC5qBWZl9Ol0bWNFR2erDLHjMUHuy3dZEX6nM/Vr7jeaGX8OLSkR5j5taikFlHfFUdj
         sBXx36qg/8Ql0+s/Xqcn8QXwzw4o4EwZuGrOFpJAO8bp54Dgf39/q6lhJW+sDqmqidSt
         qKQwk6Qwj5hqkK82Uzm6HLxTLHEbXsgw4d1nUCBdEfIa849IZGmg43ogRzpkJMN1HO0e
         CcAhftzBpsimjQm7X9b1RMTtoqAXO6k326uaumz0912m8pFzU4M+fKCO2VC3Kpih2/mZ
         9pNg==
X-Forwarded-Encrypted: i=1; AJvYcCVflfXeecv/d94nV2aL7Z9FRwv8/ekiMUT7eX3YSGE/tJKFpU5IITa21EtCcApxyhOgTuUj1Vzj+D7L3a8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj4bSGT8jqRzuzWVKUgYewJOhgGdF6z1/AM6PZBkGZwWoHUZU2
	k/CY5A+f13AfEL4gULI5/k1Rb4nvguQJHbhZ31NVNYeZ5rBsGMfr+fGqIB1zh2JR5ZCb43Od/2s
	iEViiM+RXqFG0GFRLP1f57qoQKafF6uLAI0/dFRGM5kkOigF3Eo0YfkgddG2C+/o=
X-Gm-Gg: ASbGncvFJBd38sgrtrqff46iJZ6DjZc6DdBEClL1RZh2u5Svpxxn7g3MjFj6MN2RbUi
	BucG9LUEE4oQUShd/dNvnbr4YEhAUouVfnUCgoltMgr3v+P2kCzZBz9jGHRrEvuqV9c8SV+hkAp
	Lk9p0kbHO/1OvenMS3x1YwfmVwGOnMBhyC1LHfGOXP1R7VQWe13UarzjAoyjJjtKT8N5TkoQemO
	Myjm6ALxvVGlnQY7c21HA2o+6tA/BvDEmfsfCk1+7j38PxtnHibN1ix5UmN7+uFnc8cIjBJQ4qr
	aJyRQNqpCbvNXnnfX1agHlrxRYeZbjuAUPfT7YN22/1W
X-Received: by 2002:a05:6a00:3d0a:b0:736:4d05:2e2e with SMTP id d2e1a72fcca58-739059667damr27448231b3a.6.1742905839733;
        Tue, 25 Mar 2025 05:30:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQch3AWha2DTxlzFMtC4JDwLKFF9RrWxn4KNzLCG3jKZZdV4T/Tl4Cj9iV3polzJ105XA7xQ==
X-Received: by 2002:a05:6a00:3d0a:b0:736:4d05:2e2e with SMTP id d2e1a72fcca58-739059667damr27448188b3a.6.1742905839174;
        Tue, 25 Mar 2025 05:30:39 -0700 (PDT)
Received: from hu-prashk-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390618e4b6sm9987391b3a.180.2025.03.25.05.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 05:30:38 -0700 (PDT)
From: Prashanth K <prashanth.k@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pratham Pratap <quic_ppratap@quicinc.com>,
        Prashanth K <prashanth.k@oss.qualcomm.com>
Subject: [PATCH v1 4/5] arm64: dts: qcom: qcs615: Add snps,dis_u3_susphy_quirk
Date: Tue, 25 Mar 2025 18:00:18 +0530
Message-Id: <20250325123019.597976-5-prashanth.k@oss.qualcomm.com>
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
X-Proofpoint-GUID: Ieunol7x4qrCpUhMH2v14Fx_x5WOLfGF
X-Authority-Analysis: v=2.4 cv=Hol2G1TS c=1 sm=1 tr=0 ts=67e2a1f0 cx=c_pps a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=xQyWRTzcSYSkOWr2IqcA:9 a=1OuFwYUASf3TG4hYMiVC:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: Ieunol7x4qrCpUhMH2v14Fx_x5WOLfGF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_05,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=834
 suspectscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0 spamscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503250088

From: Pratham Pratap <quic_ppratap@quicinc.com>

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

Signed-off-by: Pratham Pratap <quic_ppratap@quicinc.com>
Signed-off-by: Prashanth K <prashanth.k@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs615.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs615.dtsi b/arch/arm64/boot/dts/qcom/qcs615.dtsi
index edfb796d8dd3..7c377f3402c1 100644
--- a/arch/arm64/boot/dts/qcom/qcs615.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs615.dtsi
@@ -3600,6 +3600,7 @@ usb_1_dwc3: usb@a600000 {
 				snps,dis-u1-entry-quirk;
 				snps,dis-u2-entry-quirk;
 				snps,dis_u2_susphy_quirk;
+				snps,dis_u3_susphy_quirk;
 				snps,dis_enblslpm_quirk;
 				snps,has-lpm-erratum;
 				snps,hird-threshold = /bits/ 8 <0x10>;
@@ -3661,6 +3662,7 @@ usb_2_dwc3: usb@a800000 {
 				phy-names = "usb2-phy";
 
 				snps,dis_u2_susphy_quirk;
+				snps,dis_u3_susphy_quirk;
 				snps,dis_enblslpm_quirk;
 				snps,has-lpm-erratum;
 				snps,hird-threshold = /bits/ 8 <0x10>;
-- 
2.25.1


