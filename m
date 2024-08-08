Return-Path: <linux-kernel+bounces-279433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D72494BD43
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36671286F9A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF77918C33A;
	Thu,  8 Aug 2024 12:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JbE/cZW6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7150918C352;
	Thu,  8 Aug 2024 12:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723119588; cv=none; b=Dwe3BC6QpgBNVq4IFjskIBRLyNIo3tciHeUGaJrzYo3cBsDpTLzL8NHsPXQJMxMyFmQehTS7BClE/a2LRSt8W7bxVXCor8mq6+chkRApfmJ64BD3HSd21caRoEw5/JqUo6YZSB5a1wjoh2YsBdy598L/vhqWC5qPRvHD0u8f948=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723119588; c=relaxed/simple;
	bh=Xljr1/yImIwhvpLum0DZInmLBuHQBsAlpx6pOkwH+MQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tjGpXWfDsvc7iZZp4KJIYDLzXmvfMTlF4r3uO65Xeca51ySbrchQeqqQlPTIZXHBLNNU6LBboBdvGZ9+G8ceEkDz7o8cTdyFDBdcIP8rsKwZtoXl0NTB+ttyR6Nqf1bxMQ3+WnpZzjh+j9SwjPhPG6rS7XEuPaW2q/3ICcxnnyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JbE/cZW6; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723119588; x=1754655588;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Xljr1/yImIwhvpLum0DZInmLBuHQBsAlpx6pOkwH+MQ=;
  b=JbE/cZW6oBiVGfVju1HrC+f/igx5XgnHEoUhrVTP3ZnFJXV1Ee0MuyY0
   u+W+XL7r+L0PReVyeVsd8nLt5b4/RSviMZEOUczYA1lMOQ1uVESc7eRb6
   /6iI+VcI0KeuizgoNKeZItuSAPmjjXMrYOek4LKceceCX8G69NzJV4hyS
   wG1lOZo5jTedseRATgYlhAlaYaXZPpVF9XXLZvRrjukc+foBUYZNPWTHQ
   uTdCstf8bQ4U1lma1ctY6mxzWTVAuHNWbs+HOVy/8U/A9UQpMh3oNo3Sy
   LqmOITix+JJuYQ0gdKMxmsK/bvXiEHh7OVnhdTGbVejj+qfc5zkfBLD6E
   w==;
X-CSE-ConnectionGUID: IBLLYP06Rf68hgax8cpSXQ==
X-CSE-MsgGUID: LKleDPIZSqWvt0VDoc5UTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="21211069"
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="21211069"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 05:19:47 -0700
X-CSE-ConnectionGUID: Lc3kUjvGS4O6ti6CxYqRAg==
X-CSE-MsgGUID: jAJZWV/mQoSDOKO9l/WVxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="57122886"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO [10.245.246.169]) ([10.245.246.169])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 05:19:43 -0700
Message-ID: <930bb152-860a-4ec5-9ef0-1c96f554f365@linux.intel.com>
Date: Thu, 8 Aug 2024 14:19:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/6] ALSA: compress: add Sample Rate Converter codec
 support
To: Jaroslav Kysela <perex@perex.cz>, Shengjiu Wang <shengjiu.wang@gmail.com>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, vkoul@kernel.org, tiwai@suse.com,
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <1722940003-20126-1-git-send-email-shengjiu.wang@nxp.com>
 <1722940003-20126-2-git-send-email-shengjiu.wang@nxp.com>
 <e89a56bf-c377-43d8-bba8-6a09e571ed64@linux.intel.com>
 <CAA+D8AN9JXJr-BZf8aY7d4rB6M60pXS_DG=qv=P6=2r1A18ATA@mail.gmail.com>
 <ffa85004-8d86-4168-b278-afd24d79f9d8@linux.intel.com>
 <116041ee-7139-4b77-89be-3a68f699c01b@perex.cz>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <116041ee-7139-4b77-89be-3a68f699c01b@perex.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

 files changed, 10 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/include/uapi/sound/compress_offload.h b/include/uapi/
