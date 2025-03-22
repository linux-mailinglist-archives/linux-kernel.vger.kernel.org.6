Return-Path: <linux-kernel+bounces-572556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0963AA6CB65
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 17:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E82AA7A8CDE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 16:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3A7233150;
	Sat, 22 Mar 2025 16:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCCyqS0D"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B57022D4F9;
	Sat, 22 Mar 2025 16:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742659844; cv=none; b=croWRGgwfz3rlGuC1CUQd+wC02HR/QcRA2uC4fS8OTBJ6rkBaw0xCVYGgnr+iOesp1XImR2Koq70CWzNZm2QBFvxtLm8s/GKblBujk5iNtX90j0LFxYVfiqWMMn4fCmySru61TuI4Yzl787+SyeJN3z5a/QB140bfAFhDP5z0MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742659844; c=relaxed/simple;
	bh=HaG1QQpWowV3zqOZgL6LReoscnDOkJHO/+T7PqNBxe4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eJE98UHBk5S5TH+LvQdrrrbZn+VKiy1DdSHNFLbautOR23OLxZBW6/IUpHvlF27+bnRtCaNsonpaHOauxF/EBgwJMvaZuYSz+i+f9jduM0YdelqEFDsBJz0KkQLr3UiSmszkn+wGxfIYHEWg8ADxNrjg80cS0Vn1hwqS3GixGVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bCCyqS0D; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-301d6cbbd5bso5244092a91.3;
        Sat, 22 Mar 2025 09:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742659842; x=1743264642; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=nEjOAl7KxYpthTONAdqNUvrFWmX1LTq5WeO+Al3OX6A=;
        b=bCCyqS0Dl0Zn6fRy1DBJl7An63Uz8vYrnuPYjGnOOLZwxcQlD2DTWyF2qCmAdMDY41
         R3PPijpGyUgye1wgRTL5goS5RN1anpDCjCvsgNX5/N4vqpyCmif62BiWRhbMJonQJPPr
         OB6IMrefpmLkmIXvo9xXF2t3dQ470wU5zmJQL5Jrz9FEZ2iPYgnwIAroRi7CndIvmsGM
         j/sCE8scXXM6VUdNFSrUvCgBOPvZjPSx884y/tMwkXQs9nnZNUK3WYJqly+1RjSH+LgN
         79RBjPTvGXGXGYdF3X4LyK2K5UldbOhlOtCux35xt5Lg7iqlJGvAQ4Y8dzhlFgA1H+5+
         bc+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742659842; x=1743264642;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nEjOAl7KxYpthTONAdqNUvrFWmX1LTq5WeO+Al3OX6A=;
        b=V23FxMH1cRh/LVAckUzmdfjISc6+bqEOPCRJrx86QJMOQhpNmp+kfROvYo5qNULw7O
         cl4L3sLVdbUMLpHbVYd4HwVM/+ZNhgQYmZDM5GHIsjQ1vUPCTTE0GZ+9Wr0zU5F5LTUw
         ZojNPvfni6LVlCdfjXsUXzcFV8Im4t6aYINHIFBJikBw8IbuV9+jZQyGkig+iuRLc/AK
         U39dNccHjEOGV//skcOB9UFV6mzr0Vxn0/8hACHm+4ZakfbBuKTsIT8jxih0vgs0umqW
         d7uT0JEGRxdrrRqF5Y4q1sZfnmh1OQlL+gsB0oSCS30QB9X0lPg5yvS17XVt4ubYJfmG
         HHZw==
X-Forwarded-Encrypted: i=1; AJvYcCVCqS4Alo10cgH2Hd+psMreWn+n5QIlY237RxC58yV4ttIba/Asf3LdRPsL8haxEgDUvGMGgKol4LwPlB7v@vger.kernel.org, AJvYcCWu9akWtrDUi+StbWTXR671y/XH8S/wNycB2LZsd/Grg5KUm7CQKebkEcgD0NP6cbUMM1pvIUyJs7Bviw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyShWubmROSWkgKTlPlWcBELvPodOvSj/O9Ss/ysVuNnchMMGew
	Lk4pfdUKhXPD6YZYAJxd+zNlDnbA/sufHIJ4ZahflmpfqGhJhakx
