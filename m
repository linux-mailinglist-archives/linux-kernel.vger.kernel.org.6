Return-Path: <linux-kernel+bounces-295723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9893D95A0C8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 17:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBF511C2294E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E0D13049E;
	Wed, 21 Aug 2024 15:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="2qGkSHl6"
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5A81B2518;
	Wed, 21 Aug 2024 15:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.48.224.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724252407; cv=none; b=FkAQY9C9Xmy2QhtnZljlDfxtMxFs4hH7z+Di1lgTpe0i7HkJkM+jtgArQkQHBjsEQUagzLkik1yeihnQ5iACRCAXh4iU9Mh9I+/LN7Cm4lRM2W9EV446pCvMz6rvwq/GU92EIIaQRhipW8WL/txSFNDpBcK2MjOVkoVwGEXyyDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724252407; c=relaxed/simple;
	bh=SMnI81XBfclyrbv5a/gl+EtF56z3CwROALLr4MpqkKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kwGiliLfn8ZcAj3aNYqfzXWTlA4JGRYJpPt+Be+rnfv3tz9EZrtXyPccA6PQGMHtOW6XtOxE0siSqSVDQAyOSVeYdES+XvORi6DE8NaBANwY32lnTvNQWuK3w4WLDv+rn3lpejTM962p0hGvaDmbuzkrcyMcBvoTLmnXaPVwxas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=perex.cz; spf=pass smtp.mailfrom=perex.cz; dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b=2qGkSHl6; arc=none smtp.client-ip=77.48.224.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=perex.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perex.cz
Received: from mail1.perex.cz (localhost [127.0.0.1])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 378B72EAC;
	Wed, 21 Aug 2024 16:59:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 378B72EAC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
	t=1724252398; bh=ztiIE8JtEE1GxJzI1XnGJzV8HgxihJfeDicZ62CF28s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=2qGkSHl6KlBrYX2sWq/LT3qsPo0Ts/1dWMmLLHxLIMneInsyH+9EJBDPLE7zyt/5Z
	 pQRxVII4nRKbay90MS6tXxvEhTRmO5bogAJFjyQ2gkXOtPURPzlxoQnvdFcHc5LZo6
	 hb47jObVHhdS452kWdQK3U0Xo/g0yFKg2PboiJpc=
