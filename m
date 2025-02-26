Return-Path: <linux-kernel+bounces-533715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE582A45E11
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 877DA3AA696
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3905218ADF;
	Wed, 26 Feb 2025 12:01:48 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD2816F288
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571308; cv=none; b=rzxVQU1uTDWKO2/5FSPXsD2nWYjS0CEC3DO5wufhslM7etcXeEEY3wvRUz/Dcz7dJEQmGbxtlt2eAhihm0BkDuOJU7oKJWWs/IlxMlE34htXYZcns1RMmxQLPu4QP6XPb0sUGHqohQAuvsuPiOkrprCzHpRU9JFmUcsAlf901zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571308; c=relaxed/simple;
	bh=oqSmI5xcxwfWM9F9TTfIG7Bqp2HwCZJQe3hg1oUK1ow=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=SGcvSyZGu0e3TodaCiaKeyjYyqGVNYdAnN5byXqoHT3Ww21Im3h9DlgfoBCt+i3Tq0At46xHA44QH0E01CtFUTCeZBVF2LFB/xoLNc8vvGz+gn0TzTaQIMZauwdiMiO5KPeSSvDHJySqVFRh0KjwMYLUD+E7d48WMpkqGSrBjzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3e1ff7000001d7ae-c7-67bf02a62d46
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
Subject: [RFC PATCH v12 based on mm-unstable as of Feb 21, 2025 01/25]  x86/tlb: add APIs manipulating tlb batch's arch data
Date: Wed, 26 Feb 2025 21:01:08 +0900
Message-Id: <20250226120132.28469-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250226113342.GB1935@system.software.com>
References: <20250226113342.GB1935@system.software.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMLMWRmVeSWpSXmKPExsXC9ZZnke4ypv3pBjdeC1nMWb+GzeLzhn9s
	Fl/X/2K2ePqpj8Xi8q45bBb31vxntTi/ay2rxY6l+5gsLh1YwGRxvPcAk8X8e5/ZLDZvmsps
	cXzKVEaL3z/msDnweXxv7WPx2DnrLrvHgk2lHptXaHlsWtXJ5rHp0yR2j3fnzrF7nJjxm8Xj
	/b6rbB5bf9l5NE69xubxeZNcAE8Ul01Kak5mWWqRvl0CV8a1PbMYC54IVdzfVtjA+J2/i5GT
	Q0LAROLSlGvMMPbGi71gNpuAusSNGz/BbBEBM4mDrX/Yuxi5OJgFljFJ7D3RwAaSEBaokbg5
	/R8TiM0ioCrx6vRldhCbV8BU4vGXfnaIofISqzccABvEKWAhMWveAbB6IQFziTOP/jKCDJUQ
	uM8m8XXDWkaIBkmJgytusExg5F3AyLCKUSgzryw3MTPHRC+jMi+zQi85P3cTIzCol9X+id7B
	+OlC8CFGAQ5GJR7eB2f2pguxJpYVV+YeYpTgYFYS4eXM3JMuxJuSWFmVWpQfX1Sak1p8iFGa
	g0VJnNfoW3mKkEB6YklqdmpqQWoRTJaJg1OqgZHloKphXtYzronKui9LV8Xmy+qlaD5akjqj
	Y8KdTuXTXqfvWWoUu8xoCVJKmcD18ltdltlneSmGi+6hL+9+jojRjXNYoKhhGrd5CvdBxVrZ
	c9/nOk8MslP5NXnBAsZV97/ZZW7YJ2ur8dzu5zW+6TZHV/JbslRe+rkyxi6HS+VPxdzFHdMs
	3ymxFGckGmoxFxUnAgCaPPDpZgIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFLMWRmVeSWpSXmKPExsXC5WfdrLuMaX+6wadX7BZz1q9hs/i84R+b
	xdf1v5gtnn7qY7E4PPckq8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeJ47wEmi/n3PrNZ
	bN40ldni+JSpjBa/f8xhc+D3+N7ax+Kxc9Zddo8Fm0o9Nq/Q8ti0qpPNY9OnSewe786dY/c4
	MeM3i8f7fVfZPBa/+MDksfWXnUfj1GtsHp83yQXwRnHZpKTmZJalFunbJXBlXNszi7HgiVDF
	/W2FDYzf+bsYOTkkBEwkNl7sZQax2QTUJW7c+AlmiwiYSRxs/cPexcjFwSywjEli74kGNpCE
	sECNxM3p/5hAbBYBVYlXpy+zg9i8AqYSj7/0s0MMlZdYveEA2CBOAQuJWfMOgNULCZhLnHn0
	l3ECI9cCRoZVjCKZeWW5iZk5pnrF2RmVeZkVesn5uZsYgSG6rPbPxB2MXy67H2IU4GBU4uF9
	cGZvuhBrYllxZe4hRgkOZiURXs7MPelCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeb3CUxOEBNIT
	S1KzU1MLUotgskwcnFINjHcYLU5lOnoeZC5jv7Q4fK11+SGxK983+Jud65i4O0pt7bXcyZdz
	GSY8TtfgFLEo7GblPVvxJDiUofrqjX7XCQIzr+ZpNZXd8DIJ2bvPf8apc7eeTok+LrNSuOD7
	zBNrU9b01fMnzpZdkfLk47tVS9/v6dmil3fcsdl5wcuJEeEZPOfdUwreFSqxFGckGmoxFxUn
	AgCLgQj5TQIAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

