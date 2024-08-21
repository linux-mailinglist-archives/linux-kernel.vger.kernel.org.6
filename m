Return-Path: <linux-kernel+bounces-295700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9D395A03B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 16:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4A871F227F4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66F9189908;
	Wed, 21 Aug 2024 14:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="J1oQ5qdN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="n7il+W+2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="J1oQ5qdN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="n7il+W+2"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3061B1D54;
	Wed, 21 Aug 2024 14:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724251435; cv=none; b=K46uxJkOCcPcXy2RTMH3RfU9lsuyFWA9WksGFByVGOpNvGri7kEh9f1tBYmawGIxYhn4aORBcalMU1PZW2NR8AOJwrNKKJDnYUdIaRQH3Jwr7gQgJgeD8ILfF/AhfKeis3JUzO1HxM1cUe2ZbyhKq0nCOqVjnAQZ8jiwvKuI1S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724251435; c=relaxed/simple;
	bh=v/6GVH8xpLutVChXmiQ6kR4HNusTI2WEkiGp1NyjZEU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mqk79SymngUl2Ao962JET+Yrivf0StGJ+P8An0bWCjI+mft/RJGLVMe8WjYqySjdjJKX62c79cta/IcoFAjmkon6lO1cRq6v8dM3TrRYgZ1gsrp6J44sNuhOT6wwPNe98feOCV1/LqX6AMpzMehpwoK8WVJPvSIx7nUHT261xZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=J1oQ5qdN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=n7il+W+2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=J1oQ5qdN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=n7il+W+2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8A4962225E;
	Wed, 21 Aug 2024 14:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724251431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dJp5DkQwJ8r/9WidG0zGOERMvvaDVGY3NFJu5F//CfU=;
	b=J1oQ5qdNJ+HGDDl9sVLG1a8nqVtgTx8Pprra3Wni7vEUG+uaQl4x98XEEo3RCBxet0gqhs
	Rq2pZDzQ7DcTm2YGu9HJ6ouPvF3Wtj4FX3LR6X908NZDJMN1pihqRyCK6qwfAzsYcvB6kh
	RjwpnlKdA4bFWVDpwaujE+HOi6Q64Nc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724251431;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dJp5DkQwJ8r/9WidG0zGOERMvvaDVGY3NFJu5F//CfU=;
	b=n7il+W+2fMDrxOQLZtGCJjfgYNPceUU/v80Zk5E5uCdM1arH9RsLMFr9o7kYffp4SNZoNl
	tfJLt04JOjB0dlCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724251431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dJp5DkQwJ8r/9WidG0zGOERMvvaDVGY3NFJu5F//CfU=;
	b=J1oQ5qdNJ+HGDDl9sVLG1a8nqVtgTx8Pprra3Wni7vEUG+uaQl4x98XEEo3RCBxet0gqhs
	Rq2pZDzQ7DcTm2YGu9HJ6ouPvF3Wtj4FX3LR6X908NZDJMN1pihqRyCK6qwfAzsYcvB6kh
	RjwpnlKdA4bFWVDpwaujE+HOi6Q64Nc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724251431;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dJp5DkQwJ8r/9WidG0zGOERMvvaDVGY3NFJu5F//CfU=;
	b=n7il+W+2fMDrxOQLZtGCJjfgYNPceUU/v80Zk5E5uCdM1arH9RsLMFr9o7kYffp4SNZoNl
	tfJLt04JOjB0dlCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B7A813770;
	Wed, 21 Aug 2024 14:43:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NDaKASf9xWbLOgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 21 Aug 2024 14:43:51 +0000
Date: Wed, 21 Aug 2024 16:44:33 +0200
Message-ID: <87frqyorzi.wl-tiwai@suse.de>
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
In-Reply-To: <aa308e18-f9e0-4b1a-b548-fcc61e641c6f@mailbox.org>
References: <20240812142029.46608-1-zeno.endemann@mailbox.org>
	<dec71400-81f1-4ca6-9010-94b55ecdaafa@linux.intel.com>
	<3e9cd14b-7355-4fde-b0c1-39d40467e63c@mailbox.org>
	<8c71ea3d-5c97-423e-a270-3184c16e1603@linux.intel.com>
	<c2a46079-b9fa-46fb-8d2d-e01e5d620ea7@mailbox.org>
	<878qx0mtfe.wl-tiwai@suse.de>
	<f41762a1-048c-4ab6-86ae-f364753210c7@mailbox.org>
	<874j7omsap.wl-tiwai@suse.de>
	<aa308e18-f9e0-4b1a-b548-fcc61e641c6f@mailbox.org>
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
	NEURAL_HAM_SHORT(-0.20)[-0.999];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.30
