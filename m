Return-Path: <linux-kernel+bounces-516447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1ECA3719C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 02:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1191B3AF912
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 01:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57555C8CE;
	Sun, 16 Feb 2025 01:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IFBbSwP+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EF823A9
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 01:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739670338; cv=none; b=KyqItBU66Tw5z42f/yIcdjZflkvpk5yCY9ITYWSxr2Ozxlco5iik4DVHhRUkN/XwBOhZAlFX7Upbj94l6cR8f2QSND6VtrLuxyuQfzlJRwVQaavkwtUF5114/F/fEt+cq/R4rxn4mUD1iv12mHMSvDfxdLOSYLWx3XYeNNnF6ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739670338; c=relaxed/simple;
	bh=6d/C0OzP206Bfx6ax3rRPN3TPah22XiTEZpdfRfQaV0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s976ys9rKlp8qYKbveWhX1aHY2mcsbKKJGV/3Q6+xtNIa6AZ3/UEZwiUTVjHcyjMsDf0EYayrAgbC5idSDxlgbh9MDcbPmmCajF3hrBIRj3BPM61s4DelQdC8e3gPNvk15N0UpHwpVFluliuNtL+/y6kyxArmT2uwFx1vxeLx1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IFBbSwP+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51G0ed7b020006
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 01:45:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=QChqI6vVHRRW6C7u3A4HFPKyjHOOONIPmTq
	BbAmlM34=; b=IFBbSwP+L+TKBLOwDGTSfMR5We3MsKpzulNpXwSmmpszde/zIOm
	Q8atyutJnYwGXXt5ApAhqftF4z3CgCIRxqaY4ffma2ANRT2wy/VpyT2ARs5t3vJf
	aVQCycsROPe94dL9Dz37E7CF0ZNfPZ5HyD0ICHeO4zWWN9UFkyB5CKQ9oaOSwMnz
	baNoZWcwENPE2huuhp7qJSzqnXVzKMBlg/pZygLUzuDyyJQ6hk1OZUQPJpTq2vrD
	GAdTggzkFcElz/AbFews+Q/PPuLkXeJWxyPayXAPdLyHrnuTWqM3z/VRssjLnUYN
	FMiqu6+jWjsEV2jndKlSmjhAbmhl4uF0MlQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44tkqj9b6w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 01:45:35 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-220e1593b85so52057745ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 17:45:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739670334; x=1740275134;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QChqI6vVHRRW6C7u3A4HFPKyjHOOONIPmTqBbAmlM34=;
        b=X3gV5vmGEbwdTHaUu/CQNYNlhyGfValh2S5zqNlgOGPr5fnppbzr5GP9xfHS+0AWjJ
         FqGl+SpGfbVq4UxcCKNV97JAxxxnuqOEpNVu2PjZ9DSsEgFQ3ci/Oi3+id7wzXPOyAaA
         SIb53gITf+3mmhj077awEZnMg5aZrWrKiA9dNUCCFWBP0LNjAupnNG1hu4JpXE/ov814
         L7MMQxKFaH50b9p2vmMSIZwdhjqe7fo/+dB9dogrnRkRZ1GV9mb4v6A2qn9R/HdxlZoe
         VBbyJ8ywvjuqPXva+ZLjH323jUYvEhLJ9EGrw1hkuR7Gfi22I2ktgkUy7gZKnfL8seH9
         02lA==
X-Forwarded-Encrypted: i=1; AJvYcCWpfIYNXqmQjgldp0WvqRE7X3gm+yj1dUjVdVmK31y2bbIstgJhvFLDYN+vB3pWOME2k0yUADVyrs7qWPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfD3/5v6J9GVeN8D2VRJlChwFL4dwHQhnN+0KUZSimGfQZ2pzX
	nijSSWx5cQ/WOJ8dFEsdXM2ylyeVtg+/ReA8Zty5Vl0m01o+2Y/BdKm6U4X/nCfalIqFzPtEEha
	Sltn/Al16YkkU9gjtEN7C5X+h4PtmySIrYkI55dV9GhzzIbzJaMeoPIpnmXqWmjA=
X-Gm-Gg: ASbGncsxvUWVXXtwP/7VSYkk/kpUg9C2t8iVDA6AN3zqgUxIn+se+K+li0nS8YMDHiH
	XY6uTWgAH7Jq0RwHAWbzQ9cHvcfxFkZ3f2UtvmAv5qGCyr2VGRqDiqJ7KbsR34mc5k4JtCH7Uy+
	3MFcoX1IBz1e1x5DSQ4zMTKd39AO26xYyW5KO/0FfU5Awx5VYbp22pl2iIQksc6qCJonw4t6rOU
	NuNRaT2roMCJKOIIiFK7MGP0gBhwSmyYSMnOxoWczL4W1bcOJ58K8e9IAaZJOzNAuGEb6LWQlW3
	1LAeFgnClJQP0CL/ioJdHRD+UZokEtNPn1ubHc3I
X-Received: by 2002:a17:902:fb45:b0:21f:89e5:2704 with SMTP id d9443c01a7336-221040b1427mr59927785ad.34.1739670334384;
        Sat, 15 Feb 2025 17:45:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGk0Wm6pBDN1zI1JP/eN7P464Mszuon80WKDa6iniNlFdMaUXzJp9MDPJ+nFawzsFqmexnMJw==
X-Received: by 2002:a17:902:fb45:b0:21f:89e5:2704 with SMTP id d9443c01a7336-221040b1427mr59927565ad.34.1739670333991;
        Sat, 15 Feb 2025 17:45:33 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d536455esm49896955ad.74.2025.02.15.17.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 17:45:33 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
To: andersson@kernel.org, robh@kernel.org, dmitry.baryshkov@linaro.org,
        manivannan.sadhasivam@linaro.org, krzk@kernel.org, helgaas@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        lpieralisi@kernel.org, kw@linux.com, conor+dt@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree-spec@vger.kernel.org, quic_vbadigan@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH V3 0/2] schemas: pci: bridge: Document PCI L0s & L1 entry delay and N_FTS
Date: Sun, 16 Feb 2025 07:15:08 +0530
Message-Id: <20250216014510.3990613-1-krishna.chundru@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: fEAwg2z7s6CLH9478w5l9metMEYNZCwh
X-Proofpoint-ORIG-GUID: fEAwg2z7s6CLH9478w5l9metMEYNZCwh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-15_09,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 mlxlogscore=999 suspectscore=0 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502160014

Some controllers and endpoints provide provision to program the entry
delays of L0s & L1 which will allow the link to enter L0s & L1 more
aggressively to save power.

Per PCIe r6.0, sec 4.2.5.1, during Link training, a PCIe component
captures the N_FTS value it receives.  Per 4.2.5.6, when
transitioning the Link from L0s to L0, it must transmit N_FTS Fast
Training Sequences to enable the receiver to obtain bit and Symbol
lock.

Components may have device-specific ways to configure N_FTS values
to advertise during Link training.  Define an n-fts array with an
entry for each supported data rate.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
changes in v3:-
- Update the description to specfify about entries of the array (rob)
changes in v2:-
- Split N_FTS & L1 and L0s entry delay in two patches (bjorn)
- Update the commit text, description (bjorn)

Krishna Chaitanya Chundru (2):
  schemas: pci: bridge: Document PCI L0s & L1 entry delay
  schemas: pci: bridge: Document PCIe N_FTS

 dtschema/schemas/pci/pci-bus-common.yaml | 12 ++++++++++++
 1 file changed, 12 insertions(+)

-- 
2.34.1


