Return-Path: <linux-kernel+bounces-560705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E702A60875
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 06:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A22A63A1157
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 05:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470241624FC;
	Fri, 14 Mar 2025 05:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="p4E29TPj"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC1315A848
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 05:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741931207; cv=none; b=o5vwSpcp7fUb3MyqO0KOh7tfhipU5LUOBsnDggb5XjS9UiS3YoPgA7B2jXG1wpFNSRGp/hr75d2W4zLOjYfCQ4fA/9Ju85WDfwZZQPQ0nUJqge8o5jJsmYo+17h4h5q+JW0D1ZyuR3v5cgdFd2CEX8N2rl+KXzhGiw8fRTn6rTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741931207; c=relaxed/simple;
	bh=ruBEfoMwzZH39i3/UnFKZ+4dD1O0Kgi8BMe8Do6Tncc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=poy53DoJpNKOmIAE6RWRo0mr3TR/k4BcsAbQAePv3vsF/CdRAHmol8OQTOf51YB8pXA0FlIifQw4N/X+6TsUTNLpi/UfTVEqa3OCSa/HNBb2zz0CMCDeoEtxATznmRY9tNy+qJ4EOzn6Oo5FKADO/JmsUQFoKTr5o8NhXYp/bAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=p4E29TPj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DNOvDK018097;
	Fri, 14 Mar 2025 05:46:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Slm+QcWnMt+vSRjRU
	5hHB8Yv0leGrSO3vsQoycHpWIg=; b=p4E29TPj7uPkh0elSoSXMUQguAd/iNUu2
	XeVUlS5IUYZM+VuPmolqtNi5FmfjyaEckHSZ6TvnRqjzbxoBHW4vKfa+KuoqUSdr
	l/gLZAqi3/TTqmvpIgYcdj0W5tW35izlt6iFgcX5znUgXkFEpGbcrFRd/lkqgsko
	gtsrAH1e/03bjLWDJU50k5zGJewrgOEoZ1RyABkCGJzPylT1LeyvhxDM4GHxrPem
	v4Q+6fOVyGQY1B+COGOLb6Ao5JSnL8HzYF7lk+NJp9hRF9La6qC5tt5gcunJFj5U
	Jr4AFl06YaI+xHTaiV9NV9TCHfOR0Ci4Xrmw/f0AvKmv4A+lA3fLQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45c0srbwdb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 05:46:32 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52E5kVgV012946;
	Fri, 14 Mar 2025 05:46:31 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45c0srbwd9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 05:46:31 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52E4S8aQ003148;
	Fri, 14 Mar 2025 05:46:30 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45atstwess-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 05:46:30 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52E5kRQY23003404
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Mar 2025 05:46:27 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 437C52004B;
	Fri, 14 Mar 2025 05:46:27 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E7E6820040;
	Fri, 14 Mar 2025 05:46:23 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.22.126])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Mar 2025 05:46:23 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: sshegde@linux.ibm.com, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        mpe@ellerman.id.au, peterz@infradead.org, fbarrat@linux.ibm.com,
        ajd@linux.ibm.com, mahesh@linux.ibm.com, oohall@gmail.com,
        hbathini@linux.ibm.com, dhowells@redhat.com, haren@linux.ibm.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] powerpc: powenv: oxcl: use lock guard for mutex
Date: Fri, 14 Mar 2025 11:15:43 +0530
Message-ID: <20250314054544.1998928-6-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250314054544.1998928-1-sshegde@linux.ibm.com>
References: <20250314054544.1998928-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hOAh2jrwfqOKyxz43bSzBNe7auPwMxaK
X-Proofpoint-GUID: VfIWj_W0UKqk5AiwHFnE4EH2KH-C0QeM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_01,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 phishscore=0 mlxlogscore=830 mlxscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503140041

use guard(mutex) for scope based resource management of mutex.
This would make the code simpler and easier to maintain.

More details on lock guards can be found at
https://lore.kernel.org/all/20230612093537.614161713@infradead.org/T/#u

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 arch/powerpc/platforms/powernv/ocxl.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/ocxl.c b/arch/powerpc/platforms/powernv/ocxl.c
index 64a9c7125c29..f8139948348e 100644
--- a/arch/powerpc/platforms/powernv/ocxl.c
+++ b/arch/powerpc/platforms/powernv/ocxl.c
@@ -172,12 +172,11 @@ static void pnv_ocxl_fixup_actag(struct pci_dev *dev)
 	if (phb->type != PNV_PHB_NPU_OCAPI)
 		return;
 
-	mutex_lock(&links_list_lock);
+	guard(mutex)(&links_list_lock);
 
 	link = find_link(dev);
 	if (!link) {
 		dev_warn(&dev->dev, "couldn't update actag information\n");
-		mutex_unlock(&links_list_lock);
 		return;
 	}
 
@@ -206,7 +205,6 @@ static void pnv_ocxl_fixup_actag(struct pci_dev *dev)
 	dev_dbg(&dev->dev, "total actags for function: %d\n",
 		link->fn_desired_actags[PCI_FUNC(dev->devfn)]);
 
-	mutex_unlock(&links_list_lock);
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, pnv_ocxl_fixup_actag);
 
@@ -253,12 +251,11 @@ int pnv_ocxl_get_actag(struct pci_dev *dev, u16 *base, u16 *enabled,
 {
 	struct npu_link *link;
 
-	mutex_lock(&links_list_lock);
+	guard(mutex)(&links_list_lock);
 
 	link = find_link(dev);
 	if (!link) {
 		dev_err(&dev->dev, "actag information not found\n");
-		mutex_unlock(&links_list_lock);
 		return -ENODEV;
 	}
 	/*
@@ -274,7 +271,6 @@ int pnv_ocxl_get_actag(struct pci_dev *dev, u16 *base, u16 *enabled,
 	*enabled   = link->fn_actags[PCI_FUNC(dev->devfn)].count;
 	*supported = link->fn_desired_actags[PCI_FUNC(dev->devfn)];
 
-	mutex_unlock(&links_list_lock);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pnv_ocxl_get_actag);
@@ -293,12 +289,11 @@ int pnv_ocxl_get_pasid_count(struct pci_dev *dev, int *count)
 	 *
 	 * We only support one AFU-carrying function for now.
 	 */
-	mutex_lock(&links_list_lock);
+	guard(mutex)(&links_list_lock);
 
 	link = find_link(dev);
 	if (!link) {
 		dev_err(&dev->dev, "actag information not found\n");
-		mutex_unlock(&links_list_lock);
 		return -ENODEV;
 	}
 
@@ -309,7 +304,6 @@ int pnv_ocxl_get_pasid_count(struct pci_dev *dev, int *count)
 			break;
 		}
 
-	mutex_unlock(&links_list_lock);
 	dev_dbg(&dev->dev, "%d PASIDs available for function\n",
 		rc ? 0 : *count);
 	return rc;
-- 
2.39.3


