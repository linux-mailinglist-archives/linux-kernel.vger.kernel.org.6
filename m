Return-Path: <linux-kernel+bounces-189283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F42A8CEDEB
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 06:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CD94281A07
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 04:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF51B5664;
	Sat, 25 May 2024 04:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Zt1MCyQ5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RZuyb9y7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Zt1MCyQ5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RZuyb9y7"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69616AD35
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 04:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716612896; cv=none; b=qWEEXVqbswJlihC/pHEu8N0BqPHmJOgMj51j/oAHQ5VxLC7MCqpwCCxmVKo3yQ4tqFVYsxRMeDEHI+d6RthvcSfIC6BLsij2h//A+oivdWnMGtvQTgmnJ/pNhlIz50T2etWbY/3iQo56wDqeJGCZuTC/P3e4lMSXCirzgMHxUbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716612896; c=relaxed/simple;
	bh=N26xMOX50MmHiSEBKDTFyzq26dgmnaZ2RwmwN2hl1W0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UcEPIAj/JkRSoUzPNTFH0GXBRxNbNlza83erqLWZxS+RjOZ0JZ2R4VhhMFWNWbtrNL2pHOWZ0Ec8R/GQogb27+NaKq2w+tQhwWHLBmDhSuI6rVfc4/qmfsicGS+zOR9Glw4EhiqQ4FApjZCohivLFqLaCT54MzPD9FX82EKYimI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Zt1MCyQ5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RZuyb9y7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Zt1MCyQ5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RZuyb9y7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2C22D340C0;
	Sat, 25 May 2024 04:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716612892; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=btAdsS+hCf3mFF4waPo4jB02fuvhLt2lHJ3C41E1r4k=;
	b=Zt1MCyQ5caV8HNnwgF8lwsk22p2c7ocPBHhIpu1+r0u7/0j2uJG4XFPYMhC3BDXIzoiWRT
	EXWHelIIA5hoIhDl5nnnwoEV1T0aoCrayngeE7kDsvPD+4ot7UzfJXl9of72KRvk0Z0ryr
	uTn3RiqzjohITJ5ijXqL2GnwQWeaaYc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716612892;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=btAdsS+hCf3mFF4waPo4jB02fuvhLt2lHJ3C41E1r4k=;
	b=RZuyb9y704LokAfoEqSC095O5lJp5/RlnWrO/4ZNb7F2kOyCkNwXWXRqW1Cjr4UhBo0cbs
	8equLFiPPUMasiCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Zt1MCyQ5;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=RZuyb9y7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716612892; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=btAdsS+hCf3mFF4waPo4jB02fuvhLt2lHJ3C41E1r4k=;
	b=Zt1MCyQ5caV8HNnwgF8lwsk22p2c7ocPBHhIpu1+r0u7/0j2uJG4XFPYMhC3BDXIzoiWRT
	EXWHelIIA5hoIhDl5nnnwoEV1T0aoCrayngeE7kDsvPD+4ot7UzfJXl9of72KRvk0Z0ryr
	uTn3RiqzjohITJ5ijXqL2GnwQWeaaYc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716612892;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=btAdsS+hCf3mFF4waPo4jB02fuvhLt2lHJ3C41E1r4k=;
	b=RZuyb9y704LokAfoEqSC095O5lJp5/RlnWrO/4ZNb7F2kOyCkNwXWXRqW1Cjr4UhBo0cbs
	8equLFiPPUMasiCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9887D13A6B;
	Sat, 25 May 2024 04:54:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dPMWIhtvUWZnCwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Sat, 25 May 2024 04:54:51 +0000
Date: Sat, 25 May 2024 06:54:46 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v2 15/20] powerpc/85xx: Switch to 64 bits PGD
Message-ID: <ZlFvFk6QmyD-ieS5@localhost.localdomain>
References: <cover.1715971869.git.christophe.leroy@csgroup.eu>
 <a1d92dd7c390672c163ce0611600dde8cb0eaab4.1715971869.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1d92dd7c390672c163ce0611600dde8cb0eaab4.1715971869.git.christophe.leroy@csgroup.eu>
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 2C22D340C0
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,nvidia.com,redhat.com,ellerman.id.au,gmail.com,vger.kernel.org,kvack.org,lists.ozlabs.org];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim]

On Fri, May 17, 2024 at 09:00:09PM +0200, Christophe Leroy wrote:
> In order to allow leaf PMD entries, switch the PGD to 64 bits entries.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

I do not quite understand this change.
Are not powerE500 and power85xx two different things?
You are changing making it 64 for PPC_E500_64bits, but you are updating head_85xx.
Are they sharing this code?

Also, we would benefit from a slightly bigger changelog, explaining why
do we need this change in some more detail.

 
> diff --git a/arch/powerpc/include/asm/pgtable-types.h b/arch/powerpc/include/asm/pgtable-types.h
> index 082c85cc09b1..db965d98e0ae 100644
> --- a/arch/powerpc/include/asm/pgtable-types.h
> +++ b/arch/powerpc/include/asm/pgtable-types.h
> @@ -49,7 +49,11 @@ static inline unsigned long pud_val(pud_t x)
>  #endif /* CONFIG_PPC64 */
>  
>  /* PGD level */
> +#if defined(CONFIG_PPC_E500) && defined(CONFIG_PTE_64BIT)
> +typedef struct { unsigned long long pgd; } pgd_t;
> +#else
>  typedef struct { unsigned long pgd; } pgd_t;
> +#endif
>  #define __pgd(x)	((pgd_t) { (x) })
>  static inline unsigned long pgd_val(pgd_t x)
>  {
> diff --git a/arch/powerpc/kernel/head_85xx.S b/arch/powerpc/kernel/head_85xx.S
> index 39724ff5ae1f..a305244afc9f 100644
> --- a/arch/powerpc/kernel/head_85xx.S
> +++ b/arch/powerpc/kernel/head_85xx.S
> @@ -307,8 +307,9 @@ set_ivor:
>  #ifdef CONFIG_PTE_64BIT
>  #ifdef CONFIG_HUGETLB_PAGE
>  #define FIND_PTE	\
> -	rlwinm	r12, r10, 13, 19, 29;	/* Compute pgdir/pmd offset */	\
> -	lwzx	r11, r12, r11;		/* Get pgd/pmd entry */		\
> +	rlwinm	r12, r10, 14, 18, 28;	/* Compute pgdir/pmd offset */	\
> +	add	r12, r11, r12;

You add the offset to pgdir? 

> +	lwz	r11, 4(r12);		/* Get pgd/pmd entry */		\

What is i offset 4?


-- 
Oscar Salvador
SUSE Labs

