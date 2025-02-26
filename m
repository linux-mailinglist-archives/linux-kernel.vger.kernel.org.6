Return-Path: <linux-kernel+bounces-533721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A73A45E16
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5707189884C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F37721D3FC;
	Wed, 26 Feb 2025 12:01:51 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F4B218AD4
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571310; cv=none; b=I72zSGPbjJJrxaON+GWj8VnGKQhoQ0MuyIgPr5hzCgJCCMHYrzK8SJXfTPqNAIMrG/IwKt+O/yPP7v3PcMdW7tEJ3A2tKP5Rf527vdszI74KUDOCK51Ueaw8pp131q73sOVNWro73wRZeSgV9Dh4PJDIu3EGVz+/WFCePmXN+RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571310; c=relaxed/simple;
	bh=07dB2VSb4VmHXcINj0GA7CyOhPcp/HxkzfTK48vrIDg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=fUEQjpwf56RCUWBDrdLxqaXfx5dchI78P0YmTGbRmB+W/p1GPiGq66O/Nk0NsZirepsUdcXvtg8liLQ4SVKTgliGAKQfWnTsiWiywjCCEkkj7QlEabCt/KuaLW9PA2erB5XMgMpAbGwbvylpY7Ega/iuxNvipblhKwg0FtDp9pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3e1ff7000001d7ae-ef-67bf02a6edf0
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
Subject: [RFC PATCH v12 based on mm-unstable as of Feb 21, 2025 09/25] mm: introduce API to perform tlb shootdown on exit from page allocator
Date: Wed, 26 Feb 2025 21:01:16 +0900
Message-Id: <20250226120132.28469-9-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250226120132.28469-1-byungchul@sk.com>
References: <20250226113342.GB1935@system.software.com>
 <20250226120132.28469-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsXC9ZZnke4ypv3pBhuP6VrMWb+GzeLzhn9s
	Fl/X/2K2ePqpj8Xi8q45bBb31vxntTi/ay2rxY6l+5gsLh1YwGRxvPcAk8X8e5/ZLDZvmsps
	cXzKVEaL3z/msDnweXxv7WPx2DnrLrvHgk2lHptXaHlsWtXJ5rHp0yR2j3fnzrF7nJjxm8Xj
	/b6rbB5bf9l5NE69xubxeZNcAE8Ul01Kak5mWWqRvl0CV8aSPwEFj0Qrvq/9xtrAOFuoi5GT
	Q0LARGLj/6vsMPa8ecuZQWw2AXWJGzd+gtkiAmYSB1v/ANVwcTALLGOS2HuigQ3EERboZZRY
	cWQSC0gVi4CqxOnupWAdvAKmEvsffoeaKi+xesMBsDgn0KR/u3+DxYUEkiVa1v9mARkkIXCb
	TaL1zT4miAZJiYMrbrBMYORdwMiwilEoM68sNzEzx0QvozIvs0IvOT93EyMwrJfV/onewfjp
	QvAhRgEORiUe3gdn9qYLsSaWFVfmHmKU4GBWEuHlzNyTLsSbklhZlVqUH19UmpNafIhRmoNF
	SZzX6Ft5ipBAemJJanZqakFqEUyWiYNTqoFR+W7E08OnZlruC9nBcG3S7xuyudO3nSmcNDFb
	/KBH0r4bgSoSiY/cH0pcs1zwrDcotCGdbW7kBJaDphkurpr1vzi3Wn2MK5igU+lkm/b5Xka/
	0Z+7PYuvfOO98HGttJjcpmLhaVKKT41WqU9UOb5QWl/DOFm9QojJje3WypDP2g9YNAo+//6u
	xFKckWioxVxUnAgAHatWsWcCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNLMWRmVeSWpSXmKPExsXC5WfdrLuMaX+6wZ5pqhZz1q9hs/i84R+b
	xdf1v5gtnn7qY7E4PPckq8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeJ47wEmi/n3PrNZ
	bN40ldni+JSpjBa/f8xhc+D3+N7ax+Kxc9Zddo8Fm0o9Nq/Q8ti0qpPNY9OnSewe786dY/c4
	MeM3i8f7fVfZPBa/+MDksfWXnUfj1GtsHp83yQXwRnHZpKTmZJalFunbJXBlLPkTUPBItOL7
	2m+sDYyzhboYOTkkBEwk5s1bzgxiswmoS9y48RPMFhEwkzjY+oe9i5GLg1lgGZPE3hMNbCCO
	sEAvo8SKI5NYQKpYBFQlTncvBevgFTCV2P/wOzvEVHmJ1RsOgMU5gSb92/0bLC4kkCzRsv43
	ywRGrgWMDKsYRTLzynITM3NM9YqzMyrzMiv0kvNzNzECg3RZ7Z+JOxi/XHY/xCjAwajEw/vg
	zN50IdbEsuLK3EOMEhzMSiK8nJl70oV4UxIrq1KL8uOLSnNSiw8xSnOwKInzeoWnJggJpCeW
	pGanphakFsFkmTg4pRoYm75PauJK1ZyWp3DielHqjImsW9tyNj1O29H1p8KkLvzX5rR/H/+6
	yx959DKzfNHmZcq/rU+9OCVUObPZY03/lgkBry9Uubb/N+PZvkOrWN1y4bkf4Ufm8odd3vZi
	Sabe5nxPdZaPnqcWmpr9KdwfuPBv2TtJm3Xbs/rEzJXfn5gwQ+311pP35ZVYijMSDbWYi4oT
	AY/vV1BOAgAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Functionally, no change.  This is a preparation for luf mechanism that
