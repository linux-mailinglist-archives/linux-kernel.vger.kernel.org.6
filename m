Return-Path: <linux-kernel+bounces-560703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FEAA60873
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 06:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDD1E19C3755
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 05:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E401514EE;
	Fri, 14 Mar 2025 05:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JPQjRw5j"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF2915854A
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 05:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741931198; cv=none; b=bkLXiV3T4wcRAlz6+dRlsKKHnHNLKAkHCYYmHwUZU/McaRobgZyw0z1T4NcWTRYbihRdX0mMMAZUaiVWeQ4mZNg5+iPihjqrYuIjKSaZF0NZ6q5wBb8gHEBI1m6TLe2qRRM1+SU1hT4A/6owDrxnXbulqFLh7XK4iqeJ+0Pzsc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741931198; c=relaxed/simple;
	bh=eUvi4RqywOEEZH25sN6zIKspSCc3WWheLySzduHClLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dbhl7J5+AmQ9oTn2LS4xwEyU3jJgPBC5e0WlhiCAeXN2hUxQxKuXMSM8pqhy4vVWwXnwajT1ekGTQRd3Z3hG6wPfx6FWZizApcBLQ28emd2sUZyCr4BhVYD9NRqd3w5q6VH5C+UFTb5ju/N4LLrgXd/gCJS+Eu5L9/7BtsBasb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JPQjRw5j; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DNOvdH018074;
	Fri, 14 Mar 2025 05:46:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=MwVYPr7/JahDzLEPr
	39TM/CoUV6AsGze/brxnTHHiOc=; b=JPQjRw5jyIo4LSnDe/LgzhDwKHRnx4z50
	dyexkfSR1fKYyCykGfHAesfKQcoI6OYleyIDfDK/xJtzwgEvRirc/vGSHlbG+RG8
	o+Fo2hX4vDEs/PW3jNW8xmLb64OfCHoUk3EaXeSzO2iqd5l4iYTno2BEN2maI3zU
	fUOIBUkbk730FTQvyDoxXKXzGcyyQWw+I7TdIx+0p2XTrjB5OcR4nD/nWndJqkdU
	cLzsMVsBkO/PxXSWaxLVZzvNTGOWF761ddLbNtZIb5RyPGpXFb/imszeOJDMVpz3
	3Kw479VuyCzYMex9a+HRKxbR08fHyBVMqDzyrYMpSxUmlhwiAY5Og==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45c0srbwd0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 05:46:23 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52E5f4nA002102;
	Fri, 14 Mar 2025 05:46:22 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45c0srbwcu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 05:46:22 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52E4OnoG012359;
	Fri, 14 Mar 2025 05:46:21 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45atsrne45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 05:46:21 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52E5kHk455116166
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Mar 2025 05:46:17 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 92D762004B;
	Fri, 14 Mar 2025 05:46:17 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 362D820043;
	Fri, 14 Mar 2025 05:46:14 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.22.126])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Mar 2025 05:46:13 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: sshegde@linux.ibm.com, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        mpe@ellerman.id.au, peterz@infradead.org, fbarrat@linux.ibm.com,
        ajd@linux.ibm.com, mahesh@linux.ibm.com, oohall@gmail.com,
        hbathini@linux.ibm.com, dhowells@redhat.com, haren@linux.ibm.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] powerpc: fadump: use lock guard for mutex
Date: Fri, 14 Mar 2025 11:15:41 +0530
Message-ID: <20250314054544.1998928-4-sshegde@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: cn0oyIPr0nPtp64hNPcm0nsDHxubdUR8
X-Proofpoint-GUID: GZb7snCNZ99lih3uHAJ8kU9CscgD49pH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_01,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 phishscore=0 mlxlogscore=684 mlxscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503140041

use guard(mutex) for scope based resource management of mutex.
This would make the code simpler and easier to maintain.

More details on lock guards can be found at
https://lore.kernel.org/all/20230612093537.614161713@infradead.org/T/#u

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 arch/powerpc/kernel/fadump.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 4b371c738213..5fd2c546fd8c 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -1374,15 +1374,13 @@ static void fadump_free_elfcorehdr_buf(void)
 
 static void fadump_invalidate_release_mem(void)
 {
-	mutex_lock(&fadump_mutex);
+	guard(mutex)(&fadump_mutex);
+
 	if (!fw_dump.dump_active) {
-		mutex_unlock(&fadump_mutex);
 		return;
 	}
 
 	fadump_cleanup();
-	mutex_unlock(&fadump_mutex);
-
 	fadump_free_elfcorehdr_buf();
 	fadump_release_memory(fw_dump.boot_mem_top, memblock_end_of_DRAM());
 	fadump_free_cpu_notes_buf();
-- 
2.39.3


