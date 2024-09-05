Return-Path: <linux-kernel+bounces-317105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A63096D93D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10E391F2871F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60B619F408;
	Thu,  5 Sep 2024 12:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hQ6nKlAN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FmsFxgOu";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dddorioK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="I0m1GDz3"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EE919B5BB
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 12:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725540350; cv=none; b=kAIWzmONS9qKaFtWFQtY5SeboK3y1/ntxfmexSqsK/zE1grpKSm7s/HU47dTh8MViVevzWXx+95QdfOvcnLPRbheucBswCiSAsqlekNdnknJXoz9cRy8ne0uwRFNLknv75V6aG7NzjH+9TEk46KxTU617Xhvef38LMKw1b1O4ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725540350; c=relaxed/simple;
	bh=0mwPn/z139+ZlSLvVphEc+vg74t5eI3Z/4ZEPnYUSeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sa6M5C33vHiZJ+vQwNr8ZBjSviCcr9CWkTufwWdiWiIFDv5pOSzohpW063z7uXdFKfOwmCJR7c6LzCmo2A70yuGqY8FXeX9cH55U9o9Cdf+vIbaSd8dGMByy0ra9ocoCipUWqnagau7QpwPNROnAG7d4bUqKYf4ysBepfcVUdBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hQ6nKlAN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FmsFxgOu; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dddorioK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=I0m1GDz3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 911A22191F;
	Thu,  5 Sep 2024 12:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725540346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rRhc8o319Ph1eMZHwHQe73JokXWCLinHStXSk/wYilU=;
	b=hQ6nKlANCeSDV+pGXzsUg1y7PsC2LHYrpISheasjcJ/bu4ue5+T+r+W/chOdzE7KN09xsh
	86De0w5zZvPtEwIBv5RrPZ6hTbuEzB1aUXoWp8rLz07Hhh8FR1+Gkxpg7cHR8RK5wbCWdP
	9ZdZwZD+1WkySOByR8rJ+T+hcpMj9Do=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725540346;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rRhc8o319Ph1eMZHwHQe73JokXWCLinHStXSk/wYilU=;
	b=FmsFxgOugT0w+0c6T6v12y4CtFYM1JtQuK/THJZfrMEJvuQ0vbaavCbHtTYbmB6xoGd/F7
	2d6fRF6/E8fiE7Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725540345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rRhc8o319Ph1eMZHwHQe73JokXWCLinHStXSk/wYilU=;
	b=dddorioKnUOp9KjCSPBzyPbR4sC5213qdCi4JTOe7BffiXml4PHBuJalOS5hF+MLOh9hZX
	nw1ZTIliAuU0UFAX1ZQ0Q4sU2QMKTlvG6plHWupOCDNM/6L7H5XLMMDzowI2uD4qqJFptR
	TTcG69Ba13KxtNoV+XdDPf154YIrEWQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725540345;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rRhc8o319Ph1eMZHwHQe73JokXWCLinHStXSk/wYilU=;
	b=I0m1GDz3U3mpBd31JBmIQQZXjNNwWpGkwPROZbwGn1vodUjjW4EJEfaYtqqXUSvN8eBkYA
	1dzUg3KjvAJGChDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 03F141395F;
	Thu,  5 Sep 2024 12:45:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id z+I5Ovin2WZhdwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 05 Sep 2024 12:45:44 +0000
Message-ID: <c06636f6-d8fc-4836-b843-a9e9cb15b0db@suse.cz>
Date: Thu, 5 Sep 2024 14:47:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm/slab: Optimize the code logic in find_mergeable()
To: Xavier <xavier_qy@163.com>, cl@linux.com, penberg@kernel.org,
 rientjes@google.com, iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
 roman.gushchin@linux.dev, 42.hyeyoo@gmail.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240904074037.710692-1-xavier_qy@163.com>
From: Vlastimil Babka <vbabka@suse.cz>
Content-Language: en-US
In-Reply-To: <20240904074037.710692-1-xavier_qy@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[163.com,linux.com,kernel.org,google.com,lge.com,linux-foundation.org,linux.dev,gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[163.com,gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.80
X-Spam-Flag: NO

On 9/4/24 9:40 AM, Xavier wrote:
> We can first assess the flags, if it's unmergeable, there's no need
> to calculate the size and align.
> 
> Signed-off-by: Xavier <xavier_qy@163.com>

OK, applied to slab/for-next. Thanks.

Note this is not a hotpath so no need to micro-optimize, but it makes
the code cleaner - no more calculate_alignment() using flags before we
adjust them by kmem_cache_flags(). This currently doesn't matter as it
cares only about SLAB_HWCACHE_ALIGN which is not affected, but will be
more robust in case of future changes.

> ---
>  mm/slab_common.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 40b582a014b8..aaf5989f7ffe 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -169,14 +169,15 @@ struct kmem_cache *find_mergeable(unsigned int size, unsigned int align,
>  	if (ctor)
>  		return NULL;
>  
> -	size = ALIGN(size, sizeof(void *));
> -	align = calculate_alignment(flags, align, size);
> -	size = ALIGN(size, align);
>  	flags = kmem_cache_flags(flags, name);
>  
>  	if (flags & SLAB_NEVER_MERGE)
>  		return NULL;
>  
> +	size = ALIGN(size, sizeof(void *));
> +	align = calculate_alignment(flags, align, size);
> +	size = ALIGN(size, align);
> +
>  	list_for_each_entry_reverse(s, &slab_caches, list) {
>  		if (slab_unmergeable(s))
>  			continue;

