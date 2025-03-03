Return-Path: <linux-kernel+bounces-544857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBE1A4E604
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EB8F19C413C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910FC24C064;
	Tue,  4 Mar 2025 16:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="aHeEeVH6"
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D03202990
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 16:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104286; cv=pass; b=cnnxJHrZLpj5HRhS4vPtbULXLKZfYLHzExkBEdHqnoMdwiLqZbSPMjIwPn3q8OPmuF96HniiTRPjVVN4Kd935b3byJHrlLqGvcgYEyHD7Ik3TAvz3Ay8p0XupnhcSjm8oU2TwCDFckCy7IeyGfVHx/K2sdMxmBTXfuhc6S91kHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104286; c=relaxed/simple;
	bh=IZe72e+v2i+jeTtW39ol8WsnkfH3SWr7VXmkTOvqZ7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mbdHMCzHUbdhZZlJl1cJs1EYQQm0vXtwkmUBy4r44SNjW1F/BPfrt/RI67XFX9EEoBxrkczd6AY/FZmMlIQi4fQfMbz5CGSh9H7BrxpzXlIxZlW9zJVMJtzYUBBrEa2815PmjM/AfZPSLHenEB+g0L/itrxaPhagLDQ9Vph/KM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=aHeEeVH6; arc=none smtp.client-ip=65.109.113.108; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; arc=pass smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id 239A5408B656
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 19:04:43 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6gSy1vzVzG25M
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 19:03:14 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id E842342738; Tue,  4 Mar 2025 19:03:07 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=aHeEeVH6
X-Envelope-From: <linux-kernel+bounces-541466-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=aHeEeVH6
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id AD10041B34
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:03:29 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 13E9F2DCE0
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:03:28 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C713F3AF337
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 10:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECC51F560B;
	Mon,  3 Mar 2025 10:57:44 +0000 (UTC)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A53AD27
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 10:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999459; cv=none; b=I2AbJ0gmc42yczZc/zoqPj6m+5fAp/sTnC6Rx3B1o3rRtd+4z7ZL6rf2LkEO7nS7bNPYaF6X1L7Ty/zeDMV0byyAnpVmwOEoqcrqlZzUyVbryimRbHOC5QIqTYWBvwdx+Cw2Ks1aCBUiXFyC8slC2/umxiGV/Ruktskv6QMWl+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999459; c=relaxed/simple;
	bh=IZe72e+v2i+jeTtW39ol8WsnkfH3SWr7VXmkTOvqZ7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pCYb2kqvFOZblHYrxKADuqxSTapqnjFBngqn5K3RTs94kuBIhZd1l7gCf7GixiJldbG7EXtd7errpd5jUqeJp/LhSGTJOz8/f/BMf+1p4CFHTihUq1Wybrc+6npoHdILRzifU7OHLQyg5D3q6xuj8knd/H+fyFmczYKONnLr0rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=aHeEeVH6; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5A45A40E01D1;
	Mon,  3 Mar 2025 10:57:30 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id txShmVpQ3j3m; Mon,  3 Mar 2025 10:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740999444; bh=fsF/BJYY/vDdKR++SVp7pZPQ4pqpWof0XiKnlyeuEyc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aHeEeVH6vARp+vq/iNsLnfLXsQahhf7y8tqD7HBji9il6Wr2pXEQ782qC25ooI0KM
	 RJRux8tT/oZ0lKMTGzs6DcVUh9/PK2Jpf00uylQ8uglfuBwL1kjDrL7PBsZSnqC6HC
	 K0ZLSgbUKiMMyjViybWsAQZ3lPzFaxoDDTEQgJgz6u5H5NN31ZRe/UZeBGkmbIV1OM
	 L6BwHGkNd6r167f6wNnQj7LkCPBgv6sqxWjgiMrmJe9OKrIPMx13BgICXKO2QTWsUS
	 stwfTVnOCqS193hqWO9SBDsMBdHJMqTc/eDMCOm4btC6PRKjFWbvwCIRXP+WmaE6aK
	 VrF/6GUXsq1qRWI+r/qmvqw52ZQdAIQO3POo6W5SYIPV+Y3EuK1qWiB5eI/3YRz5LM
	 ZjOR5vsQsAAFGews4++4wJQ2kYKJ2ATj8qIWZdfaMKcsX3HthSb/DJtjTe5KQL6LpN
	 Q36+NlAVwLAuLuFv7GbCMeRyHWsyZ6FSBH5GKI5SAjRPMWeJa90Vvkh+4dKBqguOzh
	 JAbbWnFu6xVHjDmTOXImkNNidmSG2p+l81c8UD33IfcR3QbQ8QMy3oVWdi7HcsSN72
	 MnJyw3WJv2UxBcBbeb7alHxGYe8iWsUXAQRTb2MZEw5NKSHwx78r7a5GgV8JT+AwpI
	 TwLxd8LlrneIo2s7GROMojeU=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D335B40E01AD;
	Mon,  3 Mar 2025 10:57:06 +0000 (UTC)
