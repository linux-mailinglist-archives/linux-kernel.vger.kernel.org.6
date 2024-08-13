Return-Path: <linux-kernel+bounces-284280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7481C94FF4D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25516285A68
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BBB12EBEA;
	Tue, 13 Aug 2024 08:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d4NxsVh3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFD947F5B;
	Tue, 13 Aug 2024 08:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723536277; cv=none; b=P4Uo3mlp4kcd5O84RiZqTk2OgKxoHw31JSlkwZ6ZAWWBdaaYd67w+GsWtcOuQgBwwIatJGgsNHiucpXB/fxenbosWMh/cNtF9Z+OuZAksPYi1FdGtKQo0U/i3tKtS/FGYxkEmZLvBm3rOqE4KqY41JJKoRqUHdCsPM41NfxZJp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723536277; c=relaxed/simple;
	bh=JC8F9MenAO232MVenNnZ4VY3gB8G8oxP97lA62o927A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JOj695J4jRaVu8F5pN0CeJNv21r2dXNJ1DjB/uRyTAthulpmIwAwaiSZi9kZOjg1e+XN71HLTG6LvKtvQpd/G3DP8y9V+X+QjAgavWHJMCotL3Q71dH8fNcuzdw3Ae39e9dlTcBrh/95Zofik8R6TVFggM0LpKbSqUDLyNKXxXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d4NxsVh3; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723536275; x=1755072275;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JC8F9MenAO232MVenNnZ4VY3gB8G8oxP97lA62o927A=;
  b=d4NxsVh3mrpIKfnTs0LseUGanv3hVUgaHqIpaHHQB1M32coAo4epEO9+
   6ewvACudMG+rXJD1dFEXURD4I9c0yGTssBPaqAtBNk1xhWFH7DL1RQiLF
   sMEWd96o28yvo1wouy/AVs8V0ZpcireXJF3MQV2632iV56PzY78uEEqK/
   cQAuKrCetiNXC2vLziesw/Z0DXHq7SDxiotM7Vh/cwwFMw7U8clHIREnZ
   ANSrdnpFxaFzH9b5Jy7LMyv+cVjz6rXnlPoQqrHKoohcR90UQd9JS88u0
   LpvwSKHzmO90FNSE9B3uBnLkx62cW84AStwaZ0j8OnnWfKpq+MA6TCL1P
   Q==;
X-CSE-ConnectionGUID: /dG1uinwSNuvwAJ/CrHfcQ==
X-CSE-MsgGUID: uC41bXbZQvOZ6I8OzPBAbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="25547394"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="25547394"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 01:04:35 -0700
X-CSE-ConnectionGUID: 4DiBFBvhQJ+vuxbfoCU47A==
X-CSE-MsgGUID: kNBid03SRT+3sjhsMUTmIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="62748123"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO [10.245.246.236]) ([10.245.246.236])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 01:04:31 -0700
Message-ID: <8c71ea3d-5c97-423e-a270-3184c16e1603@linux.intel.com>
Date: Tue, 13 Aug 2024 10:04:28 +0200
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
 <dec71400-81f1-4ca6-9010-94b55ecdaafa@linux.intel.com>
 <3e9cd14b-7355-4fde-b0c1-39d40467e63c@mailbox.org>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <3e9cd14b-7355-4fde-b0c1-39d40467e63c@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/12/24 23:05, Zeno Endemann wrote:
> Pierre-Louis Bossart wrote on 12.08.24 19:25:
>>> * The custom timestamp there does not seem to be a meaningful
>>>    improvement over the default one; There is virtually no code in
>>>    between them, so I measured only a difference of around 300ns in a
>>>    KVM VM with ich9-intel-hda device.
>>
>> Humm, you're analyzing timestamps with a VM and a rather old device?
>> ICH9 support was added in 2014, some ten years ago. The timestamping
>> stuff is only improved with SKL+.
> 
> With more modern hardware on bare metal I would assume this difference to
> the default timestamp to be even smaller. I am not a hardware guy, so
> correct me if I'm wrong, but I would think that the unknown timing delays
> of the IO operations and internal audio hardware are orders of magnitude
> larger than even 300ns, making this improvement drown in the noise. Do you
> have some measurements of the differences with modern hardware?
> 
> Besides, the only improvement here is that the timestamp is taken slightly
> earlier, nothing fancy as far as I can tell. It seems a bit odd to me that
> the hda core is the only one that cares for this.

The timestamping is not limited to HDaudio, it just turns out that only
Intel upstreamed the solution.

> Finally, I cannot imagine what audio application needs sub-microsecond
> accuracy for the trigger timestamps. That is less than a single audio frame
> even for silly sample rates. Is this intended for some scientific use case?
> For regular audio apps I'd think most do not even care that much for the
> trigger timestamps and rather use the hw-pointer-update timestamps anyway,
> to prevent clock drifts. In my case I use only the stop trigger timestamp
> to estimate at which sample position a snd_pcm_drop happened, and don't use
> the start timestamp at all.
> 
> But these are just my possibly narrow views on this. If you really have
> valid use cases for those improved timestamps I won't insist on removing
> it.
> In fact I'd be rather interested to know if you can point me to an
> application that makes use of this.

by focusing on the trigger timestamp I think you're looking at the wrong
side of the problem. The timestamping is improved by using the same
hardware counter for the trigger AND regular timestamp during
playback/capture. If you look at a hardware counter during
playback/capture but the start position is recorded with another method,
would you agree that there's a systematic non-reproducible offset at
each run? You want the trigger and regular timestamps to be measured in
the same way to avoid measurement differences.

>>> * It creates a pitfall for hda driver writers; Calling
>>>    snd_hdac_stream_timecounter_init implicitly makes them responsible
>>>    for generating these timestamps.
>>
>> That's the point, let those drivers generate a better timestamp if they
>> can. Not sure what the problem is?
> 
> This is more of an API issue. At least to me it seems bad to sneakily
> enable
> this flag in snd_hdac_stream_timecounter_init. The documentation of it does
> not make it clear that after calling it the driver is responsible for the
> timestamps. Now I am admittedly not that deep into this code, so there may
> be a reason, but again at least to an "outsider" like me it is quite
> unclear
> why initializing the time counter also means the driver now has to
> manage the
> trigger timestamps.
> 
> If you really want this functionality to stay, maybe it would be better to
> move that out of snd_hdac_stream_timecounter_init and just make every
> driver
> that wants to manage them raise the flag explicitly themselves.

Not every hardware provides a counter than can be used for precise
timestamping, so there's no practical way to require that all solutions
use the same API. USB has e.g. no such counter, the only thing you'll
get is a 1ms counter which isn't great.

I would also refer you to the different types of timestamps that can be
taken, the wallclock counter is the simple case but there's also a
capability to get an atomic snapshop for precise measurements.

I will not disagree that most applications do not need precise
timestamping, but if you want to try to enable time-of-flight
measurements for presence or gesture detection you will need higher
sampling rates and micro-second level accuracy.



