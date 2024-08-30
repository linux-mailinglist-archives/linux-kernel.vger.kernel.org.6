Return-Path: <linux-kernel+bounces-309362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02232966957
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 21:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A9591F24794
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 19:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FD11BE25F;
	Fri, 30 Aug 2024 19:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="aySvJyyr"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77E81BD02C
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 19:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725045076; cv=none; b=OGTkEuR0OOBMjB+oNQLB/xZHgPoEVdW65SB0P0S84Mm98T4lz1jyq3afHjAFpljiQRxP7GkPMSGxSahtFzcCyoLyK/3nU88DLDqg6XfusjzyiMffq1Ww2OQNQ9DpR1rXfVDu7+L+3g5gi4i8msAL88Yxu7Su7M/TQZvxeftFSsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725045076; c=relaxed/simple;
	bh=aePfiYTeMyAz3U6m1iQCHycP01bwRNlRPeuv8aAmuQM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fhhYZVkqUZH04sERZ8nYkDFFMoCcs59Z46fjKtidFGUiD35N2KsGww2ptJrGClfQ0yjL1VIRnhDWMXtXhUJjml16yRY6X/01J6qpMiqzenedaqrEoPXLkMSv9SMv5NqV0R822c02DMhXH8VHSk7Z6GbbgTNHqmDr7zLQrJj4R9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=aySvJyyr; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1725045071;
	bh=aePfiYTeMyAz3U6m1iQCHycP01bwRNlRPeuv8aAmuQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aySvJyyr+BHJ7I3/8TV+GoS/gxRqotbiocx22bJQ6AYhluXQmdFu7nR4BPaifyoSk
	 UkBaUvK9x+zaOxryJTLH0PODEZ8LgEY08obwG3e32qrEeJtZjWZBLlSC15XUOsdLaG
	 BBgnN24iqVv+z+3nUYG9Q64spJYouMJ7524wD1Zf50M2OpBgHHYpz1wGBYQKkBoHWp
	 6uHLc+3uITYQcUgACbkNlXu7KzK6JsmOpu7YvPqVtM9nWoUlN+Rl6jhUZlUMirq+B1
	 HSyWAUqYIvxKgpsOvodTUHKdtFx9txq4RCPsijHyb7tidJzd43zfSxmF8wOjEaVjWu
	 gQfzL8ANJ6KpA==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4WwSRg4d08z1Jk3;
	Fri, 30 Aug 2024 15:11:11 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v3 5/6] lib: benchmark bitmap sets binary operation find
Date: Fri, 30 Aug 2024 15:10:42 -0400
Message-Id: <20240830191043.1028827-6-mathieu.desnoyers@efficios.com>
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

Benchmark the following bitmap find functions applying binary operations
on sets of two bitmaps:

- find_first_andnot_bit,
- find_first_nor_bit,
- find_next_andnot_bit,
- find_next_nor_bit,
- find_next_or_bit.

Note that find_first_or_bit is not part of the current API, so it is not
covered.

Use "len" parameters rather than BITMAP_LEN within all benchmark
functions (changed across the whole file).

Example output:

(AMD EPYC 9654 96-Core Processor)

Start testing find_bit() with random-filled bitmap
find_next_bit:                     595816 ns, 163603 iterations
find_next_zero_bit:                613227 ns, 164078 iterations
find_last_bit:                     464619 ns, 163602 iterations
find_nth_bit:                     2647830 ns,  16413 iterations
find_first_bit:                   1240485 ns,  16414 iterations
find_first_and_bit:                623258 ns,   8136 iterations
find_next_and_bit:                 321039 ns,  81576 iterations
find_first_andnot_bit:             929316 ns,   8279 iterations
find_next_andnot_bit:              324820 ns,  82027 iterations
find_first_nor_bit:                971359 ns,   8241 iterations
find_next_nor_bit:                 346981 ns,  82058 iterations
find_next_or_bit:                  882343 ns, 245623 iterations

Start testing find_bit() with sparse bitmap
find_next_bit:                       8751 ns,    656 iterations
find_next_zero_bit:               1184552 ns, 327025 iterations
find_last_bit:                       8820 ns,    656 iterations
find_nth_bit:                     1111597 ns,    655 iterations
find_first_bit:                      4980 ns,     59 iterations
find_first_and_bit:                   550 ns,      1 iterations
find_next_and_bit:                   3110 ns,      1 iterations
find_first_andnot_bit:               7420 ns,     59 iterations
find_next_andnot_bit:                9500 ns,    656 iterations
find_first_nor_bit:               3889256 ns,  32647 iterations
find_next_nor_bit:                1254026 ns, 326370 iterations
find_next_or_bit:                   14341 ns,   1311 iterations

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
Changes since v2:
- Use bitmap_alloc rather than a local static variable for bitmaps.
- Divide BITMAP_LEN by 10 for all find_first tests to ensure the test
  runs fast enough (a few ms per test).
