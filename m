Return-Path: <linux-kernel+bounces-439092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A9A9EAAB1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 900C8280124
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 08:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740A72309AB;
	Tue, 10 Dec 2024 08:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WrXofa2J";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="o1+KVgnT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WrXofa2J";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="o1+KVgnT"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288E017BB2E
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 08:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733819404; cv=none; b=pkO2xSzUYUnLGOPCKXSz0rLIc+bydnvoJxHnKZFNSxXGTRZB6IzCbTniNIoZpt57DedlczhGz8uOyMjCDdVMhsKxJq2Yj3mwQaHJgTgkrnh/vy78Xhh7ZiWM7BepBSEdbh6ulHT8nhd2dO80TzmhsMXVxPX3uoQdlg7xcM9Vhcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733819404; c=relaxed/simple;
	bh=qrNOvDxx3fbuOS8s+8pRNWV6sZKe+kdAQsDyxE0R6Iw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tP1Fl/m20ynW1pKoRV2jTjxjP2o0IuJp6IxgyIROK0Unl/zPP6L7qgdqwpClNZvP6qCDw4m4ndB9guNi80n1vr5mEB8UHSrb/l/0BrHkP9ld5qK7nkCY8RRYvuwrT39jWP53ZkUkoU5YZgAhPHU4DlIDQNK825NHwqszY5CxI/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WrXofa2J; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=o1+KVgnT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WrXofa2J; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=o1+KVgnT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 03CE72116C;
	Tue, 10 Dec 2024 08:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733819400; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ApdSLR0r8cd970X2qr0oOIJrWO2V7cAKvQY5rDwxHLs=;
	b=WrXofa2JK+JbsXDnhzOMDmTAjc/vOe1RL0CmqEudu755eLGlqSfKuK1MA+h4XkA5OiNxES
	k6h6OCv1LhZn3M+4nX5s34iaeL2+/+ZFFAF4PMLUdxiG4FmUzUcJc/3MCecSAsm0W96qNN
	FERMOEz4a7xV4OH37miTxrjSAupVrL4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733819400;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ApdSLR0r8cd970X2qr0oOIJrWO2V7cAKvQY5rDwxHLs=;
	b=o1+KVgnT9tF7i2bJ1D9/8zB6tZwNEio4CTv8tegBVMqNMRZikedE9D7QHMzbi3pU7Ods6k
	Kv1XGwjruKfgt1Bg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733819400; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ApdSLR0r8cd970X2qr0oOIJrWO2V7cAKvQY5rDwxHLs=;
	b=WrXofa2JK+JbsXDnhzOMDmTAjc/vOe1RL0CmqEudu755eLGlqSfKuK1MA+h4XkA5OiNxES
	k6h6OCv1LhZn3M+4nX5s34iaeL2+/+ZFFAF4PMLUdxiG4FmUzUcJc/3MCecSAsm0W96qNN
	FERMOEz4a7xV4OH37miTxrjSAupVrL4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733819400;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ApdSLR0r8cd970X2qr0oOIJrWO2V7cAKvQY5rDwxHLs=;
	b=o1+KVgnT9tF7i2bJ1D9/8zB6tZwNEio4CTv8tegBVMqNMRZikedE9D7QHMzbi3pU7Ods6k
	Kv1XGwjruKfgt1Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D95A113A15;
	Tue, 10 Dec 2024 08:29:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vsy4NAf8V2d2HwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 10 Dec 2024 08:29:59 +0000
Message-ID: <5a047afd-1e9f-4e68-8c8a-d5b0b5506bb3@suse.cz>
Date: Tue, 10 Dec 2024 09:29:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] memcg: slub: fix SUnreclaim for post charged objects
To: Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosryahmed@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
References: <20241210040657.3441287-1-shakeel.butt@linux.dev>
From: Vlastimil Babka <vbabka@suse.cz>
Content-Language: en-US
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
In-Reply-To: <20241210040657.3441287-1-shakeel.butt@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 12/10/24 05:06, Shakeel Butt wrote:
> Large kmalloc directly allocates from the page allocator and then use
> lruvec_stat_mod_folio() to increment the unreclaimable slab stats for
> global and memcg. However when post memcg charging of slab objects was
> added in commit 9028cdeb38e1 ("memcg: add charging of already allocated
> slab objects"), it missed to correctly handle the unreclaimable slab
> stats for memcg.
> 
> One user visisble effect of that bug is that the node level
> unreclaimable slab stat will work correctly but the memcg level stat can
> underflow as kernel correctly handles the free path but the charge path
> missed to increment the memcg level unreclaimable slab stat. Let's fix
> by correctly handle in the post charge code path.
> 
> Fixes: 9028cdeb38e1 ("memcg: add charging of already allocated slab objects")

That's a 6.12-rc1 commit so I'm adding cc stable.

> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Queued in slab/for-next-fixes, thanks!

Vlastimil

> ---
>  mm/slub.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index f62c829b7b6b..88bf2bf51bd6 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2189,9 +2189,24 @@ bool memcg_slab_post_charge(void *p, gfp_t flags)
>  
>  	folio = virt_to_folio(p);
>  	if (!folio_test_slab(folio)) {
> -		return folio_memcg_kmem(folio) ||
> -			(__memcg_kmem_charge_page(folio_page(folio, 0), flags,
> -						  folio_order(folio)) == 0);
> +		int size;
> +
> +		if (folio_memcg_kmem(folio))
> +			return true;
> +
> +		if (__memcg_kmem_charge_page(folio_page(folio, 0), flags,
> +					     folio_order(folio)))
> +			return false;
> +
> +		/*
> +		 * This folio has already been accounted in the global stats but
> +		 * not in the memcg stats. So, subtract from the global and use
> +		 * the interface which adds to both global and memcg stats.
> +		 */
> +		size = folio_size(folio);
> +		node_stat_mod_folio(folio, NR_SLAB_UNRECLAIMABLE_B, -size);
> +		lruvec_stat_mod_folio(folio, NR_SLAB_UNRECLAIMABLE_B, size);
> +		return true;
>  	}
>  
>  	slab = folio_slab(folio);


