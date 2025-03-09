Return-Path: <linux-kernel+bounces-552902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C5EA580CA
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 06:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C5CB7A35A7
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 05:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9668C17BB3F;
	Sun,  9 Mar 2025 05:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RBwFGUOD"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8159D17A5BE
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 05:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741499187; cv=none; b=VAT+4LzLJQXRTds3SzYhP5gbZkW6KnQDDUs5mrmxPEANy7HIPHg40a+e/HLtmeh8rFsb1iNdBJxUb18vqe7mxHxNiCMIDPnsiH8KGp9e9oRmy4Zf4d48NK/YFkJe5rZ/kqUQ7rHb5oG3qStwvj8UQhLRUWTL/T9aWS+kfCPhuKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741499187; c=relaxed/simple;
	bh=yzvYS+vDkvHU/sbyPg2yR5foiv1dbD+/nutD89aVNFA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tWstf/UUnTvRk9n4z6vvz7DnNL5HCqm7A5UOLlnLB/0KEGCd/X28ghOH4hNXKP5Bb6WsemcXznjILea9hyu8qPZ3VpIppHdPB1/vHyIeQXiRw+11IhJtGGCS5HehXrlMkKBsJuam0oekoeBcqdz1GIhdoDhGWrl5QsAvsInQUI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RBwFGUOD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5292P1Ga022175
	for <linux-kernel@vger.kernel.org>; Sun, 9 Mar 2025 05:46:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Xd5/NY/AbI/ojxPiTnWZDegzzMxF2ObPIkWgoHjce9E=; b=RBwFGUODwevnW+uu
	Rho/gnIs/l+x2KSBcECGgreHHLXiBd51X9KyswSeE8Y9kfZ7jVguE5cCVUxEhWZc
	h4FtQ/ir/zAoc7Ec8fC683uh0eOKtCrtlkYyP01mNAF8c6ZKue0tMoOS/pA800UX
	FrF9BuENDn0OWfilECnVVbCjyqTxGlCbrti8efhP3hAla4fJd8z3ILAGgizmmjV2
	nyLi2kJXADbGvc4iD8V0TxYcoaIbxzb2zH6tag/Grs0Zc4Il9akjF23E4ZfWzzIb
	C0kpRBWhngdn2uDzMAVqRSReB0a4VCE+TBrQGVG4C7QGbMe8LJo6+3Gtpy5meirc
	RaZ4JQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458ewk1pb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 05:46:24 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-223d86b4df0so91911795ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Mar 2025 21:46:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741499183; x=1742103983;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xd5/NY/AbI/ojxPiTnWZDegzzMxF2ObPIkWgoHjce9E=;
        b=X+e0jtPZdq6h1vOAtOHWHAFOnRAK5vryxQjyRyivcP+LqKMj8G6x049RY6MKVIHjqW
         8crYct4qHq3eznC2RFBKELDWPiHQYz6vAocTmM758z6zYe/IKqLAN2qDbypFMUBJxeEi
         XW+NNkEJ5Px+okRt4CRhpYe1wqp2A0+F8URI5ZCbmtz22IARAN/X6YrNdQiEx55H0DBB
         jzLqMYJlkMEInFPokWWBXG59RFjRqhcjjhtoBA2PwhLGu9An/HGn9d/AbB712bzffX9d
         A4oRcHKZRj5f/NqPO2p2Lxb+Mw+Y2bZd5Y66oZakaDBjscegkWYJaBHiL9XfRVSK1FOe
         67kw==
X-Forwarded-Encrypted: i=1; AJvYcCUp4aSHlchawfaxbCCA7xUMlOkPCs2hsMgN5+IiXDwF42Qvi54+FKCj4Z//I7qRz8BuYyCLB45aT7tyyr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD61BcwtnepbE1szchxR1x1wLqrZYdO+4DTiArulCgSLsSxBAs
	2a2qJtEEsoTFjWFpR3LewlZPOeOfwVQfV0xNP6Y5+q3Cn+/6ZRm36B5hlIQ+aUoHB17Rsnp+fCX
	RoIL2VEvnaOJNQu1TQZX8v0U4ilwv5K2FQtOapejDEnp/7DId29a6B5lC4ra5dgY=
