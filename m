Return-Path: <linux-kernel+bounces-307058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE61996478D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 16:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47A28B2827A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 14:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6611A76CD;
	Thu, 29 Aug 2024 14:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="eu6ntkBT"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BF41AD419
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 14:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724940009; cv=none; b=eo8Id3mhJh17tWg1AWmpZYpiRGoBUK7toHMiXSh2eJV0+E7zsjc2NoXIKQkp5o7l0c63deDkTxyGvGLAT1tMMeMzdC2enuc8Pzu8dzaAaGYQdmTh7KSSr7KKpG1MS2qCzS7tLsJ5AWWw/WIxvQYwbxWlcCdroXoUfO+GbXzdU0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724940009; c=relaxed/simple;
	bh=TauEHashCWRZD329tWKJi8OZYV4rw/E8L6w9rrOoAiM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h6KHudPSvI8Vf82czMmOCwRxpgGFD1S2VZVkTR/ezgpUftBJ1okScgQn//LCZGNsewyEw76sTT6D6hNg5eltsGH00CrVOHk4kRxRaqR1QTQM1yjX8bJR3ZiBULlXlvb27EBX81DKW6PCji9xTEA6uF4K5siKjFq9fTBwCHglsBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=eu6ntkBT; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1724939999;
	bh=TauEHashCWRZD329tWKJi8OZYV4rw/E8L6w9rrOoAiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eu6ntkBTZBDl9ttS7nu2yJARmQcwZBalGKT86rtnGFwOSe+7C3JY30x//Ih0qhm39
	 KsP1CHskeJ1tdSlbSnrbffP5yVa80Dn+J6TlEo3q34Atf+c2qVWwCKekhiE0Z9RiZO
	 dpw8yZU4BG21UB3edR2j9Jh2FoWwi5bp/XPmfULDvdEQlx7+/g6urnJdkMCFf4pmFN
	 CWI/VH2YBY/9HLCGBCP1coH1YIKjyJscAHuNWswrohBigaCLX8C3IBReljDOQA1JtF
	 VHxZ/P/jdVtnd48XbARmM6A8dysRAQ09TIqhMvxgzjgEWFND1f4cB8S22X/dU0A9Tv
	 JSt08pIYBeyVQ==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Wvjb35c6Bz1JQg;
	Thu, 29 Aug 2024 09:59:59 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v2 4/6] lib: Fix test_find_first_and_bit and test_find_next_and_bit benchmark
Date: Thu, 29 Aug 2024 09:59:24 -0400
Message-Id: <20240829135926.926603-5-mathieu.desnoyers@efficios.com>
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

Modify test_find_first_bit so it modifies a local copy of bitmap rather
than modifying the input bitmap, which removes the requirement of
placing it last in the tests.

Calls to test_find_first_and_bit and test_find_next_and_bit are placed
after test_find_first_bit, which makes them use a bitmap entirely filled
rather than the expected bitmap (random-filled or sparse).

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 lib/find_bit_benchmark.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/lib/find_bit_benchmark.c b/lib/find_bit_benchmark.c
index d3fb09e6eff1..aee2ebb6b3cd 100644
--- a/lib/find_bit_benchmark.c
+++ b/lib/find_bit_benchmark.c
@@ -30,18 +30,20 @@ static DECLARE_BITMAP(bitmap, BITMAP_LEN) __initdata;
 static DECLARE_BITMAP(bitmap2, BITMAP_LEN) __initdata;
 
 /*
- * This is Schlemiel the Painter's algorithm. It should be called after
- * all other tests for the same bitmap because it sets all bits of bitmap to 1.
+ * This is Schlemiel the Painter's algorithm.
  */
 static int __init test_find_first_bit(void *bitmap, unsigned long len)
 {
+	static DECLARE_BITMAP(cp, BITMAP_LEN) __initdata;
 	unsigned long i, cnt;
 	ktime_t time;
 
+	bitmap_copy(cp, bitmap, BITMAP_LEN);
+
 	time = ktime_get();
 	for (cnt = i = 0; i < len; cnt++) {
-		i = find_first_bit(bitmap, len);
-		__clear_bit(i, bitmap);
+		i = find_first_bit(cp, len);
+		__clear_bit(i, cp);
 	}
 	time = ktime_get() - time;
 	pr_err("find_first_bit:     %18llu ns, %6ld iterations\n", time, cnt);
-- 
2.39.2


