Return-Path: <linux-kernel+bounces-239328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2888C925B17
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 13:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF22B29DC58
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F70218E769;
	Wed,  3 Jul 2024 10:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BniktTIX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Mj3IDtQg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BniktTIX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Mj3IDtQg"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B770F18C348
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 10:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720003660; cv=none; b=Jod6waxvTI/oiN3gpgmxlDGIQj3b5jaN2UcCYjM0Xm2fZqFjjJ1o4HxTrl9kDmEghvr/a3XnHrNnPBMeFqwv6DZjRhyLCOgrPMBUA4PbFhyrEkgnjKzo4yEhmOja+5xdtX6trtKbzdsg8KEVKRsrBA+VpQy5idgN7t+aQ8+Wv/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720003660; c=relaxed/simple;
	bh=zDcA3kVnwBsHHRrz1TXGJ78LB7jEWJ9deRMN/t5hJak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IjL0BC7EOVbd99GXsfJ8uplTchHdLOYLa0ezgouMe+XFgERqB/HF5zdkcJ+Q3/qRJ6ZaQZ0kETrLR2Jt9ztAubYS9r1yQWXEd9ZU5qc/I5bwbb/c86CR/ZFFPSiTUxIibmHfj9agQy/+BQIDbyJu5WDABeFmIgSfwEL7F8b8Wrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BniktTIX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Mj3IDtQg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BniktTIX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Mj3IDtQg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C0B981FCD5;
	Wed,  3 Jul 2024 10:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720003655; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sd/3698zPjMXhtpZ19auMMYBrjyhs4iVIUv6dBSSr70=;
	b=BniktTIXUY2cV0SFH4BGujRZ6Dq4fAx1yJ+R6B+HQjHcG/m9MbcQRsJaY8Ygjey9OzqOal
	tPy9ixo8az8epCUo2QRC4wLh8gI4Z2S3LUPsIr0gRtzGhnQ0RQMISE7JYZUJkcM6z7n4DJ
	ioj510XthAw0Kp0mCafjoqDcdTeLTNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720003655;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sd/3698zPjMXhtpZ19auMMYBrjyhs4iVIUv6dBSSr70=;
	b=Mj3IDtQg0I3mH0J71a6dT18qzZmm0PBJIcYx2WPGJ8OUjZw5VX/IzQqms4oW5t5UJSYUVM
	QgGYkN05eZ432WDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=BniktTIX;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Mj3IDtQg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720003655; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sd/3698zPjMXhtpZ19auMMYBrjyhs4iVIUv6dBSSr70=;
	b=BniktTIXUY2cV0SFH4BGujRZ6Dq4fAx1yJ+R6B+HQjHcG/m9MbcQRsJaY8Ygjey9OzqOal
	tPy9ixo8az8epCUo2QRC4wLh8gI4Z2S3LUPsIr0gRtzGhnQ0RQMISE7JYZUJkcM6z7n4DJ
	ioj510XthAw0Kp0mCafjoqDcdTeLTNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720003655;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sd/3698zPjMXhtpZ19auMMYBrjyhs4iVIUv6dBSSr70=;
	b=Mj3IDtQg0I3mH0J71a6dT18qzZmm0PBJIcYx2WPGJ8OUjZw5VX/IzQqms4oW5t5UJSYUVM
	QgGYkN05eZ432WDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9E1D713889;
	Wed,  3 Jul 2024 10:47:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RwBCJkcshWYlbQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 03 Jul 2024 10:47:35 +0000
Message-ID: <be221a24-fec2-4ae4-9020-c684902870e7@suse.cz>
Date: Wed, 3 Jul 2024 12:47:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm, slab: move allocation tagging code in the alloc
 path into a hook
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, cl@linux.com, penberg@kernel.org,
 rientjes@google.com, iamjoonsoo.kim@lge.com, roman.gushchin@linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240703015354.3370503-1-surenb@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20240703015354.3370503-1-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: C0B981FCD5
