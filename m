Return-Path: <linux-kernel+bounces-256875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 959BA9371A6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 02:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAE031F21A73
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 00:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161AF848E;
	Fri, 19 Jul 2024 00:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gQMNYVhh"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10C6184D
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 00:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721350301; cv=none; b=fQx5SWQkTuxec7unbw9clSwhDex8myMjMlqbIqwex3eWwiwpRWxmDTVymQC5/dghoho+bIcH/6zE/VNNAb7EiE9lFpXMA28iLLpWei+GHoNSiaEAoNRNvTmeHGdS82wRGS5LAi9oCfgWQodNJBy66BMYYAtnpYQg1jiWZlQnEeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721350301; c=relaxed/simple;
	bh=iVBhD3kTXaqE3DL6rj1t2e9OS+1OftpQN4evn4oh7oU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s1ahmC4adAQsBnSNscweCCC0H6WaXP2MdFAvgbjDBdA/BF2GiejgTWSVOXaaL7DkCRWvUAW/KOV/CjFxLe6OmTL8bk5EaWLLFo6VVnW3ic9b4KoUA1yW2ub2WrSLpbpzIvFZaTeKL/F0RFNhRUYg2k96DZoJc+g1Huhi810dDZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gQMNYVhh; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70b1207bc22so306389b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 17:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721350298; x=1721955098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQz/kcn1/Vlblma+YaV3iJSRlHzLsvj/JybaTHd1s0w=;
        b=gQMNYVhhkIf2JxsQ2a2neBSY1pGWeGfWkdbUamFG1ocZIlAvZbtvWpyqR2LAy7Z5bX
         76KrqDC0g/AvJCx5C8m5Q0QZpRVklbZPQ6n8TsceyxdF0ekm20tMdEXGqs4g9mtz/K+6
         kd9diUHnN69hFh9tcLSD53pd8MRT6bIbHpJfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721350298; x=1721955098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TQz/kcn1/Vlblma+YaV3iJSRlHzLsvj/JybaTHd1s0w=;
        b=cYR3zPCPZkJNlybWoGRmykhuTd/i8/zIg6UL+L1UDK1oGIvxJwLu5/7oCM6FJJArAm
         GSdn4Jjo1tpOn8Dnd1Sf+PMR/UKawvWb69cKBTWpTv6OGiZe+XtnoNrHZsCCvozg8+Uo
         bRvXGpudUXTG7JJzc2g5HyXemCEH1PWjUhmbG/KcGGiPcPjeDmimY3HNOpnfmiJWSwfD
         Z9HQ/2R5KYAYb/S3vhE7JXZM+47ts7JI+KJOJNW+1qOPPYEpL520bIdCShdSoOkRGhXg
         pcX65vrU/C2jWHoDrXdOMeOfyP3xQtk7gay8FiJkPp72jYLl2meqU5R/IqBfPlykEq85
         7anw==
X-Gm-Message-State: AOJu0YxdCnSYpDVNmNGbppKnTP6d6M5g1R+TSywaVAYuahZyXc3M9zzc
	zGMNM+BI3qALisU2aW0+drrWPNFR9wIu/kEs71EZPoTzGINSeqj7VywIyo027XxxZniHqvXMW0Y
	=
X-Google-Smtp-Source: AGHT+IFk6xhQzDjm27qOPq3dBYo+X1YvuaOWUUKpjk6jn1udjv3U8UCmm/5lSMvACXLblNd/Vp6yrg==
X-Received: by 2002:a05:6a20:c90d:b0:1c0:f590:f77f with SMTP id adf61e73a8af0-1c3fdae8afcmr8863154637.0.1721350298091;
        Thu, 18 Jul 2024 17:51:38 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:35aa:f87d:7549:3938])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-1fd64b49c90sm2006265ad.49.2024.07.18.17.51.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 17:51:37 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Yury Norov <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	llvm@lists.linux.dev,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Brian Norris <briannorris@chromium.org>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH v3 3/4] cpumask: Switch from inline to __always_inline
Date: Thu, 18 Jul 2024 17:50:39 -0700
Message-ID: <20240719005127.2449328-3-briannorris@chromium.org>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
In-Reply-To: <20240719005127.2449328-1-briannorris@chromium.org>
References: <20240719005127.2449328-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On recent (v6.6+) builds with Clang (based on Clang 18.0.0) and certain
configurations [0], I'm finding that (lack of) inlining decisions may
lead to section mismatch warnings like the following:

  WARNING: modpost: vmlinux.o: section mismatch in reference:
  cpumask_andnot (section: .text) ->
  cpuhp_bringup_cpus_parallel.tmp_mask (section: .init.data) ERROR:
  modpost: Section mismatches detected.

or more confusingly:

  WARNING: modpost: vmlinux: section mismatch in reference:
  cpumask_andnot+0x5f (section: .text) -> efi_systab_phys (section:
  .init.data)

