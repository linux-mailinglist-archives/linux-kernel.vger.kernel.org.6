Return-Path: <linux-kernel+bounces-285038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF47950886
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87C601F21CCE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA81F19FA9F;
	Tue, 13 Aug 2024 15:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ce9dziyi"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E98419F497
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 15:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723561684; cv=none; b=KPzZdyEhUjw73XfHEWTQUJNsRtiNp+q768Ld1MQnECBYyNyxQ3OZVh7eJC7CrC8lweVv/b+E/JwDeWQVTtOm6+vaqzaa7kj1AQJ+N9xtYBbMX7vKoezC9b7Z2z3c20KwAdC+nbxjsh9tgqkhrEHMB4CIDoNgwmZohiu3yqiwGsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723561684; c=relaxed/simple;
	bh=qC3XQWCCu1rctIzw6y3siLeysb9QkV1chjdq8hOhrEs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=AV2dqTPO6Y09WTnt6eCHGWXdccu++aOLjSKkAzCevhfftyePlOf6snYGAcmXM/ok9c4YQUZkfZBX0SrneP+B+nX4665+43ETVMBX4D1aaiBxVA0umtGzyfgquphzZ1zfC9OnpVlZkdFRbNtnoI91825KQuo/i1DN3fA9pSqI5qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ce9dziyi; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0872023b7dso8884933276.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 08:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723561681; x=1724166481; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1x8HY6pqVTVF5kQzcpH4Ucp1zz0s1gAq4xU9MqMd/wE=;
        b=ce9dziyi9vKY8MxR0ZIhBgdof4vxT4DQRAqkbDkKn/qLQQsmlfboZL6d9z8sv4+w5V
         8QfoSAKz2picIJ0Xd7UwMSuYkhH6vzstRMZkj3EoN0DoODQPjaJ57SbU4vVSaQt2jI8v
         p3wt+C+lnfaw40p3SUtbn05OdX0gXPaNIll8I1r53hrsBCMxbfjTFy/eU53mPsAaxcZW
         SZuTnKCPRgJoslFXVLW/JuxJKuBruVSkQq7iQxyIewYmlpr2Bi1rgMPIJ0ouFKB1mZxW
         Qhez39/8JscTd5ZVKGMOR96KUClD14cF76euboR/keHxAdq0i82MpQN7AfUjdWNT4pVo
         Tmww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723561681; x=1724166481;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1x8HY6pqVTVF5kQzcpH4Ucp1zz0s1gAq4xU9MqMd/wE=;
        b=MfCRrh8v6wFmcVIEHSK4id6GDibhAbu5vaaucayA9icVlSqbY/q49zVbJh9xt+vYNC
         E/zYIm8Avl4vEqV0K4mz8aIuNrPn5wne8VL3TVD+OFcyxK5bAkNvZKIb3hHq0JuyjkXm
         ssUHHha27up2cPIpLskxFFa91kfVvxpxZ//H+w1+2rGPl9ZiHJ/+r3QU6QWlCEz+7aGv
         FrEO+BtPvQ+xl8Kesjgl6VyhGfA9+2NOIXWWu3BnXCgqh6CgwGK2jZ66qFkFG7zHhmsi
         Xhf86RQu6ffzQYr87P5L5vvgqNLMd4504KwsH8uifPI3qLtbVE+kxbxMWcRVb/v/Ofya
         hMMA==
X-Forwarded-Encrypted: i=1; AJvYcCWkVeS3cjYnWj2y6KSPGzKRcufmJFULKJqOfLzbVprBWc9jwgzIemQ0t9Ml2Bjtw+RlMbqQsIfyA1Ql4whnYTIUCcjC+g4UtEqsWFGu
X-Gm-Message-State: AOJu0Yw/H3ES4mTVDZikbedkHg/H/BqJoMxX8Sj6RHaMbfWwhOoC3KO8
	OLni4FxwH91g2tzs2BwqrbXfI/wZf/CgNilJu34uSeCXrupwYUuPv+arq+86181tk/jzRujmlaQ
	esQ==
