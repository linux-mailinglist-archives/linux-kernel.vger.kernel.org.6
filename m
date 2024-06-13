Return-Path: <linux-kernel+bounces-212893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B799067DF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62BF328229B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661E513D50E;
	Thu, 13 Jun 2024 08:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlRg56kO"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FC113D52C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 08:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718269009; cv=none; b=UxZden6NkTeeEsTmxOEkIXK6/np4kkqUecDdsXsCy/hKFy1k6QAmgIjzCvy8J9lAt6wTWijDtsWzZO1gVHr+0whME3+ZcRyaGjtw4Xv5Jx3XySC39ybZvh1ZHXABl5k5EEge4+6gLh2ljZzrNZ3BnaGB1nu7a42gA2nD1LFdjsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718269009; c=relaxed/simple;
	bh=Zq0PxpI8SNXZOiqfKVPCA9go+37YHmBDZUPOvsWAOeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IYB5p7N1uI5KOWe1NGhKtMM2jm6TTjyREbnhT1bXN5qLeDwEm5nHc5Ts71aUGc7Y02dPpZQaAAGDpaK4X2/FcP0utduYcQ0+B0NUIsVGKMfk3kjAvbw3pgFS9Ph/1MZn5Ch6y3wB44kfBx+MBAqgSJd8U46l3mfihi7ryNx2oaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RlRg56kO; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ebe40673e8so6645311fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 01:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718269006; x=1718873806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kZX2WwAINlm2dnG08K3dNiRiVVFaPvt78cXx+6SPatk=;
        b=RlRg56kOxVmCeeohfC65wqeyh+6chlw6fZBhSUIXkUcbKimTAMIgyKLnuYKgAmU3dR
         m5s18LoUb+5PIUqSQpiIZHVkib6qgww7ck7RbJOUMxj3z6ajljcAx+fordbW27b7DMtt
         FJ014lJlHDVhK0jsSupYimxOtlm+EJWK0S714GmMJODAXzHlhND5ZKvFjCoQ6BzkBMJ6
         W/mcLkkRy6vUQqO7Tp1mto51kn4zsgnkSB0dNRcEEOwzjNwa8j+83linb7QE4EvctiiK
         ZmXJwnPl7RGCL/SLQD1OzssDRIEQqcvImPgFipD3eQeux1J7D2YNku+9OG6kZ8xA8bPx
         8Ckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718269006; x=1718873806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kZX2WwAINlm2dnG08K3dNiRiVVFaPvt78cXx+6SPatk=;
        b=kNA+BmD4WtN7zVkx1yE6nktW3g5+MKpHK7KxuPwAcD2+EPNhQZLZWosAOf+uhymtcn
         +voXoFngcsVIaEm0DvENvHUYPHVRzw1rDCbJ8Bo5WJK5m/JZC/Zygcn/fJvsFRwjgdFq
         z4yhWXAWN0gK3VjW9fCc4QBErHfoBWURkEKhMXLhB8kZ5OxoHCinPrZSZiP/ai4eLY1j
         fW4EoT+A3C8VuRgeZmKIwhOXKIvD1hTX157p9+vh1ECXkrlfm34dFqC/PszGnAqGgGXA
         lyAt2uiG0apJktrHv94liFH/J1P1XRuZViQcYPv4SjgyWwXDsnQPgqW+SkyDqzm1QRHF
         Fi8A==
X-Forwarded-Encrypted: i=1; AJvYcCWpHngyA0uDJFSIbwbyOplduLDRFaqMjUagRp70G7BzJ297IN383YUuw454enk3zEUwU3e64lLhYY8k70TwWq4wLYyl3Zfz8mRcIcf6
X-Gm-Message-State: AOJu0YwgHniWZL5pmLr3eBcWXKjJu820VZRi7gz98bDQhlNMcsU+UHd6
	LrJr6av0QurtXLr++Pvmrv+rErBg9oby/wgVq5xmdHk+4ITZh2ddTZB6up2BCsAmVsFLelKZlwX
	DgZkLjyR9mtIDtS8i4WKzr+Joozw=
