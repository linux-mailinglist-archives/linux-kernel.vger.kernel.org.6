Return-Path: <linux-kernel+bounces-276580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C3094958F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 18:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACC511F25EC0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C683C08A;
	Tue,  6 Aug 2024 16:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pQ3U1uJI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rOOxTuk9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pQ3U1uJI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rOOxTuk9"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F154A433D0;
	Tue,  6 Aug 2024 16:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722961724; cv=none; b=OL6+FdkjpdwpACQ6c6SnsyMk1E+jw9XKs6Hxt+MQ6O9uTCQLBAkzmsGfUpw94xTHGbEO/a3lc4ELN8IJDhZc9BPLf+uRDK9nK09/bidbU8ULm+WttVMiR1icTfZEBLE0aobDIR9zXlxljgfd9nrHEuQuAaDRyFJifZXOjYqPXRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722961724; c=relaxed/simple;
	bh=sk0E9pXsc7mEmF6o2V1Ax5YG6xdVk9sgAWanYbJpMcw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jGfOUoIks/a0WTjzHVh++cjyUPpULWlrG1BKDTmcV19Fo0lkdL6NNTvg0KG6dNqWf2jmtR21Z+F35gvVSLjU/j+6gURKfnYBG8Rr2AqMCpBG93cmQYJBW+Pl3m31dUeVTTtfjnmKGc/N6GbtE62Mm8WIHL1boGvGVEoAoVWXpVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pQ3U1uJI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rOOxTuk9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pQ3U1uJI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rOOxTuk9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 04EB71FDD5;
	Tue,  6 Aug 2024 16:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722961720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gmnc4h4upoiNRP7fRPVs2uQznB4Gy/iumz+fhcWuJ8Q=;
	b=pQ3U1uJICLuH3BgUlqVAY1gk5l2Q2Hf33qy3b8BR2xNddQsuWHDDVMN+D0Dw4hUeAtBSel
	OIpDbPSwePPYxVSx88mSueRSbkYzhCKF5f8xE2nnpfPFXTB8v2+LzGKkR+LKxX0254alVc
	C656Nok0ct5k79Ncyve432+QRzP8izI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722961720;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gmnc4h4upoiNRP7fRPVs2uQznB4Gy/iumz+fhcWuJ8Q=;
	b=rOOxTuk9/K+eUSMRkK+nSvN4M14H5ru4awZ3o9nRsZ+kwL9ILPG42Cx50CegQePH3ptcWE
	/rzBlQBWzKCcpqBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pQ3U1uJI;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rOOxTuk9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722961720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gmnc4h4upoiNRP7fRPVs2uQznB4Gy/iumz+fhcWuJ8Q=;
	b=pQ3U1uJICLuH3BgUlqVAY1gk5l2Q2Hf33qy3b8BR2xNddQsuWHDDVMN+D0Dw4hUeAtBSel
	OIpDbPSwePPYxVSx88mSueRSbkYzhCKF5f8xE2nnpfPFXTB8v2+LzGKkR+LKxX0254alVc
	C656Nok0ct5k79Ncyve432+QRzP8izI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722961720;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gmnc4h4upoiNRP7fRPVs2uQznB4Gy/iumz+fhcWuJ8Q=;
	b=rOOxTuk9/K+eUSMRkK+nSvN4M14H5ru4awZ3o9nRsZ+kwL9ILPG42Cx50CegQePH3ptcWE
	/rzBlQBWzKCcpqBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B8E3113770;
	Tue,  6 Aug 2024 16:28:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cZLwKzdPsmaPfgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 06 Aug 2024 16:28:39 +0000
Date: Tue, 06 Aug 2024 18:29:17 +0200
Message-ID: <87cyml8vj6.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Abhishek Tamboli <abhishektamboli9@gmail.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	oswald.buddenhagen@gmx.de,
	skhan@linuxfoundation.org,
	rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: emu10k1: Fix coding style issues and warnings
In-Reply-To: <20240805155206.463035-1-abhishektamboli9@gmail.com>
References: <20240805155206.463035-1-abhishektamboli9@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	FREEMAIL_CC(0.00)[perex.cz,suse.com,gmx.de,linuxfoundation.org,gmail.com,lists.linuxfoundation.org,vger.kernel.org];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -5.51
X-Rspamd-Queue-Id: 04EB71FDD5

