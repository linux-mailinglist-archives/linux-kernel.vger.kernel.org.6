Return-Path: <linux-kernel+bounces-200316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF218FAE62
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A415F282FF9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6E71448E7;
	Tue,  4 Jun 2024 09:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="blYZpVz4"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B561442EF
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 09:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717492157; cv=none; b=oBb1b6FC6Sl1xJPJrVGZY8Nc7zeLO43zIxgfLwP3B5rfWbGBdK2BXCEhubSELbRCPqxMxs4IlSMzkScTJWB670qnCM8ImuCv2LQvHkkj6mEZKsUFjr0W2yCMm85JJgFDz798fZJL9uEzvlaQWmZNHXiO2LByakmX4CtTOjPbDco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717492157; c=relaxed/simple;
	bh=rkUGvj+ij6RicIA5EFzODwQ7Ora3dIw64eYqggjnLq4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qq6xNuCRzSbAXiLikj8A53iIMD7OVJ4HcOBrU0CMxxgzVwu++7TDmu20uI3zITaGTuIGWqMVNADgNUa25NzbraU+bs8zT/o8YsIgFfiY/rkvYdr0EMP2zyMjwHbHZrSu6Dd94k5jvQ7/XqNWT0zHo5T0ncgNRQnHLHSKaIr7xqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=blYZpVz4; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a68f10171bdso264743566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 02:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1717492154; x=1718096954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVxAKKIuGzczdMzzJCnaqt6bk9QQZalHnDhl7auSlGA=;
        b=blYZpVz49Qr7+sw4ovvi/0Dh9nCrkFMyfR9XE4+H+tihCd96m/5cQZ0PId8Y8K7Whb
         krClDfagcHsDARdCAcIKVWgwN5i9q1YgDWVmt/iVxcfD78rQcxv3HGmeyUhqi1W2s65q
         br66KT4Q8ggMpBIV2BSEe2qf0frehvMm8SBdwhCHg3/vBe92PqNJKt3aIQvUa9qombQ/
         tST3NkQSbiMjG/CO1VWTjrUiAf2TNUogeoHHpmJ7D0rHtlyDPYbjcDQNiZHYZxHuIWC7
         J2vzTaK0920z1nBCrZSyANIXfTo2i5wWwkgviyyDzQjp7cgBuvLb3Zi6USasYPCzZ8Um
         Qs/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717492154; x=1718096954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oVxAKKIuGzczdMzzJCnaqt6bk9QQZalHnDhl7auSlGA=;
        b=D2jxoMGYaQuiWZ2m4F2QCKkn2jvG8r83u41qc3kd/4srE0I2k6EznqAfTlz6ztJqgt
         jzymUgMQBeM+0lH3GiXL940c+J4TZHDTj1THiWSBeOd1+Pm2SzL7gx7lsqAFj8bKu0o4
         WGc30kozAwYA0iVgC5lezLlHjw6dkViFI5dT1hsi+iczltX9pA92OJJGiPs/gSXlx1D7
         N9RqqPoxElIlSYV0lNAj3ClggkqcyVYumwJYeMOuc+Pa4aXUQDpQ4aSKlhTv5hZ0OC7u
         CqSVhtp9iszwRsVRoomrV+K5aZnBUZuNLlUBsPa9NlI5F2Sdv7gJ2O37XapiZwSniZYn
         pt3g==
X-Forwarded-Encrypted: i=1; AJvYcCWlpk8W88qoeezSu1W1jwz3ZO79yq3d0Mj8m0ajcl47Gw+l9P3eRroSCmUXgJoGyepgLEGq3YbDiCmuLCh+V7IlbcWjMoNvnnuFWLSc
X-Gm-Message-State: AOJu0YzQDqAzrrCCey1ie0Qw0fCujnCi3JG8KVNKV+2t3poWX+JztmLr
	VQL7VhT07NYY3sTDTI2iA3V4eFqLiq3f1XoJ+yTknS8wdkD4wAcEHuK8CBSZR7I=
