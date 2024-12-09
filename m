Return-Path: <linux-kernel+bounces-437735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 778C59E97CE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4D6E1882F84
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2E03595B;
	Mon,  9 Dec 2024 13:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="la+7jh3W";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VENehsvf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IV1+Ichj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kTGwfDaH"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136FC12CD8B
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 13:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733752307; cv=none; b=tjQjuKJdIvBYhwXx7dQrrEzytH/w+kK0e4tzwUPfKEhZp8RWBbtnJdpKz9GOWAgIHGjAyseP78xT9FIvIVUq8w5GI4g8thQ75HSQLkMOQ6Qolr3SAjxVSag85PCrhPtOB7B8xdtQQP6Yqfxr7r3B2B+UplwPNKmzD6lcFiA8OEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733752307; c=relaxed/simple;
	bh=twtzp3CLNwRsdmt4VAUrWVEYAc6D3fK6fHq8SR2QTco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nT4JI7+OhZMXO+li7itcK5WjuYieVPkJ+c6zMBS9p5YpMnBD3T60oLCegzy2k2DIqudgkfepIETBS3LqZrZrASyqWIpbo/ePk9N2j3WMvN/SE3Fnd4CK/AOwGuFKx9wk+ehcXXQ7IHqEergbWU5qfpfZrbumcK1NPoY94tE2q5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=la+7jh3W; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VENehsvf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IV1+Ichj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kTGwfDaH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CEBF82117A;
	Mon,  9 Dec 2024 13:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733752303; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LjXSG7zV5VH0+OgjO/Ctwl2n5WEvCTsUvSdkOAFq0JU=;
	b=la+7jh3WyAoqifkGUJ4HZ6N0GRi6mtEKFtIWXnRVUO4W8ich9zoq21yBKPBvBQNdVyEnGL
	zAlC2JvOn2DpO9jHteCXWuxtwnLU5P8Rzx3lvIv/HYf66ylnlrw4acLMXpyJvb2gFNWDPP
	tSs47rRygdcxtrc0h4wKBPnuCaSNVws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733752303;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LjXSG7zV5VH0+OgjO/Ctwl2n5WEvCTsUvSdkOAFq0JU=;
	b=VENehsvfvGmbVyQZANalCYvh7NyfUwMMq0Bw5RhdxSck0r3ZQPQapT0I9zSIFlpElATTnR
	QkI/ZBnzmCNgC+DQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733752302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LjXSG7zV5VH0+OgjO/Ctwl2n5WEvCTsUvSdkOAFq0JU=;
	b=IV1+Ichjc0ONt9UM9c9G5GBOqhc5XyVXGDNkUWAWsdUqI9LeIQgmlpMbDvyKY77liAx4pu
	56h4ItY6YV8cQ2Lcr2KvAYQ04q09/ksw5ASQI72eIsUFEeE2AAsd+GdNWAQLYsukHfurX4
	efyX73Y7pb2fIsdMW1GYbG6qB10WRIk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733752302;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LjXSG7zV5VH0+OgjO/Ctwl2n5WEvCTsUvSdkOAFq0JU=;
	b=kTGwfDaHgP/YdP+aWYyVLVdeWRUAW4reSa5/T6PbBFg65/70TEmoA1i627fPaVSDUF5oxh
	UWw7Ofyk+Fg4thBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B6430138D2;
	Mon,  9 Dec 2024 13:51:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id agIoLO71VmfLcgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 09 Dec 2024 13:51:42 +0000
Message-ID: <c77d35c7-0d27-44de-9bd0-74371b881943@suse.cz>
Date: Mon, 9 Dec 2024 14:51:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: enforce __must_check on VMA merge and split
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>, Jann Horn
 <jannh@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20241206225036.273103-1-lorenzo.stoakes@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20241206225036.273103-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,oracle.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On 12/6/24 23:50, Lorenzo Stoakes wrote:
