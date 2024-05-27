Return-Path: <linux-kernel+bounces-190031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 721C38CF892
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 06:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0264F1F21F79
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 04:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C23DC2C8;
	Mon, 27 May 2024 04:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HoebKqr/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MiO3Ekd3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HoebKqr/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MiO3Ekd3"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAEA184E
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 04:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716785797; cv=none; b=dPDUthHJ5p7UtNhW/3/RQcY+WWpn8D8UJZrT7ESLoxDqRAdsAO/D4PFObfMlGzMldJNAiJk5uqKD8CA3jZkY3TUeXPYBFq1IwmOSZaUMamUdzxoq6GkY6pWzAs9Ui0i2ofo9oU78YFcc6ghwtcjTYSU28Zawsb9/wjsh9Djxjy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716785797; c=relaxed/simple;
	bh=u0BFX3WzfF3eNC8msFtDptgSqPVeS3JoT1DDuV+cmtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SvKA7OY/f2IX2BjvMSLik+DRqYc1jH5mjv5cT7XyM++znDfGfyAteJs9QbS+y0QD2qHfnhsgpzQMEZRN7RNJ6uLb7QtYMQ1gEIL9hc7P4ynE0mHOlbh7uniTQlBi5W2yoJk+0HQFdQ4rpH2MgQ33yWe8jI6/PpPKaFyDg7+Y6Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HoebKqr/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MiO3Ekd3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HoebKqr/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MiO3Ekd3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9492D21C20;
	Mon, 27 May 2024 04:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716785794; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qpjZvuybnZOPV0Sin/gwYjM8aUTQBvD2n8uPNDZdxaE=;
	b=HoebKqr/EdRAPAXhMZWVhgMUSAbqBg9tjRfij74soQ5TGD4UfC62oEsXyBhZCpUNdKC26z
	+UYJzf2K/6u7oijDULZJ8A7Zx/yY2HXWyxJxvfxyr6gCfKq4oKzsyJMHSk29L/LeRylJFb
	xonCLLZerZd6d8jP8iVl7sWUK4ATl24=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716785794;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qpjZvuybnZOPV0Sin/gwYjM8aUTQBvD2n8uPNDZdxaE=;
	b=MiO3Ekd3jJ1FR62PkwVmq3cV+yckpwZ6SOoI5/42HWPpmfD0rq+t7W2UaxMoGq6MPv4Iit
	AbM8aVYr4E2BBCCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="HoebKqr/";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=MiO3Ekd3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716785794; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qpjZvuybnZOPV0Sin/gwYjM8aUTQBvD2n8uPNDZdxaE=;
	b=HoebKqr/EdRAPAXhMZWVhgMUSAbqBg9tjRfij74soQ5TGD4UfC62oEsXyBhZCpUNdKC26z
	+UYJzf2K/6u7oijDULZJ8A7Zx/yY2HXWyxJxvfxyr6gCfKq4oKzsyJMHSk29L/LeRylJFb
	xonCLLZerZd6d8jP8iVl7sWUK4ATl24=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716785794;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qpjZvuybnZOPV0Sin/gwYjM8aUTQBvD2n8uPNDZdxaE=;
	b=MiO3Ekd3jJ1FR62PkwVmq3cV+yckpwZ6SOoI5/42HWPpmfD0rq+t7W2UaxMoGq6MPv4Iit
	AbM8aVYr4E2BBCCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1088813A6B;
	Mon, 27 May 2024 04:56:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CFN5AYISVGY1fgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 27 May 2024 04:56:34 +0000
Date: Mon, 27 May 2024 06:56:28 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v3 07/16] powerpc/8xx: Fix size given to
 set_huge_pte_at()
Message-ID: <ZlQSfOh0pQ2kE5D1@localhost.localdomain>
References: <cover.1716714720.git.christophe.leroy@csgroup.eu>
 <c459a02141c4e24b204ef76c489a63ce67c9dbbb.1716714720.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c459a02141c4e24b204ef76c489a63ce67c9dbbb.1716714720.git.christophe.leroy@csgroup.eu>
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 9492D21C20
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.986];
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
	DKIM_TRACE(0.00)[suse.de:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

On Sun, May 26, 2024 at 11:22:27AM +0200, Christophe Leroy wrote:
> set_huge_pte_at() expects the size of the hugepage as an int, not the
> psize which is the index of the page definition in table mmu_psize_defs[]
> 
> Fixes: 935d4f0c6dc8 ("mm: hugetlb: add huge page size param to set_huge_pte_at()")
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

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

