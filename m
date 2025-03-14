Return-Path: <linux-kernel+bounces-561345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B19D4A6104F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65CBB17672B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2181FCFC5;
	Fri, 14 Mar 2025 11:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AZ19pTMQ"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A121F3BB6
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 11:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741952748; cv=none; b=Wei3+sq4H17zu+ettpSiaBQhU7Z4GghuySoxg/4wHz8xkwcy/cO2J4m500SBjZFwcm6BMrwO2oWWpyhKWgD5oDviRU4NjQYWR4/kLva/+ROANNgKglQz6qBiY7ltrCdW6IQFlrs1nMmumdWZBxXQvamnbyBN3DSYvEjufxOGcL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741952748; c=relaxed/simple;
	bh=eI04HedwGrj5qLVlTsC440XRtGlC/SclPwlxp94Ld2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kiB93EgZgxTLliBgY9aJrG9adjPZQ/IlGSp4ZHwj04H0f3J3LyCCwzRrnD3FwGmDVuip/wdP+XLehlrO3j+OQueQUkCOnfg+14dRAN4JbqwdZhMSdIeZuY7td2bI6o2oIm83dbgtmM4FhFVLMjYn2NGdr14LU8R4+qjkkONgDKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AZ19pTMQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52EAOCbE032132;
	Fri, 14 Mar 2025 11:45:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=rHiuokT753NlluXTP
	eZq8TFHySwH4S01ZogXJ3+Y+w0=; b=AZ19pTMQH/XI/IGVag7vo/SyabbKxdnsm
	nZhOyPrCrIwjumkiyh3kh7lmGL4hr2oKMIgPeyiGXVgf81vbWykyWXpuyU2LQwj8
	YWtt7ONymUnDQJvp2Lgy9thOe+FX6qWApo8h0Pgrvr3RMSvn8Uz9jX0GlH28KR3E
	fWzFoDl5WJsFjeGrYPF9zAfSFjV+9qjSpnieEEa90Yz4/G2AUYZ7zDTSam9zU+xC
	Cjf0cpYnF5sW2FSbdef4uGhAg6glHzj0xElbS9OaGXtKcQyerfwAEg6L+Wd0FlWH
	uMW9kyWxcPmWJzf73MJdmH5woon1Dpov5e6SUTWl9CwRYRWgv8hMA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45c6hpudk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 11:45:31 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52EBjVVp019267;
	Fri, 14 Mar 2025 11:45:31 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45c6hpudk4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 11:45:31 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52E91RiA012314;
	Fri, 14 Mar 2025 11:45:30 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45atsrppnt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 11:45:30 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52EBjQgC39977448
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Mar 2025 11:45:27 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D58222004B;
	Fri, 14 Mar 2025 11:45:26 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9041720040;
	Fri, 14 Mar 2025 11:45:23 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.22.126])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Mar 2025 11:45:23 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: sshegde@linux.ibm.com, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        mpe@ellerman.id.au, peterz@infradead.org, fbarrat@linux.ibm.com,
        ajd@linux.ibm.com, mahesh@linux.ibm.com, oohall@gmail.com,
        hbathini@linux.ibm.com, dhowells@redhat.com, haren@linux.ibm.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] powerpc: rtas: use lock guard for mutex
Date: Fri, 14 Mar 2025 17:14:58 +0530
Message-ID: <20250314114502.2083434-3-sshegde@linux.ibm.com>
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
X-Proofpoint-GUID: o69mgQckJtTmYwcFHYOPw61DoABOXmSD
X-Proofpoint-ORIG-GUID: 6l5AajEu6YpFFXEg9XVbV0la8hDUIWG-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_04,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 impostorscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 clxscore=1015 spamscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503140091

use guard(mutex) for scope based resource management of mutex.
This would make the code simpler and easier to maintain.

More details on lock guards can be found at
https://lore.kernel.org/all/20230612093537.614161713@infradead.org/T/#u

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 arch/powerpc/kernel/rtas_flash.c | 64 ++++++++++----------------------
 1 file changed, 20 insertions(+), 44 deletions(-)

