Return-Path: <linux-kernel+bounces-189182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2AE8CEC9C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 01:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C1BA1C20D6E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 23:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A55F128803;
	Fri, 24 May 2024 23:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EbkpSPrl"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD8A2CA5
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 23:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716592389; cv=none; b=JpEWmh6OBRZJqZEDXhp/a9e6jxon9dGnEFGJgDM0qt83XUP4X09sKkwUKXR88ZB8BgS5NQSCmXVTkT4rO+C1LeabLxaY6KxjTwYhBUsmYz05DDDv2/iHLzzS17hACir8hbPx8AosymSMxs4i4dZkQzcip2xkl+SZgz7CoEY57ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716592389; c=relaxed/simple;
	bh=6/eetZAd8wF0B6rjK2XKTeoKmNQE5OZ0dbrB8SDzM4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZrUJCgNgz2sRknV3tFTHJ4h4kj761OeRY2pLPEoNgg6aIAx18XYbFfjbbJS4nq54Io1sJMo4fuJ9LBayGqAihetPvOPOE5VY9ZAjDwoIa2u/+DeEFzEmWOaFH4wowb0VkD1egFrXmHOxt2tpHsONIj8Gz5KOoPbzVOwReM9kUYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EbkpSPrl; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57857e0f462so1284984a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 16:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716592386; x=1717197186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLe89AfXNhx0q2K1ygphHX7RVDhsSbjLXuCJH9i7f18=;
        b=EbkpSPrlVhYBKA7r/JM3NTJK8VOQ0o1SsTV4j2Tj4r16jhrdADxarzhcGvkX/8sUjE
         L9GaGndgNC8+vqVqDs+ryVE8eiwzP8rXmrSDSNqPv5VD0fFbkY9TKyJB9e/ZtxHpNWdr
         bRGcVvaZXMsPahsQyuc/CEZCkIk4y8v6hRu/bThOq+uOfQlaIIUM5VBCmhMCP2xWFD3w
         W37qe79jN8EcXaoFna3coiqpwKV0BcxyDuUuXsviHF1JlrRGw0BAvoI1QEMEa+VUevGH
         DP78sov1h/thl0Tvd5MY7L7y0l9/MuOBusdnAg9FpILz84Q8V2xMDWS+HikZpDc12SL5
         liFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716592386; x=1717197186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QLe89AfXNhx0q2K1ygphHX7RVDhsSbjLXuCJH9i7f18=;
        b=CYNsY/X0dJp4iVbjgvnkQetNJsvkA2eAiutWb+I9vK1RN3eNYWowSrHX00pPqxBRRp
         0VX+RM7fb42XIzuH58s/gPgjf7jjuxV2kuoMjcQBJ00qB4HuVrgo5n0IfQPOxQzTmnHJ
         EmEc8XzlcNRA4MqfC2G1TnIm3/xT78pkNVGcjxZ03O61L3CV7DZHu4k6xJZScxoYWnJx
         YTtVZHxB+5e3kRAiVT4cs7R36cpgN+fmkmSL51GSiE8pYlsG34w1mDKGaHRriTBmFqiV
         G5Rj+U/dhZTSI15n5d84Zj3rSy0dCniGjI3ugUFWGp/k+BNBvXGp7mJDedwwlq78g49n
         DGiw==
X-Forwarded-Encrypted: i=1; AJvYcCVUChQPJO9xvCjWXYM+Dxko6GpS17ye88VI0Ih4JY1vIaNg9jNKYcIcgjh+0LeUrbeg059MlSTUNXZ0VahwRD/S1j+mD72S83BbHNBK
X-Gm-Message-State: AOJu0YxTHqwCt0geE0roG+EQ2hNWrOoL6+6sijWwN5v1TlJ+TIyInAeQ
	FajeRANrC40xHlLbar/uw8ORO9RCObJEqCJLVcmA4LFgZfrtjpK/+lJCiVAL8CGtCiBgJS1Pi9w
	ElCaBU2FLrkYGggHWVxX8sfB3Ax0flBr0+aqX
