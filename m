Return-Path: <linux-kernel+bounces-263383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4292C93D532
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 16:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB7C21F24B23
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 14:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB8C1CD00;
	Fri, 26 Jul 2024 14:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sDGVddtq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VzUMy3X5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sDGVddtq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VzUMy3X5"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF62DB673;
	Fri, 26 Jul 2024 14:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722004667; cv=none; b=JkD00m9QzIpVm+cJJDg7dOa17v6Mnqv9+MzNunpsg5aS7tUBbmLq37Wg/M2RlHEw7eLqSNU6E6kpIAavZHg3oRTJynURnJAfbIuceDSkvqSYHsuAyBgHcu9h3b3P6EZSXiFhtcbmlVmPdM2FDMbcPXKIycORD6ucr1XBJFtmh4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722004667; c=relaxed/simple;
	bh=VZNvAGZq8E3p2gY3vTlVwUNj8c6Gyl+7uavTVoXR8m0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eFmoTaenWilgkhmJe+fbhGTQYh1I6uBngS/GcbNAY43CJMJqBN9B93Gnjaj8d5kX/setI8yTpVXYzvjVpPyQZ7Jcoq2onRLCJyjI14rC4+x7qmJByx2+zLpsNwnMXViox04BnoTg0OhNOK+LzpNB2dvLNeHP0YU09Bs9QR21spo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sDGVddtq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VzUMy3X5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sDGVddtq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VzUMy3X5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BA7DE21BE8;
	Fri, 26 Jul 2024 14:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722004663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=D/ZXFeDHRiVyFLhDMqSiqUvemIGxOsAvpWKuKmrc5Gs=;
	b=sDGVddtqhoPymeOD79sCENo7Z9kM9h+gv5grVeo88H7AddRAM+yWHa86cCwD+ian3NYO52
	dWeF7FY6i7A7M+o9tHnBLDZCoQGRoi1qHLOY/CI9iI/xgvdWf7WGgthK+sBiQ8ONGG5JB/
	dTrs71mEPnSi058zzReAaPly4GwQYYs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722004663;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=D/ZXFeDHRiVyFLhDMqSiqUvemIGxOsAvpWKuKmrc5Gs=;
	b=VzUMy3X58/Y4nCjVPd5UnYdSEt+RjNzZEkXWOaJ+umhD5kCH4gsJpIG5VHF9G1SRlA9Mng
	sL1znJCOWdEryLDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=sDGVddtq;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=VzUMy3X5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722004663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=D/ZXFeDHRiVyFLhDMqSiqUvemIGxOsAvpWKuKmrc5Gs=;
	b=sDGVddtqhoPymeOD79sCENo7Z9kM9h+gv5grVeo88H7AddRAM+yWHa86cCwD+ian3NYO52
	dWeF7FY6i7A7M+o9tHnBLDZCoQGRoi1qHLOY/CI9iI/xgvdWf7WGgthK+sBiQ8ONGG5JB/
	dTrs71mEPnSi058zzReAaPly4GwQYYs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722004663;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=D/ZXFeDHRiVyFLhDMqSiqUvemIGxOsAvpWKuKmrc5Gs=;
	b=VzUMy3X58/Y4nCjVPd5UnYdSEt+RjNzZEkXWOaJ+umhD5kCH4gsJpIG5VHF9G1SRlA9Mng
	sL1znJCOWdEryLDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8CEDC138A7;
	Fri, 26 Jul 2024 14:37:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ep/FIbe0o2Z/IgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 26 Jul 2024 14:37:43 +0000
Message-ID: <07491799-9753-4fc9-b642-6d7d7d9575aa@suse.cz>
Date: Fri, 26 Jul 2024 16:37:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm: vmalloc: implement vrealloc()
Content-Language: en-US
To: Danilo Krummrich <dakr@kernel.org>, cl@linux.com, penberg@kernel.org,
 rientjes@google.com, iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
 roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, urezki@gmail.com,
 hch@infradead.org, kees@kernel.org, ojeda@kernel.org, wedsonaf@gmail.com,
 mhocko@kernel.org, mpe@ellerman.id.au, chandan.babu@oracle.com,
 christian.koenig@amd.com, maz@kernel.org, oliver.upton@linux.dev
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 rust-for-linux@vger.kernel.org
References: <20240722163111.4766-1-dakr@kernel.org>
 <20240722163111.4766-2-dakr@kernel.org>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20240722163111.4766-2-dakr@kernel.org>
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
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_TO(0.00)[kernel.org,linux.com,google.com,lge.com,linux-foundation.org,linux.dev,gmail.com,infradead.org,ellerman.id.au,oracle.com,amd.com];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Rspamd-Queue-Id: BA7DE21BE8