X-Gm-Gg: ASbGncusX59+Unq6V1b7lu8G+isgG3IWZgK6c+1SOH0wDioyQ6WFhPFPjprcamWMczQ
	eJfhf2soBQiaBPLTSLTrBYl5O/j2GoIzBA0mXxPipDkxsHHSDyvHHbPpaciMqGWoaqBeXouTL3d
	qc0yqptblttAm7q4e/ZYou2Vw2KIJOFsk7SSafQBjJxCf0RfyT92Lxe90vHLbrRvF3YvGi2Tq+X
	0NmjL3QjzJEDUL4eeSFU7d9x+uOK3Ko0yRJGT3bBKDgmlDOkFVQwtz46VkpNXZA2TeAQFfDmKhq
	MtpvVF2vSdTJ+1mtmE/sHQREBEZ8v5qPj4e5gqS4/0k2FVNA6Nhdoz7maR6VK0VKQlFatMLoI3y
	rvGSnqrCpdS57aFHEiQ==
X-Google-Smtp-Source: AGHT+IE6f4ijZ6TPZFbBvByWuGNtIewjAThqJES6BbZ3s5whFhV4Cv/NAe7MGSdaXuDEj96TeplsqQ==
X-Received: by 2002:a17:90b:3883:b0:2ff:5ed8:83d1 with SMTP id 98e67ed59e1d1-3030fea76cdmr9380645a91.19.1742659842150;
        Sat, 22 Mar 2025 09:10:42 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301a39efc5bsm9175942a91.0.2025.03.22.09.10.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Mar 2025 09:10:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <42c49b0b-cef0-49ca-a5b2-5bb05eae8dec@roeck-us.net>
Date: Sat, 22 Mar 2025 09:10:40 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hwmon: (cros_ec) Add set and get target fan RPM
 function
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>
Cc: Sung-Chi Li <lschyi@chromium.org>, Jean Delvare <jdelvare@suse.com>,
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
 chrome-platform@lists.linux.dev, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250318-extend_ec_hwmon_fan-v3-1-4c886385861f@chromium.org>
 <e4da28be-66ca-45d3-9ccf-34819460b463@t-8ch.de>
 <f50221fd-1d76-465b-ba53-62c08c6f8536@roeck-us.net>
 <780ce6e8-11fc-42be-b4a7-9cffbf811d78@t-8ch.de>
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
In-Reply-To: <780ce6e8-11fc-42be-b4a7-9cffbf811d78@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/22/25 08:23, Thomas Weißschuh wrote:
> On 2025-03-22 07:12:48-0700, Guenter Roeck wrote:
>> On 3/22/25 06:55, Thomas Weißschuh wrote:
>>> On 2025-03-18 15:45:23+0800, Sung-Chi Li wrote:
>>>> The ChromeOS embedded controller (EC) supports closed loop fan speed
>>>> control, so add the fan target attribute under hwmon framework, such
>>>> that kernel can expose reading and specifying the desired fan RPM for
>>>> fans connected to the EC.
>>>>
>>>> When probing the cros_ec hwmon module, we also check the supported
>>>> command version of setting target fan RPM. This commit implements the
>>>> version 0 of getting the target fan RPM, which can only read the target
>>>> RPM of the first fan. This commit also implements the version 1 of
>>>> setting the target fan RPM to each fan respectively.
>>>>
>>>> Signed-off-by: Sung-Chi Li <lschyi@chromium.org>
>>>> ---
>>>> ChromeOS embedded controller (EC) supports closed-loop fan control. We
>>>> anticipate to have the fan related control from the kernel side, so this
>>>> series register the HWMON_F_TARGET attribute, and implement the read and
>>>> write function for setting/reading the target fan RPM from the EC side.
>>>
>>> Should it be possible to switch back to automatic control?
>>> I can't find anything in the hwmon ABI about it.
>>> And neither in the CrOS EC source.
>>>
>>> Am I missing something?
>>>
>>
>> Not sure I understand the context, but the fan control method is normally
>> selected with pwmX_enable, which is defined as
>>
>>                  Fan speed control method:
>>
>>                  - 0: no fan speed control (i.e. fan at full speed)
>>                  - 1: manual fan speed control enabled (using `pwmY`)
>>                  - 2+: automatic fan speed control enabled
> 
> So far I associated pwmY_enable = 1 with the pwmY attribute.
> Also controlling it through fanY_target does make sense though.
> It could be clearer from the docs IMHO.
> 
> That also means that the patch under discussion needs to implement the
> pwmY_enable attribute.
> 

Does it ? Does setting the target fan speed automatically change the fan
control method ? Normally that is orthogonal: One does not necessarily
want to enable a specific fan control method after setting a single related
attribute, but do that only after all attributes have been set.

For example, there could be another attribute specifying how fast the fan
speed should be adjusted, or there could be minimum and/or maximum permitted
pwm values. I am not saying that this is the case here, but setting a target
fan speed should not automatically change the fan control method.

Guenter


