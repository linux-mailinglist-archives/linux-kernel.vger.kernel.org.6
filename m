Return-Path: <linux-kernel+bounces-248824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6EC92E273
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 10:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FF10B2534A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 08:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19A01514D1;
	Thu, 11 Jul 2024 08:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xe/SvgyA"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091CB1509BC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 08:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720686727; cv=none; b=g8KZK0XQ3rl+SMz7NjVCM73A7qSn39Oj0D8r3OBvg97zjwISd5Wo3NPiywGGQ+xfm8F9DuMKGgcnDdmEproHr8c7OFTyFKPmFNPywQTdCiEZoNtdiioIgqQojkx2Ql6zwKa3cgbFkX8Rj5Pf/MepemgJiYkofPL93V3FAjwgHQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720686727; c=relaxed/simple;
	bh=Q9IroUVK2JqRYrIfw5alHwnQixrL2oKDXVExImqaZZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rL/tm7l3ExexEMywaavzU6hKpD+MsY/J+xviDyEbXHVHjPBPSa5P6Ii7/XErFtQULfkBIXbg8z8O+eMbtPVGwwQFkNQV0s+HeFqtOADj3z+QVhry0yGOKyOO7HHNqYbhbrAtiXOf7w2OjeBsnoXXWwUYTBSTd2cPMOtwZMNfB1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xe/SvgyA; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-447df43324fso153101cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 01:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720686725; x=1721291525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YWHIbu+cvMagxFrDg1eyheaCUlAQDPbuPi2dpyEJyRM=;
        b=xe/SvgyA5r4jK6JBtYBXEt0FLciQINJjJffDPCxM3qFzYh7BmjxOeTJySFjoZ7ZmX3
         0l+yP/ZuBIV+Y3GnF9lXhIrrZc6kwdp135XwyNazwfnTc6CyyXfeej1BdXNWAhWPkF5y
         cbRMk8nNFD/4voeSj465mN8E8gHfJDLr2gipNKtIhfCNLV/GxL5+2zZ5mYMiL7SOc+j4
         oe85jkijTbYH4bbvzKfDkmWswyhMb6eMO1YD330H84RntdpTdH4zGmJ2zBi4AtENIFwE
         XuvbVFYoR2FhMvfq5HqoKA1BifXy5EClOvT5zXh9zvf0e1EaNEmvr6svSeQyBSyfdfV4
         oe8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720686725; x=1721291525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YWHIbu+cvMagxFrDg1eyheaCUlAQDPbuPi2dpyEJyRM=;
        b=vlo+rkZjTqTFhYtER5KhRiA/QGAG3BmUTiD4iIkZrx1EO6VXPTAg5iMtWLijHeNJIS
         jQVGGHjU03KObfZs7DpHC936D1tfilBxn2GOwCtNB6khnBk0nRv0WOQywntGTkJbul0J
         r3TypRp03aShK1ohS6t+xqnSq2A7p6CZ79FVuG4/LrLJpbr6AlOOnhrJy4FvSboy8G4Q
         Mr3lbyOkRDm9+eO2A5VQtXgPcPkPeoQIhgIoPHWpj/CHuQyZ8sC/M8853RxTC6QLHbtH
         UGQ8vkuTsURwZkPwJ9CjikgxqQVbE1wCvbuUTVRErb3L1qyQe/Cti1HoGTg9DrOCuX43
         R/mw==
X-Forwarded-Encrypted: i=1; AJvYcCWbKkAyVz3ZyVxvqzSybMGSZFvQIW5NvmIdJgvoMCsmKuXFHQA9Za1tEk9//YWa+uyDQkePoMkXzVAFOPBTO/LvI8ozOA+yFwAUnKw0
X-Gm-Message-State: AOJu0Ywb+L+YO+0K2tbwxZPZKYghBwVol9J2TQ/su+UJjv3PrnsGLaaZ
	RORgqbg81YbdWoHu0bj7km+gbnbbiy9dOtvPB1I6fCxxobnaSxL8b1+xsfiVkb7uDtgjQqyGmTT
	yhmuFpuJvpJpoGReFc/qJ2xq1QVHZtDOJRDgm
