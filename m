Return-Path: <linux-kernel+bounces-262818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C1B93CD1A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 05:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7377F2832DC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 03:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681AC2557F;
	Fri, 26 Jul 2024 03:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFe5TXeG"
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0392582
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 03:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721966012; cv=none; b=ZNIBeh6I4Hql8K8Qghp7qJiKZx1bkXoamohTFPvtwhDTB7kaaCkhxeqw6imVqkinBDDJQRp25dydStXqxMzDCB9LUPNyTCcihnKVrSLjfRcE8fLt9+aum25fZXWZNHAy/Fna9H/XinUmFVbgeFA59B6x+/DHrva86/jg2P3Q+SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721966012; c=relaxed/simple;
	bh=oH/b7ppMMzl/PU0MvsebN8GrF8GR2ohDfLcVxcCM8js=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KQ+kI4sstqGy9/7bmRktuFzLWUHsU2DSPq0OEBnERrvDV9YYbCxPPfqFeZDavr0HkgoATYecF1/w6n2GsSCkQd4l56rpE1XeiU8OwDYmqmooi6Mk08P3WJaW7ISfI9qoZ8YcNObTAPm56HUNGQy3lMyrGgtiKACglvwvGQX0HB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HFe5TXeG; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-831a5b7d250so63284241.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 20:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721966010; x=1722570810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BPyzrMlqeQRZ17+Ka9dRzkWQ9c9VHRZOmAi9r7+q1LM=;
        b=HFe5TXeGWv4wWX8Kz5YaWCOoVGuV1W0GMlPEgtsASx39G6N4Tm90NejnOH1APi85Eh
         KWBh3BTQGukuEbJINAo9PTQL//c9nhjY6ksZlOUo2XTVqjVGZcs+E9LVDuYmXWnJAj0W
         mtj2JajoHxSq+whquoyJp7YXL4NyPDBSpfdK/YNEa+QKyZJcgsQ6gr+ScIzoMusYVb2+
         8h8jQQMlQpAoPuiJgtw2h6icK8exQnwscB7I5/ShsCp8RDMIBE9Q+vTB9jxYVOvzKqW4
         mx4EOo2/aDkm3B2QSlpC+EL+BMXaOO5HbZ65rwHMGpwIOhCyYNaD72x81zDs4pef9PDL
         PWaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721966010; x=1722570810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BPyzrMlqeQRZ17+Ka9dRzkWQ9c9VHRZOmAi9r7+q1LM=;
        b=Xnc1OEeBDbxKh+8wSHvnO7BAGaHVpMZw8T3ZvkZMrrrTliiCbZkM+VLJBO2V2IEp7X
         XZXlFHkevgIvgl2gZv/iEXP5fa6ZskIw2DVN1gSUqD+jjdLwNAfalMCOd3b/7T8a5mYd
         FQaxLSRUgU/a2mX8eLa2zfuh3ugnEiXcNP/7hRmn4RRWf0PBZgtPE+iyRF2r6Ha/KYnK
         LB64G7jzr33Ht1itszvmpWisTZOrBh7D6DnHoDKpJzgh5nAtZi7FesjIjFFTpso2eBwb
         avQVZjD5z2rabHaKH0PK9QoYsCxRBhuNRGITBwIdWvpW+kxi8H4GkbLFKLXbPRfJ4i9C
         byGA==
X-Forwarded-Encrypted: i=1; AJvYcCXsHUiMxLF2ALkNoJDepHnNMRQclcs63UG1p5x/xmeO2cXOA+NPPuWeZOICGaOk2t2VKuxbd5LibNw9BGpRiWZ8YuZh/pyMy47F497Q
X-Gm-Message-State: AOJu0YzymF/qNvtdccqcBIyJkYbUC8ri4qHX/VLHCuTnNUWDFx3d9XEw
	rqfVfgfVrNoID5uENmBf36K9RfSJ8Vdab92R9lmzLUk7t00QO1Dyg41/VdjFO8/3EPz+4rcieBw
	hBeMdDoLg/7bEnyaB9d7v7/20QLY=
