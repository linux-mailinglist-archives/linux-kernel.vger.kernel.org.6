Return-Path: <linux-kernel+bounces-438251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FA59E9EF1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 20:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E2E21889C3E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 19:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88244194ACF;
	Mon,  9 Dec 2024 19:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mZksXDpq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WhpzAT25";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mZksXDpq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WhpzAT25"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9273B175D3A
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 19:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770870; cv=none; b=Z1+a21ZI2k2SI4qrfxZAnkMjmXkDqB7OixzYKCUTeckeeCtqNup1wGLO+1FROPraXzwIoJR2+4nVshOfCXNGw2d5ixDu+0TtQ8niA0+H3gZAl6DKsm7pSjVkf9oPdlH4DSYpYOl9QlhYobSC0Woua8UusdSBboM33LdnksdhpxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770870; c=relaxed/simple;
	bh=YeZnaPIykrfYgLhn9lXNHryfToimiIPiY95HiEQo5oY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KTegbNJ09tmtUm5OR8GojWHo4LLOypjJKEpVaPGWZx/IotKkmSck8oGuhbIH54Hr9h2spMgrOYFMOAhVdwD15xtMfY7UG4jorQ4HiXeOUxk1rQFbd3P9OXqafCZ5FDXTWc7lqKlhDOOqrhMZ5TZJya053JUFN3yaxghhYZWWyzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mZksXDpq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WhpzAT25; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mZksXDpq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WhpzAT25; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6E2081F365;
	Mon,  9 Dec 2024 19:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733770866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=F2bbcm5DB86puXOjFWb6HLU5pJ0V5N74gmVvyiWicoY=;
	b=mZksXDpqrkKhClMx7qzlS98rlfPWUqcyC8WLXdKO9Xruc1iof3WnkviY1JO/+f3PCqechV
	+pVG4F2BXCQy6hhZwu57u9E7Nbp5IwAs6OeIY21S1PQ3V9H8uWeib5erW4Y69XyGdOb7Zf
	4YgbX9Q88q6E219nYG0uRbrn4ellrKA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733770866;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=F2bbcm5DB86puXOjFWb6HLU5pJ0V5N74gmVvyiWicoY=;
	b=WhpzAT258wkP1its/RZrES2VUxHnwNFCyEkfzq03N7ZX3moZnHby8p6IO0bcVKndzhtGLP
	MSEHMSJn6vDpuRDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733770866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=F2bbcm5DB86puXOjFWb6HLU5pJ0V5N74gmVvyiWicoY=;
	b=mZksXDpqrkKhClMx7qzlS98rlfPWUqcyC8WLXdKO9Xruc1iof3WnkviY1JO/+f3PCqechV
	+pVG4F2BXCQy6hhZwu57u9E7Nbp5IwAs6OeIY21S1PQ3V9H8uWeib5erW4Y69XyGdOb7Zf
	4YgbX9Q88q6E219nYG0uRbrn4ellrKA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733770866;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=F2bbcm5DB86puXOjFWb6HLU5pJ0V5N74gmVvyiWicoY=;
	b=WhpzAT258wkP1its/RZrES2VUxHnwNFCyEkfzq03N7ZX3moZnHby8p6IO0bcVKndzhtGLP
	MSEHMSJn6vDpuRDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A958138A5;
	Mon,  9 Dec 2024 19:01:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 05qDFXI+V2dtVAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 09 Dec 2024 19:01:06 +0000
Message-ID: <e1a898ba-a717-4d20-9144-29df1a6c8813@suse.cz>
Date: Mon, 9 Dec 2024 20:01:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] mm/page_alloc: conditionally split >
 pageblock_order pages in free_one_page() and move_freepages_block_isolate()
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
 Johannes Weiner <hannes@cmpxchg.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Zi Yan <ziy@nvidia.com>, Yu Zhao <yuzhao@google.com>
