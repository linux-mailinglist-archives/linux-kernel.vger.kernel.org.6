Return-Path: <linux-kernel+bounces-309357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5876C966951
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 21:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B57A1C2164B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 19:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69A81BD035;
	Fri, 30 Aug 2024 19:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="JHTSylWx"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E491B375E
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 19:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725045074; cv=none; b=bCWAFhqThCM0P5eNT5tFly68aT9ZfbfvLlv8HOsdpxZP3w4qp2y3/rmWKkqJ67UaU+JRGGHfHeLAJyGlVncZY67UZcIuAJcDb/HTGjp82tatQ88mRQJc6IgbM74nT50qV6IPIsXGYT7PkXlserd/hGFK0nLYugKm5LWsWiCBEVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725045074; c=relaxed/simple;
	bh=mSlbGJz8j44ZPE+sDl5Lu+E4GWu7DyDgzRUR10EQ6Ys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GwCMAxOa51iKZzVvKYk18MBxneWbyv/3t/nGaXmIpWW3aNUza+5Sec2N8bXCJ+UhHevoZCYBclx0x7VqhRuV6dVCYhfc6mIQLgG9PGnoshW3QL5VfgZSRFZn0KjOqaiycdwFMUqFot3Y9AOTIVfJhyH0nUe/uhBELu4KqZLwsiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=JHTSylWx; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1725045071;
	bh=mSlbGJz8j44ZPE+sDl5Lu+E4GWu7DyDgzRUR10EQ6Ys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JHTSylWxBG4FVA3RizCacwvwEbALeTW+cfabR3VlpeOFXPSNpouIRx5VKqJI7EvvK
	 nNhkcGvZawaANoXaWttpemdCnQcVDmWt7KUTZziLocBRg6TEmkCM4UUprUHs1sHLjs
	 LCcrRGgzn5PjaVg/rydbSE0EO9rOwISneJPbH37jI26VF/Rhjr1OzVriFp2PtoXZ3M
	 44hHkJGSsGSH+1/wN4PszivZRa3kmoIZZrE/ZN9Uddxeop+1nQOBz9+/dJv8tnEN56
	 1VFcduGSmWCRrBE5kxH0bke73Sy4TzELeaDaPfGvBL6YQiNw6d9u2eAaZOST+QtMoq
	 +7LdrMtj39YJw==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4WwSRg284Zz1Jk1;
	Fri, 30 Aug 2024 15:11:11 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v3 3/6] lib: test bitmap sets binary operation iterators
Date: Fri, 30 Aug 2024 15:10:40 -0400
Message-Id: <20240830191043.1028827-4-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240830191043.1028827-1-mathieu.desnoyers@efficios.com>
References: <20240830191043.1028827-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test the following bitmap iterators applying binary operations on sets
of two bitmaps:

- for_each_and_bit,
- for_each_andnot_bit,
- for_each_nor_bit,
- for_each_or_bit.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 lib/test_bitmap.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 6dfb8d46a4ff..96ce3c78c7fa 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -184,6 +184,32 @@ __check_eq_str(const char *srcfile, unsigned int line,
 		result;							\
 	})
 
+static bool __init
+__check_neq_range_ulong(const char *srcfile, unsigned int line,
+		 const unsigned long exp_ulong_begin,
+		 const unsigned long exp_ulong_end,
+		 unsigned long x)
+{
+	if (exp_ulong_begin <= x && exp_ulong_end >= x) {
+		pr_err("[%s:%u] did not value %lu within range [%lu,%lu]\n",
+			srcfile, line, x, exp_ulong_begin, exp_ulong_end);
+		return false;
+	}
+	return true;
+}
+
+#define __expect_neq_range(suffix, ...)					\
+	({								\
+		int result = 0;						\
+		total_tests++;						\
+		if (!__check_neq_range_ ## suffix(__FILE__, __LINE__,	\
+					   ##__VA_ARGS__)) {		\
+			failed_tests++;					\
+			result = 1;					\
+		}							\
+		result;							\
+	})
+
 #define expect_eq_ulong(...)		__expect_eq(ulong, ##__VA_ARGS__)
 #define expect_eq_uint(x, y)		expect_eq_ulong((unsigned int)(x), (unsigned int)(y))
 #define expect_eq_bitmap(...)		__expect_eq(bitmap, ##__VA_ARGS__)
