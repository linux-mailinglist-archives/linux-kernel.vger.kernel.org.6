Return-Path: <linux-kernel+bounces-200322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E50EB8FAE69
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B6CB2831E6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3D71459F8;
	Tue,  4 Jun 2024 09:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="iizB5ryk"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B0B143870
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 09:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717492165; cv=none; b=ekX84zIwZ9DXQreUqXTohkA7yZGrmHBKegEcd9jJ+BvxFbUmnPo1ODoco1YaN/HqNQbxZq6lCF03lhNexfW9XS0f8tBbVMNLfFFWTkihA1lkOYae6YFiEC7nz4G50WmtkxgQda/p/P8w9Edr3Zv6CVnmjzDBs6bp9z1HUqw7hjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717492165; c=relaxed/simple;
	bh=E7omIAd4oioz178wbahLxCf/I00afQCoybuhoNDREsg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UiRkNrpO2KDYVX/grYJOMpkQfy8mo1QCb+79rkiJ5rrW/MSEALApuiBKyJBy8TPLtmmRoPE6I9B37Xg8FGvvwahBL/RuSDqx/LE5Le8ERTpgQFoSKaaBVwGDcJiQxwJELzjxGwE7/Tovak1JhsJrMGv/HornGZIUCqRClkb+VYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=iizB5ryk; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57a1fe6392eso6069898a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 02:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1717492161; x=1718096961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=66hU7JCzDxZkm1iV/ENOXsQE3QPWNxsFJw0nhpOp8E8=;
        b=iizB5ryk4QWnKCluE/rRqllcKR4DA6W90mXewvxC5i1XnoEgg6uOPKE/YRN4BOiNGm
         jz1DGQvo49Kdr0Ec4LaIzHbDrE9zh1DyPuhxN2Dud380bt4Zr+1kC2djlZsD3QUoE2Gf
         umLOMSfeRN3ASTsv2LPRL7tHeegNXwhlC/y534l1PNyyXhBiOuJh+fxaRg+N7QSikgai
         lK5vnvVjVsyXHLBKbidoeWnFsCQkN/UMDDh2v11mKKvYZD5298Mp9rELhvBFsRFh5vXK
         lGw9dHKFla0RuFfgk22FCOqTNclqwb888vJV8kW8eEE+7TxVPAqKVxSVkQOeyKhTLf53
         4Nrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717492161; x=1718096961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=66hU7JCzDxZkm1iV/ENOXsQE3QPWNxsFJw0nhpOp8E8=;
        b=u9zA0QnKsJzvRrcjK2c9YTiXHCA8SHUIeltTZYrw2rRnA/u2lMgeOWVBOlIAvxZxVW
         vHGE481/miVqNxLYP1fjEI/kxFBZn6RIY78WgwDPeLXSt5rBZG8XO6CEI+TmNugxq1qd
         WHREj/fUDIfO1F/rtkxI9fhUuUh2tthvXrHyOs8apLGQgiIzarFM3AQ6olGX8EAerkcb
         RXciLn5aJ6iBKx2z06xE2hZE+TGR3rTRudBTptSZSEs94QZLLLqVzeK9kzq8tqVb3vq+
         rb5rXQLJb0afaaXzq/nn6DyPNbeIyQEOV9mOt0mr47JRg+ONFblegeqTzgfGyNgBrrSI
         sIvg==
X-Forwarded-Encrypted: i=1; AJvYcCUlJlbOVDNyy0Mnzx31Yur7EbKgdsSO77fYfSI4+An8/O4FQyekPPmVliJb4YSTuE8noLM/VbdZEnG9lKQUDamskyh9jajPK8fdHtz5
X-Gm-Message-State: AOJu0Yww1CJ4NchR2nzsDL6y1GhkoDXZUJIRGzI4vBU+Z5obeLNz3C7/
	PNzrAemAqKXcCDbn1OLXrSjHxlw14HiVCl/tQWSjyCNjqGyFCNN1Z+Yeru86YumxAxZwHa4VEh3
	Mw/w=
X-Google-Smtp-Source: AGHT+IFjlRq5i4sRiIz9ii8DICuiWwLZihtIRXZ77Dt4nvy+Gy+GZJvOZGsJ7ckHFkBdl+70Wt0aaw==
X-Received: by 2002:a17:906:f585:b0:a68:f0ce:9f2e with SMTP id a640c23a62f3a-a68f0cea079mr465457066b.44.1717492161256;
        Tue, 04 Jun 2024 02:09:21 -0700 (PDT)
