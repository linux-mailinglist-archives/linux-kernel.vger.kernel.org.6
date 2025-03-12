Return-Path: <linux-kernel+bounces-558458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 483D1A5E636
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 22:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21E4C3BC3CB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 21:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B19C1EDA17;
	Wed, 12 Mar 2025 21:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="igNDsUhA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RnZmJeOi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="igNDsUhA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RnZmJeOi"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1891BD9DD
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 21:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741813392; cv=none; b=O8c8WU6Og5SmGdmorF/f6Da1mw8CIOYGKLoDo5nl8YYwjPjz0H18mTz49+9pWHJ8394ur9gNzHo/SJTN+dnILHitBtznzbNh/jMEa1dqc0ZrI+397qSrVPhU/cDYccO2eU6fTuIscHPvVD9KsSj1Ol/ZaYQOTkm8r4Iql6QQuSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741813392; c=relaxed/simple;
	bh=GtbQVyI9HOTpjy93ppZfMLbvExGyUWM3I66gXtg1ggQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTu5DQNSLC9YfBaO69nSqSt2mvkdiTQ0IZ9RaBczLoh3mod5GTA6FH7dUN918EfH0LU35TpWY23Bjh8T5MHuVbcwvxBsQtc2JjpEzlguXt6kmouZbaibmTHwsiIzmKBswk8md9KBMwfgbsnAc7vOmWI3apKrDqqW9byJb0HP4Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=igNDsUhA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RnZmJeOi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=igNDsUhA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RnZmJeOi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from localhost (unknown [10.100.12.32])
	by smtp-out1.suse.de (Postfix) with ESMTP id 8D41B21169;
	Wed, 12 Mar 2025 21:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741813387; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QYPVIjuXtyEWnSA0TQuv2Z6ecwvOqLWWeLHzxxVGJgo=;
	b=igNDsUhAvWy+YUiNrJnRnQDC0ArpaeNtUrBmYcEDdZh0wFR5Mw+Z0QJPNh0c1VmD991fT8
	Z27g/xiL303sApjcrXhDO7pYq/1pv0NCnNFfPYU7Ug5kwXcLk0nWYqohQo8sLNCwz29nnL
	GT2k+s4++ck5iMyka2t8MQIigcIBSvg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741813387;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QYPVIjuXtyEWnSA0TQuv2Z6ecwvOqLWWeLHzxxVGJgo=;
	b=RnZmJeOiBjydxZ1YIiLlUR6JHiXCnzJo3F+DNMqrOOuWb5QsVONJODP/7AS5aYljf6Sgeg
	bHzUN6KCtJewJ2Bw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741813387; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QYPVIjuXtyEWnSA0TQuv2Z6ecwvOqLWWeLHzxxVGJgo=;
	b=igNDsUhAvWy+YUiNrJnRnQDC0ArpaeNtUrBmYcEDdZh0wFR5Mw+Z0QJPNh0c1VmD991fT8
	Z27g/xiL303sApjcrXhDO7pYq/1pv0NCnNFfPYU7Ug5kwXcLk0nWYqohQo8sLNCwz29nnL
	GT2k+s4++ck5iMyka2t8MQIigcIBSvg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741813387;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QYPVIjuXtyEWnSA0TQuv2Z6ecwvOqLWWeLHzxxVGJgo=;
	b=RnZmJeOiBjydxZ1YIiLlUR6JHiXCnzJo3F+DNMqrOOuWb5QsVONJODP/7AS5aYljf6Sgeg
	bHzUN6KCtJewJ2Bw==
Date: Wed, 12 Mar 2025 22:03:07 +0100
From: Jiri Bohac <jbohac@suse.cz>
To: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org
Cc: Philipp Rudo <prudo@redhat.com>, Donald Dutile <ddutile@redhat.com>,
	Pingfan Liu <piliu@redhat.com>, Tao Liu <ltao@redhat.com>,
	linux-kernel@vger.kernel.org,
	David Hildenbrand <dhildenb@redhat.com>,
	Michal Hocko <mhocko@suse.cz>
Subject: [PATCH v3 1/5] Add a new optional ",cma" suffix to the crashkernel=
 command line option
Message-ID: <Z9H2iw83e7eXD8JB@dwarf.suse.cz>
References: <Z9H10pYIFLBHNKpr@dwarf.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9H10pYIFLBHNKpr@dwarf.suse.cz>
X-Spam-Score: -4.29
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.19)[-0.950];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Spam-Flag: NO
X-Spam-Level: 

