Return-Path: <linux-kernel+bounces-429669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2749E1F8C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B955E167A9A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F551F6690;
	Tue,  3 Dec 2024 14:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mpYsqH6y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IBmWl1Gx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="N+J5mDmR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="14YzFBcv"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E542B1F4711
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 14:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733236621; cv=none; b=nCdX5iaLK9NG1U6yLXfg3vdNKk3h6JdaF7Jby3aN7k2AgF5RKWav73DdkTpssG+S/gWvPQSObh0nBXAhbf1Gm/P8l3t5/wa1C4kMEGtZbrqhog9HrRu2/gRY2/jdG75Ac4Jk1EA/5wxbuMxl0iVhleCAPk4Wwn7x7Nbv83Ck9Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733236621; c=relaxed/simple;
	bh=t5JLd0933zFeIemCvjCk3shEzEmACFvgHY298M55+Eg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UfzdcuORyUKl7TtQbwmqPh8vcznP2xRRbxaRmvTWnjAyGnItYEAzVoXayDcOVGqLM9V9rOeslrLK4I3zs06p+NlKovFJMT1/JEb9pllcYGt4RJyQx1vLpN9d/WAjIn/sBjvE6HKIw9cMfF7JOPXZgaRfnUexfYYtujn261bMoyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mpYsqH6y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IBmWl1Gx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=N+J5mDmR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=14YzFBcv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 122301F445;
	Tue,  3 Dec 2024 14:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733236617; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=blsq4WzsUPf8s8FM67uXWrb8aFubNujefzu173v3mZ4=;
	b=mpYsqH6yIoNfTupFM7f2/4kU8SWGu0tFNTXUpwJjOYlOTeXXlJcpTG1ycS687Aw+ydThLk
	q4APJEhp469/cqEJD1jVM0UVtuHUVc+5T8sllJ6Gw791HbgoUBKGjmru0148K12Y0ua/yl
	w+8sOpY1KaKVYESa0U/DiXt7DA6AdBA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733236617;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=blsq4WzsUPf8s8FM67uXWrb8aFubNujefzu173v3mZ4=;
	b=IBmWl1GxBX6K6GsUtZitbbHRP5HiiNYhQz/TUIo6sDgDOn/MiGFA+tlnF7azFVSLAc8+p2
	rTU7iUs/5o6wIYCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733236616; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=blsq4WzsUPf8s8FM67uXWrb8aFubNujefzu173v3mZ4=;
	b=N+J5mDmRu94/sssudMp4OIK6GoDuJxtMzqft9IofAy9qrNWERFu8xkHgsxT6S5CgQ8ohDm
	pXufJTxkjhuuGcJDywOJU3hHKEOOxFZ7ycWtlL7Twp7DQOGDkCOxDnyvOHTyuG0jin8Tg2
	IPJ0/so4t1aY3SvE/jNtMgaTucO9s1c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733236616;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=blsq4WzsUPf8s8FM67uXWrb8aFubNujefzu173v3mZ4=;
	b=14YzFBcvuMO+7fVU4/qUGzO+tZqAko9YOrBIjfeG5mb/TPMK7dhJiA9j9XjVv7Bc8U1bZI
	yxna4vnyaSPrGRBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E63B1139C2;
	Tue,  3 Dec 2024 14:36:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /kCiN4cXT2eTNgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 03 Dec 2024 14:36:55 +0000
Message-ID: <d7b7a5c7-ef3f-44f2-9eb6-817b21ffc00e@suse.cz>
Date: Tue, 3 Dec 2024 15:36:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 5/6] mm/page_alloc: forward the gfp flags from
 alloc_contig_range() to post_alloc_hook()
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 Andrew Morton <akpm@linux-foundation.org>, Oscar Salvador
 <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>
References: <20241203094732.200195-1-david@redhat.com>
 <20241203094732.200195-6-david@redhat.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20241203094732.200195-6-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-8.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,lists.ozlabs.org,linux-foundation.org,suse.de,nvidia.com,ellerman.id.au,gmail.com,csgroup.eu,kernel.org,linux.ibm.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -8.30
X-Spam-Flag: NO

On 12/3/24 10:47, David Hildenbrand wrote:
> In the __GFP_COMP case, we already pass the gfp_flags to
> prep_new_page()->post_alloc_hook(). However, in the !__GFP_COMP case, we
> essentially pass only hardcoded __GFP_MOVABLE to post_alloc_hook(),
> preventing some action modifiers from being effective..
> 
> Let's pass our now properly adjusted gfp flags there as well.
> 
> This way, we can now support __GFP_ZERO for alloc_contig_*().
> 
> As a side effect, we now also support __GFP_SKIP_ZERO and__GFP_ZEROTAGS;
> but we'll keep the more special stuff (KASAN, NOLOCKDEP) disabled for
> now.
> 
> It's worth noting that with __GFP_ZERO, we might unnecessarily zero pages
> when we have to release part of our range using free_contig_range() again.
> This can be optimized in the future, if ever required; the caller we'll
> be converting (powernv/memtrace) next won't trigger this.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/page_alloc.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 54594cc4f650..71d70bc0ad79 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6364,7 +6364,7 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
>  	return (ret < 0) ? ret : 0;
>  }
>  
> -static void split_free_pages(struct list_head *list)
> +static void split_free_pages(struct list_head *list, gfp_t gfp_mask)
>  {
>  	int order;
>  
> @@ -6375,7 +6375,7 @@ static void split_free_pages(struct list_head *list)
>  		list_for_each_entry_safe(page, next, &list[order], lru) {
>  			int i;
>  
> -			post_alloc_hook(page, order, __GFP_MOVABLE);
> +			post_alloc_hook(page, order, gfp_mask);
>  			set_page_refcounted(page);
>  			if (!order)
>  				continue;
> @@ -6393,7 +6393,8 @@ static void split_free_pages(struct list_head *list)
>  static int __alloc_contig_verify_gfp_mask(gfp_t gfp_mask, gfp_t *gfp_cc_mask)
>  {
>  	const gfp_t reclaim_mask = __GFP_IO | __GFP_FS | __GFP_RECLAIM;
> -	const gfp_t action_mask = __GFP_COMP | __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
> +	const gfp_t action_mask = __GFP_COMP | __GFP_RETRY_MAYFAIL | __GFP_NOWARN |
> +				  __GFP_ZERO | __GFP_ZEROTAGS | __GFP_SKIP_ZERO;
>  	const gfp_t cc_action_mask = __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
>  
>  	/*
> @@ -6541,7 +6542,7 @@ int alloc_contig_range_noprof(unsigned long start, unsigned long end,
>  	}
>  
>  	if (!(gfp_mask & __GFP_COMP)) {
> -		split_free_pages(cc.freepages);
> +		split_free_pages(cc.freepages, gfp_mask);
>  
>  		/* Free head and tail (if any) */
>  		if (start != outer_start)


