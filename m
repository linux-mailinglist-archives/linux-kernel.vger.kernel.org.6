Return-Path: <linux-kernel+bounces-277568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6EF94A305
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C6DA1C208B2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 08:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EABB1C9DC9;
	Wed,  7 Aug 2024 08:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PBxyLdto"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F27822334;
	Wed,  7 Aug 2024 08:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723019864; cv=none; b=EYsn6CSvarTTkqsgeVEg3pSzzeITyvLHRtW4HfYxUXlOPfMr+iBcGFInVPHFd0FX5Rsncs9xVfbPc4Z2bK0K9TEYEfNiJXMsNt/W2z1Uh84f9+hZTp8Fr8V+e3/Dcj09lxNVz3QyRBod3zog7mfuNjZAJ6JN4Q2Vq9AqFhEKyR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723019864; c=relaxed/simple;
	bh=Ym4OPXtKdhKHOTqeu78sJOTOFNAnj/r5Rrje4PmiUa4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tiGXtN/xuwTkWKGd5hhaHO1gsIpfmmTn354HWsIBi+TKEK6pSPXpTEqK5K64lUyoVUr2poGbcrA84AzoFY2K4tI5RS6MYkRVW2qoK9QTeoGD56nKqy0AZauDj8/OOGfw2q7A3jj59PO1YQWVwlSKgcDj3nDEb5YIRRzjn5NIYgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PBxyLdto; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723019862; x=1754555862;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ym4OPXtKdhKHOTqeu78sJOTOFNAnj/r5Rrje4PmiUa4=;
  b=PBxyLdtoLPHCv0PZ8bN390XpWvwi81ocz4E7sfvEy1Ne7zxZkRmUCeVy
   y8Z9COGrZsNOa6i1OmdK+7iU+4gkRSQXh2KlugpAZxSDsNFeBw5QDBmqN
   B27MC/O21eDZrKTav9F2gxhS/0P82lIXm/VhXMLuNdSvzrqhYz1+EK3oF
   wHDeULDjZ9Xzcx6eUAYBsTZpkoh++uDYwoW0/ylNSs0NjTPhho4b4Q5k1
   BLZ3zBpzllY4RZxbWDi9gHitdJnI01Rg0pOtDrJ+tqOgm/KFbuD2NDWUK
   jCYkX20IoaKaRXHdz9LJIcmZ7bEsy/3UuyxFnk8HWeeYhUY2g+32UtBnS
   A==;
X-CSE-ConnectionGUID: Avz0Z98nTYqI/UkhpA2ZSg==
X-CSE-MsgGUID: T8Tp0UfqTcuqut1s/7J5iQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="38586022"
X-IronPort-AV: E=Sophos;i="6.09,269,1716274800"; 
   d="scan'208";a="38586022"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 01:37:41 -0700
X-CSE-ConnectionGUID: sUAmBQVmTL66Lo8BUjrCDQ==
X-CSE-MsgGUID: TA0z/V6BRsKxsWNQzy/bTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,269,1716274800"; 
   d="scan'208";a="57330741"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO [10.245.246.75]) ([10.245.246.75])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 01:37:35 -0700
Message-ID: <250c63d7-d81e-49ea-ac8f-2e3496075f20@linux.intel.com>
Date: Wed, 7 Aug 2024 10:37:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sound: sof: ioc4-topology: avoid extra dai_params copy
To: Arnd Bergmann <arnd@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 Seppo Ingalsuo <seppo.ingalsuo@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Kai Vehmanen
 <kai.vehmanen@linux.intel.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Brent Lu <brent.lu@intel.com>, sound-open-firmware@alsa-project.org,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
