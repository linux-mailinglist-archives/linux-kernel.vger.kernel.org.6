Return-Path: <linux-kernel+bounces-235499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9498191D5D7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 03:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF1071C20F3B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 01:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255E74C6B;
	Mon,  1 Jul 2024 01:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtLz3QiP"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADBE79C0
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 01:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719798140; cv=none; b=B5yvLlZX6+rb0BljxthNo3o89Lx8UrPa4jx5XplZDZjQhMpgiku3TrDnXDZagwy2krOtaKt1xxBCqwW8BIhgCKO1vahpwZxWuu5HB+O4XPSaokphLwSPR8S9eFHsRdE73e86gFn8NUz5kTtDCZY31FzUB4AwskruzsBerVQM0mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719798140; c=relaxed/simple;
	bh=s/EgXF6GOpyypwBIbZjziqi4ZoNSF+vPsmcS7o+SJdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YUua7F8uaNrt4VMnxZAZ7cENLPgdfYtFT4sPPrDR8NdTtN8IxXWT3zOxgcGNyjDtcPWLsc8FVJDvMDRnStefj0VCRKItn/eeQE8c93+/4Bdo9qVxeRvQulNRNkOcIuCmXq8lCxyg5FKl0H9zar8RthvJmG5ewU2LnPyLERUpJG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QtLz3QiP; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57ccd1111aeso2817866a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 18:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719798137; x=1720402937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QDwPLMmlaqY2Z+dXHgf9a1r847VxqdR04f3yjAi09Uk=;
        b=QtLz3QiPhoZPYu3ijU5XufQY2VfabmTB81egm1v4M4HMJWOgjB6Rn4AazqDs1kD2tg
         z8zrvmCog+a4c1do0qEaYKtCttXCQg7/tCEZzHDbbo/a/xxoHBXPpRk0GlxuXGJyu17g
         fRR3CtlDeYHxI7QWL6wg/Qlj+tPZjUPCR5ijwqHSZxTuHNNIyjmSutgry2Gw1WCCVPiV
         ZJKJGZeXS2duQyjk7bvEa/QXVZ8/UbTmbCVW+k3UQgCKoEypeGKvBJP+A/teRybCoV8O
         KYLIYZxQDlyGub6oa42FytaysHA+UnXRXLFDZ76UWxgloajk82A/rldkJZV1P6HiDf02
         /msQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719798137; x=1720402937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QDwPLMmlaqY2Z+dXHgf9a1r847VxqdR04f3yjAi09Uk=;
        b=jFXOsUI9iuu7gbSDiKmPzdC6ilnnt4k1noMFeRqY3PFp5n5znqKFX88u4MpVXVHmfV
         k0Hj+92+p+/FlE6rO80Ix1HK+6+L8TghA+s9S93ckAlOnWtj3RQiFW0hRz9xDAUzWRl0
         gw6daPCLzlI+zDxLtv0tmC992+b8CcS+pn+30Du/iw57/UoESz7F4kWbVPRcY5GJfw9y
         8kCi1X4VHOy7RelENOew7gA/QoqKtJ6eVR5v9a/NheL1ilxfQUVbWprEHf8xUjb8ASwI
         UpTrxeyXi6f01xNihBgkR6RiDHHWdrvpTx6jLxN4A5GDUOipkEaB9EqDpDSpMAqD6dbQ
         1+dA==
X-Forwarded-Encrypted: i=1; AJvYcCXZ/uSgr/sj6VyjxzJyqCKl71NojjBehpPW03vFfj8Bc+X9/n3w7VYsXM3qbnazJQggQ4dmU7t0lWlIk7bS7W8q39pUg7knDTtMUHlr
X-Gm-Message-State: AOJu0YyZCxrLBYi9W2nxx69ROW7oYMUwZDiAD47rlhtagzbf5ZO1gHzk
	yw6502XAnTbeta82oRRMrlfuQD+esTiE6E8sj3MlljUFuoCk5HbY0brQNsim8clVRjtlAy1yW0h
	CzahAsE5jtNDSlVkGT3elppQ+Tyc=
