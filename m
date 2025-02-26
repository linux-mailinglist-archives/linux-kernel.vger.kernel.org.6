Return-Path: <linux-kernel+bounces-534227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA39A4645E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC4431893083
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88A922424E;
	Wed, 26 Feb 2025 15:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZC13OJXN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="InDN0d6r";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZC13OJXN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="InDN0d6r"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB0C2222B2
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 15:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740583011; cv=none; b=Vhypcgi2fa9O5+dNuvlbMaPMrUAAdEgJZ5PE4WxPQslyMFdqUkHi0raUQX6wf5vp1Sm2OZbDyE8Jv3Zi71Rx3zR67FADIwa+jDRD/WMXKZGfqIjRSxGMaG2swIy1IjXEIrk7FH45eVcjh9xET8Yh1YE9I4juVJ2RKSujX/ZOtrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740583011; c=relaxed/simple;
	bh=fOdiVlsji0Slhzx4kloR0dK7a/mC3LkTFwdcME21l8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qdEcVW7Z5AhQC4ti+ccQ5rD/r0bscefCebWwegg2AnPSaBrE8Ncb7d3udk4drdN1jn5cJrTgxlXVZfi6J576fi1JSAqUGnwbzfJoPfl09vFypjcYvIjiCnO4zA1AWDJbZe1gvaiA8FkihxHb2Qw2FcJhZZE2wAMNPxEK7gKgEbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZC13OJXN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=InDN0d6r; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZC13OJXN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=InDN0d6r; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8054D1F74A;
	Wed, 26 Feb 2025 15:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740583007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hJayfz8MtAbPlILPbeTLJFh5NNnCDR2UTDSPWC3ZicQ=;
	b=ZC13OJXNaCYWCi4EdSEBJRxKuOpWMFkHtlkdA+u08uGLgvnLk/2mG+tmyIa76zRmZzbhSJ
	Kuxj91uvYeJveZFFYZ/jDattqdOyjBp2357Jg00cBWycRfJHdDsHTeG5odmSbrUMGUKLhA
	sgd0wgVvtM755I4QknWfDYwXqhAkRSc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740583007;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hJayfz8MtAbPlILPbeTLJFh5NNnCDR2UTDSPWC3ZicQ=;
	b=InDN0d6rPuS9D8tjMrYJs3KdApoVK02tibEur+GUDtIqc+7ihx+kNEez1khdBOR3kACrDZ
	LbWBseNjvJt/81DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740583007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hJayfz8MtAbPlILPbeTLJFh5NNnCDR2UTDSPWC3ZicQ=;
	b=ZC13OJXNaCYWCi4EdSEBJRxKuOpWMFkHtlkdA+u08uGLgvnLk/2mG+tmyIa76zRmZzbhSJ
	Kuxj91uvYeJveZFFYZ/jDattqdOyjBp2357Jg00cBWycRfJHdDsHTeG5odmSbrUMGUKLhA
	sgd0wgVvtM755I4QknWfDYwXqhAkRSc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740583007;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hJayfz8MtAbPlILPbeTLJFh5NNnCDR2UTDSPWC3ZicQ=;
	b=InDN0d6rPuS9D8tjMrYJs3KdApoVK02tibEur+GUDtIqc+7ihx+kNEez1khdBOR3kACrDZ
	LbWBseNjvJt/81DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 31DC61377F;
	Wed, 26 Feb 2025 15:16:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +Zg3C18wv2cIVgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 26 Feb 2025 15:16:47 +0000
Message-ID: <ec501508-ff60-40e0-81eb-e3c00b96bdb5@suse.cz>
Date: Wed, 26 Feb 2025 16:18:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] mm/page_alloc: Clarify should_claim_block()
 commentary
To: Brendan Jackman <jackmanb@google.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Mel Gorman <mgorman@techsingularity.net>, Michal Hocko
 <mhocko@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Yosry Ahmed <yosry.ahmed@linux.dev>
