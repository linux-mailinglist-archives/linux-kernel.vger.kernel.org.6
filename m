Return-Path: <linux-kernel+bounces-244092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 263AD929F0A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 11:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF3321F2307A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 09:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95417318A;
	Mon,  8 Jul 2024 09:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZhDoV64x"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8741B558B7
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 09:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720430962; cv=none; b=TRmRkzArn5qHC10/U0ScWiqjqorpk0g+QPLihs0Y7eQ2QuhwG1WoAIN68Z0r+LXcfTrvulQvXtwiPHmtEyM2XrW/R4AAcqP7SLPUuIadJglcxySJOos8Pm4MmqYLB0R0WboB8gX1OTKJFPDHlhLIiCP83J2HxvLuFTOgphEB62M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720430962; c=relaxed/simple;
	bh=iPnzJDPYV69x97yqOMsVW8M8RvXBmzlPMZ6dojO6w9w=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=MedHdErqTeaABiaDnfG8CjJM2aonAQVyUhT8OUwyYy0gnVSK0x+Q6NSk4zHyUhCViJXdFjlDbydzV2r/Igad19FRjS1CCYLX9LJRTUgSc3cDUdu4wWBokPQqNeMHMAVTpF3dYrIKOhrztoVEdctE+WI3v0m7ADtgmn9MPer5Iyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZhDoV64x; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=D/qnIt6lTHMe7dedD5Wou6cHbGCP/Pb/6K/ANgI22y8=; b=ZhDoV64xmEOYU3QOIuxBQCNP+Y
	Ynnoc9WLR+a6eFbtR7QM7jbooUAyBMP6wgKs87UjpKsmZs5PeyTJeOwJfFJw4TwX5+lA78oK0jZSz
	mVAgKDK5wkYirKH9OrxYh+temyYaENpOByTAXm/IpzLMJ03kXhR6kVYy6dDpN1R8WVP/vZgSvdbA8
	e6mQOawMKct21VRt92YBJkam4rt3EjOv4K/z4Imue/1vbdQH/pRnhlz/TVY3BVsQvvYrdSdvaX0ly
	s1OZJ9fwdUA9pyRAT5WjWB3zYQsW0XdPAAIKK8bMotWEuj7fUkcqNW3SxG0T9oiQ2UoW88KA8ptPH
	YJ3LXvLQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQkgN-00000006hOX-0jnI;
	Mon, 08 Jul 2024 09:29:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 044993006B7; Mon,  8 Jul 2024 11:29:13 +0200 (CEST)
Message-Id: <20240708092415.248663071@infradead.org>
User-Agent: quilt/0.65
Date: Mon, 08 Jul 2024 11:12:42 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org,
 andrii@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 rostedt@goodmis.org,
 mhiramat@kernel.org,
 oleg@redhat.com,
 jolsa@kernel.org,
 clm@meta.com,
 paulmck@kernel.org
Subject: [PATCH 01/10] perf/uprobe: Re-indent labels
References: <20240708091241.544262971@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Remove the silly label indenting.

 s/^\ \([[:alnum:]]*\):$/\1:/g

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/uprobes.c |   26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -205,7 +205,7 @@ static int __replace_page(struct vm_area
 	folio_put(old_folio);
 
 	err = 0;
- unlock:
+unlock:
 	mmu_notifier_invalidate_range_end(&range);
 	folio_unlock(old_folio);
 	return err;
@@ -857,7 +857,7 @@ static int prepare_uprobe(struct uprobe
 	smp_wmb(); /* pairs with the smp_rmb() in handle_swbp() */
 	set_bit(UPROBE_COPY_INSN, &uprobe->flags);
 
- out:
+out:
 	up_write(&uprobe->consumer_rwsem);
 
 	return ret;
@@ -965,7 +965,7 @@ build_map_info(struct address_space *map
 	struct map_info *info;
 	int more = 0;
 
- again:
+again:
 	i_mmap_lock_read(mapping);
 	vma_interval_tree_foreach(vma, &mapping->i_mmap, pgoff, pgoff) {
 		if (!valid_vma(vma, is_register))
@@ -1019,7 +1019,7 @@ build_map_info(struct address_space *map
 	} while (--more);
 
 	goto again;
- out:
+out:
 	while (prev)
 		prev = free_map_info(prev);
 	return curr;
@@ -1068,13 +1068,13 @@ register_for_each_vma(struct uprobe *upr
 				err |= remove_breakpoint(uprobe, mm, info->vaddr);
 		}
 
- unlock:
+unlock:
 		mmap_write_unlock(mm);
- free:
+free:
 		mmput(mm);
 		info = free_map_info(info);
 	}
- out:
+out:
 	percpu_up_write(&dup_mmap_sem);
 	return err;
 }
@@ -1159,7 +1159,7 @@ static int __uprobe_register(struct inod
 	if (!IS_ALIGNED(ref_ctr_offset, sizeof(short)))
 		return -EINVAL;
 
- retry:
+retry:
 	uprobe = alloc_uprobe(inode, offset, ref_ctr_offset);
 	if (!uprobe)
 		return -ENOMEM;
@@ -1468,7 +1468,7 @@ static int xol_add_vma(struct mm_struct
 	ret = 0;
 	/* pairs with get_xol_area() */
 	smp_store_release(&mm->uprobes_state.xol_area, area); /* ^^^ */
- fail:
+fail:
 	mmap_write_unlock(mm);
 
 	return ret;
@@ -1512,7 +1512,7 @@ static struct xol_area *__create_xol_are
 	kfree(area->bitmap);
  free_area:
 	kfree(area);
- out:
+out:
 	return NULL;
 }
 
@@ -1915,7 +1915,7 @@ static void prepare_uretprobe(struct upr
 	utask->return_instances = ri;
 
 	return;
- fail:
+fail:
 	kfree(ri);
 }
 
@@ -2031,7 +2031,7 @@ static int is_trap_at_addr(struct mm_str
 
 	copy_from_page(page, vaddr, &opcode, UPROBE_SWBP_INSN_SIZE);
 	put_page(page);
- out:
+out:
 	/* This needs to return true for any variant of the trap insn */
 	return is_trap_insn(&opcode);
 }
@@ -2159,7 +2159,7 @@ static void handle_trampoline(struct pt_
 	utask->return_instances = ri;
 	return;
 
- sigill:
+sigill:
 	uprobe_warn(current, "handle uretprobe, sending SIGILL.");
 	force_sig(SIGILL);
 



