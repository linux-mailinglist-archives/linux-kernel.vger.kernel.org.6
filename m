Return-Path: <linux-kernel+bounces-560701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65643A6086C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 06:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BA6817A97C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 05:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245FC148855;
	Fri, 14 Mar 2025 05:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RLZFBQDo"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEF37E0ED
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 05:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741931190; cv=none; b=KD/PbIGte5dMHry9n06PyMDzryLr/sneA+UtoUbPDmBhCmHF/iDjL9r74NJH0Fnkxag+DSybQ3fUkEAxQ+biK/Na4wxOjLlSr2GbSDVkj0i3Njw7iBaymsDzaVGg1QG5KuxqMMk6/MHt7RlnECLG3yWGMjzt0P1vE03N5V+WwqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741931190; c=relaxed/simple;
	bh=JfkqTO4XQAFJC3G9pkhdVDCoq+KaJL7gqWaGsD8ehVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=csVZ7bukaetoiWjR+phIYOxGhAFeP3gKFNVU6NOSXClb9q4kvJ1zH52Gs4oRmZegbjC2FJcZia9zxYZyzlq7iV1mw4VgxKmAgniGnEYd/Szq4nG2G/aEuDlQB/6HlDW4J4PGEAckxggAj5P8s6ONi6wemYKHDbh+nukhy4sMsX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RLZFBQDo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DNP6oG030794;
	Fri, 14 Mar 2025 05:46:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=XxU5XP2xQsKie4KRP
	nlKDhPgga75rXA+r7mJnNP2BIg=; b=RLZFBQDoalag5e52aYMwO2wI6p2VeWEEd
	vNh7pCFGhr99sxv9kkeDmpI3CMCI7c0ykWU7uh1gLDCyHbVGPbtHmKQVJsC4UQRN
	JBHfcBdu/paCRr2yaIe6nczjkFh+/bsqslsy8F3juMu7ak/G4ozK89LVPBo8l5PB
	3IuLMM1sQjdCxAHfK+B8CzIgHhU+7XKrdExLswgDFO7hisG22aJYLJny6sx1uU8X
	qwqEEcVcj0B35FZ+1exbguKx33PQlLTHxdJ7Jvldv0uGj4omoVpCJ+2QLNQBCb+8
	l9Q28NoAFjYsJKl7B2b+w+IOzdq5ygJA71wWm/FAlCwBL7gvPYZmA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45byd8vf8f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 05:46:12 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52E5kCqP031459;
	Fri, 14 Mar 2025 05:46:12 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45byd8vf8b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 05:46:12 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52E3Yt6G026010;
	Fri, 14 Mar 2025 05:46:11 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45atspnfed-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 05:46:11 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52E5k7JG43057504
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Mar 2025 05:46:08 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D09E120040;
	Fri, 14 Mar 2025 05:46:07 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7DAB12004B;
	Fri, 14 Mar 2025 05:46:04 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.22.126])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Mar 2025 05:46:04 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: sshegde@linux.ibm.com, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        mpe@ellerman.id.au, peterz@infradead.org, fbarrat@linux.ibm.com,
        ajd@linux.ibm.com, mahesh@linux.ibm.com, oohall@gmail.com,
        hbathini@linux.ibm.com, dhowells@redhat.com, haren@linux.ibm.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] powerpc: eeh: use lock guard for mutex
Date: Fri, 14 Mar 2025 11:15:39 +0530
Message-ID: <20250314054544.1998928-2-sshegde@linux.ibm.com>
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
X-Proofpoint-GUID: gI0BauemxDdfq9atzbIq9HRczMRkM8KE
X-Proofpoint-ORIG-GUID: l4a9ydR15iQ03wLKOtFxoTMspxWvenl8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_01,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=804 clxscore=1015 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503140041

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


