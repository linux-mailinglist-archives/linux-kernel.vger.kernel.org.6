Return-Path: <linux-kernel+bounces-256874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9959371A5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 02:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2767D2816AC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 00:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1505F2F30;
	Fri, 19 Jul 2024 00:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XI3mDDZ5"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33C6ECC
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 00:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721350298; cv=none; b=lQypym0/Efke1gP5amxc7TWq8ek6SWE64UcKaZtlu9oOo9OTCuNjtxHsY+C9q98pGiSeN6gn7KGdxyvyrqwIpiek1jFnfdMQ/U3UXKddiWKU//tlrygeLt3jU6aTJSlJEa/SVNJ1vapRLasaG4RU3HgXs8GtwIYpLPfw2ZmdRxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721350298; c=relaxed/simple;
	bh=OGlCBhFjr6p5I+9WvICP7vTbaMlS92Gnm81IG9QcIps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=thS8KeYmKvn45tMJQ85f5+E/Vp5PKfOc9jbsjFIlUVGltKvRt428zh5GCcRGD78Nhk7GoP/vHIy7MVkxfb2dBW+yGn85j1w0qvyu8lh0GLiVFF2nPCMCDtebr6czkwtImcpYctAXjao/6/EFp2dSLU35Jsn8UZdEIqd9K5RtnLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XI3mDDZ5; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2cb566d528aso692661a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 17:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721350296; x=1721955096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7gGXyyQODryKk1/J4yl9zNGcvrlzwtalmqeE16GDEeg=;
        b=XI3mDDZ5AZgCCv85NL981Wj7R2oT0DzTjqhig1zgXqks7f6e019b17jixYH7yCWB6l
         w+yJXr9O4hwKrY61QB8APPBwaptVnp8DYC845apqEYdY4GXb0xKsxOOdn0FyqLj6FWRD
         ju7AW0R7sSlhxKeUpL1Mtd/yQLIdbCUTM/2eg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721350296; x=1721955096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7gGXyyQODryKk1/J4yl9zNGcvrlzwtalmqeE16GDEeg=;
        b=Bl2Xxv4NOkb/1qW7Fs+DPy5YadP/QLpVlLTr70qdMeEuu3SVO6DCSNitP0fGYXAkex
         eVuO8T0vGx1SLD7oXjuk8gopI2Q67/oPJHpx3BKK4sto4AkWnB7ekAkxXj2/QxeQxF4v
         PDCo0vFa6j8KsH46r2S47Y1x2FpIm4IuX2UxL7LG3OelYt5QGpKRxR9ZEz0p1WUhUHmd
         mg4cia4EQNlHPCtusf0JSKylEORnGm4yaDnupVrNOHSxLnXHba9uOMFLdDEkDuSIO8AN
         0Vk0ORdo+4JV32xMAy5LrHIBRX8C0uJ3fI9eftbi7hLhqe1MJxc0SunfDzE/WfFgCqu1
         Luow==
X-Gm-Message-State: AOJu0YzRp4X61pzIjDzonwsHO/SdBQCBiRrP9u5ycClvwzuJRNt5AfVZ
	yW4Y2VhadJoMBAjR6UcgiMaF89pVIFN+gaqm8hn83K1/DhwFTXIukQWUfMJcdg==
X-Google-Smtp-Source: AGHT+IGLjN0MJWV5ZqYXf3qHgoiBOk4AcVDvDlyWGAKyQiBanLbyXBvZTvSC6zocoYceMA4MVI0XZA==
X-Received: by 2002:a05:6a21:594:b0:1c3:18f9:16d8 with SMTP id adf61e73a8af0-1c3fdddad23mr6383558637.52.1721350296191;
        Thu, 18 Jul 2024 17:51:36 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:35aa:f87d:7549:3938])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-1fd64b4e33esm1996265ad.42.2024.07.18.17.51.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 17:51:35 -0700 (PDT)
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
Subject: [PATCH v3 2/4] bitmap: Switch from inline to __always_inline
Date: Thu, 18 Jul 2024 17:50:38 -0700
Message-ID: <20240719005127.2449328-2-briannorris@chromium.org>
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

From: Yury Norov <yury.norov@gmail.com>

'inline' keyword is only a recommendation for compiler. If it decides to
not inline bitmap functions, the whole small_const_nbits() machinery
doesn't work.

This is how a standard GCC 11.3.0 does for my x86_64 build now. This patch
replaces 'inline' directive with unconditional '__always_inline' to make
sure that there's always a chance for compile-time optimization. It doesn't
change size of kernel image, according to bloat-o-meter.

