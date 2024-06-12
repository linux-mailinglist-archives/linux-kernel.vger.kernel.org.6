Return-Path: <linux-kernel+bounces-211584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4DE905406
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1C721F256F8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 13:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BA717C7A7;
	Wed, 12 Jun 2024 13:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wn//qDRY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387C317BB36
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 13:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718199829; cv=none; b=MHokz1bplrKM9cXIa18vOZAgdXfewz16CjcogMsXdBKaxZBdvbbqOcDWHjlnSxpMj++/ZdLnTapdXPuQTZ8HyhhbBHduVY8t0oohKwL8GZVH7Xy1PhiSAlGbjVtJntEYr6V2PjKGEzyo3+mgjIjdIOzJjcDuh0hQ4zPh5U7WTig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718199829; c=relaxed/simple;
	bh=x0rl/iXkWmbds57DCqfteL3m3Cp5tq8IMlq2/EUKoI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=op23PcaM3HU7bBp9093jr5VnG0fsXN9XUs6grDob595DrIUgLtubae8RQLsvD0djdaR1fs8ft8XLmoL825COQACJN1IGIw4kSIC/qWv7V96J+K1SlOyoJmVSBgbZu6IBdsS1aEzqrPVr/HPVEOvMrCksXpNxd/tds/F0w/TflfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wn//qDRY; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718199829; x=1749735829;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=x0rl/iXkWmbds57DCqfteL3m3Cp5tq8IMlq2/EUKoI0=;
  b=Wn//qDRYT3SemV8IndLKsr2xsjrZNm1gB+HhCWmZgEoeaWnf5sX36yzT
   QmIzh2GUVfher+keQFfY787S9Qw8fVrnfeLz4LXdiSU/a+k0PZspw/8U9
   hpZ9VCYG3rOBxFhvgTBfWCwLjKuZIrzPS/aBqfhQtwppA6gfdhBN0nPOD
   nT+3dLseoQvAsbp7wTZy9yul4oIZMHsDedMYoeYXeGZo5yPYh6HNQjbGf
   ZJ1t8RcCMuQ4SQsoM6CMEdstkgz6ZMc/b0TwYQ9rlMmIpzgMJRczdBdAj
   m2j/uLyNTlnqUXq7oc7FIeXgi3U/khd3gouY3N/GqLo5TabJOKLhilvB6
   w==;
X-CSE-ConnectionGUID: +D+gHnAqT0KeQGakUX5g9g==
X-CSE-MsgGUID: xdSyOYOaQdOfSys3g8l2ZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="18790148"
X-IronPort-AV: E=Sophos;i="6.08,233,1712646000"; 
   d="scan'208";a="18790148"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 06:43:48 -0700
X-CSE-ConnectionGUID: LtTVVT6vTV+JqMX0f/pNdQ==
X-CSE-MsgGUID: arbLcujOQqqG3dASF3YCxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,233,1712646000"; 
   d="scan'208";a="40490395"
Received: from iklimasz-mobl1.ger.corp.intel.com (HELO [10.245.246.56]) ([10.245.246.56])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 06:43:39 -0700
Message-ID: <1aad588c-c3b8-46a9-bf70-03028d28350f@linux.intel.com>
Date: Wed, 12 Jun 2024 15:43:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [RESEND PATCH v4] ASoc: tas2781: Enable RCA-based
 playback without DSP firmware download
To: "Ding, Shenghao" <shenghao-ding@ti.com>,
 "broonie@kernel.org" <broonie@kernel.org>
