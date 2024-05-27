Return-Path: <linux-kernel+bounces-190280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F258C8CFC5E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9F9128202A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200C06A357;
	Mon, 27 May 2024 09:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="almTB9U4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RIxbb8sO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SaHcXx+5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9cN3jAZn"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85F8381B1
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 09:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716800506; cv=none; b=qsh6LilFwv10FwKY9Pgd0Qg0WojtmkmrGX9VDgOs55R8pcfiqURlTXXABrZo2eGJQgePG6J74GfsKf3lNwxrM/H8Sjil52LtDkW3L9VRYJmQBsLoatzwicGOs8nwwzFa1cZWpaNctQTXeqlThQhWOwE2E/fLJ5grPmRzVgZ0rUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716800506; c=relaxed/simple;
	bh=6saI82LM+IF5SUZ7EMgU2Oqbo4imTnYAF4BXGdoz+ic=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Swee+VCGyl7tpJnXrUANsrG0WUPtGjUF3T7JQDEyR8f7fGIFHCPXcFS5y8q6+K0cdPuvhyCK6ru14IjNo5I0EEtRH188kX46brJ9xn6AedDGXcwYInuvXCp5NKGGhL7GlgFG1HqRhxJLsc3jwXpHSaHgMltBgbtAgaE9NaQ3w90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=almTB9U4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RIxbb8sO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SaHcXx+5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9cN3jAZn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D8F9F21D7C;
	Mon, 27 May 2024 09:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716800502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gXtaN4gTFvxej3uREjWvzZenfDkLBdRMKDAdRVewHIs=;
	b=almTB9U4uBWJ1tt+BaLBiSreB/nFMOtLu/qhYDM05eVHK2W/Ts6jEYyV1/RMSsMGqWl7JU
	AWRXM6dWI7gIqP7PaCcR7LDXSwZb2rWo0/NjIKOGvBfNdfTfPesaTuOjl4lznBO0NkFfHC
	+T/jaFI2DiEucY3pFFwdmKTlN9xrL0E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716800502;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gXtaN4gTFvxej3uREjWvzZenfDkLBdRMKDAdRVewHIs=;
	b=RIxbb8sOBg2rnx+cdmHN6DhHvn5DTgBTPTTtbgwQ4wKc9HT2Qln4PVrTM6cEZuv52RsvAL
	gNlJsDiA3XhODEAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716800501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gXtaN4gTFvxej3uREjWvzZenfDkLBdRMKDAdRVewHIs=;
	b=SaHcXx+5lpSHfgKeZNqeNmyGeyV+wyE1DuuE7UUaZl7d6CW7DX7dYd3VDK6RwQ1BEQLyZm
	06wr+mYnKdVlFCm+gT9hZDkAdcL45wQLDjBo/BTNYnhDbFGTjPWnREmFg0xxrly/QVBOia
	m4PcpNMPYkLAerPo4hZbPphynsmZRz4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716800501;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gXtaN4gTFvxej3uREjWvzZenfDkLBdRMKDAdRVewHIs=;
	b=9cN3jAZnfI72OAd2OCzRobDbuFq25RKldQDX/cZcOuRE4co9A3WSBWjlqLpR4yzikLDMcf
	tj5prgpPn9dZrtBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B3E3313A6B;
	Mon, 27 May 2024 09:01:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fJiYK/VLVGYeawAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 27 May 2024 09:01:41 +0000
From: Vlastimil Babka <vbabka@suse.cz>
To: Christoph Lameter <cl@linux.com>,
	David Rientjes <rientjes@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Vlastimil Babka <vbabka@suse.cz>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	Kees Cook <keescook@chromium.org>
Subject: [PATCH v2] mm, slab: don't wrap internal functions with alloc_hooks()
Date: Mon, 27 May 2024 11:01:28 +0200
Message-ID: <20240527090127.21979-2-vbabka@suse.cz>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -1.30
X-Spam-Level: 
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_CC(0.00)[linux-foundation.org,linux.dev,gmail.com,kvack.org,vger.kernel.org,suse.cz,google.com,chromium.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,chromium.org:email];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]

