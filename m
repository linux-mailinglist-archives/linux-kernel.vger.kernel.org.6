Return-Path: <linux-kernel+bounces-280490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 755DB94CB4A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 09:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 061541F24449
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 07:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4314A176FB2;
	Fri,  9 Aug 2024 07:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZnoqGaTt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADABF17BA2;
	Fri,  9 Aug 2024 07:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723188354; cv=none; b=i3U47UCsllP1BJ8g4QpyBUETuDQe6BgDLosbYRuC/2vEFrIyVSzYr6n4XubZA+N1IJUw1T2TiGZatkEH05aCFnAVpqq1iLDdmSalFyWoRPXpO/dJJXqy5CADO7tglfjhRxg9fqGNMm0rANIxkI3f1xJ5N3FwRAnOGFBUk1jfb6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723188354; c=relaxed/simple;
	bh=EZEmD9DuOTren8Yb/4Eh1tc1aNVW50mWaRZilWNBwi8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NEG07Nfq5vM0Et8yKcXCfDtTyl2TO8rVGmghuteRZRnYM6zgORi3DHj/USnO1stJQnZ95r4gOgbgFDIsTAzcfI5CEiW1u/q1C4hGRVhZDFCxrzvt57+WH9Y7wRTuVDPDe5OtJZyWQ0ACXqnyXJQhW6FEcgxf00+gpz0NXwZUxok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZnoqGaTt; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723188353; x=1754724353;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EZEmD9DuOTren8Yb/4Eh1tc1aNVW50mWaRZilWNBwi8=;
  b=ZnoqGaTtjGtUd5gmI4nWPbFReVVHQ87IWDqJVfnw5TmhXVGYCv8r3/2p
   bOl1kVonHYKQRtjZUkUqsv+sJCqSHiy0l15kDGtHbydNlIYZyG8JbA9nK
   rqtetjrdV8ma4zI5os2wIbRqof6W+ZgEkE/5Q8Qm4/o6xROanWL4/TVTM
   oAU1nJULPK9a7gpItxZxaXFpanT3GK14EtiVIHJYdYCMfXx97BkkN9acz
   8y0QXfaUHBb7Vx/HaljtFvM5aZxoiwrV4W+aAAlIqOybejtwuy3IkkkUH
   wLkHahxxCMUrYfJpWJuqNUj+tQ/4iRmt6Gtg+nIv5r3WfCq6FTz32mhZE
   Q==;
X-CSE-ConnectionGUID: XPrf7eUnRGOPBCAAOsi5qw==
X-CSE-MsgGUID: Qf/c3uZeQ5GhHYHp0vw3UA==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="12929860"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="12929860"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 00:25:50 -0700
X-CSE-ConnectionGUID: gLUemNmQTBu18Mf1kZVGHQ==
X-CSE-MsgGUID: Q8VA64rwRrKZxNZdPwAWKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="57360819"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO [10.245.246.249]) ([10.245.246.249])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 00:25:45 -0700
Message-ID: <ed1192e0-00e7-4739-a687-c96dc2d62898@linux.intel.com>
Date: Fri, 9 Aug 2024 09:19:58 +0200
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
 <930bb152-860a-4ec5-9ef0-1c96f554f365@linux.intel.com>
 <c9039808-cd04-452d-9f6c-f91811088456@perex.cz>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <c9039808-cd04-452d-9f6c-f91811088456@perex.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


>>>> Then there's the issue of parameters, we chose to only add parameters
>>>> for standard encoders/decoders. Post-processing is highly specific and
>>>> the parameter definitions varies from one implementation to another -
>>>> and usually parameters are handled in an opaque way with binary
>>>> controls. This is best handled with a UUID that needs to be known only
>>>> to applications and low-level firmware/hardware, the kernel code should
>>>> not have to be modified for each and every processing and to add new
>>>> parameters. It just does not scale and it's unmaintainable.
>>>>
>>>> At the very least if you really want to use this compress API,
>>>> extend it
>>>> to use a non-descript "UUID-defined" type and an opaque set of
>>>> parameters with this UUID passed in a header.
>>>
>>> We don't need to use UUID-defined scheme for simple (A)SRC
>>> implementation. As I noted, the specific runtime controls may use
>>> existing ALSA control API.
>>
>> "Simple (A)SRC" is an oxymoron. There are multiple ways to define the
>> performance, and how the drift estimator is handled. There's nothing
>> simple if you look under the hood. The SOF implementation has for
>> example those parameters:
>>
>> uint32_t source_rate;           /**< Define fixed source rate or */
>>                 /**< use 0 to indicate need to get */
>>                 /**< the rate from stream */
>> uint32_t sink_rate;             /**< Define fixed sink rate or */
>>                 /**< use 0 to indicate need to get */
>>                 /**< the rate from stream */
>> uint32_t asynchronous_mode;     /**< synchronous 0, asynchronous 1 */
>>                 /**< When 1 the ASRC tracks and */
>>                 /**< compensates for drift. */
>> uint32_t operation_mode;        /**< push 0, pull 1, In push mode the */
>>                 /**< ASRC consumes a defined number */
>>                 /**< of frames at input, with varying */
>>                 /**< number of frames at output. */
>>                 /**< In pull mode the ASRC outputs */
>>                 /**< a defined number of frames while */
>>                 /**< number of input frames varies. */
>>
>> They are clearly different from what is suggested above with a 'ratio-
>> mod'.
> 
> I don't think so. The proposed (A)SRC for compress-accel is just one
> case for the above configs where the input is known and output is
> controlled by the requested rate. The I/O mechanism is abstracted enough
> in this case and the driver/hardware/firmware must follow it.

ASRC is usually added when the nominal rates are known but the clock
sources differ and the drift needs to be estimated at run-time and the
coefficients or interpolation modified dynamically

If the ratio is known exactly and there's no clock drift, then it's a
different problem where the filter coefficients are constant.

>> Same if you have a 'simple EQ'. there are dozens of ways to implement
>> the functionality with FIR, IIR or a combination of the two, and
>> multiple bands.
>>
>> The point is that you have to think upfront about a generic way to pass
>> parameters. We didn't have to do it for encoders/decoders because we
>> only catered to well-documented standard solutions only. By choosing to
>> support PCM processing, a new can of worms is now open.
>>
>> I repeat: please do not make the mistake of listing all processing with
>> an enum and a new structure for parameters every time someone needs a
>> specific transform in their pipeline. We made that mistake with SOF and
>> had to backtrack rather quickly. The only way to scale is an identifier
>> that is NOT included in the kernel code but is known to higher and
>> lower-levels only.
> 
> There are two ways - black box (UUID - as you suggested) - or well
> defined purpose (abstraction). For your example 'simple EQ', the
> parameters should be the band (frequency range) volume values. It's
> abstract and the real filters (resp. implementation) used behind may
> depend on the hardware/driver capabilities.

Indeed there is a possibility that the parameters are high-level, but
that would require firmware or hardware to be able to generate actual
coefficients from those parameters. That usually requires some advanced
math which isn't necessarily obvious to implement with fixed-point hardware.

> From my view, the really special cases may be handled as black box, but
> others like (A)SRC should follow some well-defined abstraction IMHO to
> not force user space to handle all special cases.

I am not against the high-level abstractions, e.g. along the lines of
what Android defined:
https://developer.android.com/reference/android/media/audiofx/AudioEffect

That's not sufficient however, we also need to make sure there's an
ability to provide pre-computed coefficients in an opaque manner for
processing that doesn't fit in the well-defined cases. In practice there
are very few 3rd party IP that fits in well-defined cases, everyone has
secret-sauce parameters and options.

