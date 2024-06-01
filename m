Return-Path: <linux-kernel+bounces-197614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BB18D6D19
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 02:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BECCC1F270DC
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 00:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4266CEDB;
	Sat,  1 Jun 2024 00:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="e10+U6Ot"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F1E37E;
	Sat,  1 Jun 2024 00:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717200809; cv=none; b=Cc52w5T9iuFyW5DVrE8Khi6s+uhqLJkmRUBEaRBYzzvEJUntCC+ceLBPfCHkAn+YxZNvBFOWIXfRc2cdBOTGRrNWoe139O38Bnl7H9ji1h8Jom21gFb+ehWMAKnzq9zVQApAxk8FIbQp8HMMoUUSm0ApMLwWIwS4cHtaPsFoL1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717200809; c=relaxed/simple;
	bh=U3IpMTGlVC35y/n/a2+QExIY8OMaGJQZnI54eqpiEKA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=G6RlbTkOjhzceZaOk0zyIJ+7sCl9xCzk9QdpiAXVkkTShBHUN0opdigojtJpSdjhV/1hzkaXMj4iH90VtPCfWdHJin2WHiCS11N5tgTLXpJoOx/DORL+eGEDPW/1WaF0cXEk0dePiVZMFaMNfFXGgMVPDJetfxw8NppRFuuNO/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=e10+U6Ot; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44VFRLQp031606;
	Sat, 1 Jun 2024 00:13:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=U3IpMTGlVC35y/n/a2+QEx
	IY8OMaGJQZnI54eqpiEKA=; b=e10+U6Otr29RRxPvyI1dDFnbZ1uYQI8kx+mTZs
	2xaFwgnVEYL8UzoI/3R8XJ/eERU08XfRQhGYdATVQ8+Ekt30ts7EDfk2b9cwiHzr
	7eR4p8rP0/wYPhjWbNvgukSQhHPrZ3CKFIOHqN4E3fdmaHAKRXh8ULlPGbN9FUMV
	71xuf46ttwk0iv5QUF/r4KvXoWszZtuNV5sQeBe7ga56mSXcbAZLRG+oDL3s2usn
	3UMqnqOnEV84Z0nLSg7SC6+fKH8ac1lnXq+yWFgJe4Y3HEByQgKWOd31J7HLuYtX
	ThWRhM1zrNcyyx2wZgmD7k+3rkkcUIo7Vac1STynKEnygeJg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yf8xa2kaq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 01 Jun 2024 00:13:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4510DG0v021416
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 1 Jun 2024 00:13:16 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 31 May
 2024 17:13:16 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Fri, 31 May 2024 17:13:16 -0700
Subject: [PATCH] test_maple_tree: add the missing MODULE_DESCRIPTION()
 macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240531-md-lib-test_maple_tree-v1-1-7b1b485aeec3@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAJtnWmYC/x3M0QqDMAxA0V+RPC9gdU7cr4whqWYz0HaSdEMQ/
 33dHs/DvTsYq7DBtdpB+SMmr1TgThVMC6Uno8zF0NTNue5ah3HGIB4zWx4jrYHHrMzYuZna4eL
 6wfVQ4lX5Idt/fLsXezJGr5Sm5bcLkt4bRrLMCsfxBRn0xnOHAAAA
To: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett"
	<Liam.Howlett@oracle.com>
CC: <linux-kernel@vger.kernel.org>, <maple-tree@lists.infradead.org>,
        <linux-mm@kvack.org>, <kernel-janitors@vger.kernel.org>,
        Jeff Johnson
	<quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UHMNlEdKt6nGiY76iG2tw_J54Qt1Qk0k
X-Proofpoint-ORIG-GUID: UHMNlEdKt6nGiY76iG2tw_J54Qt1Qk0k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_14,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 impostorscore=0 clxscore=1011 lowpriorityscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405310185

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_maple_tree.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 lib/test_maple_tree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index 399380db449c..31561e0e1a0d 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -3946,4 +3946,5 @@ static void __exit maple_tree_harvest(void)
 module_init(maple_tree_seed);
 module_exit(maple_tree_harvest);
 MODULE_AUTHOR("Liam R. Howlett <Liam.Howlett@Oracle.com>");
+MODULE_DESCRIPTION("maple tree API test module");
 MODULE_LICENSE("GPL");

---
base-commit: b050496579632f86ee1ef7e7501906db579f3457
change-id: 20240531-md-lib-test_maple_tree-51da39617917


