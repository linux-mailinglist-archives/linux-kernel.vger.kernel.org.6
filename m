Return-Path: <linux-kernel+bounces-268236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDCE94220F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 23:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71C361F21FEA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 21:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496CD18CC1E;
	Tue, 30 Jul 2024 21:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Sf/BCW7t";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UEgWLoyD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Sf/BCW7t";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UEgWLoyD"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D4E38B
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 21:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722374060; cv=none; b=IOC8Xq0vMm7gaP/Zz75AsFrK23w2rYcjt+Gfm2wwbmwf2TcdML5itt/ezxKbgApaswo3z0rRGfJE1dhofS7Yo5MERz0t0+B9uozc3rRPn7Jh0VDs/Gp1XTB3rsW33VS6/+zmY0SF0nzU4+43jSORX9wsny1AAwYWg0N4GzJuvk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722374060; c=relaxed/simple;
	bh=F9CL40JyaG4PFAV9Sy5MzHQt8AHA7SPjA7mzTqSiDMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=et1y2A81hlYbDtpnRZZ3z95JUm2M2eMv8wpmq3vYTprWrvTgkck8zpJGE8BYYht6vbHaXqcPP2kbAPc0TaLr4UsRuQTuJaZs33Mio/U2t+GDbSvyY90XUbEb2xA5K9F5p3S6998MeHJ/1JCHsouian6T9cANXmznlpQ2xRefeqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Sf/BCW7t; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UEgWLoyD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Sf/BCW7t; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UEgWLoyD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7EC07219C6;
	Tue, 30 Jul 2024 21:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722374056; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XAGax8LVb3jlQZ8uD9QYjv/FlOREfiX45HtE90u8OzI=;
	b=Sf/BCW7t+l8/2J1eAFRbmrhnR5C6rQe/l6qsJ1nqbjSH9hni8QjtfZM4bhdkkbli1OFOQ2
	1dAQBZXFEiUYMrs8PAajYg2OQUdUInQp0B5J+e4QcQLQZQrWv7rjyDofsmn2zWKqz4mTjx
	VGh0UCgTS2qOG25QxonFrvNGc0xNFdU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722374056;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XAGax8LVb3jlQZ8uD9QYjv/FlOREfiX45HtE90u8OzI=;
	b=UEgWLoyDAdwR3ti1mcouivZztOXGpbJxdr/1Aar6fJUbGPleNA+F0IYUgkkMorpeS2h3Dl
	ra9YayScs+Wv6iAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="Sf/BCW7t";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=UEgWLoyD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722374056; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XAGax8LVb3jlQZ8uD9QYjv/FlOREfiX45HtE90u8OzI=;
	b=Sf/BCW7t+l8/2J1eAFRbmrhnR5C6rQe/l6qsJ1nqbjSH9hni8QjtfZM4bhdkkbli1OFOQ2
	1dAQBZXFEiUYMrs8PAajYg2OQUdUInQp0B5J+e4QcQLQZQrWv7rjyDofsmn2zWKqz4mTjx
	VGh0UCgTS2qOG25QxonFrvNGc0xNFdU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722374056;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XAGax8LVb3jlQZ8uD9QYjv/FlOREfiX45HtE90u8OzI=;
	b=UEgWLoyDAdwR3ti1mcouivZztOXGpbJxdr/1Aar6fJUbGPleNA+F0IYUgkkMorpeS2h3Dl
	ra9YayScs+Wv6iAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6489513983;
	Tue, 30 Jul 2024 21:14:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oYbpF6hXqWYlWQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 30 Jul 2024 21:14:16 +0000
Message-ID: <66836dd6-b0c2-4f77-b2a3-c43296aa6c93@suse.cz>
Date: Tue, 30 Jul 2024 23:14:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: krealloc: consider spare memory for __GFP_ZERO
Content-Language: en-US
To: Danilo Krummrich <dakr@kernel.org>, akpm@linux-foundation.org,
 cl@linux.com, penberg@kernel.org, rientjes@google.com,
 iamjoonsoo.kim@lge.com, roman.gushchin@linux.dev, 42.hyeyoo@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kasan-dev <kasan-dev@googlegroups.com>
References: <20240730194214.31483-1-dakr@kernel.org>
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
In-Reply-To: <20240730194214.31483-1-dakr@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 7EC07219C6
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
	TAGGED_RCPT(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,linux-foundation.org,linux.com,google.com,lge.com,linux.dev,gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]

On 7/30/24 9:42 PM, Danilo Krummrich wrote:
> As long as krealloc() is called with __GFP_ZERO consistently, starting
> with the initial memory allocation, __GFP_ZERO should be fully honored.
> 
> However, if for an existing allocation krealloc() is called with a
> decreased size, it is not ensured that the spare portion the allocation
> is zeroed. Thus, if krealloc() is subsequently called with a larger size
> again, __GFP_ZERO can't be fully honored, since we don't know the
> previous size, but only the bucket size.
> 
> Example:
> 
> 	buf = kzalloc(64, GFP_KERNEL);
> 	memset(buf, 0xff, 64);
> 
> 	buf = krealloc(buf, 48, GFP_KERNEL | __GFP_ZERO);
> 
> 	/* After this call the last 16 bytes are still 0xff. */
> 	buf = krealloc(buf, 64, GFP_KERNEL | __GFP_ZERO);
> 
> Fix this, by explicitly setting spare memory to zero, when shrinking an
> allocation with __GFP_ZERO flag set or init_on_alloc enabled.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  mm/slab_common.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 40b582a014b8..cff602cedf8e 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1273,6 +1273,13 @@ __do_krealloc(const void *p, size_t new_size, gfp_t flags)
>  
>  	/* If the object still fits, repoison it precisely. */
>  	if (ks >= new_size) {
> +		/* Zero out spare memory. */
> +		if (want_init_on_alloc(flags)) {
> +			kasan_disable_current();
> +			memset((void *)p + new_size, 0, ks - new_size);
> +			kasan_enable_current();

If we do kasan_krealloc() first, shouldn't the memset then be legal
afterwards without the disable/enable dance?

> +		}
> +
>  		p = kasan_krealloc((void *)p, new_size, flags);
>  		return (void *)p;
>  	}
> 
> base-commit: 7c3dd6d99f2df6a9d7944ee8505b195ba51c9b68