performs tlb shootdown required on exit from page allocator.

This patch introduced a new API rather than making use of existing
try_to_unmap_flush() to avoid repeated and redundant tlb shootdown due
to frequent page allocations during a session of batched unmap flush.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/sched.h |  1 +
 mm/internal.h         |  4 ++++
 mm/rmap.c             | 20 ++++++++++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 9632e3318e0d6..86ef426644639 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1401,6 +1401,7 @@ struct task_struct {
 #endif
 
 	struct tlbflush_unmap_batch	tlb_ubc;
+	struct tlbflush_unmap_batch	tlb_ubc_takeoff;
 
 	/* Cache last used pipe for splice(): */
 	struct pipe_inode_info		*splice_pipe;
diff --git a/mm/internal.h b/mm/internal.h
index 8ade04255dba3..8ad7e86c1c0e2 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1269,6 +1269,7 @@ extern struct workqueue_struct *mm_percpu_wq;
 #ifdef CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
 void try_to_unmap_flush(void);
 void try_to_unmap_flush_dirty(void);
+void try_to_unmap_flush_takeoff(void);
 void flush_tlb_batched_pending(struct mm_struct *mm);
 void fold_batch(struct tlbflush_unmap_batch *dst, struct tlbflush_unmap_batch *src, bool reset);
 void fold_luf_batch(struct luf_batch *dst, struct luf_batch *src);
@@ -1279,6 +1280,9 @@ static inline void try_to_unmap_flush(void)
 static inline void try_to_unmap_flush_dirty(void)
 {
 }
+static inline void try_to_unmap_flush_takeoff(void)
+{
+}
 static inline void flush_tlb_batched_pending(struct mm_struct *mm)
 {
 }
diff --git a/mm/rmap.c b/mm/rmap.c
index ac450a45257f6..61366b4570c9a 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -772,6 +772,26 @@ void fold_luf_batch(struct luf_batch *dst, struct luf_batch *src)
 	read_unlock_irqrestore(&src->lock, flags);
 }
 
+void try_to_unmap_flush_takeoff(void)
+{
+	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
+	struct tlbflush_unmap_batch *tlb_ubc_takeoff = &current->tlb_ubc_takeoff;
+
+	if (!tlb_ubc_takeoff->flush_required)
+		return;
+
+	arch_tlbbatch_flush(&tlb_ubc_takeoff->arch);
+
+	/*
+	 * Now that tlb shootdown of tlb_ubc_takeoff has been performed,
+	 * it's good chance to shrink tlb_ubc if possible.
+	 */
+	if (arch_tlbbatch_done(&tlb_ubc->arch, &tlb_ubc_takeoff->arch))
+		reset_batch(tlb_ubc);
+
+	reset_batch(tlb_ubc_takeoff);
+}
+
 /*
  * Flush TLB entries for recently unmapped pages from remote CPUs. It is
  * important if a PTE was dirty when it was unmapped that it's flushed
-- 
2.17.1


