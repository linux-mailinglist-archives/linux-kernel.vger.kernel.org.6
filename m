Return-Path: <linux-kernel+bounces-280740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DF594CE65
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 12:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 242F31F22660
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 10:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC4F191F71;
	Fri,  9 Aug 2024 10:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ola5MvEl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5JdyxKds";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KT24feuj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iykse5r+"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E651552EB
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 10:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723198528; cv=none; b=X7L8xA1LFRS7gjswvBEU4l5EZzdCb01HGqtmXh5ZMySjniJhiw997dQoZA5mMnVZWUXf1a/BPnkf7uoX4Du2+UpHSsdVKS7oULKabwrf5gFB4tapN0K6UdP3fSpepoKttfuuj07bYZvw8zwaQfdJ2JGbOTbIj9InPPUEwQfyApE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723198528; c=relaxed/simple;
	bh=82HlHDFE6ON/PzxG4IbzkVXSVnEjuPb66u9QgxHBe0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BVD5cvC4TZT2ISgsI6Bq1dism4sjsZNQTv1/rJc/fJ5Nf0Wze6T+LR/D1CnPl2QwNXVONbjKlKvx5NLtMNRwLULjXmzUrLLHOk1QLVT/RZ3lIVK1uOFm9kcsns58SNUPkT37PDeZ5L5WtTzGin5bAwlvbyJZTHNozyjUNU5vTNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ola5MvEl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5JdyxKds; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KT24feuj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iykse5r+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E24771FF3B;
	Fri,  9 Aug 2024 10:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723198525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hNyK4oRZs6dMkP0Kyg5TVbYnlZhigSEu0KzP52dtvd0=;
	b=ola5MvElLAGU7QhxAIIgQpIJHcGKrooiCZbjtFZmT9jVqdyexaxVyk26Ch+eCFu1N06dQZ
	Vj+OU5lAnkYVj/ybgyp2OS9bFax8CnzgtTuUZhNvKkND6FFuB8b8yEB1ZlXq8B9UNUag/M
	mpmBUeqG1YThLiXLArQPzxlL+LAlzlw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723198525;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hNyK4oRZs6dMkP0Kyg5TVbYnlZhigSEu0KzP52dtvd0=;
	b=5JdyxKds4cddfJJmGgQKZhVV7ocvQ2vpsuIc+i8AZUWNXbdil85bb/kKKT4yRDVdzwN4So
	zPpJoXSgUSwppRDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KT24feuj;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=iykse5r+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723198524; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hNyK4oRZs6dMkP0Kyg5TVbYnlZhigSEu0KzP52dtvd0=;
	b=KT24feuj+5zOZl1OJaKPUW/06J1ko9cy1HiZObRTyfj66Vk8Z2GO+zSUdq3IrKeFH5ElcJ
	FakEomQgP6Kg0SJnHFe2t3CvuezNkl8LnKL8sDTH8ZiY4rq8mjUAujSq/vXXwT04+C0H5K
	IOZMkoZgnm4L7HJSdC95HvZeNeWDF3k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723198524;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hNyK4oRZs6dMkP0Kyg5TVbYnlZhigSEu0KzP52dtvd0=;
	b=iykse5r+nKXEwPjYgKu0ONgr2Nl9G6gTSpXAJi9ejYIcwD5NhQBD5iU9sOcrpEjibd80rw
	cHnD8B2Zv8nseMAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D02EA1379A;
	Fri,  9 Aug 2024 10:15:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9OIkMjzstWb0RAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 09 Aug 2024 10:15:24 +0000