>>>>> sound/compress_offload.h
>>>>> index 98772b0cbcb7..8b2b72f94e26 100644
>>>>> --- a/include/uapi/sound/compress_offload.h
>>>>> +++ b/include/uapi/sound/compress_offload.h
>>>>> @@ -112,10 +112,12 @@ struct snd_compr_codec_caps {
>>>>>    * end of the track
>>>>>    * @SNDRV_COMPRESS_ENCODER_DELAY: no of samples inserted by the
>>>>> encoder at the
>>>>>    * beginning of the track
>>>>> + * @SNDRV_COMPRESS_SRC_RATIO_MOD: Resampling Ratio Modifier for
>>>>> sample rate converter
>>>>>    */
>>>>>   enum sndrv_compress_encoder {
>>>>>        SNDRV_COMPRESS_ENCODER_PADDING = 1,
>>>>>        SNDRV_COMPRESS_ENCODER_DELAY = 2,
>>>>> +     SNDRV_COMPRESS_SRC_RATIO_MOD = 3,
>>>>>   };
>>>>
>>>> this sounds wrong to me. The sample rate converter is not an "encoder",
>>>> and the properties for padding/delay are totally specific to an encoder
>>>> function.
>>>
>>> There is only decoder and encoder definition for compress,  I know
>>> it is difficult to add SRC to encoder or decoder classification,
>>> SRC is a Post Processing.  I hope you can have a recommandation
>>
>> I don't. I think we're blurring layers in a really odd way.
>>
>> The main reason why the compress API was added is to remove the
>> byte-to-time conversions. But that's clearly not useful for a
>> post-processing of PCM data, where the bitrate is constant. It really
>> feels like we're adding this memory-to-memory API to the compress
>> framework because we don't have anything else available, not because it
>> makes sense to do so.
> 
> It makes sense to offload decoder/encoder tasks as batch processing for
> standard compress stream and return back result (PCM stream or encoded
> stream) to user space. So it makes sense to use the compress interface
> (parameters handshake) for it. Let's talk about the proper SRC extension.
> 
> For SRC and dynamic rate modification. I would just create an ALSA
> control for this. We are already using the "PCM Rate Shift 100000"
> control in the sound/drivers/aloop.c for this purpose (something like
> pitch in MIDI) for example. There is no requirement to add this function
> through metadata ioctls. As bonus, this control can be monitored with
> multiple tasks.

this wouldn't work when the rate is estimated in firmware/hardware,
which is precisely what the 'asynchronous' part of ASRC does.


>> Then there's the issue of parameters, we chose to only add parameters
>> for standard encoders/decoders. Post-processing is highly specific and
>> the parameter definitions varies from one implementation to another -
>> and usually parameters are handled in an opaque way with binary
>> controls. This is best handled with a UUID that needs to be known only
>> to applications and low-level firmware/hardware, the kernel code should
>> not have to be modified for each and every processing and to add new
>> parameters. It just does not scale and it's unmaintainable.
>>
>> At the very least if you really want to use this compress API, extend it
>> to use a non-descript "UUID-defined" type and an opaque set of
>> parameters with this UUID passed in a header.
> 
> We don't need to use UUID-defined scheme for simple (A)SRC
> implementation. As I noted, the specific runtime controls may use
> existing ALSA control API.

"Simple (A)SRC" is an oxymoron. There are multiple ways to define the
performance, and how the drift estimator is handled. There's nothing
simple if you look under the hood. The SOF implementation has for
example those parameters:

uint32_t source_rate;           /**< Define fixed source rate or */
				/**< use 0 to indicate need to get */
				/**< the rate from stream */
uint32_t sink_rate;             /**< Define fixed sink rate or */
				/**< use 0 to indicate need to get */
				/**< the rate from stream */
uint32_t asynchronous_mode;     /**< synchronous 0, asynchronous 1 */
				/**< When 1 the ASRC tracks and */
				/**< compensates for drift. */
uint32_t operation_mode;        /**< push 0, pull 1, In push mode the */
				/**< ASRC consumes a defined number */
				/**< of frames at input, with varying */
				/**< number of frames at output. */
				/**< In pull mode the ASRC outputs */
				/**< a defined number of frames while */
				/**< number of input frames varies. */

They are clearly different from what is suggested above with a 'ratio-mod'.

Same if you have a 'simple EQ'. there are dozens of ways to implement
the functionality with FIR, IIR or a combination of the two, and
multiple bands.

The point is that you have to think upfront about a generic way to pass
parameters. We didn't have to do it for encoders/decoders because we
only catered to well-documented standard solutions only. By choosing to
support PCM processing, a new can of worms is now open.

I repeat: please do not make the mistake of listing all processing with
an enum and a new structure for parameters every time someone needs a
specific transform in their pipeline. We made that mistake with SOF and
had to backtrack rather quickly. The only way to scale is an identifier
that is NOT included in the kernel code but is known to higher and
lower-levels only.