- Fix alignment of text output.
- Clear/set bits only within range, fixing an out-of-bound access.
- Use "len" parameters rather than BITMAP_LEN within all benchmark
  functions (changed across the whole file).
---
 lib/find_bit_benchmark.c | 119 +++++++++++++++++++++++++++++++++++----
 1 file changed, 107 insertions(+), 12 deletions(-)

diff --git a/lib/find_bit_benchmark.c b/lib/find_bit_benchmark.c
index 81d358fb459b..5ab72829e7ee 100644
--- a/lib/find_bit_benchmark.c
+++ b/lib/find_bit_benchmark.c
@@ -47,7 +47,7 @@ static int __init test_find_first_bit(void *bitmap, unsigned long len)
 			__clear_bit(i, cp);
 	}
 	time = ktime_get() - time;
-	pr_err("find_first_bit:     %18llu ns, %6ld iterations\n", time, cnt);
+	pr_err("find_first_bit:        %18llu ns, %6ld iterations\n", time, cnt);
 
 	return 0;
 }
@@ -67,7 +67,47 @@ static int __init test_find_first_and_bit(void *bitmap, const void *bitmap2, uns
 			__clear_bit(i, cp);
 	}
 	time = ktime_get() - time;
-	pr_err("find_first_and_bit: %18llu ns, %6ld iterations\n", time, cnt);
+	pr_err("find_first_and_bit:    %18llu ns, %6ld iterations\n", time, cnt);
+
+	return 0;
+}
+
+static int __init test_find_first_andnot_bit(void *bitmap, const void *bitmap2, unsigned long len)
+{
+	unsigned long *cp __free(bitmap) = bitmap_alloc(len, GFP_KERNEL);
+	unsigned long i, cnt;
+	ktime_t time;
+
+	bitmap_copy(cp, bitmap, len);
+
+	time = ktime_get();
+	for (cnt = i = 0; i < len; cnt++) {
+		i = find_first_andnot_bit(cp, bitmap2, len);
+		if (i < len)
+			__clear_bit(i, cp);
+	}
+	time = ktime_get() - time;
+	pr_err("find_first_andnot_bit: %18llu ns, %6ld iterations\n", time, cnt);
+
+	return 0;
+}
+
+static int __init test_find_first_nor_bit(void *bitmap, const void *bitmap2, unsigned long len)
+{
+	unsigned long *cp __free(bitmap) = bitmap_alloc(len, GFP_KERNEL);
+	unsigned long i, cnt;
+	ktime_t time;
+
+	bitmap_copy(cp, bitmap, len);
+
+	time = ktime_get();
+	for (cnt = i = 0; i < len; cnt++) {
+		i = find_first_nor_bit(cp, bitmap2, len);
+		if (i < len)
+			__set_bit(i, cp);
+	}
+	time = ktime_get() - time;
+	pr_err("find_first_nor_bit:    %18llu ns, %6ld iterations\n", time, cnt);
 
 	return 0;
 }
@@ -78,10 +118,10 @@ static int __init test_find_next_bit(const void *bitmap, unsigned long len)
 	ktime_t time;
 
 	time = ktime_get();
-	for (cnt = i = 0; i < BITMAP_LEN; cnt++)
-		i = find_next_bit(bitmap, BITMAP_LEN, i) + 1;
+	for (cnt = i = 0; i < len; cnt++)
+		i = find_next_bit(bitmap, len, i) + 1;
 	time = ktime_get() - time;
-	pr_err("find_next_bit:      %18llu ns, %6ld iterations\n", time, cnt);
+	pr_err("find_next_bit:         %18llu ns, %6ld iterations\n", time, cnt);
 
 	return 0;
 }
@@ -92,10 +132,10 @@ static int __init test_find_next_zero_bit(const void *bitmap, unsigned long len)
 	ktime_t time;
 
 	time = ktime_get();
-	for (cnt = i = 0; i < BITMAP_LEN; cnt++)
+	for (cnt = i = 0; i < len; cnt++)
 		i = find_next_zero_bit(bitmap, len, i) + 1;
 	time = ktime_get() - time;
