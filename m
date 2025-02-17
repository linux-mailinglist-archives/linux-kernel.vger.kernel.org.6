Return-Path: <linux-kernel+bounces-518046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEF9A38912
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A504418886E1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559372253B7;
	Mon, 17 Feb 2025 16:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XIAha/RO"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61652248B6
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 16:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739809587; cv=none; b=GBmlmzerg8/eE3LzuxoCyqMhXDEKLCD4IczvE4/jTqGlZu8DweNtsBL+ZQTjUV7vd6TFx2CxUaiXNfkeAy0d3pAAKWXha1SRzg3MMtLPRNOE2rxV4CX2I9ZjTzmSDrKk/UF44PN9D3OVxUNHTrURO2EfY+aJQAyxtlw2rE86Z1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739809587; c=relaxed/simple;
	bh=rXOVe73N7fvHfgmzIgTMZ+ee01E53irQEtIEUAhLu38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=No2FhKNIZojTNyGsWDM+nxujPtekPoPRAp9KJS0Gh4ZWUmwVoZcINEuttWoS9aaM2M0CDsogayoM7TZACZ0KIUq7Cx8JI6m5MUpT8DXXNsbjtNpxPTBi6/vazvSYnVjR+rsjBqRz8XIcpl9zNwnjHQLXrxSVhWsr9e/UV8ODVDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XIAha/RO; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-471c9947bb5so544631cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 08:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739809584; x=1740414384; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CDQq1ZHlmhGCpWP3Ju0hsCsViChnbi4Dj7J9vzLAh2E=;
        b=XIAha/ROcafHLF7ESZc4DOcWlc47XCsx4cDnP/K0V2EtgG+Da/gk2guebEPZ/vrnZh
         4cqKllj4DCwRBXDMtJ549bTJy6RIfdc5cOJZvi+by4ZtiAaBHxOZzHFbhWQP5iU84sHn
         9kIiAsxudG+nzAFpLSygZDpIr8knA2xfm9eZTPrzvJHz3fIVSQjmSh/QkpK15VBYnlQX
         duBEvaxYzvuNMvnmSQyrzBFWDvGfCB591GHqIow82IItjWkpnQT7/XEC+fvv8NdehEOB
         FBJwrpW5CIpU4KqkjtmbJ9Xex2W8tPzVFn8BgSzXL9AJCAXz3nTRru6MeH+CWpukaUy+
         zaOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739809584; x=1740414384;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CDQq1ZHlmhGCpWP3Ju0hsCsViChnbi4Dj7J9vzLAh2E=;
        b=bEENdujbKPEVu55+9mpgUNtDP8DzbcOh/HRTeP102Rnt6uWrFsGIMvOKzSHVnr74fs
         v18KCZyv7rN2e+1SfAhm4UCj8BfLE95yxIB+mIxviMolGEicVYxhUj/aHsv1UBAoMlv+
         BTlKHB+WPPUo1/dGSdq+PrgK+k4/qB4QtgnR4JWI55lLW6EtP6hIESINZ9FKxfUrGPEf
         VAsZi/qwxKQlBJU56bmB2YqQ0+3kUcp+Dra4vVbyroH74QxgfaYEVE4k343vsV59IVPq
         6TGb1GWK2CRkGBn8Z+zKspA1NYaAPN7MVUvMgxxzQ1EyCIFhz7y0b5ER7qUftXdIto0B
         oSHg==
X-Forwarded-Encrypted: i=1; AJvYcCWxJdSSIy3ZQJzeOSJIVxEnTUFHnf7//9CJV13zCnyto8hQi5vSPHqKXbIEgwplZ0BK8yUakkV1YhPQWSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsTB9SQeG8TYA8xBdcpVsZT9O85eHt3GY3ItqbmWRCuluy+GXJ
	YJbaG+VecVVYJD8e+pwQJv0YKwlfYxuUYIJsZrc5m1bHlz7+rMl3SIncN+iwTwdYnU4w/N1zzRt
	9kZIRVCsdhzKmJWviRONGDFXb/QJpVx19j0bApfV2vaHqwXR3xYyiVLg=
X-Gm-Gg: ASbGncu5iz0TH7hAThWOYnll/O+aIYtJE3XREr02ntmr5YchHLH3QIh+zAf4mWGJ0ND
	rB9/zf0g0FfifUTmYzZ+H2dWFR3HpeIgHEMzeZRQl13vpY4wmh+h06Dt6z9hHqPy7mOhQ+JZJbt
	M7surC9fbNwIHuEPOOE9ILJKQyB34=
