Return-Path: <linux-kernel+bounces-183344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1018C97D5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 04:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07A611F20FAB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 02:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64EB17591;
	Mon, 20 May 2024 02:17:59 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52C88C06
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 02:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716171479; cv=none; b=R102EbtFrsOdwHjoonzhu/LlIcAaURSzMz6O+Z/VVa0c2oYek3gNMz2Sv2h8AFDOqT0ioWMF04Xa/Ecjz5U3afVqbW1K3LPxliX+DsqlPKj8cMfGfCToqHv22JvqTXHbioCcaplYyCAiYCaLCorPG1HqoyQ/f9LPBY4AorP58Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716171479; c=relaxed/simple;
	bh=O/HKlBeE1Ln5d0Jibamkt6l0z7BEfyyJZYoMpvhJjIo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=hpCoyqkCQG8pkWQFwFW7ntwBRAwA3/BUokElDHcZofDCuI4Opc4Ql+dXbJ9czFA5sYzvH7KVtTyqveXqh8oy1S0TWdDDrDfRqibrhcZ/m3rAkZ++U4Lh8nmjSaVfBHrujfipT4ksbdRURPuke2jKYfWedmr2SbKIrIFgW68B5hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-a9-664ab2c8cf5b
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
Subject: [RESEND PATCH v10 04/12] x86/tlb, riscv/tlb, mm/rmap: separate arch_tlbbatch_clear() out of arch_tlbbatch_flush()
Date: Mon, 20 May 2024 11:17:26 +0900
Message-Id: <20240520021734.21527-5-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240520021734.21527-1-byungchul@sk.com>
References: <20240520021734.21527-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsXC9ZZnke7JTV5pBtceMFrMWb+GzeLzhn9s
	Fi82tDNafF3/i9ni6ac+FovLu+awWdxb85/V4vyutawWO5buY7K4dGABk8Xx3gNMFvPvfWaz
	2LxpKrPF8SlTGS1+/wAqPjlrMouDgMf31j4Wj52z7rJ7LNhU6rF5hZbH4j0vmTw2repk89j0
	aRK7x7tz59g9Tsz4zeIx72Sgx/t9V9k8tv6y82iceo3N4/MmuQC+KC6blNSczLLUIn27BK6M
	R78msBfc56tYM3EPawPjVJ4uRg4OCQETifmzmbsYOcHM1U/bwGw2AXWJGzd+gtkiAmYSB1v/
	sIPYzAJ3mSQO9LOB2MICVRLtSx+C2SwCqhK3ts1lAbF5BUwl2hYvYYeYKS+xesMBsDmcQHNm
	rNoJViMEVPPj6FegXi6gmtdsEnc+NEI1SEocXHGDZQIj7wJGhlWMQpl5ZbmJmTkmehmVeZkV
	esn5uZsYgYG/rPZP9A7GTxeCDzEKcDAq8fDueOSZJsSaWFZcmXuIUYKDWUmEd9MWoBBvSmJl
	VWpRfnxRaU5q8SFGaQ4WJXFeo2/lKUIC6YklqdmpqQWpRTBZJg5OqQZGrlVnlrBvObjA6OIp
	Rxb9RZv3CcseuXN9SflEBX1nrcj02Ubz9ogv3tf/4ZiNsaK7V6CoXZ5w/5KjaoflfhhOWbyq
	X7vU//gbIz+JjwLmipHlOd+vbm9S8E08pBlWOUHJeftDgUuBnk+217OJW/8SUjok3vHqudVH
	oa+rbt/f79o+vXSGh/9vJZbijERDLeai4kQAji8YPXgCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsXC5WfdrHtik1eawbGNJhZz1q9hs/i84R+b
	xYsN7YwWX9f/YrZ4+qmPxeLw3JOsFpd3zWGzuLfmP6vF+V1rWS12LN3HZHHpwAImi+O9B5gs
	5t/7zGaxedNUZovjU6YyWvz+AVR8ctZkFgdBj++tfSweO2fdZfdYsKnUY/MKLY/Fe14yeWxa
	1cnmsenTJHaPd+fOsXucmPGbxWPeyUCP9/uusnksfvGByWPrLzuPxqnX2Dw+b5IL4I/isklJ
	zcksSy3St0vgynj0awJ7wX2+ijUT97A2ME7l6WLk5JAQMJFY/bSNGcRmE1CXuHHjJ5gtImAm
	cbD1DzuIzSxwl0niQD8biC0sUCXRvvQhmM0ioCpxa9tcFhCbV8BUom3xEnaImfISqzccAJvD
	CTRnxqqdYDVCQDU/jn5lm8DItYCRYRWjSGZeWW5iZo6pXnF2RmVeZoVecn7uJkZgIC+r/TNx
	B+OXy+6HGAU4GJV4eDfc9kwTYk0sK67MPcQowcGsJMK7aQtQiDclsbIqtSg/vqg0J7X4EKM0
	B4uSOK9XeGqCkEB6YklqdmpqQWoRTJaJg1OqgTHBpXxGoe7uK9OeLaxQj5H9fHSLnp5wUDw/
	V7B0KGvrlQv2XiFJtlOmPI1vOFT7rCfzp09goYvc0cov2pYPtm2zymE/7ZRWauEbExzzy+35
	6qZ1p/491JlZKdzQEFxnMf1ZzbF3rr43XaZef3C9v3ThlugzwRdE08+dNOjMDbykZjb9Ztdb
	XiWW4oxEQy3mouJEADDRNYVgAgAA
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
index 07d743f87b3f..9cbd27148357 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -234,5 +234,4 @@ void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
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
index 2608c40dffad..cf8a99a49aef 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -649,6 +649,7 @@ void try_to_unmap_flush(void)
 		return;
 
 	arch_tlbbatch_flush(&tlb_ubc->arch);
+	arch_tlbbatch_clear(&tlb_ubc->arch);
 	tlb_ubc->flush_required = false;
 	tlb_ubc->writable = false;
 }
-- 
2.17.1


