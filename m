Return-Path: <linux-kernel+bounces-210357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4719042C6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 19:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE7852826D4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 17:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3737D55E5B;
	Tue, 11 Jun 2024 17:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LQBQ3G5G"
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B519A2570
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 17:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718128312; cv=none; b=kqkm0cq3I/mfThIvFT5aup9s5+VLtFERBwiiYlqQEHrcTjX7Kk2Bexwz9GEt9970vboBY9nvOohAo7jGbymyMhN6zd6986Qebv3i8HBU1pPa+1wMUFyceyqvlCHpvN1gM79CPpVL+bEfTKx5DebU2EQ5CExcPYNCcidq2lih7mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718128312; c=relaxed/simple;
	bh=6q4EMTPOffxuSPTMuJ5rzPX8KYqgMr33SytOBvfIn4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=czy+rcgbsO1N4bRgXnqOl7HkwpSBx/GIA2FvGANtBt4v9ptLlPjsrRkaBI+YlSJUdXrgaJ/AE3J9U5ppjJk2aOXR5KWg+KCSTJOyJFksfjf81aFzNswQ7iS5be1kZzYHHA0+8vYZXjYgFquwHKavqhYX17sYL0PZUYYnvs7mUDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LQBQ3G5G; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-80b7699abcaso1120088241.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 10:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718128309; x=1718733109; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AgOOvOxwqfeCMq6yLdCzK4I4GbZLJXDhNrH/6ViA8nM=;
        b=LQBQ3G5G40P494sOqloisM7Yd+M1ua45pfo4uhRPeynJGPUSzDZKp3gqJHg4G8ceaF
         P8aGwqZ1HdgdSd26aOi9YEc9hANVH7yqmWpSCrwDB8TXAC/AvZ19/VCMUtJ1ZPwzrLBj
         9wqGsPZol26/M7rx5TjcmQd2lDQNYFhvAtjEL3vRfXNf49LWhYN5B56jm1a8qbWhjNqi
         sA/YUa0PWsqt/9r315B5DW+zAafjJLNl26M0w46pnEvF4mY6CaSl6AN2af3DGSEQ38oV
         moPyvcemd+eL51VqoggHxQVPR/kqfLq8nC6ZAThjliUy2ClwGrfRWrugpNxCeOJgJUAa
         HScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718128309; x=1718733109;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AgOOvOxwqfeCMq6yLdCzK4I4GbZLJXDhNrH/6ViA8nM=;
        b=C09B4p2ynehy8K1evA1WVsp47CYrKYUc7FcKmgNEXuGB7Dlw1YWpydTY9tX4kR6pdD
         XKkeNisFGAybn+aykWI2XWtfemR5G8ybuI0Qvci2Tky+5MmiEyD30pKCh0VB5wOCbuB3
         x/j5VmbunHpRt0km6nLcQ9vD5WTUZzDdz1MOb5gBYX8C9jVuUmwL1Iz83Qq+pfWDoK1J
         wyT6xnESEfpa+SAQHf+LhM2qAWHKISmu2FED8sF0FUjxWsZ9z3MrhdLkhoETVa6IhJOw
         sNO8L5X3QS2RCZ0HXQkKAVyvNj0QHPrLW76Dey18uKWSZkJIeLTrpKxl2BS4OHg+FgQ7
         XPaw==
X-Forwarded-Encrypted: i=1; AJvYcCVfuyvTqY6DSjFnkcEcbjQMqCRjs15AXn6dTeyh//NsvIUUJTKcqv5C/mCs68jzKeHoYLOmYIf+cMZVJiZF/nnGqBrfQdnehmhoGUd9
X-Gm-Message-State: AOJu0Yz0gjMj3Ok3sHyMm0Pk5N9o6BifTPZSCNAwJhBJsfoOvMI2Muqa
	FE7rBY6/LSbvmjwWGBApCC/3MP9ncqP3MoyXvps9mtk24RVUm6mJrDrPzEs4JNEjpgDoWzbsQoW
	QYCNUglLiXsTe/pmDrbtEZIE1dg+ebC9WCpre
