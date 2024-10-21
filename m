Return-Path: <linux-kernel+bounces-375183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B02BE9A921C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 23:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6515C283CAD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 21:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999201E2830;
	Mon, 21 Oct 2024 21:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o72ftB6k"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D504C10A3E
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 21:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729546484; cv=none; b=lAKPK1oRRf7d2w6EUhnufUYStKhksFcUs2rh2IVnOyGfvdwPq0o/KyhQGiylxzjyiHhHENTcm1B3hJGwOve6kjLJjNJA1fiHNmOOXP6BBl7uDu8SJnw5BmJKPFcgzmsnMxeqM8PMi7pMIjZckAO59U+cF06goWMYjM4EZburzt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729546484; c=relaxed/simple;
	bh=FcKWsHq1hgljR0i0vDPl0t8o2fmTLXkVbRZd9nd26gA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MxGlyizMESkQ1n2IEUwUSgew+geCM65ZalQhbev94QQnlQXcbL2pajtcHlvha+oYW7wCL9aiy+cnjlpzLYWUhC8Lddm+JLjtJiiyaijVorBJEQGZeUBgpf8W4Ubg0jSbG6RHkGF5+yB6Yzi9Vv4ONHFa7XYLYU1H1x/kTt9Z9zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o72ftB6k; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9a0f198d38so688822066b.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 14:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729546481; x=1730151281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tmm2xALcW2rsx29+DdrW+v337pzZtbQgSnw6+Xs/zn4=;
        b=o72ftB6kxDyS5oRGs3IzyZfdPtVQObtGP7vXoeEAmKRRjxRrW486uJceCQBSqPwKnz
         tjd+uujU856W+YFCaxm4/vIrTsJFJhtk23xLNp2t0r4x5ApyQlP5mrHO81zCT6uMviQn
         NkIixHzJj608VNrG5TzBVOKsbB++uAdNt8zKgCDPllO6pGJdR0EprqVP0zK9PdttEFbr
         JzYDR19uM0VEJjHkkG8b3f2pDcGqdU0/nwLeyGbImYLkCi8BdOGYjT9giKdGnKcAXOmW
         vDcXaySkjAEbcEximgJfOcoFLUZkd9mu7mkyEcnTsmyTPyGv3lsjiWr32xczZGhxun0p
         8HEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729546481; x=1730151281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tmm2xALcW2rsx29+DdrW+v337pzZtbQgSnw6+Xs/zn4=;
        b=B0iMGBiUtBWXeSn8IlJxWODV8NSn7U4rPabRZoVFKv92jGuzwRkeiV6spxXBLzB4KF
         K+DH9BJelkgbHQCX5W8j9VDvcFOYStMRF62kntpOGYFF2uxXWAQLKnhtNTcNLOwsIVUr
         VGdkgs0Xd7LPWr+v8uAIESe82fk3ek5OSNpPQtuRTBLPVTWNz813+sCzsHfi48u7hmn2
         GoL1IBUJhOs39bCfEOvPoaL2a69fGFAk9p1jcjo6KeEDU7vcrRRomEtxvlmtHnyOwnUv
         su0YeVcZsWY/RaPRA/uQHyBf/KWTkWay9Sn1/9CbKER3ZqfQ840qOpYAsUlIx15YIHij
         302w==
X-Forwarded-Encrypted: i=1; AJvYcCV3iMSMh5ravac4yvUUZXNP+mHCMi99c3rF6vEkl6DUgcJBlftHfVivlgpIwf3UEVzMOhIxr9v3Tj2E5V4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT3iil91tNBUEbkMP5hpvzV7vgi4PuppBdhqI7g6ykQFC62lpm
	MG01hmscRDN1ZcqbCa2phxOmRQgoYly/d67MF5UvC04gLmFeM7XRtB1jJDkeF6V33OkfhmE9gF1
	qhj57FHuad2YMo9eLPL47f2vVPtGu5N3Oq88R
