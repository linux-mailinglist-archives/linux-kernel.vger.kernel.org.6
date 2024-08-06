Return-Path: <linux-kernel+bounces-276069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FCE948E0B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 814412846B2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 11:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D1B1C233B;
	Tue,  6 Aug 2024 11:45:50 +0000 (UTC)
Received: from hosting3.qishost.com (signalogic.com [209.150.126.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE3B16B3B5;
	Tue,  6 Aug 2024 11:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.150.126.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722944750; cv=none; b=GqYnBDLuJ4joE35llDAen0ICX4AP3h0CXipsfzddi1VUn/EN9kQLqit5RWTxIUlgML9grtx/gyORND5HjgVqyHaaqt2XfHP+H5uoNbF4Gu7QkPMjEZNaUQWAKljRsmPZiDpVsmMm9xhBwad9FmgpPsZFMBp7SRF6nAfpYniCrkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722944750; c=relaxed/simple;
	bh=IZLPCVzb3kPUDGJIg69Ehm8qFNzjVH6IUeurAwjF0EU=;
	h=Date:Message-ID:From:To:Cc:Subject:References:In-Reply-To:
	 Content-Type:MIME-Version:Content-Disposition; b=pDH9opPHrS+WpK0sqYW/fuW1sLwcKNUXDDSMvIYmaUXeRJncniy+cxwvllwes6vO2c534AsyA/Ucg2M5znFzNhaq1r7IIwvdjJHispMeK7dFjyNdt/o+AP18Vg9EjsPF5JNDcAHBrD3YW9T6htjNIfmcURqTuLtuv2psXoKw190=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=signalogic.com; spf=pass smtp.mailfrom=signalogic.com; arc=none smtp.client-ip=209.150.126.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=signalogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=signalogic.com
Received: from hosting3.qishost.com (localhost [IPv6:::1])
	by hosting3.qishost.com (Postfix) with ESMTPSA id 7702F45A59;
	Tue,  6 Aug 2024 07:39:36 -0400 (EDT)
Authentication-Results: hosting3.qishost.com;
        spf=pass (sender IP is ::1) smtp.mailfrom=jbrower@signalogic.com smtp.helo=hosting3.qishost.com
Received-SPF: pass (hosting3.qishost.com: connection is authenticated)
Received: from c-76-132-49-220.hsd1.ca.comcast.net
 (c-76-132-49-220.hsd1.ca.comcast.net [76.132.49.220]) by
 webmail.signalogic.com (Horde Framework) with HTTP; Tue, 06 Aug 2024
 11:39:36 +0000
Date: Tue, 06 Aug 2024 11:39:36 +0000
Message-ID: <20240806113936.Horde.vcDWoEx08a51SUfvt56nQ2p@webmail.signalogic.com>
From: Jeff Brower <jbrower@signalogic.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, vkoul@kernel.org, perex@perex.cz,
 tiwai@suse.com, alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, nicoleotsuka@gmail.com, lgirdwood@gmail.com,
 broonie@kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH 1/6] ALSA: compress: add Sample Rate Converter codec
 support
References: <1722940003-20126-1-git-send-email-shengjiu.wang@nxp.com>
 <1722940003-20126-2-git-send-email-shengjiu.wang@nxp.com>
 <e89a56bf-c377-43d8-bba8-6a09e571ed64@linux.intel.com>
In-Reply-To: <e89a56bf-c377-43d8-bba8-6a09e571ed64@linux.intel.com>
User-Agent: Horde Application Framework 5
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline

All-

"The sample rate converter is not an encoder ..."

Indeed, an encoder creates a compressed bitstream from audio data  
(typically linear PCM samples), normally for transmission of some  
type. A sample rate converter generates audio data from audio data,  
and is normally applied prior to an encoder because it can only accept  
a limited range of sample rates.

-Jeff

Quoting Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>:

> On 8/6/24 12:26, Shengjiu Wang wrote:
>> Add Sample Rate Converter(SRC) codec support, define the output
>> format and rate for SRC.
>>
>> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
>> ---
>>  include/uapi/sound/compress_offload.h | 2 ++
>>  include/uapi/sound/compress_params.h  | 9 ++++++++-
>>  2 files changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/uapi/sound/compress_offload.h  
>> b/include/uapi/sound/compress_offload.h
>> index 98772b0cbcb7..8b2b72f94e26 100644
>> --- a/include/uapi/sound/compress_offload.h
>> +++ b/include/uapi/sound/compress_offload.h
>> @@ -112,10 +112,12 @@ struct snd_compr_codec_caps {
>>   * end of the track
>>   * @SNDRV_COMPRESS_ENCODER_DELAY: no of samples inserted by the  
>> encoder at the
>>   * beginning of the track
>> + * @SNDRV_COMPRESS_SRC_RATIO_MOD: Resampling Ratio Modifier for  
>> sample rate converter
>>   */
>>  enum sndrv_compress_encoder {
>>  	SNDRV_COMPRESS_ENCODER_PADDING = 1,
>>  	SNDRV_COMPRESS_ENCODER_DELAY = 2,
>> +	SNDRV_COMPRESS_SRC_RATIO_MOD = 3,
>>  };
>
> this sounds wrong to me. The sample rate converter is not an "encoder",
> and the properties for padding/delay are totally specific to an encoder
> function.
>
> The other point is that I am not sure how standard this ratio_mod
> parameter is. This could be totally specific to a specific
> implementation, and another ASRC might have different parameters.
>
>>
>>  /**
>> diff --git a/include/uapi/sound/compress_params.h  
>> b/include/uapi/sound/compress_params.h
>> index ddc77322d571..0843773ea6b4 100644
>> --- a/include/uapi/sound/compress_params.h
>> +++ b/include/uapi/sound/compress_params.h
>> @@ -43,7 +43,8 @@
>>  #define SND_AUDIOCODEC_BESPOKE               ((__u32) 0x0000000E)
>>  #define SND_AUDIOCODEC_ALAC                  ((__u32) 0x0000000F)
>>  #define SND_AUDIOCODEC_APE                   ((__u32) 0x00000010)
>> -#define SND_AUDIOCODEC_MAX                   SND_AUDIOCODEC_APE
>> +#define SND_AUDIOCODEC_SRC                   ((__u32) 0x00000011)
>> +#define SND_AUDIOCODEC_MAX                   SND_AUDIOCODEC_SRC
>
> I am not sure this is wise to change such definitions?
>>
>>  /*
>>   * Profile and modes are listed with bit masks. This allows for a
>> @@ -324,6 +325,11 @@ struct snd_dec_ape {
>>  	__u32 seek_table_present;
>>  } __attribute__((packed, aligned(4)));
>>
>> +struct snd_dec_src {
>> +	__u32 format_out;
>> +	__u32 rate_out;
>> +} __attribute__((packed, aligned(4)));
>
> Again I am not sure how standard those parameters are, and even if they
> were if their representation is reusable.
>
> And the compressed API has a good split between encoders and decoders, I
> am not sure how an SRC can be classified as either.
>
>>  union snd_codec_options {
>>  	struct snd_enc_wma wma;
>>  	struct snd_enc_vorbis vorbis;
>> @@ -334,6 +340,7 @@ union snd_codec_options {
>>  	struct snd_dec_wma wma_d;
>>  	struct snd_dec_alac alac_d;
>>  	struct snd_dec_ape ape_d;
>> +	struct snd_dec_src src;
>>  } __attribute__((packed, aligned(4)));
>>
>>  /** struct snd_codec_desc - description of codec capabilities




