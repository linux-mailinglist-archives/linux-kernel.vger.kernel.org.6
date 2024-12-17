Return-Path: <linux-kernel+bounces-448696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E65F39F445C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 07:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19E68167988
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 06:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A431E2845;
	Tue, 17 Dec 2024 06:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Zn/Y6GAl"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2562B1E1A25
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 06:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734418040; cv=none; b=qxlpelL4FO6iam8YFpJikjf3n1OHzhLEH81OSUIZ4s+SPGNsgk4G1KpMIfeIxNz5mePh6d/p8nVb+4HOhDeSUHAXIZ4WS/7HF4/46axVbHFHWxXAreFFutFyY/qiSQmlLDGfZ0J6dPsGYi7YjIs7eqk3LoLMR7z9+XK6P0cxf8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734418040; c=relaxed/simple;
	bh=9H+8j0Ar5zAnphlteNh40pqUar291wd3JONfJ8ZcK8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H8yOq6JMhjLPmRREdA3s0pU0ZVYFvUbVFgKBmUAjut87KqFZQLvaF3Q/xkd2tA98l+3WY+Hj9b+yNe5g0m43xVYJ5BLvxWO6+shdoDFeDEE8XNSMCQCWX74ayq1DfoBL3xZp2Dguk4wIwTcwTU5TkcgbPa2cb2LvswqECm59iUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Zn/Y6GAl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGHXxDE027390;
	Tue, 17 Dec 2024 06:46:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=a51YAcOPHw8REYfzD
	T6Mazib9DPYr/BR2XxrvtalFWU=; b=Zn/Y6GAlyvcCRMIHN6NxZdur2lRmODZ9v
	H/JS6B+TZvdpaqX4LbLdjLOQkZ4VuYcdL9fullxJiSn4mXzkQ9/tj9/6EZxKKkcH
	2ftP1cYYDqBHg/th51YoLQIWq7wcxQOQPTBaUzZwtIq03aJKwRCQP2WEErqCQ5F9
	gqq+Ol6p/cVqwASJwofWoNNt8pVhgueIga1BCXM0KBsiLHvTCk+KP7GX1j1IhHGD
	JWiLkXHbnpfP+N4h4HWM1Vl4wlmvSX0mczhM54BGxIMCAjGWufuaQRisXp4kNavH
	yHLiXIDui79DlVjOmdqrFdC+2jRru9XH4ZcyMEc/nkLP0K3pZzmow==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43jgd2dcsh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 06:46:47 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BH62QgI029312;
	Tue, 17 Dec 2024 06:46:46 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43hmbshtnh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 06:46:46 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BH6khac39518486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Dec 2024 06:46:43 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 54ED520040;
	Tue, 17 Dec 2024 06:46:43 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB5922004B;
	Tue, 17 Dec 2024 06:46:38 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.ibm.com.com (unknown [9.43.29.128])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Dec 2024 06:46:38 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, Baoquan he <bhe@redhat.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] crash: remove an unused argument from reserve_crashkernel_generic()
Date: Tue, 17 Dec 2024 12:16:09 +0530
Message-ID: <20241217064613.1042866-2-sourabhjain@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: nJtrhwYMtX-uL4Zhj5Q5bt90Z2ltsieJ
X-Proofpoint-GUID: nJtrhwYMtX-uL4Zhj5Q5bt90Z2ltsieJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 mlxlogscore=876 priorityscore=1501 malwarescore=0 impostorscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412170052

cmdline argument is not used in reserve_crashkernel_generic() so remove
it. Correspondingly, all the callers have been updated as well.

No functional change intended.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan he <bhe@redhat.com>
Cc: Hari Bathini <hbathini@linux.ibm.com>
CC: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/arm64/mm/init.c          |  6 ++----
 arch/loongarch/kernel/setup.c |  5 ++---
 arch/riscv/mm/init.c          |  6 ++----
 arch/x86/kernel/setup.c       |  6 ++----
 include/linux/crash_reserve.h | 11 +++++------
 kernel/crash_reserve.c        |  9 ++++-----
 6 files changed, 17 insertions(+), 26 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index ccdef53872a0..2e496209af80 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -98,21 +98,19 @@ static void __init arch_reserve_crashkernel(void)
 {
 	unsigned long long low_size = 0;
 	unsigned long long crash_base, crash_size;
-	char *cmdline = boot_command_line;
 	bool high = false;
 	int ret;
 
 	if (!IS_ENABLED(CONFIG_CRASH_RESERVE))
 		return;
 
-	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
+	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
 				&crash_size, &crash_base,
 				&low_size, &high);
 	if (ret)
 		return;
 
