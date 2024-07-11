Return-Path: <linux-kernel+bounces-249591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B32992EDA6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 19:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E1761C209AB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 17:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C0416D9BB;
	Thu, 11 Jul 2024 17:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iDt61y48";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ToJzYEyg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iDt61y48";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ToJzYEyg"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794C076034
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 17:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720718505; cv=none; b=SZBZYyjWZQJbzd84iu/dbsv0tvwlk+ViiIFJn0k/0nBfQHqln9mdMe1sIoKGnhCAtKTPHHeAEjd/zatSTN6uJ/h35q+pOkpfmI6k70EW3zReOW5w0gXOVTiVRyMJJ8BIaeMoHPKf4tPgnQeFiGVH3Ns+1l6UyG5OuN6XHKyvroU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720718505; c=relaxed/simple;
	bh=AxTVtRR11BLlVfBuxD+Lwy97eJ8iTjy/UhEtCDOiO08=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j5Mm2cbTnAP2kBUJq07cxzOOjCeMk5p5b4YGQmZfoyAYEx1t6Xj8NRiU3QN1GfPWpE96WY31klKMCzI0uVJP4hK9+6Cn/rdSFuJpGrle0iLzpIRdSHPutL+mZ2tjXPXoj7UqymQhaWvdyVSewNn5dn3umX/8470f7E3wul6j20o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iDt61y48; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ToJzYEyg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iDt61y48; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ToJzYEyg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3F09B1FB3D;
	Thu, 11 Jul 2024 17:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720718501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=e1tsKfUsWamP1++J53rRBbgIxTAdcWCi2IaUQ2jUMkw=;
	b=iDt61y48u8mOAHAhs9f08l8s9m9GxoiKpQ2fRDWEgMBTfOYUt1kQ5idaIdTc9iL4Zmc/R2
	fK1uVet/4UN82gTMb0+c1PNemD+7wdg+lu8tsEYcci7aqXYSMIrv1CYRD6igiC70Z5c6UL
	KPJ4HRQlNOrVE7dP+vS7Ps3JfwHfRJQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720718501;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=e1tsKfUsWamP1++J53rRBbgIxTAdcWCi2IaUQ2jUMkw=;
	b=ToJzYEygZ3FOI8D5361LGiS/iDoi8zBq6JGePEX+DLb7KG6GcJ2YG6RE/kcr72bqPHFUR3
	Gu/rTRTf66PHdEDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=iDt61y48;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ToJzYEyg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720718501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=e1tsKfUsWamP1++J53rRBbgIxTAdcWCi2IaUQ2jUMkw=;
	b=iDt61y48u8mOAHAhs9f08l8s9m9GxoiKpQ2fRDWEgMBTfOYUt1kQ5idaIdTc9iL4Zmc/R2
	fK1uVet/4UN82gTMb0+c1PNemD+7wdg+lu8tsEYcci7aqXYSMIrv1CYRD6igiC70Z5c6UL
	KPJ4HRQlNOrVE7dP+vS7Ps3JfwHfRJQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720718501;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=e1tsKfUsWamP1++J53rRBbgIxTAdcWCi2IaUQ2jUMkw=;
	b=ToJzYEygZ3FOI8D5361LGiS/iDoi8zBq6JGePEX+DLb7KG6GcJ2YG6RE/kcr72bqPHFUR3
	Gu/rTRTf66PHdEDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C163139E0;
	Thu, 11 Jul 2024 17:21:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ob+BBqUUkGYoRQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 11 Jul 2024 17:21:41 +0000
Message-ID: <30aa2414-3d73-4be5-adb3-10b1fc64f2a0@suse.cz>
Date: Thu, 11 Jul 2024 19:21:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm, slab: move prepare_slab_obj_exts_hook under
 CONFIG_MEM_ALLOC_PROFILING
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: sxwjean@me.com, xiongwei.song@linux.dev, willy@infradead.org,
 nathan@kernel.org, cl@linux.com, penberg@kernel.org, rientjes@google.com,
 iamjoonsoo.kim@lge.com, roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kernel test robot <lkp@intel.com>
References: <20240711170216.1149695-1-surenb@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20240711170216.1149695-1-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 3F09B1FB3D
X-Spam-Flag: NO
X-Spam-Score: 1.00
X-Spam-Level: *
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [1.00 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,me.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[me.com,linux.dev,infradead.org,kernel.org,linux.com,google.com,lge.com,gmail.com,kvack.org,vger.kernel.org,intel.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spamd-Bar: +

On 7/11/24 7:02 PM, Suren Baghdasaryan wrote:
> The only place prepare_slab_obj_exts_hook() is currently being used is
> from alloc_tagging_slab_alloc_hook() when CONFIG_MEM_ALLOC_PROFILING=y.
> Move its definition under CONFIG_MEM_ALLOC_PROFILING to prevent unused
> function warning for CONFIG_SLAB_OBJ_EXT=n case.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202407050845.zNONqauD-lkp@intel.com/

Hm so that's a mainline report, but being a clang-only W=1 warning I think
it can just wait for the merge window and no need for last-minute 6.10 fix.

> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> ---
> Applied over slab/for-next because of the refactoring [1] in that branch.

And thus took it there. thanks.

> 
> [1] 302a3ea38aec ("mm, slab: move allocation tagging code in the alloc path into a hook")
> 
>  mm/slub.c | 48 +++++++++++++++++++++---------------------------
>  1 file changed, 21 insertions(+), 27 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index ce39544acf7c..829a1f08e8a2 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2027,6 +2027,27 @@ static inline bool need_slab_obj_ext(void)
>  	return false;
>  }
>  
> +#else /* CONFIG_SLAB_OBJ_EXT */
> +
> +static int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
> +			       gfp_t gfp, bool new_slab)
> +{
> +	return 0;
> +}
> +
> +static inline void free_slab_obj_exts(struct slab *slab)
> +{
> +}
> +
> +static inline bool need_slab_obj_ext(void)
> +{
> +	return false;
> +}
> +
> +#endif /* CONFIG_SLAB_OBJ_EXT */
> +
> +#ifdef CONFIG_MEM_ALLOC_PROFILING
> +
>  static inline struct slabobj_ext *
>  prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
>  {
> @@ -2051,33 +2072,6 @@ prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
>  	return slab_obj_exts(slab) + obj_to_index(s, slab, p);
>  }
>  
> -#else /* CONFIG_SLAB_OBJ_EXT */
> -
> -static int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
> -			       gfp_t gfp, bool new_slab)
> -{
> -	return 0;
> -}
> -
> -static inline void free_slab_obj_exts(struct slab *slab)
> -{
> -}
> -
> -static inline bool need_slab_obj_ext(void)
> -{
> -	return false;
> -}
> -
> -static inline struct slabobj_ext *
> -prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
> -{
> -	return NULL;
> -}
> -
> -#endif /* CONFIG_SLAB_OBJ_EXT */
> -
> -#ifdef CONFIG_MEM_ALLOC_PROFILING
> -
>  static inline void
>  alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gfp_t flags)
>  {
> 
> base-commit: fe4e761669ab4d8b388fdb6e9dbe9a110eed8009


