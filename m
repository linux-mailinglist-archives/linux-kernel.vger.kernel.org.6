Return-Path: <linux-kernel+bounces-293536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89ED4958106
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 10:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6B381C24457
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22A718A6D4;
	Tue, 20 Aug 2024 08:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XPTL7AIF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4C0189F32;
	Tue, 20 Aug 2024 08:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724142673; cv=none; b=OIDQ/Y3wppvP4dYzsbRYdQ5X07/NhdRcXvhkpOOsuiPB2UPUijwQb/kstUPPfwBSFzhOwcre1R2CL6UgwdzJ7jjwwU3EvIyRdMRo70nPbb9MJlRZxFIUldIgmo1310ZTQ7AC3x5FgEcK2EpdgL28YeSRroo0KQVqs1g03bg8wgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724142673; c=relaxed/simple;
	bh=SxmH7pCBUCC/+QtkYdWoPaRpX3/WrQ/u9Dt4Kgg2sL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X+a9rHLqoTWKftkd046BHBhpb+IqgH7zBQbKWQzwAjgmokOIvXszMsttfiV1122dx/gGJoUKyoTKGW2g79E2s8ZQgBK87fEkTCsQjIKo0OKbby0MF91HVWCKBV7Kdftpe/rdKzv2azkNLmCx+Rz/JfM8GVtbS5KPV837UTkQC2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XPTL7AIF; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724142671; x=1755678671;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SxmH7pCBUCC/+QtkYdWoPaRpX3/WrQ/u9Dt4Kgg2sL8=;
  b=XPTL7AIF+ZwGAwaZVEZXIy+4rSQBLcMS1upmHRe73xYijgMod3+qp7dz
   Jeis7Hxi/ZasoTYScEzNF8cxpPQ+xVdq8Q0hEL+PwMjYtlWvikzN8Q/5j
   bBloCSRAIINzWH0G6lV+vFSlB5laVvjcOKZogCMVW5asdqvMLioD5BQBV
   TPOwKzbsut2o0rlo7zSamQG5QjGa8uNyv97e8trFCGv4glEQS2rWTCBDO
   MnVBOCmY0mZmvbirZhDcD9gnDiiv2PVsDEOITYHGDABwo1Q0nOQnBRQkU
   Ir2SP5aXGtNT716RKBGPo4s13PKnKx8t1dRjdCYSBerVYzT9ZgWjD0x+z
   Q==;
X-CSE-ConnectionGUID: DgYd8monTb63FcYJW53VhQ==
X-CSE-MsgGUID: LBo1i8RvSjuG16g97lOSlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="26293740"
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="26293740"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 01:30:31 -0700
X-CSE-ConnectionGUID: 6z9L+SnLRMOV5s7hbb1iIg==
X-CSE-MsgGUID: MjGIrylhS/StVmcl8sSHaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="64838542"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO [10.245.246.176]) ([10.245.246.176])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 01:30:27 -0700
Message-ID: <0cd6ed17-0bbd-4a72-884a-632c7de3977f@linux.intel.com>
Date: Tue, 20 Aug 2024 10:30:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 4/6] ASoC: fsl_asrc_m2m: Add memory to memory
 function
To: Jaroslav Kysela <perex@perex.cz>, Shengjiu Wang <shengjiu.wang@gmail.com>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, vkoul@kernel.org, tiwai@suse.com,
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <1723804959-31921-1-git-send-email-shengjiu.wang@nxp.com>
 <1723804959-31921-5-git-send-email-shengjiu.wang@nxp.com>
 <6d83cd58-5f02-414b-b627-a0022e071052@linux.intel.com>
 <CAA+D8ANDAxS42=9zOLQY_h_ihvJCmaXzE+_iZyxbSuikqt1CBw@mail.gmail.com>
 <ceb54a27-144b-40ed-8de5-482f2b0664a0@linux.intel.com>
 <CAA+D8ANqb89UavAXTiHvcHyv9uMt8_MYR9hfBaxEJDPNy5C=-g@mail.gmail.com>
 <eceafeef-2dba-48aa-b8b3-198b9bb39fb6@perex.cz>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <eceafeef-2dba-48aa-b8b3-198b9bb39fb6@perex.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/20/24 09:42, Jaroslav Kysela wrote:
> On 20. 08. 24 9:37, Shengjiu Wang wrote:
>> On Tue, Aug 20, 2024 at 2:59 PM Pierre-Louis Bossart
>> <pierre-louis.bossart@linux.intel.com> wrote:
>>>
>>>
>>>
>>> On 8/20/24 04:53, Shengjiu Wang wrote:
>>>> On Mon, Aug 19, 2024 at 3:42 PM Pierre-Louis Bossart
>>>> <pierre-louis.bossart@linux.intel.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 8/16/24 12:42, Shengjiu Wang wrote:
>>>>>> Implement the ASRC memory to memory function using
>>>>>> the compress framework, user can use this function with
>>>>>> compress ioctl interface.
>>>>>>
>>>>>> Define below private metadata key value for output
>>>>>> format, output rate and ratio modifier configuration.
>>>>>> ASRC_OUTPUT_FORMAT 0x80000001
>>>>>> ASRC_OUTPUT_RATE   0x80000002
>>>>>> ASRC_RATIO_MOD     0x80000003
>>>>>
>>>>> Can the output format/rate change at run-time?
>>>>
>>>> Seldom I think.
>>>>
>>>>>
>>>>> If no, then these parameters should be moved somewhere else - e.g.
>>>>> hw_params or something.
>>>>
>>>> This means I will do some changes in compress_params.h, add
>>>> output format and output rate definition, follow Jaroslav's example
>>>> right?
>>>
>>> yes, having parameters for the PCM case would make sense.
>>>
>>>>> I am still not very clear on the expanding the SET_METADATA ioctl to
>>>>> deal with the ratio changes. This isn't linked to the control layer as
>>>>> suggested before, and there's no precedent of calling it multiple
>>>>> times
>>>>> during streaming.
>>>>
>>>> Which control layer? if you means the snd_kcontrol_new?  it is bound
>>>> with sound card,  but in my case,  I need to the control bind with
>>>> the snd_compr_stream to support multi streams/instances.
>>>
>>> I can only quote Jaroslav's previous answer:
>>>
>>> "
>>> This argument is not valid. The controls are bound to the card, but the
>>> element identifiers have already iface (interface), device and subdevice
>>> numbers. We are using controls for PCM devices for example. The binding
>>> is straight.
>>>
>>> Just add SNDRV_CTL_ELEM_IFACE_COMPRESS define and specify the compress
>>> device number in the 'struct snd_ctl_elem_id'.
>>> "
>>
>> I don't think it is doable,  or at least I don't know how to do it.
>>
>> My case is just one card/one device/one subdevice.  can't use it to
>> distinguish multi streams.
> 
> I already wrote that the compress core code should be extended to
> support subdevices like other ALSA APIs. I'll work on it. For now, just
> add support for one converter.

I am not sure I get the benefits of subdevices in this context.

Can we not use different devices already, one per hardware ASRC instance?

Put differently, what would be the difference between a card with N
compressed devices or a card with 1 compressed device and N subdevices?


