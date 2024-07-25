Return-Path: <linux-kernel+bounces-262229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 956FE93C2CC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 15:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86BDA1C2114C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 13:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C555119ADB9;
	Thu, 25 Jul 2024 13:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Gh+9JTsH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="P9awaP2Q";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Gh+9JTsH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="P9awaP2Q"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEF016DEA8
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 13:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721913622; cv=none; b=eNXlbv+ZPTjWN4LC257oNoM3cPR/rPr8YET9te9z0H1yPWz9xc0eitZJAS/DyMTr/WWJEZOxagLpVbJMUuroI2DkndOqKJHDwH1MJ54XTF2ZNPlpwH88Sqiw3qxm5cY+StAeC0dCsygWivPM7ehmTjuuhHLyjis8wdZu6E7ReLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721913622; c=relaxed/simple;
	bh=c/EZprCbxr2bBDBxZoQpEm3Kgc9Hu+OnrRAUn2MdVJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DrgI0IdjMh/8jJUM9rv+fJk3U76WT1egIJZXubnuR7/b7ZdPDrmBJb4JpeZsraJmUAb62P+07+CL85AY4oecqg3DhIqUMH90j9Dk1KqakzarKOFwW7VtdR+y1B1jn2iCwCxiVFLADWdZ5xubry3wAWDtLi0UAdkKfjlh5y7GwtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Gh+9JTsH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=P9awaP2Q; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Gh+9JTsH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=P9awaP2Q; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F18AD1F45A;
	Thu, 25 Jul 2024 13:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721913619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7Stw7qPfwbB4swhWbYP34yYgfEmapZZj8phemCP1P9I=;
	b=Gh+9JTsHtt7PW5soaNIhHuApUiBEpD9TZXwTlC6Y1Mv3VjuFzrCKJWHsgDag4jKsDJ2bOQ
	32Pk8ydIuQV9BsrbJpQYQYVyXUh2BisPFJOgaZbvG6X0zm6wZqweIuoUrDTXYQKtiuSLJR
	7lKO12LdG2FUqhUQnwKzWpBwV2ZiG+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721913619;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7Stw7qPfwbB4swhWbYP34yYgfEmapZZj8phemCP1P9I=;
	b=P9awaP2QK084GtNWGIQPalJZ+LPJTScvPi2BnXKIIVmCnmq18Sl0xf3Mgg6wMtRK2SyJJ1
	igpmbJdAvdTZW/Cg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Gh+9JTsH;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=P9awaP2Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721913619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7Stw7qPfwbB4swhWbYP34yYgfEmapZZj8phemCP1P9I=;
	b=Gh+9JTsHtt7PW5soaNIhHuApUiBEpD9TZXwTlC6Y1Mv3VjuFzrCKJWHsgDag4jKsDJ2bOQ
	32Pk8ydIuQV9BsrbJpQYQYVyXUh2BisPFJOgaZbvG6X0zm6wZqweIuoUrDTXYQKtiuSLJR
	7lKO12LdG2FUqhUQnwKzWpBwV2ZiG+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721913619;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7Stw7qPfwbB4swhWbYP34yYgfEmapZZj8phemCP1P9I=;
	b=P9awaP2QK084GtNWGIQPalJZ+LPJTScvPi2BnXKIIVmCnmq18Sl0xf3Mgg6wMtRK2SyJJ1
	igpmbJdAvdTZW/Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CC09B13874;
	Thu, 25 Jul 2024 13:20:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5wR4MRJRombhfgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 25 Jul 2024 13:20:18 +0000
Message-ID: <1d6913c7-5a6a-412b-a4fa-0eb7b7622d4f@suse.cz>
Date: Thu, 25 Jul 2024 15:20:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] kasan: catch invalid free before SLUB
 reinitializes the object
To: Jann Horn <jannh@google.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>,
 Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: Marco Elver <elver@google.com>, kasan-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240724-kasan-tsbrcu-v2-0-45f898064468@google.com>
 <20240724-kasan-tsbrcu-v2-1-45f898064468@google.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20240724-kasan-tsbrcu-v2-1-45f898064468@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: F18AD1F45A
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[google.com,gmail.com,arm.com,linux-foundation.org,linux.com,kernel.org,lge.com,linux.dev];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]

On 7/24/24 6:34 PM, Jann Horn wrote:
> Currently, when KASAN is combined with init-on-free behavior, the
> initialization happens before KASAN's "invalid free" checks.
> 
> More importantly, a subsequent commit will want to use the object metadata
> region to store an rcu_head, and we should let KASAN check that the object
> pointer is valid before that. (Otherwise that change will make the existing
> testcase kmem_cache_invalid_free fail.)
> 
> So add a new KASAN hook that allows KASAN to pre-validate a
> kmem_cache_free() operation before SLUB actually starts modifying the
> object or its metadata.
> 
> Signed-off-by: Jann Horn <jannh@google.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz> #slub