References: <20241206095951.98007-1-david@redhat.com>
 <20241206095951.98007-2-david@redhat.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 xsFNBFZdmxYBEADsw/SiUSjB0dM+vSh95UkgcHjzEVBlby/Fg+g42O7LAEkCYXi/vvq31JTB
 KxRWDHX0R2tgpFDXHnzZcQywawu8eSq0LxzxFNYMvtB7sV1pxYwej2qx9B75qW2plBs+7+YB
 87tMFA+u+L4Z5xAzIimfLD5EKC56kJ1CsXlM8S/LHcmdD9Ctkn3trYDNnat0eoAcfPIP2OZ+
 9oe9IF/R28zmh0ifLXyJQQz5ofdj4bPf8ecEW0rhcqHfTD8k4yK0xxt3xW+6Exqp9n9bydiy
 tcSAw/TahjW6yrA+6JhSBv1v2tIm+itQc073zjSX8OFL51qQVzRFr7H2UQG33lw2QrvHRXqD
 Ot7ViKam7v0Ho9wEWiQOOZlHItOOXFphWb2yq3nzrKe45oWoSgkxKb97MVsQ+q2SYjJRBBH4
 8qKhphADYxkIP6yut/eaj9ImvRUZZRi0DTc8xfnvHGTjKbJzC2xpFcY0DQbZzuwsIZ8OPJCc
 LM4S7mT25NE5kUTG/TKQCk922vRdGVMoLA7dIQrgXnRXtyT61sg8PG4wcfOnuWf8577aXP1x
 6mzw3/jh3F+oSBHb/GcLC7mvWreJifUL2gEdssGfXhGWBo6zLS3qhgtwjay0Jl+kza1lo+Cv
 BB2T79D4WGdDuVa4eOrQ02TxqGN7G0Biz5ZLRSFzQSQwLn8fbwARAQABzSBWbGFzdGltaWwg
 QmFia2EgPHZiYWJrYUBzdXNlLmN6PsLBlAQTAQoAPgIbAwULCQgHAwUVCgkICwUWAgMBAAIe
 AQIXgBYhBKlA1DSZLC6OmRA9UCJPp+fMgqZkBQJkBREIBQkRadznAAoJECJPp+fMgqZkNxIQ
 ALZRqwdUGzqL2aeSavbum/VF/+td+nZfuH0xeWiO2w8mG0+nPd5j9ujYeHcUP1edE7uQrjOC
 Gs9sm8+W1xYnbClMJTsXiAV88D2btFUdU1mCXURAL9wWZ8Jsmz5ZH2V6AUszvNezsS/VIT87
 AmTtj31TLDGwdxaZTSYLwAOOOtyqafOEq+gJB30RxTRE3h3G1zpO7OM9K6ysLdAlwAGYWgJJ
 V4JqGsQ/lyEtxxFpUCjb5Pztp7cQxhlkil0oBYHkudiG8j1U3DG8iC6rnB4yJaLphKx57NuQ
 PIY0Bccg+r9gIQ4XeSK2PQhdXdy3UWBr913ZQ9AI2usid3s5vabo4iBvpJNFLgUmxFnr73SJ
 KsRh/2OBsg1XXF/wRQGBO9vRuJUAbnaIVcmGOUogdBVS9Sun/Sy4GNA++KtFZK95U7J417/J
 Hub2xV6Ehc7UGW6fIvIQmzJ3zaTEfuriU1P8ayfddrAgZb25JnOW7L1zdYL8rXiezOyYZ8Fm
 ZyXjzWdO0RpxcUEp6GsJr11Bc4F3aae9OZtwtLL/jxc7y6pUugB00PodgnQ6CMcfR/HjXlae
 h2VS3zl9+tQWHu6s1R58t5BuMS2FNA58wU/IazImc/ZQA+slDBfhRDGYlExjg19UXWe/gMcl
 De3P1kxYPgZdGE2eZpRLIbt+rYnqQKy8UxlszsBNBFsZNTUBCACfQfpSsWJZyi+SHoRdVyX5
 J6rI7okc4+b571a7RXD5UhS9dlVRVVAtrU9ANSLqPTQKGVxHrqD39XSw8hxK61pw8p90pg4G
 /N3iuWEvyt+t0SxDDkClnGsDyRhlUyEWYFEoBrrCizbmahOUwqkJbNMfzj5Y7n7OIJOxNRkB
 IBOjPdF26dMP69BwePQao1M8Acrrex9sAHYjQGyVmReRjVEtv9iG4DoTsnIR3amKVk6si4Ea
 X/mrapJqSCcBUVYUFH8M7bsm4CSxier5ofy8jTEa/CfvkqpKThTMCQPNZKY7hke5qEq1CBk2
 wxhX48ZrJEFf1v3NuV3OimgsF2odzieNABEBAAHCwXwEGAEKACYCGwwWIQSpQNQ0mSwujpkQ
 PVAiT6fnzIKmZAUCZAUSmwUJDK5EZgAKCRAiT6fnzIKmZOJGEACOKABgo9wJXsbWhGWYO7mD
 8R8mUyJHqbvaz+yTLnvRwfe/VwafFfDMx5GYVYzMY9TWpA8psFTKTUIIQmx2scYsRBUwm5VI
 EurRWKqENcDRjyo+ol59j0FViYysjQQeobXBDDE31t5SBg++veI6tXfpco/UiKEsDswL1WAr
 tEAZaruo7254TyH+gydURl2wJuzo/aZ7Y7PpqaODbYv727Dvm5eX64HCyyAH0s6sOCyGF5/p
 eIhrOn24oBf67KtdAN3H9JoFNUVTYJc1VJU3R1JtVdgwEdr+NEciEfYl0O19VpLE/PZxP4wX
 PWnhf5WjdoNI1Xec+RcJ5p/pSel0jnvBX8L2cmniYnmI883NhtGZsEWj++wyKiS4NranDFlA
 HdDM3b4lUth1pTtABKQ1YuTvehj7EfoWD3bv9kuGZGPrAeFNiHPdOT7DaXKeHpW9homgtBxj
 8aX/UkSvEGJKUEbFL9cVa5tzyialGkSiZJNkWgeHe+jEcfRT6pJZOJidSCdzvJpbdJmm+eED
 w9XOLH1IIWh7RURU7G1iOfEfmImFeC3cbbS73LQEFGe1urxvIH5K/7vX+FkNcr9ujwWuPE9b
 1C2o4i/yZPLXIVy387EjA6GZMqvQUFuSTs/GeBcv0NjIQi8867H3uLjz+mQy63fAitsDwLmR
 EP+ylKVEKb0Q2A==
In-Reply-To: <20241206095951.98007-2-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
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

On 12/6/24 10:59, David Hildenbrand wrote:
> Let's special-case for the common scenarios that:
> 
> (a) We are freeing pages <= pageblock_order
> (b) We are freeing a page <= MAX_PAGE_ORDER and all pageblocks match
>     (especially, no mixture of isolated and non-isolated pageblocks)

Well in many of those cases we could also just adjust the pageblocks... But
perhaps they indeed shouldn't differ in the first place, unless there's an
isolation attempt.

> When we encounter a > MAX_PAGE_ORDER page, it can only come from
> alloc_contig_range(), and we can process MAX_PAGE_ORDER chunks.
> 
> When we encounter a >pageblock_order <= MAX_PAGE_ORDER page,
> check whether all pageblocks match, and if so (common case), don't
> split them up just for the buddy to merge them back.
> 
> This makes sure that when we free MAX_PAGE_ORDER chunks to the buddy,
> for example during system startups, memory onlining, or when isolating
> consecutive pageblocks via alloc_contig_range()/memory offlining, that
> we don't unnecessarily split up what we'll immediately merge again,
> because the migratetypes match.
> 
> Rename split_large_buddy() to __free_one_page_maybe_split(), to make it
> clearer what's happening, and handle in it only natural buddy orders,
> not the alloc_contig_range(__GFP_COMP) special case: handle that in
> free_one_page() only.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz

Hm but noticed something:

> +static void __free_one_page_maybe_split(struct zone *zone, struct page *page,
> +		unsigned long pfn, int order, fpi_t fpi_flags)
> +{
> +	const unsigned long end_pfn = pfn + (1 << order);
> +	int mt = get_pfnblock_migratetype(page, pfn);
> +
> +	VM_WARN_ON_ONCE(order > MAX_PAGE_ORDER);
>  	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn, 1 << order));
>  	/* Caller removed page from freelist, buddy info cleared! */
>  	VM_WARN_ON_ONCE(PageBuddy(page));
>  
> -	if (order > pageblock_order)
> -		order = pageblock_order;
> -
> -	while (pfn != end) {
> -		int mt = get_pfnblock_migratetype(page, pfn);
> +	/*
> +	 * With CONFIG_MEMORY_ISOLATION, we might be freeing MAX_ORDER_NR_PAGES
> +	 * pages that cover pageblocks with different migratetypes; for example
> +	 * only some migratetypes might be MIGRATE_ISOLATE. In that (unlikely)
> +	 * case, fallback to freeing individual pageblocks so they get put
> +	 * onto the right lists.
> +	 */
> +	if (!IS_ENABLED(CONFIG_MEMORY_ISOLATION) ||
> +	    likely(order <= pageblock_order) ||
> +	    pfnblock_migratetype_equal(pfn + pageblock_nr_pages, end_pfn, mt)) {
> +		__free_one_page(page, pfn, zone, order, mt, fpi_flags);
> +		return;
> +	}
>  
> -		__free_one_page(page, pfn, zone, order, mt, fpi);
> -		pfn += 1 << order;
> +	while (pfn != end_pfn) {
> +		mt = get_pfnblock_migratetype(page, pfn);
> +		__free_one_page(page, pfn, zone, pageblock_order, mt, fpi_flags);
> +		pfn += pageblock_nr_pages;
>  		page = pfn_to_page(pfn);

This predates your patch, but seems potentially dangerous to attempt
pfn_to_page(end_pfn) with SPARSEMEM and no vmemmap and the end_pfn perhaps
being just outside of the valid range? Should we change that?

But seems this code was initially introduced as part of Johannes'
migratetype hygiene series.


