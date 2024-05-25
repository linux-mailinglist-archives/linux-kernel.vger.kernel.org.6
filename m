Return-Path: <linux-kernel+bounces-189272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEF98CEDCB
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 06:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A2A91F219E7
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 04:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBD23C28;
	Sat, 25 May 2024 04:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="A5CjUT33";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+oVJuGwR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VnjQaARY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1sJLPbvA"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A721AE54D
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 04:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716610384; cv=none; b=Z9SxYgJwqbwledRiVinLq/2CPGM5nY9WE7VjqzhI5XRXyJvm9rnAKspvXJp3W0jnwmt0M/xhuulwKFXYsjRHBD+0dZ9lpB2FlWq4uyKKQKyVxQgg3e5ZV5+LHVIBxERpYOFhA1eWY/luzs2s3J4BhA4hFCaaM46mfpbOEPNetQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716610384; c=relaxed/simple;
	bh=nyyaEc7g8Qp0Wa/CW/xqMXHJA2h2HVAeep66uoUQKbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LSE3ghBqi386K1UaVXFYvV9zVcS4qj0CQb+cz7X32321qPYatEnZ2cX3EH4uGP2clyez5CQTPa/4+HodVyU9XkRGjH7y8sLNaZAgQYHWSeZbpkFp0A+dJdk4LLpvCTeEVhZdwmbdVRDtHxXVlEj7fqCO3iQrvwhvPRpue1kS9xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=A5CjUT33; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+oVJuGwR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VnjQaARY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1sJLPbvA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CDD123408E;
	Sat, 25 May 2024 04:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716610381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rdi7hlA9h9Co0a/ynH1F9A1yZigACenw5JizREvilf0=;
	b=A5CjUT33XB5GQRJTtT+Z3EX+niUwuq2kjx/fWhi5RLf3FxMYgrZRmFWdDQ3JX6mpKTtfWi
	ZSIw5bxOk18Eg/NnvYFgXO+etgxf8rpPkOXzjf3quPBP9s3d9badkvFv5XdowyXzhRByHF
	SUsmfrlRQ1UoaocDyoX5FWs59Y2owGY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716610381;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rdi7hlA9h9Co0a/ynH1F9A1yZigACenw5JizREvilf0=;
	b=+oVJuGwRSjw4vmjCEjdO+J9kmtVZoNZbsUKPGIGeTGGpKEHFDhq+c+GRTjxCtc436P4Nl/
	96up70AHOW2XHwBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716610380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rdi7hlA9h9Co0a/ynH1F9A1yZigACenw5JizREvilf0=;
	b=VnjQaARYlkBAJNqfEFPaJryFW44XnmAe1VkotDNmZowF3WP6baaFzjCYyi7vbIoML10hH2
	3YUwnKBSHvjwK5tXJ2FyAs2nBgoClyxhxGDrLKqsyC0Y1tEmNLHISI29TjKMQYfe52luA5
	HUT6ClfHOQPd1rdCcaFSMdAWyRQWOeA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716610380;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rdi7hlA9h9Co0a/ynH1F9A1yZigACenw5JizREvilf0=;
	b=1sJLPbvAtnBRNsclzks5oIwJlKVIulF0vwObA4tlla2lUfaMiP/hpnM19gHTTREWiNbtV4
	2HwvEB8foC1AZLBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F1DB13A1E;
	Sat, 25 May 2024 04:13:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id o9+tEExlUWZ8BQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Sat, 25 May 2024 04:13:00 +0000
Date: Sat, 25 May 2024 06:12:54 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v2 10/20] powerpc/mm: Fix __find_linux_pte() on 32
 bits with PMD leaf entries
Message-ID: <ZlFlRr26AvS6n7p8@localhost.localdomain>
References: <cover.1715971869.git.christophe.leroy@csgroup.eu>
 <41bf05806501c0091a7d52e118b187416d24a76f.1715971869.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41bf05806501c0091a7d52e118b187416d24a76f.1715971869.git.christophe.leroy@csgroup.eu>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,nvidia.com,redhat.com,ellerman.id.au,gmail.com,vger.kernel.org,kvack.org,lists.ozlabs.org];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Fri, May 17, 2024 at 09:00:04PM +0200, Christophe Leroy wrote:
> Building on 32 bits with pmd_leaf() not returning always false leads
> to the following error:

I am curious though.
pmd_leaf is only defined in include/linux/pgtable.h for 32bits, and is hardcoded
to false.
I do not see where we change it in previous patches, so is this artificial?

> 
>   CC      arch/powerpc/mm/pgtable.o
> arch/powerpc/mm/pgtable.c: In function '__find_linux_pte':
> arch/powerpc/mm/pgtable.c:506:1: error: function may return address of local variable [-Werror=return-local-addr]
>   506 | }
>       | ^
> arch/powerpc/mm/pgtable.c:394:15: note: declared here
>   394 |         pud_t pud, *pudp;
>       |               ^~~
> arch/powerpc/mm/pgtable.c:394:15: note: declared here
> 
> This is due to pmd_offset() being a no-op in that case.

This is because 32bits powerpc include pgtable-nopmd.h?

> So rework it for powerpc/32 so that pXd_offset() are used on real
> pointers and not on on-stack copies.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/mm/pgtable.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
> index 59f0d7706d2f..51ee508eeb5b 100644
> --- a/arch/powerpc/mm/pgtable.c
> +++ b/arch/powerpc/mm/pgtable.c
> @@ -390,8 +390,12 @@ pte_t *__find_linux_pte(pgd_t *pgdir, unsigned long ea,
>  			bool *is_thp, unsigned *hpage_shift)
>  {
>  	pgd_t *pgdp;
> -	p4d_t p4d, *p4dp;
> -	pud_t pud, *pudp;
> +	p4d_t *p4dp;
> +	pud_t *pudp;
> +#ifdef CONFIG_PPC64
> +	p4d_t p4d;
> +	pud_t pud;
> +#endif
>  	pmd_t pmd, *pmdp;
>  	pte_t *ret_pte;
>  	hugepd_t *hpdp = NULL;
> @@ -412,6 +416,7 @@ pte_t *__find_linux_pte(pgd_t *pgdir, unsigned long ea,
>  	 */
>  	pgdp = pgdir + pgd_index(ea);
>  	p4dp = p4d_offset(pgdp, ea);
> +#ifdef CONFIG_PPC64
>  	p4d  = READ_ONCE(*p4dp);
>  	pdshift = P4D_SHIFT;
>  
> @@ -452,6 +457,11 @@ pte_t *__find_linux_pte(pgd_t *pgdir, unsigned long ea,
>  
>  	pdshift = PMD_SHIFT;
>  	pmdp = pmd_offset(&pud, ea);
> +#else
> +	p4dp = p4d_offset(pgdp, ea);
> +	pudp = pud_offset(p4dp, ea);
> +	pmdp = pmd_offset(pudp, ea);

I would drop a comment on top explaining that these are no-op for 32bits,
otherwise it might not be obvious to people as why this distiction between 64 and
32bits.

Other than that looks good to me

 

-- 
Oscar Salvador
SUSE Labs

