Return-Path: <linux-kernel+bounces-265826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEC093F680
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 15:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ABFE1C22E13
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 13:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2B114A4DB;
	Mon, 29 Jul 2024 13:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6Xqy6/C"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE3D1E4A2
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 13:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722258706; cv=none; b=gfzWr07uHL/pcULFh0111CmyL4nTHYm/UmJX4WacWpi1ICYQeQXzabDDuYWXhLGfFbUgn24yNoJJyEhmpKJ47qsf5nPlNIyW/9XMMvuzAEGgsweOiwsRWxUHUCjryiHiCy2yULNJ9OMceiPYSJxqIe6cKT+jcixa9h9lrnyprwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722258706; c=relaxed/simple;
	bh=nuHwFmaZuF66FosG6G9p8k47Bw408eHl3B6+SllBQ0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NAppz15z4J1Q0JcNegaji1KBoQV6X+TgLHR/WyJGvQb1OwBUtCrGu7wd/neacBORQapxd7BwjzCKGQkhIWU26vZHbpyg0dWLR0kSvVITI7QioI0fGVn8cdAlO3ZX29uX7umUQZmydoGe1RDFlTfTyzIMvRSoPXEsrdlMq57nVJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6Xqy6/C; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7093f6adc4aso1052215a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 06:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722258704; x=1722863504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3WSLu8EoQdDVl08mnyxRcNNHTsb4HNhH5XlRCO141Xs=;
        b=T6Xqy6/CnNSXdE/9g8yETfsI/cE+KiwQ40eMTXQAmTtsurb3RO2ExjBhd4AP6gdKv/
         i55X9J9nidN9PgLx+PWe2oqvzr1/A5VpOJ8uXvdSp14+zSwK+qn93H0iUa7oDKBpWV3W
         9+OG7EaJGKw5RbykuZKOAt2pe/R0ItRgM1Rs8T68edO78pubANdcNS/zxMimTjPEqbGg
         D1hWX1yNWA8yne/X6aNZN9/EeXBOjOA22tOGvGxGBXlDrfZ0kb2LkD8Kbplt7/RuwqAM
         lnZb/bHnEr3JQZxnVaj67+uLv/7NI3D8G4goSHx1ipHAkyeEroUt7DU6QXtL+KyFezaG
         N2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722258704; x=1722863504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3WSLu8EoQdDVl08mnyxRcNNHTsb4HNhH5XlRCO141Xs=;
        b=iM8DoZRR3gDFQymq7zFP3fzu1XgVgt4QMD3sSkVoVrBMrmSxfKeeqr8xh2GrcrIUO2
         aHX1+J95Q3G5Q+0cCKsTCaRa8doVdL3TEbNp9TBY3rujJzwNUlajEOX+micjz90sesAE
         h/yUfdLH7dypMLB0L4C3s45xl56xJaiQtXCCzSYBlZd9BARMhRmBN0u6drhAPd/kCAYW
         YWp7znhdFk4zTWdaJ16rlJVJ7rJWH2i3EReEFUySjX2X1kC+4pfmzk8JDeMG4t8OsLIB
         gHSGHxgAoFIfBrVip0veGMAmCHllLv7PpntRadrTrjJMz5H97HsG+rtKq930p1UIzmjE
         ZxLw==
X-Forwarded-Encrypted: i=1; AJvYcCXt5qv7NveoHaaEQhGPe3T68GvivMOPEnVMI8NYQifEDp0l87a2/rIraW26qLFoaVl98hd82dwboKu1MKQdexHw7ORa4afHbpeiBuXn
X-Gm-Message-State: AOJu0YwCiAOnODfPn4k9W7phnAxC6K2BwtUenB1OJ6T7sJS9TTRHcjQp
	Ys5xBtgWbFx4tsOBGj38A1tWU8OdCOTnKZpcg+G1HEZN4FPO6XA7CihVF/vp3uSyOKrk1t2rcFL
	CaWYltPZVrlukIvdvs7zAXKmRAb4=