-	reserve_crashkernel_generic(cmdline, crash_size, crash_base,
-				    low_size, high);
+	reserve_crashkernel_generic(crash_size, crash_base, low_size, high);
 }
 
 static phys_addr_t __init max_zone_phys(phys_addr_t zone_limit)
diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index 56934fe58170..ece9c4266c3f 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -259,18 +259,17 @@ static void __init arch_reserve_crashkernel(void)
 	int ret;
 	unsigned long long low_size = 0;
 	unsigned long long crash_base, crash_size;
-	char *cmdline = boot_command_line;
 	bool high = false;
 
 	if (!IS_ENABLED(CONFIG_CRASH_RESERVE))
 		return;
 
-	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
+	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
 				&crash_size, &crash_base, &low_size, &high);
 	if (ret)
 		return;
 
-	reserve_crashkernel_generic(cmdline, crash_size, crash_base, low_size, high);
+	reserve_crashkernel_generic(crash_size, crash_base, low_size, high);
 }
 
 static void __init fdt_setup(void)
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index fc53ce748c80..750991df9e52 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -1377,21 +1377,19 @@ static void __init arch_reserve_crashkernel(void)
 {
 	unsigned long long low_size = 0;
 	unsigned long long crash_base, crash_size;
-	char *cmdline = boot_command_line;
 	bool high = false;
 	int ret;
 
 	if (!IS_ENABLED(CONFIG_CRASH_RESERVE))
 		return;
 
-	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
+	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
 				&crash_size, &crash_base,
 				&low_size, &high);
 	if (ret)
 		return;
 
-	reserve_crashkernel_generic(cmdline, crash_size, crash_base,
-				    low_size, high);
+	reserve_crashkernel_generic(crash_size, crash_base, low_size, high);
 }
 
 void __init paging_init(void)
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index f1fea506e20f..15b6823556c8 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -469,14 +469,13 @@ static void __init memblock_x86_reserve_range_setup_data(void)
 static void __init arch_reserve_crashkernel(void)
 {
 	unsigned long long crash_base, crash_size, low_size = 0;
-	char *cmdline = boot_command_line;
 	bool high = false;
 	int ret;
 
 	if (!IS_ENABLED(CONFIG_CRASH_RESERVE))
 		return;
 
-	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
+	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
 				&crash_size, &crash_base,
 				&low_size, &high);
 	if (ret)
@@ -487,8 +486,7 @@ static void __init arch_reserve_crashkernel(void)
 		return;
 	}
 
-	reserve_crashkernel_generic(cmdline, crash_size, crash_base,
-				    low_size, high);
+	reserve_crashkernel_generic(crash_size, crash_base, low_size, high);
 }
 
 static struct resource standard_io_resources[] = {
diff --git a/include/linux/crash_reserve.h b/include/linux/crash_reserve.h
index 5a9df944fb80..1fe7e7d1b214 100644
--- a/include/linux/crash_reserve.h
+++ b/include/linux/crash_reserve.h
@@ -32,13 +32,12 @@ int __init parse_crashkernel(char *cmdline, unsigned long long system_ram,
 #define CRASH_ADDR_HIGH_MAX		memblock_end_of_DRAM()
 #endif
 
-void __init reserve_crashkernel_generic(char *cmdline,
-		unsigned long long crash_size,
-		unsigned long long crash_base,
-		unsigned long long crash_low_size,
-		bool high);
+void __init reserve_crashkernel_generic(unsigned long long crash_size,
+					unsigned long long crash_base,
+					unsigned long long crash_low_size,
+					bool high);
 #else
-static inline void __init reserve_crashkernel_generic(char *cmdline,
+static inline void __init reserve_crashkernel_generic(
 		unsigned long long crash_size,
 		unsigned long long crash_base,
 		unsigned long long crash_low_size,
diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
index a620fb4b2116..aff7c0fdbefa 100644
--- a/kernel/crash_reserve.c
+++ b/kernel/crash_reserve.c
@@ -375,11 +375,10 @@ static int __init reserve_crashkernel_low(unsigned long long low_size)
 	return 0;
 }
 
-void __init reserve_crashkernel_generic(char *cmdline,
-			     unsigned long long crash_size,
-			     unsigned long long crash_base,
-			     unsigned long long crash_low_size,
-			     bool high)
+void __init reserve_crashkernel_generic(unsigned long long crash_size,
+					unsigned long long crash_base,
+					unsigned long long crash_low_size,
+					bool high)
 {
 	unsigned long long search_end = CRASH_ADDR_LOW_MAX, search_base = 0;
 	bool fixed_base = false;
-- 
2.47.1


