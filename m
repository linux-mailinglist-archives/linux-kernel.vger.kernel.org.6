Return-Path: <linux-kernel+bounces-185980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C078CBDA3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 11:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B47741F231E8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 09:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B2F80623;
	Wed, 22 May 2024 09:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+UOVvpx"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C962D047
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 09:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716369623; cv=none; b=EM6NgUgdyB/xxfwxftlwzZ8REFfwoOCodCD7YPo+ovAzEYjtJLPEYr2teYMgg6Rmj150SnKeBiKOeHgdqfJpXVApVO91AuP57tRKgBak0her1NudY5nxOYN11DBVey5u6bDuNQAF7QEjVCxtPt/DuqcdpsVOEauzgRBMvtkP0AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716369623; c=relaxed/simple;
	bh=nowoqtcwEhGDR7CZFfXZss8Xe1bGMFzR88XRFwB/U4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JhjC3CNmGIqLxyVpEqrVvOCjP2yh9+Vq8+AVizi8CYL9r4fPqgLdHaWq0FkgKSYi4q9dL1cus9wZw6ZRyQK576BMsaN3NEFHPVdt36rm9S4nlzubp3n5Desm2x32Q2gFhpMxL+ygf0jCZAs3hWyL1qR6P/8CGFH+X8cVnXAxPKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+UOVvpx; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57342829409so1282467a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 02:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716369620; x=1716974420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8frwoHH9r4REDJsQ1v90IzqVikRQs2mKIsV/33z1n0s=;
        b=J+UOVvpxK0TPBOJYYgzSJy6m82hxb9tUcg7nBoZWiD0QqB1YEXYkLDwDZeh1rmd4sj
         zpaupgq/hKwVElHpKJfRyxF9g2ME0jQhcRQFjTIXIlS+Qwm2fyvae5Fodghzqo6l1Ksq
         97EwglSz30qGmYJO+3Iwq6Vi3UlCCkq4vFCv/CRQ51jwxRXzdFbx6afeiW5SeAshd9Cx
         mzSqx/rRgSRMixBBIYMaUxvJjNl9+o9v4a6O6wne5vSzKbqEX48edusbmLvoqa0hXZ6k
         ZDb1dt7q8HHfiv4oYCUgDlwjfryfCULEqmeE2d0geuYk3TRy26iVB348+qZ0DRY4Zt/0
         a6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716369620; x=1716974420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8frwoHH9r4REDJsQ1v90IzqVikRQs2mKIsV/33z1n0s=;
        b=r1I7q/Pwv34I/3AnlJN10fei6etoq4B7lXKgthl8f1olQtJ69xreuHquBF5Qhi/xmN
         FOQQQChEN+u00VcG7JDGifkB2euWmVZ1arVO+rGJsD079gN2DFRedH39HNKl64uwW/gl
         BnGsOPebDNGmb/zwa0SCUrca7+c5R2na1/KZOnRkEUjFE1vrL8vYQzwFG8H4BdYDmBoq
         TRlYMuWEhnPNQtFo4pEPrZNrMlny72mACckajWx/qswdn8cMJNZk31L4QG2zKSP2ZeGP
         yZ4tev3UPxx7jXKmDeYGuddhEWxfr7RGzoe8ZAFdmsyHRQ52G7aVfgVhWo/La/bMKm0R
         IYVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxONbo3R6q89ItE/KG2WiPrMMXNDH0Zjj/NP+OJ7MnqsnLqIcdKQfOL4JTewv6Ftvz6e7fwrMcjn9DlaHfg8pNG+XsxIXOvJlTVJEe
X-Gm-Message-State: AOJu0YzGv1KNf7lc0nQy7Z3xpoBVvbXEVfMgR0boT+KS52QBkJh1nT9h
	hfwqE1dRsGIcWi1NXyLpUWTN41K+42RtlOqe79QBLPZ7nLv9Ac5Gb314hBt12XNGIwGySdSKsYg
	sGdiQkrSn47nrU6sPqrOIhlloAxc=
X-Google-Smtp-Source: AGHT+IG6guLTEh+seYJRKPgfju5QEgDon9Su32zl7gl/BCFQ1l64+1U6R1bp7AMq32bZzNuot9hKMUg6mKzQioIkHkE=
X-Received: by 2002:a50:9f45:0:b0:56b:d013:a67e with SMTP id
 4fb4d7f45d1cf-5783117a404mr1304445a12.18.1716369619931; Wed, 22 May 2024
 02:20:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521-mm-hotplug-sync-v1-0-6d53706c1ba8@google.com>
 <20240521-mm-hotplug-sync-v1-2-6d53706c1ba8@google.com> <CABzRoyZXq3u4DYxO39Fcezo56HAbkNh6xLuK9jnuiNK5gVmV1w@mail.gmail.com>
 <Zk2vDeQ3feZ3hsf0@google.com>
In-Reply-To: <Zk2vDeQ3feZ3hsf0@google.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Wed, 22 May 2024 17:20:08 +0800
Message-ID: <CAK1f24=fNFPyGCh+sxsq-Gg6BkD5qH=z+Ur2UD8+4CRZYoZc6g@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm,memory_hotplug: {READ,WRITE}_ONCE unsynchronized
 zone data
To: Brendan Jackman <jackmanb@google.com>
Cc: David Hildenbrand <david@redhat.com>, Oscar Salvador <osalvador@suse.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, 
	Michal Hocko <mhocko@suse.com>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 4:38=E2=80=AFPM Brendan Jackman <jackmanb@google.co=
m> wrote:
>
> Hi Lance, thanks for taking a look.
>
> On Wed, May 22, 2024 at 12:25:30PM +0800, Lance Yang wrote:
> > Hi Brendan,
> >
> > On Tue, May 21, 2024 at 8:57=E2=80=AFPM Brendan Jackman <jackmanb@googl=
e.com> wrote:
> > > @@ -1077,7 +1081,7 @@ void adjust_present_page_count(struct page *pag=
e, struct memory_group *group,
> > >          */
> > >         if (early_section(__pfn_to_section(page_to_pfn(page))))
> > >                 zone->present_early_pages +=3D nr_pages;
> > > -       zone->present_pages +=3D nr_pages;
> > > +       WRITE_ONCE(zone->present_pages, zone->present_pages + nr_page=
s);
> >
> > I'm not sure that using the WRITE_ONCE() wrapper would prevent load tea=
ring
> > on 'zone->present_pages', but it's probably just me overthinking it :)
>
> Hmm.. this isn't for load-tearing, it's for store-tearing. I have a
> feeling I might be missing your pont here though, can you elaborate?

Sorry, my explanation wasn't clear :(

I'm a bit confused about whether 'WRITE_ONCE(zone->present_pages,
zone->present_pages + nr_pages);'
is equivalent to the following:

1 a =3D zone->present_pages + nr_pages;
2 WRITE_ONCE(zone->present_pages, a);

If so, is there any possibility of load tearing on
'zone->present_pages' in line 1?

>
> I have just noticed that the original "big bad optimizing compiler"
> article[1] only says store-tearing has been observed in the wild when
> the value being stored can be split into immediates (i.e. is
> constant). But it doesn't really seem wise to rely on that. From what
> I can tell from tools/memory-model/Documentation you are really out in
> the wild with unmarked accesses.
>
> [1] https://lwn.net/Articles/793253

Thanks for clarifying!
Lance

