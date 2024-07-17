Return-Path: <linux-kernel+bounces-255612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 516FD9342EA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D28B91F223AA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 20:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2D21850A3;
	Wed, 17 Jul 2024 20:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GSJGP6w0"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D97B18508B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 20:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721246713; cv=none; b=mGgBwymYupn2inPrb+9YWS2yHlpRF3hDRVFB0lSitZXNaq+HDkFMI8qX+UXuLzC0qHCT+bbL5IsckZ5cKhG0C5nkgzZMw9JHeXbKEcONw/2UoHL6HToHb2tHwKS99fZA9PGpQWjuoaXq1Az+Mhrc+kQqNKEpHaOIekspXA1b8F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721246713; c=relaxed/simple;
	bh=yfvmwqlbiIjdjODB3ox0PyvzL/p7umxnR4a6f4bphT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QJus57VA+ZRUksIEfEkKt4y5D8g4nmDf89mLwiAoMcYaU0prl/KVuvOSzZs26H+PFCF/e1uQbNYomaiFQVq6dEvckjRX1SxsgjT9NXqEWFewXvkpcLguH+Ai8DYvde7aCd/i4Qnwq0pQnAPpg8yupaPuSWKKv80AflXE8npa14A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GSJGP6w0; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-664b4589b1aso1427707b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 13:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721246711; x=1721851511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VBSP3e5vSaJAGM6EZi3idFKFcaAopFgZHFBzjK3LCT0=;
        b=GSJGP6w0Fv4lwLqaPGJiEwdJdv/cAZwvViRQkxQS/axVeVjqcJfMj01/RkCeM6Y3YV
         65Ks1eJNAEdtb0fXWVpEmx0jtXrhniFx6+bwbnih97FYcX8DTQoafNmATfTjC5EGzKzN
         rvbcc62eZdLq79hUChL48Ad9RI6+N8pwOhCRTtx54JomexriZsJs9ch+W/m3LsT+j/MF
         tBtiOshAOYXrxt3F+ITEYw3tbDCc+bjdgEerG4GaskOa7Fr/0t0llej3rI1dAYYYBZOK
         LXUyH96KJAPU6yF76L1OzaLRrO2GFbEGC4eHjjAyF4P//2bK6ffWpohi3UlAec/hG86z
         mxQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721246711; x=1721851511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VBSP3e5vSaJAGM6EZi3idFKFcaAopFgZHFBzjK3LCT0=;
        b=LlzHPTVivF74MSXFWIljmaFPkS8RIiAB4mgDqkazYPXQnYB6LVFAOVoY4Bcz83spKZ
         /sEj6Bcq768oCA/K6aaloEBKE2c2eqnVvGvt/13ssZHF6AX8AWDy0asSlNTKUjLqUckp
         XVK2oHUP5PuDRAsmolt51WeMC7QNvcENCSzWWyXETkSqf/Hhx0slAvXnoFR4SnZYArwQ
         nEVFfdp5OQGS3EnNzmsTbK57kaDD+uxQVOBmlgAsiIcao/4yQwoaK6zbiJKWZFCAseaZ
         rat+aZ47pBK0fw/VwmSOhcma6QhFPGWjkwv4gJoZBHtTbmZfEYFGYgkFLxDTOxstWa+4
         7i7g==
X-Forwarded-Encrypted: i=1; AJvYcCWLilu3+x9gToH25YigU1q93LWe3cLVIpe6HhWBVqU1xG2CAG5dkWSkB/3uMMzEM2JHctriL4Zz1VohhG8tDNP6Z6a1Tk5KmV/m/Jn4
X-Gm-Message-State: AOJu0YzMsqKUwdnh1Cj5m9UFX+8l06KD+JXbf+Jlh06/I/iwf1VuvLdQ
	GINiFKl4Q6BzPcJydsv0Ld0l0BXVxjLlKgqGrs7prgIFJx2bQzSbja8ygao+lpq9feeh7lTxhws
	Cx+FTZO1B0+T3ZjvW9tdUKG946vdcS+aPXQWs
