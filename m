Return-Path: <linux-kernel+bounces-307062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B5896476B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 16:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6925281A72
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 14:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A061B1414;
	Thu, 29 Aug 2024 14:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="OTTGS7gy"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F26C1AE854
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 14:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724940011; cv=none; b=kfg1b8n6BI7nuV45X2bUkHUlzGDvu8l3RZe0o5sHO05Gme6lsq9XHtl6LVQD2/NAmZYcpWCRytbdTN3rBr0KUB3gMGT9di6keYAiLra2Y9Nj05hxFw7DHxprMWo/pDKXkmKtB23ghtJVk4wiv/YudT+PlB7ZgPS8vCeiwkttVCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724940011; c=relaxed/simple;
	bh=KdXiOvXe3KSszStvVJj4Th0Hm05YrgAvrJXDPd4DUs4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zd4epGRPafpryLCR/QkTFCNYW8RyvWAxQYT4ipDIGo7inIWCc4ioiSl7osVnfBYNflJYUN35Zh17Fo5hrpBuIafdm78KC8LZqgpWqop4MNFEDTJ7zbhw/m7XaGawcLjWdoTmVmEu4VORy1JF/wCSpTtVFvtcpFI3ER756tFW7g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=OTTGS7gy; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1724940000;
	bh=KdXiOvXe3KSszStvVJj4Th0Hm05YrgAvrJXDPd4DUs4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OTTGS7gyXAZqvgCmOFPQUW47uzXn+4BuGQ1vk92uC8FErUI+ryHONu3HbVgUAL9r3
	 KLGIzIgj1t98d3aE2tOh6QN+lzIY9NfD8+V/7XDcuMILTyWJvXSX5GbvqGHWwFvSpV
	 taqxJoLFt+eLW30o/ZOBoZpZk4i6PYKKtexkqQB8vZlyAOKA2aOjh4/U+E67rdu45U
	 BS4WtiYfYMVwSXcuGQKedVjzs3UgJ0vElonG8xZBfm6ztef42e6zI039Ty2Le2CUWG
	 r6OwZBjEgojrC8iMsU5IKd18KdcrXgEXNGGDeLRDeF+HLAo0Sx52He54br5hkkSGEb
	 C4mJM3ppWAsUQ==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Wvjb36w1cz1JQh;
	Thu, 29 Aug 2024 09:59:59 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v2 5/6] lib: benchmark bitmap sets binary operation find
Date: Thu, 29 Aug 2024 09:59:25 -0400
Message-Id: <20240829135926.926603-6-mathieu.desnoyers@efficios.com>
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

Benchmark the following bitmap find functions applying binary operations
on sets of two bitmaps:

- find_first_andnot_bit,
- find_first_nor_bit,
- find_next_andnot_bit,
- find_next_nor_bit,
- find_next_or_bit.

Note that find_first_or_bit is not part of the current API, so it is not
covered.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 lib/find_bit_benchmark.c | 93 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/lib/find_bit_benchmark.c b/lib/find_bit_benchmark.c
index aee2ebb6b3cd..3b16254dec23 100644
--- a/lib/find_bit_benchmark.c
+++ b/lib/find_bit_benchmark.c
@@ -70,6 +70,44 @@ static int __init test_find_first_and_bit(void *bitmap, const void *bitmap2, uns
 	return 0;
 }
 