Add a new cma_size parameter to parse_crashkernel().
When not NULL, call __parse_crashkernel to parse the CMA
reservation size from "crashkernel=size,cma" and store it
in cma_size.

Set cma_size to NULL in all calls to parse_crashkernel().

Signed-off-by: Jiri Bohac <jbohac@suse.cz>
---
 arch/arm/kernel/setup.c              |  2 +-
 arch/arm64/mm/init.c                 |  2 +-
 arch/loongarch/kernel/setup.c        |  2 +-
 arch/mips/kernel/setup.c             |  2 +-
 arch/powerpc/kernel/fadump.c         |  2 +-
 arch/powerpc/kexec/core.c            |  2 +-
 arch/powerpc/mm/nohash/kaslr_booke.c |  2 +-
 arch/riscv/mm/init.c                 |  2 +-
 arch/s390/kernel/setup.c             |  2 +-
 arch/sh/kernel/machine_kexec.c       |  2 +-
 arch/x86/kernel/setup.c              |  2 +-
 include/linux/crash_reserve.h        |  3 ++-
 kernel/crash_reserve.c               | 16 ++++++++++++++--
 13 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index a41c93988d2c..0bfd66c7ada0 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -1004,7 +1004,7 @@ static void __init reserve_crashkernel(void)
 	total_mem = get_total_mem();
 	ret = parse_crashkernel(boot_command_line, total_mem,
 				&crash_size, &crash_base,
-				NULL, NULL);
+				NULL, NULL, NULL);
 	/* invalid value specified or crashkernel=0 */
 	if (ret || !crash_size)
 		return;
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 9c0b8d9558fc..06bf216a4b0d 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -107,7 +107,7 @@ static void __init arch_reserve_crashkernel(void)
 
 	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
 				&crash_size, &crash_base,
-				&low_size, &high);
+				&low_size, NULL, &high);
 	if (ret)
 		return;
 
diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index edcfdfcad7d2..ffdfb5407043 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -266,7 +266,7 @@ static void __init arch_reserve_crashkernel(void)
 		return;
 
 	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
-				&crash_size, &crash_base, &low_size, &high);
+				&crash_size, &crash_base, &low_size, NULL, &high);
 	if (ret)
 		return;
 
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index fbfe0771317e..11b9b6b63e19 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -458,7 +458,7 @@ static void __init mips_parse_crashkernel(void)
 	total_mem = memblock_phys_mem_size();
 	ret = parse_crashkernel(boot_command_line, total_mem,
 				&crash_size, &crash_base,
-				NULL, NULL);
+				NULL, NULL, NULL);
 	if (ret != 0 || crash_size <= 0)
 		return;
 
diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 4b371c738213..f90aaa2263aa 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -334,7 +334,7 @@ static __init u64 fadump_calculate_reserve_size(void)
 	 * memory at a predefined offset.
 	 */
 	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
-				&size, &base, NULL, NULL);
+				&size, &base, NULL, NULL, NULL);
 	if (ret == 0 && size > 0) {
 		unsigned long max_size;
 
diff --git a/arch/powerpc/kexec/core.c b/arch/powerpc/kexec/core.c
index 58a930a47422..35f92427d282 100644
--- a/arch/powerpc/kexec/core.c
+++ b/arch/powerpc/kexec/core.c
@@ -66,7 +66,7 @@ void __init reserve_crashkernel(void)
 	total_mem_sz = memory_limit ? memory_limit : memblock_phys_mem_size();
 	/* use common parsing */
 	ret = parse_crashkernel(boot_command_line, total_mem_sz,
-			&crash_size, &crash_base, NULL, NULL);
+			&crash_size, &crash_base, NULL, NULL, NULL);
 	if (ret == 0 && crash_size > 0) {
 		crashk_res.start = crash_base;
 		crashk_res.end = crash_base + crash_size - 1;
diff --git a/arch/powerpc/mm/nohash/kaslr_booke.c b/arch/powerpc/mm/nohash/kaslr_booke.c
index 5c8d1bb98b3e..5e4897daaaea 100644
--- a/arch/powerpc/mm/nohash/kaslr_booke.c
+++ b/arch/powerpc/mm/nohash/kaslr_booke.c
@@ -178,7 +178,7 @@ static void __init get_crash_kernel(void *fdt, unsigned long size)
 	int ret;
 
 	ret = parse_crashkernel(boot_command_line, size, &crash_size,
-				&crash_base, NULL, NULL);
+				&crash_base, NULL, NULL, NULL);
 	if (ret != 0 || crash_size == 0)
 		return;
 	if (crash_base == 0)
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 15b2eda4c364..9634a800629b 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -1405,7 +1405,7 @@ static void __init arch_reserve_crashkernel(void)
 
 	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
 				&crash_size, &crash_base,