On 7/22/24 6:29 PM, Danilo Krummrich wrote:
> Implement vrealloc() analogous to krealloc().
> 
> Currently, krealloc() requires the caller to pass the size of the
> previous memory allocation, which, instead, should be self-contained.
> 
> We attempt to fix this in a subsequent patch which, in order to do so,
> requires vrealloc().
> 
> Besides that, we need realloc() functions for kernel allocators in Rust
> too. With `Vec` or `KVec` respectively, potentially growing (and
> shrinking) data structures are rather common.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -4037,6 +4037,65 @@ void *vzalloc_node_noprof(unsigned long size, int node)
>  }
>  EXPORT_SYMBOL(vzalloc_node_noprof);
>  
> +/**
> + * vrealloc - reallocate virtually contiguous memory; contents remain unchanged
> + * @p: object to reallocate memory for
> + * @size: the size to reallocate
> + * @flags: the flags for the page level allocator
> + *
> + * The contents of the object pointed to are preserved up to the lesser of the
> + * new and old size (__GFP_ZERO flag is effectively ignored).

Well, technically not correct as we don't shrink. Get 8 pages, kvrealloc to
4 pages, kvrealloc back to 8 and the last 4 are not zeroed. But it's not
new, kvrealloc() did the same before patch 2/2.

But it's also fundamentally not true for krealloc(), or kvrealloc()
switching from a kmalloc to valloc. ksize() returns the size of the kmalloc
bucket, we don't know what was the exact prior allocation size. Worse, we
started poisoning the padding in debug configurations, so even a
kmalloc(__GFP_ZERO) followed by krealloc(__GFP_ZERO) can give you unexpected
poison now...

I guess we should just document __GFP_ZERO is not honored at all for
realloc, and maybe start even warning :/ Hopefully nobody relies on that.

> + *
> + * If @p is %NULL, vrealloc() behaves exactly like vmalloc(). If @size is 0 and
> + * @p is not a %NULL pointer, the object pointed to is freed.
> + *
> + * Return: pointer to the allocated memory; %NULL if @size is zero or in case of
> + *         failure
> + */
> +void *vrealloc_noprof(const void *p, size_t size, gfp_t flags)
> +{
> +	size_t old_size = 0;
> +	void *n;
> +
> +	if (!size) {
> +		vfree(p);
> +		return NULL;
> +	}
> +
> +	if (p) {
> +		struct vm_struct *vm;
> +
> +		vm = find_vm_area(p);
> +		if (unlikely(!vm)) {
> +			WARN(1, "Trying to vrealloc() nonexistent vm area (%p)\n", p);
> +			return NULL;
> +		}
> +
> +		old_size = get_vm_area_size(vm);
> +	}
> +
> +	if (size <= old_size) {
> +		/*
> +		 * TODO: Shrink the vm_area, i.e. unmap and free unused pages.
> +		 * What would be a good heuristic for when to shrink the
> +		 * vm_area?
> +		 */
> +		return (void *)p;
> +	}
> +
> +	/* TODO: Grow the vm_area, i.e. allocate and map additional pages. */
> +	n = __vmalloc_noprof(size, flags);
> +	if (!n)
> +		return NULL;
> +
> +	if (p) {
> +		memcpy(n, p, old_size);
> +		vfree(p);
> +	}
> +
> +	return n;
> +}
> +
>  #if defined(CONFIG_64BIT) && defined(CONFIG_ZONE_DMA32)
>  #define GFP_VMALLOC32 (GFP_DMA32 | GFP_KERNEL)
>  #elif defined(CONFIG_64BIT) && defined(CONFIG_ZONE_DMA)


