Return-Path: <linux-kernel+bounces-198822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 016A88D7DF6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 10:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81C221F21164
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 08:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C2576EEA;
	Mon,  3 Jun 2024 08:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1neqj64"
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB727604F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 08:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717405122; cv=none; b=nloBOWori8r5oo1xLR9s7GcukXX4+wkiJKTAvu/jlfflSfoum5eVHEZJHakDh40VM478dDBr4nmFF2hX3CUssLY8y7p+AL41mBEKJw/QKfnHVKwdQa8JSLy5bPeSmG0bp+UjJFFzlNwJvMzvaD3s35IA087NXg6phJByryGvjLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717405122; c=relaxed/simple;
	bh=C3RfmUxFeY4f6Y1AwiFIo7tDmpq5bN2TBhwTzHKKlpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eCRqj90f7vAd2AFZyuRxZlbmR1jKU0Rax17dbQrFhrH+P9jOPUsA0ADmGSKhQurzA/L8p1tPtBoIpTw43gJcWu/oLRm0yGNr622ws7Cpc8HeyBaN/SqdzlKDVM0vqFVcBJNgNAQNr4MjOaukoran2wVgPw4icctKQ5M9gfZl64I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V1neqj64; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-48bd2a9fc5fso253481137.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 01:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717405120; x=1718009920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=44UQ4/UY0KeMGbyf3xNuLfXOKsdvcbp7J6UBZb4MxnI=;
        b=V1neqj64G1A7cUfJcRPYxHLbZpI9kSOp5B2EVchzjNbF+3SGw1IVw8RNnDNCIjPo61
         XHJq5G5v4iLfxKCcPgaU+n/QUkzdLuCX1m3OFM+vr5sjHNBNU/pJkpseKdoHfd0pIxcS
         YcZBoBCoXuj1g6tc2EAUgsg8YXOU6pZEmNbBIFJySSgQ8tBM/TLCju9laHzI1WDJa/cx
         6t4ygLxsy2cwDSUopBUrRIM1WXxoPXA9RIv5dZR0ANLxS39DtHEnsZKEJVmwpYs8lTe4
         t0Cgkj/XdnBoKgLAUDRSAS8q1Yy32z84CJhRoaHiAE+GC9gqvCLUoPiFB/Y3xN72AdpK
         rBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717405120; x=1718009920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=44UQ4/UY0KeMGbyf3xNuLfXOKsdvcbp7J6UBZb4MxnI=;
        b=gMiRcJP+FiFkjVf5JafU3r0IZ3PKr+Pg6cAK2HgV7hYbMGgxUBYE9wLEAe7bm61xYc
         y4Z+gW+rZVtLuGQYmN2WD5QOOmN4l1VGW4IBlDSJG3iZS8+MMdxdpUdcWRkPtrZ5Xned
         nNvDsLamTkLR7prFH2MJ+uOuY8gjWIpTl33+uAuI3QlsT9FT2XAEKouftiZBDlaWFPcN
         ccSBGwWJm6On/rIkIKw9d5s2PpLBbdHUci7EH8jpdeXfLU7tkFJhKqBKd57fDzMwLngW
         D5cN36k5/e8/g2AEgHur0VIG2TCwvFQEUdIXDmqnZiayJogKP6LUuzi80I/x5364IC4E
         iVrA==
X-Forwarded-Encrypted: i=1; AJvYcCWB2eiEc2fHOZQYXU+y58sY/CrT+jb8A/3CsonC9exI/WALFQHPmJMFgzml5W0IuT3PmFXS+MyKChhimRpo15QE5oRpB22Fc+2O7HBW
X-Gm-Message-State: AOJu0YwHpFbXgmoC9xOICn/N5U4yGHScWu4gA2U8o58Emn8Mo5haty/h
	MDolSk1oEcbj4Dvrd99nFsMi7ozygAQHZHUzCivB3hfMp1wbEe241TgTFExblH+EeK0oL9YjSyX
	vtVSvPthJabHC/e1ZfbplxIS0KWg=
