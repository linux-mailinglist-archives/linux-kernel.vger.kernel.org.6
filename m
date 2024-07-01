Return-Path: <linux-kernel+bounces-236048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B3F91DCD8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DED6C281E26
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC77254FB5;
	Mon,  1 Jul 2024 10:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqkPDxWS"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AA8381D9
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 10:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719830215; cv=none; b=gUQhUslLZZKvn5GA7hPIEQuvKlUnw9PcxypSHkF96pwvXYCHdUfP1kwQfy9NGROKFGRAK80+6/8uKSdU+cE6WBEIr53dBNo/hijA329a57dBi2xe2Oi7LsNrcIqtKkjzLRHywKHY7KVVwJ0wX/v2LDmB9eckYnEsojn/WxdyWOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719830215; c=relaxed/simple;
	bh=SmUoB6lnw/BTLWfnj2d/zyp4M974K5zoQe5IX3fP9XU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mUsgr2b/keQZcu1GZlV5dAVxeEhSHM5GyQYOQqIj3tQdYRFUzPcjFcqrv+ff8kr+LgC7/g3pOpxNHvAbGfRzdIQV5roMrUqCTiEhXqE3MLVmXtrgajSGH/WbR9tfbNh/6XOe/1Weh5+IrohALeYs0i3WLhgNZvury1yboXkNoEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqkPDxWS; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57d15b85a34so73674a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 03:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719830212; x=1720435012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7TEtTsZBZ1gg5jFfBK9mVH7HjSHPH4E/ha4me09DcWo=;
        b=CqkPDxWSped7Zlci4hM+HsJ/LVQ3rXlyjTZtUQ3mu793isdwB9k2zx0BUThHa+m/Wx
         YaDMVK6Rba4mABNgXLL3T8Y4/xcPhU2dpuJSvqOJKVo3tAMSbzCqCQSk2qPAPwKbOMcz
         o8X0zoooIXI0F3aK6H2FX95sL+fQrw5bkqWfcQQaOsC5kK6fGtDxksL2uzH836TyXMmS
         fVvQN0pRwXMVVBMOcT9yM8zB5lz3oSp0pB9bQBqCZ+/qBlPz/cZmJUA13/w8EKcdFmNQ
         WllDfUCHhalVhPnSGS83uYW61TYnwyFGCyjR+ttS9qIDvkSIQ0xAt9wjyUlOaJRZRuoh
         shWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719830212; x=1720435012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7TEtTsZBZ1gg5jFfBK9mVH7HjSHPH4E/ha4me09DcWo=;
        b=CiTZNfWYHfgVqcbrmE93uUl33hYDOk2D62T4tcxNXMBTJUhcj8B+G7ObvZFEJVhAvX
         o+AEfp9ArU0+KEdENngYXoSKMLxYqgZK8X17CbnBXG5ly1KMoxeNfvBMyoL9rqUNeDf7
         Asp4s1I2ZN111PnHueEumbY1U0cG+e5NsEQWvfaTy2gaIa9AW5FG68EGPR8hy+OEPsf7
         dj5uN/FuURESseubOf3P87Y6beBmvZytTz4MJ1yEBPNXNDxj69eGBojNB36vkwX0jAOH
         XdfaLkH2a0CAESGFCOq1OV5pQIGTLxnbvY19OUmMqQnvpNdAQOe3fM7NcnrGoQtCEhiN
         3KPw==
X-Forwarded-Encrypted: i=1; AJvYcCXL81R5jvRLDtz8v+b583sej6wS6l/3SR6GbGde/BZaIcBBUu/Popz13eeTknAMI92Ad/3lXJC88MiCVVjzJ9RbLKOqC/oPYr5bKSsV
X-Gm-Message-State: AOJu0YxmnjpIsLDQCASHCeBPNb38VbBtCeIqvtvUz7cXUoxWBFlNqR2j
	719HfBLLeQW+ZBy2YwSUpf9i17k4b+BSa03h/iqk1xco6gVm1BUuluv31wn28VXBmTZst/hAoHV
	Cv6QPzD8QmSYzhBbajJ+fD6/AosE=
