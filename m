Return-Path: <linux-kernel+bounces-420443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EBA9D7AC3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 05:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4522B219CB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 04:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCBE82877;
	Mon, 25 Nov 2024 04:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aoRnS2RP"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547134C6E
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 04:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732508592; cv=none; b=fV50n+be5POrMobrS2hdoqy3h2ynssniAKhjQyhrs5lqoCLLeAazqDqQlUibNkBSYd5pqTT/XqqtgmGyABtdCWjULQ2/2SkraPGgRDNvLeH1C8yWz3vyrvW2wUeb1kuGkSx2e6Ym4uQOyUPehZkq7p/KHJr/7b8zY5+Av+8dP+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732508592; c=relaxed/simple;
	bh=xEe9d/pR0xmQ4YPeGrjveiHtNSGPKaAaqubAa6nJUk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jp8weQ7jzmerAk7Ypa5ABJj+69drCScm8T48j5lhiJjUUmFg5HVjR7N7b1Whtx6OQkW+Z823j1W42jpT+NFZiWoO/kg8qZ3V1JjvLLa/CQV811XwfzbxTYPqsYBCGE02hBAj0/9u2CnbsQ4LiZEKkN40fPKsz8CUv9YOTyZRJCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aoRnS2RP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AOF0Mk7012423;
	Mon, 25 Nov 2024 04:22:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=6gYY45rFaWXCTTO7D
	oA6uYes3Y9Oq5QwfdQWzwDEUW0=; b=aoRnS2RPU8G89xSUOJydlpan7+zcCddaS
	FEwkFzw9J6u2FDv+CV3JheNbhj3fOfraXaaMICRufIqFSTx3DIy0Gj218Ld3Lz4t
	nBFAX2YQ2SXT2rDANJ9j0uL38r0HJPfgoF9hrSbuDYpgN5u/OXJ3VUOaWMwuRCKd
	4Ompjm0U9T2l/NxcolirzE5EGXVW8MX8rdzUt9Jqzdn4eyQLuBi6HovqnVzeAi/Z
	JIxvHKc+1RjvEHh/twWEggoG85kFRFJ8nbUsu/sVVATwCL2NII1+i1AX4B6+7XZA
	DadHJv9l6Vsp3gQV3ESH+rGc1UhHIT/0GgfYq9ApW5qn7zoG8CElA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4338d1x39a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 04:22:43 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AP4K2rK022013;
	Mon, 25 Nov 2024 04:22:43 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4338d1x398-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 04:22:43 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AOI0Msn026326;
	Mon, 25 Nov 2024 04:22:42 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 433v30smep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 04:22:42 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AP4MdLg11600296
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Nov 2024 04:22:39 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1841220040;
	Mon, 25 Nov 2024 04:22:39 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E140020043;
	Mon, 25 Nov 2024 04:22:36 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.in.ibm.com (unknown [9.109.215.252])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 25 Nov 2024 04:22:36 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Cc: sshegde@linux.ibm.com, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        maddy@linux.ibm.com, bigeasy@linutronix.de, ankur.a.arora@oracle.com,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        vschneid@redhat.com, peterz@infradead.org
Subject: [PATCH 3/3] powerpc: print right preemption model in die
Date: Mon, 25 Nov 2024 09:52:12 +0530
Message-ID: <20241125042212.1522315-4-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241125042212.1522315-1-sshegde@linux.ibm.com>
References: <20241125042212.1522315-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mH6RW4zO8Hyrbt-xLOn55y7JYcLQHElp
X-Proofpoint-ORIG-GUID: F4Y9DOw9BeROC3AVPQoftrSnoRJmtpYz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxscore=0 suspectscore=0 phishscore=0 mlxlogscore=887
 spamscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411250031

Preemption models can change at runtime with dynamic preemption in 
place. So need to use the right methods instead of relying on
CONFIG_PREEMPT to decide whether its full preemption or not. 

While there, fix it to print preemption model correctly. 

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com> 
---
 arch/powerpc/kernel/traps.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index edf5cabe5dfd..2556fa8ec019 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -266,7 +266,11 @@ static int __die(const char *str, struct pt_regs *regs, long err)
 	printk("%s PAGE_SIZE=%luK%s%s%s%s%s%s %s\n",
 	       IS_ENABLED(CONFIG_CPU_LITTLE_ENDIAN) ? "LE" : "BE",
 	       PAGE_SIZE / 1024, get_mmu_str(),
-	       IS_ENABLED(CONFIG_PREEMPT) ? " PREEMPT" : "",
+	       preempt_model_none()      ? "none" :
+	       preempt_model_voluntary() ? "voluntary" :
+	       preempt_model_full()      ? "full" :
+	       preempt_model_lazy()      ? "lazy" :
+	       "",
 	       IS_ENABLED(CONFIG_SMP) ? " SMP" : "",
 	       IS_ENABLED(CONFIG_SMP) ? (" NR_CPUS=" __stringify(NR_CPUS)) : "",
 	       debug_pagealloc_enabled() ? " DEBUG_PAGEALLOC" : "",
-- 
2.39.3


