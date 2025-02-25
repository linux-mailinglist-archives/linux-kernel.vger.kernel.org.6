Return-Path: <linux-kernel+bounces-531636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C65A442F0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11D143BF985
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6C126FA64;
	Tue, 25 Feb 2025 14:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tc+0kEdC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="E64UIUET";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tc+0kEdC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="E64UIUET"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0366326BD87
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 14:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740494130; cv=none; b=r1NiOBZA1kv0Uz5afUt7jUr0Pc/sovA18X7TUG8w8MJYOgaleNulCT2U18+WKfFwHNHl2n0kUR+s0lPwrXaeCy2lQ5X7yp+yn7j99MnQEXnLRTtv3RJyC8RtDwVIz7w9oxTx36HhmBr+5AuiW9iyATd3f6O76SklnQkL6+jeyu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740494130; c=relaxed/simple;
	bh=TTDAsTPMfrBGF+4mWa5HuTJB6Vlk5OKK+GN5svz3QXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gqFYdPtG2F9fGrTIan3SYLGCjFUQWZDFEsxhMqsODAiGeIP/JP1h+aV4o2d5F0Dg20fbVcOSAYJHSanXxqakQg5Rr3Q5t0Ow0D5IrmR87Ah7CJQfmAIZcQIvjnj54uOMNw32561JcVcxqt0CnOyu89qNO/g/L/0cxChVj8DnqkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tc+0kEdC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=E64UIUET; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tc+0kEdC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=E64UIUET; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2928F21170;
	Tue, 25 Feb 2025 14:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740494126; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=g948sWdBhGFc6lvbZcYWo/e847khBaVEBSceIS7zpcQ=;
	b=tc+0kEdCVtJyqPi2vjzQS4r94khL14ziHyHDLwf/lXvu9/1xSQyHmIhUJT1MbRBlqIqBDf
	ntkr3jOuJR6jGed9g9J38MOBfIE3aMGFEYoSLE83SSBeOMUMqMgKZAB3QP/FdYS1O2x/XD
	Hc47hi3O8rTk80GlyGa1IBpQ+VJGWEI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740494126;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=g948sWdBhGFc6lvbZcYWo/e847khBaVEBSceIS7zpcQ=;
	b=E64UIUETgpZ5QMJkD5gnn29EwRrcoJiRyQGnvWGHM+AQZcr2H9DHTlXOhR4BjpnFBTttGB
	AJ/0aM+OpEte9SBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740494126; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=g948sWdBhGFc6lvbZcYWo/e847khBaVEBSceIS7zpcQ=;
	b=tc+0kEdCVtJyqPi2vjzQS4r94khL14ziHyHDLwf/lXvu9/1xSQyHmIhUJT1MbRBlqIqBDf
	ntkr3jOuJR6jGed9g9J38MOBfIE3aMGFEYoSLE83SSBeOMUMqMgKZAB3QP/FdYS1O2x/XD
	Hc47hi3O8rTk80GlyGa1IBpQ+VJGWEI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740494126;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=g948sWdBhGFc6lvbZcYWo/e847khBaVEBSceIS7zpcQ=;
	b=E64UIUETgpZ5QMJkD5gnn29EwRrcoJiRyQGnvWGHM+AQZcr2H9DHTlXOhR4BjpnFBTttGB
	AJ/0aM+OpEte9SBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A50213888;
	Tue, 25 Feb 2025 14:35:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WSb7BS7VvWdTFgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 25 Feb 2025 14:35:26 +0000
Message-ID: <f44b7e1a-02d1-4cda-8b0e-e748f96e92bd@suse.cz>
Date: Tue, 25 Feb 2025 15:35:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mm: page_alloc: don't steal single pages from biggest
 buddy
Content-Language: en-US
To: Brendan Jackman <jackmanb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250225001023.1494422-1-hannes@cmpxchg.org>
 <20250225001023.1494422-2-hannes@cmpxchg.org> <Z73G6A6asz_KrGTo@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <Z73G6A6asz_KrGTo@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.994];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On 2/25/25 14:34, Brendan Jackman wrote:
> On Mon, Feb 23, 2025 at 07:08:24PM -0500, Johannes Weiner wrote:
>> The fallback code searches for the biggest buddy first in an attempt
>> to steal the whole block and encourage type grouping down the line.
>> 
>> The approach used to be this:
>> 
>> - Non-movable requests will split the largest buddy and steal the
>>   remainder. This splits up contiguity, but it allows subsequent
>>   requests of this type to fall back into adjacent space.
>> 
>> - Movable requests go and look for the smallest buddy instead. The
>>   thinking is that movable requests can be compacted, so grouping is
>>   less important than retaining contiguity.
>> 
>> c0cd6f557b90 ("mm: page_alloc: fix freelist movement during block
>> conversion") enforces freelist type hygiene, which restricts stealing
>> to either claiming the whole block or just taking the requested chunk;
>> no additional pages or buddy remainders can be stolen any more.
>> 
>> The patch mishandled when to switch to finding the smallest buddy in
>> that new reality. As a result, it may steal the exact request size,
>> but from the biggest buddy. This causes fracturing for no good reason.
>> 
>> Fix this by committing to the new behavior: either steal the whole
>> block, or fall back to the smallest buddy.
>> 
>> Remove single-page stealing from steal_suitable_fallback(). Rename it
>> to try_to_steal_block() to make the intentions clear. If this fails,
>> always fall back to the smallest buddy.
> 
> Nit - I think the try_to_steal_block() changes could be a separate
> patch, the history might be easier to understand if it went:
> 
> [1/N] mm: page_alloc: don't steal single pages from biggest buddy
> [2/N] mm: page_alloc: drop unused logic in steal_suitable_fallback()
> 
> (But not a big deal, it's not that hard to follow as-is).
> 
>>  static __always_inline struct page *
>>  __rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
>> @@ -2291,45 +2289,35 @@ __rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
>>  		if (fallback_mt == -1)
>>  			continue;
>>  
>> -		/*
>> -		 * We cannot steal all free pages from the pageblock and the
>> -		 * requested migratetype is movable. In that case it's better to
>> -		 * steal and split the smallest available page instead of the
>> -		 * largest available page, because even if the next movable
>> -		 * allocation falls back into a different pageblock than this
>> -		 * one, it won't cause permanent fragmentation.
>> -		 */
>> -		if (!can_steal && start_migratetype == MIGRATE_MOVABLE
>> -					&& current_order > order)
>> -			goto find_smallest;
>> +		if (!can_steal)
>> +			break;
>>  
>> -		goto do_steal;
>> +		page = get_page_from_free_area(area, fallback_mt);
>> +		page = try_to_steal_block(zone, page, current_order, order,
>> +					  start_migratetype, alloc_flags);
>> +		if (page)
>> +			goto got_one;
>>  	}
>>  
>> -	return NULL;
>> +	if (alloc_flags & ALLOC_NOFRAGMENT)
>> +		return NULL;
> 
> Is this a separate change? Is it a bug that we currently allow
> stealing a from a fallback type when ALLOC_NOFRAGMENT? (I wonder if
> the second loop was supposed to start from min_order).

It's subtle but not a new condition. Previously ALLOC_NOFRAGMENT would
result in not taking the "goto find_smallest" path because it means
searching >=pageblock_order only and that would always be can_steal == true
if it found a fallback. And failure to find fallback would reach an
unconditional return NULL here. Now we fall through the search below
(instead of the goto), but ALLOC_NOFRAGMENT must not do it so it's now
explicit here.

>>  
>> -find_smallest:
>> +	/* No luck stealing blocks. Find the smallest fallback page */
>>  	for (current_order = order; current_order < NR_PAGE_ORDERS; current_order++) {
>>  		area = &(zone->free_area[current_order]);
>>  		fallback_mt = find_suitable_fallback(area, current_order,
>>  				start_migratetype, false, &can_steal);
>> -		if (fallback_mt != -1)
>> -			break;
>> -	}
>> -
>> -	/*
>> -	 * This should not happen - we already found a suitable fallback
>> -	 * when looking for the largest page.
>> -	 */
>> -	VM_BUG_ON(current_order > MAX_PAGE_ORDER);
>> +		if (fallback_mt == -1)
>> +			continue;
>>  
>> -do_steal:
>> -	page = get_page_from_free_area(area, fallback_mt);
>> +		page = get_page_from_free_area(area, fallback_mt);
>> +		page_del_and_expand(zone, page, order, current_order, fallback_mt);
>> +		goto got_one;
>> +	}
>>  
>> -	/* take off list, maybe claim block, expand remainder */
>> -	page = steal_suitable_fallback(zone, page, current_order, order,
>> -				       start_migratetype, alloc_flags, can_steal);
>> +	return NULL;
>>  
>> +got_one:
>>  	trace_mm_page_alloc_extfrag(page, order, current_order,
>>  		start_migratetype, fallback_mt);