X-Google-Smtp-Source: AGHT+IGzIhwYmbHd37ApVUXuzPylQlY0wKvhrRXAISVqnBCHUoxXcKmFZqR5ql6Y2ZK1aZRanS5i95IG7hqeAerVoXc=
X-Received: by 2002:a05:6402:d09:b0:57c:7599:2c67 with SMTP id
 4fb4d7f45d1cf-587a0bfdde8mr3961629a12.37.1719830212245; Mon, 01 Jul 2024
 03:36:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628130750.73097-1-ioworker0@gmail.com> <20240628130750.73097-2-ioworker0@gmail.com>
 <CAGsJ_4yF6ucmLpMpdfjEgZXB6CP7vQkidqfugsmo1vGiaUb97g@mail.gmail.com> <c0706b47-cdbc-4cff-bea8-e39ababc9b89@linux.alibaba.com>
In-Reply-To: <c0706b47-cdbc-4cff-bea8-e39ababc9b89@linux.alibaba.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Mon, 1 Jul 2024 18:36:41 +0800
Message-ID: <CAK1f24nYew635T9O+bPepShXLEwDD2wAEN8s41NYBcQ58fYiNQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm: add per-order mTHP split counters
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org, dj456119@gmail.com, 
	ryan.roberts@arm.com, david@redhat.com, shy828301@gmail.com, ziy@nvidia.com, 
	libang.li@antgroup.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Mingzhe Yang <mingzhe.yang@ly.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Baolin,

Thanks for taking time to review!

On Mon, Jul 1, 2024 at 10:23=E2=80=AFAM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 2024/7/1 08:02, Barry Song wrote:
> > On Sat, Jun 29, 2024 at 1:09=E2=80=AFAM Lance Yang <ioworker0@gmail.com=
> wrote:
> >>
> >> Currently, the split counters in THP statistics no longer include
> >> PTE-mapped mTHP. Therefore, we propose introducing per-order mTHP spli=
t
> >> counters to monitor the frequency of mTHP splits. This will help devel=
opers
> >> better analyze and optimize system performance.
> >>
> >> /sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats
> >>          split
> >>          split_failed
> >>          split_deferred
> >>
> >> Signed-off-by: Mingzhe Yang <mingzhe.yang@ly.com>
> >> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> >
> > Personally, I'm not convinced that using a temporary variable order
> > makes the code
> > more readable. Functions like folio_test_pmd_mappable() seem more reada=
ble to
> > me. In any case, it's a minor issue.
>
> Yes, I have the same opinion as Barry. With that:
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Thanks again for your opinion!
Lance

