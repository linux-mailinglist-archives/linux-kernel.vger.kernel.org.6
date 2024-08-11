Return-Path: <linux-kernel+bounces-282362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC42294E2DC
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 22:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63C992812C1
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 20:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E060C15855F;
	Sun, 11 Aug 2024 20:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KYtfB2dG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9SiQN9Fq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KYtfB2dG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9SiQN9Fq"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A491F945
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 20:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723407285; cv=none; b=Jh7vLA9lxZ0C1tpBQzXV/FR8Wt08nLIEnFTe00148C+Kzyigo2+m3H6uhd1qU//3fg2jA0bmyZhczlWcq/zzgXUn43hIeZPwFik6ggKbpl02YtiOs81kHrrtCXs5KuXHpiXDlLdv7Sa8lCCgJizP1lgkdTEtvgf0zo6fO7gOl4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723407285; c=relaxed/simple;
	bh=8ZxSrQXt7prmzTRBmQs0hOoU/AgdwuWwYeM5Tu+/p7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vCZwYB2wkbVswSBnHNDb9L2vLrH9CX/I4YyYgpCr9QTi8DMn4uX9SNMPVptra2bAiyQeA+JTDucobZl1S/72V1U/ICCjt2hBWG6XS3lK48WuzFWt7jJetZPZ4iKvtuTTNTeOeNdnfC1ypbZEXp+kSWuBCeqVWqX8c9js/uhohqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KYtfB2dG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9SiQN9Fq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KYtfB2dG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9SiQN9Fq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 716BF223C0;
	Sun, 11 Aug 2024 20:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723407280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9D/KmRd9c6rXJChAaABYGZf445gCX9B0P6fJLBpMWqI=;
	b=KYtfB2dGBykn2wTDhiVBKG5TSqpXgqugCTdTWtbA2QgJnrG7OxzCapNdHtp+s9KNIO7L/q
	aeUYaUDGOvf3531hA888HZfb+9DEgHFQZDnAkM4ytX2RyrYlYzHoEJVbXZe9v38IJePmzC
	cREduBizwPkxsrq9ZU/NGnBPSm/GkLc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723407280;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9D/KmRd9c6rXJChAaABYGZf445gCX9B0P6fJLBpMWqI=;
	b=9SiQN9FqFmdTw3js8wqUmVk18GP+8wQGTmHVXm++EXVxZaV6RGXfEFRP+KOo5nfekuNfny
	GPhPyRkUFfHljMDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KYtfB2dG;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=9SiQN9Fq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723407280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9D/KmRd9c6rXJChAaABYGZf445gCX9B0P6fJLBpMWqI=;
	b=KYtfB2dGBykn2wTDhiVBKG5TSqpXgqugCTdTWtbA2QgJnrG7OxzCapNdHtp+s9KNIO7L/q
	aeUYaUDGOvf3531hA888HZfb+9DEgHFQZDnAkM4ytX2RyrYlYzHoEJVbXZe9v38IJePmzC
	cREduBizwPkxsrq9ZU/NGnBPSm/GkLc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723407280;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9D/KmRd9c6rXJChAaABYGZf445gCX9B0P6fJLBpMWqI=;
	b=9SiQN9FqFmdTw3js8wqUmVk18GP+8wQGTmHVXm++EXVxZaV6RGXfEFRP+KOo5nfekuNfny
	GPhPyRkUFfHljMDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 042C61398D;
	Sun, 11 Aug 2024 20:14:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nQoROq8buWYGcQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Sun, 11 Aug 2024 20:14:39 +0000
Message-ID: <a1058e89-7554-475a-9cc1-90af74b90917@suse.cz>
Date: Sun, 11 Aug 2024 22:16:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm, slub: print CPU id on slab OOM
To: Axel Rasmussen <axelrasmussen@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>,
 David Rientjes <rientjes@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Pekka Enberg <penberg@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240806232649.3258741-1-axelrasmussen@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
Content-Language: en-US
In-Reply-To: <20240806232649.3258741-1-axelrasmussen@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -3.00
X-Rspamd-Queue-Id: 716BF223C0
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
	FREEMAIL_TO(0.00)[google.com,linux-foundation.org,linux.com,gmail.com,lge.com,kernel.org,linux.dev];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spam-Flag: NO

On 8/7/24 1:26 AM, Axel Rasmussen wrote:
> Depending on how remote_node_defrag_ratio is configured, allocations can
> end up in this path as a result of the local node being OOM, despite the
> allocation overall being unconstrained (node == -1).
> 
> When we print a warning, printing the current CPU makes that situation
> more clear (i.e., you can immediately see which node's OOM status
> matters for the allocation at hand).
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>  mm/slub.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index c9d8a2497fd6..7148047998de 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3422,7 +3422,8 @@ slab_out_of_memory(struct kmem_cache *s, gfp_t gfpflags, int nid)
>  	if ((gfpflags & __GFP_NOWARN) || !__ratelimit(&slub_oom_rs))
>  		return;
>  
> -	pr_warn("SLUB: Unable to allocate memory on node %d, gfp=%#x(%pGg)\n",
> +	pr_warn("SLUB: Unable to allocate memory for CPU %u on node %d, gfp=%#x(%pGg)\n",

BTW, wouldn't "on CPU" be more correct, as "for CPU" might be misleading
that we are somehow constrained to that CPU?

> +		preemptible() ? raw_smp_processor_id() : smp_processor_id(),

Also could we just use raw_smp_processor_id() always here? I don't see
this has any advantage or am I missing something?

>  		nid, gfpflags, &gfpflags);
>  	pr_warn("  cache: %s, object size: %u, buffer size: %u, default order: %u, min order: %u\n",
>  		s->name, s->object_size, s->size, oo_order(s->oo),

