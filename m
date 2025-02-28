Return-Path: <linux-kernel+bounces-538386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B66A49805
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 12:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5566188F5F0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 11:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BC9260A37;
	Fri, 28 Feb 2025 11:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TORL20zd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rePhrVR8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EfvuF9Kp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iZFI9tgS"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D4B26039A
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 11:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740740520; cv=none; b=iZx6ua9VilNfXkom3HYvuNaqQ1jCPMd+bK3gNUyrHrl0hUo1ZzfHOk6N67zwZo6xlloZSSyzidFd1B8yWl6ubxu7DdYcySKNhEkc/M0Q2+hHAULlrHVPB090sIus0QtIV475fnN2IuibfenUQKjUaDqaIZafdkUJSkcjkHAR2a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740740520; c=relaxed/simple;
	bh=cY56ByAkfiIl0iBp/zTCSGmqGQi/efmcrUMWaqORfUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BSo10Fowwcmc81wzzHY5y5awF9Hz+pftmf2sS7o9hcrz1ESLvIE1JyNqc3RCXUenvDsWZFeXJWL9Ve9NRYTly6a6f6uJWax6Ls2g07AzJLeYiC+0bLYK45yPQx8emLxdXJWQQ2An+YORMyIluJ2/5folQldM9wjck4x0juP9Hdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TORL20zd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rePhrVR8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EfvuF9Kp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iZFI9tgS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F19EB21165;
	Fri, 28 Feb 2025 11:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740740517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5xYsE7kl/f83kURL9obXqUw2kpX8E5zSQwx+IhLd9K8=;
	b=TORL20zd+sC0lUWxxEkVFJFdvcXAUmh/FefB9aLU1rNrFQispbclnlXuBv2C3c2SKqF+Qx
	R83DPgMYw+KF0h0zLvRy8dvH0Xgxuka56pdSZGyNwm0KYER1ReDVCO2VE0cO5dkx1H4L+b
	n42XKTH+UNdnuNvdadNA+LqRrlmIf1M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740740517;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5xYsE7kl/f83kURL9obXqUw2kpX8E5zSQwx+IhLd9K8=;
	b=rePhrVR8C5/uWE/xk4lv7svUkI5Tezrr8Ga+BBYgftK9rnq6ifWYrNYGZxprZex1FHJxzS
	t4yoguD+sLIugnCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740740516; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5xYsE7kl/f83kURL9obXqUw2kpX8E5zSQwx+IhLd9K8=;
	b=EfvuF9KpmeySxU2JAzozbP3omJvZ9Yr1mU1L6+Spo3V4j+XQ6tEBmw2Dtq8tz5ab7TdEpp
	xodLj3FvnsWlAnaajEw0GnC8JHZozZwZ+se8yoVOMqOwH37uIJXoR6/XlJEt7vF3mLJYvM
	9kYGnU22VUQnJJ+NoD1h7eUzZQT2L0k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740740516;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5xYsE7kl/f83kURL9obXqUw2kpX8E5zSQwx+IhLd9K8=;
	b=iZFI9tgSVhcICIbYA2y+5pGdpZ6MMoN7OjLt4CC1CJFTORSAzWfxNcRAvGN/3ACm4QQDPr
	IwOd91LoTBb9t4Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D66861344A;
	Fri, 28 Feb 2025 11:01:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ORfIMaSXwWfTbQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 28 Feb 2025 11:01:56 +0000
Message-ID: <047cdda5-d6bd-4ce0-8905-f1bc00153d6d@suse.cz>
Date: Fri, 28 Feb 2025 12:01:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/page_alloc: make the maximum number of highatomic
 pageblocks resizable
Content-Language: en-US
To: zhongjinji@honor.com, akpm@linux-foundation.org,
 Mel Gorman <mgorman@techsingularity.net>,
 Johannes Weiner <hannes@cmpxchg.org>, Brendan Jackman <jackmanb@google.com>
