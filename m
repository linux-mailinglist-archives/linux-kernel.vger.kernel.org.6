Return-Path: <linux-kernel+bounces-575341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F04A70023
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B895189118D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D635267AE4;
	Tue, 25 Mar 2025 12:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B7z/Rtql"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0634E26772C
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 12:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905836; cv=none; b=RhWDE1peettDZKmWSAROgEzQiaTCq2fVTH3qWfFcTNX0JKpFqXHIT3j3bpE5rVnkBo0HzHDQ8wspRaioXPEf6SMIe6Is/kIcFE8tOgizozwTnszhrF+Imn9nLfDradQ8l8KyHoGD2CeamGL+lLgZg23Q4+Zr486k2FmpCqC9Foo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905836; c=relaxed/simple;
	bh=EWJKXkB8LgOYgPO2GqjsxkANuQt2ed1jlqMbsU/LlwI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eD9GRsVLMNXC9pcGKScBjxJ3IW4LkU5eoMhx1Fq1jpJKlpsVUrItgCzL/J+rOV3VFhmDPICLH1JTq+V6Ra04yrpdm+e+qpPnfmr4CrtG2uCCyJlCgnQQQ8pDpzwj5vkJzLDh5nL9RENlsEN1r9ubY/XDD1qvhIOg9RZsIDYfYTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B7z/Rtql; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52P5vXlI002343
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 12:30:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=/EQM6DEoDUu
	6zxmdeqRLQ9xyT8MDYjKcZBBXwIJ855Y=; b=B7z/RtqluDa1rImIos/tyMn+Tt/
	YhNGPX6sxI4vRWKSlSTbR/BNhIKdpOsdgqjrNozsWKFozs8fKQczvvmjgFfJ23KQ
	GX5N74aCFVJ5+9Mn+UTULOhThkXvMC+BtSfbpKSr6I3vXJaa02wzH7M4IAn96yFF
	HtvQ46Lygqt7/it1K3qOK+KUo6UIW+0A3CrFU7sW2wlM4kTtNgn8YDCy30hszN11
	rtHzW4ts8HN9erkSmOEwbPTQJq9hb25988OUh4CIPuHQBhS0VdcKtn0IfhQzPqkM
	pkBCFpHvBloXhHIhvZll/XXR7f1KELvsUdO/zynaphcX/NZBBR5GuHJ1PxQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45kmd4hfjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 12:30:33 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff6aaa18e8so8443679a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 05:30:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742905833; x=1743510633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/EQM6DEoDUu6zxmdeqRLQ9xyT8MDYjKcZBBXwIJ855Y=;
        b=hhyni2o96SWnOdr+gSFHC36TGlZQDiYaLoHsevZUmtwi7nsVU/l/XYN94oYeh1Kxai
         b2/lyDUeOYsOyTRJaq+lITC/rQoH9gh0YQB1vn0azskw0hP0O327hZ8fU+TTOrxVl2tl
         SEYDy0aSgIInIz/gDPNQHGwWY1ECtdXGXqVJNnX5RwIbR9xNd2IE4XYtbYeETFa/UgE2
         gyWj37AI2Us7IBQWXUFLQNACv3glzrpeN7+H3xBhLgdZcD+0sbLwD7fJv3qkA3VlZAuD
         w+p7XVAEALQlcSIi50ldREiz6xRjskIRbmH/TjbUY4y2OM8ddllaQXAok8zWiBp14YjP
         9y4g==
X-Forwarded-Encrypted: i=1; AJvYcCXq/tfp+FW4NvUK1TLTSexTPST/JlAGxoamEvPHU+9QW8ZJsUoT9TCdopKfm/0SDDsFQePCedIHvKtmdBc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7O7ft+0rI0mG4N2w0OkQFhReB74C6NvQp4HOrT3/wmf5jiDyL
	bWc0OCCL7PhjW1PXn5EjCKhKxCXY3ljx2tl0Q0O1nnNoqgO3+QgDxsxh0WczsdsV2lK50XqUugK
	tnhmBApYWDy5VLo8zmNED64hf7ZmXqxGo6FqzzDGzRXOqXSXXvi+Gfs5Nj891Wh0=
X-Gm-Gg: ASbGncsYdq1tLHTQ6D2Sz+pfYtW7pn2JhbwuK/49IsEp/qalV6kvX5uvn5ienyxQDPX
	l5tYHwCshHQzfqz2CQrP/RBfAec9X+ScRUC44dCl8G7evgd74sVObu7MpmK1B3EJdsyKFaXT3Wq
	9vNvo9OcD8/ffxAaiYlJD1F1nGZIw0RQ1bqY/K8dChTC4sCk9Z4K5HdEIrY5vSB7XWAmFi4YrqV
	pIslevAkJLrxXxtVKXICukQQIVBLXQm8jNLcU6KmBO/ijsyagGWg7ojHwR5ZQK1CMJEbiN+ERBW
	RGMVW0uV0S1i7O8dCV9bDAV5bV6iI2jY5h4TJPehA3m2
X-Received: by 2002:a05:6a00:1301:b0:736:5e28:cfba with SMTP id d2e1a72fcca58-739059ffb1amr28507106b3a.18.1742905832860;
        Tue, 25 Mar 2025 05:30:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHouuf4m/7aas0Ea6VvKqkVXtocGxmnrkYVDOh+y2Z/ngsR4dy9YmGQThpYoaWuqqdjbhek2w==
X-Received: by 2002:a05:6a00:1301:b0:736:5e28:cfba with SMTP id d2e1a72fcca58-739059ffb1amr28507042b3a.18.1742905832325;
        Tue, 25 Mar 2025 05:30:32 -0700 (PDT)
Received: from hu-prashk-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390618e4b6sm9987391b3a.180.2025.03.25.05.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 05:30:31 -0700 (PDT)
From: Prashanth K <prashanth.k@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prashanth K <prashanth.k@oss.qualcomm.com>
Subject: [PATCH v1 2/5] arm64: dts: qcom: sm8350: Add snps,dis_u3_susphy_quirk
Date: Tue, 25 Mar 2025 18:00:16 +0530
Message-Id: <20250325123019.597976-3-prashanth.k@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: 6OgnRFbn6JoOL0L32BTdwBCcvj4IzGUa
X-Proofpoint-GUID: 6OgnRFbn6JoOL0L32BTdwBCcvj4IzGUa
X-Authority-Analysis: v=2.4 cv=QLZoRhLL c=1 sm=1 tr=0 ts=67e2a1ea cx=c_pps a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=tc1TWAvYerzeY2VvnAsA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_05,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 mlxlogscore=819 mlxscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 bulkscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503250087

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
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 5f93cae01b06..a4fc3657ff87 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -2651,6 +2651,7 @@ usb_1_dwc3: usb@a600000 {
 				interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
 				iommus = <&apps_smmu 0x0 0x0>;
 				snps,dis_u2_susphy_quirk;
+				snps,dis_u3_susphy_quirk;
 				snps,dis_enblslpm_quirk;
 				snps,dis-u1-entry-quirk;
 				snps,dis-u2-entry-quirk;
@@ -2729,6 +2730,7 @@ usb_2_dwc3: usb@a800000 {
 				interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
 				iommus = <&apps_smmu 0x20 0x0>;
 				snps,dis_u2_susphy_quirk;
+				snps,dis_u3_susphy_quirk;
 				snps,dis_enblslpm_quirk;
 				snps,dis-u1-entry-quirk;
 				snps,dis-u2-entry-quirk;
-- 
2.25.1


