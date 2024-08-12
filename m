Return-Path: <linux-kernel+bounces-283507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCCE94F5C8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 19:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27C6A1F21F50
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 17:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7B3188CCA;
	Mon, 12 Aug 2024 17:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CdUGvUZB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6871804F;
	Mon, 12 Aug 2024 17:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723483591; cv=none; b=PwrhU/UGX6M1OYxOSShFwU4d/05OaKyqP2IJpY5hgKLdsJ+yktz6MYzTXl5HAHkOEgu5UDC+dDmj0oOqJRFGBW16Z/JgFcPH4W2UIVj1avhn7Ia4rDiwLXIiDCbYUtKnAaSIhGTVikPcrKImS5ya3dCQvge+9hksH9tjskK4VRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723483591; c=relaxed/simple;
	bh=XSxPXOdw1N5KjOGfiApKGwRDQACkIeeh7PrfV/WAWMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aWna5KMTynGdr7vQ43Hd/kzM7oxhRQY8mbNvjIE9J7zwLTBOYDHUMV/IcaWhcY3nysOdPG80Ldbt8rEIDZfRB6gngdDKCiYp9z9EES6lMXq6ry/XOZv6BCZNXKfbS6O/dgnu3XjXE6df5l8uo8Y8aewpyYRgy6jvAWeVptmFESQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CdUGvUZB; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723483590; x=1755019590;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XSxPXOdw1N5KjOGfiApKGwRDQACkIeeh7PrfV/WAWMM=;
  b=CdUGvUZBzIkzkp8DfzaO5VhlNnxxEazjDBXts1HV+ERFlH+R2f0zh5JI
   x58uWgU12FTnqlFRSAwgBP1/HtioqunpQFPRL1WK7Tc+1kUVoZn2H9hq7
   ySkci6pLVj1UsI0K4Dhv14SD3xegXZ9z3bE51yArWsV8XLzQvMqdx0vC2
   XZpnEiGZJ2oilzOvYU525qio9+DiP9NrT+88fR92hk76jgJvO9kq3M3it
   tCEVeTuwHSDhUKoDbDzI6wzv6mrmAJxRKQdQRwyQFr+tA6fmDvpxUabV3
   MMqldY1KdOCe/fZ0XMKCLGdcyvPzuLnGCru5aHUdSGcYe3mRn9VqlI/NM
   Q==;
X-CSE-ConnectionGUID: eso20W9xR2KZgYMWG1MhKg==
X-CSE-MsgGUID: UN5tQtlERlKwYi7CwChndw==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="24515020"
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="24515020"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 10:25:56 -0700
X-CSE-ConnectionGUID: zH0TF5PFT8qxt1LXy805ZA==
X-CSE-MsgGUID: zCD7fNyeSFGYUsIOW0OFpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="89159495"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO [10.245.246.115]) ([10.245.246.115])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 10:25:52 -0700
Message-ID: <dec71400-81f1-4ca6-9010-94b55ecdaafa@linux.intel.com>
Date: Mon, 12 Aug 2024 19:25:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ALSA: core: Remove trigger_tstamp_latched
To: Zeno Endemann <zeno.endemann@mailbox.org>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Christian Brauner <brauner@kernel.org>, Mark Brown <broonie@kernel.org>,
 Pavel Hofman <pavel.hofman@ivitera.com>, David Howells
 <dhowells@redhat.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>
References: <20240812142029.46608-1-zeno.endemann@mailbox.org>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20240812142029.46608-1-zeno.endemann@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/12/24 16:20, Zeno Endemann wrote:
> The trigger_tstamp_latched hook was introduced to allow drivers to
> provide their own trigger timestamp instead of the default generated
> one for higher accuracy. This makes sense in theory, but in practice
> the only place that uses this is the hda core, and:
> 
> * The custom timestamp there does not seem to be a meaningful
>   improvement over the default one; There is virtually no code in
>   between them, so I measured only a difference of around 300ns in a
>   KVM VM with ich9-intel-hda device.

Humm, you're analyzing timestamps with a VM and a rather old device?
ICH9 support was added in 2014, some ten years ago. The timestamping
stuff is only improved with SKL+.


