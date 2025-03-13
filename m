Return-Path: <linux-kernel+bounces-559311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B160A5F239
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC9223BDF06
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305D126618A;
	Thu, 13 Mar 2025 11:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AzwSLWA/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA361FAC51;
	Thu, 13 Mar 2025 11:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741864847; cv=none; b=I7BzDcLMTNKc78nCAI9RfKj18hzB7P6KqWk8pR3ghlBKTQo5qN77Pc6IYO8UflMTSoSHW/MZB6rrdN1MOCnWFMmzxG5TjaDQANU0GF2/G3RePGIm2T5WJ2qjRDmzOjJI//MJd4z8LN2hy7Ty8DZb1s6KoT+blCTHaoQ0MSeS2oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741864847; c=relaxed/simple;
	bh=hToZW9/4x47mKSYrXIUJ2djr0pkTpdYJARGHnq4Nwaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t6hhNxECmy2nEujy3bNEHosIjRfW7zwQVApT13PVI7BAEYFScBHHEx043AeuoZVVgLDAbJgVuXBAY7luMWTOeBHWQsJQ5bVuUqGcstzNNESVnjJdo7etqRukS+KvJ4TOkp8OojvrfAnAnqbWPoTkywSDcrSp28WzrHypnzRSA3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AzwSLWA/; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741864844; x=1773400844;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hToZW9/4x47mKSYrXIUJ2djr0pkTpdYJARGHnq4Nwaw=;
  b=AzwSLWA/m9b8Ut8PvvghGXiixYOFFzDuyFLgJxGw+fo5H9FlS+55NUek
   PWW5ue6PebhCz2cwWaJRbj5Jj9vwMQ43YI/zFt98BF5CqEs/JCapwFiw+
   nnqAYWm4FespyxvUYZ22A82SEIrp0v+NIeWGUWxOCUT+BT/g4GTpCUFli
   GCrEd7RcTu0Cj6+zVxLtJr/m8YUmxnRTQl1d5p4Ui0hgUiRR+Dwpqdqtu
   QsUR2BBtK3m/3yNTF2xDf9QsEG+9edWXLQP2oL7S9ac2JxW0f5h7LyL/B
   b5mvOhiK97v2iVcmyunqH1Kz6iMfG+gBmyY4OGMglstYwZ7sEtvvRuI5X
   Q==;
X-CSE-ConnectionGUID: pz7MiPkeTMG3kg/uR6BpPg==
X-CSE-MsgGUID: DAd8V+P+QPGXv5GZYhmltw==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="53970638"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="53970638"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 04:20:44 -0700
X-CSE-ConnectionGUID: GbcQkpQYRLKZjG+vUW2MJg==
X-CSE-MsgGUID: ZY+zSvjLSVy3pfVtyaAL9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="125094547"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO [10.245.250.7]) ([10.245.250.7])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 04:20:38 -0700
Message-ID: <bdc7b218-8f14-4bfd-8a76-2f35e5a9393c@linux.intel.com>
Date: Thu, 13 Mar 2025 13:21:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] ASoC: SOF: ipc4-topology: Allocate ref_params on
 stack
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Cc: Liam Girdwood <lgirdwood@gmail.com>, Daniel Baluta
 <daniel.baluta@nxp.com>, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