References: <20240807080302.2372297-1-arnd@kernel.org>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20240807080302.2372297-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/7/24 10:02, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The snd_pcm_hw_params structure is really too large to fit on the
> stack. Because of the way that clang inlines functions, it ends up
> twice in one function, which exceeds the 1024 byte limit for 32-bit
> architecutes:
> 
> sound/soc/sof/ipc4-topology.c:1700:1: error: stack frame size (1304) exceeds limit (1024) in 'sof_ipc4_prepare_copier_module' [-Werror,-Wframe-larger-than]
> sof_ipc4_prepare_copier_module(struct snd_sof_widget *swidget,
> 
>>From what I can tell, this was unintentional, as both
> sof_ipc4_prepare_dai_copier() and sof_ipc4_prepare_copier_module() make a
> copy for the same purpose, but copying it once has the exact same effect.

Humm, not sure. I think the copy was intentional so that if one of the
fixups fails, then the initial hw_params structure is not modified.

Also not sure why a compiler would think inlining such a large function
is a good idea?

Probably need Ranjani, Peter and Bard to comment on the format handling.


> Remove the extra copy and change the direct struct assignment to
> an explicit memcpy() call to make it clearer to the reader that this
> is what happens. Note that gcc treats struct assignment as a memcpy()
> that may be inlined anyway, so the resulting object code is the same.
> 
> Fixes: f9209644ae76 ("ASoC: SOF: ipc4-topology: Correct DAI copier config and NHLT blob request")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  sound/soc/sof/ipc4-topology.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
> index 87be7f16e8c2..77f6850010f6 100644
> --- a/sound/soc/sof/ipc4-topology.c
> +++ b/sound/soc/sof/ipc4-topology.c
> @@ -1651,7 +1651,6 @@ sof_ipc4_prepare_dai_copier(struct snd_sof_dev *sdev, struct snd_sof_dai *dai,
>  			    struct snd_pcm_hw_params *params, int dir)
>  {
>  	struct sof_ipc4_available_audio_format *available_fmt;
> -	struct snd_pcm_hw_params dai_params = *params;
>  	struct sof_ipc4_copier_data *copier_data;
>  	struct sof_ipc4_pin_format *pin_fmts;
>  	struct sof_ipc4_copier *ipc4_copier;
> @@ -1676,7 +1675,7 @@ sof_ipc4_prepare_dai_copier(struct snd_sof_dev *sdev, struct snd_sof_dai *dai,
>  		num_pin_fmts = available_fmt->num_input_formats;
>  	}
>  
> -	ret = sof_ipc4_adjust_params_to_dai_format(sdev, &dai_params, pin_fmts,
> +	ret = sof_ipc4_adjust_params_to_dai_format(sdev, params, pin_fmts,
>  						   num_pin_fmts);
>  	if (ret)
>  		return ret;
> @@ -1684,15 +1683,11 @@ sof_ipc4_prepare_dai_copier(struct snd_sof_dev *sdev, struct snd_sof_dai *dai,
>  	single_bitdepth = sof_ipc4_copier_is_single_bitdepth(sdev, pin_fmts,
>  							     num_pin_fmts);
>  	ret = snd_sof_get_nhlt_endpoint_data(sdev, dai, single_bitdepth,
> -					     &dai_params,
> +					     params,
>  					     ipc4_copier->dai_index,
>  					     ipc4_copier->dai_type, dir,
>  					     &ipc4_copier->copier_config,
>  					     &copier_data->gtw_cfg.config_length);
> -	/* Update the params to reflect the changes made in this function */
> -	if (!ret)
> -		*params = dai_params;
> -
>  	return ret;
>  }
>  
> @@ -1784,9 +1779,9 @@ sof_ipc4_prepare_copier_module(struct snd_sof_widget *swidget,
>  		 * for capture.
>  		 */
>  		if (dir == SNDRV_PCM_STREAM_PLAYBACK)
> -			ref_params = *fe_params;
> +			memcpy(&ref_params, fe_params, sizeof(ref_params));
>  		else
> -			ref_params = *pipeline_params;
> +			memcpy(&ref_params, pipeline_params, sizeof(ref_params));
>  
>  		copier_data->gtw_cfg.node_id &= ~SOF_IPC4_NODE_INDEX_MASK;
>  		copier_data->gtw_cfg.node_id |=
> @@ -1819,7 +1814,7 @@ sof_ipc4_prepare_copier_module(struct snd_sof_widget *swidget,
>  		 * In case of capture the ref_params returned will be used to
>  		 * find the input configuration of the copier.
>  		 */
> -		ref_params = *fe_params;
> +		memcpy(&ref_params, fe_params, sizeof(ref_params));
>  		ret = sof_ipc4_prepare_dai_copier(sdev, dai, &ref_params, dir);
>  		if (ret < 0)
>  			return ret;
> @@ -1829,7 +1824,7 @@ sof_ipc4_prepare_copier_module(struct snd_sof_widget *swidget,
>  		 * input configuration of the copier.
>  		 */
>  		if (dir == SNDRV_PCM_STREAM_PLAYBACK)
> -			ref_params = *pipeline_params;
> +			memcpy(&ref_params, pipeline_params, sizeof(ref_params));
>  
>  		break;
>  	}
> @@ -1838,7 +1833,7 @@ sof_ipc4_prepare_copier_module(struct snd_sof_widget *swidget,
>  		ipc4_copier = (struct sof_ipc4_copier *)swidget->private;
>  		copier_data = &ipc4_copier->data;
>  		available_fmt = &ipc4_copier->available_fmt;
> -		ref_params = *pipeline_params;
> +		memcpy(&ref_params, pipeline_params, sizeof(ref_params));
>  
>  		break;
>  	}


