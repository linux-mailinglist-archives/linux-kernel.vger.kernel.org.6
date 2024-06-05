Return-Path: <linux-kernel+bounces-202851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 321DB8FD1EB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 17:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 375F41C229E6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E77C61FE7;
	Wed,  5 Jun 2024 15:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QucvWz82"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5F34AEC3
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 15:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717602201; cv=none; b=fNmioRu4nso82nwnW2jBgZ4AiZ0jj3MyuUI/59Lrj1inJ7PpTXO/VYDBk5l+wQqiOGH1GCIDa5yO/cubpOa/6+FOQAT2/NRSv3eHDZ2GYHLAjsBPQvhx6bfN1Teq37nV3d0a7sBTmSsg3Rle+xEW25Q6eLN6NfaerLwPNuNDLuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717602201; c=relaxed/simple;
	bh=/mmScfAlwBmYOWDlO9gXjcFXVGjBKKxkRc3eZRFJ6sQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g1cVok2LQZARwnEHCz5YaU+w6XxxFuo7TYAm7+RTZYr/SE3KhJ8kmvC6XYulsaRhtiYzS+Rc2avMrU/iSCFoQkmXm9c6rbw1cXml0GWnpMROWlA5qQMGCOX0un/sceTYVsSmNYr/IW0i0abNNcpm0hKP52bbdPnSdYpTR7qm5ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QucvWz82; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52b992fd796so5646e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 08:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717602198; x=1718206998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6GplyPYFfVj4jtYuDkS7wQRYPUo9sDheI1XACPZzCg=;
        b=QucvWz82HYsJz+hiqS66MHE94H3gFHPM/IHi10o/hLMj894oqq8NiSm1aBzRMBt9jN
         9Ak+L40geUvoqkJwFPt9K5V9j/TwmQUvn1LFqZHVWmJsWAexWfiqXuI6Mj9xEvRiDTXX
         bJdtXeF8iQl183/h9YuGEpufL1lfLrQo5OivRdNZvl/5KcGMGZVdpMCqwOjZx9iBx6SV
         Hh6iRCW2EoBLQR0N4Ljm67dtZYbXjyH4oFQtNDIN3mIweanu7KxbomZGs/UYCmNp752v
         sfzYUPAHqOBqoMUuUuCJwhRqSlJ3lYhrsSd05aMvRtSXcJYTf0+yl70sqRbD3ztuyA1A
         FuGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717602198; x=1718206998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j6GplyPYFfVj4jtYuDkS7wQRYPUo9sDheI1XACPZzCg=;
        b=PG4j4oumY9+ccydJwEaEET2yGmrJ7CK+wjJoNhY9Df6A0+EUbCzLzbhBV+7QC1qeId
         lMKdk+f2BgbePBUdubjoaTMqqRdogSKZVQ4U2I8Lm/9KFQGtV4xp2Dy8AAhqXdO7aiYw
         Yy4ymNLuIXd1SuiILpB23Pjkhbr3Km1tesS9wBgvdtP/Pf62w2YWEzvLAV3GKnzKXun4
         h+Z0NfrgrceFjGNm3JzzW1e/aCn1v7Zp01B2Ze/WLH3wDYhYI4C4Iy4NnRdmUDkcUXFE
         0OXIsqNSpHQ3dBwpdCkMeaQe6oQ8Yz71wkaLPowdIqYbfN0zUjfoF5DFJ6BGASeY+WSC
         GHiA==
X-Forwarded-Encrypted: i=1; AJvYcCUFdaFO5zWA4fSlGXSfx2HLhQYpBvVP4SLTzCqQmQ1W2q1IbBcB1zeQ4muoEBrl8WuIeAh7lime5ZRAPTYbck5Jl6pzT3EhAQz83uMF
X-Gm-Message-State: AOJu0YxCbQyMh0yh6C9f6OAyscRK0Z8QJPHjGmKhHayKaHmMhMfmbnax
	ujSL7al8DZBk+13ioDo4v/JYzbBoDrV119S37tLogKlXCykhNOHEtaVWqLeJyMs0X6/GzpUjNzb
	6gqCykmIixHJJtjwAu3+crDddE7Q=
