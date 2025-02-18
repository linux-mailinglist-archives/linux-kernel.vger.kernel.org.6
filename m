Return-Path: <linux-kernel+bounces-519167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB252A398A4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 11:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63D5D188A6CF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C121623237A;
	Tue, 18 Feb 2025 10:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WEdEBPSV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Tm5p9YcA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bnKj3VjC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="caLBMIIV"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D41F198E81
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 10:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874004; cv=none; b=Ua8fXTLcQLYna9zp4yICHLJgxnJ4o6F2mroUxjRiLZKqoJ7C3xNj0YfIzuGnW6OkjN3XpbRYUtwLaOj9GfJdc7+y6/WV8iz6Xtz9g49Ho5jbMeHZqovotAZUJNBRwxBde7r1Q2DT7vzie/hjdXM3Lls2n0v+3w8k1LG7bXdPlJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874004; c=relaxed/simple;
	bh=pQSmup6G9MJ1Q9VrIWzud9L3Njhx/nZ974MxQnBiVbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QLEgmQ8DDfHs/tSuo+X2caTcUSVAPMr1v0MX4GnAlu9/DDCBqa2/HEb4e/ijUrCxOtZq4tYVfAeIqH+aW0E6uXsUjU3CCbUEQSt4wNO/T0tq3Ho13TRgGXf7rJ2kujM7c9weUkQMDD8u4mwGhWMmgfUwiCaNY/qLf0Lq4fNzTAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=fail smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WEdEBPSV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Tm5p9YcA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bnKj3VjC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=caLBMIIV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 344C31F396;
	Tue, 18 Feb 2025 10:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739874000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6POwk11Us/UexRFgOdpPphYOOM+6iluVJn0Wmq/LmVU=;
	b=WEdEBPSVBmfdoIvcmRaj/JT970g+H0LkjzCCFRjrlX/AgvQ/7oFQE3xzmpghpKqkbpi+29
	3kqxY/h2KFPCY5nOWOica9zrA4JvLMJeXsLVkuffdbd3TMj3RPVfMTT9yMFsOAMYDi3a6u
	At6V8WTvhV2yhwIcSjnqNZlhc57oDSM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739874000;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6POwk11Us/UexRFgOdpPphYOOM+6iluVJn0Wmq/LmVU=;
	b=Tm5p9YcAuIxaUwQEOJVEP/RX3f+CIRna5P0De9ROfLMhn2i1WfMyxyJSyGkAJezok+Qvjy
	JFt8oJGg/E1HE8DA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=bnKj3VjC;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=caLBMIIV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739873999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6POwk11Us/UexRFgOdpPphYOOM+6iluVJn0Wmq/LmVU=;
	b=bnKj3VjCF4MNyzMgkaNMvWSAkiAqhWchEe0hksRLe6XG4LnZDc+ooxWXORZ+j+Mtj9YH10
	hU/X/olzvcmPLNPJK0aGBwp8PBK38Col8ycLyTegf2PgUjPqNu5gQXWZJw9O3bjdz57kTu
	boou6cGxnPvXRRpzVRWi6ZLoCJytCCY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739873999;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6POwk11Us/UexRFgOdpPphYOOM+6iluVJn0Wmq/LmVU=;
	b=caLBMIIVXNxZGWUIkY67/U6Q04rw3HQaOc7jR08mN0IvGUq96szUVJZw/oX6TEAipKEzJi
	ikYx5hXtxWiSyxAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 189F5132C7;
	Tue, 18 Feb 2025 10:19:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oYSWBc9etGfXBgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 18 Feb 2025 10:19:59 +0000
Message-ID: <764394d9-592c-4d68-8910-67362dd8810a@suse.cz>
Date: Tue, 18 Feb 2025 11:19:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/page_alloc: Clarify some migratetype fallback code
Content-Language: en-US
To: Brendan Jackman <jackmanb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Mel Gorman <mgorman@techsingularity.net>, Michal Hocko <mhocko@kernel.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Yosry Ahmed <yosry.ahmed@linux.dev>
References: <20250214-clarify-steal-v1-1-79dc5adf1b79@google.com>
 <20250214212647.GB233399@cmpxchg.org>
 <CA+i-1C3e_JUBBhMDYwrehvLZzLtb9pfgEy8=wQa=9uTBr1-b5g@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <CA+i-1C3e_JUBBhMDYwrehvLZzLtb9pfgEy8=wQa=9uTBr1-b5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 344C31F396
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:dkim,cmpxchg.org:email];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 2/17/25 17:26, Brendan Jackman wrote:
> On Fri, 14 Feb 2025 at 22:26, Johannes Weiner <hannes@cmpxchg.org> wrote:
>> >  2. can_steal_fallback() sounds as though it's answering the question "am
>> >     I functionally permitted to allocate from that other type" but in
>> >     fact it is encoding a heuristic preference.
>>
>> Here I don't see that nuance tbh.

