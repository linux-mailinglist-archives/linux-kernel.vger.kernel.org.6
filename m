Return-Path: <linux-kernel+bounces-304414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5FB961FBB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 08:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FD47282355
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 06:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A4C155A3C;
	Wed, 28 Aug 2024 06:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="G5J87x6a";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iTx7Ptt/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="G5J87x6a";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iTx7Ptt/"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BB61BC2F;
	Wed, 28 Aug 2024 06:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724826455; cv=none; b=SoMl20ulmDfSmBlWC5AFwdHgtRuOXub9qBurY1/F+/J5t/NJcpDnj6+h9MPj0FBis5F5/cEGBczNgQFjoGNFRWatinDDBrg8hJCLOHIy4BhIEBitVBPtmLLNvOan/ueWPSAhtWWGib7NC0T1R7qPjEh1put1+neoiXBCZcgnjUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724826455; c=relaxed/simple;
	bh=nKuVs1YWi94pd3zteFNgCMsFsKeSOZSLANy9Y+bgG34=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cj1B4z39e5/NkH06LDZIOusLrGkQerjEaTT1pTDubn2MDWuTytprdqA9bsJhem4pyk3HosJiSA5+D+qLZOIFUKbCWTJa3WlDyJK4HaFNhn2yIic+vxt2Ny35aBrtfzcfbjixnwHo5wOSZE+Gz7x+iWBTo71r8zX9e3da3u1iUqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=G5J87x6a; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iTx7Ptt/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=G5J87x6a; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iTx7Ptt/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C5EB51F749;
	Wed, 28 Aug 2024 06:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724826451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4/xOwA01Udhu+JJTCiMH9IJXh82nAR/3EjXhfbdVC1I=;
	b=G5J87x6aJvx6W1/6JR4fLlhY25lyLMcyF/0HwJY1qYmcSHl79PgxI7Daa5EoYAXrfUNLot
	uOhQfhEnwQKWUIy6gkfTfHdDGVhvDMLXPJSpoAPO+9BrKX2WjivUEHu+ZyHpism8FNwOns
	VbCuBvSXPqqfk6ZokOd91x3OY60S9E4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724826451;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4/xOwA01Udhu+JJTCiMH9IJXh82nAR/3EjXhfbdVC1I=;
	b=iTx7Ptt/qDohmRBb5ISu1WVOzTfZhUHFzdMR3EkmzlTGuBq85s4P2he7NW1tVXxcCzEy0r
	M8aN3kO82ndW6rBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724826451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4/xOwA01Udhu+JJTCiMH9IJXh82nAR/3EjXhfbdVC1I=;
	b=G5J87x6aJvx6W1/6JR4fLlhY25lyLMcyF/0HwJY1qYmcSHl79PgxI7Daa5EoYAXrfUNLot
	uOhQfhEnwQKWUIy6gkfTfHdDGVhvDMLXPJSpoAPO+9BrKX2WjivUEHu+ZyHpism8FNwOns
	VbCuBvSXPqqfk6ZokOd91x3OY60S9E4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724826451;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4/xOwA01Udhu+JJTCiMH9IJXh82nAR/3EjXhfbdVC1I=;
	b=iTx7Ptt/qDohmRBb5ISu1WVOzTfZhUHFzdMR3EkmzlTGuBq85s4P2he7NW1tVXxcCzEy0r
	M8aN3kO82ndW6rBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7AB65138D2;
	Wed, 28 Aug 2024 06:27:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /WacHFPDzmb9HgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 28 Aug 2024 06:27:31 +0000
Date: Wed, 28 Aug 2024 08:28:15 +0200
Message-ID: <87ttf5yxds.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
Cc: tiwai@suse.com,
	perex@perex.cz,
	kailang@realtek.com,
	sbinding@opensource.cirrus.com,
	simont@opensource.cirrus.com,
	foss@athaariq.my.id,
	rf@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Edson Juliano Drosdeck <edson@policorp.com>
Subject: Re: [PATCH] ALSA: hda/realtek: Limit mic boost on Positivo DN50F
In-Reply-To: <20240827112912.3397-1-edson@policorp.com>
References: <20240827112912.3397-1-edson@policorp.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -1.80
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, 27 Aug 2024 13:29:12 +0200,
Edson Juliano Drosdeck wrote:
> 
> The internal mic boost on the DN50F is too high. Fix this by applying the
> ALC269_FIXUP_LIMIT_INT_MIC_BOOST fixup to the machine to limit the gain.
> 
> Signed-off-by: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
> ---
>  sound/pci/hda/patch_realtek.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index d022a25635f9..b6bd3903701e 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -10767,6 +10767,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
>  	SND_PCI_QUIRK(0x1d72, 0x1901, "RedmiBook 14", ALC256_FIXUP_ASUS_HEADSET_MIC),
>  	SND_PCI_QUIRK(0x1d72, 0x1945, "Redmi G", ALC256_FIXUP_ASUS_HEADSET_MIC),
>  	SND_PCI_QUIRK(0x1d72, 0x1947, "RedmiBook Air", ALC255_FIXUP_XIAOMI_HEADSET_MIC),
> +	SND_PCI_QUIRK(0x1e50, 0x7038, "Positivo DN50F", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
>  	SND_PCI_QUIRK(0x2782, 0x0214, "VAIO VJFE-CL", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
>  	SND_PCI_QUIRK(0x2782, 0x0232, "CHUWI CoreBook XPro", ALC269VB_FIXUP_CHUWI_COREBOOK_XPRO),
>  	SND_PCI_QUIRK(0x2782, 0x1707, "Vaio VJFE-ADL", ALC298_FIXUP_SPK_VOLUME),

The table is sorted in PCI SSID order.  Could you try to put the new
entry at the right position and resubmit?


thanks,

Takashi

