Return-Path: <linux-kernel+bounces-347347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B93A698D17F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1ED91B23479
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFFD1E7650;
	Wed,  2 Oct 2024 10:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="D3HHB9Aj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GHdgaA3K";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="n+nX3td7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zXY3otUj"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9211E764F
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 10:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727865762; cv=none; b=sUgarqKtyyPUQz/aFwRtsRdO1QWRuF3IAz5RwtwmijZwhIW9N1TkzOmky6pwWVTX5KvBcB4LetxK0p4ZXVVO5S+xv1TIcjtuz68HwHxEsSFofcQuVESSO2j1efHpe2DyGNr3fHKPD/OcB/4kMoWFX0B9J6AJ12H3kyoJTmJD0m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727865762; c=relaxed/simple;
	bh=IjyX866zUqFSHScBH2wCInJ0M/ajLXhNO06Yjn23UcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bZTteqIraOfNx66pJDgHQKnlYOEZs1AlfJojVif+ntDACJ+/kX/AFRIrkfIgPfnuwIVZFNo5FbfR0CguJBRnO4aZepluZS94miNt4z3ZFLRCkVms9XRfV5Ar4Z2N9BsFPGh9jIcOCucZcsG6gtCAwQT97OdLYp2kbx7oY3BUTgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=D3HHB9Aj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GHdgaA3K; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=n+nX3td7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zXY3otUj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 01C1E21B6B;
	Wed,  2 Oct 2024 10:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727865757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=i8E6YBx9IYbiLWKiah4rdepV2BvjUAiHQI2nwFPWPZ0=;
	b=D3HHB9AjNwYgMc3VhVPiIJD2izvWdgar//7BYL3WPawh2Tuk39sF6SonERKMWs9oaUUc4Q
	WgZDTJc7WbbAicicCNkJqpy0Ocs5bjSGw6Zmhp8tJcbK8w7YeznFgXJBSlvCM5hJ+FFbbG
	1rTxyDQzN71xhZkPIZC5R44asQPStB0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727865757;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=i8E6YBx9IYbiLWKiah4rdepV2BvjUAiHQI2nwFPWPZ0=;
	b=GHdgaA3KZClH+zMENSiK3N87gGMuNLuJ2ghsVmrv2OngDZCpVfOJFcFrYEixo99ZQHYwYr
	19SkNSK72dfxDDBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727865756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=i8E6YBx9IYbiLWKiah4rdepV2BvjUAiHQI2nwFPWPZ0=;
	b=n+nX3td72Pmug+iRGp07qqXmza7HUvjKeZ+MqyVx9xAngA8TLENe1a3yiQly+5wb4nJlmI
	+gdUVfFqf8+t2FtHmVqHVMd7fzs+bVMAHIFsCC8Nq6GIKP08k1NY2cGMJ5thqWaojyVHgG
	Mn0qGmbJuPusLGzBv+5GCX6bHkOvJUs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727865756;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=i8E6YBx9IYbiLWKiah4rdepV2BvjUAiHQI2nwFPWPZ0=;
	b=zXY3otUjihty6GUnBScB+KdawB30wGXPGnzT4KHOD744wkXeODX5x70FabX3nE+nsLr/fi
	YNlc3alxFfeS+rDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD31713A6E;
	Wed,  2 Oct 2024 10:42:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lrrFMZsj/WbFZgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 02 Oct 2024 10:42:35 +0000
Message-ID: <d3dd32ba-2866-40ce-ad2b-a147dcd2bf86@suse.cz>
Date: Wed, 2 Oct 2024 12:42:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] mm/slub: Improve data handling of krealloc() when
 orig_size is enabled
Content-Language: en-US
To: Feng Tang <feng.tang@intel.com>, Andrew Morton
 <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>,
 Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Andrey Konovalov
 <andreyknvl@gmail.com>, Marco Elver <elver@google.com>,
 Shuah Khan <skhan@linuxfoundation.org>, David Gow <davidgow@google.com>,
 Danilo Krummrich <dakr@kernel.org>, Alexander Potapenko <glider@google.com>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>, Dmitry Vyukov
 <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-mm@kvack.org, kasan-dev@googlegroups.com,
 linux-kernel@vger.kernel.org
References: <20240911064535.557650-1-feng.tang@intel.com>
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
In-Reply-To: <20240911064535.557650-1-feng.tang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[intel.com,linux-foundation.org,linux.com,kernel.org,google.com,lge.com,linux.dev,gmail.com,linuxfoundation.org,arm.com];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.80
X-Spam-Flag: NO

On 9/11/24 08:45, Feng Tang wrote:
> Danilo Krummrich's patch [1] raised one problem about krealloc() that
> its caller doesn't pass the old request size, say the object is 64
> bytes kmalloc one, but caller originally only requested 48 bytes. Then
> when krealloc() shrinks or grows in the same object, or allocate a new
> bigger object, it lacks this 'original size' information to do accurate
> data preserving or zeroing (when __GFP_ZERO is set).
> 
> Thus with slub debug redzone and object tracking enabled, parts of the
> object after krealloc() might contain redzone data instead of zeroes,
> which is violating the __GFP_ZERO guarantees. Good thing is in this
> case, kmalloc caches do have this 'orig_size' feature, which could be
> used to improve the situation here.
> 
> To make the 'orig_size' accurate, we adjust some kasan/slub meta data
> handling. Also add a slub kunit test case for krealloc().
> 
> This patchset has dependency over patches in both -mm tree and -slab
> trees, so it is written based on linux-next tree '20240910' version.
> 
> [1]. https://lore.kernel.org/lkml/20240812223707.32049-1-dakr@kernel.org/

Thanks, added to slab/for-next

> 
> Thanks,
> Feng
> 
> Changelog:
> 
>   Since v1:
>   * Drop the patch changing generic kunit code from this patchset,
>     and will send it separately.
>   * Separate the krealloc moving form slab_common.c to slub.c to a 
>     new patch for better review (Danilo/Vlastimil)
>   * Improve commit log and comments (Vlastimil/Danilo) 
>   * Rework the kunit test case to remove its dependency over
>     slub_debug (which is incomplete in v1) (Vlastimil)
>   * Add ack and review tag from developers.
> 
> Feng Tang (5):
>   mm/kasan: Don't store metadata inside kmalloc object when
>     slub_debug_orig_size is on
>   mm/slub: Consider kfence case for get_orig_size()
>   mm/slub: Move krealloc() and related code to slub.c
>   mm/slub: Improve redzone check and zeroing for krealloc()
>   mm/slub, kunit: Add testcase for krealloc redzone and zeroing
> 
>  lib/slub_kunit.c   |  42 +++++++++++++++
>  mm/kasan/generic.c |   7 ++-
>  mm/slab.h          |   6 +++
>  mm/slab_common.c   |  84 ------------------------------
>  mm/slub.c          | 125 ++++++++++++++++++++++++++++++++++++++-------
>  5 files changed, 160 insertions(+), 104 deletions(-)
> 