X-Google-Smtp-Source: AGHT+IF3y/LVIbieQtEJFBqOYK2yrALBMR4CT6p9zp8Pa+ZdpkLxqwNllyVWQxdDyJVeQO7f2UVhXNv2mF7LxG2ceA4=
X-Received: by 2002:a17:906:4788:b0:a99:d797:c132 with SMTP id
 a640c23a62f3a-a9a69a6605dmr1179941666b.16.1729546480976; Mon, 21 Oct 2024
 14:34:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018105026.2521366-1-usamaarif642@gmail.com>
 <20241018105026.2521366-4-usamaarif642@gmail.com> <CAGsJ_4xyDMUDxVhi0bzZJ4jAd_Hw8Hn25+4epO9u9=iu0QMdoA@mail.gmail.com>
 <ca158172-a100-4af6-98de-083d77cd9ed8@gmail.com> <CAGsJ_4x9YKi9BKmzOuOfaLrjr=kpQsiog=rAP3jJY=YQJ3Fupg@mail.gmail.com>
 <ac2d47fc-9bdc-441f-8b96-fb47862cd2c6@gmail.com> <CAGsJ_4xbciws3AnRFk0U8YeS5MPD=deXw6PCB6i71vgrLir8ew@mail.gmail.com>
 <6d036c4d-ec2e-4562-98a1-6668948086b5@gmail.com>
In-Reply-To: <6d036c4d-ec2e-4562-98a1-6668948086b5@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 21 Oct 2024 14:34:03 -0700
Message-ID: <CAJD7tkYyYcDAAuD_vq-2zEkRrd9F_u7UXDD-edooc3qnhEXAFQ@mail.gmail.com>
Subject: Re: [RFC 3/4] mm/zswap: add support for large folio zswapin
To: Usama Arif <usamaarif642@gmail.com>
Cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	hannes@cmpxchg.org, david@redhat.com, willy@infradead.org, 
	kanchana.p.sridhar@intel.com, nphamcs@gmail.com, chengming.zhou@linux.dev, 
	ryan.roberts@arm.com, ying.huang@intel.com, riel@surriel.com, 
	shakeel.butt@linux.dev, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 1:57=E2=80=AFPM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
