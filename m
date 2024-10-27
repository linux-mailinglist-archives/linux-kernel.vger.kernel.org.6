Return-Path: <linux-kernel+bounces-383748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FECB9B1FCD
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 19:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DA34280C23
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 18:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10B317A58F;
	Sun, 27 Oct 2024 18:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/XJZuZT"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B8479C2;
	Sun, 27 Oct 2024 18:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730055587; cv=none; b=WhRMrJkVoxEubV1isFXgPL4g9t2kSDCHi0Qx4sKKpxCK13MGJ9hWJsbaOOOwSt2Ah/AEzbwIKUV6veOVb9Sau/rhwv+lpDfG6K9+1BIxidEkrDhEbzAhIrAbzl85BAigI1eT/H3xTGjg+oR34mgzyOj4xQY12mRJjUmzI/7BNUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730055587; c=relaxed/simple;
	bh=Lr4TRJxYx6nVjKQ4tpYIwDk/Nm8BSWyELefLFPZa7tE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fyuq/oxFBORCycmKVS1ssBRhW84jRvHOh7E1SIQsO73gkRh2OBC/89Ej0WbabcHuFthh9595+r1QH2Fhx8oshmTJGzSH1Bys6CFiWmT6Jv4rX/fpQ1cLbbTAJ/BoOhN9xt0gGy2Z7kah1CQxa/hjxXvCP9aWaYRnAEDbgtGf6AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/XJZuZT; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7d4fa972cbeso2977082a12.2;
        Sun, 27 Oct 2024 11:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730055584; x=1730660384; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=3UxldwfxygPOdpSs5ERJxN4fUl4s0leVrlaVWKjzmpE=;
        b=D/XJZuZT0+dnB9VVlXYE7Pbj63ay/cjbZzlWBKz+LJYnGnOFDF4/24Sz+4Ow56n7wG
         q6xxZE/iyaBPqypi/0JSU8avPqU44GLSsX+n1/ibED54BUSk/7gW/qfoFiJJjop7AU/I
         /zv4N4l/Zo35053xY2qgcZtvbrEMGNjmQGftFjHFx+XTg86X8XFLckPUmIcEyzrtbmUH
         gpMFc+8+FmbG6tlj6LSHAwRlu7DtN5mBxRtndzvOVjAfWDP6BPiTbU0H03jhCfbdbI9L
         +51S2TvDx1Y506BbNoR1XUMfbof6uhQxCbQUasqxDUa1FPIC2HefxP9X65njcGDoOnuL
         svvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730055584; x=1730660384;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3UxldwfxygPOdpSs5ERJxN4fUl4s0leVrlaVWKjzmpE=;
        b=M9caAyn1FUdTJaTFyHUygmRReCyIDY2agPbgqzH2FR7BjmoJ1dfh0lIDAmR5w3mxTe
         6sw6T0Nftdp2/oCnBmIuJAHu1e1E/WLaAYbq8j6yLDqCVNFBkLQsVO/6JkfR1gwmN6tF
         fvl214/h5PHTxZ9nDxHdtQhlFKAKkWHb/qYD8T4UTpZ3q+q+O2VEBCEGZ/WYiqQMQLO2
         +bukq8fTJPyfQCVNDhwpQK5Z+83E0kgb46A1xfsI+j7d+iNtntR+eRXnhCbfDVrQwjcr
         0YxdUDjh+IPAI4shOS+NpBozYidMCocCm/AT+fBuc0KQ6C9HmmC/8izMyVjRAgqDzCuA
         7YQg==
X-Forwarded-Encrypted: i=1; AJvYcCVxV2PJIKvC4wyodmqpeUGFRQLv4dAd+7WiSwNm1Ty2vb7KxY4OJY8yKhELoZiCZaDFr7iIw5fTeY2++KhZ@vger.kernel.org, AJvYcCXkrJn5qOjHORAjP7f4feS6sNc7YEScwR0ouy/TcvGmao6cYp9eSoo5aqf/sASEEw910UxfMQ9VjJFOQw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwA4l6kjkrf980QWOxS080AR8ymUQfp495/QvD54NSnbHNxO/iX
	bdF34tOikW7diZaoPFy7+FcDYXv/CALBL9NGSL6kiKkMllJ7Ywep
