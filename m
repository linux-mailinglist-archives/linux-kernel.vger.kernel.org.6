Return-Path: <linux-kernel+bounces-372516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B209A49B6
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 00:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93C031F25334
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 22:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88A8190068;
	Fri, 18 Oct 2024 22:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="v/v4/brA"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B50188CDC
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 22:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729291148; cv=none; b=H2j0W4s/7lnVCCC5Z5JzFNZ3YggfEDC0CGNYAjgFLG84qDDRes9YRa6qraMB3O0SYpi70W1pb0d4DNfbxjMOGOne7FtUJceD0YjkODi3jbNDuMAERat8CTnyiKhomiXP/FjodZH6JJJDg6UNn30pN5hpC1jD/4zNpzLqRoZzY4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729291148; c=relaxed/simple;
	bh=BTxBIctsFGuIebMRImYSOtEASqlxEeBV+vnkWsXEWww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZmmAKCjAjKtcSKzy0CXZgzaXAETJwE7vKSp/n+FkS2nDduEXwrG8sJOwTsFcll1iQGJHcvav3r1+emUIWP7yibut9RFvX3ugreckb3yXg084oMTaQGlVh+C/ZasahxMZMjBK1RH23pZfgAnF8PlhMJFGq3cgCs4wJE62Ti+01g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=v/v4/brA; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6cbceb48613so15435836d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 15:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1729291143; x=1729895943; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=27O84oor1VFOi2QdCyPslhDi+MuWwwNB8nDvjSXIg5I=;
        b=v/v4/brA5fGWsJrUtt1EAFACqo+tx5zKDL4DYsY4MvKD0Ueqe6hNZs0vqTGP9RqH57
         rpuPg6EIG7S7hk2wO1DJd+TQTTFz7j311kwgzzOlUZF/sBACWXuaKcw5E2Yl6914bQxX
         Wa1MvAVTvB1UwqT1GhFQxggT550vWR2BjPrQ/JOFYRlXIhgo3tFAEU8uQV5JsZnuPQKX
         MVvyYHKzX/7wwplQ9XjbG0cLb5ONEYnf3Rkf1KHfCqyvC6xNguhPIHeA+csbiYuUhcUM
         MjXy801kksfrr99yluCek8/gGSVufAw0KewBAheSz5lQg8UWXOLmS9v+h0COcM9Ymtse
         1ivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729291143; x=1729895943;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=27O84oor1VFOi2QdCyPslhDi+MuWwwNB8nDvjSXIg5I=;
        b=gIDx90mrdlBe5VllS1EjORaGaljswDX3z7LL6EeY1PTFHLc4BdUbzwwuNbAfs5vT5/
         2CfSDQOH3RH7SwrQUuD8Be+rzY2jQqevEkCAOM1QWzSXZEDVvg/rg7Qe9LKNcHD/uEGv
         iZYFjppjkNQwZXrQRatoAvCRZ7nx40MGH/nmxBsyqa3zwe/wvxUNsFARBitCmt2JBIx4
         wLXR5pzGuhfdlAjkFD0Kh111bzBvJSvnwxVbX5jNF0qC9pqtI//5OcWSr51JShgrAqHZ
         Rqwazey9rft1gLC7AEBFSCfA7gNNy1GT6AlGQc0fSIZzJMS6gv7x+kW3JI6wSythlYEQ
         8etw==
X-Forwarded-Encrypted: i=1; AJvYcCXisGusntfcY6V0+szSBOYqGHWNKCyWXhWO0El5EAuPK92ZbM07207falNLTUVFZU6UgKYrANKQ7ApKpjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFColSG0bydOwjfeKpf/YIz/KXlawH1+64gqDK+kGAmdy2yFdY
	MrlZCDYDEck0h6JojFYxxllrQyTrn8UBvFcH3MCBWG5TBzw05foC+NTlmAaxA78=
