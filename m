Return-Path: <linux-kernel+bounces-538943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F32ECA49F13
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E08153AEDC7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2A7272904;
	Fri, 28 Feb 2025 16:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cXz8Duyz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tU/xh/FV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cXz8Duyz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tU/xh/FV"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F240254861
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 16:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740760766; cv=none; b=PPC5kZdmHzZA9EP2anSbdVDW9dtZMQh7YiD6NcWxS4t45u6nSnw/TBXPX92vXVTiq26woLxqCEVsAFBFoTkeB04aPhrSodmuRPji5Tt0wiG9Cv4U7QE+GpVRHf3d5W4GwgH8ZGPTQf1+k3pVqoNnEE4Iit1Vg0pRjjj+S6/cmzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740760766; c=relaxed/simple;
	bh=7354nGz+O7okdgVTTOtBmbEd8o/kIgEvUlJFgR8YfM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UnNJPElaK79p7ckgN5lA0zE3YMzhtNBs15vOC3iVFl7mtrohf0Q4B/Oho3HNw+hd8ouAXqZO/uoWnXUbpMk/vl9w2g9iHT2RpmhfwcR+yOIHPN907ME4QT0emRA8RISwXxyiOrjVU1A43Vs17YhqDp6juc6TSVC2VFOUzTv90lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cXz8Duyz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tU/xh/FV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cXz8Duyz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tU/xh/FV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A61F72119E;
	Fri, 28 Feb 2025 16:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740760762; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o2Z/+S0bCpIiR/CVWr/u3iutpDVKtDE6whnqXRO+9u8=;
	b=cXz8DuyzO3RX8yrluy8Jk489nDWdrLlrqszF2Up5KEEVGmL1saU9abNYyN53qFHlPkewuP
	RgYVHta9FQ6W2Zba8oMS2yrwFp5yhYn+vDCA/E8v5oUPKDWb4XJQMbBIDWvPJG3VVOVDVJ
	Ym9AVjIGTE6hm8gBa5EwRA3adj2DjCs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740760762;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o2Z/+S0bCpIiR/CVWr/u3iutpDVKtDE6whnqXRO+9u8=;
	b=tU/xh/FVayA97vO9aBwbHWWtvr39v4qJc89EceUl7pyBmTxdGLlnPCVGdoeAAf1wE6J0nm
	U9wU2uzkOv07XtBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740760762; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o2Z/+S0bCpIiR/CVWr/u3iutpDVKtDE6whnqXRO+9u8=;
	b=cXz8DuyzO3RX8yrluy8Jk489nDWdrLlrqszF2Up5KEEVGmL1saU9abNYyN53qFHlPkewuP
	RgYVHta9FQ6W2Zba8oMS2yrwFp5yhYn+vDCA/E8v5oUPKDWb4XJQMbBIDWvPJG3VVOVDVJ
	Ym9AVjIGTE6hm8gBa5EwRA3adj2DjCs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740760762;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o2Z/+S0bCpIiR/CVWr/u3iutpDVKtDE6whnqXRO+9u8=;
	b=tU/xh/FVayA97vO9aBwbHWWtvr39v4qJc89EceUl7pyBmTxdGLlnPCVGdoeAAf1wE6J0nm
	U9wU2uzkOv07XtBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 943C4137AC;
	Fri, 28 Feb 2025 16:39:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mIN5IrrmwWcKYwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 28 Feb 2025 16:39:22 +0000
Message-ID: <5d8ccfd7-2487-49a7-afbf-1706c0fb43f5@suse.cz>
Date: Fri, 28 Feb 2025 17:39:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/list_lru: Remove redundant NULL check before kfree()
Content-Language: en-US
To: Yu-Chun Lin <eleanor15x@gmail.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, jserv@ccns.ncku.edu.tw,
 visitorckw@gmail.com, kernel test robot <lkp@intel.com>
References: <20250228141856.730825-1-eleanor15x@gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20250228141856.730825-1-eleanor15x@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linux-foundation.org];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,vger.kernel.org,ccns.ncku.edu.tw,gmail.com,intel.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On 2/28/25 15:18, Yu-Chun Lin wrote:
> The kernel's kfree() documentation states: "If @object is NULL, no
> operation is performed." Remove checking for NULL before calling kfree().
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202502250720.9ueIb7Xh-lkp@intel.com/
> Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>

This is already in mm-unstable:
https://lore.kernel.org/all/20250227082223.1173847-1-jingxiangzeng.cas@gmail.com/

> ---
>  mm/list_lru.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/list_lru.c b/mm/list_lru.c
> index 7d69434c70e0..7c8fb17d9027 100644
> --- a/mm/list_lru.c
> +++ b/mm/list_lru.c
> @@ -548,8 +548,7 @@ int memcg_list_lru_alloc(struct mem_cgroup *memcg, struct list_lru *lru,
>  			}
>  			xas_unlock_irqrestore(&xas, flags);
>  		} while (xas_nomem(&xas, gfp));
> -		if (mlru)
> -			kfree(mlru);
> +		kfree(mlru);
>  	} while (pos != memcg && !css_is_dying(&pos->css));
>  
>  	return xas_error(&xas);


