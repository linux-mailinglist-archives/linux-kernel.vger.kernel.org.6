Return-Path: <linux-kernel+bounces-235303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBF991D35C
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 21:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2BCE2811BF
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 19:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C4E1534EA;
	Sun, 30 Jun 2024 19:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C/U5cPSU"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C69410F2
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 19:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719775065; cv=none; b=WagCkQ8vEO9gvOfvlAPb13fuRSAiNV3p+g4QR90kkn0r7zcDhPqjYTw8NrFuSUSNdAfoPYxer9ro9yiyrxCnnvHruuUtuEiswBdEbVcca9ei9CTF1sbQ2Ntk0RwxvHwIcNWPbmDZQuUYQxwrrgDSTFmml7JtI0GTY9AaEjY7H+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719775065; c=relaxed/simple;
	bh=2vXysKU7G/zuWu9MTVdkWa2NI2s03ekoU7AlLzCX0tY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mO1gXZZ7SIA77ZLZuUEGz9fNrdBFQrOIYMdx2uiLqSMunrpCP+MTUgdHkn8ycdeelUYel0HtdYttD8OaDjOCPcadIdpmoVKaM0KqVtiiDS1Bwunjmq9PENOM1xPbdjSktIz3yEbzAS8zlcnczWUZ2eAzxucaNHpWnjVQrKwhjEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C/U5cPSU; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-643efaf0786so17756127b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 12:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719775063; x=1720379863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LiM1pX68adOinY1Ba8HhJGroraZqmuLSBXlSTDfxtcw=;
        b=C/U5cPSUN1UMaydvc0egP52azVH0TXSOblwV4iQcQrzOvosCCRCP1xTMhWU7GhU4/g
         mcaKUxt3YxF6xTHxKUJcuaDHlRMibCLFZVwAa3lQzmOPTx9UxHlQrisy1mo/WFxHqluh
         /HcEG4qjcOWC/c2s/4dSslQivDi/8hozjgd6lwZ+qOMQAlvfAIVAatW+ZcOZdjlhrNpo
         cypaP5uq8XH4aTAHFwl59aDpcL6XpkcoEQtRVtpPrNPul1avdqUOGE+Kf+tYCy+eJEfI
         sM/wv/BPyw0mnnzGv3B648iYipGTdWgYjTJQ07YBiuFaS+rEn/botnLipA2gPgXyTGTb
         VC6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719775063; x=1720379863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LiM1pX68adOinY1Ba8HhJGroraZqmuLSBXlSTDfxtcw=;
        b=QAziukKo7KbYR/M1h9djQO3Ea/jjuCNyfoj/lJR2n8Hx84/aHjdKAHe+DihXthedpp
         CMXGp+kv9aoB4JojNTKMW4nxtJOX8uj8+HloIxq4Ylgaokh/QsygsrocynmOfzHl0HP7
         IMvSqka19spmf0R6s622XuximgZIqQMrxtgVAefIdrzWu0kcwiU2LvmKie5JakMps22d
         K7NbesFUjwBhlzac01TsQCOatUFRQLEaBuxWMBZ4iNdPsprNEvAf+Uu5m9BNCFjmvuRJ
         O1FB+yFK/5lFzw34E4Rcp5/puGG8943gbljOa1fx82POeaOL/WYR2ZUOZgC6Mt4P6EMi
         zw/g==
X-Forwarded-Encrypted: i=1; AJvYcCW99MfBTYlrIG14EZ9qnzBv7Py87hjDVfHVSD1UiAM0H0Fd2Tzi9ilZuz2Lyg8NjmnoeZC3HFDwupoLpkuqgo6OULTJtKp9Un0DCiYN
X-Gm-Message-State: AOJu0YyCXnPD2Jpc8vZlgPEaGtw77/tAQz4fY8vLiL+brQ2bn0uTNaFT
	lLsN1h+KtY+JiaW/XYGG+Se89WDFutEpZKQoAyctt6TSFZiOqg8f1Qir59GuNfQPOQoIo3Xd9Ot
	HYqz97uers2FPACJL+gIaaNbquVHQoESFL89fsifHAhDgTBmg3Q==
