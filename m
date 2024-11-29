Return-Path: <linux-kernel+bounces-419539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F649D6F3B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 14:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00FABB28F27
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 13:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950C41CEAAC;
	Sun, 24 Nov 2024 12:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="riAEK0m1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11641CEAB2;
	Sun, 24 Nov 2024 12:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452449; cv=none; b=bqwhcn1lapQM3qzqQPJMDCvLymztF7uZ8XwJqDFsdOItex/uebWlGrPvklnYx1vNxNbkszPkrz0E6iFQd6RuqHUcjIeIAZG9oXepi1r4iKscfZbuvAx1bF0VSedVadA8o3IV+ZDSvc5aafx2rpuifnfRV97wg0Gak697XrPS1Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452449; c=relaxed/simple;
	bh=a8538FsydKZeS6CG2poVFhOrpVNi/7MNKMPk6Qx9Fj0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iQ+elm5/EqAfEakSKHXnZ1xA2GUvFPrJvi/wZ89SKxvNRUFJpovW6+6zgmhIPnjrAhJJTqCaRHKCUpyp8VwsNa4qzH8EI/V52pOF6SHDm8fYA6JRuLPvaFnkqN2+/T9kqa5slQvcFV9L58eYxDzbm1qxRvUIJ50Si8L+be7hk9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=riAEK0m1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D846C4CED9;
	Sun, 24 Nov 2024 12:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452448;
	bh=a8538FsydKZeS6CG2poVFhOrpVNi/7MNKMPk6Qx9Fj0=;
	h=From:To:Cc:Subject:Date:From;
	b=riAEK0m1mkH/QkPWhnDnJr6Bw/p0cMtByP9V/+6bjC9eMfFyGAeeOqFj0YEqHQYUC
	 dd0Rca06iosHIDqxFlbxnFZLvS6Vyhfq5IyPt3macmIBJV6W1JzZtLEna5roxPG2Qo
	 pkYvMP7xoVhMlTts50nXtYAUx1qB5mU2ah5hXAF5u02+vfAHPqHczCIiSV1FQ/fC6/
	 7Tn37JZ+WUkMHaiXcUOpoh/QL8wT9xgziSqIqJRm7EB0GWDgfpblostlN260PiEb+n
	 2OtXgIICV0+G8mjO+VosTlNk2wTyW8GWtmWjhu4QAoVrcwg3cNBXDKKZh+10pO1NAa
	 ijtZwz96YenFA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>,
	mhiramat@kernel.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 1/2] uprobes: sanitiize xol_free_insn_slot()
Date: Sun, 24 Nov 2024 07:47:23 -0500
Message-ID: <20241124124726.3338494-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.173
Content-Transfer-Encoding: 8bit

From: Oleg Nesterov <oleg@redhat.com>

[ Upstream commit c7b4133c48445dde789ed30b19ccb0448c7593f7 ]

1. Clear utask->xol_vaddr unconditionally, even if this addr is not valid,
   xol_free_insn_slot() should never return with utask->xol_vaddr != NULL.

2. Add a comment to explain why do we need to validate slot_addr.

3. Simplify the validation above. We can simply check offset < PAGE_SIZE,
   unsigned underflows are fine, it should work if slot_addr < area->vaddr.

4. Kill the unnecessary "slot_nr >= UINSNS_PER_PAGE" check, slot_nr must
   be valid if offset < PAGE_SIZE.

The next patches will cleanup this function even more.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240929144235.GA9471@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/events/uprobes.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index b37a6bde8a915..a0f846b2ac1ea 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1633,8 +1633,8 @@ static unsigned long xol_get_insn_slot(struct uprobe *uprobe)
 static void xol_free_insn_slot(struct task_struct *tsk)
 {
 	struct xol_area *area;
-	unsigned long vma_end;
 	unsigned long slot_addr;
+	unsigned long offset;
 
 	if (!tsk->mm || !tsk->mm->uprobes_state.xol_area || !tsk->utask)
 		return;
@@ -1643,24 +1643,21 @@ static void xol_free_insn_slot(struct task_struct *tsk)
 	if (unlikely(!slot_addr))
 		return;
 
+	tsk->utask->xol_vaddr = 0;
 	area = tsk->mm->uprobes_state.xol_area;
-	vma_end = area->vaddr + PAGE_SIZE;
-	if (area->vaddr <= slot_addr && slot_addr < vma_end) {
-		unsigned long offset;
-		int slot_nr;
-
-		offset = slot_addr - area->vaddr;
-		slot_nr = offset / UPROBE_XOL_SLOT_BYTES;
-		if (slot_nr >= UINSNS_PER_PAGE)
-			return;
+	offset = slot_addr - area->vaddr;
+	/*
+	 * slot_addr must fit into [area->vaddr, area->vaddr + PAGE_SIZE).
+	 * This check can only fail if the "[uprobes]" vma was mremap'ed.
+	 */
+	if (offset < PAGE_SIZE) {
+		int slot_nr = offset / UPROBE_XOL_SLOT_BYTES;
 
 		clear_bit(slot_nr, area->bitmap);
 		atomic_dec(&area->slot_count);
 		smp_mb__after_atomic(); /* pairs with prepare_to_wait() */
 		if (waitqueue_active(&area->wq))
 			wake_up(&area->wq);
-
-		tsk->utask->xol_vaddr = 0;
 	}
 }
 
-- 
2.43.0


