Return-Path: <linux-kernel+bounces-309358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BCF966952
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 21:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76A3D1C215DF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 19:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FC71BD039;
	Fri, 30 Aug 2024 19:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="dwsVbZJj"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825D61BAEDE
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 19:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725045074; cv=none; b=WZrP764k73C23DCeNZhCl8Gxpa/3R9YrQlPgVQtzUvIPZfyDsJqk9DyL9sRl/feZpyrUG/n7+kuklOvjYWG5mW32yl6OTRIx1/sMkev/FIFQUIo9Gr9maqESxJskwVs6pPlkTxm525XQtIu8beZx9bQiOF8h1Vp4uW6b82yVY1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725045074; c=relaxed/simple;
	bh=9Uj3/VQbpr4+TFsjkAbUH7PZHPe4UnTPFjOJXxx1hRg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gy6comGRRrPgFlWTpj8wWGK8nZK63Fbopz1TiHTuYUAfqc88+HkFRhpAnyvaY7UjddUDhVB8GtkQnWqwe0rHe63GsjLxqqbwBw3HnlcZpS/jEX8okUtlDH1gSYroY5O5QlRIO3o3R32dXCOoa+u9b7ZjIOmxC6wn0ee+fuSRlnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=dwsVbZJj; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1725045071;
	bh=9Uj3/VQbpr4+TFsjkAbUH7PZHPe4UnTPFjOJXxx1hRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dwsVbZJj8Z42vlgUtBZvDqHWtYsRctUT99FsG0b2sh2D8H2KiHofU8caGSA4SUqt0
	 gt13WE942927nOvca7ejEU3r++DarBCIrdpWmARj0dHjZ4NKDmr8bGIdYfOdM0y1L+
	 Z515MQGN8B9oLBCrLgj56onoeDycoesTVqniyUCbf9a8fB9Qsalv6lvFJPYuEr46OJ
	 xwvKosS+A/1GX7UnRieWQvRLHcKyPQH0kl4NS/B+AO6igzvYWr0mg6sLw9vhgYX6U5
	 iykLkhoPPvqFakA97vnycB7KUmmQqExF8vlQm8wEM9AhZg36jHfChXb4vwTK1uhk30
	 JU5ujdsXsl2Xw==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4WwSRg3NvPz1Jk2;
	Fri, 30 Aug 2024 15:11:11 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v3 4/6] lib: Fix test_find_first_and_bit and test_find_next_and_bit benchmark
Date: Fri, 30 Aug 2024 15:10:41 -0400
Message-Id: <20240830191043.1028827-5-mathieu.desnoyers@efficios.com>
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

Modify test_find_first_bit so it modifies a local copy of bitmap rather
than modifying the input bitmap, which removes the requirement of
placing it last in the tests.

Calls to test_find_first_and_bit and test_find_next_and_bit are placed
after test_find_first_bit, which makes them use a bitmap entirely filled
rather than the expected bitmap (random-filled or sparse).

Use bitmap_alloc rather than a local static variable in test_find_first_bit
and test_find_first_and_bit. Only clear bits when find bit returns a
value within range, which causes an out-of-bound access otherwise.

Use BITMAP_LEN / 10 for all find_first tests to ensure they run within a
few ms each.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
Changes since v2:
- Use bitmap_alloc rather than a local static variable in test_find_first_bit
  and test_find_first_and_bit.
- Use BITMAP_LEN / 10 for all find_first tests.
- Use len parameter rather than BITMAP_LEN.
- Only clear bits when find bit returns a value within range.
---
 lib/find_bit_benchmark.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/lib/find_bit_benchmark.c b/lib/find_bit_benchmark.c
index d3fb09e6eff1..81d358fb459b 100644
--- a/lib/find_bit_benchmark.c
+++ b/lib/find_bit_benchmark.c
@@ -30,18 +30,21 @@ static DECLARE_BITMAP(bitmap, BITMAP_LEN) __initdata;
 static DECLARE_BITMAP(bitmap2, BITMAP_LEN) __initdata;
 
 /*
- * This is Schlemiel the Painter's algorithm. It should be called after
- * all other tests for the same bitmap because it sets all bits of bitmap to 1.
+ * This is Schlemiel the Painter's algorithm.
  */
 static int __init test_find_first_bit(void *bitmap, unsigned long len)
 {
+	unsigned long *cp __free(bitmap) = bitmap_alloc(len, GFP_KERNEL);
 	unsigned long i, cnt;
 	ktime_t time;
 
+	bitmap_copy(cp, bitmap, len);
+
 	time = ktime_get();
 	for (cnt = i = 0; i < len; cnt++) {
-		i = find_first_bit(bitmap, len);
-		__clear_bit(i, bitmap);
+		i = find_first_bit(cp, len);
+		if (i < len)
+			__clear_bit(i, cp);
 	}
 	time = ktime_get() - time;
 	pr_err("find_first_bit:     %18llu ns, %6ld iterations\n", time, cnt);
@@ -51,16 +54,17 @@ static int __init test_find_first_bit(void *bitmap, unsigned long len)
 
 static int __init test_find_first_and_bit(void *bitmap, const void *bitmap2, unsigned long len)
 {
-	static DECLARE_BITMAP(cp, BITMAP_LEN) __initdata;
+	unsigned long *cp __free(bitmap) = bitmap_alloc(len, GFP_KERNEL);
 	unsigned long i, cnt;
 	ktime_t time;
 
-	bitmap_copy(cp, bitmap, BITMAP_LEN);
+	bitmap_copy(cp, bitmap, len);
 
 	time = ktime_get();
 	for (cnt = i = 0; i < len; cnt++) {
 		i = find_first_and_bit(cp, bitmap2, len);
-		__clear_bit(i, cp);
+		if (i < len)
+			__clear_bit(i, cp);
 	}
 	time = ktime_get() - time;
 	pr_err("find_first_and_bit: %18llu ns, %6ld iterations\n", time, cnt);
@@ -165,7 +169,7 @@ static int __init find_bit_test(void)
 	 * traverse only part of bitmap to avoid soft lockup.
 	 */
 	test_find_first_bit(bitmap, BITMAP_LEN / 10);
-	test_find_first_and_bit(bitmap, bitmap2, BITMAP_LEN / 2);
+	test_find_first_and_bit(bitmap, bitmap2, BITMAP_LEN / 10);
 	test_find_next_and_bit(bitmap, bitmap2, BITMAP_LEN);
 
 	pr_err("\nStart testing find_bit() with sparse bitmap\n");
@@ -182,8 +186,8 @@ static int __init find_bit_test(void)
 	test_find_next_zero_bit(bitmap, BITMAP_LEN);
 	test_find_last_bit(bitmap, BITMAP_LEN);
 	test_find_nth_bit(bitmap, BITMAP_LEN);
-	test_find_first_bit(bitmap, BITMAP_LEN);
-	test_find_first_and_bit(bitmap, bitmap2, BITMAP_LEN);
+	test_find_first_bit(bitmap, BITMAP_LEN / 10);
+	test_find_first_and_bit(bitmap, bitmap2, BITMAP_LEN / 10);
 	test_find_next_and_bit(bitmap, bitmap2, BITMAP_LEN);
 
 	/*
-- 
2.39.2


