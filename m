Return-Path: <linux-kernel+bounces-198825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A06E08D7DFC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 11:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2824E283BC7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 09:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA12495CC;
	Mon,  3 Jun 2024 09:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dd5up57S"
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840171E49F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 09:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717405299; cv=none; b=PjnEehP41BbOFUUKRibSdKfi01D9dcvruAhxP7uwBRUQ41gIndmvUlJXLDogULS+IL6llAw+uQfeaU2i7gt72IrNXXm8hM9eeQRhBhzWwS8EFajESR/ZsaPsS+JnmoiWB7DLGdmPjTXatPbHRxvASvQbI6+PEvXm7++4TUdbETc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717405299; c=relaxed/simple;
	bh=uIvMBZ7jb+OCtRPk7vonydYlkGugome8aqXhAxpRxKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qAstukM30na7fwryjU0d+RaaWMNGgLUxf9TzDeoz12Jo8eoWoktY1tRK6E8KVnFhK+Dd8D2D6fY1hva74ujQXgqBH1Tu7aL5/Wez/7iepEeXQVbjovnEBNppPjMg6tBIEuVtVSVXcn5OO3nrh+xP9jI7UwfXBs0nSgoPKTlYDBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dd5up57S; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4eafded3c66so1355122e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 02:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717405295; x=1718010095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tPFZKlBIY+L1Skh2mqsY6hChJ2s59haycgaaejzLJUE=;
        b=dd5up57S1v1tqkkniJwx5YRBxRyzPTdnxwCjngaVmMo29VbKlAPsEeIjYbXar0vKo7
         j2tKZi3KVGo8ajBl4lPSUY8Qw3NEXZPcMP7AJH2egq2t3ReULL9RZpxXfPk8GfeeTioA
         u1cyZGxj3D1P+Ixb7aMESzKg5a0S2dlISm070AbFZgcUxE1mEkvwhmIbtTXKMpqab4JE
         jSCz9isB/Ldg46KablI0zaR11A6oThil04dYPvNp66R41yHPdlfDGCdi4aUDB8f1AaQg
         ECvug8uzYDu04I7gOFu7ygfNmZAHD8n4xmJ3YoJ+mWyh5yIVCZjCM6jHWi46KfNq/Iik
         0yZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717405295; x=1718010095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tPFZKlBIY+L1Skh2mqsY6hChJ2s59haycgaaejzLJUE=;
        b=mCAoZCHI/6Zd1Rn10M2LWMwg93mVux008g9+pwWi09DOy48TInQHCbIAZpP4wCdmaa
         LkYQgxROP9F4GC/LbC4aC5RY2VcoWclz0NUkXSYlUuEXdQK/ybSYkslfJsGrU3+earBF
         CQYoNzzct2v5QLtbFzGsuX5BVAsDwCXLKwi0HgnLG/jZpo9yN1K86M8tFFdquLiqlSkb
         uMJ3VDIi07ysubj5tgTbD+NcsubABbZj6sDt7Erqn/3A6n++yPushTxijatps+ILfpKw
         PBuoS1szfNgGabjeXJrrfrqbsBbLcJg8WYUB8oqzt6HT4L4TkOJCJg0+C7ikj/2tG5aP
         sS+g==
X-Forwarded-Encrypted: i=1; AJvYcCWvh84iTmMuUR9TWAkwLXHtaAFGMINckK9GMEG7lkmSZZBV2YnbLaGVp27KoHdjmssYNKzypTOw6hvio+maxfkejfDcG8s5qPP5cQac
X-Gm-Message-State: AOJu0YyR4si1wJ6PLlAbZiApSctFi9O6joQ9rsXOC89+6abcKaQZnakr
	GDbzfO+FOHnSkfB4nosHiJOBG1RQ0gLLeWmqX6k6zJPj7hLdK/cFMJurQi1vvyYHGB4dpN3i/nv
	tLcUFjhdq3K7+vKxTewV4BCPxTiM=
