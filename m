Return-Path: <linux-kernel+bounces-319513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF8A96FDA6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 23:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 664F5B221F5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 21:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF7D1598EE;
	Fri,  6 Sep 2024 21:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMZhPJNI"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E411B85FB
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 21:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725659939; cv=none; b=Qt7w6kKQJOuWw4ufPRxz93h+9eWwDofJwGCdeGOWE3W6tG4e9qdW5wc03+A8N/U5vDwExz2scFaZZeWBjjQCP8lAJ3RNcmtoUvcPJkf5skO39h+Fi5YyCoxFzh65cReTukcZR8ONmtR63dUhoo1Nq05/shyCbuIDwejxGTl2bEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725659939; c=relaxed/simple;
	bh=bGFr/gLVsR2qu+CTrr8Tyg8CA/jtOfFPtkp96DQdnJk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NOlgp0QOCj2EADbMYGYzbsvEK9iQ6RfPl396muDxxZUhMl9U5GqSQ8vYq+UGIfB74OphPeCOKEsV8z9VK9CHAKLFopLR3/HDzjUODBV3B0vIutXumzfEsKhFChmp4JrHEdbHEZ5vIV99PHmF52+PJwMwh0dbP+pUviYuHI5sgSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PMZhPJNI; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-718816be6cbso1426749b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 14:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725659937; x=1726264737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fFjzAfcWlZGdLMpuzA2ujYuM7IQsh3EHmDmz8Nw4EAk=;
        b=PMZhPJNI8sETMQxmp2ENv4ZXnQROPoe94RIDNaoG5vYBrvNHu4pJ7WgCTR4e6vWcYI
         tKcxOIGmeM4abgQPqxBlgSEralWPluLNTfMYJjYP4Z/lZWEl5HwTe7fb6mfdslT/CEQa
         iLyMdeNaACL61GK6LkW0vjTeKftvgkl0OfpiDD4OA+dD/Y9vUgmUz4wu9uVyOWNeu849
         OM29rMdNufC45xGeA3ng+OZgo0CU5+QlZzFKlxl78TqCP/ULEaXG1/QFE+cJ0xgVKNdi
         Nirn1OASQdm7J67X/xKsKPgkfvTwUQ3cM/yqZYj1OmDtejnf8NmCAZtVatwxIkYrDWnA
         zNrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725659937; x=1726264737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fFjzAfcWlZGdLMpuzA2ujYuM7IQsh3EHmDmz8Nw4EAk=;
        b=XmBZ06AoqSmIPX7B+Rtpo9VU+qoWRoZtcd51XlROnoZWgAmcqsjSy+0LrLa9kSiVdv
         6ojgofRfntDKgCUsjq3sauB0JrMsyxxfEf3bNHgry+j6QET4X7N1kZP76yL99CnCZjxX
         J/GMnf7PLMHQexvOYUlhAKDhKQQv8GuhAqpCtZN4CAh0jRvWaXOGhBj9hSWMEr4xE2Of
         evZAdzVuy9ixq78OwnFn5LAsdxCa7hngOrEBgd6MK7ltqEKXnIJNFDyiCgrzoSBZPCqF
         3wres3uZVtpHhHojErtFo+znzA5upIwgpO4iG5X2CMtfxoIQAk+yor3xof+mPYUk5lSt
         c4RA==
X-Forwarded-Encrypted: i=1; AJvYcCVAgjyPOmByG5zZa/QP2UQzZi54TfQKBWyOUqSca3HqNMkGv5Trzrjw2QFFsI0gKbque+m1sVGf+fIwS1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW0pdeBdWmZXONr5ZKo1Qnluzq0vhpzNmRbQzd9x7UQUEIQAwH
	dF6ljFV+WADwz6lha0XFVA5/Hfb+wdztyjapIxPDqhrHBretIC39
X-Google-Smtp-Source: AGHT+IGUtSJX3ipBuRp9WBTDy3e7+ahjOPjujOomQp1mfFxRuQsnbQauT+2gnJ0gJeWh/ZyqvG9yAQ==
X-Received: by 2002:a05:6a20:d524:b0:1ce:d483:fc4d with SMTP id adf61e73a8af0-1cf2acd74eemr496435637.32.1725659937003;
        Fri, 06 Sep 2024 14:58:57 -0700 (PDT)
