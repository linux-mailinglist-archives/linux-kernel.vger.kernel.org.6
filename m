Return-Path: <linux-kernel+bounces-187229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 569D68CCED5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 873E91C21559
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E5313D2A4;
	Thu, 23 May 2024 09:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hu3E3NmJ"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA4A13D29C
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 09:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716455705; cv=none; b=MZDkDnTC0Q4nlwTqsnA7E8VMxqkkD7eeahoczHNx/VQvLzCP1q2pra7gxV0ZqMzYxDpo0naBRh59N3AuXVfxnNJSjnkQIPdSTlKwzIuquDy0WBYwopNU7mC+hSvtURc0zofK8GepOLKV8f/0g+R8Xi1rnIbpCoW2E9E9LOrSK18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716455705; c=relaxed/simple;
	bh=+HnSm28nck3VHTqGDjmFRzfJxYg/Ohuag17riecvzUk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=K3+NCW5B+G5x0DM48Wcby+bUtP6dn9ZRN3f1hFr+DuAckW7KY/5JyM3iv5nCkHxi5o3r3Zmcv8dawTTYbQB+dtRBIKCu6JOupy9jOZN2mbacqpOsplHZLdwf8BSD7w8F5w54JW8K90K+Wjf4+kMNjblqUUy9Cx0IZujkkKY+kRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hu3E3NmJ; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-420eed123a2so25203885e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 02:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716455701; x=1717060501; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jk02q1xwaAjXdhW1L0zkxXMpbJH4jmKA0Vi9iubvVTQ=;
        b=Hu3E3NmJhTw6viN2yRhRLFouEozrZV61ZWjzLpAOuJqNui7GJZ92KM7FbGtWO4ji2d
         f4uo3OvxR3dR/+iZGVyqTfUVgFeN+WlPbigiAjbx6NS0vvDfbIqw3CMTSH/va1KpKFNJ
         31NqYHp6jv/burC3DURPdwiGbRne0RyKXcdKCmCltaUVETC5mPnwcBuqe7/UdJrt1HpA
         AvvpEdJ+BZctuA4uPYRn/cMturmlXviAXffmTPHsvH5zXqyUvL7bPVLij9tbKk6BUjeU
         4jDZLeW+YYecmuxrfrKyi9bgivvRxmj3LVEGttN9XoYaWKEYLX6O9oA6BJYwX8g2xfGL
         SIiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716455701; x=1717060501;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jk02q1xwaAjXdhW1L0zkxXMpbJH4jmKA0Vi9iubvVTQ=;
        b=v29bJHqGOvP6gHNzoOnQL05Jge4l6usXlsLIC93Eict2jfMEeYxsL64oHHpb0azk0Y
         bDma4WjFBGb99U5u4cQU0c9J9c6A51EkdmKO0IH1OeX+flo3PFW8cKl2gbXWRuOEYsdz
         aV3eavv86+b5F9xX3a5njoDvGZ8LpxRM0U/HNBLZyUt7N7Hgk+6U8U9OJp3emUEQAZO2
         /YDuSdaqHuFOdfQ+G5BLAHF5llwxslNRPwa/KRObokqJgN7uHGL2KzIX+SiTbbeCdRvC
         h4QtekxKMtSWvF/dsI7GXJIjFtrNNFCQ8qJTDN2wu4kNjCC60WyWntDkGUrtSpN4CFrG
         +TKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWa6k8MYoz2I4SVGyBgP+NrhsRp2ecog86R3LjNp9OUn54rwAylPtjxyPl9RbyMTBocMI6pZ9u2muSrJ1Uuz5XYKGu570geLPMcght4
X-Gm-Message-State: AOJu0YwD6AkYKEX6o9fm/7gWpBZnRz3dde6QwKZep/CtrPppCF5nBcSL
	RzZGLIGxcyVFxCNJ+u/5OkzLc5DSoqEB+0NVJUwimVB/UZ5CtB//1mSiizSoPKmCwRg29sV1o7E
	oPszYapl9K9y2+TcvZQ==
X-Google-Smtp-Source: AGHT+IFg0ElFrdX/ypixxrO8pVGQT9ah/+snHJKoSVpE1zD3SXtCvnzIsIEBrtrrVICcmdjEFsitmkmwny5oAyA5
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:600c:5127:b0:420:217f:4f7 with SMTP
 id 5b1f17b1804b1-420fd3894d4mr185815e9.6.1716455700542; Thu, 23 May 2024
 02:15:00 -0700 (PDT)
Date: Thu, 23 May 2024 10:14:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240523091445.2568208-1-vdonnefort@google.com>
Subject: [PATCH] ring-buffer: Align meta-page to sub-buffers for improved TLB usage
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

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 7345a8b625fb..acaab4d4288f 100644
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
@@ -6264,20 +6267,20 @@ static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
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

base-commit: c65920c76a977c2b73c3a8b03b4c0c00cc1285ed
-- 
2.45.1.288.g0e0cd299f1-goog


