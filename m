Return-Path: <linux-kernel+bounces-383789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4579B203A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 21:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EA081F21235
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 20:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0231F176AAF;
	Sun, 27 Oct 2024 20:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PEeRgW/3"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD3C17736
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 20:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730060126; cv=none; b=J3NLEl24v61oiiXbi3+q/mQG2eZpxdP1WS/HXMJiHgMWyxPqAvUBe8zk4ltG1t3ibUFdA2B5RuSq59Fbh0URGKkXe1y5MJaufwin9G8kFdBUCr9Rlbu4QYDFjQdLS1P1MyrJNCFZ5JCVGO1ncSvKDtPxhr+PBTQ8Tkntj7szH/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730060126; c=relaxed/simple;
	bh=gi8a+qB0hgf0818SBuVbYjAvc5O/kG13G0Jh1f8UVis=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=j0yhFaHs7TBiPNpJz/4MSSSTh+/7JTtg0OyMh0iG51QqelsPcWTIkBimeLtRseM79/6Oxl3/zr8w69PZaz7Ck2Egu/i2Ce34E/6wPrO+AANnWVq67oo+e6lm+thNQUjiCLcIFkFdO3omqoD8xQCVJgqx8ULexLiuI1t7/oKgYLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PEeRgW/3; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7ede6803585so444080a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 13:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730060124; x=1730664924; darn=vger.kernel.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=N4tEyw4MScQ6/1KM0T2xQJOWBYB6ifsf58BJRWfhinQ=;
        b=PEeRgW/37ZMvN7HFBc8/1RxR2zapPu2GQSANLc5ghCO9iqRwjCtEP8lKj9VfVZGPWh
         g2JwlfjoSQBgN83yz5DNxti7L9s22y3968VOqw9LJUlwbYjNUYlJ3Muk4gr6xKhA5tLy
         s35AK/GARierxcE4sOztSSKlJxZU8nCTL0eJCLENDkXvOy9bd9W/oSTzys+EDvn6T6oE
         Yp0ePqTI9Qib+eOCuHcCXmeyGeEeGDwp98EKBzkJ+5jS7fV7F6VNjgMuxHnv8oMNBY85
         ZoKl5m/1my+PcmHzmine005ACIw2xizCXRgG6WupR3Z9g+yobOe7W5pxRFryrSGJjcIW
         5EJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730060124; x=1730664924;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N4tEyw4MScQ6/1KM0T2xQJOWBYB6ifsf58BJRWfhinQ=;
        b=NISyZSHhKfbpdjYL7yyiP46NwAJAyIaQKEakK9gpKXxWajLZV/aCmg7b8vW1icgKw9
         MQ4WoO5KJxA+euH+/8fAYw0nNyeqeinTcjBV/xVFgD8KoUDJIUxSaj4sjEJlTDG1RF8G
         rvA9jvvnBvdyWv4vqQ7HTeXezoRlvdrn86MgREA/IS6V0XOOh5BPweRoS2+SkT41vT89
         2eEdU7CRKyAe8B0tVuqv+t7BkCTtbc0svc4wnyCMokKcYHaDU6KCYYPUZb/gno1xhKaV
         IgosKu+nJjyJoDR3Dxyr275z6Y4riJh/AjcVHjYxucc+4QxO5GWep36G6dKqU0Qzg0BZ
         zL+w==
X-Forwarded-Encrypted: i=1; AJvYcCWbAxAIUCHOyWuGmg8JqQ08U381WpvpjxMO7vuGj4QAI4EzSkvnjqSubjkDlZOTivlCVlGBd7RToFh75m0=@vger.kernel.org
X-Gm-Message-State: AOJu0YysnBc4DFo7GlFWmb5RJXydf0cYqGK+bPhSwAjzMxCo2/TRj+v4
	Blf1SHKwQ1gDPH72G2sJIauex1nKpLiNcrgFQi2G2A/ab1Om+J+Ij/nQyf0eAg==
X-Google-Smtp-Source: AGHT+IFuajBXTEjfZxgeX70hHYbqnSQ4RILHo5TwtobW0qjDHdOdgvn8GMN9BJnBmzaVyVwmXW8WhA==
X-Received: by 2002:a17:90a:4d87:b0:2e0:7e80:2011 with SMTP id 98e67ed59e1d1-2e77e828515mr18864590a91.16.1730060123662;
        Sun, 27 Oct 2024 13:15:23 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e56f3f8sm7537828a91.40.2024.10.27.13.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 13:15:22 -0700 (PDT)
Date: Sun, 27 Oct 2024 13:14:42 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
cc: Pasha Tatashin <pasha.tatashin@soleen.com>, Yang Shi <shy828301@gmail.com>, 
    Matthew Wilcox <willy@infradead.org>, David Hildenbrand <david@redhat.com>, 
    Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org
Subject: [PATCH] mm: delete the unused put_pages_list()
Message-ID: <d9985d6a-293e-176b-e63d-82fdfd28c139@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

The last user of put_pages_list() converted away from it in 6.10 commit
06c375053cef ("iommu/vt-d: add wrapper functions for page allocations"):
delete put_pages_list().

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 include/linux/mm.h |  2 --
 mm/swap.c          | 31 -------------------------------
 2 files changed, 33 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ecf63d2b0582..8524bf86dd74 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1286,8 +1286,6 @@ static inline struct folio *virt_to_folio(const void *x)
 
 void __folio_put(struct folio *folio);
 
-void put_pages_list(struct list_head *pages);
-
 void split_page(struct page *page, unsigned int order);
 void folio_copy(struct folio *dst, struct folio *src);
 int folio_mc_copy(struct folio *dst, struct folio *src);
diff --git a/mm/swap.c b/mm/swap.c
index b8e3259ea2c4..638a3f001676 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -127,37 +127,6 @@ void __folio_put(struct folio *folio)
 }
 EXPORT_SYMBOL(__folio_put);
 
-/**
- * put_pages_list() - release a list of pages
- * @pages: list of pages threaded on page->lru
- *
- * Release a list of pages which are strung together on page.lru.
- */
-void put_pages_list(struct list_head *pages)
-{
-	struct folio_batch fbatch;
-	struct folio *folio, *next;
-
-	folio_batch_init(&fbatch);
-	list_for_each_entry_safe(folio, next, pages, lru) {
-		if (!folio_put_testzero(folio))
-			continue;
-		if (folio_test_hugetlb(folio)) {
-			free_huge_folio(folio);
-			continue;
-		}
-		/* LRU flag must be clear because it's passed using the lru */
-		if (folio_batch_add(&fbatch, folio) > 0)
-			continue;
-		free_unref_folios(&fbatch);
-	}
-
-	if (fbatch.nr)
-		free_unref_folios(&fbatch);
-	INIT_LIST_HEAD(pages);
-}
-EXPORT_SYMBOL(put_pages_list);
-
 typedef void (*move_fn_t)(struct lruvec *lruvec, struct folio *folio);
 
 static void lru_add(struct lruvec *lruvec, struct folio *folio)
-- 
2.35.3

