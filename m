Return-Path: <linux-kernel+bounces-292367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECAD956E88
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2E4F1C22A32
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 15:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD381BC59;
	Mon, 19 Aug 2024 15:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WNpR98IM"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A40112CDBF
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 15:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724080529; cv=none; b=uzHTcFmYdNUL5G5Jb31pI+1e1S7rcZJXOi3K/Mv/gfCI55f7yCZB1Vg6cCJJp+iBBjVM7JvsGts5w+9sb94pplg5q9RGur+Qk3fnlPsdg48s7G7vfJ6T0nk6h4tW6Gh3CUbrexohEU6AWSXaykSTnah6fTXW3zXDt3CaANOgN+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724080529; c=relaxed/simple;
	bh=MUvOJSwOhvcj0oP5fQ05zdy1te7n3482CKE5x+nxiMc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NmuxNgRe95hU0UFikp5/hrB/3Z4Bz9tIRw3Ts64xFViabR4Cv5bsISIZK9eiWCbBatBXjm7q78u/3H2qpcDZ9mCy+9MyeyRXnUxMeeN7BHIxQEvN6CjJs9aMXdDK9f7SnHqwNppUXLztKg+3HFgdPTSYXQDFb8StxnttAQ5dg2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WNpR98IM; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e163641feb9so1530468276.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 08:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724080525; x=1724685325; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YvUli7DxjvCadNZqU9R55CXUnn1ASOBr3/ifBorIX/s=;
        b=WNpR98IMZ2wyZLy3JZmOGImKa+0cCKml6iVPL/xZ9iJ3PsuBFYqsXhdUJV0vQwss2+
         7mX48n0NewnwQYNnSzxRYW0terSZZEi6OHvgZGfk7GH59c8k7lGTSfIytsNFHPlMmJzH
         pK61vyGgvuFrjUWOOQDgmsHzJN73+5B/o+hHvfBYrdZU0+qidSMcP4DnLL01eSVVbNIM
         7i55c26fwsHvgoWbrSBj+Mn22d3VJCioYBvYPhHCA2KXwWbsn0vrBYUdVdbB7NwyTnnY
         okPt0PsyqgRXyj9Z6MmJXgPYsI2rFWFdE2+04pcy/V/qSqMwz6tocrcsj0v6NRb6QDv/
         daSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724080525; x=1724685325;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YvUli7DxjvCadNZqU9R55CXUnn1ASOBr3/ifBorIX/s=;
        b=eNp8tB5ygBwAmPb2pdIB8MwwrYcvTYKE4TM5nzVVMF+B/O9NJEvbfTCD09+D99Md3s
         VXcondFvLy4XHBF6eXtOUX/3OuYfTbuzr35qIEQgHJO3U6HQp8mmkF2mLN7UPdP6YwRJ
         XW8dLABPivm9u4IEEgQxF+Ez8hBnYccrLfjytCbi3XZG4ft7Tok58Hxj+rvQT2DuBwtH
         ZD1R7wV2ZRM3awfn8VtpSWgEcZcklvDh8Nn/FkRrLKxa7TshwsUf6JQ/STFcSn24ag8U
         BWEUn0ny9vgmJjKV1Gt99VjrrpovNJaECotxJwuz6Ni7PF0THtjmQZug7GVBDBU0mWF6
         WyaQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+reVcvoQM8E3QRENAmxtKgZZOxy6UHMGCxLcN4g+sHPhi67/pMVcBkGy+Q57amSm/1XXCt7anybj3Fx4JRAQsmeGbH546VD8QMe9h
X-Gm-Message-State: AOJu0YyhHTwRULt7JoQNPYgVv76HdewdW9GHwazV7s3x11YGTkR7DD5C
	H7a0pMQBim53fPEMkzTAWEW/ZbqB9kP56kzgCn/hoeeGnAUluwKvH+GzQ1D0lfso4b9mtV6eC7V
	N6w==
X-Google-Smtp-Source: AGHT+IGmKKGKkjcmWysWP9m62+j5ch91LeGhxiVj6StWd2Ak+bhrYPJ7oEQRjLH7HKKJlPCdxmQ+SytC38U=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:5aea:cf26:50f4:76db])
 (user=surenb job=sendgmr) by 2002:a25:951:0:b0:e0b:af9b:fb94 with SMTP id
 3f1490d57ef6-e1182f824e6mr313544276.6.1724080525039; Mon, 19 Aug 2024
 08:15:25 -0700 (PDT)
