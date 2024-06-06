Return-Path: <linux-kernel+bounces-204028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 840278FE324
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66D051C20385
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167DD1514D2;
	Thu,  6 Jun 2024 09:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKQhcT2y"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E85F13E41C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 09:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717666748; cv=none; b=CPuAd2Vgb+1prqYsi4ZTxm+4IIHFp+X2f0VGpUQ2M9AdfwW4Vgj0uUinxyJohdBpj/cEfgdFHAXuCOglwngF2ag3EmJo2qtLkZ/8ucSxqekQXbjugYNdlE+dKZKcOcRDtW9/LssmSSAhAXzyIy7Phu7Y3SovjXWNCHe6NiCjV5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717666748; c=relaxed/simple;
	bh=lOIk+qn0/RiBXVWxFfke39+7kIEeognsLu5NFjoiTHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i6OaAaRjYtPW7RFnvtWieQvn6GSgZuTHg6lSSEgY52CwBEXYKE6tw7FLCKXX1P12EYXhp5QGc566xbedj4VMhFk9N285TJ4G9gx5dUZxqjA7KaUL7qRJ37+XBIVRBSAQN38wZKTwk2yfWanTed/cNfv6nGIy1oYBapW9KVYS1WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKQhcT2y; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57a4ea8058bso702597a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 02:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717666745; x=1718271545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K8xP4iI8y3hGs9QaBeNbsUbwYziKnYDMkGGrCS2wfSA=;
        b=cKQhcT2yW9hwpvsTGrTBTaiq7TTXSt7551wXmWwcbuD5b4Ro4+v2pBjYGa+K2UWftV
         +JZmNgY2T4Am4pyzFIDxSrJ9C8JfiET+waulbUkaZEiQIyGRq5TAqsxqfNzrmJO27pLn
         F+Nbr1oEwo7pVEiz2sK1AtWcRXMRci2U0YGKTBSLatWEkloH67fF4gvn4Ta2DTutb5om
         xWWydqqxUe7Izv6E7R5C5Y7ITtndYYaYT4XR4y7QpeT3XdYMsY8KuIjYfoLMke0fmx5C
         osJSjt3jw9lfFKnATkSDl4Eq4YuCbSwJBE9Q1Y3BYxyiwyyS5trsjTx5vvF/Q2bmzwcY
         V9cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717666745; x=1718271545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K8xP4iI8y3hGs9QaBeNbsUbwYziKnYDMkGGrCS2wfSA=;
        b=h/jojYaaVaVDWq+pkL+0IEZCr12ORWBfupZNPGL2YpEVI1Ey/KPrszWJQVlJ6WgdJO
         kLzJBrCWscfwa6k4dAsqWGdhH+pxQBPIvgFHzTfsOuDxQxXb7QV0piXdLTlAEtA4UM7l
         x9GeP0XKNmSN/+urCl9xYAlHixyXDIHsTITQsdREG8uEILJ6jDQaI06ohm+nEQ7l8btz
         U7Rm0WQvUq2D40OX7GrZe7br12g9m6pVL1BRVqoWQGEz/TWlg4LOfoDRcdycMP3mO84R
         HvotQT2mf047gR7JHl0sa84ZOb/y1FIBtsge0Jq1Y5LY5eHcFKfLHrvs40V1EP6GTyEw
         Xh1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVtF9OJd5qu67lJgRNRiB4RhF7qQOb3mCQMCukIHCKyct7J8E6XO0xX1C2K8hArSkxbUif+8K9tbP8wTuv7t/pgP5gu0DmIy0fGwVxg
X-Gm-Message-State: AOJu0Ywlf+N15JHmsHr0PgQy1QeyDDlNnKqcbDsgfrK9cR8iUkeM6Wou
	irxSKRag3e03If0zKo6Ckc93cTmINa260otUULnjBlAM40rBS8Rlc4/zyuY5MaoPgrIjdSZ3Elp
	3j8NIHyIu0iseVWxgnjkBum//4to=
