Return-Path: <linux-kernel+bounces-170492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C0B8BD805
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 00:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9BA0283B75
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 22:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB1015B995;
	Mon,  6 May 2024 22:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXnBE2CB"
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571C1157499
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 22:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715036320; cv=none; b=hRkzS51fKZBh+8/Xu/q6JpGZo4dy+cDVu96t5ZkuTwyDfqtOtTor4InEZicS40nO0QmAzVCq3IpAV74bsXXlZ7TQcevRk4zaUxXqRT/NLKO4130MzzmnQjgBvQYyGcXJQH6sqCdmDO1DLlw6snu7Uu7YFd1OFZsSdRu1vpnW0K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715036320; c=relaxed/simple;
	bh=uG2zw3heoV9QpOpZjSTtFU37KbvabkqXgW7P2FR97Bg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pCUOVpXkx55aMN1+c8IB9yr6Xd6qSGm3nAcI9ncx1IVIvPAcOqpDBF0EP7conczonCpyNIuBSmAaiL9ORMTICklYpkdJLifX/M7vhlHgdkaahcAMForj0fXpiUitUJVT5D3Lg9A+nwDtA5l4SDoCwUb1/Q4QPcw7senhO1m2LZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XXnBE2CB; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-47ef11b1a31so501528137.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 15:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715036317; x=1715641117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JEzMrpo9xpl1ECD3kombTAPF1tytR8JwyhRQEB9Ne7Q=;
        b=XXnBE2CBUPXWcwvBHcLDMl9nJht2/uby170iNCmEQcWFiDNFJ2pOZypc4uAE2Kugws
         XPUsvAN9Yrys4cnVeadsrhtEhx7rBkQpoLvdIzKgqpzyhKHUP/dQ1my908VaKcoOk8qv
         +v+8sxOdDQ6Z4A/pD0fM+l11wPfdKXOOMeQaC3WByJyPnX98o1Y9RfRSmEvsRGG1up+Z
         pyKCF+J6zBlZLggHnzqU8tdJkDlKBT0dmk9+z1C7lVNYb38M071BHBDtul3sej//aO6j
         hSVGMGlZb01GApmOo7xDQ1WACGZifd9oieerioxivG4ji3/rpCWVciT0kNMet/mRcLp/
         Q2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715036317; x=1715641117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JEzMrpo9xpl1ECD3kombTAPF1tytR8JwyhRQEB9Ne7Q=;
        b=Vc92KTvE64HDkZUyf8ti8lNjme0JHTQyRTIDFP5g9rBG6jK7lU5jQqxigBudsn8N2L
         SQVB+1/qvm/nyE8NZX6VM+mhZ6/6S63nQjzpec+KplybjVVRbyL1pfTTKrjuhf5M0IoX
         Y5PKJzFJGDT/ktt8onLjDXaz4fq3OHgBwdykUCT1HG66gzogj5j+1PcHxML6gi59HWtZ
         4/vSRX/znbvxFtlrnPpx7dRwNXMufaDhpvcI0oSAhX8NULpxOCjiAP1A/l36HeNKHasz
         7D6ae6qACjgpCmgRx3Ap+kp+A/aefdxXvhk7qhi/MjIcXMZboU1Pr1FUR7gTz/t9EAtX
         ZK9w==
X-Forwarded-Encrypted: i=1; AJvYcCUuWd0d7wLP70Ndz7xMpulkHZ31u31T3zYwRALBfP5kSv640mrJkmB4CEt08AL+wllz1EfjZg1q3f3P4pLBQlBSoEykQmAVLUykgCrR
X-Gm-Message-State: AOJu0YwaSU73Dr+TcJSm2csLwSX0TXAB0btXQxRB4MTKKD/nbhvTqkV2
	lV7Rud9bUMivxCmoWIBy6bRf93UQeSgQ81+nm0/jZWvyyF30mxx4XaT0CrcEYUu+9fdq2aATm47
	5EC3saq1kFf12gMLeF3VcZNhfOIo=