The functions __kmalloc_noprof(), kmalloc_large_noprof(),
kmalloc_trace_noprof() and their _node variants are all internal to the
implementations of kmalloc_noprof() and kmalloc_node_noprof() and are
only declared in the "public" slab.h and exported so that those
implementations can be static inline and distinguish the build-time
constant size variants. The only other users for some of the internal
functions are slub_kunit and fortify_kunit tests which make very
short-lived allocations.

Therefore we can stop wrapping them with the alloc_hooks() macro.
Instead add a __ prefix to all of them and a comment documenting these
as internal. Also rename __kmalloc_trace() to __kmalloc_cache() which is
more descriptive - it is a variant of __kmalloc() where the exact
kmalloc cache has been already determined.

The usage in fortify_kunit can be removed completely, as the internal
functions should be tested already through kmalloc() tests in the
test variant that passes non-constant allocation size.

Reported-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
v2: keep _noprof per Kent, remove usage from fortify_kunit per Kees

 include/linux/slab.h | 48 ++++++++++++++++++++++----------------------
 lib/fortify_kunit.c  |  5 -----
 lib/slub_kunit.c     |  2 +-
 mm/slub.c            | 26 ++++++++++++------------
 4 files changed, 38 insertions(+), 43 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 7247e217e21b..ed6bee5ec2b6 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -528,9 +528,6 @@ static_assert(PAGE_SHIFT <= 20);
 
 #include <linux/alloc_tag.h>
 
-void *__kmalloc_noprof(size_t size, gfp_t flags) __assume_kmalloc_alignment __alloc_size(1);
-#define __kmalloc(...)				alloc_hooks(__kmalloc_noprof(__VA_ARGS__))
-
 /**
  * kmem_cache_alloc - Allocate an object
  * @cachep: The cache to allocate from.
@@ -568,31 +565,34 @@ static __always_inline void kfree_bulk(size_t size, void **p)
 	kmem_cache_free_bulk(NULL, size, p);
 }
 
-void *__kmalloc_node_noprof(size_t size, gfp_t flags, int node) __assume_kmalloc_alignment
-							 __alloc_size(1);
-#define __kmalloc_node(...)			alloc_hooks(__kmalloc_node_noprof(__VA_ARGS__))
-
 void *kmem_cache_alloc_node_noprof(struct kmem_cache *s, gfp_t flags,
 				   int node) __assume_slab_alignment __malloc;
 #define kmem_cache_alloc_node(...)	alloc_hooks(kmem_cache_alloc_node_noprof(__VA_ARGS__))
 
-void *kmalloc_trace_noprof(struct kmem_cache *s, gfp_t flags, size_t size)
-		    __assume_kmalloc_alignment __alloc_size(3);
+/*
+ * The following functions are not to be used directly and are intended only
+ * for internal use from kmalloc() and kmalloc_node()
+ * with the exception of kunit tests
+ */
+
+void *__kmalloc_noprof(size_t size, gfp_t flags)
+				__assume_kmalloc_alignment __alloc_size(1);
+
+void *__kmalloc_node_noprof(size_t size, gfp_t flags, int node)
+				__assume_kmalloc_alignment __alloc_size(1);
 
-void *kmalloc_node_trace_noprof(struct kmem_cache *s, gfp_t gfpflags,
-		int node, size_t size) __assume_kmalloc_alignment
-						__alloc_size(4);
-#define kmalloc_trace(...)			alloc_hooks(kmalloc_trace_noprof(__VA_ARGS__))
+void *__kmalloc_cache_noprof(struct kmem_cache *s, gfp_t flags, size_t size)
+				__assume_kmalloc_alignment __alloc_size(3);
 
-#define kmalloc_node_trace(...)			alloc_hooks(kmalloc_node_trace_noprof(__VA_ARGS__))
+void *__kmalloc_cache_node_noprof(struct kmem_cache *s, gfp_t gfpflags,
+				  int node, size_t size)
+				__assume_kmalloc_alignment __alloc_size(4);
 
