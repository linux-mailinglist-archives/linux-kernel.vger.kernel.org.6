Return-Path: <linux-kernel+bounces-189127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE73E8CEB8B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 22:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 636A6281FD1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 20:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1E5130ADD;
	Fri, 24 May 2024 20:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="namQGzio"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0718130A66;
	Fri, 24 May 2024 20:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716583980; cv=none; b=GcGrSIyfzhdbeE4fOfnFdjRG84BBM75/C7RorRmNKzCJWrgLLeMKyR/XEKA0zZTnt1mCWSHMczU7qGACByAYl2Xls8qB+p4XiwAWCuLD/NJdH5KRm2FChK0PNnKa9pQw2o5zYGmtItG6ebQnvuwn1louVIXMmVKtowiRP6/a63g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716583980; c=relaxed/simple;
	bh=aAPEA8YiMWVDh0kdSQzZM6OYsr5S8UATZ4K88DTAx70=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=eENJwCaWv7Bfs/36tnOZHaPaDPOrMNN74HheONuCTRhmSPq9FGoFZAL8twR1RqOjhgDVBSwZU/49ite3cy7SbKcQXUTGGwHhW56xzfUqjvF6OJG3sSoWlg13SqJHsp7UG1QztHqCILZ7E2Fbfb9GDKCwsdoVgXIEq7AXbbAlv4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=namQGzio; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44OA2742017979;
	Fri, 24 May 2024 20:52:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=RIwBwqSDskgBfkqWitmbuX
	hVYh3yX8eUMqWJY+s6DdM=; b=namQGzio6teguoWqMDdwyoJbO5Rho8o8t8Qxp+
	KiHuZ6JfanGAyhY3DRDYiy+HkwmlYij9zL+pvCp6AXqXQauWHJ51hsqWPN8R7iou
	ByMR0Z7sUGr95Cz62HuTtdg/YM1o5CdBgUC+k+xDqEeJmMz01oAY99cy8NCzybGE
	/RESVhoM3feW86nlcqMFL0q3WbRnNF64D+VXVe6gqgj0EDPJQyf51l5Q3NsihWFp
	IBFnNTRXgPqXAJ/zF8wzoAsgSt73w8jgaHJWsNYHfdyOAQdkNq39SQ8TaaDyxKXc
	8kyoXJxSqMZOYiHoaEOszqo+Fm9H3BHuQ/4e8mxwKUk/6Sug==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yaa8hue9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 May 2024 20:52:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44OKqqC8016869
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 May 2024 20:52:52 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 24 May
 2024 13:52:52 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Fri, 24 May 2024 13:52:52 -0700
Subject: [PATCH] qnx6: add MODULE_DESCRIPTION()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240524-qnx6-v1-1-cf3b9de68347@quicinc.com>
X-B4-Tracking: v=1; b=H4sIACP+UGYC/x3MQQrCQAyF4auUrA1khjpVryJdTGu0AR1rojJSe
 nejyw/+9xYwVmGDQ7OA8ltM7sURNg2MUy4XRjm5IVJsaRtbfJSaMHW0p9ClXaIAns7KZ6n/m2P
 vHrIxDprLOP3GVymvirdsT1acP57Cun4BuKetNXsAAAA=
To: Anders Larsen <al@alarsen.net>, Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bCmUXlFEUvw7rI3_lltKYvgqp7ji787T
X-Proofpoint-ORIG-GUID: bCmUXlFEUvw7rI3_lltKYvgqp7ji787T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-24_07,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=897 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405240149

Fix the 'make W=1' warning:
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/qnx6/qnx6.o

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 fs/qnx6/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
index d62fbef838b6..4f1735b882b1 100644
--- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -694,4 +694,5 @@ static void __exit exit_qnx6_fs(void)
 
 module_init(init_qnx6_fs)
 module_exit(exit_qnx6_fs)
+MODULE_DESCRIPTION("QNX6 file system");
 MODULE_LICENSE("GPL");

---
base-commit: 07506d1011521a4a0deec1c69721c7405c40049b
change-id: 20240524-qnx6-670901768601


