Return-Path: <linux-kernel+bounces-249533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42ECC92ECE6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 18:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6055CB211EE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 16:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0109216D334;
	Thu, 11 Jul 2024 16:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E1KLtxmQ"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4881342ABA
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 16:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720715915; cv=none; b=j5HIB+BL+pWz6AqSnyurZ5r6YxoTLSr/ZaHH6XtLnMe65acd7LvC/S55L0O/nZ8S26jdB6nu0TlpV/j+QAMyea/5gyGkqJHgNBsgGDPySv2ELyKOrPCOokW+1p2/s79zUgyquc+pJZ8Id4V7dk+9wwLLTwVtrn+nggN7xKwdDQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720715915; c=relaxed/simple;
	bh=LFTT8OlHgRtEnNPT5/nIhzDgdyCYq/H5F//L+Ka5abE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UQcKKLhNupec4En8t7s4R8ilWzuKITGx7IdUjBKMUWqaHw4+HjUbIxDQlIaJ3TcVp8gBa3jYXqybQbSNDQwNAHNGPJjEdhjEHaMAS7nrVDt/sTQF8PDfGgEml8ZRKd70VEDGq9bujd7Y+ehNfUHpBidBhFn/OAXT7GCwvb3WMYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=E1KLtxmQ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70b2a0542c2so1095494b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 09:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720715911; x=1721320711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/CG30kVnVd5PD7ZGywsoXunzGXkPHbUkVsnwwXlgzBM=;
        b=E1KLtxmQhgSeWoGSolj4o/GRceFzIWLJcHqoGam8PgqEJoFHqV5xdH5ARHtyGFBtep
         XvXXhbuTQRuSRAf/1gUm/zUKhKxH5rlXKbcu/6Herxu0qyUo/EOpYiGnbb/BEX88030o
         fwLIZF1LRmtQJN0TnifEDC91Lftplvs90+Vmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720715911; x=1721320711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/CG30kVnVd5PD7ZGywsoXunzGXkPHbUkVsnwwXlgzBM=;
        b=tcTKkxlZFfYZQsxX2GBd3Bav9jNtLupw+OPJXkvP1xlO6FXvMMs4r9PEemeO026qOL
         uyn0R9oVbNbiCVxa8XDB0AheeqP7Nkf+ctI5vEnid3crEDbSjqVs3Eu6piURnd6m4Gz0
         Uo/nQLeOq1yv4m2OokkB2yj/KB07sZg41imISY5EM96pyDMvUqmQkWbUuk4UzqnP38m3
         ybXyslMs/7OgX39rIvwC+Ydyhl4WReub72PLfXIMIVw4kqyNX79QejFaQz2U18EWNrny
         GRPhmDW6AdGzY/aFwjjSHnt2czds2rHwvOHWMZoyaaqIFz/KKz7VqYGzYMSuIvufHbVV
         Wotg==
X-Forwarded-Encrypted: i=1; AJvYcCV9iHxyl6Y/qhMPBiIJwHx8dai6oEBbhRge0JwCnVNtHk6qXkiyqXcueFNqNvj/62ihWaSpjMP0QpLS8eCjgPrCJm/UU21F7JGpNXXt
X-Gm-Message-State: AOJu0YyxzFZM0Hqm0ejgmFrIwHMCkTDFNeGTnGFSUU8DouSdwdcnVyYX
	EuVUQG89L6fssqiltt0yoqqtX9m+wvc1+t5xCjB0wbavusrP01C/RW7RcmqKtw==
X-Google-Smtp-Source: AGHT+IHmYS5onzaUbiY2IQYao90pk8v9Ny7W1MIUj10zpHDWpUd5dTZ6WK2CjtdFqTrxKXJIlK++8w==
X-Received: by 2002:a05:6a20:cf90:b0:1c0:eb53:1741 with SMTP id adf61e73a8af0-1c2982465c8mr8049915637.27.1720715911224;
        Thu, 11 Jul 2024 09:38:31 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:509:bc0:a72f:4dff])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-70b439e95afsm5864190b3a.210.2024.07.11.09.38.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 09:38:30 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Yury Norov <yury.norov@gmail.com>
Cc: Nathan Chancellor <nathan@kernel.org>,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2] bitmap: Switch from inline to __always_inline
Date: Thu, 11 Jul 2024 09:37:11 -0700
Message-ID: <20240711163732.1837271-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
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

Based on recent discussions, it seems like a good idea to inline the
bitmap functions which make up cpumask*() implementations, as well as a
few other bitmap users, to ensure the inlining doesn't break in the
future and produce the same problems, as well as to give the best chance
that the intended small_const_nbits() optimizations carry through.

This change has been previously proposed in the past as:

  Subject: [PATCH 1/3] bitmap: switch from inline to __always_inline
  https://lore.kernel.org/all/20221027043810.350460-2-yury.norov@gmail.com/

In the end, this looks like a rebase of Yury's work, although
technically it's a rewrite.

According to bloat-o-meter, my vmlinux decreased in size by a total of
1538 bytes (-0.01%) with this change.

[0] CONFIG_HOTPLUG_PARALLEL=y ('select'ed for x86 as of [1]) and
    CONFIG_GCOV_PROFILE_ALL.

