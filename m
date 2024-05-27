Return-Path: <linux-kernel+bounces-190471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E40648CFEB7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F2FA1F22424
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6697B13A268;
	Mon, 27 May 2024 11:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1v9HSqmM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xlQOYgcr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1v9HSqmM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xlQOYgcr"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2938250263
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 11:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716808766; cv=none; b=HsRIV+/tijaPF5PunZHD9RFvPD0eQMERNS/4/hip+Hzs6Z4maAS6J/3BjACzBY/b+y3yNkBBPnqql4JsFts7Lg5rIxlV/6UpyFLlSL6E1cfLeDBcClYfOfsr9FuIW6GS5PCRXeW6cmvw1X4d+nkThtSG3RLlsh8c+sE0bFs+7cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716808766; c=relaxed/simple;
	bh=90bj6Ua089uwsGGMm3buoMjeF2Udw7a4TF62hhKO2Kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kT6RNZldwnAfTHyMHrgAdy49dSKkFCIGsSypY2SvejRohl3OisXNKrFCP0v1lYzN3yn5V/7XrT74qfxT00OnOaNE4bKHdxP8Zn+27X8a9S3iJYwMDKsG/aA7UGmuTvvIHC+lPLm4RSaJHxsKf2sCB7L7PITRjBdCmRSfy2ieuSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1v9HSqmM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xlQOYgcr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1v9HSqmM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xlQOYgcr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6711B1FCF9;
	Mon, 27 May 2024 11:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716808762; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Bi7Ql1X3s4Dacbspx0O9yRaUH+sqke7d9JnW3emmk4=;
	b=1v9HSqmM3ByGTDpUJcOlBE7lZwtRH36akLa3r92ozdA0Vig4wwX77SMggBICDlvZtiLWgR
	B8dzgwKBbCvIkiUrm0pdDG75+gyFW9El6tBG2pV3ODs/5dr+uE9sfV3JgNyMpuoEDap//n
	RAFkcpV7txMFEaS2dFHuPjxdeukGqOU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716808762;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Bi7Ql1X3s4Dacbspx0O9yRaUH+sqke7d9JnW3emmk4=;
	b=xlQOYgcrsgLz/gT/b41UXdxr3G8IJM2z3u2ptnaoTmir+HwvA8vbdcYm2iRO2RtmV6nnwz
	lsjfsRa3+2HSBIDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1v9HSqmM;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xlQOYgcr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716808762; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Bi7Ql1X3s4Dacbspx0O9yRaUH+sqke7d9JnW3emmk4=;
	b=1v9HSqmM3ByGTDpUJcOlBE7lZwtRH36akLa3r92ozdA0Vig4wwX77SMggBICDlvZtiLWgR
	B8dzgwKBbCvIkiUrm0pdDG75+gyFW9El6tBG2pV3ODs/5dr+uE9sfV3JgNyMpuoEDap//n
	RAFkcpV7txMFEaS2dFHuPjxdeukGqOU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716808762;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Bi7Ql1X3s4Dacbspx0O9yRaUH+sqke7d9JnW3emmk4=;
	b=xlQOYgcrsgLz/gT/b41UXdxr3G8IJM2z3u2ptnaoTmir+HwvA8vbdcYm2iRO2RtmV6nnwz
	lsjfsRa3+2HSBIDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CDAD713A6B;
	Mon, 27 May 2024 11:19:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4gE/LzlsVGYmDwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 27 May 2024 11:19:21 +0000
Date: Mon, 27 May 2024 13:19:12 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v3 03/16] mm: Provide mm_struct and address to
 huge_ptep_get()
Message-ID: <ZlRsMCvVo9tSEFQV@localhost.localdomain>
References: <cover.1716714720.git.christophe.leroy@csgroup.eu>
 <fbba60d762faad40ebb959bf9517c5c22301f69e.1716714720.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbba60d762faad40ebb959bf9517c5c22301f69e.1716714720.git.christophe.leroy@csgroup.eu>
X-Spam-Level: 
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linux-foundation.org,nvidia.com,redhat.com,ellerman.id.au,gmail.com,vger.kernel.org,kvack.org,lists.ozlabs.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 6711B1FCF9
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -6.51

On Sun, May 26, 2024 at 11:22:23AM +0200, Christophe Leroy wrote:
> On powerpc 8xx huge_ptep_get() will need to know whether the given
> ptep is a PTE entry or a PMD entry. This cannot be known with the
> PMD entry itself because there is no easy way to know it from the
> content of the entry.
> 
> So huge_ptep_get() will need to know either the size of the page
> or get the pmd.
> 
> In order to be consistent with huge_ptep_get_and_clear(), give
> mm and address to huge_ptep_get().
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
> v2: Add missing changes in arch implementations
> v3: Fixed a comment in ARM and missing changes in S390
> ---
>  arch/arm/include/asm/hugetlb-3level.h |  4 +--
>  arch/arm64/include/asm/hugetlb.h      |  2 +-
>  arch/arm64/mm/hugetlbpage.c           |  2 +-
>  arch/riscv/include/asm/hugetlb.h      |  2 +-
>  arch/riscv/mm/hugetlbpage.c           |  2 +-
>  arch/s390/include/asm/hugetlb.h       |  4 +--
>  arch/s390/mm/hugetlbpage.c            |  4 +--

I was wondering whether we could do something similar for what we did in
patch#1, so we do not touch architectures code.

  
> diff --git a/mm/gup.c b/mm/gup.c
> index 1611e73b1121..86b5105b82a1 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2812,7 +2812,7 @@ static int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
>  	if (pte_end < end)
>  		end = pte_end;
>  
> -	pte = huge_ptep_get(ptep);
> +	pte = huge_ptep_get(NULL, addr, ptep);

I know that after this series all this code is gone, but I was not sure
about the behaviour between this patch and the last one.

It made me nervous, until I realized that this code is only used
on CONFIG_ARCH_HAS_HUGEPD, which should not be the case anymore for 8xx after
patch#8, and since 8xx is the only one that will use the mm parameter from
huge_ptep_get, we are all good.



-- 
Oscar Salvador
SUSE Labs

