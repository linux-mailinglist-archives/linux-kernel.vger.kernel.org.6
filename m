Return-Path: <linux-kernel+bounces-179148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 172888C5C5C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 22:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBB142811FF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 20:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69371E491;
	Tue, 14 May 2024 20:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZpObK2ca";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UVARiUEa";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZpObK2ca";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UVARiUEa"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDCB365
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 20:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715719059; cv=none; b=AafqLvL+nAu8JvSLQQuv+ZgVcR5AYHa02lj19c/2mTHffDuTCab6hRoAo4mjr+fZfFVTxkgXeQB4lBAsEzyC3kRbowWX49PzTY/xwsG38TlU2F0RH2pT8L9qQ9/jXjlpE2G2ICDDcgg9DU4txwdKYMjwPBG2MC2s7jb3vZQcDm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715719059; c=relaxed/simple;
	bh=qtYRKkRqUl2iLbllESnnPGMb7ZoOLam5WvQiWWaqvhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OB1UzCmpoS4+9Hs6i2Osnm4I7ax8qnZ7i0XAA+FgQcA79hOa0iK6+Ww/4oXwPhy66jwq2dKB+c+6yzhxGJ4+vNnBSuGPROCA9A0vjGdyMgkZXc4PmV3coqv/kwjnYCiFtZNZujVbLXkR8VsGYPTWgr5vwWFtu9YyQEyaKjN/0/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZpObK2ca; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UVARiUEa; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZpObK2ca; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UVARiUEa; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6E0E01FB48;
	Tue, 14 May 2024 20:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715719056; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VYsW9Vv80A6GLzgjCSYellhzJczA30skEMWWKeZBbJk=;
	b=ZpObK2cayBrGFB+P30B4ta0PrzL46RFr44vUY5OO1vAowzek8thfNxxeOGE4BRsC7fIwDq
	+7eTpVOAzgxb7RFh6pnv6Q8JBVIOkawpsPDcTa2ObSEicYd8rCm0YADkPKTN8xOT7XG4tp
	dPHkjGGM+KVPvwqMxmeWz35c4ilgZQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715719056;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VYsW9Vv80A6GLzgjCSYellhzJczA30skEMWWKeZBbJk=;
	b=UVARiUEao8bnM3tGOX6fumiBKcLPbudeKiBmMYfi0BLZlApPyZMjtuUZjjsrk5V1d0PyxV
	o55zuYS0CbLs8iBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZpObK2ca;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=UVARiUEa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715719056; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VYsW9Vv80A6GLzgjCSYellhzJczA30skEMWWKeZBbJk=;
	b=ZpObK2cayBrGFB+P30B4ta0PrzL46RFr44vUY5OO1vAowzek8thfNxxeOGE4BRsC7fIwDq
	+7eTpVOAzgxb7RFh6pnv6Q8JBVIOkawpsPDcTa2ObSEicYd8rCm0YADkPKTN8xOT7XG4tp
	dPHkjGGM+KVPvwqMxmeWz35c4ilgZQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715719056;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VYsW9Vv80A6GLzgjCSYellhzJczA30skEMWWKeZBbJk=;
	b=UVARiUEao8bnM3tGOX6fumiBKcLPbudeKiBmMYfi0BLZlApPyZMjtuUZjjsrk5V1d0PyxV
	o55zuYS0CbLs8iBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8341B1372E;
	Tue, 14 May 2024 20:37:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IqYEHY/LQ2aHIQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 14 May 2024 20:37:35 +0000
Date: Tue, 14 May 2024 22:37:30 +0200
From: Oscar Salvador <osalvador@suse.de>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	David Hildenbrand <david@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-riscv@lists.infradead.org,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Andrew Bresticker <abrestic@rivosinc.com>,
	Chethan Seshadri <Chethan.Seshadri@catalinasystems.io>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Santosh Mamila <santosh.mamila@catalinasystems.io>,
	Sivakumar Munnangi <siva.munnangi@catalinasystems.io>,
	Sunil V L <sunilvl@ventanamicro.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 3/8] riscv: mm: Refactor create_linear_mapping_range()
 for memory hot add
Message-ID: <ZkPLimx-TSkufhjK@localhost.localdomain>
References: <20240514140446.538622-1-bjorn@kernel.org>
 <20240514140446.538622-4-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240514140446.538622-4-bjorn@kernel.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[rivosinc.com,eecs.berkeley.edu,redhat.com,dabbelt.com,sifive.com,lists.infradead.org,catalinasystems.io,gmail.com,ventanamicro.com,vger.kernel.org,kvack.org,lists.linux-foundation.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,rivosinc.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 6E0E01FB48
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -6.51

On Tue, May 14, 2024 at 04:04:41PM +0200, Björn Töpel wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> Add a parameter to the direct map setup function, so it can be used in
> arch_add_memory() later.
> 
> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  arch/riscv/mm/init.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index c969427eab88..6f72b0b2b854 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -1227,7 +1227,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>  }
>  
>  static void __meminit create_linear_mapping_range(phys_addr_t start, phys_addr_t end,
> -						  uintptr_t fixed_map_size)
> +						  uintptr_t fixed_map_size, const pgprot_t *pgprot)
>  {
>  	phys_addr_t pa;
>  	uintptr_t va, map_size;
> @@ -1238,7 +1238,7 @@ static void __meminit create_linear_mapping_range(phys_addr_t start, phys_addr_t
>  					    best_map_size(pa, va, end - pa);
>  
>  		create_pgd_mapping(swapper_pg_dir, va, pa, map_size,
> -				   pgprot_from_va(va));
> +				   pgprot ? *pgprot : pgprot_from_va(va));
>  	}
>  }
>  
> @@ -1282,22 +1282,19 @@ static void __init create_linear_mapping_page_table(void)
>  		if (end >= __pa(PAGE_OFFSET) + memory_limit)
>  			end = __pa(PAGE_OFFSET) + memory_limit;
>  
> -		create_linear_mapping_range(start, end, 0);
> +		create_linear_mapping_range(start, end, 0, NULL);
>  	}
>  
>  #ifdef CONFIG_STRICT_KERNEL_RWX
> -	create_linear_mapping_range(ktext_start, ktext_start + ktext_size, 0);
> -	create_linear_mapping_range(krodata_start,
> -				    krodata_start + krodata_size, 0);
> +	create_linear_mapping_range(ktext_start, ktext_start + ktext_size, 0, NULL);
> +	create_linear_mapping_range(krodata_start, krodata_start + krodata_size, 0, NULL);
>  
>  	memblock_clear_nomap(ktext_start,  ktext_size);
>  	memblock_clear_nomap(krodata_start, krodata_size);
>  #endif
>  
>  #ifdef CONFIG_KFENCE
> -	create_linear_mapping_range(kfence_pool,
> -				    kfence_pool + KFENCE_POOL_SIZE,
> -				    PAGE_SIZE);
> +	create_linear_mapping_range(kfence_pool, kfence_pool + KFENCE_POOL_SIZE, PAGE_SIZE, NULL);
>  
>  	memblock_clear_nomap(kfence_pool, KFENCE_POOL_SIZE);
>  #endif
> -- 
> 2.40.1
> 

-- 
Oscar Salvador
SUSE Labs