-	pr_err("find_next_zero_bit: %18llu ns, %6ld iterations\n", time, cnt);
+	pr_err("find_next_zero_bit:    %18llu ns, %6ld iterations\n", time, cnt);
 
 	return 0;
 }
@@ -114,7 +154,7 @@ static int __init test_find_last_bit(const void *bitmap, unsigned long len)
 		len = l;
 	} while (len);
 	time = ktime_get() - time;
-	pr_err("find_last_bit:      %18llu ns, %6ld iterations\n", time, cnt);
+	pr_err("find_last_bit:         %18llu ns, %6ld iterations\n", time, cnt);
 
 	return 0;
 }
@@ -130,7 +170,7 @@ static int __init test_find_nth_bit(const unsigned long *bitmap, unsigned long l
 		WARN_ON(l >= len);
 	}
 	time = ktime_get() - time;
-	pr_err("find_nth_bit:       %18llu ns, %6ld iterations\n", time, w);
+	pr_err("find_nth_bit:          %18llu ns, %6ld iterations\n", time, w);
 
 	return 0;
 }
@@ -142,10 +182,55 @@ static int __init test_find_next_and_bit(const void *bitmap,
 	ktime_t time;
 
 	time = ktime_get();
-	for (cnt = i = 0; i < BITMAP_LEN; cnt++)
-		i = find_next_and_bit(bitmap, bitmap2, BITMAP_LEN, i + 1);
+	for (cnt = i = 0; i < len; cnt++)
+		i = find_next_and_bit(bitmap, bitmap2, len, i + 1);
+	time = ktime_get() - time;
+	pr_err("find_next_and_bit:     %18llu ns, %6ld iterations\n", time, cnt);
+
+	return 0;
+}
+
+static int __init test_find_next_andnot_bit(const void *bitmap,
+		const void *bitmap2, unsigned long len)
+{
+	unsigned long i, cnt;
+	ktime_t time;
+
+	time = ktime_get();
+	for (cnt = i = 0; i < len; cnt++)
+		i = find_next_andnot_bit(bitmap, bitmap2, len, i + 1);
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
+	for (cnt = i = 0; i < len; cnt++)
+		i = find_next_nor_bit(bitmap, bitmap2, len, i + 1);
+	time = ktime_get() - time;
+	pr_err("find_next_nor_bit:     %18llu ns, %6ld iterations\n", time, cnt);
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
+	for (cnt = i = 0; i < len; cnt++)
+		i = find_next_or_bit(bitmap, bitmap2, len, i + 1);
 	time = ktime_get() - time;
-	pr_err("find_next_and_bit:  %18llu ns, %6ld iterations\n", time, cnt);
+	pr_err("find_next_or_bit:      %18llu ns, %6ld iterations\n", time, cnt);
 
 	return 0;
 }
@@ -171,6 +256,11 @@ static int __init find_bit_test(void)
 	test_find_first_bit(bitmap, BITMAP_LEN / 10);
 	test_find_first_and_bit(bitmap, bitmap2, BITMAP_LEN / 10);
 	test_find_next_and_bit(bitmap, bitmap2, BITMAP_LEN);
+	test_find_first_andnot_bit(bitmap, bitmap2, BITMAP_LEN / 10);
+	test_find_next_andnot_bit(bitmap, bitmap2, BITMAP_LEN);
+	test_find_first_nor_bit(bitmap, bitmap2, BITMAP_LEN / 10);
+	test_find_next_nor_bit(bitmap, bitmap2, BITMAP_LEN);
+	test_find_next_or_bit(bitmap, bitmap2, BITMAP_LEN);
 
 	pr_err("\nStart testing find_bit() with sparse bitmap\n");
 
@@ -189,6 +279,11 @@ static int __init find_bit_test(void)
 	test_find_first_bit(bitmap, BITMAP_LEN / 10);
 	test_find_first_and_bit(bitmap, bitmap2, BITMAP_LEN / 10);
 	test_find_next_and_bit(bitmap, bitmap2, BITMAP_LEN);
+	test_find_first_andnot_bit(bitmap, bitmap2, BITMAP_LEN / 10);
+	test_find_next_andnot_bit(bitmap, bitmap2, BITMAP_LEN);
+	test_find_first_nor_bit(bitmap, bitmap2, BITMAP_LEN / 10);
+	test_find_next_nor_bit(bitmap, bitmap2, BITMAP_LEN);
+	test_find_next_or_bit(bitmap, bitmap2, BITMAP_LEN);
 
 	/*
 	 * Everything is OK. Return error just to let user run benchmark
-- 
2.39.2


