Return-Path: <linux-kernel+bounces-198907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 555428D7EFC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 11:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D37741F25511
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 09:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B9285273;
	Mon,  3 Jun 2024 09:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ENmMGnjO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9QQy8XKn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ENmMGnjO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9QQy8XKn"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8942C85261
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 09:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407163; cv=none; b=Bj33g1CIYllOqWS6US8m4n5egS0UgdglEX6BtOFRxN2XnLe79VfwpbGtPXcjLbp7deZj9AYFlyrl0dSXBcdtsPJgwWsdcuMDZbbuqaokDQrWNzuLTxKJN/V91NwBKqjJOatQg+8WvmN6SQuTq+9AXFaJe1w6jhqJM2Tl91sqjDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407163; c=relaxed/simple;
	bh=63ejAZHAexih45XNuFiG70U3domc0Zy2O0h9hVLbnVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eSpW09eYyZukr8owNzKHMvNZJPduRO1dI3ya9OOFvGA4dCPdsJVDBLpsF2ny87NYyxc0h0U7ZLRvQId4WhK9nqMaOMsou02Xy3lYE6lEkQpDtZHo9AALQOIXcQ564lwtlkPt9yaNVYpckKeSLDX30NdgkOtKJUmr12Qc10uMkKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ENmMGnjO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9QQy8XKn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ENmMGnjO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9QQy8XKn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AA979220EF;
	Mon,  3 Jun 2024 09:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717407159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=unoPvHtEY2q8ar/jFsOGCYlFRxG2foKN8adh7yrkQyM=;
	b=ENmMGnjOaRwB8GQsF2OJkw8i4I2Rw9Vwss0yYCz1SLkNY3bybiMq4C2FTtqjh5rOQo/FtJ
	RClcmU+22aQiU680tUPr1KqF/OgjnqWGbT75BWwAuaERq7uNvR5DJeI7JlJt074qBGfo2T
	0pbqVCCq4XAw2ZlOP/rBs70LC+n0v8I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717407159;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=unoPvHtEY2q8ar/jFsOGCYlFRxG2foKN8adh7yrkQyM=;
	b=9QQy8XKn/fbOW0gmknAO2g/sAcpBTqaaXNLk83Xr7Vi0Z/2lYQQhz/HZHdrKWIHyuGBTWO
	SmBNbzIkESN8ZXDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717407159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=unoPvHtEY2q8ar/jFsOGCYlFRxG2foKN8adh7yrkQyM=;
	b=ENmMGnjOaRwB8GQsF2OJkw8i4I2Rw9Vwss0yYCz1SLkNY3bybiMq4C2FTtqjh5rOQo/FtJ
	RClcmU+22aQiU680tUPr1KqF/OgjnqWGbT75BWwAuaERq7uNvR5DJeI7JlJt074qBGfo2T
	0pbqVCCq4XAw2ZlOP/rBs70LC+n0v8I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717407159;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=unoPvHtEY2q8ar/jFsOGCYlFRxG2foKN8adh7yrkQyM=;
	b=9QQy8XKn/fbOW0gmknAO2g/sAcpBTqaaXNLk83Xr7Vi0Z/2lYQQhz/HZHdrKWIHyuGBTWO
	SmBNbzIkESN8ZXDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 969FA139CB;
	Mon,  3 Jun 2024 09:32:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /QtbJLeNXWYhBAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 03 Jun 2024 09:32:39 +0000
Message-ID: <618f3c36-9952-438b-94dc-e3cb4a8afc48@suse.cz>
Date: Mon, 3 Jun 2024 11:32:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] lib/alloc_tag: do not register sysctl interface when
 CONFIG_SYSCTL=n
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, pasha.tatashin@soleen.com,
 keescook@chromium.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kernel test robot <lkp@intel.com>
References: <20240601233831.617124-1-surenb@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20240601233831.617124-1-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.29
X-Spam-Level: 
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linux.dev:email,suse.cz:email]

On 6/2/24 1:38 AM, Suren Baghdasaryan wrote:
> Memory allocation profiling is trying to register sysctl interface even
> when CONFIG_SYSCTL=n, resulting in proc_do_static_key() being undefined.
> Prevent that by skipping sysctl registration for such configurations.
> 
> Fixes: 22d407b164ff ("lib: add allocation tagging support for memory allocation profiling")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202405280616.wcOGWJEj-lkp@intel.com/
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Cc: Kent Overstreet <kent.overstreet@linux.dev>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  lib/alloc_tag.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> index 11ed973ac359..c347b8b72d78 100644
> --- a/lib/alloc_tag.c
> +++ b/lib/alloc_tag.c
> @@ -227,6 +227,7 @@ struct page_ext_operations page_alloc_tagging_ops = {
>  };
>  EXPORT_SYMBOL(page_alloc_tagging_ops);
>  
> +#ifdef CONFIG_SYSCTL
>  static struct ctl_table memory_allocation_profiling_sysctls[] = {
>  	{
>  		.procname	= "mem_profiling",
> @@ -241,6 +242,17 @@ static struct ctl_table memory_allocation_profiling_sysctls[] = {
>  	{ }
>  };
>  
> +static void __init sysctl_init(void)
> +{
> +	if (!mem_profiling_support)
> +		memory_allocation_profiling_sysctls[0].mode = 0444;
> +
> +	register_sysctl_init("vm", memory_allocation_profiling_sysctls);
> +}
> +#else /* CONFIG_SYSCTL */
> +static inline void sysctl_init(void) {}
> +#endif /* CONFIG_SYSCTL */
> +
>  static int __init alloc_tag_init(void)
>  {
>  	const struct codetag_type_desc desc = {
> @@ -253,9 +265,7 @@ static int __init alloc_tag_init(void)
>  	if (IS_ERR(alloc_tag_cttype))
>  		return PTR_ERR(alloc_tag_cttype);
>  
> -	if (!mem_profiling_support)
> -		memory_allocation_profiling_sysctls[0].mode = 0444;
> -	register_sysctl_init("vm", memory_allocation_profiling_sysctls);
> +	sysctl_init();
>  	procfs_init();
>  
>  	return 0;
> 
> base-commit: 065d3634d60843b8e338d405b844cc7f2e5e1c66


