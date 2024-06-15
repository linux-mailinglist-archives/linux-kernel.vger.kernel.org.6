Return-Path: <linux-kernel+bounces-216018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 904789099F8
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 23:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ADCB1C21400
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 21:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7F761FF4;
	Sat, 15 Jun 2024 21:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QQln3jiK"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13E217C96;
	Sat, 15 Jun 2024 21:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718486085; cv=none; b=j2Z0E2oN8qcQPnLI81HJx4b9+wB2pawaUFcklxJnexms5PV15zCQDA785LOVb1T86VIOCJSUR2yCCnAZ+83GpqVY/OQ6rzQrYUGUZY7d7Unk0ouT/PB1lvHhGNM+2Cs67nOrPlbFYk3kLNkZOYNp7Zc7ia0XOpxIOUWSd5d4bCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718486085; c=relaxed/simple;
	bh=fCBKGEZzmu9O02RzlCooF0zRIpXmoFdLc47+2h7jC1Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=eWnLaT6KHOjHvW6ze+Ryt0wXczuaJHEb+7wIerP37miNB05aaenJwZu1cTMMRJIMWkjd5pn5VXRQZrjg0WH/PHzOjlGLzjcLgmb8kjLOx29zwDm8FUtEBS6hfmIn1Ia0v2ooeBOVMrRdWISezSCFekz9lsNR3WqrT4ZV2uUUdNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QQln3jiK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45FL99wF001703;
	Sat, 15 Jun 2024 21:14:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=/YlvqD+Ji752fOOiO0MkOp
	ghUYL8YUaEuX93FOgxL5s=; b=QQln3jiKvPFbdDwOBTu2bLyLQUjMDERtqm4qSh
	KqSmJiCDnOTOG7+4ND6KE/ExGH7vZbTNWBHH6BdAPoyjdqMRSnVlWwzyc+OpPcuE
	lzuXhp9oA3Px35vn0scEMBfVyNDW7BgnG4oXHY58Y2XkkWOpK6Q5+YqsfvfA821Z
	btYRV0dNUpoUEs+/PBMVqGD4VRUSjFaWSDKCu1gmh6sEEbL8IdK5Xu8e7r5Ve0zG
	fOJoxuOJ3jmwJnTcwDYJnhcbnlbNjfSWTy4+nDW+hpkK9Idl1Zx2EFraOVNt1df5
	xZNGTx1yvR8ebUoQZzoOZCEjOacy3zlGR6dDou2J6zaLUDEg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ys488s03u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Jun 2024 21:14:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45FLEdGT014026
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Jun 2024 21:14:39 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 15 Jun
 2024 14:14:38 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sat, 15 Jun 2024 14:14:36 -0700
Subject: [PATCH] bsr: add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240615-md-powerpc-drivers-char-v1-1-bff22fd778a4@quicinc.com>
X-B4-Tracking: v=1; b=H4sIADsEbmYC/x3M3QrCMAyG4VsZOTawdj84b0U86NroAq4ric7B2
 L0bPXzg+94dlIRJ4VLtILSy8pIN7lRBnEJ+EHIyg699W/euwzlhWT4kJWISXkkUbSg4uGZoPTW
 pO/dg7yJ05+1fvt7MY1DCUUKO06/35PzecA76IoHj+AL4giaJiAAAAA==
To: Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: K22iJQqUmKpL7KT_XN2FLL_IvxPGoR7u
X-Proofpoint-ORIG-GUID: K22iJQqUmKpL7KT_XN2FLL_IvxPGoR7u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-15_14,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 malwarescore=0 adultscore=0 mlxscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406150162

With ARCH=powerpc, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/char/bsr.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/char/bsr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/bsr.c b/drivers/char/bsr.c
index 70d31aed9011..837109ef6766 100644
--- a/drivers/char/bsr.c
+++ b/drivers/char/bsr.c
@@ -342,5 +342,6 @@ static void __exit  bsr_exit(void)
 
 module_init(bsr_init);
 module_exit(bsr_exit);
+MODULE_DESCRIPTION("IBM POWER Barrier Synchronization Register Driver");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Sonny Rao <sonnyrao@us.ibm.com>");

---
base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
change-id: 20240615-md-powerpc-drivers-char-913942e3d586


