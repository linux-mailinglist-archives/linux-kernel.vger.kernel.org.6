Return-Path: <linux-kernel+bounces-292274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E4A956D59
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DABE285DC6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0863A174EFA;
	Mon, 19 Aug 2024 14:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="j7oiACOX"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1277916C6AC
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 14:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724077933; cv=none; b=bpBBLgWaGow8E9gFyQGvVt156Gyhf7XHZmPENsv8wwXdHrMpT9dC5T1+3qNU/UG8wIFjyRWLL+gVjCsmyK5Bbhxd/ArQjCHJPwu8tZ6wikVWt0qu/a5y1ohOyOLyS0UgMjPaUgKAMtR0DJ24tMfvMc+TXocOqN59xmDZm2r+XcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724077933; c=relaxed/simple;
	bh=wyM/VPWrODiAeuvDltg6SpNw20yBBry4iGqdbnWnf94=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I5OmyetVYDXZloEbFKzqedCGOYILG6/Om0Pwt+jZrv/AXkZHwONcwxuLcJC8E5yOaARedMpwxibNb3okd4oIr0TtEOtUJX0resxU6OjALJrmyD6X3yt5gL0utuXirDN07iZXtNvC0hpXNR6+YPMdpPflKF6KiYZr7nSrogHS/po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=j7oiACOX; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1724077473;
	bh=wyM/VPWrODiAeuvDltg6SpNw20yBBry4iGqdbnWnf94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j7oiACOXuqAG6hNHL3VHQCyV22kgqGnrehXoZErnPL5O08ez5JeGHbDJCkrmt1FMh
	 UWMRBpGQMJy4aPWcvM5pn1BgVcRX3HPghYAtIMfwUe030/PqKRhuaWGLjbME1AwaTf
	 HXRLo7N+2Sw74bfcYpkLBb72KetZUBWGUvgkjyH30Psakcz2oWfEOAnkNHOOW/HiRb
	 /qKxGgGmGet4iLVEMLOCkbK2XeQKWtNo/ImpwHFwBrdQyec4pH1V8kcnlSqOkG0pGp
	 ZUghWn9Mha9Hds17zhA+8XEkhYMsMdqesNy/0ss67uSI9svYGMP+aJ3OdsVK/1xhzi
	 UlAbib+Gc/TEw==
Received: from thinkos.internal.efficios.com (109.56.13.38.mobile.3.dk [109.56.13.38])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4WnZbz3B90z1Hjt;
	Mon, 19 Aug 2024 10:24:31 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Mel Gorman <mgorman@suse.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [RFC PATCH 1/5] lib: Implement find_{first,next,nth}_notandnot_bit, find_first_andnot_bit
Date: Mon, 19 Aug 2024 16:24:02 +0200
Message-Id: <20240819142406.339084-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240819142406.339084-1-mathieu.desnoyers@efficios.com>
References: <20240819142406.339084-1-mathieu.desnoyers@efficios.com>
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
Cc: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/find.h | 122 +++++++++++++++++++++++++++++++++++++++++--
 lib/find_bit.c       |  42 +++++++++++++++
 2 files changed, 160 insertions(+), 4 deletions(-)

diff --git a/include/linux/find.h b/include/linux/find.h
index 5dfca4225fef..6b2377006b22 100644
--- a/include/linux/find.h
+++ b/include/linux/find.h
@@ -14,6 +14,8 @@ unsigned long _find_next_and_bit(const unsigned long *addr1, const unsigned long
 					unsigned long nbits, unsigned long start);
 unsigned long _find_next_andnot_bit(const unsigned long *addr1, const unsigned long *addr2,
 					unsigned long nbits, unsigned long start);
