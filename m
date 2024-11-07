Return-Path: <linux-kernel+bounces-400033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 907389C0801
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 14:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EBF1B23872
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 13:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F80212658;
	Thu,  7 Nov 2024 13:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1OKZi6BC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="n3Mgwdny";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1OKZi6BC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="n3Mgwdny"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2E32101B7;
	Thu,  7 Nov 2024 13:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730987318; cv=none; b=s19BxVRIYIVRN5r1EUogOfwyG+NPYGwyvvU7/wy4UklfyI9akMaD4s9dGB+Dbru/c+DU4apbp45qq8r+iFGE0UMNkR6tM9v81iQ5uHIudORBUc84T1p2pBdj29sS55P5R5G7aoqaV6tOUHxbt/WUGwwmWWNUrPE+n4tqAC26IVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730987318; c=relaxed/simple;
	bh=FIR9m+KAwxOXexgMI4F6oCqFvMySRuYgOPelLzIFeYI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bDeIo8quDmuXotiUA1B6ujjnhx5MJKcv0vINsf8zTVQLdRePTKTIpuipX666NKHZ+lscttzNduLfCjegcE1pCon0RxshFnAthZSwfrD9rvtqOdiZhkjuN4y0XIr9Nhrmwks1fqJvR+zoPu6l1dKx5GiUEkCLOnqEYMyFYZ3y1TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1OKZi6BC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=n3Mgwdny; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1OKZi6BC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=n3Mgwdny; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0283621C54;
	Thu,  7 Nov 2024 13:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730987309; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1NDC0Q63BjLNRamLBaugx7A+QFjoMu00RkiPdFw64DY=;
	b=1OKZi6BCQ2no9O+8mpOXNppbb+sXcgHNpr6eUvBKJSTpBdoePxN1SySwEMSA2A8yD+nYaZ
	/RKluQGCEgq2bmijK/ceLRYB3SYBonl2963eVdsxK2ynvTZonBHc1uNB4iqEImCUKoaSY+
	UskPAa1Tto2CWl+qPUM2ZjFcWEAu2JE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730987309;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1NDC0Q63BjLNRamLBaugx7A+QFjoMu00RkiPdFw64DY=;
	b=n3MgwdnydY7cDne0aVdPin3B5L2tw9/5baEdev4Zdbuov20tdiL3Y6uOvfbh4j4WCs3OW8
	v6VEprhgE1zACiCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730987309; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1NDC0Q63BjLNRamLBaugx7A+QFjoMu00RkiPdFw64DY=;
	b=1OKZi6BCQ2no9O+8mpOXNppbb+sXcgHNpr6eUvBKJSTpBdoePxN1SySwEMSA2A8yD+nYaZ
	/RKluQGCEgq2bmijK/ceLRYB3SYBonl2963eVdsxK2ynvTZonBHc1uNB4iqEImCUKoaSY+
	UskPAa1Tto2CWl+qPUM2ZjFcWEAu2JE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730987309;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1NDC0Q63BjLNRamLBaugx7A+QFjoMu00RkiPdFw64DY=;
	b=n3MgwdnydY7cDne0aVdPin3B5L2tw9/5baEdev4Zdbuov20tdiL3Y6uOvfbh4j4WCs3OW8
	v6VEprhgE1zACiCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C80C6139B3;
	Thu,  7 Nov 2024 13:48:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ss1nLyzFLGevTwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 07 Nov 2024 13:48:28 +0000
Date: Thu, 07 Nov 2024 14:48:28 +0100
Message-ID: <87zfmbgno3.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Takashi Iwai <tiwai@suse.de>,
	linux-usb@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] usb: gadget: function: remove redundant else statement
In-Reply-To: <20241107133348.22762-1-colin.i.king@gmail.com>
References: <20241107133348.22762-1-colin.i.king@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-Spam-Score: -1.80
X-Spam-Flag: NO

On Thu, 07 Nov 2024 14:33:48 +0100,
Colin Ian King wrote:
> 
> After an initial range change on the insigned int alt being > 1
> the only possible values for alt are 0 or 1. Therefore the else
> statement for values other than 0 or 1 is redundant and can be
> removed. Replace the else if (all == 1) check with just an else.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Takashi Iwai <tiwai@suse.de>

Also worth to put the original discussion thread:

Link: https://lore.kernel.org/5f54ffd0-b5fe-4203-a626-c166becad362@gmail.com


thanks,

Takashi

> ---
>  drivers/usb/gadget/function/f_midi2.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/f_midi2.c b/drivers/usb/gadget/function/f_midi2.c
> index 8285df9ed6fd..5f3f6e7700c7 100644
> --- a/drivers/usb/gadget/function/f_midi2.c
> +++ b/drivers/usb/gadget/function/f_midi2.c
> @@ -1282,16 +1282,14 @@ static int f_midi2_set_alt(struct usb_function *fn, unsigned int intf,
>  
>  	if (intf != midi2->midi_if || alt > 1)
>  		return 0;
>  
>  	if (alt == 0)
>  		op_mode = MIDI_OP_MODE_MIDI1;
> -	else if (alt == 1)
> +	else
>  		op_mode = MIDI_OP_MODE_MIDI2;
> -	else
> -		op_mode = MIDI_OP_MODE_UNSET;
>  
>  	if (midi2->operation_mode == op_mode)
>  		return 0;
>  
>  	midi2->operation_mode = op_mode;
>  
> -- 
> 2.39.5
> 