Received: from Barrys-MBP.hub ([2407:7000:8942:5500:f164:3736:44c7:42e5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7178b5660adsm3456275b3a.89.2024.09.06.14.58.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Sep 2024 14:58:56 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: yosryahmed@google.com
Cc: 21cnbao@gmail.com,
	akpm@linux-foundation.org,
	baolin.wang@linux.alibaba.com,
	chrisl@kernel.org,
	david@redhat.com,
	hanchuanhua@oppo.com,
	hannes@cmpxchg.org,
	hch@infradead.org,
	hughd@google.com,
	kaleshsingh@google.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mhocko@suse.com,
	minchan@kernel.org,
	nphamcs@gmail.com,
	ryan.roberts@arm.com,
	ryncsn@gmail.com,
	senozhatsky@chromium.org,
	shakeel.butt@linux.dev,
	shy828301@gmail.com,
	surenb@google.com,
	usamaarif642@gmail.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	xiang@kernel.org,
	ying.huang@intel.com
Subject: Re: [PATCH v8 1/3] mm: Fix swap_read_folio_zeromap() for large folios with partial zeromap
Date: Sat,  7 Sep 2024 09:58:42 +1200
Message-Id: <20240906215842.1603-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <CAJD7tkb43Of7d0mv4XTRmsRJm3_8LcnvhAnJDiRF6d7+ZQaNNw@mail.gmail.com>
References: <CAJD7tkb43Of7d0mv4XTRmsRJm3_8LcnvhAnJDiRF6d7+ZQaNNw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, Sep 7, 2024 at 6:32 AM Yosry Ahmed <yosryahmed@google.com> wrote:
>
> On Thu, Sep 5, 2024 at 5:11 PM Barry Song <21cnbao@gmail.com> wrote:
> >
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > There could be a corner case where the first entry is non-zeromap,
> > but a subsequent entry is zeromap. In this case, we should not
> > let swap_read_folio_zeromap() return false since we will still
> > read corrupted data.
> >
> > Additionally, the iteration of test_bit() is unnecessary and
> > can be replaced with bitmap operations, which are more efficient.
> >
> > We can adopt the style of swap_pte_batch() and folio_pte_batch() to
> > introduce swap_zeromap_batch() which seems to provide the greatest
> > flexibility for the caller. This approach allows the caller to either
> > check if the zeromap status of all entries is consistent or determine
> > the number of contiguous entries with the same status.
> >
> > Since swap_read_folio() can't handle reading a large folio that's
> > partially zeromap and partially non-zeromap, we've moved the code
> > to mm/swap.h so that others, like those working on swap-in, can
> > access it.
> >
> > Fixes: 0ca0c24e3211 ("mm: store zero pages to be swapped out in a bitmap")
> > Cc: Usama Arif <usamaarif642@gmail.com>
> > Cc: Yosry Ahmed <yosryahmed@google.com>
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >  mm/page_io.c | 32 +++++++-------------------------
> >  mm/swap.h    | 33 +++++++++++++++++++++++++++++++++
> >  2 files changed, 40 insertions(+), 25 deletions(-)
> >
> > diff --git a/mm/page_io.c b/mm/page_io.c
> > index 4bc77d1c6bfa..2dfe2273a1f1 100644
> > --- a/mm/page_io.c
> > +++ b/mm/page_io.c
> > @@ -226,26 +226,6 @@ static void swap_zeromap_folio_clear(struct folio *folio)
> >         }
> >  }
> >
> > -/*
> > - * Return the index of the first subpage which is not zero-filled
> > - * according to swap_info_struct->zeromap.
> > - * If all pages are zero-filled according to zeromap, it will return
> > - * folio_nr_pages(folio).
> > - */
> > -static unsigned int swap_zeromap_folio_test(struct folio *folio)
> > -{
> > -       struct swap_info_struct *sis = swp_swap_info(folio->swap);
> > -       swp_entry_t entry;
> > -       unsigned int i;
> > -
> > -       for (i = 0; i < folio_nr_pages(folio); i++) {
> > -               entry = page_swap_entry(folio_page(folio, i));
> > -               if (!test_bit(swp_offset(entry), sis->zeromap))
> > -                       return i;
> > -       }
> > -       return i;
> > -}
> > -
> >  /*
> >   * We may have stale swap cache pages in memory: notice
> >   * them here and get rid of the unnecessary final write.
> > @@ -524,19 +504,21 @@ static void sio_read_complete(struct kiocb *iocb, long ret)
> >
> >  static bool swap_read_folio_zeromap(struct folio *folio)
> >  {
> > -       unsigned int idx = swap_zeromap_folio_test(folio);
> > -
> > -       if (idx == 0)
> > -               return false;
> > +       int nr_pages = folio_nr_pages(folio);
> > +       bool is_zeromap;
> > +       int nr_zeromap = swap_zeromap_batch(folio->swap, nr_pages, &is_zeromap);
>
> swap_zeromap_batch() reads to me like the number of entries that are
> in the zeromap (i.e. bits are set), not the number of contiguous equal
> bits. I can't think of a better name though :/

We now have swap_pte_batch() and folio_pte_batch(), both of which return the number
of entries sharing the same attribute as the first entry. These functions are frequently used
in the memory management code with conditions like if (swap_pte_batch() != nr) and
if (folio_pte_batch() != nr). Given this, it seems we could adopt a consistent approach
for handling entries in the same manner as the first one :-)

>
> The local variable is not adding much value here either. It's
> reinforcing the misunderstanding I point out above, if anything. You
> can just drop that.
>
well, I feel I can remove this local variable by:

diff --git a/mm/page_io.c b/mm/page_io.c
index 2dfe2273a1f1..bc1183299a7d 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -506,14 +506,14 @@ static bool swap_read_folio_zeromap(struct folio *folio)
 {
 	int nr_pages = folio_nr_pages(folio);
 	bool is_zeromap;
-	int nr_zeromap = swap_zeromap_batch(folio->swap, nr_pages, &is_zeromap);
 
 	/*
 	 * Swapping in a large folio that is partially in the zeromap is not
 	 * currently handled. Return true without marking the folio uptodate so
 	 * that an IO error is emitted (e.g. do_swap_page() will sigbus).
 	 */
