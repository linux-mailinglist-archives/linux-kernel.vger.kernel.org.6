Return-Path: <linux-kernel+bounces-248767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF2492E1B8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 10:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 185F61F24298
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 08:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F04156C71;
	Thu, 11 Jul 2024 08:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wST6reP+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wD+j4QVQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wST6reP+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wD+j4QVQ"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DFD154449
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 08:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720685502; cv=none; b=MoeHU9XV83I6izv3fbj6KJWi3l4ZAnYgdxP6pnYbwgU4SOTi0X1nNQMkdzDjy1x75rOWsbsvkhdtWQfazbDjbZFBuFX0POM48kWneWmDCZ53ROXGGZ1Yv4zLil4sTgOI6RXCjX0NlwX0jqQxXY+Yu28VoJszybCK79cUNO1OjNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720685502; c=relaxed/simple;
	bh=IoSfOERpJTwdcjRlGVGdA+7cY4s5jzn1Y2tSjU5HR3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DNpMt8hH47d/ZiB10OaCKu4dZxEsm05EVIyVsBn22KQX92AXv+qOT9GlM0ogPxtG4fhn0V9xa+mgQ2lXvMe/y8vblt+lTw1h+rudfhY54KWZDUNb7Q7qcF8CsAwZBMITtOeTA92WHMIyIfhV9qRm33tPDeLVVo6nMJwCBLhyipU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wST6reP+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wD+j4QVQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wST6reP+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wD+j4QVQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 88D922192D;
	Thu, 11 Jul 2024 08:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720685498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+9bFZhaPYxI9MVcY1EYwod8mYg8QgnvxONqpF1N/E/o=;
	b=wST6reP+Zs5NZJrS6nhyR6W/VvQqHAtvSAMOvI8aQjJ+K32n4N4/QVoRZ3ACkkfnhdN0rh
	gvxvNPCcJBe4+XvWyMHPrvnTVrus8Rjq8s0G9rvStOKTE+O593XOSVjeLZY17Aj/v3W8eh
	1JOkvJN8E1K2oN4vhkrqWPp7+wDBRcg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720685498;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+9bFZhaPYxI9MVcY1EYwod8mYg8QgnvxONqpF1N/E/o=;
	b=wD+j4QVQKvRix/y+AJJbTotp52gL5UwKVXOlkasK2M8cYCHOttL/R4vo50TjhBV3veIX2B
	q93+jVPg8J3f+CAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720685498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+9bFZhaPYxI9MVcY1EYwod8mYg8QgnvxONqpF1N/E/o=;
	b=wST6reP+Zs5NZJrS6nhyR6W/VvQqHAtvSAMOvI8aQjJ+K32n4N4/QVoRZ3ACkkfnhdN0rh
	gvxvNPCcJBe4+XvWyMHPrvnTVrus8Rjq8s0G9rvStOKTE+O593XOSVjeLZY17Aj/v3W8eh
	1JOkvJN8E1K2oN4vhkrqWPp7+wDBRcg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720685498;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+9bFZhaPYxI9MVcY1EYwod8mYg8QgnvxONqpF1N/E/o=;
	b=wD+j4QVQKvRix/y+AJJbTotp52gL5UwKVXOlkasK2M8cYCHOttL/R4vo50TjhBV3veIX2B
	q93+jVPg8J3f+CAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 63E9C136AF;
	Thu, 11 Jul 2024 08:11:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eszMF7qTj2YSHgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 11 Jul 2024 08:11:38 +0000
Message-ID: <d6bfed41-4c2b-4855-bcb4-522079f19bf4@suse.cz>
Date: Thu, 11 Jul 2024 10:11:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REF PATCH v3 2/2] mm/slab: decouple the SLAB_OBJ_EXT from MEMCG
Content-Language: en-US
To: alexs@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Yoann Congal
 <yoann.congal@smile.fr>, Masahiro Yamada <masahiroy@kernel.org>,
 Petr Mladek <pmladek@suse.com>, Suren Baghdasaryan <surenb@google.com>
References: <20240710054336.190410-1-alexs@kernel.org>
 <20240710054336.190410-2-alexs@kernel.org>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20240710054336.190410-2-alexs@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.79 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,linux-foundation.org,linux.com,google.com,lge.com,linux.dev,gmail.com,kvack.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -2.79
X-Spam-Level: 

On 7/10/24 7:43 AM, alexs@kernel.org wrote:
> From: "Alex Shi (Tencent)" <alexs@kernel.org>
> 
> commit 21c690a349ba ("mm: introduce slabobj_ext to support slab object
> extensions") selected SLAB_OBJ_EXT on MEMCG just for SLAB_MATCH
> memcg_data, that included SLAB_OBJ_EXT for MEMCG. In fact, I didn't see
> the necessary to enable SLAB_OBJ_EXT for MEMCG.
> 
> Let's decouple the SLAB_OBJ_EXT from MEMCG and move out
> alloc_slab_obj_exts() definition from SLAB_OBJ_EXT only. To alignment
> the alloc_slab_obj_exts() return 0 for good. change its return value to
> '-1' for always failed with !SLAB_OBJ_EXT. Now we could save unnecessary
> code from MEMCG but !SLAB_OBJ_EXT.
> 
> Signed-off-by: Alex Shi (Tencent) <alexs@kernel.org>

This seems just wrong to me. The memcg hooks for slab do use obj_ext. You
made alloc_slab_obj_exts() return -1 and that will just fail all memcg
charging (unless alloc profiling selects obj_ext). The kernel will appear to
work, but memcg charging for slab won't happen at all.

So no, it can't be decoupled for slab, only for pages/folios (patch 1).


> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Yoann Congal <yoann.congal@smile.fr>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Petr Mladek <pmladek@suse.com>
> ---
>  init/Kconfig | 1 -
>  mm/slab.h    | 6 +++---
>  mm/slub.c    | 6 +++---
>  3 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/init/Kconfig b/init/Kconfig
> index 26bf8bb0a7ce..61e43ac9fe75 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -965,7 +965,6 @@ config MEMCG
>  	bool "Memory controller"
>  	select PAGE_COUNTER
>  	select EVENTFD
> -	select SLAB_OBJ_EXT
>  	help
>  	  Provides control over the memory footprint of tasks in a cgroup.
>  
> diff --git a/mm/slab.h b/mm/slab.h
> index 8ffdd4f315f8..6c727ecc1068 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -559,9 +559,6 @@ static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
>  	return (struct slabobj_ext *)(obj_exts & ~OBJEXTS_FLAGS_MASK);
>  }
>  
> -int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
> -                        gfp_t gfp, bool new_slab);
> -
>  #else /* CONFIG_SLAB_OBJ_EXT */
>  
>  static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
> @@ -571,6 +568,9 @@ static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
>  
>  #endif /* CONFIG_SLAB_OBJ_EXT */
>  
> +int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
> +			gfp_t gfp, bool new_slab);
> +
>  static inline enum node_stat_item cache_vmstat_idx(struct kmem_cache *s)
>  {
>  	return (s->flags & SLAB_RECLAIM_ACCOUNT) ?
> diff --git a/mm/slub.c b/mm/slub.c
> index cc11f3869cc6..f531c2d67238 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2075,10 +2075,10 @@ alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
>  
>  #else /* CONFIG_SLAB_OBJ_EXT */
>  
> -static int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
> -			       gfp_t gfp, bool new_slab)
> +int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
> +			gfp_t gfp, bool new_slab)
>  {
> -	return 0;
> +	return -1;
>  }
>  
>  static inline void free_slab_obj_exts(struct slab *slab)