X-Spam-Flag: NO

On Wed, 21 Aug 2024 16:27:43 +0200,
Zeno Endemann wrote:
> 
> Takashi Iwai wrote on 13.08.24 16:05:
> > On Tue, 13 Aug 2024 15:58:13 +0200,
> > Zeno Endemann wrote:
> >> 
> >> Takashi Iwai wrote on 13.08.24 15:41:
> >>> On Tue, 13 Aug 2024 14:54:42 +0200,
> >>> Zeno Endemann wrote:
> >>>> 
> >>>> Pierre-Louis Bossart wrote on 13.08.24 10:04:
> >>>>> by focusing on the trigger timestamp I think you're looking at the wrong
> >>>>> side of the problem. The timestamping is improved by using the same
> >>>>> hardware counter for the trigger AND regular timestamp during
> >>>>> playback/capture. If you look at a hardware counter during
> >>>>> playback/capture but the start position is recorded with another method,
> >>>>> would you agree that there's a systematic non-reproducible offset at
> >>>>> each run? You want the trigger and regular timestamps to be measured in
> >>>>> the same way to avoid measurement differences.
> >>>> 
> >>>> I am not sure what you are talking about. I have not seen any place in the
> >>>> code where the trigger timestamp is taken in any other more sophisticated
> >>>> way than what the default is doing, i.e. calling snd_pcm_gettime. So I do
> >>>> not see how your custom *trigger* timestamps are done "with another method".
> >>>> 
> >>>>> I will not disagree that most applications do not need precise
> >>>>> timestamping, but if you want to try to enable time-of-flight
> >>>>> measurements for presence or gesture detection you will need higher
> >>>>> sampling rates and micro-second level accuracy.
> >>>> 
> >>>> I don't know, this sounds very theoretical at best to me. However I do not
> >>>> have the desire to try to further argue and convince you otherwise.
> >>>> 
> >>>> Do you want to propose a different solution for the stop trigger timestamp
> >>>> bug? That is my main goal after all.
> >>> 
> >>> Ah, I guess that the discussion drifted because of misunderstanding.
> >>> 
> >>> This isn't about the accuracy of the audio timestamp, but rather the
> >>> timing of trigger tstamp.  The commit 2b79d7a6bf34 ("ALSA: pcm: allow
> >>> for trigger_tstamp snapshot in .trigger") allowed the trigger_tstamp
> >>> taken in the driver's trigger callback.  But, the effectiveness of
> >>> this change is dubious, because the timestamp taken in the usual code
> >>> path in PCM core is right after the trigger callback, hence the
> >>> difference should be negligible -- that's the argument.
> >> 
> >> Exactly. Sorry if my communication was not clear on that.
> >> 
> >>> 
> >>> No matter how the fix will be, could you put the Fixes tag pointing to
> >>> the culprit commit(s) at the next submission?
> >> 
> >> Will do. I guess I'll have to look up which commit actually enabled the
> >> trigger_tstamp_latched in hda, as 2b79d7a6bf34 has no driver using that
> >> yet, so is not technically the culprit?
> > 
> > You can take the HD-audio side, the commit ed610af86a71 ("ALSA: hda:
> > read trigger_timestamp immediately after starting DMA") instead, too.
> > Maybe it doesn't matter much which commit is chosen; both should
> > appear in the same kernel version.
> 
> Well, I think I've waited a decent amount of time now for more comments.
> How do we proceed?
> 
> I'm still of the opinion that the removal is the most sensible solution,
> so if we agree I could prepare a V2 where I just improve the commit message
> a bit further.
> 
> But if we don't have a good enough consensus on this, I'd need some guidance
> which alternate path should be taken to at least fix the bug of bad stop
> trigger timestamps for hda devices (e.g. should I try to fix it also for
> soc/intel/skylake without any testing? That seems to me the only other place
> that should be affected, apart from the generic pci hda code).

IIUC, the achievement of the timestamp at the exact timing was the
goal of that change (which caused a regression unfortunately), so
keeping that feature may still make sense.  I'd rather try to fix in
HD-audio side at first.

If Pierre agrees with the removal of the local timestamp call, we can
revert to there afterwards, too.


thanks,

Takashi