I think I do.

>>
>> >  3. The same piece of data has different names in different places:
>> >     can_steal vs whole_block. This reinforces point 2 because it looks

I think some of the weirdness comes from the time before migratetype hygiene
series. IIRC it was possible to steal just the page we want to allocate,
that and extra pages but not the whole block, or whole block. Now it's
either just the page or whole block.

>> >     like the different names reflect a shift in intent from "am I
>> >     allowed to steal" to "do I want to steal", but no such shift exists.
>> >
>> > Fix 1. by avoiding the term "steal" in ambiguous contexts. This fixes
>> > 3. automatically since the natural name for can_steal is whole_block.
>>
>> I'm not a fan of whole_block because it loses the action verb. It
>> makes sense in the context of steal_suitable_fallback(), but becomes
>> ominous in find_suitable_fallback().
>>
>> Maybe @block_claimable would be better?

How about @claim_block ? That's even more "action verb" as the verb is not
passive.

> 
> Yeah that sounds good to me.
> 
>> > @@ -1948,7 +1948,7 @@ steal_suitable_fallback(struct zone *zone, struct page *page,
>> >       if (boost_watermark(zone) && (alloc_flags & ALLOC_KSWAPD))
>> >               set_bit(ZONE_BOOSTED_WATERMARK, &zone->flags);
>> >
>> > -     /* We are not allowed to try stealing from the whole block */
>> > +     /* No point in stealing from the whole block */
>>
>> The original comment actually makes more sense to me. Why is there no
>> point? It could well find enough free+alike pages to steal the
>> block... It's just not allowed to.
> 
> OK so this is basically point 2 from the commit message, maybe I don't
> really understand why this condition is here, and maybe I'm about to
> look stupid.
> 
> Why don't we allow this code to steal the whole block? There wouldn't
> be any functional bug if it did, right? I thought that !whole_block
> just meant "flipping that block would not have any real benefit from a
> fragmentation point of view". So we'd just be doing work and modifying
> data structures for no good reason. Is there some stronger reason I'm
> missing why we really _mustn't_ steal it?

Agreed with your view.

>> I will say, the current code is pretty hard to reason about:
>>
>> On one hand we check the block size statically in can_steal_fallback;
>> on the other hand, we do that majority scan for compatible pages in
>> steal_suitable_fallback(). The effective outcomes are hard to discern,
>> and I'm honestly not convinced they're all intentional.
>>
>> For example, if we're allowed to steal the block because of this in
>> can_steal_fallback():
>>
>>         order >= pageblock_order/2
>>
>> surely, we'll always satisfy this in steal_suitable_fallback()
>>
>>         free_pages + alike_pages >= (1 << (pageblock_order-1)
>>
>> on free_pages alone.
> 
> No, the former is half the _order_ the latter is half the _number of
> pages_. So e.g. we could have order=6 (assuming pageblock_order=10)
> then free_pages might be only 1<<6 which is less than 1<<9.
> 
> Anyway your underlying point that this is confusing is obviously correct!
> 
>> And if the order is less than half a block, we're only allowed an
>> attempt at stealing it if this is true in can_steal_fallback():
>>
>>         start_type == MIGRATE_RECLAIMABLE ||
>>         start_type == MIGRATE_UNMOVABLE
>>
>> So why is the majority scan in steal_suitable_fallback() checking:
>>
>>         if (start_type == MIGRATE_MOVABLE)
>>                 alike_pages = movable_pages
>>
>> Here is how I read the effective rules:
>>
>> - We always steal the block if at least half of it is free.
>>
>> - If less than half is free, but more than half is compatible (free +
>>   alike), we currently do movable -> non-movable conversions.
>>
>>   We don't do non-movable -> movable (won't get to the majority scan).
>>   This seems reasonable to me, as there seems to be little value in
>>   making a new pre-polluted movable block.
>>
>> - However, we do non-movable -> movable conversion if more than half
>>   is free. This is seemingly in conflict with the previous point.
> 
> Hmm I'm not sure I'm seeing the "conflict", I think you just have to
> word it differently it's like:
> 
> - For movable allocations, there's a threshold of the square root of
> the pageblock size (??) before we consider stealing.
> 
> - Otherwise, we steal the block if more than half is compatible.
> 
> - If this threshold prevents us from stealing the whole block, we find
> the page via the smallest-order freelist possible instead of largest.
> 
> Does that seem right to you?
> 
> It feels like that last point has something to do with: if we know in
> advance that we aren't gonna steal the whole block, we wanna avoid
> breaking down a high-order page. But, if the allocation is movable, we
> wouldn't create persistent fragmentation by doing that. So I'm
> realising now that I don't entirely understand this.

Aha! Looks like this is also a leftover from before migratetype hygiene
series that went unnoticed. The logic was, if we're making an unmovable
allocation stealing from a movable block, even if we don't claim the whole
block, at least steal the highest order available. Then more unmovable
allocations can be satisfied from what remains of the high-order split,
before we have to steal from another movable pageblock.

If we're making a movable allocation stealing from an unmovable pageblock,
we don't need to make this buffer, as polluting unmovable pageblocks with
movable allocations is not that bad - they can be compacted later. So we go
for the smallest order we need.

However IIUC this is all moot now. If we don't claim the whole pageblock,
and split a high-order page, the remains of the split will go to the
freelists of the migratetype of the unclaimed pageblock (i.e. movable),
previously (before migratetype hygiene) they would got to the freelists of
the migratetype we want to allocate (unmovable).

So now it makes no sense to want the highest order if we're not claiming the
whole pageblock, we're just causing more fragmentation for no good reason.
We should always do the find_smallest. It would be good to fix this.

>> Then there is compaction, which currently uses only the
>> find_suitable_fallback() subset of the rules. Namely, for kernel
>> allocations, compaction stops as soon as there is an adequately sized
>> fallback. Even if the allocator won't convert the block due to the
>> majority scan. For movable requests, we'll stop if there is half a
>> block to fall back to.
> 
> Not half a block, "square root" of a block. But yeah.
> 
>> I suppose that's reasonable - the old
>> utilization vs. fragmentation debate aside...
>>
>> Did I miss one?
>>
>> We should be able to encode all this more concisely.
>>
>> > @@ -1995,12 +1995,14 @@ steal_suitable_fallback(struct zone *zone, struct page *page,
>> >
>> >  /*
>> >   * Check whether there is a suitable fallback freepage with requested order.
>> > - * If only_stealable is true, this function returns fallback_mt only if
>> > - * we can steal other freepages all together. This would help to reduce
>> > + * Sets *whole_block to instruct the caller whether it should convert a whole
>> > + * pageblock to the returned migratetype.
>> > + * If need_whole_block is true, this function returns fallback_mt only if
>> > + * we would do this whole-block stealing. This would help to reduce
>> >   * fragmentation due to mixed migratetype pages in one pageblock.
>> >   */
>> >  int find_suitable_fallback(struct free_area *area, unsigned int order,
>> > -                     int migratetype, bool only_stealable, bool *can_steal)
>> > +                     int migratetype, bool need_whole_block, bool *whole_block)
>> >  {
>> >       int i;
>> >       int fallback_mt;
>> > @@ -2008,19 +2010,19 @@ int find_suitable_fallback(struct free_area *area, unsigned int order,
>> >       if (area->nr_free == 0)
>> >               return -1;
>> >
>> > -     *can_steal = false;
>> > +     *whole_block = false;
>> >       for (i = 0; i < MIGRATE_PCPTYPES - 1 ; i++) {
>> >               fallback_mt = fallbacks[migratetype][i];
>> >               if (free_area_empty(area, fallback_mt))
>> >                       continue;
>> >
>> > -             if (can_steal_fallback(order, migratetype))
>> > -                     *can_steal = true;
>> > +             if (should_steal_whole_block(order, migratetype))
>> > +                     *whole_block = true;
>> >
>> > -             if (!only_stealable)
>> > +             if (!need_whole_block)
>> >                       return fallback_mt;
>> >
>> > -             if (*can_steal)
>> > +             if (*whole_block)
>> >                       return fallback_mt;
>> >       }
>>
>> This loop is quite awkward, but I think it actually gets more awkward
>> with the new names.
>>
>> Consider this instead:
>>
>>                 *block_claimable = can_claim_block(order, migratetype);
>>                 if (*block_claimable || !need_whole_block)
>>                         return fallback_mt;
> 
> Yeah and even just combining the conditionals makes this much easier
> to follow IMO.
> 
>> Or better yet, inline that function completely. There are no other
>> callers, and consolidating the rules into fewer places would IMO go a
>> long way of making it easier to follow:
>>
>>                 if (order >= pageblock_order/2 ||
>>                     start_mt == MIGRATE_RECLAIMABLE ||
>>                     start_mt == MIGRATE_UNMOVABLE)
>>                         *block_claimable = true;
>>
>>                 if (*block_claimable || !need_whole_block)
>>                         return fallback_mt;
> 
> Sounds good. There might also be some clarity to be gained by fiddling
> around with the comments and polarity of conditions too.

Agreed.

Would it make sense to have only "bool *whole_block" parameter of
find_suitable_fallback? The value the caller initializes it, it means the
current need_whole_block, the value it has upon return it instructs the
caller what to do. It would mean __compact_finished() would no longer pass
an unused parameter.

> E.g. It's confusing that the comment above that first conditional
> talks about returning false for movable pages, but the conditional is
> about returning true for unmovable.
> 
> Anyway I will have a bit more of a think about this.


