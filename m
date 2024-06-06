Return-Path: <linux-kernel+bounces-203597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1898FDD9F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 05:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C37BA1F257BA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 03:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D201F5F5;
	Thu,  6 Jun 2024 03:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lotxzlHv"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2805D19D8B9
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 03:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717646127; cv=none; b=BsePQMcvEgvRRUAfBuQC/uiD+sJunmq20KB39d6MTpmVPAbxK82YFg/OMOu9Vz0Ex5WxStmk/caP/82u/f6OCh9OxJDsHSDIUtc1tD6P2HybS3C0mYY34Z3+xc/xtunprJMJ0V8r/DK6G7T0XDde7Rm3O8x5r1acIia4LbUhVGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717646127; c=relaxed/simple;
	bh=JptyLecfETZZlTqTio563Ug6u9wJhGjG5LEf0ySITCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rRgfmNI9WpbKVTI2juS6QIvUmfSBFf4ZV/lrZOZXOpBmB57sokqF0bMbhRKxtzMGy5XhLVG8zeLfg4itQjrXSaWdnx8ZVZEx75atNcLiZJ95U+OjY0LKM2KzEYDf7N6k4X2qdEr4i/70ydpnw4dED8jlpHEI5PEwamJnJHi/d2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lotxzlHv; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57a9a3bc083so181139a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 20:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717646124; x=1718250924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zwuCiWLAKDNqOkyMb2HE5nvZt4WSpv0eSc7Hotju51I=;
        b=lotxzlHvJQSgp5NDlHSshFb1hN6xlBqtuggaYbd1voxcGwq4luzd+45rShJ/w70VUR
         +LHlwakkvmF2n2K5w5a0CeGBZTjWv5+rNI2Tr8iSGRjJh3oE4+YomI0ty99qgxbGfy8K
         0rbpzw48uNJRa0dZ2waTLFLueWShNqWyxT/M8FUBVMsT002cupcWNKyCZqwXOniGK5k/
         Bza2Niuv1crbElGqIKc2P+gkiP+Yv6Uw+yUHhlyDZ98NyanG0w549eNQeyG6tNqmQu6L
         xQJeUx7I12xuh2m4UdX66ALStIqRq2eT/UgiwhWXTbnBmi1YquXmqI5r6gmdHqBPaym1
         hm2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717646124; x=1718250924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zwuCiWLAKDNqOkyMb2HE5nvZt4WSpv0eSc7Hotju51I=;
        b=gGKwKSlhLbDKrTzLR8dg85CpCWv0Fv0O70Qier1fcCHQWXpvPU9wHESpt0O2cJL4dI
         17qOOPqsecs6zQqcsjD0BVkz+id4bXCnVePBGUkEvPSiqrpd8s5W5+X0lP0lCujlJrE6
         NuwT4giHZ3OsnVkyL8e+1dX+G9k+9G0QznVz3Swx+KAS2GFh4XabXEM+cbMuV5cBek3Z
         ceXPSodqLXAMA/q7SBVkARTZpnqwnmrThZBCn5lAyueQirl9tmVnPuMvSwNZVZ81gIfF
         OhRsmIWu51mlUiYBNqH4/JqilOiANfa+d3V+t+SWSE4C/efthGyx5oq/F7uKXj3oFX2L
         u3Cg==
X-Forwarded-Encrypted: i=1; AJvYcCWRUxnce4RsrKDy7SiC2n4hpnVE3YHYdY+wJTXM/2BRZ7/TCjamcXDRit+0tgQMIVzWH+tyIlbHq33zQMQPxF0GDbyou/PwDNyNmulQ
X-Gm-Message-State: AOJu0Yxt2fRmqBFzWYQQDrP3IavgWDlwV2iJJiZ48HQ2YTgJUkriYFAa
	Edhy3skgt/k7QlELEq79nlmUIRgQVUVFwRxL5ZZmcEHlhc0VWvre8aDXyQJoQZxoFSpC8AROpgX
	/jkneU5OYqRGtgUOdncSKKYV7AEM=
X-Google-Smtp-Source: AGHT+IHgwrML+4LDRnTpPeDCgixWl8mUVUFcKEtrgg+POneny9u/ICUeTtLD2xfHc3Pl22kHYnI+jZe7oz7f4aYcwoQ=
X-Received: by 2002:a50:aace:0:b0:579:edab:eff6 with SMTP id
 4fb4d7f45d1cf-57a8b6f8269mr3412557a12.23.1717646124105; Wed, 05 Jun 2024
 20:55:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521040244.48760-1-ioworker0@gmail.com> <20240521040244.48760-3-ioworker0@gmail.com>
 <fd16b219-bc46-484a-8581-a21240440fa6@redhat.com> <CAK1f24kwf4gDwK=8X4z1bM9-H6_M9QKy6-ko9pTUZij-W=40wg@mail.gmail.com>
 <d319f00e-9dfb-43b1-ae81-a2e2afdf36c4@redhat.com>
In-Reply-To: <d319f00e-9dfb-43b1-ae81-a2e2afdf36c4@redhat.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Thu, 6 Jun 2024 11:55:12 +0800
Message-ID: <CAK1f24kKra71RSQdFOpQecU6+yMELC748irKUt54Kg64-P=4-A@mail.gmail.com>
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

