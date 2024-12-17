Return-Path: <linux-kernel+bounces-448694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A189F445B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 07:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1EE1188A94F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 06:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FD71E0E0F;
	Tue, 17 Dec 2024 06:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KvkAYa2W"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52D41DF96E
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 06:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734418034; cv=none; b=NeKGHY8+v/bnPTWUDAcpw0AyfZC+vJ3n/XnXP2ep6Ym1JuThIi5b5xIHJ+NWG2GM8jcVgqoUBtqZ/ibe0M0zK0HX+QiXGNfwvpMKrYG0VoCOLyYT738Vj1db824n1NrfPSrU4BefORaLPVM7YUbiwX2xt0UMTLfHCACie69+TQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734418034; c=relaxed/simple;
	bh=dlDQRI3prM2RhA26oYUO7b4mYDyx4hfzyLIFy+/VHz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S2dpza7Akmg1SS4gBWiPaZXVSL2gjfDkC7dkSqp+HqpVCH89MrOdUFoGXWYXxDzIDlhSit/9YFA7AXTzhWr55p7vnVwzX2hJm5YCgLUsXqmeVN634VKgSMS0PQRjFJAfkx1T2udVnVTJfwljqqZBZYyeM5nz0R8M0BQX2neY0gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KvkAYa2W; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BH3qbCL023635;
	Tue, 17 Dec 2024 06:46:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=WH86RupiIpV7nQbN+
	Vsb8WGy3K790/g1ula/5WgtslI=; b=KvkAYa2WWMKIrp0md1cyAHmJtwwJ2CWfG
	pj3M+DAXOTAlLtFyWCTsV5OpjOrreJFZ46LWUlowGJnnLVlXQqxuxWY/w+/OQW55
	j19/1YcxG7A+7ZsDievjeH278CmJKvKhmxFGWDk8RdT0EG0TveMvvyBYZ09tNlcq
	d5eu7lV+xVwq2oHmy+Wd/VKuXrWh6bMTkKsVxBEPl7vkP3UMcLYhEL/0b/Jrt6Pe
	2T3nnWnCYcdTuI0Md6Wh6hH4gYhGXGQBCYpOd07AyiEfVMqIR9QrIoISQZivb3rH
	auGUT18D6gJv5avDiLrYJ7PQGCAh0U15FRmQ6Hr9wOQUGGTIkTf4Q==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43k1sb0jcq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 06:46:58 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BH3tGGH011271;
	Tue, 17 Dec 2024 06:46:57 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43hpjk1bwt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 06:46:57 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BH6krCZ26149512
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Dec 2024 06:46:54 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DAB8A2004B;
	Tue, 17 Dec 2024 06:46:53 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E164C20040;
	Tue, 17 Dec 2024 06:46:50 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.ibm.com.com (unknown [9.43.29.128])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Dec 2024 06:46:50 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, Baoquan he <bhe@redhat.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] powerpc/kdump: preserve user-specified memory limit
Date: Tue, 17 Dec 2024 12:16:11 +0530
Message-ID: <20241217064613.1042866-4-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241217064613.1042866-1-sourabhjain@linux.ibm.com>
References: <20241217064613.1042866-1-sourabhjain@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Np-xWnIy8W1mKryoou7nF-12SVirY23I
X-Proofpoint-ORIG-GUID: Np-xWnIy8W1mKryoou7nF-12SVirY23I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 malwarescore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412170052

Commit 59d58189f3d9 ("crash: fix crash memory reserve exceed system
memory bug") fails crashkernel parsing if the crash size is found to be
higher than system RAM, which makes the memory_limit adjustment code
ineffective due to an early exit from reserve_crashkernel().

Regardless lets not violated the user-specified memory limit by
adjusting it. Remove this adjustment to ensure all reservations stay
within the limit. Commit f94f5ac07983 ("powerpc/fadump: Don't update
the user-specified memory limit") did the same for fadump.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan he <bhe@redhat.com>
Cc: Hari Bathini <hbathini@linux.ibm.com>
CC: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/powerpc/kexec/core.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/powerpc/kexec/core.c b/arch/powerpc/kexec/core.c
index b8333a49ea5d..4945b33322ae 100644
--- a/arch/powerpc/kexec/core.c
+++ b/arch/powerpc/kexec/core.c
@@ -150,14 +150,6 @@ void __init reserve_crashkernel(void)
 		return;
 	}
 
-	/* Crash kernel trumps memory limit */
-	if (memory_limit && memory_limit <= crashk_res.end) {
-		memory_limit = crashk_res.end + 1;
-		total_mem_sz = memory_limit;
-		printk("Adjusted memory limit for crashkernel, now 0x%llx\n",
-		       memory_limit);
-	}
-
 	printk(KERN_INFO "Reserving %ldMB of memory at %ldMB "
 			"for crashkernel (System RAM: %ldMB)\n",
 			(unsigned long)(crash_size >> 20),
-- 
2.47.1


