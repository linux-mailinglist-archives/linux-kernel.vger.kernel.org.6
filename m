Return-Path: <linux-kernel+bounces-302098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 700F695F9C1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 21:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFAFF1F22564
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 19:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D74D1990D1;
	Mon, 26 Aug 2024 19:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fog1W2+D";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yoXpsPs9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fog1W2+D";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yoXpsPs9"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F196C2B9C5
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 19:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724701054; cv=none; b=LjKQxPXm3F76ijMcFeXBh83M4M765mISTDC6nmQkAF2U6AZkLtoiS/9pBOrc+5jHE4yLawnZw3bgWSNVGCj2t5WoYQKKARM0bnRCQvegdGDplGzKJHpehYSAjwKdj2+gCHIyRYdUJFGm3iLu0/WcCiJ3qS7STWS+GnOMl0hU4TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724701054; c=relaxed/simple;
	bh=gW7nFpxbgecaYdl/GnT19SoA2e44pZ3Va7K76AI9zdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ggVyJsE7CFjVhLVHrRrY9OMaokcBRBlsD6UkrlwZ4nUmcGLMiKL6mG/A4lBZ22r011OVnuXnea842+x7kXVN6fbovFFVRkri7c0AWvxAHZYmxU+QG2Xxf/BUFgtsB/sZyEGqyLi+TENCxvsz1K7MPmCR50W+F8ruf3xd5uEMK+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fog1W2+D; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yoXpsPs9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fog1W2+D; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yoXpsPs9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6B1A71F8AE;
	Mon, 26 Aug 2024 19:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724701050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AM9Yu9crE+Dnvqj4P19XUNUjohuYiAhMBrqXxIyCMak=;
	b=fog1W2+DbgaPuYbmekwiyX5492NC2BJ1B18SktI5p+8VbZgw8/CmS53Dez/iV/ZnTeNOmD
	JmtUvsZFp7fS5NRCWUyfJyEtLcK+IMPgL7v4O/ZvBjUbhzxU4fA6JNoKvkAFVBEh3GchYV
	jH/tQxa+O1w3X5xgJKRG9K34xFNN+Sc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724701050;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AM9Yu9crE+Dnvqj4P19XUNUjohuYiAhMBrqXxIyCMak=;
	b=yoXpsPs9QPb0Ym6kGoT4YJ/fd90Lrt52e1ahdm3P+DOX+bC8dvxoAjXgSyiXuiCKTois/x
	2nsvHx1J+Ytj3QCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724701050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AM9Yu9crE+Dnvqj4P19XUNUjohuYiAhMBrqXxIyCMak=;
	b=fog1W2+DbgaPuYbmekwiyX5492NC2BJ1B18SktI5p+8VbZgw8/CmS53Dez/iV/ZnTeNOmD
	JmtUvsZFp7fS5NRCWUyfJyEtLcK+IMPgL7v4O/ZvBjUbhzxU4fA6JNoKvkAFVBEh3GchYV
	jH/tQxa+O1w3X5xgJKRG9K34xFNN+Sc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724701050;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AM9Yu9crE+Dnvqj4P19XUNUjohuYiAhMBrqXxIyCMak=;
	b=yoXpsPs9QPb0Ym6kGoT4YJ/fd90Lrt52e1ahdm3P+DOX+bC8dvxoAjXgSyiXuiCKTois/x
	2nsvHx1J+Ytj3QCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4AD181398D;
	Mon, 26 Aug 2024 19:37:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id h46dEXrZzGbGOAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 26 Aug 2024 19:37:30 +0000
Message-ID: <4df50472-4f3b-4eb9-9c8e-ecfe45d34bb4@suse.cz>
Date: Mon, 26 Aug 2024 21:37:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] slub: Fixes freepointer encoding for single free
Content-Language: en-US
To: Peng Fan <peng.fan@nxp.com>,
 Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Chengming Zhou <chengming.zhou@linux.dev>,
 Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>
