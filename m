Return-Path: <linux-kernel+bounces-430872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EFC9E36B8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC54E28101C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3BA1AC8B8;
	Wed,  4 Dec 2024 09:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Q/Zx6J0P";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lTihsWB3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Q/Zx6J0P";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lTihsWB3"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63951AC43A;
	Wed,  4 Dec 2024 09:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733304723; cv=none; b=WsRZkyIT2ICaZASIDP/UJBXZ+KHMO35BX22o7g6VzpSleCKmsoZCb1+ZcYZshJlrmmSAlau6L1vRoKK+S6d99NOqT53tZhoZJN5xwKNgss5zA8gesvEU/s3jsHsmntnEzQfBhKMe4Uct2A8tIGtXZHqI8QbY7Re2Bcb21P93ESs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733304723; c=relaxed/simple;
	bh=JrJuyLzuA97RnzKWyuOh7ow+3Xx7AvY6TWUxL8wm9/4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NtRGEL5CnrPmGQSHP1fegtNL6GnJ7U/fLHTMb9uTfb17UYtQyRkDNBIXWm7rgqAvH7nhIog6JOuR5n3S6aN744ELKWc1pQn3I1bdNwFJG16Alt2ga6cpBJnz59PWuyyku3wSaxAt6SY05YXbYK1hXPi6m4EgIE4LHWOX8/rvqag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Q/Zx6J0P; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lTihsWB3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Q/Zx6J0P; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lTihsWB3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BE1FD1F365;
	Wed,  4 Dec 2024 09:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733304719; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z0+yNJvxiUtgTb8b5gEnOI/DFtHXBiV88LZiuL4b5AE=;
	b=Q/Zx6J0POyWyBv/xg/b1y6Y/vPj+6HCGsx5CAnly2KYRlTkby3v79us9B9s4nNfoDUuKAP
	HGcgurVs2daX4qfs/dYJwnHfTJ8tcHoivRExQ9Pa29vNJOSEKFm1lNRQa71ZXG+9qyArQB
	9vtIgdHSsh2J7fsOF8RgC4cr9VHnkHY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733304719;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z0+yNJvxiUtgTb8b5gEnOI/DFtHXBiV88LZiuL4b5AE=;
	b=lTihsWB35+IWboTJM30qxwXaX0VccJN+70TzFwmidQK2cCiSv+PeBrTz6WrBA4d4X06+Ll
	Ki+nxSlGrfVakHBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733304719; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z0+yNJvxiUtgTb8b5gEnOI/DFtHXBiV88LZiuL4b5AE=;
	b=Q/Zx6J0POyWyBv/xg/b1y6Y/vPj+6HCGsx5CAnly2KYRlTkby3v79us9B9s4nNfoDUuKAP
	HGcgurVs2daX4qfs/dYJwnHfTJ8tcHoivRExQ9Pa29vNJOSEKFm1lNRQa71ZXG+9qyArQB
	9vtIgdHSsh2J7fsOF8RgC4cr9VHnkHY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733304719;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z0+yNJvxiUtgTb8b5gEnOI/DFtHXBiV88LZiuL4b5AE=;
	b=lTihsWB35+IWboTJM30qxwXaX0VccJN+70TzFwmidQK2cCiSv+PeBrTz6WrBA4d4X06+Ll
	Ki+nxSlGrfVakHBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 949BD139C2;
	Wed,  4 Dec 2024 09:31:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9sUEI48hUGcXbgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 04 Dec 2024 09:31:59 +0000
Date: Wed, 04 Dec 2024 10:31:59 +0100
Message-ID: <87ttbjx08g.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: liujing <liujing@cmss.chinamobile.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: asihpi: Delete redundant judgments
In-Reply-To: <20241203154635.2512-1-liujing@cmss.chinamobile.com>
References: <20241203154635.2512-1-liujing@cmss.chinamobile.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, 03 Dec 2024 16:46:35 +0100,
liujing wrote:
> 
> Since HPI6205_TIMEOUT is a constant, time_out is always true,
> so unneeded judgments are removed.
> 
> Signed-off-by: liujing <liujing@cmss.chinamobile.com>