Received: from [192.168.100.98] (unknown [192.168.100.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: perex)
	by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
	Wed, 21 Aug 2024 16:59:42 +0200 (CEST)
Message-ID: <cea341dc-bcc2-49f2-a641-af365bfd213a@perex.cz>
Date: Wed, 21 Aug 2024 16:59:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ALSA: core: Remove trigger_tstamp_latched
To: Takashi Iwai <tiwai@suse.de>, Zeno Endemann <zeno.endemann@mailbox.org>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Cezary Rojewski <cezary.rojewski@intel.com>,
 Christian Brauner <brauner@kernel.org>, Mark Brown <broonie@kernel.org>,
 Pavel Hofman <pavel.hofman@ivitera.com>, David Howells
 <dhowells@redhat.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>
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
From: Jaroslav Kysela <perex@perex.cz>
Content-Language: en-US
Autocrypt: addr=perex@perex.cz; keydata=
 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
In-Reply-To: <87frqyorzi.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21. 08. 24 16:44, Takashi Iwai wrote:
> On Wed, 21 Aug 2024 16:27:43 +0200,
> Zeno Endemann wrote:
>>
>> Takashi Iwai wrote on 13.08.24 16:05:
>>> On Tue, 13 Aug 2024 15:58:13 +0200,
>>> Zeno Endemann wrote:
>>>>
>>>> Takashi Iwai wrote on 13.08.24 15:41:
>>>>> On Tue, 13 Aug 2024 14:54:42 +0200,
>>>>> Zeno Endemann wrote:
>>>>>>
>>>>>> Pierre-Louis Bossart wrote on 13.08.24 10:04:
>>>>>>> by focusing on the trigger timestamp I think you're looking at the wrong
>>>>>>> side of the problem. The timestamping is improved by using the same
>>>>>>> hardware counter for the trigger AND regular timestamp during
>>>>>>> playback/capture. If you look at a hardware counter during
>>>>>>> playback/capture but the start position is recorded with another method,
>>>>>>> would you agree that there's a systematic non-reproducible offset at
>>>>>>> each run? You want the trigger and regular timestamps to be measured in
>>>>>>> the same way to avoid measurement differences.
>>>>>>
>>>>>> I am not sure what you are talking about. I have not seen any place in the
>>>>>> code where the trigger timestamp is taken in any other more sophisticated
>>>>>> way than what the default is doing, i.e. calling snd_pcm_gettime. So I do
>>>>>> not see how your custom *trigger* timestamps are done "with another method".
>>>>>>
>>>>>>> I will not disagree that most applications do not need precise
>>>>>>> timestamping, but if you want to try to enable time-of-flight
>>>>>>> measurements for presence or gesture detection you will need higher
>>>>>>> sampling rates and micro-second level accuracy.
>>>>>>
>>>>>> I don't know, this sounds very theoretical at best to me. However I do not
>>>>>> have the desire to try to further argue and convince you otherwise.
>>>>>>
>>>>>> Do you want to propose a different solution for the stop trigger timestamp
>>>>>> bug? That is my main goal after all.
>>>>>
>>>>> Ah, I guess that the discussion drifted because of misunderstanding.
>>>>>
>>>>> This isn't about the accuracy of the audio timestamp, but rather the
>>>>> timing of trigger tstamp.  The commit 2b79d7a6bf34 ("ALSA: pcm: allow
>>>>> for trigger_tstamp snapshot in .trigger") allowed the trigger_tstamp
>>>>> taken in the driver's trigger callback.  But, the effectiveness of
>>>>> this change is dubious, because the timestamp taken in the usual code
>>>>> path in PCM core is right after the trigger callback, hence the
>>>>> difference should be negligible -- that's the argument.
>>>>
>>>> Exactly. Sorry if my communication was not clear on that.
>>>>
>>>>>
>>>>> No matter how the fix will be, could you put the Fixes tag pointing to
>>>>> the culprit commit(s) at the next submission?
>>>>
>>>> Will do. I guess I'll have to look up which commit actually enabled the
>>>> trigger_tstamp_latched in hda, as 2b79d7a6bf34 has no driver using that
>>>> yet, so is not technically the culprit?
>>>
>>> You can take the HD-audio side, the commit ed610af86a71 ("ALSA: hda:
>>> read trigger_timestamp immediately after starting DMA") instead, too.
>>> Maybe it doesn't matter much which commit is chosen; both should
>>> appear in the same kernel version.
>>
>> Well, I think I've waited a decent amount of time now for more comments.
>> How do we proceed?
>>
>> I'm still of the opinion that the removal is the most sensible solution,
>> so if we agree I could prepare a V2 where I just improve the commit message
>> a bit further.
>>
>> But if we don't have a good enough consensus on this, I'd need some guidance
>> which alternate path should be taken to at least fix the bug of bad stop
>> trigger timestamps for hda devices (e.g. should I try to fix it also for
>> soc/intel/skylake without any testing? That seems to me the only other place
>> that should be affected, apart from the generic pci hda code).
> 
> IIUC, the achievement of the timestamp at the exact timing was the
> goal of that change (which caused a regression unfortunately), so
> keeping that feature may still make sense.  I'd rather try to fix in
> HD-audio side at first.
> 
> If Pierre agrees with the removal of the local timestamp call, we can
> revert to there afterwards, too.

What about a patch bellow. I'll send it with proper formatting, when we decide to go with it. Perhaps, the latched flag may be reset when start is false, too.

					Jaroslav

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index 7e39d486374a..b098ceadbe74 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -590,7 +590,7 @@ void snd_hdac_stream_sync_trigger(struct hdac_stream *azx_dev, bool set,
  void snd_hdac_stream_sync(struct hdac_stream *azx_dev, bool start,
  			  unsigned int streams);
  void snd_hdac_stream_timecounter_init(struct hdac_stream *azx_dev,
-				      unsigned int streams);
+				      unsigned int streams, bool start);
  int snd_hdac_get_stream_stripe_ctl(struct hdac_bus *bus,
  				struct snd_pcm_substream *substream);
  
diff --git a/sound/hda/hdac_stream.c b/sound/hda/hdac_stream.c
index b53de020309f..0411a8fe9d6f 100644
--- a/sound/hda/hdac_stream.c
+++ b/sound/hda/hdac_stream.c
@@ -664,7 +664,7 @@ static void azx_timecounter_init(struct hdac_stream *azx_dev,
   * updated accordingly, too.
   */
  void snd_hdac_stream_timecounter_init(struct hdac_stream *azx_dev,
-				      unsigned int streams)
+				      unsigned int streams, bool start)
  {
  	struct hdac_bus *bus = azx_dev->bus;
  	struct snd_pcm_runtime *runtime = azx_dev->substream->runtime;
@@ -672,6 +672,9 @@ void snd_hdac_stream_timecounter_init(struct hdac_stream *azx_dev,
  	bool inited = false;
  	u64 cycle_last = 0;
  
+	if (!start)
+		goto skip;
+
  	list_for_each_entry(s, &bus->stream_list, list) {
  		if ((streams & (1 << s->index))) {
  			azx_timecounter_init(s, inited, cycle_last);
@@ -682,6 +685,7 @@ void snd_hdac_stream_timecounter_init(struct hdac_stream *azx_dev,
  		}
  	}
  
+skip:
  	snd_pcm_gettime(runtime, &runtime->trigger_tstamp);
  	runtime->trigger_tstamp_latched = true;
  }
diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index 5d86e5a9c814..f3330b7e0fcf 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -275,8 +275,7 @@ static int azx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
  	spin_lock(&bus->reg_lock);
  	/* reset SYNC bits */
  	snd_hdac_stream_sync_trigger(hstr, false, sbits, sync_reg);
-	if (start)
-		snd_hdac_stream_timecounter_init(hstr, sbits);
+	snd_hdac_stream_timecounter_init(hstr, sbits, start);
  	spin_unlock(&bus->reg_lock);
  	return 0;
  }
diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 613b27b8da13..7eec15a2c49e 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -446,10 +446,10 @@ static int skl_decoupled_trigger(struct snd_pcm_substream *substream,
  
  	if (start) {
  		snd_hdac_stream_start(hdac_stream(stream));
-		snd_hdac_stream_timecounter_init(hstr, 0);
  	} else {
  		snd_hdac_stream_stop(hdac_stream(stream));
  	}
+	snd_hdac_stream_timecounter_init(hstr, 0, start);
  
  	spin_unlock_irqrestore(&bus->reg_lock, cookie);
  
@@ -1145,8 +1145,7 @@ static int skl_coupled_trigger(struct snd_pcm_substream *substream,
  
  	/* reset SYNC bits */
  	snd_hdac_stream_sync_trigger(hstr, false, sbits, AZX_REG_SSYNC);
-	if (start)
-		snd_hdac_stream_timecounter_init(hstr, sbits);
+	snd_hdac_stream_timecounter_init(hstr, sbits, start);
  	spin_unlock_irqrestore(&bus->reg_lock, cookie);
  
  	return 0;


					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.