Cc: yuzhao@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 rientjes@google.com, yipengxiang@honor.com, liulu.liu@honor.com,
 feng.han@honor.com
References: <20250226024126.3718-1-zhongjinji@honor.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20250226024126.3718-1-zhongjinji@honor.com>
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
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid]
X-Spam-Flag: NO
X-Spam-Level: 

+Cc Mel, Johannes and Brendan, please keep on future submissions

On 2/26/25 03:41, zhongjinji@honor.com wrote:
> From: zhongjinji <zhongjinji@honor.com>
> 
> In the past, nr_reserved_highatomic was considered to be part of
> unusable_free when there was no ALLOC_RESERVES flag. To prevent
> unusable_free from being too large, it is reasonable to set a
> fixed maximum highatomic value.
> 
> Even if the maximum number of highatomic pageblocks is set to be larger,
> unusable_free may not increase, since Yu Zhao provided the modification
> about nr_free_highatomic in
> https://lore.kernel.org/all/20241028182653.3420139-1-yuzhao@google.com/T/#u

I think I raised in discussing that patch the fact that
unreserve_highatomic_pageblock() is flawed in that it will only find a
highatomic block to unreserve if it has some free pages as it searches via
freelist. So if the existing reserve becomes fully used up, it's dead
weight, unless the highatomic allocations are shortlived. It could make
sense to remove the HIGHATOMIC marking so other, more free blocks might be
reserved instead.

I fear if this approach isn't just working around that limitation.

> More highatomic pageblocks are beneficial for the successful allocation
> of high-order page, which is helpful in some devices. Therefore, use

Can you elaborate what is it helpful with? And what kind of values you
expect to be using? Do you find that your existing HIGHATOMIC blocks are
fully depleted as I speculate above? Are your highatomic allocations short
or long lived?

Maybe simply at this point nr_free_highatomic would be a better metric than
nr_reserved_highatomic to decide if we should reserve another pageblock? The
counter didn't exist when highatomic reserves were introduced.

But maybe also some mechanism (compaction maybe?) could also be looking for
highatomic blocks that are fully used and unreserve them?

> highatomic_reserve_ratio to adjust the maximum number of highatomic
> pageblocks.
> 
> Signed-off-by: zhongjinji <zhongjinji@honor.com>

Minimally this needs to be documented in e.g.
Documentation/admin-guide/sysctl/vm.rst, it's not obvious that the value is
divided by 1000 and not 100 for example.

> ---
>  mm/page_alloc.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 579789600a3c..dbdce6a0f694 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -273,6 +273,7 @@ int min_free_kbytes = 1024;
>  int user_min_free_kbytes = -1;
>  static int watermark_boost_factor __read_mostly = 15000;
>  static int watermark_scale_factor = 10;
> +static int highatomic_reserve_ratio = 10;
>  
>  /* movable_zone is the "real" zone pages in ZONE_MOVABLE are taken from */
>  int movable_zone;
> @@ -2046,7 +2047,8 @@ static void reserve_highatomic_pageblock(struct page *page, int order,
>  	 */
>  	if ((zone_managed_pages(zone) / 100) < pageblock_nr_pages)
>  		return;
> -	max_managed = ALIGN((zone_managed_pages(zone) / 100), pageblock_nr_pages);
> +	max_managed = ALIGN((zone_managed_pages(zone) * highatomic_reserve_ratio / 1000),
> +		      pageblock_nr_pages);
>  	if (zone->nr_reserved_highatomic >= max_managed)
>  		return;
>  
> @@ -6199,6 +6201,13 @@ static const struct ctl_table page_alloc_sysctl_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= percpu_pagelist_high_fraction_sysctl_handler,
>  		.extra1		= SYSCTL_ZERO,
> +	},
> +		.procname	= "highatomic_reserve_ratio",
> +		.data		= &highatomic_reserve_ratio,
> +		.maxlen		= sizeof(highatomic_reserve_ratio),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= SYSCTL_ZERO,
>  	},
>  	{
>  		.procname	= "lowmem_reserve_ratio",


