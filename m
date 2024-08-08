Return-Path: <linux-kernel+bounces-279861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D15F94C2BE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 18:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB8FA282844
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF8618FC79;
	Thu,  8 Aug 2024 16:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="R6phpp2G";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sfNBYC7/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="R6phpp2G";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sfNBYC7/"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BC9646
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 16:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723134471; cv=none; b=HjG1TQz84NfKd/a2+wvkkPjgI4jSXhtrJzzziaGvv6EZPetsbo1keIixFDm9mVt75Ei+/dAV2aYpY4i5wiwUtwika9vig3PUeztXGIICrV/FVZbqmjcljTIqsH0TsNZ/7Sj+TNE0McRe5vvFHxuwCFlnVWpzLS2DQY2MVEUqXZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723134471; c=relaxed/simple;
	bh=bxLJHLzI1nVBa0oewR7PFRPX9GdH42twl67mcPq3yOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qvTHPFjnZmYi9zJe0WaEne+8Mx3HfWTuIKUUNnmdpc42KVgmgBi+RwSlytZv0Dt1YeI6IH8Ot0cDQ/8FgFm+ipEeSTSvbqtrcJPut8Dy6HL/Q1J1DkNvG0AcmM7gPytE5EQxu929F6GvoRi5iAIxRwS7tUypbMhvVLdIu0wgtT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=R6phpp2G; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sfNBYC7/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=R6phpp2G; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sfNBYC7/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 78F971FCF0;
	Thu,  8 Aug 2024 16:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723134467; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yp+k+hBMouHQOgU7UqLezr6qgqiaH9RJ8ONtm90+BPc=;
	b=R6phpp2GYsmhNBIXB2mQ8G/bB4xrf0+vZO9G39Ra9t9zpdrjXbs3ZC/jV/1fH78LMyDcPG
	GdrQu9Sr/hpRMb/2eqm8A7JdWlpoQ8vyvrSud8D0XgB21DpDFSmot4Fc7TVngMvkKdYf/d
	66DJoyHWPshfG7C9bOJXYIkcQiYIAJs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723134467;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yp+k+hBMouHQOgU7UqLezr6qgqiaH9RJ8ONtm90+BPc=;
	b=sfNBYC7/qG0crGDqwyXCY1lXDO7Dy9ggWvXXHdAf5jC4QYYtu/xXy7KxkAtxgiWK3RB+Tz
	x7M9mubnN2dzF/Aw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=R6phpp2G;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="sfNBYC7/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723134467; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yp+k+hBMouHQOgU7UqLezr6qgqiaH9RJ8ONtm90+BPc=;
	b=R6phpp2GYsmhNBIXB2mQ8G/bB4xrf0+vZO9G39Ra9t9zpdrjXbs3ZC/jV/1fH78LMyDcPG
	GdrQu9Sr/hpRMb/2eqm8A7JdWlpoQ8vyvrSud8D0XgB21DpDFSmot4Fc7TVngMvkKdYf/d
	66DJoyHWPshfG7C9bOJXYIkcQiYIAJs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723134467;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yp+k+hBMouHQOgU7UqLezr6qgqiaH9RJ8ONtm90+BPc=;
	b=sfNBYC7/qG0crGDqwyXCY1lXDO7Dy9ggWvXXHdAf5jC4QYYtu/xXy7KxkAtxgiWK3RB+Tz
	x7M9mubnN2dzF/Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D687013BA9;
	Thu,  8 Aug 2024 12:49:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fDh4M7++tGZQZAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 08 Aug 2024 12:49:03 +0000
Message-ID: <a5b259f6-2ebe-4081-8b17-2eaf4d8eced3@suse.cz>
Date: Thu, 8 Aug 2024 14:49:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] mm: introduce vma_merge_struct and abstract merge
 parameters
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>
References: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
 <f2d7cc5de8aecc50d353980f62a74a0a6fcec198.1722849859.git.lorenzo.stoakes@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <f2d7cc5de8aecc50d353980f62a74a0a6fcec198.1722849859.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.50
