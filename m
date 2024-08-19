Return-Path: <linux-kernel+bounces-291623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FFA9564DD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 09:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DF952817A7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 07:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9400158DA7;
	Mon, 19 Aug 2024 07:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BLjJ3N/8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2A514AD3D;
	Mon, 19 Aug 2024 07:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724053323; cv=none; b=dB75/bMQukgPXf4659QRAm9jqwyfa8mSH8F8yXCSCoVySb5qXplNK1atCBy0K3WvCiq1nCE8t5JQ09dFPwZWfWmwbmivruSdeGuGFxq4FSIcxVteeNNGE2XZKnjfrHJst/jjOIlUIpOM0MpYQZoZXtkvtzklmHH6dAPNPEkBDt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724053323; c=relaxed/simple;
	bh=XhaDNYPtumre+DlT/8KrzFiXd1NiecHLNyAbKknf9t4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=T7JzQxgq8civNrQRoWBLO0Tw2DdggBLZMU6lPA/kJJazY5pRIgH0G8b1iT/XOFwEITceJP6xBtsQeCcaD9RcjfcbHDt5sdAIJZ4JO4xhx81Ngxv1JZgdzHZD4wHAf/CY6XdzURW2wR1MalY4lCC0/7ADcgJhsDfgjKimEdNrH3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BLjJ3N/8; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724053322; x=1755589322;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=XhaDNYPtumre+DlT/8KrzFiXd1NiecHLNyAbKknf9t4=;
  b=BLjJ3N/8fWv6uVzXAeYq9m7gK5NTGjbvFHvcYv/6JHstL1Jo4BaoB7iG
   8BaLJcGUJRDN8PHwlX3sDNM9w4RY+CnPKcmN6xpDYp5O4P6FSD3ajcDJD
   sowb+nq5MVCgNK2Kce782iJAlT66poKXe7UsdkHiLx31z0kDsRXe/YZYf
   yQqWhYzyp3mo9NK4ohAH5DpaSAmpKE1Pn56eZoBHiKnHQmpBJrMCsnANb
   fqdkHqLC+ITCPQZ1zhtmoYeJXO3/ck5CNs4KJCJUp532pLjFoEkijXkia
   WFDMDB5g7a8JQfdyQV+ku8QfQoHprEMOmc1e43W6V5egMIm+mdwK861TH
   w==;
X-CSE-ConnectionGUID: CrmTB1SaR1mEWpTHDZ6www==
X-CSE-MsgGUID: uNgA+5F8S+uwG/nRM/98aw==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="26079155"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="26079155"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 00:42:02 -0700
X-CSE-ConnectionGUID: 319Dz4XwQjqHxkKp+UQMeA==
X-CSE-MsgGUID: PrS+ec61QxCHcWL8Trew/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="64677106"
Received: from slindbla-desk.ger.corp.intel.com (HELO [10.245.246.57]) ([10.245.246.57])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 00:41:57 -0700
Message-ID: <6d83cd58-5f02-414b-b627-a0022e071052@linux.intel.com>
Date: Mon, 19 Aug 2024 08:42:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 4/6] ASoC: fsl_asrc_m2m: Add memory to memory
 function
To: Shengjiu Wang <shengjiu.wang@nxp.com>, vkoul@kernel.org, perex@perex.cz,
 tiwai@suse.com, alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, nicoleotsuka@gmail.com, lgirdwood@gmail.com,
 broonie@kernel.org, linuxppc-dev@lists.ozlabs.org
References: <1723804959-31921-1-git-send-email-shengjiu.wang@nxp.com>
 <1723804959-31921-5-git-send-email-shengjiu.wang@nxp.com>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <1723804959-31921-5-git-send-email-shengjiu.wang@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/16/24 12:42, Shengjiu Wang wrote:
> Implement the ASRC memory to memory function using
> the compress framework, user can use this function with
> compress ioctl interface.
> 
> Define below private metadata key value for output
> format, output rate and ratio modifier configuration.
> ASRC_OUTPUT_FORMAT 0x80000001
> ASRC_OUTPUT_RATE   0x80000002
> ASRC_RATIO_MOD     0x80000003

Can the output format/rate change at run-time?

If no, then these parameters should be moved somewhere else - e.g.
hw_params or something.

I am still not very clear on the expanding the SET_METADATA ioctl to
deal with the ratio changes. This isn't linked to the control layer as
suggested before, and there's no precedent of calling it multiple times
during streaming.