X-Google-Smtp-Source: AGHT+IEk2G6WdVuV0AiyfT/OZ2gfjqiJ9aqb3xvQZeS+F3gSKnR2DfHvTLagsOuYVCXxA2Q7Y/mYlg==
X-Received: by 2002:a17:90a:f2d5:b0:2e2:e549:2dbc with SMTP id 98e67ed59e1d1-2e8f11d9429mr7820226a91.34.1730055583906;
        Sun, 27 Oct 2024 11:59:43 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e48bb5csm7607615a91.8.2024.10.27.11.59.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Oct 2024 11:59:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <715afccb-56a5-4e8a-b7fd-e6151f241535@roeck-us.net>
Date: Sun, 27 Oct 2024 11:59:41 -0700
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
 linux-kernel@vger.kernel.org
References: <20241027174836.8588-1-derekjohn.clark@gmail.com>
 <24dc65c2-b6c9-4909-a784-fb81d9299f1c@roeck-us.net>
 <CAFqHKTmEauJ4RQUrn6pjX-hgLGZLNE8gaD5S41Uy0L0cNB4+mA@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAlVcphcFCRmg06EACgkQyx8mb86fmYFg0RAA
 nzXJzuPkLJaOmSIzPAqqnutACchT/meCOgMEpS5oLf6xn5ySZkl23OxuhpMZTVX+49c9pvBx
 hpvl5bCWFu5qC1jC2eWRYU+aZZE4sxMaAGeWenQJsiG9lP8wkfCJP3ockNu0ZXXAXwIbY1O1
 c+l11zQkZw89zNgWgKobKzrDMBFOYtAh0pAInZ9TSn7oA4Ctejouo5wUugmk8MrDtUVXmEA9
 7f9fgKYSwl/H7dfKKsS1bDOpyJlqhEAH94BHJdK/b1tzwJCFAXFhMlmlbYEk8kWjcxQgDWMu
 GAthQzSuAyhqyZwFcOlMCNbAcTSQawSo3B9yM9mHJne5RrAbVz4TWLnEaX8gA5xK3uCNCeyI
 sqYuzA4OzcMwnnTASvzsGZoYHTFP3DQwf2nzxD6yBGCfwNGIYfS0i8YN8XcBgEcDFMWpOQhT
 Pu3HeztMnF3HXrc0t7e5rDW9zCh3k2PA6D2NV4fews9KDFhLlTfCVzf0PS1dRVVWM+4jVl6l
 HRIAgWp+2/f8dx5vPc4Ycp4IsZN0l1h9uT7qm1KTwz+sSl1zOqKD/BpfGNZfLRRxrXthvvY8
 BltcuZ4+PGFTcRkMytUbMDFMF9Cjd2W9dXD35PEtvj8wnEyzIos8bbgtLrGTv/SYhmPpahJA
 l8hPhYvmAvpOmusUUyB30StsHIU2LLccUPPOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAlVcpi8FCRmg08MACgkQyx8mb86fmYHNRQ/+
 J0OZsBYP4leJvQF8lx9zif+v4ZY/6C9tTcUv/KNAE5leyrD4IKbnV4PnbrVhjq861it/zRQW
 cFpWQszZyWRwNPWUUz7ejmm9lAwPbr8xWT4qMSA43VKQ7ZCeTQJ4TC8kjqtcbw41SjkjrcTG
 wF52zFO4bOWyovVAPncvV9eGA/vtnd3xEZXQiSt91kBSqK28yjxAqK/c3G6i7IX2rg6pzgqh
 hiH3/1qM2M/LSuqAv0Rwrt/k+pZXE+B4Ud42hwmMr0TfhNxG+X7YKvjKC+SjPjqp0CaztQ0H
 nsDLSLElVROxCd9m8CAUuHplgmR3seYCOrT4jriMFBtKNPtj2EE4DNV4s7k0Zy+6iRQ8G8ng
 QjsSqYJx8iAR8JRB7Gm2rQOMv8lSRdjva++GT0VLXtHULdlzg8VjDnFZ3lfz5PWEOeIMk7Rj
 trjv82EZtrhLuLjHRCaG50OOm0hwPSk1J64R8O3HjSLdertmw7eyAYOo4RuWJguYMg5DRnBk
 WkRwrSuCn7UG+qVWZeKEsFKFOkynOs3pVbcbq1pxbhk3TRWCGRU5JolI4ohy/7JV1TVbjiDI
 HP/aVnm6NC8of26P40Pg8EdAhajZnHHjA7FrJXsy3cyIGqvg9os4rNkUWmrCfLLsZDHD8FnU
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CAFqHKTmEauJ4RQUrn6pjX-hgLGZLNE8gaD5S41Uy0L0cNB4+mA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/27/24 11:29, Derek John Clark wrote:
> On Sun, Oct 27, 2024 at 11:16 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 10/27/24 10:48, Derek J. Clark wrote:
>>> Greetings all,
>>>
>>> I am working with Cryolita to fix up the GPD driver she submitted recently:
>>> https://lore.kernel.org/all/20240718-gpd_fan-v4-0-116e5431a9fe@gmail.com/
>>>
>>> We are currently having a discussion about the meaning of this part of the
>>> documentation and are seeking some guidance from upstream.
>>>   >> pwm[1-*]_enable
>>>>               Fan speed control method:
>>>>               0: no fan speed control (i.e. fan at full speed)
>>>>               1: manual fan speed control enabled (using pwm[1-*])
>>>>               2+: automatic fan speed control enabled
>>>>               Check individual chip documentation files for automatic mode
>>>>               details.
>>>>               RW
>>>
>>> In oxp-sensors we took 0 to mean "no kernel control" so a setting of 0 is
>>> technically "automatic" but fully controlled by the hardware with no
>>> interaction from the driver. In her original driver draft she had taken this
>>
>> That is wrong. It should be (or have been) 2 or higher. Ah yes, I can see that
>> the code sets fan control to automatic when oxp_pwm_disable() is called.
>> Again, that is wrong. Congratulations to the submitters, you sneaked that by
>> my review. That doesn't make it better. It is still wrong, and I call it "sneaky"
>> because the function is not called "oxp_pwm_automatic()" or similar, it is
>> called "oxp_pwm_disable(). Setting fan control to automatic does not disable
>> fan control.
>>
>> My bad, I should have paid closer attention, and/or maybe not have trusted
>> the submitters as much as I did. I guess I'll have to pay closer attention
>> in the future.
>>
>>> literally to have the driver set the fan speed to 100% on this setting rather
>>> then give back control to the hardware. My question is simply what is the
>>> correct interpretation here? Ideally I would like to see this interface match
>>
>> It seems to me that the above text is well defined.
>>
>>> as existing userspace software is expecting 0 as hardware controlled and 1 as
>>> manually controlled, but we also want to ensure this is correct before we
>>> submit a v5.
>>>
>>
>> Any such userspace expectations are simply wrong. The ABI definition is above
>> and, again, it is well defined.
>>
>>          0: no fan speed control (i.e. fan at full speed)
>>
>> I don't really see any ambiguity in this text. This isn't about kernel control,
>> it is an absolute statement. There is no "kernel" in "no fan speed control".
>> "fan at full speed" should make this even more obvious.
>>
>> Guenter
> 
> Guenter,
> 
> I'll keep this in mind in the future, and I will send a patch soon to fix the
> oxp_sensors driver. One final question, is a "0" setting mandatory?
> 

No, if the hardware can not support it it doesn't make sense to mandate it.
If the hardware does not support disabling fan control, one option would be to
set it to manual and set the fan speed to 100%, but that isn't mandatory.

Note though that people can now argue that fixing the driver would be an ABI
violation in itself, because after all there is some userspace code which assumes
that setting pwm_enable to 0 fro this driver would enable automatic mode (while
other more generic applications reasonably expect fan control to be disabled if
the value is set to 0). In other words, fixing one ABI violation creates another.
That is why I am really unhappy about this.

Guenter