Cc: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "perex@perex.cz"
 <perex@perex.cz>, "13916275206@139.com" <13916275206@139.com>,
 "zhourui@huaqin.com" <zhourui@huaqin.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "Salazar, Ivan" <i-salazar@ti.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Chadha, Jasjot Singh" <j-chadha@ti.com>,
 "liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>,
 "Yue, Jaden" <jaden-yue@ti.com>,
 "yung-chuan.liao@linux.intel.com" <yung-chuan.liao@linux.intel.com>,
 "Rao, Dipa" <dipa@ti.com>, "yuhsuan@google.com" <yuhsuan@google.com>,
 "Lo, Henry" <henry.lo@ti.com>, "tiwai@suse.de" <tiwai@suse.de>,
 "Xu, Baojun" <baojun.xu@ti.com>, "soyer@irl.hu" <soyer@irl.hu>,
 "Baojun.Xu@fpt.com" <Baojun.Xu@fpt.com>,
 "judyhsiao@google.com" <judyhsiao@google.com>,
 "Navada Kanyana, Mukund" <navada@ti.com>,
 "cujomalainey@google.com" <cujomalainey@google.com>,
 "Kutty, Aanya" <aanya@ti.com>, "Mahmud, Nayeem" <nayeem.mahmud@ti.com>,
 "savyasanchi.shukla@netradyne.com" <savyasanchi.shukla@netradyne.com>,
 "flaviopr@microsoft.com" <flaviopr@microsoft.com>,
 "Ji, Jesse" <jesse-ji@ti.com>,
 "darren.ye@mediatek.com" <darren.ye@mediatek.com>
References: <20240606124105.1492-1-shenghao-ding@ti.com>
 <146da765-c53f-4eb4-874e-53625daeb03e@linux.intel.com>
 <c56ec5c5bd7349a788251230deead24a@ti.com>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <c56ec5c5bd7349a788251230deead24a@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



>> Or this this saying that the baseline is the RCA case, and then the code
>> attempts to load firmware but in case of failures just keep going, i.e.
>> failing to load firmware is NOT an error?
> Correct.
>>
>> That would be somewhat different to the commit title that says 'without DSP
>> firmware download'.
>>
>> Would you mind clarifying the steps please?
> There's two bin files for tas2781, one is register settings(RCA bin file), the other is the dsp firmware and filter coeff.
> If no RCA bin file is load, the tas2781 can't work, it will be TASDEVICE_DSP_FW_FAIL.
> If only RCA bin file load, the tas2781 will work in bypass mode, which dsp do not work, neither spk protection nor acoustic 
> algorithm is enabled 
> (TASDEVICE_RCA_FW_OK).
> If both RCA bin and dsp firmware are loaded, that is TASDEVICE_DSP_FW_ALL_OK, tas2781 work in dsp mode, both spk protection
> and acoustic algorithm are enabled


Now I get it, and I guess I was thrown off by the title of your commit
message and previous comments that the DSP_FW_FAIL state is used for the
HDaudio mode.

It's not that the RCA mode is enabled by this patch. It was present
already in the existing driver code. This patch allows this RCA mode to
become a fallback if the DSP firmware load fails, but the DSP_FW_FAIL is
still used on RCA bin load problems.

So you may want to clarify the commit title and message, but from a code
perspective things looks ok:

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>


>>>  		tasdevice_dsp_remove(tas_priv);
>>>  	}
>>>  	mutex_unlock(&tas_priv->codec_lock);
>>> @@ -466,14 +474,14 @@ static int tasdevice_startup(struct
>>> snd_pcm_substream *substream,  {
>>>  	struct snd_soc_component *codec = dai->component;
>>>  	struct tasdevice_priv TASDEVICE_RCA_FW_OK*tas_priv =
>> snd_soc_component_get_drvdata(codec);
>>> -	int ret = 0;
>>>
>>> -	if (tas_priv->fw_state != TASDEVICE_DSP_FW_ALL_OK) {
>>> -		dev_err(tas_priv->dev, "DSP bin file not loaded\n");
>>> -		ret = -EINVAL;
>>> +	switch (tas_priv->fw_state) {
>>> +	case TASDEVICE_RCA_FW_OK:
>>> +	case TASDEVICE_DSP_FW_ALL_OK:
>>> +		return 0;
>>> +	default:
>>> +		return -EINVAL;
>>>  	}
>>> -
>>> -	return ret;
>>>  }
>>>
>>>  static int tasdevice_hw_params(struct snd_pcm_substream *substream,