On Wed, Jun 5, 2024 at 10:28=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 05.06.24 16:20, Lance Yang wrote:
> > Hi David,
> >
> > On Wed, Jun 5, 2024 at 8:46=E2=80=AFPM David Hildenbrand <david@redhat.=
com> wrote:
> >>
> >> On 21.05.24 06:02, Lance Yang wrote:
> >>> In preparation for supporting try_to_unmap_one() to unmap PMD-mapped
> >>> folios, start the pagewalk first, then call split_huge_pmd_address() =
to
> >>> split the folio.
> >>>
> >>> Since TTU_SPLIT_HUGE_PMD will no longer perform immediately, we might
> >>> encounter a PMD-mapped THP missing the mlock in the VM_LOCKED range d=
uring
> >>> the page walk. It=E2=80=99s probably necessary to mlock this THP to p=
revent it from
> >>> being picked up during page reclaim.
> >>>
> >>> Suggested-by: David Hildenbrand <david@redhat.com>
> >>> Suggested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> >>> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> >>> ---
> >>
> >> [...] again, sorry for the late review.
> >
> > No worries at all, thanks for taking time to review!
> >
> >>
> >>> diff --git a/mm/rmap.c b/mm/rmap.c
> >>> index ddffa30c79fb..08a93347f283 100644
> >>> --- a/mm/rmap.c
> >>> +++ b/mm/rmap.c
> >>> @@ -1640,9 +1640,6 @@ static bool try_to_unmap_one(struct folio *foli=
o, struct vm_area_struct *vma,
> >>>        if (flags & TTU_SYNC)
> >>>                pvmw.flags =3D PVMW_SYNC;
> >>>
> >>> -     if (flags & TTU_SPLIT_HUGE_PMD)
> >>> -             split_huge_pmd_address(vma, address, false, folio);
> >>> -
> >>>        /*
> >>>         * For THP, we have to assume the worse case ie pmd for invali=
dation.
> >>>         * For hugetlb, it could be much worse if we need to do pud
> >>> @@ -1668,20 +1665,35 @@ static bool try_to_unmap_one(struct folio *fo=
lio, struct vm_area_struct *vma,
> >>>        mmu_notifier_invalidate_range_start(&range);
> >>>
> >>>        while (page_vma_mapped_walk(&pvmw)) {
> >>> -             /* Unexpected PMD-mapped THP? */
> >>> -             VM_BUG_ON_FOLIO(!pvmw.pte, folio);
> >>> -
> >>>                /*
> >>>                 * If the folio is in an mlock()d vma, we must not swa=
p it out.
> >>>                 */
> >>>                if (!(flags & TTU_IGNORE_MLOCK) &&
> >>>                    (vma->vm_flags & VM_LOCKED)) {
> >>>                        /* Restore the mlock which got missed */
> >>> -                     if (!folio_test_large(folio))
> >>> +                     if (!folio_test_large(folio) ||
> >>> +                         (!pvmw.pte && (flags & TTU_SPLIT_HUGE_PMD))=
)
> >>>                                mlock_vma_folio(folio, vma);
> >>
> >> Can you elaborate why you think this would be required? If we would ha=
ve
> >> performed the  split_huge_pmd_address() beforehand, we would still be
> >> left with a large folio, no?
> >
> > Yep, there would still be a large folio, but it wouldn't be PMD-mapped.
> >
> > After Weifeng's series[1], the kernel supports mlock for PTE-mapped lar=
ge
> > folio, but there are a few scenarios where we don't mlock a large folio=
, such
> > as when it crosses a VM_LOCKed VMA boundary.
> >
> >   -                     if (!folio_test_large(folio))
> >   +                     if (!folio_test_large(folio) ||
> >   +                         (!pvmw.pte && (flags & TTU_SPLIT_HUGE_PMD))=
)
> >
> > And this check is just future-proofing and likely unnecessary. If encou=
ntering a
> > PMD-mapped THP missing the mlock for some reason, we can mlock this
> > THP to prevent it from being picked up during page reclaim, since it is=
 fully
> > mapped and doesn't cross the VMA boundary, IIUC.
> >
> > What do you think?
> > I would appreciate any suggestions regarding this check ;)
>
> Reading this patch only, I wonder if this change makes sense in the
> context here.

Allow me to try explaining it again ;)

>
> Before this patch, we would have PTE-mapped the PMD-mapped THP before
> reaching this call and skipped it due to "!folio_test_large(folio)".

Yes, there is only a PTE-mapped THP when doing the "!folio_test_large(folio=
)"
check, as we will first conditionally split the PMD via
split_huge_pmd_address().

>
> After this patch, we either

Things will change. We'll first do the "!folio_test_large(folio)" check, th=
en
conditionally split the PMD via split_huge_pmd_address().

>
> a) PTE-remap the THP after this check, but retry and end-up here again,
> whereby we would skip it due to "!folio_test_large(folio)".

Hmm...

IIUC, we will skip it after this check, stop the page walk, and not
PTE-remap the THP.

>
> b) Discard the PMD-mapped THP due to lazyfree directly. Can that
> co-exist with mlock and what would be the problem here with mlock?

Before discarding a PMD-mapped THP as a whole, as patch #3 did,
we also perform the "!folio_test_large(folio)" check. If the THP coexists
with mlock, we will skip it, stop the page walk, and not discard it. IIUC.

>
>
> So if the check is required in this patch, we really have to understand
> why. If not, we should better drop it from this patch.

I added the "!pvmw.pte && (flags & TTU_SPLIT_HUGE_PMD))" check
in this patch just to future-proof mlock for a PMD-mapped THP missing
the mlock, to prevent it from being picked up during page reclaim.

But is this really required? It seems like nothing should really be broken
without this check.

Perhaps, we should drop it from this patch until we fully understand the
reason for it. Could you get me some suggestions?

Thanks,
Lance


>
> At least my opinion, still struggling to understand why it would be
> required (I have 0 knowledge about mlock interaction with large folios :)=
 ).
>
> --
> Cheers,
>
> David / dhildenb
>

