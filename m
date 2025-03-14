Return-Path: <linux-kernel+bounces-561344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 425FDA6104D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B255D882E86
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547541FDE3D;
	Fri, 14 Mar 2025 11:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aPok21Cp"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AA91FDE19
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 11:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741952743; cv=none; b=LnFyC/NnS3kMsUPYD4eoqUCxI96XLzW9yVHk2W4svJrxlACG69GON66kUlB+h7n1SCgnBzREh9VAtK9r1/qbotE1QFvgbBdUXuBTFi5M4LXqPceryAxXMb4fbywoNDN3q/sDwCIAwCrOpp3UjeOkiA/YFUHGsvm0LwrY7fSWRp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741952743; c=relaxed/simple;
	bh=JfkqTO4XQAFJC3G9pkhdVDCoq+KaJL7gqWaGsD8ehVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ev+vfs5PjWqx2U9mD141muRqo9YW+bJYQTplU/aQHa/Wa0ueMkBf12A6FoLh+jl5wFvBYq/m+/g3oqF3nqcC04/Xzf6QEexxK3n5PyyLS+C3u8l6/ljmbNyD/I1OVwTU3Zfw8WEi7wPydHeHRdb+PmzA8nHONCdSwi29lo+gw30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aPok21Cp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52E9d8D9005804;
	Fri, 14 Mar 2025 11:45:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=XxU5XP2xQsKie4KRP
	nlKDhPgga75rXA+r7mJnNP2BIg=; b=aPok21CpJprGHm/w34C5YGH9cufkq/pCl
	0DjQW28yt7zFX4DfaC/FJOw3KUT3hf1Jip32rUrjvzhjchxB28ZJbf3dSTxPB2w/
	8+AmMdFUAD2qB11Kf4VJJWTInOg/Dl94Qv65RoKsZ7KmzbZ0TrDqtvBc+NFY8bej
	PwuBMcfC+98i8ih7tzHIfKgv+UGz74oLo187Pc3GIX76TKBu8GDfLHga11ww0Y9e
	FunRhs66cNReq1ly3UlSOWt4EEznLVsMYtZT3xO836KDMDHLxmOEjYrkkAoT+B5H
	hiS871KV2Js05xtg6l1QBee+cIBCmk+WHyyFeHvcijmEpBVa9CZPQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45c6s5b9mk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 11:45:27 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52EBe7ob016034;
	Fri, 14 Mar 2025 11:45:27 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45c6s5b9mh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 11:45:27 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52E9334q007468;
	Fri, 14 Mar 2025 11:45:26 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45atsrepht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 11:45:26 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52EBjMfZ45023522
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Mar 2025 11:45:22 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 739A320040;
	Fri, 14 Mar 2025 11:45:22 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2909F2004B;
	Fri, 14 Mar 2025 11:45:19 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.22.126])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Mar 2025 11:45:18 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: sshegde@linux.ibm.com, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        mpe@ellerman.id.au, peterz@infradead.org, fbarrat@linux.ibm.com,
        ajd@linux.ibm.com, mahesh@linux.ibm.com, oohall@gmail.com,
        hbathini@linux.ibm.com, dhowells@redhat.com, haren@linux.ibm.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] powerpc: eeh: use lock guard for mutex
Date: Fri, 14 Mar 2025 17:14:57 +0530
Message-ID: <20250314114502.2083434-2-sshegde@linux.ibm.com>
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
X-Proofpoint-GUID: UturKL8y2FZj2RR3JkdIyvvHbWZN1fG9
X-Proofpoint-ORIG-GUID: kqQps5Cxte0KhNP6-ur22Y3F7FQeCl-p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_04,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=808 clxscore=1015 impostorscore=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2503140091

use guard(mutex) for scope based resource management of mutex.
This would make the code simpler and easier to maintain.

More details on lock guards can be found at
https://lore.kernel.org/all/20230612093537.614161713@infradead.org/T/#u

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 arch/powerpc/kernel/eeh.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 83fe99861eb1..929474c0ec77 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -1208,16 +1208,16 @@ int eeh_dev_open(struct pci_dev *pdev)
 	struct eeh_dev *edev;
 	int ret = -ENODEV;
 
-	mutex_lock(&eeh_dev_mutex);
+	guard(mutex)(&eeh_dev_mutex);
 
 	/* No PCI device ? */
 	if (!pdev)
-		goto out;
+		return ret;
 
 	/* No EEH device or PE ? */
 	edev = pci_dev_to_eeh_dev(pdev);
 	if (!edev || !edev->pe)
-		goto out;
+		return ret;
 
 	/*
 	 * The PE might have been put into frozen state, but we
@@ -1227,16 +1227,12 @@ int eeh_dev_open(struct pci_dev *pdev)
 	 */
 	ret = eeh_pe_change_owner(edev->pe);
 	if (ret)
-		goto out;
+		return ret;
 
 	/* Increase PE's pass through count */
 	atomic_inc(&edev->pe->pass_dev_cnt);
-	mutex_unlock(&eeh_dev_mutex);
 
 	return 0;
-out:
-	mutex_unlock(&eeh_dev_mutex);
-	return ret;
 }
 EXPORT_SYMBOL_GPL(eeh_dev_open);
 
@@ -1252,22 +1248,20 @@ void eeh_dev_release(struct pci_dev *pdev)
 {
 	struct eeh_dev *edev;
 
-	mutex_lock(&eeh_dev_mutex);
+	guard(mutex)(&eeh_dev_mutex);
 
 	/* No PCI device ? */
 	if (!pdev)
-		goto out;
+		return;
 
 	/* No EEH device ? */
 	edev = pci_dev_to_eeh_dev(pdev);
 	if (!edev || !edev->pe || !eeh_pe_passed(edev->pe))
-		goto out;
+		return;
 
 	/* Decrease PE's pass through count */
 	WARN_ON(atomic_dec_if_positive(&edev->pe->pass_dev_cnt) < 0);
 	eeh_pe_change_owner(edev->pe);
-out:
-	mutex_unlock(&eeh_dev_mutex);
 }
 EXPORT_SYMBOL(eeh_dev_release);
 
-- 
2.39.3