X-Gm-Gg: ASbGncvBFpSBJEG7IbURR+Jug3hQ+RPL+ehjbMP+DcsUxOsZNEQY/7g2UzmopZlYDQw
	DY2VML9CSYGhTjJ0vBbUB6BABd9xRjdavnIYrZinVt0t/wEm0vYFkp/ZqWGs4/E8/mP3QnKMuMi
	v1xycBsXUEZCaswIKT/EUpPyMqF+VwAdqR1XX1WaVq3BCBDHJo4xqhfgLmkpg698FbdIR7j9WPI
	V24Mz1aNoRQlqfDVmMCn5wgHwfPG29PQXl7sb5B/AJ1vGp7kg+Ds21x8AY7IpDY5tC23oPKnrUZ
	RNIyJnxD194EgENnx8ZPuF0BgK/xoyosg+mS7sov/HUqRChdohY=
X-Received: by 2002:a17:902:e80a:b0:224:1074:63a0 with SMTP id d9443c01a7336-22428ab7313mr144081725ad.34.1741499183128;
        Sat, 08 Mar 2025 21:46:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8jQ41ewm8mRMToOvvbPTBKa6DdkpK8KF4isFprAHrCTfOwjmsi4gJjMmDCobS1C6QBUqZ8w==
X-Received: by 2002:a17:902:e80a:b0:224:1074:63a0 with SMTP id d9443c01a7336-22428ab7313mr144081455ad.34.1741499182676;
        Sat, 08 Mar 2025 21:46:22 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109ddbe7sm54887145ad.32.2025.03.08.21.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 21:46:22 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sun, 09 Mar 2025 11:15:25 +0530
Subject: [PATCH v5 3/7] arch: arm64: qcom: sc7280: Remove optional elbi
 register
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250309-ecam_v4-v5-3-8eff4b59790d@oss.qualcomm.com>
References: <20250309-ecam_v4-v5-0-8eff4b59790d@oss.qualcomm.com>
In-Reply-To: <20250309-ecam_v4-v5-0-8eff4b59790d@oss.qualcomm.com>
To: cros-qcom-dts-watchers@chromium.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com,
        quic_vpernami@quicinc.com, mmareddy@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741499159; l=1000;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=yzvYS+vDkvHU/sbyPg2yR5foiv1dbD+/nutD89aVNFA=;
 b=8Jt0eDX2uQWxV+tx6Vb6Uv/IKPa3yVlq2Br+SVVptGCggq25ML51gwaCZysbJxBqI6kKh9z6v
 jaSwx0UM+oNC/wgb374BOelNO2/DLenm+S+c2em+fVjMbatR84eyUZU
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=Tr8chCXh c=1 sm=1 tr=0 ts=67cd2b30 cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=bu6UjZ7a5GH_BZZocUYA:9 a=QEXdDO2ut3YA:10
 a=DLZpj_5H-hTUFZwOGiJR:22 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: C8Vim0WR9KtUFL4Oy7AuJcr5XNtiZaZU
X-Proofpoint-ORIG-GUID: C8Vim0WR9KtUFL4Oy7AuJcr5XNtiZaZU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-09_02,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 mlxlogscore=747 spamscore=0 lowpriorityscore=0
 mlxscore=0 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503090043

ELBI registers are optional registers which are not used by this
platform. So removing the elbi registers from PCIe node.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 64c46221d8bf..e556285d6b75 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2202,11 +2202,10 @@ pcie1: pcie@1c08000 {
 			compatible = "qcom,pcie-sc7280";
 			reg = <0 0x01c08000 0 0x3000>,
 			      <4 0x00000000 0 0xf1d>,
-			      <4 0x00000f20 0 0xa8>,
 			      <4 0x10000000 0 0x1000>,
 			      <4 0x00000000 0 0x10000000>;
 
-			reg-names = "parf", "dbi", "elbi", "atu", "config";
+			reg-names = "parf", "dbi", "atu", "config";
 			device_type = "pci";
 			linux,pci-domain = <1>;
 			bus-range = <0x00 0xff>;

-- 
2.34.1


