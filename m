Return-Path: <linux-kernel+bounces-381109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C8D9AFA76
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 741401F239AA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 06:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECD51B0F1E;
	Fri, 25 Oct 2024 06:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rbq/C34i"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFC61B0F07
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 06:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729839452; cv=none; b=rok2nnkxOwgn1HiH4ddXRhoi2mHczL1WKZ7DhFGKBJxrs0Q/WrTHXSWi74MCDHKZLQVVN7CO9CU+m+g5XkndfuBGt7zCeiR+CM45A10OK2BClYIV2xXAR2fyPC6IoALflqRm/9Y4E5T/qUZYdqBjxR0PFSwvaaeoAmVWinrW9To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729839452; c=relaxed/simple;
	bh=fjm+bCO7i/NT9zYLGOS76HMKkHtzcyPL7S9ORd1Fols=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=RSqFKqbNWA50/YtkFKYHj14+/9xxr7zjfLToNTRPRFiDab1Wom6zGAGIWI4vlr3UQ9RRBmK6h8LUoimViALMczsqYnofZf/MeOSFIv3grnj4is0vgWlp/GYhCwEDAL+lXiLSX9Q1qM+JgeNmWUl1krEuy/cPAAgoarAQ3rU+Bbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rbq/C34i; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e30fb8cb07so1244396a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 23:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729839449; x=1730444249; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LpwEmX39tz7GkOoKXscKUueXnv66QRCEFJQBHl3iLv8=;
        b=Rbq/C34iWEpLQVY9tkieVlREzEak8UhKr0j9NKSRdcSvjXQLggDl+UFFz34QfFOUd8
         gW52zNCBocRh/WXZTZYrobYZcEgx6J74VWIRn1r0ZUvRV2PQuuEROVXXRpMaAS7q+0Gm
         YtMdSFnhlOMmsI9cccMmoDwtV6li3DpLh8PxMYP41+MSDfyVD/WR3wsWOl0uNwpCbm+i
         cHUnmmb8+W3r9qk8xVNqn1csD+lDCyACUHw+MQunc61gnVLjRvGk8bfhbGyuPCqDYF4A
         1htRxy6c/FO0MRrwtB2dkbpgeOeWoHedn19BUYkuF8NtGNH0deeDE/V4rv9hjhYqCmyx
         U+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729839449; x=1730444249;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LpwEmX39tz7GkOoKXscKUueXnv66QRCEFJQBHl3iLv8=;
        b=lVnOErXolrtGnIijHyFVjdQ6qB8zbjv4bmyp3ZaakDvbZR1sRgE0LF99Eo19dwsO1v
         s0tHOaK8MJsb02tN8eEWTHm1pwUeRl6OS3NRwd7t9MMZLrz7efSdHBNC9F1O5i94DT+z
         Zfb3vVyKlloMP80xx8pjt/HppWWggIBxGzadnAGQpDTlgk5+clG/YMRKcE0GAQhYQ/qc
         E32if5MOBLDd/jaMb0miKhabIkZBcusXHCpaTZrJ0P7nHT5kvv4HUr6csTscT/SXJ4DL
         iZu63otsnXPQkkZrGj4LoWcSf/81fodpn/n2L2Ku4BD80hI60tJvjb6TSYbXJF8DlciZ
         BC+w==
X-Forwarded-Encrypted: i=1; AJvYcCVK7o+hj+Q+RiQNXDiXyByuhai8V9SVg7v1C/5SCWqtdSy/eOKD2u7tigJwifsMKRYSliPsl56rg5hsqOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVI30gFNt5iZiFcGBLu+ffsLPF+yMF6qBLON14sjJgawaVswct
	T1lmvWhN29/NbpAgaJzDxIINo4gJgtw0tPmC1cbclxfs/PHjOjVQ8Zy2xrSmUA==
X-Google-Smtp-Source: AGHT+IG77oWggEXdNmThy91aq60vF+TSPN5sWh64WR+w6d0aDrUcaGtZToaZcstCLLRoXFKtaIR+ow==
X-Received: by 2002:a17:90a:3986:b0:2dd:5e86:8c2f with SMTP id 98e67ed59e1d1-2e76b621bd2mr8388977a91.21.1729839449017;
        Thu, 24 Oct 2024 23:57:29 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e56f468sm2654324a91.41.2024.10.24.23.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 23:57:28 -0700 (PDT)