X-Google-Smtp-Source: AGHT+IGOPz4oO6pvIvbUfEl8tKZ57eHs7hlulI2gwZf+y/bFnU/Wd7gUnGxTB+xwlS+B9tcS+usVvLSYNZehJgqoxcg=
X-Received: by 2002:a17:906:38cf:b0:a5c:dd34:25e7 with SMTP id
 a640c23a62f3a-a62642d894fmr229037466b.1.1716592385666; Fri, 24 May 2024
 16:13:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524033819.1953587-1-yosryahmed@google.com>
 <ZlAQo0P4Z-dgVHn6@casper.infradead.org> <CAJD7tkaVFa24Yty=8J01OKkaFB-TDiKq1tj0GuOD2_TbU+13SQ@mail.gmail.com>
In-Reply-To: <CAJD7tkaVFa24Yty=8J01OKkaFB-TDiKq1tj0GuOD2_TbU+13SQ@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 24 May 2024 16:12:27 -0700
Message-ID: <CAJD7tkaQQAje_jGLwnPp3xAaYcvXiXQBLHC19h=xbZwgSeVrQA@mail.gmail.com>
Subject: Re: [PATCH 0/3] mm: zswap: trivial folio conversions
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>, 
	Barry Song <21cnbao@gmail.com>, Chris Li <chrisl@kernel.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, Kairui Song <kasong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 12:53=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> On Thu, May 23, 2024 at 8:59=E2=80=AFPM Matthew Wilcox <willy@infradead.o=
rg> wrote:
> >
> > On Fri, May 24, 2024 at 03:38:15AM +0000, Yosry Ahmed wrote:
> > > Some trivial folio conversions in zswap code.
> >
> > The three patches themselves look good.
> >
> > > The mean reason I included a cover letter is that I wanted to get
> > > feedback on what other trivial conversions can/should be done in
> > > mm/zswap.c (keeping in mind that only order-0 folios are supported
> > > anyway).  These are the things I came across while searching for 'pag=
e'
> > > in mm/zswap.c, and chose not to do anything about for now:
> >
> > I think there's a deeper question to answer before answering these
> > questions, which is what we intend to do with large folios and zswap in
> > the future.  Do we intend to split them?  Compress them as a large
> > folio?  Compress each page in a large folio separately?  I can see an
> > argument for choices 2 and 3, but I think choice 1 is going to be
> > increasingly untenable.
>
> Yeah I was kinda getting the small things out of the way so that zswap
> is fully folio-ized, before we think about large folios. I haven't
> given it a lot of thought, but here's what I have in mind.
>
> Right now, I think most configs enable zswap will disable
> CONFIG_THP_SWAP (otherwise all THPs will go straight to disk), so
> let's assume that today we are splitting large folios before they go
> to zswap (i.e. choice 1).
>
> What we do next depends on how the core swap intends to deal with
> large folios. My understanding based on recent developments is that we
> intend to swapout large folios as a whole, but I saw some discussions
> about splitting all large folios before swapping them out, or leaving
> them whole but swapping them out in order-0 chunks.
>
> I assume the rationale is that there is little benefit to keeping the
> folios whole because they will most likely be freed soon anyway, but I
> understand not wanting to spend time on splitting them, so swapping
> them out in order-0 chunks makes some sense to me. It also dodges the
> whole fragmentation issue.
>
> If we do either of these things in the core swap code, then I think
> zswap doesn't need to do anything to support large folios. If not,
> then we need to make a choice between 2 (compress large folios) &
> choice 3 (compress each page separately) as you mentioned.
>
> Compressing large folios as a whole means that we need to decompress
> them as a whole to read a single page, which I think could be very
> inefficient in some cases or force us to swapin large folios. Unless
> of course we end up in a world where we mostly swapin the same large
> folios that we swapped out. Although there can be additional
> compression savings from compressing large folios as a whole.
>
> Hence, I think choice 3 is the most reasonable one, at least for the
> short-term. I also think this is what zram does, but I haven't
> checked. Even if we all agree on this, there are still questions that
> we need to answer. For example, do we allocate zswap_entry's for each
> order-0 chunk right away, or do we allocate a single zswap_entry for
> the entire folio, and then "split" it during swapin if we only need to
> read part of the folio?
>
> Wondering what others think here.

More thoughts that came to mind here:

- Whether we go with choice 2 or 3, we may face a latency issue. Zswap
compression happens synchronously in the context of reclaim, so if we
start handling large folios in zswap, it may be more efficient to do
it asynchronously like swap to disk.

- Supporting compression of large folios depends on zsmalloc (and
maybe other allocators) supporting it. There have been patches from
Barry to add this support to some extent, but I didn't take a close
look at those.

Adding other folks from the mTHP swap discussions here in case they
have other thoughts about zswap.

