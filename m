Return-Path: <linux-kernel+bounces-252868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D6693191F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 19:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BA661C21839
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 17:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0114C62A;
	Mon, 15 Jul 2024 17:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4sfvgpgV"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7688249650
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 17:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721064033; cv=none; b=u1fiNfcpP81pcbvRKozTSqlRW+jp+BFMd11y+ViUWwZvuHdSqiCGL5BOIJPUnemyZB4JywysLYjIIZBLThDjj4USEwLlAlh1enak2H+SSLiocdq3r5+YeUHm6NXUaG2gjcYeyZ1tSoXP9XgL50le6syrKQPBSPLQge1GypobLo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721064033; c=relaxed/simple;
	bh=MgDHDMOncs3+0mBz1iIq1IBO98iWAOMcTZbZAA8Cf6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dIQcVz20EIgUlCbKnAmYW8WwsXzsJftDSzdabJ8An34bsEItzXyNArP4BuxouhF9fZNdmTE9qbPyvu4WrIejVsJCIWsXCM2MwhpDQnfOyCTLNYVY07hEXsreV3mG2higdnp+gtI/IRenaTEmCp+XZSMxNHiWihEm4b3GXf6lHmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4sfvgpgV; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-447e57103d5so25593541cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 10:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721064030; x=1721668830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VqLbFBSLY2VQJjycHe2xsMNFC1xNLCGi7MCyaLlxLMo=;
        b=4sfvgpgV5nuCNNCOPzNwFBt3jblSHDkAGMKZyRRzX+Gkr1ymq0hZygc0Dy87byWY+3
         yLOashSfskBJbKTdxQcve/l7+CAMaBUo77FhS0RqZ6rJjdSw8OKzuQK0wnwbKtAQIuT1
         WoN6vJJm1vZRX0qa4XV6ASVBdyIrx58PSCET/AL6fQ/1pAj4SxYirwCHyJsZyyNo5imJ
         PwkyvxY864NYD+L8aYYhFyKOtRrbVwuPoVzk8dpS0ZJnIywbEedAFBwQbi7U9fpV8d2K
         gWGoE3lFyXLeiTVhWyKijWnIgIWb7l3YT5/icszOs0P/QfjqT/I7CfWfBU6ZkDIa2vqd
         meDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721064030; x=1721668830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VqLbFBSLY2VQJjycHe2xsMNFC1xNLCGi7MCyaLlxLMo=;
        b=DaA+JUG/527lXtHfEu0FTUWmYFnzo68WKQ/KhWS4RoUEGh/b4T55Vwl3tRAn1CYK86
         rsXKEO3yuAVjXReWd24AMIoNhqxHBMU9X75XsgKcdI0jZruOpxgKNuc/jG4Ka8WOAasS
         LxvjqF0FPXPKZiGEQwXlalkflTlBSXsQYl7AP7eIaem4jjWFeJ4IP1W+ChWUWMAbOhDw
         F9EBcE2xFMExKne2Dihu29MYSGf5TAbW8fYxTyQLwaGgyuujVHW8F9cqTfEOW7WDKG5K
         ddiB1jlNBIMsyiKNhqhLaNIXrxvDPpaRWdyUtDgXhIwe6Lht0TTU34VbUf1neCTpC9nZ
         xmJg==
X-Forwarded-Encrypted: i=1; AJvYcCVieNxo1KfuAThsTRg6o7Wk1U0fkbYEFpWU4rpczx2PVJzp1KKfmxTapyE1OH5hKOeC2HNKsyKcrdxzat2MGQDZh0L5BPhFJ5bCqs7I
X-Gm-Message-State: AOJu0Ywfuxpv0DOqdgj2OQfddSDgWaJWTsWZL7O8BTeL3vVev2XJoMkW
	p1wvjrQmp4B/153nvc/1G999dT6wYO3RuDz/LEvSA2xz+z7q/hsLdLIUQOJY9UPZE/2+aGx4Gqs
	NmxzQPfWfCl5oWiv+IKl5INXmNHpbum6jaftN
X-Google-Smtp-Source: AGHT+IHTL0CXYXz0R6B63tCFKInlhWG5kzr9gfPZtY0JfeIevUCVC2psZutIfFKbaLuOJK1+tAWwhk6VI17vNBiTaSA=
X-Received: by 2002:ad4:5aaa:0:b0:6b0:77a8:f416 with SMTP id
 6a1803df08f44-6b77df284b1mr3820816d6.47.1721064030333; Mon, 15 Jul 2024
 10:20:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618064022.1990814-1-mawupeng1@huawei.com> <e66bb4c1-f1bc-4aeb-a413-fcdbb327e73f@huawei.com>
In-Reply-To: <e66bb4c1-f1bc-4aeb-a413-fcdbb327e73f@huawei.com>
From: Alexander Potapenko <glider@google.com>
Date: Mon, 15 Jul 2024 19:19:49 +0200
Message-ID: <CAG_fn=VTKFDAx2JQAEur5cxkSwNze-SOqQRbqBGwDx96Xq-6nQ@mail.gmail.com>
Subject: Re: [Question] race during kasan_populate_vmalloc_pte
To: mawupeng <mawupeng1@huawei.com>
Cc: akpm@linux-foundation.org, ryabinin.a.a@gmail.com, andreyknvl@gmail.com, 
	dvyukov@google.com, vincenzo.frascino@arm.com, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 4:08=E2=80=AFAM mawupeng <mawupeng1@huawei.com> wro=
te:
>
> Hi maintainers,
>
> kingly ping.
>
> On 2024/6/18 14:40, Wupeng Ma wrote:
> > Hi maintainers,
> >
> > During our testing, we discovered that kasan vmalloc may trigger a fals=
e
> > vmalloc-out-of-bounds warning due to a race between kasan_populate_vmal=
loc_pte
> > and kasan_depopulate_vmalloc_pte.
> >
> > cpu0                          cpu1                            cpu2
> >   kasan_populate_vmalloc_pte  kasan_populate_vmalloc_pte      kasan_dep=
opulate_vmalloc_pte
> >                                                               spin_unlo=
ck(&init_mm.page_table_lock);
> >   pte_none(ptep_get(ptep))
> >   // pte is valid here, return here
> >                                                               pte_clear=
(&init_mm, addr, ptep);
> >                               pte_none(ptep_get(ptep))
> >                               // pte is none here try alloc new pages
> >                                                               spin_lock=
(&init_mm.page_table_lock);
> > kasan_poison
> > // memset kasan shadow region to 0
> >                               page =3D __get_free_page(GFP_KERNEL);
> >                               __memset((void *)page, KASAN_VMALLOC_INVA=
LID, PAGE_SIZE);
> >                               pte =3D pfn_pte(PFN_DOWN(__pa(page)), PAG=
E_KERNEL);
> >                               spin_lock(&init_mm.page_table_lock);
> >                               set_pte_at(&init_mm, addr, ptep, pte);
> >                               spin_unlock(&init_mm.page_table_lock);
> >
> >
> > Since kasan shadow memory in cpu0 is set to 0xf0 which means it is not
> > initialized after the race in cpu1. Consequently, a false vmalloc-out-o=
f-bounds
> > warning is triggered when a user attempts to access this memory region.
> >
> > The root cause of this problem is the pte valid check at the start of
> > kasan_populate_vmalloc_pte should be removed since it is not protected =
by
> > page_table_lock. However, this may result in severe performance degrada=
tion
> > since pages will be frequently allocated and freed.
> >
> > Is there have any thoughts on how to solve this issue?
> >
> > Thank you.

I am going to take a closer look at this issue. Any chance you have a
reproducer for it?

