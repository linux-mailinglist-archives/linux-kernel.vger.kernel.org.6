Return-Path: <linux-kernel+bounces-184978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE338CAECA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 15:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41B231C217C2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 13:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C5A757FC;
	Tue, 21 May 2024 13:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="u0hYpHxx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fOwQaVDd";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="u0hYpHxx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fOwQaVDd"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F031E48B;
	Tue, 21 May 2024 13:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716296523; cv=none; b=YhsEaRaJ16sXv7Q/8Kgd87tTR5sf1iTXFDcFzJSOvMq3LkqOSi+iP7pSWHJ0tNTY0X5U7m8tIowsFveS5STR44bLOMlnkHxSuwZniFnVSRK2PICCVYE5EFgSQjJ2XimtqjkDpKZUKBNCrEwVX6PJDcRFHUltXREG6WrhsIGOmmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716296523; c=relaxed/simple;
	bh=hrsM7ZPGvSc3gBrRAQe0+21IiututFmytl05498MpqU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LYZDtOZLqFbqnX+mQyziReeajxO9X2wjF2ipvnzMs1FG7I+XOuJzqh0pouVn45ceUEqGfHOFtkn0eVZ2Fj9SD7aKkswSXqWhFMHEzuJgQ+Y8GBN9B7s5gUykS/BwLpPdpU5J5uD0kn+VkWVxiH/N4AwjViDdVeDUuEcYt8D7lOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=u0hYpHxx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fOwQaVDd; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=u0hYpHxx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fOwQaVDd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 83DB25C171;
	Tue, 21 May 2024 13:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716296519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4Z4uWvo2twTh7wiDGu/9ID21HQ5a9PToI5gTbqHZcCU=;
	b=u0hYpHxxa9zJbhNT3Ai67Kh1uIYKgswpcbXNq6KHBRCEx+PPQ/VntIa9G3EMOyJf0seVYn
	BCQzLvKH0gB9SVc+wyiAq7Bal6gsqHWdr4A94hlJIr3cZJCZauvYTOszCaxJSUbsjluTgq
	mLvYhNNsey6YO4/otJy2hVeP6MrtnQI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716296519;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4Z4uWvo2twTh7wiDGu/9ID21HQ5a9PToI5gTbqHZcCU=;
	b=fOwQaVDdLtP92Zjaqdv4tiOoOR0tItzVT7Dg/6UGLDJGNn3c65St6OoYLkq3keI8svWZ3W
	wetbmZD/Lwp4ocBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=u0hYpHxx;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=fOwQaVDd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716296519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4Z4uWvo2twTh7wiDGu/9ID21HQ5a9PToI5gTbqHZcCU=;
	b=u0hYpHxxa9zJbhNT3Ai67Kh1uIYKgswpcbXNq6KHBRCEx+PPQ/VntIa9G3EMOyJf0seVYn
	BCQzLvKH0gB9SVc+wyiAq7Bal6gsqHWdr4A94hlJIr3cZJCZauvYTOszCaxJSUbsjluTgq
	mLvYhNNsey6YO4/otJy2hVeP6MrtnQI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716296519;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4Z4uWvo2twTh7wiDGu/9ID21HQ5a9PToI5gTbqHZcCU=;
	b=fOwQaVDdLtP92Zjaqdv4tiOoOR0tItzVT7Dg/6UGLDJGNn3c65St6OoYLkq3keI8svWZ3W
	wetbmZD/Lwp4ocBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F72213A1E;
	Tue, 21 May 2024 13:01:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NYblEUebTGYQOAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 21 May 2024 13:01:59 +0000
Date: Tue, 21 May 2024 15:02:18 +0200
Message-ID: <87h6er1fol.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: g@b4.vu,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: scarlett2: Prevent leaking urb
In-Reply-To: <20240521010352.1082164-1-nichen@iscas.ac.cn>
References: <20240521010352.1082164-1-nichen@iscas.ac.cn>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 83DB25C171
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]

On Tue, 21 May 2024 03:03:52 +0200,
Chen Ni wrote:
> 
> In scarlett2_init_notify() if kmalloc() fails the allocated urb should
> be released.

It's freed in the common USB mixer destructor (snd_usb_mixer_free()),
hence your patch will lead to a double-free.


thanks,

Takashi

> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  sound/usb/mixer_scarlett2.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/usb/mixer_scarlett2.c b/sound/usb/mixer_scarlett2.c
> index 1150cf104985..4cad6b2a0292 100644
> --- a/sound/usb/mixer_scarlett2.c
> +++ b/sound/usb/mixer_scarlett2.c
> @@ -8637,9 +8637,10 @@ static int scarlett2_init_notify(struct usb_mixer_interface *mixer)
>  		return -ENOMEM;
>  
>  	transfer_buffer = kmalloc(private->wMaxPacketSize, GFP_KERNEL);
> -	if (!transfer_buffer)
> +	if (!transfer_buffer) {
> +		usb_free_urb(mixer->urb);
>  		return -ENOMEM;
> -
> +	}
>  	usb_fill_int_urb(mixer->urb, dev, pipe,
>  			 transfer_buffer, private->wMaxPacketSize,
>  			 scarlett2_notify, mixer, private->bInterval);
> -- 
> 2.25.1
> 
> 

