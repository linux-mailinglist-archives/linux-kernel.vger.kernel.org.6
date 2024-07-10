Return-Path: <linux-kernel+bounces-248376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7B392DC5A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 01:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BB701C21ADB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 23:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF59614D701;
	Wed, 10 Jul 2024 23:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UY1X/GRL"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E051143732
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 23:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720652919; cv=none; b=UlfcUZxZ4iH/UEDR2STkgWRhVlwOwd/yGXEcCaDNvaGv1dBDwMFxWd0/PO/P/J3gLgEcforCL3Jb0m0DErmFVszVngHt6SAixgAP5hcMphkCpalKt/geTwle4y0Z29HGg/21ZEsvTaS/uQa0N+J/iT4phiccd3ghaVI1bd+Ov3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720652919; c=relaxed/simple;
	bh=nF9etVJG2K43beOJSYcmsqeCte1hBCuT81LFefT+UrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fqq94gGN99zoFJcgElUpAJkpvG2gJKmb4RVXPwRKLKi7GzzhDiVbI/qwDUIPXuXpZnXVX/apWfk0T0uyn1obsSJK/RlajcuI/KSBWNrZ4vlv/Sc2a364KUfGEfkXPUi0ZMsgDQcFB6BW7O7t4D6mqxrLQirAbwzAkJMi1PTBs34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UY1X/GRL; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-44664ad946eso51181cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 16:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720652916; x=1721257716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OoGz0HLLFa4qZQJW+qHYgc410UtzwamboTgUAOBLLm8=;
        b=UY1X/GRLPBvSbSOqSAZjtxYPuHhQsXzV72BTY0kzC1XmLs6GDpflE0fwgUWb4NgM0l
         czswOIY5UMQQNjd35B54udgbcY6pa93z/qWhzyZegw/BzKVr6YAfqkzS1CrCVdYnbDGf
         HTVRnL3p0PUJo+sTQkXfdCRaY/DISOIUDhMI0lAztJVzFE1g1VROTS6ZmaUeFzDkv7F6
         gqfnQBtDzYl61ln1FymbBcugNk5gHRgOPgXXtLXFgqEX3PoBeN2z2sA+G09jfMaFnN+k
         GXu8fjMQw2G+e5Y1grOsZyiuKgjsMkCqVaR1Gt+40r/5869X3l3O1qgjuhg8lu78LYnt
         ubrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720652916; x=1721257716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OoGz0HLLFa4qZQJW+qHYgc410UtzwamboTgUAOBLLm8=;
        b=F/GLwhVBDuDuq5ZtYSywM2MP3BUFlOXbxx7gYRpiEnpkE7Px7Z6t76v8eqKOtKmXnp
         kdEEYgvFuvNzLnBv2WIpRlHlYDBGxael9mO+bL4FvheSt4J2BWAMn3WzOWZt+YZ7WpsD
         ER+iM/ETAxtaU0qxHuHHTOAHX/6HUloHkK27C2ftQsSoTSeNr8lJ8E07/oKf5QzuzOlu
         hjR/JwB8P/0pph1zUCW4wXbXNlA4qIzMrn1VA9ktHswbJXgQuWQOXJ6Rv8hsbn26zYZn
         Md3BZR/Y2bpb/5acwChqmFfvbkzISFJy9V6xizmdJE1Otz57oNVU4mYf6DeD6ks6ioOU
         K8Cg==
X-Forwarded-Encrypted: i=1; AJvYcCXaXz8xXM6Qz9mbdKNZed6kNhiG6IAy5fIkkSh5m9StAXrgWBs2UPVCBXB8uyPEdqKar+e+IitgIKI3C1DwRDYgr4T3wxsBdy4vBtRL
X-Gm-Message-State: AOJu0YzhTScIICQh7FGlM0OcmwJmk8+LPGffFIi7Gob7baQ59p6d988P
	VvD1cy0zBd046xLqZlWv7Cz2YFkW6OphzdyYopMbwmkB30Oe9ZCnnydZowtMl5USpEVo5IrATBA
	4CuarRJ6VA5WxzATEz42WyqrbjxU+QoHvITyr
