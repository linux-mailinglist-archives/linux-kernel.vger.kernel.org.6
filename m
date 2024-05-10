Return-Path: <linux-kernel+bounces-175318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F668C1E0B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 08:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA1601C21268
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 06:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D406A15B147;
	Fri, 10 May 2024 06:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ifn5HH/1"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD5515E5D2
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 06:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715322391; cv=none; b=DapxgnvdD/MYEViOSP4RHLjQnr0G66E43duERTgs6ZzA6JwyLr1lNAUEBEfb6piN14HInDiI11QBVGUUnpejR6vIykW2Rpktxq01OOSMtEZDMWOXjOL9YddmYNB5HYKJ+g1qbZyJFoJMZSGZNS3cKzpm1/tNv1CFtKOdqgHx1a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715322391; c=relaxed/simple;
	bh=jqEa403Ip4Q6H3qKGudKAM9jGLLfwsy4VGx1KPzYp8o=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AlWO1awEn+UlBZCO9tuKFVmGaYgzmORzOSv+hvZ3wzL2RDO+YvyUF+cpaBNwfKcENlc9QR1Y4plVTQVNPIXJThT3tLBHfdI8yPNW/7wGvY1N1dmHhOYuuH5j/A3ps426dGitfE+7pMFbeZnElUfgS0Bd8abDnvtFoSPhB1q9azY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ifn5HH/1; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44A5t5Pv016630;
	Fri, 10 May 2024 06:26:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=uBRlM7MJKT+rrKvwlBySf0eucmcAfjmJ5dD+RRq8pvY=;
 b=Ifn5HH/16jXv/KuOyh0nU7ZLOCsuKELF+k0X9V9hWXtSrm2ohy/Omb5WgHC2u7/8UTkj
 /aNgAVKlFaQnD8OwSgRkHmdFUS4nJK80kxrKf6wCNUul/ixRVKtOLdrUe3/IJzZ3BtL0
 5qzayJ0RJ5IqrjOofx2TK3QfCGSyDP7h02vAoHydjq+jQ7gx9trzJT8vylYQ5KXFZMqa
 HC/DFgxYodABvbZYlNn3KCgWZtaOCKWAtHFH6iBc1Mo5IOTFR5hr+WMEWpkdJa/Uubur
 wFy3XgAIUHOJC6HxTL2g8eZWqUdWZC6uwcMUtObkRcL9SWrZnqwBSFRVXusEUexd2Fi4 FA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y1a0j88g4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 May 2024 06:26:17 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44A5vUjI020104;
	Fri, 10 May 2024 06:26:16 GMT
Received: from brm-x62-16.us.oracle.com (brm-x62-16.us.oracle.com [10.80.150.37])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3xysfpghcd-3;
	Fri, 10 May 2024 06:26:16 +0000
From: Jane Chu <jane.chu@oracle.com>
To: linmiaohe@huawei.com, nao.horiguchi@gmail.com, akpm@linux-foundation.org,
        osalvador@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] mm/madvise: Add MF_ACTION_REQUIRED to madvise(MADV_HWPOISON)
Date: Fri, 10 May 2024 00:25:59 -0600
Message-Id: <20240510062602.901510-3-jane.chu@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240510062602.901510-1-jane.chu@oracle.com>
References: <20240510062602.901510-1-jane.chu@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_04,2024-05-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405100044
X-Proofpoint-ORIG-GUID: RkkUKBZtDn54AUwSlFAoI0xSgUT30iF6
X-Proofpoint-GUID: RkkUKBZtDn54AUwSlFAoI0xSgUT30iF6

The soft hwpoison injector via madvise(MADV_HWPOISON) operates in
a synchrous way in a sense, the injector is also a process under
test, and should it have the poisoned page mapped in its address
space, it should legitimately get killed as much as in a real UE
situation.

Signed-off-by: Jane Chu <jane.chu@oracle.com>
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