X-Google-Smtp-Source: AGHT+IFU+QINFGAya2niNBVb0ufZXq6q+wAd7lWoSTPXG/4pgfbJdZ8vn2G6RdrRjk++lFQDWxsT65uJuebiS8WiWAs=
X-Received: by 2002:a05:6358:10c:b0:1ac:f4a9:45 with SMTP id
 e5c5f4694b2df-1addc1458e1mr1196562555d.3.1722258704054; Mon, 29 Jul 2024
 06:11:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726094618.401593-1-21cnbao@gmail.com> <20240726094618.401593-4-21cnbao@gmail.com>
 <ZqcRqxGaJsAwZD3C@casper.infradead.org> <CAGsJ_4xQkPtw1Cw=2mcRjpTdp-c9tSFCuW_U6JKzJ3zHGYQWrA@mail.gmail.com>
 <CAGsJ_4wxUZAysyg3cCVnHhOFt5SbyAMUfq3tJcX-Wb6D4BiBhA@mail.gmail.com> <ZqePwtX4b18wiubO@casper.infradead.org>
In-Reply-To: <ZqePwtX4b18wiubO@casper.infradead.org>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 30 Jul 2024 01:11:31 +1200
Message-ID: <CAGsJ_4zXfYT4KxBnLx1F8tpK-5s6PX3PQ7wf7tteuzEyKS+ZPQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] mm: support large folios swapin as a whole for
 zRAM-like swapfile
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, ying.huang@intel.com, 
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com, 
	hannes@cmpxchg.org, hughd@google.com, kaleshsingh@google.com, 
	kasong@tencent.com, linux-kernel@vger.kernel.org, mhocko@suse.com, 
	minchan@kernel.org, nphamcs@gmail.com, ryan.roberts@arm.com, 
	senozhatsky@chromium.org, shakeel.butt@linux.dev, shy828301@gmail.com, 
	surenb@google.com, v-songbaohua@oppo.com, xiang@kernel.org, 
	yosryahmed@google.com, Chuanhua Han <hanchuanhua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 12:49=E2=80=AFAM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Mon, Jul 29, 2024 at 04:46:42PM +1200, Barry Song wrote:
> > On Mon, Jul 29, 2024 at 4:41=E2=80=AFPM Barry Song <21cnbao@gmail.com> =
wrote:
> > >
> > > On Mon, Jul 29, 2024 at 3:51=E2=80=AFPM Matthew Wilcox <willy@infrade=
ad.org> wrote:
> > > >
> > > > On Fri, Jul 26, 2024 at 09:46:17PM +1200, Barry Song wrote:
> > > > > -                     folio =3D vma_alloc_folio(GFP_HIGHUSER_MOVA=
BLE, 0,
> > > > > -                                             vma, vmf->address, =
false);
> > > > > +                     folio =3D alloc_swap_folio(vmf);
> > > > >                       page =3D &folio->page;
> > > >
> > > > This is no longer correct.  You need to set 'page' to the precise p=
age
> > > > that is being faulted rather than the first page of the folio.  It =
was
> > > > fine before because it always allocated a single-page folio, but no=
w it
> > > > must use folio_page() or folio_file_page() (whichever has the corre=
ct
> > > > semantics for you).
> > > >
> > > > Also you need to fix your test suite to notice this bug.  I suggest
> > > > doing that first so that you know whether you've got the calculatio=
n
> > > > correct.
> > >
> > > I don't understand why the code is designed in the way the page
> > > is the first page of this folio. Otherwise, we need lots of changes
> > > later while mapping the folio in ptes and rmap.
>
> What?
>
>         folio =3D swap_cache_get_folio(entry, vma, vmf->address);
>         if (folio)
>                 page =3D folio_file_page(folio, swp_offset(entry));
>
> page is the precise page, not the first page of the folio.

this is the case we may get a large folio in swapcache but we result in
mapping only one subpage due to the condition to map the whole
folio is not met. if we meet the condition, we are going to set page
to the head instead and map the whole mTHP:

        if (folio_test_large(folio) && folio_test_swapcache(folio)) {
                int nr =3D folio_nr_pages(folio);
                unsigned long idx =3D folio_page_idx(folio, page);
                unsigned long folio_start =3D address - idx * PAGE_SIZE;
                unsigned long folio_end =3D folio_start + nr * PAGE_SIZE;
                pte_t *folio_ptep;
                pte_t folio_pte;

                if (unlikely(folio_start < max(address & PMD_MASK,
vma->vm_start)))
                        goto check_folio;
                if (unlikely(folio_end > pmd_addr_end(address, vma->vm_end)=
))
                        goto check_folio;

                folio_ptep =3D vmf->pte - idx;
                folio_pte =3D ptep_get(folio_ptep);
                if (!pte_same(folio_pte,
pte_move_swp_offset(vmf->orig_pte, -idx)) ||
                    swap_pte_batch(folio_ptep, nr, folio_pte) !=3D nr)
                        goto check_folio;

                page_idx =3D idx;
                address =3D folio_start;
                ptep =3D folio_ptep;
                nr_pages =3D nr;
                entry =3D folio->swap;
                page =3D &folio->page;
        }

