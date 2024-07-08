Return-Path: <linux-kernel+bounces-244091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD24929F0B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 11:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F03D6284678
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 09:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3587345B;
	Mon,  8 Jul 2024 09:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Og/wOdK6"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EDB54F8C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 09:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720430962; cv=none; b=TsvICwTcCi47glcV5yuyfpQcFEYFvksbC/UVjMA+OhtZMeBvCiRWaNHCQ2KmNo+r88JmmXTu5lf0WuBCyRNpJ28TRCbNktTPi49eXu6BPhHWH/13nWxSYR5FacQaz9NQjAHkgAZXTdLWOND0G15ZGXKDpmEPnxqN+QU21BaCKtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720430962; c=relaxed/simple;
	bh=Jzk70wrwgyLqpwlKGY57fPB8+FPqSQUySn0ZoqTIHvk=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=SLJZqizgTIUwfj68J0gcC9ABQNU4WE+r5c8pCO2hhCDJcJ1eV2NF9O7JZBtzuWgo+UIa6X6zZzAVuX4TXNPybYx8MCp/DHqumfeN52D7IAmgG7ohOI1wnB++17VDQav6J3z4oQ603MVKT4Mh3kw1leqc+ZiFUtkY2FbQom/UxvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Og/wOdK6; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=rOfuhX/Ngd/1oTixnYxtLLU1jaqckcc7jQQl+4rPfhA=; b=Og/wOdK6h9PcPwOSR4GCF6P3Qr
	mHdhMeReDtpf2IlRf+7AnhsUrNg2PkOZysnu6MdE/GHx4UnP0J7ieaIqJRORB8PMWKMBIjcfJ703Y
	W3XIyPy5i5mUmfUv+oUsLH8YhX7ShORQ0/477eJgzAsQf4PTEN1NGrbiXKCOXLlNlPoMfYoevRDGM
	VMXiIG5/m4qz0lnjeguJOEeBbzwdUrswAWlQhVYZe/DtQoPnlU4+u/1tFUtTbfD2HD/4b6P+jz2NJ
	VTWA0JHmfE8DLJ1yYzcLoYcRYFBFsKYzPpZ3UCCk/sRNoGmT9ao7+DdntbXzUEYqoUvZCzEy46X/o
	XNlNjXEA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQkgN-00000006hOc-354R;
	Mon, 08 Jul 2024 09:29:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 1D5A3302440; Mon,  8 Jul 2024 11:29:13 +0200 (CEST)
Message-Id: <20240708092415.801757710@infradead.org>
User-Agent: quilt/0.65
Date: Mon, 08 Jul 2024 11:12:47 +0200
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
Subject: [PATCH 06/10] perf/uprobe: Split uprobe_unregister()
References: <20240708091241.544262971@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

With uprobe_unregister() having grown a synchronize_srcu(), it becomes
fairly slow to call. Esp. since both users of this API call it in a
loop.

Peel off the sync_srcu() and do it once, after the loop.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/uprobes.h     |    8 ++++++--
 kernel/events/uprobes.c     |    8 ++++++--
 kernel/trace/bpf_trace.c    |    6 ++++--
 kernel/trace/trace_uprobe.c |    6 +++++-
 4 files changed, 21 insertions(+), 7 deletions(-)

--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -113,7 +113,8 @@ extern int uprobe_write_opcode(struct ar
 extern int uprobe_register(struct inode *inode, loff_t offset, struct uprobe_consumer *uc);
 extern int uprobe_register_refctr(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
 extern int uprobe_apply(struct inode *inode, loff_t offset, struct uprobe_consumer *uc, bool);
-extern void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc);
+extern void uprobe_unregister_nosync(struct inode *inode, loff_t offset, struct uprobe_consumer *uc);
+extern void uprobe_unregister_sync(void);
 extern int uprobe_mmap(struct vm_area_struct *vma);
 extern void uprobe_munmap(struct vm_area_struct *vma, unsigned long start, unsigned long end);
 extern void uprobe_start_dup_mmap(void);
@@ -163,7 +164,10 @@ uprobe_apply(struct inode *inode, loff_t
 	return -ENOSYS;
 }
 static inline void
-uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc)
+uprobe_unregister_nosync(struct inode *inode, loff_t offset, struct uprobe_consumer *uc)
+{
+}
+static inline void uprobes_unregister_sync(void)
 {
 }
 static inline int uprobe_mmap(struct vm_area_struct *vma)
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1126,7 +1126,7 @@ __uprobe_unregister(struct uprobe *uprob
  * @offset: offset from the start of the file.
  * @uc: identify which probe if multiple probes are colocated.
  */
-void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc)
+void uprobe_unregister_nosync(struct inode *inode, loff_t offset, struct uprobe_consumer *uc)
 {
 	struct uprobe *uprobe;
 
@@ -1138,10 +1138,14 @@ void uprobe_unregister(struct inode *ino
 	__uprobe_unregister(uprobe, uc);
 	mutex_unlock(&uprobe->register_mutex);
 	put_uprobe(uprobe);
+}
+EXPORT_SYMBOL_GPL(uprobe_unregister_nosync);
 
+void uprobe_unregister_sync(void)
+{
 	synchronize_srcu(&uprobes_srcu);
 }
-EXPORT_SYMBOL_GPL(uprobe_unregister);
+EXPORT_SYMBOL_GPL(uprobe_unregister_sync);
 
 /*
  * __uprobe_register - register a probe
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3181,9 +3181,11 @@ static void bpf_uprobe_unregister(struct
 	u32 i;
 
 	for (i = 0; i < cnt; i++) {
-		uprobe_unregister(d_real_inode(path->dentry), uprobes[i].offset,
-				  &uprobes[i].consumer);
+		uprobe_unregister_nosync(d_real_inode(path->dentry), uprobes[i].offset,
+					 &uprobes[i].consumer);
 	}
+	if (cnt)
+		uprobe_unregister_sync();
 }
 
 static void bpf_uprobe_multi_link_release(struct bpf_link *link)
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -1104,6 +1104,7 @@ static int trace_uprobe_enable(struct tr
 static void __probe_event_disable(struct trace_probe *tp)
 {
 	struct trace_uprobe *tu;
+	bool sync = false;
 
 	tu = container_of(tp, struct trace_uprobe, tp);
 	WARN_ON(!uprobe_filter_is_empty(tu->tp.event->filter));
@@ -1112,9 +1113,12 @@ static void __probe_event_disable(struct
 		if (!tu->inode)
 			continue;
 
-		uprobe_unregister(tu->inode, tu->offset, &tu->consumer);
+		uprobe_unregister_nosync(tu->inode, tu->offset, &tu->consumer);
+		sync = true;
 		tu->inode = NULL;
 	}
+	if (sync)
+		uprobe_unregister_sync();
 }
 
 static int probe_event_enable(struct trace_event_call *call,



