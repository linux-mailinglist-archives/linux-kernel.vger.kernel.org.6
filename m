Return-Path: <linux-kernel+bounces-547974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 791FBA53E4C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3EBB3A8845
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 23:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2511FCCE8;
	Wed,  5 Mar 2025 23:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="niAwEltb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471751EDA24
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 23:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741216692; cv=none; b=Tuj217qa0201buRJuzMx/qMvC6sz//0256OJ34QsRz/8jLYGQr3ZsIj4V4qyH70QUzT0vMhEGJn7RWfDXK0geSP/Pj/g0FE7PiQDoiuXHbVxV+TNUCSBkbboVvEXRkupRj+8jRTuZM9eaoN2ovJkJEAy4Yro18AMwhtJfPjCmiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741216692; c=relaxed/simple;
	bh=Y82WkIdjvwXX3jwmN+3B1pKPgPbYXzZBKTIzlLto9nI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hEZOK7Whax4H0WkWd+tcKHecCH/9kBsRUHCXeg4lR9QmfjDSFyVwLRNN3CUI7HP0Ov2p2QnwGgf5KZ2T04NitKjzyhCe1qaG4+zYlTymDMr1NIWWxhG7rDoXBJDkmF6LS5MHb9k6qOKCbPlknSZI3x//p9Ok2nl9jmRAazwvUbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=niAwEltb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7894EC4CED1;
	Wed,  5 Mar 2025 23:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741216691;
	bh=Y82WkIdjvwXX3jwmN+3B1pKPgPbYXzZBKTIzlLto9nI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=niAwEltbnzwP8yIN3X4gQL6p8S0DtDkSW4sdRbfXMqiot5fwsrgIoCi6h0t5Kjruv
	 kpt2IUi0IkpRckfudJEkGXvST/HyZ/EhtLIF/lZCsecZ3u5Ag3Gs2EA+hN0B3p3z89
	 2g1xD/hjkpzQuW9GIxZBygg2tr5V/rDsQ13B/ZaqjO1UypCvgLRC6TwgwsZcxMbEIA
	 Av9eulIREaOOaari3MUKErZ+LbQaaGXllUd0F2GL4Yay256B3F211ivAyIVpBowJUm
	 ymwMGhGkCqU+xloliLy3r3mmuHcBmrBgd1DRJaL9WF4a96Bmoh0HbFCbm3WUTr4oqR
	 lfIUi2XbMcNVQ==
From: SeongJae Park <sj@kernel.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <howlett@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 02/16] mm/madvise: split out populate behavior check logic
Date: Wed,  5 Mar 2025 15:18:09 -0800
Message-Id: <20250305231809.136776-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <kic3iznofvqvkljvelk6c7l2jigdwtlrrlhebkrh4tnundfp6h@upfyjh5hr6k5>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 5 Mar 2025 12:32:52 -0800 Shakeel Butt <shakeel.butt@linux.dev> wrote:

> On Wed, Mar 05, 2025 at 10:15:57AM -0800, SeongJae Park wrote:
> > madvise_do_behavior() has a long open-coded 'behavior' check for
> > MADV_POPULATE_{READ,WRITE}.  It adds multiple layers[1] and make the
> > code arguably take longer time to read.  Like is_memory_failure(), split
> > out the check to a separate function.  This is not technically removing
> > the additional layer but discourage further extending the switch-case.
> > Also it makes madvise_do_behavior() code shorter and therefore easier to
> > read.
> > 
> > [1] https://lore.kernel.org/bd6d0bf1-c79e-46bd-a810-9791efb9ad73@lucifer.local
> > 
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> > ---
> >  mm/madvise.c | 20 +++++++++++++-------
> >  1 file changed, 13 insertions(+), 7 deletions(-)
> > 
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index dbc8fec05cc6..4a91590656dc 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -1633,6 +1633,17 @@ static bool is_valid_madvise(unsigned long start, size_t len_in, int behavior)
> >  	return true;
> >  }
> >  
> > +static bool is_memory_populate(int behavior)
> 
> No strong opinion on this patch but if you want to keep it, the above
> name feels weird. How about either is_madvise_populate() or
> is_populate_memory()?

I wanted to make this reads consistent with other similar purpose ones like
is_memory_failure(behavior).  I have no strong opinions, either, though.
Unless someone makes a voice here, I will rename this to is_madvise_populate()
in the next version.

> 
> > +{
> > +	switch (behavior) {
> > +	case MADV_POPULATE_READ:
> > +	case MADV_POPULATE_WRITE:
> > +		return true;
> > +	default:
> > +		return false;
> > +	}
> > +}

Thanks,
SJ

[...]