Message-ID: <1f446461-8858-429a-8a0e-cb6b24c6a0c8@suse.cz>
Date: Fri, 9 Aug 2024 12:15:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] mm: introduce commit_merge(), abstracting merge
 operation
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>
References: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
 <3b04eb13b499df3ebf50ae3cde9a7ed5e76237fd.1722849860.git.lorenzo.stoakes@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 xsFNBFZdmxYBEADsw/SiUSjB0dM+vSh95UkgcHjzEVBlby/Fg+g42O7LAEkCYXi/vvq31JTB
 KxRWDHX0R2tgpFDXHnzZcQywawu8eSq0LxzxFNYMvtB7sV1pxYwej2qx9B75qW2plBs+7+YB
 87tMFA+u+L4Z5xAzIimfLD5EKC56kJ1CsXlM8S/LHcmdD9Ctkn3trYDNnat0eoAcfPIP2OZ+
 9oe9IF/R28zmh0ifLXyJQQz5ofdj4bPf8ecEW0rhcqHfTD8k4yK0xxt3xW+6Exqp9n9bydiy
 tcSAw/TahjW6yrA+6JhSBv1v2tIm+itQc073zjSX8OFL51qQVzRFr7H2UQG33lw2QrvHRXqD
 Ot7ViKam7v0Ho9wEWiQOOZlHItOOXFphWb2yq3nzrKe45oWoSgkxKb97MVsQ+q2SYjJRBBH4
 8qKhphADYxkIP6yut/eaj9ImvRUZZRi0DTc8xfnvHGTjKbJzC2xpFcY0DQbZzuwsIZ8OPJCc
 LM4S7mT25NE5kUTG/TKQCk922vRdGVMoLA7dIQrgXnRXtyT61sg8PG4wcfOnuWf8577aXP1x
 6mzw3/jh3F+oSBHb/GcLC7mvWreJifUL2gEdssGfXhGWBo6zLS3qhgtwjay0Jl+kza1lo+Cv
 BB2T79D4WGdDuVa4eOrQ02TxqGN7G0Biz5ZLRSFzQSQwLn8fbwARAQABzSBWbGFzdGltaWwg
 QmFia2EgPHZiYWJrYUBzdXNlLmN6PsLBlAQTAQoAPgIbAwULCQgHAwUVCgkICwUWAgMBAAIe
 AQIXgBYhBKlA1DSZLC6OmRA9UCJPp+fMgqZkBQJkBREIBQkRadznAAoJECJPp+fMgqZkNxIQ
 ALZRqwdUGzqL2aeSavbum/VF/+td+nZfuH0xeWiO2w8mG0+nPd5j9ujYeHcUP1edE7uQrjOC
 Gs9sm8+W1xYnbClMJTsXiAV88D2btFUdU1mCXURAL9wWZ8Jsmz5ZH2V6AUszvNezsS/VIT87
 AmTtj31TLDGwdxaZTSYLwAOOOtyqafOEq+gJB30RxTRE3h3G1zpO7OM9K6ysLdAlwAGYWgJJ
 V4JqGsQ/lyEtxxFpUCjb5Pztp7cQxhlkil0oBYHkudiG8j1U3DG8iC6rnB4yJaLphKx57NuQ
 PIY0Bccg+r9gIQ4XeSK2PQhdXdy3UWBr913ZQ9AI2usid3s5vabo4iBvpJNFLgUmxFnr73SJ
 KsRh/2OBsg1XXF/wRQGBO9vRuJUAbnaIVcmGOUogdBVS9Sun/Sy4GNA++KtFZK95U7J417/J
 Hub2xV6Ehc7UGW6fIvIQmzJ3zaTEfuriU1P8ayfddrAgZb25JnOW7L1zdYL8rXiezOyYZ8Fm
 ZyXjzWdO0RpxcUEp6GsJr11Bc4F3aae9OZtwtLL/jxc7y6pUugB00PodgnQ6CMcfR/HjXlae
 h2VS3zl9+tQWHu6s1R58t5BuMS2FNA58wU/IazImc/ZQA+slDBfhRDGYlExjg19UXWe/gMcl
 De3P1kxYPgZdGE2eZpRLIbt+rYnqQKy8UxlszsBNBFsZNTUBCACfQfpSsWJZyi+SHoRdVyX5
 J6rI7okc4+b571a7RXD5UhS9dlVRVVAtrU9ANSLqPTQKGVxHrqD39XSw8hxK61pw8p90pg4G
 /N3iuWEvyt+t0SxDDkClnGsDyRhlUyEWYFEoBrrCizbmahOUwqkJbNMfzj5Y7n7OIJOxNRkB
 IBOjPdF26dMP69BwePQao1M8Acrrex9sAHYjQGyVmReRjVEtv9iG4DoTsnIR3amKVk6si4Ea
 X/mrapJqSCcBUVYUFH8M7bsm4CSxier5ofy8jTEa/CfvkqpKThTMCQPNZKY7hke5qEq1CBk2
 wxhX48ZrJEFf1v3NuV3OimgsF2odzieNABEBAAHCwXwEGAEKACYCGwwWIQSpQNQ0mSwujpkQ
 PVAiT6fnzIKmZAUCZAUSmwUJDK5EZgAKCRAiT6fnzIKmZOJGEACOKABgo9wJXsbWhGWYO7mD
 8R8mUyJHqbvaz+yTLnvRwfe/VwafFfDMx5GYVYzMY9TWpA8psFTKTUIIQmx2scYsRBUwm5VI
 EurRWKqENcDRjyo+ol59j0FViYysjQQeobXBDDE31t5SBg++veI6tXfpco/UiKEsDswL1WAr
 tEAZaruo7254TyH+gydURl2wJuzo/aZ7Y7PpqaODbYv727Dvm5eX64HCyyAH0s6sOCyGF5/p
 eIhrOn24oBf67KtdAN3H9JoFNUVTYJc1VJU3R1JtVdgwEdr+NEciEfYl0O19VpLE/PZxP4wX
 PWnhf5WjdoNI1Xec+RcJ5p/pSel0jnvBX8L2cmniYnmI883NhtGZsEWj++wyKiS4NranDFlA
 HdDM3b4lUth1pTtABKQ1YuTvehj7EfoWD3bv9kuGZGPrAeFNiHPdOT7DaXKeHpW9homgtBxj
 8aX/UkSvEGJKUEbFL9cVa5tzyialGkSiZJNkWgeHe+jEcfRT6pJZOJidSCdzvJpbdJmm+eED
 w9XOLH1IIWh7RURU7G1iOfEfmImFeC3cbbS73LQEFGe1urxvIH5K/7vX+FkNcr9ujwWuPE9b
 1C2o4i/yZPLXIVy387EjA6GZMqvQUFuSTs/GeBcv0NjIQi8867H3uLjz+mQy63fAitsDwLmR
 EP+ylKVEKb0Q2A==