X-Google-Smtp-Source: AGHT+IEz36OwLmoBcnEL1WUUu6fUVYlI+FT85j7U+cB0aTgWoq2vINT4jdflqp8Za9uby33WBDXFm+7GRew=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:b416:2d8c:d850:78])
 (user=surenb job=sendgmr) by 2002:a25:4844:0:b0:e05:eb99:5f84 with SMTP id
 3f1490d57ef6-e113e9066d6mr4889276.4.1723561681199; Tue, 13 Aug 2024 08:08:01
 -0700 (PDT)
Date: Tue, 13 Aug 2024 08:07:56 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240813150758.855881-1-surenb@google.com>
Subject: [PATCH v3 1/2] alloc_tag: introduce clear_page_tag_ref() helper function
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, david@redhat.com, vbabka@suse.cz, 
	pasha.tatashin@soleen.com, souravpanda@google.com, keescook@chromium.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, surenb@google.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In several cases we are freeing pages which were not allocated using
common page allocators. For such cases, in order to keep allocation
accounting correct, we should clear the page tag to indicate that the
page being freed is expected to not have a valid allocation tag.
Introduce clear_page_tag_ref() helper function to be used for this.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Cc: stable@vger.kernel.org # v6.10
---
 include/linux/pgalloc_tag.h | 13 +++++++++++++
 mm/mm_init.c                | 10 +---------
 mm/page_alloc.c             |  9 +--------
 3 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/include/linux/pgalloc_tag.h b/include/linux/pgalloc_tag.h
index 18cd0c0c73d9..207f0c83c8e9 100644
--- a/include/linux/pgalloc_tag.h
+++ b/include/linux/pgalloc_tag.h
@@ -43,6 +43,18 @@ static inline void put_page_tag_ref(union codetag_ref *ref)
 	page_ext_put(page_ext_from_codetag_ref(ref));
 }
 
+static inline void clear_page_tag_ref(struct page *page)
+{
+	if (mem_alloc_profiling_enabled()) {
+		union codetag_ref *ref = get_page_tag_ref(page);
+
+		if (ref) {
+			set_codetag_empty(ref);
+			put_page_tag_ref(ref);
+		}
+	}
+}
+
 static inline void pgalloc_tag_add(struct page *page, struct task_struct *task,
 				   unsigned int nr)
 {
@@ -126,6 +138,7 @@ static inline void pgalloc_tag_sub_pages(struct alloc_tag *tag, unsigned int nr)
 
 static inline union codetag_ref *get_page_tag_ref(struct page *page) { return NULL; }
 static inline void put_page_tag_ref(union codetag_ref *ref) {}
+static inline void clear_page_tag_ref(struct page *page) {}
 static inline void pgalloc_tag_add(struct page *page, struct task_struct *task,
 				   unsigned int nr) {}
 static inline void pgalloc_tag_sub(struct page *page, unsigned int nr) {}
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 75c3bd42799b..907c46b0773f 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2460,15 +2460,7 @@ void __init memblock_free_pages(struct page *page, unsigned long pfn,
 	}
 
 	/* pages were reserved and not allocated */
-	if (mem_alloc_profiling_enabled()) {
-		union codetag_ref *ref = get_page_tag_ref(page);
-
-		if (ref) {
-			set_codetag_empty(ref);
-			put_page_tag_ref(ref);
-		}
-	}
-
+	clear_page_tag_ref(page);
 	__free_pages_core(page, order, MEMINIT_EARLY);
 }
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 28f80daf5c04..3f80e94a0b66 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5821,14 +5821,7 @@ unsigned long free_reserved_area(void *start, void *end, int poison, const char
 
 void free_reserved_page(struct page *page)
 {
-	if (mem_alloc_profiling_enabled()) {
-		union codetag_ref *ref = get_page_tag_ref(page);
-
-		if (ref) {
-			set_codetag_empty(ref);
-			put_page_tag_ref(ref);
-		}
-	}
+	clear_page_tag_ref(page);
 	ClearPageReserved(page);
 	init_page_count(page);
 	__free_page(page);

base-commit: d74da846046aeec9333e802f5918bd3261fb5509
-- 
2.46.0.76.ge559c4bf1a-goog


