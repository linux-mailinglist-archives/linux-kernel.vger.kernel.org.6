Return-Path: <linux-kernel+bounces-318114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FD596E89C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 06:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1AA71C215BB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 04:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF2777112;
	Fri,  6 Sep 2024 04:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sZwDt5j6"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776A160DCF
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 04:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725596481; cv=none; b=Y+asA9qePq49mQV0YSkDsKnPgGU5lywUD9lEfuwyVur07vroK9+81hUS05zale/yOcS/EaENtIfLoqwvNTlpDmz3KnxlrZsz63eCkHT9ewQ/rexG//EbvI9UpT1oklnoZSQFVc57plkjugxcnx1xRd2T/cUVEFZ5uxMYbVfVSX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725596481; c=relaxed/simple;
	bh=pbOpeH2XdxfdMxyKeI3c14H0aMfGDiL1C5SemqQyepQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WgSiEsSM7sXAsRHW1kUKu5yCdAPSqbOa8GzYVsviMJuHw6YuFINXWpgtNrI7ZUa90bexZwcMxauuwTUBzzWPSRlv0XdJXDUsvgRF6B9b6io2CrOJnE3dR4/YYkodNeBlFjzU6Ji3wiPnevNWzDJTeWF6Z0UgcSb6CWeNwytG+3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sZwDt5j6; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6b2249bf2d0so57270917b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 21:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725596478; x=1726201278; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=50wP6OBJW621Z1lTCrGAHD/paOiHcQB2J19sjWWdS44=;
        b=sZwDt5j6IjwjviNEfeX8dM1jaZ7CsFCtWLgqBbGmlxJUykP1LVUyu47zu4dVh9GX/g
         Uyvh7tmXAEINgZO65Ci2gjdbaDj+iA5QV/TnOZV0fjiW9Ng6PT1r2IaYUHXse1KN1Owd
         TmaBMROe3LsWqAF2nOHXPOHOz35rUpmd9jUTPxj9werhHFtI1cxvID1Gy3SGnEXDnoVo
         foi24W0MEa7idyT578Ma6SAfEPlMERvvvgXW7JSviyxlNtfmRMDS5m+HBjXA75B/BymP
         v0LyrFZ1HL9tCkDEHpyk7AK1/hv+3hAFlh6pRArYOZkKMFgNAtgI/e3+rZgJHRngBzsd
         oJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725596478; x=1726201278;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=50wP6OBJW621Z1lTCrGAHD/paOiHcQB2J19sjWWdS44=;
        b=Xbfe5wjy0UMF26/e1QIS/XOHvVU9wnYN2gu6SGsrHO5Co1bGUeWRggArcQujkiv1Kx
         0FTNnI0yK+s71CIcW5iyvx0dVVBKyZSX+lesJVnHb3ES4zWkFbhnp/8etEq46Bb1gt1F
         BHxVhT/MIkvJELWxzPzFcAT8nMEPcUDxjvC2ARlKKCaPWafrKpewCFf9W99XWWutXD2c
         kkHsiVGj4taYpo0mOrY5eKWuiYXjnWZrl4olN1IdW3kMMX8zyUcFJntFfnYDYam3g1MB
         XOQwcnk5vpW0jf5DvhGGUawAc9eOZ40DqIXNoGWXz3xPrmgDC+RfsqPExe4bVK3hP+Lq
         R0HA==
X-Forwarded-Encrypted: i=1; AJvYcCX431Z1i33TqzvExhLIzM5CaiDZIuWk4qqxdeo2qiPHDffeP08T/gqaoSLsb1MHsu97R8khUvQooYecSRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUtjC9bpI4diuPqqpuvDsQkunxLH/Gs0Aq5DGvJKqo0MtyUFtG
	eaU4TQDH4970efA0C2DcdBlXNkvQJesTpMnq8yrWa6UXcm5b1Nx0DE+dNwocs4Q60h2LKU3nHsp
	aDg==
X-Google-Smtp-Source: AGHT+IF4EfUu9keMzscep5B8o/9Ylkdf8A/cgbCOdPnpDmV6X9nqkqfVEQVj/bbPL42JtNauX/vBJjc/UKI=
X-Received: from yuzhao2.bld.corp.google.com ([2a00:79e0:2e28:6:5b7a:cdaf:9b3d:354a])
 (user=yuzhao job=sendgmr) by 2002:a25:d84e:0:b0:e11:5da7:337 with SMTP id
 3f1490d57ef6-e1d3487f694mr2558276.3.1725596477951; Thu, 05 Sep 2024 21:21:17
 -0700 (PDT)
