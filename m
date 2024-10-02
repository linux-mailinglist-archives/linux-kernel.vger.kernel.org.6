Return-Path: <linux-kernel+bounces-347340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FAB98D153
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B73ACB22E96
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E57C1E6DEC;
	Wed,  2 Oct 2024 10:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Com6Ui7J";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ajY6s+j/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Com6Ui7J";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ajY6s+j/"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62708273FC
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 10:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727865181; cv=none; b=EkITMP0G0IPMVvIObHVJNtR4GWPIDhXOgi72ACOWxkv57CLl9NSSrTw8cDmb+oFEzB/karkafaki7iukvuPuQcoTAk+dy8TDeSBzlLaHB+9+fmcTpD5VtmKFDZiz6ZDjTB/78w5zm6XwchaOklG8vxN9ZsvxUN6N3xd1Uk0gXXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727865181; c=relaxed/simple;
	bh=sWvyVYJ+2pc/qECsSI4wNmHdfDuULPTMjgFiD3qTlmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O6XZ77y3LQE7Io2ESEjh3Cv+SQr9skq/72dg8vTXP6+lIE4qjbwS//z3EIltU4/qlZfxOsY4jNhLvr52bvwBSJ7vAlSZ9LOPdOi5jZaW+wdjywAOEeTef00OdGFATNlO+7VbsQuXfDqQGoDVDvdf/YV76+SFvDBcWOw5iW4Hqvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Com6Ui7J; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ajY6s+j/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Com6Ui7J; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ajY6s+j/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5F46F1FD49;
	Wed,  2 Oct 2024 10:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727865177; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=86BxNHYY1HvgxklxD4Bu5J4puSU7ybJmC39mnNztmrw=;
	b=Com6Ui7JQFFU3blg3i6WUVbvM9qxwEizvrPQVCYQJz/OJpPw6V07KR8+4uQNu9+amOKnAP
	RFMZAgiaQd1rtIc3b/wqBGwGdrGoS94rgPuMYA52SbBvyW52wBhII9/qO8qH7bXnDUAa7Q
	MF3j2sCFIqpYOBtm300pqKbpIT5lGNs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727865177;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=86BxNHYY1HvgxklxD4Bu5J4puSU7ybJmC39mnNztmrw=;
	b=ajY6s+j/2Po3cYnR9Zn8KhWpE9MOWhBsnUSysEqS4sLxgrWzudat1fQcWmiyC+Mausjzrs
	p3BX7Sh8c41OEIDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Com6Ui7J;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="ajY6s+j/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727865177; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=86BxNHYY1HvgxklxD4Bu5J4puSU7ybJmC39mnNztmrw=;
	b=Com6Ui7JQFFU3blg3i6WUVbvM9qxwEizvrPQVCYQJz/OJpPw6V07KR8+4uQNu9+amOKnAP
	RFMZAgiaQd1rtIc3b/wqBGwGdrGoS94rgPuMYA52SbBvyW52wBhII9/qO8qH7bXnDUAa7Q
	MF3j2sCFIqpYOBtm300pqKbpIT5lGNs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727865177;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=86BxNHYY1HvgxklxD4Bu5J4puSU7ybJmC39mnNztmrw=;
	b=ajY6s+j/2Po3cYnR9Zn8KhWpE9MOWhBsnUSysEqS4sLxgrWzudat1fQcWmiyC+Mausjzrs
	p3BX7Sh8c41OEIDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3478F13A6E;
	Wed,  2 Oct 2024 10:32:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id y2xsDFkh/Wa1YwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 02 Oct 2024 10:32:57 +0000
Message-ID: <2cbdf455-f12f-4c40-9d08-527857fb2621@suse.cz>
Date: Wed, 2 Oct 2024 12:32:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] SLUB: Add support for per object memory policies
Content-Language: en-US
To: cl@gentwo.org, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Yang Shi <shy828301@gmail.com>,
 Christoph Lameter <cl@linux.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Huang Shijie <shijie@os.amperecomputing.com>
References: <20241001-strict_numa-v3-1-ee31405056ee@gentwo.org>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20241001-strict_numa-v3-1-ee31405056ee@gentwo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5F46F1FD49
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[gentwo.org,kernel.org,google.com,lge.com,linux-foundation.org,linux.dev,gmail.com,linux.com];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

