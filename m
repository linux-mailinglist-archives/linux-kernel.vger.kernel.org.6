Return-Path: <linux-kernel+bounces-189062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDDB8CEA7C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 21:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0F951F21A00
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 19:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F6942ABE;
	Fri, 24 May 2024 19:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vlP/zhnU"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4541BF3F
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 19:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716580483; cv=none; b=DTWaBlx9ugYDzhAtpvxo1j+9/D+/WRuobGdyQ/TgWXObfzJztodFOKkPpJXuPAbBQG1/8qcmiPlqLdLWyUVnTvki8puqqYTMYJNuFqHWP06cQK42e1U8fTRz9Z/SQYZp8blegt37Zb5TB8faxj0wiElfUc+xojkFvhslkrOhNtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716580483; c=relaxed/simple;
	bh=M8QSxZyABGJysN2Nq3Op4hByeA8DuoRqgb9QnmLXaOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h/33dXNoWQ3nEe/FcwU1vmlericAOzb4X68+atARv5RdRCcG6CY5xHkhommE+D8Z42j1F9/jLC1CTxciVnwYpq6i+tsxj3N2P9evoT2awQ2uxwdpzhHEjnh8rhHFl2jLgp4Bo9zoxMkxoX0dGKkT69w3/gNEWKU2qF3T2e786s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vlP/zhnU; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a6269ad71b6so152529266b.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 12:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716580479; x=1717185279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ICme2/z6Xr6kFtN3pR1B01HW/Va0+ZeDeW0iiu2ZaK8=;
        b=vlP/zhnUAz34zQhSHeyyaoKBwQO9Oq3wzldi1p+c2exXYs1RwR1NL0Q1f+eIZlq3pu
         6ht7dZKct0eCsDjSi4fDjCvqP3B1GxbZmN/NjYKkENtAZwbTWT95dv9nVGE30lj/6OOF
         MZBnZP537s+DPB+mpMav5KD4tYHedUSeZEbMSbjeycWH3EnqRTsT4mBj3bZghCn53F0B
         bjTPhFD8CP4uwlYV4sQYrNtP4M+j9gFCBQ5z8e9kxyN+QObZEZ14vqZsFjdAR0UVs+9U
         NmlSLuZu8usGFWVStuj6iv2Bf8oFMjbqkGYQOTtYfWRT/uUudNwuE/NtqDHYXB+eqZIb
         uFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716580479; x=1717185279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ICme2/z6Xr6kFtN3pR1B01HW/Va0+ZeDeW0iiu2ZaK8=;
        b=rd9EbgIfoYdi+KiTF0/aNsT3Sh5zOMeBQahy6D/R576g8mCKcVn0YbRoYwP1DHHh5Q
         RQP29IYaAsADHlIls8yBWcOZCMVHq+Ip/58BuVHR5nSMyyV12jgquk4MApipaE5qYnUJ
         ZQYzuhiUdNilt8WtzZmFmGQfWuJGOh3JMBe7xtlvULR1RtY1lYL6/tl/DePVj9jftVNQ
         P3UuvoYWdkeFc3bJ/CpJX/iH2xcC3K1R6Z3AGfQdEScs3Yfec0gEM3PpSn/UiORApmus
         Vft8FSyCw4rmyCAPYhQnmeZUrAnmLZVlk48+ADYlaywJ3HbRw2g7veH7YnDPXvRCbNF7
         4Ruw==
X-Forwarded-Encrypted: i=1; AJvYcCUkpMN7gdyDP3smT65PG+UmYSdyMtQkIcgFbv1XgoYAJ+d4ZuOe8nP2qG/QNuIxOa4nkFafajdc6CEi1ZvtqEgI3SCNOzUaG+MtUVFC
X-Gm-Message-State: AOJu0YzYth9FQC4Ut7zSJMtdbn7qfLbI7hx9NdaQiiNTBQeyFDhAOz5J
	pewW00ey1QAMdZ13rEYkqUJmWcQKQJS0ElAA/aYNKhuB3LQZM1R1EATLmLO38sTj9Slp3s0bn4J
	bPxDcBx1Lq6dV0rnfH0fpgRUF+UG9l24erbWy
X-Google-Smtp-Source: AGHT+IEpm0E34iKpxTfKRJRT8lqX7m0YvtLAkZwX7X8J7kgj94Zr2Xv9VdmfJYxRG0lwyTKu5x/bwZhL/EcoxOEX6yc=
X-Received: by 2002:a17:906:c4c6:b0:a59:c28a:7ec2 with SMTP id
 a640c23a62f3a-a62646ce06amr209526066b.41.1716580478946; Fri, 24 May 2024
 12:54:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524033819.1953587-1-yosryahmed@google.com> <ZlAQo0P4Z-dgVHn6@casper.infradead.org>
In-Reply-To: <ZlAQo0P4Z-dgVHn6@casper.infradead.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 24 May 2024 12:53:59 -0700
Message-ID: <CAJD7tkaVFa24Yty=8J01OKkaFB-TDiKq1tj0GuOD2_TbU+13SQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] mm: zswap: trivial folio conversions
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 8:59=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Fri, May 24, 2024 at 03:38:15AM +0000, Yosry Ahmed wrote:
> > Some trivial folio conversions in zswap code.
>
> The three patches themselves look good.
>
> > The mean reason I included a cover letter is that I wanted to get
> > feedback on what other trivial conversions can/should be done in
> > mm/zswap.c (keeping in mind that only order-0 folios are supported
> > anyway).  These are the things I came across while searching for 'page'
> > in mm/zswap.c, and chose not to do anything about for now:
>
> I think there's a deeper question to answer before answering these
> questions, which is what we intend to do with large folios and zswap in
> the future.  Do we intend to split them?  Compress them as a large
> folio?  Compress each page in a large folio separately?  I can see an
> argument for choices 2 and 3, but I think choice 1 is going to be
> increasingly untenable.

Yeah I was kinda getting the small things out of the way so that zswap
is fully folio-ized, before we think about large folios. I haven't
given it a lot of thought, but here's what I have in mind.

Right now, I think most configs enable zswap will disable
CONFIG_THP_SWAP (otherwise all THPs will go straight to disk), so
let's assume that today we are splitting large folios before they go
to zswap (i.e. choice 1).

What we do next depends on how the core swap intends to deal with
large folios. My understanding based on recent developments is that we
intend to swapout large folios as a whole, but I saw some discussions
about splitting all large folios before swapping them out, or leaving
them whole but swapping them out in order-0 chunks.

I assume the rationale is that there is little benefit to keeping the
folios whole because they will most likely be freed soon anyway, but I
understand not wanting to spend time on splitting them, so swapping
them out in order-0 chunks makes some sense to me. It also dodges the
whole fragmentation issue.

If we do either of these things in the core swap code, then I think
zswap doesn't need to do anything to support large folios. If not,
then we need to make a choice between 2 (compress large folios) &
choice 3 (compress each page separately) as you mentioned.

Compressing large folios as a whole means that we need to decompress
them as a whole to read a single page, which I think could be very
inefficient in some cases or force us to swapin large folios. Unless
of course we end up in a world where we mostly swapin the same large
folios that we swapped out. Although there can be additional
compression savings from compressing large folios as a whole.

Hence, I think choice 3 is the most reasonable one, at least for the
short-term. I also think this is what zram does, but I haven't
checked. Even if we all agree on this, there are still questions that
we need to answer. For example, do we allocate zswap_entry's for each
order-0 chunk right away, or do we allocate a single zswap_entry for
the entire folio, and then "split" it during swapin if we only need to
read part of the folio?

Wondering what others think here.

