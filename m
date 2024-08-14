Return-Path: <linux-kernel+bounces-287300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9145C95261A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 01:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48856284280
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 23:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F3F152E02;
	Wed, 14 Aug 2024 23:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4Q/7ID2"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB84914B092;
	Wed, 14 Aug 2024 23:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723676755; cv=none; b=AuO9/1JFUUy80jrfHlgeF8muEqdrFhQI+oVO81vVwhvXMLS2rK5Z/OWwKKI7uO2BWOgnX7jqzZwlt4KkviaARTnq01za5wwR+GnoC5UQEi5fS1WOk2eJvJmYAl/lcO39fdZKfxVunjw0oEwIY3xBDx9JcAQbBIiIDVfrACOw1PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723676755; c=relaxed/simple;
	bh=C25yuGKLZ8Seb4BM6GltHOq7tViFeGcDxh2xDFtbdLg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KeQsuE9C3lmXO+wzOxJWVAIPueDPM/IJoK1nTdW2m5dSniAsqFdqZWOAQgllQ3f+q2WsCz98IULV8GP3IfuyGj3WU5C1t810Z57mZs46p8L06YzVQkCZGxU7S2JG6JCGw++hF8UV0Db5GsuVnL3k3iM+FnC8f/9cXFgcX5NSYL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c4Q/7ID2; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7c3ebba7fbbso353347a12.1;
        Wed, 14 Aug 2024 16:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723676753; x=1724281553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mYxTfjyRpR/7rH4HqiHRBcUKt/StR011Utyi06+DQ3M=;
        b=c4Q/7ID25zbYT3rrE8UdnqBx88EbPhxOyHIP4VgeAGI3m266Ly6TXjyEjVFaPXTkhp
         8tNAz5XbcqUTqwc5+KnvtZen5hTQTYl/Tt3Pt0whTQCkPAVlZE0Icf11Lnu8Z2PKXsIx
         +EUcchv1hQznZ2ugrrw/jCZcBtM3YG2Z1ylkNWufbkqUGnpPD7y4XqKNu65UAFXBACLe
         /7fR1c5oyN6wW2g54JK/N4/tkOnA+uEMjvvyEF1YiniaTXwYH8Lk+vqiXRQRfjrjiTQd
         u/+AG4Vlrm899bp8UREYK+fhmLWOcmNf0IJj8KoDvzVkH8hmfWVW2+MTMFffUwg7Ql3y
         PTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723676753; x=1724281553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mYxTfjyRpR/7rH4HqiHRBcUKt/StR011Utyi06+DQ3M=;
        b=Jg2cpfIEYY4Xqdokuys/AzuBt88QslvxwDRucTY+KJQw8WOHK5yH7qigsTxV0xc8ap
         qApxCDXottiwpQbguuhLhh8FmLwCRD5+pgyLTJmp6ov9sdQdLE94xGT7q+EZzUZp4tHK
         0S6iJzbeAgIHfzOIdvPoj0EnYxwcJ6eP1vqkTFSQv7ltqiwGCbcP0Qa5v5falhCIlzj1
         pSVVex0WO9CrMjrN6NEz89NaOIpEwE9vBN4kn0ZmJ829zTLEE3KJ1gRMeskwfYOjDiCf
         mdlWOL8iB4xOLOkO4n3edgF9qV2laC9fYf1+x/TtRAy5p+rbrdHM8pr5ZQk/RUlikYfN
         lI8w==
X-Forwarded-Encrypted: i=1; AJvYcCUNQemueunwtkbzUomISKMFqAJQv+fUYePSs5EG4BAqO1hyPLTRwoUCLDDbe2OSTNAFEyKG5S2DuiTFGBfI4fK8M3G9f2grNsCA5Xuc6RWPKmofl4THQ250fONjnRMZ0/Oj+nO0f8O4
X-Gm-Message-State: AOJu0YxQvk/jKAqjpYHv8qFPJLxCUERWRwMI+MLnwsIqw6zPDu/7ETVj
	xwqqQTgOXxqT4HrcueJ3HD47F1FEUCCrVEyahjXz7Gq7at+vg0vH
