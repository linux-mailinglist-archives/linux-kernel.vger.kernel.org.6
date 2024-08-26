Return-Path: <linux-kernel+bounces-302109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB1895F9E8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 21:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F8C91F22EE5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 19:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61455199389;
	Mon, 26 Aug 2024 19:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LVRgFvaZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6FnshH6F";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LVRgFvaZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6FnshH6F"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1ED79945
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 19:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724701492; cv=none; b=nR//Wfn++U7D5mAeUwfCVLdqfSr+lzeakc8WnL51qIlOlPSP5DNV29zD2isWnvXiLyL4rlEkFpzWaOMcGNPgC+hLbPS2tY9PG9qjJGk671V86pQXQJvWHGsm7DVvULho1ujPumnCww9q8bNZMnk0noswRHESl/eOXFV4XZcthF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724701492; c=relaxed/simple;
	bh=hWdvI9C0Mk+jwyRzmQ+H/t5ywWyCYD46vmCq4OP/C64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ChX9ikoye+70+LeVhyCsAqA2HyOfzorbawInSQJJER3AAs0oEoRu8Na+cgVZhhp54ZaTalmbUHJF47ZACvWtd+SGq6cK+MFj/w6QPdWZeydRBU4VTCdjKJ3l2EbeGc0Du0Yrkc2vk18gRKJ9ShWO2swEEaSQ1NSEmjTHJQjLTr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LVRgFvaZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6FnshH6F; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LVRgFvaZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6FnshH6F; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 573481F8AE;
	Mon, 26 Aug 2024 19:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724701488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LHL39kTG08YAxQMF/S9M2pxd2nii1+KP2CGwq8hsDyY=;
	b=LVRgFvaZ5KhSBxTDq+9nsjE2ye/+asmWgrQSl+ivIAfw5suRUrDzZ6s1U59/D99vcWrzR0
	7rVgMefnUwZY6L9Tl3eIAcFVq8WcDNH8Y8Um0n6Tjb+QEE4EnUkZXf4S6vXIoC8jrrAjy0
	JkA/lfoMkFUrdI1uR0WmcnP2KTagr+0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724701488;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LHL39kTG08YAxQMF/S9M2pxd2nii1+KP2CGwq8hsDyY=;
	b=6FnshH6Fa4xbK+FcNhJpseuikBI8EAxgNTkd8/bFCIYGHuwqosnct6YSWBHm2+eGXyXycI
	Fpd2E03wK5zCtJCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=LVRgFvaZ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=6FnshH6F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724701488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LHL39kTG08YAxQMF/S9M2pxd2nii1+KP2CGwq8hsDyY=;
	b=LVRgFvaZ5KhSBxTDq+9nsjE2ye/+asmWgrQSl+ivIAfw5suRUrDzZ6s1U59/D99vcWrzR0
	7rVgMefnUwZY6L9Tl3eIAcFVq8WcDNH8Y8Um0n6Tjb+QEE4EnUkZXf4S6vXIoC8jrrAjy0
	JkA/lfoMkFUrdI1uR0WmcnP2KTagr+0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724701488;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LHL39kTG08YAxQMF/S9M2pxd2nii1+KP2CGwq8hsDyY=;
	b=6FnshH6Fa4xbK+FcNhJpseuikBI8EAxgNTkd8/bFCIYGHuwqosnct6YSWBHm2+eGXyXycI
	Fpd2E03wK5zCtJCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 354E21398D;
	Mon, 26 Aug 2024 19:44:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VAVYDDDbzGbgOgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 26 Aug 2024 19:44:48 +0000
Message-ID: <f62fba18-972e-46be-8832-e5ce21ddf9c3@suse.cz>
Date: Mon, 26 Aug 2024 21:44:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Reenable NUMA policy support in the slab allocator
Content-Language: en-US
To: cl@gentwo.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Yang Shi <shy828301@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@kernel.org
References: <20240819-numa_policy-v1-1-f096cff543ee@gentwo.org>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20240819-numa_policy-v1-1-f096cff543ee@gentwo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 573481F8AE
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gentwo.org,infradead.org,cmpxchg.org,kernel.org,google.com,lge.com,linux-foundation.org,linux.dev,gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 8/19/24 20:54, Christoph Lameter via B4 Relay wrote:
> From: Christoph Lameter <cl@gentwo.org>
> 
> Revert commit 8014c46ad991 ("slub: use alloc_pages_node() in alloc_slab_page()").
> 
> The patch disabled the numa policy support in the slab allocator. It
> did not consider that alloc_pages() uses memory policies but
> alloc_pages_node() does not.
> 
> As a result of this patch slab memory allocations are no longer spread via
> interleave policy across all available NUMA nodes on bootup. Instead
> all slab memory is allocated close to the boot processor. This leads to
> an imbalance of memory accesses on NUMA systems.
> 
> Also applications using MPOL_INTERLEAVE as a memory policy will no longer
> spread slab allocations over all nodes in the interleave set but allocate
> memory locally. This may also result in unbalanced allocations
> on a single numa node.
> 
> SLUB does not apply memory policies to individual object allocations.
> However, it relies on the page allocators support of memory policies
> through alloc_pages() to do the NUMA memory allocations on a per
> folio or page level. SLUB also applies memory policies when retrieving
> partial allocated slab pages from the partial list.
> 
> Fixes: 8014c46ad991 ("slub: use alloc_pages_node() in alloc_slab_page()")
> Cc: stable@kernel.org

I'm removing this as (unlike the stable tree maintainers) I try to follow
the stable tree rules, and this wouldn't apply by them. Also it's a revert
of 6.8 commit, so the LTS kernel 6.6 doesn't care anyway.

> Signed-off-by: Christoph Lameter <cl@gentwo.org>

Thanks, added to slab/for-next

> ---
>  mm/slub.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index c9d8a2497fd6..4dea3c7df5ad 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2318,7 +2318,11 @@ static inline struct slab *alloc_slab_page(gfp_t flags, int node,
>  	struct slab *slab;
>  	unsigned int order = oo_order(oo);
>  
> -	folio = (struct folio *)alloc_pages_node(node, flags, order);
> +	if (node == NUMA_NO_NODE)
> +		folio = (struct folio *)alloc_pages(flags, order);
> +	else
> +		folio = (struct folio *)__alloc_pages_node(node, flags, order);
> +
>  	if (!folio)
>  		return NULL;
>  
> 
> ---
> base-commit: b0da640826ba3b6506b4996a6b23a429235e6923
> change-id: 20240806-numa_policy-5188f44ba0d8
> 
> Best regards,


