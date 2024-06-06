Return-Path: <linux-kernel+bounces-203842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7498FE118
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AD6F28923A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E519113D280;
	Thu,  6 Jun 2024 08:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="agkyIPbx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HwlqLsx9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="agkyIPbx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HwlqLsx9"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588BA13C812
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 08:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717662963; cv=none; b=lR3wuaAsbJBiRjQfX+ki56Nfx+/aoyxsnGlKlAz1c2eW0QvX972rSm/5fPlBkgqFZfNdt47WwFbb7qiR9jFsHkf9gY29CSB3FFOlKxZao3qKoTAl/YVt9ej9Zpe5tWdj9MYHpKifz6zjA7hzb8JAOURpUj3wcddPy+Rfa8GgH5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717662963; c=relaxed/simple;
	bh=h5MaGUe3MI7rAIRC5xbnYNFqOJ/Ukf2kn6KcA2QehpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tp/9ABMpWe9WTz3o1BQquxr96k3mJ7xuvpSTpXqaqRVrjumckZiRrnPPy8c/YFWzYYz/s3MdY+NMG54cE0X4KIcPXu+rmDGh6saj2Paku4JwOhDhgkq9KIWq2Grp0nk5C5BO2ZevbVRMafGvsRoxY7XHgBvSjjkSql7KJR4GKOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=agkyIPbx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HwlqLsx9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=agkyIPbx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HwlqLsx9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2372221AD8;
	Thu,  6 Jun 2024 08:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717662955; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BzafF/9Ae7kwGLcFiDETjPkS0+rFEzBvXkCkAibKgTc=;
	b=agkyIPbxV5sqySyeSJKi0WwMVxNnSWccTchSc1ZfdKkxZ33Hh3AswsgnxGlghLTg1TzL/r
	YhZlzxR5ictqBUr/EtyclIbXwIoy3axtYI6MSMzWND9BzvJ2fkO93v8YPQAyzwjaS4BjrS
	gFx9/l1sfRFHY0dlAH+0BFLDI5O+vSA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717662955;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BzafF/9Ae7kwGLcFiDETjPkS0+rFEzBvXkCkAibKgTc=;
	b=HwlqLsx9CFHArZX9omzlrLX1LewRuyXUfaK4kfZHM/VYfhJlYqRuHzhvwPGUmWVSJMLxve
	9wWweS287Vhpg0AQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=agkyIPbx;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=HwlqLsx9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717662955; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BzafF/9Ae7kwGLcFiDETjPkS0+rFEzBvXkCkAibKgTc=;
	b=agkyIPbxV5sqySyeSJKi0WwMVxNnSWccTchSc1ZfdKkxZ33Hh3AswsgnxGlghLTg1TzL/r
	YhZlzxR5ictqBUr/EtyclIbXwIoy3axtYI6MSMzWND9BzvJ2fkO93v8YPQAyzwjaS4BjrS
	gFx9/l1sfRFHY0dlAH+0BFLDI5O+vSA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717662955;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BzafF/9Ae7kwGLcFiDETjPkS0+rFEzBvXkCkAibKgTc=;
	b=HwlqLsx9CFHArZX9omzlrLX1LewRuyXUfaK4kfZHM/VYfhJlYqRuHzhvwPGUmWVSJMLxve
	9wWweS287Vhpg0AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0C58B13A1E;
	Thu,  6 Jun 2024 08:35:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tnS3Aut0YWb9ZQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 06 Jun 2024 08:35:55 +0000
Message-ID: <92b759d3-ab88-4471-8698-d80296b1148b@suse.cz>
Date: Thu, 6 Jun 2024 10:35:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] slab: delete useless RED_INACTIVE and RED_ACTIVE
Content-Language: en-US
To: Chengming Zhou <chengming.zhou@linux.dev>,
 Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Feng Tang <feng.tang@intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 zhouchengming@bytedance.com
References: <20240605-b4-slab-debug-v2-0-c535b9cd361c@linux.dev>
 <20240605-b4-slab-debug-v2-3-c535b9cd361c@linux.dev>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20240605-b4-slab-debug-v2-3-c535b9cd361c@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -3.00
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 2372221AD8
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_TO(0.00)[linux.dev,linux.com,kernel.org,google.com,lge.com,linux-foundation.org,gmail.com,intel.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from]

On 6/5/24 9:13 AM, Chengming Zhou wrote:
> These seem useless since we use the SLUB_RED_INACTIVE and SLUB_RED_ACTIVE,
> so just delete them, no functional change.
> 
> Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  include/linux/poison.h       | 7 ++-----
>  mm/slub.c                    | 4 ++--
>  tools/include/linux/poison.h | 7 ++-----
>  3 files changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/poison.h b/include/linux/poison.h
> index 1f0ee2459f2a..9c1a035af97c 100644
> --- a/include/linux/poison.h
> +++ b/include/linux/poison.h
> @@ -38,11 +38,8 @@
>   * Magic nums for obj red zoning.
>   * Placed in the first word before and the first word after an obj.
>   */
> -#define	RED_INACTIVE	0x09F911029D74E35BULL	/* when obj is inactive */
> -#define	RED_ACTIVE	0xD84156C5635688C0ULL	/* when obj is active */
> -
> -#define SLUB_RED_INACTIVE	0xbb
> -#define SLUB_RED_ACTIVE		0xcc
> +#define SLUB_RED_INACTIVE	0xbb	/* when obj is inactive */
> +#define SLUB_RED_ACTIVE		0xcc	/* when obj is active */
>  
>  /* ...and for poisoning */
>  #define	POISON_INUSE	0x5a	/* for use-uninitialised poisoning */
> diff --git a/mm/slub.c b/mm/slub.c
> index 704c662227e6..0bab0f041ab2 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1214,8 +1214,8 @@ static int check_bytes_and_report(struct kmem_cache *s, struct slab *slab,
>   * 	Padding is extended by another word if Redzoning is enabled and
>   * 	object_size == inuse.
>   *
> - * 	We fill with 0xbb (RED_INACTIVE) for inactive objects and with
> - * 	0xcc (RED_ACTIVE) for objects in use.
> + * 	We fill with 0xbb (SLUB_RED_INACTIVE) for inactive objects and with
> + * 	0xcc (SLUB_RED_ACTIVE) for objects in use.
>   *
>   * object + s->inuse
>   * 	Meta data starts here.
> diff --git a/tools/include/linux/poison.h b/tools/include/linux/poison.h
> index 2e6338ac5eed..e530e54046c9 100644
> --- a/tools/include/linux/poison.h
> +++ b/tools/include/linux/poison.h
> @@ -47,11 +47,8 @@
>   * Magic nums for obj red zoning.
>   * Placed in the first word before and the first word after an obj.
>   */
> -#define	RED_INACTIVE	0x09F911029D74E35BULL	/* when obj is inactive */
> -#define	RED_ACTIVE	0xD84156C5635688C0ULL	/* when obj is active */
> -
> -#define SLUB_RED_INACTIVE	0xbb
> -#define SLUB_RED_ACTIVE		0xcc
> +#define SLUB_RED_INACTIVE	0xbb	/* when obj is inactive */
> +#define SLUB_RED_ACTIVE		0xcc	/* when obj is active */
>  
>  /* ...and for poisoning */
>  #define	POISON_INUSE	0x5a	/* for use-uninitialised poisoning */
> 