[1] commit 0c7ffa32dbd6 ("x86/smpboot/64: Implement
    arch_cpuhp_init_parallel_bringup() and enable it")

Cc: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
 - rebase, update cpumask.h based on recent additions and removals
 - also convert bitmap.h, find.h, nodemask.h

 include/linux/bitmap.h   | 122 ++++++++++++----------
 include/linux/cpumask.h  | 216 +++++++++++++++++++++------------------
 include/linux/find.h     |  50 ++++-----
 include/linux/nodemask.h |  86 ++++++++--------
 4 files changed, 249 insertions(+), 225 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 8c4768c44a01..7f44b4428d77 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -203,7 +203,7 @@ unsigned long bitmap_find_next_zero_area_off(unsigned long *map,
  * the bit offset of all zero areas this function finds is multiples of that
  * power of 2. A @align_mask of 0 means no alignment is required.
  */
-static inline unsigned long
+static __always_inline unsigned long
 bitmap_find_next_zero_area(unsigned long *map,
 			   unsigned long size,
 			   unsigned long start,
@@ -228,7 +228,7 @@ void bitmap_fold(unsigned long *dst, const unsigned long *orig,
 
 #define bitmap_size(nbits)	(ALIGN(nbits, BITS_PER_LONG) / BITS_PER_BYTE)
 
-static inline void bitmap_zero(unsigned long *dst, unsigned int nbits)
+static __always_inline void bitmap_zero(unsigned long *dst, unsigned int nbits)
 {
 	unsigned int len = bitmap_size(nbits);
 
@@ -238,7 +238,7 @@ static inline void bitmap_zero(unsigned long *dst, unsigned int nbits)
 		memset(dst, 0, len);
 }
 
-static inline void bitmap_fill(unsigned long *dst, unsigned int nbits)
+static __always_inline void bitmap_fill(unsigned long *dst, unsigned int nbits)
 {
 	unsigned int len = bitmap_size(nbits);
 
@@ -248,8 +248,8 @@ static inline void bitmap_fill(unsigned long *dst, unsigned int nbits)
 		memset(dst, 0xff, len);
 }
 
-static inline void bitmap_copy(unsigned long *dst, const unsigned long *src,
-			unsigned int nbits)
+static __always_inline void
+bitmap_copy(unsigned long *dst, const unsigned long *src, unsigned int nbits)
 {
 	unsigned int len = bitmap_size(nbits);
 
@@ -262,8 +262,8 @@ static inline void bitmap_copy(unsigned long *dst, const unsigned long *src,
 /*
  * Copy bitmap and clear tail bits in last word.
  */
-static inline void bitmap_copy_clear_tail(unsigned long *dst,
-		const unsigned long *src, unsigned int nbits)
+static __always_inline void
+bitmap_copy_clear_tail(unsigned long *dst, const unsigned long *src, unsigned int nbits)
 {
 	bitmap_copy(dst, src, nbits);
 	if (nbits % BITS_PER_LONG)
@@ -306,16 +306,18 @@ void bitmap_to_arr64(u64 *buf, const unsigned long *bitmap, unsigned int nbits);
 	bitmap_copy_clear_tail((unsigned long *)(buf), (const unsigned long *)(bitmap), (nbits))
 #endif
 
-static inline bool bitmap_and(unsigned long *dst, const unsigned long *src1,
-			const unsigned long *src2, unsigned int nbits)
+static __always_inline bool
+bitmap_and(unsigned long *dst, const unsigned long *src1,
+	   const unsigned long *src2, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
 		return (*dst = *src1 & *src2 & BITMAP_LAST_WORD_MASK(nbits)) != 0;
 	return __bitmap_and(dst, src1, src2, nbits);
 }
 
-static inline void bitmap_or(unsigned long *dst, const unsigned long *src1,
-			const unsigned long *src2, unsigned int nbits)
+static __always_inline void
+bitmap_or(unsigned long *dst, const unsigned long *src1,
+	  const unsigned long *src2, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
 		*dst = *src1 | *src2;
@@ -323,8 +325,9 @@ static inline void bitmap_or(unsigned long *dst, const unsigned long *src1,
 		__bitmap_or(dst, src1, src2, nbits);
 }
 
-static inline void bitmap_xor(unsigned long *dst, const unsigned long *src1,
-			const unsigned long *src2, unsigned int nbits)
+static __always_inline void
+bitmap_xor(unsigned long *dst, const unsigned long *src1,
+	   const unsigned long *src2, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
 		*dst = *src1 ^ *src2;
@@ -332,16 +335,17 @@ static inline void bitmap_xor(unsigned long *dst, const unsigned long *src1,
 		__bitmap_xor(dst, src1, src2, nbits);
 }
 
-static inline bool bitmap_andnot(unsigned long *dst, const unsigned long *src1,
-			const unsigned long *src2, unsigned int nbits)
+static __always_inline bool
+bitmap_andnot(unsigned long *dst, const unsigned long *src1,
+	      const unsigned long *src2, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
 		return (*dst = *src1 & ~(*src2) & BITMAP_LAST_WORD_MASK(nbits)) != 0;
 	return __bitmap_andnot(dst, src1, src2, nbits);
 }
 
-static inline void bitmap_complement(unsigned long *dst, const unsigned long *src,
-			unsigned int nbits)
+static __always_inline void
+bitmap_complement(unsigned long *dst, const unsigned long *src, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
 		*dst = ~(*src);
@@ -356,8 +360,8 @@ static inline void bitmap_complement(unsigned long *dst, const unsigned long *sr
 #endif
 #define BITMAP_MEM_MASK (BITMAP_MEM_ALIGNMENT - 1)
 
-static inline bool bitmap_equal(const unsigned long *src1,
-				const unsigned long *src2, unsigned int nbits)
+static __always_inline bool
+bitmap_equal(const unsigned long *src1, const unsigned long *src2, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
 		return !((*src1 ^ *src2) & BITMAP_LAST_WORD_MASK(nbits));
@@ -376,10 +380,9 @@ static inline bool bitmap_equal(const unsigned long *src1,
  *
  * Returns: True if (*@src1 | *@src2) == *@src3, false otherwise
  */
-static inline bool bitmap_or_equal(const unsigned long *src1,
-				   const unsigned long *src2,
-				   const unsigned long *src3,
-				   unsigned int nbits)
+static __always_inline bool
+bitmap_or_equal(const unsigned long *src1, const unsigned long *src2,
+		const unsigned long *src3, unsigned int nbits)
 {
 	if (!small_const_nbits(nbits))
 		return __bitmap_or_equal(src1, src2, src3, nbits);
@@ -387,9 +390,8 @@ static inline bool bitmap_or_equal(const unsigned long *src1,
 	return !(((*src1 | *src2) ^ *src3) & BITMAP_LAST_WORD_MASK(nbits));
 }
 
-static inline bool bitmap_intersects(const unsigned long *src1,
-				     const unsigned long *src2,
-				     unsigned int nbits)
+static __always_inline bool
+bitmap_intersects(const unsigned long *src1, const unsigned long *src2, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
 		return ((*src1 & *src2) & BITMAP_LAST_WORD_MASK(nbits)) != 0;
@@ -397,8 +399,8 @@ static inline bool bitmap_intersects(const unsigned long *src1,
 		return __bitmap_intersects(src1, src2, nbits);
 }
 
-static inline bool bitmap_subset(const unsigned long *src1,
-				 const unsigned long *src2, unsigned int nbits)
+static __always_inline bool
+bitmap_subset(const unsigned long *src1, const unsigned long *src2, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
 		return ! ((*src1 & ~(*src2)) & BITMAP_LAST_WORD_MASK(nbits));
@@ -406,7 +408,8 @@ static inline bool bitmap_subset(const unsigned long *src1,
 		return __bitmap_subset(src1, src2, nbits);
 }
 
-static inline bool bitmap_empty(const unsigned long *src, unsigned nbits)
+static __always_inline bool
+bitmap_empty(const unsigned long *src, unsigned nbits)
 {
 	if (small_const_nbits(nbits))
 		return ! (*src & BITMAP_LAST_WORD_MASK(nbits));
@@ -414,7 +417,8 @@ static inline bool bitmap_empty(const unsigned long *src, unsigned nbits)
 	return find_first_bit(src, nbits) == nbits;
 }
 
-static inline bool bitmap_full(const unsigned long *src, unsigned int nbits)
+static __always_inline bool
+bitmap_full(const unsigned long *src, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
 		return ! (~(*src) & BITMAP_LAST_WORD_MASK(nbits));
@@ -480,8 +484,9 @@ static __always_inline void bitmap_clear(unsigned long *map, unsigned int start,
 		__bitmap_clear(map, start, nbits);
 }
 
-static inline void bitmap_shift_right(unsigned long *dst, const unsigned long *src,
-				unsigned int shift, unsigned int nbits)
+static __always_inline void
+bitmap_shift_right(unsigned long *dst, const unsigned long *src,
+		   unsigned int shift, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
 		*dst = (*src & BITMAP_LAST_WORD_MASK(nbits)) >> shift;
@@ -489,8 +494,9 @@ static inline void bitmap_shift_right(unsigned long *dst, const unsigned long *s
 		__bitmap_shift_right(dst, src, shift, nbits);
 }
 
-static inline void bitmap_shift_left(unsigned long *dst, const unsigned long *src,
-				unsigned int shift, unsigned int nbits)
+static __always_inline void
+bitmap_shift_left(unsigned long *dst, const unsigned long *src,
+		  unsigned int shift, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
 		*dst = (*src << shift) & BITMAP_LAST_WORD_MASK(nbits);
@@ -498,11 +504,12 @@ static inline void bitmap_shift_left(unsigned long *dst, const unsigned long *sr
 		__bitmap_shift_left(dst, src, shift, nbits);
 }
 
-static inline void bitmap_replace(unsigned long *dst,
-				  const unsigned long *old,
-				  const unsigned long *new,
-				  const unsigned long *mask,
-				  unsigned int nbits)
+static __always_inline void
+bitmap_replace(unsigned long *dst,
+	       const unsigned long *old,
+	       const unsigned long *new,
+	       const unsigned long *mask,
+	       unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
 		*dst = (*old & ~(*mask)) | (*new & *mask);
@@ -545,8 +552,9 @@ static inline void bitmap_replace(unsigned long *dst,
  * bitmap_gather() can be seen as the 'reverse' bitmap_scatter() operation.
  * See bitmap_scatter() for details related to this relationship.
  */
-static inline void bitmap_scatter(unsigned long *dst, const unsigned long *src,
-				  const unsigned long *mask, unsigned int nbits)
+static __always_inline void
+bitmap_scatter(unsigned long *dst, const unsigned long *src,
+	       const unsigned long *mask, unsigned int nbits)
 {
 	unsigned int n = 0;
 	unsigned int bit;
@@ -599,8 +607,9 @@ static inline void bitmap_scatter(unsigned long *dst, const unsigned long *src,
  * bitmap_scatter(res, src, mask, n) and a call to
  * bitmap_scatter(res, result, mask, n) will lead to the same res value.
  */
-static inline void bitmap_gather(unsigned long *dst, const unsigned long *src,
-				 const unsigned long *mask, unsigned int nbits)
+static __always_inline void
+bitmap_gather(unsigned long *dst, const unsigned long *src,
+	      const unsigned long *mask, unsigned int nbits)
 {
 	unsigned int n = 0;
 	unsigned int bit;
@@ -611,9 +620,9 @@ static inline void bitmap_gather(unsigned long *dst, const unsigned long *src,
 		__assign_bit(n++, dst, test_bit(bit, src));
 }
 
-static inline void bitmap_next_set_region(unsigned long *bitmap,
-					  unsigned int *rs, unsigned int *re,
-					  unsigned int end)
+static __always_inline void
+bitmap_next_set_region(unsigned long *bitmap, unsigned int *rs,
+		       unsigned int *re, unsigned int end)
 {
 	*rs = find_next_bit(bitmap, end, *rs);
 	*re = find_next_zero_bit(bitmap, end, *rs + 1);
@@ -628,7 +637,8 @@ static inline void bitmap_next_set_region(unsigned long *bitmap,
  * This is the complement to __bitmap_find_free_region() and releases
  * the found region (by clearing it in the bitmap).
  */
-static inline void bitmap_release_region(unsigned long *bitmap, unsigned int pos, int order)
+static __always_inline void
+bitmap_release_region(unsigned long *bitmap, unsigned int pos, int order)
 {
 	bitmap_clear(bitmap, pos, BIT(order));
 }
@@ -644,7 +654,8 @@ static inline void bitmap_release_region(unsigned long *bitmap, unsigned int pos
  * Returns: 0 on success, or %-EBUSY if specified region wasn't
  * free (not all bits were zero).
  */
-static inline int bitmap_allocate_region(unsigned long *bitmap, unsigned int pos, int order)
+static __always_inline int
+bitmap_allocate_region(unsigned long *bitmap, unsigned int pos, int order)
 {
 	unsigned int len = BIT(order);
 
@@ -668,7 +679,8 @@ static inline int bitmap_allocate_region(unsigned long *bitmap, unsigned int pos
  * Returns: the bit offset in bitmap of the allocated region,
  * or -errno on failure.
  */
-static inline int bitmap_find_free_region(unsigned long *bitmap, unsigned int bits, int order)
+static __always_inline int
+bitmap_find_free_region(unsigned long *bitmap, unsigned int bits, int order)
 {
 	unsigned int pos, end;		/* scans bitmap by regions of size order */
 
@@ -722,7 +734,7 @@ static inline int bitmap_find_free_region(unsigned long *bitmap, unsigned int bi
  * That is ``(u32 *)(&val)[0]`` gets the upper 32 bits,
  * but we expect the lower 32-bits of u64.
  */
-static inline void bitmap_from_u64(unsigned long *dst, u64 mask)
+static __always_inline void bitmap_from_u64(unsigned long *dst, u64 mask)
 {
 	bitmap_from_arr64(dst, &mask, 64);
 }
@@ -737,9 +749,8 @@ static inline void bitmap_from_u64(unsigned long *dst, u64 mask)
  * @map memory region. For @nbits = 0 and @nbits > BITS_PER_LONG the return
  * value is undefined.
  */
-static inline unsigned long bitmap_read(const unsigned long *map,
-					unsigned long start,
-					unsigned long nbits)
+static __always_inline unsigned long
+bitmap_read(const unsigned long *map, unsigned long start, unsigned long nbits)
 {
 	size_t index = BIT_WORD(start);
 	unsigned long offset = start % BITS_PER_LONG;
@@ -772,8 +783,9 @@ static inline unsigned long bitmap_read(const unsigned long *map,
  *
  * For @nbits == 0 and @nbits > BITS_PER_LONG no writes are performed.
  */
-static inline void bitmap_write(unsigned long *map, unsigned long value,
-				unsigned long start, unsigned long nbits)
+static __always_inline void
+bitmap_write(unsigned long *map, unsigned long value,
+	     unsigned long start, unsigned long nbits)
 {
 	size_t index;
 	unsigned long offset;
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
diff --git a/include/linux/find.h b/include/linux/find.h
index 5dfca4225fef..516f0ba19564 100644
--- a/include/linux/find.h
+++ b/include/linux/find.h
@@ -52,7 +52,7 @@ unsigned long _find_next_bit_le(const unsigned long *addr, unsigned
  * Returns the bit number for the next set bit
  * If no bits are set, returns @size.
  */
-static inline
+static __always_inline
 unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
 			    unsigned long offset)
 {
@@ -81,7 +81,7 @@ unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
  * Returns the bit number for the next set bit
  * If no bits are set, returns @size.
  */
-static inline
+static __always_inline
 unsigned long find_next_and_bit(const unsigned long *addr1,
 		const unsigned long *addr2, unsigned long size,
 		unsigned long offset)
@@ -112,7 +112,7 @@ unsigned long find_next_and_bit(const unsigned long *addr1,
  * Returns the bit number for the next set bit
  * If no bits are set, returns @size.
  */
-static inline
+static __always_inline
 unsigned long find_next_andnot_bit(const unsigned long *addr1,
 		const unsigned long *addr2, unsigned long size,
 		unsigned long offset)
@@ -142,7 +142,7 @@ unsigned long find_next_andnot_bit(const unsigned long *addr1,
  * Returns the bit number for the next set bit
  * If no bits are set, returns @size.
  */
-static inline
+static __always_inline
 unsigned long find_next_or_bit(const unsigned long *addr1,
 		const unsigned long *addr2, unsigned long size,
 		unsigned long offset)
@@ -171,7 +171,7 @@ unsigned long find_next_or_bit(const unsigned long *addr1,
  * Returns the bit number of the next zero bit
  * If no bits are zero, returns @size.
  */
-static inline
+static __always_inline
 unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
 				 unsigned long offset)
 {
@@ -198,7 +198,7 @@ unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
  * Returns the bit number of the first set bit.
  * If no bits are set, returns @size.
  */
-static inline
+static __always_inline
 unsigned long find_first_bit(const unsigned long *addr, unsigned long size)
 {
 	if (small_const_nbits(size)) {
@@ -224,7 +224,7 @@ unsigned long find_first_bit(const unsigned long *addr, unsigned long size)
  * Returns the bit number of the N'th set bit.
  * If no such, returns >= @size.
  */
-static inline
+static __always_inline
 unsigned long find_nth_bit(const unsigned long *addr, unsigned long size, unsigned long n)
 {
 	if (n >= size)
@@ -249,7 +249,7 @@ unsigned long find_nth_bit(const unsigned long *addr, unsigned long size, unsign
  * Returns the bit number of the N'th set bit.
  * If no such, returns @size.
  */
-static inline
+static __always_inline
 unsigned long find_nth_and_bit(const unsigned long *addr1, const unsigned long *addr2,
 				unsigned long size, unsigned long n)
 {
@@ -276,7 +276,7 @@ unsigned long find_nth_and_bit(const unsigned long *addr1, const unsigned long *
  * Returns the bit number of the N'th set bit.
  * If no such, returns @size.
  */
-static inline
+static __always_inline
 unsigned long find_nth_andnot_bit(const unsigned long *addr1, const unsigned long *addr2,
 				unsigned long size, unsigned long n)
 {
@@ -332,7 +332,7 @@ unsigned long find_nth_and_andnot_bit(const unsigned long *addr1,
  * Returns the bit number for the next set bit
  * If no bits are set, returns @size.
  */
-static inline
+static __always_inline
 unsigned long find_first_and_bit(const unsigned long *addr1,
 				 const unsigned long *addr2,
 				 unsigned long size)
@@ -357,7 +357,7 @@ unsigned long find_first_and_bit(const unsigned long *addr1,
  * Returns the bit number for the first set bit
  * If no bits are set, returns @size.
  */
-static inline
+static __always_inline
 unsigned long find_first_and_and_bit(const unsigned long *addr1,
 				     const unsigned long *addr2,
 				     const unsigned long *addr3,
@@ -381,7 +381,7 @@ unsigned long find_first_and_and_bit(const unsigned long *addr1,
  * Returns the bit number of the first cleared bit.
  * If no bits are zero, returns @size.
  */
-static inline
+static __always_inline
 unsigned long find_first_zero_bit(const unsigned long *addr, unsigned long size)
 {
 	if (small_const_nbits(size)) {
@@ -402,7 +402,7 @@ unsigned long find_first_zero_bit(const unsigned long *addr, unsigned long size)
  *
  * Returns the bit number of the last set bit, or size.
  */
-static inline
+static __always_inline
 unsigned long find_last_bit(const unsigned long *addr, unsigned long size)
 {
 	if (small_const_nbits(size)) {
@@ -425,7 +425,7 @@ unsigned long find_last_bit(const unsigned long *addr, unsigned long size)
  * Returns the bit number for the next set bit, or first set bit up to @offset
  * If no bits are set, returns @size.
  */
-static inline
+static __always_inline
 unsigned long find_next_and_bit_wrap(const unsigned long *addr1,
 					const unsigned long *addr2,
 					unsigned long size, unsigned long offset)
@@ -448,7 +448,7 @@ unsigned long find_next_and_bit_wrap(const unsigned long *addr1,
  * Returns the bit number for the next set bit, or first set bit up to @offset
  * If no bits are set, returns @size.
  */
-static inline
+static __always_inline
 unsigned long find_next_bit_wrap(const unsigned long *addr,
 					unsigned long size, unsigned long offset)
 {
@@ -465,7 +465,7 @@ unsigned long find_next_bit_wrap(const unsigned long *addr,
  * Helper for for_each_set_bit_wrap(). Make sure you're doing right thing
  * before using it alone.
  */
-static inline
+static __always_inline
 unsigned long __for_each_wrap(const unsigned long *bitmap, unsigned long size,
 				 unsigned long start, unsigned long n)
 {
@@ -506,20 +506,20 @@ extern unsigned long find_next_clump8(unsigned long *clump,
 
 #if defined(__LITTLE_ENDIAN)
 
-static inline unsigned long find_next_zero_bit_le(const void *addr,
-		unsigned long size, unsigned long offset)
+static __always_inline unsigned long
+find_next_zero_bit_le(const void *addr, unsigned long size, unsigned long offset)
 {
 	return find_next_zero_bit(addr, size, offset);
 }
 
-static inline unsigned long find_next_bit_le(const void *addr,
-		unsigned long size, unsigned long offset)
+static __always_inline unsigned long
+find_next_bit_le(const void *addr, unsigned long size, unsigned long offset)
 {
 	return find_next_bit(addr, size, offset);
 }
 
-static inline unsigned long find_first_zero_bit_le(const void *addr,
-		unsigned long size)
+static __always_inline unsigned long
+find_first_zero_bit_le(const void *addr, unsigned long size)
 {
 	return find_first_zero_bit(addr, size);
 }
@@ -527,7 +527,7 @@ static inline unsigned long find_first_zero_bit_le(const void *addr,
 #elif defined(__BIG_ENDIAN)
 
 #ifndef find_next_zero_bit_le
-static inline
+static __always_inline
 unsigned long find_next_zero_bit_le(const void *addr, unsigned
 		long size, unsigned long offset)
 {
@@ -546,7 +546,7 @@ unsigned long find_next_zero_bit_le(const void *addr, unsigned
 #endif
 
 #ifndef find_first_zero_bit_le
-static inline
+static __always_inline
 unsigned long find_first_zero_bit_le(const void *addr, unsigned long size)
 {
 	if (small_const_nbits(size)) {
@@ -560,7 +560,7 @@ unsigned long find_first_zero_bit_le(const void *addr, unsigned long size)
 #endif
 
 #ifndef find_next_bit_le
-static inline
+static __always_inline
 unsigned long find_next_bit_le(const void *addr, unsigned
 		long size, unsigned long offset)
 {
diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
index b61438313a73..9fd7a0ce9c1a 100644
--- a/include/linux/nodemask.h
+++ b/include/linux/nodemask.h
@@ -107,11 +107,11 @@ extern nodemask_t _unused_nodemask_arg_;
  */
 #define nodemask_pr_args(maskp)	__nodemask_pr_numnodes(maskp), \
 				__nodemask_pr_bits(maskp)
-static inline unsigned int __nodemask_pr_numnodes(const nodemask_t *m)
+static __always_inline unsigned int __nodemask_pr_numnodes(const nodemask_t *m)
 {
 	return m ? MAX_NUMNODES : 0;
 }
-static inline const unsigned long *__nodemask_pr_bits(const nodemask_t *m)
+static __always_inline const unsigned long *__nodemask_pr_bits(const nodemask_t *m)
 {
 	return m ? m->bits : NULL;
 }
@@ -132,19 +132,19 @@ static __always_inline void __node_set(int node, volatile nodemask_t *dstp)
 }
 
 #define node_clear(node, dst) __node_clear((node), &(dst))
-static inline void __node_clear(int node, volatile nodemask_t *dstp)
+static __always_inline void __node_clear(int node, volatile nodemask_t *dstp)
 {
 	clear_bit(node, dstp->bits);
 }
 
 #define nodes_setall(dst) __nodes_setall(&(dst), MAX_NUMNODES)
-static inline void __nodes_setall(nodemask_t *dstp, unsigned int nbits)
+static __always_inline void __nodes_setall(nodemask_t *dstp, unsigned int nbits)
 {
 	bitmap_fill(dstp->bits, nbits);
 }
 
 #define nodes_clear(dst) __nodes_clear(&(dst), MAX_NUMNODES)
-static inline void __nodes_clear(nodemask_t *dstp, unsigned int nbits)
+static __always_inline void __nodes_clear(nodemask_t *dstp, unsigned int nbits)
 {
 	bitmap_zero(dstp->bits, nbits);
 }
@@ -154,14 +154,14 @@ static inline void __nodes_clear(nodemask_t *dstp, unsigned int nbits)
 
 #define node_test_and_set(node, nodemask) \
 			__node_test_and_set((node), &(nodemask))
-static inline bool __node_test_and_set(int node, nodemask_t *addr)
+static __always_inline bool __node_test_and_set(int node, nodemask_t *addr)
 {
 	return test_and_set_bit(node, addr->bits);
 }
 
 #define nodes_and(dst, src1, src2) \
 			__nodes_and(&(dst), &(src1), &(src2), MAX_NUMNODES)
-static inline void __nodes_and(nodemask_t *dstp, const nodemask_t *src1p,
+static __always_inline void __nodes_and(nodemask_t *dstp, const nodemask_t *src1p,
 					const nodemask_t *src2p, unsigned int nbits)
 {
 	bitmap_and(dstp->bits, src1p->bits, src2p->bits, nbits);
@@ -169,7 +169,7 @@ static inline void __nodes_and(nodemask_t *dstp, const nodemask_t *src1p,
 
 #define nodes_or(dst, src1, src2) \
 			__nodes_or(&(dst), &(src1), &(src2), MAX_NUMNODES)
-static inline void __nodes_or(nodemask_t *dstp, const nodemask_t *src1p,
+static __always_inline void __nodes_or(nodemask_t *dstp, const nodemask_t *src1p,
 					const nodemask_t *src2p, unsigned int nbits)
 {
 	bitmap_or(dstp->bits, src1p->bits, src2p->bits, nbits);
@@ -177,7 +177,7 @@ static inline void __nodes_or(nodemask_t *dstp, const nodemask_t *src1p,
 
 #define nodes_xor(dst, src1, src2) \
 			__nodes_xor(&(dst), &(src1), &(src2), MAX_NUMNODES)
-static inline void __nodes_xor(nodemask_t *dstp, const nodemask_t *src1p,
+static __always_inline void __nodes_xor(nodemask_t *dstp, const nodemask_t *src1p,
 					const nodemask_t *src2p, unsigned int nbits)
 {
 	bitmap_xor(dstp->bits, src1p->bits, src2p->bits, nbits);
@@ -185,7 +185,7 @@ static inline void __nodes_xor(nodemask_t *dstp, const nodemask_t *src1p,
 
 #define nodes_andnot(dst, src1, src2) \
 			__nodes_andnot(&(dst), &(src1), &(src2), MAX_NUMNODES)
-static inline void __nodes_andnot(nodemask_t *dstp, const nodemask_t *src1p,
+static __always_inline void __nodes_andnot(nodemask_t *dstp, const nodemask_t *src1p,
 					const nodemask_t *src2p, unsigned int nbits)
 {
 	bitmap_andnot(dstp->bits, src1p->bits, src2p->bits, nbits);
@@ -193,7 +193,7 @@ static inline void __nodes_andnot(nodemask_t *dstp, const nodemask_t *src1p,
 
 #define nodes_complement(dst, src) \
 			__nodes_complement(&(dst), &(src), MAX_NUMNODES)
-static inline void __nodes_complement(nodemask_t *dstp,
+static __always_inline void __nodes_complement(nodemask_t *dstp,
 					const nodemask_t *srcp, unsigned int nbits)
 {
 	bitmap_complement(dstp->bits, srcp->bits, nbits);
@@ -201,7 +201,7 @@ static inline void __nodes_complement(nodemask_t *dstp,
 
 #define nodes_equal(src1, src2) \
 			__nodes_equal(&(src1), &(src2), MAX_NUMNODES)
-static inline bool __nodes_equal(const nodemask_t *src1p,
+static __always_inline bool __nodes_equal(const nodemask_t *src1p,
 					const nodemask_t *src2p, unsigned int nbits)
 {
 	return bitmap_equal(src1p->bits, src2p->bits, nbits);
@@ -209,7 +209,7 @@ static inline bool __nodes_equal(const nodemask_t *src1p,
 
 #define nodes_intersects(src1, src2) \
 			__nodes_intersects(&(src1), &(src2), MAX_NUMNODES)
-static inline bool __nodes_intersects(const nodemask_t *src1p,
+static __always_inline bool __nodes_intersects(const nodemask_t *src1p,
 					const nodemask_t *src2p, unsigned int nbits)
 {
 	return bitmap_intersects(src1p->bits, src2p->bits, nbits);
@@ -217,33 +217,33 @@ static inline bool __nodes_intersects(const nodemask_t *src1p,
 
 #define nodes_subset(src1, src2) \
 			__nodes_subset(&(src1), &(src2), MAX_NUMNODES)
-static inline bool __nodes_subset(const nodemask_t *src1p,
+static __always_inline bool __nodes_subset(const nodemask_t *src1p,
 					const nodemask_t *src2p, unsigned int nbits)
 {
 	return bitmap_subset(src1p->bits, src2p->bits, nbits);
 }
 
 #define nodes_empty(src) __nodes_empty(&(src), MAX_NUMNODES)
-static inline bool __nodes_empty(const nodemask_t *srcp, unsigned int nbits)
+static __always_inline bool __nodes_empty(const nodemask_t *srcp, unsigned int nbits)
 {
 	return bitmap_empty(srcp->bits, nbits);
 }
 
 #define nodes_full(nodemask) __nodes_full(&(nodemask), MAX_NUMNODES)
-static inline bool __nodes_full(const nodemask_t *srcp, unsigned int nbits)
+static __always_inline bool __nodes_full(const nodemask_t *srcp, unsigned int nbits)
 {
 	return bitmap_full(srcp->bits, nbits);
 }
 
 #define nodes_weight(nodemask) __nodes_weight(&(nodemask), MAX_NUMNODES)
-static inline int __nodes_weight(const nodemask_t *srcp, unsigned int nbits)
+static __always_inline int __nodes_weight(const nodemask_t *srcp, unsigned int nbits)
 {
 	return bitmap_weight(srcp->bits, nbits);
 }
 
 #define nodes_shift_right(dst, src, n) \
 			__nodes_shift_right(&(dst), &(src), (n), MAX_NUMNODES)
-static inline void __nodes_shift_right(nodemask_t *dstp,
+static __always_inline void __nodes_shift_right(nodemask_t *dstp,
 					const nodemask_t *srcp, int n, int nbits)
 {
 	bitmap_shift_right(dstp->bits, srcp->bits, n, nbits);
@@ -251,7 +251,7 @@ static inline void __nodes_shift_right(nodemask_t *dstp,
 
 #define nodes_shift_left(dst, src, n) \
 			__nodes_shift_left(&(dst), &(src), (n), MAX_NUMNODES)
-static inline void __nodes_shift_left(nodemask_t *dstp,
+static __always_inline void __nodes_shift_left(nodemask_t *dstp,
 					const nodemask_t *srcp, int n, int nbits)
 {
 	bitmap_shift_left(dstp->bits, srcp->bits, n, nbits);
@@ -261,13 +261,13 @@ static inline void __nodes_shift_left(nodemask_t *dstp,
           > MAX_NUMNODES, then the silly min_ts could be dropped. */
 
 #define first_node(src) __first_node(&(src))
-static inline unsigned int __first_node(const nodemask_t *srcp)
+static __always_inline unsigned int __first_node(const nodemask_t *srcp)
 {
 	return min_t(unsigned int, MAX_NUMNODES, find_first_bit(srcp->bits, MAX_NUMNODES));
 }
 
 #define next_node(n, src) __next_node((n), &(src))
-static inline unsigned int __next_node(int n, const nodemask_t *srcp)
+static __always_inline unsigned int __next_node(int n, const nodemask_t *srcp)
 {
 	return min_t(unsigned int, MAX_NUMNODES, find_next_bit(srcp->bits, MAX_NUMNODES, n+1));
 }
@@ -277,7 +277,7 @@ static inline unsigned int __next_node(int n, const nodemask_t *srcp)
  * the first node in src if needed.  Returns MAX_NUMNODES if src is empty.
  */
 #define next_node_in(n, src) __next_node_in((n), &(src))
-static inline unsigned int __next_node_in(int node, const nodemask_t *srcp)
+static __always_inline unsigned int __next_node_in(int node, const nodemask_t *srcp)
 {
 	unsigned int ret = __next_node(node, srcp);
 
@@ -286,7 +286,7 @@ static inline unsigned int __next_node_in(int node, const nodemask_t *srcp)
 	return ret;
 }
 
-static inline void init_nodemask_of_node(nodemask_t *mask, int node)
+static __always_inline void init_nodemask_of_node(nodemask_t *mask, int node)
 {
 	nodes_clear(*mask);
 	node_set(node, *mask);
@@ -304,7 +304,7 @@ static inline void init_nodemask_of_node(nodemask_t *mask, int node)
 })
 
 #define first_unset_node(mask) __first_unset_node(&(mask))
-static inline unsigned int __first_unset_node(const nodemask_t *maskp)
+static __always_inline unsigned int __first_unset_node(const nodemask_t *maskp)
 {
 	return min_t(unsigned int, MAX_NUMNODES,
 			find_first_zero_bit(maskp->bits, MAX_NUMNODES));
@@ -338,21 +338,21 @@ static inline unsigned int __first_unset_node(const nodemask_t *maskp)
 
 #define nodemask_parse_user(ubuf, ulen, dst) \
 		__nodemask_parse_user((ubuf), (ulen), &(dst), MAX_NUMNODES)
-static inline int __nodemask_parse_user(const char __user *buf, int len,
+static __always_inline int __nodemask_parse_user(const char __user *buf, int len,
 					nodemask_t *dstp, int nbits)
 {
 	return bitmap_parse_user(buf, len, dstp->bits, nbits);
 }
 
 #define nodelist_parse(buf, dst) __nodelist_parse((buf), &(dst), MAX_NUMNODES)
-static inline int __nodelist_parse(const char *buf, nodemask_t *dstp, int nbits)
+static __always_inline int __nodelist_parse(const char *buf, nodemask_t *dstp, int nbits)
 {
 	return bitmap_parselist(buf, dstp->bits, nbits);
 }
 
 #define node_remap(oldbit, old, new) \
 		__node_remap((oldbit), &(old), &(new), MAX_NUMNODES)
-static inline int __node_remap(int oldbit,
+static __always_inline int __node_remap(int oldbit,
 		const nodemask_t *oldp, const nodemask_t *newp, int nbits)
 {
 	return bitmap_bitremap(oldbit, oldp->bits, newp->bits, nbits);
@@ -360,7 +360,7 @@ static inline int __node_remap(int oldbit,
 
 #define nodes_remap(dst, src, old, new) \
 		__nodes_remap(&(dst), &(src), &(old), &(new), MAX_NUMNODES)
-static inline void __nodes_remap(nodemask_t *dstp, const nodemask_t *srcp,
+static __always_inline void __nodes_remap(nodemask_t *dstp, const nodemask_t *srcp,
 		const nodemask_t *oldp, const nodemask_t *newp, int nbits)
 {
 	bitmap_remap(dstp->bits, srcp->bits, oldp->bits, newp->bits, nbits);
@@ -368,7 +368,7 @@ static inline void __nodes_remap(nodemask_t *dstp, const nodemask_t *srcp,
 
 #define nodes_onto(dst, orig, relmap) \
 		__nodes_onto(&(dst), &(orig), &(relmap), MAX_NUMNODES)
-static inline void __nodes_onto(nodemask_t *dstp, const nodemask_t *origp,
+static __always_inline void __nodes_onto(nodemask_t *dstp, const nodemask_t *origp,
 		const nodemask_t *relmapp, int nbits)
 {
 	bitmap_onto(dstp->bits, origp->bits, relmapp->bits, nbits);
@@ -376,7 +376,7 @@ static inline void __nodes_onto(nodemask_t *dstp, const nodemask_t *origp,
 
 #define nodes_fold(dst, orig, sz) \
 		__nodes_fold(&(dst), &(orig), sz, MAX_NUMNODES)
-static inline void __nodes_fold(nodemask_t *dstp, const nodemask_t *origp,
+static __always_inline void __nodes_fold(nodemask_t *dstp, const nodemask_t *origp,
 		int sz, int nbits)
 {
 	bitmap_fold(dstp->bits, origp->bits, sz, nbits);
@@ -418,22 +418,22 @@ enum node_states {
 extern nodemask_t node_states[NR_NODE_STATES];
 
 #if MAX_NUMNODES > 1
-static inline int node_state(int node, enum node_states state)
+static __always_inline int node_state(int node, enum node_states state)
 {
 	return node_isset(node, node_states[state]);
 }
 
-static inline void node_set_state(int node, enum node_states state)
+static __always_inline void node_set_state(int node, enum node_states state)
 {
 	__node_set(node, &node_states[state]);
 }
 
-static inline void node_clear_state(int node, enum node_states state)
+static __always_inline void node_clear_state(int node, enum node_states state)
 {
 	__node_clear(node, &node_states[state]);
 }
 
-static inline int num_node_state(enum node_states state)
+static __always_inline int num_node_state(enum node_states state)
 {
 	return nodes_weight(node_states[state]);
 }
@@ -443,11 +443,11 @@ static inline int num_node_state(enum node_states state)
 
 #define first_online_node	first_node(node_states[N_ONLINE])
 #define first_memory_node	first_node(node_states[N_MEMORY])
-static inline unsigned int next_online_node(int nid)
+static __always_inline unsigned int next_online_node(int nid)
 {
 	return next_node(nid, node_states[N_ONLINE]);
 }
-static inline unsigned int next_memory_node(int nid)
+static __always_inline unsigned int next_memory_node(int nid)
 {
 	return next_node(nid, node_states[N_MEMORY]);
 }
@@ -455,13 +455,13 @@ static inline unsigned int next_memory_node(int nid)
 extern unsigned int nr_node_ids;
 extern unsigned int nr_online_nodes;
 
-static inline void node_set_online(int nid)
+static __always_inline void node_set_online(int nid)
 {
 	node_set_state(nid, N_ONLINE);
 	nr_online_nodes = num_node_state(N_ONLINE);
 }
 
-static inline void node_set_offline(int nid)
+static __always_inline void node_set_offline(int nid)
 {
 	node_clear_state(nid, N_ONLINE);
 	nr_online_nodes = num_node_state(N_ONLINE);
@@ -469,20 +469,20 @@ static inline void node_set_offline(int nid)
 
 #else
 
-static inline int node_state(int node, enum node_states state)
+static __always_inline int node_state(int node, enum node_states state)
 {
 	return node == 0;
 }
 
-static inline void node_set_state(int node, enum node_states state)
+static __always_inline void node_set_state(int node, enum node_states state)
 {
 }
 
-static inline void node_clear_state(int node, enum node_states state)
+static __always_inline void node_clear_state(int node, enum node_states state)
 {
 }
 
-static inline int num_node_state(enum node_states state)
+static __always_inline int num_node_state(enum node_states state)
 {
 	return 1;
 }
@@ -502,7 +502,7 @@ static inline int num_node_state(enum node_states state)
 
 #endif
 
-static inline int node_random(const nodemask_t *maskp)
+static __always_inline int node_random(const nodemask_t *maskp)
 {
 #if defined(CONFIG_NUMA) && (MAX_NUMNODES > 1)
 	int w, bit;
-- 
2.45.2.803.g4e1b14247a-goog


