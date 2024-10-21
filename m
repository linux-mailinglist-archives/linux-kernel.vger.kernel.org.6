Return-Path: <linux-kernel+bounces-374149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC76D9A6591
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3B881C224F7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D21A1E3DF3;
	Mon, 21 Oct 2024 10:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LEBqmA9d"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AE81E5019;
	Mon, 21 Oct 2024 10:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729508157; cv=none; b=V/wVoHjdJsTp8RZEctxqTNjlx2jSpNViwjg0LFHa/cgV5Y0tPAko+SFpZGUmhuCe3PnzntJNBuz7wOO6QPYSOdTC+HVCdkQSEZBGlHj3RzZIpJr48x3dFk/1L6K04//BCtB8wjrhXJCxJQs4HB1BPbcvxlUCVQdyp5fHjYJrJqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729508157; c=relaxed/simple;
	bh=PCtXJL290XL5PoeIQ7+iOwxksyU2RXN5xm9kHVeR/v4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H1NF9vAEQP6aSMHJcjchtxep8zoTYCMgGHVoYryOKWLVXyz2Ao2H+vLMFNr7LWP83SAjxB5l5a1XwHcnSelKK64dSDAM20SCPPiPTaXL2Z6p1yLP21a1kwx3u9Gqc+UcoXyojMMQhwt3hgMo9qUCOYTY3cDoQiySuZTGAY7mfEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LEBqmA9d; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-84fd057a993so1422949241.3;
        Mon, 21 Oct 2024 03:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729508154; x=1730112954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tw7cBq9HQW3Pz1bDK5GF0DqimDVbrISyogNutiUoZiY=;
        b=LEBqmA9dhll3deMzhRSyOmVotNQzD4CkfVwFKtJ/PhDk/5tUaoDYobJEs5aXCaeym1
         KRg8zjHZHtBohIr/O4wiMou/KOMT+Zf5OaODsg77cGh2TvFJ01PlWRKJ/rXgnot2+6uH
         uS+7KmiLCkBXQ8ISPb/Cir5oH2yqsPP4OMDzDe9gvh2/dkgxaujMoFmxf2u/bBCiuPN3
         9N33lN7PfheNeSkqk3eRlNUpZqqmH9URQirXZAEU7VSubtT3FiuWyBJGuk564/WBq5Zv
         4LNIxzkrXluPFOIy1atlr3I1avrfRiO37u0E1NVvyF9ltyLc+UJo6JYKjK3tfUUf49H9
         ArGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729508154; x=1730112954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tw7cBq9HQW3Pz1bDK5GF0DqimDVbrISyogNutiUoZiY=;
        b=acj9sqf+ldaUvuGyPu2jF5T55i36pdGY/D/mRhcLlaypRuDNk+Mkr+mp19w/BtDTgL
         ZaV6rSEnmYsTbO57sFYdEIsvrD/037VJkugSaZKQiYO7+d0bZxcCegHknI3GTfNtNfdZ
         uyd5Tg4gvewVpQHg6/zzIHxK2jY30druSkXLbqHl/SZ4jacN+EZqC5fQ1T1ZdTCTn2FO
         6gK+9HQS9chaYwAPqBEZuOkS3N26MoV4K9QjYhuVEegUcuroGn6c5+n4JDj+2ghEMsRP
         Wbfz4bf9dhd/ZUB8Ssjby+zO794qSz36SEks2Rq7Y6x5+ieEO//iB5ot7MUAmF2DFoYl
         9zHA==
X-Forwarded-Encrypted: i=1; AJvYcCUCHYllJLmk3KPxOl18cLPaOD32nemTXgF8f9jZ2B2aheAnSQodzEzuYAfq6JYZHPphAQUC/UOOSB+bjhh2@vger.kernel.org, AJvYcCVUZHrNScfG0izs4FXTcyRgsOE0ByQINVmctzkbs+1fPvjXmVVJPkvSNo48kxNWswQ6uyDQnatS2tg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoHCVYXVO6WRIt8BPYO9/TbTXmm5oNGNMyyx+AAl/h/PF9e0KY
	j5ZL+hB0hgFylQ1ruBPigL4xqr3StS3gzSa0lWwWUP+30hvxTQNx2VRrLGVJAo24SueN8MGtXO2
	X18iAoQpfzwM8e3jsDnR14v72F3E=
X-Google-Smtp-Source: AGHT+IEdjlJxKwJ1omUMr87/RX/IjlvDbVY998oAj7sVtses9psQKv5JM4L8n2RCnfIyFlSjf70Flssref2OPXschBc=
X-Received: by 2002:a05:6102:374b:b0:4a5:afbc:48a9 with SMTP id
 ada2fe7eead31-4a5d6ab7a18mr10286586137.8.1729508154141; Mon, 21 Oct 2024
 03:55:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018105026.2521366-1-usamaarif642@gmail.com>
 <20241018105026.2521366-4-usamaarif642@gmail.com> <CAGsJ_4xyDMUDxVhi0bzZJ4jAd_Hw8Hn25+4epO9u9=iu0QMdoA@mail.gmail.com>
 <ca158172-a100-4af6-98de-083d77cd9ed8@gmail.com>
