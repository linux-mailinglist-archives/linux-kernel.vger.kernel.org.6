Return-Path: <linux-kernel+bounces-561349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3769CA61058
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D36F219C003F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA531FE452;
	Fri, 14 Mar 2025 11:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NxJi0e2r"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17FF1FECA9
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 11:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741952761; cv=none; b=IzDtNGvkCqDLoVihdlYKNtNHAh+Gugikdu83rqK8yMcTP4t69gMZmn4SxV20rPcW8F5i50yOBI9rtTd/pDdr63CwNiuOZ7uB1HQTZ4xdiqn+7eZ7yiVuC718A/EBGeog5I5ohmcPJQEIdTlgaa6OPvutL94JlTcPqTLxRu7mE9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741952761; c=relaxed/simple;
	bh=ruBEfoMwzZH39i3/UnFKZ+4dD1O0Kgi8BMe8Do6Tncc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aROyZou3xiqV8Q3Q2Zni8PWIE+w5xTKlFvDm3aG465ptFfq/J+JFzaLozjaPHRZ2PBYl38XzjK1dEteMlXeOK9XzUDVW/cePwZROsx3e3s14Vpg6gfnjGZhtbDLNfRsEOu8rlpqWJ4gyT0rujhw4KxbBbYZhGQFkBKPrxN4i1lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NxJi0e2r; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52EATY6f005811;
	Fri, 14 Mar 2025 11:45:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Slm+QcWnMt+vSRjRU
	5hHB8Yv0leGrSO3vsQoycHpWIg=; b=NxJi0e2rEoO6cLqSbTanr0QpsgyamTJcW
	aOHTQvM3rlUHYXnAyxjtufDoPUH4vno13vMlxtGBm14XnViPT1lS3gxSgrkO2f9G
	DxiC+WDtBMOsrJpAzbL2T9IdMYoCgrSmXCu3mr9rSkXvi9Khj95SbFUi6Q0E7DBa
	isf+apfW5JPa/eaEoxJGO7/bQ165k6voPN579DRtIbPr4KuL1zm24r6ghfvDNoDB
	u1pcdbV2f0zzq87/j/odEqFoOJpM4XA/vf70lep4HUvX6N7fCtoBK9XkOKSmUtym
	oQw+KsGzmxeXIDqdzTh5Uusr4fjaEd6gvSAKNI3nSBOR7jepP3W6g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45c6s5b9nd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 11:45:44 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52EBUH2k024757;
	Fri, 14 Mar 2025 11:45:44 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45c6s5b9n9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 11:45:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52E93At9026021;
	Fri, 14 Mar 2025 11:45:43 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45atspprh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 11:45:43 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52EBjeh940894912
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Mar 2025 11:45:40 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1AF9920040;
	Fri, 14 Mar 2025 11:45:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C7A422004B;
	Fri, 14 Mar 2025 11:45:36 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.22.126])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Mar 2025 11:45:36 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: sshegde@linux.ibm.com, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        mpe@ellerman.id.au, peterz@infradead.org, fbarrat@linux.ibm.com,
        ajd@linux.ibm.com, mahesh@linux.ibm.com, oohall@gmail.com,
        hbathini@linux.ibm.com, dhowells@redhat.com, haren@linux.ibm.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] powerpc: powernv: ocxl: use lock guard for mutex
Date: Fri, 14 Mar 2025 17:15:01 +0530
Message-ID: <20250314114502.2083434-6-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250314114502.2083434-1-sshegde@linux.ibm.com>
References: <20250314114502.2083434-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WDlYtrigkizWK_eI8Sa89vGVzvko9BVd
X-Proofpoint-ORIG-GUID: 0lY6FIU1w1S_4lE9ReG44QVTstmVYxWc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_04,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=826 clxscore=1015 impostorscore=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2503140091

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


