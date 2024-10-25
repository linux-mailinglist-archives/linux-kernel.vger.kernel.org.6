Return-Path: <linux-kernel+bounces-381403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1BA9AFEA5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 11:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74F49286F78
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 09:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740B61D3633;
	Fri, 25 Oct 2024 09:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="A8k+KCSk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xMGhyKyg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="A8k+KCSk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xMGhyKyg"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D0E18BC0B
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 09:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729849404; cv=none; b=aSmHFq6v9x6+DHbm0MWczDGWY17jQm0FXfxGawO+nC8i0/0TS/fTT/U9QLXlGrOqnRQOTQqKFcLKOzi42oVTB1OSM6kXBjxfAOFZQ4/VGcYsl6FW56CEP7k0KVg3JauaJNH3IXViC9RNaHORfcC6MWQkdYDHmWF9ZOMvMjN71kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729849404; c=relaxed/simple;
	bh=7EftrcVtjK6oQLXiLNYNBQkTbfxp/N/Uhxi8izIA56A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QhXx6W24IN/yFOC7XRrdMdolTNTKJmO8V/5set8Neok+TUwzD99wt4ABOxRgWkNWdjrEZp/TYuSpSXh8ucdr/ryVR0tvf81JJX3Pg3Q8Vp7AQLVJZ0NvofH4FfGl52YBJPNZaO+ZHFcgmtnGkvdA0WsjD5jF15hVCnpaPKB5mKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=A8k+KCSk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xMGhyKyg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=A8k+KCSk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xMGhyKyg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AF45321D0E;
	Fri, 25 Oct 2024 09:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729849400; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Fkow1kgNcOrWQwdPZWs0Qu/RTSGpxVj/arg07S6n7jc=;
	b=A8k+KCSkM672TBgSBF1cFG7ymJkWpsUfBzM/3TKETSiUqpFTolZpkpDYIDKqXvselQDAnZ
	HnlQEUfiHEl0V3F74TlPEWS/HY29l9mnKJ3saU734+6RLfA9TDBsQVKQvA+gSbutFhuSY7
	3ezUjKfGkRwjBNlgqNRhWPfW3qoGD4Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729849400;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Fkow1kgNcOrWQwdPZWs0Qu/RTSGpxVj/arg07S6n7jc=;
	b=xMGhyKygu0tYuflrUM0/MQx//7x+EGlBuzm/d/3P5gZ9tJa/qMvqtJ4U0or5MZ7/2hXMWU
	Ut8m3MBJgSG4FjCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729849400; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Fkow1kgNcOrWQwdPZWs0Qu/RTSGpxVj/arg07S6n7jc=;
	b=A8k+KCSkM672TBgSBF1cFG7ymJkWpsUfBzM/3TKETSiUqpFTolZpkpDYIDKqXvselQDAnZ
	HnlQEUfiHEl0V3F74TlPEWS/HY29l9mnKJ3saU734+6RLfA9TDBsQVKQvA+gSbutFhuSY7
	3ezUjKfGkRwjBNlgqNRhWPfW3qoGD4Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729849400;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Fkow1kgNcOrWQwdPZWs0Qu/RTSGpxVj/arg07S6n7jc=;
	b=xMGhyKygu0tYuflrUM0/MQx//7x+EGlBuzm/d/3P5gZ9tJa/qMvqtJ4U0or5MZ7/2hXMWU
	Ut8m3MBJgSG4FjCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E20E132D3;
	Fri, 25 Oct 2024 09:43:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8s9ZIjhoG2ezewAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 25 Oct 2024 09:43:20 +0000
Message-ID: <2ca9450c-b5aa-4e7d-aa7b-437d9aec45dd@suse.cz>
Date: Fri, 25 Oct 2024 11:43:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] mm: defer second attempt at merge on mmap()
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>, Jann Horn
 <jannh@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Linus Torvalds <torvalds@linux-foundation.org>, Peter Xu <peterx@redhat.com>
