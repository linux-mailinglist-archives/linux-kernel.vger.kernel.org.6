Return-Path: <linux-kernel+bounces-284917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7DE9506D0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A8531C22930
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 13:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643DA19CCEF;
	Tue, 13 Aug 2024 13:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jTRpgT2O";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IBGmYGv7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jTRpgT2O";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IBGmYGv7"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E9919AD8E;
	Tue, 13 Aug 2024 13:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723556452; cv=none; b=a9ONKRMA52srTmLZXnmSui6gR7xOvg9wuIYxhL8XRypl6CTNkCROqUqvrRieQqsKDXTIV28rKUB+FUlvH2C+NFfJR6rY3npw8ZLbIWn9abcWE40+j1rjsMv35kF3tX2Rkvd3hi1uxkqOBOzlSJYCOy1Z7DlGL7AE1tbyqokGwyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723556452; c=relaxed/simple;
	bh=zpy6lireVql7psMi9v3QBs+29qnTrxr0ZqbMt5hVgVo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j0P1JR4HtvDAsLOox78iHfbY4PiU+l+llWXN/VCj63q1ZHhD6VBSTGLikAJ/d5xBu2fUI0pk0WwsIjyualQx+aGIEXwVJhSJOKDooy0qXb1mn5Fuc0VqfnxlWwYD0FDQvSF27sDIOSLK+IokprPq2IW1NhMEO/coXY1LCHFnalg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jTRpgT2O; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IBGmYGv7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jTRpgT2O; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IBGmYGv7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4B4EC227F0;
	Tue, 13 Aug 2024 13:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723556449; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rZdCZHI6RH6SXp15uNkpWZfEU8RDBNLc9FuD4tDaQhM=;
	b=jTRpgT2O8yF/VNMlV0Gkjrtk5vW2p0roDX12qeXYy5/bWK4h5zBlgAp+c4tZp83m7r8zAP
	WppsPjzXrO6Xbm0TNA630OechGC05sxKVCJtCjsH4wTamEIq9cQzIjY2epJF0wjFIxZZmm
	3eJWLsmt6BlocXBM9NTpS/bZ/2Sl4gw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723556449;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rZdCZHI6RH6SXp15uNkpWZfEU8RDBNLc9FuD4tDaQhM=;
	b=IBGmYGv7cmwLID0uYB9ZbGbnGzm4qgQ3sJm89MhhLjSCfZWY+wMMZ6/3mCIBApUISva1Tc
	wS0o1HhWGycy+AAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jTRpgT2O;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=IBGmYGv7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723556449; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rZdCZHI6RH6SXp15uNkpWZfEU8RDBNLc9FuD4tDaQhM=;
	b=jTRpgT2O8yF/VNMlV0Gkjrtk5vW2p0roDX12qeXYy5/bWK4h5zBlgAp+c4tZp83m7r8zAP
	WppsPjzXrO6Xbm0TNA630OechGC05sxKVCJtCjsH4wTamEIq9cQzIjY2epJF0wjFIxZZmm
	3eJWLsmt6BlocXBM9NTpS/bZ/2Sl4gw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723556449;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rZdCZHI6RH6SXp15uNkpWZfEU8RDBNLc9FuD4tDaQhM=;
	b=IBGmYGv7cmwLID0uYB9ZbGbnGzm4qgQ3sJm89MhhLjSCfZWY+wMMZ6/3mCIBApUISva1Tc
	wS0o1HhWGycy+AAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1457513ABD;
	Tue, 13 Aug 2024 13:40:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id F54RBGFiu2ZSGQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 13 Aug 2024 13:40:49 +0000
Date: Tue, 13 Aug 2024 15:41:25 +0200
Message-ID: <878qx0mtfe.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Zeno Endemann <zeno.endemann@mailbox.org>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Christian Brauner <brauner@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Pavel Hofman <pavel.hofman@ivitera.com>,
	David Howells
 <dhowells@redhat.com>,
	Liam Girdwood <liam.r.girdwood@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: Re: [PATCH] ALSA: core: Remove trigger_tstamp_latched
In-Reply-To: <c2a46079-b9fa-46fb-8d2d-e01e5d620ea7@mailbox.org>
References: <20240812142029.46608-1-zeno.endemann@mailbox.org>
	<dec71400-81f1-4ca6-9010-94b55ecdaafa@linux.intel.com>
	<3e9cd14b-7355-4fde-b0c1-39d40467e63c@mailbox.org>
	<8c71ea3d-5c97-423e-a270-3184c16e1603@linux.intel.com>
	<c2a46079-b9fa-46fb-8d2d-e01e5d620ea7@mailbox.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.51
X-Rspamd-Queue-Id: 4B4EC227F0
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spam-Flag: NO

On Tue, 13 Aug 2024 14:54:42 +0200,
Zeno Endemann wrote:
> 
> Pierre-Louis Bossart wrote on 13.08.24 10:04:
> > by focusing on the trigger timestamp I think you're looking at the wrong
> > side of the problem. The timestamping is improved by using the same
> > hardware counter for the trigger AND regular timestamp during
> > playback/capture. If you look at a hardware counter during
> > playback/capture but the start position is recorded with another method,
> > would you agree that there's a systematic non-reproducible offset at
> > each run? You want the trigger and regular timestamps to be measured in
> > the same way to avoid measurement differences.
> 
> I am not sure what you are talking about. I have not seen any place in the
> code where the trigger timestamp is taken in any other more sophisticated
> way than what the default is doing, i.e. calling snd_pcm_gettime. So I do
> not see how your custom *trigger* timestamps are done "with another method".
> 
> > I will not disagree that most applications do not need precise
> > timestamping, but if you want to try to enable time-of-flight
> > measurements for presence or gesture detection you will need higher
> > sampling rates and micro-second level accuracy.
> 
> I don't know, this sounds very theoretical at best to me. However I do not
> have the desire to try to further argue and convince you otherwise.
> 
> Do you want to propose a different solution for the stop trigger timestamp
> bug? That is my main goal after all.

Ah, I guess that the discussion drifted because of misunderstanding.

This isn't about the accuracy of the audio timestamp, but rather the
timing of trigger tstamp.  The commit 2b79d7a6bf34 ("ALSA: pcm: allow
for trigger_tstamp snapshot in .trigger") allowed the trigger_tstamp
taken in the driver's trigger callback.  But, the effectiveness of
this change is dubious, because the timestamp taken in the usual code
path in PCM core is right after the trigger callback, hence the
difference should be negligible -- that's the argument.

No matter how the fix will be, could you put the Fixes tag pointing to
the culprit commit(s) at the next submission?


thanks,

Takashi