X-Google-Smtp-Source: AGHT+IFd55xH84VmPhuot7l4LvkhDfemuCLIXaAj3pqLKDG8dxzYAHjDXy63ivF9tlTWUFKUKHCjL2g4b0E+veTEV9c=
X-Received: by 2002:a05:6102:354a:b0:47c:14bd:7ccd with SMTP id
 ada2fe7eead31-48bc21942b6mr6367775137.15.1717405118377; Mon, 03 Jun 2024
 01:58:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1717033868.git.baolin.wang@linux.alibaba.com>
 <bf80d4a792ea82ab066f819ad7d10ed22a2f8e66.1717033868.git.baolin.wang@linux.alibaba.com>
 <CAGsJ_4z60mrjuQ5qKCKn0+knk_M1dy=NsH4nVLqe5Khue_5gFw@mail.gmail.com> <e05df24a-6254-430e-88ca-6db23e5c6bab@linux.alibaba.com>
In-Reply-To: <e05df24a-6254-430e-88ca-6db23e5c6bab@linux.alibaba.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 3 Jun 2024 20:58:26 +1200
Message-ID: <CAGsJ_4zsR=xA4sCSyMc0OafaRdp7ibRGpdc00mDFEqT6pSQbKA@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] mm: memory: extend finish_fault() to support large folio
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, hughd@google.com, willy@infradead.org, 
	david@redhat.com, wangkefeng.wang@huawei.com, ying.huang@intel.com, 
	ryan.roberts@arm.com, shy828301@gmail.com, ziy@nvidia.com, 
	ioworker0@gmail.com, da.gomez@samsung.com, p.raghav@samsung.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 8:29=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 2024/6/3 13:28, Barry Song wrote:
> > On Thu, May 30, 2024 at 2:04=E2=80=AFPM Baolin Wang
> > <baolin.wang@linux.alibaba.com> wrote:
> >>
> >> Add large folio mapping establishment support for finish_fault() as a =
preparation,
> >> to support multi-size THP allocation of anonymous shmem pages in the f=
ollowing
> >> patches.
> >>
> >> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> >> ---
> >>   mm/memory.c | 58 ++++++++++++++++++++++++++++++++++++++++++++-------=
--
> >>   1 file changed, 48 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/mm/memory.c b/mm/memory.c
> >> index eef4e482c0c2..435187ff7ea4 100644
> >> --- a/mm/memory.c
> >> +++ b/mm/memory.c
> >> @@ -4831,9 +4831,12 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
> >>   {
> >>          struct vm_area_struct *vma =3D vmf->vma;
> >>          struct page *page;
> >> +       struct folio *folio;
> >>          vm_fault_t ret;
> >>          bool is_cow =3D (vmf->flags & FAULT_FLAG_WRITE) &&
> >>                        !(vma->vm_flags & VM_SHARED);
> >> +       int type, nr_pages, i;
> >> +       unsigned long addr =3D vmf->address;
> >>
> >>          /* Did we COW the page? */
> >>          if (is_cow)
> >> @@ -4864,24 +4867,59 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
> >>                          return VM_FAULT_OOM;
> >>          }
> >>
> >> +       folio =3D page_folio(page);
> >> +       nr_pages =3D folio_nr_pages(folio);
> >> +
> >> +       /*
> >> +        * Using per-page fault to maintain the uffd semantics, and sa=
me
> >> +        * approach also applies to non-anonymous-shmem faults to avoi=
d
> >> +        * inflating the RSS of the process.
> >
> > I don't feel the comment explains the root cause.
> > For non-shmem, anyway we have allocated the memory? Avoiding inflating
> > RSS seems not so useful as we have occupied the memory. the memory foot=
print
>
> This is also to keep the same behavior as before for non-anon-shmem, and
> will be discussed in the future.

OK.

>
> > is what we really care about. so we want to rely on read-ahead hints of=
 subpage
> > to determine read-ahead size? that is why we don't map nr_pages for non=
-shmem
> > files though we can potentially reduce nr_pages - 1 page faults?
>
> IMHO, there is 2 cases for non-anon-shmem:
> (1) read mmap() faults: we can rely on the 'fault_around_bytes'
> interface to determin what size of mapping to build.
> (2) writable mmap() faults: I want to keep the same behavior as before
> (per-page fault), but we can talk about this when I send new patches to
> use mTHP to control large folio allocation for writable mmap().

OK.

>
> >> +        */
> >> +       if (!vma_is_anon_shmem(vma) || unlikely(userfaultfd_armed(vma)=
)) {
> >> +               nr_pages =3D 1;
> >> +       } else if (nr_pages > 1) {
> >> +               pgoff_t idx =3D folio_page_idx(folio, page);
> >> +               /* The page offset of vmf->address within the VMA. */
> >> +               pgoff_t vma_off =3D vmf->pgoff - vmf->vma->vm_pgoff;
> >> +
> >> +               /*
> >> +                * Fallback to per-page fault in case the folio size i=
n page
> >> +                * cache beyond the VMA limits.
> >> +                */
> >> +               if (unlikely(vma_off < idx ||
> >> +                            vma_off + (nr_pages - idx) > vma_pages(vm=
a))) {
> >> +                       nr_pages =3D 1;
> >> +               } else {
> >> +                       /* Now we can set mappings for the whole large=
 folio. */
> >> +                       addr =3D vmf->address - idx * PAGE_SIZE;
> >> +                       page =3D &folio->page;
> >> +               }
> >> +       }
> >> +
> >>          vmf->pte =3D pte_offset_map_lock(vma->vm_mm, vmf->pmd,
> >> -                                     vmf->address, &vmf->ptl);
> >> +                                      addr, &vmf->ptl);
> >>          if (!vmf->pte)
> >>                  return VM_FAULT_NOPAGE;
> >>
> >>          /* Re-check under ptl */
> >> -       if (likely(!vmf_pte_changed(vmf))) {
> >> -               struct folio *folio =3D page_folio(page);
> >> -               int type =3D is_cow ? MM_ANONPAGES : mm_counter_file(f=
olio);
> >> -
> >> -               set_pte_range(vmf, folio, page, 1, vmf->address);
> >> -               add_mm_counter(vma->vm_mm, type, 1);
> >> -               ret =3D 0;
> >> -       } else {
> >> -               update_mmu_tlb(vma, vmf->address, vmf->pte);
> >> +       if (nr_pages =3D=3D 1 && unlikely(vmf_pte_changed(vmf))) {
> >> +               update_mmu_tlb(vma, addr, vmf->pte);
> >>                  ret =3D VM_FAULT_NOPAGE;
> >> +               goto unlock;
> >> +       } else if (nr_pages > 1 && !pte_range_none(vmf->pte, nr_pages)=
) {
> >
> > In what case we can't use !pte_range_none(vmf->pte, 1) for nr_pages =3D=
=3D 1
> > then unify the code for nr_pages=3D=3D1 and nr_pages > 1?
> >
> > It seems this has been discussed before, but I forget the reason.
>
> IIUC, this is for uffd case, which is not a none pte entry.

Is it possible to have a COW case for shmem? For example, if someone
maps a shmem
file as read-only and then writes to it, would that prevent the use of
pte_range_none?

Furthermore, if we encounter a large folio in shmem while reading,
does it necessarily
mean we can map the entire folio? Is it possible for some processes to
only map part
of large folios? For instance, if process A allocates large folios and
process B maps
only part of this shmem file or partially unmaps a large folio, how
would that be handled?

Apologies for not debugging this thoroughly, but these two corner
cases seem worth
considering. If these scenarios have already been addressed, please disrega=
rd my
comments.

Thanks
Barry