X-Google-Smtp-Source: AGHT+IHYGXU8wDQ/HC0H0lRWd8kGHs1Z7OHR6aT/4YuXZBaLaDF8nPL8a2Hixk9N2C88EbcxWE+fxpIugGkKr5aw/Ds=
X-Received: by 2002:a05:6122:316:b0:4e4:e9db:6b10 with SMTP id
 71dfb90a1353d-4eb02d76968mr7015626e0c.2.1717405295157; Mon, 03 Jun 2024
 02:01:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1717033868.git.baolin.wang@linux.alibaba.com>
 <bf80d4a792ea82ab066f819ad7d10ed22a2f8e66.1717033868.git.baolin.wang@linux.alibaba.com>
 <CAGsJ_4z60mrjuQ5qKCKn0+knk_M1dy=NsH4nVLqe5Khue_5gFw@mail.gmail.com>
 <e05df24a-6254-430e-88ca-6db23e5c6bab@linux.alibaba.com> <CAGsJ_4zsR=xA4sCSyMc0OafaRdp7ibRGpdc00mDFEqT6pSQbKA@mail.gmail.com>
In-Reply-To: <CAGsJ_4zsR=xA4sCSyMc0OafaRdp7ibRGpdc00mDFEqT6pSQbKA@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 3 Jun 2024 21:01:24 +1200
Message-ID: <CAGsJ_4yKaag+ryGvS=JMoYBXaKRTUoMacNXxgUCGe4YjucdqbQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] mm: memory: extend finish_fault() to support large folio
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, hughd@google.com, willy@infradead.org, 
	david@redhat.com, wangkefeng.wang@huawei.com, ying.huang@intel.com, 
	ryan.roberts@arm.com, shy828301@gmail.com, ziy@nvidia.com, 
	ioworker0@gmail.com, da.gomez@samsung.com, p.raghav@samsung.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 8:58=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrote=
:
>
> On Mon, Jun 3, 2024 at 8:29=E2=80=AFPM Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
> >
> >
> >
> > On 2024/6/3 13:28, Barry Song wrote:
> > > On Thu, May 30, 2024 at 2:04=E2=80=AFPM Baolin Wang
> > > <baolin.wang@linux.alibaba.com> wrote:
> > >>
> > >> Add large folio mapping establishment support for finish_fault() as =
a preparation,
> > >> to support multi-size THP allocation of anonymous shmem pages in the=
 following
