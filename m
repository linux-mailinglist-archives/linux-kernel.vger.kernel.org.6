Return-Path: <linux-kernel+bounces-363802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A6D99C745
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 12:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E7661F234FA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE8A172BA9;
	Mon, 14 Oct 2024 10:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EBWhCM7R";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kGmrN/s1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EBWhCM7R";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kGmrN/s1"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20143170A2E
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 10:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728902269; cv=none; b=a2LRXwzdEtOYBm7WKUrviKzHEaJC+Hzf60HQjTHpJMdp191DZFcP0knUq4BwIjh8NmW2LnPihWugFKhve36cSBTDFvxSFzp0KIbDzESZFebA7nkQH8vIDbjc616P4JUfGsK9Us0kUxf8ftKN949YQXoD7/MauXDidKzu3rmo3x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728902269; c=relaxed/simple;
	bh=kFzr98EQPCiVGp1+/iEsZMSzGfHz/DLqzDhGI6jJr6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p2ajrcs3Uy1uVqmrQM85SVM+19dGJWaeZZo6iyW0O64dxk+ll5N+jsoamJier7/a2j8642DBT9Kzyv/E/QSczzSjdYdLyObnRSVV0NnOrldv4qKZcPCipVvCu32yiNVK05Ny/K2Pt1JdDmH8PI3iyn+w91nEVNBFxHeQ/j3gp1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EBWhCM7R; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kGmrN/s1; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EBWhCM7R; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kGmrN/s1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 410C21F786;
	Mon, 14 Oct 2024 10:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728902265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nz2I5FT15ZQhSs4tr1Du9ZagXzAtAlidl5olumNcdA0=;
	b=EBWhCM7R2gzMScacFrZPN7g3Ofj2ecWI/zE+OvozItACddu8xGf2KirnbHtAG0+ya5PwC/
	RHU3UQYCVn9P+hfKTPRoT42/sscC/nh2ZolHhFrzyb1M5YIGevTrKeCjuV1TbVI/Jq2ueW
	bA/ycuMSn5l9EDoQUQq8so8o4VpnLVs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728902265;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nz2I5FT15ZQhSs4tr1Du9ZagXzAtAlidl5olumNcdA0=;
	b=kGmrN/s1IASY1j+1g7PiVG0ssjgV9aSm8kebAAqo2OTtnbHZD95GffgAiWo6Y0ZIzdxsB+
	ejdnftkQImp7NFAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=EBWhCM7R;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="kGmrN/s1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728902265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nz2I5FT15ZQhSs4tr1Du9ZagXzAtAlidl5olumNcdA0=;
	b=EBWhCM7R2gzMScacFrZPN7g3Ofj2ecWI/zE+OvozItACddu8xGf2KirnbHtAG0+ya5PwC/
	RHU3UQYCVn9P+hfKTPRoT42/sscC/nh2ZolHhFrzyb1M5YIGevTrKeCjuV1TbVI/Jq2ueW
	bA/ycuMSn5l9EDoQUQq8so8o4VpnLVs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728902265;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nz2I5FT15ZQhSs4tr1Du9ZagXzAtAlidl5olumNcdA0=;
	b=kGmrN/s1IASY1j+1g7PiVG0ssjgV9aSm8kebAAqo2OTtnbHZD95GffgAiWo6Y0ZIzdxsB+
	ejdnftkQImp7NFAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 200C813A42;
	Mon, 14 Oct 2024 10:37:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NDhDB3n0DGdlHgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 14 Oct 2024 10:37:45 +0000
Message-ID: <0f46ff18-e385-4940-b0f0-db4130704bfb@suse.cz>
Date: Mon, 14 Oct 2024 12:37:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/page_alloc: Let GFP_ATOMIC order-0 allocs access
 highatomic reserves
Content-Language: en-US
To: Matt Fleming <matt@readmodwrite.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
 Matt Fleming <mfleming@cloudflare.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <20241011120737.3300370-1-matt@readmodwrite.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20241011120737.3300370-1-matt@readmodwrite.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 410C21F786
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 10/11/24 14:07, Matt Fleming wrote:
> From: Matt Fleming <mfleming@cloudflare.com>
> 
> Under memory pressure it's possible for GFP_ATOMIC order-0 allocations
> to fail even though free pages are available in the highatomic reserves.
> GFP_ATOMIC allocations cannot trigger unreserve_highatomic_pageblock()
> since it's only run from reclaim.
> 
> Given that such allocations will pass the watermarks in
> __zone_watermark_unusable_free(), it makes sense to fallback to
> highatomic reserves the same way that ALLOC_OOM can.
> 
> This fixes order-0 page allocation failures observed on Cloudflare's
> fleet when handling network packets:
> 
>   kswapd1: page allocation failure: order:0, mode:0x820(GFP_ATOMIC),
>   nodemask=(null),cpuset=/,mems_allowed=0-7
>   CPU: 10 PID: 696 Comm: kswapd1 Kdump: loaded Tainted: G           O 6.6.43-CUSTOM #1
>   Hardware name: MACHINE
>   Call Trace:
>    <IRQ>
>    dump_stack_lvl+0x3c/0x50
>    warn_alloc+0x13a/0x1c0
>    __alloc_pages_slowpath.constprop.0+0xc9d/0xd10
>    __alloc_pages+0x327/0x340
>    __napi_alloc_skb+0x16d/0x1f0
>    bnxt_rx_page_skb+0x96/0x1b0 [bnxt_en]
>    bnxt_rx_pkt+0x201/0x15e0 [bnxt_en]
>    __bnxt_poll_work+0x156/0x2b0 [bnxt_en]
>    bnxt_poll+0xd9/0x1c0 [bnxt_en]
>    __napi_poll+0x2b/0x1b0
>    bpf_trampoline_6442524138+0x7d/0x1000
>    __napi_poll+0x5/0x1b0
>    net_rx_action+0x342/0x740
>    handle_softirqs+0xcf/0x2b0
>    irq_exit_rcu+0x6c/0x90
>    sysvec_apic_timer_interrupt+0x72/0x90
>    </IRQ>
> 
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: linux-mm@kvack.org
> Link: https://lore.kernel.org/all/CAGis_TWzSu=P7QJmjD58WWiu3zjMTVKSzdOwWE8ORaGytzWJwQ@mail.gmail.com/
> Signed-off-by: Matt Fleming <mfleming@cloudflare.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
(but a comment should be updated, see below)

I think we could add Cc: stable and I believe the commit that broke it was:

Fixes: 1d91df85f399 ("mm/page_alloc: handle a missing case for
memalloc_nocma_{save/restore} APIs")

because it was where an order > 0 condition was introduced to allow
allocation from MIGRATE_HIGHATOMIC

commit eb2e2b425c69 ("mm/page_alloc: explicitly record high-order atomic
allocations in alloc_flags") realized there's a gap for OOM (even if
changelog doesn't mention it) but we should allow the order-0 atomic
allocations to fallback as well.

> ---
>  mm/page_alloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 8afab64814dc..0c4c359f5ba7 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2898,7 +2898,7 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
>  			 * failing a high-order atomic allocation in the
>  			 * future.
>  			 */

We should also update the comment above to reflect this is no longer just
for the OOM case?

> -			if (!page && (alloc_flags & ALLOC_OOM))
> +			if (!page && (alloc_flags & (ALLOC_OOM|ALLOC_NON_BLOCK)))
>  				page = __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);
>  
>  			if (!page) {


