Return-Path: <linux-kernel+bounces-249623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5645792EDF3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 19:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6E501F23696
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 17:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00B516D9BC;
	Thu, 11 Jul 2024 17:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QyDn/AfX"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7869642AB5
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 17:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720719562; cv=none; b=tH7FP3FJy6dZNXDbOsUcYSTK8hRi+KtJdEcjyTua7ZNXYO2UbfhHoRJO9CdsbkA75/bqM5xQeL13QQZ8IcJjA8SDBWeYaMh1wNUAe+E8j+xqYiT3F1cpy8yZBRE0EAvhfoklkDiweChvKIdKfBC9Em2I1pgmrIsa1ysdwtRtSOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720719562; c=relaxed/simple;
	bh=r4ZdT9eOdG1rIogC82ewixN2xUXKOsCM0E7oZyhLPA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=syeiXvtt87UNC71RQboxuQGXWRZkPIFXkPFU1m4lBirlQsNaa7S44hAQO3u/vN1A9akMUxU/IHFLSS/cTFiyYB8Cp1zx0R9Fg1jJfLnLroTKGBKKqdTzNG+kY+oLBOoMvrL57sgAnvQQx+VwrURlw1bvgtYggBS56R0o10lTg9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QyDn/AfX; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-447f8aa87bfso18941cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 10:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720719559; x=1721324359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/LH8mU+M+sCWnR9+Ca+ARV1BNg1CNNL62rL9vAcSPBM=;
        b=QyDn/AfXD8ZXj0mhreqAow11ecag39lmPiS1JMFEC4BJU1UCtW8+oN01cfCxJQDks7
         5xwO8OiHJCpOQVX8cPB1xXrTwG2aXz5bCvhwmaut9Ivo9zmU1zighQGMbE9HdNUdbF53
         L8ao/AVo8ANkvnxv1gXJguIGoZLQkEsLKfRL0XxdGDeMHW4NjqwnSlEjn2TbcIapwJ7f
         iRmdcvRrad7afiqZ0hjqxJHEKRw6k9xdL9tupfSHZuyO3QuNq0yWxpVbtbuYgeaFK2WZ
         L+RPcCgSM6x3oc1gdBIjp0GeUqtqcf4qCdKlJ6Ykty7z+pu+1LeehGeavGlNO1XLdIjk
         HI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720719559; x=1721324359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/LH8mU+M+sCWnR9+Ca+ARV1BNg1CNNL62rL9vAcSPBM=;
        b=xVnK2uI/1hu3jgUSK29rAgnyxQjdxZKbDfO1zh3n7ozvWTE+rNq86owwqX5waOEQd5
         btmBUdo38HvOUUrMHjNwVp6byjyz5jK24gsb0V9zny2a1oKovke/4zLU6QLcurfUOhtA
         CNDiVoCg2fqQpohO+xjmfcncEoobPtEtSrRKIAYGC73X1V2jlxmlZaIpIvGMXWnzKIuz
         QUHgTOTsYjz3K0vifjxes627wrHgIMNgBD5uqBRGumEieWX207MXzPKwoeVGZdAYbSkj
         rWg6ZirWL10+Q3pFKmRA6RIwdEQPBnK0uRPpJkQWRoZ64Onn7oPDWxt0gzT52g27+yP4
         kVlg==
X-Forwarded-Encrypted: i=1; AJvYcCX683CJgdhY4S2RXP7g3DLkGEfzAWd/evksSv9H1+Py0e1d4LDcixFqF/knJfnGH55g9uKVDtmhLab93K38dTFFSlcd9hJsVT4vA3nm
X-Gm-Message-State: AOJu0YybqR+h1QnVLcwzHmIb/18uBEGOnubfban1ihnz9W8acNBlH6Sb
	1j6WNCG+t4nDdWLkAaTEHGt+c/dXJ/ssUPHjyRY/Tf8mdDnMIV1zhJ6IgDuprDdEqRFrQb7WjE2
	DiS4ylbBlV1Xl23fBO2OTXGakXVaqsAncxanJ
