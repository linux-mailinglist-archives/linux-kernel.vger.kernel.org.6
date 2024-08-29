Return-Path: <linux-kernel+bounces-307060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3394964769
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 16:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03A611C22A90
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 14:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA661AED53;
	Thu, 29 Aug 2024 14:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="oDrAiUex"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1E71AD9E5
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 14:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724940009; cv=none; b=bFUyJ4UcG5QUxHZCqFyA+Il2RcqmfYWVO0f5/7VnC45/iyypxEijoiBnlP2avVrPDgZdUwGLZYVemgNucTePXMN1eBjw1/joKAb6EVB93UL+cAt0EVtNnbq4VAnBg+Sl+KMX6hUKzVkr0llbu2P1pbHjqPDz3VPaEsS3LUpovqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724940009; c=relaxed/simple;
	bh=GZRhJ9V/rBWzlcb4oNthjmQL/Bu5uEyMcfx5lKJI1xc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JY13iN8E4gQHZfGD6dXrpJ9aYOVUEOBB1rgmPtv6R2EYV76CDgXepR92rL8cag3KvIVTGslO4mMzNlRzDNmw9EBM8iW7VGf2dmmf2F+et4LTo41t7bBE5/FdRrtRT827LH0u1UkWmVcyU528wFv7CkFdIFBpE1BWtSVjgtZQFzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=oDrAiUex; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1724939999;
	bh=GZRhJ9V/rBWzlcb4oNthjmQL/Bu5uEyMcfx5lKJI1xc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oDrAiUex+fFf4A+WRjhRVn7/ZsaATNPR4PeLiHilQhgiGKNhrfHtvuepQhX5jT3Oz
	 lnUjRKRdKhU5tl5fhbjjFoKSiHO4vd4s7NQitGsYTzTB/ej4rP+KyRxSRuTQueI6UH
	 aEkrrykPPHQg3KARI58K24+a1QWzmYCRf88tJehyU7UORHWiMLeB5DgeX3TKW0p9Zq
	 BAjwI+iLldtRGCpWxfUcRhrv2exjmbg3rH0chbSy6CK1CbVB3o5VxUd9rfJTxMWxTD
	 Vee7Qu5AXbIGejszn3IV8fIF+ilR8Jsi00VRJTX8PgyViaEukDN5AUvsEGz7X6pSd1
	 dSdr8//MYKCqg==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Wvjb334rhz1JQd;
	Thu, 29 Aug 2024 09:59:59 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v2 2/6] lib: Implement find_{first,next,nth}_nor_bit, for_each_nor_bit, find_first_andnot_bit
Date: Thu, 29 Aug 2024 09:59:22 -0400
Message-Id: <20240829135926.926603-3-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240829135926.926603-1-mathieu.desnoyers@efficios.com>
References: <20240829135926.926603-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow finding the first, next, or nth bit within two input bitmasks
which is zero in both masks.

Allow fiding the first bit within two input bitmasks which is set in
first mask and cleared in the second mask. find_next_andnot_bit and
find_nth_andnot_bit already exist, so find the first bit appears to be
missing.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Acked-by: Yury Norov <yury.norov@gmail.com>
Cc: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
Changes since v0:
- Rename "notandnot" to "nor", document equivalence.
- Move comment cleanups to a separate patch.
- Use __always_inline.
Changes since v1:
- Introduce for_each_nor_bit.
---
 include/linux/find.h | 117 +++++++++++++++++++++++++++++++++++++++++++
 lib/find_bit.c       |  36 +++++++++++++
 2 files changed, 153 insertions(+)

diff --git a/include/linux/find.h b/include/linux/find.h
index 8a170aa55634..cf3a49d18c1f 100644
--- a/include/linux/find.h
+++ b/include/linux/find.h
@@ -14,6 +14,8 @@ unsigned long _find_next_and_bit(const unsigned long *addr1, const unsigned long
 					unsigned long nbits, unsigned long start);
 unsigned long _find_next_andnot_bit(const unsigned long *addr1, const unsigned long *addr2,
 					unsigned long nbits, unsigned long start);
