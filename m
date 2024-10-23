Return-Path: <linux-kernel+bounces-378307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B5F9ACE1F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 17:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37A461C21F84
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 15:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C821A725C;
	Wed, 23 Oct 2024 15:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VHKDfyBv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="A/g596dy";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gH6DlvQ5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="M1eNrP0O"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E9F19F13C
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 15:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729695695; cv=none; b=mAjoPLoLg3oEAxGRvAz0k8+P79dfUC2PLG0HTf6Axd9HVwgNUZAqCO/nRXfvqX40srq82H4oiohJmppkFTIRVgBSBNvmoe2apLHSnoWKV4ipXjv0pyoyKIyARI8aMtVFRMoAhrkmkVOHutu9Z7Fb0YG6BWE51pXFZqyMZsk/Xns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729695695; c=relaxed/simple;
	bh=hiLtjXeOgOHfSuhkhvmGozk3/Ner78I4QfhLwmPJiAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cacaB3WCwKBht7kwWTerPNObr9VsxUXv1qnhd1Q2ArLqTU9+a9ml6/wlff2Un6EAFHJD1KlleWpImq6XGaeQOrIYhOG80rzA5a/G8SG1Xz75KLibvx4mRtSR6iW4vf6ReO6B5aLNcnK6eZ/FS/UOQf+Jk+nVIsCbZsIpwagR1h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VHKDfyBv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=A/g596dy; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gH6DlvQ5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=M1eNrP0O; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CF8B521FFE;
	Wed, 23 Oct 2024 15:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729695691; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4kvKQW7teN3ZH5WGWLxYS6jbROyk39Wk+SZYb41S0EI=;
	b=VHKDfyBv98fFViUU/cErJrEpOiVmlY27DTIIYKkVnSxSUtSqCHPzWUz2HeihXjrddg/Cfa
	RZMB/sOl6ro371gClqDaJBtgthFjkNJewj5aPKCWtJ65ln1e/KYB5IgomQEb9j0IIGHlD8
	BpEs8vkXUA/Vok1QzVrkn5Y4fGN8NlM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729695691;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4kvKQW7teN3ZH5WGWLxYS6jbROyk39Wk+SZYb41S0EI=;
	b=A/g596dyvSmki7OpcgSNpiwjHPbUq/6+Pl7cu8POjQMdWPcV5/7ODZoCr8+7bHGOcbEQxk
	I1FLCBKgWsKqaqAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729695689; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4kvKQW7teN3ZH5WGWLxYS6jbROyk39Wk+SZYb41S0EI=;
	b=gH6DlvQ5J1UALj0UI08FDhybCEpRwpH4cxMhujTpheJQ2gxCxKo2pVbqGXJZ3AZXTeOAT+
	SqF7b2UgmVKCVVnf7zpamRy0epKQqVgAjEKW3EnEuRV/MdUpPT8ZJen7Ty/IHLgtShyXIn
	uF98XmCOBgNlJX8vMapZT9z3oWPBLRw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729695689;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4kvKQW7teN3ZH5WGWLxYS6jbROyk39Wk+SZYb41S0EI=;
	b=M1eNrP0OvkNUOHN6HsMQLB8WXBLPXJHhKXChf4DDZ2GxjB3fxozaOSMgTgt7ywunCrEQiw
	moZOzFDsHD/VBNCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AFA8D13A63;
	Wed, 23 Oct 2024 15:01:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cHh7KskPGWdTIAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 23 Oct 2024 15:01:29 +0000
Message-ID: <f5037dbb-7412-4fda-b397-3e5538343686@suse.cz>
Date: Wed, 23 Oct 2024 17:01:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hotfix 6.12 8/8] mm: do not attempt second merge for
 file-backed VMAs
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>, Jann Horn
 <jannh@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Linus Torvalds <torvalds@linux-foundation.org>, Peter Xu <peterx@redhat.com>
References: <cover.1729628198.git.lorenzo.stoakes@oracle.com>
 <7b6bf6165080505feb5e00b313d2c84c25015e45.1729628198.git.lorenzo.stoakes@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <7b6bf6165080505feb5e00b313d2c84c25015e45.1729628198.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,oracle.com:email,suse.cz:mid]