X-Google-Smtp-Source: AGHT+IENuHk+XYdmaKndbm1NyrRpo5lo+VKYKMgky8xiysVwKKilSKKOWdgqRnmVE6SDf3NzSrBUj++y55g8ri9HiVo=
X-Received: by 2002:a05:6102:6cb:b0:493:ddd1:d7fc with SMTP id
 ada2fe7eead31-493dfe5cb87mr3497359137.11.1721966009587; Thu, 25 Jul 2024
 20:53:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725035318.471-1-hailong.liu@oppo.com> <ZqI5V+5E3RNhuSwx@MiWiFi-R3L-srv>
 <20240725164003.ft6huabwa5dqoy2g@oppo.com> <ZqMKZ67YhzhbqYg9@MiWiFi-R3L-srv>
In-Reply-To: <ZqMKZ67YhzhbqYg9@MiWiFi-R3L-srv>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 26 Jul 2024 15:53:18 +1200
Message-ID: <CAGsJ_4z0AYTVoCJjTyZsku24kPfOTnu1KCms_NPevdNKW+6sdg@mail.gmail.com>
Subject: Re: [RFC PATCH v2] mm/vmalloc: fix incorrect __vmap_pages_range_noflush()
 if vm_area_alloc_pages() from high order fallback to order0
To: Baoquan He <bhe@redhat.com>
Cc: Hailong Liu <hailong.liu@oppo.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>, 
	Matthew Wilcox <willy@infradead.org>, Tangquan Zheng <zhengtangquan@oppo.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 2:31=E2=80=AFPM Baoquan He <bhe@redhat.com> wrote:
>
> On 07/26/24 at 12:40am, Hailong Liu wrote:
> > On Thu, 25. Jul 19:39, Baoquan He wrote:
> > > On 07/25/24 at 11:53am, hailong.liu@oppo.com wrote:
> > > > From: "Hailong.Liu" <hailong.liu@oppo.com>
> > > >
> > > > The scenario where the issue occurs is as follows:
> > > > CONFIG: vmap_allow_huge =3D true && 2M is for PMD_SIZE
> > > > kvmalloc(2M, __GFP_NOFAIL|GFP_XXX)
> > > >     __vmalloc_node_range(vm_flags=3DVM_ALLOW_HUGE_VMAP)
> > > >         vm_area_alloc_pages(order=3D9) --->allocs order9 failed and=
 fallback to order0
