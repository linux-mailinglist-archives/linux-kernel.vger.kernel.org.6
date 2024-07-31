Return-Path: <linux-kernel+bounces-269362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C872943207
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 16:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73F801C21C06
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796311BB6BD;
	Wed, 31 Jul 2024 14:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sRcRseK/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yOjHPtns";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lgYEkuBz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bGXxIJpY"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37C926AE4
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 14:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722436289; cv=none; b=Q/dGFweqzBL0K/C/CRq5w08vwPLuMre/ReZNqMAQZ2It8l0WVi/FGwnhvCD1hFFwV0dbGg3/tIGts6cQi9hxbZo484a1n1cklDNutbv8Sci5csn72aTmGbmXwSyHiP5W6ZFYMIjI5TlF/DYhwEradYGtYiDWtI1tNHWOLA9czdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722436289; c=relaxed/simple;
	bh=s/dNb0WJgGXT+WqLobWyc56rEYkYqU2y4Fz3kPl1C9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ME/WM2JptiT85NdYnExoG/0G2mRsviP9ZS4gofxcZ7vTE+r/qz/KZCoGaSHc5zAADIBM21UmNTvkzIwm2pZCSmVwc2qkoS8m+tpsfgLjmLPzRYVb3pej0byg/TIDQFUUEDMSYJb/5zUtZNeeIPdbOT+y9B0MKAoMranqqvD1Jag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sRcRseK/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yOjHPtns; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lgYEkuBz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bGXxIJpY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D1F1F1F809;
	Wed, 31 Jul 2024 14:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722436275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OuZbBveZ6qairsKxQDumRPqX5vJlLgj+W3IqJApmEx8=;
	b=sRcRseK/0LwGuBNqPg33L2SuPW28LvklKNxglWLZTB+N8qejqqqdqWWRiUx5MLDR3vMkXS
	udaZc4P9X63iBtdOOILrWXaLuuzmk9VEb+wf25SOdxBCNeRcE8FSW4JIlvasJe+fSvIBLe
	EB0gTO27tTqfR8b/oHJ02tOrtNBG9Ow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722436275;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OuZbBveZ6qairsKxQDumRPqX5vJlLgj+W3IqJApmEx8=;
	b=yOjHPtnsULK72mYpLBQV/9tuy1FbgnhVqbDjiNZ4Yy8ChbIbSaBxudXv6UGhLJd7J8phOE
	L2tQ/X/v5xYwciDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=lgYEkuBz;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=bGXxIJpY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722436274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OuZbBveZ6qairsKxQDumRPqX5vJlLgj+W3IqJApmEx8=;
	b=lgYEkuBzStNoVtSWVBanDNuEROnjL6qfLcQdwm4Q5tL4IaJVEAFMbdTkKbAVDSPhLZVqnZ
	BWXDjP0CRFoA0jGIJPb2Mib0iIMTG376g8wkItaXX+2yi5lpnxkzk/m+Wz1rSsc012lrK6
	fcDobCtKOqpFhVMzB7QDyShJyl3RqGs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722436274;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OuZbBveZ6qairsKxQDumRPqX5vJlLgj+W3IqJApmEx8=;
	b=bGXxIJpYYF+s83qeXIYVtbm9vTFTEJX9cKs1hbaWM07zn1pEdz5XEi0cmTtEm1a0t73KD7
	Ed4rAnxqV4cxHqCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD8FC13297;
	Wed, 31 Jul 2024 14:31:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ye3lLbJKqmYKdQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 31 Jul 2024 14:31:14 +0000
Message-ID: <17d83377-4904-49a3-9b3e-2ea0aefd9885@suse.cz>
Date: Wed, 31 Jul 2024 16:31:14 +0200
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
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240730194214.31483-1-dakr@kernel.org>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20240730194214.31483-1-dakr@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_TO(0.00)[kernel.org,linux-foundation.org,linux.com,google.com,lge.com,linux.dev,gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Rspamd-Queue-Id: D1F1F1F809

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

Acked-by: Vlastimil Babka <vbabka@suse.cz>

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
> +		}
> +
>  		p = kasan_krealloc((void *)p, new_size, flags);
>  		return (void *)p;
>  	}
> 
> base-commit: 7c3dd6d99f2df6a9d7944ee8505b195ba51c9b68