References: <20250312160516.3864295-1-andriy.shevchenko@linux.intel.com>
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20250312160516.3864295-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 12/03/2025 18:05, Andy Shevchenko wrote:
> Currently the compiler (clang 19.1.7) is not happy about the size of
> the stack frame in sof_ipc4_prepare_copier_module:
> 
> sound/soc/sof/ipc4-topology.c:1800:1: error: stack frame size (1288) exceeds limit (1024) in 'sof_ipc4_prepare_copier_module' [-Werror,-Wframe-larger-than]
>  1800 | sof_ipc4_prepare_copier_module(struct snd_sof_widget *swidget,
>       | ^
> 
> Work around this by allocating ref_params on stack, as it looks the biggest
> variable on stack right now.
> 
> Note, this only happens when compile for 32-bit machines (x86_32 in my case).

I don't have better idea for fix, apart from somehow refactor this huge
function.
Thank you for the fix,

Acked-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  sound/soc/sof/ipc4-topology.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
> index 6d5cda813e48..41110ee6edc7 100644
> --- a/sound/soc/sof/ipc4-topology.c
> +++ b/sound/soc/sof/ipc4-topology.c
> @@ -7,6 +7,7 @@
>  //
>  //
>  #include <linux/bitfield.h>
> +#include <linux/cleanup.h>
>  #include <uapi/sound/sof/tokens.h>
>  #include <sound/pcm_params.h>
>  #include <sound/sof/ext_manifest4.h>
> @@ -1807,8 +1808,8 @@ sof_ipc4_prepare_copier_module(struct snd_sof_widget *swidget,
>  	struct snd_sof_dev *sdev = snd_soc_component_get_drvdata(scomp);
>  	struct sof_ipc4_copier_data *copier_data;
>  	int input_fmt_index, output_fmt_index;
> -	struct snd_pcm_hw_params ref_params;
>  	struct sof_ipc4_copier *ipc4_copier;
> +	struct snd_pcm_hw_params *ref_params __free(kfree) = NULL;
>  	struct snd_sof_dai *dai;
>  	u32 gtw_cfg_config_length;
>  	u32 dma_config_tlv_size = 0;
> @@ -1884,9 +1885,11 @@ sof_ipc4_prepare_copier_module(struct snd_sof_widget *swidget,
>  		 * for capture.
>  		 */
>  		if (dir == SNDRV_PCM_STREAM_PLAYBACK)
> -			ref_params = *fe_params;
> +			ref_params = kmemdup(fe_params, sizeof(*ref_params), GFP_KERNEL);
>  		else
> -			ref_params = *pipeline_params;
> +			ref_params = kmemdup(pipeline_params, sizeof(*ref_params), GFP_KERNEL);
> +		if (!ref_params)
> +			return -ENOMEM;
>  
>  		copier_data->gtw_cfg.node_id &= ~SOF_IPC4_NODE_INDEX_MASK;
>  		copier_data->gtw_cfg.node_id |=
> @@ -1919,8 +1922,11 @@ sof_ipc4_prepare_copier_module(struct snd_sof_widget *swidget,
>  		 * In case of capture the ref_params returned will be used to
>  		 * find the input configuration of the copier.
>  		 */
> -		ref_params = *fe_params;
> -		ret = sof_ipc4_prepare_dai_copier(sdev, dai, &ref_params, dir);
> +		ref_params = kmemdup(fe_params, sizeof(*ref_params), GFP_KERNEL);
> +		if (!ref_params)
> +			return -ENOMEM;
> +
> +		ret = sof_ipc4_prepare_dai_copier(sdev, dai, ref_params, dir);
>  		if (ret < 0)
>  			return ret;
>  
> @@ -1929,7 +1935,7 @@ sof_ipc4_prepare_copier_module(struct snd_sof_widget *swidget,
>  		 * input configuration of the copier.
>  		 */
>  		if (dir == SNDRV_PCM_STREAM_PLAYBACK)
> -			ref_params = *pipeline_params;
> +			memcpy(ref_params, pipeline_params, sizeof(*ref_params));
>  
>  		break;
>  	}
> @@ -1938,7 +1944,10 @@ sof_ipc4_prepare_copier_module(struct snd_sof_widget *swidget,
>  		ipc4_copier = (struct sof_ipc4_copier *)swidget->private;
>  		copier_data = &ipc4_copier->data;
>  		available_fmt = &ipc4_copier->available_fmt;
> -		ref_params = *pipeline_params;
> +
> +		ref_params = kmemdup(pipeline_params, sizeof(*ref_params), GFP_KERNEL);
> +		if (!ref_params)
> +			return -ENOMEM;
>  
>  		break;
>  	}
> @@ -1951,7 +1960,7 @@ sof_ipc4_prepare_copier_module(struct snd_sof_widget *swidget,
>  	/* set input and output audio formats */
>  	input_fmt_index = sof_ipc4_init_input_audio_fmt(sdev, swidget,
>  							&copier_data->base_config,
> -							&ref_params, available_fmt);
> +							ref_params, available_fmt);
>  	if (input_fmt_index < 0)
>  		return input_fmt_index;
>  

-- 
Péter


