Return-Path: <linux-kernel+bounces-377581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7495B9AC0E0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 953D51C233F1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 08:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EC2155CBD;
	Wed, 23 Oct 2024 08:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TY3ntfsJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="epfsrfir";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TY3ntfsJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="epfsrfir"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE243143C40
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 08:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729670453; cv=none; b=lNYGHXabV/ocQNzvorvteQseM/kHcYBig28mepXKRl62ZmMoEav0aDujGlBRnRkpdtd+KjnXs3mkE80G2wlievWPlPV6D2Iq2Qwe2HirxpOx1v7sHsu8qqtk/rpFeEAuu5L45brV2IEASjz3OyN3Q6LIz1SPYlx4LyTtm8iryx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729670453; c=relaxed/simple;
	bh=RDENvc4NKnRbdF+ewA8VZ5ikQze4xVC215Skq6IZN7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i3VvNJ6SUtAK+E4vkNrhaBJuN9wp8zon6GPsPQ+68i4qpPZrde02vClImfluipvWqU0whGM0LbjkoPqb1p49JKFVnoeg43v8AURKvgRLM24UWo+lKvfjGLpQnBuv8TZzztHvVUbciazVsnpg8ULe9nXHg6V7vD4TW19NzERzTwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TY3ntfsJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=epfsrfir; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TY3ntfsJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=epfsrfir; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 08E4C21B1C;
	Wed, 23 Oct 2024 08:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729670449; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CrRCw9M6HseYj/8j1JzkG9che+niQGA7M5qHxqGnnYg=;
	b=TY3ntfsJ/miqct3YG9xnT+unFGb0lTelfgbgelOSf5KqTTx706TDRUX4oGk2Ex0SovsHmO
	LPXl0cgFfRisSnu+Adr291RGSEnviJ7+Z4I9POjNCGHKifpPL4F1riuvzwrI4kY5Jl2VTs
	YzqRoOIR/VztuS7qx5sKpshc5q2aeso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729670449;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CrRCw9M6HseYj/8j1JzkG9che+niQGA7M5qHxqGnnYg=;
	b=epfsrfirbu86A8mC7+astVI4Wp0LjmpfJgEsN7E2FmkFGN6qdsfxmox3oiGuY8Utck4sN7
	gNaqqRQnGWHfMUCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=TY3ntfsJ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=epfsrfir
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729670449; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CrRCw9M6HseYj/8j1JzkG9che+niQGA7M5qHxqGnnYg=;
	b=TY3ntfsJ/miqct3YG9xnT+unFGb0lTelfgbgelOSf5KqTTx706TDRUX4oGk2Ex0SovsHmO
	LPXl0cgFfRisSnu+Adr291RGSEnviJ7+Z4I9POjNCGHKifpPL4F1riuvzwrI4kY5Jl2VTs
	YzqRoOIR/VztuS7qx5sKpshc5q2aeso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729670449;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CrRCw9M6HseYj/8j1JzkG9che+niQGA7M5qHxqGnnYg=;
	b=epfsrfirbu86A8mC7+astVI4Wp0LjmpfJgEsN7E2FmkFGN6qdsfxmox3oiGuY8Utck4sN7
	gNaqqRQnGWHfMUCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E5EB613AD3;
	Wed, 23 Oct 2024 08:00:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QrvCNzCtGGcOEAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 23 Oct 2024 08:00:48 +0000
Message-ID: <873ca7e7-5789-4e4c-b3aa-4331cf2b6638@suse.cz>
Date: Wed, 23 Oct 2024 10:00:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] slub_kunit:fix a WARNING due to __kmalloc_cache_noprof
 incorretly use
Content-Language: en-US
To: Pei Xiao <xiaopei01@kylinos.cn>, surenb@google.com
Cc: akpm@linux-foundation.org, gehao@kylinos.cn, hao.ge@linux.dev,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, xiaopeitux@foxmail.com,
 xiongxin@kylinos.cn, yuzhao@google.com
References: <CAJuCfpHxrN_12h3pmK6Z+k7W1_6QWgAym9xgczcKTjYyLQ+S_Q@mail.gmail.com>
 <0c215961308b0433cd76389fe53d7f7776a32dcb.1729663738.git.xiaopei01@kylinos.cn>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <0c215961308b0433cd76389fe53d7f7776a32dcb.1729663738.git.xiaopei01@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 08E4C21B1C
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[foxmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,kylinos.cn,linux.dev,vger.kernel.org,kvack.org,foxmail.com,google.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 10/23/24 08:21, Pei Xiao wrote:
> 'modprobe slub_kunit',will have a warning [1].The root cause is that
> __kmalloc_cache_noprof was directly used,which resulted in no alloc_tag
> being allocated.This caused current->alloc_tag to be null,leading to
> a warning in alloc_tag_add_check.
> 
> Let's add an alloc_hook layer to __kmalloc_cache_noprof specifically
> within lib/slub_kunit.c.
> 
> [1].
> [58162.947016] WARNING: CPU: 2 PID: 6210 at
> ./include/linux/alloc_tag.h:125 alloc_tagging_slab_alloc_hook+0x268/0x27c
> [58162.957721] Call trace:
> [58162.957919]  alloc_tagging_slab_alloc_hook+0x268/0x27c
> [58162.958286]  __kmalloc_cache_noprof+0x14c/0x344
> [58162.958615]  test_kmalloc_redzone_access+0x50/0x10c [slub_kunit]
> [58162.959045]  kunit_try_run_case+0x74/0x184 [kunit]
> [58162.959401]  kunit_generic_run_threadfn_adapter+0x2c/0x4c [kunit]
> [58162.959841]  kthread+0x10c/0x118
> [58162.960093]  ret_from_fork+0x10/0x20
> [58162.960363] ---[ end trace 0000000000000000 ]---
> 
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> Fixes: a0a44d9175b3 ("mm, slab: don't wrap internal functions with alloc_hooks()")

Thanks, I'm adding the fix for test_kmalloc_redzone_access() to
slab/for-6.12-rc4/fixes as a 6.12 hotfix

> Fixes: a286da323418 ("mm/slub, kunit: Add testcase for krealloc redzone and zeroing")

This is in slab/for-next so I will just adjust the new tests in place there.

> ---
>  lib/slub_kunit.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/slub_kunit.c b/lib/slub_kunit.c
> index 3cd1cc667988..f11691315c2f 100644
> --- a/lib/slub_kunit.c
> +++ b/lib/slub_kunit.c
> @@ -141,7 +141,7 @@ static void test_kmalloc_redzone_access(struct kunit *test)
>  {
>  	struct kmem_cache *s = test_kmem_cache_create("TestSlub_RZ_kmalloc", 32,
>  				SLAB_KMALLOC|SLAB_STORE_USER|SLAB_RED_ZONE);
> -	u8 *p = __kmalloc_cache_noprof(s, GFP_KERNEL, 18);
> +	u8 *p = alloc_hooks(__kmalloc_cache_noprof(s, GFP_KERNEL, 18));
>  
>  	kasan_disable_current();
>  
> @@ -199,7 +199,7 @@ static void test_krealloc_redzone_zeroing(struct kunit *test)
>  	struct kmem_cache *s = test_kmem_cache_create("TestSlub_krealloc", 64,
>  				SLAB_KMALLOC|SLAB_STORE_USER|SLAB_RED_ZONE);
>  
> -	p = __kmalloc_cache_noprof(s, GFP_KERNEL, 48);
> +	p = alloc_hooks(__kmalloc_cache_noprof(s, GFP_KERNEL, 48));
>  	memset(p, 0xff, 48);
>  
>  	kasan_disable_current();