>
>
> On 21/10/2024 21:28, Barry Song wrote:
> > On Tue, Oct 22, 2024 at 1:21=E2=80=AFAM Usama Arif <usamaarif642@gmail.=
com> wrote:
> >>
> >>
> >>
> >> On 21/10/2024 11:55, Barry Song wrote:
> >>> On Mon, Oct 21, 2024 at 11:44=E2=80=AFPM Usama Arif <usamaarif642@gma=
il.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 21/10/2024 06:49, Barry Song wrote:
> >>>>> On Fri, Oct 18, 2024 at 11:50=E2=80=AFPM Usama Arif <usamaarif642@g=
mail.com> wrote:
> >>>>>>
> >>>>>> At time of folio allocation, alloc_swap_folio checks if the entire
> >>>>>> folio is in zswap to determine folio order.
> >>>>>> During swap_read_folio, zswap_load will check if the entire folio
> >>>>>> is in zswap, and if it is, it will iterate through the pages in
> >>>>>> folio and decompress them.
> >>>>>> This will mean the benefits of large folios (fewer page faults, ba=
tched
> >>>>>> PTE and rmap manipulation, reduced lru list, TLB coalescing (for a=
rm64
> >>>>>> and amd) are not lost at swap out when using zswap.
> >>>>>> This patch does not add support for hybrid backends (i.e. folios
> >>>>>> partly present swap and zswap).
> >>>>>>
> >>>>>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> >>>>>> ---
> >>>>>>  mm/memory.c | 13 +++-------
> >>>>>>  mm/zswap.c  | 68 ++++++++++++++++++++++++------------------------=
-----
> >>>>>>  2 files changed, 34 insertions(+), 47 deletions(-)
> >>>>>>
> >>>>>> diff --git a/mm/memory.c b/mm/memory.c
> >>>>>> index 49d243131169..75f7b9f5fb32 100644
> >>>>>> --- a/mm/memory.c
> >>>>>> +++ b/mm/memory.c
> >>>>>> @@ -4077,13 +4077,14 @@ static bool can_swapin_thp(struct vm_fault=
 *vmf, pte_t *ptep, int nr_pages)
> >>>>>>
> >>>>>>         /*
> >>>>>>          * swap_read_folio() can't handle the case a large folio i=
s hybridly
> >>>>>> -        * from different backends. And they are likely corner cas=
es. Similar
> >>>>>> -        * things might be added once zswap support large folios.
> >>>>>> +        * from different backends. And they are likely corner cas=
es.
> >>>>>>          */
> >>>>>>         if (unlikely(swap_zeromap_batch(entry, nr_pages, NULL) !=
=3D nr_pages))
> >>>>>>                 return false;
> >>>>>>         if (unlikely(non_swapcache_batch(entry, nr_pages) !=3D nr_=
pages))
> >>>>>>                 return false;
> >>>>>> +       if (unlikely(!zswap_present_test(entry, nr_pages)))
> >>>>>> +               return false;

Hmm if the entire folio is not in zswap, this will prevent the large
folio swapin, right?

Also, I think this is racy, see the comments below and in patch 1.

> >>>>>>
> >>>>>>         return true;
> >>>>>>  }
> >>>>>> @@ -4130,14 +4131,6 @@ static struct folio *alloc_swap_folio(struc=
t vm_fault *vmf)
> >>>>>>         if (unlikely(userfaultfd_armed(vma)))
> >>>>>>                 goto fallback;
> >>>>>>
> >>>>>> -       /*
> >>>>>> -        * A large swapped out folio could be partially or fully i=
n zswap. We
> >>>>>> -        * lack handling for such cases, so fallback to swapping i=
n order-0
> >>>>>> -        * folio.
> >>>>>> -        */
> >>>>>> -       if (!zswap_never_enabled())
> >>>>>> -               goto fallback;
> >>>>>> -
> >>>>>>         entry =3D pte_to_swp_entry(vmf->orig_pte);
> >>>>>>         /*
> >>>>>>          * Get a list of all the (large) orders below PMD_ORDER th=
at are enabled
> >>>>>> diff --git a/mm/zswap.c b/mm/zswap.c
> >>>>>> index 9cc91ae31116..a5aa86c24060 100644
> >>>>>> --- a/mm/zswap.c
> >>>>>> +++ b/mm/zswap.c
> >>>>>> @@ -1624,59 +1624,53 @@ bool zswap_present_test(swp_entry_t swp, i=
nt nr_pages)
> >>>>>>
> >>>>>>  bool zswap_load(struct folio *folio)
> >>>>>>  {
> >>>>>> +       int nr_pages =3D folio_nr_pages(folio);
> >>>>>>         swp_entry_t swp =3D folio->swap;
> >>>>>> +       unsigned int type =3D swp_type(swp);
> >>>>>>         pgoff_t offset =3D swp_offset(swp);
> >>>>>>         bool swapcache =3D folio_test_swapcache(folio);
> >>>>>> -       struct xarray *tree =3D swap_zswap_tree(swp);
> >>>>>> +       struct xarray *tree;
> >>>>>>         struct zswap_entry *entry;
> >>>>>> +       int i;
> >>>>>>
> >>>>>>         VM_WARN_ON_ONCE(!folio_test_locked(folio));
> >>>>>>
> >>>>>>         if (zswap_never_enabled())
> >>>>>>                 return false;
> >>>>>>
> >>>>>> -       /*
> >>>>>> -        * Large folios should not be swapped in while zswap is be=
ing used, as
> >>>>>> -        * they are not properly handled. Zswap does not properly =
load large
> >>>>>> -        * folios, and a large folio may only be partially in zswa=
p.
> >>>>>> -        *
> >>>>>> -        * Return true without marking the folio uptodate so that =
an IO error is
> >>>>>> -        * emitted (e.g. do_swap_page() will sigbus).
> >>>>>> -        */
> >>>>>> -       if (WARN_ON_ONCE(folio_test_large(folio)))
> >>>>>> -               return true;
> >>>>>> -
> >>>>>> -       /*
> >>>>>> -        * When reading into the swapcache, invalidate our entry. =
The
> >>>>>> -        * swapcache can be the authoritative owner of the page an=
d
> >>>>>> -        * its mappings, and the pressure that results from having=
 two
> >>>>>> -        * in-memory copies outweighs any benefits of caching the
> >>>>>> -        * compression work.
> >>>>>> -        *
> >>>>>> -        * (Most swapins go through the swapcache. The notable
> >>>>>> -        * exception is the singleton fault on SWP_SYNCHRONOUS_IO
> >>>>>> -        * files, which reads into a private page and may free it =
if
> >>>>>> -        * the fault fails. We remain the primary owner of the ent=
ry.)
> >>>>>> -        */
> >>>>>> -       if (swapcache)
> >>>>>> -               entry =3D xa_erase(tree, offset);
> >>>>>> -       else
> >>>>>> -               entry =3D xa_load(tree, offset);
> >>>>>> -
> >>>>>> -       if (!entry)
> >>>>>> +       if (!zswap_present_test(folio->swap, nr_pages))
> >>>>>>                 return false;
> >>>>>
> >>>>> Hi Usama,
> >>>>>
> >>>>> Is there any chance that zswap_present_test() returns true
> >>>>> in do_swap_page() but false in zswap_load()? If that=E2=80=99s
> >>>>> possible, could we be missing something? For example,
> >>>>> could it be that zswap has been partially released (with
> >>>>> part of it still present) during an mTHP swap-in?

