Return-Path: <linux-kernel+bounces-200315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C658FAE60
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B35271C21489
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4AC1448C6;
	Tue,  4 Jun 2024 09:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Uhwp6MO0"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B78143C62
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 09:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717492156; cv=none; b=E6+h3tQbAoClqbIA0BnAie1UU/SqufMToIph8Sa6rthT9Wr0DDNgMu6cp/W0ZV/RSTBI7zGwlAei4yjKqgPoFJwSl9b0iS3eK8z4ReeJv6Aad4YH0HY5O7yIWcDRpSEuBRWJNyMd6YB5SnHE7+a1+AnsI3dG59CSunL/+ucu2QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717492156; c=relaxed/simple;
	bh=E3A3l3B6ecN/6qv87Qca2szysFuXPHOomJqMT+mzlXY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Go1D3TWIB6o86PKq3hJlKIKmo+RiDqQLL2I7MFlSKZ+DJxIaAxbBrYhZ74oseEpHOxIKr1GkU3TPRiwSwtD+ZsN4qi92ReNQ64xgOeV1QlzJH4cKNVjPxINSt1b86LTTRnlIYoO0VVg7b0ynS5gIgoqHWUkT7B32oSrqbCdQmcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Uhwp6MO0; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57a20ccafc6so4695246a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 02:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1717492153; x=1718096953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ugwYiQRh7gsSZKM5f9fZEfiERzaZSJH9xrcJo+enM8=;
        b=Uhwp6MO0YYJlz6FHPU9FAtNqKkFq46/XkEh+8teWHfkJTDDtuzsHzmMzGEeZ8I+ZtR
         nFkOUH7SsBhmCJANAfIQGbyFSMcU6LHkgfMzVFpsHXyAiLRWYh3zoGqALt7O0QVkCSoF
         d/6xUVd/Zg0U7x5dLrZgo7G8FFxmSecLSCXtjBTfUkoi3mick5nlnd5HZR/yPEIYWLjL
         SzLQ/DshFuGxajsOcLYqccKd4JaoC6R4PrZfV/p8fpLt8PdXu+uZsibVvZoBW5U5uGbz
         ElK4hWmtrj9VNNSCZo37qKuw13eb6TAxVYtvJ7tYIdWvnSKXYNz00a8V3BKwaoBK84Qw
         5HZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717492153; x=1718096953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ugwYiQRh7gsSZKM5f9fZEfiERzaZSJH9xrcJo+enM8=;
        b=N5pLxwBm3Vahbm9mr/BfRRo3TU7UNizQNaG3JzZqOECWstxK7XFi1ikt/oK59iH9/s
         D7hb0e57XMG626KVo1aZH57sWLQbMZarOOxgfwbpS3xe+2QQUb8rIFv0g5Wrc28KrnwC
         cor7BqjCMuTR9RCv5gNA9ZWX289DH2Ps/s4v3RRpWfHlbxKJtJJgh/T6oIfF0G5NmmCG
         k+OFdRswr+NdMou3WWdmhYB/4o4Yi0Atx5NNvTntn4+ZvfOfcPWySb3JC0w1W/37jMZE
         fO4qUlSeRU2gFrPG01/MZsJFbCJ3tumXxTB5eKKB/gdgHCnn6Qvb2OQwT8CP5u+CAO+l
         8eaw==
X-Forwarded-Encrypted: i=1; AJvYcCUDTXRxvNPT6YHF15HUtn/DTG4v1djM/znWs/x5jUG7vqFbQA94Q/O1ZhQ33DPmxvB8/X9Ero8YIA4YIY/C3XHGyAZPRzEqehpBZFHi
X-Gm-Message-State: AOJu0Yzj2f/tduevFeOeBq8MWKss2SzcVi9lRBWNqSCqQiSp7bqRII4u
	M/rYBILxt2cA1BxMEtaHrCNBNXg44tSXWOkjJ8Ul3whdW5b+bw/K6xx243fkC/c=