Date: Mon, 19 Aug 2024 08:15:11 -0700
In-Reply-To: <20240819151512.2363698-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240819151512.2363698-1-surenb@google.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240819151512.2363698-6-surenb@google.com>
Subject: [PATCH 5/5] alloc_tag: config to store page allocation tag refs in
 page flags
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, corbet@lwn.net, arnd@arndb.de, 
	mcgrof@kernel.org, rppt@kernel.org, paulmck@kernel.org, thuth@redhat.com, 
	tglx@linutronix.de, bp@alien8.de, xiongwei.song@windriver.com, 
	ardb@kernel.org, david@redhat.com, vbabka@suse.cz, mhocko@suse.com, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, dave@stgolabs.net, 
	willy@infradead.org, liam.howlett@oracle.com, pasha.tatashin@soleen.com, 
	souravpanda@google.com, keescook@chromium.org, dennis@kernel.org, 
	jhubbard@nvidia.com, yuzhao@google.com, vvvvvv@google.com, 
	rostedt@goodmis.org, iamjoonsoo.kim@lge.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

Add CONFIG_PGALLOC_TAG_USE_PAGEFLAGS to store allocation tag
references directly in the page flags. This removes dependency on
page_ext and results in better performance for page allocations as
well as reduced page_ext memory overhead.
CONFIG_PGALLOC_TAG_REF_BITS controls the number of bits required
to be available in the page flags to store the references. If the
number of page flag bits is insufficient, the build will fail and
either CONFIG_PGALLOC_TAG_REF_BITS would have to be lowered or
CONFIG_PGALLOC_TAG_USE_PAGEFLAGS should be disabled.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mmzone.h            |  3 ++
 include/linux/page-flags-layout.h | 10 +++++--
 include/linux/pgalloc_tag.h       | 48 +++++++++++++++++++++++++++++++
 lib/Kconfig.debug                 | 27 +++++++++++++++--
 lib/alloc_tag.c                   |  4 +++
 mm/page_ext.c                     |  2 +-
 6 files changed, 89 insertions(+), 5 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 17506e4a2835..0dd2b42f7cb6 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1085,6 +1085,7 @@ static inline bool zone_is_empty(struct zone *zone)
 #define KASAN_TAG_PGOFF		(LAST_CPUPID_PGOFF - KASAN_TAG_WIDTH)
 #define LRU_GEN_PGOFF		(KASAN_TAG_PGOFF - LRU_GEN_WIDTH)
 #define LRU_REFS_PGOFF		(LRU_GEN_PGOFF - LRU_REFS_WIDTH)
+#define ALLOC_TAG_REF_PGOFF	(LRU_REFS_PGOFF - ALLOC_TAG_REF_WIDTH)
 
 /*
  * Define the bit shifts to access each section.  For non-existent
@@ -1096,6 +1097,7 @@ static inline bool zone_is_empty(struct zone *zone)
 #define ZONES_PGSHIFT		(ZONES_PGOFF * (ZONES_WIDTH != 0))
 #define LAST_CPUPID_PGSHIFT	(LAST_CPUPID_PGOFF * (LAST_CPUPID_WIDTH != 0))
 #define KASAN_TAG_PGSHIFT	(KASAN_TAG_PGOFF * (KASAN_TAG_WIDTH != 0))
+#define ALLOC_TAG_REF_PGSHIFT	(ALLOC_TAG_REF_PGOFF * (ALLOC_TAG_REF_WIDTH != 0))
 
 /* NODE:ZONE or SECTION:ZONE is used to ID a zone for the buddy allocator */
 #ifdef NODE_NOT_IN_PAGE_FLAGS
@@ -1116,6 +1118,7 @@ static inline bool zone_is_empty(struct zone *zone)
 #define LAST_CPUPID_MASK	((1UL << LAST_CPUPID_SHIFT) - 1)
 #define KASAN_TAG_MASK		((1UL << KASAN_TAG_WIDTH) - 1)
 #define ZONEID_MASK		((1UL << ZONEID_SHIFT) - 1)
