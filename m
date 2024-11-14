Return-Path: <linux-kernel+bounces-408893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC8F9C84CB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 09:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F40021F21945
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 08:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CAF1F708D;
	Thu, 14 Nov 2024 08:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lHWdndqB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/JqV+E+k";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lHWdndqB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/JqV+E+k"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC36163
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 08:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731572644; cv=none; b=luF5qvQiejRC1dkjCNoEaaLVINvAwHkdVEx6WvvPI4iEqgasNN5ECL9QfGvk6a5ae6nAqLludH03L6H7ZqmCvVMAiQmCZhnCeW+9hT+VrY8LmRqj/UCT+k5ihcl/mU6quKCRncveapX/bXE/c8PWUnJDeU6NHmQiQxcq/3Bg+x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731572644; c=relaxed/simple;
	bh=L+3ZI44y+Rn9IeqKhnAeJj6kkELPyPRtpJSU1l5Sjio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P9wzxOT8NWVNC1FsMBZENCrblCJRmijGWCbGG6QuBFOgotl0+X9Mvqd9UkGJuQ3zGMzcTOp4BXj0MWhl8YRTc/tPwjRNW6NX19FJUWHUzewOwSC1OK/QT4SURSvFN+g+yPulRNIfK97SonNDqaYsLU5FSdYXAMAdkGAe53EJ4bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lHWdndqB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/JqV+E+k; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lHWdndqB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/JqV+E+k; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4A93021992;
	Thu, 14 Nov 2024 08:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731572639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ahl2Hcr0Je8uYd9uL+Sf7oiifODQpHijWsLEfV1f1Vo=;
	b=lHWdndqBn9sRpogDf/rWkU/FCPhj6dGmC+WFEPJ64Q8PX68HU+yvybDeYxZPYVKtUSgiCj
	Bmte2zT82T7lasduSF/ltHAsV237xx03yXuAN6XfXJki7hl3B5ORM1U30C65e7pj5Jn3ez
	b4AZ3+CpuMFKwNFq4ukUbnkFc3DxL9M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731572639;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ahl2Hcr0Je8uYd9uL+Sf7oiifODQpHijWsLEfV1f1Vo=;
	b=/JqV+E+kA7M4Ue4qqa9B86A0fktCcKzRgjaOxs++GG4A+anB8+ANLEuppDVVUTVf7U37c5
	6eCNnw4ZF47wYECw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=lHWdndqB;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/JqV+E+k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731572639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ahl2Hcr0Je8uYd9uL+Sf7oiifODQpHijWsLEfV1f1Vo=;
	b=lHWdndqBn9sRpogDf/rWkU/FCPhj6dGmC+WFEPJ64Q8PX68HU+yvybDeYxZPYVKtUSgiCj
	Bmte2zT82T7lasduSF/ltHAsV237xx03yXuAN6XfXJki7hl3B5ORM1U30C65e7pj5Jn3ez
	b4AZ3+CpuMFKwNFq4ukUbnkFc3DxL9M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731572639;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ahl2Hcr0Je8uYd9uL+Sf7oiifODQpHijWsLEfV1f1Vo=;
	b=/JqV+E+kA7M4Ue4qqa9B86A0fktCcKzRgjaOxs++GG4A+anB8+ANLEuppDVVUTVf7U37c5
	6eCNnw4ZF47wYECw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA4AF13721;
	Thu, 14 Nov 2024 08:23:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AwCyNJ6zNWeEdQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 14 Nov 2024 08:23:58 +0000
Message-ID: <1d9f9188-42b1-4f83-87e7-e02a22b67caa@suse.cz>
Date: Thu, 14 Nov 2024 09:23:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 04/57] mm/page_alloc: Make page_frag_cache
 boot-time page size compatible