X-Google-Smtp-Source: AGHT+IGNqoML5kFUzVyQW8QnecFL6JZ0uDikh8HvHvIwDxa22nsavjslwHT/oJO6b3GimZSsoJkxgY4rNb48ZWdPxNw=
X-Received: by 2002:ac8:73ca:0:b0:447:e01a:de95 with SMTP id
 d75a77b69052e-44d07cc7faemr2510091cf.0.1720686724500; Thu, 11 Jul 2024
 01:32:04 -0700 (PDT)
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
 <Zo8LTaP-6-zIcc9v@arm.com> <CAOUHufawuXOifhrULx6mC0Kv0_sbjT0y16QMePiw=gH9b6xxAw@mail.gmail.com>
In-Reply-To: <CAOUHufawuXOifhrULx6mC0Kv0_sbjT0y16QMePiw=gH9b6xxAw@mail.gmail.com>
From: Yu Zhao <yuzhao@google.com>
Date: Thu, 11 Jul 2024 02:31:25 -0600
Message-ID: <CAOUHufb3CHLCo54fZcPSG+mrXD-kRsa0Foi8=vL5=q+YHpQ+Rg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] A Solution to Re-enable hugetlb vmemmap optimize
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Nanyong Sun <sunnanyong@huawei.com>, will@kernel.org, mike.kravetz@oracle.com, 
	muchun.song@linux.dev, akpm@linux-foundation.org, anshuman.khandual@arm.com, 
	willy@infradead.org, wangkefeng.wang@huawei.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 5:07=E2=80=AFPM Yu Zhao <yuzhao@google.com> wrote:
>
> On Wed, Jul 10, 2024 at 4:29=E2=80=AFPM Catalin Marinas <catalin.marinas@=
arm.com> wrote:
> >
> > On Wed, Jul 10, 2024 at 11:12:01AM -0600, Yu Zhao wrote:
> > > On Wed, Jul 10, 2024 at 10:51=E2=80=AFAM Catalin Marinas
> > > <catalin.marinas@arm.com> wrote:
> > > > On Fri, Jul 05, 2024 at 11:41:34AM -0600, Yu Zhao wrote:
> > > > > On Fri, Jul 5, 2024 at 9:49=E2=80=AFAM Catalin Marinas <catalin.m=
arinas@arm.com> wrote:
> > > > > > If I did the maths right, for a 2MB hugetlb page, we have about=
 8
> > > > > > vmemmap pages (32K). Once we split a 2MB vmemap range,
> > > > >
> > > > > Correct.
> > > > >
> > > > > > whatever else
> > > > > > needs to be touched in this range won't require a stop_machine(=
).
> > > > >
> > > > > There might be some misunderstandings here.
> > > > >
> > > > > To do HVO:
> > > > > 1. we split a PMD into 512 PTEs;
> > > > > 2. for every 8 PTEs:
> > > > >   2a. we allocate an order-0 page for PTE #0;
> > > > >   2b. we remap PTE #0 *RW* to this page;
> > > > >   2c. we remap PTEs #1-7 *RO* to this page;
> > > > >   2d. we free the original order-3 page.
> > > >
> > > > Thanks. I now remember why we reverted such support in 060a2c92d1b6
> > > > ("arm64: mm: hugetlb: Disable HUGETLB_PAGE_OPTIMIZE_VMEMMAP"). The =
main
> > > > problem is that point 2c also changes the output address of the PTE
> > > > (and the content of the page slightly). The architecture requires a
> > > > break-before-make in such scenario, though it would have been nice =
if it
> > > > was more specific on what could go wrong.
> > > >
> > > > We can do point 1 safely if we have FEAT_BBM level 2. For point 2, =
I
> > > > assume these 8 vmemmap pages may be accessed and that's why we can'=
t do
> > > > a break-before-make safely.
> > >
> > > Correct
> > >
> > > > I was wondering whether we could make the
> > > > PTEs RO first and then change the output address but we have anothe=
r
> > > > rule that the content of the page should be the same. I don't think
> > > > entries 1-7 are identical to entry 0 (though we could ask the archi=
tects
> > > > for clarification here). Also, can we guarantee that nothing writes=
 to