Date: Mon, 3 Mar 2025 11:57:00 +0100
From: Borislav Petkov <bp@alien8.de>
To: Rik van Riel <riel@surriel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
	dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
	nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com,
	linux-mm@kvack.org, akpm@linux-foundation.org, jackmanb@google.com,
	jannh@google.com, mhklinux@outlook.com, andrew.cooper3@citrix.com,
	Manali.Shukla@amd.com, mingo@kernel.org
Subject: Re: [PATCH v14 10/13] x86/mm: enable broadcast TLB invalidation for
 multi-threaded processes
Message-ID: <20250303105700.GAZ8WK_Bkq_r6lBNVc@fat_crate.local>
References: <20250226030129.530345-1-riel@surriel.com>
 <20250226030129.530345-11-riel@surriel.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250226030129.530345-11-riel@surriel.com>
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6gSy1vzVzG25M
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741709006.76609@PAs+A4/Us7xoTgIg0uTbOA
X-ITU-MailScanner-SpamCheck: not spam

On Tue, Feb 25, 2025 at 10:00:45PM -0500, Rik van Riel wrote:
> +/*
> + * x86 has 4k ASIDs (2k when compiled with KPTI), but the largest
> + * x86 systems have over 8k CPUs. Because of this potential ASID
> + * shortage, global ASIDs are handed out to processes that have
> + * frequent TLB flushes and are active on 4 or more CPUs simultaneously.
> + */
> +static void consider_global_asid(struct mm_struct *mm)
> +{
> +	if (!static_cpu_has(X86_FEATURE_INVLPGB))
> +		return;
> +
> +	/* Check every once in a while. */
> +	if ((current->pid & 0x1f) != (jiffies & 0x1f))
> +		return;

Uff, this looks funky.

> +
> +	if (!READ_ONCE(global_asid_available))
> +		return;

use_global_asid() will do that check for us already and it'll even warn.

> +
> +	/*
> +	 * Assign a global ASID if the process is active on
> +	 * 4 or more CPUs simultaneously.
> +	 */
> +	if (mm_active_cpus_exceeds(mm, 3))
> +		use_global_asid(mm);
> +}
> +

...

