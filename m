Return-Path: <linux-kernel+bounces-283199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B1E94EE88
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 15:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6F64B2322B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 13:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7682E17C7C9;
	Mon, 12 Aug 2024 13:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P0gFmOok"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E907817A92F;
	Mon, 12 Aug 2024 13:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723470283; cv=none; b=bWP0bKUXsTMq3njO/p0Z/+sp2iHO970LJapyfwH2qb3fICHHtkrmPEFV9WZxZyHvT2OoMajBTssvd34wY4khp1tp4Phzf3m1XP9n2EFRUI9vYqiToG2/83+J480x5gsL0aUEaQv82xacbzueUOvdNHLpWHVhK3yR4vrTAoyeiuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723470283; c=relaxed/simple;
	bh=/RjqGAxXdDn5eYnASyKXGIi+4WtLzhr+cDrkdx8Rpxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IonfSC8pevHsTaNIfJ53CADxWPY/D027JsEvstR/lQjOUMd/jnQoTLPruoaiDlPrJDC7q5oLUQlktpMj2nR/65okhyeZ/5M5mTd5TqPBAOEXAiY6mBXzVHoBIitOsy4i5Ok/3Grm7F0cHyRJPMpCQ2C/cQGkK1M1QqjVTIPFKF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P0gFmOok; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723470282; x=1755006282;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/RjqGAxXdDn5eYnASyKXGIi+4WtLzhr+cDrkdx8Rpxs=;
  b=P0gFmOokFMUjenZYLFjjwGttwuOJSHfqJj9vya0FA8iR8jNS3jFRgZyf
   Blu1HGzs0QmelBqJtGUw6cgzQp+jvbYZPvhi4TC+hKCMpEVpKX3GAZvDB
   VON6Gk8lqO9zW6TKyV9t0ExJcFZrA8BaTeGeItVGcV7x8oewaJLJbyIXJ
   8qymPlognPB47hmeR5JmFWJHXaESqRKfVXATKioDSN8ETWjTesQoSC9nC
   sslMQrE5LrXQbA4Ixn4d6/5Uxi78a3vMmQGkyvM8U4S3YjeSG2yxHWAFr
   dYwIHhzU4zRAkLnmXBANwUCp0cpC7I0QpuiwF7m72jYzveexr45AGsJz8
   g==;
X-CSE-ConnectionGUID: 9eyjZd7zRV6X1VPg9KmauA==
X-CSE-MsgGUID: SSbXXa5kS6SRpCFZz/0ADw==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="25444663"
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="25444663"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 06:43:12 -0700
X-CSE-ConnectionGUID: LhzXRniDSz68H7GhGTzgEQ==
X-CSE-MsgGUID: H21YVEE1T46GE24AgW31Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="57925733"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO [10.245.246.115]) ([10.245.246.115])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 06:43:07 -0700
Message-ID: <7dc039db-ecce-4650-8eb7-96d0cfde09a2@linux.intel.com>
Date: Mon, 12 Aug 2024 15:43:05 +0200
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
 <ed1192e0-00e7-4739-a687-c96dc2d62898@linux.intel.com>
 <CAA+D8AMOh=G7W5-dYw_=Xx-s0PqEu2suKYorscoWku86Rn-=+A@mail.gmail.com>
 <542d47c5-7ce3-4c17-8c0a-3a2b2a9e6c6a@linux.intel.com>
 <c3b8f7b8-fc5e-4285-bee8-7edd448a405d@perex.cz>
 <CAA+D8ANg7C7vuxU44mAG8EnmcZjB_te5N_=4M4v_-Q9ZyPZ49g@mail.gmail.com>
 <2be4303e-58e1-4ad7-92cf-f06fa6fa0f08@perex.cz>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <2be4303e-58e1-4ad7-92cf-f06fa6fa0f08@perex.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/12/24 15:31, Jaroslav Kysela wrote:
> On 12. 08. 24 12:24, Shengjiu Wang wrote:
>> On Fri, Aug 9, 2024 at 10:01 PM Jaroslav Kysela <perex@perex.cz> wrote:
>>>
>>> On 09. 08. 24 14:52, Pierre-Louis Bossart wrote:
>>>
>>>>> And metadata
>>>>> ioctl can be called many times which can meet the ratio modifier
>>>>> requirement (ratio may be drift on the fly)
>>>>
>>>> Interesting, that's yet another way of handling the drift with
>>>> userspace
>>>> modifying the ratio dynamically. That's different to what I've seen
>>>> before.
>>>
>>> Note that the "timing" is managed by the user space with this scheme.
>>>
>>>>> And compress API uses codec as the unit for capability query and
>>>>> parameter setting,  So I think need to define "SND_AUDIOCODEC_SRC'
>>>>> and 'struct snd_dec_src',  for the 'snd_dec_src' just defined output
>>>>> format and output rate, channels definition just reuse the
>>>>> snd_codec.ch_in.
>>>>
>>>> The capability query is an interesting point as well, it's not clear
>>>> how
>>>> to expose to userspace what this specific implementation can do, while
>>>> at the same time *requiring* userpace to update the ratio dynamically.
>>>> For something like this to work, userspace needs to have pre-existing
>>>> information on how the SRC works.
>>>
>>> Yes, it's about abstraction. The user space wants to push data, read
>>> data back
>>> converted to the target rate and eventually modify the drift using a
>>> control
>>> managing clocks using own way. We can eventually assume, that if this
>>> control
>>> does not exist, the drift cannot be controlled. Also, nice thing is
>>> that the
>>> control has min and max values (range), so driver can specify the
>>> drift range,
>>> too.
>>>
>>> And again, look to "PCM Rate Shift 100000" control implementation in
>>> sound/drivers/aloop.c. It would be nice to have the base offset for the
>>> shift/drift/pitch value standardized.
>>
>> Thanks.
>>
>> But the ASRC driver I implemented is different, I just register one sound
>> card, one device/subdevice.  but the ASRC hardware support 4 instances
>> together, so user can open the card device 4 times to create 4 instances
>> then the controls can only bind with compress streams.
> 
> It's just a reason to add the subdevice code for the compress offload
> layer like we have in other APIs for overall consistency. I'll try to
> work on this.

I thought this was supported already? I remember there was a request to
enable more than one compressed stream for enhanced cross-fade support
with different formats? That isn't supported with the single-device +
PARTIAL_DRAIN method.

Vinod?

>> I think I can remove the 'SNDRV_COMPRESS_SRC_RATIO_MOD',
> 
> Yes.
> 
>> Only define a private type for driver,  which means only the ASRC driver
>> and its user application know the type.
> 
> The control API should be used for this IMHO.

Agree, this would be a 'clean' split where the compress API is used for
the data parts and the control parts used otherwise to alter the ratio
or whatever else is needed.

>> For the change in 'include/uapi/sound/compress_params.h",  should I
>> keep them,  is there any other suggestion for them?

You can add the SRC type but if you use a control for the parameters you
don't need to add anything for the encoder options, do you?



