Return-Path: <linux-kernel+bounces-385598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCAE9B3938
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 19:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 626B31F21849
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7F31DF975;
	Mon, 28 Oct 2024 18:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="x325xeDh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8092XCw1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="x325xeDh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8092XCw1"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5373B1DF747
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 18:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730140431; cv=none; b=pvQ4rNH8dWgCmZlWDF999pvR/f2X1BYg5X/ix/70ae4SkKnj1y53PdGA19EL5uCnO0FsA6ODg2glR0OEHwMyHRKoCwoJyhVoktnJrpRVa593I5WSuLK7R1bLgXh68JlLLBnBC+saWSwgMeVf7+MgBPXELNbKqPtwUxub97q4Udw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730140431; c=relaxed/simple;
	bh=D5Egz8AcV8jYKukgQMis1fYKxinqehZQFwo8QWEhV18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p49HgJscN8lqnHH2VO294+Fux0BQdXijn9s38pqZy7duOgbgAfCjjMM6SpjGv0sIPNuzTeOGTDGGNnMClL5FZgUtlwKvoRRpH5g5fw/x1yX8V4k08Hrkn1xaPgBTOAiMOrU8OkUgEuUIb1BF+WXnC0kq/GFFVuoZNtKG5TawA1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=x325xeDh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8092XCw1; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=x325xeDh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8092XCw1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 807C31FB63;
	Mon, 28 Oct 2024 18:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730140425; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/7WtUa+n3/Sz0f5vF4g4cuVAsBifwurM06pfi5RD2LY=;
	b=x325xeDhJmxR37UH5f79H+gBvFYZVLnUJljUcY5RMXNnrX2bVLRLQbh3phV4rW6gbcIzrb
	LvqcnPYXwLuu9v3BIt8cx0s0+m5FTElZ7e7ZYvwO6xHNwDNwH1OWnoWsgOF1RL8t76gvEI
	tc1MkJK5Aa4y96HAOeX/MKzmdM+5Rck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730140425;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/7WtUa+n3/Sz0f5vF4g4cuVAsBifwurM06pfi5RD2LY=;
	b=8092XCw1bANvlfIENU3POS70Al3za04VEt+ylSlYopnFReNidPf2l5GbMcRAfWSpW61Psl
	dvijQB2r5Sw/yXDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=x325xeDh;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=8092XCw1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730140425; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/7WtUa+n3/Sz0f5vF4g4cuVAsBifwurM06pfi5RD2LY=;
	b=x325xeDhJmxR37UH5f79H+gBvFYZVLnUJljUcY5RMXNnrX2bVLRLQbh3phV4rW6gbcIzrb
	LvqcnPYXwLuu9v3BIt8cx0s0+m5FTElZ7e7ZYvwO6xHNwDNwH1OWnoWsgOF1RL8t76gvEI
	tc1MkJK5Aa4y96HAOeX/MKzmdM+5Rck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730140425;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/7WtUa+n3/Sz0f5vF4g4cuVAsBifwurM06pfi5RD2LY=;
	b=8092XCw1bANvlfIENU3POS70Al3za04VEt+ylSlYopnFReNidPf2l5GbMcRAfWSpW61Psl
	dvijQB2r5Sw/yXDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 61CD7137D4;
	Mon, 28 Oct 2024 18:33:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QRMqFwnZH2ePSAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 28 Oct 2024 18:33:45 +0000
Message-ID: <d34b5c47-19c6-487c-a418-9b691e25961d@suse.cz>
Date: Mon, 28 Oct 2024 19:33:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-unstable v3] mm/page_alloc: keep track of free
 highatomic
Content-Language: en-US
To: Yu Zhao <yuzhao@google.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Link Lin <linkl@google.com>, David Rientjes <rientjes@google.com>
References: <20241028182653.3420139-1-yuzhao@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20241028182653.3420139-1-yuzhao@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 807C31FB63
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 10/28/24 19:26, Yu Zhao wrote:
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
> usable free memory. And the cost would be minimal, i.e., simple
> arithmetics in the highatomic alloc/free/move paths.
> 
> Note that since nr_free_highatomic can be relatively small, using a
> per-cpu counter might cause too much drift and defeat its purpose,
> in addition to the extra memory overhead.
> 
> Reported-by: Link Lin <linkl@google.com>
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> Acked-by: David Rientjes <rientjes@google.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

For LTS benefit I'd also add:

Cc: <stable@vger.kernel.org> # v6.12+

> ---
>  include/linux/mmzone.h |  1 +
>  mm/page_alloc.c        | 10 +++++++---
>  2 files changed, 8 insertions(+), 3 deletions(-)
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
> index a78acaae6d9c..372a386f34f5 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -635,6 +635,8 @@ compaction_capture(struct capture_control *capc, struct page *page,
>  static inline void account_freepages(struct zone *zone, int nr_pages,
>  				     int migratetype)
>  {
> +	lockdep_assert_held(&zone->lock);
> +
>  	if (is_migrate_isolate(migratetype))
>  		return;
>  
> @@ -642,6 +644,9 @@ static inline void account_freepages(struct zone *zone, int nr_pages,
>  
>  	if (is_migrate_cma(migratetype))
>  		__mod_zone_page_state(zone, NR_FREE_CMA_PAGES, nr_pages);
> +
> +	if (is_migrate_highatomic(migratetype))
> +		WRITE_ONCE(zone->nr_free_highatomic, zone->nr_free_highatomic + nr_pages);
>  }
>  
>  /* Used for pages not on another list */
> @@ -3117,11 +3122,10 @@ static inline long __zone_watermark_unusable_free(struct zone *z,
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


