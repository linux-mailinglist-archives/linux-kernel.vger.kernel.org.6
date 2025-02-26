Return-Path: <linux-kernel+bounces-534200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7943AA4640E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76E0A7A37AA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8EB2222AB;
	Wed, 26 Feb 2025 15:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bYlvG+JB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cPsWv/Uf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bYlvG+JB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cPsWv/Uf"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83ADD194AF9
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 15:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740582393; cv=none; b=ewX0BdRzXHtvb2Hf7M4hYjt1zpZjqhMqidJ6FPSM4Ui86v//f8zr2JP1k/YipfU0+TqM6r+3R73piGhcl6zOtxFeFLpExQ3dynBQ78u44Lccn9zs6Vj+GmV2Q6IJxwdDA/yQROm5CdhfM+LaQW4nhr6w+ID158X7n9CqCRKiDiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740582393; c=relaxed/simple;
	bh=FMTgYR6+0rj0AeMRBsG4FmBPm5h6QoxPfbvWs3ptwbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CX/aNEXrMzCCqiyiAt2c4oyQ0wAift1iuNqmtQSTSpBRPu7vxegI3uMmRWgRziOehHBnygFLYLW3KZQv5RDE9e0TF5+sDCt6h01K3+2/BmgEMFz/2ObR0PfLwzn/qkw64iairxcc0/y2EA4diGEQ+1DfsGO8mxC4xz2qK0RzZa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bYlvG+JB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cPsWv/Uf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bYlvG+JB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cPsWv/Uf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 821631F38F;
	Wed, 26 Feb 2025 15:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740582389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jxm8Pr+FqnfY8/g+l47LAw1z03IBsuprmZ2kuOjhmlE=;
	b=bYlvG+JB/XoJDCzLp6IlQipEqh5LcQ7iVXu6/EwtfZ3EfQ7Yvk5IcUslX7prkSCrnc2/H7
	DO+AgUDEf1j9VP2fwkW9WIIO15ByrBaS5uBchyKqshXy766W2P5r8/uV/W7wCR6ScVePMa
	/v+fhWD1urCe+fwcdylOGNbnZ6ubz68=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740582389;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jxm8Pr+FqnfY8/g+l47LAw1z03IBsuprmZ2kuOjhmlE=;
	b=cPsWv/UfIzC6/1oQqGDH2PY8IjoHcvtkbeXps2cQmSd8UDKxyBVg62iG3i2R2nWxKvnZsi
	P2bOGucwMsHzwWBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740582389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jxm8Pr+FqnfY8/g+l47LAw1z03IBsuprmZ2kuOjhmlE=;
	b=bYlvG+JB/XoJDCzLp6IlQipEqh5LcQ7iVXu6/EwtfZ3EfQ7Yvk5IcUslX7prkSCrnc2/H7
	DO+AgUDEf1j9VP2fwkW9WIIO15ByrBaS5uBchyKqshXy766W2P5r8/uV/W7wCR6ScVePMa
	/v+fhWD1urCe+fwcdylOGNbnZ6ubz68=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740582389;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jxm8Pr+FqnfY8/g+l47LAw1z03IBsuprmZ2kuOjhmlE=;
	b=cPsWv/UfIzC6/1oQqGDH2PY8IjoHcvtkbeXps2cQmSd8UDKxyBVg62iG3i2R2nWxKvnZsi
	P2bOGucwMsHzwWBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D9871377F;
	Wed, 26 Feb 2025 15:06:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id j4IrGvUtv2dAUgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 26 Feb 2025 15:06:29 +0000
Message-ID: <dae2179c-1562-447c-a4fc-d415b4a9ebfc@suse.cz>
Date: Wed, 26 Feb 2025 16:08:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] mm/page_alloc: Clarify terminology in migratetype
 fallback code
To: Brendan Jackman <jackmanb@google.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Mel Gorman <mgorman@techsingularity.net>, Michal Hocko
 <mhocko@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Yosry Ahmed <yosry.ahmed@linux.dev>
References: <20250225-clarify-steal-v3-0-f2550ead0139@google.com>
 <20250225-clarify-steal-v3-1-f2550ead0139@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
Content-Language: en-US
In-Reply-To: <20250225-clarify-steal-v3-1-f2550ead0139@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On 2/25/25 4:29 PM, Brendan Jackman wrote:
> This code is rather confusing because:
> 
>  1. "Steal" is sometimes used to refer to the general concept of
>     allocating from a from a block of a fallback migratetype
>     (steal_suitable_fallback()) but sometimes it refers specifically to
>     converting a whole block's migratetype (can_steal_fallback()).
> 
>  2. can_steal_fallback() sounds as though it's answering the question "am
>     I functionally permitted to allocate from that other type" but in
>     fact it is encoding a heuristic preference.
> 
>  3. The same piece of data has different names in different places:
>     can_steal vs whole_block. This reinforces point 2 because it looks
>     like the different names reflect a shift in intent from "am I
>     allowed to steal" to "do I want to steal", but no such shift exists.
> 
> Fix 1. by avoiding the term "steal" in ambiguous contexts. Start using
> the term "claim" to refer to the special case of stealing the entire
> block.
> 
> Fix 2. by using "should" instead of "can", and also rename its
> parameters and add some commentary to make it more explicit what they
> mean.
> 
> Fix 3. by adopting the new "claim" terminology universally for this
> set of variables.
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Some nits:

> ---
>  mm/compaction.c |  4 ++--
>  mm/internal.h   |  2 +-
>  mm/page_alloc.c | 72 ++++++++++++++++++++++++++++-----------------------------
>  3 files changed, 39 insertions(+), 39 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 0992106d4ea751f7f1f8ebf7c75cd433d676cbe0..550ce50218075509ccb5f9485fd84f5d1f3d23a7 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -2333,7 +2333,7 @@ static enum compact_result __compact_finished(struct compact_control *cc)
>  	ret = COMPACT_NO_SUITABLE_PAGE;
>  	for (order = cc->order; order < NR_PAGE_ORDERS; order++) {
>  		struct free_area *area = &cc->zone->free_area[order];
> -		bool can_steal;
> +		bool claim_block;
>  
>  		/* Job done if page is free of the right migratetype */
>  		if (!free_area_empty(area, migratetype))
> @@ -2350,7 +2350,7 @@ static enum compact_result __compact_finished(struct compact_control *cc)
>  		 * other migratetype buddy lists.
>  		 */
>  		if (find_suitable_fallback(area, order, migratetype,
> -						true, &can_steal) != -1)
> +						true, &claim_block) != -1)
>  			/*
>  			 * Movable pages are OK in any pageblock. If we are
>  			 * stealing for a non-movable allocation, make sure
> diff --git a/mm/internal.h b/mm/internal.h
> index b07550db2bfd1d152fa90f91b3687b0fa1a9f653..aa30282a774ae26349944a75da854ae6a3da2a98 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -863,7 +863,7 @@ static inline void init_cma_pageblock(struct page *page)
>  
>  
>  int find_suitable_fallback(struct free_area *area, unsigned int order,
> -			int migratetype, bool only_stealable, bool *can_steal);
> +			int migratetype, bool claim_only, bool *claim_block);
>  
>  static inline bool free_area_empty(struct free_area *area, int migratetype)
>  {
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 5d8e274c8b1d500d263a17ef36fe190f60b88196..5e694046ef92965b34d4831e96d92f02681a8b45 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1942,22 +1942,22 @@ static inline bool boost_watermark(struct zone *zone)
>  
>  /*
>   * When we are falling back to another migratetype during allocation, try to
> - * steal extra free pages from the same pageblocks to satisfy further
> - * allocations, instead of polluting multiple pageblocks.
> + * claim entire blocks to satisfy further allocations, instead of polluting
> + * multiple pageblocks.
>   *
> - * If we are stealing a relatively large buddy page, it is likely there will
> - * be more free pages in the pageblock, so try to steal them all. For
> - * reclaimable and unmovable allocations, we steal regardless of page size,
> - * as fragmentation caused by those allocations polluting movable pageblocks
> - * is worse than movable allocations stealing from unmovable and reclaimable
> - * pageblocks.
> + * If we are stealing a relatively large buddy page, it is likely there will be
> + * more free pages in the pageblock, so try to claim the whole block. For
> + * reclaimable and unmovable allocations, we claim the whole block regardless of

It's also "try to claim" here as it may still fail due to not enough
free/compatible pages even for those migratetypes. Maybe the question
(out of scope of the patch) if they should get a lower threshold than
half. Before migratetype hygiene, the "we steal regardless" meant that
we really would steal all free pages even if not claiming the pageblock.

> + * page size, as fragmentation caused by those allocations polluting movable
> + * pageblocks is worse than movable allocations stealing from unmovable and
> + * reclaimable pageblocks.
>   */
> -static bool can_steal_fallback(unsigned int order, int start_mt)
> +static bool should_claim_block(unsigned int order, int start_mt)

So technically it's should_try_claim_block() if we want to be precise
(but longer).

>  {
>  	/*
>  	 * Leaving this order check is intended, although there is
>  	 * relaxed order check in next check. The reason is that
> -	 * we can actually steal whole pageblock if this condition met,
> +	 * we can actually claim the whole pageblock if this condition met,

try claiming

>  	 * but, below check doesn't guarantee it and that is just heuristic
>  	 * so could be changed anytime.
>  	 */
> @@ -1970,7 +1970,7 @@ static bool can_steal_fallback(unsigned int order, int start_mt)
>  	 * reclaimable pages that are closest to the request size.  After a
>  	 * while, memory compaction may occur to form large contiguous pages,
>  	 * and the next movable allocation may not need to steal.  Unmovable and
> -	 * reclaimable allocations need to actually steal pages.
> +	 * reclaimable allocations need to actually claim the whole block.

also

>  	 */
>  	if (order >= pageblock_order / 2 ||
>  		start_mt == MIGRATE_RECLAIMABLE ||

