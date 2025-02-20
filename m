Return-Path: <linux-kernel+bounces-522989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD92A3D0DF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 06:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B1563A5F14
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 05:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074D9524F;
	Thu, 20 Feb 2025 05:36:07 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48241E3DD8
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 05:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740029765; cv=none; b=L7wZUyYahfNR0Mg19rqSv9stflZaNJpP+H3DI0qPZbM/RHa+EqIxzCass4csPWWB8Q1bv2FluKwf/kx7FJXNZTrpgyTgNtXLIn18owJ9IynDxSc3MKav+Jbpn9SnHkdlO8EVUohi15n4UeCNDc+J786liQMOtnzvcGbGML6oscE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740029765; c=relaxed/simple;
	bh=O+xLeL/yU205IDwGfwDxMSn+hZr/1tNXQbKe4WQie4c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=u7VlFWu0x16wtsHiAPZlOAvQ3euiyUr+wT4+svTbiAmVZTnrP6bfVNciu3Ecr2ZIkegD2vzgIYcMZ0GvUsmJi+0L6E4ObvVcU3TW/gGuIRwbp/LZivmtUmfjCdybGb2RNq0BB2jnsXp7pAxgdNIxDXiomE1FmsWO6UTB2/h3UtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3c9ff7000001d7ae-db-67b6bba6bdc3
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
Subject: [RFC PATCH v12 09/26] mm: introduce API to perform tlb shootdown on exit from page allocator
Date: Thu, 20 Feb 2025 14:20:10 +0900
Message-Id: <20250220052027.58847-10-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250220052027.58847-1-byungchul@sk.com>
References: <20250220052027.58847-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsXC9ZZnoe6y3dvSDZqvaFjMWb+GzeLzhn9s
	Fi82tDNafF3/i9ni6ac+FovLu+awWdxb85/V4vyutawWO5buY7K4dGABk8Xx3gNMFvPvfWaz
	2LxpKrPF8SlTGS1+/wAqPjlrMouDgMf31j4Wj52z7rJ7LNhU6rF5hZbH4j0vmTw2repk89j0
	aRK7x7tz59g9Tsz4zeIx72Sgx/t9V9k8tv6y82iceo3N4/MmuQC+KC6blNSczLLUIn27BK6M
	+yvPMxc8Eq24MTG2gXG2UBcjJ4eEgInEjvZmRhj70fdrbCA2m4C6xI0bP5lBbBEBM4mDrX/Y
	QWxmgbtMEgf6wWqEBVIl9v3azwpiswioSnxZshKshheofsmViSwQM+UlVm84ADaHEyj+Y0Yv
	WK+QgKnEuwWXmLoYuYBq3rNJvNo0jQ2iQVLi4IobLBMYeRcwMqxiFMrMK8tNzMwx0cuozMus
	0EvOz93ECAz8ZbV/oncwfroQfIhRgINRiYd3Ruu2dCHWxLLiytxDjBIczEoivG31W9KFeFMS
	K6tSi/Lji0pzUosPMUpzsCiJ8xp9K08REkhPLEnNTk0tSC2CyTJxcEo1MBaz89d1iDzqnOTv
	Wsv6OfT3ye8lpr67Dr3OvbT1yZ+oO7P1LnBV+f8qrBOOfT/Z5L92Z8dHsZRdZz4sVGV0u+Gl
	X9T0Up0zMH7hpd+Z50wTlAsjhWffMMx4L8zztVr4T8OtaC3lmTa/X7I5G16xjRdaffaukLwR
	b5auDzMT19VjPxg/mszrUmIpzkg01GIuKk4EAEubtG54AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsXC5WfdrLts97Z0g5UXZS3mrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XhuSdZLS7vmsNmcW/Nf1aL87vWslrsWLqPyeLSgQVMFsd7DzBZ
	zL/3mc1i86apzBbHp0xltPj9A6j45KzJLA6CHt9b+1g8ds66y+6xYFOpx+YVWh6L97xk8ti0
	qpPNY9OnSewe786dY/c4MeM3i8e8k4Ee7/ddZfNY/OIDk8fWX3YejVOvsXl83iQXwB/FZZOS
	mpNZllqkb5fAlXF/5XnmgkeiFTcmxjYwzhbqYuTkkBAwkXj0/RobiM0moC5x48ZPZhBbRMBM
	4mDrH3YQm1ngLpPEgX6wGmGBVIl9v/azgtgsAqoSX5asBKvhBapfcmUiC8RMeYnVGw6AzeEE
	iv+Y0QvWKyRgKvFuwSWmCYxcCxgZVjGKZOaV5SZm5pjqFWdnVOZlVugl5+duYgSG8bLaPxN3
	MH657H6IUYCDUYmH98HjrelCrIllxZW5hxglOJiVRHjb6rekC/GmJFZWpRblxxeV5qQWH2KU
	5mBREuf1Ck9NEBJITyxJzU5NLUgtgskycXBKNTDufxh/WJi78Pbx/Q1Xyk4sWdB0wM5nl/fC
	WMbUo0+0dp+P49vOF9PKni/QUx93dW+8g63bNjeNJY/2/gvKbbkn5phUrT5RwKph5vfZ6T9j
	L4r4r9i/8bejsbnO569m9v7sB2tPuZhv2Nfy+Whv56JpMbfX/ZvQYuhtfuSggv/lWyxPbCTX
	Ln2jxFKckWioxVxUnAgA3SuVa18CAAA=
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
index bb343136ddd05..8e6e7a83332cf 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1375,6 +1375,7 @@ struct task_struct {
 #endif
 
 	struct tlbflush_unmap_batch	tlb_ubc;
+	struct tlbflush_unmap_batch	tlb_ubc_takeoff;
 
 	/* Cache last used pipe for splice(): */
 	struct pipe_inode_info		*splice_pipe;
diff --git a/mm/internal.h b/mm/internal.h
index b38a9ae9d6993..cbdebf8a02437 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1239,6 +1239,7 @@ extern struct workqueue_struct *mm_percpu_wq;
 #ifdef CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
 void try_to_unmap_flush(void);
 void try_to_unmap_flush_dirty(void);
+void try_to_unmap_flush_takeoff(void);
 void flush_tlb_batched_pending(struct mm_struct *mm);
 void fold_batch(struct tlbflush_unmap_batch *dst, struct tlbflush_unmap_batch *src, bool reset);
 void fold_luf_batch(struct luf_batch *dst, struct luf_batch *src);
@@ -1249,6 +1250,9 @@ static inline void try_to_unmap_flush(void)
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
index 74fbf6c2fb3a7..72c5e665e59a4 100644
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


