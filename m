Return-Path: <linux-kernel+bounces-205301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC09E8FFA84
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A3D81F25CB2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AEB14E2DB;
	Fri,  7 Jun 2024 04:26:57 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A4A1C2AF
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734416; cv=none; b=AzR5XRDBQAJs0A0d5V5ABFycki1VxQBYufKHyTkU6kK/O4TsyYlsgcbJyzww5P2WhPOQL7Dn0PxpLuE7EYN1361t4EPOQwMJrJtEc0GEmTzIzETwS8BS2qavcFYtkDO5sF/I1ibM3fnjgjmUR0/Oy0ktoupbIZiQ4/P8PggmUXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734416; c=relaxed/simple;
	bh=yRKUSeI/oGM9RyHCJz4KQ0eESRc5XMpsFjC/22BH/Jk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RbTEQzSoDQhsJtLwMclYM2Ze+Kj3FzVi3tZ/EJ3eVBtkeQxw064R4NJXmB0rkZCFM6YJaOEuVKDnBPcxaQFYQ8Z9nJgwXXZAQIMoQPJzXmb8UIbTPUMNGdbQZiZuPbBdng4Yh+JXTZACnPpkOdLzz8gWiPIcFEu/DuERma8ouEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VwSmR0KXjzdZdd;
	Fri,  7 Jun 2024 12:25:27 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id EC8B21400D5;
	Fri,  7 Jun 2024 12:26:51 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:26:47 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 028/110] ubifs-utils: Add sorting implementations
Date: Fri, 7 Jun 2024 12:24:53 +0800
Message-ID: <20240607042615.2069840-29-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240607042615.2069840-1-chengzhihao1@huawei.com>
References: <20240607042615.2069840-1-chengzhihao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600013.china.huawei.com (7.193.23.68)

Add sorting implementations, because the sorting function
is used in UBIFS linux kernel libs.

This is a preparation for replacing implementation of UBIFS utils with
linux kernel libs.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/Makemodule.am |   2 +
 ubifs-utils/common/sort.c | 274 ++++++++++++++++++++++++++++++++++++++++++++++
 ubifs-utils/common/sort.h |  20 ++++
 3 files changed, 296 insertions(+)
 create mode 100644 ubifs-utils/common/sort.c
 create mode 100644 ubifs-utils/common/sort.h

diff --git a/ubifs-utils/Makemodule.am b/ubifs-utils/Makemodule.am
index ece8a6e9..3329b6f9 100644
--- a/ubifs-utils/Makemodule.am
+++ b/ubifs-utils/Makemodule.am
@@ -10,6 +10,8 @@ common_SOURCES = \
 	ubifs-utils/common/rwsem.h \
 	ubifs-utils/common/kmem.h \
 	ubifs-utils/common/kmem.c \
+	ubifs-utils/common/sort.h \
+	ubifs-utils/common/sort.c \
 	ubifs-utils/common/defs.h \
 	ubifs-utils/common/crc16.h \
 	ubifs-utils/common/crc16.c \