X-Google-Smtp-Source: AGHT+IGolnkqh/0cQmoY1ihS/u6BKEbTqfLlttDItVi1BvrDJ55vkA4yD+lxtzH6jgs1GPeggzymYNaU6QvNglRJQeI=
X-Received: by 2002:a67:f4d5:0:b0:47c:14eb:5fdd with SMTP id
 s21-20020a67f4d5000000b0047c14eb5fddmr12813837vsn.29.1715036316957; Mon, 06
 May 2024 15:58:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503005023.174597-1-21cnbao@gmail.com> <20240503005023.174597-7-21cnbao@gmail.com>
 <0b4d4d4b-91d8-4fd5-af4e-aebe9ee08b89@arm.com> <CAGsJ_4wm6v+xgh4jQ+u2-EzOXCLsz6L6nRJi_=FfWuGDUjxRYg@mail.gmail.com>
 <ff5b371a-16f6-4d03-b80d-b56af0f488c3@redhat.com> <CAGsJ_4z93FwPZx7w2VuCEkHP_JCwkO0whKwymonRJ9bSiKMVyQ@mail.gmail.com>
 <CAGsJ_4xssg3CcjifePMmgk4aqLO+iAon0YdT9p=Uq-D8vFMxyQ@mail.gmail.com> <5b770715-7516-42a8-9ea0-3f61572d92af@redhat.com>
In-Reply-To: <5b770715-7516-42a8-9ea0-3f61572d92af@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 7 May 2024 10:58:25 +1200
Message-ID: <CAGsJ_4xP1jPjH-SH7BgnFHiT4m+2gB0tP7ie_cUFynVpD_zpxQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] mm: swap: entirely map large folios found in swapcache
To: David Hildenbrand <david@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, hanchuanhua@oppo.com, 
	hannes@cmpxchg.org, hughd@google.com, kasong@tencent.com, 
	linux-kernel@vger.kernel.org, surenb@google.com, v-songbaohua@oppo.com, 
	willy@infradead.org, xiang@kernel.org, ying.huang@intel.com, 
	yosryahmed@google.com, yuzhao@google.com, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 1:16=E2=80=AFAM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 06.05.24 14:58, Barry Song wrote:
> > On Tue, May 7, 2024 at 12:38=E2=80=AFAM Barry Song <21cnbao@gmail.com> =
wrote:
> >>
> >> On Tue, May 7, 2024 at 12:07=E2=80=AFAM David Hildenbrand <david@redha=
t.com> wrote:
> >>>
> >>> On 04.05.24 01:23, Barry Song wrote:
> >>>> On Fri, May 3, 2024 at 6:50=E2=80=AFPM Ryan Roberts <ryan.roberts@ar=
m.com> wrote:
> >>>>>
> >>>>> On 03/05/2024 01:50, Barry Song wrote:
> >>>>>> From: Chuanhua Han <hanchuanhua@oppo.com>
> >>>>>>
> >>>>>> When a large folio is found in the swapcache, the current implemen=
tation
> >>>>>> requires calling do_swap_page() nr_pages times, resulting in nr_pa=
ges
> >>>>>> page faults. This patch opts to map the entire large folio at once=
 to
> >>>>>> minimize page faults. Additionally, redundant checks and early exi=
ts
> >>>>>> for ARM64 MTE restoring are removed.
> >>>>>>
> >>>>>> Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
> >>>>>> Co-developed-by: Barry Song <v-songbaohua@oppo.com>
> >>>>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> >>>>>
> >>>>> With the suggested changes below:
> >>>>>
> >>>>> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> >>>>>
> >>>>>> ---
> >>>>>>    mm/memory.c | 60 ++++++++++++++++++++++++++++++++++++++++++----=
-------
> >>>>>>    1 file changed, 48 insertions(+), 12 deletions(-)
> >>>>>>
> >>>>>> diff --git a/mm/memory.c b/mm/memory.c
> >>>>>> index 22e7c33cc747..940fdbe69fa1 100644
> >>>>>> --- a/mm/memory.c
> >>>>>> +++ b/mm/memory.c
> >>>>>> @@ -3968,6 +3968,10 @@ vm_fault_t do_swap_page(struct vm_fault *vm=
f)
> >>>>>>         pte_t pte;
> >>>>>>         vm_fault_t ret =3D 0;
> >>>>>>         void *shadow =3D NULL;
> >>>>>> +     int nr_pages =3D 1;
> >>>>>> +     unsigned long page_idx =3D 0;
> >>>>>> +     unsigned long address =3D vmf->address;
> >>>>>> +     pte_t *ptep;
> >>>>>
> >>>>> nit: Personally I'd prefer all these to get initialised just before=
 the "if
