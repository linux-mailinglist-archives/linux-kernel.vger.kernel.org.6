Return-Path: <linux-kernel+bounces-228960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A00891691B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FEBD28AE78
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 13:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C5116A37C;
	Tue, 25 Jun 2024 13:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ga1bEF6v";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WHCYmOdF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ga1bEF6v";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WHCYmOdF"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C974158A03;
	Tue, 25 Jun 2024 13:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719322602; cv=none; b=aoYshfAm5JVOZXrUU1smuh/OwNmuAcdh1xwCqQzdO6HT2Gc0ugabcRbBUSRnsCff9OPsnjW2AGdsCke2yzHJk1LKi1sbjxqu/k8AVcClBH4Vk3ebSoiiLGFW3hysQ0bBDWTOWzfC7FvxQpJpYX26G86gnOaZkgRAwFt4zQ7VIJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719322602; c=relaxed/simple;
	bh=2NNrfxdGHRIS9EPNSQASsFMV9IUSfTj+l1pLf5bdFn0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rxAnEZM1MzBRAOwRxNJFnWYE7woOuQyU+8Abrd30ObFKb+QATh2lWKVNQxzkzwRAcrYqPBIjYs5Xuld32fRA0tVmBzpTcjunRfXQ9drIeD4ho0UpAa5Cd8tl/FLXRUNGbN6rPMoEYu9A4i6WdaBb0LICfhaWaPpVUOdWbQXSBIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ga1bEF6v; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WHCYmOdF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ga1bEF6v; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WHCYmOdF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 28AA61F455;
	Tue, 25 Jun 2024 13:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719322599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BjJvQF5Kx2DUvlD3SHvk77Gtd8qjlI64dqtGYtiomQY=;
	b=ga1bEF6vZL7POkidm81twLxaoHimWh6jC3rbzv/xK6NBqAE7YdmotvR/re6lLYoX4CmKKa
	xY+E24J/LwcA1M2nlg8G66Nc92JW1MWpQhMlTEOFhPHRoUpu+6UplNzg+JJiLzKladkqhM
	JxuMCY3tzqULDhfGwLy4/I1y7rFDax4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719322599;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BjJvQF5Kx2DUvlD3SHvk77Gtd8qjlI64dqtGYtiomQY=;
	b=WHCYmOdFyeWNEe1ujV2pojCdKscAUeEoqETCAuXoX011PuARYfkweT5nYYv5FFwOPTeGF6
	qRYHPd8rfLHDRFAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719322599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BjJvQF5Kx2DUvlD3SHvk77Gtd8qjlI64dqtGYtiomQY=;
	b=ga1bEF6vZL7POkidm81twLxaoHimWh6jC3rbzv/xK6NBqAE7YdmotvR/re6lLYoX4CmKKa
	xY+E24J/LwcA1M2nlg8G66Nc92JW1MWpQhMlTEOFhPHRoUpu+6UplNzg+JJiLzKladkqhM
	JxuMCY3tzqULDhfGwLy4/I1y7rFDax4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719322599;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BjJvQF5Kx2DUvlD3SHvk77Gtd8qjlI64dqtGYtiomQY=;
	b=WHCYmOdFyeWNEe1ujV2pojCdKscAUeEoqETCAuXoX011PuARYfkweT5nYYv5FFwOPTeGF6
	qRYHPd8rfLHDRFAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED91E13A9A;
	Tue, 25 Jun 2024 13:36:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yjFYOebHemYUHAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 25 Jun 2024 13:36:38 +0000
Date: Tue, 25 Jun 2024 15:37:06 +0200
Message-ID: <871q4lm9dp.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Gergo Koteles <soyer@irl.hu>
Cc: Rauty <rautyrauty@gmail.com>,
	alsa-devel@alsa-project.org,
	tiwai@suse.com,
	perex@perex.cz,
	kailang@realtek.com,
	sbinding@opensource.cirrus.com,
	luke@ljones.dev,
	shenghao-ding@ti.com,
	simont@opensource.cirrus.com,
	foss@athaariq.my.id,
	rf@opensource.cirrus.com,
	wzhd@ustc.edu,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ALSA: hda/realtek: Enable headset mic on IdeaPad 330-17IKB 81DM
In-Reply-To: <c0a9e15e7926e098bdea97a7d31c32427e0910c9.camel@irl.hu>
References: <20240615125457.167844-1-rauty@altlinux.org>
	<2c9ba341bc95d4b9010bf5f8794c0d14b1c57dc9.camel@irl.hu>
	<CAGpJQTHoBAixmxta2WuZfjHjiK9GXF=hkfPyV7PBD5rt9Z_0WA@mail.gmail.com>
	<CAGpJQTGqxEkfp003QLsp-syUgzDFCmHSmNaoOaem0ZMVf7_=bg@mail.gmail.com>
	<c0a9e15e7926e098bdea97a7d31c32427e0910c9.camel@irl.hu>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,alsa-project.org,suse.com,perex.cz,realtek.com,opensource.cirrus.com,ljones.dev,ti.com,athaariq.my.id,ustc.edu,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 

On Tue, 25 Jun 2024 15:32:16 +0200,
Gergo Koteles wrote:
> 
> Hey Rauty,
> 
> On Mon, 2024-06-24 at 11:25 +0300, Rauty wrote:
> > I haven't changed the patch yet, but it's already in the stable-queue:
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/queue-5.10/alsa-hda-realtek-enable-headset-mic-on-ideapad-330-1.patch
> > Do you still need changes from me?
> 
> I still think this breaks Duet 7 sound, because snd_hda_pick_fixup
> function picks the PCI SSIDs before Codec SSIDs.
> But maybe I missed something.
> 
> Takashi, what do you think?

Hm, a breakage looks possible, indeed.  I naively thought it being a
same model, but this is a different one.

We need an additional codec vendor or SSID check as done for other
machines.


Takashi

