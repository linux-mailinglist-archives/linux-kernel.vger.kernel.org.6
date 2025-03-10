Return-Path: <linux-kernel+bounces-554053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2777FA59232
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 12:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A6611883914
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9A1226D1E;
	Mon, 10 Mar 2025 11:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bj2neNPP"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F934226D07
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 11:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741604660; cv=none; b=b2YSNChltwFhW0XtZ1vil6gv3UYZ2IpoANpheTH5DNb2urrH0PhOLEktZyW8wqFMZudN+jJYnSo9eZDcBBkNcsA6sCpbrw+W4n3Pr/U4EJzgtHEF5VuFV0rr+clgLpl50b2X73w0FILJzL/DtLHatUjvhHaR5V6+V20OCO7FevQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741604660; c=relaxed/simple;
	bh=SLKi5/pU6VmqZloQSrc3BsEC95BvrfInlTEKZdNyDPI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JXSQVQ5tabtEkbKwwY6PoUjQLnnjAC5proQ+r8Id7XOE4oR6W6HAL9Py3rbLUnGmqSpg5bRyT4Y8SmwX1k+mF9GF7bo3C8VjZRH+XDyLpIqlPrhiPQS9pOpKhkZxkG8IEQ2u/is8v3ji47ONUVHN3A2Rc8sJHkzrGrJvgHlLinY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bj2neNPP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52A9tWkL008001
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 11:04:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=7+h0SgCQWbpp2hc08NzZtuUqyuQ4lXLc5tQ
	LmGtbA50=; b=bj2neNPPyGpRSdjTyspYKoXqr14OqsTXVLwiR9JUgqJTZzyZpXX
	d6rdXBVYipzcHPvJkkfveDmRHAt+jCfMBfr/+expJ8k8JEBMb6quwaPVvS3bM05Q
	U9ax+hAhd89Kx2tEmJXMSzepqa7qBD1990jPd63aBdEPBeE5TvU1j50VUcv47qPs
	6K0d+9i4AVpvR1oegcOwVb/dMV7HUfORL+FkmNZ0YIFi0OiUe0PZAeTzTw9qZycz
	ox3rzhe0kIdVE88URT+z/PjGkEYuPcnPBkv0Vg5XUd11WHmUhJ9nuRTq9h8v4PkT
	U+4p74QN3SeXafsdULRBxxAGj5tWvhZ8NqQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458eyt4h7c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 11:04:16 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2242ade807fso87035205ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 04:04:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741604655; x=1742209455;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7+h0SgCQWbpp2hc08NzZtuUqyuQ4lXLc5tQLmGtbA50=;
        b=FPBfesLRbBxYm59n98cKTxq3oTyuYhDkVhWMkkB+WMBz9N+yubl50qOQOjpArpk4ym
         FQPWmbi32irEAIrH8N9x9+A0qNcDD7bel20qH2HyYlKUI1sa5mhg16tsw3YKFNjLnfxk
         yl6JgeZtaFUmvCLE1W6Isf3Qoh/tiCUTJ14HfLYnHWf/VKEYDEFmUatPsD+JjKKQwwYp
         1wrRvIbBdKnBWO82ANmpysbBTIEgywZfX4wpUnvtarWQTUTOC+bsl4qrOXHMXO/d8YWw
         hJK1loGBau6FUiDza11d7EO9PNU8xJ7iFSfTwjic4+4qHfDMFztG5ysLdgGLC748N8nP
         oCew==
X-Forwarded-Encrypted: i=1; AJvYcCUxH+LrrZF51FDqYqap2JJ5LtYK0j9b9Lp+FChS5PEpe1m08hWhmVrhbL8yR5PleUCVXnwZvu0LF2j1obY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIcikBoN8YzsbU3ylDzWF3oVhHv6QZKT4fb4FZhn2BZjKRW3bK
	a6jtamsEXgZ31X3BNeQl4gQRB5+5bTqEHPF8q9qARYIfV3jYsbhEzoIapAbNXB1dVOeniVAkVcc
	GM4uXZ8om9iQhws5RFoQLHm9/D3FfoRkDm9Fd2dRBbuviNkIVFOo6zi+3N6oWESg=
X-Gm-Gg: ASbGnct5wdErCBJEMXB5Hofvgvq96Wccq4jNW6LL4CRCSZvzIiVHnLnxQjmINM97iA1
	6VnXwEmWguw6Lod8CmufTYUkfIwzN3wjWcpDehVT7H9IDcfx/7GU4S+MwzxWuEspVqG23X14Vwy
	sxoaFDAcXy98Q74XfC1y8TEsG7ngNV7hpC87abIjdrzJfsIzlerugWSeHPAQktmF2bvUvV8h4XY
	thZKVH1gAl1AY86YXjjh3zwBHXn/2sgEDUeJT1WUf39X3CU7oDvZgupERIEsIu2fLnxxEHJcPQi
	AUd1JXOd+COTeOC6i3CA7O8yAM5zGgECAJGuq9BCqztjFcFTlWfjmQ==
X-Received: by 2002:a17:903:22c8:b0:220:f449:7419 with SMTP id d9443c01a7336-22428880305mr190238575ad.7.1741604655631;
        Mon, 10 Mar 2025 04:04:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPpOyafTgqJOPNvJdDELRWWpYaOQqOg/hYct9/Qs6ay7Y38goWmm0TeDagcKLKgA3lGaIYZQ==
X-Received: by 2002:a17:903:22c8:b0:220:f449:7419 with SMTP id d9443c01a7336-22428880305mr190238105ad.7.1741604655245;
        Mon, 10 Mar 2025 04:04:15 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a7f8c2sm74902025ad.116.2025.03.10.04.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 04:04:14 -0700 (PDT)
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Subject: [PATCH v4] phy: qcom: qmp-usbc: Add qmp configuration for QCS615
Date: Mon, 10 Mar 2025 16:33:59 +0530
Message-Id: <20250310110359.210990-1-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: am3rX5PjVs2l-MfD3QYvUpOfBxoAYfiy
X-Authority-Analysis: v=2.4 cv=CupFcm4D c=1 sm=1 tr=0 ts=67cec730 cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=GV-Fn4z6lk5qDZWrX1MA:9 a=324X-CrmTo6CU4MGRt3R:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: am3rX5PjVs2l-MfD3QYvUpOfBxoAYfiy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_04,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1011
 suspectscore=0 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503100087

Provide PHY configuration for the USB QMP PHY for QCS615 Platform.

Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Link to v3:
https://lore.kernel.org/all/20241224084621.4139021-4-krishna.kurapati@oss.qualcomm.com/
 
Changes in v4:
First two patches in v3 are merged. Rebasing this patch on top
of phy/next. No changes in code and v3 applies cleanly so keeping
RB from Dmitry unchanged. Also changing mail ID from quicinc to OSS
mail ID.

 drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
index cf12a6f12134..5e7fcb26744a 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
@@ -1124,6 +1124,9 @@ static const struct of_device_id qmp_usbc_of_match_table[] = {
 	}, {
 		.compatible = "qcom,qcm2290-qmp-usb3-phy",
 		.data = &qcm2290_usb3phy_cfg,
+	}, {
+		.compatible = "qcom,qcs615-qmp-usb3-phy",
+		.data = &qcm2290_usb3phy_cfg,
 	}, {
 		.compatible = "qcom,sdm660-qmp-usb3-phy",
 		.data = &sdm660_usb3phy_cfg,
-- 
2.34.1