Received: from raven.blarg.de (p200300dc6f4f9200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f4f:9200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68fa49e66fsm328376766b.129.2024.06.04.02.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 02:09:20 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	sfr@canb.auug.org.au,
	david@redhat.com,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v6 12/15] linux/mm.h: move pfmemalloc-related functions to pfmemalloc.h
Date: Tue,  4 Jun 2024 11:08:42 +0200
Message-Id: <20240604090845.2182265-13-max.kellermann@ionos.com>
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

This is needed to eliminate linux/skbuff.h's dependency on linux/mm.h.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/mm.h            | 45 +-----------------------------
 include/linux/mm/pfmemalloc.h | 52 +++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 44 deletions(-)
 create mode 100644 include/linux/mm/pfmemalloc.h

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c026e58e3725..e178bda2525d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -8,6 +8,7 @@
 #include <linux/mm/folio_zone.h>
 #include <linux/mm/page_address.h>
 #include <linux/mm/page_section.h>
+#include <linux/mm/pfmemalloc.h>
 #include <linux/errno.h>
 #include <linux/mmdebug.h>
 #include <linux/gfp.h>
@@ -1772,50 +1773,6 @@ static inline int arch_make_folio_accessible(struct folio *folio)
  */
 #include <linux/vmstat.h>
 
-/*
- * Return true only if the page has been allocated with
- * ALLOC_NO_WATERMARKS and the low watermark was not
- * met implying that the system is under some pressure.
- */
-static inline bool page_is_pfmemalloc(const struct page *page)
-{
-	/*
-	 * lru.next has bit 1 set if the page is allocated from the
-	 * pfmemalloc reserves.  Callers may simply overwrite it if
-	 * they do not need to preserve that information.
-	 */
-	return (uintptr_t)page->lru.next & BIT(1);
-}
-
-/*
- * Return true only if the folio has been allocated with
- * ALLOC_NO_WATERMARKS and the low watermark was not
- * met implying that the system is under some pressure.
- */
-static inline bool folio_is_pfmemalloc(const struct folio *folio)
-{
-	/*
-	 * lru.next has bit 1 set if the page is allocated from the
-	 * pfmemalloc reserves.  Callers may simply overwrite it if
-	 * they do not need to preserve that information.
-	 */
-	return (uintptr_t)folio->lru.next & BIT(1);
-}
-
-/*
- * Only to be called by the page allocator on a freshly allocated
- * page.
- */
-static inline void set_page_pfmemalloc(struct page *page)
-{
-	page->lru.next = (void *)BIT(1);
-}
-
-static inline void clear_page_pfmemalloc(struct page *page)
-{
-	page->lru.next = NULL;
-}
-
 /*
  * Can be called by the pagefault handler when it gets a VM_FAULT_OOM.
  */
diff --git a/include/linux/mm/pfmemalloc.h b/include/linux/mm/pfmemalloc.h
new file mode 100644
index 000000000000..345b215a3566
--- /dev/null
+++ b/include/linux/mm/pfmemalloc.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_MM_PFMEMALLOC_H
+#define _LINUX_MM_PFMEMALLOC_H
+
+#include <linux/bits.h> // for BIT()
+#include <linux/mm_types.h> // for struct page
+
+/*
+ * Return true only if the page has been allocated with
+ * ALLOC_NO_WATERMARKS and the low watermark was not
+ * met implying that the system is under some pressure.
+ */
+static inline bool page_is_pfmemalloc(const struct page *page)
+{
+	/*
+	 * lru.next has bit 1 set if the page is allocated from the
+	 * pfmemalloc reserves.  Callers may simply overwrite it if
+	 * they do not need to preserve that information.
+	 */
+	return (uintptr_t)page->lru.next & BIT(1);
+}
+
+/*
+ * Return true only if the folio has been allocated with
+ * ALLOC_NO_WATERMARKS and the low watermark was not
+ * met implying that the system is under some pressure.
+ */
+static inline bool folio_is_pfmemalloc(const struct folio *folio)
+{
+	/*
+	 * lru.next has bit 1 set if the page is allocated from the
+	 * pfmemalloc reserves.  Callers may simply overwrite it if
+	 * they do not need to preserve that information.
+	 */
+	return (uintptr_t)folio->lru.next & BIT(1);
+}
+
+/*
+ * Only to be called by the page allocator on a freshly allocated
+ * page.
+ */
+static inline void set_page_pfmemalloc(struct page *page)
+{
+	page->lru.next = (void *)BIT(1);
+}
+
+static inline void clear_page_pfmemalloc(struct page *page)
+{
+	page->lru.next = NULL;
+}
+
+#endif /* _LINUX_MM_PFMEMALLOC_H */
-- 
2.39.2


