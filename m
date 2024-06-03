Return-Path: <linux-kernel+bounces-199624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CEC8D89A2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 21:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7007F28B186
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 19:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41E613B2B4;
	Mon,  3 Jun 2024 19:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="U8idsLAu"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C503613B287;
	Mon,  3 Jun 2024 19:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717441720; cv=none; b=RQ21bcyKHPuzj4uhisf3tCh8vOkeqT+00rqbl2rtbFB5aLc9sjSAbGmgitOukvvekIGtQkvBSkN+7VVY/ldluzOKUXz45LFzSSM0YTAu9xtlx+4Vs70u8ItD8gEyxlxADviQmKV67BU21+QLQFvbDHL07JCJQKuuu2nOPonjvdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717441720; c=relaxed/simple;
	bh=F/TK9OcxivDRmYkoq1xiln0SMyd/XO2PpVVZ5xeEJ/U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=Az1WXrZrVmC4RQJ8kZ+Gp/LyFfyEsw4Rc4AVrnmLr5zTrY11zDdyF5kBBwvOvPXP6DQ+dzCh8EMJ+TuX4EW3Qpv2hdOFlSt3ldpvNIqUMvGmvwLr45M716c8mB67KC/sAEBxaptcE2ISczPHsc5D9fCN84s3nTvKxjs6v1Cx1dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=U8idsLAu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 453BLFrS021300;
	Mon, 3 Jun 2024 19:08:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=V3XSllfSI8aiZfLLyosstx
	n33bIag5OldLcqt9tDy4Q=; b=U8idsLAu7agaSY9ACDz+BcfXJ8Wo3H/hF18B07
	d6Wsqfkfdf8Wurmusm/ftx1gFSZMvRSlCs9LvSd1suRdihiiAXkR1r7gqmvIVbmw
	OWJtgF5yk337vWnvHRMiFtvRfoMuVgDLbRwBYKc/6mbUQIRHEVHnejYzPiAk84CW
	/DEfCc8p3c9rZaI0qMGojCwh9u1d2hP4H+lG/FG7Gv5pYXjqvCGvjgRV/ogm44v1
	4xNEhtZuSHBx1H0X77ZO8q8h6h3Txwl+dsrGQafXnHC7OzleISHOyBXJs9IO/6ya
	BBd87couF6A6LlRqLz7NZss4DG98hTpENaz9WYgKb4fJNofQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw4an1g9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 19:08:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 453J8Y3K007292
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Jun 2024 19:08:34 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 3 Jun 2024
 12:08:33 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Mon, 3 Jun 2024 12:08:32 -0700
Subject: [PATCH] char: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240603-md-char-misc-v1-1-25d43d6f331d@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAK8UXmYC/x3M0QrCMAyF4VcZuTaQ1VHBVxEv0ja6gK2SOBmMv
 bvVy4/D+TdwMRWH87CByUddn61jPAyQZ253QS3dEChMFOmItWAfDKt6xjFFLhRONHGEfnmZ3HT
 95y7X7sQumIxbnn+Rh7Zlxcr+FoN9/wJ/m5pMfQAAAA==
To: Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8iCGYLuUTvGCT_vha9RCmoRncIjvbY-O
X-Proofpoint-ORIG-GUID: 8iCGYLuUTvGCT_vha9RCmoRncIjvbY-O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_15,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0 adultscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406030155

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/char/ttyprintk.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/char/lp.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/char/nvram.o

Add the missing invocations of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
These are the ones left after addressing the ones in
drivers/char that had explicit MAINTAINERS entries.
---
 drivers/char/lp.c        | 1 +
 drivers/char/nvram.c     | 1 +
 drivers/char/ttyprintk.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/char/lp.c b/drivers/char/lp.c
index 2f171d14b9b5..5faebe0365c5 100644
--- a/drivers/char/lp.c
+++ b/drivers/char/lp.c
@@ -1123,4 +1123,5 @@ module_init(lp_init_module);
 module_exit(lp_cleanup_module);
 
 MODULE_ALIAS_CHARDEV_MAJOR(LP_MAJOR);
+MODULE_DESCRIPTION("Generic parallel printer driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/char/nvram.c b/drivers/char/nvram.c
index e9f694b36871..9eff426a9286 100644
--- a/drivers/char/nvram.c
+++ b/drivers/char/nvram.c
@@ -540,6 +540,7 @@ static void __exit nvram_module_exit(void)
 module_init(nvram_module_init);
 module_exit(nvram_module_exit);
 
+MODULE_DESCRIPTION("CMOS/NV-RAM driver for Linux");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_MISCDEV(NVRAM_MINOR);
 MODULE_ALIAS("devname:nvram");
diff --git a/drivers/char/ttyprintk.c b/drivers/char/ttyprintk.c
index 4c806a189ee5..d7f841ab4323 100644
--- a/drivers/char/ttyprintk.c
+++ b/drivers/char/ttyprintk.c
@@ -228,4 +228,5 @@ static void __exit ttyprintk_exit(void)
 device_initcall(ttyprintk_init);
 module_exit(ttyprintk_exit);
 
+MODULE_DESCRIPTION("TTY driver to output user messages via printk");
 MODULE_LICENSE("GPL");

---
base-commit: a693b9c95abd4947c2d06e05733de5d470ab6586
change-id: 20240603-md-char-misc-1b6ad02704a6


