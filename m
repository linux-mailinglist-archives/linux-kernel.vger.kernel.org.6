Return-Path: <linux-kernel+bounces-189121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1029D8CEB81
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 22:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A357BB21793
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 20:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EDC86245;
	Fri, 24 May 2024 20:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="V4HQA5PO"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D9784A31;
	Fri, 24 May 2024 20:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716583914; cv=none; b=fdUnbHTu80l4/yVOAI4p7bwrmTCLtEw5L/xPd7mwbdFiv5Afxzk7oOLHtcYnzTq3WKdok1lvUr/aTQilRt+Lr8dZV+s0foRWVrjZ0ZpFymUQsm82RcLoexRjVS1xmySzwkLxvP7SrhToaE1CvpcPOClSmqKqCW9TVEwGmokv3ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716583914; c=relaxed/simple;
	bh=wVb0lzpmx8ccsfWnbGaK7PZEp7OlXYT/aejBpVtFiS0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=Gon6+FgmoamlJ6K/elwicm8amRIcCy310QvisjTPDt7LfPoBk/u7iNxXxD7NniqfA94ZEw0EXgu1+dAf9Oy+qU3XUdRJklrOO0uZpOjbmM4VQu0xr6b89gqVYvJkJOfx6KYyAUaclgBD9Cuq3uzqo8o9wdCifLp1YpewF53iBDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=V4HQA5PO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44OK0sRG016429;
	Fri, 24 May 2024 20:51:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=q1gu4x5jVVvHSwt0EO6udP
	X9cQqj+yCr+2hd/iuyJaU=; b=V4HQA5POsfmmZmhqnp2xUOXQku255yRTLjQpWp
	yb1iB+YAU0uiXJ+96pMgY9JZX0oLD3cODTp/BnMp4b5CY0LGLzRn4VT5IBwHIHhs
	TH8DNZ0OnKrLPIrkv5d+zxy+eprQmqfCwrhZPgEg9HVV5UqvLG8MgbGJM+w5x8CF
	CEuqCex1blgJISHcbJe5phwxw+4JrMzIAElsZcdbqNT1PSlvN6rLB19s08DdmXic
	osX+QibKTzIUJdmfODiAzPWsx1p37eATkITVarf2p5xnY5SeLrlXOLOajytHpdqI
	SSv/a9c7aE6Lgd7jBPYOUy9S7PJ/27t/e82asp2eNBTzTStg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yb1j582ab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 May 2024 20:51:47 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44OKpkix015335
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 May 2024 20:51:46 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 24 May
 2024 13:51:46 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Fri, 24 May 2024 13:51:46 -0700
Subject: [PATCH] qnx4: add MODULE_DESCRIPTION()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240524-md-qnx4-v1-1-5ae060082e5f@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAOH9UGYC/x3MUQrCMBCE4auUfXYhhhTBq4gPaTJtF+xasyqR0
 rsbffzgn9nIUARG526jgreY3LXheOgozVEnsORm8s4H1/vAS+aH1sDJISME5HwaqdVrwSj1/3S
 5Ng/RwEOJmubf/ib6qrxEe6Lw+mkp7fsXEj/E5n4AAAA=
To: Anders Larsen <al@alarsen.net>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pUYz9jJEBD1ztxQD9h4pPR8O3L6otlsI
X-Proofpoint-ORIG-GUID: pUYz9jJEBD1ztxQD9h4pPR8O3L6otlsI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-24_07,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 clxscore=1011
 adultscore=0 mlxlogscore=897 suspectscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405240149

Fix the 'make W=1' warning:
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/qnx4/qnx4.o

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 fs/qnx4/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/qnx4/inode.c b/fs/qnx4/inode.c
index d79841e94428..e399e2dd3a12 100644
--- a/fs/qnx4/inode.c
+++ b/fs/qnx4/inode.c
@@ -430,5 +430,6 @@ static void __exit exit_qnx4_fs(void)
 
 module_init(init_qnx4_fs)
 module_exit(exit_qnx4_fs)
+MODULE_DESCRIPTION("QNX4 file system");
 MODULE_LICENSE("GPL");
 

---
base-commit: 07506d1011521a4a0deec1c69721c7405c40049b
change-id: 20240524-md-qnx4-c0ede44edd7f