+unsigned long _find_next_notandnot_bit(const unsigned long *addr1, const unsigned long *addr2,
+					unsigned long nbits, unsigned long start);
 unsigned long _find_next_or_bit(const unsigned long *addr1, const unsigned long *addr2,
 					unsigned long nbits, unsigned long start);
 unsigned long _find_next_zero_bit(const unsigned long *addr, unsigned long nbits,
@@ -24,11 +26,17 @@ unsigned long __find_nth_and_bit(const unsigned long *addr1, const unsigned long
 				unsigned long size, unsigned long n);
 unsigned long __find_nth_andnot_bit(const unsigned long *addr1, const unsigned long *addr2,
 					unsigned long size, unsigned long n);
+unsigned long __find_nth_notandnot_bit(const unsigned long *addr1, const unsigned long *addr2,
+					unsigned long size, unsigned long n);
 unsigned long __find_nth_and_andnot_bit(const unsigned long *addr1, const unsigned long *addr2,
 					const unsigned long *addr3, unsigned long size,
 					unsigned long n);
 extern unsigned long _find_first_and_bit(const unsigned long *addr1,
 					 const unsigned long *addr2, unsigned long size);
+extern unsigned long _find_first_andnot_bit(const unsigned long *addr1,
+					 const unsigned long *addr2, unsigned long size);
+extern unsigned long _find_first_notandnot_bit(const unsigned long *addr1,
+					 const unsigned long *addr2, unsigned long size);
 unsigned long _find_first_and_and_bit(const unsigned long *addr1, const unsigned long *addr2,
 				      const unsigned long *addr3, unsigned long size);
 extern unsigned long _find_first_zero_bit(const unsigned long *addr, unsigned long size);
@@ -102,15 +110,14 @@ unsigned long find_next_and_bit(const unsigned long *addr1,
 
 #ifndef find_next_andnot_bit
 /**
- * find_next_andnot_bit - find the next set bit in *addr1 excluding all the bits
- *                        in *addr2
+ * find_next_andnot_bit - find the next set bit in *addr1, cleared in *addr2
  * @addr1: The first address to base the search on
  * @addr2: The second address to base the search on
  * @size: The bitmap size in bits
  * @offset: The bitnumber to start searching at
  *
- * Returns the bit number for the next set bit
- * If no bits are set, returns @size.
+ * Returns the bit number for the next bit set in *addr1, cleared in *addr2.
+ * If no such bits are found, returns @size.
  */
 static inline
 unsigned long find_next_andnot_bit(const unsigned long *addr1,
@@ -131,6 +138,36 @@ unsigned long find_next_andnot_bit(const unsigned long *addr1,
 }
 #endif
 
+#ifndef find_next_notandnot_bit
+/**
+ * find_next_notandnot_bit - find the next bit cleared in both *addr1 and *addr2
+ * @addr1: The first address to base the search on
+ * @addr2: The second address to base the search on
+ * @size: The bitmap size in bits
+ * @offset: The bitnumber to start searching at
+ *
+ * Returns the bit number for the next bit cleared in both *addr1 and *addr2.
+ * If no such bits are found, returns @size.
+ */
+static inline
+unsigned long find_next_notandnot_bit(const unsigned long *addr1,
+		const unsigned long *addr2, unsigned long size,
+		unsigned long offset)
+{
+	if (small_const_nbits(size)) {
+		unsigned long val;
+
+		if (unlikely(offset >= size))
+			return size;
+
+		val = (~*addr1) & (~*addr2) & GENMASK(size - 1, offset);
+		return val ? __ffs(val) : size;
+	}
+
+	return _find_next_notandnot_bit(addr1, addr2, size, offset);
+}
+#endif
+
 #ifndef find_next_or_bit
 /**
  * find_next_or_bit - find the next set bit in either memory regions
@@ -292,6 +329,32 @@ unsigned long find_nth_andnot_bit(const unsigned long *addr1, const unsigned lon
 	return __find_nth_andnot_bit(addr1, addr2, size, n);
 }
 
+/**
+ * find_nth_notandnot_bit - find N'th cleared bit in 2 memory regions.
+ * @addr1: The 1st address to start the search at
+ * @addr2: The 2nd address to start the search at
+ * @size: The maximum number of bits to search
+ * @n: The number of set bit, which position is needed, counting from 0
+ *
+ * Returns the bit number of the N'th bit cleared in the two regions.
+ * If no such, returns @size.
+ */
+static inline
+unsigned long find_nth_notandnot_bit(const unsigned long *addr1, const unsigned long *addr2,
+				unsigned long size, unsigned long n)
+{
+	if (n >= size)
+		return size;
+
+	if (small_const_nbits(size)) {
+		unsigned long val = (~*addr1) & (~*addr2) & GENMASK(size - 1, 0);
+
+		return val ? fns(val, n) : size;
+	}
+
+	return __find_nth_notandnot_bit(addr1, addr2, size, n);
+}
+
 /**
  * find_nth_and_andnot_bit - find N'th set bit in 2 memory regions,
  *			     excluding those set in 3rd region
@@ -347,6 +410,57 @@ unsigned long find_first_and_bit(const unsigned long *addr1,
 }
 #endif
 
+#ifndef find_first_andnot_bit
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
+static inline
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
+#endif
+
+#ifndef find_first_notandnot_bit
+/**
+ * find_first_notandnot_bit - find the first cleared bit in 2 memory regions
+ * @addr1: The first address to base the search on
+ * @addr2: The second address to base the search on
+ * @size: The bitmap size in bits
+ *
+ * Returns the bit number for the next cleared bit.
+ * If no bits are set, returns @size.
+ */
+static inline
+unsigned long find_first_notandnot_bit(const unsigned long *addr1,
+				 const unsigned long *addr2,
+				 unsigned long size)
+{
+	if (small_const_nbits(size)) {
+		unsigned long val = (~*addr1) & (~*addr2) & GENMASK(size - 1, 0);
+
+		return val ? __ffs(val) : size;
+	}
+
+	return _find_first_notandnot_bit(addr1, addr2, size);
+}
+#endif
+
 /**
  * find_first_and_and_bit - find the first set bit in 3 memory regions
  * @addr1: The first address to base the search on
diff --git a/lib/find_bit.c b/lib/find_bit.c
index 0836bb3d76c5..b4a3dd62a255 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -116,6 +116,32 @@ unsigned long _find_first_and_bit(const unsigned long *addr1,
 EXPORT_SYMBOL(_find_first_and_bit);
 #endif
 
+#ifndef find_first_andnot_bit
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
+#endif
+
+#ifndef find_first_notandnot_bit
+/*
+ * Find the first cleared bit in two memory regions.
+ */
+unsigned long _find_first_notandnot_bit(const unsigned long *addr1,
+				  const unsigned long *addr2,
+				  unsigned long size)
+{
+	return FIND_FIRST_BIT(~addr1[idx] & ~addr2[idx], /* nop */, size);
+}
+EXPORT_SYMBOL(_find_first_notandnot_bit);
+#endif
+
 /*
  * Find the first set bit in three memory regions.
  */
@@ -167,6 +193,13 @@ unsigned long __find_nth_andnot_bit(const unsigned long *addr1, const unsigned l
 }
 EXPORT_SYMBOL(__find_nth_andnot_bit);
 
+unsigned long __find_nth_notandnot_bit(const unsigned long *addr1, const unsigned long *addr2,
+				 unsigned long size, unsigned long n)
+{
+	return FIND_NTH_BIT(~addr1[idx] & ~addr2[idx], size, n);
+}
+EXPORT_SYMBOL(__find_nth_notandnot_bit);
+
 unsigned long __find_nth_and_andnot_bit(const unsigned long *addr1,
 					const unsigned long *addr2,
 					const unsigned long *addr3,
@@ -194,6 +227,15 @@ unsigned long _find_next_andnot_bit(const unsigned long *addr1, const unsigned l
 EXPORT_SYMBOL(_find_next_andnot_bit);
 #endif
 
+#ifndef find_next_notandnot_bit
+unsigned long _find_next_notandnot_bit(const unsigned long *addr1, const unsigned long *addr2,
+					unsigned long nbits, unsigned long start)
+{
+	return FIND_NEXT_BIT(~addr1[idx] & ~addr2[idx], /* nop */, nbits, start);
+}
+EXPORT_SYMBOL(_find_next_notandnot_bit);
+#endif
+
 #ifndef find_next_or_bit
 unsigned long _find_next_or_bit(const unsigned long *addr1, const unsigned long *addr2,
 					unsigned long nbits, unsigned long start)
-- 
2.39.2