> * It is also bugged as it does not set a timestamp when the stream
>   stops.

That's quite possible, the main point was to get accurate timestamps on
start and during playback.
https://github.com/alsa-project/alsa-lib/issues/387 maybe be a valid
issue, we never looked at the sequence with a drop.


> * It creates a pitfall for hda driver writers; Calling
>   snd_hdac_stream_timecounter_init implicitly makes them responsible
>   for generating these timestamps.

That's the point, let those drivers generate a better timestamp if they
can. Not sure what the problem is?

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
> ---
>  include/sound/pcm.h     | 1 -
>  sound/core/pcm_native.c | 4 +---
>  sound/hda/hdac_stream.c | 6 ------
>  3 files changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/include/sound/pcm.h b/include/sound/pcm.h
> index ac8f3aef9205..3539af9f733e 100644
> --- a/include/sound/pcm.h
> +++ b/include/sound/pcm.h
> @@ -361,7 +361,6 @@ struct snd_pcm_runtime {
>  	snd_pcm_state_t suspended_state; /* suspended stream state */
>  	struct snd_pcm_substream *trigger_master;
>  	struct timespec64 trigger_tstamp;	/* trigger timestamp */
> -	bool trigger_tstamp_latched;     /* trigger timestamp latched in low-level driver/hardware */
>  	int overrange;
>  	snd_pcm_uframes_t avail_max;
>  	snd_pcm_uframes_t hw_ptr_base;	/* Position at buffer restart */
> diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
> index 4057f9f10aee..ced5bd2d7ebb 100644
> --- a/sound/core/pcm_native.c
> +++ b/sound/core/pcm_native.c
> @@ -1194,8 +1194,7 @@ static void snd_pcm_trigger_tstamp(struct snd_pcm_substream *substream)
>  	if (runtime->trigger_master == NULL)
>  		return;
>  	if (runtime->trigger_master == substream) {
> -		if (!runtime->trigger_tstamp_latched)
> -			snd_pcm_gettime(runtime, &runtime->trigger_tstamp);
> +		snd_pcm_gettime(runtime, &runtime->trigger_tstamp);
>  	} else {
>  		snd_pcm_trigger_tstamp(runtime->trigger_master);
>  		runtime->trigger_tstamp = runtime->trigger_master->runtime->trigger_tstamp;
> @@ -1422,7 +1421,6 @@ static int snd_pcm_pre_start(struct snd_pcm_substream *substream,
>  	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK &&
>  	    !snd_pcm_playback_data(substream))
>  		return -EPIPE;
> -	runtime->trigger_tstamp_latched = false;
>  	runtime->trigger_master = substream;
>  	return 0;
>  }
> diff --git a/sound/hda/hdac_stream.c b/sound/hda/hdac_stream.c
> index b53de020309f..271d42b765fc 100644
> --- a/sound/hda/hdac_stream.c
> +++ b/sound/hda/hdac_stream.c
> @@ -660,14 +660,11 @@ static void azx_timecounter_init(struct hdac_stream *azx_dev,
>   *
>   * Initializes the time counter of streams marked by the bit flags (each
>   * bit corresponds to the stream index).
> - * The trigger timestamp of PCM substream assigned to the given stream is
> - * updated accordingly, too.
>   */
>  void snd_hdac_stream_timecounter_init(struct hdac_stream *azx_dev,
>  				      unsigned int streams)
>  {
>  	struct hdac_bus *bus = azx_dev->bus;
> -	struct snd_pcm_runtime *runtime = azx_dev->substream->runtime;
>  	struct hdac_stream *s;
>  	bool inited = false;
>  	u64 cycle_last = 0;
> @@ -681,9 +678,6 @@ void snd_hdac_stream_timecounter_init(struct hdac_stream *azx_dev,
>  			}
>  		}
>  	}
> -
> -	snd_pcm_gettime(runtime, &runtime->trigger_tstamp);
> -	runtime->trigger_tstamp_latched = true;
>  }
>  EXPORT_SYMBOL_GPL(snd_hdac_stream_timecounter_init);
>  