X-Google-Smtp-Source: AGHT+IEz9QiFxXVt9djGwQjwWFsghAxtlpfKAUsRNzaiUbfqECJc6eT7Hqzi7PX01YhFiFcKyP0+Nw8TsBTb156+e6A=
X-Received: by 2002:a05:622a:1899:b0:467:7c30:3446 with SMTP id
 d75a77b69052e-471de0b5ed9mr6840341cf.25.1739809584141; Mon, 17 Feb 2025
 08:26:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214-clarify-steal-v1-1-79dc5adf1b79@google.com> <20250214212647.GB233399@cmpxchg.org>
In-Reply-To: <20250214212647.GB233399@cmpxchg.org>
From: Brendan Jackman <jackmanb@google.com>
Date: Mon, 17 Feb 2025 17:26:13 +0100
X-Gm-Features: AWEUYZlMYGEgOlTizF6GmwQhAkr6afPT7FHv6V6Y7r1Y6XTAFkC33lSRqBjnQt0
Message-ID: <CA+i-1C3e_JUBBhMDYwrehvLZzLtb9pfgEy8=wQa=9uTBr1-b5g@mail.gmail.com>
Subject: Re: [PATCH] mm/page_alloc: Clarify some migratetype fallback code
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Mel Gorman <mgorman@techsingularity.net>, Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Feb 2025 at 22:26, Johannes Weiner <hannes@cmpxchg.org> wrote:
> >  2. can_steal_fallback() sounds as though it's answering the question "am
> >     I functionally permitted to allocate from that other type" but in
> >     fact it is encoding a heuristic preference.
>
> Here I don't see that nuance tbh.
>
> >  3. The same piece of data has different names in different places:
> >     can_steal vs whole_block. This reinforces point 2 because it looks
> >     like the different names reflect a shift in intent from "am I
> >     allowed to steal" to "do I want to steal", but no such shift exists.
> >
> > Fix 1. by avoiding the term "steal" in ambiguous contexts. This fixes
> > 3. automatically since the natural name for can_steal is whole_block.
>
> I'm not a fan of whole_block because it loses the action verb. It
> makes sense in the context of steal_suitable_fallback(), but becomes
> ominous in find_suitable_fallback().
>
> Maybe @block_claimable would be better?

Yeah that sounds good to me.