X-Google-Smtp-Source: AGHT+IG2T9lbzffU7CgaOg8lnSW5VZ5O9T1UU/WFFkEqrSPD7Y5nSYj5Jcb0g6rH1mOfXn1sqNxOPbJhqlHhqAfPhc0=
X-Received: by 2002:a50:8a92:0:b0:578:67db:7516 with SMTP id
 4fb4d7f45d1cf-57a8bcb5db5mr3332344a12.37.1717666744421; Thu, 06 Jun 2024
 02:39:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521040244.48760-1-ioworker0@gmail.com> <20240521040244.48760-3-ioworker0@gmail.com>
 <fd16b219-bc46-484a-8581-a21240440fa6@redhat.com> <CAK1f24kwf4gDwK=8X4z1bM9-H6_M9QKy6-ko9pTUZij-W=40wg@mail.gmail.com>
 <d319f00e-9dfb-43b1-ae81-a2e2afdf36c4@redhat.com> <CAK1f24kKra71RSQdFOpQecU6+yMELC748irKUt54Kg64-P=4-A@mail.gmail.com>
 <758f7be7-c17e-46d1-879f-83340ec85749@redhat.com> <5a728148-ed93-4d68-a86f-9be3612dedbb@redhat.com>
In-Reply-To: <5a728148-ed93-4d68-a86f-9be3612dedbb@redhat.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Thu, 6 Jun 2024 17:38:52 +0800
Message-ID: <CAK1f24nMbW_UvCTq=K0aFu9=7psYZ9wmHq47J=AK7VYmpCpC4Q@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] mm/rmap: integrate PMD-mapped folio splitting into
 pagewalk loop
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, sj@kernel.org, 
	baolin.wang@linux.alibaba.com, maskray@google.com, ziy@nvidia.com, 
	ryan.roberts@arm.com, 21cnbao@gmail.com, mhocko@suse.com, 
	fengwei.yin@intel.com, zokeefe@google.com, shy828301@gmail.com, 
	xiehuan09@gmail.com, libang.li@antgroup.com, wangkefeng.wang@huawei.com, 
	songmuchun@bytedance.com, peterx@redhat.com, minchan@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 4:06=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 06.06.24 10:01, David Hildenbrand wrote:
> > On 06.06.24 05:55, Lance Yang wrote:
> >> On Wed, Jun 5, 2024 at 10:28=E2=80=AFPM David Hildenbrand <david@redha=
t.com> wrote:
> >>>
> >>> On 05.06.24 16:20, Lance Yang wrote:
> >>>> Hi David,
> >>>>
> >>>> On Wed, Jun 5, 2024 at 8:46=E2=80=AFPM David Hildenbrand <david@redh=
at.com> wrote:
> >>>>>
> >>>>> On 21.05.24 06:02, Lance Yang wrote:
> >>>>>> In preparation for supporting try_to_unmap_one() to unmap PMD-mapp=
ed
> >>>>>> folios, start the pagewalk first, then call split_huge_pmd_address=
() to
> >>>>>> split the folio.
> >>>>>>
> >>>>>> Since TTU_SPLIT_HUGE_PMD will no longer perform immediately, we mi=
ght
> >>>>>> encounter a PMD-mapped THP missing the mlock in the VM_LOCKED rang=
e during
> >>>>>> the page walk. It=E2=80=99s probably necessary to mlock this THP t=
o prevent it from
> >>>>>> being picked up during page reclaim.
> >>>>>>
> >>>>>> Suggested-by: David Hildenbrand <david@redhat.com>
> >>>>>> Suggested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> >>>>>> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> >>>>>> ---
> >>>>>
> >>>>> [...] again, sorry for the late review.
> >>>>
> >>>> No worries at all, thanks for taking time to review!
> >>>>
> >>>>>
> >>>>>> diff --git a/mm/rmap.c b/mm/rmap.c
> >>>>>> index ddffa30c79fb..08a93347f283 100644
> >>>>>> --- a/mm/rmap.c
> >>>>>> +++ b/mm/rmap.c
> >>>>>> @@ -1640,9 +1640,6 @@ static bool try_to_unmap_one(struct folio *f=
olio, struct vm_area_struct *vma,
> >>>>>>          if (flags & TTU_SYNC)
> >>>>>>                  pvmw.flags =3D PVMW_SYNC;
> >>>>>>
> >>>>>> -     if (flags & TTU_SPLIT_HUGE_PMD)
> >>>>>> -             split_huge_pmd_address(vma, address, false, folio);
> >>>>>> -
> >>>>>>          /*
> >>>>>>           * For THP, we have to assume the worse case ie pmd for i=
nvalidation.
> >>>>>>           * For hugetlb, it could be much worse if we need to do p=
ud
> >>>>>> @@ -1668,20 +1665,35 @@ static bool try_to_unmap_one(struct folio =
*folio, struct vm_area_struct *vma,
> >>>>>>          mmu_notifier_invalidate_range_start(&range);
> >>>>>>
> >>>>>>          while (page_vma_mapped_walk(&pvmw)) {
> >>>>>> -             /* Unexpected PMD-mapped THP? */
> >>>>>> -             VM_BUG_ON_FOLIO(!pvmw.pte, folio);
> >>>>>> -
> >>>>>>                  /*
> >>>>>>                   * If the folio is in an mlock()d vma, we must no=
t swap it out.
> >>>>>>                   */
> >>>>>>                  if (!(flags & TTU_IGNORE_MLOCK) &&
> >>>>>>                      (vma->vm_flags & VM_LOCKED)) {
> >>>>>>                          /* Restore the mlock which got missed */
> >>>>>> -                     if (!folio_test_large(folio))
> >>>>>> +                     if (!folio_test_large(folio) ||
> >>>>>> +                         (!pvmw.pte && (flags & TTU_SPLIT_HUGE_PM=
D)))
> >>>>>>                                  mlock_vma_folio(folio, vma);

Should we still keep the '!pvmw.pte' here? Something like:

if (!folio_test_large(folio) || !pvmw.pte)
    mlock_vma_folio(folio, vma);

We can mlock the THP to prevent it from being picked up during page reclaim=
.

David, I=E2=80=99d like to hear your thoughts on this ;)

Thanks,
Lance

> >>>>>
> >>>>> Can you elaborate why you think this would be required? If we would=
 have
> >>>>> performed the  split_huge_pmd_address() beforehand, we would still =
be
> >>>>> left with a large folio, no?
> >>>>
> >>>> Yep, there would still be a large folio, but it wouldn't be PMD-mapp=
ed.
> >>>>
> >>>> After Weifeng's series[1], the kernel supports mlock for PTE-mapped =
large
> >>>> folio, but there are a few scenarios where we don't mlock a large fo=
lio, such
> >>>> as when it crosses a VM_LOCKed VMA boundary.
> >>>>
> >>>>     -                     if (!folio_test_large(folio))
> >>>>     +                     if (!folio_test_large(folio) ||
> >>>>     +                         (!pvmw.pte && (flags & TTU_SPLIT_HUGE_=
PMD)))
> >>>>
> >>>> And this check is just future-proofing and likely unnecessary. If en=
countering a
> >>>> PMD-mapped THP missing the mlock for some reason, we can mlock this
> >>>> THP to prevent it from being picked up during page reclaim, since it=
 is fully
> >>>> mapped and doesn't cross the VMA boundary, IIUC.
> >>>>
> >>>> What do you think?
> >>>> I would appreciate any suggestions regarding this check ;)
> >>>
> >>> Reading this patch only, I wonder if this change makes sense in the
> >>> context here.
> >>
> >> Allow me to try explaining it again ;)
> >>
> >>>
> >>> Before this patch, we would have PTE-mapped the PMD-mapped THP before
> >>> reaching this call and skipped it due to "!folio_test_large(folio)".
> >>
> >> Yes, there is only a PTE-mapped THP when doing the "!folio_test_large(=
folio)"
> >> check, as we will first conditionally split the PMD via
> >> split_huge_pmd_address().
> >>
> >>>
> >>> After this patch, we either
> >>
> >> Things will change. We'll first do the "!folio_test_large(folio)" chec=
k, then
> >> conditionally split the PMD via split_huge_pmd_address().
> >>
> >>>
> >>> a) PTE-remap the THP after this check, but retry and end-up here agai=
n,
> >>> whereby we would skip it due to "!folio_test_large(folio)".
> >>
> >> Hmm...
> >>
> >> IIUC, we will skip it after this check, stop the page walk, and not
> >> PTE-remap the THP.
> >>
> >>>
> >>> b) Discard the PMD-mapped THP due to lazyfree directly. Can that
> >>> co-exist with mlock and what would be the problem here with mlock?
> >>
> >> Before discarding a PMD-mapped THP as a whole, as patch #3 did,
> >> we also perform the "!folio_test_large(folio)" check. If the THP coexi=
sts
> >> with mlock, we will skip it, stop the page walk, and not discard it. I=
IUC.
> >
> > But "!folio_test_large(folio)" would *skip* the THP and not consider it
> > regarding mlock.
> >
> > I'm probably missing something
>
> I'm stupid, I missed that we still do the "goto walk_done_err;", only
> that we don't do the mlock_vma_folio(folio, vma);
>
> Yes, let's drop it for now! :)
>
> --
> Cheers,
>
> David / dhildenb
>