X-Google-Smtp-Source: AGHT+IGOgen2Jx0g/YQ6+0A61e2VmACILINzoPWZHBtfeJO66xBbBL4F3Gr+Gh7gEwW1i0zrX6OeUg==
X-Received: by 2002:a17:906:c94d:b0:a67:aa2b:1028 with SMTP id a640c23a62f3a-a681fc5cbccmr901709666b.8.1717492153798;
        Tue, 04 Jun 2024 02:09:13 -0700 (PDT)
Received: from raven.blarg.de (p200300dc6f4f9200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f4f:9200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68fa49e66fsm328376766b.129.2024.06.04.02.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 02:09:13 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	sfr@canb.auug.org.au,
	david@redhat.com,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v6 06/15] linux/mm.h: move page_address() and others to mm/page_address.h
Date: Tue,  4 Jun 2024 11:08:36 +0200
Message-Id: <20240604090845.2182265-7-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240604090845.2182265-1-max.kellermann@ionos.com>
References: <20240604090845.2182265-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare to reduce dependencies on linux/mm.h.

page_address() is used by the following popular headers:

- linux/bio.h
- linux/bvec.h
- linux/highmem.h
- linux/scatterlist.h
- linux/skbuff.h

Moving it to a separate lean header will allow us to avoid the
dependency on linux/mm.h.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/mm.h              | 56 +-------------------------
 include/linux/mm/page_address.h | 71 +++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+), 55 deletions(-)
 create mode 100644 include/linux/mm/page_address.h

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c9a3f1c0ae07..014db2b39c16 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2,7 +2,7 @@
 #ifndef _LINUX_MM_H
 #define _LINUX_MM_H
 
-#include <linux/mm/page_kasan_tag.h>
+#include <linux/mm/page_address.h>
 #include <linux/mm/page_section.h>
 #include <linux/errno.h>
 #include <linux/mmdebug.h>
@@ -105,10 +105,6 @@ extern int mmap_rnd_compat_bits __read_mostly;
 #define __pa_symbol(x)  __pa(RELOC_HIDE((unsigned long)(x), 0))
 #endif
 
-#ifndef page_to_virt
-#define page_to_virt(x)	__va(PFN_PHYS(page_to_pfn(x)))
-#endif
-
 #ifndef lm_alias
 #define lm_alias(x)	__va(__pa_symbol(x))
 #endif
