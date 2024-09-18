Return-Path: <linux-kernel+bounces-332372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB3E97B8FA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 10:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E01651F216E2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 08:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BB7176230;
	Wed, 18 Sep 2024 08:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="R1YJ/qhR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Wgm78cXi";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="miBSuaYS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gPNtlZnn"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2745F14A0A4;
	Wed, 18 Sep 2024 08:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726646903; cv=none; b=I5WpZJgoRs2aOSubUcXeqdOQXnfITFgTuYXMEhLSW+mOt5lVmgT9+vtw6rLS8JEbKrfjSecqQxNot52Up7503u+NuK2aIisIy5/LnwccbHxTqe4bbKsMz6EDPHWpvbDZsLWyKgx+viMgswuMTSVVG4txFtMnhFqjnAIw0ug3X74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726646903; c=relaxed/simple;
	bh=mdLJ7ZLU9vxZx51pje0sV6Xwgy1GiyxiDE2P8wEYh7k=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S0DTmULxLj9pRsJ/jCba5jmXMYSX7a4BttbJg2N32oEMRzGfBsPaPuRRGNI0t4dQ9kHddm3G1frkOAFxOmIWdwWPwj9ohNYpn1P/9uPVKU/aK/KJ1QZCK+3uFqwekkaAw+FxQfpnwdLXntGBKJEzKjt90AchIzRDhJJQmj2wGBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=R1YJ/qhR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Wgm78cXi; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=miBSuaYS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gPNtlZnn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3CD741FBB5;
	Wed, 18 Sep 2024 08:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726646900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pxliENHXGWSgt3jZX5k5O8yPdk+geuL+rXsuaHaClHU=;
	b=R1YJ/qhRIwDSUSiuc2lFxrtW5DYfD0JlX3EFG4wdTqOXHXlktBZAwr4OBrsbjCBrDIBfhr
	aegDSPg26dlVfiCEz268H7HNYOEDxWhbCEb3svD1bkhYEURZ7Hs9Ib7g2XqwuIwbWrVMrF
	XuwxpZ8kyKV9SqsI7oqBDJJGjiIzs8M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726646900;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pxliENHXGWSgt3jZX5k5O8yPdk+geuL+rXsuaHaClHU=;
	b=Wgm78cXiduQBY5g4wDcr18J8YcMeVfFnE/hELdS4tCXMVk0mSVxh99WXkxJCGh4f2o7Whg
	xNdOYrjoOWkDOmDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726646899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pxliENHXGWSgt3jZX5k5O8yPdk+geuL+rXsuaHaClHU=;
	b=miBSuaYSE/Ug+JV3btTex5c9+LbKS1aNBYDB5v85v7JEt/hbAtXWPcF0LmkNhgtCpAjrw2
	o208EzG1ONOQU0Uqu5NZ41IgBNmW/wI/QTVk+Qy+1C9idzAkYqIzWGtc6V9t9lwyw0yvYn
	iAwn4ctkMmoYr2oDgEftLZdSNXDbVOc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726646899;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pxliENHXGWSgt3jZX5k5O8yPdk+geuL+rXsuaHaClHU=;
	b=gPNtlZnnwBJfiVP47XjAH5IaZ2oZ74b7Qh4o4ocqDaJVGEZ9Xt6cLpTgEmt4rIfgztRAWS
	CjzTTC8vVcLDVHBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EA5D613A57;
	Wed, 18 Sep 2024 08:08:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 881zN3KK6maNVgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 18 Sep 2024 08:08:18 +0000
Date: Wed, 18 Sep 2024 10:09:09 +0200
Message-ID: <87r09he63e.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jerry Luo <jerryluo225@gmail.com>,
	Christoffer Sandberg <cs@tuxedo.de>,
	Christian Heusel <christian@heusel.eu>,
	Werner Sembach <wse@tuxedocomputers.com>,
	regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	Jaroslav Kysela <perex@perex.cz>
Subject: Re: [REGRESSION][BISECTED] Audio volume issues since 4178d78cd7a8
In-Reply-To: <87setxe68m.wl-tiwai@suse.de>
References: <c930b6a6-64e5-498f-b65a-1cd5e0a1d733@heusel.eu>
	<87jzfbh5tu.wl-tiwai@suse.de>
	<66dfd536-ae17-4d75-b514-7931a3734e54@gmail.com>
	<20f70c0a92a27db29f188e05c33ba82c@tuxedo.de>
	<1fbba03e-56b8-4e74-adf6-998e3a2d9dac@gmail.com>
	<87setxe68m.wl-tiwai@suse.de>
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
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,tuxedo.de,heusel.eu,tuxedocomputers.com,lists.linux.dev,vger.kernel.org,perex.cz];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, 18 Sep 2024 10:06:01 +0200,
Takashi Iwai wrote:
> 
> On Tue, 17 Sep 2024 23:16:08 +0200,
> Jerry Luo wrote:
> > 
> > On 9/17/24 5:50 AM, Christoffer Sandberg wrote:
> > 
> > > From the dmesg logs it does look like the quirk is applied. Assuming
> > > the pci ids collide between these models (or the model param is used)
> > > which would explain why it gets applied:
> > > 
> > > 1. Does the device have dual speaker pairs? If so (or if in doubt),
> > >    check alsamixer for the codec and play around with the volume knobs
> > >    to see if the controls affect the individual speaker pairs. Or try
> > >    this https://github.com/alsa-project/alsa-ucm-conf/pull/410 to control
> > >    both with the system volume control
> > > 2. If the device does not have dual speakers the quirk application
> > > probably
> > >    needs to be extended with DMI specific info to limit it more.
> > > 
> > > Let me know how it works,
> > > 
> > > Christoffer
> > 
> > From what I am can tell, and as mentioned in the tech specs, the
> > laptop only have two speakers, unlike the Sirius series.
> > 
> > In case I didn't make it clear enough, the audio volume is normal now
> > for some unknown reasons. And no matter which kernel I change to, the
> > issue doesn't reappear.
> > 
> > If you want a dmesg log from the kernel that used to not work, or any
> > other info, please let me know.
> 
> I don't see any relevant about the incorrect volumes by the suggested
> commit, but at least we should avoid applying the quirk for a
> non-existing speaker pin.
> 
> Jerry, yours is with CX11970 (codec id 0x14f120d0), right?
> 
> Werner, how about your Sirius models?  Are they also with the same
> codec chip?
> If they are different, we can have the additional checks
> for judging whether to apply the pincfg fix or not.

Or it's a question to Christoffer.  Doesn't matter, if anyone can give
a info :)


thanks,

Takashi

