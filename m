Return-Path: <linux-kernel+bounces-307181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DE2964993
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 17:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B113C282472
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 15:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447271B14E1;
	Thu, 29 Aug 2024 15:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NyUniX/6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="E2OkLvnR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Btb24Aa0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ycuSFCeq"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4951F1B29AD
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 15:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724944380; cv=none; b=NL8g/eHDoYi7Shz110msTKm0Hg4sVQBs7MqcbgYQlVVFEhDzdlVFwoVeSz1D1GAiqef8lZA4ReAuM0jPIDiwf0uLfq9AF7kIwu7cUS2hkdEPe9a1oyYnvfx0gFHFSo8uykRi1RTQBEIgQnGtkezqtodkxqvbYewc/t3zI2yZUSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724944380; c=relaxed/simple;
	bh=V5DowjvluDsybV56nm4GswMY3heyW43h6csNO5UfwFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YFrfXCIKA8dVlwZsmkrVRwr2YTuTNatwfBf3sjQQ6/5tatVvLaS4MvkEgtuW7q5Jco1m2lzaFZZ9U43/PoC41eYXkuhETPt1oKXq2PN+uPdQoDQki1vOli7Y4KWtDylrH6vqWaYit5dup2ZFOvgtDWv8Sz+iIl/cciwyz2otbr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NyUniX/6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=E2OkLvnR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Btb24Aa0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ycuSFCeq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 519F51F388;
	Thu, 29 Aug 2024 15:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724944376; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6X9/eYh1crDGihSaZn++G44iewqHQux0aaLHTtIqBFQ=;
	b=NyUniX/6q0ePaNyCxEY0ZLSJPuF55Fur70HhQs3EbnSBHsOihQ0/3PsP5zQBVVL2vsdVuL
	7aAGICCvA4SI9G2kx9hgXqt3U5mLZjdu9tf3uDDWgBkWLTR26seJWT808wZyWP9Dy12pUn
	iFGV1vd6Y9288IFPXAWePA1A9Qaenrc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724944376;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6X9/eYh1crDGihSaZn++G44iewqHQux0aaLHTtIqBFQ=;
	b=E2OkLvnRz3UWOWTEb44zqmUNk3M24DKBXUQpYdfJ5c5IrzEqY8Zng2affYN/+yre0ioSuq
	s2L0DzQnR/3zdyDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724944375; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6X9/eYh1crDGihSaZn++G44iewqHQux0aaLHTtIqBFQ=;
	b=Btb24Aa09NfcjQQfW82qIMZJLjx8/HZUdOXbvpXrwu7hWVWgnno/5vCMTtKOK+Y9/uRZPH
	2irEG0TD3xjWhlErsLpo3ryqlRXXZ5J5UQQq055kZvITojuGRFElhe19sGMbmnhTPGCQuc
	WePK20OyZ9MQt+y0pNdHXPLH9NuGI3U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724944375;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6X9/eYh1crDGihSaZn++G44iewqHQux0aaLHTtIqBFQ=;
	b=ycuSFCeqU5ELl2uEbYtGsAqoNyaKIrkSr0Nx2xrm2LsFZWUkE/1RzEArOhRn4tKkqCih4b
	hz5pwK+kB616i/Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 41D70139B0;
	Thu, 29 Aug 2024 15:12:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vHWfD/eP0GbyYwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 29 Aug 2024 15:12:55 +0000
Message-ID: <e3276bb1-6d70-41c8-9d04-c7eade3dae95@suse.cz>
Date: Thu, 29 Aug 2024 17:12:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: page_alloc: simpify page del and expand
Content-Language: en-US
To: Huan Yang <link@vivo.com>, Andrew Morton <akpm@linux-foundation.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
References: <20240826064048.187790-1-link@vivo.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240826064048.187790-1-link@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vivo.com:email,suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 8/26/24 08:40, Huan Yang wrote:
> When page del from buddy and need expand, it will account free_pages
> in zone's migratetype.
> 
> The current way is to subtract the page number of the current order
> when deleting, and then add it back when expanding.
> 
> This is unnecessary, as when migrating the same type, we can directly
> record the difference between the high-order pages and the expand
> added, and then subtract it directly.
> 
> This patch merge that, only when del and expand done, then account
> free_pages.
> 
> Signed-off-by: Huan Yang <link@vivo.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

can't hurt to reduce the number of calls to __mod_zone_page_state() (via
account_freepages()) in the allocator

> ---
>  mm/page_alloc.c | 35 +++++++++++++++++++++++++----------
>  1 file changed, 25 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 023132f66d29..900b0947c6e1 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1363,11 +1363,11 @@ struct page *__pageblock_pfn_to_page(unsigned long start_pfn,
>   *
>   * -- nyc
>   */
> -static inline void expand(struct zone *zone, struct page *page,
> -	int low, int high, int migratetype)
> +static inline unsigned int expand(struct zone *zone, struct page *page, int low,
> +				  int high, int migratetype)
>  {
> -	unsigned long size = 1 << high;
> -	unsigned long nr_added = 0;
> +	unsigned int size = 1 << high;
> +	unsigned int nr_added = 0;
>  
>  	while (high > low) {
>  		high--;
> @@ -1387,7 +1387,19 @@ static inline void expand(struct zone *zone, struct page *page,
>  		set_buddy_order(&page[size], high);
>  		nr_added += size;
>  	}
> -	account_freepages(zone, nr_added, migratetype);
> +
> +	return nr_added;
> +}
> +
> +static __always_inline void page_del_and_expand(struct zone *zone,
> +						struct page *page, int low,
> +						int high, int migratetype)
> +{
> +	int nr_pages = 1 << high;
> +
> +	__del_page_from_free_list(page, zone, high, migratetype);
> +	nr_pages -= expand(zone, page, low, high, migratetype);
> +	account_freepages(zone, -nr_pages, migratetype);
>  }
>  
>  static void check_new_page_bad(struct page *page)
> @@ -1557,8 +1569,9 @@ struct page *__rmqueue_smallest(struct zone *zone, unsigned int order,
>  		page = get_page_from_free_area(area, migratetype);
>  		if (!page)
>  			continue;
> -		del_page_from_free_list(page, zone, current_order, migratetype);
> -		expand(zone, page, order, current_order, migratetype);
> +
> +		page_del_and_expand(zone, page, order, current_order,
> +				    migratetype);
>  		trace_mm_page_alloc_zone_locked(page, order, migratetype,
>  				pcp_allowed_order(order) &&
>  				migratetype < MIGRATE_PCPTYPES);
> @@ -1888,9 +1901,12 @@ steal_suitable_fallback(struct zone *zone, struct page *page,
>  
>  	/* Take ownership for orders >= pageblock_order */
>  	if (current_order >= pageblock_order) {
> +		unsigned int nr_added;
> +
>  		del_page_from_free_list(page, zone, current_order, block_type);
>  		change_pageblock_range(page, current_order, start_type);
> -		expand(zone, page, order, current_order, start_type);
> +		nr_added = expand(zone, page, order, current_order, start_type);
> +		account_freepages(zone, nr_added, start_type);
>  		return page;
>  	}
>  
> @@ -1943,8 +1959,7 @@ steal_suitable_fallback(struct zone *zone, struct page *page,
>  	}
>  
>  single_page:
> -	del_page_from_free_list(page, zone, current_order, block_type);
> -	expand(zone, page, order, current_order, block_type);
> +	page_del_and_expand(zone, page, order, current_order, block_type);
>  	return page;
>  }
>  