X-Google-Smtp-Source: AGHT+IGhpAkKikX9WUeBj1u9fTmUMy9VLmxdlbU7nnkRl24NRs3MGy0QS8vyqtirWUKAa1YhY3F14tnsHnAw8L2LYas=
X-Received: by 2002:ac8:7943:0:b0:447:e393:fed1 with SMTP id
 d75a77b69052e-44d3555cbd2mr3314221cf.7.1720719559055; Thu, 11 Jul 2024
 10:39:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d1671959-74a4-8ea5-81f0-539df8d9c0f0@huawei.com>
 <ZcN7P0CGUOOgki71@arm.com> <CAOUHufYo=SQmpaYA3ThrdHcY9fQfFmycriSvOX1iuC4Y=Gj7Xg@mail.gmail.com>
 <ZogV9Iag4mxe6enx@arm.com> <CAOUHufYwoTTsRBF_wWZU_jWzb8e6FF=vN8UKtVHBeXLBkwHWzA@mail.gmail.com>
 <Zo68DP6siXfb6ZBR@arm.com> <CAOUHufZC0Jn=bTpc0JhqONXbYXgyBOVZ4j8bbKSJWv1dOSmQEA@mail.gmail.com>
 <Zo8LTaP-6-zIcc9v@arm.com> <CAOUHufawuXOifhrULx6mC0Kv0_sbjT0y16QMePiw=gH9b6xxAw@mail.gmail.com>
 <CAOUHufb3CHLCo54fZcPSG+mrXD-kRsa0Foi8=vL5=q+YHpQ+Rg@mail.gmail.com> <Zo_EiIm4ylNqO2ZR@arm.com>
In-Reply-To: <Zo_EiIm4ylNqO2ZR@arm.com>
From: Yu Zhao <yuzhao@google.com>
Date: Thu, 11 Jul 2024 11:38:40 -0600
Message-ID: <CAOUHufZKBkiHQFMvkmoMSX88SdjZ12+FFwtfGJtKAqvMXxJS+g@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] A Solution to Re-enable hugetlb vmemmap optimize
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Nanyong Sun <sunnanyong@huawei.com>, will@kernel.org, mike.kravetz@oracle.com, 
	muchun.song@linux.dev, akpm@linux-foundation.org, anshuman.khandual@arm.com, 
	willy@infradead.org, wangkefeng.wang@huawei.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 5:39=E2=80=AFAM Catalin Marinas <catalin.marinas@ar=
m.com> wrote:
>
> On Thu, Jul 11, 2024 at 02:31:25AM -0600, Yu Zhao wrote:
> > On Wed, Jul 10, 2024 at 5:07=E2=80=AFPM Yu Zhao <yuzhao@google.com> wro=
te:
> > > On Wed, Jul 10, 2024 at 4:29=E2=80=AFPM Catalin Marinas <catalin.mari=
nas@arm.com> wrote:
> > > > The Arm ARM states that we need a BBM if we change the output addre=
ss
> > > > and: the old or new mappings are RW *or* the content of the page
> > > > changes. Ignoring the latter (page content), we can turn the PTEs R=
O
> > > > first without changing the pfn followed by changing the pfn while t=
hey
> > > > are RO. Once that's done, we make entry 0 RW and, of course, with
> > > > additional TLBIs between all these steps.
> > >
> > > Aha! This is easy to do -- I just made the RO guaranteed, as I
> > > mentioned earlier.
> > >
> > > Just to make sure I fully understand the workflow:
> > >
> > > 1. Split a RW PMD into 512 RO PTEs, pointing to the same 2MB `struct =
page` area.
>
> I don't think we can turn all of them RO here since some of those 512
> PTEs are not related to the hugetlb page. So you'd need to keep them RW
> but preserving the pfn so that there's no actual translation change. I
> think that's covered by FEAT_BBM level 2. Basically this step should be
> only about breaking up a PMD block entry into a table entry.

Ack.

