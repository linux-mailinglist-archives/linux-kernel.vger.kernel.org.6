Return-Path: <linux-kernel+bounces-284943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 522D9950727
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 16:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 092CA287EF1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B235219D8A2;
	Tue, 13 Aug 2024 14:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WA4/3WvT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rLTx3wgS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WA4/3WvT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rLTx3wgS"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2249719B3DD;
	Tue, 13 Aug 2024 14:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723557918; cv=none; b=SfAmBrWx0FzIH1Wvpz0H9OoKZvVevrYaHyWfnAtc2J5xNwug8jH28cHLwrwT7nY0Ugks+pEBx9h51O7BM+LeYiH75K7DGZsths8e/W2HNHzVJucsJ9WPnO9hApzCuCT+yM0cFkdFXA4yAJSQB27UJizaS/ZpXS4CUYMF3cYINQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723557918; c=relaxed/simple;
	bh=bivMz5afMh+YjXijC3ua60okr8l7GoSWglHjdF9sPl8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ewxfbZAcC0KHguzIVzZx7y5ZqQYXrJU3y/tw2VNza4qq2VGBSBYCrgrl89arJCM2hiSUUJ73bPpeIYQlfgV8wCUacSNVxg1605q8S+DcgGR8GD/22xp5hWdVyYRJ3XBaDIsCQJ65x51HEkkmQ4anxMx1yZ03bY7aJkrJ1nk61sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WA4/3WvT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rLTx3wgS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WA4/3WvT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rLTx3wgS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3603C203C1;
	Tue, 13 Aug 2024 14:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723557914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/V9VZIIGiqqkowv9k8jSQztQwc1NsJKwIYZhzHqS/sc=;
	b=WA4/3WvT/2aF3ZEg/J2yhK6cAkvyMAz+MpEbonJ3lVYkzzE1TtgoTUV5qMBS3/A1FXJ3KN
	+IWoBqN+vMeTRNkiv/oY0dCg+NhS0t5Odg/2q21uZa5syaN+DZKit4zlQaYI0y0sKKv0yO
	/n91ntvW9omIwqCDvk3JoZsr0kwGmSc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723557914;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/V9VZIIGiqqkowv9k8jSQztQwc1NsJKwIYZhzHqS/sc=;
	b=rLTx3wgSd3lQWWGHuPZW//gkahiylTIe394ImwG7ykIK5VKpwgHdzgF2+0CcIkfu9Q4e9h
	qpVKme1yLhLzVqCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723557914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/V9VZIIGiqqkowv9k8jSQztQwc1NsJKwIYZhzHqS/sc=;
	b=WA4/3WvT/2aF3ZEg/J2yhK6cAkvyMAz+MpEbonJ3lVYkzzE1TtgoTUV5qMBS3/A1FXJ3KN
	+IWoBqN+vMeTRNkiv/oY0dCg+NhS0t5Odg/2q21uZa5syaN+DZKit4zlQaYI0y0sKKv0yO
	/n91ntvW9omIwqCDvk3JoZsr0kwGmSc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723557914;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/V9VZIIGiqqkowv9k8jSQztQwc1NsJKwIYZhzHqS/sc=;
	b=rLTx3wgSd3lQWWGHuPZW//gkahiylTIe394ImwG7ykIK5VKpwgHdzgF2+0CcIkfu9Q4e9h
	qpVKme1yLhLzVqCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 04A6B13ABD;
	Tue, 13 Aug 2024 14:05:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id USWTABpou2a1IQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 13 Aug 2024 14:05:14 +0000
Date: Tue, 13 Aug 2024 16:05:50 +0200
Message-ID: <874j7omsap.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Zeno Endemann <zeno.endemann@mailbox.org>
Cc: Takashi Iwai <tiwai@suse.de>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
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
In-Reply-To: <f41762a1-048c-4ab6-86ae-f364753210c7@mailbox.org>
References: <20240812142029.46608-1-zeno.endemann@mailbox.org>
	<dec71400-81f1-4ca6-9010-94b55ecdaafa@linux.intel.com>
	<3e9cd14b-7355-4fde-b0c1-39d40467e63c@mailbox.org>
	<8c71ea3d-5c97-423e-a270-3184c16e1603@linux.intel.com>
	<c2a46079-b9fa-46fb-8d2d-e01e5d620ea7@mailbox.org>
	<878qx0mtfe.wl-tiwai@suse.de>
	<f41762a1-048c-4ab6-86ae-f364753210c7@mailbox.org>
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
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.994];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, 13 Aug 2024 15:58:13 +0200,
Zeno Endemann wrote:
> 
> Takashi Iwai wrote on 13.08.24 15:41:
> > On Tue, 13 Aug 2024 14:54:42 +0200,
> > Zeno Endemann wrote:
> >> 
> >> Pierre-Louis Bossart wrote on 13.08.24 10:04:
> >>> by focusing on the trigger timestamp I think you're looking at the wrong
> >>> side of the problem. The timestamping is improved by using the same
> >>> hardware counter for the trigger AND regular timestamp during
> >>> playback/capture. If you look at a hardware counter during
> >>> playback/capture but the start position is recorded with another method,
> >>> would you agree that there's a systematic non-reproducible offset at
> >>> each run? You want the trigger and regular timestamps to be measured in
> >>> the same way to avoid measurement differences.
> >> 
> >> I am not sure what you are talking about. I have not seen any place in the
> >> code where the trigger timestamp is taken in any other more sophisticated
> >> way than what the default is doing, i.e. calling snd_pcm_gettime. So I do
> >> not see how your custom *trigger* timestamps are done "with another method".
> >> 
> >>> I will not disagree that most applications do not need precise
> >>> timestamping, but if you want to try to enable time-of-flight
> >>> measurements for presence or gesture detection you will need higher
> >>> sampling rates and micro-second level accuracy.
> >> 
> >> I don't know, this sounds very theoretical at best to me. However I do not
> >> have the desire to try to further argue and convince you otherwise.
> >> 
> >> Do you want to propose a different solution for the stop trigger timestamp
> >> bug? That is my main goal after all.
> > 
> > Ah, I guess that the discussion drifted because of misunderstanding.
> > 
> > This isn't about the accuracy of the audio timestamp, but rather the
> > timing of trigger tstamp.  The commit 2b79d7a6bf34 ("ALSA: pcm: allow
> > for trigger_tstamp snapshot in .trigger") allowed the trigger_tstamp
> > taken in the driver's trigger callback.  But, the effectiveness of
> > this change is dubious, because the timestamp taken in the usual code
> > path in PCM core is right after the trigger callback, hence the
> > difference should be negligible -- that's the argument.
> 
> Exactly. Sorry if my communication was not clear on that.
> 
> > 
> > No matter how the fix will be, could you put the Fixes tag pointing to
> > the culprit commit(s) at the next submission?
> 
> Will do. I guess I'll have to look up which commit actually enabled the
> trigger_tstamp_latched in hda, as 2b79d7a6bf34 has no driver using that
> yet, so is not technically the culprit?

You can take the HD-audio side, the commit ed610af86a71 ("ALSA: hda:
read trigger_timestamp immediately after starting DMA") instead, too.
Maybe it doesn't matter much which commit is chosen; both should
appear in the same kernel version.


thanks,

Takashi

