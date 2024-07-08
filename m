Return-Path: <linux-kernel+bounces-244122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D999929F76
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 11:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F76DB2817B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 09:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE05A6A8D2;
	Mon,  8 Jul 2024 09:46:23 +0000 (UTC)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBCD3C08A
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 09:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720431983; cv=none; b=b6phTHKcZtj90byZaqTDbj7UAVAGlKURpuwN8ebVI2BGwt9OCWTSNrRoOwEwnfbsirJ2axTTWaA/fbV/K2XrhC23Y3Y4BjOpIfkfwE//o/0/ADh91Zd/wIp7bfmaUYNTd7zSwpm6FQkkAHlwROKK21m4r5rD/jtcvJRYcwbBGts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720431983; c=relaxed/simple;
	bh=acGpI95Z81dh1AlmKqkEh8/oj6bi4FcdQoAbNsD+yXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uCAcKFIO/gzuOZwI1HUn9zQ45c1EFP5VsGuw8/5s0YXdjmD4FV9zHuklePqwBbTWsAem/nM7+02HVHa/wiHXP7a7+HL/FVO3kdRsw894QVGWKfbOlxhavtY1VeHqbeV+D3rNTXb0e4uLL9o7Ar/9/r4xftkTzXRhwJbt61NWLFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-8100eca5345so956662241.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 02:46:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720431980; x=1721036780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SpLSB/CN2SDFiRQYc+S++TJqbe4+r/mJtlnD6MtwaQs=;
        b=I+2W0tfJV9VsPB14LsHq0cLaqi/1MTXZjlvzPIimm//fvfl57a519uMDwg5DcuEZ70
         HrXZfOxB5dG2aTL7ipoOsF6IhXML1Ag221wGfRsEIKkJIM+GjdUJ/J9i8F1BbU6kMzxu
         /NR0MF7G1UsdG03fp8kX1rv/TjHeLSwd4pxH95KEuSdAmeSHKULpSVTABNhoXybMqM+1
         iRMOxHor4UMmsuBBcgAK/CVztXE8DO7uxH8nqnjm+Couk8asGgAzJ1Y+HY5LWc89ChZh
         j8/ciD4sB3LLP+Lxn7oEh/ijuscqz2zqTsjC1qgAVwnbscyEwKc4KCdV0b8Hirh/nCH3
         gL8g==
X-Forwarded-Encrypted: i=1; AJvYcCWBvpP4U0Ug/d1Cyd7JUVFr6R/HlXF6O8MYV0fm+DjH3Ed9sIV24L0Ao8GZuv0TllcdX1yHZyBkkzZE+5K2wXU3MIlihz3pXKQi4qof
X-Gm-Message-State: AOJu0Yy98OJgY+MUcrgvmxeWtexumYyumj+l1UKNkEoCx9uLC7kAmR1G
	P0lQlyfeWshcENDF9oeMWM1ST51Di2iLUstBj40cweaP2e8Ml79HFyXEJd0d8DOyi4ZEvaMNg++
	CKI+ms8FcF9r/MpB8IZL8vK+yZDE=
X-Google-Smtp-Source: AGHT+IHqK7myHjemDaFxYt787o7c+4YGD60lg9B5FlPkiyuZ62jj9iBrgp0YtirZcF97qT59X1j+vMhhyx75N7KNzEg=
X-Received: by 2002:a05:6102:4653:b0:48f:e9df:ec4d with SMTP id
 ada2fe7eead31-48fee6462d0mr11933834137.2.1720431980445; Mon, 08 Jul 2024
 02:46:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708090413.888-1-justinjiang@vivo.com> <ad7873f4-9c98-45cc-b7be-0c1c36b65ade@redhat.com>
In-Reply-To: <ad7873f4-9c98-45cc-b7be-0c1c36b65ade@redhat.com>
From: Barry Song <baohua@kernel.org>
Date: Mon, 8 Jul 2024 21:46:07 +1200
Message-ID: <CAGsJ_4zN95hh6G15L=hCTmXx4Y_OC-ExpsU7iErZ2SiZZaxmhA@mail.gmail.com>
Subject: Re: [PATCH v5] mm: shrink skip folio mapped by an exiting process
To: David Hildenbrand <david@redhat.com>
Cc: Zhiguo Jiang <justinjiang@vivo.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 9:36=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 08.07.24 11:04, Zhiguo Jiang wrote:
> > The releasing process of the non-shared anonymous folio mapped solely b=
y
> > an exiting process may go through two flows: 1) the anonymous folio is
> > firstly is swaped-out into swapspace and transformed into a swp_entry
> > in shrink_folio_list; 2) then the swp_entry is released in the process
> > exiting flow. This will increase the cpu load of releasing a non-shared
> > anonymous folio mapped solely by an exiting process, because the folio
> > go through swap-out and the releasing the swapspace and swp_entry.
> >
> > When system is low memory, it is more likely to occur, because more
> > backend applidatuions will be killed.
> >
> > The modification is that shrink skips the non-shared anonymous folio
> > solely mapped by an exting process and the folio is only released
> > directly in the process exiting flow, which will save swap-out time
> > and alleviate the load of the process exiting.
> >
> > Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
> > ---
> >
> > Change log:
> > v4->v5:
> > 1.Modify to skip non-shared anonymous folio only.
> > 2.Update comments for pra->referenced =3D -1.
> > v3->v4:
> > 1.Modify that the unshared folios mapped only in exiting task are skip.
> > v2->v3:
> > Nothing.
> > v1->v2:
> > 1.The VM_EXITING added in v1 patch is removed, because it will fail
> > to compile in 32-bit system.
> >
> >   mm/rmap.c   | 13 +++++++++++++
> >   mm/vmscan.c |  7 ++++++-
> >   2 files changed, 19 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index 26806b49a86f..5b5281d71dbb
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -843,6 +843,19 @@ static bool folio_referenced_one(struct folio *fol=
io,
> >       int referenced =3D 0;
> >       unsigned long start =3D address, ptes =3D 0;
> >
> > +     /*
> > +      * Skip the non-shared anonymous folio mapped solely by
> > +      * the single exiting process, and release it directly
> > +      * in the process exiting.
> > +      */
> > +     if ((!atomic_read(&vma->vm_mm->mm_users) ||
> > +             test_bit(MMF_OOM_SKIP, &vma->vm_mm->flags)) &&
> > +             folio_test_anon(folio) && folio_test_swapbacked(folio) &&
> > +             !folio_likely_mapped_shared(folio)) {
>
> I'm currently working on moving all folio_likely_mapped_shared() under
> the PTL, where we are then sure that the folio is actually mapped by
> this process (e.g., no concurrent unmapping poisslbe).
>
> Can we do the same here directly?

Implementing this is challenging because page_vma_mapped_walk() is
responsible for
traversing the page table to acquire and release the PTL. This becomes
particularly
complex with mTHP, as we may need to interrupt the page_vma_mapped_walk
loop at the first PTE.

>
> --
> Cheers,
>
> David / dhildenb
>

Thanks
Barry