The first warning makes a little sense, because
cpuhp_bringup_cpus_parallel() (an __init function) calls
cpumask_andnot() on tmp_mask (an __initdata symbol). If the compiler
doesn't inline cpumask_andnot(), this may appear like a mismatch.

The second warning makes less sense, but might be because efi_systab_phys
and cpuhp_bringup_cpus_parallel.tmp_mask are laid out near each other,
and the latter isn't a proper C symbol definition.

In any case, it seems a reasonable solution to suggest more strongly to
the compiler that these cpumask macros *must* be inlined, as 'inline' is
just a recommendation.

This change has been previously proposed in the past as:

  Subject: [PATCH 1/3] bitmap: switch from inline to __always_inline
  https://lore.kernel.org/all/20221027043810.350460-2-yury.norov@gmail.com/

But the change has been split up, to separately justify the cpumask
changes (which drive my work) and the bitmap/const optimizations (that
Yury separately proposed for other reasons). This ends up as somewhere
between a "rebase" and "rewrite" -- I had to rewrite most of the patch.

According to bloat-o-meter, vmlinux decreases minimally in size (-0.00%
to -0.01%, depending on the version of GCC or Clang and .config in
question) with this series of changes:

gcc 13.2.0, x86_64_defconfig
-3005 bytes, Before=21944501, After=21941496, chg -0.01%

clang 16.0.6, x86_64_defconfig
-105 bytes, Before=22571692, After=22571587, chg -0.00%

gcc 9.5.0, x86_64_defconfig
-1771 bytes, Before=21557598, After=21555827, chg -0.01%

clang 18.0_pre516547 (ChromiumOS toolchain), x86_64_defconfig
-191 bytes, Before=22615339, After=22615148, chg -0.00%

clang 18.0_pre516547 (ChromiumOS toolchain), based on ChromiumOS config + gcov
-979 bytes, Before=76294783, After=76293804, chg -0.00%

[0] CONFIG_HOTPLUG_PARALLEL=y ('select'ed for x86 as of [1]) and
    CONFIG_GCOV_PROFILE_ALL.