Date: Thu, 24 Oct 2024 23:57:26 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Yang Shi <shy828301@gmail.com>
cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
    Usama Arif <usamaarif642@gmail.com>, Wei Yang <richard.weiyang@gmail.com>, 
    "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
    Matthew Wilcox <willy@infradead.org>, David Hildenbrand <david@redhat.com>, 
    Johannes Weiner <hannes@cmpxchg.org>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    Barry Song <baohua@kernel.org>, Kefeng Wang <wangkefeng.wang@huawei.com>, 
    Ryan Roberts <ryan.roberts@arm.com>, Nhat Pham <nphamcs@gmail.com>, 
    Zi Yan <ziy@nvidia.com>, Chris Li <chrisl@kernel.org>, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH hotfix 2/2] mm/thp: fix deferred split unqueue naming
 and locking
In-Reply-To: <CAHbLzkoRHcC33vj7iajw_JXVig7yghJRGaTpaHXaxhoni76yPw@mail.gmail.com>
Message-ID: <b3e88e26-5bda-50fc-cc55-a62b4b2a4e24@google.com>
References: <760237a3-69d6-9197-432d-0306d52c048a@google.com> <7dc6b280-cd87-acd1-1124-e512e3d2217d@google.com> <CAHbLzkoRHcC33vj7iajw_JXVig7yghJRGaTpaHXaxhoni76yPw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463770367-1593665756-1729839448=:30812"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463770367-1593665756-1729839448=:30812
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 24 Oct 2024, Yang Shi wrote:
> On Wed, Oct 23, 2024 at 9:13=E2=80=AFPM Hugh Dickins <hughd@google.com> w=
rote:
> >
> > That goes back to 5.4 commit 87eaceb3faa5 ("mm: thp: make deferred spli=
t
> > shrinker memcg aware"): which included a check on swapcache before addi=
ng
> > to deferred queue (which can now be removed), but no check on deferred
> > queue before adding THP to swapcache (maybe other circumstances prevent=
ed
> > it at that time, but not now).
>=20
> If I remember correctly, THP just can be added to deferred list when
> there is no PMD map before mTHP swapout, so shrink_page_list() did
> check THP's compound_mapcount (called _entire_mapcount now) before
> adding it to swap cache.
>=20
> Now the code just checked whether the large folio is on deferred list or =
not.

I've continued to find it hard to think about, hard to be convinced by
that sequence of checks, without an actual explicit _deferred_list check.

David has brilliantly come up with the failed THP migration example;
and I think now perhaps 5.8's 5503fbf2b0b8 ("khugepaged: allow to
collapse PTE-mapped compound pages") introduced another way?

But I certainly need to reword that wagging finger pointing to your
commit: these are much more exceptional cases than I was thinking there.

I have this evening tried running swapping load on 5.10 and 6.6 and 6.11,
each with just a BUG_ON(!list_empty(the deferred list)) before resetting
memcg in mem_cgroup_swapout() - it would of course be much easier to hit
such a BUG_ON() than for the consequent wrong locking to be so unlucky
as to actually result in list corruption.

None of those BUG_ONs hit; though I was only running each for 1.5 hour,
and looking at vmstats at the end, see the were really not exercising
deferred split very much at all.  I'd been hoping for an immediate hit
(as on 6.12-rc) to confirm my doubt, but no.  That doesn't *prove* you're
right, but (excepting David's and my weird cases) I bet you are right.

> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 4b21a368b4e2..57f64b5d0004 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -2681,7 +2681,9 @@ void free_unref_folios(struct folio_batch *folios=
)
> >                 unsigned long pfn =3D folio_pfn(folio);
> >                 unsigned int order =3D folio_order(folio);
> >
> > -               folio_undo_large_rmappable(folio);
> > +               if (mem_cgroup_disabled())
> > +                       folio_unqueue_deferred_split(folio);
>=20
> This looks confusing. It looks all callsites of free_unref_folios()
> have folio_unqueue_deferred_split() and memcg uncharge called before
> it. If there is any problem, memcg uncharge should catch it. Did I
> miss something?

I don't understand what you're suggesting there.  But David remarked
on it too, so it seems that I do need at least to add some comment.

I'd better re-examine the memcg/non-memcg forking paths again: but by
strange coincidence (or suggestion?), I'm suddenly now too tired here,
precisely where David stopped too.  I'll have to come back to this
tomorrow, sorry.

Hugh
---1463770367-1593665756-1729839448=:30812--

