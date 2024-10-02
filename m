Return-Path: <linux-kernel+bounces-347439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DC598D2C0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B6AB1C219DC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B2D1CF5F8;
	Wed,  2 Oct 2024 12:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uCQpOEev";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="p/PrOTMG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uCQpOEev";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="p/PrOTMG"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A261CF5F9
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 12:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727870974; cv=none; b=WPN4ld+8EsRug003ElL+W4vOJeE3sXjurA3egWPrZekmzu03VXYU65XxvQJEk79P8z2AkH6sbMKIfRIqKJYeD0GJPH6aDFX+SILhmhOWl99POQ39O1iZrDTRK2f+PLX+qC7Jolwb4XSzJhI7XYNGIB1Q0xx5+amO/EsUY0crPAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727870974; c=relaxed/simple;
	bh=4jd211YQYQU4gzqr7DVYD5h45aohOPU1wZJRM+lAqgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=W2dgS4gdrRsAOaDsZfl9X4p1YLxiTrKDiKm23+6SLbobHUwS2uJzoUnVMIGjORQk+JVhJ677UlK4N5C7ed8BbS7FzG7wEBrxbN6NsSd/D3rLuaqf0+ILU0UYZVwP83Z2VGUUlXTbwAhQtDRdTmN8cvT7UzWbbjLvofUMl9CnMj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uCQpOEev; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=p/PrOTMG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uCQpOEev; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=p/PrOTMG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1D63821BAF;
	Wed,  2 Oct 2024 12:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727870971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eye96+7HSXT6nu/JM5zabUMkyUuxngRNpv5ElZUqX4c=;
	b=uCQpOEevKq7to4n31ympq/TYVAB9loUaPhDfOITUgHSLXwEmRpEuhwyxUQbpKvjW+ORUIH
	G3X4/3WNSO+W+udmzBXYzTyOTbR4hu8uGbksHSfYXDtJqsIjLQC1e4X5oW/QVfzeSZzWik
	aIQ2O6v8OCkWDP3fXpdaCOmYBYJ1q8k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727870971;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eye96+7HSXT6nu/JM5zabUMkyUuxngRNpv5ElZUqX4c=;
	b=p/PrOTMGGm88jrN5vD7exhmAjgohcls5kA3u4CFexFt34Fe7Mynf6QEJnzBuphJ8m0CQE7
	v48fuUZTEoKfeuAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=uCQpOEev;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="p/PrOTMG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727870971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eye96+7HSXT6nu/JM5zabUMkyUuxngRNpv5ElZUqX4c=;
	b=uCQpOEevKq7to4n31ympq/TYVAB9loUaPhDfOITUgHSLXwEmRpEuhwyxUQbpKvjW+ORUIH
	G3X4/3WNSO+W+udmzBXYzTyOTbR4hu8uGbksHSfYXDtJqsIjLQC1e4X5oW/QVfzeSZzWik
	aIQ2O6v8OCkWDP3fXpdaCOmYBYJ1q8k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727870971;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eye96+7HSXT6nu/JM5zabUMkyUuxngRNpv5ElZUqX4c=;
	b=p/PrOTMGGm88jrN5vD7exhmAjgohcls5kA3u4CFexFt34Fe7Mynf6QEJnzBuphJ8m0CQE7
	v48fuUZTEoKfeuAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0303513974;
	Wed,  2 Oct 2024 12:09:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4rsMAPs3/WZ6BAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 02 Oct 2024 12:09:30 +0000