X-Google-Smtp-Source: AGHT+IFW69M4nfsYi29M3zBfyivmaOCONNrtXO/Vdnq3OjZCVVh12iV0VLVWjulmWfiQpP23Fs8hLe/yAlGcfs44q6o=
X-Received: by 2002:a05:6102:833:b0:48d:8c7f:551a with SMTP id
 ada2fe7eead31-48d8dbdc025mr1300935137.21.1718128309441; Tue, 11 Jun 2024
 10:51:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610121820.328876-1-usamaarif642@gmail.com>
 <20240610121820.328876-2-usamaarif642@gmail.com> <CAJD7tkbpXjg00CRSrXU_pbaHwEaW1b3k8AQgu8y2PAh7EkTOug@mail.gmail.com>
 <d822ec8b-3b7d-4e5c-ac96-b6fda63da5d4@gmail.com> <CAJD7tkZoaM=dWim7GPqEERDZyxp3PqMNctzXQCPDMO=8kQSwfw@mail.gmail.com>
 <9ddfe544-636d-4638-ae0e-053674e47322@gmail.com> <CAJD7tkY0F-Tczq4j861HxKATzEOfkVv=76m8zFcJHuh8E3VMEw@mail.gmail.com>
 <08ea43f2-13d2-4b27-ae62-42cebc185c7b@gmail.com>
In-Reply-To: <08ea43f2-13d2-4b27-ae62-42cebc185c7b@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 11 Jun 2024 10:51:08 -0700
Message-ID: <CAJD7tkZC8e8ZTBSOGZH-1srTeC=jqxwWchd-BjvNsV2FR0oT8Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mm: store zero pages to be swapped out in a bitmap
To: Usama Arif <usamaarif642@gmail.com>
Cc: 21cnbao@gmail.com, akpm@linux-foundation.org, hannes@cmpxchg.org, 
	david@redhat.com, ying.huang@intel.com, hughd@google.com, willy@infradead.org, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	Shakeel Butt <shakeel.butt@linux.dev>
Content-Type: text/plain; charset="UTF-8"