On Mon, 05 Aug 2024 17:52:06 +0200,
Abhishek Tamboli wrote:
> 
> Fix coding style errors and warnings in sound/pci/emu10k1/memory.c
> reported by checkpatch.pl. Changes includes:
> 
> - Add spaces after commas in macro definitions.
> - Insert blank lines after variable declarations.
> - Consistent spacing around operators.
> - Remove trailing whitespace.
> - Move EXPORT_SYMBOL declarations to immediately follow their
>   respective functions.
> - Correct spacing in conditional statements and type casts.
> 
> Fix the following errors and warnings:
> 
> ERROR: space required after that ',' (ctx:VxV)
> +#define __set_ptb_entry(emu,page,addr) \
> 
> ERROR: space required after that ',' (ctx:VxV)
> +#define __set_ptb_entry(emu,page,addr) \
> 
> ERROR: space required after that ',' (ctx:VxV)
> +#define set_ptb_entry(emu,page,addr)	__set_ptb_entry(emu,page,addr)
> 
> ERROR: space required after that ',' (ctx:VxV)
> +#define set_ptb_entry(emu,page,addr)	__set_ptb_entry(emu,page,addr)
> 
> ERROR: space required after that ',' (ctx:VxV)
> +#define set_ptb_entry(emu,page,addr)	__set_ptb_entry(emu,page,addr)
> 
> ERROR: space required after that ',' (ctx:VxV)
> +#define set_ptb_entry(emu,page,addr)	__set_ptb_entry(emu,page,addr)
> 
> ERROR: space required after that ',' (ctx:VxV)
> +#define set_silent_ptb(emu,page)
> 	__set_ptb_entry(emu,page,emu->silent_page.addr)
> 
> ERROR: space required after that ',' (ctx:VxV)
> +#define set_silent_ptb(emu,page)
> 	__set_ptb_entry(emu,page,emu->silent_page.addr)
> 
> ERROR: space required after that ',' (ctx:VxV)
> +#define set_silent_ptb(emu,page)
> 	__set_ptb_entry(emu,page,emu->silent_page.addr)
> 
> WARNING: Missing a blank line after declarations
> +	int i;
> +	page *= UNIT_PAGES;
> 
> WARNING: Missing a blank line after declarations
> +	int i;
> +	page *= UNIT_PAGES;
> 
> ERROR: space required after that ',' (ctx:VxV)
> +#define get_emu10k1_memblk(l,member)
> 	list_entry(l, struct snd_emu10k1_memblk, member)
> 
> WARNING: space prohibited between function name and open parenthesis '('
> +	list_for_each (pos, &emu->mapped_link_head) {
> 
> WARNING: Missing a blank line after declarations
> +	struct snd_emu10k1_memblk *blk =
> 		get_emu10k1_memblk(pos, mapped_link);
> +	if (blk->mapped_page < 0)
> 
> ERROR: else should follow close brace '}'
> +		}
> +		else if (size > max_size) {
> 
> ERROR: need consistent spacing around '-' (ctx:WxV)
> +	psize = get_aligned_page(size + PAGE_SIZE -1);
>  	                                          ^
> 
> WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
> +EXPORT_SYMBOL(snd_emu10k1_memblk_map);
> 
> WARNING: Missing a blank line after declarations
> +		dma_addr_t addr;
> +		if (ofs >= runtime->dma_bytes)
> 
> ERROR: space prohibited after that '!' (ctx:BxW)
> +		if (! is_valid_page(emu, addr)) {
>  		    ^
> 
> ERROR: trailing whitespace
> +^Istruct snd_util_memhdr *hdr = hw->memhdr; $
> 
> WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
> +EXPORT_SYMBOL(snd_emu10k1_synth_alloc);
> 
> ERROR: trailing whitespace
> +^Istruct snd_util_memhdr *hdr = emu->memhdr; $
> 
> WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
> +EXPORT_SYMBOL(snd_emu10k1_synth_free);
> 
> WARNING: Missing a blank line after declarations
> +	int first_page, last_page;
> +	first_page = blk->first_page;
> 
> WARNING: Missing a blank line after declarations
> +	char *ptr;
> +	if (snd_BUG_ON(page < 0 || page >= emu->max_cache_pages))
> 
> ERROR: space prohibited after that '!' (ctx:BxW)
> +	if (! ptr) {
>  	    ^
> 
> ERROR: "(foo*)" should be "(foo *)"
> +	return (void*)ptr;
> 
> WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
> +EXPORT_SYMBOL(snd_emu10k1_synth_memset);
> 
> WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
> +EXPORT_SYMBOL(snd_emu10k1_synth_copy_from_user);
> 
> Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>

Thanks for the patch.  But in general, I take this kind of
white-space-only patches as a preliminary only when coupled with some
other real fixes or improvement changes -- especially for old driver
code.  Otherwise it'd just scratch the git history.

So, if you have other actual fixes for this driver based on this clean
up, let me know.


Takashi