> > > > entry 0 while we would do such remapping?
> > >
> > > Yes, it's already guaranteed.
> > >
> > > > We know entries 1-7 won't be
> > > > written as we mapped them as RO but entry 0 contains the head page.
> > > > Maybe it's ok to map it RO temporarily until the newly allocated hu=
getlb
> > > > page is returned.
> > >
> > > We can do that. I don't understand how this could elide BBM. After th=
e
> > > above, we would still need to do:
> > > 3. remap entry 0 from RO to RW, mapping the `struct page` page that
> > > will be shared with entry 1-7.
> > > 4. remap entry 1-7 from their respective `struct page` pages to that
> > > of entry 0, while they remain RO.
> >
> > The Arm ARM states that we need a BBM if we change the output address
> > and: the old or new mappings are RW *or* the content of the page
> > changes. Ignoring the latter (page content), we can turn the PTEs RO
> > first without changing the pfn followed by changing the pfn while they
> > are RO. Once that's done, we make entry 0 RW and, of course, with
> > additional TLBIs between all these steps.
>
> Aha! This is easy to do -- I just made the RO guaranteed, as I
> mentioned earlier.
>
> Just to make sure I fully understand the workflow:
>
> 1. Split a RW PMD into 512 RO PTEs, pointing to the same 2MB `struct page=
` area.
> 2. TLBI once, after pmd_populate_kernel()
> 3. Remap PTE 1-7 to the 4KB `struct page` area of PTE 0, for every 8
> PTEs, while they remain RO.
> 4. TLBI once, after set_pte_at() on PTE 1-7.
> 5. Change PTE 0 from RO to RW, pointing to the same 4KB `struct page` are=
a.
> 6. TLBI once, after set_pte_at() on PTE 0.
>
> No BBM required, regardless of FEAT_BBM level 2.

I just studied D8.16.1 from the reference manual, and it seems to me:
1. We still need either FEAT_BBM or BBM to split PMD.
2. We still need BBM when we change PTE 1-7, because even if they
remain RO, the content of the `struct page` page at the new location
does not match that at the old location.

> Is this correct?
>
> > Can we leave entry 0 RO? This
> > would save an additional TLBI.
>
> Unfortunately we can't. Otherwise we wouldn't be able to, e.g., grab a
> refcnt on any hugeTLB pages.
>
> > Now, I wonder if all this is worth it. What are the scenarios where the
> > 8 PTEs will be accessed? The vmemmap range corresponding to a 2MB
> > hugetlb page for example is pretty well defined - 8 x 4K pages, aligned=
.

One of the fundamental assumptions in core MM is that anyone can
read or try to grab (write) a refcnt from any `struct page`. Those
speculative PFN walkers include memory compaction, etc.


> > > > If we could get the above work, it would be a lot simpler than thin=
king
> > > > of stop_machine() or other locks to wait for such remapping.
> > >
> > > Steps 3/4 would not require BBM somehow?
> >
> > If we ignore the 'content' requirement, I think we could skip the BBM
> > but we need to make sure we don't change the permission and pfn at the
> > same time.
>
> Gotcha.
>
> > > > > To do de-HVO:
> > > > > 1. for every 8 PTEs:
> > > > >   1a. we allocate 7 order-0 pages.
> > > > >   1b. we remap PTEs #1-7 *RW* to those pages, respectively.
> > > >
> > > > Similar problem in 1.b, changing the output address. Here we could =
force
> > > > the content to be the same
> > >
> > > I don't follow the "the content to be the same" part. After HVO, we h=
ave:
> > >
> > > Entry 0 -> `struct page` page A, RW
> > > Entry 1 -> `struct page` page A, RO
> > > ...
> > > Entry 7 -> `struct page` page A, RO
> > >
> > > To de-HVO, we need to make them:
> > >
> > > Entry 0 -> `struct page` page A, RW
> > > Entry 1 -> `struct page` page B, RW
> > > ...
> > > Entry 7 -> `struct page` page H, RW
> > >
> > > I assume the same content means PTE_0 =3D=3D PTE_1/.../7?
> >
> > That's the content of the page at the corresponding pfn before and afte=
r
> > the pte change. I'm pretty sure the Arm ARM states this in case the
> > hardware starts a load (e.g. unaligned) from one page and completes it
> > from another, the software should not see any difference. But for the
> > fields we care about in struct page, I assume they'd be the same (or
> > that we just don't care about inconsistencies during this transient
> > period).
>
> Thanks for the explanation. I'll cook up something if my understanding
> above is correct.