X-Google-Smtp-Source: AGHT+IGhsWC2zhiEe5HyqIKFiKRUuXkTjH/M95dSoqq3vPDJECDG2/qkfwLCxcq4j0ry3fp+0ptH1cfEcUOLFV8wr8s=
X-Received: by 2002:ac8:4509:0:b0:444:e366:3fda with SMTP id
 d75a77b69052e-44d35b2bd77mr591451cf.27.1720652916040; Wed, 10 Jul 2024
 16:08:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240113094436.2506396-1-sunnanyong@huawei.com>
 <ZbKjHHeEdFYY1xR5@arm.com> <d1671959-74a4-8ea5-81f0-539df8d9c0f0@huawei.com>
 <ZcN7P0CGUOOgki71@arm.com> <CAOUHufYo=SQmpaYA3ThrdHcY9fQfFmycriSvOX1iuC4Y=Gj7Xg@mail.gmail.com>
 <ZogV9Iag4mxe6enx@arm.com> <CAOUHufYwoTTsRBF_wWZU_jWzb8e6FF=vN8UKtVHBeXLBkwHWzA@mail.gmail.com>
 <Zo68DP6siXfb6ZBR@arm.com> <CAOUHufZC0Jn=bTpc0JhqONXbYXgyBOVZ4j8bbKSJWv1dOSmQEA@mail.gmail.com>
 <Zo8LTaP-6-zIcc9v@arm.com>
In-Reply-To: <Zo8LTaP-6-zIcc9v@arm.com>
From: Yu Zhao <yuzhao@google.com>
Date: Wed, 10 Jul 2024 17:07:57 -0600
Message-ID: <CAOUHufawuXOifhrULx6mC0Kv0_sbjT0y16QMePiw=gH9b6xxAw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] A Solution to Re-enable hugetlb vmemmap optimize
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Nanyong Sun <sunnanyong@huawei.com>, will@kernel.org, mike.kravetz@oracle.com, 
	muchun.song@linux.dev, akpm@linux-foundation.org, anshuman.khandual@arm.com, 
	willy@infradead.org, wangkefeng.wang@huawei.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 4:29=E2=80=AFPM Catalin Marinas <catalin.marinas@ar=
m.com> wrote:
>
> On Wed, Jul 10, 2024 at 11:12:01AM -0600, Yu Zhao wrote:
> > On Wed, Jul 10, 2024 at 10:51=E2=80=AFAM Catalin Marinas
> > <catalin.marinas@arm.com> wrote:
> > > On Fri, Jul 05, 2024 at 11:41:34AM -0600, Yu Zhao wrote:
> > > > On Fri, Jul 5, 2024 at 9:49=E2=80=AFAM Catalin Marinas <catalin.mar=
inas@arm.com> wrote:
> > > > > If I did the maths right, for a 2MB hugetlb page, we have about 8
> > > > > vmemmap pages (32K). Once we split a 2MB vmemap range,
> > > >
> > > > Correct.
> > > >
> > > > > whatever else
> > > > > needs to be touched in this range won't require a stop_machine().
> > > >
> > > > There might be some misunderstandings here.
> > > >
> > > > To do HVO:
> > > > 1. we split a PMD into 512 PTEs;
> > > > 2. for every 8 PTEs:
> > > >   2a. we allocate an order-0 page for PTE #0;
> > > >   2b. we remap PTE #0 *RW* to this page;
> > > >   2c. we remap PTEs #1-7 *RO* to this page;
> > > >   2d. we free the original order-3 page.
> > >
> > > Thanks. I now remember why we reverted such support in 060a2c92d1b6
> > > ("arm64: mm: hugetlb: Disable HUGETLB_PAGE_OPTIMIZE_VMEMMAP"). The ma=
in
> > > problem is that point 2c also changes the output address of the PTE
> > > (and the content of the page slightly). The architecture requires a
> > > break-before-make in such scenario, though it would have been nice if=
 it
