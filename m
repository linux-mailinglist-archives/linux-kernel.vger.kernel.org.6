Return-Path: <linux-kernel+bounces-230797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1E29181FD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D859CB286BC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E6079F0;
	Wed, 26 Jun 2024 13:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPOICk61"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A35C181317;
	Wed, 26 Jun 2024 13:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719407381; cv=none; b=bGuEYaj0tQQkROtn3IXLTIO1Iwa7+1gSLFeNcBrFxRj1PP3JK4UzxfTf+Ws/yRLMCRmeWOS0sqAyIx7/5e3qyvKYgl+Ffx7Lqd2LAnprfS13RiSElt06ocI1RsyaUK2GqmNP5vXW8NEJtmAWpEUvTyZ1IE0RxzlGHp2Ru4kI7Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719407381; c=relaxed/simple;
	bh=XRza0LYYRc3eq7/ZicGsRqiyjXUJRix+TvSQm3uUJ30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uqA+4Xecv/oLHv+Enni6NSciUWJDs5PFXNitR8uv0w48Py8sXgP93fyGqM3GGPJt2Vj/+nlxAzbVSPwP2ksWuuB4n8CrFIQv/WckYFURIGdYLLIqeqUzuSYT5kjSIYwI0kYeln9mM4Hd+BUpglkSJafQhqaE07sbplHA8xYssTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPOICk61; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7ec0385de1fso256426039f.3;
        Wed, 26 Jun 2024 06:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719407378; x=1720012178; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=jbIul95IiAdrCpaQCiXavVl0qli0kmX8f13o2oCOgGQ=;
        b=dPOICk619MUmf13Qi/X1afy4+8GnvNZZ+h8MwcotS4CkG2RQmoSPD1qvbI4TEMQHSf
         fL8gR3dscg8YoPGfE+TQzft4eb3HGXF3jEFR5FXvhsN+ndNCGhNnXVWweaQLzYTMmS7a
         UwcaHvBBllo2XLaLaOOIRVcRixAmMWfOYgbpdNnGkGyhfF4G/JmkCC7jrxbgbres8ZWC
         0F4Wq7c4fUZnQs/f1V9bHATStWVG8RMF6bWjSStxyeyIDfkaFiiotOmhT0X64z/iQBR6
         rOXBRq4m6lcBXuDlRd/fjnIU6ZmWFyi57bHMY4gbA6OgpDAwWb+BQLneAJ3UVwTn9/oa
         h2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719407378; x=1720012178;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jbIul95IiAdrCpaQCiXavVl0qli0kmX8f13o2oCOgGQ=;
        b=ICCr3kE/mfVodv+uydDZy21jqLl6+vI9WtqN6eGlJRq9Qp/iA6pqOlg5d2ZyccHbFL
         +sF4IECuldPzzC/eJDpBq5+1m7T9NG0x6o8gGwdN2Ou0VrhsPanjIOcXn3w2t/Fod0cr
         EUXTXXEEUB5OZCtLVY8kqJ6oPIHaEr0IFMRnf2iZPK5i6PZYy1Yu4iIIAdySXQYP656v
         Ih3+01HNnR/K7dLT3Ys/2x/hfi9OCAVPDx2VRoea40O96MnHflSy30CjGZL3trGKPFRU
         /a/dgcO5MAJXvrPYgscLLiN+obqXUjBv2inhyULUTklZ6GwRxwXVZQKUSJ6z0/x31IZZ
         9VUQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7t7lh5Wzc1WgxSVtqx0RgFF2DGtsuAD6eBk+Q3qBOsmawCg4Z2s7USCrFc7fpFePgGmNJQW/cRzRr8y1jXu8RroIiheAZchxd59gq+nUxdOM5W/It+sPbKMmBCH4SI4pmDAiHnqY4X1Y=
X-Gm-Message-State: AOJu0YzXXmYsgeZo7/CoiC9CfVsfkUBqczJvHTuda5MkCbSVZyghVScH
	+SerGUyhMVggmyD3T/j5VwHatW7IAvbgzZyzsXphYRpwcjwLyfyMIE/OyA==
X-Google-Smtp-Source: AGHT+IHDBNwyF3yqYq8SINduMUQOS+BdwelFCdeuqy0+90D2akEC2VYuXkqqgotMW0QQOKvpaPOURw==
X-Received: by 2002:a05:6602:6c0b:b0:7eb:8887:d6bb with SMTP id ca18e2360f4ac-7f3a74d7044mr1320387839f.2.1719407378556;
        Wed, 26 Jun 2024 06:09:38 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7067e0e5723sm6181314b3a.75.2024.06.26.06.09.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 06:09:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7bbf1688-4dfd-4a6f-90f2-ee235027c701@roeck-us.net>
Date: Wed, 26 Jun 2024 06:09:34 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ALSA: hda: intel-dsp-config: Fix Azulle Access 4 quirk
 detection
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <fb9ce0ce-dddb-4f88-9ac6-0f6cdd6ccb28@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/26/24 00:04, Pierre-Louis Bossart wrote:
> 
> 
> On 6/25/24 23:37, Guenter Roeck wrote:
>> On Fri, Jun 21, 2024 at 10:35:31AM +0200, Pierre-Louis Bossart wrote:
>>>
>>>
>>> On 6/21/24 08:15, Amadeusz Sławiński wrote:
>>>> On 6/20/2024 9:27 PM, Allen Ballway wrote:
>>>>> I filed a bug and after sharing the requested information it looks
>>>>> like this device won't work on SOF without vendor support. Given this,
>>>>> would the original patch returning this device to using HDAudio be
>>>>> reasonable, or is there an preferred alternative to force this device
>>>>> into using HDAudio?
>>>>>
>>>>
>>>> And can you share link to the issue on mailing list, so someone reading
>>>> this thread in the future doesn't have to guess where it is? ;)
>>>
>>> https://github.com/thesofproject/linux/issues/4981
>>>
>>> I don't know what to do with this configuration.
>>> We added a quirk to force SOF to be used for ES8336 devices. It worked
>>> for some, but not for others. Now we have quite a few ES8336-based
>>> platforms that are broken with zero support from the vendor, with
>>> obscure I2C/GPIO/clk issues.
>>> Are we going to tag each one of them and say 'not supported, use HDMI only'?
>>> That's pushing a bit the notion of quirk...It would generate an endless
>>> stream of patches. The alternative is to do nothing and ask that those
>>> platforms revert to HDMI audio only with a kernel parameter. That latter
>>> alternative has my vote.
>>>
>>
>> Given that this apparently does not work for many ES8336 devices,
>> would it make more sense to disable SOF support for those by default
>> and _enable_ them with a kernel parameter ?
> 
> Some configurations work, so we would break them.
> 

Yes, but for others it is a regression, so arguably the change to force-enable
SOF caused a regression and should either be reverted or fixed such that all
previously working configurations still work (even more so since fixing
the problem one-by-one as affected systems are found is being rejected).

Thanks,
Guenter