> ---
>  include/linux/kasan.h | 10 ++++++++++
>  mm/kasan/common.c     | 51 +++++++++++++++++++++++++++++++++++++++------------
>  mm/slub.c             |  7 +++++++
>  3 files changed, 56 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 70d6a8f6e25d..eee8ca1dcb40 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -175,6 +175,16 @@ static __always_inline void * __must_check kasan_init_slab_obj(
>  	return (void *)object;
>  }
>  
> +bool __kasan_slab_pre_free(struct kmem_cache *s, void *object,
> +			unsigned long ip);
> +static __always_inline bool kasan_slab_pre_free(struct kmem_cache *s,
> +						void *object)
> +{
> +	if (kasan_enabled())
> +		return __kasan_slab_pre_free(s, object, _RET_IP_);
> +	return false;
> +}
> +
>  bool __kasan_slab_free(struct kmem_cache *s, void *object,
>  			unsigned long ip, bool init);
>  static __always_inline bool kasan_slab_free(struct kmem_cache *s,
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 85e7c6b4575c..7c7fc6ce7eb7 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -208,31 +208,52 @@ void * __must_check __kasan_init_slab_obj(struct kmem_cache *cache,
>  	return (void *)object;
>  }
>  
> -static inline bool poison_slab_object(struct kmem_cache *cache, void *object,
> -				      unsigned long ip, bool init)
> +enum free_validation_result {
> +	KASAN_FREE_IS_IGNORED,
> +	KASAN_FREE_IS_VALID,
> +	KASAN_FREE_IS_INVALID
> +};
> +
> +static enum free_validation_result check_slab_free(struct kmem_cache *cache,
> +						void *object, unsigned long ip)
>  {
> -	void *tagged_object;
> +	void *tagged_object = object;
>  
> -	if (!kasan_arch_is_ready())
> -		return false;
> +	if (is_kfence_address(object) || !kasan_arch_is_ready())
> +		return KASAN_FREE_IS_IGNORED;
>  
> -	tagged_object = object;
>  	object = kasan_reset_tag(object);
>  
>  	if (unlikely(nearest_obj(cache, virt_to_slab(object), object) != object)) {
>  		kasan_report_invalid_free(tagged_object, ip, KASAN_REPORT_INVALID_FREE);
> -		return true;
> +		return KASAN_FREE_IS_INVALID;
>  	}
>  
> -	/* RCU slabs could be legally used after free within the RCU period. */
> -	if (unlikely(cache->flags & SLAB_TYPESAFE_BY_RCU))
> -		return false;
> -
>  	if (!kasan_byte_accessible(tagged_object)) {
>  		kasan_report_invalid_free(tagged_object, ip, KASAN_REPORT_DOUBLE_FREE);
> -		return true;
> +		return KASAN_FREE_IS_INVALID;
>  	}
>  
> +	return KASAN_FREE_IS_VALID;
> +}
> +
> +static inline bool poison_slab_object(struct kmem_cache *cache, void *object,
> +				      unsigned long ip, bool init)
> +{
> +	void *tagged_object = object;
> +	enum free_validation_result valid = check_slab_free(cache, object, ip);
> +
> +	if (valid == KASAN_FREE_IS_IGNORED)
> +		return false;
> +	if (valid == KASAN_FREE_IS_INVALID)
> +		return true;
> +
> +	object = kasan_reset_tag(object);
> +
> +	/* RCU slabs could be legally used after free within the RCU period. */
> +	if (unlikely(cache->flags & SLAB_TYPESAFE_BY_RCU))
> +		return false;
> +
>  	kasan_poison(object, round_up(cache->object_size, KASAN_GRANULE_SIZE),
>  			KASAN_SLAB_FREE, init);
>  
> @@ -242,6 +263,12 @@ static inline bool poison_slab_object(struct kmem_cache *cache, void *object,
>  	return false;
>  }
>  
> +bool __kasan_slab_pre_free(struct kmem_cache *cache, void *object,
> +				unsigned long ip)
> +{
> +	return check_slab_free(cache, object, ip) == KASAN_FREE_IS_INVALID;
> +}
> +
>  bool __kasan_slab_free(struct kmem_cache *cache, void *object,
>  				unsigned long ip, bool init)
>  {
> diff --git a/mm/slub.c b/mm/slub.c
> index 4927edec6a8c..34724704c52d 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2170,6 +2170,13 @@ bool slab_free_hook(struct kmem_cache *s, void *x, bool init)
>  	if (kfence_free(x))
>  		return false;
>  
> +	/*
> +	 * Give KASAN a chance to notice an invalid free operation before we
> +	 * modify the object.
> +	 */
> +	if (kasan_slab_pre_free(s, x))
> +		return false;
> +
>  	/*
>  	 * As memory initialization might be integrated into KASAN,
>  	 * kasan_slab_free and initialization memset's must be
> 