> >>>>> (folio_test_large()..." block below. That way it is clear they are =
fresh (incase
> >>>>> any logic between here and there makes an adjustment) and its clear=
 that they
> >>>>> are only to be used after that block (the compiler will warn if usi=
ng an
> >>>>> uninitialized value).
> >>>>
> >>>> right. I agree this will make the code more readable.
> >>>>
> >>>>>
> >>>>>>
> >>>>>>         if (!pte_unmap_same(vmf))
> >>>>>>                 goto out;
> >>>>>> @@ -4166,6 +4170,36 @@ vm_fault_t do_swap_page(struct vm_fault *vm=
f)
> >>>>>>                 goto out_nomap;
> >>>>>>         }
> >>>>>>
> >>>>>> +     ptep =3D vmf->pte;
> >>>>>> +     if (folio_test_large(folio) && folio_test_swapcache(folio)) =
{
> >>>>>> +             int nr =3D folio_nr_pages(folio);
> >>>>>> +             unsigned long idx =3D folio_page_idx(folio, page);
> >>>>>> +             unsigned long folio_start =3D vmf->address - idx * P=
AGE_SIZE;
> >>>>>> +             unsigned long folio_end =3D folio_start + nr * PAGE_=
SIZE;
> >>>>>> +             pte_t *folio_ptep;
> >>>>>> +             pte_t folio_pte;
> >>>>>> +
> >>>>>> +             if (unlikely(folio_start < max(vmf->address & PMD_MA=
SK, vma->vm_start)))
> >>>>>> +                     goto check_folio;
> >>>>>> +             if (unlikely(folio_end > pmd_addr_end(vmf->address, =
vma->vm_end)))
> >>>>>> +                     goto check_folio;
> >>>>>> +
> >>>>>> +             folio_ptep =3D vmf->pte - idx;
> >>>>>> +             folio_pte =3D ptep_get(folio_ptep);
> >>>>>> +             if (!pte_same(folio_pte, pte_move_swp_offset(vmf->or=
ig_pte, -idx)) ||
> >>>>>> +                 swap_pte_batch(folio_ptep, nr, folio_pte) !=3D n=
r)
> >>>>>> +                     goto check_folio;
> >>>>>> +
> >>>>>> +             page_idx =3D idx;
> >>>>>> +             address =3D folio_start;
> >>>>>> +             ptep =3D folio_ptep;
> >>>>>> +             nr_pages =3D nr;
> >>>>>> +             entry =3D folio->swap;
> >>>>>> +             page =3D &folio->page;
> >>>>>> +     }
> >>>>>> +
> >>>>>> +check_folio:
> >>>>>
> >>>>> Is this still the correct label name, given the checks are now abov=
e the new
> >>>>> block? Perhaps "one_page" or something like that?
> >>>>
> >>>> not quite sure about this, as the code after one_page can be multipl=
e_pages.
> >>>> On the other hand, it seems we are really checking folio after "chec=
k_folio"
> >>>> :-)
> >>>>
> >>>>
> >>>> BUG_ON(!folio_test_anon(folio) && folio_test_mappedtodisk(folio));
> >>>> BUG_ON(folio_test_anon(folio) && PageAnonExclusive(page));
> >>>>
> >>>> /*
> >>>> * Check under PT lock (to protect against concurrent fork() sharing
> >>>> * the swap entry concurrently) for certainly exclusive pages.
> >>>> */
> >>>> if (!folio_test_ksm(folio)) {
> >>>>
> >>>>
> >>>>>
> >>>>>> +
> >>>>>>         /*
> >>>>>>          * PG_anon_exclusive reuses PG_mappedtodisk for anon pages=
 A swap pte
> >>>>>>          * must never point at an anonymous page in the swapcache =
that is
> >>>>>> @@ -4225,12 +4259,13 @@ vm_fault_t do_swap_page(struct vm_fault *v=
mf)
> >>>>>>          * We're already holding a reference on the page but haven=
't mapped it
> >>>>>>          * yet.
> >>>>>>          */
> >>>>>> -     swap_free_nr(entry, 1);
> >>>>>> +     swap_free_nr(entry, nr_pages);
> >>>>>>         if (should_try_to_free_swap(folio, vma, vmf->flags))
> >>>>>>                 folio_free_swap(folio);
> >>>>>>
> >>>>>> -     inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
> >>>>>> -     dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
> >>>>>> +     folio_ref_add(folio, nr_pages - 1);
> >>>>>> +     add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr_pages);
> >>>>>> +     add_mm_counter(vma->vm_mm, MM_SWAPENTS, -nr_pages);
> >>>>>>         pte =3D mk_pte(page, vma->vm_page_prot);
> >>>>>>
> >>>>>>         /*
> >>>>>> @@ -4240,34 +4275,35 @@ vm_fault_t do_swap_page(struct vm_fault *v=
mf)
> >>>>>>          * exclusivity.
> >>>>>>          */
> >>>>>>         if (!folio_test_ksm(folio) &&
> >>>>>> -         (exclusive || folio_ref_count(folio) =3D=3D 1)) {
> >>>>>> +         (exclusive || (folio_ref_count(folio) =3D=3D nr_pages &&
> >>>>>> +                        folio_nr_pages(folio) =3D=3D nr_pages))) =
{
> >>>>>
> >>>>> I think in practice there is no change here? If nr_pages > 1 then t=
he folio is
> >>>>> in the swapcache, so there is an extra ref on it? I agree with the =
change for
> >>>>> robustness sake. Just checking my understanding.
> >>>>
> >>>> This is the code showing we are reusing/(mkwrite) a folio either
> >>>> 1. we meet a small folio and we are the only one hitting the small f=
olio
> >>>> 2. we meet a large folio and we are the only one hitting the large f=
olio
> >>>>
> >>>> any corner cases besides the above two seems difficult. for example,
> >>>>
> >>>> while we hit a large folio in swapcache but if we can't entirely map=
 it
> >>>> (nr_pages=3D=3D1) due to partial unmap, we will have folio_ref_count=
(folio)
> >>>> =3D=3D nr_pages =3D=3D 1
> >>>
> >>> No, there would be other references from the swapcache and
> >>> folio_ref_count(folio) > 1. See my other reply.
> >>
> >> right. can be clearer by:
> >
> > Wait, do we still need folio_nr_pages(folio) =3D=3D nr_pages even if we=
 use
> > folio_ref_count(folio) =3D=3D 1 and moving folio_ref_add(folio, nr_page=
s - 1)?
>
> I don't think that we will "need" it.
>
> >
> > one case is that we have a large folio with 16 PTEs, and we unmap
> > 15 swap PTE entries, thus we have only one swap entry left. Then
> > we hit the large folio in swapcache.  but we have only one PTE thus we =
will
> > map only one PTE. lacking folio_nr_pages(folio) =3D=3D nr_pages, we reu=
se the
> > large folio for one PTE. with it, do_wp_page() will migrate the large
> > folio to a small one?
>
> We will set PAE bit and do_wp_page() will unconditionally reuse that page=
.
>
> Note that this is the same as if we had pte_swp_exclusive() set and
> would have run into "exclusive=3Dtrue" here.
>
> If we'd want a similar "optimization" as we have in
> wp_can_reuse_anon_folio(), you'd want something like
>
> exclusive || (folio_ref_count(folio) =3D=3D 1 &&
>               (!folio_test_large(folio) || nr_pages > 1)

I feel like

A :   !folio_test_large(folio) || nr_pages > 1

equals

B:    folio_nr_pages(folio) =3D=3D nr_pages

if folio is small,  folio_test_large(folio) is false, both A and B will be =
true;
if folio is large, and we map the whole large folio, A will be true
because of nr_pages > 1;
B is also true;
if folio is large, and we map single one PTE, A will be false;
B is also false, because nr_pages =3D=3D 1 but  folio_nr_pages(folio) > 1;

right?

However, I agree that delving into this complexity might not be necessary
at the moment.

>
> ... but I am not sure if that is really worth the complexity here.
>
> >
> > 1AM, tired and sleepy. not quite sure I am correct.
> > I look forward to seeing your reply tomorrow morning :-)
>
> Heh, no need to dream about this ;)
>
> --
> Cheers,
>
> David / dhildenb

Thanks
Barry

