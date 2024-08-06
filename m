Return-Path: <linux-kernel+bounces-276041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E13948D9C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03F62280DB3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 11:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39531C2335;
	Tue,  6 Aug 2024 11:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QhUBkTPr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE27813B2AC;
	Tue,  6 Aug 2024 11:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722943540; cv=none; b=qZ8LSZtZz0AN0Byt7FYGPKVGbjhk9Ylej34zXQnWQZPMVKvcdWs9/sAZXi9rL8E6Z7MjxMtVEh66mEJVCdscpU1Sj9ww7WdwqmOKtVjCvqYk5b9hDRnFT0dqfgRP6zzr48nkJt0RJYM0r23jUxwqkzTFQ/WXa3ejUOEg4FcWFrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722943540; c=relaxed/simple;
	bh=XeP8qMVW9duWHN2BUl9XidmCMVmrVkb5XZ55nX3RpWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CGGCgP5CzpEFzlwJEOSewDyQnp90zsDZKotwUvlqKSGjoUlzgOMB7YSrbhBszdF3YS8VKueDjZsG9NNHFYKeDA6Q5xfTSlr94mKOJO6IOYk2AwJtFyZ5BUDB6AgPp0lTyGZYBOtupo+vB21cXagjxZkqXrndEAxcDqCtTjvlTms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QhUBkTPr; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722943538; x=1754479538;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=XeP8qMVW9duWHN2BUl9XidmCMVmrVkb5XZ55nX3RpWU=;
  b=QhUBkTPrVEQaKxPIwWyQ7x1J57OSf/x5PGwWuxLAkDvqG1k04tE1u429
   FfKzbjVLcb4B6PLFECwmTTgxvMUVc0mMWJupbCJiSltVb+npcmm/o8411
   0nEeEOfd/x5FU5GUCIuWoTVZP5bBrk69kak17LiaW7MqSZ+rKtbIp+TZZ
   j0nij8St+C2ccHwOmIBt2s+GFl8yeSeEvzKKU+LGmC2P69g/amIAWcjOz
   dTGz+/QCOrJpMjEyk7V2FdcqBwfCbaTQ6qai2xFqG+gPJCmXQtIap6RHb
   cRXRo9DXmy2jeJ6lVBA9gMsSlToUzr+UrPNiM9pxLGX7uHUSXsX2wKS2o
   Q==;
X-CSE-ConnectionGUID: Z8IjaQKDQuG2g1BQXJI6jA==
X-CSE-MsgGUID: cKtBJhieRweIqUfqILNsbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="20804834"
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="20804834"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 04:25:37 -0700
X-CSE-ConnectionGUID: uVVs95WMQuuVeX2XlWhaPA==
X-CSE-MsgGUID: 4wC1AypiTUqIxnJYqoPfTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="56399162"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO [10.245.246.248]) ([10.245.246.248])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 04:25:34 -0700
Message-ID: <e89a56bf-c377-43d8-bba8-6a09e571ed64@linux.intel.com>
Date: Tue, 6 Aug 2024 13:16:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/6] ALSA: compress: add Sample Rate Converter codec
 support
To: Shengjiu Wang <shengjiu.wang@nxp.com>, vkoul@kernel.org, perex@perex.cz,
 tiwai@suse.com, alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, nicoleotsuka@gmail.com, lgirdwood@gmail.com,
 broonie@kernel.org, linuxppc-dev@lists.ozlabs.org
References: <1722940003-20126-1-git-send-email-shengjiu.wang@nxp.com>
 <1722940003-20126-2-git-send-email-shengjiu.wang@nxp.com>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <1722940003-20126-2-git-send-email-shengjiu.wang@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/6/24 12:26, Shengjiu Wang wrote:
> Add Sample Rate Converter(SRC) codec support, define the output
> format and rate for SRC.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  include/uapi/sound/compress_offload.h | 2 ++
>  include/uapi/sound/compress_params.h  | 9 ++++++++-
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/sound/compress_offload.h b/include/uapi/sound/compress_offload.h
> index 98772b0cbcb7..8b2b72f94e26 100644
> --- a/include/uapi/sound/compress_offload.h
> +++ b/include/uapi/sound/compress_offload.h
> @@ -112,10 +112,12 @@ struct snd_compr_codec_caps {
>   * end of the track
>   * @SNDRV_COMPRESS_ENCODER_DELAY: no of samples inserted by the encoder at the
>   * beginning of the track
> + * @SNDRV_COMPRESS_SRC_RATIO_MOD: Resampling Ratio Modifier for sample rate converter
>   */
>  enum sndrv_compress_encoder {
>  	SNDRV_COMPRESS_ENCODER_PADDING = 1,
>  	SNDRV_COMPRESS_ENCODER_DELAY = 2,
> +	SNDRV_COMPRESS_SRC_RATIO_MOD = 3,
>  };

this sounds wrong to me. The sample rate converter is not an "encoder",
and the properties for padding/delay are totally specific to an encoder
function.

The other point is that I am not sure how standard this ratio_mod
parameter is. This could be totally specific to a specific
implementation, and another ASRC might have different parameters.

>  
>  /**
> diff --git a/include/uapi/sound/compress_params.h b/include/uapi/sound/compress_params.h
> index ddc77322d571..0843773ea6b4 100644
> --- a/include/uapi/sound/compress_params.h
> +++ b/include/uapi/sound/compress_params.h
> @@ -43,7 +43,8 @@
>  #define SND_AUDIOCODEC_BESPOKE               ((__u32) 0x0000000E)
>  #define SND_AUDIOCODEC_ALAC                  ((__u32) 0x0000000F)
>  #define SND_AUDIOCODEC_APE                   ((__u32) 0x00000010)
> -#define SND_AUDIOCODEC_MAX                   SND_AUDIOCODEC_APE
> +#define SND_AUDIOCODEC_SRC                   ((__u32) 0x00000011)
> +#define SND_AUDIOCODEC_MAX                   SND_AUDIOCODEC_SRC

I am not sure this is wise to change such definitions?
>  
>  /*
>   * Profile and modes are listed with bit masks. This allows for a
> @@ -324,6 +325,11 @@ struct snd_dec_ape {
>  	__u32 seek_table_present;
>  } __attribute__((packed, aligned(4)));
>  
> +struct snd_dec_src {
> +	__u32 format_out;
> +	__u32 rate_out;
> +} __attribute__((packed, aligned(4)));

Again I am not sure how standard those parameters are, and even if they
were if their representation is reusable.

And the compressed API has a good split between encoders and decoders, I
am not sure how an SRC can be classified as either.

>  union snd_codec_options {
>  	struct snd_enc_wma wma;
>  	struct snd_enc_vorbis vorbis;
> @@ -334,6 +340,7 @@ union snd_codec_options {
>  	struct snd_dec_wma wma_d;
>  	struct snd_dec_alac alac_d;
>  	struct snd_dec_ape ape_d;
> +	struct snd_dec_src src;
>  } __attribute__((packed, aligned(4)));
>  
>  /** struct snd_codec_desc - description of codec capabilities


