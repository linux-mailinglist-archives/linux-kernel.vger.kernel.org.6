Return-Path: <linux-kernel+bounces-383784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BA49B2032
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 21:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA438281FAB
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 20:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0FD17E017;
	Sun, 27 Oct 2024 20:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUaDYCyS"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A1E17DFE8;
	Sun, 27 Oct 2024 20:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730059541; cv=none; b=tQCr4U7yGGETCl2Gh1SP9ncL5dax7niIL5863K+UXBcJnSuvGcHIQJFjaENAsar5NL9PTvAiNQMe+ZKjCtm4RnKAtp10tKe2k3QCqgW0qjsjsl5fUVihs2poYHbq0UQaEBJN99e2pOP3jE+8cyXlLyplxFanE64UOzJMPvZUKFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730059541; c=relaxed/simple;
	bh=hLdnlnRd4TSsr2U4ETJnkSflQ4aREENISviowFqNzgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gSz6uSVUN7yuTRzEA1Ed9j/QE9jeBDA63DvHveWnrfr3AP0zMWQqz5/q+HInMp3wqX5XRyqw9IeRAYsP0hFBSFTYqhhwOEaRLOA7azCb2KfVgner11BTuHgS/EMS6LLnWOCPz7bfrYWqWYVM6bLcRwu78IJ/KeGz4qKpm/O3GIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eUaDYCyS; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7ea8c4ce232so2929690a12.0;
        Sun, 27 Oct 2024 13:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730059539; x=1730664339; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=vFZEXMmx7eg7D7l6iGlYMICtrOffVApchYTvOrISmwM=;
        b=eUaDYCyS3gIRYDUn/zA3/ixzrnFucl3u41r6BHPe0d4edzH53g8Ovysas/v/L+TLh3
         6FtXrQrZywAnsDVnWK78OUJqoVApFTmCvmuHAWigWJExsa1A0qAzyz8IdQUGoqTKiF9D
         JM+zZiYJv6RLfI8qXR8nb4mhu7Blf0JGsY8x/lFOP4pg7rJigSVcLivRemq6Wx/CZa6p
         5azz6Kkgni65QvHL7s99oAHWFey3NKKGLDBuuxeKpVQANytVIBKHJ3OzAC4V0lR9Q0k8
         NBfAFp7Eie6hmciRm3KIxFBRJ/Lhi4HNjN+mOU7wq60UHk3k3HqZ0go7pOnKaYSmef3j
         IORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730059539; x=1730664339;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vFZEXMmx7eg7D7l6iGlYMICtrOffVApchYTvOrISmwM=;
        b=i7iyrxF9bjRY1CbLRQwvDdDshPp5WATQWBTjgoOgmBzu3bzvC3o4pSCvxR1COE7azP
         /SrFPuykeIDEzgr51tTdAbMZtEr4idAPObFBYZX2j9cfebjvfXcn2XAnCUMHE8+6SCL/
         lqWhcArh4/IE7eLDyhnis3tjD8cyrGgSGPqrK6r/Werl/6oEIL+1eSvTQQ4eCz0Gr2EP
         ykW20W0nJtGfhaPqchGCaq3fuhXTfQsRVQuHH6iv43BsfzEVw0yCPyG2+Q0uwJHJOi8T
         mjP0JpKIsVEoGIKFBVZaYNEdXdbT0T5dq+tZDKlLjJKsIbg7Fh6BmEaSpOxfD6hjq8lz
         Zi2A==
X-Forwarded-Encrypted: i=1; AJvYcCUbtkW5ioOS97kDm1HOodj90YzV6Ss5oSjQ6EsIOgwPFC2+gbW2HEY5SJXcWrwOSjP2dZbAELUtewoVIw==@vger.kernel.org, AJvYcCWVPDBunTyqV/v2MNWu1/P2QO8PeKfwQxfOeRzw7NGUZkXZFXqCXYILPBbHEbTjPvBgTwLJgIo7pKLVVGUJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxszQATDsrPhvEaA/6aBw8jV6Q4X07UwJNM71ElRGqfAK47gO4s
	TPNVlFC48p7m/K23Mdr2yU5XN8i2zDsnKzyF0GQ1OBgUHZK/aK8T
X-Google-Smtp-Source: AGHT+IFfhFYEWZp37igfRwqS7InfMWLhpblCUSK2x3mWF84MhB63F38CbVqns8thLOYV74WQ6BrGIA==
X-Received: by 2002:a05:6a21:178a:b0:1d9:275b:4eed with SMTP id adf61e73a8af0-1d9a8511786mr8721351637.42.1730059538850;
        Sun, 27 Oct 2024 13:05:38 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720579360f5sm4400017b3a.88.2024.10.27.13.05.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Oct 2024 13:05:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <528fed98-4fe0-41b6-b148-cf950866cdb3@roeck-us.net>
Date: Sun, 27 Oct 2024 13:05:36 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] hwmon: pwm_enable clarification
To: Derek John Clark <derekjohn.clark@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 Cryolita PukNgae <cryolitia@gmail.com>, linux-hwmon@vger.kernel.org,
 open list <linux-kernel@vger.kernel.org>,
 =?UTF-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= <samsagax@gmail.com>
