Return-Path: <linux-kernel+bounces-538127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC7AA494DC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88EB43B8EE6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A395255E3E;
	Fri, 28 Feb 2025 09:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ytSxtFsB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="R5XThv1m";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ytSxtFsB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="R5XThv1m"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C14F256C88
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 09:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740734731; cv=none; b=To2JnszUSAvSxf5AGL6t2aQgEyoomNebWRmAr6ZP5zHp28ci4YsDRky02VuD0Ch9geHhpqpz2xdkCIuCpTCTY0IvU1BOt1Vr+A5P6eajX714Wi0RPKSjzD8gBHJpRRmpx14wctc6OYHszArd6bzYlUDsK1OzdNBYgV9Bx4QgvkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740734731; c=relaxed/simple;
	bh=yzn1yAtNyBK+oQtGjZYJoI4L8wSq97LshLpEXtnMNos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rwOp0AwbBgB+7/Q7kzECJrmG8hPU/SHa3M1fSeN6nTxxFxg5T1VyIZSUqv3z38toXaQaADt6bly7AzLZDGxWMuQNqYEOFwUhgjvbzYLRjWzWWtgg/ZtmRw1II5EFhD2JB0xIIUshXhRdIUnoaEAtYPkEDTEldcRdv7xMQO+2pwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ytSxtFsB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=R5XThv1m; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ytSxtFsB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=R5XThv1m; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A97381F38F;
	Fri, 28 Feb 2025 09:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740734727; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=v3vg/ZVXsH9q9PXkYDg8nzS9VLr/G0V+K4n/dtpGT2s=;
	b=ytSxtFsBNLANRvRDwkef8tgIx7uT/AZ6ABvyOfmL2magd5flbW3vrYE0q32IP3L2nzuKa1
	UAHxaJjxKuGaqpJ7CiYWCFcB+++1CK2uSz10IGLPAIstqmDYyG2elODH+LO4xsv1GiMeSX
	+W6F6MZTZw532BH3dA7JGCrRRlWKh6A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740734727;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=v3vg/ZVXsH9q9PXkYDg8nzS9VLr/G0V+K4n/dtpGT2s=;
	b=R5XThv1makNXpPlXd2lghqF2Pu+aqVQ4555gKopRwumyReTioId/WucjZcDAENUUNRrWqy
	1jzcAM8sLTA3gvDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740734727; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=v3vg/ZVXsH9q9PXkYDg8nzS9VLr/G0V+K4n/dtpGT2s=;
	b=ytSxtFsBNLANRvRDwkef8tgIx7uT/AZ6ABvyOfmL2magd5flbW3vrYE0q32IP3L2nzuKa1
	UAHxaJjxKuGaqpJ7CiYWCFcB+++1CK2uSz10IGLPAIstqmDYyG2elODH+LO4xsv1GiMeSX
	+W6F6MZTZw532BH3dA7JGCrRRlWKh6A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740734727;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=v3vg/ZVXsH9q9PXkYDg8nzS9VLr/G0V+K4n/dtpGT2s=;
	b=R5XThv1makNXpPlXd2lghqF2Pu+aqVQ4555gKopRwumyReTioId/WucjZcDAENUUNRrWqy
	1jzcAM8sLTA3gvDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B986137AC;
	Fri, 28 Feb 2025 09:25:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KQc5IAeBwWc7TQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 28 Feb 2025 09:25:27 +0000
Message-ID: <bc14db89-378c-466e-935a-1b5d38264bb7@suse.cz>
Date: Fri, 28 Feb 2025 10:25:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] mm/page_alloc: Clarify terminology in migratetype
 fallback code
To: Brendan Jackman <jackmanb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Mel Gorman <mgorman@techsingularity.net>, Michal Hocko <mhocko@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Yosry Ahmed <yosry.ahmed@linux.dev>
References: <20250225-clarify-steal-v3-0-f2550ead0139@google.com>
 <20250225-clarify-steal-v3-1-f2550ead0139@google.com>
 <dae2179c-1562-447c-a4fc-d415b4a9ebfc@suse.cz> <Z8A6v2V8l8c4VaSA@google.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <Z8A6v2V8l8c4VaSA@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 2/27/25 11:13, Brendan Jackman wrote:
> On Wed, Feb 26, 2025 at 04:08:09PM +0100, Vlastimil Babka wrote:
>> On 2/25/25 4:29 PM, Brendan Jackman wrote:
>> >  /*
>> >   * When we are falling back to another migratetype during allocation, try to
>> > - * steal extra free pages from the same pageblocks to satisfy further
>> > - * allocations, instead of polluting multiple pageblocks.
>> > + * claim entire blocks to satisfy further allocations, instead of polluting
>> > + * multiple pageblocks.
>> >   *
>> > - * If we are stealing a relatively large buddy page, it is likely there will
>> > - * be more free pages in the pageblock, so try to steal them all. For
>> > - * reclaimable and unmovable allocations, we steal regardless of page size,
>> > - * as fragmentation caused by those allocations polluting movable pageblocks
>> > - * is worse than movable allocations stealing from unmovable and reclaimable
>> > - * pageblocks.
>> > + * If we are stealing a relatively large buddy page, it is likely there will be
>> > + * more free pages in the pageblock, so try to claim the whole block. For
>> > + * reclaimable and unmovable allocations, we claim the whole block regardless of
>> 
>> It's also "try to claim" here as it may still fail due to not enough
>> free/compatible pages even for those migratetypes. 
> 
> Yeah thanks, I seems worthwhile to be precise about this.
> 
>> Maybe the question
>> (out of scope of the patch) if they should get a lower threshold than
>> half. Before migratetype hygiene, the "we steal regardless" meant that
>> we really would steal all free pages even if not claiming the pageblock.
> 
> I wonder if there's some benefit to deciding when to claim blocks also
> based on the count of blocks per type or something? Like, if we're
> under memory pressure so all the freelists are empty, but there are
> already a bunch of unmovable blocks (that currently have movable pages
> in them), there's not much point in claiming a block, instead we'd
> prefer to reclaim/migrate those movable pages?

Hm we don't currently have counters for that, do we? But that would be the
feasible part. "that currently have movable pages in them" would be
expensive to determine, and an attempt to reclaim/migrate would be expensive
too. At best we could try kicking some asynchronous attempt I think.

>> > + * page size, as fragmentation caused by those allocations polluting movable
>> > + * pageblocks is worse than movable allocations stealing from unmovable and
>> > + * reclaimable pageblocks.
>> >   */
>> > -static bool can_steal_fallback(unsigned int order, int start_mt)
>> > +static bool should_claim_block(unsigned int order, int start_mt)
>> 
>> So technically it's should_try_claim_block() if we want to be precise
>> (but longer).
> 
> Yep, that seems worth it (especially given the function is effectively
> just an internal block of find_suitable_fallback()).
> 
>> >  {
>> >  	/*
>> >  	 * Leaving this order check is intended, although there is
>> >  	 * relaxed order check in next check. The reason is that
>> > -	 * we can actually steal whole pageblock if this condition met,
>> > +	 * we can actually claim the whole pageblock if this condition met,
>> 
>> try claiming
> 
> But I think in this case we really do claim unconditionally.

Ah right, thanks.