> > > was more specific on what could go wrong.
> > >
> > > We can do point 1 safely if we have FEAT_BBM level 2. For point 2, I
> > > assume these 8 vmemmap pages may be accessed and that's why we can't =
do
> > > a break-before-make safely.
> >
> > Correct
> >
> > > I was wondering whether we could make the
> > > PTEs RO first and then change the output address but we have another
> > > rule that the content of the page should be the same. I don't think
> > > entries 1-7 are identical to entry 0 (though we could ask the archite=
cts
> > > for clarification here). Also, can we guarantee that nothing writes t=
o
> > > entry 0 while we would do such remapping?
> >
> > Yes, it's already guaranteed.
> >
> > > We know entries 1-7 won't be
> > > written as we mapped them as RO but entry 0 contains the head page.
> > > Maybe it's ok to map it RO temporarily until the newly allocated huge=
tlb
> > > page is returned.
> >
> > We can do that. I don't understand how this could elide BBM. After the
> > above, we would still need to do:
> > 3. remap entry 0 from RO to RW, mapping the `struct page` page that
> > will be shared with entry 1-7.
> > 4. remap entry 1-7 from their respective `struct page` pages to that
> > of entry 0, while they remain RO.
>
> The Arm ARM states that we need a BBM if we change the output address
> and: the old or new mappings are RW *or* the content of the page
> changes. Ignoring the latter (page content), we can turn the PTEs RO
> first without changing the pfn followed by changing the pfn while they
> are RO. Once that's done, we make entry 0 RW and, of course, with
> additional TLBIs between all these steps.

Aha! This is easy to do -- I just made the RO guaranteed, as I
mentioned earlier.

Just to make sure I fully understand the workflow:

1. Split a RW PMD into 512 RO PTEs, pointing to the same 2MB `struct page` =
area.
2. TLBI once, after pmd_populate_kernel()
3. Remap PTE 1-7 to the 4KB `struct page` area of PTE 0, for every 8
PTEs, while they remain RO.
4. TLBI once, after set_pte_at() on PTE 1-7.
5. Change PTE 0 from RO to RW, pointing to the same 4KB `struct page` area.
6. TLBI once, after set_pte_at() on PTE 0.

No BBM required, regardless of FEAT_BBM level 2.

Is this correct?

> Can we leave entry 0 RO? This
> would save an additional TLBI.

Unfortunately we can't. Otherwise we wouldn't be able to, e.g., grab a
refcnt on any hugeTLB pages.

> Now, I wonder if all this is worth it. What are the scenarios where the
> 8 PTEs will be accessed? The vmemmap range corresponding to a 2MB
> hugetlb page for example is pretty well defined - 8 x 4K pages, aligned.
>
> > > If we could get the above work, it would be a lot simpler than thinki=
ng
> > > of stop_machine() or other locks to wait for such remapping.
> >
> > Steps 3/4 would not require BBM somehow?
>
> If we ignore the 'content' requirement, I think we could skip the BBM
> but we need to make sure we don't change the permission and pfn at the
> same time.

Gotcha.

> > > > To do de-HVO:
> > > > 1. for every 8 PTEs:
> > > >   1a. we allocate 7 order-0 pages.
> > > >   1b. we remap PTEs #1-7 *RW* to those pages, respectively.
> > >
> > > Similar problem in 1.b, changing the output address. Here we could fo=
rce
> > > the content to be the same
> >
> > I don't follow the "the content to be the same" part. After HVO, we hav=
e:
> >
> > Entry 0 -> `struct page` page A, RW
> > Entry 1 -> `struct page` page A, RO
> > ...
> > Entry 7 -> `struct page` page A, RO
> >
> > To de-HVO, we need to make them:
> >
> > Entry 0 -> `struct page` page A, RW
> > Entry 1 -> `struct page` page B, RW
> > ...
> > Entry 7 -> `struct page` page H, RW
> >
> > I assume the same content means PTE_0 =3D=3D PTE_1/.../7?
>
> That's the content of the page at the corresponding pfn before and after
> the pte change. I'm pretty sure the Arm ARM states this in case the
> hardware starts a load (e.g. unaligned) from one page and completes it
> from another, the software should not see any difference. But for the
> fields we care about in struct page, I assume they'd be the same (or
> that we just don't care about inconsistencies during this transient
> period).

Thanks for the explanation. I'll cook up something if my understanding
above is correct.