[..]
> >> I think its better to handle this in Barrys patch. I feel this series is
> >> close to its final state, i.e. the only diff I have for the next
> >> revision is below to remove start/end_writeback for zer_filled case. I
> >> will comment on Barrys patch once the I send out the next revision of this.
> > Sorry I did not make myself clearer. I did not mean that you should
> > handle the large folio swapin here. This needs to be handled at a
> > higher level because as you mentioned, a large folio may be partially
> > in the zeromap, zswap, swapcache, disk, etc.
> >
> > What I meant is that we should probably have a debug check to make
> > sure this doesn't go unhandled. For zswap, I am trying to add a
> > warning and fail the swapin operation if a large folio slips through
> > to zswap. We can do something similar here if folks agree this is the
> > right way in the interim:
> > https://lore.kernel.org/lkml/20240611024516.1375191-3-yosryahmed@google.com/.
> >
> > Maybe I am too paranoid, but I think it's easy to mess up these things
> > when working on large folio swapin imo.
>
> So there is a difference between zswap and this optimization. In this
> optimization, if the zeromap is set for all the folio bits, then we
> should do large folio swapin. There still needs to be a change in Barrys
> patch in alloc_swap_folio, but apart from that does the below diff over
> v3 make it better? I will send a v4 with this if it sounds good.
>
>
> diff --git a/mm/page_io.c b/mm/page_io.c
> index 6400be6e4291..bf01364748a9 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -234,18 +234,24 @@ static void swap_zeromap_folio_clear(struct folio
> *folio)
>          }
>   }
>
> -static bool swap_zeromap_folio_test(struct folio *folio)
> +/*
> + * Return the index of the first subpage which is not zero-filled
> + * according to swap_info_struct->zeromap.
> + * If all pages are zero-filled according to zeromap, it will return
> + * folio_nr_pages(folio).
> + */
> +static long swap_zeromap_folio_test(struct folio *folio)
>   {
>          struct swap_info_struct *sis = swp_swap_info(folio->swap);
>          swp_entry_t entry;
> -       unsigned int i;
> +       long i;

Why long?

>
>          for (i = 0; i < folio_nr_pages(folio); i++) {
>                  entry = page_swap_entry(folio_page(folio, i));
>                  if (!test_bit(swp_offset(entry), sis->zeromap))
> -                       return false;
> +                       return i;
>          }
> -       return true;
> +       return i;
>   }
>
>   /*
> @@ -581,6 +587,7 @@ void swap_read_folio(struct folio *folio, bool
> synchronous,
>   {
>          struct swap_info_struct *sis = swp_swap_info(folio->swap);
>          bool workingset = folio_test_workingset(folio);
> +       long first_non_zero_page_idx;
>          unsigned long pflags;
>          bool in_thrashing;
>
> @@ -598,10 +605,19 @@ void swap_read_folio(struct folio *folio, bool
> synchronous,
>                  psi_memstall_enter(&pflags);
>          }
>          delayacct_swapin_start();
> -       if (swap_zeromap_folio_test(folio)) {
> +       first_non_zero_page_idx = swap_zeromap_folio_test(folio);
> +       if (first_non_zero_page_idx == folio_nr_pages(folio)) {
>                  folio_zero_fill(folio);
>                  folio_mark_uptodate(folio);
>                  folio_unlock(folio);
> +       } else if (first_non_zero_page_idx != 0) {
> +               /*
> +                * The case for when only *some* of subpages being
> swapped-in were recorded
> +                * in sis->zeromap, while the rest are in zswap/disk is
> currently not handled.
> +                * WARN in this case and return without marking the
> folio uptodate so that
> +                * an IO error is emitted (e.g. do_swap_page() will sigbus).
> +                */
> +                WARN_ON_ONCE(1);
>          } else if (zswap_load(folio)) {
>                  folio_mark_uptodate(folio);
>                  folio_unlock(folio);
>
>

This is too much noise for swap_read_folio(). How about adding
swap_read_folio_zeromap() that takes care of this and decides whether
or not to call folio_mark_uptodate()?

-static bool swap_zeromap_folio_test(struct folio *folio)
+/*
+ * Return the index of the first subpage which is not zero-filled according to
+ * swap_info_struct->zeromap.  If all pages are zero-filled according to
+ * zeromap, it will return folio_nr_pages(folio).
+ */
+static unsigned int swap_zeromap_folio_test(struct folio *folio)
 {
        struct swap_info_struct *sis = swp_swap_info(folio->swap);
        swp_entry_t entry;
@@ -243,9 +248,9 @@ static bool swap_zeromap_folio_test(struct folio *folio)
        for (i = 0; i < folio_nr_pages(folio); i++) {
                entry = page_swap_entry(folio_page(folio, i));
                if (!test_bit(swp_offset(entry), sis->zeromap))
-                       return false;
+                       return i;
        }
-       return true;
+       return i;
 }

 /*
@@ -511,6 +516,25 @@ static void sio_read_complete(struct kiocb *iocb, long ret)
        mempool_free(sio, sio_pool);
 }

+static bool swap_read_folio_zeromap(struct folio *folio)
+{
+       unsigned int idx = swap_zeromap_folio_test(folio);
+
+       if (idx == 0)
+               return false;
+
+       /*
+        * Swapping in a large folio that is partially in the zeromap is not
+        * currently handled. Return true without marking the folio uptodate so
+        * that an IO error is emitted (e.g.  do_swap_page() will sigbus).
+        */
+       if (WARN_ON_ONCE(idx < folio_nr_pages(folio)))
+               return true;
+
+       folio_zero_fill(folio);
+       folio_mark_uptodate(folio);
+       return true
+}
+
 static void swap_read_folio_fs(struct folio *folio, struct swap_iocb **plug)
 {
        struct swap_info_struct *sis = swp_swap_info(folio->swap);
@@ -600,9 +624,7 @@ void swap_read_folio(struct folio *folio, bool synchronous,
                psi_memstall_enter(&pflags);
        }
        delayacct_swapin_start();
-       if (swap_zeromap_folio_test(folio)) {
-               folio_zero_fill(folio);
-               folio_mark_uptodate(folio);
+       if (swap_read_folio_zeromap(folio)) {
                folio_unlock(folio);
        } else if (zswap_load(folio)) {
                folio_mark_uptodate(folio);

