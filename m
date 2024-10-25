Return-Path: <linux-kernel+bounces-382280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 034549B0BBC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7021F1F2A0D5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8C420EA30;
	Fri, 25 Oct 2024 17:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lNoH5LVK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Qrz65M8m";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="S0ghxCDx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2Ik9HeBi"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5713206515
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 17:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729877727; cv=none; b=OpTAdORIjgb99p2gnLQSqfydz+O0wN//qdXv149Nqx8ulee9EGm+nVeqZeZuUnbvRpuQ/Eek6znKVxhQRUEIVrximDg2ezpVhGyOPi791lmOCNVTMyNSbfYK5e0Q9WVQahE8Whwz45z4e9bvTWTYz673bhmuO2HGXU0+3w/12yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729877727; c=relaxed/simple;
	bh=ShluMMlw3Tu9H4VAx50bioPDcS++4dRjtYcydP2BifU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=keo2JQHPP59zfd7cjW5heCorrqUeFh5lEPUdlasEy4nzevSGL8i3Yr++A7XyorfEVAs2geQ0wTikB0BVbDApJROR98XlNEJl6cvZbCHGCtaKmDJBSRjJz/VM+hG+LwojTMC4tdNfxtt3gK74p2GoCvzeTFKkq8qCMFNdkixuDHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lNoH5LVK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Qrz65M8m; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=S0ghxCDx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2Ik9HeBi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D55781FE29;
	Fri, 25 Oct 2024 17:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729877723; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AsmsTsNboAT8NF5w4q/ox7PcX0F/HoJ6HqAls3ejgJs=;
	b=lNoH5LVKPqATmlfXJXiEOHdFHmYt6KZ0O6NawYFXfkiBrsmMt14VI/i6NiE290SmDYd/3f
	2O93n/LxKdbXUI+0wLDteupxK2FnaLgUqQOTQhpL34dEYxL8281mgD6KLBHPq8qDwsf3U1
	iOmF/NeLQQ+jPxVdg2Kwbvntlybozlw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729877723;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AsmsTsNboAT8NF5w4q/ox7PcX0F/HoJ6HqAls3ejgJs=;
	b=Qrz65M8mgPS8L3PQac3mjgHsu1Ee1RpxC4Z8PXaVETaa4tz9HARTTmVNoQO0bZ5CO1yB+/
	ZJ6xNENi8s7ZJJAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729877722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AsmsTsNboAT8NF5w4q/ox7PcX0F/HoJ6HqAls3ejgJs=;
	b=S0ghxCDxQSGGjsbfppjkD+c3HteVc+CX34T+RCyJLpkjY+ZImfiyl4teC/0KJbjBAWJHdI
	VgBTLZfLSRh7ffERVxyn55Nyq1Yut4WMQ1c1DwhvaP8zPEcUYO02rdABNuGGeBjcSSWE+O
	9797LceTETg1uOhuGExVooAwuI+klmU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729877722;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AsmsTsNboAT8NF5w4q/ox7PcX0F/HoJ6HqAls3ejgJs=;
	b=2Ik9HeBi6ZyyRf8xweRrldKGQHsv1yWqYPoPKIvhULVM+9YZD0KOABirREDjxHp7WldXvj
	21YfwTS0BYy/K8Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BA749132D3;
	Fri, 25 Oct 2024 17:35:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pWrlLNrWG2c2FwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 25 Oct 2024 17:35:22 +0000
Message-ID: <21e7bed9-b705-4fb1-84e6-9fab2e66dbeb@suse.cz>
Date: Fri, 25 Oct 2024 19:35:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] mm: remove unnecessary reset state logic on merge
 new VMA
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>, Jann Horn
 <jannh@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Linus Torvalds <torvalds@linux-foundation.org>, Peter Xu <peterx@redhat.com>
References: <cover.1729858176.git.lorenzo.stoakes@oracle.com>
 <5d9a59eee6498ae017cc87d89aa723de7179f75d.1729858176.git.lorenzo.stoakes@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <5d9a59eee6498ae017cc87d89aa723de7179f75d.1729858176.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On 10/25/24 14:26, Lorenzo Stoakes wrote:
> The only place where this was used was in mmap_region(), which we have now
> adjusted to not require this to be performed (we reset ourselves in
> effect).
> 
> It also created a dangerous assumption that VMG state could be safely
> reused after a merge, at which point it may have been mutated in unexpected
> ways, leading to subtle bugs.
> 
> Note that it was discovered by Wei Yang that there was also an error in
> this code - we are comparing vmg->vma with prev after setting it to
> NULL.
> 
> This however had no impact, as we previously reset VMA iterator state
> before attempting merge again, but it was useless effort.
> 
> In any case, this patch removes all of the logic so also eliminates this
> wasted effort.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Yeah glad to be rid of this.

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/vma.c | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/mm/vma.c b/mm/vma.c
> index b91c947babd6..7c690be67910 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -963,7 +963,6 @@ struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg)
>  	struct vm_area_struct *next = vmg->next;
>  	unsigned long start = vmg->start;
>  	unsigned long end = vmg->end;
> -	pgoff_t pgoff = vmg->pgoff;
>  	pgoff_t pglen = PHYS_PFN(end - start);
>  	bool can_merge_left, can_merge_right;
>  	bool just_expand = vmg->merge_flags & VMG_FLAG_JUST_EXPAND;
> @@ -1020,16 +1019,6 @@ struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg)
>  		return vmg->vma;
>  	}
>  
> -	/* If expansion failed, reset state. Allows us to retry merge later. */
> -	if (!just_expand) {
> -		vmg->vma = NULL;
> -		vmg->start = start;
> -		vmg->end = end;
> -		vmg->pgoff = pgoff;
> -		if (vmg->vma == prev)
> -			vma_iter_set(vmg->vmi, start);
> -	}
> -
>  	return NULL;
>  }
>  


