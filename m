Return-Path: <linux-kernel+bounces-533724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E108BA45E1A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67D721897DE6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF1722171F;
	Wed, 26 Feb 2025 12:01:53 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D2521D3F1
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571313; cv=none; b=ZkolgZlnDB/Ot8/MUgs2GWXKRAWIfWW1Jokr+3ocloLtasuH1YUZwuybglcZthMkcucdMTzN+8N/6AKnHxpq2Kkm/Q56BHpBWI94YBas9k3oYaK361VgCOVyA+VdWjQBFkrFKQqhNUmL8gI8Gnauhv8McA5/ENTVr0OAAbLdYck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571313; c=relaxed/simple;
	bh=YiHg1X6qaYyBdI/xfLrk6f6PYVZNawiRejvc0UJ0i34=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=s2+ZuzROPq2+EMvt1n3wh/6F4suavnTxthX8YLCfgxdh1lJGMTI6PdeU6+hn+OduwppzkVipNMBOfj3n151wGSBnT5JRTyIJVKzWcv6C9lX/6ZQIsFyK8FYSle1XJlrLfLgN7fIcA8O8w2k92j1AZfhxe6pAjUfguW41By7GlQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3e1ff7000001d7ae-08-67bf02a769c9
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
Subject: [RFC PATCH v12 based on mm-unstable as of Feb 21, 2025 14/25]  mm/rmap: recognize read-only tlb entries during batched tlb flush
Date: Wed, 26 Feb 2025 21:01:21 +0900
Message-Id: <20250226120132.28469-14-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250226120132.28469-1-byungchul@sk.com>
References: <20250226113342.GB1935@system.software.com>
 <20250226120132.28469-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMLMWRmVeSWpSXmKPExsXC9ZZnke5ypv3pBgfes1vMWb+GzeLzhn9s
	Fl/X/2K2ePqpj8Xi8q45bBb31vxntTi/ay2rxY6l+5gsLh1YwGRxvPcAk8X8e5/ZLDZvmsps
	cXzKVEaL3z/msDnweXxv7WPx2DnrLrvHgk2lHptXaHlsWtXJ5rHp0yR2j3fnzrF7nJjxm8Xj
	/b6rbB5bf9l5NE69xubxeZNcAE8Ul01Kak5mWWqRvl0CV8aby/PYC26KVTRMDmpg/CPUxcjJ
	ISFgInHx4C1mGLvtx2Ewm01AXeLGjZ9gtoiAmcTB1j/sXYxcHMwCy5gk9p5oYANJCAt0Mkpc
	eJcLYrMIqEq0fL8A1sAL1DD/1CwmiKHyEqs3HACLcwLF/+3+zQ5iCwkkS7Ss/80CMlRC4Dab
	xLrtX1kgGiQlDq64wTKBkXcBI8MqRqHMvLLcxMwcE72MyrzMCr3k/NxNjMCgXlb7J3oH46cL
	wYcYBTgYlXh4H5zZmy7EmlhWXJl7iFGCg1lJhJczc0+6EG9KYmVValF+fFFpTmrxIUZpDhYl
	cV6jb+UpQgLpiSWp2ampBalFMFkmDk6pBkajsxsWffZ9lVSkb9nAuaRH7e+E9XbqcYJft2Rl
	HHh6X0C654dXp8oTJw6rz79sS+98XCNWZSbYGp70zp31lNnfBSmZfv8Evv8OWKnaqZrUVzNN
	UXW74t8PUZ0fH39P5rOuCvMMXH5t8i2rpAuW71rSIw5vfGlma+h8/erZPaJrnxtfWP7cc44S
	S3FGoqEWc1FxIgDhRYCTZgIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFLMWRmVeSWpSXmKPExsXC5WfdrLuMaX+6wbn9NhZz1q9hs/i84R+b
	xdf1v5gtnn7qY7E4PPckq8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeJ47wEmi/n3PrNZ
	bN40ldni+JSpjBa/f8xhc+D3+N7ax+Kxc9Zddo8Fm0o9Nq/Q8ti0qpPNY9OnSewe786dY/c4
	MeM3i8f7fVfZPBa/+MDksfWXnUfj1GtsHp83yQXwRnHZpKTmZJalFunbJXBlvLk8j73gplhF
	w+SgBsY/Ql2MnBwSAiYSbT8OM4PYbALqEjdu/ASzRQTMJA62/mHvYuTiYBZYxiSx90QDG0hC
	WKCTUeLCu1wQm0VAVaLl+wWwBl6ghvmnZjFBDJWXWL3hAFicEyj+b/dvdhBbSCBZomX9b5YJ
	jFwLGBlWMYpk5pXlJmbmmOoVZ2dU5mVW6CXn525iBIbosto/E3cwfrnsfohRgINRiYf3wZm9
	6UKsiWXFlbmHGCU4mJVEeDkz96QL8aYkVlalFuXHF5XmpBYfYpTmYFES5/UKT00QEkhPLEnN
	Tk0tSC2CyTJxcEo1MC5R+NMRyZlrsezGp6jFZ/ymHT4x/12MRC+n+wHrLvOfG67YbAkSu2U6
	T+bavub3KlZWLB+YzMRnryiUZEwz+vi39HxNYvqvB89Lo9clcYc5fnx2KGVm0xTndHWDgxyX
	3v303rTumQ+zdvnDbfOKPvzO+jL5QqdQxJ/WV+crT797xjbpBs/T9QeUWIozEg21mIuKEwFC
	FGFNTQIAAA==
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
index a3049ea5b3ad3..d1a3c97491ff2 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1407,6 +1407,7 @@ struct task_struct {
 
 	struct tlbflush_unmap_batch	tlb_ubc;
 	struct tlbflush_unmap_batch	tlb_ubc_takeoff;
+	struct tlbflush_unmap_batch	tlb_ubc_ro;
 
 	/* Cache last used pipe for splice(): */
 	struct pipe_inode_info		*splice_pipe;
diff --git a/mm/rmap.c b/mm/rmap.c
index 40de03c8f73be..c9c594d73058c 100644
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
 		unsigned long start, unsigned long end)
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
 	arch_tlbbatch_add_pending(&tlb_ubc->arch, mm, start, end);
 	tlb_ubc->flush_required = true;
 
-- 
2.17.1