+#define ALLOC_TAG_REF_MASK	((1UL << ALLOC_TAG_REF_WIDTH) - 1)
 
 static inline enum zone_type page_zonenum(const struct page *page)
 {
diff --git a/include/linux/page-flags-layout.h b/include/linux/page-flags-layout.h
index 7d79818dc065..21bba7c8c965 100644
--- a/include/linux/page-flags-layout.h
+++ b/include/linux/page-flags-layout.h
@@ -5,6 +5,12 @@
 #include <linux/numa.h>
 #include <generated/bounds.h>
 
+#ifdef CONFIG_PGALLOC_TAG_USE_PAGEFLAGS
+#define ALLOC_TAG_REF_WIDTH	CONFIG_PGALLOC_TAG_REF_BITS
+#else
+#define ALLOC_TAG_REF_WIDTH	0
+#endif
+
 /*
  * When a memory allocation must conform to specific limitations (such
  * as being suitable for DMA) the caller will pass in hints to the
@@ -91,7 +97,7 @@
 #endif
 
 #if ZONES_WIDTH + LRU_GEN_WIDTH + SECTIONS_WIDTH + NODES_WIDTH + \
-	KASAN_TAG_WIDTH + LAST_CPUPID_SHIFT <= BITS_PER_LONG - NR_PAGEFLAGS
+	KASAN_TAG_WIDTH + ALLOC_TAG_REF_WIDTH + LAST_CPUPID_SHIFT <= BITS_PER_LONG - NR_PAGEFLAGS
 #define LAST_CPUPID_WIDTH LAST_CPUPID_SHIFT
 #else
 #define LAST_CPUPID_WIDTH 0
@@ -102,7 +108,7 @@
 #endif
 
 #if ZONES_WIDTH + LRU_GEN_WIDTH + SECTIONS_WIDTH + NODES_WIDTH + \
-	KASAN_TAG_WIDTH + LAST_CPUPID_WIDTH > BITS_PER_LONG - NR_PAGEFLAGS
+	KASAN_TAG_WIDTH + ALLOC_TAG_REF_WIDTH + LAST_CPUPID_WIDTH > BITS_PER_LONG - NR_PAGEFLAGS
 #error "Not enough bits in page flags"
 #endif
 
diff --git a/include/linux/pgalloc_tag.h b/include/linux/pgalloc_tag.h
index 80b8801cb90b..da95c09bcdf1 100644
--- a/include/linux/pgalloc_tag.h
+++ b/include/linux/pgalloc_tag.h
@@ -88,6 +88,52 @@ static inline void write_pgref(pgalloc_tag_ref *pgref, union codetag_ref *ref)
 void __init alloc_tag_sec_init(void);
 
 #endif /* PGALLOC_TAG_DIRECT_REF */
+
+#ifdef CONFIG_PGALLOC_TAG_USE_PAGEFLAGS
+
+typedef struct page	*pgtag_ref_handle;
+
+/* Should be called only if mem_alloc_profiling_enabled() */
+static inline pgtag_ref_handle get_page_tag_ref(struct page *page,
+						union codetag_ref *ref)
+{
+	if (page) {
+		pgalloc_tag_ref pgref;
+
+		pgref = (page->flags >> ALLOC_TAG_REF_PGSHIFT) & ALLOC_TAG_REF_MASK;
+		read_pgref(&pgref, ref);
+		return page;
+	}
+
+	return NULL;
+}
+
+static inline void put_page_tag_ref(pgtag_ref_handle page)
+{
+	WARN_ON(!page);
+}
+
+static inline void update_page_tag_ref(pgtag_ref_handle page, union codetag_ref *ref)
+{
+	unsigned long old_flags, flags, val;
+	pgalloc_tag_ref pgref;
+
+	if (WARN_ON(!page || !ref))
+		return;
+
+	write_pgref(&pgref, ref);
+	val = (unsigned long)pgref;
+	val = (val & ALLOC_TAG_REF_MASK) << ALLOC_TAG_REF_PGSHIFT;
+	do {
+		old_flags = READ_ONCE(page->flags);
+		flags = old_flags;
+		flags &= ~(ALLOC_TAG_REF_MASK << ALLOC_TAG_REF_PGSHIFT);
+		flags |= val;
+	} while (unlikely(!try_cmpxchg(&page->flags, &old_flags, flags)));
+}
+
+#else /* CONFIG_PGALLOC_TAG_USE_PAGEFLAGS */
+
 #include <linux/page_ext.h>
 
 extern struct page_ext_operations page_alloc_tagging_ops;
@@ -136,6 +182,8 @@ static inline void update_page_tag_ref(pgtag_ref_handle pgref, union codetag_ref
 	write_pgref(pgref, ref);
 }
 
+#endif /* CONFIG_PGALLOC_TAG_USE_PAGEFLAGS */
+
 static inline void clear_page_tag_ref(struct page *page)
 {
 	if (mem_alloc_profiling_enabled()) {
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 253f9c2028da..9fc8c1981f27 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -979,7 +979,7 @@ config MEM_ALLOC_PROFILING
 	depends on PROC_FS
 	depends on !DEBUG_FORCE_WEAK_PER_CPU
 	select CODE_TAGGING
-	select PAGE_EXTENSION
+	select PAGE_EXTENSION if !PGALLOC_TAG_USE_PAGEFLAGS
 	select SLAB_OBJ_EXT
 	help
 	  Track allocation source code and record total allocation size
@@ -1000,10 +1000,26 @@ config MEM_ALLOC_PROFILING_DEBUG
 	  Adds warnings with helpful error messages for memory allocation
 	  profiling.
 
+config PGALLOC_TAG_USE_PAGEFLAGS
+	bool "Use pageflags to encode page allocation tag reference"
+	default n
+	depends on MEM_ALLOC_PROFILING
+	help
+	  When set, page allocation tag references are encoded inside page
+	  flags, otherwise they are encoded in page extensions.
+
+	  Setting this flag reduces memory and performance overhead of memory
+	  allocation profiling but also limits how many allocations can be
+	  tagged. The number of bits is set by PGALLOC_TAG_USE_PAGEFLAGS and
+	  they must fit in the page flags field.
+
+	  Say N if unsure.
+
 config PGALLOC_TAG_REF_BITS
 	int "Number of bits for page allocation tag reference (10-64)"
 	range 10 64
-	default "64"
+	default "16" if PGALLOC_TAG_USE_PAGEFLAGS
+	default "64" if !PGALLOC_TAG_USE_PAGEFLAGS
 	depends on MEM_ALLOC_PROFILING
 	help
 	  Number of bits used to encode a page allocation tag reference.
@@ -1011,6 +1027,13 @@ config PGALLOC_TAG_REF_BITS
 	  Smaller number results in less memory overhead but limits the number of
 	  allocations which can be tagged (including allocations from modules).
 
+	  If PGALLOC_TAG_USE_PAGEFLAGS is set, the number of requested bits should
+	  fit inside the page flags.
+
+	  If PGALLOC_TAG_USE_PAGEFLAGS is not set, the number of bits used to store
+	  a reference is rounded up to the closest basic type. If set higher than 32,
+	  a direct pointer to the allocation tag is stored for performance reasons.
+
 source "lib/Kconfig.kasan"
 source "lib/Kconfig.kfence"
 source "lib/Kconfig.kmsan"
diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index d0da206d539e..1fbe80e68fdb 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -432,6 +432,8 @@ static int __init setup_early_mem_profiling(char *str)
 }
 early_param("sysctl.vm.mem_profiling", setup_early_mem_profiling);
 
+#ifndef CONFIG_PGALLOC_TAG_USE_PAGEFLAGS
+
 static __init bool need_page_alloc_tagging(void)
 {
 	return mem_profiling_support;
@@ -448,6 +450,8 @@ struct page_ext_operations page_alloc_tagging_ops = {
 };
 EXPORT_SYMBOL(page_alloc_tagging_ops);
 
+#endif /* CONFIG_PGALLOC_TAG_USE_PAGEFLAGS */
+
 #ifdef CONFIG_SYSCTL
 static struct ctl_table memory_allocation_profiling_sysctls[] = {
 	{
diff --git a/mm/page_ext.c b/mm/page_ext.c
index 641d93f6af4c..5f993c271ee7 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -83,7 +83,7 @@ static struct page_ext_operations *page_ext_ops[] __initdata = {
 #if defined(CONFIG_PAGE_IDLE_FLAG) && !defined(CONFIG_64BIT)
 	&page_idle_ops,
 #endif
-#ifdef CONFIG_MEM_ALLOC_PROFILING
+#if defined(CONFIG_MEM_ALLOC_PROFILING) && !defined(CONFIG_PGALLOC_TAG_USE_PAGEFLAGS)
 	&page_alloc_tagging_ops,
 #endif
 #ifdef CONFIG_PAGE_TABLE_CHECK
-- 
2.46.0.184.g6999bdac58-goog


