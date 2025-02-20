Return-Path: <linux-kernel+bounces-522981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C7EA3D0D6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 06:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69E85189D949
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 05:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A105B1E32DB;
	Thu, 20 Feb 2025 05:36:03 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBDD198E81
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 05:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740029763; cv=none; b=sdJ9mV1GSX1O7NmtXeDjBLNH3wiBVe8qUy6hhjBv+5Lir5cv6bZt3jEhDsE2qJ0xI8eIrmYFRqPiJxuJGaL/OIMccXEe10dTqpmAN6DEjS/33beg/QeIp5oWk+ShGP7C24WzRtKGPdgU8PjYQRxA6vXDrj4ZNKjNKuXnj7JCHgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740029763; c=relaxed/simple;
	bh=QzVui9QA+b13SQhXv5/2R6P1FQ7PePIcbk7dbrC4Dec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=LQSIgj2HXdUJAmvWVyIHMBNoOiKsnPYTCDGySt+EY/wFg7LP7QI/Q4H92rauNSW8Gj+HpXcC0W5j1hs8HxnheCuo60Zd9oY8HCsAfFrRbD0jxfO+eDGb8tyG7UrDuT5dev7zAGJ5b2TpGSnUne/bYu6JQ2fG++lV5gc5ClgYxds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3c9ff7000001d7ae-bf-67b6bba6b39a
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
Subject: [RFC PATCH v12 04/26] x86/tlb, riscv/tlb, mm/rmap: separate arch_tlbbatch_clear() out of arch_tlbbatch_flush()
Date: Thu, 20 Feb 2025 14:20:05 +0900
Message-Id: <20250220052027.58847-5-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250220052027.58847-1-byungchul@sk.com>
References: <20250220052027.58847-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsXC9ZZnoe6y3dvSDfb+FbeYs34Nm8XnDf/Y
	LF5saGe0+Lr+F7PF0099LBaXd81hs7i35j+rxflda1ktdizdx2Rx6cACJovjvQeYLObf+8xm
	sXnTVGaL41OmMlr8/gFUfHLWZBYHAY/vrX0sHjtn3WX3WLCp1GPzCi2PxXteMnlsWtXJ5rHp
	0yR2j3fnzrF7nJjxm8Vj3slAj/f7rrJ5bP1l59E49Rqbx+dNcgF8UVw2Kak5mWWpRfp2CVwZ
	Z288Yil4ylcxafI8tgbG2TxdjJwcEgImEv++3mGFsVfvXsoGYrMJqEvcuPGTGcQWETCTONj6
	hx3EZha4yyRxoB+ohoNDWKBcYs0sPxCTRUBV4uktVZAKXgFTictfWhghJspLrN5wAGwKJ9CU
	HzN6waYLAdW8W3CJqYuRC6jmM5tE963rUCdIShxccYNlAiPvAkaGVYxCmXlluYmZOSZ6GZV5
	mRV6yfm5mxiBYb+s9k/0DsZPF4IPMQpwMCrx8M5o3ZYuxJpYVlyZe4hRgoNZSYS3rX5LuhBv
	SmJlVWpRfnxRaU5q8SFGaQ4WJXFeo2/lKUIC6YklqdmpqQWpRTBZJg5OqQbGagPJ7Zt9xZsn
	626cPF0wizV9rsuiZ0WaXSc4pogo+J+dOHvfvNg/Yf+fTRJv99soeam8JdDC7mCKm8CiZydf
	q8fvLND++czCd+q9iKUeF9aGL/vUNuOy1nWe2c4C+gmr7V8tKz6RY8IpnNX/+chT1/It6xXV
	52vHKezyi/o36fTCROXbmzzXKrEUZyQaajEXFScCAFaoSSN3AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsXC5WfdrLts97Z0g9MP+SzmrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XhuSdZLS7vmsNmcW/Nf1aL87vWslrsWLqPyeLSgQVMFsd7DzBZ
	zL/3mc1i86apzBbHp0xltPj9A6j45KzJLA6CHt9b+1g8ds66y+6xYFOpx+YVWh6L97xk8ti0
	qpPNY9OnSewe786dY/c4MeM3i8e8k4Ee7/ddZfNY/OIDk8fWX3YejVOvsXl83iQXwB/FZZOS
	mpNZllqkb5fAlXH2xiOWgqd8FZMmz2NrYJzN08XIySEhYCKxevdSNhCbTUBd4saNn8wgtoiA
	mcTB1j/sIDazwF0miQP9QDUcHMIC5RJrZvmBmCwCqhJPb6mCVPAKmEpc/tLCCDFRXmL1hgNg
	UziBpvyY0Qs2XQio5t2CS0wTGLkWMDKsYhTJzCvLTczMMdUrzs6ozMus0EvOz93ECAziZbV/
	Ju5g/HLZ/RCjAAejEg/vg8db04VYE8uKK3MPMUpwMCuJ8LbVb0kX4k1JrKxKLcqPLyrNSS0+
	xCjNwaIkzusVnpogJJCeWJKanZpakFoEk2Xi4JRqYLQ5vFln2+xUHd+QVxJOv7PWGchsd9lm
	du7eT/3HdrdcVacJr7sc63vT52PH3NbERVe5fLwefAzqV/E0O7WvgdvY//Upht/fyg70WMTG
	aWz/fVjgRnhE8uwfXc6a4Sk/63ccK12X+pyPeS/nhQqpwvwnVRt/H22JfVLvfImp+23P7hPs
	6qrztiuxFGckGmoxFxUnAgBEHJIWXgIAAA==
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
index 86593d1b787d8..860e49b223fd7 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -1262,8 +1262,6 @@ void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
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