Message-ID: <4dadf9be-a349-4a19-ae9c-652ade9e2198@suse.cz>
Date: Wed, 2 Oct 2024 14:09:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm/slab: remove duplicate check in create_cache()
Content-Language: en-US
To: Zhen Lei <thunder.leizhen@huawei.com>, Christoph Lameter <cl@linux.com>,
 Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240821032637.1930-1-thunder.leizhen@huawei.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 xsFNBFZdmxYBEADsw/SiUSjB0dM+vSh95UkgcHjzEVBlby/Fg+g42O7LAEkCYXi/vvq31JTB
 KxRWDHX0R2tgpFDXHnzZcQywawu8eSq0LxzxFNYMvtB7sV1pxYwej2qx9B75qW2plBs+7+YB
 87tMFA+u+L4Z5xAzIimfLD5EKC56kJ1CsXlM8S/LHcmdD9Ctkn3trYDNnat0eoAcfPIP2OZ+
 9oe9IF/R28zmh0ifLXyJQQz5ofdj4bPf8ecEW0rhcqHfTD8k4yK0xxt3xW+6Exqp9n9bydiy
 tcSAw/TahjW6yrA+6JhSBv1v2tIm+itQc073zjSX8OFL51qQVzRFr7H2UQG33lw2QrvHRXqD
 Ot7ViKam7v0Ho9wEWiQOOZlHItOOXFphWb2yq3nzrKe45oWoSgkxKb97MVsQ+q2SYjJRBBH4
 8qKhphADYxkIP6yut/eaj9ImvRUZZRi0DTc8xfnvHGTjKbJzC2xpFcY0DQbZzuwsIZ8OPJCc
 LM4S7mT25NE5kUTG/TKQCk922vRdGVMoLA7dIQrgXnRXtyT61sg8PG4wcfOnuWf8577aXP1x
 6mzw3/jh3F+oSBHb/GcLC7mvWreJifUL2gEdssGfXhGWBo6zLS3qhgtwjay0Jl+kza1lo+Cv
 BB2T79D4WGdDuVa4eOrQ02TxqGN7G0Biz5ZLRSFzQSQwLn8fbwARAQABzSBWbGFzdGltaWwg
 QmFia2EgPHZiYWJrYUBzdXNlLmN6PsLBlAQTAQoAPgIbAwULCQgHAwUVCgkICwUWAgMBAAIe
 AQIXgBYhBKlA1DSZLC6OmRA9UCJPp+fMgqZkBQJkBREIBQkRadznAAoJECJPp+fMgqZkNxIQ
 ALZRqwdUGzqL2aeSavbum/VF/+td+nZfuH0xeWiO2w8mG0+nPd5j9ujYeHcUP1edE7uQrjOC
 Gs9sm8+W1xYnbClMJTsXiAV88D2btFUdU1mCXURAL9wWZ8Jsmz5ZH2V6AUszvNezsS/VIT87
 AmTtj31TLDGwdxaZTSYLwAOOOtyqafOEq+gJB30RxTRE3h3G1zpO7OM9K6ysLdAlwAGYWgJJ
 V4JqGsQ/lyEtxxFpUCjb5Pztp7cQxhlkil0oBYHkudiG8j1U3DG8iC6rnB4yJaLphKx57NuQ
 PIY0Bccg+r9gIQ4XeSK2PQhdXdy3UWBr913ZQ9AI2usid3s5vabo4iBvpJNFLgUmxFnr73SJ
 KsRh/2OBsg1XXF/wRQGBO9vRuJUAbnaIVcmGOUogdBVS9Sun/Sy4GNA++KtFZK95U7J417/J
 Hub2xV6Ehc7UGW6fIvIQmzJ3zaTEfuriU1P8ayfddrAgZb25JnOW7L1zdYL8rXiezOyYZ8Fm
 ZyXjzWdO0RpxcUEp6GsJr11Bc4F3aae9OZtwtLL/jxc7y6pUugB00PodgnQ6CMcfR/HjXlae
 h2VS3zl9+tQWHu6s1R58t5BuMS2FNA58wU/IazImc/ZQA+slDBfhRDGYlExjg19UXWe/gMcl
 De3P1kxYPgZdGE2eZpRLIbt+rYnqQKy8UxlszsBNBFsZNTUBCACfQfpSsWJZyi+SHoRdVyX5
 J6rI7okc4+b571a7RXD5UhS9dlVRVVAtrU9ANSLqPTQKGVxHrqD39XSw8hxK61pw8p90pg4G
 /N3iuWEvyt+t0SxDDkClnGsDyRhlUyEWYFEoBrrCizbmahOUwqkJbNMfzj5Y7n7OIJOxNRkB
 IBOjPdF26dMP69BwePQao1M8Acrrex9sAHYjQGyVmReRjVEtv9iG4DoTsnIR3amKVk6si4Ea
 X/mrapJqSCcBUVYUFH8M7bsm4CSxier5ofy8jTEa/CfvkqpKThTMCQPNZKY7hke5qEq1CBk2
 wxhX48ZrJEFf1v3NuV3OimgsF2odzieNABEBAAHCwXwEGAEKACYCGwwWIQSpQNQ0mSwujpkQ
 PVAiT6fnzIKmZAUCZAUSmwUJDK5EZgAKCRAiT6fnzIKmZOJGEACOKABgo9wJXsbWhGWYO7mD
 8R8mUyJHqbvaz+yTLnvRwfe/VwafFfDMx5GYVYzMY9TWpA8psFTKTUIIQmx2scYsRBUwm5VI
 EurRWKqENcDRjyo+ol59j0FViYysjQQeobXBDDE31t5SBg++veI6tXfpco/UiKEsDswL1WAr
 tEAZaruo7254TyH+gydURl2wJuzo/aZ7Y7PpqaODbYv727Dvm5eX64HCyyAH0s6sOCyGF5/p
 eIhrOn24oBf67KtdAN3H9JoFNUVTYJc1VJU3R1JtVdgwEdr+NEciEfYl0O19VpLE/PZxP4wX
 PWnhf5WjdoNI1Xec+RcJ5p/pSel0jnvBX8L2cmniYnmI883NhtGZsEWj++wyKiS4NranDFlA
 HdDM3b4lUth1pTtABKQ1YuTvehj7EfoWD3bv9kuGZGPrAeFNiHPdOT7DaXKeHpW9homgtBxj
 8aX/UkSvEGJKUEbFL9cVa5tzyialGkSiZJNkWgeHe+jEcfRT6pJZOJidSCdzvJpbdJmm+eED
 w9XOLH1IIWh7RURU7G1iOfEfmImFeC3cbbS73LQEFGe1urxvIH5K/7vX+FkNcr9ujwWuPE9b
 1C2o4i/yZPLXIVy387EjA6GZMqvQUFuSTs/GeBcv0NjIQi8867H3uLjz+mQy63fAitsDwLmR
 EP+ylKVEKb0Q2A==
