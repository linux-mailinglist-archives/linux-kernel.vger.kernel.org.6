Return-Path: <linux-kernel+bounces-176126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C6D8C2A2D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 21:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 308931C231B6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 19:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BDD45978;
	Fri, 10 May 2024 19:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fwBvBKqC"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD5B43ADF;
	Fri, 10 May 2024 19:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715367743; cv=none; b=Y/w8JyWMBMhBcLWQGFtKLuVXIzMxdYJIcisMd6J7J/kEx/G4xy8+sKkhGZzIgGqz3fBOOPzEFYXV/AEyO0rXIyaXjXqneUdVVlAY2Fq8ajmGlqLDSVpWx92c0IsdDB/OnE5F3c4RnD6LvTzuje/da443mPr3CrkgMYUVGLeCP2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715367743; c=relaxed/simple;
	bh=PY7yO/kkHqsNTacKId8oceYK4e1mSLzHNFzRpX8/Apc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=GWG0HfpaVuRpNLCdev0COBA2quvnfasHstZNop3+0dohvZ5wP6vD9dKZmnha+2YvZVg8vZwXoTz1ULGyEIMmxaTyTW9o4TtN+zVgGiANuDMrsdA33QBAF+Lp4zgtdLZFJwQ6jCt0pSZiDCOBXObcmSwAUrf4GvbWuHiQVyJxvXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fwBvBKqC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44AE8udc029548;
	Fri, 10 May 2024 19:02:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=Mlr
	nFlTFcvQde5BLi/mz/csJVwz7jruJ6XQkyz94GJk=; b=fwBvBKqCCiUJSqRNmxU
	Y1b1QlEQ3nGEghAIKU0e0jDtZH/neseSD4vlplVGTuzMNIVPGvSzTlQVTqTNqUdB
	I//uaRbhDtDPv10OUarR2PzEHDKSAVWIVEckOHkLkKcw/NhjxU9wSlyZpdo11kl8
	Q1aybFEJko6IotRnUfab7mjxBZANT8dqXszzBh7ej/SpkloCE5Qaanfz4xYEgbhj
	Y2+bHV/LDlzV3A2ehHKbLm8PmGasxibaeba/QPA0eFBhLS67Gqbz0a2rq9vobf8D
	pVaTZmZNmpbZNkgU8omO/hZ9v20teJczkXK6relYAydTpGVHKt16IFf/8swGdVT+
	PEA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y16w1abt4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 19:02:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44AJ2GWJ027157
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 19:02:16 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 10 May
 2024 12:02:16 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Fri, 10 May 2024 12:02:15 -0700
Subject: [PATCH] fs: ufs: add MODULE_DESCRIPTION()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240510-ufs-md-v1-1-85eaff8c6beb@quicinc.com>
X-B4-Tracking: v=1; b=H4sIADZvPmYC/x3MwQqDQAwE0F+RnBtYxaL0V8RDdLMaqKsktQjiv
 zf1MvBgZk4wVmGDV3GC8ldM1uwoHwWMM+WJUaIbqlDV4VkG3JPhErGhpo2tZ0o1eHlTTnLcR13
 vHsgYB6U8zv/5W/J+4EL2YYXr+gFCbI6FdwAAAA==
To: Evgeniy Dushistov <dushistov@mail.ru>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Iz2skDyZPPQtOvPxSAECxkZjmPsFbz_L
X-Proofpoint-ORIG-GUID: Iz2skDyZPPQtOvPxSAECxkZjmPsFbz_L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_14,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 phishscore=0 mlxlogscore=787
 malwarescore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405010000 definitions=main-2405100136

Fix make W=1 warning:

WARNING: modpost: missing MODULE_DESCRIPTION() in fs/ufs/ufs.o

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 fs/ufs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index 44666afc6209..bc625788589c 100644
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -1540,4 +1540,5 @@ static void __exit exit_ufs_fs(void)
 
 module_init(init_ufs_fs)
 module_exit(exit_ufs_fs)
+MODULE_DESCRIPTION("UFS Filesystem");
 MODULE_LICENSE("GPL");

---
base-commit: dd5a440a31fae6e459c0d6271dddd62825505361
change-id: 20240510-ufs-md-7a78d87a7ff4