-void *kmalloc_large_noprof(size_t size, gfp_t flags) __assume_page_alignment
-					      __alloc_size(1);
-#define kmalloc_large(...)			alloc_hooks(kmalloc_large_noprof(__VA_ARGS__))
+void *__kmalloc_large_noprof(size_t size, gfp_t flags)
+				__assume_page_alignment __alloc_size(1);
 
-void *kmalloc_large_node_noprof(size_t size, gfp_t flags, int node) __assume_page_alignment
-							     __alloc_size(1);
-#define kmalloc_large_node(...)			alloc_hooks(kmalloc_large_node_noprof(__VA_ARGS__))
+void *__kmalloc_large_node_noprof(size_t size, gfp_t flags, int node)
+				__assume_page_alignment __alloc_size(1);
 
 /**
  * kmalloc - allocate kernel memory
@@ -654,10 +654,10 @@ static __always_inline __alloc_size(1) void *kmalloc_noprof(size_t size, gfp_t f
 		unsigned int index;
 
 		if (size > KMALLOC_MAX_CACHE_SIZE)
-			return kmalloc_large_noprof(size, flags);
+			return __kmalloc_large_noprof(size, flags);
 
 		index = kmalloc_index(size);
-		return kmalloc_trace_noprof(
+		return __kmalloc_cache_noprof(
 				kmalloc_caches[kmalloc_type(flags, _RET_IP_)][index],
 				flags, size);
 	}
@@ -671,10 +671,10 @@ static __always_inline __alloc_size(1) void *kmalloc_node_noprof(size_t size, gf
 		unsigned int index;
 
 		if (size > KMALLOC_MAX_CACHE_SIZE)
-			return kmalloc_large_node_noprof(size, flags, node);
+			return __kmalloc_large_node_noprof(size, flags, node);
 
 		index = kmalloc_index(size);
-		return kmalloc_node_trace_noprof(
+		return __kmalloc_cache_node_noprof(
 				kmalloc_caches[kmalloc_type(flags, _RET_IP_)][index],
 				flags, node, size);
 	}
diff --git a/lib/fortify_kunit.c b/lib/fortify_kunit.c
index 39da5b3bc649..044f409ef856 100644
--- a/lib/fortify_kunit.c
+++ b/lib/fortify_kunit.c
@@ -233,11 +233,6 @@ static void fortify_test_alloc_size_##allocator##_dynamic(struct kunit *test) \
 		kfree(p));						\
 	checker(expected_size,						\
 		kmalloc_array_node(alloc_size, 1, gfp, NUMA_NO_NODE),	\
-		kfree(p));						\
-	checker(expected_size, __kmalloc(alloc_size, gfp),		\
-		kfree(p));						\
-	checker(expected_size,						\
-		__kmalloc_node(alloc_size, gfp, NUMA_NO_NODE),		\
 		kfree(p));						\
 									\
 	orig = kmalloc(alloc_size, gfp);				\
diff --git a/lib/slub_kunit.c b/lib/slub_kunit.c
index 4ce960438806..e6667a28c014 100644
--- a/lib/slub_kunit.c
+++ b/lib/slub_kunit.c
@@ -140,7 +140,7 @@ static void test_kmalloc_redzone_access(struct kunit *test)
 {
 	struct kmem_cache *s = test_kmem_cache_create("TestSlub_RZ_kmalloc", 32,
 				SLAB_KMALLOC|SLAB_STORE_USER|SLAB_RED_ZONE);
-	u8 *p = kmalloc_trace(s, GFP_KERNEL, 18);
+	u8 *p = __kmalloc_cache_noprof(s, GFP_KERNEL, 18);
 
 	kasan_disable_current();
 
diff --git a/mm/slub.c b/mm/slub.c
index 0809760cf789..95e0a3332c44 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4053,7 +4053,7 @@ EXPORT_SYMBOL(kmem_cache_alloc_node_noprof);
  * directly to the page allocator. We use __GFP_COMP, because we will need to
  * know the allocation order to free the pages properly in kfree.
  */
