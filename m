Return-Path: <linux-kernel+bounces-235200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2064E91D172
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 13:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B372F281A6C
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 11:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C90A13B7AF;
	Sun, 30 Jun 2024 11:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7805ACf"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA343A29C
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 11:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719747274; cv=none; b=fd89eWPIL1Hq9zfZc8+jb5B5jVahhQCnXx/Afz247/AW7XK4fv5RG6ChB8P0VUESX6DeZa9GCyMvnxARYsQtwex5s6Z4AF+Vt1P2aPJ/ruaNWdekNWgXwyNDaDbgKEtzReKHCXQPdDQSE/4+oWeL9gglMnsY3axQFSfJZ3yfE+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719747274; c=relaxed/simple;
	bh=Da/cSc+VblxPgGpzly7PNkmb+PIG4/txYn3rvE4jHtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M4sJgJCVeqntlolU/84YaxDCnrBKNSwRlUUTQ52Gk5LElEV8QAFgZhK2WB8R5Q4gnrbmM4g4gyn6vhkusPIxH41pOPWDp0mZFzVJzqpH+isfCIQbFqYh7RtQet+IPwS22XkmLXk8ukFYadBHhs33vgF/W8ImKEj4jXxHJz5Xt9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W7805ACf; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57d106e69a2so1986685a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 04:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719747271; x=1720352071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=clUWiMT5oWK1imkvgrbcgrXS0hnspsa2Owk2lsm/OyY=;
        b=W7805ACfSCeNUV/YGLN3/5Y+XGDzn+8eRCGxkvpD45fSZpKtFH8pzAEr6Zqr4wOKDS
         lUFcCiDgIubZR2v9MGD5bccuhY3tYOlBYnjlXWU5uzeK/GMCVjNtNgjiamygF5ZzqqJa
         wFRMtT9/Mv4QWXkVCkQdqowE+wTUmaBo+OJvxMq1JFaqmfn0pt85waJvFoSfrpd9G2va
         +HAZXAV3RGDP3YfjKiyST2ley/Lfs5LczdzOkLOfLO0N5ypYmwbJ8P1KVsvY1GaPfXsg
         hHmbIvL1Fyz5FxJUp78hPQ8KS7lGtxb0A6rEfCKOeIS3JxxLFCYNbFk0mCCRFdA/8sG4
         3pwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719747271; x=1720352071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=clUWiMT5oWK1imkvgrbcgrXS0hnspsa2Owk2lsm/OyY=;
        b=TNJcJmLBrhCNBSZY+3VcVdjh3PTUl3gqrC0iGSrHWM0+ug+Q+J+JzyBIymRddty7Ur
         156JBvufJLBjE04rgzKvRfa+gvvCcOPrdveY7d9ptlBiGJNsPlkpfi6al8FuNfsTP+DW
         4ET1sE2KjJBq760DHa9bEH9FQoRI+GY56dQGWqITEzAnxFz5Zt6VgXx5S05gEQ8v1Hc1
         HtukP7cMMRFQab7iGWmduKSOWz5avUZHVgt0njww2II1HkOtHvtl8QpWlaqoqP0k9gOV
         3l9DnwK6nfw4+/204TMSIOlSoTHPOQwfRy5Ipzn9u/9E3EnTmmMw9NE4Kjc5NoIWcoVX
         pTOg==
X-Forwarded-Encrypted: i=1; AJvYcCVJTrmJjps+oKMRvmaH+Iv/eU6RozoRS8ACwT2bYndpgn7FaPlDb5YdXr59RvnrASF3CbaU7I10uOMhmpifZWhfHafT/3cnRXFaSms4
X-Gm-Message-State: AOJu0Yx0cfxlFtL8nI6vMmE/K6Et4AV6OTgZ8pxbY8/zG4RBT35h7yke
	8B1kCKHXMAU7Tb/XC2Y1Uksbw1cdrAAOH9Lk9ppLO/0hJU5KEbvQDWMnCv/zJmIttu0f8pPTqaC
	taL4/29o/LptEAxMe5ILoZVwZBH8=
