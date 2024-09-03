Return-Path: <linux-kernel+bounces-313827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1437A96AA4D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 23:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AD46B20CDD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 21:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954751D58B7;
	Tue,  3 Sep 2024 21:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EveYTynR"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE9D1D5897
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 21:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725399423; cv=none; b=imi+aEyYk1zSTMFnOBmsvtxPuTO0ykVzrf89wfFYwIGH6pI4gowc1c8V00k9tVx/lHHngm++DRgewiqy8b2gMGc/Z2gn3u8BujvWXLDX0OHRRENdgBUPnB2i1p1XheFra2pR+A6n6tzBcvc33H9/u5oixrBoJHgAXwunr64FqVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725399423; c=relaxed/simple;
	bh=HSPDQPv0F6AReypdlZzilXWxz/vDzx+q3gQhnTOZAAE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MlLO6VOsLB4R9oeSGcHkRt0g6fpLE0/URsx+Ni/BmVpjZoNkIuYb5RYiMelkNXaGH759Rx4I0iG2Kft8mdP4bxHUoXgx0RlcSxOyljwEMemMaQVl5UtcGTXI5rPWTjF5GCRH/JlNMrhZ5SBcuvWf5PxmYRQTdreTXpq7Qqoeiv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EveYTynR; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6d4bd76f5a8so72351837b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 14:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725399420; x=1726004220; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7lRbWVNLaQ1IZX12itRVMEELUogajjWtfSLYwZb6BSc=;
        b=EveYTynR12qvxcGPPoOtQN2aCtNzOSgJjX6rXo81QvKNf5lVQTExj/l7Ag2hxAQHJa
         rc2UohWcRFPNdWNqe9wsrmqI+R1swYTyzX25Zvpf35s8psyHrtR9sR+qVNFCuJHPJusc
         TGGLO4qUurDH2asxj7fBg0rNW6+XoJIMFzLKbBRhAzPYa4LoUy3/pqe3nWRbKjMr40fW
         L6cntZ1QNLeYKhUGFBjF4FcjJgJBLrqnsJi1KXIhuIYYx+CtwOIVVAFOO7nQqA22fzD8
         RTudQHyaRV2cv8pLLlkkYmjwzoJkxsTvF3WV0Rm5D2DyujqE0MgcW6TmvdNe8NqLo8OT
         FvlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725399420; x=1726004220;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7lRbWVNLaQ1IZX12itRVMEELUogajjWtfSLYwZb6BSc=;
        b=ZhG9cKEQ2uCMOAf5/h4z3Y6inkskLPAA7KCRXGZUPPiZDQj99r6EDomEsvz8x7iZ89
         8XCHvWsTNb6pqnHM0JlHf0AaF7TblM2FyDjkBcE7YICr+M84LuOonyiM6SDesZ1NphUK
         tMp5Ji5PyiCgCNMpDSEWgX58mqWD+DAcEHoMyDS5wBuOMWFXQZx0CLEy+h4hw7pcUQgf
         RFMM67sRM7S44kiSBtwgHkqIEGBUCsYKRBlDePbonU8jryimQZDDbpStbljNJHiSUBnL
         +hBSeKR5rPSM0+exX9bAUmpefphk8LFiBlaP6wtXRaWqIb35JljfKcuWyVYhaLYzFybO
         EGIA==
X-Forwarded-Encrypted: i=1; AJvYcCXhphrJquTsyzGuOdRj1feT5ObyOdGALySgi0g4LFjVl/c7tU00oRQzkoZgCQoS3B4ehFcRA7BMWvgMXWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZe1wwZTYUhX1ZwmgjACdkOAb34l0A2kZD2tFmDUpnX92wVPT4
	aeVINaR+GoH7jmabYiFvp+4o3tq3xoBE4lSKQ+X+TF3x81RDrSkZNfKnK31ZWku78976wfiPiCL
	AlA==
X-Google-Smtp-Source: AGHT+IFKMuOj0a8gCYr8Reqa7ik1LwLwagBRCBwi0mhu448Z4IqlPF9etRzCqLqKmBASiXsj6Jc8sLxDbM4=
X-Received: from yuzhao2.bld.corp.google.com ([2a00:79e0:2e28:6:bb58:3d85:3f9c:c6c6])
 (user=yuzhao job=sendgmr) by 2002:a25:264d:0:b0:e11:7246:963b with SMTP id
 3f1490d57ef6-e1a79fb492dmr639799276.1.1725399420440; Tue, 03 Sep 2024
 14:37:00 -0700 (PDT)
Date: Tue,  3 Sep 2024 15:36:49 -0600
In-Reply-To: <20240903213649.3566695-1-yuzhao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240903213649.3566695-1-yuzhao@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240903213649.3566695-3-yuzhao@google.com>
Subject: [PATCH mm-unstable v1 3/3] mm/codetag: add pgalloc_tag_copy()
From: Yu Zhao <yuzhao@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Suren Baghdasaryan <surenb@google.com>
Cc: Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"

Add pgalloc_tag_copy() to transfer the codetag from the old folio to
the new one during migration. This makes original allocation sites
persist cross migration rather than lump into compaction_alloc, e.g.,
  # echo 1 >/proc/sys/vm/compact_memory
  # grep compaction_alloc /proc/allocinfo

Before this patch:
  132968448  32463  mm/compaction.c:1880 func:compaction_alloc

After this patch:
          0      0  mm/compaction.c:1880 func:compaction_alloc

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 include/linux/alloc_tag.h | 24 ++++++++++--------------
 include/linux/mm.h        | 25 +++++++++++++++++++++++++
 mm/migrate.c              |  1 +
 3 files changed, 36 insertions(+), 14 deletions(-)

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
index a07e93adb8ad..1b98d843a5e9 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4161,10 +4161,35 @@ static inline void pgalloc_tag_split(struct folio *folio, int old_order, int new
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
+	/* Clear the old ref to the original allocation site. */
+	clear_page_tag_ref(&old->page);
+	/* Decrement the counters of the tag on get_new_folio. */
+	alloc_tag_sub(ref, folio_nr_pages(new));
+	__alloc_tag_ref_set(ref, tag);
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
index 35cc9d35064b..0b24021d5fee 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -750,6 +750,7 @@ void folio_migrate_flags(struct folio *newfolio, struct folio *folio)
 		folio_set_readahead(newfolio);
 
 	folio_copy_owner(newfolio, folio);
+	pgalloc_tag_copy(newfolio, folio);
 
 	mem_cgroup_migrate(folio, newfolio);
 }
-- 
2.46.0.469.g59c65b2a67-goog