>
> > For both accessing large folios in the swapcache and allocating
> > new large folios, the page points to the first page of the folio. we
> > are mapping the whole folio not the specific page.
>
> But what address are we mapping the whole folio at?
>
> > for swapcache cases, you can find the same thing here,
> >
> >         if (folio_test_large(folio) && folio_test_swapcache(folio)) {
> >                 ...
> >                 entry =3D folio->swap;
> >                 page =3D &folio->page;
> >         }
>
> Yes, but you missed some important lines from your quote:
>
>                 page_idx =3D idx;
>                 address =3D folio_start;
>                 ptep =3D folio_ptep;
>                 nr_pages =3D nr;
>
> We deliberate adjust the address so that, yes, we're mapping the entire
> folio, but we're mapping it at an address that means that the page we
> actually faulted on ends up at the address that we faulted on.

for this zRAM case, it is a new allocated large folio, only
while all conditions are met, we will allocate and map
the whole folio. you can check can_swapin_thp() and
thp_swap_suitable_orders().

static bool can_swapin_thp(struct vm_fault *vmf, pte_t *ptep, int nr_pages)
{
        struct swap_info_struct *si;
        unsigned long addr;
        swp_entry_t entry;
        pgoff_t offset;
        char has_cache;
        int idx, i;
        pte_t pte;

        addr =3D ALIGN_DOWN(vmf->address, nr_pages * PAGE_SIZE);
        idx =3D (vmf->address - addr) / PAGE_SIZE;
        pte =3D ptep_get(ptep);

        if (!pte_same(pte, pte_move_swp_offset(vmf->orig_pte, -idx)))
                return false;
        entry =3D pte_to_swp_entry(pte);
        offset =3D swp_offset(entry);
        if (swap_pte_batch(ptep, nr_pages, pte) !=3D nr_pages)
                return false;

        si =3D swp_swap_info(entry);
        has_cache =3D si->swap_map[offset] & SWAP_HAS_CACHE;
        for (i =3D 1; i < nr_pages; i++) {
                /*
                 * while allocating a large folio and doing
swap_read_folio for the
                 * SWP_SYNCHRONOUS_IO path, which is the case the
being faulted pte
                 * doesn't have swapcache. We need to ensure all PTEs
have no cache
                 * as well, otherwise, we might go to swap devices
while the content
                 * is in swapcache
                 */
                if ((si->swap_map[offset + i] & SWAP_HAS_CACHE) !=3D has_ca=
che)
                        return false;
        }

        return true;
}

and

static struct folio *alloc_swap_folio(struct vm_fault *vmf)
{
        ....
        entry =3D pte_to_swp_entry(vmf->orig_pte);
        /*
         * Get a list of all the (large) orders below PMD_ORDER that are en=
abled
         * and suitable for swapping THP.
         */
        orders =3D thp_vma_allowable_orders(vma, vma->vm_flags,
                        TVA_IN_PF | TVA_IN_SWAPIN | TVA_ENFORCE_SYSFS,
                        BIT(PMD_ORDER) - 1);
        orders =3D thp_vma_suitable_orders(vma, vmf->address, orders);
        orders =3D thp_swap_suitable_orders(swp_offset(entry),
vmf->address, orders);
....
}

static inline unsigned long thp_swap_suitable_orders(pgoff_t swp_offset,
                unsigned long addr, unsigned long orders)
{
        int order, nr;

        order =3D highest_order(orders);

        /*
         * To swap-in a THP with nr pages, we require its first swap_offset
         * is aligned with nr. This can filter out most invalid entries.
         */
        while (orders) {
                nr =3D 1 << order;
                if ((addr >> PAGE_SHIFT) % nr =3D=3D swp_offset % nr)
                        break;
                order =3D next_order(&orders, order);
        }

        return orders;
}


A mTHP is swapped out at aligned swap offset. and we only swap in
aligned mTHP. if somehow one mTHP is mremap() to unaligned address,
we won't swap them in as a large folio. For swapcache case, we are
still checking unaligned mTHP, but for new allocated mTHP, it
is a different story. There is totally no necessity to support
unaligned mTHP and there is no possibility to support unless
something is marked in swap devices to say there was a mTHP.

Thanks
Barry