diff --git a/ubifs-utils/common/sort.c b/ubifs-utils/common/sort.c
new file mode 100644
index 00000000..d585836d
--- /dev/null
+++ b/ubifs-utils/common/sort.c
@@ -0,0 +1,274 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A fast, small, non-recursive O(n log n) sort for the Linux kernel
+ *
+ * This performs n*log2(n) + 0.37*n + o(n) comparisons on average,
+ * and 1.5*n*log2(n) + O(n) in the (very contrived) worst case.
+ *
+ * Glibc qsort() manages n*log2(n) - 1.26*n for random inputs (1.63*n
+ * better) at the expense of stack usage and much larger code to avoid
+ * quicksort's O(n^2) worst case.
+ */
+
+#include <stdio.h>
+#include <stdbool.h>
+#include <linux/types.h>
+
+#include "sort.h"
+#include "linux_types.h"
+
+/**
+ * is_aligned - is this pointer & size okay for word-wide copying?
+ * @base: pointer to data
+ * @size: size of each element
+ * @align: required alignment (typically 4 or 8)
+ *
+ * Returns true if elements can be copied using word loads and stores.
+ * The size must be a multiple of the alignment.
+ *
+ * For some reason, gcc doesn't know to optimize "if (a & mask || b & mask)"
+ * to "if ((a | b) & mask)", so we do that by hand.
+ */
+__const __always_inline
+static bool is_aligned(const void *base, size_t size, unsigned char align)
+{
+	unsigned char lsbits = (unsigned char)size;
+
+	(void)base;
+	return (lsbits & (align - 1)) == 0;
+}
+
+/**
+ * swap_words_32 - swap two elements in 32-bit chunks
+ * @a: pointer to the first element to swap
+ * @b: pointer to the second element to swap
+ * @n: element size (must be a multiple of 4)
+ *
+ * Exchange the two objects in memory.  This exploits base+index addressing,
+ * which basically all CPUs have, to minimize loop overhead computations.
+ *
+ * For some reason, on x86 gcc 7.3.0 adds a redundant test of n at the
+ * bottom of the loop, even though the zero flag is still valid from the
+ * subtract (since the intervening mov instructions don't alter the flags).
+ * Gcc 8.1.0 doesn't have that problem.
+ */
+static void swap_words_32(void *a, void *b, size_t n)
+{
+	do {
+		u32 t = *(u32 *)(a + (n -= 4));
+		*(u32 *)(a + n) = *(u32 *)(b + n);
+		*(u32 *)(b + n) = t;
+	} while (n);
+}
+
+/**
+ * swap_words_64 - swap two elements in 64-bit chunks
+ * @a: pointer to the first element to swap
+ * @b: pointer to the second element to swap
+ * @n: element size (must be a multiple of 8)
+ *
+ * Exchange the two objects in memory.  This exploits base+index
+ * addressing, which basically all CPUs have, to minimize loop overhead
+ * computations.
+ *
+ * We'd like to use 64-bit loads if possible.  If they're not, emulating
+ * one requires base+index+4 addressing which x86 has but most other
+ * processors do not.
+ */
+static void swap_words_64(void *a, void *b, size_t n)
+{
+	do {
+		u64 t = *(u64 *)(a + (n -= 8));
+		*(u64 *)(a + n) = *(u64 *)(b + n);
+		*(u64 *)(b + n) = t;
+	} while (n);
+}
+
+/**
+ * swap_bytes - swap two elements a byte at a time
+ * @a: pointer to the first element to swap
+ * @b: pointer to the second element to swap
+ * @n: element size
+ *
+ * This is the fallback if alignment doesn't allow using larger chunks.
+ */
+static void swap_bytes(void *a, void *b, size_t n)
+{
+	do {
+		char t = ((char *)a)[--n];
+		((char *)a)[n] = ((char *)b)[n];
+		((char *)b)[n] = t;
+	} while (n);
+}
+
+/*
+ * The values are arbitrary as long as they can't be confused with
+ * a pointer, but small integers make for the smallest compare
+ * instructions.
+ */
+#define SWAP_WORDS_64 (swap_r_func_t)0
+#define SWAP_WORDS_32 (swap_r_func_t)1
+#define SWAP_BYTES    (swap_r_func_t)2
+#define SWAP_WRAPPER  (swap_r_func_t)3
+
+struct wrapper {
+	cmp_func_t cmp;
+	swap_func_t swap;
+};
+
+/*
+ * The function pointer is last to make tail calls most efficient if the
+ * compiler decides not to inline this function.
+ */
+static void do_swap(void *a, void *b, size_t size, swap_r_func_t swap_func, const void *priv)
+{
+	if (swap_func == SWAP_WRAPPER) {
+		((const struct wrapper *)priv)->swap(a, b, (int)size);
+		return;
+	}
+
+	if (swap_func == SWAP_WORDS_64)
+		swap_words_64(a, b, size);
+	else if (swap_func == SWAP_WORDS_32)
+		swap_words_32(a, b, size);
+	else if (swap_func == SWAP_BYTES)
+		swap_bytes(a, b, size);
+	else
+		swap_func(a, b, (int)size, priv);
+}
+
+#define _CMP_WRAPPER ((cmp_r_func_t)0L)
+
+static int do_cmp(const void *a, const void *b, cmp_r_func_t cmp, const void *priv)
+{
+	if (cmp == _CMP_WRAPPER)
+		return ((const struct wrapper *)priv)->cmp(a, b);
+	return cmp(a, b, priv);
+}
+
+/**
+ * parent - given the offset of the child, find the offset of the parent.
+ * @i: the offset of the heap element whose parent is sought.  Non-zero.
+ * @lsbit: a precomputed 1-bit mask, equal to "size & -size"
+ * @size: size of each element
+ *
+ * In terms of array indexes, the parent of element j = @i/@size is simply
+ * (j-1)/2.  But when working in byte offsets, we can't use implicit
+ * truncation of integer divides.
+ *
+ * Fortunately, we only need one bit of the quotient, not the full divide.
+ * @size has a least significant bit.  That bit will be clear if @i is
+ * an even multiple of @size, and set if it's an odd multiple.
+ *
+ * Logically, we're doing "if (i & lsbit) i -= size;", but since the
+ * branch is unpredictable, it's done with a bit of clever branch-free
+ * code instead.
+ */
+__const __always_inline
+static size_t parent(size_t i, unsigned int lsbit, size_t size)
+{
+	i -= size;
+	i -= size & -(i & lsbit);
+	return i / 2;
+}
+
+/**
+ * sort_r - sort an array of elements
+ * @base: pointer to data to sort
+ * @num: number of elements
+ * @size: size of each element
+ * @cmp_func: pointer to comparison function
+ * @swap_func: pointer to swap function or NULL
+ * @priv: third argument passed to comparison function
+ *
+ * This function does a heapsort on the given array.  You may provide
+ * a swap_func function if you need to do something more than a memory
+ * copy (e.g. fix up pointers or auxiliary data), but the built-in swap
+ * avoids a slow retpoline and so is significantly faster.
+ *
+ * Sorting time is O(n log n) both on average and worst-case. While
+ * quicksort is slightly faster on average, it suffers from exploitable
+ * O(n*n) worst-case behavior and extra memory requirements that make
+ * it less suitable for kernel use.
+ */
+void sort_r(void *base, size_t num, size_t size,
+	    cmp_r_func_t cmp_func,
+	    swap_r_func_t swap_func,
+	    const void *priv)
+{
+	/* pre-scale counters for performance */
+	size_t n = num * size, a = (num/2) * size;
+	const unsigned int lsbit = size & -size;  /* Used to find parent */
+
+	if (!a)		/* num < 2 || size == 0 */
+		return;
+
+	/* called from 'sort' without swap function, let's pick the default */
+	if (swap_func == SWAP_WRAPPER && !((struct wrapper *)priv)->swap)
+		swap_func = NULL;
+
+	if (!swap_func) {
+		if (is_aligned(base, size, 8))
+			swap_func = SWAP_WORDS_64;
+		else if (is_aligned(base, size, 4))
+			swap_func = SWAP_WORDS_32;
+		else
+			swap_func = SWAP_BYTES;
+	}
+
+	/*
+	 * Loop invariants:
+	 * 1. elements [a,n) satisfy the heap property (compare greater than
+	 *    all of their children),
+	 * 2. elements [n,num*size) are sorted, and
+	 * 3. a <= b <= c <= d <= n (whenever they are valid).
+	 */
+	for (;;) {
+		size_t b, c, d;
+
+		if (a)			/* Building heap: sift down --a */
+			a -= size;
+		else if (n -= size)	/* Sorting: Extract root to --n */
+			do_swap(base, base + n, size, swap_func, priv);
+		else			/* Sort complete */
+			break;
+
+		/*
+		 * Sift element at "a" down into heap.  This is the
+		 * "bottom-up" variant, which significantly reduces
+		 * calls to cmp_func(): we find the sift-down path all
+		 * the way to the leaves (one compare per level), then
+		 * backtrack to find where to insert the target element.
+		 *
+		 * Because elements tend to sift down close to the leaves,
+		 * this uses fewer compares than doing two per level
+		 * on the way down.  (A bit more than half as many on
+		 * average, 3/4 worst-case.)
+		 */
+		for (b = a; c = 2*b + size, (d = c + size) < n;)
+			b = do_cmp(base + c, base + d, cmp_func, priv) >= 0 ? c : d;
+		if (d == n)	/* Special case last leaf with no sibling */
+			b = c;
+
+		/* Now backtrack from "b" to the correct location for "a" */
+		while (b != a && do_cmp(base + a, base + b, cmp_func, priv) >= 0)
+			b = parent(b, lsbit, size);
+		c = b;			/* Where "a" belongs */
+		while (b != a) {	/* Shift it into place */
+			b = parent(b, lsbit, size);
+			do_swap(base + b, base + c, size, swap_func, priv);
+		}
+	}
+}
+
+void sort(void *base, size_t num, size_t size,
+	  cmp_func_t cmp_func,
+	  swap_func_t swap_func)
+{
+	struct wrapper w = {
+		.cmp  = cmp_func,
+		.swap = swap_func,
+	};
+
+	return sort_r(base, num, size, _CMP_WRAPPER, SWAP_WRAPPER, &w);
+}
diff --git a/ubifs-utils/common/sort.h b/ubifs-utils/common/sort.h
new file mode 100644
index 00000000..89829422
--- /dev/null
+++ b/ubifs-utils/common/sort.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_SORT_H
+#define _LINUX_SORT_H
+
+typedef void (*swap_r_func_t)(void *a, void *b, int size, const void *priv);
+typedef void (*swap_func_t)(void *a, void *b, int size);
+
+typedef int (*cmp_r_func_t)(const void *a, const void *b, const void *priv);
+typedef int (*cmp_func_t)(const void *a, const void *b);
+
+void sort_r(void *base, size_t num, size_t size,
+	    cmp_r_func_t cmp_func,
+	    swap_r_func_t swap_func,
+	    const void *priv);
+
+void sort(void *base, size_t num, size_t size,
+	  cmp_func_t cmp_func,
+	  swap_func_t swap_func);
+
+#endif
-- 
2.13.6