X-Rspamd-Queue-Id: 78F971FCF0
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,oracle.com:email,suse.cz:dkim,suse.cz:email];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,oracle.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spam-Flag: NO

On 8/5/24 14:13, Lorenzo Stoakes wrote:
> Rather than passing around huge numbers of parameters to numerous helper
> functions, abstract them into a single struct that we thread through the
> operation.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

In general,

Acked-by: Vlastimil Babka <vbabka@suse.cz>

It would be great to have the tests already at this point but I understand
they depend on this. At least the result can be tested later in the series...

I haven't seen the final form yet, so some suggestions may become moot.

> +static struct vm_area_struct *vma_merge(struct vma_merge_struct *vmg)
>  {
> -	struct mm_struct *mm = src->vm_mm;
> -	struct anon_vma *anon_vma = src->anon_vma;
> -	struct file *file = src->vm_file;
> +	struct mm_struct *mm = container_of(vmg->vmi->mas.tree, struct mm_struct, mm_mt);

This feels weird, but I'll leave it to Liam. Can't we just pass the mm? Hope
it's one of the things that will disappear in later patch :)

> +	struct vm_area_struct *prev = vmg->prev;
>  	struct vm_area_struct *curr, *next, *res;
>  	struct vm_area_struct *vma, *adjust, *remove, *remove2;
>  	struct vm_area_struct *anon_dup = NULL;

<snip>

> +/* Assumes addr >= vma->vm_start. */
> +static pgoff_t vma_pgoff_offset(struct vm_area_struct *vma, unsigned long addr)
> +{
> +	return vma->vm_pgoff + PHYS_PFN(addr - vma->vm_start);
> +}
> +
> +struct vm_area_struct *vma_modify_flags(struct vma_iterator *vmi,
> +					struct vm_area_struct *prev,
> +					struct vm_area_struct *vma,
> +					unsigned long start, unsigned long end,
> +					unsigned long new_flags)
> +{
> +	struct vma_merge_struct vmg = {
> +		.vmi = vmi,
> +		.prev = prev,
> +		.vma = vma,
> +		.start = start,
> +		.end = end,
> +		.flags = new_flags,
> +		.pgoff = vma_pgoff_offset(vma, start),
> +		.file = vma->vm_file,
> +		.anon_vma = vma->anon_vma,
> +		.policy = vma_policy(vma),
> +		.uffd_ctx = vma->vm_userfaultfd_ctx,
> +		.anon_name = anon_vma_name(vma),
> +	};
> +
> +	return vma_modify(&vmg);
> +}
> +
> +struct vm_area_struct
> +*vma_modify_flags_name(struct vma_iterator *vmi,
> +		       struct vm_area_struct *prev,
> +		       struct vm_area_struct *vma,
> +		       unsigned long start,
> +		       unsigned long end,
> +		       unsigned long new_flags,
> +		       struct anon_vma_name *new_name)
> +{
> +	struct vma_merge_struct vmg = {
> +		.vmi = vmi,
> +		.prev = prev,
> +		.vma = vma,
> +		.start = start,
> +		.end = end,
> +		.flags = new_flags,
> +		.pgoff = vma_pgoff_offset(vma, start),
> +		.file = vma->vm_file,
> +		.anon_vma = vma->anon_vma,
> +		.policy = vma_policy(vma),
> +		.uffd_ctx = vma->vm_userfaultfd_ctx,
> +		.anon_name = new_name,
> +	};
> +
> +	return vma_modify(&vmg);
> +}
> +
> +struct vm_area_struct
> +*vma_modify_policy(struct vma_iterator *vmi,
> +		   struct vm_area_struct *prev,
> +		   struct vm_area_struct *vma,
> +		   unsigned long start, unsigned long end,
> +		   struct mempolicy *new_pol)
> +{
> +	struct vma_merge_struct vmg = {
> +		.vmi = vmi,
> +		.prev = prev,
> +		.vma = vma,
> +		.start = start,
> +		.end = end,
> +		.flags = vma->vm_flags,
> +		.pgoff = vma_pgoff_offset(vma, start),
> +		.file = vma->vm_file,
> +		.anon_vma = vma->anon_vma,
> +		.policy = new_pol,
> +		.uffd_ctx = vma->vm_userfaultfd_ctx,
> +		.anon_name = anon_vma_name(vma),
> +	};
> +
> +	return vma_modify(&vmg);
> +}
> +
> +struct vm_area_struct
> +*vma_modify_flags_uffd(struct vma_iterator *vmi,
> +		       struct vm_area_struct *prev,
> +		       struct vm_area_struct *vma,
> +		       unsigned long start, unsigned long end,
> +		       unsigned long new_flags,
> +		       struct vm_userfaultfd_ctx new_ctx)
> +{
> +	struct vma_merge_struct vmg = {
> +		.vmi = vmi,
> +		.prev = prev,
> +		.vma = vma,
> +		.start = start,
> +		.end = end,
> +		.flags = new_flags,
> +		.file = vma->vm_file,
> +		.anon_vma = vma->anon_vma,
> +		.pgoff = vma_pgoff_offset(vma, start),
> +		.policy = vma_policy(vma),
> +		.uffd_ctx = new_ctx,
> +		.anon_name = anon_vma_name(vma),
> +	};
> +
> +	return vma_modify(&vmg);
>  }
>  
>  /*
> @@ -1180,8 +1274,22 @@ struct vm_area_struct
>  		   struct vm_area_struct *vma, unsigned long start,
>  		   unsigned long end, pgoff_t pgoff)
>  {
> -	return vma_merge(vmi, prev, vma, start, end, vma->vm_flags, pgoff,
> -			 vma_policy(vma), vma->vm_userfaultfd_ctx, anon_vma_name(vma));
> +	struct vma_merge_struct vmg = {
> +		.vmi = vmi,
> +		.prev = prev,
> +		.vma = vma,
> +		.start = start,
> +		.end = end,
> +		.flags = vma->vm_flags,
> +		.file = vma->vm_file,
> +		.anon_vma = vma->anon_vma,
> +		.pgoff = pgoff,
> +		.policy = vma_policy(vma),
> +		.uffd_ctx = vma->vm_userfaultfd_ctx,
> +		.anon_name = anon_vma_name(vma),
> +	};
> +
> +	return vma_merge(&vmg);
>  }
>  
>  /*
> @@ -1193,11 +1301,22 @@ struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
>  					unsigned long delta)
>  {
>  	pgoff_t pgoff = vma->vm_pgoff + vma_pages(vma);
> +	struct vma_merge_struct vmg = {
> +		.vmi = vmi,
> +		.prev = vma,
> +		.vma = vma,
> +		.start = vma->vm_end,
> +		.end = vma->vm_end + delta,
> +		.flags = vma->vm_flags,
> +		.file = vma->vm_file,
> +		.pgoff = pgoff,
> +		.policy = vma_policy(vma),
> +		.uffd_ctx = vma->vm_userfaultfd_ctx,
> +		.anon_name = anon_vma_name(vma),
> +	};

Wonder if there's a way to initialize a "standard" vmg and then apply the
usage-specific differences on top, instead of needing many repeated but
subtly different blocks like above.

>  
>  	/* vma is specified as prev, so case 1 or 2 will apply. */
> -	return vma_merge(vmi, vma, vma, vma->vm_end, vma->vm_end + delta,
> -			 vma->vm_flags, pgoff, vma_policy(vma),
> -			 vma->vm_userfaultfd_ctx, anon_vma_name(vma));
> +	return vma_merge(&vmg);
>  }
>  
>  void unlink_file_vma_batch_init(struct unlink_vma_file_batch *vb)
> diff --git a/mm/vma.h b/mm/vma.h
> index 6efdf1768a0a..c31684cc1da6 100644