>
>
> > Acked-by: Barry Song <baohua@kernel.org>
> >
> >> ---
> >>   include/linux/huge_mm.h |  3 +++
> >>   mm/huge_memory.c        | 19 ++++++++++++++-----
> >>   2 files changed, 17 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> >> index 212cca384d7e..cee3c5da8f0e 100644
> >> --- a/include/linux/huge_mm.h
> >> +++ b/include/linux/huge_mm.h
> >> @@ -284,6 +284,9 @@ enum mthp_stat_item {
> >>          MTHP_STAT_FILE_ALLOC,
> >>          MTHP_STAT_FILE_FALLBACK,
> >>          MTHP_STAT_FILE_FALLBACK_CHARGE,
> >> +       MTHP_STAT_SPLIT,
> >> +       MTHP_STAT_SPLIT_FAILED,
> >> +       MTHP_STAT_SPLIT_DEFERRED,
> >>          __MTHP_STAT_COUNT
> >>   };
> >>
> >> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >> index c7ce28f6b7f3..a633206375af 100644
> >> --- a/mm/huge_memory.c
> >> +++ b/mm/huge_memory.c
> >> @@ -559,6 +559,9 @@ DEFINE_MTHP_STAT_ATTR(swpout_fallback, MTHP_STAT_S=
WPOUT_FALLBACK);
> >>   DEFINE_MTHP_STAT_ATTR(file_alloc, MTHP_STAT_FILE_ALLOC);
> >>   DEFINE_MTHP_STAT_ATTR(file_fallback, MTHP_STAT_FILE_FALLBACK);
> >>   DEFINE_MTHP_STAT_ATTR(file_fallback_charge, MTHP_STAT_FILE_FALLBACK_=
CHARGE);
> >> +DEFINE_MTHP_STAT_ATTR(split, MTHP_STAT_SPLIT);
> >> +DEFINE_MTHP_STAT_ATTR(split_failed, MTHP_STAT_SPLIT_FAILED);
> >> +DEFINE_MTHP_STAT_ATTR(split_deferred, MTHP_STAT_SPLIT_DEFERRED);
> >>
> >>   static struct attribute *stats_attrs[] =3D {
> >>          &anon_fault_alloc_attr.attr,
> >> @@ -569,6 +572,9 @@ static struct attribute *stats_attrs[] =3D {
> >>          &file_alloc_attr.attr,
> >>          &file_fallback_attr.attr,
> >>          &file_fallback_charge_attr.attr,
> >> +       &split_attr.attr,
> >> +       &split_failed_attr.attr,
> >> +       &split_deferred_attr.attr,
> >>          NULL,
> >>   };
> >>
> >> @@ -3068,7 +3074,7 @@ int split_huge_page_to_list_to_order(struct page=
 *page, struct list_head *list,
> >>          XA_STATE_ORDER(xas, &folio->mapping->i_pages, folio->index, n=
ew_order);
> >>          struct anon_vma *anon_vma =3D NULL;
> >>          struct address_space *mapping =3D NULL;
> >> -       bool is_thp =3D folio_test_pmd_mappable(folio);
> >> +       int order =3D folio_order(folio);
> >>          int extra_pins, ret;
> >>          pgoff_t end;
> >>          bool is_hzp;
> >> @@ -3076,7 +3082,7 @@ int split_huge_page_to_list_to_order(struct page=
 *page, struct list_head *list,
> >>          VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
> >>          VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
> >>
> >> -       if (new_order >=3D folio_order(folio))
> >> +       if (new_order >=3D order)
> >>                  return -EINVAL;
> >>
> >>          if (folio_test_anon(folio)) {
> >> @@ -3253,8 +3259,9 @@ int split_huge_page_to_list_to_order(struct page=
 *page, struct list_head *list,
> >>                  i_mmap_unlock_read(mapping);
> >>   out:
> >>          xas_destroy(&xas);
> >> -       if (is_thp)
> >> +       if (order >=3D HPAGE_PMD_ORDER)
> >>                  count_vm_event(!ret ? THP_SPLIT_PAGE : THP_SPLIT_PAGE=
_FAILED);
> >> +       count_mthp_stat(order, !ret ? MTHP_STAT_SPLIT : MTHP_STAT_SPLI=
T_FAILED);
> >>          return ret;
> >>   }
> >>
> >> @@ -3278,13 +3285,14 @@ void deferred_split_folio(struct folio *folio)
> >>   #ifdef CONFIG_MEMCG
> >>          struct mem_cgroup *memcg =3D folio_memcg(folio);
> >>   #endif
> >> +       int order =3D folio_order(folio);
> >>          unsigned long flags;
> >>
> >>          /*
> >>           * Order 1 folios have no space for a deferred list, but we a=
lso
> >>           * won't waste much memory by not adding them to the deferred=
 list.
> >>           */
> >> -       if (folio_order(folio) <=3D 1)
> >> +       if (order <=3D 1)
> >>                  return;
> >>
> >>          /*
> >> @@ -3305,8 +3313,9 @@ void deferred_split_folio(struct folio *folio)
> >>
> >>          spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
> >>          if (list_empty(&folio->_deferred_list)) {
> >> -               if (folio_test_pmd_mappable(folio))
> >> +               if (order >=3D HPAGE_PMD_ORDER)
> >>                          count_vm_event(THP_DEFERRED_SPLIT_PAGE);
> >> +               count_mthp_stat(order, MTHP_STAT_SPLIT_DEFERRED);
> >>                  list_add_tail(&folio->_deferred_list, &ds_queue->spli=
t_queue);
> >>                  ds_queue->split_queue_len++;
> >>   #ifdef CONFIG_MEMCG
> >> --
> >> 2.45.2
> >>

