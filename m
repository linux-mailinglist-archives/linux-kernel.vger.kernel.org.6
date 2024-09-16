Return-Path: <linux-kernel+bounces-330274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D444C979BEE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 09:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00BAE1C2110F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 07:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E02132122;
	Mon, 16 Sep 2024 07:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="a5iRAYv+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tNdv1FhU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="a5iRAYv+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tNdv1FhU"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4D012BF02;
	Mon, 16 Sep 2024 07:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726471089; cv=none; b=J/9dspoUq/rnt6k9JV08uq/PuLm/3PgmFWKPjF1LiuA55kRZDZeoKfe5dE07XrVMXpiTfnPiKbKxN6CMutEPMfMQqm339LR+/29u21vq+tBz0/xinrBiH+Hdm7Idhfy+866xeinuQ8Z5+GOOssQjtk+TYpgTgT2MF8FSkjR+WPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726471089; c=relaxed/simple;
	bh=m5xjs9XVlGg9b0/abligfmacSmVsMUqsrLBPBEW6Grs=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ulkmut8srPvqQod3iIaXIhT9IQFA2PMFeDOBPMc7YihAfx+8Uw42MYYDv7EgHYBBYW7K+0Sz8uqtYQ9L2WfhKQ/VAIHbIGlh9gvfhIssfSe5hca3KWWaoF7CuapzROrUct+0izCy7CVg/38Cl5aP9L6vglXbJvknnukm1DvZJHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=a5iRAYv+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tNdv1FhU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=a5iRAYv+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tNdv1FhU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C319B1F86B;
	Mon, 16 Sep 2024 07:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726471085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/VvYwHRzNWPnqirKJo+tSyHgM6efeQ76sEtro7Yl3P4=;
	b=a5iRAYv+QsIAxU1XZr1VlQq7pcs+/HiW1v8ScleOkA9lXrqI+JtC3pp97IWP1pevVnKws6
	h7DKjeLj1AnmUo1iSHUviy7QvBBpZL6YqsPb75ArEjNtrJyb6bFcOaphU46JyckIhMrNtb
	O5TmW5+iTE4gXEMMYS3EZLZYsYxN8Dk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726471085;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/VvYwHRzNWPnqirKJo+tSyHgM6efeQ76sEtro7Yl3P4=;
	b=tNdv1FhUSv/rLmGU8NLJWc6/J0gQmCKvWGaXtopX78M/bmvEwb0eEoDku2cGr3CicInOeZ
	Yzzif8UQAfN62GAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726471085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/VvYwHRzNWPnqirKJo+tSyHgM6efeQ76sEtro7Yl3P4=;
	b=a5iRAYv+QsIAxU1XZr1VlQq7pcs+/HiW1v8ScleOkA9lXrqI+JtC3pp97IWP1pevVnKws6
	h7DKjeLj1AnmUo1iSHUviy7QvBBpZL6YqsPb75ArEjNtrJyb6bFcOaphU46JyckIhMrNtb
	O5TmW5+iTE4gXEMMYS3EZLZYsYxN8Dk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726471085;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/VvYwHRzNWPnqirKJo+tSyHgM6efeQ76sEtro7Yl3P4=;
	b=tNdv1FhUSv/rLmGU8NLJWc6/J0gQmCKvWGaXtopX78M/bmvEwb0eEoDku2cGr3CicInOeZ
	Yzzif8UQAfN62GAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 98B781397F;
	Mon, 16 Sep 2024 07:18:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pyP2I63b52auKQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 16 Sep 2024 07:18:05 +0000
Date: Mon, 16 Sep 2024 09:18:55 +0200
Message-ID: <871q1k9icg.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-sound@vger.kernel.org,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ALSA: i2c: cs8427: Use common code in snd_cs8427_qsubcode_get()
In-Reply-To: <641210ba-571b-43e7-9007-5633a6c7434c@web.de>
References: <641210ba-571b-43e7-9007-5633a6c7434c@web.de>
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
	FREEMAIL_TO(0.00)[web.de];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[web.de];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 

On Sun, 15 Sep 2024 13:48:51 +0200,
Markus Elfring wrote:
> 
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 15 Sep 2024 13:38:29 +0200
> 
> Add two labels so that a bit of exception handling can be better reused
> at the end of this function implementation.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

The double goto jumps aren't nice, either.
I guess we can do clean up better with cleanup.h stuff.


thanks,

Takashi

> ---
>  sound/i2c/cs8427.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/i2c/cs8427.c b/sound/i2c/cs8427.c
> index 29a1a7a0d050..ee650006cac4 100644
> --- a/sound/i2c/cs8427.c
> +++ b/sound/i2c/cs8427.c
> @@ -397,18 +397,25 @@ static int snd_cs8427_qsubcode_get(struct snd_kcontrol *kcontrol,
>  	if (err != 1) {
>  		dev_err(device->bus->card->dev,
>  			"unable to send register 0x%x byte to CS8427\n", reg);
> -		snd_i2c_unlock(device->bus);
> -		return err < 0 ? err : -EIO;
> +		goto recheck_err;
>  	}
>  	err = snd_i2c_readbytes(device, ucontrol->value.bytes.data, 10);
>  	if (err != 10) {
>  		dev_err(device->bus->card->dev,
>  			"unable to read Q-subcode bytes from CS8427\n");
> -		snd_i2c_unlock(device->bus);
> -		return err < 0 ? err : -EIO;
> +		goto recheck_err;
>  	}
> +
> +	err = 0;
> +unlock:
>  	snd_i2c_unlock(device->bus);
> -	return 0;
> +	return err;
> +
> +recheck_err:
> +	if (err >= 0)
> +		err = -EIO;
> +
> +	goto unlock;
>  }
> 
>  static int snd_cs8427_spdif_info(struct snd_kcontrol *kcontrol,
> --
> 2.46.0
> 

