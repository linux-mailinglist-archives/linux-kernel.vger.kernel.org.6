Return-Path: <linux-kernel+bounces-277745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FFF94A5A5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 12:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64AE61C210F1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782661DD3B5;
	Wed,  7 Aug 2024 10:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WCjZymr5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kacA7n7Z";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WCjZymr5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kacA7n7Z"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDC61D3641
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 10:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723026882; cv=none; b=Dqlxw4RB0WC0qKAEzr6U1Vc5x/NuRc4eftXYkpiaTi3wt3ELboSKjlZar35KsdMmc2YqBLD58xPDYvLr727eQMQSVHWAYn4vUJDiKTw12Q9zzapsUPz2MVuVvk+RDYg2zWVgi5RpQjcG156+XRu41cry9sTMG4+2AwmZUrdxaos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723026882; c=relaxed/simple;
	bh=RM2zTsfTmYwjLgEaNFtP9kWNdfS6XLKtGB/YbgCCXro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WVDiOmNvgsoX+in3nETD2naZvGNYt2cUvLFOrwf8UzaxI+wkLdKl/+h4GpXugleqTzJ2zzSGjoUF7ntKCNX+ZyN2Q4gWarSeUZvwNPdCnyWg9qPohxB8cplUU0U3PHc0bDxEyj60mkhaCfy3GhCSdVqYAeT3G8RxSyrXk87B2qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WCjZymr5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kacA7n7Z; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WCjZymr5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kacA7n7Z; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E11B221D05;
	Wed,  7 Aug 2024 10:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723026878; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=St1W696W8Wp5SNFYj9xdHue1hGJpxWYLvydA0+nkKhc=;
	b=WCjZymr59KD7e/bIhrEVm7ZMWuGdAlb+s/7qrOPLpZySfO3ZTKE7LmDQ+EEyh8JkV9fv14
	N5Y6Jo+1xxghtjm+nYnX+7mhxmhhpN5U5+0LNLG69JBd9tOlUTerylENDZdjIq+GstgHUn
	b3EreM9nVefE/AGO36rS6uEPx4V5+wk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723026878;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=St1W696W8Wp5SNFYj9xdHue1hGJpxWYLvydA0+nkKhc=;
	b=kacA7n7ZDldHciEaRBOOY4IXTgXyk+snyDTUqqkWO/0HbYzyF9HkV2rf2VOH+buBKrTUvk
	Nng3eb5P0+BUGBAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=WCjZymr5;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=kacA7n7Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723026878; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=St1W696W8Wp5SNFYj9xdHue1hGJpxWYLvydA0+nkKhc=;
	b=WCjZymr59KD7e/bIhrEVm7ZMWuGdAlb+s/7qrOPLpZySfO3ZTKE7LmDQ+EEyh8JkV9fv14
	N5Y6Jo+1xxghtjm+nYnX+7mhxmhhpN5U5+0LNLG69JBd9tOlUTerylENDZdjIq+GstgHUn
	b3EreM9nVefE/AGO36rS6uEPx4V5+wk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723026878;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=St1W696W8Wp5SNFYj9xdHue1hGJpxWYLvydA0+nkKhc=;
	b=kacA7n7ZDldHciEaRBOOY4IXTgXyk+snyDTUqqkWO/0HbYzyF9HkV2rf2VOH+buBKrTUvk
	Nng3eb5P0+BUGBAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C795913297;
	Wed,  7 Aug 2024 10:34:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BGBUML5Ns2YwIAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 07 Aug 2024 10:34:38 +0000
Message-ID: <6de91cc3-3942-471b-9f89-5eec144fb33e@suse.cz>
Date: Wed, 7 Aug 2024 12:34:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] slab: Warn on duplicate cache names when DEBUG_VM=y
To: Pedro Falcato <pedro.falcato@gmail.com>, Christoph Lameter
 <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240807090746.2146479-1-pedro.falcato@gmail.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20240807090746.2146479-1-pedro.falcato@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com,linux.com,kernel.org,google.com,lge.com,linux-foundation.org];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,kvack.org,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.00
X-Rspamd-Queue-Id: E11B221D05

On 8/7/24 11:07, Pedro Falcato wrote:
> Duplicate slab cache names can create havoc for userspace tooling that
> expects slab cache names to be unique. This is a reasonable expectation.
> 
> Sadly, too many duplicate name problems are out there in the wild, so
> simply pr_warn instead of pr_err() + failing the sanity check.
> 
> Link: https://lore.kernel.org/linux-fsdevel/2d1d053da1cafb3e7940c4f25952da4f0af34e38.1722293276.git.osandov@fb.com/
> Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
> ---
> v2:
>  - Replace the pr_err() + failure with a simple pr_warn
> 
> Contrary to Vlastimil's suggestion, we don't seem to require a refcount
> == 0 check, because shutdown_cache already synchronously deletes the cache from the list (even reusing
> the same list_head for TYPESAFE_BY_RCU).

It's not deleted when leaked objects are detected and the destroy is
aborted. But in this series that should no longer happen so then it will be
fine:

https://lore.kernel.org/all/20240807-b4-slab-kfree_rcu-destroy-v2-0-ea79102f428c@suse.cz/

> 
>  mm/slab_common.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 40b582a014b..1abe6a577d5 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -88,6 +88,19 @@ unsigned int kmem_cache_size(struct kmem_cache *s)
>  EXPORT_SYMBOL(kmem_cache_size);
>  
>  #ifdef CONFIG_DEBUG_VM
> +
> +static bool kmem_cache_is_duplicate_name(const char *name)
> +{
> +	struct kmem_cache *s;
> +
> +	list_for_each_entry(s, &slab_caches, list) {
> +		if (!strcmp(s->name, name))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  static int kmem_cache_sanity_check(const char *name, unsigned int size)
>  {
>  	if (!name || in_interrupt() || size > KMALLOC_MAX_SIZE) {
> @@ -95,6 +108,11 @@ static int kmem_cache_sanity_check(const char *name, unsigned int size)
>  		return -EINVAL;
>  	}
>  
> +	if (kmem_cache_is_duplicate_name(name)) {
> +		/* Duplicate names will confuse slabtop, et al */
> +		pr_warn("%s: name %s already exists as a cache\n", __func__, name);
> +	}
> +
>  	WARN_ON(strchr(name, ' '));	/* It confuses parsers */
>  	return 0;
>  }