A new mechanism, LUF(Lazy Unmap Flush), defers tlb flush until folios
that have been unmapped and freed, eventually get allocated again.  It's
safe for folios that had been mapped read-only and were unmapped, since
the contents of the folios wouldn't change while staying in pcp or buddy
so we can still read the data through the stale tlb entries.

This is a preparation for the mechanism that needs to recognize
read-only tlb entries by separating tlb batch arch data into two, one is
for read-only entries and the other is for writable ones, and merging
those two when needed.

It also optimizes tlb shootdown by skipping CPUs that have already
performed tlb flush needed since.  To support it, added APIs
manipulating arch data for x86.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 arch/x86/include/asm/tlbflush.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 29373da7b00a6..52c54ca68ca9e 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -5,6 +5,7 @@
 #include <linux/mm_types.h>
 #include <linux/mmu_notifier.h>
 #include <linux/sched.h>
+#include <linux/cpumask.h>
 
 #include <asm/processor.h>
 #include <asm/cpufeature.h>
@@ -293,6 +294,29 @@ static inline void arch_flush_tlb_batched_pending(struct mm_struct *mm)
 
 extern void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch);
 
+static inline void arch_tlbbatch_clear(struct arch_tlbflush_unmap_batch *batch)
+{
+	cpumask_clear(&batch->cpumask);
+}
+
+static inline void arch_tlbbatch_fold(struct arch_tlbflush_unmap_batch *bdst,
+		struct arch_tlbflush_unmap_batch *bsrc)
+{
+	cpumask_or(&bdst->cpumask, &bdst->cpumask, &bsrc->cpumask);
+}
+
+static inline bool arch_tlbbatch_need_fold(struct arch_tlbflush_unmap_batch *batch,
+		struct mm_struct *mm)
+{
+	return !cpumask_subset(mm_cpumask(mm), &batch->cpumask);
+}
+
+static inline bool arch_tlbbatch_done(struct arch_tlbflush_unmap_batch *bdst,
+		struct arch_tlbflush_unmap_batch *bsrc)
+{
+	return !cpumask_andnot(&bdst->cpumask, &bdst->cpumask, &bsrc->cpumask);
+}
+
 static inline bool pte_flags_need_flush(unsigned long oldflags,
 					unsigned long newflags,
 					bool ignore_access)

base-commit: f7ed46277aaa8f848f18959ff68469f5186ba87c
-- 
2.17.1


