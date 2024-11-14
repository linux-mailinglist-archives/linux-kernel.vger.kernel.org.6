Return-Path: <linux-kernel+bounces-409077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E369C8753
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 11:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBFA11F2193E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 10:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E0A1F81B1;
	Thu, 14 Nov 2024 10:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="H1IDs8ap";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wUbPSJg7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="H1IDs8ap";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wUbPSJg7"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC041F818E
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 10:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731578964; cv=none; b=qs9pgI2b3UuJfih2V2wFPK3mfNX+SLbBYM/jfs63WFBGs1ZTI8LCsBySepNzacJffF/lbDM5whRUOzNNiabe9kKLkgXQzPOAa4DBTBDy9Y8h2GRzjA1zzAnaCDue9baf4o5ZHNUvAaX98B0Z/JTT1Z0tuG5MNGyqt6VK92RTv0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731578964; c=relaxed/simple;
	bh=KMzNPvCxaCOcEEb7CWWW5njE53kJtlshFvvmL4nwOlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lHCK8I8v5Ml0f74T3PaDAfs5GUJqnLk04gvBRUPgHJawXNzKxtGiFmYgbD2fhG5hGIlv0bStb6T/xrHrjM+vUOC3XR82BUn6YnrXCS1Z68eTb0CIpec02XSF0/4VwZ9LuIcrnBTMHSrZUwYxr9r5GJzkYpiXR50wq2hOCbduu9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=H1IDs8ap; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wUbPSJg7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=H1IDs8ap; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wUbPSJg7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 753E52119F;
	Thu, 14 Nov 2024 10:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731578960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Il6MCIWPQie3YJaODFOx8K/akx4KWy4DGzrSlIIzXQo=;
	b=H1IDs8ap3R0WhxzhJfAHUhV8nquICuKmn5BuJQnAUKNFH6hm2KdhOqPqQr+gA4lgXT42kl
	+gZj/NWcbBBcPErB7piRzIcSPlQB8UnLhFdXy3NX0M0djJ1WRSzQ0z/dtVh1HKntq23YBi
	Vrs+1m6IdvMbffMB/70fSRZhc+9CLkg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731578960;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Il6MCIWPQie3YJaODFOx8K/akx4KWy4DGzrSlIIzXQo=;
	b=wUbPSJg7bnBdXNUSJ01COjnVMsD68Mwtcu2s/SzXdEW6KYLyBSgrw6jQXDJH63C7yplZdT
	9ifItblf8gGgiDBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731578960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Il6MCIWPQie3YJaODFOx8K/akx4KWy4DGzrSlIIzXQo=;
	b=H1IDs8ap3R0WhxzhJfAHUhV8nquICuKmn5BuJQnAUKNFH6hm2KdhOqPqQr+gA4lgXT42kl
	+gZj/NWcbBBcPErB7piRzIcSPlQB8UnLhFdXy3NX0M0djJ1WRSzQ0z/dtVh1HKntq23YBi
	Vrs+1m6IdvMbffMB/70fSRZhc+9CLkg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731578960;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Il6MCIWPQie3YJaODFOx8K/akx4KWy4DGzrSlIIzXQo=;
	b=wUbPSJg7bnBdXNUSJ01COjnVMsD68Mwtcu2s/SzXdEW6KYLyBSgrw6jQXDJH63C7yplZdT
	9ifItblf8gGgiDBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 66D9C13721;
	Thu, 14 Nov 2024 10:09:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id f/HHGFDMNWc2GwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 14 Nov 2024 10:09:20 +0000
Message-ID: <cb9cabed-0038-42b3-b9fc-c9ba62b12781@suse.cz>
Date: Thu, 14 Nov 2024 11:09:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm/slab: Avoid build bug for calls to kmalloc with a
 large constant
Content-Language: en-US
To: Dave Kleikamp <dave.kleikamp@oracle.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
 <20241014105912.3207374-6-ryan.roberts@arm.com>
 <44312f4a-8b9c-49ce-9277-5873a94ca1bb@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <44312f4a-8b9c-49ce-9277-5873a94ca1bb@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[6]
X-Spam-Flag: NO
X-Spam-Level: 

On 11/1/24 21:16, Dave Kleikamp wrote:
> When boot-time page size is enabled, the test against KMALLOC_MAX_CACHE_SIZE
> is no longer optimized out with a constant size, so a build bug may
> occur on a path that won't be reached.

That's rather unfortunate, the __builtin_constant_p(size) part of
kmalloc_noprof() really expects things to resolve at compile time and it
would be better to keep it that way.

I think it would be better if we based KMALLOC_MAX_CACHE_SIZE itself on
PAGE_SHIFT_MAX and kept it constant, instead of introducing
KMALLOC_SHIFT_HIGH_MAX only for some sanity checks.

So if the kernel was built to support 4k to 64k, but booted as 4k, it would
still create and use kmalloc caches up to 128k. SLUB should handle that fine
(if not, please report it :)

Maybe we could also stop adding + 1 to PAGE_SHIFT_MAX if it's >=64k, so the
cache size is max 64k and not 128k but that should be probably evaluated
separately from this series.

Vlastimil

> Found compiling drivers/net/ethernet/qlogic/qed/qed_sriov.c
> 
> Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
> ---
> 
> Ryan,
> 
> Please consider incorporating this fix or something similar into your
> mm patch in the boot-time pages size patches.
> 
>   include/linux/slab.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 9848296ca6ba..a4c7507ab8ec 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -685,7 +685,8 @@ static __always_inline unsigned int __kmalloc_index(size_t size,
>   	if (size <= 1024 * 1024) return 20;
>   	if (size <=  2 * 1024 * 1024) return 21;
>   
> -	if (!IS_ENABLED(CONFIG_PROFILE_ALL_BRANCHES) && size_is_constant)
> +	if (!IS_ENABLED(CONFIG_ARM64_BOOT_TIME_PAGE_SIZE) &&
> +	    !IS_ENABLED(CONFIG_PROFILE_ALL_BRANCHES) && size_is_constant)
>   		BUILD_BUG_ON_MSG(1, "unexpected size in kmalloc_index()");
>   	else
>   		BUG();