References: <cover.1729715266.git.lorenzo.stoakes@oracle.com>
 <e063d9d31a4dbd83c2d77a3f1e0114e6a0788724.1729715266.git.lorenzo.stoakes@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <e063d9d31a4dbd83c2d77a3f1e0114e6a0788724.1729715266.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 10/23/24 22:38, Lorenzo Stoakes wrote:
> Rather than trying to merge again when ostensibly allocating a new VMA,
> instead defer until the VMA is added and attempt to merge the existing
> range.
> 
> This way we have no complicated unwinding logic midway through the process
> of mapping the VMA.
> 
> In addition this removes limitations on the VMA not being able to be the
> first in the virtual memory address space which was previously implicitly
> required.
> 
> It also performs this merge after the final flag adjustments are performed,
> something that was not done previously and thus might have prevented
> possibly valid merges in the past.
> 
> In theory, for this very same reason, we should unconditionally attempt
> merge here, however this is likely to have a performance impact so it is
> better to avoid this given the unlikely outcome of a merge.

Maybe just expand the cases where we set map->retry_merge, i.e. in case the
final flag adjustments do anything?

> The vmg state will already have been reset by the first attempt at a merge
> so we only need to reset the iterator, set the vma and flags and try again.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

A nit:

> ---
>  mm/vma.c | 75 ++++++++++++++++++++------------------------------------
>  1 file changed, 26 insertions(+), 49 deletions(-)
> 
> diff --git a/mm/vma.c b/mm/vma.c
> index 065f5e1f65be..c493ecebf394 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -19,6 +19,7 @@ struct mmap_state {
>  	struct file *file;
>  
>  	unsigned long charged;
> +	bool retry_merge;
>  
>  	struct vm_area_struct *prev;
>  	struct vm_area_struct *next;
> @@ -2280,9 +2281,9 @@ static int __mmap_prepare(struct mmap_state *map, struct vma_merge_struct *vmg,
>  	return 0;
>  }
>  
> +
>  static int __mmap_new_file_vma(struct mmap_state *map,
> -			       struct vma_merge_struct *vmg,
> -			       struct vm_area_struct **vmap, bool *mergedp)
> +			       struct vm_area_struct **vmap)
>  {
>  	struct vma_iterator *vmi = map->vmi;
>  	struct vm_area_struct *vma = *vmap;
> @@ -2311,37 +2312,11 @@ static int __mmap_new_file_vma(struct mmap_state *map,
>  			!(map->flags & VM_MAYWRITE) &&
>  			(vma->vm_flags & VM_MAYWRITE));
>  
> -	vma_iter_config(vmi, map->addr, map->end);
> -	/*
> -	 * If flags changed after mmap_file(), we should try merge
> -	 * vma again as we may succeed this time.
> -	 */
> -	if (unlikely(map->flags != vma->vm_flags && map->prev)) {
> -		struct vm_area_struct *merge;
> -
> -		vmg->flags = vma->vm_flags;
> -		/* If this fails, state is reset ready for a reattempt. */
> -		merge = vma_merge_new_range(vmg);
> -
> -		if (merge) {
> -			/*
> -			 * ->mmap() can change vma->vm_file and fput
> -			 * the original file. So fput the vma->vm_file
> -			 * here or we would add an extra fput for file
> -			 * and cause general protection fault
> -			 * ultimately.
> -			 */
> -			fput(vma->vm_file);
> -			vm_area_free(vma);
> -			vma = merge;
> -			*mergedp = true;
> -		} else {
> -			vma_iter_config(vmi, map->addr, map->end);
> -		}
> -	}
> +	/* If the flags change (and are mergeable), let's retry later. */
> +	map->retry_merge = vma->vm_flags != map->flags && !(vma->vm_flags & VM_SPECIAL);
>  
> +	vma_iter_config(vmi, map->addr, map->end);

Do we need this still? __mmap_new_vma() did that and nothing changed since
in the non-error case, AFAICS?

>  	map->flags = vma->vm_flags;
> -	*vmap = vma;
>  	return 0;
>  }
>  