@@ -212,14 +208,6 @@ int overcommit_kbytes_handler(struct ctl_table *, int, void *, size_t *,
 int overcommit_policy_handler(struct ctl_table *, int, void *, size_t *,
 		loff_t *);
 
-#if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
-#define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
-#define folio_page_idx(folio, p)	(page_to_pfn(p) - folio_pfn(folio))
-#else
-#define nth_page(page,n) ((page) + (n))
-#define folio_page_idx(folio, p)	((p) - &(folio)->page)
-#endif
-
 /* to align the pointer to the (next) page boundary */
 #define PAGE_ALIGN(addr) ALIGN(addr, PAGE_SIZE)
 
@@ -2174,44 +2162,6 @@ static inline int arch_make_folio_accessible(struct folio *folio)
  */
 #include <linux/vmstat.h>
 
-#if defined(CONFIG_HIGHMEM) && !defined(WANT_PAGE_VIRTUAL)
-#define HASHED_PAGE_VIRTUAL
-#endif
-
-#if defined(WANT_PAGE_VIRTUAL)
-static inline void *page_address(const struct page *page)
-{
-	return page->virtual;
-}
-static inline void set_page_address(struct page *page, void *address)
-{
-	page->virtual = address;
-}
-#define page_address_init()  do { } while(0)
-#endif
-
-#if defined(HASHED_PAGE_VIRTUAL)
-void *page_address(const struct page *page);
-void set_page_address(struct page *page, void *virtual);
-void page_address_init(void);
-#endif
-
-static __always_inline void *lowmem_page_address(const struct page *page)
-{
-	return page_to_virt(page);
-}
-
-#if !defined(HASHED_PAGE_VIRTUAL) && !defined(WANT_PAGE_VIRTUAL)
-#define page_address(page) lowmem_page_address(page)
-#define set_page_address(page, address)  do { } while(0)
-#define page_address_init()  do { } while(0)
-#endif
-
-static inline void *folio_address(const struct folio *folio)
-{
-	return page_address(&folio->page);
-}
-
 /*
  * Return true only if the page has been allocated with
  * ALLOC_NO_WATERMARKS and the low watermark was not
@@ -2261,10 +2211,6 @@ static inline void clear_page_pfmemalloc(struct page *page)
  */
 extern void pagefault_out_of_memory(void);
 
-#define offset_in_page(p)	((unsigned long)(p) & ~PAGE_MASK)
-#define offset_in_thp(page, p)	((unsigned long)(p) & (thp_size(page) - 1))
-#define offset_in_folio(folio, p) ((unsigned long)(p) & (folio_size(folio) - 1))
-
 /*
  * Parameter block passed down to zap_pte_range in exceptional cases.
  */
diff --git a/include/linux/mm/page_address.h b/include/linux/mm/page_address.h
new file mode 100644
index 000000000000..630fc4e2be95
--- /dev/null
+++ b/include/linux/mm/page_address.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_MM_PAGE_ADDRESS_H
+#define _LINUX_MM_PAGE_ADDRESS_H
+
+#include <linux/mm_types.h> // for struct page
+#include <linux/mm/page_kasan_tag.h> // needed by the page_to_virt() macro on some architectures (e.g. arm64)
+#include <asm/page.h> // for PAGE_MASK, page_to_virt()
+
+#if defined(CONFIG_FLATMEM)
+#include <linux/mmzone.h> // for memmap (used by __pfn_to_page())
+#elif defined(CONFIG_SPARSEMEM_VMEMMAP)
+#include <asm/pgtable.h> // for vmemmap (used by __pfn_to_page())
+#elif defined(CONFIG_SPARSEMEM)
+#include <linux/mm/page_section.h> // for page_to_section() (used by __page_to_pfn())
+#endif
+
+#ifndef page_to_virt
+#define page_to_virt(x)	__va(PFN_PHYS(page_to_pfn(x)))
+#endif
+
+#if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
+#define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
+#define folio_page_idx(folio, p)	(page_to_pfn(p) - folio_pfn(folio))
+#else
+#define nth_page(page,n) ((page) + (n))
+#define folio_page_idx(folio, p)	((p) - &(folio)->page)
+#endif
+
+#if defined(CONFIG_HIGHMEM) && !defined(WANT_PAGE_VIRTUAL)
+#define HASHED_PAGE_VIRTUAL
+#endif
+
+#if defined(WANT_PAGE_VIRTUAL)
+static inline void *page_address(const struct page *page)
+{
+	return page->virtual;
+}
+static inline void set_page_address(struct page *page, void *address)
+{
+	page->virtual = address;
+}
+#define page_address_init()  do { } while(0)
+#endif
+
+#if defined(HASHED_PAGE_VIRTUAL)
+void *page_address(const struct page *page);
+void set_page_address(struct page *page, void *virtual);
+void page_address_init(void);
+#endif
+
+static __always_inline void *lowmem_page_address(const struct page *page)
+{
+	return page_to_virt(page);
+}
+
+#if !defined(HASHED_PAGE_VIRTUAL) && !defined(WANT_PAGE_VIRTUAL)
+#define page_address(page) lowmem_page_address(page)
+#define set_page_address(page, address)  do { } while(0)
+#define page_address_init()  do { } while(0)
+#endif
+
+static inline void *folio_address(const struct folio *folio)
+{
+	return page_address(&folio->page);
+}
+
+#define offset_in_page(p)	((unsigned long)(p) & ~PAGE_MASK)
+#define offset_in_thp(page, p)	((unsigned long)(p) & (thp_size(page) - 1))
+#define offset_in_folio(folio, p) ((unsigned long)(p) & (folio_size(folio) - 1))
+
+#endif /* _LINUX_MM_PAGE_ADDRESS_H */
-- 
2.39.2


