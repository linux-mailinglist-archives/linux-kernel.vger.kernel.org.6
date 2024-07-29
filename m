Return-Path: <linux-kernel+bounces-266329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D71FE93FE37
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 21:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 656B51F22AD8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 19:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAF918734B;
	Mon, 29 Jul 2024 19:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VliUM/b6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="f7J9uxb/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="s69QFT0M";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="u5FK5zBv"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC89F84D34;
	Mon, 29 Jul 2024 19:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722281224; cv=none; b=AlEfnpSOL9sorJ8KpIhqfofM7nYj2bTljBaRUlYc1EfiWzjK/DmoZHamOHWpVS/90skFAatjDcs9WqExlmAGkHCl0JvcEzM69QUEERFpMHe3jNeWhWld+d7qFgbo8lBwF7QPnJP2n0giG5ohxRnk13MIQoYiR0w03S33rAhL4xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722281224; c=relaxed/simple;
	bh=cvfsAHSi0d/dgRWJetm1h/PLtW/nC7SPpo8BdBSh174=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lyru3wwB3y7W8Ihhr4tTr+Kzq/3hMY8i6vjbAqPBPiBqGDiDpb+JfOBCtID1c3Zab0aO6AWasylcuSw7TrSXZStVJqua4KI3fH3EhNgf0ZVBltTlDdQWYHuHVeSf1StwVrIDsFDGaw1yRm4Qc0sjkG1yWD05i8a90uv59EmYNHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VliUM/b6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=f7J9uxb/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=s69QFT0M; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=u5FK5zBv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EEAB11F7B7;
	Mon, 29 Jul 2024 19:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722281220; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ap1CzPaQNwLMZeEIW6gyKI8pGrm9CZN65+dOLmY4P3U=;
	b=VliUM/b6VWpb27ZaZ24e37m5yPfrVX8wD6h+TLPdru4kSlwBpSU+e/fgbFAkVimaJqhZlu
	T3ULJjgsuCPaTyb06A4EoT9IczZh7saH9TYDFe4bxDgVqagPzFVk0SuFx+aHbpNtcuw7Dp
	dOMq01hobuaYyrw4DKLZ1FZ5N4/tjzs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722281220;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ap1CzPaQNwLMZeEIW6gyKI8pGrm9CZN65+dOLmY4P3U=;
	b=f7J9uxb/14xDOSETXcQHsbDNG6dnajRdOnwdZKTKLGMLaTd1u9eajxFj2e4q7tr5tfW7qJ
	Cn7JiCGsSRZQurAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722281218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ap1CzPaQNwLMZeEIW6gyKI8pGrm9CZN65+dOLmY4P3U=;
	b=s69QFT0M1jaEEoIyemRP4nmXu+g4fEQed9H+o23IMdvnXyiYpCsknxXNTDK/zt7opkpOuK
	NKyHcKPslD23f/IUTt84ZingYVyWWjdOIup2Acghq77j11I6GXqNz/pgWre+/Tfsg2dUaw
	ZtuI+Z5z04epmG+tuTLyo5HIeBZkAjQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722281218;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ap1CzPaQNwLMZeEIW6gyKI8pGrm9CZN65+dOLmY4P3U=;
	b=u5FK5zBv/I7ikIqK/JCXDhj8aV0EV/O3VeWTBQvrzIBtrpA8NTWYoQAYPShS72vW33kDZb
	E4jpYECuYeoj7cCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C1229138A7;
	Mon, 29 Jul 2024 19:26:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Opr7LQLtp2YYPAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 29 Jul 2024 19:26:58 +0000
Date: Mon, 29 Jul 2024 21:27:34 +0200
Message-ID: <87jzh49exl.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Simon Trimmer <simont@opensource.cirrus.com>
Cc: <tiwai@suse.com>,
	<linux-sound@vger.kernel.org>,
	<alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>,
	<patches@opensource.cirrus.com>
Subject: Re: [PATCH] ALSA: hda: cs35l56: Stop creating ALSA controls for firmware coefficients
In-Reply-To: <019d01dae1da$bc32b1d0$34981570$@opensource.cirrus.com>
References: <20240729161532.147893-1-simont@opensource.cirrus.com>
	<019d01dae1da$bc32b1d0$34981570$@opensource.cirrus.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-3.10 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,alsa-project.org:email,suse.com:email,cirrus.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.10

On Mon, 29 Jul 2024 19:14:13 +0200,
Simon Trimmer wrote:
> 
> Apologies Takashi - can you ignore this one please? It will need a V2

Sure.


thanks,

Takashi

> 
> > -----Original Message-----
> > From: Simon Trimmer <simont@opensource.cirrus.com>
> > Sent: Monday, July 29, 2024 5:16 PM
> > To: tiwai@suse.com
> > Cc: linux-sound@vger.kernel.org; alsa-devel@alsa-project.org; linux-
> > kernel@vger.kernel.org; patches@opensource.cirrus.com; Simon Trimmer
> > <simont@opensource.cirrus.com>
> > Subject: [PATCH] ALSA: hda: cs35l56: Stop creating ALSA controls for
> firmware
> > coefficients
> > 
> > A number of laptops have gone to market with old firmware versions that
> > export controls that have since been hidden, but we can't just install a
> > newer firmware because the firmware for each product is customized and
> > qualified by the OEM. The issue is that alsactl save and restore has no
> > idea what controls are good to persist which can lead to
> > misconfiguration.
> > 
> > As the ALSA controls for the firmware coefficients are not used in
> > normal operation they can all be hidden, but add a kernel parameter so
> > that they can be re-enabled for debugging.
> > 
> > Fixes: 73cfbfa9caea ("ALSA: hda/cs35l56: Add driver for Cirrus Logic
> CS35L56
> > amplifier")
> > Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
> > ---
> >  sound/pci/hda/cs35l56_hda.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/sound/pci/hda/cs35l56_hda.c b/sound/pci/hda/cs35l56_hda.c
> > index 96d3f13c5abf..1494383b22c9 100644
> > --- a/sound/pci/hda/cs35l56_hda.c
> > +++ b/sound/pci/hda/cs35l56_hda.c
> > @@ -23,6 +23,10 @@
> >  #include "hda_cs_dsp_ctl.h"
> >  #include "hda_generic.h"
> > 
> > +static bool expose_dsp_controls;
> > +module_param(expose_dsp_controls, bool, 0444);
> > +MODULE_PARM_DESC(expose_dsp_controls, "Expose firmware controls as
> > ALSA controls 0=no (default), 1=yes");
> > +
> >   /*
> >    * The cs35l56_hda_dai_config[] reg sequence configures the device as
> >    *  ASP1_BCLK_FREQ = 3.072 MHz
> > @@ -758,6 +762,9 @@ static int cs35l56_hda_bind(struct device *dev, struct
> > device *master, void *mas
> > 
> >  	cs35l56_hda_create_controls(cs35l56);
> > 
> > +	if (expose_dsp_controls)
> > +		cs35l56_hda_add_dsp_controls(cs35l56);
> > +
> >  #if IS_ENABLED(CONFIG_SND_DEBUG)
> >  	cs35l56->debugfs_root = debugfs_create_dir(dev_name(cs35l56-
> > >base.dev), sound_debugfs_root);
> >  	cs_dsp_init_debugfs(&cs35l56->cs_dsp, cs35l56->debugfs_root);
> > --
> > 2.43.0
> 
> 