X-Google-Smtp-Source: AGHT+IHfPPMLVKhQIYQq+vH52LgiwBYqk+yx7jrNs0qArCy52u19+nLsf/wyM3sJ2QtC6hJrAh85tZ10Z5PJLiozSvU=
X-Received: by 2002:a05:690c:827:b0:651:4b29:403c with SMTP id
 00721157ae682-66607a46eadmr3959767b3.2.1721246710658; Wed, 17 Jul 2024
 13:05:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717181239.2510054-1-surenb@google.com> <20240717181239.2510054-2-surenb@google.com>
 <16286915-1350-4e6b-a0f6-deec02b7fa92@suse.cz>
In-Reply-To: <16286915-1350-4e6b-a0f6-deec02b7fa92@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 17 Jul 2024 13:04:57 -0700
Message-ID: <CAJuCfpG2uNicytRYhfqAKrfkxJoNLUUK_o066D=yKggsoc3wKQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] alloc_tag: outline and export free_reserved_page()
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, hch@infradead.org, 
	pasha.tatashin@soleen.com, souravpanda@google.com, keescook@chromium.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 12:36=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> w=
rote:
>
> On 7/17/24 8:12 PM, Suren Baghdasaryan wrote:
> > Outline and export free_reserved_page() because modules use it and it
> > in turn uses page_ext_{get|put} which should not be exported. The same
> > result could be obtained by outlining {get|put}_page_tag_ref() but that
> > would have higher performance impact as these functions are used in
> > more performance critical paths.
> >
> > Fixes: dcfe378c81f7 ("lib: introduce support for page allocation taggin=
g")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202407080044.DWMC9N9I-lkp=
@intel.com/
> > Suggested-by: Christoph Hellwig <hch@infradead.org>
> > Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>
> Are these two patches now stable@ material as 6.10 build is broken on ppc=
64
> with alloc taging enabled?

I tested them with that specific configuration mentioned in the bug
report and with several usual ones I use.
Yeah, I guess from now on all such fixes should have

Cc: stable@vger.kernel.org # v6.10

>
> > ---
> > Changes since v1 [1]
> > - Outlined and exported free_reserved_page() in place of {get|put}_page=
_tag_ref,
> > per Vlastimil Babka
> >
> > [1] https://lore.kernel.org/all/20240717011631.2150066-2-surenb@google.=
com/
> >
> >  include/linux/mm.h | 16 +---------------
> >  mm/page_alloc.c    | 17 +++++++++++++++++
> >  2 files changed, 18 insertions(+), 15 deletions(-)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index eb7c96d24ac0..b58bad248eef 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -3177,21 +3177,7 @@ extern void reserve_bootmem_region(phys_addr_t s=
tart,
> >                                  phys_addr_t end, int nid);
> >
> >  /* Free the reserved page into the buddy system, so it gets managed. *=
/
> > -static inline void free_reserved_page(struct page *page)
> > -{
> > -     if (mem_alloc_profiling_enabled()) {
> > -             union codetag_ref *ref =3D get_page_tag_ref(page);
> > -
> > -             if (ref) {
> > -                     set_codetag_empty(ref);
> > -                     put_page_tag_ref(ref);
> > -             }
> > -     }
> > -     ClearPageReserved(page);
> > -     init_page_count(page);
> > -     __free_page(page);
> > -     adjust_managed_page_count(page, 1);
> > -}
> > +void free_reserved_page(struct page *page);
> >  #define free_highmem_page(page) free_reserved_page(page)
> >
> >  static inline void mark_page_reserved(struct page *page)
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 9ecf99190ea2..7d2fa9f5e750 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -5805,6 +5805,23 @@ unsigned long free_reserved_area(void *start, vo=
id *end, int poison, const char
> >       return pages;
> >  }
> >
> > +void free_reserved_page(struct page *page)
> > +{
> > +     if (mem_alloc_profiling_enabled()) {
> > +             union codetag_ref *ref =3D get_page_tag_ref(page);
> > +
> > +             if (ref) {
> > +                     set_codetag_empty(ref);
> > +                     put_page_tag_ref(ref);
> > +             }
> > +     }
> > +     ClearPageReserved(page);
> > +     init_page_count(page);
> > +     __free_page(page);
> > +     adjust_managed_page_count(page, 1);
> > +}
> > +EXPORT_SYMBOL(free_reserved_page);
> > +
> >  static int page_alloc_cpu_dead(unsigned int cpu)
> >  {
> >       struct zone *zone;
>