diff --git a/arch/powerpc/kernel/rtas_flash.c b/arch/powerpc/kernel/rtas_flash.c
index 5407024881e5..583dc16e9d3c 100644
--- a/arch/powerpc/kernel/rtas_flash.c
+++ b/arch/powerpc/kernel/rtas_flash.c
@@ -312,13 +312,13 @@ static ssize_t rtas_flash_write(struct file *file, const char __user *buffer,
 {
 	struct rtas_update_flash_t *const uf = &rtas_update_flash_data;
 	char *p;
-	int next_free, rc;
+	int next_free;
 	struct flash_block_list *fl;
 
-	mutex_lock(&rtas_update_flash_mutex);
+	guard(mutex)(&rtas_update_flash_mutex);
 
 	if (uf->status == FLASH_AUTH || count == 0)
-		goto out;	/* discard data */
+		return count;	/* discard data */
 
 	/* In the case that the image is not ready for flashing, the memory
 	 * allocated for the block list will be freed upon the release of the 
@@ -327,7 +327,7 @@ static ssize_t rtas_flash_write(struct file *file, const char __user *buffer,
 	if (uf->flist == NULL) {
 		uf->flist = kmem_cache_zalloc(flash_block_cache, GFP_KERNEL);
 		if (!uf->flist)
-			goto nomem;
+			return -ENOMEM;
 	}
 
 	fl = uf->flist;
@@ -338,7 +338,7 @@ static ssize_t rtas_flash_write(struct file *file, const char __user *buffer,
 		/* Need to allocate another block_list */
 		fl->next = kmem_cache_zalloc(flash_block_cache, GFP_KERNEL);
 		if (!fl->next)
-			goto nomem;
+			return -ENOMEM;
 		fl = fl->next;
 		next_free = 0;
 	}
@@ -347,25 +347,17 @@ static ssize_t rtas_flash_write(struct file *file, const char __user *buffer,
 		count = RTAS_BLK_SIZE;
 	p = kmem_cache_zalloc(flash_block_cache, GFP_KERNEL);
 	if (!p)
-		goto nomem;
+		return -ENOMEM;
 	
 	if(copy_from_user(p, buffer, count)) {
 		kmem_cache_free(flash_block_cache, p);
-		rc = -EFAULT;
-		goto error;
+		return -EFAULT;
 	}
 	fl->blocks[next_free].data = p;
 	fl->blocks[next_free].length = count;
 	fl->num_blocks++;
-out:
-	mutex_unlock(&rtas_update_flash_mutex);
-	return count;
 
-nomem:
-	rc = -ENOMEM;
-error:
-	mutex_unlock(&rtas_update_flash_mutex);
-	return rc;
+	return count;
 }
 
 /*
@@ -405,19 +397,18 @@ static ssize_t manage_flash_write(struct file *file, const char __user *buf,
 	static const char reject_str[] = "0";
 	static const char commit_str[] = "1";
 	char stkbuf[10];
-	int op, rc;
+	int op;
 
-	mutex_lock(&rtas_manage_flash_mutex);
+	guard(mutex)(&rtas_manage_flash_mutex);
 
 	if ((args_buf->status == MANAGE_AUTH) || (count == 0))
-		goto out;
+		return count;
 		
 	op = -1;
 	if (buf) {
 		if (count > 9) count = 9;
-		rc = -EFAULT;
 		if (copy_from_user (stkbuf, buf, count))
-			goto error;
+			return -EFAULT;
 		if (strncmp(stkbuf, reject_str, strlen(reject_str)) == 0) 
 			op = RTAS_REJECT_TMP_IMG;
 		else if (strncmp(stkbuf, commit_str, strlen(commit_str)) == 0) 
@@ -425,18 +416,11 @@ static ssize_t manage_flash_write(struct file *file, const char __user *buf,
 	}
 	
 	if (op == -1) {   /* buf is empty, or contains invalid string */
-		rc = -EINVAL;
-		goto error;
+		return -EINVAL;
 	}
 
 	manage_flash(args_buf, op);
-out:
-	mutex_unlock(&rtas_manage_flash_mutex);
 	return count;
-
-error:
-	mutex_unlock(&rtas_manage_flash_mutex);
-	return rc;
 }
 
 /*
@@ -499,16 +483,14 @@ static ssize_t validate_flash_write(struct file *file, const char __user *buf,
 {
 	struct rtas_validate_flash_t *const args_buf =
 		&rtas_validate_flash_data;
-	int rc;
 
-	mutex_lock(&rtas_validate_flash_mutex);
+	guard(mutex)(&rtas_validate_flash_mutex);
 
 	/* We are only interested in the first 4K of the
 	 * candidate image */
 	if ((*off >= VALIDATE_BUF_SIZE) || 
 		(args_buf->status == VALIDATE_AUTH)) {
 		*off += count;
-		mutex_unlock(&rtas_validate_flash_mutex);
 		return count;
 	}
 
@@ -519,20 +501,14 @@ static ssize_t validate_flash_write(struct file *file, const char __user *buf,
 		args_buf->status = VALIDATE_INCOMPLETE;
 	}
 
-	if (!access_ok(buf, count)) {
-		rc = -EFAULT;
-		goto done;
-	}
-	if (copy_from_user(args_buf->buf + *off, buf, count)) {
-		rc = -EFAULT;
-		goto done;
-	}
+	if (!access_ok(buf, count))
+		return -EFAULT;
+
+	if (copy_from_user(args_buf->buf + *off, buf, count))
+		return -EFAULT;
 
 	*off += count;
-	rc = count;
-done:
-	mutex_unlock(&rtas_validate_flash_mutex);
-	return rc;
+	return count;
 }
 
 static int validate_flash_release(struct inode *inode, struct file *file)
-- 
2.39.3