On 10/1/24 21:08, Christoph Lameter via B4 Relay wrote:
> From: Christoph Lameter <cl@gentwo.org>
> 
>     The old SLAB allocator used to support memory policies on a per
>     allocation bases. In SLUB the memory policies are applied on a
>     per page frame / folio bases. Doing so avoids having to check memory
>     policies in critical code paths for kmalloc and friends.
> 
>     This worked on general well on Intel/AMD/PowerPC because the
>     interconnect technology is mature and can minimize the latencies
>     through intelligent caching even if a small object is not
>     placed optimally.
> 
>     However, on ARM we have an emergence of new NUMA interconnect
>     technology based more on embedded devices. Caching of remote content
>     can currently be ineffective using the standard building blocks / mesh
>     available on that platform. Such architectures benefit if each slab
>     object is individually placed according to memory policies
>     and other restrictions.
> 
>     This patch adds another kernel parameter
> 
>             slab_strict_numa
> 
>     If that is set then a static branch is activated that will cause
>     the hotpaths of the allocator to evaluate the current memory
>     allocation policy. Each object will be properly placed by
>     paying the price of extra processing and SLUB will no longer
>     defer to the page allocator to apply memory policies at the
>     folio level.
> 
>     This patch improves performance of memcached running
>     on Ampere Altra 2P system (ARM Neoverse N1 processor)
>     by 3.6% due to accurate placement of small kernel objects.
> 
> Tested-by: Huang Shijie <shijie@os.amperecomputing.com>
> Signed-off-by: Christoph Lameter (Ampere) <cl@gentwo.org>

OK, but we should document this parameter in:
Documentation/admin-guide/kernel-parameters.rst
Documentation/mm/slab.rst

Thanks,
Vlastimil

> ---
> Changes in v3:
> - Make the static key a static in slub.c
> - Use pr_warn / pr_info instead of printk
> - Link to v2: https://lore.kernel.org/r/20240906-strict_numa-v2-1-f104e6de6d1e@gentwo.org
> 
> Changes in v2:
> - Fix various issues
> - Testing
> ---
>  mm/slub.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 21f71cb6cc06..7ae94f79740d 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -218,6 +218,10 @@ DEFINE_STATIC_KEY_FALSE(slub_debug_enabled);
>  #endif
>  #endif		/* CONFIG_SLUB_DEBUG */
>  
> +#ifdef CONFIG_NUMA
> +static DEFINE_STATIC_KEY_FALSE(strict_numa);
> +#endif
> +
>  /* Structure holding parameters for get_partial() call chain */
>  struct partial_context {
>  	gfp_t flags;
> @@ -3957,6 +3961,28 @@ static __always_inline void *__slab_alloc_node(struct kmem_cache *s,
>  	object = c->freelist;
>  	slab = c->slab;
>  
> +#ifdef CONFIG_NUMA
> +	if (static_branch_unlikely(&strict_numa) &&
> +			node == NUMA_NO_NODE) {
> +
> +		struct mempolicy *mpol = current->mempolicy;
> +
> +		if (mpol) {
> +			/*
> +			 * Special BIND rule support. If existing slab
> +			 * is in permitted set then do not redirect
> +			 * to a particular node.
> +			 * Otherwise we apply the memory policy to get
> +			 * the node we need to allocate on.
> +			 */
> +			if (mpol->mode != MPOL_BIND || !slab ||
> +					!node_isset(slab_nid(slab), mpol->nodes))
> +
> +				node = mempolicy_slab_node();
> +		}
> +	}
> +#endif
> +
>  	if (!USE_LOCKLESS_FAST_PATH() ||
>  	    unlikely(!object || !slab || !node_match(slab, node))) {
>  		object = __slab_alloc(s, gfpflags, node, addr, c, orig_size);
> @@ -5601,6 +5627,22 @@ static int __init setup_slub_min_objects(char *str)
>  __setup("slab_min_objects=", setup_slub_min_objects);
>  __setup_param("slub_min_objects=", slub_min_objects, setup_slub_min_objects, 0);
>  
> +#ifdef CONFIG_NUMA
> +static int __init setup_slab_strict_numa(char *str)
> +{
> +	if (nr_node_ids > 1) {
> +		static_branch_enable(&strict_numa);
> +		pr_info("SLUB: Strict NUMA enabled.\n");
> +	} else
> +		pr_warn("slab_strict_numa parameter set on non NUMA system.\n");
> +
> +	return 1;
> +}
> +
> +__setup("slab_strict_numa", setup_slab_strict_numa);
> +#endif
> +
> +
>  #ifdef CONFIG_HARDENED_USERCOPY
>  /*
>   * Rejects incorrectly sized objects and objects that are to be copied
> 
> ---
> base-commit: e32cde8d2bd7d251a8f9b434143977ddf13dcec6
> change-id: 20240819-strict_numa-fc59b33123a2
> 
> Best regards,