> > > >                                         and phys_addr is aligned wi=
th PMD_SIZE
> > > >             vmap_pages_range
> > > >                 vmap_pages_range_noflush
> > > >                     __vmap_pages_range_noflush(page_shift =3D 21) -=
---> incorrect vmap *huge* here
> > > >
> > > > In fact, as long as page_shift is not equal to PAGE_SHIFT, there
> > > > might be issues with the __vmap_pages_range_noflush().
> > > >
> > > > The patch also remove VM_ALLOW_HUGE_VMAP in kvmalloc_node(), There
> > > > are several reasons for this:
> > > > - This increases memory footprint because ALIGNMENT.
> > > > - This increases the likelihood of kvmalloc allocation failures.
> > > > - Without this it fixes the origin issue of kvmalloc with __GFP_NOF=
AIL may return NULL.
> > > > Besides if drivers want to vmap huge, user vmalloc_huge instead.
> > >
> > > Seem there are two issues you are folding into one patch:
> > Got it. I will separate in the next version.
> >
> > >
> > > one is the wrong informatin passed into __vmap_pages_range_noflush();
> > > the other is you want to take off VM_ALLOW_HUGE_VMAP on kvmalloc().
> > >
> > > About the 1st one, do you think below draft is OK to you?
> > >
> > > Pass out the fall back order and adjust the order and shift for later
> > > usage, mainly for vmap_pages_range().
> > >
> > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > index 260897b21b11..5ee9ae518f3d 100644
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -3508,9 +3508,9 @@ EXPORT_SYMBOL_GPL(vmap_pfn);
> > >
> > >  static inline unsigned int
> > >  vm_area_alloc_pages(gfp_t gfp, int nid,
> > > -           unsigned int order, unsigned int nr_pages, struct page **=
pages)
> > > +           unsigned int *page_order, unsigned int nr_pages, struct p=
age **pages)
> > >  {
> > > -   unsigned int nr_allocated =3D 0;
> > > +   unsigned int nr_allocated =3D 0, order =3D *page_order;
> > >     gfp_t alloc_gfp =3D gfp;
> > >     bool nofail =3D gfp & __GFP_NOFAIL;
> > >     struct page *page;
> > > @@ -3611,6 +3611,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
> > >             cond_resched();
> > >             nr_allocated +=3D 1U << order;
> > >     }
> > > +   *page_order =3D order;
> > >
> > >     return nr_allocated;
> > >  }
> > > @@ -3654,7 +3655,7 @@ static void *__vmalloc_area_node(struct vm_stru=
ct *area, gfp_t gfp_mask,
> > >     page_order =3D vm_area_page_order(area);
> > >
> > >     area->nr_pages =3D vm_area_alloc_pages(gfp_mask | __GFP_NOWARN,
> > > -           node, page_order, nr_small_pages, area->pages);
> > > +           node, &page_order, nr_small_pages, area->pages);
> > >
> > >     atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
> > >     if (gfp_mask & __GFP_ACCOUNT) {
> > > @@ -3686,6 +3687,10 @@ static void *__vmalloc_area_node(struct vm_str=
uct *area, gfp_t gfp_mask,
> > >             goto fail;
> > >     }
> > >
> > > +
> > > +   set_vm_area_page_order(area, page_order);
> > > +   page_shift =3D page_order + PAGE_SHIFT;
> > > +
> > >     /*
> > >      * page tables allocations ignore external gfp mask, enforce it
> > >      * by the scope API
> > >
> > The logic of this patch is somewhat similar to my first one. If high or=
der
> > allocation fails, it will go normal mapping.
> >
> > However I also save the fallback position. The ones before this positio=
n are
> > used for huge mapping, the ones >=3D position for normal mapping as Bar=
ry said.
> > "support the combination of PMD and PTE mapping". this  will take some
> > times as it needs to address the corner cases and do some tests.
>
> Hmm, we may not need to worry about the imperfect mapping. Currently
> there are two places setting VM_ALLOW_HUGE_VMAP: __kvmalloc_node_noprof()
> and vmalloc_huge().
>
> For vmalloc_huge(), it's called in below three interfaces which are all
> invoked during boot. Basically they can succeed to get required contiguou=
s
> physical memory. I guess that's why Tangquan only spot this issue on kvma=
lloc
> invocation when the required size exceeds e.g 2M. For kvmalloc_node(),
> we have told that in the code comment above __kvmalloc_node_noprof(),
> it's a best effort behaviour.
>
>  mm/mm_init.c <<alloc_large_system_hash>>
>  table =3D vmalloc_huge(size, gfp_flags);
>  net/ipv4/inet_hashtables.c <<inet_pernet_hashinfo_alloc>>
>  new_hashinfo->ehash =3D vmalloc_huge(ehash_entries * sizeof(struct inet_=
ehash_bucket),
>  net/ipv4/udp.c <<udp_pernet_table_alloc>>
>  udptable->hash =3D vmalloc_huge(hash_entries * 2 * sizeof(struct udp_hsl=
ot)
>
> Maybe we should add code comment or document to notice people that the
> contiguous physical pages are not guaranteed for vmalloc_huge() if you
> use it after boot.

Currently, the issue goes beyond just 'contiguous physical pages are
not guaranteed.'
The problem includes the likelihood of failure when trying to allocate
2MB of contiguous
memory. That's why I suggest we allow fallback to order-0 for
non-nofail allocations with
your proposed changes.

The only difference is that for non-nofail allocations, if we fall
back to order-0 and still
fail, the process will break. In the case of nofail, we always succeed
on the final
allocation.

>
> >
> > IMO, the draft can fix the current issue, it also does not have signifi=
cant side
> > effects. Barry, what do you think about this patch? If you think it's o=
kay,
> > I will split this patch into two: one to remove the VM_ALLOW_HUGE_VMAP =
and the
> > other to address the current mapping issue.
> >
> > --
> > help you, help me,
> > Hailong.
> >

Thanks
Barry

