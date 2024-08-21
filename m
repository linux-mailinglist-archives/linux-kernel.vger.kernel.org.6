Return-Path: <linux-kernel+bounces-295729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2979A95A0DA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 17:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2AF71F241D7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3667A13A;
	Wed, 21 Aug 2024 15:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WRLMcDl3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AaklP7wE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LaGQxV8c";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iS2wuhBa"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9941E522;
	Wed, 21 Aug 2024 15:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724252679; cv=none; b=aYBfKX9zY9+lQKZSzythinBrLpJnMy6TBk89YYYL9BvOtOyaMdTxRboCaF7VkTSy88ArlLGWs7KD5OTREa7KSsthNJzvkWYN3U4zkkFQNEPS2Yck/1juTeKEFedmINNRUKbAzA/S7PLGzaMDG344n6byLgOA3LyG21qc0B8nzf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724252679; c=relaxed/simple;
	bh=OkDEoZGly81lf5gW2MbMELkfieiZa8lyDmiQLleQhdg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XNrq6hqxATbuc/pCZcdtXUr6GrEa4uBS0Jcmnv7UuBO+xdp1F9DUsqBuJ/xLMVa0zYNjUnL1yfUrtQVaAqOq1C8IV2VNCABBd7PZfTIT1ljlI1r1MXRI5h5mdsYjSwqdR1DdDExMTC5+Lgn1Jy8KvJZJW2Iv1LRoUVZa4XnDM/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WRLMcDl3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AaklP7wE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LaGQxV8c; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iS2wuhBa; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CCAE91FDDC;
	Wed, 21 Aug 2024 15:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724252675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=stiqDtU4ipjBcBh8/CuaxM+WGrTFV6LHVPrhKOsF+m8=;
	b=WRLMcDl3NQexTpgLc/pis79FAAfYPlGzY3q9qGa147JjpWs67pnwZ0SdupPo6SA3Czuxhv
	1CEWYfODoPLWrnimBzGGZsLnvQb1P7FhDkrUFXtq9McnRF+qB0+V+b1npyXzes6IenQBfO
	GrJE9ZJEP/FYTWbXLXihE81oAm1v/b0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724252675;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=stiqDtU4ipjBcBh8/CuaxM+WGrTFV6LHVPrhKOsF+m8=;
	b=AaklP7wEOTSTMTGgZRAIE5Iu3gkcqoh9T/VuNiwivTH+MrtzuaSpOOM3GLDEtDShc584AK
	S83MUz+ZZwHUB4AQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724252674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=stiqDtU4ipjBcBh8/CuaxM+WGrTFV6LHVPrhKOsF+m8=;
	b=LaGQxV8c9G7XSTgmxHGEgueH6OuvLfWMsbZxLLnDj5A1C+onJ6gT3ePiH4m1peIyWdwtTh
	refnNENY8IfL1GyRYkswF9wwykXM77S2pYI2M4MJ813Qma8QwOsglULbD+N83Rm2t1w879
	5Da+cijYvp2pk+14wP1wvl0+Wc57++U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724252674;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=stiqDtU4ipjBcBh8/CuaxM+WGrTFV6LHVPrhKOsF+m8=;
	b=iS2wuhBa760WaX/Y2Ue4eZFnj3nWVKhB1t42Ne6DqY+94mjYSYsPg8UYqB20NQgVcyekni
	ODXQxBOk5JZhi/Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5EBEF13770;
	Wed, 21 Aug 2024 15:04:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GHmaFQICxmbjQQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 21 Aug 2024 15:04:34 +0000
Date: Wed, 21 Aug 2024 17:05:16 +0200
Message-ID: <878qwpq5lf.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>,
	Zeno Endemann <zeno.endemann@mailbox.org>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
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
In-Reply-To: <cea341dc-bcc2-49f2-a641-af365bfd213a@perex.cz>
References: <20240812142029.46608-1-zeno.endemann@mailbox.org>
	<dec71400-81f1-4ca6-9010-94b55ecdaafa@linux.intel.com>
	<3e9cd14b-7355-4fde-b0c1-39d40467e63c@mailbox.org>
	<8c71ea3d-5c97-423e-a270-3184c16e1603@linux.intel.com>
	<c2a46079-b9fa-46fb-8d2d-e01e5d620ea7@mailbox.org>
	<878qx0mtfe.wl-tiwai@suse.de>
	<f41762a1-048c-4ab6-86ae-f364753210c7@mailbox.org>
	<874j7omsap.wl-tiwai@suse.de>
	<aa308e18-f9e0-4b1a-b548-fcc61e641c6f@mailbox.org>
	<87frqyorzi.wl-tiwai@suse.de>
	<cea341dc-bcc2-49f2-a641-af365bfd213a@perex.cz>
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

