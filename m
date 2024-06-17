Return-Path: <linux-kernel+bounces-217105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0962A90AAB4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 12:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94BC42848F6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 10:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DAE193064;
	Mon, 17 Jun 2024 10:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="T/wWlncg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Boph06D0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="T/wWlncg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Boph06D0"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C54718FDAE
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 10:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718618672; cv=none; b=Neuw356Phxygd/eHPKi81A9H6GrGZh7tLJH3fzsb8PnQaHJol2G4pHHmhUHOu6WksYjvHX4LO2jIKS+2soZgrbnecJAqb+mrC6jx6xEBq6VNrbtQ1baEFC4aCS/v//ixoEJzWFDIm4clAP2qnkHsk1ceXrIHT7wEsPao3Div1fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718618672; c=relaxed/simple;
	bh=fdVgNOVOliE8z/tiCB0KAT1jESeudyJ9mT1x+BcVXDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FLjVRP2NSvCdrhCRO6UVwhhdSah90IR7eexZ9EwYQAMd9PvrWLj/Fe1HwX3k/g001/NHYgZs0ZdRCFdPzNTZvzpZbkL9YZeovM6ewQQ66Qp9vPBVLKCx9Id7t07FL3ZPju8aLTqYKCSCqHCK/a9XT7n+Igjt4ONF0PzQbSi4DQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=T/wWlncg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Boph06D0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=T/wWlncg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Boph06D0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0D82D5FE69;
	Mon, 17 Jun 2024 10:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718618669; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2CXi0BTLwxFoo/bkUlEw4sVrubcxsdawRIzl9TVs1D8=;
	b=T/wWlncgQ3bfz2IeBG9+PiEIRRBa8yisa13+TaiXAPhJ+mgijLysl3xWSXxI20VvNal6Ro
	tkK30b7LTLdZOzIMxGcraJF9N2XZkT4IYTfxQ05Ia6w+p8ioCVTwawzm/BYZIFf/pjLujA
	IlUurOWUtEY3FDso1hpT2oi3otc+tEU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718618669;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2CXi0BTLwxFoo/bkUlEw4sVrubcxsdawRIzl9TVs1D8=;
	b=Boph06D0ouhYwucGExInaYmzSx2L/VWJOjQys2uYw8ufRhTXJrweO4Pkdm5/qHjJPOXDXq
	OCU7W1dtFSUhszBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="T/wWlncg";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Boph06D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718618669; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2CXi0BTLwxFoo/bkUlEw4sVrubcxsdawRIzl9TVs1D8=;
	b=T/wWlncgQ3bfz2IeBG9+PiEIRRBa8yisa13+TaiXAPhJ+mgijLysl3xWSXxI20VvNal6Ro
	tkK30b7LTLdZOzIMxGcraJF9N2XZkT4IYTfxQ05Ia6w+p8ioCVTwawzm/BYZIFf/pjLujA
	IlUurOWUtEY3FDso1hpT2oi3otc+tEU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718618669;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2CXi0BTLwxFoo/bkUlEw4sVrubcxsdawRIzl9TVs1D8=;
	b=Boph06D0ouhYwucGExInaYmzSx2L/VWJOjQys2uYw8ufRhTXJrweO4Pkdm5/qHjJPOXDXq
	OCU7W1dtFSUhszBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB355139AB;
	Mon, 17 Jun 2024 10:04:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QMUKOSwKcGbfAQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 17 Jun 2024 10:04:28 +0000
Message-ID: <18a30d5c-abf3-4ceb-a7fd-2edfd8bee2a8@suse.cz>
Date: Mon, 17 Jun 2024 12:04:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm/slab: fix 'variable obj_exts set but not used'
 warning
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, pasha.tatashin@soleen.com,
 souravpanda@google.com, keescook@chromium.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20240614225951.3845577-1-surenb@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20240614225951.3845577-1-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0D82D5FE69
X-Spam-Score: -4.50
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	URIBL_BLOCKED(0.00)[intel.com:email,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On 6/15/24 12:59 AM, Suren Baghdasaryan wrote:
> slab_post_alloc_hook() uses prepare_slab_obj_exts_hook() to obtain
> slabobj_ext object. Currently the only user of slabobj_ext object in
> this path is memory allocation profiling, therefore when it's not enabled
> this object is not needed. This also generates a warning when compiling
> with CONFIG_MEM_ALLOC_PROFILING=n. Move the code under this configuration
> to fix the warning. If more slabobj_ext users appear in the future, the
> code will have to be changed back to call prepare_slab_obj_exts_hook().
> 
> Fixes: 4b8736964640 ("mm/slab: add allocation accounting into slab allocation and free paths")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202406150444.F6neSaiy-lkp@intel.com/
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

But it seems to me we could remove the whole #ifdef if current->alloc_tag
(which doesn't exist with !MEM_ALLOC_PROFILING) had an access helper, or
there was a alloc_tag_add_current() variant?

> ---
>  mm/slub.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 1373ac365a46..4927edec6a8c 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3902,7 +3902,6 @@ bool slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
>  			  unsigned int orig_size)
>  {
>  	unsigned int zero_size = s->object_size;
> -	struct slabobj_ext *obj_exts;
>  	bool kasan_init = init;
>  	size_t i;
>  	gfp_t init_flags = flags & gfp_allowed_mask;
> @@ -3945,9 +3944,11 @@ bool slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
>  		kmemleak_alloc_recursive(p[i], s->object_size, 1,
>  					 s->flags, init_flags);
>  		kmsan_slab_alloc(s, p[i], init_flags);
> +#ifdef CONFIG_MEM_ALLOC_PROFILING
>  		if (need_slab_obj_ext()) {
> +			struct slabobj_ext *obj_exts;
> +
>  			obj_exts = prepare_slab_obj_exts_hook(s, flags, p[i]);
> -#ifdef CONFIG_MEM_ALLOC_PROFILING
>  			/*
>  			 * Currently obj_exts is used only for allocation profiling.
>  			 * If other users appear then mem_alloc_profiling_enabled()
> @@ -3955,8 +3956,8 @@ bool slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
>  			 */
>  			if (likely(obj_exts))
>  				alloc_tag_add(&obj_exts->ref, current->alloc_tag, s->size);
> -#endif
>  		}
> +#endif
>  	}
>  
>  	return memcg_slab_post_alloc_hook(s, lru, flags, size, p);
> 
> base-commit: c286c21ff94252f778515b21b6bebe749454a852