X-Google-Smtp-Source: AGHT+IE49zC2YaWLxpj0vloyoaA+nYSez/aYHKFx2zeZYok2DEgoCeeZkMf7aExA+uQ+h7v+WXULiA==
X-Received: by 2002:a17:90a:6881:b0:2c9:6d8:d823 with SMTP id 98e67ed59e1d1-2d3aaa7ab9bmr5477821a91.1.1723676752872;
        Wed, 14 Aug 2024 16:05:52 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3ac855073sm2326640a91.54.2024.08.14.16.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 16:05:52 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: usamaarif642@gmail.com
Cc: akpm@linux-foundation.org,
	baohua@kernel.org,
	cerasuolodomenico@gmail.com,
	corbet@lwn.net,
	david@redhat.com,
	hannes@cmpxchg.org,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	riel@surriel.com,
	roman.gushchin@linux.dev,
	rppt@kernel.org,
	ryan.roberts@arm.com,
	shakeel.butt@linux.dev,
	willy@infradead.org,
	yuzhao@google.com
Subject: Re: [PATCH v3 4/6] mm: Introduce a pageflag for partially mapped folios
Date: Thu, 15 Aug 2024 11:05:33 +1200
Message-Id: <20240814230533.54938-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <88d411c5-6d66-4d41-ae86-e0f943e5fb91@gmail.com>
References: <88d411c5-6d66-4d41-ae86-e0f943e5fb91@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Thu, Aug 15, 2024 at 12:37 AM Usama Arif <usamaarif642@gmail.com> wrote:
[snip]
> >>>>
> >>>> -void deferred_split_folio(struct folio *folio)
> >>>> +void deferred_split_folio(struct folio *folio, bool partially_mapped)
> >>>>  {
> >>>>         struct deferred_split *ds_queue = get_deferred_split_queue(folio);
> >>>>  #ifdef CONFIG_MEMCG
> >>>> @@ -3485,14 +3487,17 @@ void deferred_split_folio(struct folio *folio)
> >>>>         if (folio_test_swapcache(folio))
> >>>>                 return;
> >>>>
> >>>> -       if (!list_empty(&folio->_deferred_list))
> >>>> -               return;
> >>>> -
> >>>>         spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
> >>>> +       if (partially_mapped)
> >>>> +               folio_set_partially_mapped(folio);
> >>>> +       else
> >>>> +               folio_clear_partially_mapped(folio);
> >>>>         if (list_empty(&folio->_deferred_list)) {
> >>>> -               if (folio_test_pmd_mappable(folio))
> >>>> -                       count_vm_event(THP_DEFERRED_SPLIT_PAGE);
> >>>> -               count_mthp_stat(folio_order(folio), MTHP_STAT_SPLIT_DEFERRED);
> >>>> +               if (partially_mapped) {
> >>>> +                       if (folio_test_pmd_mappable(folio))
> >>>> +                               count_vm_event(THP_DEFERRED_SPLIT_PAGE);
> >>>> +                       count_mthp_stat(folio_order(folio), MTHP_STAT_SPLIT_DEFERRED);
> >>>
> >>> This code completely broke MTHP_STAT_SPLIT_DEFERRED for PMD_ORDER. It
> >>> added the folio to the deferred_list as entirely_mapped
> >>> (partially_mapped == false).
> >>> However, when partially_mapped becomes true, there's no opportunity to
> >>> add it again
> >>> as it has been there on the list. Are you consistently seeing the counter for
> >>> PMD_ORDER as 0?
> >>>
> >>
> >> Ah I see it, this should fix it?
> >>
> >> -void deferred_split_folio(struct folio *folio)
> >> +/* partially_mapped=false won't clear PG_partially_mapped folio flag */
> >> +void deferred_split_folio(struct folio *folio, bool partially_mapped)
> >>  {
> >>         struct deferred_split *ds_queue = get_deferred_split_queue(folio);
> >>  #ifdef CONFIG_MEMCG
> >> @@ -3485,14 +3488,14 @@ void deferred_split_folio(struct folio *folio)
> >>         if (folio_test_swapcache(folio))
> >>                 return;
> >>
> >> -       if (!list_empty(&folio->_deferred_list))
> >> -               return;
> >> -
> >>         spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
> >> -       if (list_empty(&folio->_deferred_list)) {
> >> +       if (partially_mapped) {
> >> +               folio_set_partially_mapped(folio);
> >>                 if (folio_test_pmd_mappable(folio))
> >>                         count_vm_event(THP_DEFERRED_SPLIT_PAGE);
> >>                 count_mthp_stat(folio_order(folio), MTHP_STAT_SPLIT_DEFERRED);
> >> +       }
> >> +       if (list_empty(&folio->_deferred_list)) {
> >>                 list_add_tail(&folio->_deferred_list, &ds_queue->split_queue);
> >>                 ds_queue->split_queue_len++;
> >>  #ifdef CONFIG_MEMCG
> >>
> >
> > not enough. as deferred_split_folio(true) won't be called if folio has been
> > deferred_list in __folio_remove_rmap():
> >
> >         if (partially_mapped && folio_test_anon(folio) &&
> >             list_empty(&folio->_deferred_list))
> >                 deferred_split_folio(folio, true);
> >
> > so you will still see 0.
> >
>
> ah yes, Thanks.
>
> So below diff over the current v3 series should work for all cases:
>
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index b4d72479330d..482e3ab60911 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3483,6 +3483,7 @@ void __folio_undo_large_rmappable(struct folio *folio)
>         spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
>  }
>
> +/* partially_mapped=false won't clear PG_partially_mapped folio flag */
>  void deferred_split_folio(struct folio *folio, bool partially_mapped)
>  {
>         struct deferred_split *ds_queue = get_deferred_split_queue(folio);
> @@ -3515,16 +3516,16 @@ void deferred_split_folio(struct folio *folio, bool partially_mapped)
>                 return;
>
>         spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
> -       if (partially_mapped)
> +       if (partially_mapped) {
>                 folio_set_partially_mapped(folio);
> -       else
> -               folio_clear_partially_mapped(folio);
> +               if (folio_test_pmd_mappable(folio))
> +                       count_vm_event(THP_DEFERRED_SPLIT_PAGE);
> +               count_mthp_stat(folio_order(folio), MTHP_STAT_SPLIT_DEFERRED);
> +       } else {
> +               /* partially mapped folios cannont become partially unmapped */
> +               VM_WARN_ON_FOLIO(folio_test_partially_mapped(folio), folio);
> +       }
>         if (list_empty(&folio->_deferred_list)) {
> -               if (partially_mapped) {
> -                       if (folio_test_pmd_mappable(folio))
> -                               count_vm_event(THP_DEFERRED_SPLIT_PAGE);
> -                       count_mthp_stat(folio_order(folio), MTHP_STAT_SPLIT_DEFERRED);
> -               }
>                 list_add_tail(&folio->_deferred_list, &ds_queue->split_queue);
>                 ds_queue->split_queue_len++;
>  #ifdef CONFIG_MEMCG
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 9ad558c2bad0..4c330635aa4e 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1578,7 +1578,7 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
>          * Check partially_mapped first to ensure it is a large folio.
>          */
>         if (partially_mapped && folio_test_anon(folio) &&
> -           list_empty(&folio->_deferred_list))
> +           !folio_test_partially_mapped(folio))
>                 deferred_split_folio(folio, true);
>
>         __folio_mod_stat(folio, -nr, -nr_pmdmapped);
>

This is an improvement, but there's still an issue. Two or more threads can
execute deferred_split_folio() simultaneously, which could lead to
DEFERRED_SPLIT being added multiple times. We should double-check
the status after acquiring the spinlock.

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f401ceded697..3d247826fb95 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3607,10 +3607,12 @@ void deferred_split_folio(struct folio *folio, bool partially_mapped)
 
 	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
 	if (partially_mapped) {
-		folio_set_partially_mapped(folio);
-		if (folio_test_pmd_mappable(folio))
-			count_vm_event(THP_DEFERRED_SPLIT_PAGE);
-		count_mthp_stat(folio_order(folio), MTHP_STAT_SPLIT_DEFERRED);
+		if (!folio_test_partially_mapped(folio)) {
+			folio_set_partially_mapped(folio);
+			if (folio_test_pmd_mappable(folio))
+				count_vm_event(THP_DEFERRED_SPLIT_PAGE);
+			count_mthp_stat(folio_order(folio), MTHP_STAT_SPLIT_DEFERRED);
+		}
 	} else {
 		/* partially mapped folios cannont become partially unmapped */
 		VM_WARN_ON_FOLIO(folio_test_partially_mapped(folio), folio);