References: <20241027174836.8588-1-derekjohn.clark@gmail.com>
 <24dc65c2-b6c9-4909-a784-fb81d9299f1c@roeck-us.net>
 <CAFqHKTmEauJ4RQUrn6pjX-hgLGZLNE8gaD5S41Uy0L0cNB4+mA@mail.gmail.com>
 <715afccb-56a5-4e8a-b7fd-e6151f241535@roeck-us.net>
 <CAFqHKTmhfYOAu9t6oZBQqQ1227Ot=Q4G_13-FHb=DmvACB+Xqg@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CAFqHKTmhfYOAu9t6oZBQqQ1227Ot=Q4G_13-FHb=DmvACB+Xqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/27/24 12:10, Derek John Clark wrote:
> On Sun, Oct 27, 2024 at 11:59 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 10/27/24 11:29, Derek John Clark wrote:
>>> On Sun, Oct 27, 2024 at 11:16 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>>>
>>>> On 10/27/24 10:48, Derek J. Clark wrote:
>>>>> Greetings all,
>>>>>
>>>>> I am working with Cryolita to fix up the GPD driver she submitted recently:
>>>>> https://lore.kernel.org/all/20240718-gpd_fan-v4-0-116e5431a9fe@gmail.com/
>>>>>
>>>>> We are currently having a discussion about the meaning of this part of the
>>>>> documentation and are seeking some guidance from upstream.
>>>>>    >> pwm[1-*]_enable
>>>>>>                Fan speed control method:
>>>>>>                0: no fan speed control (i.e. fan at full speed)
>>>>>>                1: manual fan speed control enabled (using pwm[1-*])
>>>>>>                2+: automatic fan speed control enabled
>>>>>>                Check individual chip documentation files for automatic mode
>>>>>>                details.
>>>>>>                RW
>>>>>
>>>>> In oxp-sensors we took 0 to mean "no kernel control" so a setting of 0 is
>>>>> technically "automatic" but fully controlled by the hardware with no
>>>>> interaction from the driver. In her original driver draft she had taken this
>>>>
>>>> That is wrong. It should be (or have been) 2 or higher. Ah yes, I can see that
>>>> the code sets fan control to automatic when oxp_pwm_disable() is called.
>>>> Again, that is wrong. Congratulations to the submitters, you sneaked that by
>>>> my review. That doesn't make it better. It is still wrong, and I call it "sneaky"
>>>> because the function is not called "oxp_pwm_automatic()" or similar, it is
>>>> called "oxp_pwm_disable(). Setting fan control to automatic does not disable
>>>> fan control.
>>>>
>>>> My bad, I should have paid closer attention, and/or maybe not have trusted
>>>> the submitters as much as I did. I guess I'll have to pay closer attention
>>>> in the future.
>>>>
>>>>> literally to have the driver set the fan speed to 100% on this setting rather
>>>>> then give back control to the hardware. My question is simply what is the
>>>>> correct interpretation here? Ideally I would like to see this interface match
>>>>
>>>> It seems to me that the above text is well defined.
>>>>
>>>>> as existing userspace software is expecting 0 as hardware controlled and 1 as
>>>>> manually controlled, but we also want to ensure this is correct before we
>>>>> submit a v5.
>>>>>
>>>>
>>>> Any such userspace expectations are simply wrong. The ABI definition is above
>>>> and, again, it is well defined.
>>>>
>>>>           0: no fan speed control (i.e. fan at full speed)
>>>>
>>>> I don't really see any ambiguity in this text. This isn't about kernel control,
>>>> it is an absolute statement. There is no "kernel" in "no fan speed control".
>>>> "fan at full speed" should make this even more obvious.
>>>>
>>>> Guenter
>>>
>>> Guenter,
>>>
>>> I'll keep this in mind in the future, and I will send a patch soon to fix the
>>> oxp_sensors driver. One final question, is a "0" setting mandatory?
>>>
>>
>> No, if the hardware can not support it it doesn't make sense to mandate it.
>> If the hardware does not support disabling fan control, one option would be to
>> set it to manual and set the fan speed to 100%, but that isn't mandatory.
> 
> Okay, thanks for the insight.
> 
>> Note though that people can now argue that fixing the driver would be an ABI
>> violation in itself, because after all there is some userspace code which assumes
>> that setting pwm_enable to 0 fro this driver would enable automatic mode (while
>> other more generic applications reasonably expect fan control to be disabled if
>> the value is set to 0). In other words, fixing one ABI violation creates another.
>> That is why I am really unhappy about this.
>>
>> Guenter
> 
> Understandable, and I apologize for not understanding during the initial driver
> development. Joaquín maintains the most prominent userspace application to use
> this interface and I'm in contact with the two other developers who
> use it as well.
> We can certainly correct this oversight and get everyone on-board with
> the correct
> ABI, unless you prefer we keep it as is.
> 

I would most definitely prefer to get it fixed.

Thanks,
Guenter


