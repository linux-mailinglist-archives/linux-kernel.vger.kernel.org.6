Return-Path: <linux-kernel+bounces-409194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 746589C8897
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 12:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E65BC1F2364B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 11:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13AF71F9419;
	Thu, 14 Nov 2024 11:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="soH1KFQI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kQ4TG4KN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="soH1KFQI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kQ4TG4KN"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F641F9415
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 11:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731582926; cv=none; b=TTH+zaOECC2iWDQzlMY+34YaPYQRN54qBzBg0HNjSk2Ig2C88r8VkKYUwMtyEoIEmve+VgA9wkk1dFDy8dYCP6uCGSI2hnFC8ZM3JmjK/+uce6eu2ng6cMd7TsW3m92MkZ0dhaoK6MmC6DBLItTWXMCY1Y/ETg0n0J/5bkLgadE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731582926; c=relaxed/simple;
	bh=zyWP1ylx11r86ytNiB8cABfhwMaWmsr7CPddShsTbmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ALNC8bbTUB0sHJspURRYcm7vu3d3HGE308wV59R1DxECXt7cQ33ie0fa465Q5KPzil4pwbbLxt1pF2ssYYJp61mUY4xoB5oS+GBLyVHJXNsuRtdLtgLOYnsgn4PYdA/3aMoFWOuvxre8Vxy1cCS6/oLZ2SW20foROA+eRArR3lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=soH1KFQI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kQ4TG4KN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=soH1KFQI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kQ4TG4KN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6B01621209;
	Thu, 14 Nov 2024 11:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731582917; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0qjey6Mx3Q/UGdfyDuIVN7Gf6sPP9fIdKBKgrtzXg9E=;
	b=soH1KFQIh22uCUjBTw7ooNR7RW3FkSpu16dbXeUuMOZjBi+81nutpdqLjYG7dMO21+ZD38
	xlNV5NQmrUgTdTUV0YO8wbL95F2596wNvFya5rrvwN9CpNodcIYgENN6Dg2JD1Xz2zks27
	4CRqsDOukFthq5QPWQabS6ZAL7PA4xY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731582917;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0qjey6Mx3Q/UGdfyDuIVN7Gf6sPP9fIdKBKgrtzXg9E=;
	b=kQ4TG4KNu3OM2RgAnFIyLRLWHgw8nRfex4fOQN8zExSInSuPKYOW3k2o/Eu0ZFTtni2EfK
	lCWzuETanD5w/tAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731582917; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0qjey6Mx3Q/UGdfyDuIVN7Gf6sPP9fIdKBKgrtzXg9E=;
	b=soH1KFQIh22uCUjBTw7ooNR7RW3FkSpu16dbXeUuMOZjBi+81nutpdqLjYG7dMO21+ZD38
	xlNV5NQmrUgTdTUV0YO8wbL95F2596wNvFya5rrvwN9CpNodcIYgENN6Dg2JD1Xz2zks27
	4CRqsDOukFthq5QPWQabS6ZAL7PA4xY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731582917;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0qjey6Mx3Q/UGdfyDuIVN7Gf6sPP9fIdKBKgrtzXg9E=;
	b=kQ4TG4KNu3OM2RgAnFIyLRLWHgw8nRfex4fOQN8zExSInSuPKYOW3k2o/Eu0ZFTtni2EfK
	lCWzuETanD5w/tAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3AC6113794;
	Thu, 14 Nov 2024 11:15:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id h8vIDcXbNWeXMQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 14 Nov 2024 11:15:17 +0000
Message-ID: <2510b50b-4178-4c14-b2cc-db5a77a1c8d7@suse.cz>
Date: Thu, 14 Nov 2024 12:15:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 15/57] stackdepot: Remove PAGE_SIZE compile-time
 constant assumption
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
 <20241014105912.3207374-15-ryan.roberts@arm.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20241014105912.3207374-15-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On 10/14/24 12:58, Ryan Roberts wrote:
> To prepare for supporting boot-time page size selection, refactor code
> to remove assumptions about PAGE_SIZE being compile-time constant. Code
> intended to be equivalent when compile-time page size is active.
> 
> "union handle_parts" previously calculated the number of bits required
> for its pool index and offset members based on PAGE_SHIFT. This is
> problematic for boot-time page size builds because the actual page size
> isn't known until boot-time.
> 
> We could use PAGE_SHIFT_MAX in calculating the worst case offset bits,
> but bits would be wasted that could be used for pool index when
> PAGE_SIZE is set smaller than MAX, the end result being that stack depot
> can address less memory than it should.
> 
> To avoid needing to dynamically define the offset and index bit widths,
> let's instead fix the pool size and derive the order at runtime based on
> the PAGE_SIZE. This means that the fields' widths can remain static,
> with the down side being slightly increased risk of failing to allocate
> the large folio.
> 
> This only affects boot-time page size builds. compile-time page size
> builds will still always allocate order-2 folios.
> 
> Additionally, wrap global variables that are initialized with PAGE_SIZE
> derived values using DEFINE_GLOBAL_PAGE_SIZE_VAR() so their
> initialization can be deferred for boot-time page size builds.

This is done for pool_offset but given it's initialized by DEPOT_POOL_SIZE,
it doesn't look derived from PAGE_SIZE?

> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Other than that,
Acked-by: Vlastimil Babka <vbabka@suse.cz>


> ---
> 
> ***NOTE***
> Any confused maintainers may want to read the cover note here for context:
> https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/
> 
>  include/linux/stackdepot.h | 6 +++---
>  lib/stackdepot.c           | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
> index e9ec32fb97d4a..ac877a4e90406 100644
> --- a/include/linux/stackdepot.h
> +++ b/include/linux/stackdepot.h
> @@ -32,10 +32,10 @@ typedef u32 depot_stack_handle_t;
>  
>  #define DEPOT_HANDLE_BITS (sizeof(depot_stack_handle_t) * 8)
>  
> -#define DEPOT_POOL_ORDER 2 /* Pool size order, 4 pages */
> -#define DEPOT_POOL_SIZE (1LL << (PAGE_SHIFT + DEPOT_POOL_ORDER))
> +#define DEPOT_POOL_ORDER 2 /* Pool size order, 4 pages of PAGE_SIZE_MAX */
> +#define DEPOT_POOL_SIZE (1LL << (PAGE_SHIFT_MAX + DEPOT_POOL_ORDER))
>  #define DEPOT_STACK_ALIGN 4
> -#define DEPOT_OFFSET_BITS (DEPOT_POOL_ORDER + PAGE_SHIFT - DEPOT_STACK_ALIGN)
> +#define DEPOT_OFFSET_BITS (DEPOT_POOL_ORDER + PAGE_SHIFT_MAX - DEPOT_STACK_ALIGN)
>  #define DEPOT_POOL_INDEX_BITS (DEPOT_HANDLE_BITS - DEPOT_OFFSET_BITS - \
>  			       STACK_DEPOT_EXTRA_BITS)
>  
> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index 5ed34cc963fc3..974351f0e9e3c 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -68,7 +68,7 @@ static void *new_pool;
>  /* Number of pools in stack_pools. */
>  static int pools_num;
>  /* Offset to the unused space in the currently used pool. */
> -static size_t pool_offset = DEPOT_POOL_SIZE;
> +static DEFINE_GLOBAL_PAGE_SIZE_VAR(size_t, pool_offset, DEPOT_POOL_SIZE);
>  /* Freelist of stack records within stack_pools. */
>  static LIST_HEAD(free_stacks);
>  /* The lock must be held when performing pool or freelist modifications. */
> @@ -625,7 +625,7 @@ depot_stack_handle_t stack_depot_save_flags(unsigned long *entries,
>  	 */
>  	if (unlikely(can_alloc && !READ_ONCE(new_pool))) {
>  		page = alloc_pages(gfp_nested_mask(alloc_flags),
> -				   DEPOT_POOL_ORDER);
> +				   get_order(DEPOT_POOL_SIZE));
>  		if (page)
>  			prealloc = page_address(page);
>  	}
> @@ -663,7 +663,7 @@ depot_stack_handle_t stack_depot_save_flags(unsigned long *entries,
>  exit:
>  	if (prealloc) {
>  		/* Stack depot didn't use this memory, free it. */
> -		free_pages((unsigned long)prealloc, DEPOT_POOL_ORDER);
> +		free_pages((unsigned long)prealloc, get_order(DEPOT_POOL_SIZE));
>  	}
>  	if (found)
>  		handle = found->handle.handle;


