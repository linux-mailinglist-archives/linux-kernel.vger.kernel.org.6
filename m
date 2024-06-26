Return-Path: <linux-kernel+bounces-230168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0EF917950
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2912E284542
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 07:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38603158A22;
	Wed, 26 Jun 2024 07:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jNla57GO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4D1E554;
	Wed, 26 Jun 2024 07:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719385460; cv=none; b=b7DFL830n5RfO2LUKnGex5PffXUbuCZyW13JVN8Au6Nvvj9P3Z6ZIuWqIx3tokq5c2qeoKTiWle6zai+AbglS2GFiFoId0h25LXWjW11eKq6+nXIA3aEgGNQpaXGx5QRgAM+9DOs209pMwO3jl1IRMC3yKjlc0hrMYsvv4+LLK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719385460; c=relaxed/simple;
	bh=gZum9CO4vVWwXuEygpu8fe8HRr2qkCPf+bDqxn8cuoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P768lnOyCwgJEiFfrGsc/luE6pOtAb4sLyepEivwW/3wregbiT6/TKNsMHj23OCR118sDe2kIrc9RyH4cJ1ZtiHpHCN34lSRwtX5D+ANQ5OFVN70R+CzWKT/DnjK3UYsZxp83FSqbQHoxANKDhCKiv8Onpg2d7gNp8h18s5dKrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jNla57GO; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719385459; x=1750921459;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gZum9CO4vVWwXuEygpu8fe8HRr2qkCPf+bDqxn8cuoA=;
  b=jNla57GO7hQ3KAcGjz+RK7nsuTUVkMbaS6dexLVvaptXxeDU8iEs01Vu
   aR1Y7sDrdT7e0TUPKzhpByHrhmNljOTDJ+RHW5Wokv2iay7jZzcTRsouB
   CVjIyXxiv210OzYRDJxyxPSiIwZoua36yyAHOPynPwUefiYNVt6bSFtGu
   3KSZDf6Jr9FH3MZ2dWIc49IMcLTOTEGivjw+q7eNBZgbZvdcQmSu6FcdM
   TazVf1Kjk1dVeDfJq0d3nAMLz9ww6Sx2/i+kcpyL24qBsDHauw6VxMMQa
   6/+rmLrB5L16s7pl5/Y+2b73KD0T72OjhLs3/8sZ80YjDVmABb1uuhv2C
   w==;
X-CSE-ConnectionGUID: hsfk+OhLQxmMRq8GknaDwA==
X-CSE-MsgGUID: OkxIR2mRRO2yE6PyoNjNlw==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16402226"
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="16402226"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 00:04:19 -0700
X-CSE-ConnectionGUID: UmKkzFF5SyW3mrwTpaO5Ag==
X-CSE-MsgGUID: +3eImLQSTr6XLx5anQopRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="44561107"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO [10.245.246.76]) ([10.245.246.76])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 00:04:15 -0700
Message-ID: <fb9ce0ce-dddb-4f88-9ac6-0f6cdd6ccb28@linux.intel.com>
Date: Wed, 26 Jun 2024 09:04:11 +0200
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
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <01904abc-5e7c-4006-96d9-83fc5de8bb21@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/25/24 23:37, Guenter Roeck wrote:
> On Fri, Jun 21, 2024 at 10:35:31AM +0200, Pierre-Louis Bossart wrote:
>>
>>
>> On 6/21/24 08:15, Amadeusz Sławiński wrote:
>>> On 6/20/2024 9:27 PM, Allen Ballway wrote:
>>>> I filed a bug and after sharing the requested information it looks
>>>> like this device won't work on SOF without vendor support. Given this,
>>>> would the original patch returning this device to using HDAudio be
>>>> reasonable, or is there an preferred alternative to force this device
>>>> into using HDAudio?
>>>>
>>>
>>> And can you share link to the issue on mailing list, so someone reading
>>> this thread in the future doesn't have to guess where it is? ;)
>>
>> https://github.com/thesofproject/linux/issues/4981
>>
>> I don't know what to do with this configuration.
>> We added a quirk to force SOF to be used for ES8336 devices. It worked
>> for some, but not for others. Now we have quite a few ES8336-based
>> platforms that are broken with zero support from the vendor, with
>> obscure I2C/GPIO/clk issues.
>> Are we going to tag each one of them and say 'not supported, use HDMI only'?
>> That's pushing a bit the notion of quirk...It would generate an endless
>> stream of patches. The alternative is to do nothing and ask that those
>> platforms revert to HDMI audio only with a kernel parameter. That latter
>> alternative has my vote.
>>
> 
> Given that this apparently does not work for many ES8336 devices,
> would it make more sense to disable SOF support for those by default
> and _enable_ them with a kernel parameter ?

Some configurations work, so we would break them.

We tried to improve things by using ACPI information, but it turns out
some of the information is broken as well, so it's a multi-level chase
to figure out how the codec is wired (GPIOs mainly).

There's no good solution here.

