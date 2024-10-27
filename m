Return-Path: <linux-kernel+bounces-383766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E179B1FF9
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 20:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B0E71F21435
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 19:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A7017C217;
	Sun, 27 Oct 2024 19:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LtOIZllZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="M5lcvgug";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LzfmjFqz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BwS1+KVS"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF293286A1
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 19:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730058835; cv=none; b=mswK2NkYNt/1u5eQLbbHvkeQ/SeDJ8riuCGVymBfyIN6oafG2Wk5XnHRHxQzg1kR+0OE/wARNWAhIBFi5k53ockaV3HI/N+zMqlEXvByjXcciosWvvUgsoyLeqvw1qac1fxyKL4+bz7RE81/di/TsYmhW2ZZ1nmqhXoZVUPdSlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730058835; c=relaxed/simple;
	bh=xxFRGAZ9KC6ReRl5w5Ukfvy+It9RezpVBO2ote2fYPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k3BXd2RyaOKEMxNtCsU7WDKIbQMsbMaCQt9kBNV5Z+WMHlxMG+aMd/M95FKgE6yB2bNjPJ/RejDOW56Fs9f31MwUb2gJsh5v+zVoCESPa4WfLimrSEF/eGvjzXUCH2PVuBTVVlbRLBgLPD9ntqwGbw4CN5jXu5ZxHyGajSxl8Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LtOIZllZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=M5lcvgug; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LzfmjFqz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BwS1+KVS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CCB9E21A51;
	Sun, 27 Oct 2024 19:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730058831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6bZuodg/oCtNJ35krij6ExljtD5sewptVTl9Za/LKIY=;
	b=LtOIZllZFd/FHQqsT8QIuMgcwFlQPNjkCqixbgsqOQ20jwz+xXlyWOhZpn7lUwlvuWjvlm
	T22T2P83teA7Rm85c8KAaiMIXiUdQTRXC5OMlXEGhbMHrB1ee0AGgOgP65U0REzlFzYIOv
	KFw5jjjxwudOyGh1PZgRBFimDvpKgUs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730058831;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6bZuodg/oCtNJ35krij6ExljtD5sewptVTl9Za/LKIY=;
	b=M5lcvgugJAWDlWHaevWyVjTTpgDHDxTO9F8yRsTsoXv+uNEmtWdoy7cvfZe8zJTMqASPiX
	id8bhbaSkwb5XNBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=LzfmjFqz;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=BwS1+KVS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730058830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6bZuodg/oCtNJ35krij6ExljtD5sewptVTl9Za/LKIY=;
	b=LzfmjFqz5ZjzLSxuYXJsXbuN/+Cw5ZhDK1eT0zRLrBpvaqjYTlcdrzlPu+r8MKVvQT/NJg
	b4IE0wwmR2q82X3Y4G9a9PDiejVVVR6AzQL8Km5GKfK3BF+iJY25xRQdXNDmXv+AtqnLpp
	f3li4QlvOf5nH/L062J+wE/3HdA7Ogc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730058830;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6bZuodg/oCtNJ35krij6ExljtD5sewptVTl9Za/LKIY=;
	b=BwS1+KVSDpu9/QyE1R5/X6/NMM1KJYTsU8T2EaUtqCgabAT2JXrW09IUXAEp+LasNriKEU
	iTrNdsOdILoE4cDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF56C136C7;
	Sun, 27 Oct 2024 19:53:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nng0Kk6aHmc+aAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Sun, 27 Oct 2024 19:53:50 +0000
Message-ID: <37a28ef7-e477-40b0-a8e4-3d74b747e323@suse.cz>
Date: Sun, 27 Oct 2024 20:53:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-unstable v2] mm/page_alloc: keep track of free
 highatomic
Content-Language: en-US
To: Yu Zhao <yuzhao@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
 Mel Gorman <mgorman@techsingularity.net>,
 Matt Fleming <mfleming@cloudflare.com>
Cc: David Rientjes <rientjes@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Link Lin <linkl@google.com>
References: <20241026033625.2237102-1-yuzhao@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20241026033625.2237102-1-yuzhao@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: CCB9E21A51
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 10/26/24 05:36, Yu Zhao wrote:
> OOM kills due to vastly overestimated free highatomic reserves were
> observed:
> 
>   ... invoked oom-killer: gfp_mask=0x100cca(GFP_HIGHUSER_MOVABLE), order=0 ...
>   Node 0 Normal free:1482936kB boost:0kB min:410416kB low:739404kB high:1068392kB reserved_highatomic:1073152KB ...
>   Node 0 Normal: 1292*4kB (ME) 1920*8kB (E) 383*16kB (UE) 220*32kB (ME) 340*64kB (E) 2155*128kB (UE) 3243*256kB (UE) 615*512kB (U) 1*1024kB (M) 0*2048kB 0*4096kB = 1477408kB
> 
> The second line above shows that the OOM kill was due to the following
> condition:
> 
>   free (1482936kB) - reserved_highatomic (1073152kB) = 409784KB < min (410416kB)
> 
> And the third line shows there were no free pages in any
> MIGRATE_HIGHATOMIC pageblocks, which otherwise would show up as type
> 'H'. Therefore __zone_watermark_unusable_free() underestimated the
> usable free memory by over 1GB, which resulted in the unnecessary OOM
> kill above.
> 
> The comments in __zone_watermark_unusable_free() warns about the
> potential risk, i.e.,
> 
>   If the caller does not have rights to reserves below the min
>   watermark then subtract the high-atomic reserves. This will
>   over-estimate the size of the atomic reserve but it avoids a search.
> 
> However, it is possible to keep track of free pages in reserved
> highatomic pageblocks with a new per-zone counter nr_free_highatomic
> protected by the zone lock, to avoid a search when calculating the

