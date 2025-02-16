Return-Path: <linux-kernel+bounces-516448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 070F2A371A2
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 02:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A714D1892FEC
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 01:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B9633EC;
	Sun, 16 Feb 2025 01:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QNGkFf93"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B3410A1F
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 01:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739670342; cv=none; b=P1uyIyk0X9j6GX+HTjBbo39jXGg9NRRcXQJhGRlFYXj2YogimHQ9NkujI/Wyiuzp8fPIfuBYQF64dmMp3eeXWDA7GD8oJGa4iKaKwVgMLwNkv0J57OLVE3lFLT7nLjzfwvR2kaB2ZhGJjNKq1vZ9OCByL27+S4s9Rdo7htDOu3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739670342; c=relaxed/simple;
	bh=Fk5tEvSGj966u5MNAJ6KeljaVlxKuCrisn/aqCxdhBw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OWjrkN5iOIJ2lqi2FBPXviL9+SBbWqgisWTLiQPpO70jeMgJfl26GZmfCutkQbG0lrDJ9LkhRETLLD3Sw2cyzwQmRED34gC3h9H0dPbtcHWLHLkcxgcr84vYPgSdNTmhNTTr56eZiudnS2Eim+x/S+HzROwv+McHaVDHL92H7NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QNGkFf93; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51G10Nkv020171
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 01:45:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=uBFsWeSYOmq
	gaCuFxuf/xhhEESZ518ip0a8YRr+64yE=; b=QNGkFf931rknH/8YWJAz9QemnD/
	f9RRsMjk5UY42TexsNNRuSOT5PlGKFuac1LCUTX46Q4AxVf9Vg8SQnNSIDq+JDCS
	LJkAZaZZJQsB4xzs+c+DTty0iJaYTm9RnxQaonF6VTjoEGMBlSIdJwxtrdlDCb/a
	6NwxEQRrNN1hiXkoIzjm9cPHcYlbNoVTYjvvE1CiimWecBrtbGXwEuvBzpCah6AM
	doEkLusongbS9ucxtJFGv93zaMsMBM0XQXTELuM+SYK3LZEwwuYsCsoLl7VJilXS
	7nqMcHTkiXus1EiuXt5YyIVH8YD35tHAnGEJ/2Dh48nv9b0OcPvSbGx1ouw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44tktf9b1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 01:45:40 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-220e7d654acso49082815ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 17:45:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739670339; x=1740275139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uBFsWeSYOmqgaCuFxuf/xhhEESZ518ip0a8YRr+64yE=;
        b=im5l02lQ0KGVZMNVywp985qsxee6JlbduxQXkejLsWbgW1AP5QU65XTyGtDf8TE7ut
         brNt0Jn5jfEjzj+QZEGzcG3j9DoD3XsxrhaoWS66LaXoQMNEQn9opXyDuzSAU/Db7buY
         5madkiCPaTM4Q6XFM4Q40M8Wm+6dLq6J1DI/1oE6wkns8QDl0/hlE7zayoEX4f80uFr7
         ErJ8Z+ao2BR6gXdiRY+NN8oxjGWDK5zTdvvdKZwuSd5cQPgWu7quNLGD61rSiE9VSVlK
         /LqKqrEyOMVCpozOmuQhvpGGKhgvb4bJCFoUgwnu/03BSPafossREavD53eGvPSHD0CA
         +emg==
X-Forwarded-Encrypted: i=1; AJvYcCUO6NYbqawetTZCepLqpqXohuNpWhf/MPp8pFWMpufnwdxT2O80+O13NCyO3dSQOjRhLO/n+7v89f9SpA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAcym9sgbgst2oPcB4s1g1Sfos+vDo41Rkdz+7B3KJofuzJzGK
	x1hggtnDxrmNHD4q8X9WL3xloPsUuLpd4dT/I6llw2o8LmBleZKEUyqGNZdw6HEPVapaN8IMmz4
	qEAsEZzeqh/bmqqEHvdALDbKALZ8wEMCImmZh+K1KoRGpB40b4QR2xGSe1sfu4eU=
X-Gm-Gg: ASbGncuq5HpTphkCUBT+gGfdjq7GTByfTEcrqpTn7kIKSTJ3IJIxNMkYNpHlA1hoBcf
	GQDrOZ9LxgnFo5v6V5CO7fGwzY3SIfGIzWE5nYJJ+yaZ1y8pwUdgOSP+yyp0KX7x1t8Jurf7+2E
	k9RgmrPj1WVIvCl24nWjZXHEEdxz2AMpBH+WvE2aZbTV5cSdiBbl6Ct/bTbiIJ69vWT21+A4soe
	kNBb21ZiUBMf6iIiz5YHWAEFipux3+bMTdVO6gjCuG1eUg70ms2C/1W0CxxOHBrYxOmD0nVDscT
	oKFczPmkn9fohSJAPReBCnauYV8Mmq3E5sgSeK56
X-Received: by 2002:a17:902:cf08:b0:220:fe36:650c with SMTP id d9443c01a7336-221047179dfmr77347025ad.23.1739670338768;
        Sat, 15 Feb 2025 17:45:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtn0S+vjVcVhx9pqmU7t/1GUwT1n4B1MxV5GxUJhmy6ojrRHtS/+9ejqHefQ8Ia6K1n3p9LQ==
X-Received: by 2002:a17:902:cf08:b0:220:fe36:650c with SMTP id d9443c01a7336-221047179dfmr77346735ad.23.1739670338393;
        Sat, 15 Feb 2025 17:45:38 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d536455esm49896955ad.74.2025.02.15.17.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 17:45:38 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
To: andersson@kernel.org, robh@kernel.org, dmitry.baryshkov@linaro.org,
        manivannan.sadhasivam@linaro.org, krzk@kernel.org, helgaas@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        lpieralisi@kernel.org, kw@linux.com, conor+dt@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree-spec@vger.kernel.org, quic_vbadigan@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH V3 1/2] schemas: pci: bridge: Document PCI L0s & L1 entry delay
Date: Sun, 16 Feb 2025 07:15:09 +0530
Message-Id: <20250216014510.3990613-2-krishna.chundru@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250216014510.3990613-1-krishna.chundru@oss.qualcomm.com>
References: <20250216014510.3990613-1-krishna.chundru@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 3ikJ4to3cGhKS0dB7T0Q5WcPuD9bgPwh
X-Proofpoint-GUID: 3ikJ4to3cGhKS0dB7T0Q5WcPuD9bgPwh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-15_09,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 impostorscore=0
 priorityscore=1501 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502160014

Some controllers and endpoints provide provision to program the entry
delays of L0s & L1 which will allow the link to enter L0s & L1 more
aggressively to save power.

These values needs to be programmed before link training.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 dtschema/schemas/pci/pci-bus-common.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/dtschema/schemas/pci/pci-bus-common.yaml b/dtschema/schemas/pci/pci-bus-common.yaml
index 94b648f..a9309af 100644
--- a/dtschema/schemas/pci/pci-bus-common.yaml
+++ b/dtschema/schemas/pci/pci-bus-common.yaml
@@ -150,6 +150,12 @@ properties:
     description: Disables ASPM L0s capability
     type: boolean
 
+  aspm-l0s-entry-delay-ns:
+    description: ASPM L0s entry delay
+
+  aspm-l1-entry-delay-ns:
+    description: ASPM L1 entry delay
+
   vpcie12v-supply:
     description: 12v regulator phandle for the slot
 
-- 
2.34.1


