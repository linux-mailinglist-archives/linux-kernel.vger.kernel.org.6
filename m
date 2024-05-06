Return-Path: <linux-kernel+bounces-169436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD8A8BC89C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 09:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 287FBB21CCF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 07:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8EC140E2B;
	Mon,  6 May 2024 07:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yhFFlPJx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xrGO7U3n";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yhFFlPJx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xrGO7U3n"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCE314039E;
	Mon,  6 May 2024 07:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714981884; cv=none; b=lrtzUQ0fkvbU7usPPaPyKfLLyQ/1soQZNAfAm5ibTTKJYyD21bRbOqU4h1JeowcGPaAt8Bs/aK2nTxmj24Up3IV8ZJtqa4runw60srKFF6G1wQLLuwV0MQfNfMv+inChxXFsejCVg5IbVlJyqTCQQVEW8XoApOOHGx5WvB1FU3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714981884; c=relaxed/simple;
	bh=Yi1qwZhhBmPO560FIdmxT+mud+5dEx4hOqdd2jyqSzs=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eD1EoH3cbfGMRaeca+tu03rd9g6soyK/7WiBI0Tw6sbZQaMouJsWvqO4L6+B9ftx8GiP96cWkJUlmO17qUrv9zuAlyH5DSmJqFbzIi2H/Oqm+9M4cXowxXeMXTkhP7y7hhieDkSGdStFwcWE/JHLS+ToE267xWdT8+KoB15ZR4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yhFFlPJx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xrGO7U3n; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yhFFlPJx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xrGO7U3n; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 826F85F983;
	Mon,  6 May 2024 07:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714981881; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6AEMocBpEuQxKMzcluqSd6YGePkkcrRGPGY8X/G3p8o=;
	b=yhFFlPJxe0hkHTweCAJqXxgEBtvyik4+jxjmebutSOzfbal0sNkr2WIEexZ0AWBLTMLIYL
	airlFYBzNriVTYGjioJkBCYpJ2kJlRBpkffIw6WggnYs/2qqo6nswFGvKHTphWjhzf4vBP
	asvcPRFSLLKkQHvop3ZLbzmvtvz0NBo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714981881;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6AEMocBpEuQxKMzcluqSd6YGePkkcrRGPGY8X/G3p8o=;
	b=xrGO7U3ncdNxBnh+hJ0Q81pUoPnFiHS+6QqV1Rs9Qpn8rRnD+7a5PxwdFomKpeb7VWge5F
	78FIUrilgoTbAWAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714981881; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6AEMocBpEuQxKMzcluqSd6YGePkkcrRGPGY8X/G3p8o=;
	b=yhFFlPJxe0hkHTweCAJqXxgEBtvyik4+jxjmebutSOzfbal0sNkr2WIEexZ0AWBLTMLIYL
	airlFYBzNriVTYGjioJkBCYpJ2kJlRBpkffIw6WggnYs/2qqo6nswFGvKHTphWjhzf4vBP
	asvcPRFSLLKkQHvop3ZLbzmvtvz0NBo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714981881;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6AEMocBpEuQxKMzcluqSd6YGePkkcrRGPGY8X/G3p8o=;
	b=xrGO7U3ncdNxBnh+hJ0Q81pUoPnFiHS+6QqV1Rs9Qpn8rRnD+7a5PxwdFomKpeb7VWge5F
	78FIUrilgoTbAWAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 46F4313A25;
	Mon,  6 May 2024 07:51:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id j4UvEPmLOGbFYAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 06 May 2024 07:51:21 +0000
Date: Mon, 06 May 2024 09:51:35 +0200
Message-ID: <87y18ngyyg.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: ArcticLampyrid <ArcticLampyrid@outlook.com>
Cc: tiwai@suse.de,
	Jaroslav Kysela <perex@perex.cz>,
	sbinding@opensource.cirrus.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	rf@opensource.cirrus.com
Subject: Re: [PATCH v4 0/1] ALSA: hda/realtek: Fix internal speakers for Legion Y9000X 2022 IAH7
In-Reply-To: <TYCP286MB2535FAD4F73A78C410CE11F0C41C2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
References: <TYCP286MB2535F8C34EB5E3D826B74C17C41C2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
	<05819798-2ac2-4aed-9f4f-0494c4c24159@perex.cz>
	<TYCP286MB2535FAD4F73A78C410CE11F0C41C2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -3.26
X-Spam-Level: 
X-Spamd-Result: default: False [-3.26 / 50.00];
	BAYES_HAM(-2.96)[99.84%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[outlook.com];
	FREEMAIL_ENVRCPT(0.00)[outlook.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,outlook.com:email]

On Mon, 06 May 2024 09:32:56 +0200,
ArcticLampyrid wrote:
> 
> > On 06. 05. 24 9:27, ArcticLampyrid wrote:
> > > This fixes the sound not working from internal speakers on
> > > Lenovo Legion Y9000X 2022 IAH7 models.
> > > 
> > > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218744
> > > 
> > > This patch depends on [PATCH v1 1/2] ALSA: hda: cs35l41: Ignore errors
> > > when configuring IRQs (by Stefan Binding) See also
> > > <https://lore.kernel.org/lkml/20240429154853.9393-2-sbinding@opensource.c
> > > irrus.com/>
> > We don't accept commits from anonymous sources. Please, follow
> > Documentation/process/submitting-patches.rst .
> > 
> > 					Jaroslav
> 
> I've signed it off in commit message.
> > Signed-off-by: Junhao Pei <ArcticLampyrid@outlook.com>

The From line doesn't match with your Signed-off-by line.
Please align it and resubmit.


thanks,

Takashi