X-Google-Smtp-Source: AGHT+IE0+uenPF9XBd53tHxD6s6wFhKtAF6HA66llVd3O3zjLyZhmGzIWuAwlqiCtV7CuJ01q1Chfk17FwGyU4Ue5O8=
X-Received: by 2002:a05:6402:26c7:b0:57d:df3:4cf2 with SMTP id
 4fb4d7f45d1cf-58780c2a167mr2434745a12.11.1719747270776; Sun, 30 Jun 2024
 04:34:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424135148.30422-1-ioworker0@gmail.com> <20240424135148.30422-2-ioworker0@gmail.com>
 <a0f57d90-a556-4b19-a925-a82a81fbb067@arm.com> <CAGsJ_4xSKWXGY9TPS_kvhp7FALH16cyVnZu5FkHy3nN_hsZ_kQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4xSKWXGY9TPS_kvhp7FALH16cyVnZu5FkHy3nN_hsZ_kQ@mail.gmail.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Sun, 30 Jun 2024 19:34:17 +0800
Message-ID: <CAK1f24=rC+iEHkwAHmPBk=SUQ9HRHLA+Q7aKcADdO3uQSs9pnA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: add per-order mTHP split counters
To: Barry Song <baohua@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>, akpm@linux-foundation.org, david@redhat.com, 
	baolin.wang@linux.alibaba.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Barry,

Thanks for following up!

