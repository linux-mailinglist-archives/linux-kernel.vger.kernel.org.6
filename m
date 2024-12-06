Return-Path: <linux-kernel+bounces-435024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BB59E6E8A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 13:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5E101699D9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 12:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F88C2066D5;
	Fri,  6 Dec 2024 12:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kkesa0FX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="l+ltgAvX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kkesa0FX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="l+ltgAvX"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C04196DA2;
	Fri,  6 Dec 2024 12:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733489342; cv=none; b=k9R+VlWqRf2QDYZ+Th1tkerzSHrjyhDNHcOrDLb/17rwHDHoxVrQ8ra2y1BTVVFwh3dnZYzQxMzvPIgmvjMVnbQmCSJnoqZJEkGniCKtyuLd/DD149kVOYVpAIYndizDAqUsIpcjvYhXw5OOd3zmnFDNqpLC5LY8/nEweptKaLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733489342; c=relaxed/simple;
	bh=b6WgRv8rtiB7pTTMcphIGsOMKRIsXI5qMlLnrXGHB1c=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=th5ALGE/BfW2r9QjPUHqwtkD3qSTX3FcFBlgoCCfAVc82NYI07x5lQKOQMqAdN1NUr5WgRlcub78zovymJ12w5c7FuLydhdyKdx3IeHekgl9Uz5vxVvQqrPZPlmfP9gsdIlylJtK9Pe5/DYRIp/AZuRIgZnuvxRGTQnndVT3WYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kkesa0FX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=l+ltgAvX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kkesa0FX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=l+ltgAvX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 06E8421191;
	Fri,  6 Dec 2024 12:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733489333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5K5CGsSKu551hYd3WzWHJ25z8Kb3GEXEqTT48JAUn1A=;
	b=kkesa0FXkOz6ZdgLYCQCBz5vHsRKao4X5p29Ju5cqRkljWjRMnbAmpTfpr5X+MuuJO/8ff
	8eSioNdx4TRs6PtUPnYyJkTV7B7aEw6DcUwNlyP3865UQ9o4jUzUJVIcH5jtB3vSq3261P
	j1u4HXj7QglTSEF5hbz1Ryc4K0fe3Cw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733489333;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5K5CGsSKu551hYd3WzWHJ25z8Kb3GEXEqTT48JAUn1A=;
	b=l+ltgAvXi/mJgaVMo1aKyd2vtMX/lug/UFu4YW6oqr5bxb7K+aqWsCQx85PcnMVC5uimLd
	Gfimvo2njLYHYkDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733489333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5K5CGsSKu551hYd3WzWHJ25z8Kb3GEXEqTT48JAUn1A=;
	b=kkesa0FXkOz6ZdgLYCQCBz5vHsRKao4X5p29Ju5cqRkljWjRMnbAmpTfpr5X+MuuJO/8ff
	8eSioNdx4TRs6PtUPnYyJkTV7B7aEw6DcUwNlyP3865UQ9o4jUzUJVIcH5jtB3vSq3261P
	j1u4HXj7QglTSEF5hbz1Ryc4K0fe3Cw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733489333;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5K5CGsSKu551hYd3WzWHJ25z8Kb3GEXEqTT48JAUn1A=;
	b=l+ltgAvXi/mJgaVMo1aKyd2vtMX/lug/UFu4YW6oqr5bxb7K+aqWsCQx85PcnMVC5uimLd
	Gfimvo2njLYHYkDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CAD8C138A7;
	Fri,  6 Dec 2024 12:48:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2Vc6MLTyUmdhSgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 06 Dec 2024 12:48:52 +0000
Date: Fri, 06 Dec 2024 13:48:52 +0100
Message-ID: <87r06lrn7v.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: liujing <liujing@cmss.chinamobile.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	ghanshyam1898@gmail.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: au88x0: Modify the incorrect format specifier
In-Reply-To: <20241206020543.2153-1-liujing@cmss.chinamobile.com>
References: <20241206020543.2153-1-liujing@cmss.chinamobile.com>
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
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[perex.cz,suse.com,gmail.com,vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, 06 Dec 2024 03:05:43 +0100,
liujing wrote:
> 
> Make a minor change to eliminate a static checker warning. The type
> of chip->irq is unsigned int, so the correct format specifier should be
> %u instead of %i.
> 
> Signed-off-by: liujing <liujing@cmss.chinamobile.com>

In this particular case, it's better to correct snd_vortex.irq to be
normal signed int.  The validity check is with a negative value, as
it's initialized with -1.


thanks,

Takashi

> 
> diff --git a/sound/pci/au88x0/au88x0.c b/sound/pci/au88x0/au88x0.c
> index 62b10b0e07b1..e3b1d7116110 100644
> --- a/sound/pci/au88x0/au88x0.c
> +++ b/sound/pci/au88x0/au88x0.c
> @@ -223,7 +223,7 @@ __snd_vortex_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
>  	// Card details needed in snd_vortex_midi
>  	strcpy(card->driver, CARD_NAME_SHORT);
>  	sprintf(card->shortname, "Aureal Vortex %s", CARD_NAME_SHORT);
> -	sprintf(card->longname, "%s at 0x%lx irq %i",
> +	sprintf(card->longname, "%s at 0x%lx irq %u",
>  		card->shortname, chip->io, chip->irq);
>  
>  	// (4) Alloc components.
> -- 
> 2.27.0
> 
> 
> 

