Return-Path: <linux-kernel+bounces-263045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F014E93D047
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 11:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EFB628322A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 09:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D630C178395;
	Fri, 26 Jul 2024 09:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3nLcaOh"
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9CA178372
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 09:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721985351; cv=none; b=AXO9y/qS6jGL1GIGtUC480KXCZUB6HMGAF6sY0G4zG3FAbgV/8C7tDsayoULSxkGkxC0bm83dQ64dhlHQcNH1cstDxc7unV6D4AAfVWXLLU51e9Zdrl3jxbkQPvQULIEBbRMcVzwSMNYesT9EDLtxw5juPapPDbodzFUsOLDRF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721985351; c=relaxed/simple;
	bh=TxnDTTrU1XLBDXUhBaE7WpCNYMdSalx+CqrjnL6Qq0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gLvhq0byxHgulUXK70n0D0Xf//8baVhzmy8FYdYNfsR5pymjvuD55KIog/brYVpXcJBCejhoxDifubb8hqGVqEzH/EzZASphOZ18BT2dAlnRz8jyUgcCu3GRzIXn/VZc31UcaSCx1GCD5QN6wohlBoDdcxoJEkd/BrEi9wurksE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3nLcaOh; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-826fee202d3so179913241.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 02:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721985348; x=1722590148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MHUp/YEibHMgEvyjOywFC1rVXXKb5KCbG4vI6T8V30Y=;
        b=M3nLcaOhVNQ+QNZaF8bZiV2u18V47LpoXxT3OyCunHzLwfJ+so0dJbm5c3102+S2gd
         X3eMIRGg+9jr3IW3wWDyUCnEEFcNY+zZfTXT5OojVb/YGvCfrF93h61uVyMHSw1drOTR
         Av//EfWpnu98LgUL1iTbDsLGTGZNIbZQA3ZGgwL2Q9UXYFmKdXMqeQxTH1TPl4obuef+
         diMDI9miaKnvWm6uCQUMd/rG5kDIgDSEsudcu2FZZeg6n8MIoYi52cNamCbIAcopOWBs
         jkKX/NEWCrPkTPX4qdbY2OkQ5AtBbs9avQZ7zpKszDKdvH+0ABj89+G0D2UMqpAc41Dy
         V6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721985348; x=1722590148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MHUp/YEibHMgEvyjOywFC1rVXXKb5KCbG4vI6T8V30Y=;
        b=LTl3aGyoDQUl7GWaq8DUZXtsDmkA/f5jmdWdT7ae6jk/ve0PaI79yWfnKFfFm5lRDb
         Tk9rx0mdW9iYDm48JKO/1QdGmhL3qEM2dy5AcEfJaXLmGu6AAgzCn8NEjSf6pW3T8OwT
         gQapCboZTLDRozF5WZYiGx0EYOJMEZQoMz3hDQczUIw5LoO7hxg5fK0EN6c1H9oZG5Mi
         OQMbsm8PJmi2ySYeUO3qztMwGSo+z5qHXH6EXd3raxlK6TGnlGhL34R7baRKCL9/CjJF
         epkMWjqtzaEVz0SKYz9eFqPjGq51xvGjnI6sTLhnCxIV38PQPWQ4ML5/ulNNKF7HSUTu
         FlPQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/LKoctd8xfouVTEBtcma2NwwHo8tnfdhADRWku75rV7+nCFXIeOze16rhbZTrKphpXfyk1A1fQvu3gAcI8ypJviRdpJICn9KPuE1a
X-Gm-Message-State: AOJu0Yw2CzWaBDBET4Md/7NteLQNawanRMF6zSiSJc4TCTgo0tPA+0yh
	c86Sae09EBGbesaY+vtwnHaeXRz/wSQObxlCLUzmPVEfTHbBqqL+QIlCmYz2JqKLOYgAsCuKkKQ
	BY6XnTY5xlC/9/JfLIoi0o2re1W8=