On Sun, Jun 30, 2024 at 5:48=E2=80=AFPM Barry Song <baohua@kernel.org> wrot=
e:
>
> On Thu, Apr 25, 2024 at 3:41=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.co=
m> wrote:
> >
> > + Barry
> >
> > On 24/04/2024 14:51, Lance Yang wrote:
> > > At present, the split counters in THP statistics no longer include
> > > PTE-mapped mTHP. Therefore, this commit introduces per-order mTHP spl=
it
> > > counters to monitor the frequency of mTHP splits. This will assist
> > > developers in better analyzing and optimizing system performance.
> > >
> > > /sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats
> > >         split_page
> > >         split_page_failed
> > >         deferred_split_page
> > >
> > > Signed-off-by: Lance Yang <ioworker0@gmail.com>
> > > ---
> > >  include/linux/huge_mm.h |  3 +++
> > >  mm/huge_memory.c        | 14 ++++++++++++--
> > >  2 files changed, 15 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > > index 56c7ea73090b..7b9c6590e1f7 100644
> > > --- a/include/linux/huge_mm.h
> > > +++ b/include/linux/huge_mm.h
> > > @@ -272,6 +272,9 @@ enum mthp_stat_item {
> > >       MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
> > >       MTHP_STAT_ANON_SWPOUT,
> > >       MTHP_STAT_ANON_SWPOUT_FALLBACK,
> > > +     MTHP_STAT_SPLIT_PAGE,
> > > +     MTHP_STAT_SPLIT_PAGE_FAILED,
> > > +     MTHP_STAT_DEFERRED_SPLIT_PAGE,
> > >       __MTHP_STAT_COUNT
> > >  };
> > >
> > > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > > index 055df5aac7c3..52db888e47a6 100644
> > > --- a/mm/huge_memory.c
> > > +++ b/mm/huge_memory.c
> > > @@ -557,6 +557,9 @@ DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_S=
TAT_ANON_FAULT_FALLBACK);
> > >  DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAU=
LT_FALLBACK_CHARGE);
> > >  DEFINE_MTHP_STAT_ATTR(anon_swpout, MTHP_STAT_ANON_SWPOUT);
> > >  DEFINE_MTHP_STAT_ATTR(anon_swpout_fallback, MTHP_STAT_ANON_SWPOUT_FA=
LLBACK);
> > > +DEFINE_MTHP_STAT_ATTR(split_page, MTHP_STAT_SPLIT_PAGE);
> > > +DEFINE_MTHP_STAT_ATTR(split_page_failed, MTHP_STAT_SPLIT_PAGE_FAILED=
);
> > > +DEFINE_MTHP_STAT_ATTR(deferred_split_page, MTHP_STAT_DEFERRED_SPLIT_=
PAGE);
> > >
> > >  static struct attribute *stats_attrs[] =3D {
> > >       &anon_fault_alloc_attr.attr,
> > > @@ -564,6 +567,9 @@ static struct attribute *stats_attrs[] =3D {
> > >       &anon_fault_fallback_charge_attr.attr,
> > >       &anon_swpout_attr.attr,
> > >       &anon_swpout_fallback_attr.attr,
> > > +     &split_page_attr.attr,
> > > +     &split_page_failed_attr.attr,
> > > +     &deferred_split_page_attr.attr,
> > >       NULL,
> > >  };
> > >
> > > @@ -3083,7 +3089,7 @@ int split_huge_page_to_list_to_order(struct pag=
e *page, struct list_head *list,
> > >       XA_STATE_ORDER(xas, &folio->mapping->i_pages, folio->index, new=
_order);
> > >       struct anon_vma *anon_vma =3D NULL;
> > >       struct address_space *mapping =3D NULL;
> > > -     bool is_thp =3D folio_test_pmd_mappable(folio);
> > > +     int order =3D folio_order(folio);
> > >       int extra_pins, ret;
> > >       pgoff_t end;
> > >       bool is_hzp;
> > > @@ -3262,8 +3268,10 @@ int split_huge_page_to_list_to_order(struct pa=
ge *page, struct list_head *list,
> > >               i_mmap_unlock_read(mapping);
> > >  out:
> > >       xas_destroy(&xas);
> > > -     if (is_thp)
> > > +     if (order >=3D HPAGE_PMD_ORDER)
> > >               count_vm_event(!ret ? THP_SPLIT_PAGE : THP_SPLIT_PAGE_F=
AILED);
> > > +     count_mthp_stat(order, !ret ? MTHP_STAT_SPLIT_PAGE :
> > > +                                   MTHP_STAT_SPLIT_PAGE_FAILED);
> > >       return ret;
> > >  }
> > >
> > > @@ -3327,6 +3335,8 @@ void deferred_split_folio(struct folio *folio)
> > >       if (list_empty(&folio->_deferred_list)) {
> > >               if (folio_test_pmd_mappable(folio))
> > >                       count_vm_event(THP_DEFERRED_SPLIT_PAGE);
> > > +             count_mthp_stat(folio_order(folio),
> > > +                             MTHP_STAT_DEFERRED_SPLIT_PAGE);
> >
> > There is a very long conversation with Barry about adding a 'global "mT=
HP became
> > partially mapped 1 or more processes" counter (inc only)', which termin=
ates at
> > [1]. There is a lot of discussion about the required semantics around t=
he need
> > for partial map to cover alignment and contiguity as well as whether al=
l pages
> > are mapped, and to trigger once it becomes partial in at least 1 proces=
s.
> >
> > MTHP_STAT_DEFERRED_SPLIT_PAGE is giving much simpler semantics, but les=
s
> > information as a result. Barry, what's your view here? I'm guessing thi=
s doesn't
> > quite solve what you are looking for?
>
> This doesn't quite solve what I am looking for but I still think the
> patch has its value.
>
> I'm looking for a solution that can:
>
>   *  Count the amount of memory in the system for each mTHP size.
>   *  Determine how much memory for each mTHP size is partially unmapped.
>
> For example, in a system with 16GB of memory, we might find that we have =
3GB
> of 64KB mTHP, and within that, 512MB is partially unmapped, potentially w=
asting
> memory at this moment.  I'm uncertain whether Lance is interested in
> this job :-)

Nice, that's an interesting/valuable job for me ;)

Let's do it separately, as 'split' and friends probably can=E2=80=99t be th=
e
solution you
mentioned above, IMHO.

Hmm... I don't have a good idea about the solution for now, but will
think it over
and come back to discuss it here.

>
> Counting deferred_split remains valuable as it can signal whether the sys=
tem is
> experiencing significant partial unmapping.

Have a nice weekend!
Lance

>
> >
> > [1] https://lore.kernel.org/linux-mm/6cc7d781-884f-4d8f-a175-8609732b87=
eb@arm.com/
> >
> > Thanks,
> > Ryan
> >
> > >               list_add_tail(&folio->_deferred_list, &ds_queue->split_=
queue);
> > >               ds_queue->split_queue_len++;
> > >  #ifdef CONFIG_MEMCG
> >
>
> Thanks
> Barry

