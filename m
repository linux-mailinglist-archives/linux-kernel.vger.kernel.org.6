Return-Path: <linux-kernel+bounces-560704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62136A60874
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 06:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CA5119C261B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 05:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929FB1519A7;
	Fri, 14 Mar 2025 05:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gbfO1J9+"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EC214F9FB
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 05:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741931205; cv=none; b=MFPgkEhup7f2IM+JcjlSZKDKawybhK9DZspQ9nEymmDYgTu7oty93/9kmrIsSyVO0pv8ef/OmB7nXydthQ84IjUJcFDI0VoB1I5nXacy3aP5R8o+kJ+oWEhcA16m/1nsp2F9VCUcZQqnCmM+cYYwGVq9nfrvQXySQYn1nZ1nOnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741931205; c=relaxed/simple;
	bh=nHt6dLmpT+cU0vpK8p0HKXXQqhiW/4EwnSQCOVzgpCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UoEjWt2lVKeWpqoWflrI12OBDodDKd71xUp4Vopzg9zq4drEnrC4At3vwdYVvHpzosh2IN+1g1cuCMd0IKyVX77RrzOF7LjmmwwL5ExAtNXWrUiTGYIcZGWthzvoadNlDV6VkzkeTlG+kXdDxvPUvVGKLGakqKRwV1Xx6jN1uGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gbfO1J9+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DNP1bZ030636;
	Fri, 14 Mar 2025 05:46:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=TRESxEA7oSzae+g2+
	qPdwZ3SY0VvRAeOCRjwooFoXNE=; b=gbfO1J9+reFi0uSM20HWE+Dl++v12FC69
	He00EeREGF8gLvKtMJyBhsat9mqBJBg7mZeoE9tKHC4d/FlmyjT1abIz70dteAQr
	qZOyzeWR0e8RpuYvX2IbhSq3iKeP2VRJb47paa90atnqWzWY3m1CkN7RfpLjs0R1
	MZXT0hvHFb1kuVXCAHcMd2g8AXbAH/VD1KJEyH4XFQgQA7CUWgr8cV9KrBKex6Pm
	P8rHUSMCPvkyfVz7Hmp10ZC2peUV436+nvrSkoLFa/jSBm+axxzZxZE5/WpqjExu
	ffPosp2p91uSkUbSqyo8LCB8rYYOvuqvgwYTJbxjHejlj8vlOzUzw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45byd8vf9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 05:46:28 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52E5ix79028924;
	Fri, 14 Mar 2025 05:46:27 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45byd8vf98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 05:46:27 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52E4sdw8007412;
	Fri, 14 Mar 2025 05:46:26 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45atsrddjg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 05:46:26 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52E5kMcq30343448
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Mar 2025 05:46:22 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BE3B2004E;
	Fri, 14 Mar 2025 05:46:22 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0982A20043;
	Fri, 14 Mar 2025 05:46:19 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.22.126])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Mar 2025 05:46:18 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: sshegde@linux.ibm.com, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        mpe@ellerman.id.au, peterz@infradead.org, fbarrat@linux.ibm.com,
        ajd@linux.ibm.com, mahesh@linux.ibm.com, oohall@gmail.com,
        hbathini@linux.ibm.com, dhowells@redhat.com, haren@linux.ibm.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] powerpc: book3s: vas: use lock guard for mutex
Date: Fri, 14 Mar 2025 11:15:42 +0530
Message-ID: <20250314054544.1998928-5-sshegde@linux.ibm.com>
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
X-Proofpoint-GUID: MTYBMPTK44BLY-d_dLxUWXy3Ux07JK09
X-Proofpoint-ORIG-GUID: bAwwU9RXnhl8ikrbv8vkFXqPGf_ZU3xR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_01,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=872 clxscore=1015 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503140041

use guard(mutex) for scope based resource management of mutex.
This would make the code simpler and easier to maintain.

More details on lock guards can be found at
https://lore.kernel.org/all/20230612093537.614161713@infradead.org/T/#u

There is also an example of using scoped_guard. 

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 arch/powerpc/platforms/book3s/vas-api.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/platforms/book3s/vas-api.c b/arch/powerpc/platforms/book3s/vas-api.c
index 0b6365d85d11..eb1a97271afb 100644
--- a/arch/powerpc/platforms/book3s/vas-api.c
+++ b/arch/powerpc/platforms/book3s/vas-api.c
@@ -425,7 +425,7 @@ static vm_fault_t vas_mmap_fault(struct vm_fault *vmf)
 		return VM_FAULT_SIGBUS;
 	}
 
-	mutex_lock(&txwin->task_ref.mmap_mutex);
+	guard(mutex)(&txwin->task_ref.mmap_mutex);
 	/*
 	 * The window may be inactive due to lost credit (Ex: core
 	 * removal with DLPAR). If the window is active again when
@@ -437,11 +437,9 @@ static vm_fault_t vas_mmap_fault(struct vm_fault *vmf)
 		if (paste_addr) {
 			fault = vmf_insert_pfn(vma, vma->vm_start,
 					(paste_addr >> PAGE_SHIFT));
-			mutex_unlock(&txwin->task_ref.mmap_mutex);
 			return fault;
 		}
 	}
-	mutex_unlock(&txwin->task_ref.mmap_mutex);
 
 	/*
 	 * Received this fault due to closing the actual window.
@@ -494,9 +492,8 @@ static void vas_mmap_close(struct vm_area_struct *vma)
 		return;
 	}
 
-	mutex_lock(&txwin->task_ref.mmap_mutex);
-	txwin->task_ref.vma = NULL;
-	mutex_unlock(&txwin->task_ref.mmap_mutex);
+	scoped_guard(mutex, &txwin->task_ref.mmap_mutex)
+		txwin->task_ref.vma = NULL;
 }
 
 static const struct vm_operations_struct vas_vm_ops = {
@@ -543,18 +540,16 @@ static int coproc_mmap(struct file *fp, struct vm_area_struct *vma)
 	 * close/open event and allows mmap() only when the window is
 	 * active.
 	 */
-	mutex_lock(&txwin->task_ref.mmap_mutex);
+	guard(mutex)(&txwin->task_ref.mmap_mutex);
 	if (txwin->status != VAS_WIN_ACTIVE) {
 		pr_err("Window is not active\n");
-		rc = -EACCES;
-		goto out;
+		return -EACCES;
 	}
 
 	paste_addr = cp_inst->coproc->vops->paste_addr(txwin);
 	if (!paste_addr) {
 		pr_err("Window paste address failed\n");
-		rc = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
 	pfn = paste_addr >> PAGE_SHIFT;
@@ -574,8 +569,6 @@ static int coproc_mmap(struct file *fp, struct vm_area_struct *vma)
 	txwin->task_ref.vma = vma;
 	vma->vm_ops = &vas_vm_ops;
 
-out:
-	mutex_unlock(&txwin->task_ref.mmap_mutex);
 	return rc;
 }
 
-- 
2.39.3