-	if (WARN_ON_ONCE(nr_zeromap != nr_pages))
+	if (WARN_ON_ONCE(swap_zeromap_batch(folio->swap, nr_pages,
+			&is_zeromap) != nr_pages))
 		return true;
 
 	if (!is_zeromap)

> >
> >         /*
> >          * Swapping in a large folio that is partially in the zeromap is not
> >          * currently handled. Return true without marking the folio uptodate so
> >          * that an IO error is emitted (e.g. do_swap_page() will sigbus).
> >          */
> > -       if (WARN_ON_ONCE(idx < folio_nr_pages(folio)))
> > +       if (WARN_ON_ONCE(nr_zeromap != nr_pages))
> >                 return true;
> >
> > +       if (!is_zeromap)
> > +               return false;
> > +
> >         folio_zero_range(folio, 0, folio_size(folio));
> >         folio_mark_uptodate(folio);
> >         return true;
> > diff --git a/mm/swap.h b/mm/swap.h
> > index f8711ff82f84..1cc56a02fb5f 100644
> > --- a/mm/swap.h
> > +++ b/mm/swap.h
> > @@ -80,6 +80,32 @@ static inline unsigned int folio_swap_flags(struct folio *folio)
> >  {
> >         return swp_swap_info(folio->swap)->flags;
> >  }
> > +
> > +/*
> > + * Return the count of contiguous swap entries that share the same
> > + * zeromap status as the starting entry. If is_zeromap is not NULL,
> > + * it will return the zeromap status of the starting entry.
> > + */
> > +static inline int swap_zeromap_batch(swp_entry_t entry, int max_nr,
> > +               bool *is_zeromap)
> > +{
> > +       struct swap_info_struct *sis = swp_swap_info(entry);
> > +       unsigned long start = swp_offset(entry);
> > +       unsigned long end = start + max_nr;
> > +       bool start_entry_zeromap;
> > +
> > +       start_entry_zeromap = test_bit(start, sis->zeromap);
>
> first_bit is probably a better name.
>

yep, might be. I am glad to rename if it makes the code easier to understand:

diff --git a/mm/swap.h b/mm/swap.h
index 1cc56a02fb5f..e0397a197620 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -92,15 +92,15 @@ static inline int swap_zeromap_batch(swp_entry_t entry, int max_nr,
 	struct swap_info_struct *sis = swp_swap_info(entry);
 	unsigned long start = swp_offset(entry);
 	unsigned long end = start + max_nr;
-	bool start_entry_zeromap;
+	bool first_bit;
 
-	start_entry_zeromap = test_bit(start, sis->zeromap);
-	if (is_zeromap)
-		*is_zeromap = start_entry_zeromap;
+	first_bit = test_bit(start, sis->zeromap);
+	if (is_zeromap)
+		*is_zeromap = first_bit;
 
 	if (max_nr <= 1)
 		return max_nr;
-	if (start_entry_zeromap)
+	if (first_bit)
 		return find_next_zero_bit(sis->zeromap, end, start) - start;
 	else
 		return find_next_bit(sis->zeromap, end, start) - start;

> > +       if (is_zeromap)
> > +               *is_zeromap = start_entry_zeromap;
> > +
> > +       if (max_nr <= 1)
> > +               return max_nr;
> > +       if (start_entry_zeromap)
> > +               return find_next_zero_bit(sis->zeromap, end, start) - start;
> > +       else
> > +               return find_next_bit(sis->zeromap, end, start) - start;
>
> The usage of these functions look correct to me, although
> FIND_NEXT_BIT is not really easy for me to parse :)

Yep :-) with the above two changes, the patch becomes:

From 272c04cb758b8062eaa96a52b855ff79c8afdf6a Mon Sep 17 00:00:00 2001
From: Barry Song <v-songbaohua@oppo.com>
Date: Thu, 5 Sep 2024 11:56:03 +1200
Subject: [PATCH v8 1/3] mm: Fix swap_read_folio_zeromap() for large folios
 with partial zeromap