X-Google-Smtp-Source: AGHT+IFyu/OD7RMD2Zd6YdOZ7bBTZ3lTg4KPjPn3NrIv7gG22SyGWtP5Oz15hh8AuJkZ0SkOhlkwF8Fwq7t0qb/lt78=
X-Received: by 2002:a05:6102:4b14:b0:48f:e4b0:81b4 with SMTP id
 ada2fe7eead31-493d99f776dmr5997687137.7.1721985348084; Fri, 26 Jul 2024
 02:15:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725035318.471-1-hailong.liu@oppo.com> <ZqI5V+5E3RNhuSwx@MiWiFi-R3L-srv>
 <20240725164003.ft6huabwa5dqoy2g@oppo.com> <ZqMKZ67YhzhbqYg9@MiWiFi-R3L-srv>
 <20240726040052.hs2gvpktrnlbvhsq@oppo.com> <20240726050356.ludmpxfee6erlxxt@oppo.com>
 <CAGsJ_4xOauOwkHO5MTKHBP=fpeoNiP_9VJ31G4gBECFvLG4y0g@mail.gmail.com> <ZqNgY1T/VuWQvtfL@MiWiFi-R3L-srv>
In-Reply-To: <ZqNgY1T/VuWQvtfL@MiWiFi-R3L-srv>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 26 Jul 2024 21:15:36 +1200
Message-ID: <CAGsJ_4x6QLExJZ4=oOnVteEqm74rJBuCMwgkvjJuj4BsLtXFFw@mail.gmail.com>
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

On Fri, Jul 26, 2024 at 8:38=E2=80=AFPM Baoquan He <bhe@redhat.com> wrote:
>
> On 07/26/24 at 05:29pm, Barry Song wrote:
> > On Fri, Jul 26, 2024 at 5:04=E2=80=AFPM Hailong Liu <hailong.liu@oppo.c=
om> wrote:
> > >
> > > On Fri, 26. Jul 12:00, Hailong Liu wrote:
> > > > On Fri, 26. Jul 10:31, Baoquan He wrote:
> > > > [...]
> > > > > > The logic of this patch is somewhat similar to my first one. If=
 high order
> > > > > > allocation fails, it will go normal mapping.
> > > > > >
> > > > > > However I also save the fallback position. The ones before this=
 position are
> > > > > > used for huge mapping, the ones >=3D position for normal mappin=
g as Barry said.
> > > > > > "support the combination of PMD and PTE mapping". this  will ta=
ke some
> > > > > > times as it needs to address the corner cases and do some tests=
.
> > > > >
> > > > > Hmm, we may not need to worry about the imperfect mapping. Curren=
tly
> > > > > there are two places setting VM_ALLOW_HUGE_VMAP: __kvmalloc_node_=
noprof()
> > > > > and vmalloc_huge().
> > > > >
> > > > > For vmalloc_huge(), it's called in below three interfaces which a=
re all
> > > > > invoked during boot. Basically they can succeed to get required c=
ontiguous
> > > > > physical memory. I guess that's why Tangquan only spot this issue=
 on kvmalloc
