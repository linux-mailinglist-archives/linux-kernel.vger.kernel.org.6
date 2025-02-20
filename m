Return-Path: <linux-kernel+bounces-522991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23090A3D0E0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 06:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E8A43BB8AD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 05:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E991E9B26;
	Thu, 20 Feb 2025 05:36:08 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA38F1E571A
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 05:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740029767; cv=none; b=uf8U7ZHEF7x41ouh8wZN4JnTEOO0zgbxyXiGXfiXhnxwYBxo5ETPWQIbEUFZ8Z1RRl4pCma/axPhP7BhFxAZwD8+puT3BQCqw096XpJwCVs5ha5kDu3DdLLpOGP2wj8AF9Vqz0Y8kRRZ9jbWtY8uI5TerSiH5H1VBfWp3hPefuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740029767; c=relaxed/simple;
	bh=w7vX7JgcAEQHAdfHnEtOdFTLy8UIyanj3an2oyK8r3E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=u2mDYE2Idu+9rG+2fX6xnLHH/k4sQGdqM39QrwITPOI8aOVCk9O35fbu8t5Mc6NOXKADPGEZHDLv/MY+/fOHGGZJJ4+r3OBldV9a4yvuDS2OX7tUahoN7p5videhZB9JqUqIF4apHozKht1G84qZPFXe6fhXF7V1k4Dqcb9O010=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3c9ff7000001d7ae-f4-67b6bba6ccf4
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
Subject: [RFC PATCH v12 14/26] mm/rmap: recognize read-only tlb entries during batched tlb flush
Date: Thu, 20 Feb 2025 14:20:15 +0900
Message-Id: <20250220052027.58847-15-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250220052027.58847-1-byungchul@sk.com>
References: <20250220052027.58847-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsXC9ZZnoe6y3dvSDU5cMLeYs34Nm8XnDf/Y
	LF5saGe0+Lr+F7PF0099LBaXd81hs7i35j+rxflda1ktdizdx2Rx6cACJovjvQeYLObf+8xm
	sXnTVGaL41OmMlr8/gFUfHLWZBYHAY/vrX0sHjtn3WX3WLCp1GPzCi2PxXteMnlsWtXJ5rHp
	0yR2j3fnzrF7nJjxm8Vj3slAj/f7rrJ5bP1l59E49Rqbx+dNcgF8UVw2Kak5mWWpRfp2CVwZ
	P/ZsZC04KVbxpHUrWwPjC6EuRk4OCQETiTWT2lm6GDnA7Edz+UHCbALqEjdu/GQGsUUEzCQO
	tv5hB7GZBe4ySRzoZwOxhQUSJNY2P2ABsVkEVCVmNhxlAhnDC1Tf2F0OMV1eYvWGA2BjOIHC
	P2b0grUKCZhKvFtwiQmi5jObxLsd6hC2pMTBFTdYJjDyLmBkWMUolJlXlpuYmWOil1GZl1mh
	l5yfu4kRGPTLav9E72D8dCH4EKMAB6MSD++M1m3pQqyJZcWVuYcYJTiYlUR42+q3pAvxpiRW
	VqUW5ccXleakFh9ilOZgURLnNfpWniIkkJ5YkpqdmlqQWgSTZeLglGpgzPlhdov7meX1hzlX
	j7eIndjz/NQBa59mlz2uVx+zeyfJPbG9bXpQ8VRw2ZXGgvtii24+77AN+bCo4f5XlfMW2Qpd
	sTHCd12Xl3qedX6+9tHaANZ3J3P2b9kfq9y7fnF27vt/YicuWS++OH+fDue9uBARCfZn2Xyt
	Z5PY32m5H6j7d9y4sdP7oBJLcUaioRZzUXEiAFB+uU92AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsXC5WfdrLts97Z0g5U3dS3mrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XhuSdZLS7vmsNmcW/Nf1aL87vWslrsWLqPyeLSgQVMFsd7DzBZ
	zL/3mc1i86apzBbHp0xltPj9A6j45KzJLA6CHt9b+1g8ds66y+6xYFOpx+YVWh6L97xk8ti0
	qpPNY9OnSewe786dY/c4MeM3i8e8k4Ee7/ddZfNY/OIDk8fWX3YejVOvsXl83iQXwB/FZZOS
	mpNZllqkb5fAlfFjz0bWgpNiFU9at7I1ML4Q6mLk4JAQMJF4NJe/i5GTg01AXeLGjZ/MILaI
	gJnEwdY/7CA2s8BdJokD/WwgtrBAgsTa5gcsIDaLgKrEzIajTCBjeIHqG7vLQcISAvISqzcc
	ABvDCRT+MaMXrFVIwFTi3YJLTBMYuRYwMqxiFMnMK8tNzMwx1SvOzqjMy6zQS87P3cQIDOJl
	tX8m7mD8ctn9EKMAB6MSD++Dx1vThVgTy4orcw8xSnAwK4nwttVvSRfiTUmsrEotyo8vKs1J
	LT7EKM3BoiTO6xWemiAkkJ5YkpqdmlqQWgSTZeLglGpg1LkjXdLXPGX5tN8CbH3Hpggxr9z6
	XeOBpoS47P71YiuMjF//X65ldlPM2+rrMxEra3+WyZtTLmvcXpXWtGzPutn/fPUZ9mw8oMv1
	3IG35IPY3ir749UaZ8NX8e1y0L7XekdBTFT7wWFOkcctobuPzZqjGW33yzFLR69jhVfiQvXp
	y7YJHNrkpsRSnJFoqMVcVJwIALEjBHJeAgAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Functionally, no change.  This is a preparation for luf mechanism that