X-Spam-Flag: NO
X-Spam-Score: -4.50
X-Spam-Level: 

On 7/3/24 3:53 AM, Suren Baghdasaryan wrote:
> Move allocation tagging specific code in the allocation path into
> alloc_tagging_slab_alloc_hook, similar to how freeing path uses
> alloc_tagging_slab_free_hook. No functional changes, just code
> cleanup.
> 
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  mm/slub.c | 34 +++++++++++++++++++++++++++++-----
>  1 file changed, 29 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 4927edec6a8c..99d53190cfcf 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2033,11 +2033,18 @@ prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
>  	return slab_obj_exts(slab) + obj_to_index(s, slab, p);
>  }
>  
> +#ifdef CONFIG_MEM_ALLOC_PROFILING

I think if you extract this whole #ifdef CONFIG_MEM_ALLOC_PROFILING section
to go outside of CONFIG_SLAB_OBJ_EXT sections, i.e. below the final

#endif /* CONFIG_SLAB_OBJ_EXT */

then it wouldn't be necessary to have two instances of the empty hooks?

> +
> +static inline void
> +alloc_tagging_slab_alloc_hook(struct slabobj_ext *obj_exts, unsigned int size)
> +{
> +	alloc_tag_add(&obj_exts->ref, current->alloc_tag, size);
> +}
> +
>  static inline void
>  alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
>  			     int objects)
>  {
> -#ifdef CONFIG_MEM_ALLOC_PROFILING
>  	struct slabobj_ext *obj_exts;
>  	int i;
>  
> @@ -2053,9 +2060,23 @@ alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
>  
>  		alloc_tag_sub(&obj_exts[off].ref, s->size);
>  	}
> -#endif
>  }
>  
> +#else /* CONFIG_MEM_ALLOC_PROFILING */
> +
> +static inline void
> +alloc_tagging_slab_alloc_hook(struct slabobj_ext *obj_exts, unsigned int size)
> +{
> +}
> +
> +static inline void
> +alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
> +			     int objects)
> +{
> +}
> +
> +#endif /* CONFIG_MEM_ALLOC_PROFILING*/
> +
>  #else /* CONFIG_SLAB_OBJ_EXT */
>  
>  static int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
> @@ -2079,6 +2100,11 @@ prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
>  	return NULL;
>  }
>  
> +static inline void
> +alloc_tagging_slab_alloc_hook(struct slabobj_ext *obj_exts, unsigned int size)
> +{
> +}
> +
>  static inline void
>  alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
>  			     int objects)
> @@ -3944,7 +3970,6 @@ bool slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
>  		kmemleak_alloc_recursive(p[i], s->object_size, 1,
>  					 s->flags, init_flags);
>  		kmsan_slab_alloc(s, p[i], init_flags);
> -#ifdef CONFIG_MEM_ALLOC_PROFILING
>  		if (need_slab_obj_ext()) {
>  			struct slabobj_ext *obj_exts;
>  
> @@ -3955,9 +3980,8 @@ bool slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
>  			 * check should be added before alloc_tag_add().
>  			 */
>  			if (likely(obj_exts))
> -				alloc_tag_add(&obj_exts->ref, current->alloc_tag, s->size);
> +				alloc_tagging_slab_alloc_hook(obj_exts, s->size);
>  		}

Could this whole "if (need_slab_obj_ext())" block be part of
alloc_tagging_slab_alloc_hook()? That would match
__memcg_slab_post_alloc_hook also taking care of calloing
alloc_slab_obj_exts on its own. Maybe then we won't even need empty versions
of prepare_slab_obj_exts_hook()

> -#endif
>  	}
>  
>  	return memcg_slab_post_alloc_hook(s, lru, flags, size, p);
> 
> base-commit: e9d22f7a6655941fc8b2b942ed354ec780936b3e


