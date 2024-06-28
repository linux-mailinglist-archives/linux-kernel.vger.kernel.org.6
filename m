Return-Path: <linux-kernel+bounces-233764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B971C91BCC8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 12:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EC37B21584
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 10:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96B115573B;
	Fri, 28 Jun 2024 10:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v4lp96/z"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC6F14A636
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 10:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719571624; cv=none; b=WcIPWOqgRYVkefAkKG85Gqmd2T/rQXsJ4yIDEeQ0qmC4CBcjzB7UF3bKpF9N7ojMUlooUZyqTLA1EzTSJGptGSBI8oyQMlkBOZKs329x3PgdrMEs4y2z+3hlSut898nV5Ostx6LrfYCvfuzPvKdBSSdkmpwrHuCVBlMHacbd81I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719571624; c=relaxed/simple;
	bh=woktVHjxsn0gr5hr8+bromFgaR2dogPu6y9jS/+fBQ4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZVKE173fuyereBGAYRfxqaBrUz1m+4sl7QvXNX0wxZsGASCs5kLWttNxPHpisobfM0OGHClwuWIObx7IhytF8sxbv/EhjcvzZxegQDhqpx39/HDV3Bktogtq/piWeVhdBR2u3iI/pjUuqBxnTxVZHbGIurINTgaUbS+c7LDslvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v4lp96/z; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4256b7702a5so3132145e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 03:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719571621; x=1720176421; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mVAGmQDGpiRemF1EjQXmA7rPtOTMJWbLR7/b4BT5RFw=;
        b=v4lp96/zQJlpT76ERcsL2tTbP+JW1NhGvQ5uwwFgTNoLRUs+SGYLfnTqQCe6DBPQ5H
         Mx8sryHVafGwO3Ml+GgqFaEsvXeHDDBKvafg2uceSg9jAdh3YfcRS1xgEMchyNWyGMDH
         3O0L1BkzchL6I/SeZ96rgyLoCInWvppjWl11JP6RVHkvx0RyPV+d2LJEZuSJ0bxqnsst
         k1xNT20wPS56kysw44D516gpywYHTOBf18Uf8kidQ6A2NnQPqUxqWgf1IooY0jrM8gl6
         itD8Ag1zxudVy1srXdYWT90f+b4jZk1Q3g93QQWrnBrBeDZ7uNX7b+7mOIq4iSYwLWhr
         d7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719571621; x=1720176421;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mVAGmQDGpiRemF1EjQXmA7rPtOTMJWbLR7/b4BT5RFw=;
        b=sjKvj5ptOVBEeC7N454tZGO+vdOMHxsBCgmgYoVghYrSc7XBhucxdFfZPr+Y2NFBJK
         pOotTk12qpGAZos7UtyStjRchWRqKOcwHdVyX5BTi8sZktryNtx3G+PT/4HRvRjvvfkl
         7ZxQkitI/X5JMMwbFY/Na+ulQtgHVGu24Xo5VVBVU3SQ1A91a9r70qhhv5YYFa4Ax39O
         SwF4WQNbuJXyoD1/t0n4TeL6MzdZgt1KRX44npUXdeMDHtyWvIDutrLypbRs8vkEnsve
         hD57wgb1sXKsKwXF2wcU5kgCpfZG73HtP+QTSD9gTnQ0EMZCdr/1YrqnPIGokdHsBjQi
         e0VQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqW+9RAjOGB7G2TU/8Wu5UkrDjg1TxvBIarjL6KwY053mihzqNqlx6wHBHFhf5tTl5ik2uq2xQ3LjUXsjr7o6qBErXlS2khBspj8Qb
X-Gm-Message-State: AOJu0YzaK2Ma2h8MKzB+6UTYW647IenFGnfkNhdH0n7OGgm1XZ2oVZCS
	33RzpzDtvlInII2EHZcWbNda/Gw8yAyIciuR8iJBZpj2dZXPIJyIWKkvexOweWEuqsEZLzE5MDk
	lt8UY9J4e4yowY8KxbQ==
X-Google-Smtp-Source: AGHT+IHZHlvGw4nxcFoHXUEV2Mmu2bpQJUntZHoAE0zOBHagzfvEXRkaEhyc77Lxq96Bn5RGJbrsHF420JmpKzNT
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:600c:4c11:b0:425:5eee:2b75 with
 SMTP id 5b1f17b1804b1-4256d5a7ceamr221355e9.4.1719571620888; Fri, 28 Jun 2024
 03:47:00 -0700 (PDT)
Date: Fri, 28 Jun 2024 11:46:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240628104611.1443542-1-vdonnefort@google.com>
Subject: [PATCH v2] ring-buffer: Align meta-page to sub-buffers for improved
 TLB usage
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, david@redhat.com, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Previously, the mapped ring-buffer layout caused misalignment between
the meta-page and sub-buffers when the sub-buffer size was not a
multiple of PAGE_SIZE. This prevented hardware with larger TLB entries
from utilizing them effectively.

Add a padding with the zero-page between the meta-page and sub-buffers.
Also update the ring-buffer map_test to verify that padding.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

--

This is based on the mm-unstable branch [1] as it depends on David's work [2]
for allowing the zero-page in vm_insert_page().

[1] https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git
[2] https://lore.kernel.org/all/20240522125713.775114-1-david@redhat.com

v1 -> v2:
  * Fix unsequenced modification and access to 'p' (s390 build)


diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 7345a8b625fb..c1116e76fe17 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6148,10 +6148,10 @@ static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
 	/* install subbuf ID to kern VA translation */
 	cpu_buffer->subbuf_ids = subbuf_ids;
 
-	meta->meta_page_size = PAGE_SIZE;
 	meta->meta_struct_len = sizeof(*meta);
 	meta->nr_subbufs = nr_subbufs;
 	meta->subbuf_size = cpu_buffer->buffer->subbuf_size + BUF_PAGE_HDR_SIZE;
+	meta->meta_page_size = meta->subbuf_size;
 
 	rb_update_meta_page(cpu_buffer);
 }
@@ -6238,6 +6238,12 @@ static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
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
@@ -6247,11 +6253,8 @@ static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
 
 	lockdep_assert_held(&cpu_buffer->mapping_lock);
 
-	subbuf_order = cpu_buffer->buffer->subbuf_order;
-	subbuf_pages = 1 << subbuf_order;
-
 	nr_subbufs = cpu_buffer->nr_pages + 1; /* + reader-subbuf */
-	nr_pages = ((nr_subbufs) << subbuf_order) - pgoff + 1; /* + meta-page */
+	nr_pages = ((nr_subbufs + 1) << subbuf_order) - pgoff; /* + meta-page */
 
 	vma_pages = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
 	if (!vma_pages || vma_pages > nr_pages)
@@ -6264,20 +6267,24 @@ static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
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

base-commit: c65920c76a977c2b73c3a8b03b4c0c00cc1285ed
-- 
2.45.2.803.g4e1b14247a-goog


