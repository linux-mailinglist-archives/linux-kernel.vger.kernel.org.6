Return-Path: <linux-kernel+bounces-189158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE268CEBEE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 23:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 739731F221BD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 21:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E87A129E74;
	Fri, 24 May 2024 21:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BljuSLIh"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2648612E
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 21:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716587610; cv=none; b=j741K8klozwvAuAc3MDcUuRSiT5pEb1ZfgcUJSI8UtIxkgZUde3wTcA59IkaF9P3ozzwCZfOGmU5yTx50jk2F6BZnwj76j18jTVhkC+7KGSyVf9w7k60iAz/8sKzlpN0qGgt6sXCD8kCYrMsI8VbfU1RMHSHrCLtAsxuE+AI68w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716587610; c=relaxed/simple;
	bh=mT+QH+hU8g5l3Zv5v9XCenrx59MVtbIUnXCOz0uw8J4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oFjlvcY6KTjutFX0uI60j2Gh5DdR11K8/mCeThOvCVq2Ro3TGlrYDpe3RT8+g/USH1qObWKKTofRG2by3rZH1fWVJaOlscfY723adM3smlA1Z/1jVzDfRQTzkWEkWqjWUSPdaeG7UeEvGWXZdlHi3/+XAoP9qu4L9jk5gkhWwfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BljuSLIh; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44OIC2G4010959;
	Fri, 24 May 2024 21:53:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=fT0mhbFhuyfEQ6ht8rgkYeHmF9I9tk49P2eL39tTz8s=;
 b=BljuSLIhlHGj7+LZ9Fli7rwBFZcnSBIe7v8KKY5KV9Egm878l/J+VHH1xWXi8MoITsjp
 kT67s5ZBWYovpiWSkPQxGbIwGh+5yy25XDlcrS7IqgZ9tN0mFrep4btWoUP617Ak5UwF
 sTEf1cmEmBTiT8VL57c+SmsN5qxe07nReb5HNVL5rwTPrbgy0wl/Ttqd6Z8n06tl1pVH
 HdzgUAqITKS24dJjoA79lJp1QDcgdImTdegcU//MdKMPwvcgJP/0B0onuBIUPpJovgzX
 pz9xGdxlLjYOQDg+Can6zxaztk9PTsD2n/ASTnnqIZl4vJeJO5E5vl1qonSnInCZDOij 6w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6jx2n8wy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 May 2024 21:53:16 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44OLjG1A035956;
	Fri, 24 May 2024 21:53:15 GMT
Received: from brm-x62-16.us.oracle.com (brm-x62-16.us.oracle.com [10.80.150.37])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3y6jscbsu0-3;
	Fri, 24 May 2024 21:53:15 +0000
From: Jane Chu <jane.chu@oracle.com>
To: linmiaohe@huawei.com, nao.horiguchi@gmail.com, akpm@linux-foundation.org,
        osalvador@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/5] mm/madvise: Add MF_ACTION_REQUIRED to madvise(MADV_HWPOISON)
Date: Fri, 24 May 2024 15:53:03 -0600
Message-Id: <20240524215306.2705454-3-jane.chu@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240524215306.2705454-1-jane.chu@oracle.com>
References: <20240524215306.2705454-1-jane.chu@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-24_08,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405240157
X-Proofpoint-GUID: 7grlyNM4N9_MwCVNy18sOMTXeKd1BPaf
X-Proofpoint-ORIG-GUID: 7grlyNM4N9_MwCVNy18sOMTXeKd1BPaf

The soft hwpoison injector via madvise(MADV_HWPOISON) operates in
a synchrous way in a sense, the injector is also a process under
test, and should it have the poisoned page mapped in its address
space, it should get killed as much as in a real UE situation.
Doing so align with what the madvise(2) man page says: "
"This operation may result in the calling process receiving a SIGBUS
and the page being unmapped."

Signed-off-by: Jane Chu <jane.chu@oracle.com>
Reviewed-by: Oscar Salvador <oalvador@suse.de>
Acked-by: Miaohe Lin <linmiaohe@huawei.com>
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


