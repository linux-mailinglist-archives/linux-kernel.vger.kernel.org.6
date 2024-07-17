Return-Path: <linux-kernel+bounces-254965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5AC9339D9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 11:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 773E4283D5F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 09:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B133F9D5;
	Wed, 17 Jul 2024 09:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WQ5y45eY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rRlOIPxr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WQ5y45eY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rRlOIPxr"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5182224FA
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 09:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721208646; cv=none; b=Chnl7YsY8ZJMewEhlaHVqNK414KfNT3uMHP0kSVDvpOGe0PILTnegXJlMrhcRVefxsf7dcy9gCaHfoYEh31v24FZb0GXFcqdJNhT4U28XGq9InUrltCZnD1Tz/Lrh33tsu3TL3ixe+eWCt+6yGT/0qAqe8tUUgedjiOMHGkuhxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721208646; c=relaxed/simple;
	bh=N6LcIwuylo6tly9FQjD3RIFw5EIrF6As8m9pdzbrAFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DKicQLWKMIg1fXKqAH0noGkYeQRzf7MHwKlS1nSMMgfWZA/HcdX/PYzAtjgTe1RgrjJtQanwV/eWZsNFxLMNoEpFtQcuvlTLB3L+Pu6bgI4tPVncGD0Hlca8ZN/Pk2GkXeN0fFrZ3p7jQK6JE59eVMAMZ9irv7mlCg/XidJHEM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WQ5y45eY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rRlOIPxr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WQ5y45eY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rRlOIPxr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 906E521ADD;
	Wed, 17 Jul 2024 09:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721208641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qcTz1ZeKOjXrPBceZbnpdHK/tN2ydZ9N5V5O1DKOgsI=;
	b=WQ5y45eYlgJIbAQdWIim/NtbmBoAgFycFNhmSEP+D/gxVypPtXzPtCEYFZyWInJPXRAR0D
	keMNK80BRF9ePj865UX9Z5mRqlLhkpV3+TC9BxeK7wLdxfGVqnZX9Dc3PU1WlAE4DeZ8PL
	kKQ+AtpD1j+Gb82+ehm2qbEbr6EWvZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721208641;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qcTz1ZeKOjXrPBceZbnpdHK/tN2ydZ9N5V5O1DKOgsI=;
	b=rRlOIPxritoKlKd2TB4/VPGJCf72xR3wfXA8G9xklAwy5lrjDyevLp3/ckldyKRnosS5rq
	csQFm2x95WIPYZCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721208641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qcTz1ZeKOjXrPBceZbnpdHK/tN2ydZ9N5V5O1DKOgsI=;
	b=WQ5y45eYlgJIbAQdWIim/NtbmBoAgFycFNhmSEP+D/gxVypPtXzPtCEYFZyWInJPXRAR0D
	keMNK80BRF9ePj865UX9Z5mRqlLhkpV3+TC9BxeK7wLdxfGVqnZX9Dc3PU1WlAE4DeZ8PL
	kKQ+AtpD1j+Gb82+ehm2qbEbr6EWvZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721208641;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qcTz1ZeKOjXrPBceZbnpdHK/tN2ydZ9N5V5O1DKOgsI=;
	b=rRlOIPxritoKlKd2TB4/VPGJCf72xR3wfXA8G9xklAwy5lrjDyevLp3/ckldyKRnosS5rq
	csQFm2x95WIPYZCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 499A8136E5;
	Wed, 17 Jul 2024 09:30:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MyJGEUGPl2aEJwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 17 Jul 2024 09:30:41 +0000
Message-ID: <3ac089e1-7a30-42ef-a11a-d4d080e06c69@suse.cz>
Date: Wed, 17 Jul 2024 11:30:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] alloc_tag: outline and export
 {get|put}_page_tag_ref() used by modules
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, hch@infradead.org, pasha.tatashin@soleen.com,
 souravpanda@google.com, keescook@chromium.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, kernel test robot <lkp@intel.com>
References: <20240717011631.2150066-1-surenb@google.com>
 <20240717011631.2150066-2-surenb@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20240717011631.2150066-2-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -0.29