> +static void broadcast_tlb_flush(struct flush_tlb_info *info)
> +{
> +	bool pmd = info->stride_shift == PMD_SHIFT;
> +	unsigned long asid = mm_global_asid(info->mm);
> +	unsigned long addr = info->start;
> +
> +	/*
> +	 * TLB flushes with INVLPGB are kicked off asynchronously.
> +	 * The inc_mm_tlb_gen() guarantees page table updates are done
> +	 * before these TLB flushes happen.
> +	 */
> +	if (info->end == TLB_FLUSH_ALL) {
> +		invlpgb_flush_single_pcid_nosync(kern_pcid(asid));
> +		/* Do any CPUs supporting INVLPGB need PTI? */

I hope not. :)

However, I think one can force-enable PTI on AMD so yeah, let's keep that.

...

Final result:

From: Rik van Riel <riel@surriel.com>
Date: Tue, 25 Feb 2025 22:00:45 -0500
Subject: [PATCH] x86/mm: Enable broadcast TLB invalidation for multi-threaded
 processes

There is not enough room in the 12-bit ASID address space to hand out
broadcast ASIDs to every process. Only hand out broadcast ASIDs to processes
when they are observed to be simultaneously running on 4 or more CPUs.

This also allows single threaded process to continue using the cheaper, local
TLB invalidation instructions like INVLPGB.

Due to the structure of flush_tlb_mm_range(), the INVLPGB flushing is done in
a generically named broadcast_tlb_flush() function which can later also be
used for Intel RAR.

Combined with the removal of unnecessary lru_add_drain calls() (see
https://lore.kernel.org/r/20241219153253.3da9e8aa@fangorn) this results in
a nice performance boost for the will-it-scale tlb_flush2_threads test on an
AMD Milan system with 36 cores:

  - vanilla kernel:           527k loops/second
  - lru_add_drain removal:    731k loops/second
  - only INVLPGB:             527k loops/second
  - lru_add_drain + INVLPGB: 1157k loops/second

Profiling with only the INVLPGB changes showed while TLB invalidation went
down from 40% of the total CPU time to only around 4% of CPU time, the
contention simply moved to the LRU lock.

Fixing both at the same time about doubles the number of iterations per second
from this case.

Comparing will-it-scale tlb_flush2_threads with several different numbers of
threads on a 72 CPU AMD Milan shows similar results. The number represents the
total number of loops per second across all the threads:

  threads	tip		INVLPGB

  1		315k		304k
  2		423k		424k
  4		644k		1032k
  8		652k		1267k
  16		737k		1368k
  32		759k		1199k
  64		636k		1094k
  72		609k		993k

1 and 2 thread performance is similar with and without INVLPGB, because
INVLPGB is only used on processes using 4 or more CPUs simultaneously.

The number is the median across 5 runs.

Some numbers closer to real world performance can be found at Phoronix, thanks
to Michael:

https://www.phoronix.com/news/AMD-INVLPGB-Linux-Benefits

  [ bp:
   - Massage
   - :%s/\<static_cpu_has\>/cpu_feature_enabled/cgi
   - :%s/\<clear_asid_transition\>/mm_clear_asid_transition/cgi
   ]

Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nadav Amit <nadav.amit@gmail.com>
Link: https://lore.kernel.org/r/20250226030129.530345-11-riel@surriel.com
---
 arch/x86/include/asm/tlbflush.h |   5 ++
 arch/x86/mm/tlb.c               | 104 +++++++++++++++++++++++++++++++-
 2 files changed, 108 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index e6c3be06dd21..8c21030269ff 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -280,6 +280,11 @@ static inline void mm_assign_global_asid(struct mm_struct *mm, u16 asid)
 	smp_store_release(&mm->context.global_asid, asid);
 }
 
+static inline void mm_clear_asid_transition(struct mm_struct *mm)
+{
+	WRITE_ONCE(mm->context.asid_transition, false);
+}
+
 static inline bool mm_in_asid_transition(struct mm_struct *mm)
 {
 	if (!cpu_feature_enabled(X86_FEATURE_INVLPGB))
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index b5681e6f2333..0efd99053c09 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -430,6 +430,105 @@ static bool mm_needs_global_asid(struct mm_struct *mm, u16 asid)
 	return false;
 }
 
+/*
+ * x86 has 4k ASIDs (2k when compiled with KPTI), but the largest x86
+ * systems have over 8k CPUs. Because of this potential ASID shortage,
+ * global ASIDs are handed out to processes that have frequent TLB
+ * flushes and are active on 4 or more CPUs simultaneously.
+ */
+static void consider_global_asid(struct mm_struct *mm)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_INVLPGB))
+		return;
+
+	/* Check every once in a while. */
+	if ((current->pid & 0x1f) != (jiffies & 0x1f))
+		return;
+
+	/*
+	 * Assign a global ASID if the process is active on
+	 * 4 or more CPUs simultaneously.
+	 */
+	if (mm_active_cpus_exceeds(mm, 3))
+		use_global_asid(mm);
+}
+
+static void finish_asid_transition(struct flush_tlb_info *info)
+{
+	struct mm_struct *mm = info->mm;
+	int bc_asid = mm_global_asid(mm);
+	int cpu;
+
+	if (!mm_in_asid_transition(mm))
+		return;
+
+	for_each_cpu(cpu, mm_cpumask(mm)) {
+		/*
+		 * The remote CPU is context switching. Wait for that to
+		 * finish, to catch the unlikely case of it switching to
+		 * the target mm with an out of date ASID.
+		 */
+		while (READ_ONCE(per_cpu(cpu_tlbstate.loaded_mm, cpu)) == LOADED_MM_SWITCHING)
+			cpu_relax();
+
+		if (READ_ONCE(per_cpu(cpu_tlbstate.loaded_mm, cpu)) != mm)
+			continue;
+
+		/*
+		 * If at least one CPU is not using the global ASID yet,
+		 * send a TLB flush IPI. The IPI should cause stragglers
+		 * to transition soon.
+		 *
+		 * This can race with the CPU switching to another task;
+		 * that results in a (harmless) extra IPI.
+		 */
+		if (READ_ONCE(per_cpu(cpu_tlbstate.loaded_mm_asid, cpu)) != bc_asid) {
+			flush_tlb_multi(mm_cpumask(info->mm), info);
+			return;
+		}
+	}
+
+	/* All the CPUs running this process are using the global ASID. */
+	mm_clear_asid_transition(mm);
+}
+
+static void broadcast_tlb_flush(struct flush_tlb_info *info)
+{
+	bool pmd = info->stride_shift == PMD_SHIFT;
+	unsigned long asid = mm_global_asid(info->mm);
+	unsigned long addr = info->start;
+
+	/*
+	 * TLB flushes with INVLPGB are kicked off asynchronously.
+	 * The inc_mm_tlb_gen() guarantees page table updates are done
+	 * before these TLB flushes happen.
+	 */
+	if (info->end == TLB_FLUSH_ALL) {
+		invlpgb_flush_single_pcid_nosync(kern_pcid(asid));
+		/* Do any CPUs supporting INVLPGB need PTI? */
+		if (cpu_feature_enabled(X86_FEATURE_PTI))
+			invlpgb_flush_single_pcid_nosync(user_pcid(asid));
+	} else do {
+		unsigned long nr = 1;
+
+		if (info->stride_shift <= PMD_SHIFT) {
+			nr = (info->end - addr) >> info->stride_shift;
+			nr = clamp_val(nr, 1, invlpgb_count_max);
+		}
+
+		invlpgb_flush_user_nr_nosync(kern_pcid(asid), addr, nr, pmd);
+		if (cpu_feature_enabled(X86_FEATURE_PTI))
+			invlpgb_flush_user_nr_nosync(user_pcid(asid), addr, nr, pmd);
+
+		addr += nr << info->stride_shift;
+	} while (addr < info->end);
+
+	finish_asid_transition(info);
+
+	/* Wait for the INVLPGBs kicked off above to finish. */
+	__tlbsync();
+}
+
 /*
  * Given an ASID, flush the corresponding user ASID.  We can delay this
  * until the next time we switch to it.
@@ -1260,9 +1359,12 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 	 * a local TLB flush is needed. Optimize this use-case by calling
 	 * flush_tlb_func_local() directly in this case.
 	 */
-	if (cpumask_any_but(mm_cpumask(mm), cpu) < nr_cpu_ids) {
+	if (mm_global_asid(mm)) {
+		broadcast_tlb_flush(info);
+	} else if (cpumask_any_but(mm_cpumask(mm), cpu) < nr_cpu_ids) {
 		info->trim_cpumask = should_trim_cpumask(mm);
 		flush_tlb_multi(mm_cpumask(mm), info);
+		consider_global_asid(mm);
 	} else if (mm == this_cpu_read(cpu_tlbstate.loaded_mm)) {
 		lockdep_assert_irqs_enabled();
 		local_irq_disable();
-- 
2.43.0

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


