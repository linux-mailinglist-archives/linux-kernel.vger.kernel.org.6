Return-Path: <linux-kernel+bounces-310577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1101967E9E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 06:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B1F1281BB4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 04:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84650177992;
	Mon,  2 Sep 2024 04:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iPimVhla"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730B916DC28
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 04:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725252107; cv=none; b=BK3N2HMqJT15yjxbZTJtlYuZBmgBvuGeuPt8/kemXSTo/jP3MBlzyhiXPwXmFDGADZkE6IFisQzStjATmsFuUfI/Uf0HgsMcLH3t1HtwVvB7ksvxTQrQrwwMTl7ZNCJljedWn6ewM+eLxgW48u6gpHH3TLk3QQ7MzSNTiCw71nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725252107; c=relaxed/simple;
	bh=Pf8Ai6mn9Z/XDost5C7B5IyWwUvzclGVwz6K3kHE9Qs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JyDPAEj3AVgeuS9spS/I9tcl/cVKGSO3B4UrgWwRXjUJwEUfCORYjjyUtPJeD3CCsm4P8xatPQK3NtGbmLHI1Ze1u86DMMUlQGSPiqWTxpVrJow4ENmBCdYHgeOGgA7xS1v6Hez4Uw6n1MmfiThh9pGq2LcuTlWxo4AVzJZws90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iPimVhla; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e11368fa2e3so7174997276.3
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2024 21:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725252104; x=1725856904; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=o+zkIQ79nR91+bZ9fiMOs0/SZD3fit87wxI6zeuv5qM=;
        b=iPimVhlaxupwceEDULblaCOlPdM/dg9K4RcO+5VLUga7uad+ARJiguyRaHflWckpUj
         3USvgDbBMjn9AS8vnoUM4dyt0OBtAWNsga5jbaqhG9pklmijhax/pVbitrTGR/6bUaUf
         lUbAYsggFQ5MS+Bi7rdxZ+YJJSW2YJS0aUkVWRiEQGAtB25Ma2mzZ8Z+xpdm4ynQT7xu
         rcV3d5Bf6tOKvaTiue7BliVuiq2289nMxX1YhltQYGkUmBaXLspnF0QRWCf3sVHU7uRi
         8z2Ui/A/d4RdRFgAkOBBtBNkXN6ClNi2cfzebcs4aDIgxeuM/9SPnnoIAnm1wNznayDR
         q8ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725252104; x=1725856904;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o+zkIQ79nR91+bZ9fiMOs0/SZD3fit87wxI6zeuv5qM=;
        b=HaxaCbMrgrNUWA7e8jNU6FvPRGIj7ahkzqEc/LLcB5yb5ZCZuf2D570yeF4pLBiy6w
         IowfroYqBb1/rW9QxsAfluIgj3aIXjo7kUZcEp+Hfk5UtKyEMe7Iq0f565y+lzSZk8my
         WxJdKzfTQf1U4CIcuRGD1CRrGdtG7BVErxbUM0Mv/jnyQyS9s1ueOn73eP0yFjbwxq5Y
         ftMwjEx291O4HUrRwFFTuiEPEoawUVV2wo8LD182c6LytDywrJWxZEoeQLdcVVOnJ341
         dqYVMcVvPhLupALrPbXV1KYR4B+uR6zkfmxSDHjUc1Go14q0PBVHfwCjMT6YtAl/xNju
         +J1A==
X-Forwarded-Encrypted: i=1; AJvYcCXlylTYR6u9lDZBxojel588xiO3kSPnmSwLy2vB+aLPPAFea/ZtDF5+TOGSNttY63PLigrZqGE9tF3+9d4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLDmLuG6jAOA/G+cxVqie33UsSvq9+xUmZBXMRil9xCDp8f6C9
	rVNQ3DRuxYu9XrRxIbQvJgWckQO3FG98raai8Tz5wxA7hLPF+wp377W0Hb2oj/Lpgss5lfyLQRP
	TEw==
X-Google-Smtp-Source: AGHT+IGESmFEaOyUz7H46Wj9ZUskazUKRvv1KzwKzYF26vqNkzVhO5DbeT/NbEzV1QldF78OxMgid1k7qes=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:7343:ecd2:aed:5b8f])
 (user=surenb job=sendgmr) by 2002:a05:6902:1b0a:b0:e0b:a2a7:df77 with SMTP id
 3f1490d57ef6-e1a79faf966mr117475276.2.1725252104383; Sun, 01 Sep 2024
 21:41:44 -0700 (PDT)
Date: Sun,  1 Sep 2024 21:41:28 -0700
In-Reply-To: <20240902044128.664075-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240902044128.664075-1-surenb@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240902044128.664075-7-surenb@google.com>
Subject: [PATCH v2 6/6] alloc_tag: config to store page allocation tag refs in
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
index a7f8f00c118f..dcb6706dee15 100644
--- a/include/linux/pgalloc_tag.h
+++ b/include/linux/pgalloc_tag.h
@@ -118,6 +118,52 @@ static inline void write_pgref(pgalloc_tag_ref *pgref, union codetag_ref *ref)
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
@@ -166,6 +212,8 @@ static inline void update_page_tag_ref(pgtag_ref_handle pgref, union codetag_ref
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
index 73791aa55ab6..34820650186d 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -476,6 +476,8 @@ static int __init setup_early_mem_profiling(char *str)
 }
 early_param("sysctl.vm.mem_profiling", setup_early_mem_profiling);
 
+#ifndef CONFIG_PGALLOC_TAG_USE_PAGEFLAGS
+
 static __init bool need_page_alloc_tagging(void)
 {
 	return mem_profiling_support;
@@ -492,6 +494,8 @@ struct page_ext_operations page_alloc_tagging_ops = {
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
2.46.0.469.g59c65b2a67-goog


