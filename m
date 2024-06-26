Return-Path: <linux-kernel+bounces-230910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 163C09183AC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BE151C2121C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 14:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10ED11849D1;
	Wed, 26 Jun 2024 14:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIoIuZGX"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9743225A2;
	Wed, 26 Jun 2024 14:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719410945; cv=none; b=aiHYk1/8S5OpmJMFXNTj9aYsJwD2DLkf9O53YrcBdcztfvI9KUor4/Ehz5UfGNcQvMfIIizblDqxn2S6596UUWpmPc3ybi5THLTxQ4MXmxKNL8MXVF/H6W9Ah+8/epA00fGYzAaq+2PVLkJdIoee7zxuJoJopy7SzsGi1BeOxd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719410945; c=relaxed/simple;
	bh=Vr6hYtV7Zl3bXC1ChQKDQo1aN/7x40vR0BL7R7Wc/L0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Blad2iNRxHdB8GpHae0jQ2upWemCkgoleKiyfLF72g/fqkhopm5bxCQuxv9kylwSdgUGNsB1EgRgod+ZIwHsjtmt6A+hI3J8AkygMouUaiXW0eq/XkBJE/Kn3ggYVzWQecAwVjllg/XbuAULUAhFIXoNhNrMG7uiDsxhK6EoiBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mIoIuZGX; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-37636c3872bso19286215ab.3;
        Wed, 26 Jun 2024 07:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719410943; x=1720015743; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=4D7A/mvD/K+ODhRJ+AkWFaOKxLUsvunNZDKSwgNI6HA=;
        b=mIoIuZGXiwLQgdZEfhtiG1v0FJJz8XYqis7yu9SuBoSHTdI4vKYe7KUmroOa6iBBvJ
         MeD33v+iLxoG0mgIrJz5dDPJ8Px2xGwwWcJLnG/pvbkJUYjaSoOJqX2AST217uEkrdIm
         i3fiAX7MRXU67ujY91bopU1BNTfJikryOU0rxI+SViUDm1cc5Y8DfD7T4MS9Sw8tiLIy
         pzi0AKmQzbsEDLYG8Bi+l1jt1jndDQywUOITYAzByp2o6Lc3BW9gCUAju+MCqwe2q9+R
         6fM4xSMfxcPFkgvMFLGOwgAJIzBMftu2Av3BqmQdB63fyjHapY87AF5+9JuywTkW67y1
         Syvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719410943; x=1720015743;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4D7A/mvD/K+ODhRJ+AkWFaOKxLUsvunNZDKSwgNI6HA=;
        b=gd6RaISOm4ixmRibY/Lf+Tdcrf1esgITCZMYYq88TX7J5i0ulSGGprOS2mRxw29zNx
         MXFTPTHeeXq0ZZ9lyXC74M3oYdLullAln7nc1Ssxhdz1UqvJFYDCyWUd432xtLqU1pVv
         MgoLBGgH0y/dItTibNA48BTeYVQYEQFxg5Pzp8KX7Of6YBuvI0LkmzhY2FvskIZJdHLw
         qcV3mpZiWVXm/hiM6az2GbS5ljXnOgGbOBppq1n60CaJrv4WOKZeVTqToO2MFK9vJG+A
         TEt/usccOQG30Yf1sfYR9C4OzBsbeIF0pvxx4KDkSPgbRD7mourjcDBj4ZWE7zAGjLAO
         xEhA==
X-Forwarded-Encrypted: i=1; AJvYcCWECIx/YW7WATLwDDvqRrm7+9e6xdfws0Ki/KOYyX6V+K31tEDNYaEN9Vzz0iKKBpM2ETawJn0eRV4sa0+/w6l6BjwVM7jZoo3p1t+OsjkLJW1GDqWNDnPw6kJMK/spd+ns1hkTaraJwCg=
X-Gm-Message-State: AOJu0YwKdmfBpGMktjWiqmpXEzOD6v7eSvxI1rB3yUq1HtvzV+HoB/ZI
	gf9MmZnL4ntgyHlyou81fRLS8gvD4WdjxyPyeB8Oy7kjm1znQSZ7
X-Google-Smtp-Source: AGHT+IG/tnKNtfsNJeZbePLsVTvRIlvsRrowuQPI2F0Cm2DazYM93hKW6GVRiHo1rHxjkc0DBNDRtA==
X-Received: by 2002:a92:cdaf:0:b0:374:aa60:a5c3 with SMTP id e9e14a558f8ab-3763f6c2aa3mr118647465ab.28.1719410942685;
        Wed, 26 Jun 2024 07:09:02 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72363463233sm1836817a12.72.2024.06.26.07.09.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 07:09:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a55f1344-80e2-4107-8c01-e56495d4b324@roeck-us.net>
Date: Wed, 26 Jun 2024 07:09:00 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ALSA: hda: intel-dsp-config: Fix Azulle Access 4 quirk
 detection
To: Takashi Iwai <tiwai@suse.de>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
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
 <87r0cjj059.wl-tiwai@suse.de>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <87r0cjj059.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/26/24 06:37, Takashi Iwai wrote:
> On Wed, 26 Jun 2024 15:09:34 +0200,
> Guenter Roeck wrote:
>>
>> On 6/26/24 00:04, Pierre-Louis Bossart wrote:
>>>
>>>
>>> On 6/25/24 23:37, Guenter Roeck wrote:
>>>> On Fri, Jun 21, 2024 at 10:35:31AM +0200, Pierre-Louis Bossart wrote:
>>>>>
>>>>>
>>>>> On 6/21/24 08:15, Amadeusz Sławiński wrote:
>>>>>> On 6/20/2024 9:27 PM, Allen Ballway wrote:
>>>>>>> I filed a bug and after sharing the requested information it looks
>>>>>>> like this device won't work on SOF without vendor support. Given this,
>>>>>>> would the original patch returning this device to using HDAudio be
>>>>>>> reasonable, or is there an preferred alternative to force this device
>>>>>>> into using HDAudio?
>>>>>>>
>>>>>>
>>>>>> And can you share link to the issue on mailing list, so someone reading
>>>>>> this thread in the future doesn't have to guess where it is? ;)
>>>>>
>>>>> https://github.com/thesofproject/linux/issues/4981
>>>>>
>>>>> I don't know what to do with this configuration.
>>>>> We added a quirk to force SOF to be used for ES8336 devices. It worked
>>>>> for some, but not for others. Now we have quite a few ES8336-based
>>>>> platforms that are broken with zero support from the vendor, with
>>>>> obscure I2C/GPIO/clk issues.
>>>>> Are we going to tag each one of them and say 'not supported, use HDMI only'?
>>>>> That's pushing a bit the notion of quirk...It would generate an endless
>>>>> stream of patches. The alternative is to do nothing and ask that those
>>>>> platforms revert to HDMI audio only with a kernel parameter. That latter
>>>>> alternative has my vote.
>>>>>
>>>>
>>>> Given that this apparently does not work for many ES8336 devices,
>>>> would it make more sense to disable SOF support for those by default
>>>> and _enable_ them with a kernel parameter ?
>>>
>>> Some configurations work, so we would break them.
>>>
>>
>> Yes, but for others it is a regression,
> 
> Is it?  The speaker should have never worked for them without SOF,
> either.
> 

Interesting comment, especially in the context of the reasons given for this patch
to be rejected.

Guenter