Content-Language: en-US
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 David Hildenbrand <david@redhat.com>, Greg Marsden
 <greg.marsden@oracle.com>, Ivan Ivanov <ivan.ivanov@suse.com>,
 Kalesh Singh <kaleshsingh@google.com>, Marc Zyngier <maz@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <mbrugger@suse.com>,
 Miroslav Benes <mbenes@suse.cz>, Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
 <20241014105912.3207374-4-ryan.roberts@arm.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20241014105912.3207374-4-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4A93021992
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 10/14/24 12:58, Ryan Roberts wrote:
> "struct page_frag_cache" has some optimizations that depend on page
> size. Let's refactor it a bit so that those optimizations can be
> determined at run-time for the case where page size is a boot-time
> parameter. For compile-time page size, the compiler should dead code
> strip and the result is very similar to before.
> 
> One wrinkle is that we don't know if we need the size member until
> runtime. So remove the ifdeffery and always define offset as u32 (needed
> if PAGE_SIZE is >= 64K) and size as u16 (only used when PAGE_SIZE <=
> 32K). We move the members around a bit so that the overall size of the
> struct remains the same; 24 bytes for 64-bit and 16 bytes on 32 bit.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Looks ok, but ideally the PAGE_FRAG_CACHE_MAX_ORDER #define should also be
replaced by some variable that's populated just once. It can be static local
to page_alloc.c as nothing else seems to use it.

> 
> page_alloc
> ---
> 
> ***NOTE***
> Any confused maintainers may want to read the cover note here for context:
> https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/
> 
>  include/linux/mm_types.h | 13 ++++++-------
>  mm/page_alloc.c          | 31 ++++++++++++++++++-------------
>  2 files changed, 24 insertions(+), 20 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 4854249792545..0844ed7cfaa53 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -544,16 +544,15 @@ static inline void *folio_get_private(struct folio *folio)
>  
>  struct page_frag_cache {
>  	void * va;
> -#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> -	__u16 offset;
> -	__u16 size;
> -#else
> -	__u32 offset;
> -#endif
>  	/* we maintain a pagecount bias, so that we dont dirty cache line
>  	 * containing page->_refcount every time we allocate a fragment.
>  	 */
> -	unsigned int		pagecnt_bias;
> +	unsigned int pagecnt_bias;
> +	__u32 offset;
> +	/* size only used when PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE, in which
> +	 * case PAGE_FRAG_CACHE_MAX_SIZE is 32K and 16 bits is sufficient.
> +	 */
> +	__u16 size;
>  	bool pfmemalloc;
>  };
>  
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 91ace8ca97e21..8678103b1b396 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4822,13 +4822,18 @@ static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
>  	struct page *page = NULL;
>  	gfp_t gfp = gfp_mask;
>  
> -#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> -	gfp_mask = (gfp_mask & ~__GFP_DIRECT_RECLAIM) |  __GFP_COMP |
> -		   __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
> -	page = alloc_pages_node(NUMA_NO_NODE, gfp_mask,
> -				PAGE_FRAG_CACHE_MAX_ORDER);
> -	nc->size = page ? PAGE_FRAG_CACHE_MAX_SIZE : PAGE_SIZE;
> -#endif
> +	if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE) {
> +		gfp_mask = (gfp_mask & ~__GFP_DIRECT_RECLAIM) |  __GFP_COMP |
> +			   __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
> +		page = alloc_pages_node(NUMA_NO_NODE, gfp_mask,
> +					PAGE_FRAG_CACHE_MAX_ORDER);
> +		/*
> +		 * Cast to silence warning due to 16-bit nc->size. Not real
> +		 * because PAGE_SIZE only less than PAGE_FRAG_CACHE_MAX_SIZE
> +		 * when PAGE_FRAG_CACHE_MAX_SIZE is 32K.
> +		 */
> +		nc->size = (__u16)(page ? PAGE_FRAG_CACHE_MAX_SIZE : PAGE_SIZE);
> +	}
>  	if (unlikely(!page))
>  		page = alloc_pages_node(NUMA_NO_NODE, gfp, 0);
>  
> @@ -4870,10 +4875,10 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
>  		if (!page)
>  			return NULL;
>  
> -#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>  		/* if size can vary use size else just use PAGE_SIZE */
> -		size = nc->size;
> -#endif
> +		if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> +			size = nc->size;
> +
>  		/* Even if we own the page, we do not use atomic_set().
>  		 * This would break get_page_unless_zero() users.
>  		 */
> @@ -4897,10 +4902,10 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
>  			goto refill;
>  		}
>  
> -#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>  		/* if size can vary use size else just use PAGE_SIZE */
> -		size = nc->size;
> -#endif
> +		if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> +			size = nc->size;
> +
>  		/* OK, page count is 0, we can safely set it */
>  		set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
>  