> > > > > invocation when the required size exceeds e.g 2M. For kvmalloc_no=
de(),
> > > > > we have told that in the code comment above __kvmalloc_node_nopro=
f(),
> > > > > it's a best effort behaviour.
> > > > >
> > > > Take a __vmalloc_node_range(2.1M, VM_ALLOW_HUGE_VMAP) as a example.
> > > > because the align requirement of huge. the real size is 4M.
> > > > if allocation first order-9 successfully and the next failed. becua=
se the
> > > > fallback, the layout out pages would be like order9 - 512 * order0
> > > > order9 support huge mapping, but order0 not.
> > > > with the patch above, would call vmap_small_pages_range_noflush() a=
nd do normal
> > > > mapping, the huge mapping would not exist.
> > > >
> > > > >  mm/mm_init.c <<alloc_large_system_hash>>
> > > > >  table =3D vmalloc_huge(size, gfp_flags);
> > > > >  net/ipv4/inet_hashtables.c <<inet_pernet_hashinfo_alloc>>
> > > > >  new_hashinfo->ehash =3D vmalloc_huge(ehash_entries * sizeof(stru=
ct inet_ehash_bucket),
> > > > >  net/ipv4/udp.c <<udp_pernet_table_alloc>>
> > > > >  udptable->hash =3D vmalloc_huge(hash_entries * 2 * sizeof(struct=
 udp_hslot)
> > > > >
> > > > > Maybe we should add code comment or document to notice people tha=
t the
> > > > > contiguous physical pages are not guaranteed for vmalloc_huge() i=
f you
> > > > > use it after boot.
> > > > >
> > > > > >
> > > > > > IMO, the draft can fix the current issue, it also does not have=
 significant side
> > > > > > effects. Barry, what do you think about this patch? If you thin=
k it's okay,
> > > > > > I will split this patch into two: one to remove the VM_ALLOW_HU=
GE_VMAP and the
> > > > > > other to address the current mapping issue.
> > > > > >
> > > > > > --
> > > > > > help you, help me,
> > > > > > Hailong.
> > > > > >
> > > > >
> > > > >
> > > I check the code, the issue only happen in gfp_mask with __GFP_NOFAIL=
 and
> > > fallback to order 0, actuaally without this commit
> > > e9c3cda4d86e ("mm, vmalloc: fix high order __GFP_NOFAIL allocations")
> > > if __vmalloc_area_node allocation failed, it will goto fail and try o=
rder-0.
> > >
> > > fail:
> > >         if (shift > PAGE_SHIFT) {
> > >                 shift =3D PAGE_SHIFT;
> > >                 align =3D real_align;
> > >                 size =3D real_size;
> > >                 goto again;
> > >         }
> > >
> > > So do we really need fallback to order-0 if nofail?
> >
> > Good catch, this is what I missed. I feel we can revert Michal's fix.
> > And just remove __GFP_NOFAIL bit when we are still allocating
> > by high-order. When "goto again" happens, we will allocate by
> > order-0, in this case, we keep the __GFP_NOFAIL.
>
> With Michal's patch, the fallback will be able to satisfy the allocation
> for nofail case because it fallback to 0-order plus __GFP_NOFAIL. The

My point is that vm_area_alloc_pages() is an internal function and
just an implementation
detail. As long as its caller, __vmalloc_area_node(), can support
NOFAIL, it's fine.
Therefore, we can skip NOFAIL support for high-order allocations in
vm_area_alloc_pages()
and limit GFP_NOFAIL support to order-0.

Good news is that __vmalloc_node_range_noprof() has already a way to fallba=
ck
to order-0

fail:
        if (shift > PAGE_SHIFT) {
                shift =3D PAGE_SHIFT;
                align =3D real_align;
                size =3D real_size;
                goto again;
        }

So, we can definitely utilize this fallback instead of implementing it
within vm_area_alloc_pages(),
which would alter the page_order of vm_area and create inconsistency,
crashing the system
due to memory corruption.

With higher-level fallback in __vmalloc_node_range_noprof(), we won't
need an unusual fix-up
for vm_area as you're proposing. The page_order of vm_area will
consistently stay the same.

If there is any way to improvement, we may also add:

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index caf032f0bd69..03d8148d7a02 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3806,7 +3806,7 @@ void *__vmalloc_node_range_noprof(unsigned long
size, unsigned long align,
                warn_alloc(gfp_mask, NULL,
                        "vmalloc error: size %lu, vm_struct allocation
failed%s",
                        real_size, (nofail) ? ". Retrying." : "");
-               if (nofail) {
+               if (nofail && shift =3D=3D PAGE_SHIFT) {
                        schedule_timeout_uninterruptible(1);
                        goto again;
                }

There's no need to keep retrying for __get_vm_area_node() until success,
as we will succeed when we fall back to order-0.

> 'if (shift > PAGE_SHIFT)' conditional checking and handling may be
> problemtic since it could jump to fail becuase vmap_pages_range()
> invocation failed, or partially allocate huge parges and break down,
> then it will ignore the already allocated pages, and do all the thing aga=
in.
>
> The only thing 'if (shift > PAGE_SHIFT)' checking and handling makes
> sense is it fallback to the real_size and real_align. BUT we need handle
> the fail separately, e.g
> 1)__get_vm_area_node() failed;
> 2)vm_area_alloc_pages() failed when shift > PAGE_SHIFT and non-nofail;
> 3)vmap_pages_range() failed;
>
> Honestly, I didn't see where the nofail is mishandled, could you point
> it out specifically? I could miss it.
>
> Thanks
> Baoquan
>

Thanks
Barry

