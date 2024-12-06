Return-Path: <linux-kernel+bounces-434672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DA49E69A9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C12E18862AB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2EE1F471E;
	Fri,  6 Dec 2024 09:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ghKyi8Mq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4z2ZDDZk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dkZGVp0f";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="09tGQeq2"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C511EF09B;
	Fri,  6 Dec 2024 09:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733475939; cv=none; b=ScLS9PM6a5JkA9niYH0PvdpCMbXRJ3o2sHaLApUkJZyVB5iGus4+l4+2ssjCbVDo5R4VFVE0n9ZV9m8j60eip3O0uvLgKvdlSGE/gjNiry99gb3zWB7gpy6roZxFw+XvOXR3Hkm3BrrpRH8RZEXiyvksOj8VY9Z1AMwYD7CV3sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733475939; c=relaxed/simple;
	bh=DijnDZaaq+IA5AVo93RJHgyN/7M9vEhB5ux34VJTULA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bw87wv50b0LS1dVWUFsnI1e7QQe/A0DopYN425fzNbadwYaRDxVPFaOtDt82jVkR7rmAcmxTuRT/1U5rCR0bE+2AmOO6A+vY1fYqWmD0zteY3DOPkKz3vnI82Hnn4ek021iaMEyahNm6BwzSsZkqhRhWgA1z6h9Nz00lSFsdne4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ghKyi8Mq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4z2ZDDZk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dkZGVp0f; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=09tGQeq2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EF0EE1F394;
	Fri,  6 Dec 2024 09:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733475936; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NNupd75CdGILE2+T7ZCRahYJXHLurz69gTGUk4nOHeI=;
	b=ghKyi8MqvbzlakkVuWI+bJv3G/LPE4NjJNY+UeySy5vddM96u0arFD1N0gugdxBGambuYe
	boKv8dm1eD7sSJJR8q9aYDDM84eHwop5+4feZKL6WeB6d+D13twRQdsC/rlmyNJ6mCXJc+
	X61ktA9yv09awxWSUtsrXK1EZuBZxrI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733475936;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NNupd75CdGILE2+T7ZCRahYJXHLurz69gTGUk4nOHeI=;
	b=4z2ZDDZkNxZB1YTKI70tKKzEI9wm0b8kwmmAQbuzXL0X4Jt9ZpuZ2NdHzItZfskI5TXLSk
	zqCtX+bRe6Xp45Dg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733475935; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NNupd75CdGILE2+T7ZCRahYJXHLurz69gTGUk4nOHeI=;
	b=dkZGVp0fw+cHSd9VOx9G5HhwJZGwjAJ5Sy1lv9h3I9saJNUEQ/gBymYEKAzQg7jhUwEx30
	+PyWyY6pk+617OWBK0zToGuOHRHZXWfggczsb/zr9eQypIjwL1MC/M2vvPLgy13ghiN+Sb
	Mg/q2WvH4VwwikQr21oGzr46hjXgdWU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733475935;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NNupd75CdGILE2+T7ZCRahYJXHLurz69gTGUk4nOHeI=;
	b=09tGQeq2fUvuF/Qp1bbsmwzy6atHypoDyvxhCBTN9y2k731hDUu6ywczBdwPNaTI6sLt7E
	gz6506PBFlfdKwBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD23A13647;
	Fri,  6 Dec 2024 09:05:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SW5nLF++UmcjBgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 06 Dec 2024 09:05:35 +0000
Date: Fri, 06 Dec 2024 10:05:35 +0100
Message-ID: <871pyltc4g.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Linux Sound Mailing List <linux-sound@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] sound fixes for 6.13-rc2
In-Reply-To: <8734j1tc89.wl-tiwai@suse.de>
References: <8734j1tc89.wl-tiwai@suse.de>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, 06 Dec 2024 10:03:18 +0100,
Takashi Iwai wrote:
> 
> Linus,
> 
> please pull sound fixes for v6.13-rc2 from:

Please don't mind about the wrong subject prefix, the PR itself is
correct.  It slipped in a rush morning action, sorry.


Takashi

> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.13-rc2
> 
> The topmost commit is c34e9ab9a612ee8b18273398ef75c207b01f516d
> 
> ----------------------------------------------------------------
> 
> sound fixes for 6.13-rc2
> 
> A collection of small fixes that have been gathered in the week.
> 
> - Fix the missing XRUN handling in USB-audio low latency mode
> - Fix regression by the previous USB-audio hadening change
> - Clean up old SH sound driver to use the standard helpers
> - A few further fixes for MIDI 2.0 UMP handling
> - Various HD-audio and USB-audio quirks
> - Fix jack handling at PM on ASoC Intel AVS
> - Misc small fixes for ASoC SOF and Mediatek
> 
> ----------------------------------------------------------------
> 
> Asahi Lina (1):
>       ALSA: usb-audio: Add extra PID for RME Digiface USB
> 
> Chris Chiu (1):
>       ALSA: hda/realtek: fix micmute LEDs don't work on HP Laptops
> 
> Colin Ian King (1):
>       ALSA: hda/realtek: Fix spelling mistake "Firelfy" -> "Firefly"
> 
> Dan Carpenter (3):
>       ALSA: hda/tas2781: Fix error code tas2781_read_acpi()
>       ASoC: SOF: ipc3-topology: fix resource leaks in sof_ipc3_widget_setup_comp_dai()
>       ALSA: usb-audio: Fix a DMA to stack memory bug
> 
> Marek Maslanka (1):
>       ASoC: Intel: avs: da7219: Remove suspend_pre() and resume_post()
> 
> Marie Ramlow (1):
>       ALSA: usb-audio: add mixer mapping for Corsair HS80
> 
> Nazar Bilinskyi (1):
>       ALSA: hda/realtek: Enable mute and micmute LED on HP ProBook 430 G8
> 
> Nícolas F. R. A. Prado (1):
>       ASoC: mediatek: mt8188-mt6359: Remove hardcoded dmic codec
> 
> Sahas Leelodharry (1):
>       ALSA: hda/realtek: Add support for Samsung Galaxy Book3 360 (NP730QFG)
> 
> Takashi Iwai (7):
>       ALSA: seq: ump: Fix seq port updates per FB info notify
>       ALSA: ump: Don't open legacy substream for an inactive group
>       ALSA: ump: Indicate the inactive group in legacy substream names
>       ALSA: ump: Update legacy substream names upon FB info update
>       ALSA: usb-audio: Notify xrun for low-latency mode
>       ALSA: sh: Use standard helper for buffer accesses
>       ALSA: ump: Shut up truncated string warning
> 
> bo liu (1):
>       ALSA: hda/conexant: fix Z60MR100 startup pop issue
> 
> ---
>  sound/core/seq/seq_ump_client.c           |   6 +-
>  sound/core/ump.c                          |  26 ++-
>  sound/pci/hda/patch_conexant.c            |  28 +++
>  sound/pci/hda/patch_realtek.c             |   8 +
>  sound/pci/hda/tas2781_hda_i2c.c           |   1 +
>  sound/sh/sh_dac_audio.c                   |   5 +-
>  sound/soc/intel/avs/boards/da7219.c       |  17 --
>  sound/soc/mediatek/mt8188/mt8188-mt6359.c |   4 +-
>  sound/soc/sof/ipc3-topology.c             |   7 +-
>  sound/usb/endpoint.c                      |  14 +-
>  sound/usb/mixer_maps.c                    |  10 +
>  sound/usb/mixer_quirks.c                  |   1 +
>  sound/usb/quirks-table.h                  | 341 +++++++++++++++---------------
>  sound/usb/quirks.c                        |  44 ++--
>  14 files changed, 291 insertions(+), 221 deletions(-)
> 

