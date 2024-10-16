Return-Path: <linux-kernel+bounces-367728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A57339A05E4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 11:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5E991C2182F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E688206072;
	Wed, 16 Oct 2024 09:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RVKLT85W";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="f8J8W3X6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3JjVSqSv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tmGnjMfd"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1401B3926
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 09:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729071921; cv=none; b=opRt0v7D69k+0065Kb3J7DEATMrWHKoaUFJGe8IOns0EyXu2HCLGebrSUCBYSTgeSNsonyriGBGePs/xCg1N3WQ623qxx3LUULYPeN3HL8uIEma8M0wGb1dNaZCorDDPsU79BH3h7Fwd/Hg3mMXZpuWIGf5K8+IOu09Tu4ppOWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729071921; c=relaxed/simple;
	bh=MTy0GQc8ir4aujbhF9e2ZNdTFPUrHIPRsZ5f94DNxoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bv+P5RBP3z3nR0HGqELaTjvT/Qc6tvcPsBR0uL7QKlGhu+W6mX3A60+OAh3omBcjc9LjLuqXy5KnrpLmWUbTjSiveGEJbDk0uQiy/0Ecy5TaO5ucE6JWQJQcQFV2OF6Ib92ag26o+kvgJnGKcQ7l+x2WHajt/jtddpTKWT/qEng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RVKLT85W; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=f8J8W3X6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3JjVSqSv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tmGnjMfd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EFF0521E90;
	Wed, 16 Oct 2024 09:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729071918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=T2I/N2wBWQsTBpR3wXE/mAoefw4Qr0wdLG0WaUhFups=;
	b=RVKLT85WbvhsZW2WeLXPjvYinNMiZgKroYajl9gXOCI1SyyZ2hUWinDdknJBhN/7GUPhzd
	ctThJFrxrN0kNhJpFsJal8BDhxju174y92n3B7fWc67+daP/HCvBuAhC1NgdGHyh3bYXK5
	DuOBg+LQL7JXXvxsMN6c2kjzY6rQ4s8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729071918;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=T2I/N2wBWQsTBpR3wXE/mAoefw4Qr0wdLG0WaUhFups=;
	b=f8J8W3X6WImdXo6rVjQiceV67EahOqBGyrMXUFabcoMWQ+FKufTONycYE+q4wJ5ijYU2fl
	cCd7ZzPMoQxwNuCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729071917; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=T2I/N2wBWQsTBpR3wXE/mAoefw4Qr0wdLG0WaUhFups=;
	b=3JjVSqSvzh0UX9vt8mM1PWsGhOfAJKyt+geUM8LnRgPMvrYiTWmA+RNQi9/ZACy5Wb3CUj
	+vHddS7RxVzclO1cS6ljc0rA1dk+Rq4tpZu8BCraaZ81SZpvVcPoxLAF7aI+xqDgkoL0k2
	35UPw/ugtnd6q0p323d8BxsT2xjyqQg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729071917;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=T2I/N2wBWQsTBpR3wXE/mAoefw4Qr0wdLG0WaUhFups=;
	b=tmGnjMfdsB/dnkb6Dwttm9K5sZKmLW/R+jhPx5htGMyTUTjQTzLZPpE9X7ywUauQVV/1c4
	NjiCGAdAnOFj/HDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DAFA21376C;
	Wed, 16 Oct 2024 09:45:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tdckNS2LD2ddPwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 16 Oct 2024 09:45:17 +0000
Message-ID: <575a7505-dfb2-44ca-aa5f-d34783fc14fa@suse.cz>
Date: Wed, 16 Oct 2024 11:45:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/mmap: Fix race in mmap_region() with ftrucate()
Content-Language: en-US
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Jann Horn <jannh@google.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Matthew Wilcox <willy@infradead.org>, David Hildenbrand <david@redhat.com>
References: <20241016013455.2241533-1-Liam.Howlett@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20241016013455.2241533-1-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Subject has a typo, should say ftruncate()

Also let's explicitly note it's a 6.12 hotfix.

On 10/16/24 03:34, Liam R. Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> Avoiding the zeroing of the vma tree in mmap_region() introduced a race
> with truncate in the page table walk.  To avoid any races, create a hole
> in the rmap during the operation by clearing the pagetable entries
> earlier under the mmap write lock and (critically) before the new vma is
> installed into the vma tree.  The result is that the old vma(s) are left
> in the vma tree, but free_pgtables() removes them from the rmap and
> clears the ptes while holding the necessary locks.

And no parallel page faults can reinstate any PTEs as the vma's are marked
as detached, right.

> This change extends the fix required for hugetblfs and the call_mmap()
> function by moving the cleanup higher in the function and running it
> unconditionally.
> 
> Cc: Jann Horn <jannh@google.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: David Hildenbrand <david@redhat.com>
> Fixes: f8d112a4e657 ("mm/mmap: avoid zeroing vma tree in mmap_region()")
> Reported-by: Jann Horn <jannh@google.com>
> Closes: https://lore.kernel.org/all/CAG48ez0ZpGzxi=-5O_uGQ0xKXOmbjeQ0LjZsRJ1Qtf2X5eOr1w@mail.gmail.com/
> Link: https://lore.kernel.org/all/CAG48ez0ZpGzxi=-5O_uGQ0xKXOmbjeQ0LjZsRJ1Qtf2X5eOr1w@mail.gmail.com/
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Reviewed-by: Jann Horn <jannh@google.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/mmap.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> v1: https://lore.kernel.org/all/20241015161135.2133951-1-Liam.Howlett@oracle.com/
> 
> Changes since v1:
>   Updated commit message - Thanks Lorenzo
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index dd4b35a25aeb..a20998fb633c 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1413,6 +1413,13 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  		vmg.flags = vm_flags;
>  	}
>  
> +	/*
> +	 * clear PTEs while the vma is still in the tree so that rmap
> +	 * cannot race with the freeing later in the truncate scenario.
> +	 * This is also needed for call_mmap(), which is why vm_ops
> +	 * close function is called.
> +	 */
> +	vms_clean_up_area(&vms, &mas_detach);
>  	vma = vma_merge_new_range(&vmg);
>  	if (vma)
>  		goto expanded;
> @@ -1432,11 +1439,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  
>  	if (file) {
>  		vma->vm_file = get_file(file);
> -		/*
> -		 * call_mmap() may map PTE, so ensure there are no existing PTEs
> -		 * and call the vm_ops close function if one exists.
> -		 */
> -		vms_clean_up_area(&vms, &mas_detach);
>  		error = call_mmap(file, vma);
>  		if (error)
>  			goto unmap_and_free_vma;