X-Google-Smtp-Source: AGHT+IHtbfYXamlGFEAiXUeTmfE7JAmJyT9hNWLW1R+8Hx2Kd9pGyd56H2rm7Z0f9UaPctOiJ68pR3Gqf60xKWnHlMk=
X-Received: by 2002:a81:4c50:0:b0:64a:62f4:2a79 with SMTP id
 00721157ae682-64c71aebe40mr28201327b3.21.1719775063121; Sun, 30 Jun 2024
 12:17:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614230504.3849136-1-surenb@google.com> <2a0ee369-12f9-401a-9179-82bd659ae201@suse.cz>
In-Reply-To: <2a0ee369-12f9-401a-9179-82bd659ae201@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 30 Jun 2024 12:17:32 -0700
Message-ID: <CAJuCfpE+ae8VSZFEsy0rp19dCFHgT4fOR3MnSWORYa3ORJOjqw@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: handle profiling for fake memory allocations
 during compaction
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, 
	pasha.tatashin@soleen.com, souravpanda@google.com, keescook@chromium.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 1:33=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 6/15/24 1:05 AM, Suren Baghdasaryan wrote:
> > During compaction isolated free pages are marked allocated so that they
> > can be split and/or freed. For that, post_alloc_hook() is used inside
> > split_map_pages() and release_free_list(). split_map_pages() marks free
> > pages allocated, splits the pages and then lets alloc_contig_range_nopr=
of()
> > free those pages. release_free_list() marks free pages and immediately
>
> Well in case of split_map_pages() only some of them end up freed, but mos=
t
> should be used as migration targets. But we move the tags from the source
> page during migration and unaccount the ones from the target (i.e. from t=
he
> instrumented post_alloc_hook() after this patch), right? So it should be =
ok,
> just the description here is incomplete.

Sorry for the delay with replying, Vlastimil.
Yes, you are correct. Some of these pages are not immediately freed
but migrated and during migration the destination gets charged for
them. As a result these new counters should still read 0 most of the
time except for some intermediate states.
I can amend the description if this is considered important.
Thanks,
Suren.

>
> > frees them. This usage of post_alloc_hook() affect memory allocation
> > profiling because these functions might not be called from an instrumen=
ted
> > allocator, therefore current->alloc_tag is NULL and when debugging is
> > enabled (CONFIG_MEM_ALLOC_PROFILING_DEBUG=3Dy) that causes warnings.
> > To avoid that, wrap such post_alloc_hook() calls into an instrumented
> > function which acts as an allocator which will be charged for these
> > fake allocations. Note that these allocations are very short lived unti=
l
> > they are freed, therefore the associated counters should usually read 0=
.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>
> > ---
> >  mm/compaction.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/compaction.c b/mm/compaction.c
> > index e731d45befc7..739b1bf3d637 100644
> > --- a/mm/compaction.c
> > +++ b/mm/compaction.c
> > @@ -79,6 +79,13 @@ static inline bool is_via_compact_memory(int order) =
{ return false; }
> >  #define COMPACTION_HPAGE_ORDER       (PMD_SHIFT - PAGE_SHIFT)
> >  #endif
> >
> > +static struct page *mark_allocated_noprof(struct page *page, unsigned =
int order, gfp_t gfp_flags)
> > +{
> > +     post_alloc_hook(page, order, __GFP_MOVABLE);
> > +     return page;
> > +}
> > +#define mark_allocated(...)  alloc_hooks(mark_allocated_noprof(__VA_AR=
GS__))
> > +
> >  static void split_map_pages(struct list_head *freepages)
> >  {
> >       unsigned int i, order;
> > @@ -93,7 +100,7 @@ static void split_map_pages(struct list_head *freepa=
ges)
> >
> >                       nr_pages =3D 1 << order;
> >
> > -                     post_alloc_hook(page, order, __GFP_MOVABLE);
> > +                     mark_allocated(page, order, __GFP_MOVABLE);
> >                       if (order)
> >                               split_page(page, order);
> >
> > @@ -122,7 +129,7 @@ static unsigned long release_free_list(struct list_=
head *freepages)
> >                        * Convert free pages into post allocation pages,=
 so
> >                        * that we can free them via __free_page.
> >                        */
> > -                     post_alloc_hook(page, order, __GFP_MOVABLE);
> > +                     mark_allocated(page, order, __GFP_MOVABLE);
> >                       __free_pages(page, order);
> >                       if (pfn > high_pfn)
> >                               high_pfn =3D pfn;
> >
> > base-commit: c286c21ff94252f778515b21b6bebe749454a852
>

