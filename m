Return-Path: <linux-kernel+bounces-381263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F20989AFCAA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8424281956
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1401D1319;
	Fri, 25 Oct 2024 08:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="miQC9x2C";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JADSNbIZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qSKqa8Hm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AsERz/0Q"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB58418BC30
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 08:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729845332; cv=none; b=lYs5YjxkgMv8NTATnI2SzApZJKcLbPuNsAio9PJywp3mAJPC0abn77jDRQTslKBl3HlGsIhDHfENHW66+j+zrRigeVTK3+gr6QftGQkmf0oDWuLnsSqL7iXKhXUF69olTiqUj3aTv1FqayriPs5auCndvYoI+MwL653B4Yi836k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729845332; c=relaxed/simple;
	bh=wp0is5REOAWOQkIN/GDtWFP/LX35pbi3KN+obTydZE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rvfF3dyIq7gnliM3v6Upw+xh/8IHcvcG9HMar4i9YhbU6zPpWjk3cmorCBoxmfnyoJjK+p6PsQwAxyUAPMCyGbpbrBk1tjVY8jPBZTDvn6pMbdhjOJyFDnb9crZeYqE2NmnTPoO9QN4yBSiMmM0LukJYKOdp/689w2/4WjyuZJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=miQC9x2C; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JADSNbIZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qSKqa8Hm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AsERz/0Q; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0EBD61FB5D;
	Fri, 25 Oct 2024 08:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729845322; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4cSs+iIaLe9LqrnxJ0hkoB/7+YWeu/DvRnAfwYtueNc=;
	b=miQC9x2C7jlYN5gsjGzwsPZ0gqujYtKKO/c6snUGS5l6GCnPTXrUfwIOAzA5PF9MWE/w3l
	P0G+uR1jxX1Vi6MlNg4iWzSUqEmN6McxOiLoXVBui1TyjZvWMI+8wTVMEbTpHCDXsMkN3Y
	VVzTY0ErL4uYZfJuVDBIf2c60Bb85u8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729845322;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4cSs+iIaLe9LqrnxJ0hkoB/7+YWeu/DvRnAfwYtueNc=;
	b=JADSNbIZ+SdypF+9jdNXjJ2Qvl9wNr46Q2X3hblVNN8GxXHKa8Gye2qXtLeHXJo6KT4bWh
	FxRzzwJ82MPG/2Cw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=qSKqa8Hm;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="AsERz/0Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729845321; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4cSs+iIaLe9LqrnxJ0hkoB/7+YWeu/DvRnAfwYtueNc=;
	b=qSKqa8Hm0ruLCUwB8Dp0+R7VRbvAa8tZVuR2kKaTpMFAoVcmulbgkTDZDmO8y8dDpexfis
	frwx8FLcHozcoHo16jL7timAQZ7/uu9Ciy0noiMA7lGSIbYgS8gVDxoLzHdOVrRPBOQexs
	+4G3e5HWy9C/lTWeEv9yiIYjKEPyAqs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729845321;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4cSs+iIaLe9LqrnxJ0hkoB/7+YWeu/DvRnAfwYtueNc=;
	b=AsERz/0QKLHkUcozPsN3b5o5r/8x6TV0BxGAKMLUh4c0XDbkxW126UgayF4gAk+eX0kYdb
	Gt/LL3B91FmG09CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EDD58136F5;
	Fri, 25 Oct 2024 08:35:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZAq5OUhYG2fyZAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 25 Oct 2024 08:35:20 +0000
Message-ID: <ca8d603c-20b2-4f8d-879c-c0ed9503afdc@suse.cz>
Date: Fri, 25 Oct 2024 10:35:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] mm: refactor __mmap_region()
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>, Jann Horn
 <jannh@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Linus Torvalds <torvalds@linux-foundation.org>, Peter Xu <peterx@redhat.com>
References: <cover.1729715266.git.lorenzo.stoakes@oracle.com>
 <0b1da31b49d47ccb930d36f509d50d04c0422b73.1729715266.git.lorenzo.stoakes@oracle.com>
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
In-Reply-To: <0b1da31b49d47ccb930d36f509d50d04c0422b73.1729715266.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0EBD61FB5D
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,vmg.next:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim,suse.cz:mid];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 10/23/24 22:38, Lorenzo Stoakes wrote:
> We have seen bugs and resource leaks arise from the complexity of the
> __mmap_region() function. This, and the generally deeply fragile error
> handling logic and complexity which makes understanding the function
> difficult make it highly desirable to refactor it into something readable.
> 
> Achieve this by separating the function into smaller logical parts which
> are easier to understand and follow, and which importantly very
> significantly simplify the error handling.
> 
> Note that we now call vms_abort_munmap_vmas() in more error paths than we
> used to, however in cases where no abort need occur, vms->nr_pages will be
> equal to zero and we simply exit this function without doing more than we
> would have done previously.
> 
> Importantly, the invocation of the driver mmap hook via mmap_file() now has
> very simple and obvious handling (this was previously the most problematic
> part of the mmap() operation).
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Some nits:

