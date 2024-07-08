Return-Path: <linux-kernel+bounces-244099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52235929F14
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 11:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08A6F2863E5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 09:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A6A7D071;
	Mon,  8 Jul 2024 09:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fLP2gPzh"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39A854F8C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 09:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720430970; cv=none; b=jW7S1jRFVn+BoJmh4AAHdou8FmKs3eGei7jbatFta4JpYppYzdQToDW4I4Gu24Z24uydA0MX7BcaUb/GhHGCLncrn4FY1gIjU9ipw4PGG/+YXHo/yoboNHSGlYNg8sMdrC8eVZzGT+uFFXSX6dNpv6zXELrXQuHCTq14BNOqc1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720430970; c=relaxed/simple;
	bh=Z+tf+zGbvC0gSaMaFf/2zXls1bdcxX+Z2+74bcL4sJ4=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=kpoq2AN3XVlnEbl+wR0vUsyuBhf3dRg1ErKAcs3McDAQ/2W0GYQTnLd4VEIsfGPO1jowEl/mJSG87KqsoXmf4s55b5Gj4F3k0voJnaAoKD+3abPgL/EuCbDxXBjzeUBmpAF1FbHlrtkEq1KymgpFX2STwdDOPCD0aAOrxaCCd4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fLP2gPzh; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=FqzzvelQ00c0zN3R4blHkZc53U+LXab6OIi85Tl6cJg=; b=fLP2gPzh1ziLfREnPNinzFXPxf
	sBEqJ7n7OTCxUyDyP8q/bXvawVZAyjInEmcSc9+0lpU6nc+ksfETXaboPaCDQ9WWygKzm7IuFyF3c
	mdAtHCaTIB2pjKBQaFTfbbfX+WqW4HmpzkMfvoh3bay70f2GyIRbGmr46tGoMC7SQ3366a4UbzO5c
	E05PXU/Lb8eBJ+rM9uYp7juW0cnlXrPuBo3PN4QpeyNH1TAFBGx6Ubprnrw9AfyfCzxVno4myTp0i
	0nsukPCI+l7AkUVhOjNh3ynw+0lDiDKXAcm+7kGKipX5FCQApa+iyIIjpDEntWqkhB7FTd2yAI73Y
	av1EunCQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQkgN-00000000ZsP-4BCt;
	Mon, 08 Jul 2024 09:29:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 184B2302182; Mon,  8 Jul 2024 11:29:13 +0200 (CEST)
Message-Id: <20240708092415.695619684@infradead.org>
User-Agent: quilt/0.65
Date: Mon, 08 Jul 2024 11:12:46 +0200
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
Subject: [PATCH 05/10] perf/uprobe: SRCU-ify uprobe->consumer list
References: <20240708091241.544262971@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

With handle_swbp() hitting concurrently on (all) CPUs the
uprobe->register_rwsem can get very contended. Replace it with
SRCU+mutex.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/uprobes.c |   37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -26,6 +26,7 @@
 #include <linux/task_work.h>
 #include <linux/shmem_fs.h>
 #include <linux/khugepaged.h>
+#include <linux/srcu.h>
 
 #include <linux/uprobes.h>
 
