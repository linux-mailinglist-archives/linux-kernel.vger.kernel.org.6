Return-Path: <linux-kernel+bounces-364043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD6B99CA69
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 14:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFA2D2812B9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 12:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F851A7271;
	Mon, 14 Oct 2024 12:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PHGUumH8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9xAPvqnV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PHGUumH8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9xAPvqnV"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5571A7249;
	Mon, 14 Oct 2024 12:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728909629; cv=none; b=nEhg4f/W3qLwi9t68zep3I4EyV8hdXs1GNUfvHnwjUlP0e/6PW7/AFKGWmUUQCEpinW+To8FDyYTm1KpQ8ltFlP1U1r52z9sOSuLqyuUDVCwEAGzEySFKtsE07o/pBZD9Nw86+1vXYODw+P6yqJ0IoIFG4J++dillBfOt3nTpEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728909629; c=relaxed/simple;
	bh=eLv93g+XA//OTp2safLqFz4/KQcBzg9Js76cf3suyXc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eQKK00LCwFuVmbld3XbL48MMw7S8rPVjyBECKXUCdr0XoVAkkvdAPwa2YGknLDpW8v+epeOtPYjL5QwKoQ+yEoUAwO3BnKnmMdgrdoD6FAsqfxdAYVS/W7L2z/P8w78NcdPh3fZ0AFSElRe8rx2FrGToLpWnvxTar6RRLYqefyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PHGUumH8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9xAPvqnV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PHGUumH8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9xAPvqnV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5CE161FDF9;
	Mon, 14 Oct 2024 12:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728909625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7ZJ2fMmVlwHb5HvH9xU5iseMxVbY4QfNNlC3OaZlj+w=;
	b=PHGUumH8nj5isCuPAQnE4eYR5dihMZdP7zvegGPfRu+qTFJZVJYhvq15ZiV2V9k1hB154c
	GG8HKcOnHJeeDSASCBeRlpaqCYxD6rVU8vXoc+rRNBck6FubfFFyh6fSQ7sRzYIiJaqlvr
	Gk19R6YhPHsb91hLtAPq5NNRfuPGXqg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728909625;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7ZJ2fMmVlwHb5HvH9xU5iseMxVbY4QfNNlC3OaZlj+w=;
	b=9xAPvqnViW03ecvj5tWuJNz4ilkQOcf5wIaUHnifeZcnuht5FjCTnnu1CdZhWD2J8OJgav
	8i15gyza3wbwqWCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=PHGUumH8;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9xAPvqnV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728909625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7ZJ2fMmVlwHb5HvH9xU5iseMxVbY4QfNNlC3OaZlj+w=;
	b=PHGUumH8nj5isCuPAQnE4eYR5dihMZdP7zvegGPfRu+qTFJZVJYhvq15ZiV2V9k1hB154c
	GG8HKcOnHJeeDSASCBeRlpaqCYxD6rVU8vXoc+rRNBck6FubfFFyh6fSQ7sRzYIiJaqlvr
	Gk19R6YhPHsb91hLtAPq5NNRfuPGXqg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728909625;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7ZJ2fMmVlwHb5HvH9xU5iseMxVbY4QfNNlC3OaZlj+w=;
	b=9xAPvqnViW03ecvj5tWuJNz4ilkQOcf5wIaUHnifeZcnuht5FjCTnnu1CdZhWD2J8OJgav
	8i15gyza3wbwqWCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B39C313A42;
	Mon, 14 Oct 2024 12:40:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kGUyKjgRDWctRgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 14 Oct 2024 12:40:24 +0000
Date: Mon, 14 Oct 2024 14:41:22 +0200
Message-ID: <8734kyyhzh.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Mark Brown <broonie@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Greg Marsden
 <greg.marsden@oracle.com>,
	Ivan Ivanov <ivan.ivanov@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Kalesh Singh <kaleshsingh@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-sound@vger.kernel.org
Subject: Re: [RFC PATCH v1 22/57] sound: Remove PAGE_SIZE compile-time constant assumption
In-Reply-To: <6926988e-5532-457f-9e1a-135b03585c5d@arm.com>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
	<20241014105912.3207374-1-ryan.roberts@arm.com>
	<20241014105912.3207374-22-ryan.roberts@arm.com>
	<Zw0CyAlSmaxOCZJl@finisterre.sirena.org.uk>
	<6926988e-5532-457f-9e1a-135b03585c5d@arm.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 5CE161FDF9
X-Spam-Score: -3.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, 14 Oct 2024 14:24:02 +0200,
Ryan Roberts wrote:
> 
> On 14/10/2024 12:38, Mark Brown wrote:
> > On Mon, Oct 14, 2024 at 11:58:29AM +0100, Ryan Roberts wrote:
> >> -static const struct snd_pcm_hardware dummy_dma_hardware = {
> >> +static DEFINE_GLOBAL_PAGE_SIZE_VAR_CONST(struct snd_pcm_hardware, dummy_dma_hardware, {
> >>  	/* Random values to keep userspace happy when checking constraints */
> >>  	.info			= SNDRV_PCM_INFO_INTERLEAVED |
> >>  				  SNDRV_PCM_INFO_BLOCK_TRANSFER,
> >> @@ -107,7 +107,7 @@ static const struct snd_pcm_hardware dummy_dma_hardware = {
> >>  	.period_bytes_max	= PAGE_SIZE*2,
> >>  	.periods_min		= 2,
> >>  	.periods_max		= 128,
> >> -};
> >> +});
> > 
> > It's probably better to just use PAGE_SIZE_MAX here and avoid the
> > deferred patching, like the comment says we don't particularly care what
> > the value actually is here given that it's a dummy.
> 
> OK, so would that be:
> 
> 	.buffer_bytes_max	= 128*1024,
> 	.period_bytes_min	= PAGE_SIZE_MAX,      <<<<<
> 	.period_bytes_max	= PAGE_SIZE_MAX*2,    <<<<<
> 	.periods_min		= 2,
> 	.periods_max		= 128,
> 
> ?
> 
> It's not really clear to me how all the parameters interact; the buffer size
> 128K, which, if PAGE_SIZE_MAX is 64K, would hold 1 period of the maximum size.
> But periods_min is 2. So not sure that works? Or perhaps I'm trying to apply too
> much meaning to the param names...

Right, when PAGE_SIZE_MAX is 64k, 128k won't be used because of the
constrant of periods_min=2.

As Mark mentioned, here the actual size itself doesn't matter much.
So I suppose it'd be even simpler to define just 4096 and 4096 * 2 for
period_bytes_min and *_max instead of sticking with PAGE_SIZE.  Then
it would become platform-agnostic, too.


thanks,

Takashi

