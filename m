Return-Path: <linux-kernel+bounces-179156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8828C5C78
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 22:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2396282ABA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 20:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F77D1E501;
	Tue, 14 May 2024 20:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lAA1e1AV"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67ECD1DFD1
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 20:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715719759; cv=none; b=YzUBPQGQG0vx71Ln1y+KU5RaRB2HFXn1p51Acbgsd4HKnhfO+ANfpCsFK6tOyei/xLYJb1+VjOkGqXK3qjuRXUk1HOdOiV5ds58uGmStdGy8mQtz1zqAPf8OwQOSiETGo/8Ypq1gVbtLoeVEIjTCe0Rcqfl3Q6WJdVTOu2nmYPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715719759; c=relaxed/simple;
	bh=S9vXhIkda9AGLnzalwy+UbNJko5OG/PyEa5VPyuiijI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hPa1LhO5H3Ftkh1PY5wX6KPd8mGiLDQZiKW7egnC+nFf8L3UcSXzYyBR2e0CKmCoHIyHsvy7hiclgI7dRa9s0odEr5ECWT7hBsebDkFwcU5th7ZW33g8cXsGs+ZE1bfiG9QcgKP8Yqww3jSLjVgGieEmKzL8DDhzpezfVqp1wwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lAA1e1AV; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5f415fd71f8so4706893a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 13:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715719757; x=1716324557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bs7yaGwdkkmTKwX9dFxeJrKWagBYlWarsqwGWf69vgQ=;
        b=lAA1e1AVs7XK1Koc/oMratRaVwzjWS2YFIW0z0KhlT+YoiSibZlwLryFpBYTXz0efB
         4J65EUL/wkEgYuvZlrZ+nuKMxIAahSrFr5lnRsQp3oKG0xtHT1H3RI7uVyAFZhU44hkD
         d0tTieMYABXbPGZH74A+N9MI7dLwQXlUnQGPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715719757; x=1716324557;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bs7yaGwdkkmTKwX9dFxeJrKWagBYlWarsqwGWf69vgQ=;
        b=UGDjNYt3T5wRMGe5nJTh35NmKQpdReqcyhwmmL+aw+enWg/Hvo2SD/oOnV/nmmvjKG
         GK5CwUJXwPmmTabYNfQodheZV9OktL0aWTylJM4IvMR+My6aL5BCJB+dfR3V/qo3uikP
         8RXg7zNVoNZ3UK802oUUoVVyFm6b+pg+Xy7JzQ/bU2gN4PVcVQwWs26Dn71qYuCYmTbw
         RCqBmCSPBEenQLtvcrXatDHZxZ1SyGwBDEHJ0x2ipsiRFlW0nUTOHfkAkJrNLdLhopxp
         mqLUyxEHmBZ7Dnp1gDANfJ9jipn+3E/sTybjfSNfWGP8vm8K55ubRaCGjAC/CkZPluOO
         wq5w==
X-Forwarded-Encrypted: i=1; AJvYcCU1TEeNuDOXaVGCWtewV+FnqmJcuk4J8BIVbx3+LruFdVzyVJZU40EPLKW+dr8n/AiUVscz6L1sNi0Fqa4BtfMXZyyKxD/pd9zQPjST
X-Gm-Message-State: AOJu0Yy4mmibTZQ4wBAxTizJv+aaeu6BFQGoKXRuzyp5DtOcjDUXUBa4
	MxpSYpwC2sPWg53dtY1XOshrBfjDk8i0zGSRPupZAyuQ4Glxj6A1xM9kjQaBRw==
X-Google-Smtp-Source: AGHT+IHlJwzDSMv9s8pNcnYtlpRlZK7KxOJf010Xq83oFUJyEhkshbWQwMIOZrKOw9UUqD04rDrcrA==
X-Received: by 2002:a05:6a21:3a94:b0:1b0:1a80:4115 with SMTP id adf61e73a8af0-1b01a805d12mr189314637.61.1715719756499;
        Tue, 14 May 2024 13:49:16 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:5af3:76d2:94d8:9c5c])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-1ef0bf30d2dsm102904155ad.155.2024.05.14.13.49.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 13:49:16 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Justin Stitt <justinstitt@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH] cpumask: Switch from inline to __always_inline