X-Google-Smtp-Source: AGHT+IFJ7PMB0YWbSXcu0BJe/T0BQhm3CnzjPN0ToSLmEoHdAVs7NdsRrZlFVzkEuSF5l5ZKvIKWNg==
X-Received: by 2002:a05:6214:469c:b0:6c7:50bf:a443 with SMTP id 6a1803df08f44-6cde1583893mr60176556d6.30.1729291143089;
        Fri, 18 Oct 2024 15:39:03 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cde111ccd4sm11346246d6.26.2024.10.18.15.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 15:38:59 -0700 (PDT)
Date: Fri, 18 Oct 2024 18:38:55 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Kairui Song <ryncsn@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Chris Li <chrisl@kernel.org>, Barry Song <v-songbaohua@oppo.com>,
	"Huang, Ying" <ying.huang@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm, zswap: don't touch the XArray lock if there is no
 entry to free
Message-ID: <20241018223855.GC81612@cmpxchg.org>
References: <20241018192525.95862-1-ryncsn@gmail.com>
 <ZxK7G3S0N42ejJMh@casper.infradead.org>
 <CAMgjq7AjBMJAE-rj2MmB53FrQKcsARK5tZ3sKB4+uhWhkQ=EGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMgjq7AjBMJAE-rj2MmB53FrQKcsARK5tZ3sKB4+uhWhkQ=EGA@mail.gmail.com>

On Sat, Oct 19, 2024 at 04:01:18AM +0800, Kairui Song wrote:
> On Sat, Oct 19, 2024 at 3:46 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Sat, Oct 19, 2024 at 03:25:25AM +0800, Kairui Song wrote:
> > >       if (xa_empty(tree))
> > >               return;
> > >
> > > -     entry = xa_erase(tree, offset);
> > > -     if (entry)
> > > +     rcu_read_lock();
> > > +     entry = xas_load(&xas);
> > > +     if (entry) {
> >
> > You should call xas_reset() here.  And I'm not sure it's a great idea to
> > spin waiting for the xa lock while holding the RCU read lock?  Probably
> > not awful but I could easily be wrong.

Spinlocks already implicitly acquire an RCU read-side lock before
beginning to spin, so we shouldn't be worse for wear by doing this.

> Thanks for the review. I thought about it, that could cancel this optimization.
> 
> Oh, and there is a thing I forgot to mention (maybe I should add some
> comments about it?). If xas_load found an entry, that entry must be
> pinned by HAS_CACHE or swap slot count right now, and one entry can
> only be freed once.
> So it should be safe here?
> 
> This might be a little fragile though, maybe this optimization can
> better be done after some zswap invalidation path cleanup.

This seems fine too, exlusivity during invalidation is a fundamental
property of swap. If a load were possible, we'd be freeing an entry
with ptes pointing to it (or readahead a slot whose backing space has
been discarded). If a store were possible, we could write new data
into a dead slot and lose it. Even the swapcache bypass path in
do_swap_page() must at least acquire HAS_CACHE due to this.

So from a swap POV, if we find an entry here it's guaranteed to remain
in the tree by the calling context. The xa lock is for protection the
tree structure against concurrent changes (e.g. from adjacent entries).

With that said, is there still a way for the tree to change internally
before we acquire the lock? Such that tree + index might end up
pointing to the same contents in a different memory location?

AFAIK there are two possible ways:

- xas_split() - this shouldn't be possible because we don't do large
  entries inside the zswap trees.

- xas_shrink() - this could move the entry from a node to xa->head,
  iff it's the last entry in the tree and its index is 0. Swap offset
  0 is never a valid swap entry (swap header), but unfortunately we
  have split trees so it could happen to any offset that is a multiple
  of SWAP_ADDRESS_SPACE_PAGES. AFAICS xas_store() doesn't detect such
  a transition. And making it do that honestly sounds a bit hairy...

So this doesn't look safe to me without a reload :(