X-Google-Smtp-Source: AGHT+IHWouC1BpENc394vm09Ch5F+mJszVyyUsvh1OfUljLcY3TWFkFj8TrcIfx6ECmaNaWzAaKtz+k9Ca6bq5alAiM=
X-Received: by 2002:a05:6512:1287:b0:523:91d1:12b2 with SMTP id
 2adb3069b0e04-52bab4cb83amr2142113e87.6.1717602197618; Wed, 05 Jun 2024
 08:43:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521040244.48760-1-ioworker0@gmail.com> <20240521040244.48760-3-ioworker0@gmail.com>
 <fd16b219-bc46-484a-8581-a21240440fa6@redhat.com> <CAK1f24kwf4gDwK=8X4z1bM9-H6_M9QKy6-ko9pTUZij-W=40wg@mail.gmail.com>
 <d319f00e-9dfb-43b1-ae81-a2e2afdf36c4@redhat.com> <8580a462-eadc-4fa5-b01a-c0b8c3ae644d@redhat.com>
 <CAK1f24=7=QqDFoh=joC+o1eZfyJ8onyc9ELBZBzn1CFr4uPSwQ@mail.gmail.com> <7f2ab112-5916-422c-b29f-343cc0d6d754@redhat.com>
In-Reply-To: <7f2ab112-5916-422c-b29f-343cc0d6d754@redhat.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Wed, 5 Jun 2024 23:43:06 +0800
Message-ID: <CAK1f24nDH2UxCskNsFM84=5uGTUb_bAUivgmQJCcE+H1dJHDxw@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] mm/rmap: integrate PMD-mapped folio splitting into
 pagewalk loop
To: David Hildenbrand <david@redhat.com>
Cc: Yin Fengwei <fengwei.yin@intel.com>, akpm@linux-foundation.org, willy@infradead.org, 
	sj@kernel.org, baolin.wang@linux.alibaba.com, maskray@google.com, 
	ziy@nvidia.com, ryan.roberts@arm.com, 21cnbao@gmail.com, mhocko@suse.com, 
	zokeefe@google.com, shy828301@gmail.com, xiehuan09@gmail.com, 
	libang.li@antgroup.com, wangkefeng.wang@huawei.com, songmuchun@bytedance.com, 
	peterx@redhat.com, minchan@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 11:03=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 05.06.24 16:57, Lance Yang wrote:
> > On Wed, Jun 5, 2024 at 10:39=E2=80=AFPM David Hildenbrand <david@redhat=
.com> wrote:
> >>
> >> On 05.06.24 16:28, David Hildenbrand wrote:
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
> >>>
> >>> Before this patch, we would have PTE-mapped the PMD-mapped THP before
> >>> reaching this call and skipped it due to "!folio_test_large(folio)".
> >>>
> >>> After this patch, we either
> >>>
> >>> a) PTE-remap the THP after this check, but retry and end-up here agai=
n,
> >>> whereby we would skip it due to "!folio_test_large(folio)".
> >>>
> >>> b) Discard the PMD-mapped THP due to lazyfree directly. Can that
> >>> co-exist with mlock and what would be the problem here with mlock?
> >>>
> >>>
> >
> > Thanks a lot for clarifying!
> >
> >>> So if the check is required in this patch, we really have to understa=
nd
> >>> why. If not, we should better drop it from this patch.
> >>>
> >>> At least my opinion, still struggling to understand why it would be
> >>> required (I have 0 knowledge about mlock interaction with large folio=
s :) ).
> >>>
> >>
> >> Looking at that series, in folio_references_one(), we do
> >>
> >>                          if (!folio_test_large(folio) || !pvmw.pte) {
> >>                                  /* Restore the mlock which got missed=
 */
> >>                                  mlock_vma_folio(folio, vma);
> >>                                  page_vma_mapped_walk_done(&pvmw);
> >>                                  pra->vm_flags |=3D VM_LOCKED;
> >>                                  return false; /* To break the loop */
> >>                          }
> >>
> >> I wonder if we want that here as well now: in case of lazyfree we
> >> would not back off, right?
> >>
> >> But I'm not sure if lazyfree in mlocked areas are even possible.
> >>
> >> Adding the "!pvmw.pte" would be much clearer to me than the flag check=
.
> >
> > Hmm... How about we drop it from this patch for now, and add it back if=
 needed
> > in the future?
>
> If we can rule out that MADV_FREE + mlock() keeps working as expected in
> the PMD-mapped case, we're good.
>
> Can we rule that out? (especially for MADV_FREE followed by mlock())

Perhaps we don't worry about that.

IIUC, without that check, MADV_FREE + mlock() still works as expected in
the PMD-mapped case, since if encountering a large folio in a VM_LOCKED
VMA range, we will stop the page walk immediately.

Thanks,
Lance


>
> --
> Cheers,
>
> David / dhildenb
>

