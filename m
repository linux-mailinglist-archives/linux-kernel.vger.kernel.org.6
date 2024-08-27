Return-Path: <linux-kernel+bounces-302960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E9D96058A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81D162829D5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0974719E7EB;
	Tue, 27 Aug 2024 09:27:05 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D8D19D892
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 09:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724750824; cv=none; b=pfBvaRoEfDCpPY0JE01CI7G6AHl/ZFsFoUh51PzHONIPPeJN/PX/aq1ZybfC6eIXxHpvnbfnz0UNi27XzwOizy6zmBwi8b5OebCSL3aHxOkKcS49UqlzmOR9bD5yD4jk+SvHYHj7vgkdhjpBNEVn6zPnNa8wPfFfiUMzOrNv9rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724750824; c=relaxed/simple;
	bh=TKiJo5+xBSU6Jnu3/wyofZzugr39xRcvGRJWKdE3S1Q=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=PRdyDiwsrXVT3oRf4Njco47tLjmzBpdWyIuhm3JBq2R0UK+268ZnTE+jfaa7waBGZxP51sia8EzFxXUivAnkvIlrbRij6zDzQu7omtIziTO1X054HDKdiNUx37/zPYVbMt+xCHM347CkBZyqOLi8kdbn2LPKGCnISrobZatWjpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA19C8B7BC;
	Tue, 27 Aug 2024 09:27:04 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1sisUM-00000004SLl-2kAi;
	Tue, 27 Aug 2024 05:27:46 -0400
Message-ID: <20240827092746.514052482@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 27 Aug 2024 05:27:19 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vincent Donnefort <vdonnefort@google.com>
Subject: [for-next][PATCH 3/8] ring-buffer: Align meta-page to sub-buffers for improved TLB usage
References: <20240827092716.515115830@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Vincent Donnefort <vdonnefort@google.com>

Previously, the mapped ring-buffer layout caused misalignment between
the meta-page and sub-buffers when the sub-buffer size was not a
multiple of PAGE_SIZE. This prevented hardware with larger TLB entries
from utilizing them effectively.

Add a padding with the zero-page between the meta-page and sub-buffers.
Also update the ring-buffer map_test to verify that padding.

Link: https://lore.kernel.org/20240628104611.1443542-1-vdonnefort@google.com
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c                    | 33 +++++++++++--------
 .../testing/selftests/ring-buffer/map_test.c  | 14 ++++++++
 2 files changed, 34 insertions(+), 13 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index c3a5e6cbb940..77dc0b25140e 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6852,10 +6852,10 @@ static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
 	/* install subbuf ID to kern VA translation */
 	cpu_buffer->subbuf_ids = subbuf_ids;
 
-	meta->meta_page_size = PAGE_SIZE;
 	meta->meta_struct_len = sizeof(*meta);
 	meta->nr_subbufs = nr_subbufs;
 	meta->subbuf_size = cpu_buffer->buffer->subbuf_size + BUF_PAGE_HDR_SIZE;
+	meta->meta_page_size = meta->subbuf_size;
 
 	rb_update_meta_page(cpu_buffer);
 }
@@ -6949,6 +6949,12 @@ static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
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
@@ -6958,11 +6964,8 @@ static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
 
 	lockdep_assert_held(&cpu_buffer->mapping_lock);
 
-	subbuf_order = cpu_buffer->buffer->subbuf_order;
-	subbuf_pages = 1 << subbuf_order;
-
 	nr_subbufs = cpu_buffer->nr_pages + 1; /* + reader-subbuf */
-	nr_pages = ((nr_subbufs) << subbuf_order) - pgoff + 1; /* + meta-page */
+	nr_pages = ((nr_subbufs + 1) << subbuf_order) - pgoff; /* + meta-page */
 
 	nr_vma_pages = vma_pages(vma);
 	if (!nr_vma_pages || nr_vma_pages > nr_pages)
@@ -6975,20 +6978,24 @@ static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
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
-	} else {
-		/* Skip the meta-page */
-		pgoff--;
+		meta_page_padding = subbuf_pages - 1;
+		while (meta_page_padding-- && p < nr_pages) {
+			unsigned long __maybe_unused zero_addr =
+				vma->vm_start + (PAGE_SIZE * p);
 
-		if (pgoff % subbuf_pages) {
-			err = -EINVAL;
-			goto out;
+			pages[p++] = ZERO_PAGE(zero_addr);
 		}
+	} else {
+		/* Skip the meta-page */
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
-- 
2.43.0



