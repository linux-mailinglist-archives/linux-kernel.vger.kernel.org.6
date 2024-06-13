Return-Path: <linux-kernel+bounces-212726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E1690655A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 09:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 509BE1F24087
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 07:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4B113C80A;
	Thu, 13 Jun 2024 07:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Hk6IrMmN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dKuE2pVb";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Hk6IrMmN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dKuE2pVb"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D8613C3D6
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 07:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718264360; cv=none; b=am87wcHYifPdQBR13nF3c0QmmY4IC8qKPLscOR1/+jrPw2xqoxz+Gl2T7+tGoWCqephj0juqSWQ2rLGvs0EpNitDAWOOovFhi4s/2KnmcsU/I1gz9RTeDaNGvv4UXe3FwdsKQblIjLVFTNc404iuP90BLukxpK2WHuHm1d/UN1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718264360; c=relaxed/simple;
	bh=eeRUEo41icEwmxMt46WyBX5D6jIPGfbgEfVlpJjOh/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kth0R95x8zdvFRo5yRHNDZAaRMZdUxlJwr04/JBBzqeTwbKtaS75TflGJMbvyXFmTbdjm2KorRqUOGKFFSAbVWozm0aEIPT7xm3H0hpFI0Yi0d/omCon/zYDDGQGK2NOeqmk29HZzb6tSRyLtjsZE2BsubsDQihAE0s3kiQzczw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Hk6IrMmN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dKuE2pVb; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Hk6IrMmN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dKuE2pVb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 597463504D;
	Thu, 13 Jun 2024 07:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718264357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PJr/sVqqibP7odVJAVm3G5KXSTQ5G/aztZXaBj/Ps0Q=;
	b=Hk6IrMmNmmk6+OnKpC5t1Fwcg7VYXLsRjctko2pjEjG1EzMMSOoNexWIbKwg0b0ubAm3U0
	9WntOMQY0sGnUitsr5bPygUGELIHnkDV8sfwZOLwW5F65fgvvAAvXVxyQvOFpSndpRI91P
	xFx5oThb/plGx5nZfuL2Qsh2ftPuzJc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718264357;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PJr/sVqqibP7odVJAVm3G5KXSTQ5G/aztZXaBj/Ps0Q=;
	b=dKuE2pVb2zgiX6DotLeuAj+BGf1xKCV69k885AFnTmtuD7zIla+rVE9LmjHStNJiy8nkZ9
	0Z2ts9tc2MNb5FAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Hk6IrMmN;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=dKuE2pVb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718264357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PJr/sVqqibP7odVJAVm3G5KXSTQ5G/aztZXaBj/Ps0Q=;
	b=Hk6IrMmNmmk6+OnKpC5t1Fwcg7VYXLsRjctko2pjEjG1EzMMSOoNexWIbKwg0b0ubAm3U0
	9WntOMQY0sGnUitsr5bPygUGELIHnkDV8sfwZOLwW5F65fgvvAAvXVxyQvOFpSndpRI91P
	xFx5oThb/plGx5nZfuL2Qsh2ftPuzJc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718264357;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PJr/sVqqibP7odVJAVm3G5KXSTQ5G/aztZXaBj/Ps0Q=;
	b=dKuE2pVb2zgiX6DotLeuAj+BGf1xKCV69k885AFnTmtuD7zIla+rVE9LmjHStNJiy8nkZ9
	0Z2ts9tc2MNb5FAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D4EBD13A87;
	Thu, 13 Jun 2024 07:39:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id V9lyMSSiamZ9TQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 13 Jun 2024 07:39:16 +0000
Date: Thu, 13 Jun 2024 09:39:15 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 16/18] powerpc/64s: Use contiguous PMD/PUD instead of
 HUGEPD
Message-ID: <ZmqiI5Q8DyyEA0gW@localhost.localdomain>
References: <cover.1717955558.git.christophe.leroy@csgroup.eu>
 <92a741b0358fc100ad331760181f66e82781052b.1717955559.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92a741b0358fc100ad331760181f66e82781052b.1717955559.git.christophe.leroy@csgroup.eu>
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,nvidia.com,redhat.com,ellerman.id.au,gmail.com,vger.kernel.org,kvack.org,lists.ozlabs.org];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 597463504D
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 

On Mon, Jun 10, 2024 at 07:55:01AM +0200, Christophe Leroy wrote:
> On book3s/64, the only user of hugepd is hash in 4k mode.
> 
> All other setups (hash-64, radix-4, radix-64) use leaf PMD/PUD.
> 
> Rework hash-4k to use contiguous PMD and PUD instead.
> 
> In that setup there are only two huge page sizes: 16M and 16G.
> 
> 16M sits at PMD level and 16G at PUD level.
> 
> pte_update doesn't know page size, lets use the same trick as
> hpte_need_flush() to get page size from segment properties. That's
> not the most efficient way but let's do that until callers of
> pte_update() provide page size instead of just a huge flag.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
...
> +static inline unsigned long hash__pte_update(struct mm_struct *mm,
> +					 unsigned long addr,
> +					 pte_t *ptep, unsigned long clr,
> +					 unsigned long set,
> +					 int huge)
> +{
> +	unsigned long old;
> +
> +	old = hash__pte_update_one(ptep, clr, set);
> +
> +	if (IS_ENABLED(CONFIG_PPC_4K_PAGES) && huge) {
> +		unsigned int psize = get_slice_psize(mm, addr);
> +		int nb, i;
> +
> +		if (psize == MMU_PAGE_16M)
> +			nb = SZ_16M / PMD_SIZE;
> +		else if (psize == MMU_PAGE_16G)
> +			nb = SZ_16G / PUD_SIZE;
> +		else
> +			nb = 1;

Although that might be a safe default, it might carry consequences down the road?
It might not, but if we reach that, something went wrong, so I would put a
WARN_ON_ONCE at least.

> --- a/arch/powerpc/mm/book3s64/hugetlbpage.c
> +++ b/arch/powerpc/mm/book3s64/hugetlbpage.c
> @@ -53,6 +53,16 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
>  		/* If PTE permissions don't match, take page fault */
>  		if (unlikely(!check_pte_access(access, old_pte)))
>  			return 1;
> +		/*
> +		 * If hash-4k, hugepages use seeral contiguous PxD entries
> +		 * so bail out and let mm make the page young or dirty
> +		 */
> +		if (IS_ENABLED(CONFIG_PPC_4K_PAGES)) {
> +			if (!(old_pte & _PAGE_ACCESSED))
> +				return 1;
> +			if ((access & _PAGE_WRITE) && !(old_pte & _PAGE_DIRTY))
> +				return 1;
> +		}

You mentioned that we need to bail out otherwise only the first PxD would be
updated.
In the comment you say that mm will take care of making the page young
or dirty.
Does this mean that the PxDs underneath will not have its bits updated?
 

-- 
Oscar Salvador
SUSE Labs