[[ Brian: split out from:
      Subject: [PATCH 1/3] bitmap: switch from inline to __always_inline
      https://lore.kernel.org/all/20221027043810.350460-2-yury.norov@gmail.com/
   But rewritten, as there were too many conflicts. ]]

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Co-developed-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Kees Cook <kees@kernel.org>
---

Changes in v3:
 - newly split out in v3

 include/linux/bitmap.h | 140 ++++++++++++++++++++++-------------------
 1 file changed, 76 insertions(+), 64 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 8c4768c44a01..0406f48f0a6a 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -203,12 +203,12 @@ unsigned long bitmap_find_next_zero_area_off(unsigned long *map,
  * the bit offset of all zero areas this function finds is multiples of that
  * power of 2. A @align_mask of 0 means no alignment is required.
  */
-static inline unsigned long
-bitmap_find_next_zero_area(unsigned long *map,
-			   unsigned long size,
-			   unsigned long start,
-			   unsigned int nr,
-			   unsigned long align_mask)
+static __always_inline
+unsigned long bitmap_find_next_zero_area(unsigned long *map,
+					 unsigned long size,
+					 unsigned long start,
+					 unsigned int nr,
+					 unsigned long align_mask)
 {
 	return bitmap_find_next_zero_area_off(map, size, start, nr,
 					      align_mask, 0);
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
+static __always_inline
+void bitmap_copy(unsigned long *dst, const unsigned long *src, unsigned int nbits)
 {
 	unsigned int len = bitmap_size(nbits);
 
@@ -262,8 +262,8 @@ static inline void bitmap_copy(unsigned long *dst, const unsigned long *src,
 /*
  * Copy bitmap and clear tail bits in last word.
  */
-static inline void bitmap_copy_clear_tail(unsigned long *dst,
-		const unsigned long *src, unsigned int nbits)
+static __always_inline
+void bitmap_copy_clear_tail(unsigned long *dst, const unsigned long *src, unsigned int nbits)
 {
 	bitmap_copy(dst, src, nbits);
 	if (nbits % BITS_PER_LONG)
@@ -306,16 +306,18 @@ void bitmap_to_arr64(u64 *buf, const unsigned long *bitmap, unsigned int nbits);
 	bitmap_copy_clear_tail((unsigned long *)(buf), (const unsigned long *)(bitmap), (nbits))
 #endif
 
-static inline bool bitmap_and(unsigned long *dst, const unsigned long *src1,
-			const unsigned long *src2, unsigned int nbits)
+static __always_inline
+bool bitmap_and(unsigned long *dst, const unsigned long *src1,
+		const unsigned long *src2, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
 		return (*dst = *src1 & *src2 & BITMAP_LAST_WORD_MASK(nbits)) != 0;
 	return __bitmap_and(dst, src1, src2, nbits);
 }
 
-static inline void bitmap_or(unsigned long *dst, const unsigned long *src1,
-			const unsigned long *src2, unsigned int nbits)
+static __always_inline
+void bitmap_or(unsigned long *dst, const unsigned long *src1,
+	       const unsigned long *src2, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
 		*dst = *src1 | *src2;
@@ -323,8 +325,9 @@ static inline void bitmap_or(unsigned long *dst, const unsigned long *src1,
 		__bitmap_or(dst, src1, src2, nbits);
 }
 
-static inline void bitmap_xor(unsigned long *dst, const unsigned long *src1,
-			const unsigned long *src2, unsigned int nbits)
+static __always_inline
+void bitmap_xor(unsigned long *dst, const unsigned long *src1,
+		const unsigned long *src2, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
 		*dst = *src1 ^ *src2;
@@ -332,16 +335,17 @@ static inline void bitmap_xor(unsigned long *dst, const unsigned long *src1,
 		__bitmap_xor(dst, src1, src2, nbits);
 }
 
-static inline bool bitmap_andnot(unsigned long *dst, const unsigned long *src1,
-			const unsigned long *src2, unsigned int nbits)
+static __always_inline
+bool bitmap_andnot(unsigned long *dst, const unsigned long *src1,
+		   const unsigned long *src2, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
 		return (*dst = *src1 & ~(*src2) & BITMAP_LAST_WORD_MASK(nbits)) != 0;
 	return __bitmap_andnot(dst, src1, src2, nbits);
 }
 
-static inline void bitmap_complement(unsigned long *dst, const unsigned long *src,
-			unsigned int nbits)
+static __always_inline
+void bitmap_complement(unsigned long *dst, const unsigned long *src, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
 		*dst = ~(*src);
@@ -356,8 +360,8 @@ static inline void bitmap_complement(unsigned long *dst, const unsigned long *sr
 #endif
 #define BITMAP_MEM_MASK (BITMAP_MEM_ALIGNMENT - 1)
 
-static inline bool bitmap_equal(const unsigned long *src1,
-				const unsigned long *src2, unsigned int nbits)
+static __always_inline
+bool bitmap_equal(const unsigned long *src1, const unsigned long *src2, unsigned int nbits)
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
+static __always_inline
+bool bitmap_or_equal(const unsigned long *src1, const unsigned long *src2,
+		     const unsigned long *src3, unsigned int nbits)
 {
 	if (!small_const_nbits(nbits))
 		return __bitmap_or_equal(src1, src2, src3, nbits);
@@ -387,9 +390,8 @@ static inline bool bitmap_or_equal(const unsigned long *src1,
 	return !(((*src1 | *src2) ^ *src3) & BITMAP_LAST_WORD_MASK(nbits));
 }
 
-static inline bool bitmap_intersects(const unsigned long *src1,
-				     const unsigned long *src2,
-				     unsigned int nbits)
+static __always_inline
+bool bitmap_intersects(const unsigned long *src1, const unsigned long *src2, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
 		return ((*src1 & *src2) & BITMAP_LAST_WORD_MASK(nbits)) != 0;
@@ -397,8 +399,8 @@ static inline bool bitmap_intersects(const unsigned long *src1,
 		return __bitmap_intersects(src1, src2, nbits);
 }
 
-static inline bool bitmap_subset(const unsigned long *src1,
-				 const unsigned long *src2, unsigned int nbits)
+static __always_inline
+bool bitmap_subset(const unsigned long *src1, const unsigned long *src2, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
 		return ! ((*src1 & ~(*src2)) & BITMAP_LAST_WORD_MASK(nbits));
@@ -406,7 +408,8 @@ static inline bool bitmap_subset(const unsigned long *src1,
 		return __bitmap_subset(src1, src2, nbits);
 }
 
-static inline bool bitmap_empty(const unsigned long *src, unsigned nbits)
+static __always_inline
+bool bitmap_empty(const unsigned long *src, unsigned nbits)
 {
 	if (small_const_nbits(nbits))
 		return ! (*src & BITMAP_LAST_WORD_MASK(nbits));
@@ -414,7 +417,8 @@ static inline bool bitmap_empty(const unsigned long *src, unsigned nbits)
 	return find_first_bit(src, nbits) == nbits;
 }
 
-static inline bool bitmap_full(const unsigned long *src, unsigned int nbits)
+static __always_inline
+bool bitmap_full(const unsigned long *src, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
 		return ! (~(*src) & BITMAP_LAST_WORD_MASK(nbits));
@@ -448,8 +452,8 @@ unsigned long bitmap_weight_andnot(const unsigned long *src1,
 	return __bitmap_weight_andnot(src1, src2, nbits);
 }
 
-static __always_inline void bitmap_set(unsigned long *map, unsigned int start,
-		unsigned int nbits)
+static __always_inline
+void bitmap_set(unsigned long *map, unsigned int start, unsigned int nbits)
 {
 	if (__builtin_constant_p(nbits) && nbits == 1)
 		__set_bit(start, map);
@@ -464,8 +468,8 @@ static __always_inline void bitmap_set(unsigned long *map, unsigned int start,
 		__bitmap_set(map, start, nbits);
 }
 
-static __always_inline void bitmap_clear(unsigned long *map, unsigned int start,
-		unsigned int nbits)
+static __always_inline
+void bitmap_clear(unsigned long *map, unsigned int start, unsigned int nbits)
 {
 	if (__builtin_constant_p(nbits) && nbits == 1)
 		__clear_bit(start, map);
@@ -480,8 +484,9 @@ static __always_inline void bitmap_clear(unsigned long *map, unsigned int start,
 		__bitmap_clear(map, start, nbits);
 }
 
-static inline void bitmap_shift_right(unsigned long *dst, const unsigned long *src,
-				unsigned int shift, unsigned int nbits)
+static __always_inline
+void bitmap_shift_right(unsigned long *dst, const unsigned long *src,
+			unsigned int shift, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
 		*dst = (*src & BITMAP_LAST_WORD_MASK(nbits)) >> shift;
@@ -489,8 +494,9 @@ static inline void bitmap_shift_right(unsigned long *dst, const unsigned long *s
 		__bitmap_shift_right(dst, src, shift, nbits);
 }
 
-static inline void bitmap_shift_left(unsigned long *dst, const unsigned long *src,
-				unsigned int shift, unsigned int nbits)
+static __always_inline
+void bitmap_shift_left(unsigned long *dst, const unsigned long *src,
+		       unsigned int shift, unsigned int nbits)
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
+static __always_inline
+void bitmap_replace(unsigned long *dst,
+		    const unsigned long *old,
+		    const unsigned long *new,
+		    const unsigned long *mask,
+		    unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
 		*dst = (*old & ~(*mask)) | (*new & *mask);
@@ -545,8 +552,9 @@ static inline void bitmap_replace(unsigned long *dst,
  * bitmap_gather() can be seen as the 'reverse' bitmap_scatter() operation.
  * See bitmap_scatter() for details related to this relationship.
  */
-static inline void bitmap_scatter(unsigned long *dst, const unsigned long *src,
-				  const unsigned long *mask, unsigned int nbits)
+static __always_inline
+void bitmap_scatter(unsigned long *dst, const unsigned long *src,
+		    const unsigned long *mask, unsigned int nbits)
 {
 	unsigned int n = 0;
 	unsigned int bit;
@@ -599,8 +607,9 @@ static inline void bitmap_scatter(unsigned long *dst, const unsigned long *src,
  * bitmap_scatter(res, src, mask, n) and a call to
  * bitmap_scatter(res, result, mask, n) will lead to the same res value.
  */
-static inline void bitmap_gather(unsigned long *dst, const unsigned long *src,
-				 const unsigned long *mask, unsigned int nbits)
+static __always_inline
+void bitmap_gather(unsigned long *dst, const unsigned long *src,
+		   const unsigned long *mask, unsigned int nbits)
 {
 	unsigned int n = 0;
 	unsigned int bit;
@@ -611,9 +620,9 @@ static inline void bitmap_gather(unsigned long *dst, const unsigned long *src,
 		__assign_bit(n++, dst, test_bit(bit, src));
 }
 
-static inline void bitmap_next_set_region(unsigned long *bitmap,
-					  unsigned int *rs, unsigned int *re,
-					  unsigned int end)
+static __always_inline
+void bitmap_next_set_region(unsigned long *bitmap, unsigned int *rs,
+			    unsigned int *re, unsigned int end)
 {
 	*rs = find_next_bit(bitmap, end, *rs);
 	*re = find_next_zero_bit(bitmap, end, *rs + 1);
@@ -628,7 +637,8 @@ static inline void bitmap_next_set_region(unsigned long *bitmap,
  * This is the complement to __bitmap_find_free_region() and releases
  * the found region (by clearing it in the bitmap).
  */
-static inline void bitmap_release_region(unsigned long *bitmap, unsigned int pos, int order)
+static __always_inline
+void bitmap_release_region(unsigned long *bitmap, unsigned int pos, int order)
 {
 	bitmap_clear(bitmap, pos, BIT(order));
 }
@@ -644,7 +654,8 @@ static inline void bitmap_release_region(unsigned long *bitmap, unsigned int pos
  * Returns: 0 on success, or %-EBUSY if specified region wasn't
  * free (not all bits were zero).
  */
-static inline int bitmap_allocate_region(unsigned long *bitmap, unsigned int pos, int order)
+static __always_inline
+int bitmap_allocate_region(unsigned long *bitmap, unsigned int pos, int order)
 {
 	unsigned int len = BIT(order);
 
@@ -668,7 +679,8 @@ static inline int bitmap_allocate_region(unsigned long *bitmap, unsigned int pos
  * Returns: the bit offset in bitmap of the allocated region,
  * or -errno on failure.
  */
-static inline int bitmap_find_free_region(unsigned long *bitmap, unsigned int bits, int order)
+static __always_inline
+int bitmap_find_free_region(unsigned long *bitmap, unsigned int bits, int order)
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
+static __always_inline
+unsigned long bitmap_read(const unsigned long *map, unsigned long start, unsigned long nbits)
 {
 	size_t index = BIT_WORD(start);
 	unsigned long offset = start % BITS_PER_LONG;
@@ -772,8 +783,9 @@ static inline unsigned long bitmap_read(const unsigned long *map,
  *
  * For @nbits == 0 and @nbits > BITS_PER_LONG no writes are performed.
  */
-static inline void bitmap_write(unsigned long *map, unsigned long value,
-				unsigned long start, unsigned long nbits)
+static __always_inline
+void bitmap_write(unsigned long *map, unsigned long value,
+		  unsigned long start, unsigned long nbits)
 {
 	size_t index;
 	unsigned long offset;
-- 
2.45.2.1089.g2a221341d9-goog


