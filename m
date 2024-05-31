Return-Path: <linux-kernel+bounces-196566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA548D5E18
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 11:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 774B0B252F9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 09:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D3C12FF63;
	Fri, 31 May 2024 09:20:26 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C2B78C62
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 09:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717147226; cv=none; b=pHJVi9jJY/q2kEysPsEf00y679QSoqSRXCNthBcQsVGp9WYbeonzt6VWuC86tnHpXM/eijSRA+yJYta+TM5dFtlTGy1bH8KJYy1tiu39XbIhVqlxztJH4uarI6urooczFW0krVb7Oz/WCgcb+C8ifaDs4+5NksMXQOOHbkbRBeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717147226; c=relaxed/simple;
	bh=d6bHunNAOkL4AaON84uJC/Z4Z5hH+zI4TAL/MT3Bllc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=FrRH3Fu8bnMRnygj6OVPKV+EplAPyztQ73WjfvDEPOyg0O/fb0+4RsqURJn7pM78RIqjVNIbeeuNZwnRIBJ/AaUgFFmGAYC9yJU57JdXWzL1nK2/wNfCZuinIj9joRKUfv5h4gb1LHYPqSlcV35sPjei9/k1T2qnTrSi4p0jCiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-52-6659964cfef5
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: kernel_team@skhynix.com,
	akpm@linux-foundation.org,
	ying.huang@intel.com,
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
	dave.hansen@linux.intel.com,
	rjgolo@gmail.com
Subject: [PATCH v11 04/12] x86/tlb, riscv/tlb, mm/rmap: separate arch_tlbbatch_clear() out of arch_tlbbatch_flush()
Date: Fri, 31 May 2024 18:19:53 +0900
Message-Id: <20240531092001.30428-5-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240531092001.30428-1-byungchul@sk.com>
References: <20240531092001.30428-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsXC9ZZnka7PtMg0g1lNnBZz1q9hs/i84R+b
	xYsN7YwWX9f/YrZ4+qmPxeLyrjlsFvfW/Ge1OL9rLavFjqX7mCwuHVjAZHG89wCTxfx7n9ks
	Nm+aymxxfMpURovfP4CKT86azOIg4PG9tY/FY+esu+weCzaVemxeoeWxeM9LJo9NqzrZPDZ9
	msTu8e7cOXaPEzN+s3jMOxno8X7fVTaPrb/sPBqnXmPz+LxJLoAvissmJTUnsyy1SN8ugSvj
	xukuxoL7fBVTVr9maWCcytPFyMkhIWAi0dD+iA3G3tJ3nBnEZhNQl7hx4yeYLSJgJnGw9Q87
	iM0scJdJ4kA/WL2wQLHEnN7tYHEWAVWJG/f+soDYvAKmEuc27WCFmCkvsXrDAbA5nEBzDvy9
	wwhiCwHVLPrfC2RzAdW8ZpN4s20CC0SDpMTBFTdYJjDyLmBkWMUolJlXlpuYmWOil1GZl1mh
	l5yfu4kRGPrLav9E72D8dCH4EKMAB6MSD29ARUSaEGtiWXFl7iFGCQ5mJRHeX+lAId6UxMqq
	1KL8+KLSnNTiQ4zSHCxK4rxG38pThATSE0tSs1NTC1KLYLJMHJxSDYzNRnL8/nuWnzK8qckm
	dq89+qGT2Yne8kVT90eyvfEWXxzTv3FlsjNL3Gn1u+zbr29Sf/kxPajbUnClote7hrnizOzi
	aa48x7I7rW2Lr1ty7bfYqpcyY4PbKU71ZV8WZwXVOccUTNFmkmadP2mi8nKjlp3p+YF1cq6X
	mNR2l7btOiJqWPn2uxJLcUaioRZzUXEiAHlk0Fd5AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsXC5WfdrOs9LTLN4MVsG4s569ewWXze8I/N
	4sWGdkaLr+t/MVs8/dTHYnF47klWi8u75rBZ3Fvzn9Xi/K61rBY7lu5jsrh0YAGTxfHeA0wW
	8+99ZrPYvGkqs8XxKVMZLX7/ACo+OWsyi4Ogx/fWPhaPnbPusnss2FTqsXmFlsfiPS+ZPDat
	6mTz2PRpErvHu3Pn2D1OzPjN4jHvZKDH+31X2TwWv/jA5LH1l51H49RrbB6fN8kF8Edx2aSk
	5mSWpRbp2yVwZdw43cVYcJ+vYsrq1ywNjFN5uhg5OSQETCS29B1nBrHZBNQlbtz4CWaLCJhJ
	HGz9ww5iMwvcZZI40M8GYgsLFEvM6d0OFmcRUJW4ce8vC4jNK2AqcW7TDlaImfISqzccAJvD
	CTTnwN87jCC2EFDNov+9jBMYuRYwMqxiFMnMK8tNzMwx1SvOzqjMy6zQS87P3cQIDORltX8m
	7mD8ctn9EKMAB6MSD29ARUSaEGtiWXFl7iFGCQ5mJRHeX+lAId6UxMqq1KL8+KLSnNTiQ4zS
	HCxK4rxe4akJQgLpiSWp2ampBalFMFkmDk6pBkYd80cf9bWsTEMtDzqfUl7MKb3L3bLIIaR8
	p/vFqnaDt20ar7w9dky5sEqWR2j2ny1O1/teb/jtm/vq0Du2Lwc/uBQ4q8e5/DrxWOnnxge8
	AvdCHjmwh67JrYlfbnY5RVwovEljpWS7d9dh8XoutfmyLqFO3dNY1/0//Il1r8W5aVPzGDst
	XJRYijMSDbWYi4oTAWUft89gAgAA
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

This is a preparation for the mechanism that requires to avoid redundant
tlb flush by manipulating tlb batch's arch data.  To achieve that, we
need to separate the part clearing the tlb batch's arch data out of
arch_tlbbatch_flush().

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 arch/riscv/mm/tlbflush.c | 1 -
 arch/x86/mm/tlb.c        | 2 --
 mm/rmap.c                | 1 +
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 9b6e86ce3867..36f996af6256 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -201,5 +201,4 @@ void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 {
 	__flush_tlb_range(&batch->cpumask, FLUSH_TLB_NO_ASID, 0,
 			  FLUSH_TLB_MAX_SIZE, PAGE_SIZE);
-	cpumask_clear(&batch->cpumask);
 }
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 44ac64f3a047..24bce69222cd 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -1265,8 +1265,6 @@ void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 		local_irq_enable();
 	}
 
-	cpumask_clear(&batch->cpumask);
-
 	put_flush_tlb_info();
 	put_cpu();
 }
diff --git a/mm/rmap.c b/mm/rmap.c
index 52357d79917c..a65a94aada8d 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -648,6 +648,7 @@ void try_to_unmap_flush(void)
 		return;
 
 	arch_tlbbatch_flush(&tlb_ubc->arch);
+	arch_tlbbatch_clear(&tlb_ubc->arch);
 	tlb_ubc->flush_required = false;
 	tlb_ubc->writable = false;
 }
-- 
2.17.1