+static int __init test_find_first_andnot_bit(void *bitmap, const void *bitmap2, unsigned long len)
+{
+	static DECLARE_BITMAP(cp, BITMAP_LEN) __initdata;
+	unsigned long i, cnt;
+	ktime_t time;
+
+	bitmap_copy(cp, bitmap, BITMAP_LEN);
+
+	time = ktime_get();
+	for (cnt = i = 0; i < len; cnt++) {
+		i = find_first_andnot_bit(cp, bitmap2, len);
+		__clear_bit(i, cp);
+	}
+	time = ktime_get() - time;
+	pr_err("find_first_andnot_bit: %18llu ns, %6ld iterations\n", time, cnt);
+
+	return 0;
+}
+
+static int __init test_find_first_nor_bit(void *bitmap, const void *bitmap2, unsigned long len)
+{
+	static DECLARE_BITMAP(cp, BITMAP_LEN) __initdata;
+	unsigned long i, cnt;
+	ktime_t time;
+
+	bitmap_copy(cp, bitmap, BITMAP_LEN);
+
+	time = ktime_get();
+	for (cnt = i = 0; i < len; cnt++) {
+		i = find_first_nor_bit(cp, bitmap2, len);
+		__set_bit(i, cp);
+	}
+	time = ktime_get() - time;
+	pr_err("find_first_nor_bit: %18llu ns, %6ld iterations\n", time, cnt);
+
+	return 0;
+}
+
 static int __init test_find_next_bit(const void *bitmap, unsigned long len)
 {
 	unsigned long i, cnt;
@@ -148,6 +186,51 @@ static int __init test_find_next_and_bit(const void *bitmap,
 	return 0;
 }
 
+static int __init test_find_next_andnot_bit(const void *bitmap,
+		const void *bitmap2, unsigned long len)
+{
+	unsigned long i, cnt;
+	ktime_t time;
+
+	time = ktime_get();
+	for (cnt = i = 0; i < BITMAP_LEN; cnt++)
+		i = find_next_andnot_bit(bitmap, bitmap2, BITMAP_LEN, i + 1);
+	time = ktime_get() - time;
+	pr_err("find_next_andnot_bit:  %18llu ns, %6ld iterations\n", time, cnt);
+
+	return 0;
+}
+
+static int __init test_find_next_nor_bit(const void *bitmap,
+		const void *bitmap2, unsigned long len)
+{
+	unsigned long i, cnt;
+	ktime_t time;
+
+	time = ktime_get();
+	for (cnt = i = 0; i < BITMAP_LEN; cnt++)
+		i = find_next_nor_bit(bitmap, bitmap2, BITMAP_LEN, i + 1);
+	time = ktime_get() - time;
+	pr_err("find_next_nor_bit:  %18llu ns, %6ld iterations\n", time, cnt);
+
+	return 0;
+}
+
+static int __init test_find_next_or_bit(const void *bitmap,
+		const void *bitmap2, unsigned long len)
+{
+	unsigned long i, cnt;
+	ktime_t time;
+
+	time = ktime_get();
+	for (cnt = i = 0; i < BITMAP_LEN; cnt++)
+		i = find_next_or_bit(bitmap, bitmap2, BITMAP_LEN, i + 1);
+	time = ktime_get() - time;
+	pr_err("find_next_or_bit:  %18llu ns, %6ld iterations\n", time, cnt);
+
+	return 0;
+}
+
 static int __init find_bit_test(void)
 {
 	unsigned long nbits = BITMAP_LEN / SPARSE;
@@ -169,6 +252,11 @@ static int __init find_bit_test(void)
 	test_find_first_bit(bitmap, BITMAP_LEN / 10);
 	test_find_first_and_bit(bitmap, bitmap2, BITMAP_LEN / 2);
 	test_find_next_and_bit(bitmap, bitmap2, BITMAP_LEN);
+	test_find_first_andnot_bit(bitmap, bitmap2, BITMAP_LEN / 2);
+	test_find_next_andnot_bit(bitmap, bitmap2, BITMAP_LEN);
+	test_find_first_nor_bit(bitmap, bitmap2, BITMAP_LEN / 2);
+	test_find_next_nor_bit(bitmap, bitmap2, BITMAP_LEN);
+	test_find_next_or_bit(bitmap, bitmap2, BITMAP_LEN);
 
 	pr_err("\nStart testing find_bit() with sparse bitmap\n");
 
@@ -187,6 +275,11 @@ static int __init find_bit_test(void)
 	test_find_first_bit(bitmap, BITMAP_LEN);
 	test_find_first_and_bit(bitmap, bitmap2, BITMAP_LEN);
 	test_find_next_and_bit(bitmap, bitmap2, BITMAP_LEN);
+	test_find_first_andnot_bit(bitmap, bitmap2, BITMAP_LEN);
+	test_find_next_andnot_bit(bitmap, bitmap2, BITMAP_LEN);
+	test_find_first_nor_bit(bitmap, bitmap2, BITMAP_LEN);
+	test_find_next_nor_bit(bitmap, bitmap2, BITMAP_LEN);
+	test_find_next_or_bit(bitmap, bitmap2, BITMAP_LEN);
 
 	/*
 	 * Everything is OK. Return error just to let user run benchmark
-- 
2.39.2


