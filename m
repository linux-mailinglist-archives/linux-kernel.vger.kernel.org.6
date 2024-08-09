Return-Path: <linux-kernel+bounces-281032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6D194D21C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D121C283DD7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 14:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16136196DA4;
	Fri,  9 Aug 2024 14:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KBsO3KIb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nhyADwxN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KBsO3KIb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nhyADwxN"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A80196455
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 14:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723213558; cv=none; b=NO2DYDovrvo1OZ607gn6Q1NJd/z66xd5CF4lkWP9MIpK23eeKVE80YTP4hgxim9BSSoPIzmsBIcQmuzh6+dQNbJ/+cYXALZiPeqPnmz92I3xOtDp08CFCCgKPqYjc8i1ChGho8nATC9CKxmm6mF0BuyJ2QVx01sKPOhUqRZ9lqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723213558; c=relaxed/simple;
	bh=71JEsZed4o4ZwRnFfx3g73qFi1f8DHjDp22lpljenGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kFrjK2I1iqnyF68EXS2Y2u2C/SdkR+Oj/6D2qyi8quRbKyqCI/DQ/hEeDUQXalB4HKpd+6yETO7qNLivX+7TjzdXQ9fR4hn8hx5dacOGCjy2cIT0b9fVGMwOzORjQf8ApPhrYeV3rtaTt3TC986lgulXwhjE86DVG7RsqqIzvhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KBsO3KIb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nhyADwxN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KBsO3KIb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nhyADwxN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0B3F321E07;
	Fri,  9 Aug 2024 14:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723213554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QBksEJGpnuFRp/mepJbQOzxCuBoXxkk7MiDVFEOMnn8=;
	b=KBsO3KIbkMAPSjm5b5kL/eFBYLdfehvCkRTcjINHTxdr89+gU0fQJsjt8an5LRgxovMYZ6
	7EVvpBv+pbWQpjZzjagrEvt8utTEOX21K/46qCjLVHsQIcUv08hzOS60rK4173rHwqM8ox
	597LhCKUZClPRN08tBV2bfkY2+YY+O8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723213554;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QBksEJGpnuFRp/mepJbQOzxCuBoXxkk7MiDVFEOMnn8=;
	b=nhyADwxNX2xBIujSmoW3521dmdnsQoEWmQX9fRJai4+mmWcf63n+mSThI/Oatw2OADsQEM
	Wltsn+7EdZ7SVXBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723213554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QBksEJGpnuFRp/mepJbQOzxCuBoXxkk7MiDVFEOMnn8=;
	b=KBsO3KIbkMAPSjm5b5kL/eFBYLdfehvCkRTcjINHTxdr89+gU0fQJsjt8an5LRgxovMYZ6
	7EVvpBv+pbWQpjZzjagrEvt8utTEOX21K/46qCjLVHsQIcUv08hzOS60rK4173rHwqM8ox
	597LhCKUZClPRN08tBV2bfkY2+YY+O8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723213554;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QBksEJGpnuFRp/mepJbQOzxCuBoXxkk7MiDVFEOMnn8=;
	b=nhyADwxNX2xBIujSmoW3521dmdnsQoEWmQX9fRJai4+mmWcf63n+mSThI/Oatw2OADsQEM
	Wltsn+7EdZ7SVXBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F053C13A7D;
	Fri,  9 Aug 2024 14:25:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id g1NHOvEmtmahEgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 09 Aug 2024 14:25:53 +0000
Message-ID: <46d631a3-47f6-4ea7-9a69-32bf1a3adf01@suse.cz>
Date: Fri, 9 Aug 2024 16:25:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] mm: rework vm_ops->close() handling on VMA merge
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>
References: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
 <0afd85543d46fd743c0c71b6f6520f9580174b4f.1722849860.git.lorenzo.stoakes@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <0afd85543d46fd743c0c71b6f6520f9580174b4f.1722849860.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.29
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On 8/5/24 14:13, Lorenzo Stoakes wrote:
> In commit 714965ca8252 ("mm/mmap: start distinguishing if vma can be
> removed in mergeability test") we relaxed the VMA merge rules for VMAs
> possessing a vm_ops->close() hook, permitting this operation in instances
> where we wouldn't delete the VMA as part of the merge operation.
> 
> This was later corrected in commit fc0c8f9089c2 ("mm, mmap: fix vma_merge()
> case 7 with vma_ops->close") to account for a subtle case that the previous
> commit had not taken into account.
> 
> In both instances, we first rely on is_mergeable_vma() to determine whether
> we might be dealing with a VMA that might be removed, taking advantage of
> the fact that a 'previous' VMA will never be deleted, only VMAs that follow
> it.
> 
> The second patch corrects the instance where a merge of the previous VMA
> into a subsequent one did not correctly check whether the subsequent VMA
> had a vm_ops->close() handler.
> 
> Both changes prevent merge cases that are actually permissible (for
> instance a merge of a VMA into a following VMA with a vm_ops->close(), but
> with no previous VMA, which would result in the next VMA being extended,
> not deleted).
> 
> In addition, both changes fail to consider the case where a VMA that would
> otherwise be merged with the previous and next VMA might have
> vm_ops->close(), on the assumption that for this to be the case, all three
> would have to have the same vma->vm_file to be mergeable and thus the same
> vm_ops.
> 
> And in addition both changes operate at 50,000 feet, trying to guess
> whether a VMA will be deleted.
> 
> As we have majorly refactored the VMA merge operation and de-duplicated
> code to the point where we know precisely where deletions will occur, this
> patch removes the aforementioned checks altogether and instead explicitly
> checks whether a VMA will be deleted.
> 
> In cases where a reduced merge is still possible (where we merge both
> previous and next VMA but the next VMA has a vm_ops->close hook, meaning we
> could just merge the previous and current VMA), we do so, otherwise the
> merge is not permitted.
> 
> We take advantage of our userland testing to assert that this functions
> correctly - replacing the previous limited vm_ops->close() tests with tests
> for every single case where we delete a VMA.
> 
> We also update all testing for both new and modified VMAs to set
> vma->vm_ops->close() in every single instance where this would not prevent
> the merge, to assert that we never do so.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Amazing!

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> @@ -710,9 +706,30 @@ static struct vm_area_struct *vma_merge_modified(struct vma_merge_struct *vmg)
> 
>  	/* If we span the entire VMA, a merge implies it will be deleted. */
>  	merge_will_delete_vma = left_side && right_side;
> -	/* If we merge both VMAs, then next is also deleted. */

Nit: This comment ...

> +
> +	/*
> +	 * If we need to remove vma in its entirety but are unable to do so,
> +	 * we have no sensible recourse but to abort the merge.
> +	 */
> +	if (merge_will_delete_vma && !can_merge_remove_vma(vma))
> +		return NULL;
> +
> +	/*
> +	 * If we merge both VMAs, then next is also deleted. This implies
> +	 * merge_will_delete_vma also.
> +	 */

... changed to this comment. Seems spurious, could have been like that
before already? I don't see how the new "This implies" part became relevant
now? We already tested merge_will_delete_vma above.

>  	merge_will_delete_next = merge_both;
> 
> +	/*
> +	 * If we cannot delete next, then we can reduce the operation to merging
> +	 * prev and vma (thereby deleting vma).
> +	 */
> +	if (merge_will_delete_next && !can_merge_remove_vma(next)) {
> +		merge_will_delete_next = false;
> +		merge_right = false;
> +		merge_both = false;
> +	}
> +
>  	/* No matter what happens, we will be adjusting vma. */
>  	vma_start_write(vma);
> 


