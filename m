Return-Path: <linux-kernel+bounces-256266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 366DB934BAE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 12:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B21831C21B0C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 10:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA73A84A4E;
	Thu, 18 Jul 2024 10:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Hj9y2EiN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cKRJ5ibt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vc+O3fLg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LlCf/DYi"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F283C78C76
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 10:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721298637; cv=none; b=d4xVa6TOHLwqkQZSNV/33XwMd+LOFLoqGohj4by/rtYK/ahjE62+qNoml3r6FImXPffopCWlXazJzx8RP1PgJVM8tEOC4TX6Wcm4qGTPiNFZxvpXw0JOiM3X8ybPNAmQVJWiA9fFrDugZmsgPe638R43Bp8/w3m5oSFa2dVuCDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721298637; c=relaxed/simple;
	bh=1HrxsMHHqPCxzP1A9+t0SClpK0znsPiIg671iR9VvQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OcxhmXo8/3IhoXoSMgKNscBY7IZZld/znGeAn+aeLXcQkqCExdetE3FDs0Yn7+49xNDyuG0LbDMzZvmcycKJfVY1oXdEcqLIVfWFMDgbpxqGE7q+V9fN8G1ZeScsUR9VvDCub7HrwnX89ecSz+7wyQiDxs/Jt1EZagUezd8CmZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Hj9y2EiN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cKRJ5ibt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vc+O3fLg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LlCf/DYi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E1564218C8;
	Thu, 18 Jul 2024 10:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721298634; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RKFn5iWbDyDH+/1O7Li0GpjI3lQtPk0/d9N6b/RMp8g=;
	b=Hj9y2EiNYaaC7DwATBjDGZA/XZD+vq6ReRXRHyEwEJwuNdu8eQkpchY0LmTDQccZlIWMhS
	eDOJlv64QSBgkKmWgZdZrb2IbDMyT4RwG09hLCJXEryaOjQ0GT20cR/Ynfnzca13FcE72s
	dy9VtDQ9UEOu1LwKNVxWagNArOvtOAs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721298634;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RKFn5iWbDyDH+/1O7Li0GpjI3lQtPk0/d9N6b/RMp8g=;
	b=cKRJ5ibtLfz2QMu5SM2lgUlqfOSZEWuETTtW176vhRmS/1d0ojMGSREZOgjxhPqIjD9Wk4
	K1sbIpLJSavw9CCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vc+O3fLg;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="LlCf/DYi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721298633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RKFn5iWbDyDH+/1O7Li0GpjI3lQtPk0/d9N6b/RMp8g=;
	b=vc+O3fLgoCbfDX0FuirGHz3WEZXwTNM7aIP5ugRL6Aw4f5pFyKI8xL0Mxos9+pyOBRqpiq
	l5bsBdhF4INRS8OAjiehtIigaZbkpwm3Z92bJLvAOPeWPQoyLSriEPKSv1RJdsZ4j9y68x
	mnDIED8aquicI9KzDba3R1vzxgz344Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721298633;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RKFn5iWbDyDH+/1O7Li0GpjI3lQtPk0/d9N6b/RMp8g=;
	b=LlCf/DYi0GGbuxXeR7AoZZjm2l1eh7PNuEnDP67FeNmgjxLpaiOPxmtltQBOCB3YEGpwUp
	dntjc8OwpPrb5BAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C63B6136F7;
	Thu, 18 Jul 2024 10:30:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hZUTL8numGb0SwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 18 Jul 2024 10:30:33 +0000
Message-ID: <65b7d88b-af4f-4869-9322-e38910abce6d@suse.cz>
Date: Thu, 18 Jul 2024 12:30:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: list_lru: fix UAF for memory cgroup
Content-Language: en-US
To: Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org
Cc: hannes@cmpxchg.org, muchun.song@linux.dev, nphamcs@gmail.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Michal Hocko <mhocko@kernel.org>
References: <20240718083607.42068-1-songmuchun@bytedance.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20240718083607.42068-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,linux.dev,gmail.com,kvack.org,vger.kernel.org,kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim]
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.50
X-Spam-Level: 
X-Rspamd-Queue-Id: E1564218C8

On 7/18/24 10:36 AM, Muchun Song wrote:
> The mem_cgroup_from_slab_obj() is supposed to be called under rcu
> lock or cgroup_mutex or others which could prevent returned memcg
> from being freed. Fix it by adding missing rcu read lock.

Was the UAF ever observed, or is this due to code review?
Should there be some lockdep_assert somwhere?

> Fixes: 0a97c01cd20bb ("list_lru: allow explicit memcg and NUMA node selection)
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/list_lru.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/list_lru.c b/mm/list_lru.c
> index 3fd64736bc458..225da0778a3be 100644
> --- a/mm/list_lru.c
> +++ b/mm/list_lru.c
> @@ -85,6 +85,7 @@ list_lru_from_memcg_idx(struct list_lru *lru, int nid, int idx)
>  }
>  #endif /* CONFIG_MEMCG_KMEM */
>  
> +/* The caller must ensure the memcg lifetime. */
>  bool list_lru_add(struct list_lru *lru, struct list_head *item, int nid,
>  		    struct mem_cgroup *memcg)
>  {
> @@ -109,14 +110,20 @@ EXPORT_SYMBOL_GPL(list_lru_add);
>  
>  bool list_lru_add_obj(struct list_lru *lru, struct list_head *item)
>  {
> +	bool ret;
>  	int nid = page_to_nid(virt_to_page(item));
> -	struct mem_cgroup *memcg = list_lru_memcg_aware(lru) ?
> -		mem_cgroup_from_slab_obj(item) : NULL;
> +	struct mem_cgroup *memcg;
>  
> -	return list_lru_add(lru, item, nid, memcg);
> +	rcu_read_lock();
> +	memcg = list_lru_memcg_aware(lru) ? mem_cgroup_from_slab_obj(item) : NULL;
> +	ret = list_lru_add(lru, item, nid, memcg);
> +	rcu_read_unlock();
> +
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(list_lru_add_obj);
>  
> +/* The caller must ensure the memcg lifetime. */
>  bool list_lru_del(struct list_lru *lru, struct list_head *item, int nid,
>  		    struct mem_cgroup *memcg)
>  {
> @@ -139,11 +146,16 @@ EXPORT_SYMBOL_GPL(list_lru_del);
>  
>  bool list_lru_del_obj(struct list_lru *lru, struct list_head *item)
>  {
> +	bool ret;
>  	int nid = page_to_nid(virt_to_page(item));
> -	struct mem_cgroup *memcg = list_lru_memcg_aware(lru) ?
> -		mem_cgroup_from_slab_obj(item) : NULL;
> +	struct mem_cgroup *memcg;
>  
> -	return list_lru_del(lru, item, nid, memcg);
> +	rcu_read_lock();
> +	memcg = list_lru_memcg_aware(lru) ? mem_cgroup_from_slab_obj(item) : NULL;
> +	ret = list_lru_del(lru, item, nid, memcg);
> +	rcu_read_unlock();
> +
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(list_lru_del_obj);
>  