X-Spam-Flag: NO
X-Spam-Level: 

On 10/22/24 22:40, Lorenzo Stoakes wrote:
> Previously, we'd always try to merge a file-backed VMA if its flags were
> changed by the driver.
> 
> This however is rarely meaningful as typically the flags would be changed
> to VM_PFNMAP or other VM_SPECIAL flags which are inherently unmergable.
> 
> In cases where it is meaningful (for instance DAX) it is doubtful that this

Hm if that's true, I'm imagining many piecemeal mmap()s of DAX that used to
merge but now will create tons of VMA's, which doesn't sound great. Then it
has also potentially breaking effects on mremap() which doesn't work accross
multiple VMA's.

> optimisation is worth the effort and maintenance risk of having to unwind
> state and perform a merge.

What if we simply created a new vma but only then checked if the flags
changed and we can merge it with neighbours (i.e. like the mprotect()
merging case). Less efficient, but less tricky and with the same result
hopefully?

> Since we've observed bugs and resource leaks due to complexity in this
> area, it is simply not acceptable to have a 'nice to have' optimisation
> like this complicating an already very complicated code path, so let's
> simply eliminate it.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  mm/vma.c | 39 ++-------------------------------------
>  1 file changed, 2 insertions(+), 37 deletions(-)
> 
> diff --git a/mm/vma.c b/mm/vma.c
> index a271e2b406ab..fe1fe5099e78 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -2260,8 +2260,7 @@ static int __mmap_prepare(struct mmap_state *map)
>  	return 0;
>  }
> 
> -static int __mmap_new_file_vma(struct mmap_state *map, struct vm_area_struct *vma,
> -			       struct vm_area_struct **mergep)
> +static int __mmap_new_file_vma(struct mmap_state *map, struct vm_area_struct *vma)
>  {
>  	struct vma_iterator *vmi = map->vmi;
>  	struct vma_merge_struct *vmg = map->vmg;
> @@ -2291,34 +2290,6 @@ static int __mmap_new_file_vma(struct mmap_state *map, struct vm_area_struct *vm
>  			(vma->vm_flags & VM_MAYWRITE));
> 
>  	vma_iter_config(vmi, vmg->start, vmg->end);
> -	/*
> -	 * If flags changed after mmap_file(), we should try merge
> -	 * vma again as we may succeed this time.
> -	 */
> -	if (unlikely(map->flags != vma->vm_flags && vmg->prev)) {
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
> -			vma_iter_free(vmi);
> -			*mergep = merge;
> -		} else {
> -			vma_iter_config(vmi, vmg->start, vmg->end);
> -		}
> -	}
> -
>  	map->flags = vma->vm_flags;
>  	return 0;
>  }
> @@ -2341,7 +2312,6 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
>  {
>  	struct vma_iterator *vmi = map->vmi;
>  	struct vma_merge_struct *vmg = map->vmg;
> -	struct vm_area_struct *merge = NULL;
>  	int error = 0;
>  	struct vm_area_struct *vma;
> 
> @@ -2365,7 +2335,7 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
>  	}
> 
>  	if (vmg->file)
> -		error = __mmap_new_file_vma(map, vma, &merge);
> +		error = __mmap_new_file_vma(map, vma);
>  	else if (map->flags & VM_SHARED)
>  		error = shmem_zero_setup(vma);
>  	else
> @@ -2374,9 +2344,6 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
>  	if (error)
>  		goto free_iter_vma;
> 
> -	if (merge)
> -		goto file_expanded;
> -
>  #ifdef CONFIG_SPARC64
>  	/* TODO: Fix SPARC ADI! */
>  	WARN_ON_ONCE(!arch_validate_flags(map->flags));
> @@ -2393,8 +2360,6 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
>  	 * call covers the non-merge case.
>  	 */
>  	khugepaged_enter_vma(vma, map->flags);
> -
> -file_expanded:
>  	ksm_add_vma(vma);
> 
>  	*vmap = vma;
> --
> 2.47.0