@@ -192,6 +218,9 @@ __check_eq_str(const char *srcfile, unsigned int line,
 #define expect_eq_clump8(...)		__expect_eq(clump8, ##__VA_ARGS__)
 #define expect_eq_str(...)		__expect_eq(str, ##__VA_ARGS__)
 
+#define expect_neq_range_ulong(...)		__expect_neq_range(ulong, ##__VA_ARGS__)
+#define expect_neq_range_uint(begin, end, y)	expect_neq_range_ulong((unsigned int)(begin), (unsigned int) end, (unsigned int)(y))
+
 static void __init test_zero_clear(void)
 {
 	DECLARE_BITMAP(bmap, 1024);
@@ -849,6 +878,57 @@ static void __init test_for_each_set_bit(void)
 	expect_eq_bitmap(orig, copy, 500);
 }
 
+static void __init test_for_each_binaryops_bit(void)
+{
+	DECLARE_BITMAP(orig1, 500);
+	DECLARE_BITMAP(orig2, 500);
+	unsigned int bit, count;
+
+	bitmap_zero(orig1, 500);
+	bitmap_zero(orig2, 500);
+
+	/* Set individual bits in orig1 and orig2 with stride 10 (expected in both orig1 & orig2) */
+	for (bit = 0; bit < 500; bit += 10) {
+		bitmap_set(orig1, bit, 1);
+		bitmap_set(orig2, bit, 1);
+	}
+	/* Set individual bits in orig1 with offset 1, stride 10 (expected in orig1 only) */
+	for (bit = 1; bit < 500; bit += 10)
+		bitmap_set(orig1, bit, 1);
+	/* Set individual bits in orig2 with offset 2, stride 10 (expected in orig2 only). */
+	for (bit = 2; bit < 500; bit += 10)
+		bitmap_set(orig2, bit, 1);
+
+	count = 0;
+	for_each_and_bit(bit, orig1, orig2, 500) {	/* orig1 & orig2 */
+		expect_neq_range_uint(1, 9, bit % 10);
+		count++;
+	}
+	expect_eq_uint(50, count);
+
+	count = 0;
+	for_each_andnot_bit(bit, orig1, orig2, 500) {	/* orig1 & ~orig2 */
+		expect_neq_range_uint(0, 0, bit % 10);
+		expect_neq_range_uint(2, 9, bit % 10);
+		count++;
+	}
+	expect_eq_uint(50, count);
+
+	count = 0;
+	for_each_nor_bit(bit, orig1, orig2, 500) {	/* ~(orig1 | orig2) */
+		expect_neq_range_uint(0, 2, bit % 10);
+		count++;
+	}
+	expect_eq_uint(7 * 50, count);
+
+	count = 0;
+	for_each_or_bit(bit, orig1, orig2, 500) {	/* orig1 | orig2 */
+		expect_neq_range_uint(3, 9, bit % 10);
+		count++;
+	}
+	expect_eq_uint(3 * 50, count);
+}
+
 static void __init test_for_each_set_bit_from(void)
 {
 	DECLARE_BITMAP(orig, 500);
@@ -1482,6 +1562,7 @@ static void __init selftest(void)
 	test_for_each_clear_bitrange_from();
 	test_for_each_set_clump8();
 	test_for_each_set_bit_wrap();
+	test_for_each_binaryops_bit();
 }
 
 KSTM_MODULE_LOADERS(test_bitmap);
-- 
2.39.2