I also wonder how it was tested since tinycompress does not support this?


> +static int fsl_asrc_m2m_fill_codec_caps(struct fsl_asrc *asrc,
> +					struct snd_compr_codec_caps *codec)
> +{
> +	struct fsl_asrc_m2m_cap cap;
> +	__u32 rates[MAX_NUM_BITRATES];
> +	snd_pcm_format_t k;
> +	int i = 0, j = 0;
> +	int ret;
> +
> +	ret = asrc->m2m_get_cap(&cap);
> +	if (ret)
> +		return -EINVAL;
> +
> +	if (cap.rate_in & SNDRV_PCM_RATE_5512)
> +		rates[i++] = snd_pcm_rate_bit_to_rate(SNDRV_PCM_RATE_5512);

this doesn't sound compatible with the patch2 definitions?

cap->rate_in = SNDRV_PCM_RATE_8000_768000;

> +	if (cap.rate_in & SNDRV_PCM_RATE_8000)
> +		rates[i++] = snd_pcm_rate_bit_to_rate(SNDRV_PCM_RATE_8000);
> +	if (cap.rate_in & SNDRV_PCM_RATE_11025)
> +		rates[i++] = snd_pcm_rate_bit_to_rate(SNDRV_PCM_RATE_11025);
> +	if (cap.rate_in & SNDRV_PCM_RATE_16000)
> +		rates[i++] = snd_pcm_rate_bit_to_rate(SNDRV_PCM_RATE_16000);
> +	if (cap.rate_in & SNDRV_PCM_RATE_22050)
> +		rates[i++] = snd_pcm_rate_bit_to_rate(SNDRV_PCM_RATE_22050);

missing 24 kHz

> +	if (cap.rate_in & SNDRV_PCM_RATE_32000)
> +		rates[i++] = snd_pcm_rate_bit_to_rate(SNDRV_PCM_RATE_32000);
> +	if (cap.rate_in & SNDRV_PCM_RATE_44100)
> +		rates[i++] = snd_pcm_rate_bit_to_rate(SNDRV_PCM_RATE_44100);
> +	if (cap.rate_in & SNDRV_PCM_RATE_48000)
> +		rates[i++] = snd_pcm_rate_bit_to_rate(SNDRV_PCM_RATE_48000);

missing 64kHz

> +	if (cap.rate_in & SNDRV_PCM_RATE_88200)
> +		rates[i++] = snd_pcm_rate_bit_to_rate(SNDRV_PCM_RATE_88200);
> +	if (cap.rate_in & SNDRV_PCM_RATE_96000)
> +		rates[i++] = snd_pcm_rate_bit_to_rate(SNDRV_PCM_RATE_96000);
> +	if (cap.rate_in & SNDRV_PCM_RATE_176400)
> +		rates[i++] = snd_pcm_rate_bit_to_rate(SNDRV_PCM_RATE_176400);
> +	if (cap.rate_in & SNDRV_PCM_RATE_192000)
> +		rates[i++] = snd_pcm_rate_bit_to_rate(SNDRV_PCM_RATE_192000);
> +	if (cap.rate_in & SNDRV_PCM_RATE_352800)
> +		rates[i++] = snd_pcm_rate_bit_to_rate(SNDRV_PCM_RATE_352800);
> +	if (cap.rate_in & SNDRV_PCM_RATE_384000)
> +		rates[i++] = snd_pcm_rate_bit_to_rate(SNDRV_PCM_RATE_384000);
> +	if (cap.rate_in & SNDRV_PCM_RATE_705600)
> +		rates[i++] = snd_pcm_rate_bit_to_rate(SNDRV_PCM_RATE_705600);
> +	if (cap.rate_in & SNDRV_PCM_RATE_768000)
> +		rates[i++] = snd_pcm_rate_bit_to_rate(SNDRV_PCM_RATE_768000);
> +
> +	pcm_for_each_format(k) {
> +		if (pcm_format_to_bits(k) & cap.fmt_in) {
> +			codec->descriptor[j].max_ch = cap.chan_max;
> +			memcpy(codec->descriptor[j].sample_rates, rates, i * sizeof(__u32));
> +			codec->descriptor[j].num_sample_rates = i;
> +			codec->descriptor[j].formats = k;
> +			j++;
> +		}
> +	}
> +
> +	codec->codec = SND_AUDIOCODEC_PCM;
> +	codec->num_descriptors = j;
> +	return 0;