X-Google-Smtp-Source: AGHT+IHuYP1ufnXMMmWaJJ03GHA9WgouemhQpCjHhbIXLQh1XyAq6YAVOglv63VcXHv+oaxWEjtZQA==
X-Received: by 2002:a17:907:9725:b0:a68:fafc:659 with SMTP id a640c23a62f3a-a68fafc0807mr430280566b.29.1717492152699;
        Tue, 04 Jun 2024 02:09:12 -0700 (PDT)
Received: from raven.blarg.de (p200300dc6f4f9200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f4f:9200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68fa49e66fsm328376766b.129.2024.06.04.02.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 02:09:11 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	sfr@canb.auug.org.au,
	david@redhat.com,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v6 05/15] linux/mm.h: move section functions to mm/page_section.h
Date: Tue,  4 Jun 2024 11:08:35 +0200
Message-Id: <20240604090845.2182265-6-max.kellermann@ionos.com>
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

page_to_section() is used by __page_to_pfn() (but
asm-generic/memory_model.h does not include linux/mm.h).  Thus, in
order to be able to use anything that calls page_to_pfn(), linux/mm.h
needs to be included.

This would prevent us from moving page_address() to a separate header,
because it calls lowmem_page_address() which in turn calls
page_to_virt() and then page_to_pfn().  To prepare for this move, we
move page_to_section() out of linux/mm.h into a separate lean header.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/mm.h              | 18 +-----------------
 include/linux/mm/page_section.h | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+), 17 deletions(-)
 create mode 100644 include/linux/mm/page_section.h

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 3ff239992d4c..c9a3f1c0ae07 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3,6 +3,7 @@
 #define _LINUX_MM_H
 
 #include <linux/mm/page_kasan_tag.h>
+#include <linux/mm/page_section.h>
 #include <linux/errno.h>
 #include <linux/mmdebug.h>
 #include <linux/gfp.h>
@@ -1631,10 +1632,6 @@ static inline bool is_nommu_shared_mapping(vm_flags_t flags)
 }
 #endif
 
-#if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
-#define SECTION_IN_PAGE_FLAGS
-#endif
-
 /*
  * The identification function is mainly used by the buddy allocator for
  * determining if two pages could be buddies. We are not really identifying
@@ -1832,19 +1829,6 @@ static inline pg_data_t *folio_pgdat(const struct folio *folio)
 	return page_pgdat(&folio->page);
 }
 
-#ifdef SECTION_IN_PAGE_FLAGS
-static inline void set_page_section(struct page *page, unsigned long section)
-{
-	page->flags &= ~(SECTIONS_MASK << SECTIONS_PGSHIFT);
-	page->flags |= (section & SECTIONS_MASK) << SECTIONS_PGSHIFT;
-}
-
-static inline unsigned long page_to_section(const struct page *page)
-{
-	return (page->flags >> SECTIONS_PGSHIFT) & SECTIONS_MASK;
-}
-#endif
-
 /**
  * folio_pfn - Return the Page Frame Number of a folio.
  * @folio: The folio.
diff --git a/include/linux/mm/page_section.h b/include/linux/mm/page_section.h
new file mode 100644
index 000000000000..e4558c2691b8
--- /dev/null
+++ b/include/linux/mm/page_section.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_MM_PAGE_SECTION_H
+#define _LINUX_MM_PAGE_SECTION_H
+
+#include <linux/mm_types.h> // for struct page
+#include <linux/mmzone.h> // for SECTIONS_*
+
+#if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
+#define SECTION_IN_PAGE_FLAGS
+
+static inline void set_page_section(struct page *page, unsigned long section)
+{
+	page->flags &= ~(SECTIONS_MASK << SECTIONS_PGSHIFT);
+	page->flags |= (section & SECTIONS_MASK) << SECTIONS_PGSHIFT;
+}
+
+static inline unsigned long page_to_section(const struct page *page)
+{
+	return (page->flags >> SECTIONS_PGSHIFT) & SECTIONS_MASK;
+}
+#endif
+
+#endif /* _LINUX_MM_PAGE_SECTION_H */
-- 
2.39.2


