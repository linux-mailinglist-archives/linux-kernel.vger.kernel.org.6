Return-Path: <linux-kernel+bounces-533714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EEBA45E10
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C820168D2E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B93A218858;
	Wed, 26 Feb 2025 12:01:48 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCCC258CD0
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571308; cv=none; b=CZ/nnFZhZLoA+M++JjMPSvA6E8R6JTdOwcGojSNSrpSne4PERkc1VanlrvCj1b8hcqZri8NZf53W0hbKvhWGXqud7Jg0zWHiJEeeCBsgZUBm1WKFYvtxPc5i9XWfqGv/u/6OgdRNDVI4uEE9PlN4Rw7fWI9iStrNJ3FUz33UFPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571308; c=relaxed/simple;
	bh=TxSYzLf0ithtaToRg2G2T5Mr/C8IWtSZU4guqdgiBm8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Diru9w06jQuYuWhqxaCeYGSycoEP4UfvYQHwvnJ+mp2I+YY2dQt6wJrf1UrWGMFt9S2XqHJsxNHYZyjaYjM79t5lY5rfUaFt2VWLS/4rRNEYd1/yYITr1zZFbYycfI5vgUHbamJJy6Fv7krlviMf43IqVXC/gWajojh7wesxUfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3e1ff7000001d7ae-cc-67bf02a6ea00
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: kernel_team@skhynix.com,
	akpm@linux-foundation.org,
	vernhao@tencent.com,
	mgorman@techsingularity.net,
	hughd@google.com,
	willy@infradead.org,
	david@redhat.com,
	peterz@infradead.org,
	luto@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	rjgolo@gmail.com
Subject: [RFC PATCH v12 based on mm-unstable as of Feb 21, 2025 02/25]  arm64/tlbflush: add APIs manipulating tlb batch's arch data
Date: Wed, 26 Feb 2025 21:01:09 +0900
Message-Id: <20250226120132.28469-2-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250226120132.28469-1-byungchul@sk.com>
References: <20250226113342.GB1935@system.software.com>
 <20250226120132.28469-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsXC9ZZnke4ypv3pBgvfCVnMWb+GzeLzhn9s
	Fl/X/2K2ePqpj8Xi8q45bBb31vxntTi/ay2rxY6l+5gsLh1YwGRxvPcAk8X8e5/ZLDZvmsps
	cXzKVEaL3z/msDnweXxv7WPx2DnrLrvHgk2lHptXaHlsWtXJ5rHp0yR2j3fnzrF7nJjxm8Xj
	/b6rbB5bf9l5NE69xubxeZNcAE8Ul01Kak5mWWqRvl0CV8aPSb8YC/7yVWxY3MXUwLiUp4uR
	k0NCwETifNshdhj79a1jzCA2m4C6xI0bP8FsEQEziYOtf4BquDiYBZYxSew90cAGkhAWaGaU
	uPLZCsRmEVCVuHXuF9ggXgFTiTv329gghspLrN5wAGwQJ9Cgf7t/g9UICSRLtKz/zQIyVELg
	NpvEv4f7WCEaJCUOrrjBMoGRdwEjwypGocy8stzEzBwTvYzKvMwKveT83E2MwLBeVvsnegfj
	pwvBhxgFOBiVeHgfnNmbLsSaWFZcmXuIUYKDWUmElzNzT7oQb0piZVVqUX58UWlOavEhRmkO
	FiVxXqNv5SlCAumJJanZqakFqUUwWSYOTqkGxsiw9In1CRmXHii4LTS4bdgWxKAvM7lQZ8bq
	hU0a06YzJ3lq8OQcO8EzofuzBLt2pmmmeR7/6n93tTvvzZxYus594tOzr/xmRN7Zv1fRqcSv
	W6StVO7kCo5Pwhm26t+3nL5x2GxHT4SxE6Nv5JImrf2L8tWSvHS2fZl9kDvPbv6CULNk03lf
	lFiKMxINtZiLihMBMTo6gGcCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNLMWRmVeSWpSXmKPExsXC5WfdrLuMaX+6warPnBZz1q9hs/i84R+b
	xdf1v5gtnn7qY7E4PPckq8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeJ47wEmi/n3PrNZ
	bN40ldni+JSpjBa/f8xhc+D3+N7ax+Kxc9Zddo8Fm0o9Nq/Q8ti0qpPNY9OnSewe786dY/c4
	MeM3i8f7fVfZPBa/+MDksfWXnUfj1GtsHp83yQXwRnHZpKTmZJalFunbJXBl/Jj0i7HgL1/F
	hsVdTA2MS3m6GDk5JARMJF7fOsYMYrMJqEvcuPETzBYRMJM42PqHvYuRi4NZYBmTxN4TDWwg
	CWGBZkaJK5+tQGwWAVWJW+d+sYPYvAKmEnfut7FBDJWXWL3hANggTqBB/3b/BqsREkiWaFn/
	m2UCI9cCRoZVjCKZeWW5iZk5pnrF2RmVeZkVesn5uZsYgUG6rPbPxB2MXy67H2IU4GBU4uF9
	cGZvuhBrYllxZe4hRgkOZiURXs7MPelCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeb3CUxOEBNIT
	S1KzU1MLUotgskwcnFINjDVCLtmqp+ROKeRJsMWKVy1a9SWap37f9itpnDYPDj0+xsr3drXz
	U5cTmz6Xtpx6fPZIaHn2rNxvd9Y2M+rJWWd/05n6gTdu477VjZK9hjxdKVse882aIHruwOIZ
	6oxFKSWhgrFpZr+Wrn7+4rOjyTlj8f0qTxuVVrK0vWldw2SpbvBz68fz9UosxRmJhlrMRcWJ
	AAkBmzpOAgAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

A new mechanism, LUF(Lazy Unmap Flush), defers tlb flush until folios
that have been unmapped and freed, eventually get allocated again.  It's
safe for folios that had been mapped read only and were unmapped, since
the contents of the folios don't change while staying in pcp or buddy
so we can still read the data through the stale tlb entries.

This is a preparation for the mechanism that requires to manipulate tlb
batch's arch data.  Even though arm64 does nothing for tlb things, arch
with CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH should provide the APIs.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 arch/arm64/include/asm/tlbflush.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index b7e1920570bdd..f7036cd33e35c 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -347,6 +347,33 @@ static inline void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 	dsb(ish);
 }
 
+static inline void arch_tlbbatch_clear(struct arch_tlbflush_unmap_batch *batch)
+{
+	/* nothing to do */
+}
+
+static inline void arch_tlbbatch_fold(struct arch_tlbflush_unmap_batch *bdst,
+			       struct arch_tlbflush_unmap_batch *bsrc)
+{
+	/* nothing to do */
+}
+
+static inline bool arch_tlbbatch_need_fold(struct arch_tlbflush_unmap_batch *batch,
+			       struct mm_struct *mm)
+{
+	/*
+	 * Nothing is needed in this architecture.
+	 */
+	return false;
+}
+
+static inline bool arch_tlbbatch_done(struct arch_tlbflush_unmap_batch *bdst,
+			       struct arch_tlbflush_unmap_batch *bsrc)
+{
+	/* Kernel can consider tlb batch always has been done. */
+	return true;
+}
+
 /*
  * This is meant to avoid soft lock-ups on large TLB flushing ranges and not
  * necessarily a performance improvement.
-- 
2.17.1