X-Spamd-Result: default: False [-0.29 / 50.00];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

On 7/17/24 3:16 AM, Suren Baghdasaryan wrote:
> Outline and export get_page_tag_ref() and put_page_tag_ref() so that
> modules can use them without exporting page_ext_get() and page_ext_put().
> 
> Fixes: dcfe378c81f7 ("lib: introduce support for page allocation tagging")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202407080044.DWMC9N9I-lkp@intel.com/
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Better than exporting page_ext but still seems like suboptimal level to me.
You have various inline functions that use get/put_page_tag_ref and now will
call into them both. IMHO outlining those (and leaving only the static key
check inline) is the better way.

As for the report that triggered this, AFAICS it was due to
free_reserved_page() so it could be enough to only outline that memalloc
profiling part there and leave the rest as that seems to be used only from
core code and no modules.

> ---
>  include/linux/pgalloc_tag.h | 23 +++--------------------
>  lib/alloc_tag.c             | 23 +++++++++++++++++++++++
>  2 files changed, 26 insertions(+), 20 deletions(-)
> 
> diff --git a/include/linux/pgalloc_tag.h b/include/linux/pgalloc_tag.h
> index 9cacadbd61f8..3c6ab717bd57 100644
> --- a/include/linux/pgalloc_tag.h
> +++ b/include/linux/pgalloc_tag.h
> @@ -13,6 +13,9 @@
>  
>  extern struct page_ext_operations page_alloc_tagging_ops;
>  
> +union codetag_ref *get_page_tag_ref(struct page *page);
> +void put_page_tag_ref(union codetag_ref *ref);
> +
>  static inline union codetag_ref *codetag_ref_from_page_ext(struct page_ext *page_ext)
>  {
>  	return (void *)page_ext + page_alloc_tagging_ops.offset;
> @@ -23,26 +26,6 @@ static inline struct page_ext *page_ext_from_codetag_ref(union codetag_ref *ref)
>  	return (void *)ref - page_alloc_tagging_ops.offset;
>  }
>  
> -/* Should be called only if mem_alloc_profiling_enabled() */
> -static inline union codetag_ref *get_page_tag_ref(struct page *page)
> -{
> -	if (page) {
> -		struct page_ext *page_ext = page_ext_get(page);
> -
> -		if (page_ext)
> -			return codetag_ref_from_page_ext(page_ext);
> -	}
> -	return NULL;
> -}
> -
> -static inline void put_page_tag_ref(union codetag_ref *ref)
> -{
> -	if (WARN_ON(!ref))
> -		return;
> -
> -	page_ext_put(page_ext_from_codetag_ref(ref));
> -}
> -
>  static inline void pgalloc_tag_add(struct page *page, struct task_struct *task,
>  				   unsigned int nr)
>  {
> diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> index 832f79a32b3e..5271cc070901 100644
> --- a/lib/alloc_tag.c
> +++ b/lib/alloc_tag.c
> @@ -4,6 +4,7 @@
>  #include <linux/gfp.h>
>  #include <linux/module.h>
>  #include <linux/page_ext.h>
> +#include <linux/pgalloc_tag.h>
>  #include <linux/proc_fs.h>
>  #include <linux/seq_buf.h>
>  #include <linux/seq_file.h>
> @@ -22,6 +23,28 @@ struct allocinfo_private {
>  	bool print_header;
>  };
>  
> +/* Should be called only if mem_alloc_profiling_enabled() */
> +union codetag_ref *get_page_tag_ref(struct page *page)
> +{
> +	if (page) {
> +		struct page_ext *page_ext = page_ext_get(page);
> +
> +		if (page_ext)
> +			return codetag_ref_from_page_ext(page_ext);
> +	}
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(get_page_tag_ref);
> +
> +void put_page_tag_ref(union codetag_ref *ref)
> +{
> +	if (WARN_ON(!ref))
> +		return;
> +
> +	page_ext_put(page_ext_from_codetag_ref(ref));
> +}
> +EXPORT_SYMBOL_GPL(put_page_tag_ref);
> +
>  static void *allocinfo_start(struct seq_file *m, loff_t *pos)
>  {
>  	struct allocinfo_private *priv;


