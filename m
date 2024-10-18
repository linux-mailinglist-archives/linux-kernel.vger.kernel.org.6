Return-Path: <linux-kernel+bounces-372331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0507F9A474C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 21:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F01BB21F69
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 19:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FF0205ACE;
	Fri, 18 Oct 2024 19:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2ZLPRH3"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727A4205ABC
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 19:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729280668; cv=none; b=dhyVQaXHWZxka3CUXQFbYtu+Fhx8yfn8tLFVx0tG0kXFT2jTL9Vfz9SKe8zZZlxUp9FhYWEPOJL8RYFinZdeswvRrHsT3aZrkiEtybQfEVfKx86r4hkCxCDiZRb+rnUiVoXF7OM6ps7DnBwPxUNVBYp5q2GehP4xrR+y5sNmxLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729280668; c=relaxed/simple;
	bh=pB0+6hh468YQrf6LZd+LbNYYAzvwC817yKGYNzpsxWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZGgDv4HGK1v4hZgP4/EBboitSWKYkYnhT64/QQMWx2Fx881+xntB8BmRz6+YMaF2FWt4rU+ox25uqKXQ9o9e+8RhvBRxSslxqzoBb1zuwGPj69axM2o0RoUK9xuX+y8SbweJ38Ds1/DwUaInrJPxy2ihnNC42V+31x7SAlqB+Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X2ZLPRH3; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a99cc265e0aso336237166b.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 12:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729280665; x=1729885465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7rL4uFYxiHaJ0JKUkuavoS+7dJ1eUFch4sClLn68ScE=;
        b=X2ZLPRH3nWmwRKeT+e2hI/CgI4X1Ddr0vb9aSHKriC+aaPwtH8lMuiLZ5ngDSDuM3c
         Py9dceTDr5hAVZoY/p6XxmII+qHp30kXUIx4eMBYSes2MFQRc3wMUPeEvFavTkxSO/0x
         K7LmHMohPp7cl0+BbDv78kptuSARhtGib2dhPr4Wug994aRraWSf5ztRh2rxRa03rufQ
         68LlJQbw4SKMTO1HZO3u/uXUZTXi7cbjldBF4WdDqz1C4P9G9X9j2AhgK8cr2iXTP4zE
         W6UojIHXXWH9OI0zCIwkr83kQeMZlKXkAhumPFymKmkV0aDgOOFXGLEpgEIJ8eharlrA
         a5DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729280665; x=1729885465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7rL4uFYxiHaJ0JKUkuavoS+7dJ1eUFch4sClLn68ScE=;
        b=ONhLNHdPKC/6p5jEgVTkHIp0e3mued6SNbLhwlXj5AutYAlP1HXT2RywSxhuYvsTak
         R+kKJ05nUqKx+iXcBj8jTyQtAZNO3TA+NEG91cPjoNHoUFufLSSVgz7NpGFQG3wTvZHT
         9tDTwnzGMdplr/+gI+FkHLVst+1NoELpkxVUi68PPi14KHQOMhFJliDiQCP0S8he8eX7
         gSHepOqJUNkPSVT1ZkK30GBH+bXZDHv/oC/YwM4z+CDEOp5tk3cAKSB/O7ureALodz10
         IlsZGhRUBxCIGJu+W6ZZEkicT1YlLPRGuLNJXlQtUoWU0c1/e32yhR2zDRVW5R0o9fnE
         zQ9Q==
X-Forwarded-Encrypted: i=1; AJvYcCX2dcMYKHWcVqBsuXjRQJGBU6FUyiPJ1UoMuWrxgHZM79luSLLTCEMtmo/QYJQF3vTDGSFh172S7bX3Vrg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1HDKkK73tDgZpsnfwW5RN0Rum+2Gs8aBX7j+0/TJrL6JNSVpF
	K4HR51p8H/IZB1lxWz6Qha5vsDlv5yeJoSuM8YkexEfqhdJJIT18pxkbstvHUsHzEBCHkpCA1g8
	1JSYiKCXBXli1HUF+P8T/uBNpd+0=