-				&low_size, &high);
+				&low_size, NULL, &high);
 	if (ret)
 		return;
 
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index d78bcfe707b5..4d9b5b5d0cb2 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -607,7 +607,7 @@ static void __init reserve_crashkernel(void)
 	int rc;
 
 	rc = parse_crashkernel(boot_command_line, ident_map_size,
-			       &crash_size, &crash_base, NULL, NULL);
+			       &crash_size, &crash_base, NULL, NULL, NULL);
 
 	crash_base = ALIGN(crash_base, KEXEC_CRASH_MEM_ALIGN);
 	crash_size = ALIGN(crash_size, KEXEC_CRASH_MEM_ALIGN);
diff --git a/arch/sh/kernel/machine_kexec.c b/arch/sh/kernel/machine_kexec.c
index 8321b31d2e19..37073ca1e0ad 100644
--- a/arch/sh/kernel/machine_kexec.c
+++ b/arch/sh/kernel/machine_kexec.c
@@ -146,7 +146,7 @@ void __init reserve_crashkernel(void)
 		return;
 
 	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
-			&crash_size, &crash_base, NULL, NULL);
+			&crash_size, &crash_base, NULL, NULL, NULL);
 	if (ret == 0 && crash_size > 0) {
 		crashk_res.start = crash_base;
 		crashk_res.end = crash_base + crash_size - 1;
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index cebee310e200..853afde761a7 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -481,7 +481,7 @@ static void __init arch_reserve_crashkernel(void)
 
 	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
 				&crash_size, &crash_base,
-				&low_size, &high);
+				&low_size, NULL, &high);
 	if (ret)
 		return;
 
diff --git a/include/linux/crash_reserve.h b/include/linux/crash_reserve.h
index 5a9df944fb80..a681f265a361 100644
--- a/include/linux/crash_reserve.h
+++ b/include/linux/crash_reserve.h
@@ -16,7 +16,8 @@ extern struct resource crashk_low_res;
 
 int __init parse_crashkernel(char *cmdline, unsigned long long system_ram,
 		unsigned long long *crash_size, unsigned long long *crash_base,
-		unsigned long long *low_size, bool *high);
+		unsigned long long *low_size, unsigned long long *cma_size,
+		bool *high);
 
 #ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
 #ifndef DEFAULT_CRASH_KERNEL_LOW_SIZE
diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
index a620fb4b2116..4969d60c00d6 100644
--- a/kernel/crash_reserve.c
+++ b/kernel/crash_reserve.c
@@ -172,17 +172,19 @@ static int __init parse_crashkernel_simple(char *cmdline,
 
 #define SUFFIX_HIGH 0
 #define SUFFIX_LOW  1
-#define SUFFIX_NULL 2
+#define SUFFIX_CMA  2
+#define SUFFIX_NULL 3
 static __initdata char *suffix_tbl[] = {
 	[SUFFIX_HIGH] = ",high",
 	[SUFFIX_LOW]  = ",low",
+	[SUFFIX_CMA]  = ",cma",
 	[SUFFIX_NULL] = NULL,
 };
 
 /*
  * That function parses "suffix"  crashkernel command lines like
  *
- *	crashkernel=size,[high|low]
+ *	crashkernel=size,[high|low|cma]
  *
  * It returns 0 on success and -EINVAL on failure.
  */
@@ -298,9 +300,11 @@ int __init parse_crashkernel(char *cmdline,
 			     unsigned long long *crash_size,
 			     unsigned long long *crash_base,
 			     unsigned long long *low_size,
+			     unsigned long long *cma_size,
 			     bool *high)
 {
 	int ret;
+	unsigned long long __always_unused cma_base;
 
 	/* crashkernel=X[@offset] */
 	ret = __parse_crashkernel(cmdline, system_ram, crash_size,
@@ -331,6 +335,14 @@ int __init parse_crashkernel(char *cmdline,
 
 		*high = true;
 	}
+
+	/*
+	 * optional CMA reservation
+	 * cma_base is ignored
+	 */
+	if (cma_size)
+		__parse_crashkernel(cmdline, 0, cma_size,
+			&cma_base, suffix_tbl[SUFFIX_CMA]);
 #endif
 	if (!*crash_size)
 		ret = -EINVAL;

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia


