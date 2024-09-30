Return-Path: <linux-kernel+bounces-343535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A471989C32
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5D1B1F21E1B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 08:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956DF170A13;
	Mon, 30 Sep 2024 08:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="O3J2ZByD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jz2GTFnl";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="O3J2ZByD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jz2GTFnl"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7136C15D5D9;
	Mon, 30 Sep 2024 08:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727683693; cv=none; b=D69MW1NWYPlryblbGyxOjrwTSEFvJV5FFN2dQ+pYJ1dtcXSASBIzMfuMn3qIyNh0Dd5mu37oHevFAYtYO6J6p94eA2zF0En2NvdCDOSNSMgFxv24Pz2KTlqWDB1i3cxcVJ+0Jz0PjoHUAkR2q+1UphpMHg4IPiETsROHZNJtskA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727683693; c=relaxed/simple;
	bh=P6Xo+mehh8QI6H7gqYXNmioph9nxWrB3vqSiwpbxXbI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u3ECDyMhC1rO3yEUh2uGzG6EjvmoJej7DSGwZycpt5StwWBGdYUYfbt6rqShEN1rENHli0/x4NboF++7cZrXSlGHSVUaj93ceFkJO9VTBqlEf+bN4diiXVdUCnEQNL53UFZJci7BEg17yKcfF4Gk+HTBN3IVh8tsUF5808wknqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=O3J2ZByD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jz2GTFnl; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=O3J2ZByD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jz2GTFnl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A1C641F7F0;
	Mon, 30 Sep 2024 08:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727683689; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EjTRlgNPhzw1rijGLE17ikh00xLt84X0n31FFoSHoQs=;
	b=O3J2ZByDwfW8BL9KNPGbcjDcNr9XjHhj+Y7d74bjOOKg7I/nU3F3u++l3xJl5B16ZKBRad
	xp0piod2pn55fS7qmdo85D564h1BOCHS5lD4k9J578+/SBsNZaRelZEN+3ocf17g6rYedi
	YVladQlbPvWZdBJtsUTzi3aWnB+SRFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727683689;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EjTRlgNPhzw1rijGLE17ikh00xLt84X0n31FFoSHoQs=;
	b=jz2GTFnlmEGds46GDwf3/5LAuoy0ViGVv81AmvoN29eUipgJP9Qy+D6Qc9+dWjdi97g3RX
	UxZEL2HzSIX3KCBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727683689; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EjTRlgNPhzw1rijGLE17ikh00xLt84X0n31FFoSHoQs=;
	b=O3J2ZByDwfW8BL9KNPGbcjDcNr9XjHhj+Y7d74bjOOKg7I/nU3F3u++l3xJl5B16ZKBRad
	xp0piod2pn55fS7qmdo85D564h1BOCHS5lD4k9J578+/SBsNZaRelZEN+3ocf17g6rYedi
	YVladQlbPvWZdBJtsUTzi3aWnB+SRFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727683689;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EjTRlgNPhzw1rijGLE17ikh00xLt84X0n31FFoSHoQs=;
	b=jz2GTFnlmEGds46GDwf3/5LAuoy0ViGVv81AmvoN29eUipgJP9Qy+D6Qc9+dWjdi97g3RX
	UxZEL2HzSIX3KCBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 47ADB13A8B;
	Mon, 30 Sep 2024 08:08:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BMo/EGlc+mZ+FQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 30 Sep 2024 08:08:09 +0000
Date: Mon, 30 Sep 2024 10:09:02 +0200
Message-ID: <878qv9k1gh.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Abhishek Tamboli <abhishektamboli9@gmail.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	kailang@realtek.com,
	sbinding@opensource.cirrus.com,
	simont@opensource.cirrus.com,
	josh@joshuagrisham.com,
	foss@athaariq.my.id,
	rf@opensource.cirrus.com,
	skhan@linuxfoundation.org,
	rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Add a quirk for HP Pavilion 15z-ec200
In-Reply-To: <20240926155112.8079-1-abhishektamboli9@gmail.com>
References: <20240926155112.8079-1-abhishektamboli9@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[perex.cz,suse.com,realtek.com,opensource.cirrus.com,joshuagrisham.com,athaariq.my.id,linuxfoundation.org,gmail.com,lists.linuxfoundation.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Score: -3.30
X-Spam-Flag: NO

On Thu, 26 Sep 2024 17:51:12 +0200,
Abhishek Tamboli wrote:
> 
> Add the quirk for HP Pavilion Gaming laptop 15z-ec200 for
> enabling the mute led. The fix apply the ALC285_FIXUP_HP_MUTE_LED
> quirk for this model.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=219303
> 
> Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
> ---
>  sound/pci/hda/patch_realtek.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index 4ca66234e561..94125a977f08 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -10315,6 +10315,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
>  	SND_PCI_QUIRK(0x103c, 0x8786, "HP OMEN 15", ALC285_FIXUP_HP_MUTE_LED),
>  	SND_PCI_QUIRK(0x103c, 0x8787, "HP OMEN 15", ALC285_FIXUP_HP_MUTE_LED),
>  	SND_PCI_QUIRK(0x103c, 0x8788, "HP OMEN 15", ALC285_FIXUP_HP_MUTE_LED),
> +	SND_PCI_QUIRK(0x103c, 0x88DD, "HP Pavilion 15z-ec200", ALC285_FIXUP_HP_MUTE_LED),
>  	SND_PCI_QUIRK(0x103c, 0x87b7, "HP Laptop 14-fq0xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
>  	SND_PCI_QUIRK(0x103c, 0x87c8, "HP", ALC287_FIXUP_HP_GPIO_LED),
>  	SND_PCI_QUIRK(0x103c, 0x87d3, "HP Laptop 15-gw0xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),

The quirk table is sorted in PCI SSID order.  Could you try to put at
the right position?
Also, please use lower letters for the hex numbers there.


thanks,

Takashi

