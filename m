Return-Path: <linux-kernel+bounces-284457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FB6950123
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 11:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2EB81C21037
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62D617F505;
	Tue, 13 Aug 2024 09:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Hl407IgM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VHrHuteX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Hl407IgM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VHrHuteX"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A8D16D33F;
	Tue, 13 Aug 2024 09:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723541129; cv=none; b=CWGv9Nqxi4RtwuvOM3DChwxR/EaEpCOUWd0iePwAXOUNhGpIKs5SSxTp23R6IwWIirsyWK/QhE01l0ncccvcI0nrgAcD/aCUF+GarrbOzaOlQ2/U85WFphTO6HcoZPmIUBBUODrEosnoYKWRQWqEheJW8yVCVyuAVlvEXlBJZBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723541129; c=relaxed/simple;
	bh=0MMNp2bJAw0jw+jlLlWSbgto/CA8cvHMO8Slrcm0pds=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VlohgXCpI7AkwZOs9J+xCHllpELPSMh9m8Fk/QyoQuMMyPhHioL05EwIS7P9SY0ubJ3ajfYvranjbr3cdrk/gAIR0pLos/669ab3DWXCYJ1//62H1bCNH9oR/yaIS3oH6qMFR9tt7TfXVEKvs+Ct2VIBKJ9xZD+SoVhqPVWLoAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Hl407IgM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VHrHuteX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Hl407IgM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VHrHuteX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 14C3F1F45B;
	Tue, 13 Aug 2024 09:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723541125; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=25hQMdxUVySQBpoRmHu/Ac+bEc864HKe0K2gwnXqz6Y=;
	b=Hl407IgMmetHruBObNANbId1v7r2zH2B/T/T6fJZ9wyQPBmotXdZ0jYc0Eqro01A+KLYCi
	IblnvdIkTdJiPwnGNg6WoObaD1Ko4PNngdPW2yQCbuUy0J54XpzlG3yjSwMuAjUoW92ZVX
	fe7yJsZ4hZDbOvz078LUNuw/oA0YWGk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723541125;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=25hQMdxUVySQBpoRmHu/Ac+bEc864HKe0K2gwnXqz6Y=;
	b=VHrHuteXlhVySvLoil+vKCVnkp/UjlHD1vCcMvguJI5vwbDwOlYzvSf95Kf8PCL3dcq60N
	9rED/tj+Vk6fQxAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Hl407IgM;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=VHrHuteX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723541125; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=25hQMdxUVySQBpoRmHu/Ac+bEc864HKe0K2gwnXqz6Y=;
	b=Hl407IgMmetHruBObNANbId1v7r2zH2B/T/T6fJZ9wyQPBmotXdZ0jYc0Eqro01A+KLYCi
	IblnvdIkTdJiPwnGNg6WoObaD1Ko4PNngdPW2yQCbuUy0J54XpzlG3yjSwMuAjUoW92ZVX
	fe7yJsZ4hZDbOvz078LUNuw/oA0YWGk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723541125;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=25hQMdxUVySQBpoRmHu/Ac+bEc864HKe0K2gwnXqz6Y=;
	b=VHrHuteXlhVySvLoil+vKCVnkp/UjlHD1vCcMvguJI5vwbDwOlYzvSf95Kf8PCL3dcq60N
	9rED/tj+Vk6fQxAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5B1313ADE;
	Tue, 13 Aug 2024 09:25:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +YqMM4Qmu2Z/RgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 13 Aug 2024 09:25:24 +0000
Date: Tue, 13 Aug 2024 11:26:01 +0200
Message-ID: <87r0asbwpi.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Zeno Endemann <zeno.endemann@mailbox.org>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Christian Brauner <brauner@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Pavel Hofman <pavel.hofman@ivitera.com>,
	David Howells <dhowells@redhat.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Liam Girdwood <liam.r.girdwood@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: Re: [PATCH] ALSA: core: Remove trigger_tstamp_latched
In-Reply-To: <20240812142029.46608-1-zeno.endemann@mailbox.org>
References: <20240812142029.46608-1-zeno.endemann@mailbox.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 14C3F1F45B
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -5.51
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, 12 Aug 2024 16:20:29 +0200,
Zeno Endemann wrote:
> 
> The trigger_tstamp_latched hook was introduced to allow drivers to
> provide their own trigger timestamp instead of the default generated
> one for higher accuracy. This makes sense in theory, but in practice
> the only place that uses this is the hda core, and:
> 
> * The custom timestamp there does not seem to be a meaningful
>   improvement over the default one; There is virtually no code in
>   between them, so I measured only a difference of around 300ns in a
>   KVM VM with ich9-intel-hda device.
> * It is also bugged as it does not set a timestamp when the stream
>   stops.
> * It creates a pitfall for hda driver writers; Calling
>   snd_hdac_stream_timecounter_init implicitly makes them responsible
>   for generating these timestamps.
> 
> Since there is no real good use of this facility, I propose to remove
> it.
> 
> I reported the bug initially on github (see below), there one can also
> find a reproducer userspace app, as well as some other potential ways
> to fix this issue, in case this removal is not accepted.
> 
> Cc'ing the Intel ASoC maintainers, as the skl-pcm.c is using the
> snd_hdac_stream_timecounter_init function this patch modifies.
> 
> Closes: https://github.com/alsa-project/alsa-lib/issues/387
> Signed-off-by: Zeno Endemann <zeno.endemann@mailbox.org>

As long as I read the thread, there seems still use cases for this
high resolution time counter, so I'm rather for fixing the bugs of
bogus trigger tstamp than dropping the feature.

I still wonder, though, why the trigger_tstamp becomes *earlier* when
runtime->trigger_tstamp_latched is set.  I thought the same value
would be kept, instead.  What am I overlooking?

In anyway, if it's only about the missing trigger_tstamp update at PCM
trigger actions other than START, it could be fixed simply by clearing
trigger_tstamp_latched flag, too.  Alternatively, move the conditional
call to snd_pcm_post_start() instead of snd_pcm_trigger_tstamp()
itself, something like below.


thanks,

Takashi

--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -1194,8 +1194,7 @@ static void snd_pcm_trigger_tstamp(struct snd_pcm_substream *substream)
 	if (runtime->trigger_master == NULL)
 		return;
 	if (runtime->trigger_master == substream) {
-		if (!runtime->trigger_tstamp_latched)
-			snd_pcm_gettime(runtime, &runtime->trigger_tstamp);
+		snd_pcm_gettime(runtime, &runtime->trigger_tstamp);
 	} else {
 		snd_pcm_trigger_tstamp(runtime->trigger_master);
 		runtime->trigger_tstamp = runtime->trigger_master->runtime->trigger_tstamp;
@@ -1454,7 +1453,8 @@ static void snd_pcm_post_start(struct snd_pcm_substream *substream,
 			       snd_pcm_state_t state)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	snd_pcm_trigger_tstamp(substream);
+	if (!runtime->trigger_tstamp_latched)
+		snd_pcm_trigger_tstamp(substream);
 	runtime->hw_ptr_jiffies = jiffies;
 	runtime->hw_ptr_buffer_jiffies = (runtime->buffer_size * HZ) / 
 							    runtime->rate;