In-Reply-To: <3b04eb13b499df3ebf50ae3cde9a7ed5e76237fd.1722849860.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.50 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,suse.cz:email,suse.cz:dkim];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -1.50
X-Rspamd-Queue-Id: E24771FF3B

On 8/5/24 14:13, Lorenzo Stoakes wrote:
> Pull this operation into its own function and have vma_expand() call
> commit_merge() instead.
> 
> This lays the groundwork for a subsequent patch which replaces vma_merge()
> with a simpler function which can share the same code.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

In general,

Acked-by: Vlastimil Babka <vbabka@suse.cz>

If you consider the following suggestions, great:

> ---
>  mm/vma.c | 57 ++++++++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 45 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/vma.c b/mm/vma.c
> index a404cf718f9e..b7e3c64d5d68 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -564,6 +564,49 @@ void validate_mm(struct mm_struct *mm)
>  }
>  #endif /* CONFIG_DEBUG_VM_MAPLE_TREE */
>  
> +/* Actually perform the VMA merge operation. */
> +static int commit_merge(struct vma_merge_struct *vmg,
> +			struct vm_area_struct *adjust,
> +			struct vm_area_struct *remove,
> +			struct vm_area_struct *remove2,
> +			long adj_start,
> +			bool expanded)

I've read the subthread with Petr. I understand it's hard to organize such
big changes in self-contained units. But maybe it would still be possible to
introduce this function now without the parameters, and as part of the the
next patch add the two parameters and the code using them. Maybe it would
even make git detect the added code as code move from where it's now, so it
would be more obviousl.

> +{
> +	struct vma_prepare vp;
> +
> +	init_multi_vma_prep(&vp, vmg->vma, adjust, remove, remove2);
> +
> +	if (expanded) {
> +		vma_iter_config(vmg->vmi, vmg->start, vmg->end);

This originally had a comment

/* Note: vma iterator must be pointing to 'start' */

and now it's gone.

> +	} else {
> +		vma_iter_config(vmg->vmi, adjust->vm_start + adj_start,
> +				adjust->vm_end);

And this less obvious one has none either :(

> +	}
> +
> +	if (vma_iter_prealloc(vmg->vmi, vmg->vma))
> +		return -ENOMEM;
> +
> +	vma_prepare(&vp);
> +	vma_adjust_trans_huge(vmg->vma, vmg->start, vmg->end, adj_start);
> +	vma_set_range(vmg->vma, vmg->start, vmg->end, vmg->pgoff);
> +
> +	if (expanded)
> +		vma_iter_store(vmg->vmi, vmg->vma);
> +
> +	if (adj_start) {
> +		adjust->vm_start += adj_start;
> +		adjust->vm_pgoff += PHYS_PFN(adj_start);
> +		if (adj_start < 0) {
> +			WARN_ON(expanded);
> +			vma_iter_store(vmg->vmi, adjust);
> +		}
> +	}
> +
> +	vma_complete(&vp, vmg->vmi, vmg->vma->vm_mm);
> +
> +	return 0;
> +}
> +
>  /*
>   * vma_merge_new_vma - Attempt to merge a new VMA into address space
>   *
> @@ -700,7 +743,6 @@ int vma_expand(struct vma_merge_struct *vmg)
>  	bool remove_next = false;
>  	struct vm_area_struct *vma = vmg->vma;
>  	struct vm_area_struct *next = vmg->next;
> -	struct vma_prepare vp;
>  
>  	vma_start_write(vma);
>  	if (next && (vma != next) && (vmg->end == next->vm_end)) {
> @@ -713,24 +755,15 @@ int vma_expand(struct vma_merge_struct *vmg)
>  			return ret;
>  	}
>  
> -	init_multi_vma_prep(&vp, vma, NULL, remove_next ? next : NULL, NULL);
>  	/* Not merging but overwriting any part of next is not handled. */
> -	VM_WARN_ON(next && !vp.remove &&
> +	VM_WARN_ON(next && !remove_next &&
>  		  next != vma && vmg->end > next->vm_start);
>  	/* Only handles expanding */
>  	VM_WARN_ON(vma->vm_start < vmg->start || vma->vm_end > vmg->end);
>  
> -	/* Note: vma iterator must be pointing to 'start' */
> -	vma_iter_config(vmg->vmi, vmg->start, vmg->end);
> -	if (vma_iter_prealloc(vmg->vmi, vma))
> +	if (commit_merge(vmg, NULL, remove_next ? next : NULL, NULL, 0, true))
>  		goto nomem;
>  
> -	vma_prepare(&vp);
> -	vma_adjust_trans_huge(vma, vmg->start, vmg->end, 0);
> -	vma_set_range(vma, vmg->start, vmg->end, vmg->pgoff);
> -	vma_iter_store(vmg->vmi, vma);
> -
> -	vma_complete(&vp, vmg->vmi, vma->vm_mm);
>  	return 0;
>  
>  nomem:


