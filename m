Return-Path: <linux-kernel+bounces-204824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C53F08FF3E9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 19:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F6A11F282A4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958561991CE;
	Thu,  6 Jun 2024 17:39:23 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F27438DC7
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 17:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717695563; cv=none; b=spg+gdhQjVllrhj8D2hMtRMZakjmBUGOJ1wskTOBWJJ2O5UmHql4QQtY2rwCeYIe0ZBo1V3KOxzBIlXDcrqR1uRBPFVc1N/LjoqnWrcHVqyJxzfR2fDXvmz/QTafPPtelGs3IQdUiEnCNYHjR4DWRM2EUZ1Iu8ls96uiVroi2Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717695563; c=relaxed/simple;
	bh=vzUJmp9RSaHFxKhynNzblRWh4Wso+VaChGcCRUFdtOg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=tsWSALvckSMK1kqs0efVK1dp4PSc9oCUkvDnug9OLq5dU9sdVZD1ltnwV3tbp5BcxAYxNSbyPX9yd6vYM+y2CQaTU27iPW0Csb7uw/vCj+egsiQwnYUJo+XnTriv9pHD5AwjYXyqIEtO12i6mi5QfdnCREIKZ50oam9z45TN5nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00119C32782;
	Thu,  6 Jun 2024 17:39:21 +0000 (UTC)
Date: Thu, 6 Jun 2024 13:39:33 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Vincent Donnefort <vdonnefort@google.com>
Subject: [for-next][PATCH] ring-buffer: Align meta-page to sub-buffers for
 improved TLB usage
Message-ID: <20240606133933.175a6b2a@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
ring-buffer/for-next

Head SHA1: ff74f987504fe90e88fdba8d80197202868ce342


Vincent Donnefort (1):
      ring-buffer: Align meta-page to sub-buffers for improved TLB usage

----
 kernel/trace/ring_buffer.c                     | 29 ++++++++++++++------------
 tools/testing/selftests/ring-buffer/map_test.c | 14 +++++++++++++
 2 files changed, 30 insertions(+), 13 deletions(-)
---------------------------
commit ff74f987504fe90e88fdba8d80197202868ce342
Author: Vincent Donnefort <vdonnefort@google.com>
Date:   Thu May 23 10:14:45 2024 +0100

    ring-buffer: Align meta-page to sub-buffers for improved TLB usage
    
    Previously, the mapped ring-buffer layout caused misalignment between
    the meta-page and sub-buffers when the sub-buffer size was not a
    multiple of PAGE_SIZE. This prevented hardware with larger TLB entries
    from utilizing them effectively.
    
    Add a padding with the zero-page between the meta-page and sub-buffers.
    Also update the ring-buffer map_test to verify that padding.
    
    Link: https://lore.kernel.org/linux-trace-kernel/20240523091445.2568208-1-vdonnefort@google.com
    
    Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
    Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 28853966aa9a..41f58415c709 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6147,10 +6147,10 @@ static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
 	/* install subbuf ID to kern VA translation */
 	cpu_buffer->subbuf_ids = subbuf_ids;
 
-	meta->meta_page_size = PAGE_SIZE;
 	meta->meta_struct_len = sizeof(*meta);
 	meta->nr_subbufs = nr_subbufs;
 	meta->subbuf_size = cpu_buffer->buffer->subbuf_size + BUF_PAGE_HDR_SIZE;
+	meta->meta_page_size = meta->subbuf_size;
 
 	rb_update_meta_page(cpu_buffer);
 }
@@ -6237,6 +6237,12 @@ static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
 	    !(vma->vm_flags & VM_MAYSHARE))
 		return -EPERM;
 
+	subbuf_order = cpu_buffer->buffer->subbuf_order;
+	subbuf_pages = 1 << subbuf_order;
+
+	if (subbuf_order && pgoff % subbuf_pages)
+		return -EINVAL;
+
 	/*
 	 * Make sure the mapping cannot become writable later. Also tell the VM
 	 * to not touch these pages (VM_DONTCOPY | VM_DONTEXPAND).
@@ -6246,11 +6252,8 @@ static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
 
 	lockdep_assert_held(&cpu_buffer->mapping_lock);
 
-	subbuf_order = cpu_buffer->buffer->subbuf_order;
-	subbuf_pages = 1 << subbuf_order;
-
 	nr_subbufs = cpu_buffer->nr_pages + 1; /* + reader-subbuf */
-	nr_pages = ((nr_subbufs) << subbuf_order) - pgoff + 1; /* + meta-page */
+	nr_pages = ((nr_subbufs + 1) << subbuf_order) - pgoff; /* + meta-page */
 
 	vma_pages = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
 	if (!vma_pages || vma_pages > nr_pages)
@@ -6263,20 +6266,20 @@ static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
 		return -ENOMEM;
 
 	if (!pgoff) {
+		unsigned long meta_page_padding;
+
 		pages[p++] = virt_to_page(cpu_buffer->meta_page);
 
 		/*
-		 * TODO: Align sub-buffers on their size, once
-		 * vm_insert_pages() supports the zero-page.
+		 * Pad with the zero-page to align the meta-page with the
+		 * sub-buffers.
 		 */
+		meta_page_padding = subbuf_pages - 1;
+		while (meta_page_padding-- && p < nr_pages)
+			pages[p++] = ZERO_PAGE(vma->vm_start + (PAGE_SIZE * p));
 	} else {
 		/* Skip the meta-page */
-		pgoff--;
-
-		if (pgoff % subbuf_pages) {
-			err = -EINVAL;
-			goto out;
-		}
+		pgoff -= subbuf_pages;
 
 		s += pgoff / subbuf_pages;
 	}
diff --git a/tools/testing/selftests/ring-buffer/map_test.c b/tools/testing/selftests/ring-buffer/map_test.c
index a9006fa7097e..4bb0192e43f3 100644
--- a/tools/testing/selftests/ring-buffer/map_test.c
+++ b/tools/testing/selftests/ring-buffer/map_test.c
@@ -228,6 +228,20 @@ TEST_F(map, data_mmap)
 	data = mmap(NULL, data_len, PROT_READ, MAP_SHARED,
 		    desc->cpu_fd, meta_len);
 	ASSERT_EQ(data, MAP_FAILED);
+
+	/* Verify meta-page padding */
+	if (desc->meta->meta_page_size > getpagesize()) {
+		void *addr;
+
+		data_len = desc->meta->meta_page_size;
+		data = mmap(NULL, data_len,
+			    PROT_READ, MAP_SHARED, desc->cpu_fd, 0);
+		ASSERT_NE(data, MAP_FAILED);
+
+		addr = (void *)((unsigned long)data + getpagesize());
+		ASSERT_EQ(*((int *)addr), 0);
+		munmap(data, data_len);
+	}
 }
 
 FIXTURE(snapshot) {