> +static int __mmap_prepare(struct mmap_state *map, struct vma_merge_struct *vmg,
> +	struct list_head *uf)
>  {
> -	struct mm_struct *mm = current->mm;
> -	struct vm_area_struct *vma = NULL;
> -	pgoff_t pglen = PHYS_PFN(len);
> -	unsigned long charged = 0;
> -	struct vma_munmap_struct vms;
> -	struct ma_state mas_detach;
> -	struct maple_tree mt_detach;
> -	unsigned long end = addr + len;
>  	int error;
> -	VMA_ITERATOR(vmi, mm, addr);
> -	VMG_STATE(vmg, mm, &vmi, addr, end, vm_flags, pgoff);
> -
> -	vmg.file = file;
> -	/* Find the first overlapping VMA */
> -	vma = vma_find(&vmi, end);
> -	init_vma_munmap(&vms, &vmi, vma, addr, end, uf, /* unlock = */ false);
> -	if (vma) {
> -		mt_init_flags(&mt_detach, vmi.mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
> -		mt_on_stack(mt_detach);
> -		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
> +	struct vma_iterator *vmi = map->vmi;
> +	struct vma_munmap_struct *vms = &map->vms;
> +
> +	/* Find the first overlapping VMA and initialise unmap state. */
> +	vms->vma = vma_find(vmi, map->end);
> +	init_vma_munmap(vms, vmi, vms->vma, map->addr, map->end, uf,
> +			/* unlock = */ false);
> +
> +	/* OK, we have overlapping VMAs - prepare to unmap them. */
> +	if (vms->vma) {
> +		mt_init_flags(&map->mt_detach,
> +			      vmi->mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
> +		mt_on_stack(map->mt_detach);
> +		mas_init(&map->mas_detach, &map->mt_detach, /* addr = */ 0);
>  		/* Prepare to unmap any existing mapping in the area */
> -		error = vms_gather_munmap_vmas(&vms, &mas_detach);
> -		if (error)
> -			goto gather_failed;
> +		error = vms_gather_munmap_vmas(vms, &map->mas_detach);
> +		if (error) {
> +			/* On error VMAs will already have been reattached. */
> +			vms->nr_pages = 0;
> +			return error;
> +		}
>  
> -		vmg.next = vms.next;
> -		vmg.prev = vms.prev;
> -		vma = NULL;
> +		map->next = vms->next;
> +		map->prev = vms->prev;
>  	} else {
> -		vmg.next = vma_iter_next_rewind(&vmi, &vmg.prev);
> +		map->next = vma_iter_next_rewind(vmi, &map->prev);
>  	}
>  
> +	/* Set up vmg for merge attempt. */
> +	vmg->file = map->file;
> +	vmg->prev = map->prev;
> +	vmg->next = map->next;

It seems arbitrary to do this here. vmg->flags are set in __mmap_region().
Why not all of this? We wouldn't need to pass vmg to __mmap_prepare() at
all? Do any of the values chenge between here and returning and vmg needs to
capture them as they are now? AFAICS not.

> +
>  	/* Check against address space limit. */
> -	if (!may_expand_vm(mm, vm_flags, pglen - vms.nr_pages)) {
> -		error = -ENOMEM;
> -		goto abort_munmap;
> -	}
> +	if (!may_expand_vm(map->mm, map->flags, map->pglen - vms->nr_pages))
> +		return -ENOMEM;
>  
> -	/*
> -	 * Private writable mapping: check memory availability
> -	 */
> -	if (accountable_mapping(file, vm_flags)) {
> -		charged = pglen;
> -		charged -= vms.nr_accounted;
> -		if (charged) {
> -			error = security_vm_enough_memory_mm(mm, charged);
> +	/* Private writable mapping: check memory availability. */
> +	if (accountable_mapping(map->file, map->flags)) {
> +		map->charged = map->pglen;
> +		map->charged -= vms->nr_accounted;
> +		if (map->charged) {
> +			error = security_vm_enough_memory_mm(map->mm, map->charged);
>  			if (error)
> -				goto abort_munmap;
> +				return error;
>  		}
>  
> -		vms.nr_accounted = 0;
> -		vm_flags |= VM_ACCOUNT;
> -		vmg.flags = vm_flags;
> +		vms->nr_accounted = 0;
> +		map->flags |= VM_ACCOUNT;
>  	}
>  
>  	/*
> -	 * clear PTEs while the vma is still in the tree so that rmap
> +	 * Clear PTEs while the vma is still in the tree so that rmap
>  	 * cannot race with the freeing later in the truncate scenario.
>  	 * This is also needed for mmap_file(), which is why vm_ops
>  	 * close function is called.
>  	 */
> -	vms_clean_up_area(&vms, &mas_detach);
> -	vma = vma_merge_new_range(&vmg);
> -	if (vma)
> -		goto expanded;
> +	vms_clean_up_area(vms, &map->mas_detach);
> +
> +	return 0;
> +}
> +

<snip>

> +static int __mmap_new_vma(struct mmap_state *map, struct vma_merge_struct *vmg,
> +			  struct vm_area_struct **vmap)
> +{
> +	struct vma_iterator *vmi = map->vmi;
> +	int error = 0;
> +	bool merged = false;
> +	struct vm_area_struct *vma;
> +
>  	/*
>  	 * Determine the object being mapped and call the appropriate
>  	 * specific mapper. the address has already been validated, but
>  	 * not unmapped, but the maps are removed from the list.
>  	 */
> -	vma = vm_area_alloc(mm);
> -	if (!vma) {
> -		error = -ENOMEM;
> -		goto unacct_error;
> -	}
> +	vma = vm_area_alloc(map->mm);
> +	if (!vma)
> +		return -ENOMEM;
>  
> -	vma_iter_config(&vmi, addr, end);
> -	vma_set_range(vma, addr, end, pgoff);
> -	vm_flags_init(vma, vm_flags);
> -	vma->vm_page_prot = vm_get_page_prot(vm_flags);
> +	vma_iter_config(vmi, map->addr, map->end);
> +	vma_set_range(vma, map->addr, map->end, map->pgoff);
> +	vm_flags_init(vma, map->flags);
> +	vma->vm_page_prot = vm_get_page_prot(map->flags);
>  
> -	if (vma_iter_prealloc(&vmi, vma)) {
> +	if (vma_iter_prealloc(vmi, vma)) {
>  		error = -ENOMEM;
>  		goto free_vma;
>  	}
>  
> -	if (file) {
> -		vma->vm_file = get_file(file);
> -		error = mmap_file(file, vma);
> -		if (error)
> -			goto unmap_and_free_file_vma;
> -
> -		/* Drivers cannot alter the address of the VMA. */
> -		WARN_ON_ONCE(addr != vma->vm_start);
> -		/*
> -		 * Drivers should not permit writability when previously it was
> -		 * disallowed.
> -		 */
> -		VM_WARN_ON_ONCE(vm_flags != vma->vm_flags &&
> -				!(vm_flags & VM_MAYWRITE) &&
> -				(vma->vm_flags & VM_MAYWRITE));
> -
> -		vma_iter_config(&vmi, addr, end);
> -		/*
> -		 * If vm_flags changed after mmap_file(), we should try merge
> -		 * vma again as we may succeed this time.
> -		 */
> -		if (unlikely(vm_flags != vma->vm_flags && vmg.prev)) {
> -			struct vm_area_struct *merge;
> -
> -			vmg.flags = vma->vm_flags;
> -			/* If this fails, state is reset ready for a reattempt. */
> -			merge = vma_merge_new_range(&vmg);
> -
> -			if (merge) {
> -				/*
> -				 * ->mmap() can change vma->vm_file and fput
> -				 * the original file. So fput the vma->vm_file
> -				 * here or we would add an extra fput for file
> -				 * and cause general protection fault
> -				 * ultimately.
> -				 */
> -				fput(vma->vm_file);
> -				vm_area_free(vma);
> -				vma = merge;
> -				/* Update vm_flags to pick up the change. */
> -				vm_flags = vma->vm_flags;
> -				goto file_expanded;
> -			}
> -			vma_iter_config(&vmi, addr, end);
> -		}
> -
> -		vm_flags = vma->vm_flags;
> -	} else if (vm_flags & VM_SHARED) {
> +	if (map->file)
> +		error = __mmap_new_file_vma(map, vmg, &vma, &merged);
> +	else if (map->flags & VM_SHARED)
>  		error = shmem_zero_setup(vma);
> -		if (error)
> -			goto free_iter_vma;
> -	} else {
> +	else
>  		vma_set_anonymous(vma);
> -	}
> +
> +	if (error)
> +		goto free_iter_vma;
> +
> +	if (merged)
> +		goto file_expanded;
>  
>  #ifdef CONFIG_SPARC64
>  	/* TODO: Fix SPARC ADI! */
> -	WARN_ON_ONCE(!arch_validate_flags(vm_flags));
> +	WARN_ON_ONCE(!arch_validate_flags(map->flags));
>  #endif
>  
>  	/* Lock the VMA since it is modified after insertion into VMA tree */
>  	vma_start_write(vma);
> -	vma_iter_store(&vmi, vma);
> -	mm->map_count++;
> +	vma_iter_store(vmi, vma);
> +	map->mm->map_count++;
>  	vma_link_file(vma);
>  
>  	/*
>  	 * vma_merge_new_range() calls khugepaged_enter_vma() too, the below
>  	 * call covers the non-merge case.
>  	 */
> -	khugepaged_enter_vma(vma, vma->vm_flags);
> +	khugepaged_enter_vma(vma, map->flags);
>  
>  file_expanded:
> -	file = vma->vm_file;
>  	ksm_add_vma(vma);

I'm wondering if this could go to the "non file expanded" region above. If
we expanded a vma, it was either in ksm and stays in ksm, or it was not
eligible and that couldn't have changed by expanding?

> -expanded:
> +	*vmap = vma;
> +	return 0;
> +
> +free_iter_vma:
> +	vma_iter_free(vmi);
> +free_vma:
> +	vm_area_free(vma);
> +	return error;
> +}
> +