X-Google-Smtp-Source: AGHT+IFEhC0kMZOjREatp1kTzwH1u4yXzZNwy3b7ULP4COvTFtYnodeIOuVk/DaUcXMJD/eXvW5ie7Ljmu2lI0pp13s=
X-Received: by 2002:a17:907:7e99:b0:a99:76cb:cedd with SMTP id
 a640c23a62f3a-a9a69774946mr283012766b.9.1729280664463; Fri, 18 Oct 2024
 12:44:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008223748.555845-1-ziy@nvidia.com> <7ec81ff8-5645-42a1-a048-c8700aff07fa@redhat.com>
 <9A314663-43F1-49B5-9225-0E326A4DB315@nvidia.com>
In-Reply-To: <9A314663-43F1-49B5-9225-0E326A4DB315@nvidia.com>
From: Yang Shi <shy828301@gmail.com>
Date: Fri, 18 Oct 2024 12:44:13 -0700
Message-ID: <CAHbLzkqDo7ADnwfvQsdKVqE18sUuz+98SVuk1nerW+vsE=nFSQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] Buddy allocator like folio split
To: Zi Yan <ziy@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Hugh Dickins <hughd@google.com>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, 
	Yang Shi <yang@os.amperecomputing.com>, Miaohe Lin <linmiaohe@huawei.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Yu Zhao <yuzhao@google.com>, 
	John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 12:11=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>
> On 18 Oct 2024, at 14:42, David Hildenbrand wrote:
>
> > On 09.10.24 00:37, Zi Yan wrote:
> >> Hi all,
> >
> > Hi!
> >
> >>
> >> Matthew and I have discussed about a different way of splitting large
> >> folios. Instead of split one folio uniformly into the same order small=
er
> >> ones, doing buddy allocator like split can reduce the total number of
> >> resulting folios, the amount of memory needed for multi-index xarray
> >> split, and keep more large folios after a split. In addition, both
> >> Hugh[1] and Ryan[2] had similar suggestions before.
> >>
> >> The patch is an initial implementation. It passes simple order-9 to
> >> lower order split tests for anonymous folios and pagecache folios.
> >> There are still a lot of TODOs to make it upstream. But I would like t=
o gather
> >> feedbacks before that.
> >
> > Interesting, but I don't see any actual users besides the debug/test in=
terface wired up.
>
> Right. I am working on it now, since two potential users, anon large foli=
os
> and truncate, might need more sophisticated implementation to fully take
> advantage of this new split.
>
> For anon large folios, this might be open to debate, if only a subset of
> orders are enabled, I assume folio_split() can only split to smaller
> folios with the enabled orders. For example, to get one order-0 from
> an order-9, and only order-4 (64KB on x86) is enabled, folio_split()
> can only split the order-9 to 16 order-0s, 31 order-4s, unless we are
> OK with anon large folios with not enabled orders appear in the system.

For anon large folios, deferred split may be a problem too. The
deferred split is typically used to free the unmapped subpages by, for
example, MADV_DONTNEED. But we don't know which subpages are unmapped
without reading their _mapcount by iterating every subpages.

>
> For truncate, the example you give below is an easy one. For cases like
> punching from 3rd to 5th order-0 of a order-3, [O0, O0, __, __, __, O0, O=
0, O0],
> I am thinking which approach is better:
>
> 1. two folio_split()s,
>   1) split second order-1 from order-3, 2) split order-0 from the second =
order-2;
>
> 2. one folio_split() by making folio_split() to support arbitrary range s=
plit,
> so two steps in 1 can be done in one shot, which saves unmapping and rema=
pping
> cost.
>
> Maybe I should go for 1 first as an easy route, but I still need an algor=
ithm
> in truncate to figure out the way of calling folio_split()s.
>
> >
> > I assume ftruncate() / fallocate(PUNCH_HOLE) might be good use cases? F=
or example, when punching 1M of a 2M folio, we can just leave a 1M folio in=
 the pagecache.
>
> Yes, I am trying to make this work.
>
> >
> > Any other obvious users you have in mind?
>
> Presumably, folio_split() should replace all split_huge*() to reduce tota=
l
> number of folios after a split. But for swapcache folios, I need to figur=
e
> out if swap system works well with buddy allocator like splits.
>
>
>
> Best Regards,
> Yan, Zi

