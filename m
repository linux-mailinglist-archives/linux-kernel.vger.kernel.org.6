Return-Path: <linux-kernel+bounces-183524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 065098C9A32
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 11:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A3B51F212EE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 09:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864251CD02;
	Mon, 20 May 2024 09:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SQ/+LTtN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QC8SRNpp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SQ/+LTtN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QC8SRNpp"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1E51C6A3
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 09:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716196496; cv=none; b=jtGyt7SPRw2PEDHg7w1vhtX/bMVRoFPwu2ugpynYFi5+MWBANBwl429UVdgjipj7FErk2EFFa5kq//RVmSPBFYtJFQ18emer6oQLzECTjwnmNTBrIkAAPu72FTgRzGxZcgOWwOjWsLdXtvB13yugINxqhLNXFTj31TmWD4uf9Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716196496; c=relaxed/simple;
	bh=LVBctxLzOPar47r1X+xyUCWooEprhK/vcDKfEVAVmcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=StIXEALlUg6A2oatGLF9CVYO/OkyLL0FOwFAts7oAqwPS4X2HJWjBWgjloSUZHYEuRPLtAiQzJbVLx4J+usdoAjzbUo1i/gYyq5QNv1aR3Col3Y8XIYZWsXGWDOf8ZcJ38sM9nvuW4h7gr9qsvbgomEP+n+zq0K+M7YOSjZnYCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SQ/+LTtN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QC8SRNpp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SQ/+LTtN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QC8SRNpp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1D19C2230F;
	Mon, 20 May 2024 09:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716196493; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DQpaWqEk14kmnZcRhdQPeYIN4UAv14SG3VVppGhfDQw=;
	b=SQ/+LTtNmqQ5lsOk1oA9qLfIIOqAFGFL5m4YmwHs8Is7y9FKQNJjmip74l+Uwc9gzozVUg
	hzCz6cM5ClUd/phVVLgFDDCk/Kfg96Hc+VF/LRatpnCuQSvX6wyl1yY3fIim5HyPYfktSg
	ZV1ZlLdrh0DVbh9jVSxoeUKLRsrsQso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716196493;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DQpaWqEk14kmnZcRhdQPeYIN4UAv14SG3VVppGhfDQw=;
	b=QC8SRNppEITCa/rAX9pRgj9rB/ERaebOnt5nW39BmxGgevybxtNyCzt9dMQXYCSQARYQkq
	nU2/g80JI8Uw2LBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716196493; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DQpaWqEk14kmnZcRhdQPeYIN4UAv14SG3VVppGhfDQw=;
	b=SQ/+LTtNmqQ5lsOk1oA9qLfIIOqAFGFL5m4YmwHs8Is7y9FKQNJjmip74l+Uwc9gzozVUg
	hzCz6cM5ClUd/phVVLgFDDCk/Kfg96Hc+VF/LRatpnCuQSvX6wyl1yY3fIim5HyPYfktSg
	ZV1ZlLdrh0DVbh9jVSxoeUKLRsrsQso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716196493;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DQpaWqEk14kmnZcRhdQPeYIN4UAv14SG3VVppGhfDQw=;
	b=QC8SRNppEITCa/rAX9pRgj9rB/ERaebOnt5nW39BmxGgevybxtNyCzt9dMQXYCSQARYQkq
	nU2/g80JI8Uw2LBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8475713A6B;
	Mon, 20 May 2024 09:14:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id C18sHYwUS2ZSYQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 20 May 2024 09:14:52 +0000
Date: Mon, 20 May 2024 11:14:51 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v2 06/20] powerpc/8xx: Fix size given to
 set_huge_pte_at()
Message-ID: <ZksUiwNaKx2n1fJO@localhost.localdomain>
References: <cover.1715971869.git.christophe.leroy@csgroup.eu>
 <04f4e737608ea0b177b88057db138fbf0d6ab138.1715971869.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04f4e737608ea0b177b88057db138fbf0d6ab138.1715971869.git.christophe.leroy@csgroup.eu>
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,nvidia.com,redhat.com,ellerman.id.au,gmail.com,vger.kernel.org,kvack.org,lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,csgroup.eu:email]

On Fri, May 17, 2024 at 09:00:00PM +0200, Christophe Leroy wrote:
> set_huge_pte_at() expects the real page size, not the psize which is

"expects the size of the huge page" sounds bettter? 

> the index of the page definition in table mmu_psize_defs[]
> 
> Fixes: 935d4f0c6dc8 ("mm: hugetlb: add huge page size param to set_huge_pte_at()")
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

AFAICS, this fixup is not related to the series, right? (yes, you will
the parameter later)
I would have it at the very beginning of the series.


> ---
>  arch/powerpc/mm/nohash/8xx.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/mm/nohash/8xx.c b/arch/powerpc/mm/nohash/8xx.c
> index 43d4842bb1c7..d93433e26ded 100644
> --- a/arch/powerpc/mm/nohash/8xx.c
> +++ b/arch/powerpc/mm/nohash/8xx.c
> @@ -94,7 +94,8 @@ static int __ref __early_map_kernel_hugepage(unsigned long va, phys_addr_t pa,
>  		return -EINVAL;
>  
>  	set_huge_pte_at(&init_mm, va, ptep,
> -			pte_mkhuge(pfn_pte(pa >> PAGE_SHIFT, prot)), psize);
> +			pte_mkhuge(pfn_pte(pa >> PAGE_SHIFT, prot)),
> +			1UL << mmu_psize_to_shift(psize));
>  
>  	return 0;
>  }
> -- 
> 2.44.0
> 

-- 
Oscar Salvador
SUSE Labs

