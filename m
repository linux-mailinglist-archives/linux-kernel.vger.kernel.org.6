Return-Path: <linux-kernel+bounces-198903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2A98D7EF1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 11:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7612B28A4EB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 09:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB9280C14;
	Mon,  3 Jun 2024 09:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="y0j8j0mb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lWI79YB+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="y0j8j0mb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lWI79YB+"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB4212DD82
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 09:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407095; cv=none; b=LBDzLUgA3r8z/j+iKiAL3r7JJj993dtHCU8ygzEjdW55ojObb08OXEwT28ivfELDPwAcREPMv4pEkmhu6aHlS4HkZ8B3tsYv3VMhCOqL3X7jw8SUHmHNtGiVlZPfSfM8OiJHxzMHqbnt2oEUtEKnl9kDu8I1Ru0k8i5CmixgVrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407095; c=relaxed/simple;
	bh=YcFG+qUK53jNaGR/MrgArr+MO3jaexkdASFoPxdCl8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NuIdxyWgbfh/8v8VpD4OtCDD/Js5ObntIu3h3XGHAZAQh4ZtYun4SX9rKuIaPgWaL6GmXkDJT1BziZRf2Fpks55CyaNdXcZLACBX89vdnbGehaKKiUEpsBn9wjdbaSh7XgYa0Dntm2W8KFEI+zb1BNZS/i893QcmRgqMg6YDDaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=y0j8j0mb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lWI79YB+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=y0j8j0mb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lWI79YB+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5567720021;
	Mon,  3 Jun 2024 09:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717407092; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NPI7bgKFql9EWRv8hvpz0MafqnDTdtzD/AJmE3/oetE=;
	b=y0j8j0mb+22oY0HDiiQxzURe/6uGFGD9IbfnzIAvKKcso5BzZaIi9p9vv9Vh4eGIzZ3kod
	0vAuSXJX/YU8V1MHYDXInO1K3Bu1EpnI0yzB8kAwBnL+AKftbOtga7r1qTiH3FT4Dpu1Ya
	9QbZZsu+gzsoWiB34Mn4PSh7NkGkmRQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717407092;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NPI7bgKFql9EWRv8hvpz0MafqnDTdtzD/AJmE3/oetE=;
	b=lWI79YB+P+8BYKhYkm6h7ONoyV4sYwjMkrSpu6E8yyltvis/hZj8vyOUCfg+FSgwK9J/xj
	r5B6RpH9/srBDsAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=y0j8j0mb;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=lWI79YB+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717407092; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NPI7bgKFql9EWRv8hvpz0MafqnDTdtzD/AJmE3/oetE=;
	b=y0j8j0mb+22oY0HDiiQxzURe/6uGFGD9IbfnzIAvKKcso5BzZaIi9p9vv9Vh4eGIzZ3kod
	0vAuSXJX/YU8V1MHYDXInO1K3Bu1EpnI0yzB8kAwBnL+AKftbOtga7r1qTiH3FT4Dpu1Ya
	9QbZZsu+gzsoWiB34Mn4PSh7NkGkmRQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717407092;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NPI7bgKFql9EWRv8hvpz0MafqnDTdtzD/AJmE3/oetE=;
	b=lWI79YB+P+8BYKhYkm6h7ONoyV4sYwjMkrSpu6E8yyltvis/hZj8vyOUCfg+FSgwK9J/xj
	r5B6RpH9/srBDsAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F42D139CB;
	Mon,  3 Jun 2024 09:31:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vvITD3SNXWbNAwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 03 Jun 2024 09:31:32 +0000
Message-ID: <f14e42cb-5b73-4b78-b6b8-19a916b1750b@suse.cz>
Date: Mon, 3 Jun 2024 11:31:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] lib/alloc_tag: fix RCU imbalance in pgalloc_tag_get()
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, pasha.tatashin@soleen.com,
 keescook@chromium.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kernel test robot <oliver.sang@intel.com>
References: <20240601233840.617458-1-surenb@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20240601233840.617458-1-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.50
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 5567720021
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,intel.com:email,linux.dev:email];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]

On 6/2/24 1:38 AM, Suren Baghdasaryan wrote:
> put_page_tag_ref() should be called only when get_page_tag_ref() returns
> a valid reference because only in that case get_page_tag_ref() enters RCU
> read section while put_page_tag_ref() will call rcu_read_unlock() even if
> the provided reference is NULL. Fix pgalloc_tag_get() which does not
> follow this rule causing RCU imbalance. Add a warning in put_page_tag_ref()
> to catch any future mistakes.
> 
> Fixes: cc92eba1c88b ("mm: fix non-compound multi-order memory accounting in __free_pages")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202405271029.6d2f9c4c-lkp@intel.com
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Cc: Kent Overstreet <kent.overstreet@linux.dev>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  include/linux/pgalloc_tag.h | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/pgalloc_tag.h b/include/linux/pgalloc_tag.h
> index 86ba5d33e43b..9cacadbd61f8 100644
> --- a/include/linux/pgalloc_tag.h
> +++ b/include/linux/pgalloc_tag.h
> @@ -37,6 +37,9 @@ static inline union codetag_ref *get_page_tag_ref(struct page *page)
>  
>  static inline void put_page_tag_ref(union codetag_ref *ref)
>  {
> +	if (WARN_ON(!ref))
> +		return;
> +
>  	page_ext_put(page_ext_from_codetag_ref(ref));
>  }
>  
> @@ -102,9 +105,11 @@ static inline struct alloc_tag *pgalloc_tag_get(struct page *page)
>  		union codetag_ref *ref = get_page_tag_ref(page);
>  
>  		alloc_tag_sub_check(ref);
> -		if (ref && ref->ct)
> -			tag = ct_to_alloc_tag(ref->ct);
> -		put_page_tag_ref(ref);
> +		if (ref) {
> +			if (ref->ct)
> +				tag = ct_to_alloc_tag(ref->ct);
> +			put_page_tag_ref(ref);
> +		}
>  	}
>  
>  	return tag;
> 
> base-commit: 065d3634d60843b8e338d405b844cc7f2e5e1c66


