Return-Path: <linux-kernel+bounces-238365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AB0924932
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5293C285950
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 20:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0C5201243;
	Tue,  2 Jul 2024 20:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Jdk7sGe5"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2707B282E1;
	Tue,  2 Jul 2024 20:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719952081; cv=none; b=lTXlWzJeki7yTQPKBFV250kpnreDNtqY8SHNHD/7GpiqcGus+ExpnJ/n+TgDvnPriwhorRiFwZByCDT95eZxEVru16VXYGCkR4jVn/ODMm8e7BxnZ0CzDXGjyFH0/tbftisbAKSmohsocegorOKeiOBRI/8JQsE9gIEw3HUn9Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719952081; c=relaxed/simple;
	bh=gTyn2ADNAcJwdLB2lOekeMjmY/ioOnz6zhNtYg46M4M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=gSiE30AD/7IBgvpYVpI1fdSayN7XajcQMjmj/ehpn2UPQBTunQgjvrfBWMvAldIBqdFsRMuPCbJlnshRQLeSr9E55yTLvbGieRzcIrxXifef5/uSXqbD41bF9OkOC7PKlmguojCYWQWkkA/12Jo5XGNxhEN0hfB+5U0xG4ecEmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Jdk7sGe5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 462IJVb3009131;
	Tue, 2 Jul 2024 20:27:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=pDoDdNk1hd0Hd67iYs0FEz
	BCbvrGkjAB6hRRSe/fjws=; b=Jdk7sGe5sYLYXB7s7bCzy9JskRu32+KZcYO3T9
	Z6waoW8x0knOeY/SefPytZddytOzH3vqLeqJrEpWoeqCY5iPUCaowIyp+fz+VOeR
	YeojYF5fGW80ufbEZKQ/AyIYocvMdEw3T6kqjVgdFImfGquPhKazIcYWWF0KxAv7
	nYJQGLtfFctFLvxBj/NkJdDuxCfiOQyD/Rdlm4CkBX5GGn5j6H9c7LFfB/11z0/j
	0rIfci0N0eJ4KkLrWmTcRqLjFeCetI0UJrNaE3QctIvfbjxNEKyxRj43+zloRY5k
	/e6GsDj1WsKsvNMTFAQseBcdh/6jp9YoYBQzC4tfU4xKX3LQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 402bj89frs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jul 2024 20:27:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 462KRZDS019008
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Jul 2024 20:27:35 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 2 Jul 2024
 13:27:34 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Tue, 2 Jul 2024 13:27:34 -0700
Subject: [PATCH] hostfs: add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240702-md-um-fs-hostfs-v1-1-fd2b565027e7@quicinc.com>
X-B4-Tracking: v=1; b=H4sIALVihGYC/x3MQQrCMBCF4auUWTsQQ7XoVcTFJJ2YAZPKTFsKp
 Xc3unp8i/fvYKzCBvduB+VVTKbacD51EDPVF6OMzeCd793gPJYRl4LJME82t0l05RDTcPH9Ddr
 ro5xk+xcfz+ZAxhiUasy/zlvqsmEhm1nhOL6JOBJQgAAAAA==
To: Richard Weinberger <richard@nod.at>,
        Anton Ivanov
	<anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>
CC: <linux-um@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6UaXOYRe2t3aiAHmrPsbINGoxEGKxR0D
X-Proofpoint-GUID: 6UaXOYRe2t3aiAHmrPsbINGoxEGKxR0D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-02_15,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 spamscore=0 suspectscore=0 mlxlogscore=990 mlxscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407020150

With ARCH=um, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/hostfs/hostfs.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 fs/hostfs/hostfs_kern.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index a73d27c4dd58..ff5f14ffa838 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -1010,4 +1010,5 @@ static void __exit exit_hostfs(void)
 
 module_init(init_hostfs)
 module_exit(exit_hostfs)
+MODULE_DESCRIPTION("User-Mode Linux Host filesystem");
 MODULE_LICENSE("GPL");

---
base-commit: 1dfe225e9af5bd3399a1dbc6a4df6a6041ff9c23
change-id: 20240702-md-um-fs-hostfs-fa6ebcf75249


