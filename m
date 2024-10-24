Return-Path: <linux-kernel+bounces-380293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C723B9AEBCF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 18:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B423B2150B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF5A1F80A3;
	Thu, 24 Oct 2024 16:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EbEP6ont"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D8C1F4707
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 16:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729787004; cv=none; b=nXi6KbJWh3Y6P57UMeyIxj7WEyUOjdl4NhWiV8LBy3z+0JdMvH6oqifIa8jRFK18A/yLr0Tq+1/VFgQOKKgKJTs8r50G3PGq6RrYHpTRXCU5gnpJZ8y43wRWCBtJeTjHSIgEasD2vwzx0Lcrux/GrqZig4XP6HrZoIfejAYCIDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729787004; c=relaxed/simple;
	bh=8oc5PdhhlgmJAcecp9jnCe71f+xSSCxou7pzD2J331M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=oCT6eWZk1HTGLhzR7DKGqOBO3Z+tLvqHInl3Q74FkcIAk6cYLnu29+8biE5uIZyPFEVra0S6AHetAXwQGM7LKt8AZ0SCp8ehVE+U1tcHOAtsb2ToHPzr3dMGKczIoI7rxU1R/mmz3xiGw6q+IUfqkJp/5FAIlZ3oCa3VE2DZepk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EbEP6ont; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e7e0093018so20045657b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 09:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729787001; x=1730391801; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gTU/Az6oQC87qV0R2JNeB98NQAAeDAB9smYAoMmnxCc=;
        b=EbEP6ontvRrpJmWoan7khR+fAXGZ0ZLIhrdBLEox3s2QYTRlubVt5FSEgkq/aYITFk
         QfMPbR2lZMcBNrGppJWwIcCwqS3RJXiSR4JYBtuzubHb3RCkjasq5Qz1fLhZYU2U/4F+
         zOwCrRXI9PPIVGaEOhJRyZySWHUofs/whlotdcK71xApYr1I22MZJnYo+plxLD0tWggR
         0tBOOgBRiULdFoO9cBBSwwZ+sNDI7sPpVtntaID607n7Vr3WR9Si+hEG3O/IcGd87HHZ
         DnV8UooSV0TI7geYqHj87reYzeo42EjXx9RnUt3UzwKe0PhpYmT9apZddwZ1r+KM+jOg
         TppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729787001; x=1730391801;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gTU/Az6oQC87qV0R2JNeB98NQAAeDAB9smYAoMmnxCc=;
        b=acshLgPluo4Hw25jaDkPPjmIMAgAWLbO/RW8o09OOVmTH38QqJkYmH0XA8i3RRM7Uk
         TktJ+toB/GDc/wndFKmwJraIs5BqNW7R478eH2sme2YBRQw1uYrBiOxCWZYFElR7o0yz
         uZiL4iaecd4PY2OXXeDI2iMqpYRH6u765AzCsZ8ZjrKmeom1PlvJ3jzCh+EghfDAkEVX
         f7C0nc+FK4VzH1TFYZDQCGx8e6EiQyrErMobUvcVv7PIt7tZrBJjslTd4uKhyrI7+Lt5
         UAPpwhvk4yOqhhtBbe3bm3oIpzLwC9WDaQYc0C2zSdPNZeUWyKFVVG3EpYSrhhZqdHU2
         Tlvw==
X-Forwarded-Encrypted: i=1; AJvYcCUtxOHY0m0SPQbFrroM5QcX/MAbc3v+a/r0Ub2x5K+ho/rr9GK4dxNbQSnF+oWgDQrzm/jMRsdaN8UpH+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL6arHfg8HJtu3F8KcIiVMYXVrC0C+PIHa9NH3s/w+82uuir73
	uUym6OdYMMR9EpYgVz5eY0M1HHof3lThIvgsEbShPN2fSD0tiuqYWX6gP2r5z5yCXHeGdGyJn/c
	VHw==
X-Google-Smtp-Source: AGHT+IGzDL8ww+0/uK6UkUgn7P+6nNxCybhx2NYsrl5o+4THb/v3434ldbCSMuGjsNZGJegfhEedS/IaArE=
X-Received: from surenb-desktop.mtv.corp.google.com ([2a00:79e0:2e3f:8:47e4:54e:bc8e:cb18])
 (user=surenb job=sendgmr) by 2002:a05:690c:3802:b0:6de:19f:34d7 with SMTP id
 00721157ae682-6e858143817mr695977b3.2.1729787001130; Thu, 24 Oct 2024
 09:23:21 -0700 (PDT)
Date: Thu, 24 Oct 2024 09:23:18 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <20241024162318.1640781-1-surenb@google.com>
Subject: [PATCH 1/1] mm/codetag: uninline and move pgalloc_tag_copy and pgalloc_tag_split
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, yuzhao@google.com, souravpanda@google.com, 
	pasha.tatashin@soleen.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	surenb@google.com
Content-Type: text/plain; charset="UTF-8"

pgalloc_tag_copy() and pgalloc_tag_split() are sizable and outside of
any performance-critical paths, so it should be fine to uninline them.
Also move their declarations into pgalloc_tag.h which seems like a more
appropriate place for them.
No functional changes other than uninlining.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Suggested-by: Andrew Morton <akpm@linux-foundation.org>
---
Applies over mm-unstable

 include/linux/mm.h          | 58 -------------------------------------
 include/linux/pgalloc_tag.h |  5 ++++
 lib/alloc_tag.c             | 48 ++++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+), 58 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 4ef8cf1043f1..5184624c0f21 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4165,62 +4165,4 @@ static inline int do_mseal(unsigned long start, size_t len_in, unsigned long fla
 }
 #endif
 
