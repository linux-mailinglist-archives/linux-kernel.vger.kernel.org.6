Return-Path: <linux-kernel+bounces-533738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3997A45E2A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91F1D189C146
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF3221A44B;
	Wed, 26 Feb 2025 12:03:49 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F712217670
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571429; cv=none; b=JIndjHIARjW1leZJ7k1ght6oVaV9/ZZF5eFRO2MTWd7DHKlnhxmca5AHTOT9Rk7PuQsMzBbZGRTjAnvcuq8ocYNblxHsO0jDhcXu4kkUQ6pjylWvM0PZvpwaQKdwGr+A7My9k+v2UjWeS0NWng6P4k8GKPo1mtLonNfxi3sCn48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571429; c=relaxed/simple;
	bh=yh4fgjcsXrHfO1O64CdK4LrTi7qSILAeD4OhLcBzvbo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=JdPN7Eevlur7V73RlQI/UJ5eMe2Cp+RexFKRDylOYt+yjtEL5JCSr0o0BvhvXgp1k9yyPrpep1JEtQO3lAd0blODBR67EriTHCdOhbIpa6Niit6B3/gRfDIFRUIgrjUomv5Mgqh9kit52abUKfvCZ+8nb+DW5gMibkfQhdfQXbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3e1ff7000001d7ae-fb-67bf0322d251
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
Subject: [RFC PATCH v12 based on v6.14-rc4 02/25] arm64/tlbflush: add APIs manipulating tlb batch's arch data
Date: Wed, 26 Feb 2025 21:03:13 +0900
Message-Id: <20250226120336.29565-2-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250226120336.29565-1-byungchul@sk.com>
References: <20250226113024.GA1935@system.software.com>
 <20250226120336.29565-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsXC9ZZnka4S8/50g5sN4hZz1q9hs/i84R+b
	xdf1v5gtnn7qY7G4vGsOm8W9Nf9ZLc7vWstqsWPpPiaLSwcWMFkc7z3AZDH/3mc2i82bpjJb
	HJ8yldHi9485bA58Ht9b+1g8ds66y+6xYFOpx+YVWh6bVnWyeWz6NInd4925c+weJ2b8ZvF4
	v+8qm8fWX3YejVOvsXl83iQXwBPFZZOSmpNZllqkb5fAlbH60iqWgr98Fbca57M3MC7l6WLk
	5JAQMJFYf+EAE4w9vX0NC4jNJqAucePGT2YQW0TATOJg6x/2LkYuDmaBZUwSe080sIEkhAVy
	JbY/nwHWzCKgKjGxayUjiM0rYCpxY/o2doih8hKrNxwAG8QJNOjTtGNgvUICyRI7f/9hAhkq
	IXCbTaLr+xpWiAZJiYMrbrBMYORdwMiwilEoM68sNzEzx0QvozIvs0IvOT93EyMwrJfV/one
	wfjpQvAhRgEORiUe3gdn9qYLsSaWFVfmHmKU4GBWEuHlzNyTLsSbklhZlVqUH19UmpNafIhR
	moNFSZzX6Ft5ipBAemJJanZqakFqEUyWiYNTqoFx1aVvAifSF09e++Pclb8G5ju71nFnFm9R
	X/4rsuAWv9BPtmMcZtXeTqEfJ1y6VfBv+dGphoLJl/ts9/7T4fRyL1jIZ7ot/Rr3ndxpq/yU
	l65dvjhum8sHwa+Gv+8fZMw74jbpVk7y73lL9Ri+PrKMSmCN79x1adXDxin6QScmLVx4rTrR
	7MiOlUosxRmJhlrMRcWJAHybQUhnAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNLMWRmVeSWpSXmKPExsXC5WfdrKvEvD/dYM9UPos569ewWXze8I/N
	4uv6X8wWTz/1sVgcnnuS1eLyrjlsFvfW/Ge1OL9rLavFjqX7mCwuHVjAZHG89wCTxfx7n9ks
	Nm+aymxxfMpURovfP+awOfB7fG/tY/HYOesuu8eCTaUem1doeWxa1cnmsenTJHaPd+fOsXuc
	mPGbxeP9vqtsHotffGDy2PrLzqNx6jU2j8+b5AJ4o7hsUlJzMstSi/TtErgyVl9axVLwl6/i
	VuN89gbGpTxdjJwcEgImEtPb17CA2GwC6hI3bvxkBrFFBMwkDrb+Ye9i5OJgFljGJLH3RAMb
	SEJYIFdi+/MZTCA2i4CqxMSulYwgNq+AqcSN6dvYIYbKS6zecABsECfQoE/TjoH1CgkkS+z8
	/YdpAiPXAkaGVYwimXlluYmZOaZ6xdkZlXmZFXrJ+bmbGIFBuqz2z8QdjF8uux9iFOBgVOLh
	fXBmb7oQa2JZcWXuIUYJDmYlEV7OzD3pQrwpiZVVqUX58UWlOanFhxilOViUxHm9wlMThATS
	E0tSs1NTC1KLYLJMHJxSDYxs0sKtwUvMTcSufg66ohDewsbGMfERa0hDUrAvV9typthHLlE5
	H59pxMa8Nap0mrJgVdn1v/0JU/6kWR7VZ2SK1N5wrqEw4Pb7HqfHZefNW0J5tryeauR9+14F
	z7XzvRPZ4lt2K3OJPJS5tt9p/5TJF5mYHs1k2m3kpLtAXD/SU77eknu+kxJLcUaioRZzUXEi
	AOGD5elOAgAA
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
index bc94e036a26b9..acac53a21e5d1 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -354,6 +354,33 @@ static inline void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
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


