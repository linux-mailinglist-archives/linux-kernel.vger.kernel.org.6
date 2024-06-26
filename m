Return-Path: <linux-kernel+bounces-230829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DC291826C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9AB01C22256
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D6C18133E;
	Wed, 26 Jun 2024 13:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="exLIIBhL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0988825;
	Wed, 26 Jun 2024 13:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719408644; cv=none; b=e4FZsKEyb/wlToAtVqfyHXtScLAbpBdePa+Odrn+E6SAXu/P8aLRYRfq0O9g2sHy1WNEjZ6z/OgaB4cSA76ysBTZ1ysI+5rZmPFH/6TZBIFaFCnZzxcR2+ycWLzLgOlZK622/S2eSBVRMaD1toSCG1InJ8BXZvrSPcGfTI1er1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719408644; c=relaxed/simple;
	bh=0fVaUR0kdYT/imczx4lGPFmuFv72qFD2+TqVqLWotK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BAMIobseraT//k7RvQ/bHM3ceFJMMULWLYGSp3nTO+ACCULqZVLVmfZktarUw+pdztfigi6LJbaUUXDBsUa9E41sy16cRr4++Jj1vR8wb5pP2AWfu2vupzKAA5fGoHa1FHgwlzIktUI6lLkzWbaPNX/p2u08BhrlfaGbMb1UkLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=exLIIBhL; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719408642; x=1750944642;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0fVaUR0kdYT/imczx4lGPFmuFv72qFD2+TqVqLWotK0=;
  b=exLIIBhLyz1LvWrp547P7EmTMCahPQ+Sk4F6/A3O+cXBMPJEOO7zEKvc
   IB9j6a7kL3jjankx+IlGhFFuX/utAIswiLf6X3GyCGKEFD62mCL1bIbcT
   oveaqXtDTJqux6ASULQe2zrCLI157c9Y4W3Y22PjhU9+GQsNW7+VVRqdD
   39O9luOQQFVdH0HYsjgN2eevoeeBD11+l+GzOijzC6QXzXDzHoW+1vqO0
   DHne0BbWe1JnZ8fIaLHl/E3gMEcFSgNT6fjhAC1BMaxU9kmRUKSPT8Dlr
   3aMrUk1lAtCFDw0abXnFhPf0AUZl4cVoBfA6ZLlDu/mH1bLRkGNchQ/AW
   A==;
X-CSE-ConnectionGUID: cmkeoO1CQxOhrYZUGC7w3g==
X-CSE-MsgGUID: BSVdKVR3QgqPy19c5KGqhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="20362020"
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="20362020"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 06:30:41 -0700
X-CSE-ConnectionGUID: 5ofn5FYPQSaJ7UGWYkm2Qg==
X-CSE-MsgGUID: PB9cky4oTYyMwKazWTvtIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="48448185"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO [10.245.246.76]) ([10.245.246.76])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 06:30:38 -0700
Message-ID: <437a6141-33e0-4075-be22-b2b364787b6a@linux.intel.com>
Date: Wed, 26 Jun 2024 15:30:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ALSA: hda: intel-dsp-config: Fix Azulle Access 4 quirk
 detection
To: Guenter Roeck <linux@roeck-us.net>
Cc: =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>, Allen Ballway <ballway@chromium.org>,
 LKML <linux-kernel@vger.kernel.org>, Brady Norander
 <bradynorander@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, linux-sound@vger.kernel.org,
 Mark Hasemeyer <markhas@chromium.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>
References: <20240430212838.1.I77b0636d5df17c275042fd66cfa028de8ad43532@changeid>
 <83e218f9-29f5-4f35-bd0c-b298e3bb9e8c@linux.intel.com>
 <CAEs41JC-vJaMHj6fzmNO=-bu5oURRA-u565sN2=yzBeVtKb=4g@mail.gmail.com>
 <b2375610-4044-49e6-86e9-5c172abb2ffa@linux.intel.com>
 <CAEs41JAPPr3xRR42H6vKic5rVrtV-on4HyT5wNCXxbJtwijnCA@mail.gmail.com>
 <3d44c749-6c81-4c11-9409-b01815fe1a91@linux.intel.com>
 <3d9ef693-75e9-4be0-b1c0-488d3e2d41c5@linux.intel.com>
 <01904abc-5e7c-4006-96d9-83fc5de8bb21@roeck-us.net>
 <fb9ce0ce-dddb-4f88-9ac6-0f6cdd6ccb28@linux.intel.com>
 <7bbf1688-4dfd-4a6f-90f2-ee235027c701@roeck-us.net>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <7bbf1688-4dfd-4a6f-90f2-ee235027c701@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/26/24 15:09, Guenter Roeck wrote:
> On 6/26/24 00:04, Pierre-Louis Bossart wrote:
>>
>>
>> On 6/25/24 23:37, Guenter Roeck wrote:
>>> On Fri, Jun 21, 2024 at 10:35:31AM +0200, Pierre-Louis Bossart wrote:
>>>>
>>>>
>>>> On 6/21/24 08:15, Amadeusz Sławiński wrote:
>>>>> On 6/20/2024 9:27 PM, Allen Ballway wrote:
>>>>>> I filed a bug and after sharing the requested information it looks
>>>>>> like this device won't work on SOF without vendor support. Given
>>>>>> this,
>>>>>> would the original patch returning this device to using HDAudio be
>>>>>> reasonable, or is there an preferred alternative to force this device
>>>>>> into using HDAudio?
>>>>>>
>>>>>
>>>>> And can you share link to the issue on mailing list, so someone
>>>>> reading
>>>>> this thread in the future doesn't have to guess where it is? ;)
>>>>
>>>> https://github.com/thesofproject/linux/issues/4981
>>>>
>>>> I don't know what to do with this configuration.
>>>> We added a quirk to force SOF to be used for ES8336 devices. It worked
>>>> for some, but not for others. Now we have quite a few ES8336-based
>>>> platforms that are broken with zero support from the vendor, with
>>>> obscure I2C/GPIO/clk issues.
>>>> Are we going to tag each one of them and say 'not supported, use
>>>> HDMI only'?
>>>> That's pushing a bit the notion of quirk...It would generate an endless
>>>> stream of patches. The alternative is to do nothing and ask that those
>>>> platforms revert to HDMI audio only with a kernel parameter. That
>>>> latter
>>>> alternative has my vote.
>>>>
>>>
>>> Given that this apparently does not work for many ES8336 devices,
>>> would it make more sense to disable SOF support for those by default
>>> and _enable_ them with a kernel parameter ?
>>
>> Some configurations work, so we would break them.
>>
> 
> Yes, but for others it is a regression, so arguably the change to
> force-enable
> SOF caused a regression and should either be reverted or fixed such that
> all
> previously working configurations still work (even more so since fixing
> the problem one-by-one as affected systems are found is being rejected).

If you disable SOF, all you get with snd-hda-intel is HDMI outputs.
There is no alternative if you want local speakers, mic and jack
support, or extensions based on I2S.

Some of my Intel colleagues have an ES8336-based platform that works for
them, they successfully modified the sof_es8336 machine driver to add
HDMI support, so why would we disable a working config?

I would really err on the side of "if you contributed a working config,
or helped enable a working config, it will be maintained in the kernel".