> It is of critical importance to check the return results on VMA merge (and
> split), failure to do so can result in use-after-free's. This bug has
> recurred, so have the compiler enforce this check to prevent any future
> repetition.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/vma.c |  8 +++++---
>  mm/vma.h | 26 +++++++++++++++-----------
>  2 files changed, 20 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/vma.c b/mm/vma.c
> index a06747845cac..543c102b4062 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -447,8 +447,9 @@ void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
>   * has already been checked or doesn't make sense to fail.
>   * VMA Iterator will point to the original VMA.
>   */
> -static int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
> -		       unsigned long addr, int new_below)
> +static __must_check int
> +__split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
> +	    unsigned long addr, int new_below)
>  {
>  	struct vma_prepare vp;
>  	struct vm_area_struct *new;
> @@ -710,7 +711,8 @@ static bool can_merge_remove_vma(struct vm_area_struct *vma)
>   * - The caller must hold a WRITE lock on the mm_struct->mmap_lock.
>   * - vmi must be positioned within [@vmg->vma->vm_start, @vmg->vma->vm_end).
>   */
> -static struct vm_area_struct *vma_merge_existing_range(struct vma_merge_struct *vmg)
> +static __must_check struct vm_area_struct *vma_merge_existing_range(
> +		struct vma_merge_struct *vmg)
>  {
>  	struct vm_area_struct *vma = vmg->vma;
>  	struct vm_area_struct *prev = vmg->prev;
> diff --git a/mm/vma.h b/mm/vma.h
> index 295d44ea54db..61ed044b6145 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -139,9 +139,10 @@ void validate_mm(struct mm_struct *mm);
>  #define validate_mm(mm) do { } while (0)
>  #endif
>  
> -int vma_expand(struct vma_merge_struct *vmg);
> -int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
> -	       unsigned long start, unsigned long end, pgoff_t pgoff);
> +__must_check int vma_expand(struct vma_merge_struct *vmg);
> +__must_check int vma_shrink(struct vma_iterator *vmi,
> +		struct vm_area_struct *vma,
> +		unsigned long start, unsigned long end, pgoff_t pgoff);
>  
>  static inline int vma_iter_store_gfp(struct vma_iterator *vmi,
>  			struct vm_area_struct *vma, gfp_t gfp)
> @@ -174,13 +175,14 @@ void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
>  		struct vm_area_struct *prev, struct vm_area_struct *next);
>  
>  /* We are about to modify the VMA's flags. */
> -struct vm_area_struct *vma_modify_flags(struct vma_iterator *vmi,
> +__must_check struct vm_area_struct
> +*vma_modify_flags(struct vma_iterator *vmi,
>  		struct vm_area_struct *prev, struct vm_area_struct *vma,
>  		unsigned long start, unsigned long end,
>  		unsigned long new_flags);
>  
>  /* We are about to modify the VMA's flags and/or anon_name. */
> -struct vm_area_struct
> +__must_check struct vm_area_struct
>  *vma_modify_flags_name(struct vma_iterator *vmi,
>  		       struct vm_area_struct *prev,
>  		       struct vm_area_struct *vma,
> @@ -190,7 +192,7 @@ struct vm_area_struct
>  		       struct anon_vma_name *new_name);
>  
>  /* We are about to modify the VMA's memory policy. */
> -struct vm_area_struct
> +__must_check struct vm_area_struct
>  *vma_modify_policy(struct vma_iterator *vmi,
>  		   struct vm_area_struct *prev,
>  		   struct vm_area_struct *vma,
> @@ -198,7 +200,7 @@ struct vm_area_struct
>  		   struct mempolicy *new_pol);
>  
>  /* We are about to modify the VMA's flags and/or uffd context. */
> -struct vm_area_struct
> +__must_check struct vm_area_struct
>  *vma_modify_flags_uffd(struct vma_iterator *vmi,
>  		       struct vm_area_struct *prev,
>  		       struct vm_area_struct *vma,
> @@ -206,11 +208,13 @@ struct vm_area_struct
>  		       unsigned long new_flags,
>  		       struct vm_userfaultfd_ctx new_ctx);
>  
> -struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg);
> +__must_check struct vm_area_struct
> +*vma_merge_new_range(struct vma_merge_struct *vmg);
>  
> -struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
> -					struct vm_area_struct *vma,
> -					unsigned long delta);
> +__must_check struct vm_area_struct
> +*vma_merge_extend(struct vma_iterator *vmi,
> +		  struct vm_area_struct *vma,
> +		  unsigned long delta);
>  
>  void unlink_file_vma_batch_init(struct unlink_vma_file_batch *vb);
>  