It's only possible to track this reliably since the "mm: page_alloc:
freelist migratetype hygiene" patchset was merged, which explains why
nr_reserved_highatomic was used until now, even if it's imprecise. But I
agree it should be a good solution to the problem now.

> usable free memory. And the cost would be minimal, i.e., simple
> arithmetics in the highatomic alloc/free/move paths.
> 
> Reported-by: Link Lin <linkl@google.com>
> Signed-off-by: Yu Zhao <yuzhao@google.com>

However, implementation wise that patchset also centralized everything to
account_freepages() which currently handles NR_FREE_PAGES and
NR_FREE_CMA_PAGES, and your patch differs from that approach. Can't you
simply add a NR_FREE_HIGHATOMIC update there instead of creating
account_highatomic_freepages() which is hooked to 3 different places? And
for consistency indeed add a zone_stat_item counter instead a struct zone
field? Then it becomes visible in e.g. /proc/zoneinfo and /proc/vmstat too.
Bonus points for printing it in the oom/alloc failure reports as well
(wherever we print NR_FREE_CMA_PAGES).

Thanks!
Vlastimil

> ---
>  include/linux/mmzone.h |  1 +
>  mm/page_alloc.c        | 23 ++++++++++++++++++++---
>  2 files changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 2e8c4307c728..5e8f567753bd 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -825,6 +825,7 @@ struct zone {
>  	unsigned long watermark_boost;
>  
>  	unsigned long nr_reserved_highatomic;
> +	unsigned long nr_free_highatomic;
>  
>  	/*
>  	 * We don't know if the memory that we're going to allocate will be
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index c81762c49b00..43ecc7d75a2a 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -644,6 +644,18 @@ static inline void account_freepages(struct zone *zone, int nr_pages,
>  		__mod_zone_page_state(zone, NR_FREE_CMA_PAGES, nr_pages);
>  }
>  
> +static void account_highatomic_freepages(struct zone *zone, unsigned int order,
> +					 int old_mt, int new_mt)
> +{
> +	int delta = 1 << order;
> +
> +	if (is_migrate_highatomic(old_mt))
> +		WRITE_ONCE(zone->nr_free_highatomic, zone->nr_free_highatomic - delta);
> +
> +	if (is_migrate_highatomic(new_mt))
> +		WRITE_ONCE(zone->nr_free_highatomic, zone->nr_free_highatomic + delta);
> +}
> +
>  /* Used for pages not on another list */
>  static inline void __add_to_free_list(struct page *page, struct zone *zone,
>  				      unsigned int order, int migratetype,
> @@ -660,6 +672,8 @@ static inline void __add_to_free_list(struct page *page, struct zone *zone,
>  	else
>  		list_add(&page->buddy_list, &area->free_list[migratetype]);
>  	area->nr_free++;
> +
> +	account_highatomic_freepages(zone, order, -1, migratetype);
>  }
>  
>  /*
> @@ -681,6 +695,8 @@ static inline void move_to_free_list(struct page *page, struct zone *zone,
>  
>  	account_freepages(zone, -(1 << order), old_mt);
>  	account_freepages(zone, 1 << order, new_mt);
> +
> +	account_highatomic_freepages(zone, order, old_mt, new_mt);
>  }
>  
>  static inline void __del_page_from_free_list(struct page *page, struct zone *zone,
> @@ -698,6 +714,8 @@ static inline void __del_page_from_free_list(struct page *page, struct zone *zon
>  	__ClearPageBuddy(page);
>  	set_page_private(page, 0);
>  	zone->free_area[order].nr_free--;
> +
> +	account_highatomic_freepages(zone, order, migratetype, -1);
>  }
>  
>  static inline void del_page_from_free_list(struct page *page, struct zone *zone,
> @@ -3119,11 +3137,10 @@ static inline long __zone_watermark_unusable_free(struct zone *z,
>  
>  	/*
>  	 * If the caller does not have rights to reserves below the min
> -	 * watermark then subtract the high-atomic reserves. This will
> -	 * over-estimate the size of the atomic reserve but it avoids a search.
> +	 * watermark then subtract the free pages reserved for highatomic.
>  	 */
>  	if (likely(!(alloc_flags & ALLOC_RESERVES)))
> -		unusable_free += z->nr_reserved_highatomic;
> +		unusable_free += READ_ONCE(z->nr_free_highatomic);
>  
>  #ifdef CONFIG_CMA
>  	/* If allocation can't use CMA areas don't use free CMA pages */