[1] commit 0c7ffa32dbd6 ("x86/smpboot/64: Implement
    arch_cpuhp_init_parallel_bringup() and enable it")

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Co-developed-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Kees Cook <kees@kernel.org>
---

Changes in v3:
 - rearrange line wrapping of function signatures
 - add more compiler x .config test data
 - split to 4 patches, with a mix of Yury+mine authorship
 - include Kees's Acked-by

Changes in v2:
 - rebase, update cpumask.h based on recent additions and removals
 - also convert bitmap.h, find.h, nodemask.h

 include/linux/cpumask.h | 216 +++++++++++++++++++++-------------------
 1 file changed, 114 insertions(+), 102 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 23686bed441d..072e0d692625 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -42,7 +42,7 @@ typedef struct cpumask { DECLARE_BITMAP(bits, NR_CPUS); } cpumask_t;
 extern unsigned int nr_cpu_ids;
 #endif
 
-static inline void set_nr_cpu_ids(unsigned int nr)
+static __always_inline void set_nr_cpu_ids(unsigned int nr)
 {
 #if (NR_CPUS == 1) || defined(CONFIG_FORCE_NR_CPUS)
 	WARN_ON(nr != nr_cpu_ids);
@@ -158,7 +158,7 @@ static __always_inline unsigned int cpumask_check(unsigned int cpu)
  *
  * Return: >= nr_cpu_ids if no cpus set.
  */
-static inline unsigned int cpumask_first(const struct cpumask *srcp)
+static __always_inline unsigned int cpumask_first(const struct cpumask *srcp)
 {
 	return find_first_bit(cpumask_bits(srcp), small_cpumask_bits);
 }
@@ -169,7 +169,7 @@ static inline unsigned int cpumask_first(const struct cpumask *srcp)
  *
  * Return: >= nr_cpu_ids if all cpus are set.
  */
-static inline unsigned int cpumask_first_zero(const struct cpumask *srcp)
+static __always_inline unsigned int cpumask_first_zero(const struct cpumask *srcp)
 {
 	return find_first_zero_bit(cpumask_bits(srcp), small_cpumask_bits);
 }
@@ -181,7 +181,7 @@ static inline unsigned int cpumask_first_zero(const struct cpumask *srcp)
  *
  * Return: >= nr_cpu_ids if no cpus set in both.  See also cpumask_next_and().
  */
-static inline
+static __always_inline
 unsigned int cpumask_first_and(const struct cpumask *srcp1, const struct cpumask *srcp2)
 {
 	return find_first_and_bit(cpumask_bits(srcp1), cpumask_bits(srcp2), small_cpumask_bits);
@@ -195,7 +195,7 @@ unsigned int cpumask_first_and(const struct cpumask *srcp1, const struct cpumask
  *
  * Return: >= nr_cpu_ids if no cpus set in all.
  */
-static inline
+static __always_inline
 unsigned int cpumask_first_and_and(const struct cpumask *srcp1,
 				   const struct cpumask *srcp2,
 				   const struct cpumask *srcp3)
@@ -210,7 +210,7 @@ unsigned int cpumask_first_and_and(const struct cpumask *srcp1,
  *
  * Return:	>= nr_cpumask_bits if no CPUs set.
  */
-static inline unsigned int cpumask_last(const struct cpumask *srcp)
+static __always_inline unsigned int cpumask_last(const struct cpumask *srcp)
 {
 	return find_last_bit(cpumask_bits(srcp), small_cpumask_bits);
 }
@@ -222,7 +222,7 @@ static inline unsigned int cpumask_last(const struct cpumask *srcp)
  *
  * Return: >= nr_cpu_ids if no further cpus set.
  */
-static inline
+static __always_inline
 unsigned int cpumask_next(int n, const struct cpumask *srcp)
 {
 	/* -1 is a legal arg here. */
@@ -238,7 +238,8 @@ unsigned int cpumask_next(int n, const struct cpumask *srcp)
  *
  * Return: >= nr_cpu_ids if no further cpus unset.
  */
-static inline unsigned int cpumask_next_zero(int n, const struct cpumask *srcp)
+static __always_inline
+unsigned int cpumask_next_zero(int n, const struct cpumask *srcp)
 {
 	/* -1 is a legal arg here. */
 	if (n != -1)
@@ -248,18 +249,21 @@ static inline unsigned int cpumask_next_zero(int n, const struct cpumask *srcp)
 
 #if NR_CPUS == 1
 /* Uniprocessor: there is only one valid CPU */
-static inline unsigned int cpumask_local_spread(unsigned int i, int node)
+static __always_inline
+unsigned int cpumask_local_spread(unsigned int i, int node)
 {
 	return 0;
 }
 
-static inline unsigned int cpumask_any_and_distribute(const struct cpumask *src1p,
-						      const struct cpumask *src2p)
+static __always_inline
+unsigned int cpumask_any_and_distribute(const struct cpumask *src1p,
+					const struct cpumask *src2p)
 {
 	return cpumask_first_and(src1p, src2p);
 }
 
-static inline unsigned int cpumask_any_distribute(const struct cpumask *srcp)
+static __always_inline
+unsigned int cpumask_any_distribute(const struct cpumask *srcp)
 {
 	return cpumask_first(srcp);
 }
@@ -278,9 +282,9 @@ unsigned int cpumask_any_distribute(const struct cpumask *srcp);
  *
  * Return: >= nr_cpu_ids if no further cpus set in both.
  */
-static inline
+static __always_inline
 unsigned int cpumask_next_and(int n, const struct cpumask *src1p,
-		     const struct cpumask *src2p)
+			      const struct cpumask *src2p)
 {
 	/* -1 is a legal arg here. */
 	if (n != -1)
@@ -300,7 +304,7 @@ unsigned int cpumask_next_and(int n, const struct cpumask *src1p,
 	for_each_set_bit(cpu, cpumask_bits(mask), small_cpumask_bits)
 
 #if NR_CPUS == 1
-static inline
+static __always_inline
 unsigned int cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool wrap)
 {
 	cpumask_check(start);
@@ -403,7 +407,7 @@ unsigned int __pure cpumask_next_wrap(int n, const struct cpumask *mask, int sta
  * Often used to find any cpu but smp_processor_id() in a mask.
  * Return: >= nr_cpu_ids if no cpus set.
  */
-static inline
+static __always_inline
 unsigned int cpumask_any_but(const struct cpumask *mask, unsigned int cpu)
 {
 	unsigned int i;
@@ -423,7 +427,7 @@ unsigned int cpumask_any_but(const struct cpumask *mask, unsigned int cpu)
  *
  * Returns >= nr_cpu_ids if no cpus set.
  */
-static inline
+static __always_inline
 unsigned int cpumask_any_and_but(const struct cpumask *mask1,
 				 const struct cpumask *mask2,
 				 unsigned int cpu)
@@ -445,7 +449,8 @@ unsigned int cpumask_any_and_but(const struct cpumask *mask1,
  *
  * Return: >= nr_cpu_ids if such cpu doesn't exist.
  */
-static inline unsigned int cpumask_nth(unsigned int cpu, const struct cpumask *srcp)
+static __always_inline
+unsigned int cpumask_nth(unsigned int cpu, const struct cpumask *srcp)
 {
 	return find_nth_bit(cpumask_bits(srcp), small_cpumask_bits, cpumask_check(cpu));
 }
@@ -458,7 +463,7 @@ static inline unsigned int cpumask_nth(unsigned int cpu, const struct cpumask *s
  *
  * Return: >= nr_cpu_ids if such cpu doesn't exist.
  */
-static inline
+static __always_inline
 unsigned int cpumask_nth_and(unsigned int cpu, const struct cpumask *srcp1,
 							const struct cpumask *srcp2)
 {
@@ -474,7 +479,7 @@ unsigned int cpumask_nth_and(unsigned int cpu, const struct cpumask *srcp1,
  *
  * Return: >= nr_cpu_ids if such cpu doesn't exist.
  */
-static inline
+static __always_inline
 unsigned int cpumask_nth_andnot(unsigned int cpu, const struct cpumask *srcp1,
 							const struct cpumask *srcp2)
 {
@@ -517,12 +522,14 @@ unsigned int cpumask_nth_and_andnot(unsigned int cpu, const struct cpumask *srcp
  * @cpu: cpu number (< nr_cpu_ids)
  * @dstp: the cpumask pointer
  */
-static __always_inline void cpumask_set_cpu(unsigned int cpu, struct cpumask *dstp)
+static __always_inline
+void cpumask_set_cpu(unsigned int cpu, struct cpumask *dstp)
 {
 	set_bit(cpumask_check(cpu), cpumask_bits(dstp));
 }
 
-static __always_inline void __cpumask_set_cpu(unsigned int cpu, struct cpumask *dstp)
+static __always_inline
+void __cpumask_set_cpu(unsigned int cpu, struct cpumask *dstp)
 {
 	__set_bit(cpumask_check(cpu), cpumask_bits(dstp));
 }
@@ -566,7 +573,8 @@ static __always_inline void __cpumask_assign_cpu(int cpu, struct cpumask *dstp,
  *
  * Return: true if @cpu is set in @cpumask, else returns false
  */
-static __always_inline bool cpumask_test_cpu(int cpu, const struct cpumask *cpumask)
+static __always_inline
+bool cpumask_test_cpu(int cpu, const struct cpumask *cpumask)
 {
 	return test_bit(cpumask_check(cpu), cpumask_bits((cpumask)));
 }
@@ -580,7 +588,8 @@ static __always_inline bool cpumask_test_cpu(int cpu, const struct cpumask *cpum
  *
  * Return: true if @cpu is set in old bitmap of @cpumask, else returns false
  */
-static __always_inline bool cpumask_test_and_set_cpu(int cpu, struct cpumask *cpumask)
+static __always_inline
+bool cpumask_test_and_set_cpu(int cpu, struct cpumask *cpumask)
 {
 	return test_and_set_bit(cpumask_check(cpu), cpumask_bits(cpumask));
 }
@@ -594,7 +603,8 @@ static __always_inline bool cpumask_test_and_set_cpu(int cpu, struct cpumask *cp
  *
  * Return: true if @cpu is set in old bitmap of @cpumask, else returns false
  */
-static __always_inline bool cpumask_test_and_clear_cpu(int cpu, struct cpumask *cpumask)
+static __always_inline
+bool cpumask_test_and_clear_cpu(int cpu, struct cpumask *cpumask)
 {
 	return test_and_clear_bit(cpumask_check(cpu), cpumask_bits(cpumask));
 }
@@ -603,7 +613,7 @@ static __always_inline bool cpumask_test_and_clear_cpu(int cpu, struct cpumask *
  * cpumask_setall - set all cpus (< nr_cpu_ids) in a cpumask
  * @dstp: the cpumask pointer
  */
-static inline void cpumask_setall(struct cpumask *dstp)
+static __always_inline void cpumask_setall(struct cpumask *dstp)
 {
 	if (small_const_nbits(small_cpumask_bits)) {
 		cpumask_bits(dstp)[0] = BITMAP_LAST_WORD_MASK(nr_cpumask_bits);
@@ -616,7 +626,7 @@ static inline void cpumask_setall(struct cpumask *dstp)
  * cpumask_clear - clear all cpus (< nr_cpu_ids) in a cpumask
  * @dstp: the cpumask pointer
  */
-static inline void cpumask_clear(struct cpumask *dstp)
+static __always_inline void cpumask_clear(struct cpumask *dstp)
 {
 	bitmap_zero(cpumask_bits(dstp), large_cpumask_bits);
 }
@@ -629,9 +639,9 @@ static inline void cpumask_clear(struct cpumask *dstp)
  *
  * Return: false if *@dstp is empty, else returns true
  */
-static inline bool cpumask_and(struct cpumask *dstp,
-			       const struct cpumask *src1p,
-			       const struct cpumask *src2p)
+static __always_inline
+bool cpumask_and(struct cpumask *dstp, const struct cpumask *src1p,
+		 const struct cpumask *src2p)
 {
 	return bitmap_and(cpumask_bits(dstp), cpumask_bits(src1p),
 				       cpumask_bits(src2p), small_cpumask_bits);
@@ -643,8 +653,9 @@ static inline bool cpumask_and(struct cpumask *dstp,
  * @src1p: the first input
  * @src2p: the second input
  */
-static inline void cpumask_or(struct cpumask *dstp, const struct cpumask *src1p,
-			      const struct cpumask *src2p)
+static __always_inline
+void cpumask_or(struct cpumask *dstp, const struct cpumask *src1p,
+		const struct cpumask *src2p)
 {
 	bitmap_or(cpumask_bits(dstp), cpumask_bits(src1p),
 				      cpumask_bits(src2p), small_cpumask_bits);
@@ -656,9 +667,9 @@ static inline void cpumask_or(struct cpumask *dstp, const struct cpumask *src1p,
  * @src1p: the first input
  * @src2p: the second input
  */
-static inline void cpumask_xor(struct cpumask *dstp,
-			       const struct cpumask *src1p,
-			       const struct cpumask *src2p)
+static __always_inline
+void cpumask_xor(struct cpumask *dstp, const struct cpumask *src1p,
+		 const struct cpumask *src2p)
 {
 	bitmap_xor(cpumask_bits(dstp), cpumask_bits(src1p),
 				       cpumask_bits(src2p), small_cpumask_bits);
@@ -672,9 +683,9 @@ static inline void cpumask_xor(struct cpumask *dstp,
  *
  * Return: false if *@dstp is empty, else returns true
  */
-static inline bool cpumask_andnot(struct cpumask *dstp,
-				  const struct cpumask *src1p,
-				  const struct cpumask *src2p)
+static __always_inline
+bool cpumask_andnot(struct cpumask *dstp, const struct cpumask *src1p,
+		    const struct cpumask *src2p)
 {
 	return bitmap_andnot(cpumask_bits(dstp), cpumask_bits(src1p),
 					  cpumask_bits(src2p), small_cpumask_bits);
@@ -687,8 +698,8 @@ static inline bool cpumask_andnot(struct cpumask *dstp,
  *
  * Return: true if the cpumasks are equal, false if not
  */
-static inline bool cpumask_equal(const struct cpumask *src1p,
-				const struct cpumask *src2p)
+static __always_inline
+bool cpumask_equal(const struct cpumask *src1p, const struct cpumask *src2p)
 {
 	return bitmap_equal(cpumask_bits(src1p), cpumask_bits(src2p),
 						 small_cpumask_bits);
@@ -703,9 +714,9 @@ static inline bool cpumask_equal(const struct cpumask *src1p,
  * Return: true if first cpumask ORed with second cpumask == third cpumask,
  *	   otherwise false
  */
-static inline bool cpumask_or_equal(const struct cpumask *src1p,
-				    const struct cpumask *src2p,
-				    const struct cpumask *src3p)
+static __always_inline
+bool cpumask_or_equal(const struct cpumask *src1p, const struct cpumask *src2p,
+		      const struct cpumask *src3p)
 {
 	return bitmap_or_equal(cpumask_bits(src1p), cpumask_bits(src2p),
 			       cpumask_bits(src3p), small_cpumask_bits);
@@ -719,8 +730,8 @@ static inline bool cpumask_or_equal(const struct cpumask *src1p,
  * Return: true if first cpumask ANDed with second cpumask is non-empty,
  *	   otherwise false
  */
-static inline bool cpumask_intersects(const struct cpumask *src1p,
-				     const struct cpumask *src2p)
+static __always_inline
+bool cpumask_intersects(const struct cpumask *src1p, const struct cpumask *src2p)
 {
 	return bitmap_intersects(cpumask_bits(src1p), cpumask_bits(src2p),
 						      small_cpumask_bits);
@@ -733,8 +744,8 @@ static inline bool cpumask_intersects(const struct cpumask *src1p,
  *
  * Return: true if *@src1p is a subset of *@src2p, else returns false
  */
-static inline bool cpumask_subset(const struct cpumask *src1p,
-				 const struct cpumask *src2p)
+static __always_inline
+bool cpumask_subset(const struct cpumask *src1p, const struct cpumask *src2p)
 {
 	return bitmap_subset(cpumask_bits(src1p), cpumask_bits(src2p),
 						  small_cpumask_bits);
@@ -746,7 +757,7 @@ static inline bool cpumask_subset(const struct cpumask *src1p,
  *
  * Return: true if srcp is empty (has no bits set), else false
  */
-static inline bool cpumask_empty(const struct cpumask *srcp)
+static __always_inline bool cpumask_empty(const struct cpumask *srcp)
 {
 	return bitmap_empty(cpumask_bits(srcp), small_cpumask_bits);
 }
@@ -757,7 +768,7 @@ static inline bool cpumask_empty(const struct cpumask *srcp)
  *
  * Return: true if srcp is full (has all bits set), else false
  */
-static inline bool cpumask_full(const struct cpumask *srcp)
+static __always_inline bool cpumask_full(const struct cpumask *srcp)
 {
 	return bitmap_full(cpumask_bits(srcp), nr_cpumask_bits);
 }
@@ -768,7 +779,7 @@ static inline bool cpumask_full(const struct cpumask *srcp)
  *
  * Return: count of bits set in *srcp
  */
-static inline unsigned int cpumask_weight(const struct cpumask *srcp)
+static __always_inline unsigned int cpumask_weight(const struct cpumask *srcp)
 {
 	return bitmap_weight(cpumask_bits(srcp), small_cpumask_bits);
 }
@@ -780,8 +791,8 @@ static inline unsigned int cpumask_weight(const struct cpumask *srcp)
  *
  * Return: count of bits set in both *srcp1 and *srcp2
  */
-static inline unsigned int cpumask_weight_and(const struct cpumask *srcp1,
-						const struct cpumask *srcp2)
+static __always_inline
+unsigned int cpumask_weight_and(const struct cpumask *srcp1, const struct cpumask *srcp2)
 {
 	return bitmap_weight_and(cpumask_bits(srcp1), cpumask_bits(srcp2), small_cpumask_bits);
 }
@@ -793,8 +804,9 @@ static inline unsigned int cpumask_weight_and(const struct cpumask *srcp1,
  *
  * Return: count of bits set in both *srcp1 and *srcp2
  */
-static inline unsigned int cpumask_weight_andnot(const struct cpumask *srcp1,
-						const struct cpumask *srcp2)
+static __always_inline
+unsigned int cpumask_weight_andnot(const struct cpumask *srcp1,
+				   const struct cpumask *srcp2)
 {
 	return bitmap_weight_andnot(cpumask_bits(srcp1), cpumask_bits(srcp2), small_cpumask_bits);
 }
@@ -805,8 +817,8 @@ static inline unsigned int cpumask_weight_andnot(const struct cpumask *srcp1,
  * @srcp: the input to shift
  * @n: the number of bits to shift by
  */
-static inline void cpumask_shift_right(struct cpumask *dstp,
-				       const struct cpumask *srcp, int n)
+static __always_inline
+void cpumask_shift_right(struct cpumask *dstp, const struct cpumask *srcp, int n)
 {
 	bitmap_shift_right(cpumask_bits(dstp), cpumask_bits(srcp), n,
 					       small_cpumask_bits);
@@ -818,8 +830,8 @@ static inline void cpumask_shift_right(struct cpumask *dstp,
  * @srcp: the input to shift
  * @n: the number of bits to shift by
  */
-static inline void cpumask_shift_left(struct cpumask *dstp,
-				      const struct cpumask *srcp, int n)
+static __always_inline
+void cpumask_shift_left(struct cpumask *dstp, const struct cpumask *srcp, int n)
 {
 	bitmap_shift_left(cpumask_bits(dstp), cpumask_bits(srcp), n,
 					      nr_cpumask_bits);
@@ -830,8 +842,8 @@ static inline void cpumask_shift_left(struct cpumask *dstp,
  * @dstp: the result
  * @srcp: the input cpumask
  */
-static inline void cpumask_copy(struct cpumask *dstp,
-				const struct cpumask *srcp)
+static __always_inline
+void cpumask_copy(struct cpumask *dstp, const struct cpumask *srcp)
 {
 	bitmap_copy(cpumask_bits(dstp), cpumask_bits(srcp), large_cpumask_bits);
 }
@@ -867,8 +879,8 @@ static inline void cpumask_copy(struct cpumask *dstp,
  *
  * Return: -errno, or 0 for success.
  */
-static inline int cpumask_parse_user(const char __user *buf, int len,
-				     struct cpumask *dstp)
+static __always_inline
+int cpumask_parse_user(const char __user *buf, int len, struct cpumask *dstp)
 {
 	return bitmap_parse_user(buf, len, cpumask_bits(dstp), nr_cpumask_bits);
 }
@@ -881,8 +893,8 @@ static inline int cpumask_parse_user(const char __user *buf, int len,
  *
  * Return: -errno, or 0 for success.
  */
-static inline int cpumask_parselist_user(const char __user *buf, int len,
-				     struct cpumask *dstp)
+static __always_inline
+int cpumask_parselist_user(const char __user *buf, int len, struct cpumask *dstp)
 {
 	return bitmap_parselist_user(buf, len, cpumask_bits(dstp),
 				     nr_cpumask_bits);
@@ -895,7 +907,7 @@ static inline int cpumask_parselist_user(const char __user *buf, int len,
  *
  * Return: -errno, or 0 for success.
  */
-static inline int cpumask_parse(const char *buf, struct cpumask *dstp)
+static __always_inline int cpumask_parse(const char *buf, struct cpumask *dstp)
 {
 	return bitmap_parse(buf, UINT_MAX, cpumask_bits(dstp), nr_cpumask_bits);
 }
@@ -907,7 +919,7 @@ static inline int cpumask_parse(const char *buf, struct cpumask *dstp)
  *
  * Return: -errno, or 0 for success.
  */
-static inline int cpulist_parse(const char *buf, struct cpumask *dstp)
+static __always_inline int cpulist_parse(const char *buf, struct cpumask *dstp)
 {
 	return bitmap_parselist(buf, cpumask_bits(dstp), nr_cpumask_bits);
 }
@@ -917,7 +929,7 @@ static inline int cpulist_parse(const char *buf, struct cpumask *dstp)
  *
  * Return: size to allocate for a &struct cpumask in bytes
  */
-static inline unsigned int cpumask_size(void)
+static __always_inline unsigned int cpumask_size(void)
 {
 	return bitmap_size(large_cpumask_bits);
 }
@@ -970,7 +982,7 @@ typedef struct cpumask *cpumask_var_t;
 
 bool alloc_cpumask_var_node(cpumask_var_t *mask, gfp_t flags, int node);
 
-static inline
+static __always_inline
 bool zalloc_cpumask_var_node(cpumask_var_t *mask, gfp_t flags, int node)
 {
 	return alloc_cpumask_var_node(mask, flags | __GFP_ZERO, node);
@@ -988,13 +1000,13 @@ bool zalloc_cpumask_var_node(cpumask_var_t *mask, gfp_t flags, int node)
  *
  * Return: %true if allocation succeeded, %false if not
  */
-static inline
+static __always_inline
 bool alloc_cpumask_var(cpumask_var_t *mask, gfp_t flags)
 {
 	return alloc_cpumask_var_node(mask, flags, NUMA_NO_NODE);
 }
 
-static inline
+static __always_inline
 bool zalloc_cpumask_var(cpumask_var_t *mask, gfp_t flags)
 {
 	return alloc_cpumask_var(mask, flags | __GFP_ZERO);
@@ -1004,7 +1016,7 @@ void alloc_bootmem_cpumask_var(cpumask_var_t *mask);
 void free_cpumask_var(cpumask_var_t mask);
 void free_bootmem_cpumask_var(cpumask_var_t mask);
 
-static inline bool cpumask_available(cpumask_var_t mask)
+static __always_inline bool cpumask_available(cpumask_var_t mask)
 {
 	return mask != NULL;
 }
@@ -1015,43 +1027,43 @@ typedef struct cpumask cpumask_var_t[1];
 #define this_cpu_cpumask_var_ptr(x) this_cpu_ptr(x)
 #define __cpumask_var_read_mostly
 
-static inline bool alloc_cpumask_var(cpumask_var_t *mask, gfp_t flags)
+static __always_inline bool alloc_cpumask_var(cpumask_var_t *mask, gfp_t flags)
 {
 	return true;
 }
 
-static inline bool alloc_cpumask_var_node(cpumask_var_t *mask, gfp_t flags,
+static __always_inline bool alloc_cpumask_var_node(cpumask_var_t *mask, gfp_t flags,
 					  int node)
 {
 	return true;
 }
 
-static inline bool zalloc_cpumask_var(cpumask_var_t *mask, gfp_t flags)
+static __always_inline bool zalloc_cpumask_var(cpumask_var_t *mask, gfp_t flags)
 {
 	cpumask_clear(*mask);
 	return true;
 }
 
-static inline bool zalloc_cpumask_var_node(cpumask_var_t *mask, gfp_t flags,
+static __always_inline bool zalloc_cpumask_var_node(cpumask_var_t *mask, gfp_t flags,
 					  int node)
 {
 	cpumask_clear(*mask);
 	return true;
 }
 
-static inline void alloc_bootmem_cpumask_var(cpumask_var_t *mask)
+static __always_inline void alloc_bootmem_cpumask_var(cpumask_var_t *mask)
 {
 }
 
-static inline void free_cpumask_var(cpumask_var_t mask)
+static __always_inline void free_cpumask_var(cpumask_var_t mask)
 {
 }
 
-static inline void free_bootmem_cpumask_var(cpumask_var_t mask)
+static __always_inline void free_bootmem_cpumask_var(cpumask_var_t mask)
 {
 }
 
-static inline bool cpumask_available(cpumask_var_t mask)
+static __always_inline bool cpumask_available(cpumask_var_t mask)
 {
 	return true;
 }
@@ -1083,7 +1095,7 @@ void init_cpu_present(const struct cpumask *src);
 void init_cpu_possible(const struct cpumask *src);
 void init_cpu_online(const struct cpumask *src);
 
-static inline void
+static __always_inline void
 set_cpu_possible(unsigned int cpu, bool possible)
 {
 	if (possible)
@@ -1092,7 +1104,7 @@ set_cpu_possible(unsigned int cpu, bool possible)
 		cpumask_clear_cpu(cpu, &__cpu_possible_mask);
 }
 
-static inline void
+static __always_inline void
 set_cpu_present(unsigned int cpu, bool present)
 {
 	if (present)
@@ -1103,7 +1115,7 @@ set_cpu_present(unsigned int cpu, bool present)
 
 void set_cpu_online(unsigned int cpu, bool online);
 
-static inline void
+static __always_inline void
 set_cpu_active(unsigned int cpu, bool active)
 {
 	if (active)
@@ -1112,7 +1124,7 @@ set_cpu_active(unsigned int cpu, bool active)
 		cpumask_clear_cpu(cpu, &__cpu_active_mask);
 }
 
-static inline void
+static __always_inline void
 set_cpu_dying(unsigned int cpu, bool dying)
 {
 	if (dying)
@@ -1135,7 +1147,7 @@ set_cpu_dying(unsigned int cpu, bool dying)
 	((struct cpumask *)(1 ? (bitmap)				\
 			    : (void *)sizeof(__check_is_bitmap(bitmap))))
 
-static inline int __check_is_bitmap(const unsigned long *bitmap)
+static __always_inline int __check_is_bitmap(const unsigned long *bitmap)
 {
 	return 1;
 }
@@ -1150,7 +1162,7 @@ static inline int __check_is_bitmap(const unsigned long *bitmap)
 extern const unsigned long
 	cpu_bit_bitmap[BITS_PER_LONG+1][BITS_TO_LONGS(NR_CPUS)];
 
-static inline const struct cpumask *get_cpu_mask(unsigned int cpu)
+static __always_inline const struct cpumask *get_cpu_mask(unsigned int cpu)
 {
 	const unsigned long *p = cpu_bit_bitmap[1 + cpu % BITS_PER_LONG];
 	p -= cpu / BITS_PER_LONG;
@@ -1176,27 +1188,27 @@ static __always_inline unsigned int num_online_cpus(void)
 #define num_present_cpus()	cpumask_weight(cpu_present_mask)
 #define num_active_cpus()	cpumask_weight(cpu_active_mask)
 
-static inline bool cpu_online(unsigned int cpu)
+static __always_inline bool cpu_online(unsigned int cpu)
 {
 	return cpumask_test_cpu(cpu, cpu_online_mask);
 }
 
-static inline bool cpu_possible(unsigned int cpu)
+static __always_inline bool cpu_possible(unsigned int cpu)
 {
 	return cpumask_test_cpu(cpu, cpu_possible_mask);
 }
 
-static inline bool cpu_present(unsigned int cpu)
+static __always_inline bool cpu_present(unsigned int cpu)
 {
 	return cpumask_test_cpu(cpu, cpu_present_mask);
 }
 
-static inline bool cpu_active(unsigned int cpu)
+static __always_inline bool cpu_active(unsigned int cpu)
 {
 	return cpumask_test_cpu(cpu, cpu_active_mask);
 }
 
-static inline bool cpu_dying(unsigned int cpu)
+static __always_inline bool cpu_dying(unsigned int cpu)
 {
 	return cpumask_test_cpu(cpu, cpu_dying_mask);
 }
@@ -1208,27 +1220,27 @@ static inline bool cpu_dying(unsigned int cpu)
 #define num_present_cpus()	1U
 #define num_active_cpus()	1U
 
-static inline bool cpu_online(unsigned int cpu)
+static __always_inline bool cpu_online(unsigned int cpu)
 {
 	return cpu == 0;
 }
 
-static inline bool cpu_possible(unsigned int cpu)
+static __always_inline bool cpu_possible(unsigned int cpu)
 {
 	return cpu == 0;
 }
 
-static inline bool cpu_present(unsigned int cpu)
+static __always_inline bool cpu_present(unsigned int cpu)
 {
 	return cpu == 0;
 }
 
-static inline bool cpu_active(unsigned int cpu)
+static __always_inline bool cpu_active(unsigned int cpu)
 {
 	return cpu == 0;
 }
 
-static inline bool cpu_dying(unsigned int cpu)
+static __always_inline bool cpu_dying(unsigned int cpu)
 {
 	return false;
 }
@@ -1262,7 +1274,7 @@ static inline bool cpu_dying(unsigned int cpu)
  * Return: the length of the (null-terminated) @buf string, zero if
  * nothing is copied.
  */
-static inline ssize_t
+static __always_inline ssize_t
 cpumap_print_to_pagebuf(bool list, char *buf, const struct cpumask *mask)
 {
 	return bitmap_print_to_pagebuf(list, buf, cpumask_bits(mask),
@@ -1285,9 +1297,9 @@ cpumap_print_to_pagebuf(bool list, char *buf, const struct cpumask *mask)
  * Return: the length of how many bytes have been copied, excluding
  * terminating '\0'.
  */
-static inline ssize_t
-cpumap_print_bitmask_to_buf(char *buf, const struct cpumask *mask,
-		loff_t off, size_t count)
+static __always_inline
+ssize_t cpumap_print_bitmask_to_buf(char *buf, const struct cpumask *mask,
+				    loff_t off, size_t count)
 {
 	return bitmap_print_bitmask_to_buf(buf, cpumask_bits(mask),
 				   nr_cpu_ids, off, count) - 1;
@@ -1307,9 +1319,9 @@ cpumap_print_bitmask_to_buf(char *buf, const struct cpumask *mask,
  * Return: the length of how many bytes have been copied, excluding
  * terminating '\0'.
  */
-static inline ssize_t
-cpumap_print_list_to_buf(char *buf, const struct cpumask *mask,
-		loff_t off, size_t count)
+static __always_inline
+ssize_t cpumap_print_list_to_buf(char *buf, const struct cpumask *mask,
+				 loff_t off, size_t count)
 {
 	return bitmap_print_list_to_buf(buf, cpumask_bits(mask),
 				   nr_cpu_ids, off, count) - 1;
-- 
2.45.2.1089.g2a221341d9-goog


