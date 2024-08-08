Return-Path: <linux-kernel+bounces-279361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC76694BC45
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 13:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC3161C20C9A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 11:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710A518B487;
	Thu,  8 Aug 2024 11:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lfmnshT2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DE013D265;
	Thu,  8 Aug 2024 11:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723116458; cv=none; b=MbNHyzR8QV9vFvNjJKnCUDSOI6S0lAvii5XW0DseSF+I7kSqCkS1kZYXOR72ilHlEUEk8bzXiUvwEkOvUgi4oZqryI0ytdE2UI4gWoz+Wd8qpcrXVi2z/WF8tv6kjESqWBWwfTQHnVDmf8BFnScToEeTfeFLpqTNjAAk+KUEBBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723116458; c=relaxed/simple;
	bh=VmB/6QS1FQ+RUMXWz253lu/uSyqhXxIJWMc4iBtGTIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tpq40xQUdKU8jCAL6RYtgsjUFKJ2r7JDSKCY1hbNa/F/ZS+JvAbdlgk3Mtwmg2iT5XB96K6v/9EB80jWik8IsEg8HmK/ToiK62+hFdVtsdKKl9Z6pSfkICK9YtF4AzWaGjeC8KR9IjSrUXFDy3ZSs7s8wEGnTQI6QTKkjBlajyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lfmnshT2; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723116457; x=1754652457;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VmB/6QS1FQ+RUMXWz253lu/uSyqhXxIJWMc4iBtGTIA=;
  b=lfmnshT2n+6WbAq2USO96vXFrGYWsr7iFE5OEGPG3529FVa0inZzphpw
   Dv7UufmZx2zo2PgFdaOKK1dchqFrNcTafWa1ppdEXRm6g4yZU9JIB+Jcw
   r4J98EKezomoScVjNpMjTuuTFU+PNRw1DRSa8p9QdG3QuXGSmBAEuAvS6
   DEi8V6QFT8+gDMyKhhPYGnKpiRvwqmKp7LP4xRgql/ihFBewz8VlhgSFZ
   jc2W9Mp98YI9e6VwBKL5cf0dbqnaw+Y2HU7GB5fIsEQatCeoZ75C6ncB6
   NPQxqnggMjJQ5cxPInBZazSxRq3MbD83DwWdhNSnsuroVxNExDXEHr+wF
   A==;
X-CSE-ConnectionGUID: usIVvuytTNC++ke3GjjeCg==
X-CSE-MsgGUID: EB/qUY5cQoOseBFYhm4F6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="38742180"
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="38742180"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 04:27:36 -0700
X-CSE-ConnectionGUID: CU7zVrCdQxe/FdISjC4yqQ==
X-CSE-MsgGUID: oN5J9gC0QvOy35eh/N/PBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="61575228"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO [10.245.246.169]) ([10.245.246.169])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 04:27:32 -0700
Message-ID: <ffa85004-8d86-4168-b278-afd24d79f9d8@linux.intel.com>
Date: Thu, 8 Aug 2024 13:27:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/6] ALSA: compress: add Sample Rate Converter codec
 support
To: Shengjiu Wang <shengjiu.wang@gmail.com>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, vkoul@kernel.org, perex@perex.cz,
 tiwai@suse.com, alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <1722940003-20126-1-git-send-email-shengjiu.wang@nxp.com>
 <1722940003-20126-2-git-send-email-shengjiu.wang@nxp.com>
 <e89a56bf-c377-43d8-bba8-6a09e571ed64@linux.intel.com>
 <CAA+D8AN9JXJr-BZf8aY7d4rB6M60pXS_DG=qv=P6=2r1A18ATA@mail.gmail.com>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <CAA+D8AN9JXJr-BZf8aY7d4rB6M60pXS_DG=qv=P6=2r1A18ATA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/8/24 11:17, Shengjiu Wang wrote:
> On Tue, Aug 6, 2024 at 7:25 PM Pierre-Louis Bossart
> <pierre-louis.bossart@linux.intel.com> wrote:
>>
>>
>>
>> On 8/6/24 12:26, Shengjiu Wang wrote:
>>> Add Sample Rate Converter(SRC) codec support, define the output
>>> format and rate for SRC.
>>>
>>> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
>>> ---
>>>  include/uapi/sound/compress_offload.h | 2 ++
>>>  include/uapi/sound/compress_params.h  | 9 ++++++++-
>>>  2 files changed, 10 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/uapi/sound/compress_offload.h b/include/uapi/sound/compress_offload.h
>>> index 98772b0cbcb7..8b2b72f94e26 100644
>>> --- a/include/uapi/sound/compress_offload.h
>>> +++ b/include/uapi/sound/compress_offload.h
>>> @@ -112,10 +112,12 @@ struct snd_compr_codec_caps {
>>>   * end of the track
>>>   * @SNDRV_COMPRESS_ENCODER_DELAY: no of samples inserted by the encoder at the
>>>   * beginning of the track
>>> + * @SNDRV_COMPRESS_SRC_RATIO_MOD: Resampling Ratio Modifier for sample rate converter
>>>   */
>>>  enum sndrv_compress_encoder {
>>>       SNDRV_COMPRESS_ENCODER_PADDING = 1,
>>>       SNDRV_COMPRESS_ENCODER_DELAY = 2,
>>> +     SNDRV_COMPRESS_SRC_RATIO_MOD = 3,
>>>  };
>>
>> this sounds wrong to me. The sample rate converter is not an "encoder",
>> and the properties for padding/delay are totally specific to an encoder
>> function.
> 
> There is only decoder and encoder definition for compress,  I know
> it is difficult to add SRC to encoder or decoder classification,
> SRC is a Post Processing.  I hope you can have a recommandation

I don't. I think we're blurring layers in a really odd way.

The main reason why the compress API was added is to remove the
byte-to-time conversions. But that's clearly not useful for a
post-processing of PCM data, where the bitrate is constant. It really
feels like we're adding this memory-to-memory API to the compress
framework because we don't have anything else available, not because it
makes sense to do so.

Then there's the issue of parameters, we chose to only add parameters
for standard encoders/decoders. Post-processing is highly specific and
the parameter definitions varies from one implementation to another -
and usually parameters are handled in an opaque way with binary
controls. This is best handled with a UUID that needs to be known only
to applications and low-level firmware/hardware, the kernel code should
not have to be modified for each and every processing and to add new
parameters. It just does not scale and it's unmaintainable.

At the very least if you really want to use this compress API, extend it
to use a non-descript "UUID-defined" type and an opaque set of
parameters with this UUID passed in a header.

