Return-Path: <linux-kernel+bounces-185534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F24BF8CB669
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 01:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F940B2139C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 23:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898F514A611;
	Tue, 21 May 2024 23:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g6cUrmqR"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D8D58AB9
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 23:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716335718; cv=none; b=cN045tGrpka/YVZ6er92R7DgDYirZF66jsPcTHlcNWFjKbs63N8MzMkljUol6HQS2E97vRUTPYMznS4Jgi/E749qS/cPGMBpjbvPX8squ5B77hWLshgCavtEGQdfIVqpNK2UfJ+0wLGi34JLdlKk91oCnpkPZ4nTvq9231h1WVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716335718; c=relaxed/simple;
	bh=bu3dUrEttL0jhrzOAsEVq2ALqieoahCw/j2brR0L42A=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PeDTZKUHT/ZdoMkbzOyruIlZ35/leVTxj4Xw+q5FHpt9yMPUtad6IjfMJ/II2wBk7kxHWvrC/q7hZnQdyhVoKAVsdztYvrLO3e4DUV9XHYq4DpsddtYLRWMVLrC1dnsFVAdwyVNOQBS2cVEidZW9tR2lmz7o/CcSMRNeLnHU4j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=g6cUrmqR; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44LJkCvG016732;
	Tue, 21 May 2024 23:55:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=uGf2vROyvg6ZwMJ/Hw9eQH29lzC7eJMyJb27dxpCla8=;
 b=g6cUrmqR0x6RsZLklZW3C4yPOprOOlqOabivyLBi5K34GjPi1uBH4gEk33FmgbZijwgo
 yL5DHU5SbsvaTOe2Mpsin+IDSQyt3m5kix9y2mHjY1GsheO09ZlAvUT0wTGZ9q4ZHMc4
 SCMHgSJDmicGy1fnDevChzwRdfStdVdgExvqtnuDDeR7s24DtvJkXfIXJIQ7VbklfuGo
 xNvCuTtvOXVZvoPsFT1Xdb0PH4SfStl41HmzY0K/Rov+ETG5RUKOTOL4kt/WiPD1pzaG
 ktn4cwsBAGqOdsUapynVBGGDWyfDHn8rYty9cHDU5+MHNSFB930W16IhsUwIeoflVuCx bQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6jx2efc5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 May 2024 23:55:07 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44LMZkKT002667;
	Tue, 21 May 2024 23:55:05 GMT
Received: from brm-x62-16.us.oracle.com (brm-x62-16.us.oracle.com [10.80.150.37])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3y6js8erce-3;
	Tue, 21 May 2024 23:55:05 +0000
From: Jane Chu <jane.chu@oracle.com>
To: linmiaohe@huawei.com, nao.horiguchi@gmail.com, akpm@linux-foundation.org,
        osalvador@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/5] mm/madvise: Add MF_ACTION_REQUIRED to madvise(MADV_HWPOISON)
Date: Tue, 21 May 2024 17:54:26 -0600
Message-Id: <20240521235429.2368017-3-jane.chu@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240521235429.2368017-1-jane.chu@oracle.com>
References: <20240521235429.2368017-1-jane.chu@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-21_14,2024-05-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405210181
X-Proofpoint-GUID: s8TZqutMV_sNhtOaqmw9r6gFiSZXwMpt
X-Proofpoint-ORIG-GUID: s8TZqutMV_sNhtOaqmw9r6gFiSZXwMpt

The soft hwpoison injector via madvise(MADV_HWPOISON) operates in
a synchrous way in a sense, the injector is also a process under
test, and should it have the poisoned page mapped in its address
space, it should get killed as much as in a real UE situation.
Doing so align with what the madvise(2) man page says: "
"This operation may result in the calling process receiving a SIGBUS
and the page being unmapped."

Signed-off-by: Jane Chu <jane.chu@oracle.com>
Reviewed-by: Oscar Salvador <oalvador@suse.de>
---
 mm/madvise.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index c8ba3f3eb54d..d8a01d7b2860 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1147,7 +1147,7 @@ static int madvise_inject_error(int behavior,
 		} else {
 			pr_info("Injecting memory failure for pfn %#lx at process virtual address %#lx\n",
 				 pfn, start);
-			ret = memory_failure(pfn, MF_COUNT_INCREASED | MF_SW_SIMULATED);
+			ret = memory_failure(pfn, MF_ACTION_REQUIRED | MF_COUNT_INCREASED | MF_SW_SIMULATED);
 			if (ret == -EOPNOTSUPP)
 				ret = 0;
 		}
-- 
2.39.3