On Wed, 21 Aug 2024 16:59:41 +0200,
Jaroslav Kysela wrote:
> 
> On 21. 08. 24 16:44, Takashi Iwai wrote:
> > On Wed, 21 Aug 2024 16:27:43 +0200,
> > Zeno Endemann wrote:
> >> 
> >> Takashi Iwai wrote on 13.08.24 16:05:
> >>> On Tue, 13 Aug 2024 15:58:13 +0200,
> >>> Zeno Endemann wrote:
> >>>> 
> >>>> Takashi Iwai wrote on 13.08.24 15:41:
> >>>>> On Tue, 13 Aug 2024 14:54:42 +0200,
> >>>>> Zeno Endemann wrote:
> >>>>>> 
> >>>>>> Pierre-Louis Bossart wrote on 13.08.24 10:04:
> >>>>>>> by focusing on the trigger timestamp I think you're looking at the wrong
> >>>>>>> side of the problem. The timestamping is improved by using the same
> >>>>>>> hardware counter for the trigger AND regular timestamp during
> >>>>>>> playback/capture. If you look at a hardware counter during
> >>>>>>> playback/capture but the start position is recorded with another method,
> >>>>>>> would you agree that there's a systematic non-reproducible offset at
> >>>>>>> each run? You want the trigger and regular timestamps to be measured in
> >>>>>>> the same way to avoid measurement differences.
> >>>>>> 
> >>>>>> I am not sure what you are talking about. I have not seen any place in the
> >>>>>> code where the trigger timestamp is taken in any other more sophisticated
> >>>>>> way than what the default is doing, i.e. calling snd_pcm_gettime. So I do
> >>>>>> not see how your custom *trigger* timestamps are done "with another method".
> >>>>>> 
> >>>>>>> I will not disagree that most applications do not need precise
> >>>>>>> timestamping, but if you want to try to enable time-of-flight
> >>>>>>> measurements for presence or gesture detection you will need higher
> >>>>>>> sampling rates and micro-second level accuracy.
> >>>>>> 
> >>>>>> I don't know, this sounds very theoretical at best to me. However I do not
> >>>>>> have the desire to try to further argue and convince you otherwise.
> >>>>>> 
> >>>>>> Do you want to propose a different solution for the stop trigger timestamp
> >>>>>> bug? That is my main goal after all.
> >>>>> 
> >>>>> Ah, I guess that the discussion drifted because of misunderstanding.
> >>>>> 
> >>>>> This isn't about the accuracy of the audio timestamp, but rather the
> >>>>> timing of trigger tstamp.  The commit 2b79d7a6bf34 ("ALSA: pcm: allow
> >>>>> for trigger_tstamp snapshot in .trigger") allowed the trigger_tstamp
> >>>>> taken in the driver's trigger callback.  But, the effectiveness of
> >>>>> this change is dubious, because the timestamp taken in the usual code
> >>>>> path in PCM core is right after the trigger callback, hence the
> >>>>> difference should be negligible -- that's the argument.
> >>>> 
> >>>> Exactly. Sorry if my communication was not clear on that.
> >>>> 
> >>>>> 
> >>>>> No matter how the fix will be, could you put the Fixes tag pointing to
> >>>>> the culprit commit(s) at the next submission?
> >>>> 
> >>>> Will do. I guess I'll have to look up which commit actually enabled the
> >>>> trigger_tstamp_latched in hda, as 2b79d7a6bf34 has no driver using that
> >>>> yet, so is not technically the culprit?
> >>> 
> >>> You can take the HD-audio side, the commit ed610af86a71 ("ALSA: hda:
> >>> read trigger_timestamp immediately after starting DMA") instead, too.
> >>> Maybe it doesn't matter much which commit is chosen; both should
> >>> appear in the same kernel version.
> >> 
> >> Well, I think I've waited a decent amount of time now for more comments.
> >> How do we proceed?
> >> 
> >> I'm still of the opinion that the removal is the most sensible solution,
> >> so if we agree I could prepare a V2 where I just improve the commit message
> >> a bit further.
> >> 
> >> But if we don't have a good enough consensus on this, I'd need some guidance
> >> which alternate path should be taken to at least fix the bug of bad stop
> >> trigger timestamps for hda devices (e.g. should I try to fix it also for
> >> soc/intel/skylake without any testing? That seems to me the only other place
> >> that should be affected, apart from the generic pci hda code).
> > 
> > IIUC, the achievement of the timestamp at the exact timing was the
> > goal of that change (which caused a regression unfortunately), so
> > keeping that feature may still make sense.  I'd rather try to fix in
> > HD-audio side at first.
> > 
> > If Pierre agrees with the removal of the local timestamp call, we can
> > revert to there afterwards, too.
> 
> What about a patch bellow. I'll send it with proper formatting, when we decide to go with it. Perhaps, the latched flag may be reset when start is false, too.

It's similar like what I had in mind, too.
(My version was to drop the call of snd_pcm_gettime() from
 snd_hdac_stream_timecounter_init() but call it at each place,
 instead.)


Takashi

> 
> 					Jaroslav
> 
> diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
> index 7e39d486374a..b098ceadbe74 100644
> --- a/include/sound/hdaudio.h
> +++ b/include/sound/hdaudio.h
> @@ -590,7 +590,7 @@ void snd_hdac_stream_sync_trigger(struct hdac_stream *azx_dev, bool set,
>  void snd_hdac_stream_sync(struct hdac_stream *azx_dev, bool start,
>  			  unsigned int streams);
>  void snd_hdac_stream_timecounter_init(struct hdac_stream *azx_dev,
> -				      unsigned int streams);
> +				      unsigned int streams, bool start);
>  int snd_hdac_get_stream_stripe_ctl(struct hdac_bus *bus,
>  				struct snd_pcm_substream *substream);
>  diff --git a/sound/hda/hdac_stream.c b/sound/hda/hdac_stream.c
> index b53de020309f..0411a8fe9d6f 100644
> --- a/sound/hda/hdac_stream.c
> +++ b/sound/hda/hdac_stream.c
> @@ -664,7 +664,7 @@ static void azx_timecounter_init(struct hdac_stream *azx_dev,
>   * updated accordingly, too.
>   */
>  void snd_hdac_stream_timecounter_init(struct hdac_stream *azx_dev,
> -				      unsigned int streams)
> +				      unsigned int streams, bool start)
>  {
>  	struct hdac_bus *bus = azx_dev->bus;
>  	struct snd_pcm_runtime *runtime = azx_dev->substream->runtime;
> @@ -672,6 +672,9 @@ void snd_hdac_stream_timecounter_init(struct hdac_stream *azx_dev,
>  	bool inited = false;
>  	u64 cycle_last = 0;
>  +	if (!start)
> +		goto skip;
> +
>  	list_for_each_entry(s, &bus->stream_list, list) {
>  		if ((streams & (1 << s->index))) {
>  			azx_timecounter_init(s, inited, cycle_last);
> @@ -682,6 +685,7 @@ void snd_hdac_stream_timecounter_init(struct hdac_stream *azx_dev,
>  		}
>  	}
>  +skip:
>  	snd_pcm_gettime(runtime, &runtime->trigger_tstamp);
>  	runtime->trigger_tstamp_latched = true;
>  }
> diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
> index 5d86e5a9c814..f3330b7e0fcf 100644
> --- a/sound/pci/hda/hda_controller.c
> +++ b/sound/pci/hda/hda_controller.c
> @@ -275,8 +275,7 @@ static int azx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
>  	spin_lock(&bus->reg_lock);
>  	/* reset SYNC bits */
>  	snd_hdac_stream_sync_trigger(hstr, false, sbits, sync_reg);
> -	if (start)
> -		snd_hdac_stream_timecounter_init(hstr, sbits);
> +	snd_hdac_stream_timecounter_init(hstr, sbits, start);
>  	spin_unlock(&bus->reg_lock);
>  	return 0;
>  }
> diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
> index 613b27b8da13..7eec15a2c49e 100644
> --- a/sound/soc/intel/skylake/skl-pcm.c
> +++ b/sound/soc/intel/skylake/skl-pcm.c
> @@ -446,10 +446,10 @@ static int skl_decoupled_trigger(struct snd_pcm_substream *substream,
>   	if (start) {
>  		snd_hdac_stream_start(hdac_stream(stream));
> -		snd_hdac_stream_timecounter_init(hstr, 0);
>  	} else {
>  		snd_hdac_stream_stop(hdac_stream(stream));
>  	}
> +	snd_hdac_stream_timecounter_init(hstr, 0, start);
>   	spin_unlock_irqrestore(&bus->reg_lock, cookie);
>  @@ -1145,8 +1145,7 @@ static int skl_coupled_trigger(struct
> snd_pcm_substream *substream,
>   	/* reset SYNC bits */
>  	snd_hdac_stream_sync_trigger(hstr, false, sbits, AZX_REG_SSYNC);
> -	if (start)
> -		snd_hdac_stream_timecounter_init(hstr, sbits);
> +	snd_hdac_stream_timecounter_init(hstr, sbits, start);
>  	spin_unlock_irqrestore(&bus->reg_lock, cookie);
>   	return 0;
> 
> 
> 					Jaroslav
> 
> -- 
> Jaroslav Kysela <perex@perex.cz>
> Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
> 