Date: Thu,  5 Sep 2024 22:21:08 -0600
In-Reply-To: <20240906042108.1150526-1-yuzhao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240906042108.1150526-1-yuzhao@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240906042108.1150526-3-yuzhao@google.com>
Subject: [PATCH mm-unstable v2 3/3] mm/codetag: add pgalloc_tag_copy()
From: Yu Zhao <yuzhao@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Suren Baghdasaryan <surenb@google.com>
Cc: Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yu Zhao <yuzhao@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add pgalloc_tag_copy() to transfer the codetag from the old folio to
the new one during migration. This makes original allocation sites
persist cross migration rather than lump into the get_new_folio
callbacks passed into migrate_pages(), e.g., compaction_alloc():

  # echo 1 >/proc/sys/vm/compact_memory
  # grep compaction_alloc /proc/allocinfo

Before this patch:
  132968448  32463  mm/compaction.c:1880 func:compaction_alloc

After this patch:
          0      0  mm/compaction.c:1880 func:compaction_alloc

Fixes: dcfe378c81f7 ("lib: introduce support for page allocation tagging")
Signed-off-by: Yu Zhao <yuzhao@google.com>
Acked-by: Suren Baghdasaryan <surenb@google.com>
Cc: <stable@vger.kernel.org>
---
 include/linux/alloc_tag.h | 24 ++++++++++--------------
 include/linux/mm.h        | 27 +++++++++++++++++++++++++++
 mm/migrate.c              |  1 +
 3 files changed, 38 insertions(+), 14 deletions(-)

diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
index 896491d9ebe8..1f0a9ff23a2c 100644
--- a/include/linux/alloc_tag.h
+++ b/include/linux/alloc_tag.h
@@ -137,7 +137,16 @@ static inline void alloc_tag_sub_check(union codetag_ref *ref) {}
 /* Caller should verify both ref and tag to be valid */
 static inline void __alloc_tag_ref_set(union codetag_ref *ref, struct alloc_tag *tag)
 {
+	alloc_tag_add_check(ref, tag);
+	if (!ref || !tag)
+		return;
+
 	ref->ct = &tag->ct;
+}
+
+static inline void alloc_tag_ref_set(union codetag_ref *ref, struct alloc_tag *tag)
+{
+	__alloc_tag_ref_set(ref, tag);
 	/*
 	 * We need in increment the call counter every time we have a new
 	 * allocation or when we split a large allocation into smaller ones.
@@ -147,22 +156,9 @@ static inline void __alloc_tag_ref_set(union codetag_ref *ref, struct alloc_tag
 	this_cpu_inc(tag->counters->calls);
 }
 
-static inline void alloc_tag_ref_set(union codetag_ref *ref, struct alloc_tag *tag)
-{
-	alloc_tag_add_check(ref, tag);
-	if (!ref || !tag)
-		return;
-
-	__alloc_tag_ref_set(ref, tag);
-}
-
 static inline void alloc_tag_add(union codetag_ref *ref, struct alloc_tag *tag, size_t bytes)
 {
-	alloc_tag_add_check(ref, tag);
-	if (!ref || !tag)
-		return;
-
-	__alloc_tag_ref_set(ref, tag);
+	alloc_tag_ref_set(ref, tag);
 	this_cpu_add(tag->counters->bytes, bytes);
 }
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index a07e93adb8ad..d750be768121 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4161,10 +4161,37 @@ static inline void pgalloc_tag_split(struct folio *folio, int old_order, int new
 		}
 	}
 }
+
+static inline void pgalloc_tag_copy(struct folio *new, struct folio *old)
+{
+	struct alloc_tag *tag;
+	union codetag_ref *ref;
+
+	tag = pgalloc_tag_get(&old->page);
+	if (!tag)
+		return;
+
+	ref = get_page_tag_ref(&new->page);
+	if (!ref)
+		return;
+
+	/* Clear the old ref to the original allocation tag. */
+	clear_page_tag_ref(&old->page);
+	/* Decrement the counters of the tag on get_new_folio. */
+	alloc_tag_sub(ref, folio_nr_pages(new));
+
+	__alloc_tag_ref_set(ref, tag);
+
+	put_page_tag_ref(ref);
+}
 #else /* !CONFIG_MEM_ALLOC_PROFILING */
 static inline void pgalloc_tag_split(struct folio *folio, int old_order, int new_order)
 {
 }
+
+static inline void pgalloc_tag_copy(struct folio *new, struct folio *old)
+{
+}
 #endif /* CONFIG_MEM_ALLOC_PROFILING */
 
 #endif /* _LINUX_MM_H */
diff --git a/mm/migrate.c b/mm/migrate.c
index 0f6b78fd73aa..dfdb3a136bf8 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -743,6 +743,7 @@ void folio_migrate_flags(struct folio *newfolio, struct folio *folio)
 		folio_set_readahead(newfolio);
 
 	folio_copy_owner(newfolio, folio);
+	pgalloc_tag_copy(newfolio, folio);
 
 	mem_cgroup_migrate(folio, newfolio);
 }
-- 
2.46.0.469.g59c65b2a67-goog