> > >> patches.
> > >>
> > >> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > >> ---
> > >>   mm/memory.c | 58 ++++++++++++++++++++++++++++++++++++++++++++-----=
----
> > >>   1 file changed, 48 insertions(+), 10 deletions(-)
> > >>
> > >> diff --git a/mm/memory.c b/mm/memory.c
> > >> index eef4e482c0c2..435187ff7ea4 100644
> > >> --- a/mm/memory.c
> > >> +++ b/mm/memory.c
> > >> @@ -4831,9 +4831,12 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
> > >>   {
> > >>          struct vm_area_struct *vma =3D vmf->vma;
> > >>          struct page *page;
> > >> +       struct folio *folio;
> > >>          vm_fault_t ret;
> > >>          bool is_cow =3D (vmf->flags & FAULT_FLAG_WRITE) &&
> > >>                        !(vma->vm_flags & VM_SHARED);
> > >> +       int type, nr_pages, i;
> > >> +       unsigned long addr =3D vmf->address;
> > >>
> > >>          /* Did we COW the page? */
> > >>          if (is_cow)
> > >> @@ -4864,24 +4867,59 @@ vm_fault_t finish_fault(struct vm_fault *vmf=
)
> > >>                          return VM_FAULT_OOM;
> > >>          }
> > >>
> > >> +       folio =3D page_folio(page);
> > >> +       nr_pages =3D folio_nr_pages(folio);
> > >> +
> > >> +       /*
> > >> +        * Using per-page fault to maintain the uffd semantics, and =
same
> > >> +        * approach also applies to non-anonymous-shmem faults to av=
oid
> > >> +        * inflating the RSS of the process.
> > >
> > > I don't feel the comment explains the root cause.
> > > For non-shmem, anyway we have allocated the memory? Avoiding inflatin=
g
> > > RSS seems not so useful as we have occupied the memory. the memory fo=
otprint
> >
> > This is also to keep the same behavior as before for non-anon-shmem, an=
d
> > will be discussed in the future.
>
> OK.
>
> >
> > > is what we really care about. so we want to rely on read-ahead hints =
of subpage
> > > to determine read-ahead size? that is why we don't map nr_pages for n=
on-shmem
> > > files though we can potentially reduce nr_pages - 1 page faults?
> >
> > IMHO, there is 2 cases for non-anon-shmem:
> > (1) read mmap() faults: we can rely on the 'fault_around_bytes'
> > interface to determin what size of mapping to build.
> > (2) writable mmap() faults: I want to keep the same behavior as before
> > (per-page fault), but we can talk about this when I send new patches to
> > use mTHP to control large folio allocation for writable mmap().
>
> OK.
>
> >
> > >> +        */
> > >> +       if (!vma_is_anon_shmem(vma) || unlikely(userfaultfd_armed(vm=
a))) {
> > >> +               nr_pages =3D 1;
> > >> +       } else if (nr_pages > 1) {
> > >> +               pgoff_t idx =3D folio_page_idx(folio, page);
> > >> +               /* The page offset of vmf->address within the VMA. *=
/
> > >> +               pgoff_t vma_off =3D vmf->pgoff - vmf->vma->vm_pgoff;
> > >> +
> > >> +               /*
> > >> +                * Fallback to per-page fault in case the folio size=
 in page
> > >> +                * cache beyond the VMA limits.
> > >> +                */
> > >> +               if (unlikely(vma_off < idx ||
> > >> +                            vma_off + (nr_pages - idx) > vma_pages(=
vma))) {
> > >> +                       nr_pages =3D 1;
> > >> +               } else {
> > >> +                       /* Now we can set mappings for the whole lar=
ge folio. */
> > >> +                       addr =3D vmf->address - idx * PAGE_SIZE;
> > >> +                       page =3D &folio->page;
> > >> +               }
> > >> +       }
> > >> +
> > >>          vmf->pte =3D pte_offset_map_lock(vma->vm_mm, vmf->pmd,
> > >> -                                     vmf->address, &vmf->ptl);
> > >> +                                      addr, &vmf->ptl);
> > >>          if (!vmf->pte)
> > >>                  return VM_FAULT_NOPAGE;
> > >>
> > >>          /* Re-check under ptl */
> > >> -       if (likely(!vmf_pte_changed(vmf))) {
> > >> -               struct folio *folio =3D page_folio(page);
> > >> -               int type =3D is_cow ? MM_ANONPAGES : mm_counter_file=
(folio);
> > >> -
> > >> -               set_pte_range(vmf, folio, page, 1, vmf->address);
> > >> -               add_mm_counter(vma->vm_mm, type, 1);
> > >> -               ret =3D 0;
> > >> -       } else {
> > >> -               update_mmu_tlb(vma, vmf->address, vmf->pte);
> > >> +       if (nr_pages =3D=3D 1 && unlikely(vmf_pte_changed(vmf))) {
> > >> +               update_mmu_tlb(vma, addr, vmf->pte);
> > >>                  ret =3D VM_FAULT_NOPAGE;
> > >> +               goto unlock;
> > >> +       } else if (nr_pages > 1 && !pte_range_none(vmf->pte, nr_page=
s)) {
> > >
> > > In what case we can't use !pte_range_none(vmf->pte, 1) for nr_pages =
=3D=3D 1
> > > then unify the code for nr_pages=3D=3D1 and nr_pages > 1?
> > >
> > > It seems this has been discussed before, but I forget the reason.
> >
> > IIUC, this is for uffd case, which is not a none pte entry.
>
> Is it possible to have a COW case for shmem? For example, if someone
> maps a shmem
> file as read-only and then writes to it, would that prevent the use of
> pte_range_none?

sorry, i mean PRIVATE but not READ-ONLY.

>
> Furthermore, if we encounter a large folio in shmem while reading,
> does it necessarily
> mean we can map the entire folio? Is it possible for some processes to
> only map part
> of large folios? For instance, if process A allocates large folios and
> process B maps
> only part of this shmem file or partially unmaps a large folio, how
> would that be handled?
>
> Apologies for not debugging this thoroughly, but these two corner
> cases seem worth
> considering. If these scenarios have already been addressed, please disre=
gard my
> comments.
>
> Thanks
> Barry

