Return-Path: <linux-kernel+bounces-174251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9F98C0C1F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 09:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1193D1F22DDD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 07:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F242A149C52;
	Thu,  9 May 2024 07:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="q5Hcz/HP";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="q5Hcz/HP"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AF414830B
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 07:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715240945; cv=none; b=CuheiZQJUU7KYvGGeooCTJPHGBFAJCXXdE9usJee74anVT+T2llGGXqvDQ4PUmhWs5oQIl6jRI0i/P+MjAbOi1EagBES0W89X8PcqrpNlosB5s8kqBPk4hNGaRO9JbDjQ08kH1SyYFoTVcRt1n5JG7C6yNcOaVsCjAgPGEt1iaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715240945; c=relaxed/simple;
	bh=l8MvONk0+ApKLplnhCqModGKWNpgifqCliqom2TOBsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EylKXe/63x98aFkgE/axGwoUZXScN/q1eDqoPR5rbaW/5cHtFwyOVV5sjKys7NWFhZunm+puKNFMpVEBakjZlpGzS2I8yTHQ/t5Kj5tZ1FHboksbuucXRpF2DYd0dTlgkae+yNV39xBMrzGgVCThu8tlQfqysphM5FPnPOUWBo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=q5Hcz/HP; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=q5Hcz/HP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A28A05FA04;
	Thu,  9 May 2024 07:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715240941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iwS77UEIDIui68vRbwx9BsX+4DYZiA+lBLJ3muE9lSE=;
	b=q5Hcz/HPTPEbZVRbLf25WP16dpAneCdFIqp+3UOpQl6GzhmOzloD9a3aQUxBHiH2WhHooD
	L1W73nBPDGlG2ANr1SWD8mTmk8O7cl6iEcn6Omyr82nKEeSKQJ1NWRxxDhXOjXF+VFPa/a
	tAMw5eAnXNzHyr8m+dcBWyhhSX74rW8=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715240941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iwS77UEIDIui68vRbwx9BsX+4DYZiA+lBLJ3muE9lSE=;
	b=q5Hcz/HPTPEbZVRbLf25WP16dpAneCdFIqp+3UOpQl6GzhmOzloD9a3aQUxBHiH2WhHooD
	L1W73nBPDGlG2ANr1SWD8mTmk8O7cl6iEcn6Omyr82nKEeSKQJ1NWRxxDhXOjXF+VFPa/a
	tAMw5eAnXNzHyr8m+dcBWyhhSX74rW8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 76E4D13941;
	Thu,  9 May 2024 07:49:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0y4yG+1/PGb6EgAAD6G6ig
	(envelope-from <mhocko@suse.com>); Thu, 09 May 2024 07:49:01 +0000
Date: Thu, 9 May 2024 09:48:56 +0200
From: Michal Hocko <mhocko@suse.com>
To: hailong.liu@oppo.com
Cc: akpm@linux-foundation.org, urezki@gmail.com, hch@infradead.org,
	lstoakes@gmail.com, 21cnbao@gmail.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, xiang@kernel.org, chao@kernel.org,
	Oven <liyangouwen1@oppo.com>
Subject: Re: [RFC PATCH] mm/vmalloc: fix vmalloc which may return null if
 called with __GFP_NOFAIL
Message-ID: <Zjx_6F3Fti_EBD_e@tiehlicka>
References: <20240508125808.28882-1-hailong.liu@oppo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508125808.28882-1-hailong.liu@oppo.com>
X-Spam-Flag: NO
X-Spam-Score: -3.40
X-Spam-Level: 
X-Spamd-Result: default: False [-3.40 / 50.00];
	BAYES_HAM(-2.60)[98.21%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,infradead.org,kvack.org,vger.kernel.org,kernel.org,oppo.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]

On Wed 08-05-24 20:58:08, hailong.liu@oppo.com wrote:
> From: "Hailong.Liu" <hailong.liu@oppo.com>
> 
> Commit a421ef303008 ("mm: allow !GFP_KERNEL allocations for kvmalloc")
> includes support for __GFP_NOFAIL, but it presents a conflict with
> commit dd544141b9eb ("vmalloc: back off when the current task is
> OOM-killed"). A possible scenario is as belows:
> 
> process-a
> kvcalloc(n, m, GFP_KERNEL | __GFP_NOFAIL)
>     __vmalloc_node_range()
> 	__vmalloc_area_node()
> 	    vm_area_alloc_pages()
>             --> oom-killer send SIGKILL to process-a
>             if (fatal_signal_pending(current)) break;
> --> return NULL;
> 
> to fix this, do not check fatal_signal_pending() in vm_area_alloc_pages()
> if __GFP_NOFAIL set.
> 
> Reported-by: Oven <liyangouwen1@oppo.com>
> Signed-off-by: Hailong.Liu <hailong.liu@oppo.com>
> ---
>  mm/vmalloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 6641be0ca80b..2f359d08bf8d 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3560,7 +3560,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
> 
>  	/* High-order pages or fallback path if "bulk" fails. */
>  	while (nr_allocated < nr_pages) {
> -		if (fatal_signal_pending(current))
> +		if (!(gfp & __GFP_NOFAIL) && fatal_signal_pending(current))

Use nofail instead of gfp & __GFP_NOFAIL.

Other than that looks good to me. After that is fixed, please feel free
to add Acked-by: Michal Hocko <mhocko@suse.com>

I believe this should also have Fixes: 9376130c390a ("mm/vmalloc: add support for __GFP_NOFAIL")
-- 
Michal Hocko
SUSE Labs

