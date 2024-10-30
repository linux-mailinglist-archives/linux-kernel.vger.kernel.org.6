Return-Path: <linux-kernel+bounces-388268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 428C19B5CEB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 08:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0337B2149F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 07:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283411DC1A2;
	Wed, 30 Oct 2024 07:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Azox7cRy"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B919F85931
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 07:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730273225; cv=none; b=OU1aVegNyWZHgdn6zK07utVIYqNmmBRFoogx2v9oUJSNKZ4SG2OH1AeMIRwMoU3M+R2mfZZppjUQSJ3r+25qARpFKC6CVZrKeRdF0cBa7JNokriTsEO2aJncTIpPjAac5FvIjRNAQB+tblXL/HoOnZ9bL3GypBd3tYookKd0FZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730273225; c=relaxed/simple;
	bh=xWQoH8VAfhvJoIm5bKZ4CxmOKhWlkidOghTm5/TTAy0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=khCKI5sA4GIsojfB53yBZwIsh4rzE/USGE428DdfElsPuFnnnIQM66TOt7WRPXZwrMwHUjGAfnLFNDB7xJ9uq5ELISLbqpZBTDMGDeDb941xbHJ6eibj5yKjZM7gd32Oj4v+AOCt7CAyzJ+/4v55w9B9hYAACYoul8K/Vih/Sik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Azox7cRy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TMRMF9018745;
	Wed, 30 Oct 2024 07:26:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=kADonSwPqbWY02deI/90hv
	BXFxAQZc7rfAEBMFI6QII=; b=Azox7cRyQr68nLEdCJLzhlH0YZUkJmy71YXMLv
	xPUgrZArZwSOwYXRFB2RMC8gzE4NMtfGBXTdti4vRSYRouJkBB3hOqDRGoUdwgYZ
	2UhvZVwiVpFbaEEyupTdORDoIIPyquSihE248xOyZM38uoPq3bZGXZuhz7hEU7Th
	WF+xsGO0wWjZgNNVVcpg+RE2RXGQzPUxcKK5EnNwJrEVUdCtLhtPwqwpmeJcIlhm
	hZmES0goQp1CmnEVJaT1kqJXt3Rnuc/WT1gLk9S+YZPLZO0sMakUd8agYAi4/zuJ
	0UbQ+J+o8gzfBLY0IOxBsr6dYbB3gwaYkAi+XSbvZv6Vqaeg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42gqe62ykx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 07:26:32 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49U7QURl011984
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 07:26:30 GMT
Received: from shaojied-gv.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 30 Oct 2024 00:26:28 -0700
From: Shaojie Dong <quic_shaojied@quicinc.com>
To: Richard Weinberger <richard@nod.at>,
        Anton Ivanov
	<anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>
CC: Benjamin Berg <benjamin.berg@intel.com>,
        Tiwei Bie
	<tiwei.btw@antgroup.com>,
        Shaojie Dong <quic_shaojied@quicinc.com>,
        <linux-um@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] um: Remove double zero check
Date: Wed, 30 Oct 2024 15:26:09 +0800
Message-ID: <20241030072609.1645401-1-quic_shaojied@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tWNFPUx_CQn6pqFohoziJNXjLh3pzA9F
X-Proofpoint-ORIG-GUID: tWNFPUx_CQn6pqFohoziJNXjLh3pzA9F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxlogscore=857 malwarescore=0 adultscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410300057

free_pages() performs a parameter null check inside
therefore remove double zero check here.

Signed-off-by: Shaojie Dong <quic_shaojied@quicinc.com>
---
 arch/um/kernel/skas/mmu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/um/kernel/skas/mmu.c b/arch/um/kernel/skas/mmu.c
index d3fb506d5bd6..0eb5a1d3ba70 100644
--- a/arch/um/kernel/skas/mmu.c
+++ b/arch/um/kernel/skas/mmu.c
@@ -46,8 +46,7 @@ int init_new_context(struct task_struct *task, struct mm_struct *mm)
 	return 0;
 
  out_free:
-	if (new_id->stack != 0)
-		free_pages(new_id->stack, ilog2(STUB_DATA_PAGES));
+	free_pages(new_id->stack, ilog2(STUB_DATA_PAGES));
  out:
 	return ret;
 }
-- 
2.34.1