X-Google-Smtp-Source: AGHT+IEKxKd+fOM4lT24EFbmpWHNxeD7S6i9WuElPROWBSwMH+z09CHHmllDqvbFP6PpzSPJmgI2NnItObhjGyWX7Ao=
X-Received: by 2002:a2e:80d2:0:b0:2eb:f5ce:a0fa with SMTP id
 38308e7fff4ca-2ebfc96483amr26295121fa.46.1718269005929; Thu, 13 Jun 2024
 01:56:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610120809.66601-1-ioworker0@gmail.com> <20240613072858.16512-1-ioworker0@gmail.com>
 <d48bcbcc-0935-4d04-b6a8-f1ceec8190bf@linux.alibaba.com>
In-Reply-To: <d48bcbcc-0935-4d04-b6a8-f1ceec8190bf@linux.alibaba.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Thu, 13 Jun 2024 16:56:34 +0800
Message-ID: <CAK1f24nr4khVun9eSanywYhA3-0LGn-ZDV2kLVkToRTekVfG2g@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] mm/vmscan: avoid split lazyfree THP during shrink_folio_list()
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, 21cnbao@gmail.com, david@redhat.com, 
	fengwei.yin@intel.com, libang.li@antgroup.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, maskray@google.com, mhocko@suse.com, minchan@kernel.org, 
	peterx@redhat.com, ryan.roberts@arm.com, shy828301@gmail.com, sj@kernel.org, 
	songmuchun@bytedance.com, wangkefeng.wang@huawei.com, willy@infradead.org, 
	xiehuan09@gmail.com, ziy@nvidia.com, zokeefe@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 4:20=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 2024/6/13 15:28, Lance Yang wrote:
> > Hi Andrew,
> >
> > I'd like to fix the bug[1] I mentioned previously. Could you please fol=
d the
> > following changes into this patch?
> >
> > [1] https://lore.kernel.org/linux-mm/20240613065521.15960-1-ioworker0@g=
mail.com/
> >
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index f409ea9fcc18..425374ae06ed 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -2707,10 +2707,8 @@ static bool __discard_anon_folio_pmd_locked(stru=
ct vm_area_struct *vma,
> >       if (unlikely(page_folio(page) !=3D folio))
> >               return false;
> >
> > -     if (folio_test_dirty(folio) || pmd_dirty(orig_pmd)) {
> > -             folio_set_swapbacked(folio);
> > +     if (folio_test_dirty(folio) || pmd_dirty(orig_pmd))
> >               return false;
> > -     }
> >
> >       orig_pmd =3D pmdp_huge_clear_flush(vma, addr, pmdp);
> >
> > @@ -2737,10 +2735,8 @@ static bool __discard_anon_folio_pmd_locked(stru=
ct vm_area_struct *vma,
> >        *
> >        * The only folio refs must be one from isolation plus the rmap(s=
).
> >        */
> > -     if (folio_test_dirty(folio) || pmd_dirty(orig_pmd))
> > -             folio_set_swapbacked(folio);
> > -
> > -     if (folio_test_swapbacked(folio) || ref_count !=3D map_count + 1)=
 {
> > +     if (folio_test_dirty(folio) || pmd_dirty(orig_pmd) ||
> > +         ref_count !=3D map_count + 1) {
> >               set_pmd_at(mm, addr, pmdp, orig_pmd);
> >               return false;
> >       }
> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index b9e5943c8349..393e2c11c44c 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -1824,12 +1824,7 @@ static bool try_to_unmap_one(struct folio *folio=
, struct vm_area_struct *vma,
> >                        */
> >                       if (unlikely(folio_test_swapbacked(folio) !=3D
> >                                       folio_test_swapcache(folio))) {
> > -                             /*
> > -                              * unmap_huge_pmd_locked() will unmark a
> > -                              * PMD-mapped folio as lazyfree if the fo=
lio or
> > -                              * its PMD was redirtied.
> > -                              */
> > -                             WARN_ON_ONCE(!pmd_mapped);
> > +                             WARN_ON_ONCE(1);
> >                               goto walk_done_err;
> >                       }
> >
>
> You can also drop the unused 'pmd_mapped' variable now.

Good catch!

Will drop it in the next version.

Thanks,
Lance