In-Reply-To: <20240821032637.1930-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 1D63821BAF
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TAGGED_RCPT(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[huawei.com,linux.com,kernel.org,google.com,lge.com,linux-foundation.org,linux.dev,gmail.com,kvack.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

On 8/21/24 05:26, Zhen Lei wrote:
> The WARN_ON() check in static function create_cache() is done by its only
> parent kmem_cache_create_usercopy() before calling it.
> 	if (...
> 	    WARN_ON(size < usersize || size - usersize < useroffset))
> 		usersize = useroffset = 0;
> 	...
> 	s = create_cache(..., size, ..., useroffset, usersize, ...);
> 
> Therefore, the WARN_ON() check in create_cache() can be safely removed.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Hi, sorry for the late reply.
This code was heavily refactored as of 6.12-rc1. Can you check if it's still
the case and send updated patch?
Thanks,
Vlastimil

> ---
>  mm/slab_common.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 40b582a014b8f2f..3069c9095523484 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -210,9 +210,6 @@ static struct kmem_cache *create_cache(const char *name,
>  	struct kmem_cache *s;
>  	int err;
>  
> -	if (WARN_ON(useroffset + usersize > object_size))
> -		useroffset = usersize = 0;
> -
>  	err = -ENOMEM;
>  	s = kmem_cache_zalloc(kmem_cache, GFP_KERNEL);
>  	if (!s)


