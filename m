Return-Path: <linux-kernel+bounces-360796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 312D9999FD8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 11:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABC7D1F2238E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 09:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0668520CCC8;
	Fri, 11 Oct 2024 09:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="C33ErDdy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1gVAczZk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Xvk+rtk0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aRu3PTSo"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B3120C46C;
	Fri, 11 Oct 2024 09:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728637913; cv=none; b=nEshrVGdPTCuKpP+YB000+YWCI8OVZHoh63VgmYAbBVi7DDUrraghbL+es28DR5AyRevjbmjOzzSMuaflQIOdcDuYRIsbrq3z8EUEG3raVhpt1QHH3DsXs4bjpyQMoOWSpLgxLPVL1FgkP60jkuMxBtqZg1J9xBZeMVXo+nUw+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728637913; c=relaxed/simple;
	bh=3uOl5msXhMcnmG4tD4a7j6kHeBRrApQCa2hdgtzfr/g=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BM1prP55aA4oEqA0Rte2peLcO4AuD1KdHtDlMvD6oTCOKTmiIxwNAs5SoTHiQtLNK+AHnwLEKeQQwgPt9G9g+CLoCHjKyRkThwH7+FGTs7jpE/ypCQQGvQjGX/aoY1EDnnyASxYBsDXzJ+rl7jHb1+UU0PHrKkNY61LRcfT6QXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=C33ErDdy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1gVAczZk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Xvk+rtk0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aRu3PTSo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EFC91219C5;
	Fri, 11 Oct 2024 09:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728637910; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xuZTgWdFD/hq8KR11XFrFgYR7ZkWzK+2bSpdRlLNDB4=;
	b=C33ErDdyZbbbrhnhdFu0f7eb8QvNS+S9jrUImLemWh0zh0jPMxUqXoFG4bJ2fj9q4w2kMu
	ewif9IzMzvQm6VhCYxvUEq56J0z9HsZcix2kQElcBZ+LxYaMCDfBP2Zw1SnSAJ/y2IAK1r
	YOICfhHMWDA/0ckGj6TEMCXu2h5aeME=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728637910;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xuZTgWdFD/hq8KR11XFrFgYR7ZkWzK+2bSpdRlLNDB4=;
	b=1gVAczZkEGUHbYW86l5zb2Qna6WCI+Vw6rBhNEFv3W8AqWC1dJ6QI4MGIaUMwmIep64t2g
	9DSmGHzQLxqrZDDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Xvk+rtk0;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=aRu3PTSo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728637909; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xuZTgWdFD/hq8KR11XFrFgYR7ZkWzK+2bSpdRlLNDB4=;
	b=Xvk+rtk0sJ9Rmw79SHnRifqwxFQYjGPonhj9nuESNkrdYmGhd6Lh/YgfjrJig5vFfez0S8
	Ed5/qKV1MEE2+FQup+GCDByPCDNP49JL2BghrOa4GmE8BCZH8/bdbla35V5e5uFn8VZIE6
	q+mqi1HVY343ksbnYH/hVJ3fDXaCIvM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728637909;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xuZTgWdFD/hq8KR11XFrFgYR7ZkWzK+2bSpdRlLNDB4=;
	b=aRu3PTSoGpEx6/aKAF7AGNL+FB8YBBJI+TDZliRCP4yncs3Mqecww/EdolAPqL8996ED4s
	OBQHvQp61+CRPXBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C5588136E0;
	Fri, 11 Oct 2024 09:11:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LSLgLtXrCGd4KQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 11 Oct 2024 09:11:49 +0000
Date: Fri, 11 Oct 2024 11:12:46 +0200
Message-ID: <87o73rm29d.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: linux@treblig.org
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: core: Remove unused copy_from_user_toio
In-Reply-To: <20241010205340.278133-1-linux@treblig.org>
References: <20241010205340.278133-1-linux@treblig.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: EFC91219C5
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51
X-Spam-Flag: NO

On Thu, 10 Oct 2024 22:53:40 +0200,
linux@treblig.org wrote:
> 
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> copy_from_user_toio() has been unused since commit
> ce2d8ed8d809 ("ASoC: qcom: Convert to generic PCM copy ops")
> 
> Remove it.

It's a pair of copy_to_*(), so if any, it should be dropped only after
both users are gone.


thanks,

Takashi

> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>  include/sound/core.h |  1 -
>  sound/core/memory.c  | 20 --------------------
>  2 files changed, 21 deletions(-)
> 
> diff --git a/include/sound/core.h b/include/sound/core.h
> index 1f3f5dccd736..b5a6f3d2bff5 100644
> --- a/include/sound/core.h
> +++ b/include/sound/core.h
> @@ -267,7 +267,6 @@ static inline int snd_minor_info_oss_init(void) { return 0; }
>  /* memory.c */
>  
>  int copy_to_user_fromio(void __user *dst, const volatile void __iomem *src, size_t count);
> -int copy_from_user_toio(volatile void __iomem *dst, const void __user *src, size_t count);
>  
>  /* init.c */
>  
> diff --git a/sound/core/memory.c b/sound/core/memory.c
> index 2d2d0094c897..8222a851da87 100644
> --- a/sound/core/memory.c
> +++ b/sound/core/memory.c
> @@ -63,26 +63,6 @@ int copy_to_iter_fromio(struct iov_iter *dst, const void __iomem *src,
>  }
>  EXPORT_SYMBOL(copy_to_iter_fromio);
>  
> -/**
> - * copy_from_user_toio - copy data from user-space to mmio-space
> - * @dst: the destination pointer on mmio-space
> - * @src: the source pointer on user-space
> - * @count: the data size to copy in bytes
> - *
> - * Copies the data from user-space to mmio-space.
> - *
> - * Return: Zero if successful, or non-zero on failure.
> - */
> -int copy_from_user_toio(volatile void __iomem *dst, const void __user *src, size_t count)
> -{
> -	struct iov_iter iter;
> -
> -	if (import_ubuf(ITER_SOURCE, (void __user *)src, count, &iter))
> -		return -EFAULT;
> -	return copy_from_iter_toio((void __iomem *)dst, &iter, count);
> -}
> -EXPORT_SYMBOL(copy_from_user_toio);
> -
>  /**
>   * copy_from_iter_toio - copy data from iov_iter to mmio-space
>   * @dst: the destination pointer on mmio-space
> -- 
> 2.47.0
> 