X-Google-Smtp-Source: AGHT+IG/MYaPLxvlYOaDUSFyv1g6sKCJYrmgLplveO02lDU/vDYT0ChyOHw5p1KMxVyGv3bpjUijSClKJ1dfNzeetNg=
X-Received: by 2002:a05:6402:50d3:b0:57d:4b56:da11 with SMTP id
 4fb4d7f45d1cf-5879f4a5716mr3289105a12.11.1719798136582; Sun, 30 Jun 2024
 18:42:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628130750.73097-1-ioworker0@gmail.com> <20240628130750.73097-2-ioworker0@gmail.com>
 <CAGsJ_4yF6ucmLpMpdfjEgZXB6CP7vQkidqfugsmo1vGiaUb97g@mail.gmail.com>
In-Reply-To: <CAGsJ_4yF6ucmLpMpdfjEgZXB6CP7vQkidqfugsmo1vGiaUb97g@mail.gmail.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Mon, 1 Jul 2024 09:42:05 +0800
Message-ID: <CAK1f24kotV_CiWRM3rNrQqF+=uAjzJShV+t4YU+035vzA1LGJw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm: add per-order mTHP split counters
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, dj456119@gmail.com, ryan.roberts@arm.com, 
	david@redhat.com, shy828301@gmail.com, ziy@nvidia.com, libang.li@antgroup.com, 
	baolin.wang@linux.alibaba.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Mingzhe Yang <mingzhe.yang@ly.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Barry,

Thanks  for taking time to review!

On Mon, Jul 1, 2024 at 8:02=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrote=
:
>
> On Sat, Jun 29, 2024 at 1:09=E2=80=AFAM Lance Yang <ioworker0@gmail.com> =
wrote:
> >
> > Currently, the split counters in THP statistics no longer include
> > PTE-mapped mTHP. Therefore, we propose introducing per-order mTHP split
> > counters to monitor the frequency of mTHP splits. This will help develo=
pers
> > better analyze and optimize system performance.
> >
> > /sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats
> >         split
> >         split_failed
> >         split_deferred
> >
> > Signed-off-by: Mingzhe Yang <mingzhe.yang@ly.com>
> > Signed-off-by: Lance Yang <ioworker0@gmail.com>
>
> Personally, I'm not convinced that using a temporary variable order
> makes the code
> more readable. Functions like folio_test_pmd_mappable() seem more readabl=
e to

Agreed. Using functions like folio_test_pmd_mappable() is more readable
for THP checks.

> me. In any case, it's a minor issue.

I'd like to hear other opinions as well ;)

>
> Acked-by: Barry Song <baohua@kernel.org>

Thanks again for your time!
Lance

