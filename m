Return-Path: <linux-kernel+bounces-560706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DADE9A60876
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 06:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 909543A5783
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 05:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0277D155A2F;
	Fri, 14 Mar 2025 05:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ub5YRin5"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E4215199B
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 05:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741931213; cv=none; b=mDfkCN7B1P1mwFLZTcCHwRknRLLgQznJzHB5qftMOEOn8LTGbbkg/VhRtvFy6po9jhTKwJX24vh7aoVR/4kHJa44ZbjEvqAEAOBfnuZ9g/7fp8qx+DMsITZt2o9P0f2xEJiftKlrhJKzAFHYVpwdV/KbIYX16kr38h6btfhNsNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741931213; c=relaxed/simple;
	bh=1DkS2cn25IZOsOqgB34SeuFVQyVPdVpZ8rt0xOcBNOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rTj3CptXwE7cprdqKSllOLLjcAbnPZYQxJ1a70fBOLX0n1ZyZAslTWWEVamvuP6IixPoznkha6oTkskDg6TZtXy2LuI93p+sTCzqlEti4rOKwHWjEmaWoZurYxfft/fd2Eyw7KGmduf30l6gQ28z1r2FLQrZmqg62mq/fB60lrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ub5YRin5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52E3kYJs020652;
	Fri, 14 Mar 2025 05:46:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=rqd8nApZfIj14eDIu
	EBmgblnXR/j8d+uZ5j9bQDSyx8=; b=Ub5YRin5iuB8xFzqhpxqN4VbPZliMOqCM
	mT18O5IjqYz6XhNUtS3FLippc17f+MHyJB/1qtJa6A+dqeq+6FPC9oVa3fXN8kUf
	q+KKp5kbN7X9Cr/figTuyh0SJn7Pwg87y02P63mSeMaNcAwfvuFIW9g8+xE5XbY9
	d4qtjhdxsH8PiSj7tENgozT90p3pP2craHVg9b1uMYn1ueak2hsClaywI3V7hM4V
	QcWGrTQwT4Ij6nlVZRb3Fz4/8Xx1EQHZHsVjSrwD8Xvj0ngWZ9aoAvrnb/TUOd+w
	rElAJ8bXdKuzsK3t9NJh8QUiRWxcrvekcHoiMHSat8rYn8mrLXYRQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45ccu98dju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 05:46:38 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52E5kbdN000397;
	Fri, 14 Mar 2025 05:46:37 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45ccu98djs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 05:46:37 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52E5F8jq007555;
	Fri, 14 Mar 2025 05:46:36 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45atsrddk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 05:46:36 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52E5kWw032440906
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Mar 2025 05:46:32 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 70E792004E;
	Fri, 14 Mar 2025 05:46:32 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D82A20043;
	Fri, 14 Mar 2025 05:46:29 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.22.126])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Mar 2025 05:46:28 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: sshegde@linux.ibm.com, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        mpe@ellerman.id.au, peterz@infradead.org, fbarrat@linux.ibm.com,
        ajd@linux.ibm.com, mahesh@linux.ibm.com, oohall@gmail.com,
        hbathini@linux.ibm.com, dhowells@redhat.com, haren@linux.ibm.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] powerpc: sysdev: use lock guard for mutex
Date: Fri, 14 Mar 2025 11:15:44 +0530
Message-ID: <20250314054544.1998928-7-sshegde@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: yCsldXnCv7_YVnev3G0b_MmgmNzp_kTS
X-Proofpoint-GUID: 8SNQeekt3qQUZWAbThuHNs6g_5hcctUT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_01,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxlogscore=771 mlxscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503140041

use guard(mutex) for scope based resource management of mutex
This would make the code simpler and easier to maintain.

More details on lock guards can be found at
https://lore.kernel.org/all/20230612093537.614161713@infradead.org/T/#u

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 arch/powerpc/sysdev/fsl_mpic_timer_wakeup.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_mpic_timer_wakeup.c b/arch/powerpc/sysdev/fsl_mpic_timer_wakeup.c
index ce6c739c51e5..bbfc7c39b957 100644
--- a/arch/powerpc/sysdev/fsl_mpic_timer_wakeup.c
+++ b/arch/powerpc/sysdev/fsl_mpic_timer_wakeup.c
@@ -75,7 +75,7 @@ static ssize_t fsl_timer_wakeup_store(struct device *dev,
 	if (kstrtoll(buf, 0, &interval))
 		return -EINVAL;
 
-	mutex_lock(&sysfs_lock);
+	guard(mutex)(&sysfs_lock);
 
 	if (fsl_wakeup->timer) {
 		disable_irq_wake(fsl_wakeup->timer->irq);
@@ -84,14 +84,12 @@ static ssize_t fsl_timer_wakeup_store(struct device *dev,
 	}
 
 	if (!interval) {
-		mutex_unlock(&sysfs_lock);
 		return count;
 	}
 
 	fsl_wakeup->timer = mpic_request_timer(fsl_mpic_timer_irq,
 						fsl_wakeup, interval);
 	if (!fsl_wakeup->timer) {
-		mutex_unlock(&sysfs_lock);
 		return -EINVAL;
 	}
 
@@ -99,15 +97,11 @@ static ssize_t fsl_timer_wakeup_store(struct device *dev,
 	if (ret) {
 		mpic_free_timer(fsl_wakeup->timer);
 		fsl_wakeup->timer = NULL;
-		mutex_unlock(&sysfs_lock);
-
 		return ret;
 	}
 
 	mpic_start_timer(fsl_wakeup->timer);
 
-	mutex_unlock(&sysfs_lock);
-
 	return count;
 }
 
-- 
2.39.3