In-Reply-To: <ca158172-a100-4af6-98de-083d77cd9ed8@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 21 Oct 2024 23:55:43 +1300
Message-ID: <CAGsJ_4x9YKi9BKmzOuOfaLrjr=kpQsiog=rAP3jJY=YQJ3Fupg@mail.gmail.com>
Subject: Re: [RFC 3/4] mm/zswap: add support for large folio zswapin
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	david@redhat.com, willy@infradead.org, kanchana.p.sridhar@intel.com, 
	yosryahmed@google.com, nphamcs@gmail.com, chengming.zhou@linux.dev, 
	ryan.roberts@arm.com, ying.huang@intel.com, riel@surriel.com, 
	shakeel.butt@linux.dev, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 11:44=E2=80=AFPM Usama Arif <usamaarif642@gmail.com=
> wrote:
>
>
>
> On 21/10/2024 06:49, Barry Song wrote:
> > On Fri, Oct 18, 2024 at 11:50=E2=80=AFPM Usama Arif <usamaarif642@gmail=
.com> wrote:
> >>
> >> At time of folio allocation, alloc_swap_folio checks if the entire
> >> folio is in zswap to determine folio order.
> >> During swap_read_folio, zswap_load will check if the entire folio
> >> is in zswap, and if it is, it will iterate through the pages in
> >> folio and decompress them.
> >> This will mean the benefits of large folios (fewer page faults, batche=
d
> >> PTE and rmap manipulation, reduced lru list, TLB coalescing (for arm64
> >> and amd) are not lost at swap out when using zswap.
> >> This patch does not add support for hybrid backends (i.e. folios
> >> partly present swap and zswap).
> >>
> >> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> >> ---
> >>  mm/memory.c | 13 +++-------
> >>  mm/zswap.c  | 68 ++++++++++++++++++++++++----------------------------=
-
> >>  2 files changed, 34 insertions(+), 47 deletions(-)
> >>
> >> diff --git a/mm/memory.c b/mm/memory.c
> >> index 49d243131169..75f7b9f5fb32 100644
> >> --- a/mm/memory.c
> >> +++ b/mm/memory.c
> >> @@ -4077,13 +4077,14 @@ static bool can_swapin_thp(struct vm_fault *vm=
f, pte_t *ptep, int nr_pages)
> >>
> >>         /*
> >>          * swap_read_folio() can't handle the case a large folio is hy=
bridly
> >> -        * from different backends. And they are likely corner cases. =
Similar
> >> -        * things might be added once zswap support large folios.
> >> +        * from different backends. And they are likely corner cases.
> >>          */
> >>         if (unlikely(swap_zeromap_batch(entry, nr_pages, NULL) !=3D nr=
_pages))
> >>                 return false;
> >>         if (unlikely(non_swapcache_batch(entry, nr_pages) !=3D nr_page=
s))
> >>                 return false;
> >> +       if (unlikely(!zswap_present_test(entry, nr_pages)))
> >> +               return false;
> >>
> >>         return true;
> >>  }
> >> @@ -4130,14 +4131,6 @@ static struct folio *alloc_swap_folio(struct vm=
_fault *vmf)
> >>         if (unlikely(userfaultfd_armed(vma)))
> >>                 goto fallback;
> >>
> >> -       /*
> >> -        * A large swapped out folio could be partially or fully in zs=
wap. We
> >> -        * lack handling for such cases, so fallback to swapping in or=
der-0
> >> -        * folio.
> >> -        */
> >> -       if (!zswap_never_enabled())
> >> -               goto fallback;
> >> -
> >>         entry =3D pte_to_swp_entry(vmf->orig_pte);
> >>         /*
> >>          * Get a list of all the (large) orders below PMD_ORDER that a=
re enabled
> >> diff --git a/mm/zswap.c b/mm/zswap.c
> >> index 9cc91ae31116..a5aa86c24060 100644
> >> --- a/mm/zswap.c
> >> +++ b/mm/zswap.c
> >> @@ -1624,59 +1624,53 @@ bool zswap_present_test(swp_entry_t swp, int n=
r_pages)
> >>
> >>  bool zswap_load(struct folio *folio)
> >>  {
> >> +       int nr_pages =3D folio_nr_pages(folio);
> >>         swp_entry_t swp =3D folio->swap;
> >> +       unsigned int type =3D swp_type(swp);
> >>         pgoff_t offset =3D swp_offset(swp);
> >>         bool swapcache =3D folio_test_swapcache(folio);
> >> -       struct xarray *tree =3D swap_zswap_tree(swp);
> >> +       struct xarray *tree;
> >>         struct zswap_entry *entry;
> >> +       int i;
> >>
> >>         VM_WARN_ON_ONCE(!folio_test_locked(folio));
> >>
> >>         if (zswap_never_enabled())
> >>                 return false;
> >>
> >> -       /*
> >> -        * Large folios should not be swapped in while zswap is being =
used, as
> >> -        * they are not properly handled. Zswap does not properly load=
 large
> >> -        * folios, and a large folio may only be partially in zswap.
> >> -        *
> >> -        * Return true without marking the folio uptodate so that an I=
O error is
> >> -        * emitted (e.g. do_swap_page() will sigbus).
> >> -        */
> >> -       if (WARN_ON_ONCE(folio_test_large(folio)))
> >> -               return true;
> >> -
> >> -       /*
> >> -        * When reading into the swapcache, invalidate our entry. The
> >> -        * swapcache can be the authoritative owner of the page and
> >> -        * its mappings, and the pressure that results from having two
> >> -        * in-memory copies outweighs any benefits of caching the
> >> -        * compression work.
> >> -        *
> >> -        * (Most swapins go through the swapcache. The notable
> >> -        * exception is the singleton fault on SWP_SYNCHRONOUS_IO
> >> -        * files, which reads into a private page and may free it if
> >> -        * the fault fails. We remain the primary owner of the entry.)
> >> -        */
> >> -       if (swapcache)
> >> -               entry =3D xa_erase(tree, offset);
> >> -       else
> >> -               entry =3D xa_load(tree, offset);
> >> -
> >> -       if (!entry)
> >> +       if (!zswap_present_test(folio->swap, nr_pages))
> >>                 return false;
> >
> > Hi Usama,
> >
> > Is there any chance that zswap_present_test() returns true
> > in do_swap_page() but false in zswap_load()? If that=E2=80=99s
> > possible, could we be missing something? For example,
> > could it be that zswap has been partially released (with
> > part of it still present) during an mTHP swap-in?
> >
> > If this happens with an mTHP, my understanding is that
> > we shouldn't proceed with reading corrupted data from the
> > disk backend.
> >
>
> If its not swapcache, the zswap entry is not deleted so I think
> it should be ok?
>
> We can check over here if the entire folio is in zswap,
> and if not, return true without marking the folio uptodate
> to give an error.

