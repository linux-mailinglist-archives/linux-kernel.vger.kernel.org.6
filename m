Return-Path: <linux-kernel+bounces-255763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 222339344D0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 00:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2EED283628
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3694455886;
	Wed, 17 Jul 2024 22:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMdu6Px9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F9A4D8BA;
	Wed, 17 Jul 2024 22:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721255126; cv=none; b=c4aYJ+kYajbCIaI+7zH2K/2/paqa8N4zJAVhZ9a+LMRI8/7JKGAXNJ7zcfgrN+pQM5e8hkx9bmNHK8L7GzF0aCedTBzK2QfPIcmu812kS7p8qmnlgY5DpZTi9Q3fFdXxu2c38Mas5Dz+HpANv/hZsRnJ4GDozvacFMnylTEnkJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721255126; c=relaxed/simple;
	bh=tXaAq6dQU0DYi9kqEOhCwnRJo8WINgtfsOO12DLQp/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f+si5m+IIj7v2bDJ++F8hp3UvDaL+uqJYgYvDcWoYqas5jHXjjPyO5vaIkxpdCascWYhhKEmuxcq4z+3FLKak1lGP2Q/orGz7RsXGOVTuP6f1jcIBlPfFxQq7zO0Eklizm6JqaJkziAnFu7PrO8ZiA0dlHabIw00mqoykjruaGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMdu6Px9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF41C2BD10;
	Wed, 17 Jul 2024 22:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721255126;
	bh=tXaAq6dQU0DYi9kqEOhCwnRJo8WINgtfsOO12DLQp/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mMdu6Px9696h6a8IIIg+uuDYZ+vEQr1pGnPPwtF0lQLYRAYhTXlLJOoW0DYmJJvvN
	 moaMm+DS2g/0CQ2kGqQ2NXanXuFNoEzPrdI76Xm71x/mBW14OxbdVJFcps8FNwPSCU
	 zLovJ+77wkGbLSB7G+Myp51+g3b5DsDmngzwo2kIy8hI3xZlGlx7G3sac3A0yGz64x
	 r+DvvOm6Jk/Q0azeEiCwfBil5E84SuVBqFI9/cVeDjvYBMCkqajYnzUH5GpqoHHNVX
	 tIo7fYDQzBPnaE/KYK6mSQAvA8yqYx0pGFcsHg8U/xSFIvrrGTPBZpA6Qp4OsmB0qR
	 RECBeGKGKEi5Q==
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
	christian.koenig@amd.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 1/2] mm: vmalloc: implement vrealloc()
Date: Thu, 18 Jul 2024 00:24:01 +0200
Message-ID: <20240717222427.2211-2-dakr@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240717222427.2211-1-dakr@kernel.org>
References: <20240717222427.2211-1-dakr@kernel.org>
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
 mm/vmalloc.c            | 58 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index e4a631ec430b..9ff0a8e5c323 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -189,6 +189,10 @@ extern void *__vcalloc_noprof(size_t n, size_t size, gfp_t flags) __alloc_size(1
 extern void *vcalloc_noprof(size_t n, size_t size) __alloc_size(1, 2);
 #define vcalloc(...)		alloc_hooks(vcalloc_noprof(__VA_ARGS__))
 
+extern void * __must_check vrealloc_noprof(const void *p, size_t size,
+					   gfp_t flags) __realloc_size(2);
+#define vrealloc(...)		alloc_hooks(vrealloc_noprof(__VA_ARGS__))
+
 extern void vfree(const void *addr);
 extern void vfree_atomic(const void *addr);
 
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index e34ea860153f..4ec949ac9d9d 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -4036,6 +4036,64 @@ void *vzalloc_node_noprof(unsigned long size, int node)
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
+		/* TODO: Can we optimize and shrink the allocation? What would
+		 * be a good metric for when to shrink the vm_area?
+		 */
+		return (void *)p;
+	}
+
+	/* TODO: Can we optimize and extend the existing allocation if we have
+	 * enough contiguous space left in the virtual address space?
+	 */
+	n = __vmalloc_noprof(size, flags);
+
+	if (p) {
+		memcpy(n, p, old_size);
+		vfree(p);
+	}
+
+	return n;
+}
+EXPORT_SYMBOL(vrealloc_noprof);
+
 #if defined(CONFIG_64BIT) && defined(CONFIG_ZONE_DMA32)
 #define GFP_VMALLOC32 (GFP_DMA32 | GFP_KERNEL)
 #elif defined(CONFIG_64BIT) && defined(CONFIG_ZONE_DMA)
-- 
2.45.2


