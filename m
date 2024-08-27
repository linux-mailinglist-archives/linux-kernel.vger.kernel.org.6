Return-Path: <linux-kernel+bounces-302721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA468960282
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 08:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CE241F231B4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 06:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92141158DD0;
	Tue, 27 Aug 2024 06:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0kCF8QJd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="i8KDeLBm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0kCF8QJd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="i8KDeLBm"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED6114C59A
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 06:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724741561; cv=none; b=Y+2DPlLQ7I0VLuMPwAg+hesehY4Y6nZjP/Am3YxVFdDmeG8CslTqUR6EWQlcYz49QaKRLANuVAxCikanqZBW/YiQ61b3u4ZMBuLbR7TGBf10BKQdwEAi4WPFdZUZJxIC6+yK/CQqhMCMohaFChGc0lekoKp4mEDzOKyI8RujIFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724741561; c=relaxed/simple;
	bh=vwYWQDbz3vUpYB7jwSyI07uQM43VjcbTQ5zEvhsJNWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CMiz1MKZVVhcU/9LTCEYeO11Slg2cKlBNfd+Yr+nndrAtynzP19tuZMSXmGrUV/trBppez8nDlDErQfnPjulEQ6BTGBy0pmDbpejxrl/YqK4sR7rPYDz+ukhv+TNfU65WuamtgkTWXL6P/n4e2k91qd0LykxuVlNQ+g31MuR8Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0kCF8QJd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=i8KDeLBm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0kCF8QJd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=i8KDeLBm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 614EC219C4;
	Tue, 27 Aug 2024 06:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724741557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Q4Q/foGOiwLAlEEnyHFbOjEBIbylsqi1rcIrtd8oivM=;
	b=0kCF8QJdQLejjw8wZ/nJ86lvZTqgFB7QjhcCqNMgywpXq0BhCsgiNdifUApOTSMzqVJzgd
	/UAPwbfs8wRRpHfm+fnIPzustXf8qN2DdNytjG5XKBbOT9HRx32dg7dg6YPmkJ/HOm76g0
	FuzdlHrr9r4fn1XTf1E53KdtIkEakj4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724741557;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Q4Q/foGOiwLAlEEnyHFbOjEBIbylsqi1rcIrtd8oivM=;
	b=i8KDeLBmay6hjGV5q2pc9kBNKu5WmOS8Pj2f+s/oYKOiosReMXLU7BdPuTsqUdn87mF/q3
	GjTG6qlCel2qn5Bw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724741557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Q4Q/foGOiwLAlEEnyHFbOjEBIbylsqi1rcIrtd8oivM=;
	b=0kCF8QJdQLejjw8wZ/nJ86lvZTqgFB7QjhcCqNMgywpXq0BhCsgiNdifUApOTSMzqVJzgd
	/UAPwbfs8wRRpHfm+fnIPzustXf8qN2DdNytjG5XKBbOT9HRx32dg7dg6YPmkJ/HOm76g0
	FuzdlHrr9r4fn1XTf1E53KdtIkEakj4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724741557;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Q4Q/foGOiwLAlEEnyHFbOjEBIbylsqi1rcIrtd8oivM=;
	b=i8KDeLBmay6hjGV5q2pc9kBNKu5WmOS8Pj2f+s/oYKOiosReMXLU7BdPuTsqUdn87mF/q3
	GjTG6qlCel2qn5Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3999113724;
	Tue, 27 Aug 2024 06:52:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0p5eDbV3zWbzbgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 27 Aug 2024 06:52:37 +0000
Message-ID: <8678eac7-93c3-4a85-86e3-0fef8facb1f0@suse.cz>
Date: Tue, 27 Aug 2024 08:52:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/slub: Add check for s->flags in the
 alloc_tagging_slab_free_hook
To: Hao Ge <hao.ge@linux.dev>, surenb@google.com
Cc: 42.hyeyoo@gmail.com, akpm@linux-foundation.org, cl@linux.com,
 gehao@kylinos.cn, iamjoonsoo.kim@lge.com, kees@kernel.org,
 kent.overstreet@linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 penberg@kernel.org, rientjes@google.com, roman.gushchin@linux.dev
References: <CAJuCfpF5v397w9+532bQzPonXzAbBwVVvuXFw3z46q0R1E7Rug@mail.gmail.com>
 <20240816013336.17505-1-hao.ge@linux.dev>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20240816013336.17505-1-hao.ge@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,linux.com,kylinos.cn,lge.com,kernel.org,linux.dev,vger.kernel.org,kvack.org,google.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On 8/16/24 03:33, Hao Ge wrote:
> From: Hao Ge <gehao@kylinos.cn>
> 
> When enable CONFIG_MEMCG & CONFIG_KFENCE & CONFIG_KMEMLEAK,
> the following warning always occurs,This is because the
> following call stack occurred:
> mem_pool_alloc
>     kmem_cache_alloc_noprof
>         slab_alloc_node
>             kfence_alloc
> 
> Once the kfence allocation is successful,slab->obj_exts will not be empty,
> because it has already been assigned a value in kfence_init_pool.
> 
> Since in the prepare_slab_obj_exts_hook function,we perform a check for
> s->flags & (SLAB_NO_OBJ_EXT | SLAB_NOLEAKTRACE),the alloc_tag_add function
> will not be called as a result.Therefore,ref->ct remains NULL.
> 
> However,when we call mem_pool_free,since obj_ext is not empty,
> it eventually leads to the alloc_tag_sub scenario being invoked.
> This is where the warning occurs.
> 
> So we should add corresponding checks in the alloc_tagging_slab_free_hook.
> For __GFP_NO_OBJ_EXT case,I didn't see the specific case where it's
> using kfence,so I won't add the corresponding check in
> alloc_tagging_slab_free_hook for now.
> 
> [    3.734349] ------------[ cut here ]------------
> [    3.734807] alloc_tag was not set
> [    3.735129] WARNING: CPU: 4 PID: 40 at ./include/linux/alloc_tag.h:130 kmem_cache_free+0x444/0x574
> [    3.735866] Modules linked in: autofs4
> [    3.736211] CPU: 4 UID: 0 PID: 40 Comm: ksoftirqd/4 Tainted: G        W          6.11.0-rc3-dirty #1
> [    3.736969] Tainted: [W]=WARN
> [    3.737258] Hardware name: QEMU KVM Virtual Machine, BIOS unknown 2/2/2022
> [    3.737875] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    3.738501] pc : kmem_cache_free+0x444/0x574
> [    3.738951] lr : kmem_cache_free+0x444/0x574
> [    3.739361] sp : ffff80008357bb60
> [    3.739693] x29: ffff80008357bb70 x28: 0000000000000000 x27: 0000000000000000
> [    3.740338] x26: ffff80008207f000 x25: ffff000b2eb2fd60 x24: ffff0000c0005700
> [    3.740982] x23: ffff8000804229e4 x22: ffff800082080000 x21: ffff800081756000
> [    3.741630] x20: fffffd7ff8253360 x19: 00000000000000a8 x18: ffffffffffffffff
> [    3.742274] x17: ffff800ab327f000 x16: ffff800083398000 x15: ffff800081756df0
> [    3.742919] x14: 0000000000000000 x13: 205d344320202020 x12: 5b5d373038343337
> [    3.743560] x11: ffff80008357b650 x10: 000000000000005d x9 : 00000000ffffffd0
> [    3.744231] x8 : 7f7f7f7f7f7f7f7f x7 : ffff80008237bad0 x6 : c0000000ffff7fff
> [    3.744907] x5 : ffff80008237ba78 x4 : ffff8000820bbad0 x3 : 0000000000000001
> [    3.745580] x2 : 68d66547c09f7800 x1 : 68d66547c09f7800 x0 : 0000000000000000
> [    3.746255] Call trace:
> [    3.746530]  kmem_cache_free+0x444/0x574
> [    3.746931]  mem_pool_free+0x44/0xf4
> [    3.747306]  free_object_rcu+0xc8/0xdc
> [    3.747693]  rcu_do_batch+0x234/0x8a4
> [    3.748075]  rcu_core+0x230/0x3e4
> [    3.748424]  rcu_core_si+0x14/0x1c
> [    3.748780]  handle_softirqs+0x134/0x378
> [    3.749189]  run_ksoftirqd+0x70/0x9c
> [    3.749560]  smpboot_thread_fn+0x148/0x22c
> [    3.749978]  kthread+0x10c/0x118
> [    3.750323]  ret_from_fork+0x10/0x20
> [    3.750696] ---[ end trace 0000000000000000 ]---
> 
> Fixes: 4b8736964640 ("mm/slab: add allocation accounting into slab allocation and free paths")
> Signed-off-by: Hao Ge <gehao@kylinos.cn>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/slub.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index c9d8a2497fd6..a77f354f8325 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2116,6 +2116,10 @@ alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
>  	if (!mem_alloc_profiling_enabled())
>  		return;
>  
> +	/* slab->obj_exts might not be NULL if it was created for MEMCG accounting. */
> +	if (s->flags & (SLAB_NO_OBJ_EXT | SLAB_NOLEAKTRACE))
> +		return;
> +
>  	obj_exts = slab_obj_exts(slab);
>  	if (!obj_exts)
>  		return;