References: <20250225-clarify-steal-v3-0-f2550ead0139@google.com>
 <20250225-clarify-steal-v3-2-f2550ead0139@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
Content-Language: en-US
In-Reply-To: <20250225-clarify-steal-v3-2-f2550ead0139@google.com>
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
> There's lots of text here but it's a little hard to follow, this is an
> attempt to break it up and align its structure more closely with the
> code.
> 
> Reword the top-level function comment to just explain what question the
> function answers from the point of view of the caller.
> 
> Break up the internal logic into different sections that can have their
> own commentary describing why that part of the rationale is present.
> 
> Note the page_groupy_by_mobility_disabled logic is not explained in the

grouping

> commentary, that is outside the scope of this patch...
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>

Johannes suggested moving the checks to the caller and removing this
function but with this kind of detailed commentary I guess it's better
to keep it as a separate function.

> ---
>  mm/page_alloc.c | 39 +++++++++++++++++++++++----------------
>  1 file changed, 23 insertions(+), 16 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 5e694046ef92965b34d4831e96d92f02681a8b45..475ec1284033acec69da4a39dd4e7d7fbaee6d0f 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1941,16 +1941,9 @@ static inline bool boost_watermark(struct zone *zone)
>  }
>  
>  /*
> - * When we are falling back to another migratetype during allocation, try to
> - * claim entire blocks to satisfy further allocations, instead of polluting
> - * multiple pageblocks.
> - *
> - * If we are stealing a relatively large buddy page, it is likely there will be
> - * more free pages in the pageblock, so try to claim the whole block. For
> - * reclaimable and unmovable allocations, we claim the whole block regardless of
> - * page size, as fragmentation caused by those allocations polluting movable
> - * pageblocks is worse than movable allocations stealing from unmovable and
> - * reclaimable pageblocks.
> + * When we are falling back to another migratetype during allocation, should we
> + * try to claim an entire block to satisfy further allocations, instead of
> + * polluting multiple pageblocks?
>   */
>  static bool should_claim_block(unsigned int order, int start_mt)
>  {
> @@ -1964,6 +1957,26 @@ static bool should_claim_block(unsigned int order, int start_mt)
>  	if (order >= pageblock_order)
>  		return true;
>  
> +	/*
> +	 * Above a certain threshold, always try to claim, as it's likely there
> +	 * will be more free pages in the pageblock.
> +	 */
> +	if (order >= pageblock_order / 2)
> +		return true;
> +
> +	/*
> +	 * Unmovable/reclaimable allocations would cause permanent
> +	 * fragmentations if they fell back to allocating from a movable block
> +	 * (polluting it), so we try to claim the whole block regardless of the
> +	 * allocation size. Later movable allocations can always steal from this
> +	 * block, which is less problematic.
> +	 */
> +	if (start_mt == MIGRATE_RECLAIMABLE || start_mt == MIGRATE_UNMOVABLE)
> +		return true;
> +
> +	if (page_group_by_mobility_disabled)
> +		return true;
> +
>  	/*
>  	 * Movable pages won't cause permanent fragmentation, so when you alloc
>  	 * small pages, you just need to temporarily steal unmovable or
> @@ -1972,12 +1985,6 @@ static bool should_claim_block(unsigned int order, int start_mt)
>  	 * and the next movable allocation may not need to steal.  Unmovable and
>  	 * reclaimable allocations need to actually claim the whole block.
>  	 */

This block could be also massaged? I'd unify the style so it's "we"
everywhere and not suddenly "you". The last sentence is redundant with
the comment you added above reclaimable/unmovable. The text should be
just about movable allocations in the case of small enough order.

> -	if (order >= pageblock_order / 2 ||
> -		start_mt == MIGRATE_RECLAIMABLE ||
> -		start_mt == MIGRATE_UNMOVABLE ||
> -		page_group_by_mobility_disabled)
> -		return true;
> -
>  	return false;
>  }
>  
> 


