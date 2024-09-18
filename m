Return-Path: <linux-kernel+bounces-332370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F69297B8F6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 10:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2F84B280E2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 08:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17893170A27;
	Wed, 18 Sep 2024 08:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hwObczKK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aKyjuGee";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cK5ofELI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/sz8tx6+"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F1D34CDD;
	Wed, 18 Sep 2024 08:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726646721; cv=none; b=UIM+QRwdGQgydDT6TvozC8wcHFQIk+nB54Ld0B13t9LkBppWLW1JkjOGS8lMfqG6vEUtT2/C7FHZ5ZsGlKNAybW7Ll5yafgqnDs/tMBao0qF9PthgwatjM1Gedaz2aV73BhcxCjVK+cp2dLY5Wqz9aBxzQdy1v/tweNOBGuu8cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726646721; c=relaxed/simple;
	bh=hMFeXQZRHn8UB2b48vO/INvfoZ45GI6TKEEB4599HkA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hbsa/Dzh+bSpTG+bg54FZlRbN1gCOviYlNq5JXN4O3nhxcjheZZBBYrJjm8eFat68wDOWriz/BEVbhhycmFOBsEOF3/FYXdNtATbTrBCdrgTNygVr8Kydg0g5as/muEkQUmPItzXJ9/Bs9GXK79O9GChdChbjIYhU97f2BWsMnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hwObczKK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aKyjuGee; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cK5ofELI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/sz8tx6+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EFDA21FBB5;
	Wed, 18 Sep 2024 08:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726646712; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iRb6bhUWnfap7Hi0tQE7Q46cU6rKKKEkL1LdvSyKE34=;
	b=hwObczKKsvudn5VmkoySwCfL+3jwY5o4EW2Kkxv5nQpTftRCbnvVoyC3hBObBZTSjfKwVK
	oRDv18Wt1Q1zymP5pY/RyqKnbIgJxnB4K3cvyP5sqj8MhIFBXPl0uabESsEDk4pFhLv5+2
	9p47QyS4XPdXn1HBpMJc3IMBA+1e06U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726646712;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iRb6bhUWnfap7Hi0tQE7Q46cU6rKKKEkL1LdvSyKE34=;
	b=aKyjuGeeWte7+hYVvmhDGlJJPU9wmYUr03NAD8+wG71U+doC4rPFwErOgSWDYN9vGnCQfs
	Kg6xW9w4nG6x+RCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cK5ofELI;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/sz8tx6+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726646710; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iRb6bhUWnfap7Hi0tQE7Q46cU6rKKKEkL1LdvSyKE34=;
	b=cK5ofELIJK/qJAmUPiFdayjaLFQt255Uo12uNmfeXonSuvCrOoJEoF2IebF+nxMxyBArYO
	dbVh/Lrg+z46JOqJf95359QB2QwFIBGDP8TBjsBk9M03GA3IVaYDL/VeoEqAoiwQd+moLS
	JOiDCN1kp0uYA03pL52FrsP+/h5YPOo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726646710;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iRb6bhUWnfap7Hi0tQE7Q46cU6rKKKEkL1LdvSyKE34=;
	b=/sz8tx6+f/4xxKdpoLp8G3VXfdSqp2Lc+f3OkludsFrOD2LefO/zPFUezBj0esfSaDYhfa
	TYlRwm1fgtkZQ9Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF33613A57;
	Wed, 18 Sep 2024 08:05:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fq93KbaJ6mazVQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 18 Sep 2024 08:05:10 +0000
Date: Wed, 18 Sep 2024 10:06:01 +0200
Message-ID: <87setxe68m.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Jerry Luo <jerryluo225@gmail.com>
Cc: Christoffer Sandberg <cs@tuxedo.de>,
	Christian Heusel <christian@heusel.eu>,
	Werner Sembach <wse@tuxedocomputers.com>,
	regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.de>
Subject: Re: [REGRESSION][BISECTED] Audio volume issues since 4178d78cd7a8
In-Reply-To: <1fbba03e-56b8-4e74-adf6-998e3a2d9dac@gmail.com>
References: <c930b6a6-64e5-498f-b65a-1cd5e0a1d733@heusel.eu>
	<87jzfbh5tu.wl-tiwai@suse.de>
	<66dfd536-ae17-4d75-b514-7931a3734e54@gmail.com>
	<20f70c0a92a27db29f188e05c33ba82c@tuxedo.de>
	<1fbba03e-56b8-4e74-adf6-998e3a2d9dac@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EFDA21FBB5
X-Spam-Level: 
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -5.51
X-Spam-Flag: NO

On Tue, 17 Sep 2024 23:16:08 +0200,
Jerry Luo wrote:
> 
> On 9/17/24 5:50 AM, Christoffer Sandberg wrote:
> 
> > From the dmesg logs it does look like the quirk is applied. Assuming
> > the pci ids collide between these models (or the model param is used)
> > which would explain why it gets applied:
> > 
> > 1. Does the device have dual speaker pairs? If so (or if in doubt),
> >    check alsamixer for the codec and play around with the volume knobs
> >    to see if the controls affect the individual speaker pairs. Or try
> >    this https://github.com/alsa-project/alsa-ucm-conf/pull/410 to control
> >    both with the system volume control
> > 2. If the device does not have dual speakers the quirk application
> > probably
> >    needs to be extended with DMI specific info to limit it more.
> > 
> > Let me know how it works,
> > 
> > Christoffer
> 
> From what I am can tell, and as mentioned in the tech specs, the
> laptop only have two speakers, unlike the Sirius series.
> 
> In case I didn't make it clear enough, the audio volume is normal now
> for some unknown reasons. And no matter which kernel I change to, the
> issue doesn't reappear.
> 
> If you want a dmesg log from the kernel that used to not work, or any
> other info, please let me know.

I don't see any relevant about the incorrect volumes by the suggested
commit, but at least we should avoid applying the quirk for a
non-existing speaker pin.

Jerry, yours is with CX11970 (codec id 0x14f120d0), right?

Werner, how about your Sirius models?  Are they also with the same
codec chip?  If they are different, we can have the additional checks
for judging whether to apply the pincfg fix or not.


thanks,

Takashi