> > > 2. TLBI once, after pmd_populate_kernel()
> > > 3. Remap PTE 1-7 to the 4KB `struct page` area of PTE 0, for every 8
> > >    PTEs, while they remain RO.
>
> You may need some intermediate step to turn these PTEs read-only since
> step 1 should leave them RW. Also, if we want to free and order-3 page
> here, it might be better to allocate an order 0 even for PTE entry 0 (I
> had the impression that's what the core code does, I haven't checked).

Ack.

> > > 4. TLBI once, after set_pte_at() on PTE 1-7.
> > > 5. Change PTE 0 from RO to RW, pointing to the same 4KB `struct page`=
 area.
> > > 6. TLBI once, after set_pte_at() on PTE 0.
> > >
> > > No BBM required, regardless of FEAT_BBM level 2.
> >
> > I just studied D8.16.1 from the reference manual, and it seems to me:
> > 1. We still need either FEAT_BBM or BBM to split PMD.
>
> Yes.

Also, I want to confirm my understanding of "changing table size" from
the reference manual: in our case, it means splitting a PMD into 512
PTEs with the same permission and OA. If we change the permission *or*
OA, we still need to do BBM even with FEAT_BBM level 2. Is this
correct?

> > 2. We still need BBM when we change PTE 1-7, because even if they
> > remain RO, the content of the `struct page` page at the new location
> > does not match that at the old location.
>
> Yes, in theory, the data at the new pfn should be the same. We could try
> to get clarification from the architects on what could go wrong but I
> suspect it's some atomicity is not guarantee if you read the data (the
> CPU getting confused whether to read from the old or the new page).
>
> Otherwise, since after all these steps PTEs 1-7 point to the same data
> as PTE 0, before step 3 we could copy the data in page 0 over to the
> other 7 pages while entries 1-7 are still RO. The remapping afterwards
> would be fully compliant.

Correct -- we do need to copy to make it fully compliant because the
core MM doesn't guarantee that. The core MM only guarantees fields (of
struct page) required for speculative PFN walkers to function
correctly have the same value for all tail pages within a compound
page. Non-correctness related fields in theory can have different
values for those tail pages.

> > > > Can we leave entry 0 RO? This would save an additional TLBI.
> > >
> > > Unfortunately we can't. Otherwise we wouldn't be able to, e.g., grab =
a
> > > refcnt on any hugeTLB pages.
>
> OK, fair enough.
>
> > > > Now, I wonder if all this is worth it. What are the scenarios where=
 the
> > > > 8 PTEs will be accessed? The vmemmap range corresponding to a 2MB
> > > > hugetlb page for example is pretty well defined - 8 x 4K pages, ali=
gned.
> >
> > One of the fundamental assumptions in core MM is that anyone can
> > read or try to grab (write) a refcnt from any `struct page`. Those
> > speculative PFN walkers include memory compaction, etc.
>
> But how does this work if PTEs 1-7 are RO? Do those walkers detect it's
> a tail page and skip it.

Correct.

> Actually, if they all point to the same vmemmap
> page, how can one distinguish a tail page via PTE 1 from the head page
> via PTE 0?

Two of the correctness related fields are page->_refcount and
page->compound_head:
1. _refcount is the only one that can be speculatively updated.
Speculative walkers are not allowed to update other fields unless they
can grab a refcount. All tail pages must have zero refcount.
2. compound_head speculatively indicates whether a page is head or
tail, and if it's tail, its head can be extracted by compound_head().
Since a head can have non-zero refcount, after PTEs 1-7 are remapped
to PTE 0, we need a way to prevent speculative walkers from mistaking
the first tail for each PTE 1-7 for the head and trying to grab their
refcount. This is done by page_is_fake_head() returning true, which
relies on the following sequence on.
On the writer side:
2a. init compound_head
2b. reset _refcount to 0
2c. synchronize_rcu()
2d. remap PTEs 1-7 to PTE 0
2e. inc _refcount
Speculative readers of the first tails respectively at PTEs 1-7 either
see refcount being 0 or page_is_fake_head() being true.

> BTW, I'll be on holiday from tomorrow for two weeks and won't be able to
> follow up on this thread (and likely to forget all the discussion by the
> time I get back ;)).

Thanks for the heads-up!