@@ -49,6 +50,8 @@ static struct mutex uprobes_mmap_mutex[U
 
 DEFINE_STATIC_PERCPU_RWSEM(dup_mmap_sem);
 
+DEFINE_STATIC_SRCU(uprobes_srcu);
+
 /* Have a copy of original instruction */
 #define UPROBE_COPY_INSN	0
 
@@ -56,7 +59,7 @@ struct uprobe {
 	struct rb_node		rb_node;	/* node in the rb tree */
 	refcount_t		ref;
 	struct rcu_head		rcu;
-	struct rw_semaphore	register_rwsem;
+	struct mutex		register_mutex;
 	struct rw_semaphore	consumer_rwsem;
 	struct list_head	pending_list;
 	struct uprobe_consumer	*consumers;
@@ -750,7 +753,7 @@ static struct uprobe *alloc_uprobe(struc
 	uprobe->inode = inode;
 	uprobe->offset = offset;
 	uprobe->ref_ctr_offset = ref_ctr_offset;
-	init_rwsem(&uprobe->register_rwsem);
+	mutex_init(&uprobe->register_mutex);
 	init_rwsem(&uprobe->consumer_rwsem);
 
 	/* add to uprobes_tree, sorted on inode:offset */
@@ -1129,10 +1132,12 @@ void uprobe_unregister(struct inode *ino
 	if (WARN_ON(!uprobe))
 		return;
 
-	down_write(&uprobe->register_rwsem);
+	mutex_lock(&uprobe->register_mutex);
 	__uprobe_unregister(uprobe, uc);
-	up_write(&uprobe->register_rwsem);
+	mutex_unlock(&uprobe->register_mutex);
 	put_uprobe(uprobe);
+
+	synchronize_srcu(&uprobes_srcu);
 }
 EXPORT_SYMBOL_GPL(uprobe_unregister);
 
@@ -1192,7 +1197,7 @@ static int __uprobe_register(struct inod
 	 * We can race with uprobe_unregister()->delete_uprobe().
 	 * Check uprobe_is_active() and retry if it is false.
 	 */
-	down_write(&uprobe->register_rwsem);
+	mutex_lock(&uprobe->register_mutex);
 	ret = -EAGAIN;
 	if (likely(uprobe_is_active(uprobe))) {
 		consumer_add(uprobe, uc);
@@ -1200,7 +1205,7 @@ static int __uprobe_register(struct inod
 		if (ret)
 			__uprobe_unregister(uprobe, uc);
 	}
-	up_write(&uprobe->register_rwsem);
+	mutex_unlock(&uprobe->register_mutex);
 	put_uprobe(uprobe);
 
 	if (unlikely(ret == -EAGAIN))
@@ -1240,12 +1245,12 @@ int uprobe_apply(struct inode *inode, lo
 	if (WARN_ON(!uprobe))
 		return ret;
 
-	down_write(&uprobe->register_rwsem);
+	mutex_lock(&uprobe->register_mutex);
 	for (con = uprobe->consumers; con && con != uc ; con = con->next)
 		;
 	if (con)
 		ret = register_for_each_vma(uprobe, add ? uc : NULL);
-	up_write(&uprobe->register_rwsem);
+	mutex_unlock(&uprobe->register_mutex);
 	put_uprobe(uprobe);
 
 	return ret;
@@ -2087,14 +2092,19 @@ static struct uprobe *find_active_uprobe
 	return uprobe;
 }
 
+#define for_each_consumer_rcu(pos, head) \
+	for (pos = rcu_dereference_raw(head); pos; \
+	     pos = rcu_dereference_raw(pos->next))
+
 static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
 {
 	struct uprobe_consumer *uc;
 	int remove = UPROBE_HANDLER_REMOVE;
 	bool need_prep = false; /* prepare return uprobe, when needed */
 
-	down_read(&uprobe->register_rwsem);
-	for (uc = uprobe->consumers; uc; uc = uc->next) {
+	guard(srcu)(&uprobes_srcu);
+
+	for_each_consumer_rcu(uc, uprobe->consumers) {
 		int rc = 0;
 
 		if (uc->handler) {
@@ -2116,7 +2126,6 @@ static void handler_chain(struct uprobe
 		WARN_ON(!uprobe_is_active(uprobe));
 		unapply_uprobe(uprobe, current->mm);
 	}
-	up_read(&uprobe->register_rwsem);
 }
 
 static void
@@ -2125,12 +2134,12 @@ handle_uretprobe_chain(struct return_ins
 	struct uprobe *uprobe = ri->uprobe;
 	struct uprobe_consumer *uc;
 
-	down_read(&uprobe->register_rwsem);
-	for (uc = uprobe->consumers; uc; uc = uc->next) {
+	guard(srcu)(&uprobes_srcu);
+
+	for_each_consumer_rcu(uc, uprobe->consumers) {
 		if (uc->ret_handler)
 			uc->ret_handler(uc, ri->func, regs);
 	}
-	up_read(&uprobe->register_rwsem);
 }
 
 static struct return_instance *find_next_ret_chain(struct return_instance *ri)



