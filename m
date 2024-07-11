Return-Path: <linux-kernel+bounces-248769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDA192E1BD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 10:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9C97B22ADD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 08:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77A91514DA;
	Thu, 11 Jul 2024 08:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kvnlSRMP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rC6RTVVe";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kvnlSRMP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rC6RTVVe"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCA41509A6
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 08:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720685592; cv=none; b=WV1rPbb7ts5B5uyCrMv5fKNUltw0oFBBLMiACxWBK3u0vdu/NNGWNEggIVS8Adr3Lh+xvUqua6FiqT2+U0t5go0oDPwho1EvH0WY06kddFCr+LVIObEWrOPi7sxGoQnZ2Ddqtf4JywYZ2UHdv89cblYmpLiqxCplUVzwqSUhAkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720685592; c=relaxed/simple;
	bh=XUQUDMxSjhgGf3D0QdlcDv+64r0y2CQZ37AplO6mXkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YD28tdHZtLiTrqoRrXx4XKs0JIZxAxn0EeHi8Md6DjSDi9jC6fXz34rVwrHzm7ALq0wHXkqrds7KqetOikyTVE8sBGk+0yn15Apd3DoCCL7Q19AzFGj4dn1tMeCcOoWAqhnQW4GbMuhSwpCkzTEG4Hc11mhp/2w7uwQH+mFA/mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kvnlSRMP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rC6RTVVe; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kvnlSRMP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rC6RTVVe; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2C2052191C;
	Thu, 11 Jul 2024 08:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720685589; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iXv7ArpG3e8N4OhGTgyHxbykD3wgp31n59XMlfWeuSw=;
	b=kvnlSRMPMh3rHHVP8q9jJbWJbQzel3IyMGmIgXBL5sTOxtjCDYgdESKylma8IvJo6S/lKy
	6GzjlrMtcCCezcni5w3tEAU+XriDWJNT0foMSxfdkQvrkAcz/IsyyHaTXtaAFMEWF9C9th
	L4m7hT2cdzFTTinkniKwaVVM1Mzxd4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720685589;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iXv7ArpG3e8N4OhGTgyHxbykD3wgp31n59XMlfWeuSw=;
	b=rC6RTVVe4IeWhNpgRYcCvKuXzzfiBLKrRtbM91yGZCk97MbmT4aKo813oolL4Jxu71Ulwx
	PdtGhfRflL13kSAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720685589; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iXv7ArpG3e8N4OhGTgyHxbykD3wgp31n59XMlfWeuSw=;
	b=kvnlSRMPMh3rHHVP8q9jJbWJbQzel3IyMGmIgXBL5sTOxtjCDYgdESKylma8IvJo6S/lKy
	6GzjlrMtcCCezcni5w3tEAU+XriDWJNT0foMSxfdkQvrkAcz/IsyyHaTXtaAFMEWF9C9th
	L4m7hT2cdzFTTinkniKwaVVM1Mzxd4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720685589;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iXv7ArpG3e8N4OhGTgyHxbykD3wgp31n59XMlfWeuSw=;
	b=rC6RTVVe4IeWhNpgRYcCvKuXzzfiBLKrRtbM91yGZCk97MbmT4aKo813oolL4Jxu71Ulwx
	PdtGhfRflL13kSAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F027136AF;
	Thu, 11 Jul 2024 08:13:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sHFQAxWUj2ZsHgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 11 Jul 2024 08:13:09 +0000
Message-ID: <42afbce8-7746-438f-ba3a-c997a2c702e5@suse.cz>
Date: Thu, 11 Jul 2024 10:13:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] mm/memcg: alignment memcg_data define condition
Content-Language: en-US
To: alexs@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Yoann Congal
 <yoann.congal@smile.fr>, Masahiro Yamada <masahiroy@kernel.org>,
 Petr Mladek <pmladek@suse.com>, Suren Baghdasaryan <surenb@google.com>
References: <20240710054336.190410-1-alexs@kernel.org>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20240710054336.190410-1-alexs@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: 1.21
X-Spamd-Result: default: False [1.21 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,linux-foundation.org,linux.com,google.com,lge.com,linux.dev,gmail.com,kvack.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Level: *

On 7/10/24 7:43 AM, alexs@kernel.org wrote:
> From: "Alex Shi (Tencent)" <alexs@kernel.org>
> 
> commit 21c690a349ba ("mm: introduce slabobj_ext to support slab object
> extensions") changed the folio/page->memcg_data define condition from
> MEMCG to SLAB_OBJ_EXT. And selected SLAB_OBJ_EXT for MEMCG, just for
> SLAB_MATCH(memcg_data, obj_exts), even no other relationship between them.
> 
> Above action make memcg_data exposed and include SLAB_OBJ_EXT for
> !MEMCG. That's incorrect in logcial and pay on code size.
> 
> As Vlastimil Babka suggested, let's add _unused_slab_obj_ext for
> SLAB_MATCH for slab.obj_exts while !MEMCG. That could resolve the match
> issue, clean up the feature logical. And decouple the SLAB_OBJ_EXT from
> MEMCG in next patch.
> 
> Signed-off-by: Alex Shi (Tencent) <alexs@kernel.org>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Yoann Congal <yoann.congal@smile.fr>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> ---
> v1->v3: take Vlastimil's suggestion and move SLAB_OBJ_EXT/MEMCG decouple
> to 2nd patch.
> ---
>  include/linux/mm_types.h | 8 ++++++--
>  mm/slab.h                | 4 ++++
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index ef09c4eef6d3..4ac3abc673d3 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -180,8 +180,10 @@ struct page {
>  	/* Usage count. *DO NOT USE DIRECTLY*. See page_ref.h */
>  	atomic_t _refcount;
>  
> -#ifdef CONFIG_SLAB_OBJ_EXT
> +#ifdef CONFIG_MEMCG
>  	unsigned long memcg_data;
> +#elif defined(CONFIG_SLAB_OBJ_EXT)
> +	unsigned long _unused_slab_obj_ext;
>  #endif
>  
>  	/*
> @@ -343,8 +345,10 @@ struct folio {
>  			};
>  			atomic_t _mapcount;
>  			atomic_t _refcount;
> -#ifdef CONFIG_SLAB_OBJ_EXT
> +#ifdef CONFIG_MEMCG
>  			unsigned long memcg_data;
> +#elif defined(CONFIG_SLAB_OBJ_EXT)
> +			unsigned long _unused_slab_obj_ext;
>  #endif
>  #if defined(WANT_PAGE_VIRTUAL)
>  			void *virtual;
> diff --git a/mm/slab.h b/mm/slab.h
> index 3586e6183224..8ffdd4f315f8 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -98,7 +98,11 @@ SLAB_MATCH(flags, __page_flags);
>  SLAB_MATCH(compound_head, slab_cache);	/* Ensure bit 0 is clear */
>  SLAB_MATCH(_refcount, __page_refcount);
>  #ifdef CONFIG_SLAB_OBJ_EXT
> +#ifdef CONFIG_MEMCG
>  SLAB_MATCH(memcg_data, obj_exts);
> +#else
> +SLAB_MATCH(_unused_slab_obj_ext, obj_exts);
> +#endif
>  #endif

Why not also #ifdef / #elif like above, instead of this nesting?

>  #undef SLAB_MATCH
>  static_assert(sizeof(struct slab) <= sizeof(struct page));