We have swapcache_prepare() called in do_swap_page(), which should
have protected these entries from being partially freed by other processes
(for example, if someone falls back to small folios for the same address).
Therefore, I believe that zswap_present_test() cannot be false for mTHP in
the current case where only synchronous I/O is supported.

the below might help detect the bug?

if (!zswap_present_test(folio->swap, nr_pages)) {
     if (WARN_ON_ONCE(nr_pages > 1))
                return true;
     return false;
}

the code seems quite ugly :-) do we have some way to unify the code
for large and small folios?

not quite sure about shmem though....

>
>
> >>
> >> -       zswap_decompress(entry, &folio->page);
> >> +       for (i =3D 0; i < nr_pages; ++i) {
> >> +               tree =3D swap_zswap_tree(swp_entry(type, offset + i));
> >> +               /*
> >> +                * When reading into the swapcache, invalidate our ent=
ry. The
> >> +                * swapcache can be the authoritative owner of the pag=
e and
> >> +                * its mappings, and the pressure that results from ha=
ving two
> >> +                * in-memory copies outweighs any benefits of caching =
the
> >> +                * compression work.
> >> +                *
> >> +                * (Swapins with swap count > 1 go through the swapcac=
he.
> >> +                * For swap count =3D=3D 1, the swapcache is skipped a=
nd we
> >> +                * remain the primary owner of the entry.)
> >> +                */
> >> +               if (swapcache)
> >> +                       entry =3D xa_erase(tree, offset + i);
> >> +               else
> >> +                       entry =3D xa_load(tree, offset + i);
> >>
> >> -       count_vm_event(ZSWPIN);
> >> -       if (entry->objcg)
> >> -               count_objcg_events(entry->objcg, ZSWPIN, 1);
> >> +               zswap_decompress(entry, folio_page(folio, i));
> >>
> >> -       if (swapcache) {
> >> -               zswap_entry_free(entry);
> >> -               folio_mark_dirty(folio);
> >> +               if (entry->objcg)
> >> +                       count_objcg_events(entry->objcg, ZSWPIN, 1);
> >> +               if (swapcache)
> >> +                       zswap_entry_free(entry);
> >>         }
> >>
> >> +       count_vm_events(ZSWPIN, nr_pages);
> >> +       if (swapcache)
> >> +               folio_mark_dirty(folio);
> >> +
> >>         folio_mark_uptodate(folio);
> >>         return true;
> >>  }
> >> --
> >> 2.43.5
> >>
> >

Thanks
barry