Date: Tue, 14 May 2024 13:49:01 -0700
Message-ID: <20240514204910.1383909-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
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

This change (plus more) has been previously proposed for other reasons
-- that some of the bitmask 'const' machinery doesn't work without
inlining -- in the past as:

  Subject: [PATCH 1/3] bitmap: switch from inline to __always_inline
  https://lore.kernel.org/all/20221027043810.350460-2-yury.norov@gmail.com/

It seems like a good idea to at least make all cpumask functions use
__always_inline; several already do.

According to bloat-o-meter, my ~29MB vmlinux increases by a total of 61
bytes (0.00%) with this change.

[0] CONFIG_HOTPLUG_PARALLEL=y ('select'ed for x86 as of [1]) and
    CONFIG_GCOV_PROFILE_ALL.

[1] commit 0c7ffa32dbd6 ("x86/smpboot/64: Implement
    arch_cpuhp_init_parallel_bringup() and enable it")

Cc: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 include/linux/cpumask.h | 214 +++++++++++++++++++++-------------------
 1 file changed, 113 insertions(+), 101 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 1c29947db848..bcd3e9c1131d 100644
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
@@ -193,7 +193,7 @@ unsigned int cpumask_first_and(const struct cpumask *srcp1, const struct cpumask
  *
  * Return:	>= nr_cpumask_bits if no CPUs set.
  */
-static inline unsigned int cpumask_last(const struct cpumask *srcp)
+static __always_inline unsigned int cpumask_last(const struct cpumask *srcp)
 {
 	return find_last_bit(cpumask_bits(srcp), small_cpumask_bits);
 }
@@ -205,7 +205,7 @@ static inline unsigned int cpumask_last(const struct cpumask *srcp)
  *
  * Return: >= nr_cpu_ids if no further cpus set.
  */
-static inline
+static __always_inline
 unsigned int cpumask_next(int n, const struct cpumask *srcp)
 {
 	/* -1 is a legal arg here. */
@@ -221,7 +221,8 @@ unsigned int cpumask_next(int n, const struct cpumask *srcp)
  *
  * Return: >= nr_cpu_ids if no further cpus unset.
  */
-static inline unsigned int cpumask_next_zero(int n, const struct cpumask *srcp)
+static __always_inline
+unsigned int cpumask_next_zero(int n, const struct cpumask *srcp)
 {
 	/* -1 is a legal arg here. */
 	if (n != -1)
@@ -231,18 +232,21 @@ static inline unsigned int cpumask_next_zero(int n, const struct cpumask *srcp)
 
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
@@ -261,9 +265,9 @@ unsigned int cpumask_any_distribute(const struct cpumask *srcp);
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
@@ -283,7 +287,7 @@ unsigned int cpumask_next_and(int n, const struct cpumask *src1p,
 	for_each_set_bit(cpu, cpumask_bits(mask), small_cpumask_bits)
 
 #if NR_CPUS == 1
-static inline
+static __always_inline
 unsigned int cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool wrap)
 {
 	cpumask_check(start);
@@ -376,7 +380,7 @@ unsigned int __pure cpumask_next_wrap(int n, const struct cpumask *mask, int sta
  * Often used to find any cpu but smp_processor_id() in a mask.
  * Return: >= nr_cpu_ids if no cpus set.
  */
-static inline
+static __always_inline
 unsigned int cpumask_any_but(const struct cpumask *mask, unsigned int cpu)
 {
 	unsigned int i;
@@ -395,7 +399,8 @@ unsigned int cpumask_any_but(const struct cpumask *mask, unsigned int cpu)
  *
  * Return: >= nr_cpu_ids if such cpu doesn't exist.
  */
-static inline unsigned int cpumask_nth(unsigned int cpu, const struct cpumask *srcp)
+static __always_inline
+unsigned int cpumask_nth(unsigned int cpu, const struct cpumask *srcp)
 {
 	return find_nth_bit(cpumask_bits(srcp), small_cpumask_bits, cpumask_check(cpu));
 }
@@ -408,7 +413,7 @@ static inline unsigned int cpumask_nth(unsigned int cpu, const struct cpumask *s
  *
  * Return: >= nr_cpu_ids if such cpu doesn't exist.
  */
-static inline
+static __always_inline
 unsigned int cpumask_nth_and(unsigned int cpu, const struct cpumask *srcp1,
 							const struct cpumask *srcp2)
 {
@@ -424,7 +429,7 @@ unsigned int cpumask_nth_and(unsigned int cpu, const struct cpumask *srcp1,
  *
  * Return: >= nr_cpu_ids if such cpu doesn't exist.
  */
-static inline
+static __always_inline
 unsigned int cpumask_nth_andnot(unsigned int cpu, const struct cpumask *srcp1,
 							const struct cpumask *srcp2)
 {
@@ -467,12 +472,14 @@ unsigned int cpumask_nth_and_andnot(unsigned int cpu, const struct cpumask *srcp
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
@@ -500,7 +507,8 @@ static __always_inline void __cpumask_clear_cpu(int cpu, struct cpumask *dstp)
  *
  * Return: true if @cpu is set in @cpumask, else returns false
  */
-static __always_inline bool cpumask_test_cpu(int cpu, const struct cpumask *cpumask)
+static __always_inline
+bool cpumask_test_cpu(int cpu, const struct cpumask *cpumask)
 {
 	return test_bit(cpumask_check(cpu), cpumask_bits((cpumask)));
 }
@@ -514,7 +522,8 @@ static __always_inline bool cpumask_test_cpu(int cpu, const struct cpumask *cpum
  *
  * Return: true if @cpu is set in old bitmap of @cpumask, else returns false
  */
-static __always_inline bool cpumask_test_and_set_cpu(int cpu, struct cpumask *cpumask)
+static __always_inline
+bool cpumask_test_and_set_cpu(int cpu, struct cpumask *cpumask)
 {
 	return test_and_set_bit(cpumask_check(cpu), cpumask_bits(cpumask));
 }
@@ -528,7 +537,8 @@ static __always_inline bool cpumask_test_and_set_cpu(int cpu, struct cpumask *cp
  *
  * Return: true if @cpu is set in old bitmap of @cpumask, else returns false
  */
-static __always_inline bool cpumask_test_and_clear_cpu(int cpu, struct cpumask *cpumask)
+static __always_inline
+bool cpumask_test_and_clear_cpu(int cpu, struct cpumask *cpumask)
 {
 	return test_and_clear_bit(cpumask_check(cpu), cpumask_bits(cpumask));
 }
@@ -537,7 +547,7 @@ static __always_inline bool cpumask_test_and_clear_cpu(int cpu, struct cpumask *
  * cpumask_setall - set all cpus (< nr_cpu_ids) in a cpumask
  * @dstp: the cpumask pointer
  */
-static inline void cpumask_setall(struct cpumask *dstp)
+static __always_inline void cpumask_setall(struct cpumask *dstp)
 {
 	if (small_const_nbits(small_cpumask_bits)) {
 		cpumask_bits(dstp)[0] = BITMAP_LAST_WORD_MASK(nr_cpumask_bits);
@@ -550,7 +560,7 @@ static inline void cpumask_setall(struct cpumask *dstp)
  * cpumask_clear - clear all cpus (< nr_cpu_ids) in a cpumask
  * @dstp: the cpumask pointer
  */
-static inline void cpumask_clear(struct cpumask *dstp)
+static __always_inline void cpumask_clear(struct cpumask *dstp)
 {
 	bitmap_zero(cpumask_bits(dstp), large_cpumask_bits);
 }
@@ -563,9 +573,9 @@ static inline void cpumask_clear(struct cpumask *dstp)
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
@@ -577,8 +587,9 @@ static inline bool cpumask_and(struct cpumask *dstp,
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
@@ -590,9 +601,9 @@ static inline void cpumask_or(struct cpumask *dstp, const struct cpumask *src1p,
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
@@ -606,9 +617,9 @@ static inline void cpumask_xor(struct cpumask *dstp,
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
@@ -621,8 +632,8 @@ static inline bool cpumask_andnot(struct cpumask *dstp,
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
@@ -637,9 +648,9 @@ static inline bool cpumask_equal(const struct cpumask *src1p,
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
@@ -653,8 +664,8 @@ static inline bool cpumask_or_equal(const struct cpumask *src1p,
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
@@ -667,8 +678,8 @@ static inline bool cpumask_intersects(const struct cpumask *src1p,
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
@@ -680,7 +691,7 @@ static inline bool cpumask_subset(const struct cpumask *src1p,
  *
  * Return: true if srcp is empty (has no bits set), else false
  */
-static inline bool cpumask_empty(const struct cpumask *srcp)
+static __always_inline bool cpumask_empty(const struct cpumask *srcp)
 {
 	return bitmap_empty(cpumask_bits(srcp), small_cpumask_bits);
 }
@@ -691,7 +702,7 @@ static inline bool cpumask_empty(const struct cpumask *srcp)
  *
  * Return: true if srcp is full (has all bits set), else false
  */
-static inline bool cpumask_full(const struct cpumask *srcp)
+static __always_inline bool cpumask_full(const struct cpumask *srcp)
 {
 	return bitmap_full(cpumask_bits(srcp), nr_cpumask_bits);
 }
@@ -702,7 +713,7 @@ static inline bool cpumask_full(const struct cpumask *srcp)
  *
  * Return: count of bits set in *srcp
  */
-static inline unsigned int cpumask_weight(const struct cpumask *srcp)
+static __always_inline unsigned int cpumask_weight(const struct cpumask *srcp)
 {
 	return bitmap_weight(cpumask_bits(srcp), small_cpumask_bits);
 }
@@ -714,8 +725,8 @@ static inline unsigned int cpumask_weight(const struct cpumask *srcp)
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
@@ -727,8 +738,9 @@ static inline unsigned int cpumask_weight_and(const struct cpumask *srcp1,
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
@@ -739,8 +751,8 @@ static inline unsigned int cpumask_weight_andnot(const struct cpumask *srcp1,
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
@@ -752,8 +764,8 @@ static inline void cpumask_shift_right(struct cpumask *dstp,
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
@@ -764,8 +776,8 @@ static inline void cpumask_shift_left(struct cpumask *dstp,
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
@@ -801,8 +813,8 @@ static inline void cpumask_copy(struct cpumask *dstp,
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
@@ -815,8 +827,8 @@ static inline int cpumask_parse_user(const char __user *buf, int len,
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
@@ -829,7 +841,7 @@ static inline int cpumask_parselist_user(const char __user *buf, int len,
  *
  * Return: -errno, or 0 for success.
  */
-static inline int cpumask_parse(const char *buf, struct cpumask *dstp)
+static __always_inline int cpumask_parse(const char *buf, struct cpumask *dstp)
 {
 	return bitmap_parse(buf, UINT_MAX, cpumask_bits(dstp), nr_cpumask_bits);
 }
@@ -841,7 +853,7 @@ static inline int cpumask_parse(const char *buf, struct cpumask *dstp)
  *
  * Return: -errno, or 0 for success.
  */
-static inline int cpulist_parse(const char *buf, struct cpumask *dstp)
+static __always_inline int cpulist_parse(const char *buf, struct cpumask *dstp)
 {
 	return bitmap_parselist(buf, cpumask_bits(dstp), nr_cpumask_bits);
 }
@@ -851,7 +863,7 @@ static inline int cpulist_parse(const char *buf, struct cpumask *dstp)
  *
  * Return: size to allocate for a &struct cpumask in bytes
  */
-static inline unsigned int cpumask_size(void)
+static __always_inline unsigned int cpumask_size(void)
 {
 	return BITS_TO_LONGS(large_cpumask_bits) * sizeof(long);
 }
@@ -904,7 +916,7 @@ typedef struct cpumask *cpumask_var_t;
 
 bool alloc_cpumask_var_node(cpumask_var_t *mask, gfp_t flags, int node);
 
-static inline
+static __always_inline
 bool zalloc_cpumask_var_node(cpumask_var_t *mask, gfp_t flags, int node)
 {
 	return alloc_cpumask_var_node(mask, flags | __GFP_ZERO, node);
@@ -922,13 +934,13 @@ bool zalloc_cpumask_var_node(cpumask_var_t *mask, gfp_t flags, int node)
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
@@ -938,7 +950,7 @@ void alloc_bootmem_cpumask_var(cpumask_var_t *mask);
 void free_cpumask_var(cpumask_var_t mask);
 void free_bootmem_cpumask_var(cpumask_var_t mask);
 
-static inline bool cpumask_available(cpumask_var_t mask)
+static __always_inline bool cpumask_available(cpumask_var_t mask)
 {
 	return mask != NULL;
 }
@@ -949,43 +961,43 @@ typedef struct cpumask cpumask_var_t[1];
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
@@ -1017,12 +1029,12 @@ void init_cpu_present(const struct cpumask *src);
 void init_cpu_possible(const struct cpumask *src);
 void init_cpu_online(const struct cpumask *src);
 
-static inline void reset_cpu_possible_mask(void)
+static __always_inline void reset_cpu_possible_mask(void)
 {
 	bitmap_zero(cpumask_bits(&__cpu_possible_mask), NR_CPUS);
 }
 
-static inline void
+static __always_inline void
 set_cpu_possible(unsigned int cpu, bool possible)
 {
 	if (possible)
@@ -1031,7 +1043,7 @@ set_cpu_possible(unsigned int cpu, bool possible)
 		cpumask_clear_cpu(cpu, &__cpu_possible_mask);
 }
 
-static inline void
+static __always_inline void
 set_cpu_present(unsigned int cpu, bool present)
 {
 	if (present)
@@ -1042,7 +1054,7 @@ set_cpu_present(unsigned int cpu, bool present)
 
 void set_cpu_online(unsigned int cpu, bool online);
 
-static inline void
+static __always_inline void
 set_cpu_active(unsigned int cpu, bool active)
 {
 	if (active)
@@ -1051,7 +1063,7 @@ set_cpu_active(unsigned int cpu, bool active)
 		cpumask_clear_cpu(cpu, &__cpu_active_mask);
 }
 
-static inline void
+static __always_inline void
 set_cpu_dying(unsigned int cpu, bool dying)
 {
 	if (dying)
@@ -1074,7 +1086,7 @@ set_cpu_dying(unsigned int cpu, bool dying)
 	((struct cpumask *)(1 ? (bitmap)				\
 			    : (void *)sizeof(__check_is_bitmap(bitmap))))
 
-static inline int __check_is_bitmap(const unsigned long *bitmap)
+static __always_inline int __check_is_bitmap(const unsigned long *bitmap)
 {
 	return 1;
 }
@@ -1089,7 +1101,7 @@ static inline int __check_is_bitmap(const unsigned long *bitmap)
 extern const unsigned long
 	cpu_bit_bitmap[BITS_PER_LONG+1][BITS_TO_LONGS(NR_CPUS)];
 
-static inline const struct cpumask *get_cpu_mask(unsigned int cpu)
+static __always_inline const struct cpumask *get_cpu_mask(unsigned int cpu)
 {
 	const unsigned long *p = cpu_bit_bitmap[1 + cpu % BITS_PER_LONG];
 	p -= cpu / BITS_PER_LONG;
@@ -1115,27 +1127,27 @@ static __always_inline unsigned int num_online_cpus(void)
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
@@ -1147,27 +1159,27 @@ static inline bool cpu_dying(unsigned int cpu)
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
@@ -1201,7 +1213,7 @@ static inline bool cpu_dying(unsigned int cpu)
  * Return: the length of the (null-terminated) @buf string, zero if
  * nothing is copied.
  */
-static inline ssize_t
+static __always_inline ssize_t
 cpumap_print_to_pagebuf(bool list, char *buf, const struct cpumask *mask)
 {
 	return bitmap_print_to_pagebuf(list, buf, cpumask_bits(mask),
@@ -1224,9 +1236,9 @@ cpumap_print_to_pagebuf(bool list, char *buf, const struct cpumask *mask)
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
@@ -1246,9 +1258,9 @@ cpumap_print_bitmask_to_buf(char *buf, const struct cpumask *mask,
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
2.45.0.rc1.225.g2a3ae87e7f-goog


