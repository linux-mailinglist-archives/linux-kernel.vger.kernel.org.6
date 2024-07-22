Return-Path: <linux-kernel+bounces-259203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E487939290
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 18:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2291A281A26
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 16:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AF216E871;
	Mon, 22 Jul 2024 16:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="apt6UI3X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6441626ACD;
	Mon, 22 Jul 2024 16:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721665908; cv=none; b=kPGRQ6xcDJP7UDH5Nwlz/iA8x3CwIwezcEL0JRdch6UtnP7b+jN97YMd4EG4VklEwrXzCrDKrR/PUA38S+I9jusEpo4Jf3wMOIdg41wrR4p7toWVV/t7T+q0GRzg4cEcHdHeDh5CAbUHxKFL+DO2p41cv3py5rac0Sf9GVQ98Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721665908; c=relaxed/simple;
	bh=8R5zLx4UelCLfyVht0GJQcdBO0xBkZadv109mekdLLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vBVh8bQ7d8dqM3q8VHIGBAm+qul5IEjqeyxYDzAR43nh+h+wpx0q58CbU0wjtHNtQZhOk7ReJEVXhTt6gKY+KI55S3siuDAd/JTI4sxnufVJkguneJwHHIpUAeRJgXtRpio2JdjLPtnyj+O6EQCQHnlL1ZAUSV5DKsE7OWr9IU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=apt6UI3X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D35FC116B1;
	Mon, 22 Jul 2024 16:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721665907;
	bh=8R5zLx4UelCLfyVht0GJQcdBO0xBkZadv109mekdLLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=apt6UI3XCpX9famE1RKBq9IxyCaLlbsuNOSSSCetsAo3Ccd6iOmtq2aw/OEgdOV9N
	 yjQK039V0lwMuJluAOKh85GkhNES/hTRB0foU7Qehnd/Isq1dimaVRxVwrvW/PWWH+
	 g7kjlZ80Xul72QYxRUdKzhYUIht4L8LHGblAOAaA49j6k8iDQ0lE9BviAU8AWExbmp
	 WpWO1NsmDthK2QhGzYIXLmYOJnRvTfIiqXEyNjkPEV/vyaW9nztTV4PoiXDtsAQYI6
	 BAlHaRVGQFEmdywmM7vomRsNKZWfD3HuRwIyfFlx/gqo+iwJVqIu0u8PfxpYGe6fxG
	 RUdnzyypKuRog==
From: Danilo Krummrich <dakr@kernel.org>
To: cl@linux.com,
	penberg@kernel.org,
	rientjes@google.com,
	iamjoonsoo.kim@lge.com,
	akpm@linux-foundation.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	42.hyeyoo@gmail.com,
	urezki@gmail.com,
	hch@infradead.org,
	kees@kernel.org,
	ojeda@kernel.org,
	wedsonaf@gmail.com,
	mhocko@kernel.org,
	mpe@ellerman.id.au,
	chandan.babu@oracle.com,
	christian.koenig@amd.com,
	maz@kernel.org,
	oliver.upton@linux.dev
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v2 1/2] mm: vmalloc: implement vrealloc()
Date: Mon, 22 Jul 2024 18:29:23 +0200
Message-ID: <20240722163111.4766-2-dakr@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240722163111.4766-1-dakr@kernel.org>
References: <20240722163111.4766-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement vrealloc() analogous to krealloc().

Currently, krealloc() requires the caller to pass the size of the
previous memory allocation, which, instead, should be self-contained.

We attempt to fix this in a subsequent patch which, in order to do so,
requires vrealloc().

Besides that, we need realloc() functions for kernel allocators in Rust
too. With `Vec` or `KVec` respectively, potentially growing (and
shrinking) data structures are rather common.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 include/linux/vmalloc.h |  4 +++
 mm/vmalloc.c            | 59 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index e4a631ec430b..ad2ce7a6ab7a 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -189,6 +189,10 @@ extern void *__vcalloc_noprof(size_t n, size_t size, gfp_t flags) __alloc_size(1
 extern void *vcalloc_noprof(size_t n, size_t size) __alloc_size(1, 2);
 #define vcalloc(...)		alloc_hooks(vcalloc_noprof(__VA_ARGS__))
 
+void * __must_check vrealloc_noprof(const void *p, size_t size, gfp_t flags)
+		__realloc_size(2);
+#define vrealloc(...)		alloc_hooks(vrealloc_noprof(__VA_ARGS__))
+
 extern void vfree(const void *addr);
 extern void vfree_atomic(const void *addr);
 
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 6b783baf12a1..caf032f0bd69 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -4037,6 +4037,65 @@ void *vzalloc_node_noprof(unsigned long size, int node)
 }
 EXPORT_SYMBOL(vzalloc_node_noprof);
 
+/**
+ * vrealloc - reallocate virtually contiguous memory; contents remain unchanged
+ * @p: object to reallocate memory for
+ * @size: the size to reallocate
+ * @flags: the flags for the page level allocator
+ *
+ * The contents of the object pointed to are preserved up to the lesser of the
+ * new and old size (__GFP_ZERO flag is effectively ignored).
+ *
+ * If @p is %NULL, vrealloc() behaves exactly like vmalloc(). If @size is 0 and
+ * @p is not a %NULL pointer, the object pointed to is freed.
+ *
+ * Return: pointer to the allocated memory; %NULL if @size is zero or in case of
+ *         failure
+ */
+void *vrealloc_noprof(const void *p, size_t size, gfp_t flags)
+{
+	size_t old_size = 0;
+	void *n;
+
+	if (!size) {
+		vfree(p);
+		return NULL;
+	}
+
+	if (p) {
+		struct vm_struct *vm;
+
+		vm = find_vm_area(p);
+		if (unlikely(!vm)) {
+			WARN(1, "Trying to vrealloc() nonexistent vm area (%p)\n", p);
+			return NULL;
+		}
+
+		old_size = get_vm_area_size(vm);
+	}
+
+	if (size <= old_size) {
+		/*
+		 * TODO: Shrink the vm_area, i.e. unmap and free unused pages.
+		 * What would be a good heuristic for when to shrink the
+		 * vm_area?
+		 */
+		return (void *)p;
+	}
+
+	/* TODO: Grow the vm_area, i.e. allocate and map additional pages. */
+	n = __vmalloc_noprof(size, flags);
+	if (!n)
+		return NULL;
+
+	if (p) {
+		memcpy(n, p, old_size);
+		vfree(p);
+	}
+
+	return n;
+}
+
 #if defined(CONFIG_64BIT) && defined(CONFIG_ZONE_DMA32)
 #define GFP_VMALLOC32 (GFP_DMA32 | GFP_KERNEL)
 #elif defined(CONFIG_64BIT) && defined(CONFIG_ZONE_DMA)
-- 
2.45.2


