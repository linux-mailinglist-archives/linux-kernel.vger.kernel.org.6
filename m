Return-Path: <linux-kernel+bounces-556917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD4FA5D09C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 21:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F91817A1B9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 20:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467FF264A6F;
	Tue, 11 Mar 2025 20:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DSY1Yh1J";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AOPuZBRa";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fRspo3fo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kXcGZ1Vm"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D557E263F3F
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 20:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741724120; cv=none; b=rnZwPXTz5xsYVjrJ8gmR08y39Rg8uSycxzLEOmq29syOG7VLRx5U+aVlaBqYi159roxhxoWJgBjJ/VsBQ2d2frsSvuRS8NlqnAjzBAUQP2ZtT3c3RJSM6pOBM4WwUCuI8oWnZiH7MURy6KK97ZE0nw6khNOy1dvaEpCIoO3L2vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741724120; c=relaxed/simple;
	bh=gzYjPCmlJWUGrIy1NZsbrqTW6eUdr3n8qqb1vCqcOA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rFB5mdnLymS2JrfaE681Sk3HdEYKB8wO3KmMg3BuEczw863Gnv+x0RkoJ4VcYkIG9wjs6ncCzB/4a9FY9EgOGq49tn0ihzswPKThv8KJYdt99Sf7wj59kqvoFJnOoIhQQ/Vo86dtvayHrsrO7ikoMQU4Iay/8PD86/epZgwP9gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DSY1Yh1J; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AOPuZBRa; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fRspo3fo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kXcGZ1Vm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C9ECA2117D;
	Tue, 11 Mar 2025 20:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741724117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MOymMAqxQuWdddRLmuh9+YU6OLKrxhKGbPPHnJzrflY=;
	b=DSY1Yh1JOVv/ZTzcEVsr9Ti1k9cmcp22Scvv2CWSTQX3axcqqi3rW3t0x2Pynyi+DwqyHR
	ZuY/Ulf1yNNiR/f3Rnar/X0aKAwe57XY0sZxT7VgPyfBvR3o1/QRE1L7MjS/fJAn5/7EMO
	iEbHrQ8WoA0Oi5a2Mcp/zEqgbDGv0ac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741724117;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MOymMAqxQuWdddRLmuh9+YU6OLKrxhKGbPPHnJzrflY=;
	b=AOPuZBRaUBqYhLrakEgihcY4LJWL5b9svAc2c/X6W9ZvXBM4plw5Nv2jJ55KzMXiBbzDfn
	skKgz0yMOhT8V1Cw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=fRspo3fo;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=kXcGZ1Vm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741724116; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MOymMAqxQuWdddRLmuh9+YU6OLKrxhKGbPPHnJzrflY=;
	b=fRspo3fok3Djsq0C0D/DB5ui1oCrOZP5AUscfN+gf9QlFPoyMIG746eUTe7zAU8Nml+ckp
	YHZbtCLD0IBe1z1pL3bgLqbgyDLTCUbxa5Aa5TykH+CVAU32xueaNbZbRfJDUROxQ0KrV1
	E74CMv5qVFtXTnocqS+iRb8qX+LWcsI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741724116;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MOymMAqxQuWdddRLmuh9+YU6OLKrxhKGbPPHnJzrflY=;
	b=kXcGZ1Vmr4aoGYZRETCaSzu18GsByerx0YeDPI4/+vBPNPNwndvKfARFu3MlKrERsFOHbu
	wm5/JAzb8hI398Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A0C56134A0;
	Tue, 11 Mar 2025 20:15:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5DmmJtSZ0GeiQQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 11 Mar 2025 20:15:16 +0000
Message-ID: <12460463-a2c4-4d02-b3fd-42a490d500a9@suse.cz>
Date: Tue, 11 Mar 2025 21:15:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/page_alloc: Fix memory accept before watermarks gets
 initialized
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@redhat.com>,
 Mel Gorman <mgorman@techsingularity.net>,
 Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish"
 <ashish.kalra@amd.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>,
 linux-mm@kvack.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org, Farrah Chen <farrah.chen@intel.com>
References: <20250310082855.2587122-1-kirill.shutemov@linux.intel.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20250310082855.2587122-1-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C9ECA2117D
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:mid,suse.cz:email,intel.com:email];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 3/10/25 09:28, Kirill A. Shutemov wrote:
> Watermarks are initialized during the postcore initcall. Until then, all
> watermarks are set to zero. This causes cond_accept_memory() to
> incorrectly skip memory acceptance because a watermark of 0 is always
> met.
> 
> To ensure progress, accept one MAX_ORDER page if the watermark is zero.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reported-and-tested-by: Farrah Chen <farrah.chen@intel.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/page_alloc.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 579789600a3c..4fe93029bcb6 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7004,7 +7004,7 @@ static inline bool has_unaccepted_memory(void)
>  
>  static bool cond_accept_memory(struct zone *zone, unsigned int order)
>  {
> -	long to_accept;
> +	long to_accept, wmark;
>  	bool ret = false;
>  
>  	if (!has_unaccepted_memory())
> @@ -7013,8 +7013,18 @@ static bool cond_accept_memory(struct zone *zone, unsigned int order)
>  	if (list_empty(&zone->unaccepted_pages))
>  		return false;
>  
> +	wmark = promo_wmark_pages(zone);
> +
> +	/*
> +	 * Watermarks have not been initialized yet.
> +	 *
> +	 * Accepting one MAX_ORDER page to ensure progress.
> +	 */
> +	if (!wmark)
> +		return try_to_accept_memory_one(zone);
> +
>  	/* How much to accept to get to promo watermark? */
> -	to_accept = promo_wmark_pages(zone) -
> +	to_accept = wmark -
>  		    (zone_page_state(zone, NR_FREE_PAGES) -
>  		    __zone_watermark_unusable_free(zone, order, 0) -
>  		    zone_page_state(zone, NR_UNACCEPTED));


