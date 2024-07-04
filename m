Return-Path: <linux-kernel+bounces-240874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF7A9273FE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 12:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9140A1C21343
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 10:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738A11ABC52;
	Thu,  4 Jul 2024 10:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P+VJVlXA"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771391AB908
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 10:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720088783; cv=none; b=Hgr9hb/7y6N7/427GLUlHbq/3kTy4lm0y8AnXBJE8T84cGZxDIRemFksXu9nDF+GDrjLULXW3PSAtGzAlTG3FwOc5b1kLfpbcJBxqwCqIJmOgkWZd6qem49fkfNx3qyN6EZ61qF8gE3sUHv0NrJxtp79uaNTeO9jaq49Y6R2RwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720088783; c=relaxed/simple;
	bh=h3E4WT2pJxswg3rBZtjgjLVx5HnJRGBne7qKSl90+QA=;
	h=Subject:From:To:Cc:Date:Message-ID:Content-Type:MIME-Version; b=AVF09XjHGpIiOkt+4l1TE7kB1o8Yjv4lB/bajCFHxgSfmw33qmzueN8pzPQ2KLsudgFtoSpThtJQep/xsz5ZT1IXL/MBDzjJkhy+ppfhdGVW9Nj2PeHwlwQYWINaVbU13vyFjV+3hHfQ2U4/ytpDGBz9tYVp1afsrM/goGkN5EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P+VJVlXA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4649vdbj014367;
	Thu, 4 Jul 2024 10:25:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	subject:from:to:cc:date:message-id:content-type
	:content-transfer-encoding:mime-version; s=pp1; bh=beaAn83Z14Fgy
	nHM1T6PvGwI5Mpl48BF0FwSGHvL8Ms=; b=P+VJVlXAdZEj6SSUUjOPbGMAJcsao
	GmSJlR2cpJy/6c1M3dFv7IKDwKx1Sy4ft873vw6P7qUlGEYUN7+DVN+6OSACJFvl
	af53qWaKj285p0bBK+kOUNZLUabSQxYqWgONXqEKeDB/MDLfM3JHzaVngxu5dQ8C
	VU+cuqCBKS8qvGo5ORi5zqlK3DpS46MTQ09FohZWngRu93cqL92mCOC500z327al
	4mI+IOg6S9oO6u8huE2WPQ0tjkI3MTEN5S4hpOauqlApSFlkOxK2tJDuc9wESfHR
	Y33Dklksl9IPUj2+Pj6HVgs+wGsVeB4T9kvsq9WzU0HkhYE0z8IPFqcFA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 405r8m892s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jul 2024 10:25:57 +0000 (GMT)
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 464APu2U023834;
	Thu, 4 Jul 2024 10:25:56 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 405r8m8911-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jul 2024 10:25:56 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4647YRf3026386;
	Thu, 4 Jul 2024 10:22:45 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 402wkq7jjk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jul 2024 10:22:45 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 464AMdm039125310
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Jul 2024 10:22:41 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C04E820043;
	Thu,  4 Jul 2024 10:22:39 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A9B320040;
	Thu,  4 Jul 2024 10:22:38 +0000 (GMT)
Received: from [172.17.0.2] (unknown [9.3.101.175])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Jul 2024 10:22:37 +0000 (GMT)
Subject: [PATCH] powerpc/pseries/iommu: Define spapr_tce_table_group_ops only
 with CONFIG_IOMMU_API
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
To: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Cc: npiggin@gmail.com, christophe.leroy@csgroup.eu, gbatra@linux.vnet.ibm.com,
        sbhat@linux.ibm.com, jgg@ziepe.ca, ruscur@russell.cc,
        linux-kernel@vger.kernel.org, tpearson@raptorengineering.com,
        msuchanek@suse.de, vaibhav@linux.ibm.com
Date: Thu, 04 Jul 2024 10:22:37 +0000
Message-ID: <172008854222.784.13666247605789409729.stgit@linux.ibm.com>
User-Agent: StGit/1.5
Content-Type: text/plain; charset="utf-8"
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: X3dxyxVRaFXE-JkPkAQcVZ3EaetPX8DY
X-Proofpoint-ORIG-GUID: FQCHDyXwtnorQwBRYtnOW0e3msDtdnlE
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_06,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=812 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 impostorscore=0
 phishscore=0 clxscore=1015 adultscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407040072

The patch fixes the below warning,
arch/powerpc/platforms/pseries/iommu.c:1824:37: warning: 'spapr_tce_table_group_ops' defined but not used [-Wunused-variable]

The other error reported by the test robot no longer exists on the top
of the tree due to later changes on the file.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202407020357.Hz8kQkKf-lkp@intel.com/
Fixes: b09c031d9433 ("powerpc/iommu: Move pSeries specific functions to pseries/iommu.c")
Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/iommu.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 672199ba7400..534cd159e9ab 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -68,7 +68,9 @@ static struct iommu_table *iommu_pseries_alloc_table(int node)
 	return tbl;
 }
 
+#ifdef CONFIG_IOMMU_API
 static struct iommu_table_group_ops spapr_tce_table_group_ops;
+#endif
 
 static struct iommu_table_group *iommu_pseries_alloc_group(int node)
 {
@@ -165,6 +167,7 @@ static unsigned long tce_get_pseries(struct iommu_table *tbl, long index)
 	return be64_to_cpu(*tcep);
 }
 
+#ifdef CONFIG_IOMMU_API
 static long pseries_tce_iommu_userspace_view_alloc(struct iommu_table *tbl)
 {
 	unsigned long cb = ALIGN(sizeof(tbl->it_userspace[0]) * tbl->it_size, PAGE_SIZE);
@@ -183,6 +186,7 @@ static long pseries_tce_iommu_userspace_view_alloc(struct iommu_table *tbl)
 
 	return 0;
 }
+#endif
 
 static void tce_iommu_userspace_view_free(struct iommu_table *tbl)
 {
@@ -738,6 +742,7 @@ struct iommu_table_ops iommu_table_lpar_multi_ops = {
 	.free = tce_free_pSeries
 };
 
+#ifdef CONFIG_IOMMU_API
 /*
  * When the DMA window properties might have been removed,
  * the parent node has the table_group setup on it.
@@ -757,6 +762,7 @@ static struct device_node *pci_dma_find_parent_node(struct pci_dev *dev,
 
 	return NULL;
 }
+#endif
 
 /*
  * Find nearest ibm,dma-window (default DMA window) or direct DMA window or
@@ -1845,6 +1851,7 @@ static bool iommu_bypass_supported_pSeriesLP(struct pci_dev *pdev, u64 dma_mask)
 	return false;
 }
 
+#ifdef CONFIG_IOMMU_API
 /*
  * A simple iommu_table_group_ops which only allows reusing the existing
  * iommu_table. This handles VFIO for POWER7 or the nested KVM.
@@ -2327,6 +2334,7 @@ static struct iommu_table_group_ops spapr_tce_table_group_ops = {
 	.take_ownership = spapr_tce_take_ownership,
 	.release_ownership = spapr_tce_release_ownership,
 };
+#endif
 
 static int iommu_mem_notifier(struct notifier_block *nb, unsigned long action,
 		void *data)