References: <ZjDXY74yS6UyQPxv@archlinux>
 <PAXPR04MB84594764DBDBEFB124CA9994888C2@PAXPR04MB8459.eurprd04.prod.outlook.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <PAXPR04MB84594764DBDBEFB124CA9994888C2@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,linux.com,kernel.org,google.com,lge.com,linux-foundation.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,imap1.dmz-prg2.suse.org:helo,suse.cz:mid]
X-Spam-Score: -2.80
X-Spam-Flag: NO

On 8/19/24 04:43, Peng Fan wrote:
> Hi Nicolas,
>> Subject: [PATCH v3] slub: Fixes freepointer encoding for single free
>> 
> 
> With slub_debug=FUZ init_on_free=1 loglevel=7, I see error
> In 6.6 kernel. Should this patch be backported to 6.6?

But it was a fix for commit 284f17ac13fe that's from 6.8 and wasn't
backported to 6.6. Are you seeing the same error happening for the same
reason, or is it a different one?

> I also had a hack together with your patch applied to 6.6
> diff --git a/mm/slub.c b/mm/slub.c
> index 96406f9813e8..ff8cdc737722 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1209,7 +1209,8 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
>                         if (s->object_size > orig_size  &&
>                                 !check_bytes_and_report(s, slab, object,
>                                         "kmalloc Redzone", p + orig_size,
> -                                       val, s->object_size - orig_size)) {
> +                                       slab_want_init_on_free(s) ? 0 : val,
> +                                       s->object_size - orig_size)) {
>                                 return 0;
>                         }
>                 }
> 
> Thanks,
> Peng.
> 
>> From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
>> 
>> Commit 284f17ac13fe ("mm/slub: handle bulk and single object
>> freeing
>> separately") splits single and bulk object freeing in two functions
>> slab_free() and slab_free_bulk() which leads slab_free() to call
>> slab_free_hook() directly instead of slab_free_freelist_hook().
>> 
>> If `init_on_free` is set, slab_free_hook() zeroes the object.
>> Afterward, if `slub_debug=F` and `CONFIG_SLAB_FREELIST_HARDENED`
>> are set, the do_slab_free() slowpath executes freelist consistency
>> checks and try to decode a zeroed freepointer which leads to a
>> "Freepointer corrupt" detection in check_object().
>> 
>> During bulk free, slab_free_freelist_hook() isn't affected as it always
>> sets it objects freepointer using set_freepointer() to maintain its
>> reconstructed freelist after `init_on_free`.
>> 
>> For single free, object's freepointer thus needs to be avoided when
>> stored outside the object if `init_on_free` is set. The freepointer left as
>> is, check_object() may later detect an invalid pointer value due to
>> objects overflow.
>> 
>> To reproduce, set `slub_debug=FU init_on_free=1 log_level=7` on the
>> command line of a kernel build with
>> `CONFIG_SLAB_FREELIST_HARDENED=y`.
>> 
>> dmesg sample log:
>> [   10.708715]
>> ============================================================
>> =================
>> [   10.710323] BUG kmalloc-rnd-05-32 (Tainted: G    B           T ):
>> Freepointer corrupt
>> [   10.712695] -----------------------------------------------------------------------------
>> [   10.712695]
>> [   10.712695] Slab 0xffffd8bdc400d580 objects=32 used=4
>> fp=0xffff9d9a80356f80
>> flags=0x200000000000a00(workingset|slab|node=0|zone=2)
>> [   10.716698] Object 0xffff9d9a80356600 @offset=1536
>> fp=0x7ee4f480ce0ecd7c
>> [   10.716698]
>> [   10.716698] Bytes b4 ffff9d9a803565f0: 00 00 00 00 00 00 00 00 00
>> 00 00 00 00 00 00 00  ................
>> [   10.720703] Object   ffff9d9a80356600: 00 00 00 00 00 00 00 00 00
>> 00 00 00 00 00 00 00  ................
>> [   10.720703] Object   ffff9d9a80356610: 00 00 00 00 00 00 00 00 00
>> 00 00 00 00 00 00 00  ................
>> [   10.724696] Padding  ffff9d9a8035666c: 00 00 00 00 00 00 00 00 00
>> 00 00 00 00 00 00 00  ................
>> [   10.724696] Padding  ffff9d9a8035667c: 00 00 00
>> 00                                      ....
>> [   10.724696] FIX kmalloc-rnd-05-32: Object at 0xffff9d9a80356600
>> not freed
>> 
>> Co-developed-by: Chengming Zhou <chengming.zhou@linux.dev>
>> Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
>> ---
>> Changes since v2:
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2F
>> lore.kernel.org%2Fall%2FZjCxZfD1d36zfq-
>> R%40archlinux%2F&data=05%7C02%7Cpeng.fan%40nxp.com%7C38af
>> dff178a0422aeddc08dc690996f5%7C686ea1d3bc2b4c6fa92cd99c5c3
>> 01635%7C0%7C0%7C638500737122575573%7CUnknown%7CTWFpb
>> GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLC
>> JXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=Q4Vs38E%2F7HSIETGC2hYD
>> 07gN6U8hkVZR764Yn4TFWlw%3D&reserved=0
>> 
>> * Reword commit message in order to clarify the patch approach as
>> suggested by Vlastimil Babka
>> 
>> Changes since v1:
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2F
>> lore.kernel.org%2Fall%2FZij_fGjRS_rK-
>> 65r%40archlinux%2F&data=05%7C02%7Cpeng.fan%40nxp.com%7C38
>> afdff178a0422aeddc08dc690996f5%7C686ea1d3bc2b4c6fa92cd99c5c
>> 301635%7C0%7C0%7C638500737122594077%7CUnknown%7CTWFp
>> bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiL
>> CJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=xWgnIygCHwUPjnFENutIai
>> cMTk0HQTne8hQfOqIzbA0%3D&reserved=0
>> 
>> * Jump above out of object freepointer if init_on_free is set instead of
>> initializing it with set_freepointer() as suggested by Vlastimil Babka.
>> 
>> * Adapt maybe_wipe_obj_freeptr() to avoid wiping out of object on
>> alloc freepointer as suggested by Chengming Zhou.
>> 
>> * Reword commit message.
>> ---
>>  mm/slub.c | 11 ++++++++---
>>  1 file changed, 8 insertions(+), 3 deletions(-)
>> 
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 3aa12b9b323d..173c340ec1d3 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -2102,15 +2102,20 @@ bool slab_free_hook(struct kmem_cache
>> *s, void *x, bool init)
>>  	 *
>>  	 * The initialization memset's clear the object and the
>> metadata,
>>  	 * but don't touch the SLAB redzone.
>> +	 *
>> +	 * The object's freepointer is also avoided if stored outside the
>> +	 * object.
>>  	 */
>>  	if (unlikely(init)) {
>>  		int rsize;
>> +		unsigned int inuse;
>> 
>> +		inuse = get_info_end(s);
>>  		if (!kasan_has_integrated_init())
>>  			memset(kasan_reset_tag(x), 0, s->object_size);
>>  		rsize = (s->flags & SLAB_RED_ZONE) ? s->red_left_pad :
>> 0;
>> -		memset((char *)kasan_reset_tag(x) + s->inuse, 0,
>> -		       s->size - s->inuse - rsize);
>> +		memset((char *)kasan_reset_tag(x) + inuse, 0,
>> +			s->size - inuse - rsize);
>>  	}
>>  	/* KASAN might put x into memory quarantine, delaying its
>> reuse. */
>>  	return !kasan_slab_free(s, x, init);
>> @@ -3789,7 +3794,7 @@ static void *__slab_alloc_node(struct
>> kmem_cache *s,  static __always_inline void
>> maybe_wipe_obj_freeptr(struct kmem_cache *s,
>>  						   void *obj)
>>  {
>> -	if (unlikely(slab_want_init_on_free(s)) && obj)
>> +	if (unlikely(slab_want_init_on_free(s)) && obj &&
>> +!freeptr_outside_object(s))
>>  		memset((void *)((char *)kasan_reset_tag(obj) + s-
>> >offset),
>>  			0, sizeof(void *));
>>  }
>> --
>> 2.44.0
>> 
> 