>
> > ---
> >  include/linux/huge_mm.h |  3 +++
> >  mm/huge_memory.c        | 19 ++++++++++++++-----
> >  2 files changed, 17 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index 212cca384d7e..cee3c5da8f0e 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -284,6 +284,9 @@ enum mthp_stat_item {
> >         MTHP_STAT_FILE_ALLOC,
> >         MTHP_STAT_FILE_FALLBACK,
> >         MTHP_STAT_FILE_FALLBACK_CHARGE,
> > +       MTHP_STAT_SPLIT,
> > +       MTHP_STAT_SPLIT_FAILED,
> > +       MTHP_STAT_SPLIT_DEFERRED,
> >         __MTHP_STAT_COUNT
> >  };
> >
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index c7ce28f6b7f3..a633206375af 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -559,6 +559,9 @@ DEFINE_MTHP_STAT_ATTR(swpout_fallback, MTHP_STAT_SW=
POUT_FALLBACK);
> >  DEFINE_MTHP_STAT_ATTR(file_alloc, MTHP_STAT_FILE_ALLOC);
> >  DEFINE_MTHP_STAT_ATTR(file_fallback, MTHP_STAT_FILE_FALLBACK);
> >  DEFINE_MTHP_STAT_ATTR(file_fallback_charge, MTHP_STAT_FILE_FALLBACK_CH=
ARGE);
> > +DEFINE_MTHP_STAT_ATTR(split, MTHP_STAT_SPLIT);
> > +DEFINE_MTHP_STAT_ATTR(split_failed, MTHP_STAT_SPLIT_FAILED);
> > +DEFINE_MTHP_STAT_ATTR(split_deferred, MTHP_STAT_SPLIT_DEFERRED);
> >
> >  static struct attribute *stats_attrs[] =3D {
> >         &anon_fault_alloc_attr.attr,
> > @@ -569,6 +572,9 @@ static struct attribute *stats_attrs[] =3D {
> >         &file_alloc_attr.attr,
> >         &file_fallback_attr.attr,
> >         &file_fallback_charge_attr.attr,
> > +       &split_attr.attr,
> > +       &split_failed_attr.attr,
> > +       &split_deferred_attr.attr,
> >         NULL,
> >  };
> >
> > @@ -3068,7 +3074,7 @@ int split_huge_page_to_list_to_order(struct page =
*page, struct list_head *list,
> >         XA_STATE_ORDER(xas, &folio->mapping->i_pages, folio->index, new=
_order);
> >         struct anon_vma *anon_vma =3D NULL;
> >         struct address_space *mapping =3D NULL;
> > -       bool is_thp =3D folio_test_pmd_mappable(folio);
> > +       int order =3D folio_order(folio);
> >         int extra_pins, ret;
> >         pgoff_t end;
> >         bool is_hzp;
> > @@ -3076,7 +3082,7 @@ int split_huge_page_to_list_to_order(struct page =
*page, struct list_head *list,
> >         VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
> >         VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
> >
> > -       if (new_order >=3D folio_order(folio))
> > +       if (new_order >=3D order)
> >                 return -EINVAL;
> >
> >         if (folio_test_anon(folio)) {
> > @@ -3253,8 +3259,9 @@ int split_huge_page_to_list_to_order(struct page =
*page, struct list_head *list,
> >                 i_mmap_unlock_read(mapping);
> >  out:
> >         xas_destroy(&xas);
> > -       if (is_thp)
> > +       if (order >=3D HPAGE_PMD_ORDER)
> >                 count_vm_event(!ret ? THP_SPLIT_PAGE : THP_SPLIT_PAGE_F=
AILED);
> > +       count_mthp_stat(order, !ret ? MTHP_STAT_SPLIT : MTHP_STAT_SPLIT=
_FAILED);
> >         return ret;
> >  }
> >
> > @@ -3278,13 +3285,14 @@ void deferred_split_folio(struct folio *folio)
> >  #ifdef CONFIG_MEMCG
> >         struct mem_cgroup *memcg =3D folio_memcg(folio);
> >  #endif
> > +       int order =3D folio_order(folio);
> >         unsigned long flags;
> >
> >         /*
> >          * Order 1 folios have no space for a deferred list, but we als=
o
> >          * won't waste much memory by not adding them to the deferred l=
ist.
> >          */
> > -       if (folio_order(folio) <=3D 1)
> > +       if (order <=3D 1)
> >                 return;
> >
> >         /*
> > @@ -3305,8 +3313,9 @@ void deferred_split_folio(struct folio *folio)
> >
> >         spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
> >         if (list_empty(&folio->_deferred_list)) {
> > -               if (folio_test_pmd_mappable(folio))
> > +               if (order >=3D HPAGE_PMD_ORDER)
> >                         count_vm_event(THP_DEFERRED_SPLIT_PAGE);
> > +               count_mthp_stat(order, MTHP_STAT_SPLIT_DEFERRED);
> >                 list_add_tail(&folio->_deferred_list, &ds_queue->split_=
queue);
> >                 ds_queue->split_queue_len++;
> >  #ifdef CONFIG_MEMCG
> > --
> > 2.45.2
> >