As I mentioned in patch 1, we need to document when the result of
zswap_present_test() is stable, and we can't race with other stores,
exclusive loads, writeback, or invalidation.

> >>>>>
> >>>>> If this happens with an mTHP, my understanding is that
> >>>>> we shouldn't proceed with reading corrupted data from the
> >>>>> disk backend.
> >>>>>
> >>>>
> >>>> If its not swapcache, the zswap entry is not deleted so I think
> >>>> it should be ok?

Can we race with things like writeback and other exclusive loads
because swapcache_prepare() is not called yet?

> >>>>
> >>>> We can check over here if the entire folio is in zswap,
> >>>> and if not, return true without marking the folio uptodate
> >>>> to give an error.
> >>>
> >>> We have swapcache_prepare() called in do_swap_page(), which should
> >>> have protected these entries from being partially freed by other proc=
esses
> >>> (for example, if someone falls back to small folios for the same addr=
ess).
> >>> Therefore, I believe that zswap_present_test() cannot be false for mT=
HP in
> >>> the current case where only synchronous I/O is supported.
> >>>
> >>> the below might help detect the bug?
> >>>
> >>> if (!zswap_present_test(folio->swap, nr_pages)) {
> >>>      if (WARN_ON_ONCE(nr_pages > 1))
> >>>                 return true;
> >>>      return false;
> >>> }
> >>>
> >>
> >> I think this isn't correct. If nr_pages > 1 and the entire folio is no=
t in zswap,
> >> it should still return false. So would need to check the whole folio i=
f we want to
> >> warn. But I think if we are sure the code is ok, it is an unnecessary =
check.
> >
> > my point is that zswap_present_test() can't differentiate
> > 1. the *whole* folio is not in zswap
> > 2. the folio is *partially* not in zswap
> >
> > in case 2, returning false is wrong.
> >
>
> Agreed!
>
> > And when nr_pages > 1, we have already confirmed earlier in
> > do_swap_page() that zswap_present_test() is true. At this point,
> > it must always be true; if it's false, it indicates a bug.
> >
>
> Yes agreed! I was thinking from just zswap_load perspective irrespective
> of who calls it.
> If someone adds large folio support to swapin_readahead, then I think the
> above warn might be an issue.
>
> But just with this patch series, doing what you suggested is correct. I
> will add it in next revision. We can deal with it once swap count > 1,
> starts supporting large folios.

I think I don't follow this part of the conversation properly, but it
seems like we want to catch the case where we end up in zswap_load()
and only part of the folio is in zswap. Can we use something like the
approach we used for swap_zeromap_batch()?