-#ifdef CONFIG_MEM_ALLOC_PROFILING
-static inline void pgalloc_tag_split(struct folio *folio, int old_order, int new_order)
-{
-	int i;
-	struct alloc_tag *tag;
-	unsigned int nr_pages = 1 << new_order;
-
-	if (!mem_alloc_profiling_enabled())
-		return;
-
-	tag = pgalloc_tag_get(&folio->page);
-	if (!tag)
-		return;
-
-	for (i = nr_pages; i < (1 << old_order); i += nr_pages) {
-		union pgtag_ref_handle handle;
-		union codetag_ref ref;
-
-		if (get_page_tag_ref(folio_page(folio, i), &ref, &handle)) {
-			/* Set new reference to point to the original tag */
-			alloc_tag_ref_set(&ref, tag);
-			update_page_tag_ref(handle, &ref);
-			put_page_tag_ref(handle);
-		}
-	}
-}
-
-static inline void pgalloc_tag_copy(struct folio *new, struct folio *old)
-{
-	union pgtag_ref_handle handle;
-	union codetag_ref ref;
-	struct alloc_tag *tag;
-
-	tag = pgalloc_tag_get(&old->page);
-	if (!tag)
-		return;
-
-	if (!get_page_tag_ref(&new->page, &ref, &handle))
-		return;
-
-	/* Clear the old ref to the original allocation tag. */
-	clear_page_tag_ref(&old->page);
-	/* Decrement the counters of the tag on get_new_folio. */
-	alloc_tag_sub(&ref, folio_size(new));
-	__alloc_tag_ref_set(&ref, tag);
-	update_page_tag_ref(handle, &ref);
-	put_page_tag_ref(handle);
-}
-#else /* !CONFIG_MEM_ALLOC_PROFILING */
-static inline void pgalloc_tag_split(struct folio *folio, int old_order, int new_order)
-{
-}
-
-static inline void pgalloc_tag_copy(struct folio *new, struct folio *old)
-{
-}
-#endif /* CONFIG_MEM_ALLOC_PROFILING */
-
 #endif /* _LINUX_MM_H */
diff --git a/include/linux/pgalloc_tag.h b/include/linux/pgalloc_tag.h
index 1fe63b52e5e5..0e43ab653ab6 100644
--- a/include/linux/pgalloc_tag.h
+++ b/include/linux/pgalloc_tag.h
@@ -230,6 +230,9 @@ static inline void pgalloc_tag_sub_pages(struct alloc_tag *tag, unsigned int nr)
 		this_cpu_sub(tag->counters->bytes, PAGE_SIZE * nr);
 }
 
+void pgalloc_tag_split(struct folio *folio, int old_order, int new_order);
+void pgalloc_tag_copy(struct folio *new, struct folio *old);
+
 void __init alloc_tag_sec_init(void);
 
 #else /* CONFIG_MEM_ALLOC_PROFILING */
@@ -241,6 +244,8 @@ static inline void pgalloc_tag_sub(struct page *page, unsigned int nr) {}
 static inline struct alloc_tag *pgalloc_tag_get(struct page *page) { return NULL; }
 static inline void pgalloc_tag_sub_pages(struct alloc_tag *tag, unsigned int nr) {}
 static inline void alloc_tag_sec_init(void) {}
+static inline void pgalloc_tag_split(struct folio *folio, int old_order, int new_order) {}
+static inline void pgalloc_tag_copy(struct folio *new, struct folio *old) {}
 
 #endif /* CONFIG_MEM_ALLOC_PROFILING */
 
diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index a6f6f014461e..c1ddac2d29f0 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -163,6 +163,54 @@ size_t alloc_tag_top_users(struct codetag_bytes *tags, size_t count, bool can_sl
 	return nr;
 }
 
+void pgalloc_tag_split(struct folio *folio, int old_order, int new_order)
+{
+	int i;
+	struct alloc_tag *tag;
+	unsigned int nr_pages = 1 << new_order;
+
+	if (!mem_alloc_profiling_enabled())
+		return;
+
+	tag = pgalloc_tag_get(&folio->page);
+	if (!tag)
+		return;
+
+	for (i = nr_pages; i < (1 << old_order); i += nr_pages) {
+		union pgtag_ref_handle handle;
+		union codetag_ref ref;
+
+		if (get_page_tag_ref(folio_page(folio, i), &ref, &handle)) {
+			/* Set new reference to point to the original tag */
+			alloc_tag_ref_set(&ref, tag);
+			update_page_tag_ref(handle, &ref);
+			put_page_tag_ref(handle);
+		}
+	}
+}
+
+void pgalloc_tag_copy(struct folio *new, struct folio *old)
+{
+	union pgtag_ref_handle handle;
+	union codetag_ref ref;
+	struct alloc_tag *tag;
+
+	tag = pgalloc_tag_get(&old->page);
+	if (!tag)
+		return;
+
+	if (!get_page_tag_ref(&new->page, &ref, &handle))
+		return;
+
+	/* Clear the old ref to the original allocation tag. */
+	clear_page_tag_ref(&old->page);
+	/* Decrement the counters of the tag on get_new_folio. */
+	alloc_tag_sub(&ref, folio_size(new));
+	__alloc_tag_ref_set(&ref, tag);
+	update_page_tag_ref(handle, &ref);
+	put_page_tag_ref(handle);
+}
+
 static void shutdown_mem_profiling(bool remove_file)
 {
 	if (mem_alloc_profiling_enabled())

base-commit: 9c111059234a949a4d3442a413ade19cc65ab927
-- 
2.47.0.105.g07ac214952-goog