Keeping it allows to remove the time_out for experiments, and compiler
would optimize things in anyway, so there must be no code difference
in the end.

Since this doesn't improve things so significantly, I'd rather leave
as is.

And you mixed different fixes (the conversion of printf format) in a
single patch without explanation, too.  Please split, if any.


thanks,

Takashi

> 
> diff --git a/sound/pci/asihpi/hpi6205.c b/sound/pci/asihpi/hpi6205.c
> index c7d7eff86727..391cce428a11 100644
> --- a/sound/pci/asihpi/hpi6205.c
> +++ b/sound/pci/asihpi/hpi6205.c
> @@ -2127,22 +2127,20 @@ static u16 message_response_sequence(struct hpi_adapter_obj *pao,
>  	time_out = HPI6205_TIMEOUT;
>  
>  	/* read the result */
> -	if (time_out) {
> -		if (interface->u.response_buffer.response.size <= phr->size)
> -			memcpy(phr, &interface->u.response_buffer,
> -				interface->u.response_buffer.response.size);
> -		else {
> -			HPI_DEBUG_LOG(ERROR,
> +	if (interface->u.response_buffer.response.size <= phr->size)
> +		memcpy(phr, &interface->u.response_buffer,
> +			interface->u.response_buffer.response.size);
> +	else {
> +		HPI_DEBUG_LOG(ERROR,
>  				"response len %d too big for buffer %d\n",
>  				interface->u.response_buffer.response.size,
>  				phr->size);
> -			memcpy(phr, &interface->u.response_buffer,
> +		memcpy(phr, &interface->u.response_buffer,
>  				sizeof(struct hpi_response_header));
> -			phr->error = HPI_ERROR_RESPONSE_BUFFER_TOO_SMALL;
> -			phr->specific_error =
> -				interface->u.response_buffer.response.size;
> -			phr->size = sizeof(struct hpi_response_header);
> -		}
> +		phr->error = HPI_ERROR_RESPONSE_BUFFER_TOO_SMALL;
> +		phr->specific_error =
> +			interface->u.response_buffer.response.size;
> +		phr->size = sizeof(struct hpi_response_header);
>  	}
>  	/* set interface back to idle */
>  	send_dsp_command(phw, H620_HIF_IDLE);
> diff --git a/sound/pci/mixart/mixart.c b/sound/pci/mixart/mixart.c
> index 7ceaf6a7a77e..cac5fcaef08b 100644
> --- a/sound/pci/mixart/mixart.c
> +++ b/sound/pci/mixart/mixart.c
> @@ -1320,12 +1320,12 @@ static int snd_mixart_probe(struct pci_dev *pci,
>  			idx = index[dev];
>  		else
>  			idx = index[dev] + i;
> -		snprintf(tmpid, sizeof(tmpid), "%s-%d", id[dev] ? id[dev] : "MIXART", i);
> +		snprintf(tmpid, sizeof(tmpid), "%s-%u", id[dev] ? id[dev] : "MIXART", i);
>  		err = snd_card_new(&pci->dev, idx, tmpid, THIS_MODULE,
>  				   0, &card);
>  
>  		if (err < 0) {
> -			dev_err(&pci->dev, "cannot allocate the card %d\n", i);
> +			dev_err(&pci->dev, "cannot allocate the card %u\n", i);
>  			snd_mixart_free(mgr);
>  			return err;
>  		}
> @@ -1334,7 +1334,7 @@ static int snd_mixart_probe(struct pci_dev *pci,
>  		snprintf(card->shortname, sizeof(card->shortname),
>  			 "Digigram miXart [PCM #%d]", i);
>  		snprintf(card->longname, sizeof(card->longname),
> -			"Digigram miXart at 0x%lx & 0x%lx, irq %i [PCM #%d]",
> +			"Digigram miXart at 0x%lx & 0x%lx, irq %i [PCM #%u]",
>  			mgr->mem[0].phys, mgr->mem[1].phys, mgr->irq, i);
>  
>  		err = snd_mixart_create(mgr, card, i);
> -- 
> 2.27.0
> 
> 
> 