> > @@ -1948,7 +1948,7 @@ steal_suitable_fallback(struct zone *zone, struct page *page,
> >       if (boost_watermark(zone) && (alloc_flags & ALLOC_KSWAPD))
> >               set_bit(ZONE_BOOSTED_WATERMARK, &zone->flags);
> >
> > -     /* We are not allowed to try stealing from the whole block */
> > +     /* No point in stealing from the whole block */
>
> The original comment actually makes more sense to me. Why is there no
> point? It could well find enough free+alike pages to steal the
> block... It's just not allowed to.

OK so this is basically point 2 from the commit message, maybe I don't
really understand why this condition is here, and maybe I'm about to
look stupid.

Why don't we allow this code to steal the whole block? There wouldn't
be any functional bug if it did, right? I thought that !whole_block
just meant "flipping that block would not have any real benefit from a
fragmentation point of view". So we'd just be doing work and modifying
data structures for no good reason. Is there some stronger reason I'm
missing why we really _mustn't_ steal it?

> I will say, the current code is pretty hard to reason about:
>
> On one hand we check the block size statically in can_steal_fallback;
> on the other hand, we do that majority scan for compatible pages in
> steal_suitable_fallback(). The effective outcomes are hard to discern,
> and I'm honestly not convinced they're all intentional.
>
> For example, if we're allowed to steal the block because of this in
> can_steal_fallback():
>
>         order >= pageblock_order/2
>
> surely, we'll always satisfy this in steal_suitable_fallback()
>
>         free_pages + alike_pages >= (1 << (pageblock_order-1)
>
> on free_pages alone.

No, the former is half the _order_ the latter is half the _number of
pages_. So e.g. we could have order=6 (assuming pageblock_order=10)
then free_pages might be only 1<<6 which is less than 1<<9.

Anyway your underlying point that this is confusing is obviously correct!

> And if the order is less than half a block, we're only allowed an
> attempt at stealing it if this is true in can_steal_fallback():
>
>         start_type == MIGRATE_RECLAIMABLE ||
>         start_type == MIGRATE_UNMOVABLE
>
> So why is the majority scan in steal_suitable_fallback() checking:
>
>         if (start_type == MIGRATE_MOVABLE)
>                 alike_pages = movable_pages
>
> Here is how I read the effective rules:
>
> - We always steal the block if at least half of it is free.
>
> - If less than half is free, but more than half is compatible (free +
>   alike), we currently do movable -> non-movable conversions.
>
>   We don't do non-movable -> movable (won't get to the majority scan).
>   This seems reasonable to me, as there seems to be little value in
>   making a new pre-polluted movable block.
>
> - However, we do non-movable -> movable conversion if more than half
>   is free. This is seemingly in conflict with the previous point.

Hmm I'm not sure I'm seeing the "conflict", I think you just have to
word it differently it's like:

- For movable allocations, there's a threshold of the square root of
the pageblock size (??) before we consider stealing.

- Otherwise, we steal the block if more than half is compatible.

- If this threshold prevents us from stealing the whole block, we find
the page via the smallest-order freelist possible instead of largest.

Does that seem right to you?

It feels like that last point has something to do with: if we know in
advance that we aren't gonna steal the whole block, we wanna avoid
breaking down a high-order page. But, if the allocation is movable, we
wouldn't create persistent fragmentation by doing that. So I'm
realising now that I don't entirely understand this.

> Then there is compaction, which currently uses only the
> find_suitable_fallback() subset of the rules. Namely, for kernel
> allocations, compaction stops as soon as there is an adequately sized
> fallback. Even if the allocator won't convert the block due to the
> majority scan. For movable requests, we'll stop if there is half a
> block to fall back to.

Not half a block, "square root" of a block. But yeah.

> I suppose that's reasonable - the old
> utilization vs. fragmentation debate aside...
>
> Did I miss one?
>
> We should be able to encode all this more concisely.
>
> > @@ -1995,12 +1995,14 @@ steal_suitable_fallback(struct zone *zone, struct page *page,
> >
> >  /*
> >   * Check whether there is a suitable fallback freepage with requested order.
> > - * If only_stealable is true, this function returns fallback_mt only if
> > - * we can steal other freepages all together. This would help to reduce
> > + * Sets *whole_block to instruct the caller whether it should convert a whole
> > + * pageblock to the returned migratetype.
> > + * If need_whole_block is true, this function returns fallback_mt only if
> > + * we would do this whole-block stealing. This would help to reduce
> >   * fragmentation due to mixed migratetype pages in one pageblock.
> >   */
> >  int find_suitable_fallback(struct free_area *area, unsigned int order,
> > -                     int migratetype, bool only_stealable, bool *can_steal)
> > +                     int migratetype, bool need_whole_block, bool *whole_block)
> >  {
> >       int i;
> >       int fallback_mt;
> > @@ -2008,19 +2010,19 @@ int find_suitable_fallback(struct free_area *area, unsigned int order,
> >       if (area->nr_free == 0)
> >               return -1;
> >
> > -     *can_steal = false;
> > +     *whole_block = false;
> >       for (i = 0; i < MIGRATE_PCPTYPES - 1 ; i++) {
> >               fallback_mt = fallbacks[migratetype][i];
> >               if (free_area_empty(area, fallback_mt))
> >                       continue;
> >
> > -             if (can_steal_fallback(order, migratetype))
> > -                     *can_steal = true;
> > +             if (should_steal_whole_block(order, migratetype))
> > +                     *whole_block = true;
> >
> > -             if (!only_stealable)
> > +             if (!need_whole_block)
> >                       return fallback_mt;
> >
> > -             if (*can_steal)
> > +             if (*whole_block)
> >                       return fallback_mt;
> >       }
>
> This loop is quite awkward, but I think it actually gets more awkward
> with the new names.
>
> Consider this instead:
>
>                 *block_claimable = can_claim_block(order, migratetype);
>                 if (*block_claimable || !need_whole_block)
>                         return fallback_mt;

Yeah and even just combining the conditionals makes this much easier
to follow IMO.

> Or better yet, inline that function completely. There are no other
> callers, and consolidating the rules into fewer places would IMO go a
> long way of making it easier to follow:
>
>                 if (order >= pageblock_order/2 ||
>                     start_mt == MIGRATE_RECLAIMABLE ||
>                     start_mt == MIGRATE_UNMOVABLE)
>                         *block_claimable = true;
>
>                 if (*block_claimable || !need_whole_block)
>                         return fallback_mt;

Sounds good. There might also be some clarity to be gained by fiddling
around with the comments and polarity of conditions too.

E.g. It's confusing that the comment above that first conditional
talks about returning false for movable pages, but the conditional is
about returning true for unmovable.

Anyway I will have a bit more of a think about this.