There could be a corner case where the first entry is non-zeromap,
but a subsequent entry is zeromap. In this case, we should not
let swap_read_folio_zeromap() return false since we will still
read corrupted data.

Additionally, the iteration of test_bit() is unnecessary and
can be replaced with bitmap operations, which are more efficient.

We can adopt the style of swap_pte_batch() and folio_pte_batch() to
introduce swap_zeromap_batch() which seems to provide the greatest
flexibility for the caller. This approach allows the caller to either
check if the zeromap status of all entries is consistent or determine
the number of contiguous entries with the same status.

Since swap_read_folio() can't handle reading a large folio that's
partially zeromap and partially non-zeromap, we've moved the code
to mm/swap.h so that others, like those working on swap-in, can
access it.

Fixes: 0ca0c24e3211 ("mm: store zero pages to be swapped out in a bitmap")
Cc: Usama Arif <usamaarif642@gmail.com>
Cc: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 mm/page_io.c | 32 +++++++-------------------------
 mm/swap.h    | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 25 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index 4bc77d1c6bfa..bc1183299a7d 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -226,26 +226,6 @@ static void swap_zeromap_folio_clear(struct folio *folio)
 	}
 }
 
-/*
- * Return the index of the first subpage which is not zero-filled
- * according to swap_info_struct->zeromap.
- * If all pages are zero-filled according to zeromap, it will return
- * folio_nr_pages(folio).
- */
-static unsigned int swap_zeromap_folio_test(struct folio *folio)
-{
-	struct swap_info_struct *sis = swp_swap_info(folio->swap);
-	swp_entry_t entry;
-	unsigned int i;
-
-	for (i = 0; i < folio_nr_pages(folio); i++) {
-		entry = page_swap_entry(folio_page(folio, i));
-		if (!test_bit(swp_offset(entry), sis->zeromap))
-			return i;
-	}
-	return i;
-}
-
 /*
  * We may have stale swap cache pages in memory: notice
  * them here and get rid of the unnecessary final write.
@@ -524,19 +504,21 @@ static void sio_read_complete(struct kiocb *iocb, long ret)
 
 static bool swap_read_folio_zeromap(struct folio *folio)
 {
-	unsigned int idx = swap_zeromap_folio_test(folio);
-
-	if (idx == 0)
-		return false;
+	int nr_pages = folio_nr_pages(folio);
+	bool is_zeromap;
 
 	/*
 	 * Swapping in a large folio that is partially in the zeromap is not
 	 * currently handled. Return true without marking the folio uptodate so
 	 * that an IO error is emitted (e.g. do_swap_page() will sigbus).
 	 */
-	if (WARN_ON_ONCE(idx < folio_nr_pages(folio)))
+	if (WARN_ON_ONCE(swap_zeromap_batch(folio->swap, nr_pages,
+			&is_zeromap) != nr_pages))
 		return true;
 
+	if (!is_zeromap)
+		return false;
+
 	folio_zero_range(folio, 0, folio_size(folio));
 	folio_mark_uptodate(folio);
 	return true;
diff --git a/mm/swap.h b/mm/swap.h
index f8711ff82f84..e0397a197620 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -80,6 +80,32 @@ static inline unsigned int folio_swap_flags(struct folio *folio)
 {
 	return swp_swap_info(folio->swap)->flags;
 }
+
+/*
+ * Return the count of contiguous swap entries that share the same
+ * zeromap status as the starting entry. If is_zeromap is not NULL,
+ * it will return the zeromap status of the starting entry.
+ */
+static inline int swap_zeromap_batch(swp_entry_t entry, int max_nr,
+		bool *is_zeromap)
+{
+	struct swap_info_struct *sis = swp_swap_info(entry);
+	unsigned long start = swp_offset(entry);
+	unsigned long end = start + max_nr;
+	bool first_bit;
+
+	first_bit = test_bit(start, sis->zeromap);
+	if (is_zeromap)
+		*is_zeromap = first_bit;
+
+	if (max_nr <= 1)
+		return max_nr;
+	if (first_bit)
+		return find_next_zero_bit(sis->zeromap, end, start) - start;
+	else
+		return find_next_bit(sis->zeromap, end, start) - start;
+}
+
 #else /* CONFIG_SWAP */
 struct swap_iocb;
 static inline void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
@@ -171,6 +197,13 @@ static inline unsigned int folio_swap_flags(struct folio *folio)
 {
 	return 0;
 }
+
+static inline int swap_zeromap_batch(swp_entry_t entry, int max_nr,
+		bool *has_zeromap)
+{
+	return 0;
+}
+
 #endif /* CONFIG_SWAP */
 
 #endif /* _MM_SWAP_H */
-- 
2.34.1

Thanks
Barry


