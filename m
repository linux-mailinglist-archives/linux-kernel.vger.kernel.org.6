Return-Path: <linux-kernel+bounces-533741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFBAA45E2E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91C673B24FA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B524521B9F6;
	Wed, 26 Feb 2025 12:03:50 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E0C21858E
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571429; cv=none; b=aD+lvKnf/iaJvaMd2X6e2rRo8vrWqTaZkXrW2GmDsg5evR9TCMXdXdQef7Vm8kcAMKpMtKhd2hlE06e8lGvZ9VoTX4VP1HKOCyZnW265jC7Ff4bUSSK4q+9WCVMxJnlVDRHFvfDe3ZbVTPnTBu4HGLNXWWxzLJGe70WnDsawdbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571429; c=relaxed/simple;
	bh=3dqt1NTA4VqVmtzrYf3aAXfLj7mvBI+X8j7daE0mAwg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=IAOcANGNNvLnVOXMYOGoyJkmyB/fq1JOB4zJTNfEJXtyg16B7NGJcwC7i22ffIB2ql/clYebpjTFCTUGyiIHcZ8sHdfKSyUZpZMKRo7DMcLWo0HctoZSu3QsNk4Az/3f7c8y/R5R2F9ingbhgVbLkJtog10pzpJ3/k9FvIVdOzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3e1ff7000001d7ae-05-67bf0322220f
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
Subject: [RFC PATCH v12 based on v6.14-rc4 04/25] x86/tlb, riscv/tlb, mm/rmap: separate arch_tlbbatch_clear() out of arch_tlbbatch_flush()
Date: Wed, 26 Feb 2025 21:03:15 +0900
Message-Id: <20250226120336.29565-4-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250226120336.29565-1-byungchul@sk.com>
References: <20250226113024.GA1935@system.software.com>
 <20250226120336.29565-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsXC9ZZnka4S8/50g51TpC3mrF/DZvF5wz82
	i6/rfzFbPP3Ux2JxedccNot7a/6zWpzftZbVYsfSfUwWlw4sYLI43nuAyWL+vc9sFps3TWW2
	OD5lKqPF7x9z2Bz4PL639rF47Jx1l91jwaZSj80rtDw2repk89j0aRK7x7tz59g9Tsz4zeLx
	ft9VNo+tv+w8GqdeY/P4vEkugCeKyyYlNSezLLVI3y6BK2PunU+sBU/5Krr3JjQwzubpYuTk
	kBAwkVjV+JwJxp5+ug3MZhNQl7hx4ycziC0iYCZxsPUPexcjFwezwDImib0nGthAHGGBLkaJ
	my1NYFUsAqoSu+ceYgGxeQVMJQ5174SaKi+xesMBsBpOoEmfph1jA7GFBJIldv7+wwQySELg
	NpvExtdd7BANkhIHV9xgmcDIu4CRYRWjUGZeWW5iZo6JXkZlXmaFXnJ+7iZGYFgvq/0TvYPx
	04XgQ4wCHIxKPLwPzuxNF2JNLCuuzD3EKMHBrCTCy5m5J12INyWxsiq1KD++qDQntfgQozQH
	i5I4r9G38hQhgfTEktTs1NSC1CKYLBMHp1QDo3izEHP9nBebDpwM1T/0okyjf9fGbIOfxrHT
	jXzkxRcfaos/rsXd+V76vBazyxJ+m9LivGyfuoYFIt6Ojodm3GQ88iP6pMQpzYYDD9NE75aJ
	+/4QnvF+furBnJwtVtudxEOY53E77Piz0jD93jTFxeJSV3580mRas0n0sfI6I1+DTVn5SypT
	lViKMxINtZiLihMB+7rekmcCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNLMWRmVeSWpSXmKPExsXC5WfdrKvEvD/dYOcqIYs569ewWXze8I/N
	4uv6X8wWTz/1sVgcnnuS1eLyrjlsFvfW/Ge1OL9rLavFjqX7mCwuHVjAZHG89wCTxfx7n9ks
	Nm+aymxxfMpURovfP+awOfB7fG/tY/HYOesuu8eCTaUem1doeWxa1cnmsenTJHaPd+fOsXuc
	mPGbxeP9vqtsHotffGDy2PrLzqNx6jU2j8+b5AJ4o7hsUlJzMstSi/TtErgy5t75xFrwlK+i
	e29CA+Nsni5GTg4JAROJ6afbmEBsNgF1iRs3fjKD2CICZhIHW/+wdzFycTALLGOS2HuigQ3E
	ERboYpS42dIEVsUioCqxe+4hFhCbV8BU4lD3TiaIqfISqzccAKvhBJr0adoxNhBbSCBZYufv
	P0wTGLkWMDKsYhTJzCvLTczMMdUrzs6ozMus0EvOz93ECAzSZbV/Ju5g/HLZ/RCjAAejEg/v
	gzN704VYE8uKK3MPMUpwMCuJ8HJm7kkX4k1JrKxKLcqPLyrNSS0+xCjNwaIkzusVnpogJJCe
	WJKanZpakFoEk2Xi4JRqYIwWv+aq6KWR/q7FW7r5JTe/wtzj4a17FKOdKm5tMBJ7ynfwhdLj
	LObJBpduTFbqtjNdoTs3LCE0SeLboY/aP2fOS10g4vTbWbBr4USheM3r3xKWs1SYnuU4/j9k
	iWvjP/G2C1dT5wqmpxSpnlnx2sO6KGbGulQ7YXV/z3m2V1x1zv9fa/1qlxJLcUaioRZzUXEi
	AHikbm9OAgAA
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
index 9b6e86ce38674..36f996af6256c 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -201,5 +201,4 @@ void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
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
index c6c4d4ea29a7e..2de01de164ef0 100644
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


