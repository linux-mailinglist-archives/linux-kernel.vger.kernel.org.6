Return-Path: <linux-kernel+bounces-533713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0191CA45E0F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF2A1188A754
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009A921772D;
	Wed, 26 Feb 2025 12:01:48 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD6E18DB32
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571307; cv=none; b=o4BOROKiJ3GoGhm3DjHipdY77Xv6qyI/BXp9H7FvtITw/kz50IZ/jQ5H2529dz+JWrI69bEJ04flfmzojzF/4Zikut4iyuIBgVRL5WvcOewAJE5aP8CIMcPRLECzC8v/d58SuaSoMmj/ilfHLS10458YQjcV1VzjRAhMVgxs5jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571307; c=relaxed/simple;
	bh=UxONzsFobyt+dqll/9BAj/yNJOrJ11BkMSsA4cIJ0N8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Wq8975Wg7BK539Xy2rElPX91kXMmwD0TUNeEQnSYBAT2GlR20qqd/ernlIS0oUCLjJCBiUGEpivoEJzNuEU51sIGIQzn1mCsPziaoCdzBulHVsKKqd3uerTpvC1ET+Yl1vbohtdOoARDP9HilXDV2ho6WLsPW/BAkfelFcylunc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3e1ff7000001d7ae-d6-67bf02a660b4
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
Subject: [RFC PATCH v12 based on mm-unstable as of Feb 21, 2025 04/25]  x86/tlb, riscv/tlb, mm/rmap: separate arch_tlbbatch_clear() out of arch_tlbbatch_flush()
Date: Wed, 26 Feb 2025 21:01:11 +0900
Message-Id: <20250226120132.28469-4-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250226120132.28469-1-byungchul@sk.com>
References: <20250226113342.GB1935@system.software.com>
 <20250226120132.28469-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKLMWRmVeSWpSXmKPExsXC9ZZnke4ypv3pBrPWSlrMWb+GzeLzhn9s
	Fl/X/2K2ePqpj8Xi8q45bBb31vxntTi/ay2rxY6l+5gsLh1YwGRxvPcAk8X8e5/ZLDZvmsps
	cXzKVEaL3z/msDnweXxv7WPx2DnrLrvHgk2lHptXaHlsWtXJ5rHp0yR2j3fnzrF7nJjxm8Xj
	/b6rbB5bf9l5NE69xubxeZNcAE8Ul01Kak5mWWqRvl0CV8b+y5+YC57yVWxduompgXE2Txcj
	J4eEgIlEW18fC4w98UMPI4jNJqAucePGT2YQW0TATOJg6x/2LkYuDmaBZUwSe080sIE4wgIL
	GCUmdExiBaliEVCVeHyuH6ybV8BUYseKtUwQU+UlVm84ADaJE2jSv92/2UFsIYFkiZb1v1lA
	BkkI3GeT+L/wCtQZkhIHV9xgmcDIu4CRYRWjUGZeWW5iZo6JXkZlXmaFXnJ+7iZGYGAvq/0T
	vYPx04XgQ4wCHIxKPLwPzuxNF2JNLCuuzD3EKMHBrCTCy5m5J12INyWxsiq1KD++qDQntfgQ
	ozQHi5I4r9G38hQhgfTEktTs1NSC1CKYLBMHp1QDY7HkV05O7lkN/henvV58qGZeNq97j3eH
	sYDs1zk83/44887KKO1m+Bakque+IOqIXVzgvaxtD7t29uwK+2TB/ejPc54pHxYdla+O+bLC
	Rbd3ffS6NU+uT/mxgpPtboDusgN6puy/1n02aaxdsXbB1tfbAp6dVldrf+kalHBB6OTp3W3f
	7leeXqPEUpyRaKjFXFScCACeUCQdaAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDLMWRmVeSWpSXmKPExsXC5WfdrLuMaX+6QdtRAYs569ewWXze8I/N
	4uv6X8wWTz/1sVgcnnuS1eLyrjlsFvfW/Ge1OL9rLavFjqX7mCwuHVjAZHG89wCTxfx7n9ks
	Nm+aymxxfMpURovfP+awOfB7fG/tY/HYOesuu8eCTaUem1doeWxa1cnmsenTJHaPd+fOsXuc
	mPGbxeP9vqtsHotffGDy2PrLzqNx6jU2j8+b5AJ4o7hsUlJzMstSi/TtErgy9l/+xFzwlK9i
	69JNTA2Ms3m6GDk5JARMJCZ+6GEEsdkE1CVu3PjJDGKLCJhJHGz9w97FyMXBLLCMSWLviQY2
	EEdYYAGjxISOSawgVSwCqhKPz/WDdfMKmErsWLGWCWKqvMTqDQfAJnECTfq3+zc7iC0kkCzR
	sv43ywRGrgWMDKsYRTLzynITM3NM9YqzMyrzMiv0kvNzNzECw3RZ7Z+JOxi/XHY/xCjAwajE
	w/vgzN50IdbEsuLK3EOMEhzMSiK8nJl70oV4UxIrq1KL8uOLSnNSiw8xSnOwKInzeoWnJggJ
	pCeWpGanphakFsFkmTg4pRoYH/MVal/dc/ZRh3WVpNLHhXz/anq8+3cZ9XZomr2VXZY549/a
	ZS/cil7znjqlxDOxwd5pRtd2w9cVXNzT/5+2EAiZaLM7TqziuvGpiSaOafINeqxHO5NYvaVv
	HJ4TUnxk1uXo5SJsy3UfrGUVmXNgz6NPFcuuy5v+9K2sOfRi1habCqb1+aJeSizFGYmGWsxF
	xYkAF+3NiE8CAAA=
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
index 74dd9307fbf1b..38f4bea8a964a 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -200,5 +200,4 @@ void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 {
 	__flush_tlb_range(&batch->cpumask, FLUSH_TLB_NO_ASID, 0,
 			  FLUSH_TLB_MAX_SIZE, PAGE_SIZE);
-	cpumask_clear(&batch->cpumask);
 }
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 6cf881a942bbe..523e8bb6fba1f 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -1292,8 +1292,6 @@ void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 		local_irq_enable();
 	}
 
-	cpumask_clear(&batch->cpumask);
-
 	put_flush_tlb_info();
 	put_cpu();
 }
diff --git a/mm/rmap.c b/mm/rmap.c
index bcec8677f68df..546b7a6a30a44 100644
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