requires to recognize read-only tlb entries and handle them in a
different way.  The newly introduced API in this patch, fold_ubc(), will
be used by luf mechanism.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/sched.h |  1 +
 mm/rmap.c             | 16 ++++++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index c4ff83e1d5953..a217d6011fdfe 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1381,6 +1381,7 @@ struct task_struct {
 
 	struct tlbflush_unmap_batch	tlb_ubc;
 	struct tlbflush_unmap_batch	tlb_ubc_takeoff;
+	struct tlbflush_unmap_batch	tlb_ubc_ro;
 
 	/* Cache last used pipe for splice(): */
 	struct pipe_inode_info		*splice_pipe;
diff --git a/mm/rmap.c b/mm/rmap.c
index 1581b1a00f974..3ed6234dd777e 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -775,6 +775,7 @@ void fold_luf_batch(struct luf_batch *dst, struct luf_batch *src)
 void try_to_unmap_flush_takeoff(void)
 {
 	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
+	struct tlbflush_unmap_batch *tlb_ubc_ro = &current->tlb_ubc_ro;
 	struct tlbflush_unmap_batch *tlb_ubc_takeoff = &current->tlb_ubc_takeoff;
 
 	if (!tlb_ubc_takeoff->flush_required)
@@ -789,6 +790,9 @@ void try_to_unmap_flush_takeoff(void)
 	if (arch_tlbbatch_done(&tlb_ubc->arch, &tlb_ubc_takeoff->arch))
 		reset_batch(tlb_ubc);
 
+	if (arch_tlbbatch_done(&tlb_ubc_ro->arch, &tlb_ubc_takeoff->arch))
+		reset_batch(tlb_ubc_ro);
+
 	reset_batch(tlb_ubc_takeoff);
 }
 
@@ -801,7 +805,9 @@ void try_to_unmap_flush_takeoff(void)
 void try_to_unmap_flush(void)
 {
 	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
+	struct tlbflush_unmap_batch *tlb_ubc_ro = &current->tlb_ubc_ro;
 
+	fold_batch(tlb_ubc, tlb_ubc_ro, true);
 	if (!tlb_ubc->flush_required)
 		return;
 
@@ -813,8 +819,9 @@ void try_to_unmap_flush(void)
 void try_to_unmap_flush_dirty(void)
 {
 	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
+	struct tlbflush_unmap_batch *tlb_ubc_ro = &current->tlb_ubc_ro;
 
-	if (tlb_ubc->writable)
+	if (tlb_ubc->writable || tlb_ubc_ro->writable)
 		try_to_unmap_flush();
 }
 
@@ -831,13 +838,18 @@ void try_to_unmap_flush_dirty(void)
 static void set_tlb_ubc_flush_pending(struct mm_struct *mm, pte_t pteval,
 				      unsigned long uaddr)
 {
-	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
+	struct tlbflush_unmap_batch *tlb_ubc;
 	int batch;
 	bool writable = pte_dirty(pteval);
 
 	if (!pte_accessible(mm, pteval))
 		return;
 
+	if (pte_write(pteval))
+		tlb_ubc = &current->tlb_ubc;
+	else
+		tlb_ubc = &current->tlb_ubc_ro;
+
 	arch_tlbbatch_add_pending(&tlb_ubc->arch, mm, uaddr);
 	tlb_ubc->flush_required = true;
 
-- 
2.17.1