+unsigned long _find_next_nor_bit(const unsigned long *addr1, const unsigned long *addr2,
+					unsigned long nbits, unsigned long start);
 unsigned long _find_next_or_bit(const unsigned long *addr1, const unsigned long *addr2,
 					unsigned long nbits, unsigned long start);
 unsigned long _find_next_zero_bit(const unsigned long *addr, unsigned long nbits,
@@ -24,11 +26,17 @@ unsigned long __find_nth_and_bit(const unsigned long *addr1, const unsigned long
 				unsigned long size, unsigned long n);
 unsigned long __find_nth_andnot_bit(const unsigned long *addr1, const unsigned long *addr2,
 					unsigned long size, unsigned long n);
+unsigned long __find_nth_nor_bit(const unsigned long *addr1, const unsigned long *addr2,
+					unsigned long size, unsigned long n);
 unsigned long __find_nth_and_andnot_bit(const unsigned long *addr1, const unsigned long *addr2,
 					const unsigned long *addr3, unsigned long size,
 					unsigned long n);
 extern unsigned long _find_first_and_bit(const unsigned long *addr1,
 					 const unsigned long *addr2, unsigned long size);
+extern unsigned long _find_first_andnot_bit(const unsigned long *addr1,
+					 const unsigned long *addr2, unsigned long size);
+extern unsigned long _find_first_nor_bit(const unsigned long *addr1,
+					 const unsigned long *addr2, unsigned long size);
 unsigned long _find_first_and_and_bit(const unsigned long *addr1, const unsigned long *addr2,
 				      const unsigned long *addr3, unsigned long size);
 extern unsigned long _find_first_zero_bit(const unsigned long *addr, unsigned long size);
@@ -130,6 +138,35 @@ unsigned long find_next_andnot_bit(const unsigned long *addr1,
 }
 #endif
 
+/**
+ * find_next_nor_bit - find the next bit cleared in both *addr1 and *addr2
+ * @addr1: The first address to base the search on
+ * @addr2: The second address to base the search on
+ * @size: The bitmap size in bits
+ * @offset: The bitnumber to start searching at
+ *
+ * Returns the bit number for the next bit cleared in both *addr1 and *addr2.
+ * If no such bits are found, returns @size.
+ * The bitwise operation nor ~(A | B) is equivalent to (~A & ~B).
+ */
+static __always_inline
+unsigned long find_next_nor_bit(const unsigned long *addr1,
+		const unsigned long *addr2, unsigned long size,
+		unsigned long offset)
+{
+	if (small_const_nbits(size)) {
+		unsigned long val;
+
+		if (unlikely(offset >= size))
+			return size;
+
+		val = ~(*addr1 | *addr2) & GENMASK(size - 1, offset);
+		return val ? __ffs(val) : size;
+	}
+
+	return _find_next_nor_bit(addr1, addr2, size, offset);
+}
+
 #ifndef find_next_or_bit
 /**
  * find_next_or_bit - find the next set bit in either memory regions
@@ -291,6 +328,33 @@ unsigned long find_nth_andnot_bit(const unsigned long *addr1, const unsigned lon
 	return __find_nth_andnot_bit(addr1, addr2, size, n);
 }
 
+/**
+ * find_nth_nor_bit - find N'th cleared bit in 2 memory regions.
+ * @addr1: The 1st address to start the search at
+ * @addr2: The 2nd address to start the search at
+ * @size: The maximum number of bits to search
+ * @n: The number of set bit, which position is needed, counting from 0
+ *
+ * Returns the bit number of the N'th bit cleared in the two regions.
+ * If no such, returns @size.
+ * The bitwise operation nor ~(A | B) is equivalent to (~A & ~B).
+ */
+static __always_inline
+unsigned long find_nth_nor_bit(const unsigned long *addr1, const unsigned long *addr2,
+				unsigned long size, unsigned long n)
+{
+	if (n >= size)
+		return size;
+
+	if (small_const_nbits(size)) {
+		unsigned long val = ~(*addr1 | *addr2) & GENMASK(size - 1, 0);
+
+		return val ? fns(val, n) : size;
+	}
+
+	return __find_nth_nor_bit(addr1, addr2, size, n);
+}
+
 /**
  * find_nth_and_andnot_bit - find N'th set bit in 2 memory regions,
  *			     excluding those set in 3rd region
@@ -346,6 +410,54 @@ unsigned long find_first_and_bit(const unsigned long *addr1,
 }
 #endif
 
+/**
+ * find_first_andnot_bit - find the first set bit in 2 memory regions,
+ *                         flipping bits in 2nd region.
+ * @addr1: The first address to base the search on
+ * @addr2: The second address to base the search on
+ * @size: The bitmap size in bits
+ *
+ * Returns the bit number for the next set bit.
+ * If no bits are set, returns @size.
+ */
+static __always_inline
+unsigned long find_first_andnot_bit(const unsigned long *addr1,
+				 const unsigned long *addr2,
+				 unsigned long size)
+{
+	if (small_const_nbits(size)) {
+		unsigned long val = *addr1 & (~*addr2) & GENMASK(size - 1, 0);
+
+		return val ? __ffs(val) : size;
+	}
+
+	return _find_first_andnot_bit(addr1, addr2, size);
+}
+
+/**
+ * find_first_nor_bit - find the first cleared bit in 2 memory regions
+ * @addr1: The first address to base the search on
+ * @addr2: The second address to base the search on
+ * @size: The bitmap size in bits
+ *
+ * Returns the bit number for the next cleared bit.
+ * If no bits are set, returns @size.
+ * The bitwise operation nor ~(A | B) is equivalent to (~A & ~B).
+ */
+static __always_inline
+unsigned long find_first_nor_bit(const unsigned long *addr1,
+				 const unsigned long *addr2,
+				 unsigned long size)
+{
+	if (small_const_nbits(size)) {
+		unsigned long val = ~(*addr1 | *addr2) & GENMASK(size - 1, 0);
+
+		return val ? __ffs(val) : size;
+	}
+
+	return _find_first_nor_bit(addr1, addr2, size);
+}
+
 /**
  * find_first_and_and_bit - find the first set bit in 3 memory regions
  * @addr1: The first address to base the search on
@@ -594,6 +706,11 @@ unsigned long find_next_bit_le(const void *addr, unsigned
 	     (bit) = find_next_andnot_bit((addr1), (addr2), (size), (bit)), (bit) < (size);\
 	     (bit)++)
 
+#define for_each_nor_bit(bit, addr1, addr2, size) \
+	for ((bit) = 0;									\
+	     (bit) = find_next_nor_bit((addr1), (addr2), (size), (bit)), (bit) < (size);\
+	     (bit)++)
+
 #define for_each_or_bit(bit, addr1, addr2, size) \
 	for ((bit) = 0;									\
 	     (bit) = find_next_or_bit((addr1), (addr2), (size), (bit)), (bit) < (size);\
diff --git a/lib/find_bit.c b/lib/find_bit.c
index 0836bb3d76c5..8050bc7c7ede 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -116,6 +116,28 @@ unsigned long _find_first_and_bit(const unsigned long *addr1,
 EXPORT_SYMBOL(_find_first_and_bit);
 #endif
 
+/*
+ * Find the first set bit in two memory regions, flipping bits in 2nd region.
+ */
+unsigned long _find_first_andnot_bit(const unsigned long *addr1,
+				  const unsigned long *addr2,
+				  unsigned long size)
+{
+	return FIND_FIRST_BIT(addr1[idx] & ~addr2[idx], /* nop */, size);
+}
+EXPORT_SYMBOL(_find_first_andnot_bit);
+
+/*
+ * Find the first cleared bit in two memory regions.
+ */
+unsigned long _find_first_nor_bit(const unsigned long *addr1,
+				  const unsigned long *addr2,
+				  unsigned long size)
+{
+	return FIND_FIRST_BIT(~(addr1[idx] | addr2[idx]), /* nop */, size);
+}
+EXPORT_SYMBOL(_find_first_nor_bit);
+
 /*
  * Find the first set bit in three memory regions.
  */
@@ -167,6 +189,13 @@ unsigned long __find_nth_andnot_bit(const unsigned long *addr1, const unsigned l
 }
 EXPORT_SYMBOL(__find_nth_andnot_bit);
 
+unsigned long __find_nth_nor_bit(const unsigned long *addr1, const unsigned long *addr2,
+				 unsigned long size, unsigned long n)
+{
+	return FIND_NTH_BIT(~(addr1[idx] | addr2[idx]), size, n);
+}
+EXPORT_SYMBOL(__find_nth_nor_bit);
+
 unsigned long __find_nth_and_andnot_bit(const unsigned long *addr1,
 					const unsigned long *addr2,
 					const unsigned long *addr3,
@@ -194,6 +223,13 @@ unsigned long _find_next_andnot_bit(const unsigned long *addr1, const unsigned l
 EXPORT_SYMBOL(_find_next_andnot_bit);
 #endif
 
+unsigned long _find_next_nor_bit(const unsigned long *addr1, const unsigned long *addr2,
+					unsigned long nbits, unsigned long start)
+{
+	return FIND_NEXT_BIT(~(addr1[idx] | addr2[idx]), /* nop */, nbits, start);
+}
+EXPORT_SYMBOL(_find_next_nor_bit);
+
 #ifndef find_next_or_bit
 unsigned long _find_next_or_bit(const unsigned long *addr1, const unsigned long *addr2,
 					unsigned long nbits, unsigned long start)
-- 
2.39.2