-static void *__kmalloc_large_node(size_t size, gfp_t flags, int node)
+static void *___kmalloc_large_node(size_t size, gfp_t flags, int node)
 {
 	struct folio *folio;
 	void *ptr = NULL;
@@ -4078,25 +4078,25 @@ static void *__kmalloc_large_node(size_t size, gfp_t flags, int node)
 	return ptr;
 }
 
-void *kmalloc_large_noprof(size_t size, gfp_t flags)
+void *__kmalloc_large_noprof(size_t size, gfp_t flags)
 {
-	void *ret = __kmalloc_large_node(size, flags, NUMA_NO_NODE);
+	void *ret = ___kmalloc_large_node(size, flags, NUMA_NO_NODE);
 
 	trace_kmalloc(_RET_IP_, ret, size, PAGE_SIZE << get_order(size),
 		      flags, NUMA_NO_NODE);
 	return ret;
 }
-EXPORT_SYMBOL(kmalloc_large_noprof);
+EXPORT_SYMBOL(__kmalloc_large_noprof);
 
-void *kmalloc_large_node_noprof(size_t size, gfp_t flags, int node)
+void *__kmalloc_large_node_noprof(size_t size, gfp_t flags, int node)
 {
-	void *ret = __kmalloc_large_node(size, flags, node);
+	void *ret = ___kmalloc_large_node(size, flags, node);
 
 	trace_kmalloc(_RET_IP_, ret, size, PAGE_SIZE << get_order(size),
 		      flags, node);
 	return ret;
 }
-EXPORT_SYMBOL(kmalloc_large_node_noprof);
+EXPORT_SYMBOL(__kmalloc_large_node_noprof);
 
 static __always_inline
 void *__do_kmalloc_node(size_t size, gfp_t flags, int node,
@@ -4106,7 +4106,7 @@ void *__do_kmalloc_node(size_t size, gfp_t flags, int node,
 	void *ret;
 
 	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE)) {
-		ret = __kmalloc_large_node(size, flags, node);
+		ret = __kmalloc_large_node_noprof(size, flags, node);
 		trace_kmalloc(caller, ret, size,
 			      PAGE_SIZE << get_order(size), flags, node);
 		return ret;
@@ -4142,7 +4142,7 @@ void *kmalloc_node_track_caller_noprof(size_t size, gfp_t flags,
 }
 EXPORT_SYMBOL(kmalloc_node_track_caller_noprof);
 
-void *kmalloc_trace_noprof(struct kmem_cache *s, gfp_t gfpflags, size_t size)
+void *__kmalloc_cache_noprof(struct kmem_cache *s, gfp_t gfpflags, size_t size)
 {
 	void *ret = slab_alloc_node(s, NULL, gfpflags, NUMA_NO_NODE,
 					    _RET_IP_, size);
@@ -4152,10 +4152,10 @@ void *kmalloc_trace_noprof(struct kmem_cache *s, gfp_t gfpflags, size_t size)
 	ret = kasan_kmalloc(s, ret, size, gfpflags);
 	return ret;
 }
-EXPORT_SYMBOL(kmalloc_trace_noprof);
+EXPORT_SYMBOL(__kmalloc_cache_noprof);
 
-void *kmalloc_node_trace_noprof(struct kmem_cache *s, gfp_t gfpflags,
-			 int node, size_t size)
+void *__kmalloc_cache_node_noprof(struct kmem_cache *s, gfp_t gfpflags,
+				  int node, size_t size)
 {
 	void *ret = slab_alloc_node(s, NULL, gfpflags, node, _RET_IP_, size);
 
@@ -4164,7 +4164,7 @@ void *kmalloc_node_trace_noprof(struct kmem_cache *s, gfp_t gfpflags,
 	ret = kasan_kmalloc(s, ret, size, gfpflags);
 	return ret;
 }
-EXPORT_SYMBOL(kmalloc_node_trace_noprof);
+EXPORT_SYMBOL(__kmalloc_cache_node_noprof);
 
 static noinline void free_to_partial_list(
 	struct kmem_cache *s, struct slab *slab,
-- 
2.45.1


