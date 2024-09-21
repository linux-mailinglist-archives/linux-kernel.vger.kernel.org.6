Return-Path: <linux-kernel+bounces-334746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D32E97DB98
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 05:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 175252830CC
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 03:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B2F18C0C;
	Sat, 21 Sep 2024 03:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="eW+S5erL"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4DE848E
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 03:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726890717; cv=none; b=DfI4cUoV8CjsaAyEF7kcaNIW3hwsJY6UJQe7SbdpuaibEo0sO9SmcZOKVIu3CPuZ3wG3zHuRj76wscCKXOu3Y3q5rIapwHD6Anc66iMUUJlVqkJMYvTf7aYmHSf8oi1Tb7Fvb97TEjEgwuXz5yiVBrMz7hBhdEzTbVt+/e5TZQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726890717; c=relaxed/simple;
	bh=V3p2UXTvJW4YmYSIsi8D27NGNa9wuivsdXhFVldqOM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aAqySaWfuXwya2SKtdE/HhwaQd6FH4R9qz7dc8vAXF/rA4oaf8D6cIT1m1+BFB2YvhDqgV0dyRUwuQL2cKRl2+dnyzwYRxh1pYQ7Z3EbgcDO4+dJelAYKWkDoomOMOd2Tb0bWFw9OkvrDXavme3XyKhA38zoS2ULaaY4wRK/4fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net; spf=pass smtp.mailfrom=telus.net; dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b=eW+S5erL; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telus.net
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2da5acb95d2so450778a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 20:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1726890713; x=1727495513; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hFBuPbcDiH6J98bxAqHe7NG+vmOezzRKil54cbciqIU=;
        b=eW+S5erLMzNGOcI4x5jDGYs/L0lGM04zwyFeG98z6RJ3ra2q3wdfgIz163FMjK+aIG
         WZxgfFNIMdXi2vn8cArPRErNzmuUJF0HI4XUe/PkXW7gfTvKFgKrsXRiFGyyh2FMFfsw
         uZSW0KlC9X7IcU8BJHRIN8OmTNPtpFtuVXv9Rg31P5R4oBp+isndwCG2/k2B8+TsDzOp
         3vYuzWAFmgIZ065Ip3q3TMxkbIBN5kpEE2IYw9OMq6fLd2so6BqUq1MMNgxmL4sZtMgS
         B49sFpQjpXU7aYiG3igeDJh3scHxQ7DGodNa/hWeVEArKUDVmd9B+tZo+P2QSXPZRRym
         7QNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726890713; x=1727495513;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hFBuPbcDiH6J98bxAqHe7NG+vmOezzRKil54cbciqIU=;
        b=dRZhyjSfKzxBItYKf2RMTzqcMsPbr8CJMBDalgivgxXUusuy0q2DeQosoNJ8wITkb1
         A+lJRZm5heHoMJbGRPER0DK5fzwjfQRI7RFEgTkhghvHruECC6u/QT3JIUNcA9tXKXzq
         vNJksL1exs+AHoM1rwGz0zT7Z7wDa2Hb33eavC2PKQMxc/KLuw1zmUr8FbGqjOdh41uR
         uBmalkw7ISU7igfXqjz390YLUrg6yh5wa/NSdffdnXCUVUYSQDrNUbq573f9R+kKeOov
         x7bZZXzokgCYa9FwuANb/bLZxNthuEoTDYZlrZZdRE7lynf0zgUR1wQoS23TusG8i9Vk
         6v6g==
X-Gm-Message-State: AOJu0YwrkmaXsXgWkmhahzjhVPto1bmQkrt6atWJWn8juEOheIMX9GSq
	E/aGb36Ua/jIjd0xn89BASmLF+03scHMQ3WcY+9cALaAhQiUPnrn+ZFakH7yvYk=
X-Google-Smtp-Source: AGHT+IHd2lgx67tKpFNq6dsbvKaE5w5KdlABOz3LK3zHjreb+sRCPDLipKONQQAOdAkOE5Xru5EOpQ==
X-Received: by 2002:a17:902:da88:b0:207:14ca:f0c3 with SMTP id d9443c01a7336-208d856da04mr26431525ad.15.1726890712987;
        Fri, 20 Sep 2024 20:51:52 -0700 (PDT)
Received: from ?IPV6:2001:56a:f979:1f00:1e92:b1c8:44bc:ce5a? ([2001:56a:f979:1f00:1e92:b1c8:44bc:ce5a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207945da599sm101503115ad.6.2024.09.20.20.51.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2024 20:51:52 -0700 (PDT)
Message-ID: <609d594a-62e8-44ed-9cc2-585f9bf5ef70@telus.net>
Date: Fri, 20 Sep 2024 21:51:50 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Re: AMDGPU 6.11.0 crash, 6.10.0 git bisect log
To: Alex Hung <alex.hung@amd.com>, "Dr. David Alan Gilbert"
 <linux@treblig.org>, alexander.deucher@amd.com
Cc: linux-kernel@vger.kernel.org, regressions@lists.linux.dev
References: <c21b734a-1d3d-4286-a3c5-a6ae9b69d847@telus.net>
 <Zu3-nJ7LpVzoN5Bj@gallifrey> <1ab1991a-382f-4b59-9e07-76a696159631@amd.com>
 <894c29d5-0997-422c-9013-d1a17990b8a0@telus.net>
 <4bbf68fa-6ca2-47a0-9966-6971dabd7a0f@amd.com>
Content-Language: en-US
From: Bob Gill <gillb5@telus.net>
In-Reply-To: <4bbf68fa-6ca2-47a0-9966-6971dabd7a0f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

So the final change:

CONFIG_DEBUG_KERNEL_DC=y

(about line 227) of drivers/gpu/drm/amd/display/dc/bios/command_table2.c

BIOS_CMD_TABLE_REVISION(dig1transmittercontrol, frev, crev);

with the 6.11.0 kernel,

and the X server is working OK.

Thanks,

Bob

On 2024-09-20 20:20, Alex Hung wrote:
>
>
> On 2024-09-20 18:20, Bob Gill wrote:
>> Hi.  Sorry for the late reply.  My config has
>> CONFIG_DEBUG_KERNEL_DC=y
>>
>> I will set it to # CONFIG_DEBUG_KERNEL_DC is not set
>
> Hi Bob,
>
> It seems the below change in a171cce57792 causes the hang when 
> CONFIG_DEBUG_KERNEL_DC is set.
>
> --- a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
> +++ b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
> @@ -227,7 +227,8 @@ static void init_transmitter_control(struct 
> bios_parser *bp)
>         uint8_t frev;
>         uint8_t crev = 0;
>
> -       BIOS_CMD_TABLE_REVISION(dig1transmittercontrol, frev, crev);
> +       if (!BIOS_CMD_TABLE_REVISION(dig1transmittercontrol, frev, crev))
> +               BREAK_TO_DEBUGGER();
>
> If you can help confirm thefollowing fix the hang, I will prepare a 
> revert patch next week:
>
> * Set CONFIG_DEBUG_KERNEL_DC and revert the above change, i.e.
>
> --- a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
> +++ b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
> @@ -227,8 +227,7 @@ static void init_transmitter_control(struct 
> bios_parser *bp)
>         uint8_t frev;
>         uint8_t crev = 0;
>
> -       if (!BIOS_CMD_TABLE_REVISION(dig1transmittercontrol, frev, crev))
> -               BREAK_TO_DEBUGGER();
> +       BIOS_CMD_TABLE_REVISION(dig1transmittercontrol, frev, crev);
>
>
> Thanks a lot
>
>>
>> also,
>>
>> cat /var/log/kern.log | grep VBIOS       gives
>>
>> Sep 15 11:53:43 freedom kernel: [   16.372684] amdgpu 0000:04:00.0: 
>> amdgpu: Fetched VBIOS from ROM BAR
>> Sep 15 13:58:04 freedom kernel: [   16.705182] amdgpu 0000:04:00.0: 
>> amdgpu: Fetched VBIOS from ROM BAR
>> Sep 15 14:20:05 freedom kernel: [   17.043288] amdgpu 0000:04:00.0: 
>> amdgpu: Fetched VBIOS from ROM BAR
>> Sep 15 14:38:23 freedom kernel: [   16.625105] amdgpu 0000:04:00.0: 
>> amdgpu: Fetched VBIOS from ROM BAR
>> Sep 16 09:40:52 freedom kernel: [   16.780135] amdgpu 0000:04:00.0: 
>> amdgpu: Fetched VBIOS from ROM BAR
>> Sep 16 09:52:39 freedom kernel: [   15.764412] amdgpu 0000:04:00.0: 
>> amdgpu: Fetched VBIOS from ROM BAR
>> Sep 16 14:59:23 freedom kernel: [   16.077181] amdgpu 0000:04:00.0: 
>> amdgpu: Fetched VBIOS from ROM BAR
>> Sep 16 19:03:50 freedom kernel: [   16.613359] amdgpu 0000:04:00.0: 
>> amdgpu: Fetched VBIOS from ROM BAR
>> Sep 16 19:18:13 freedom kernel: [   15.895630] amdgpu 0000:04:00.0: 
>> amdgpu: Fetched VBIOS from ROM BAR
>> Sep 16 22:01:53 freedom kernel: [   15.768717] amdgpu 0000:04:00.0: 
>> amdgpu: Fetched VBIOS from ROM BAR
>> Sep 17 09:48:50 freedom kernel: [   15.758361] amdgpu 0000:04:00.0: 
>> amdgpu: Fetched VBIOS from ROM BAR
>> Sep 17 10:31:23 freedom kernel: [   15.762467] amdgpu 0000:04:00.0: 
>> amdgpu: Fetched VBIOS from ROM BAR
>> Sep 18 09:43:12 freedom kernel: [   16.086531] amdgpu 0000:04:00.0: 
>> amdgpu: Fetched VBIOS from ROM BAR
>> Sep 19 09:32:07 freedom kernel: [   16.034418] amdgpu 0000:04:00.0: 
>> amdgpu: Fetched VBIOS from ROM BAR
>> Sep 19 12:04:46 freedom kernel: [   15.771447] amdgpu 0000:04:00.0: 
>> amdgpu: Fetched VBIOS from ROM BAR
>> Sep 19 13:54:41 freedom kernel: [   15.791940] amdgpu 0000:04:00.0: 
>> amdgpu: Fetched VBIOS from ROM BAR
>> Sep 19 15:37:35 freedom kernel: [   15.749058] amdgpu 0000:04:00.0: 
>> amdgpu: Fetched VBIOS from ROM BAR
>> Sep 19 17:25:04 freedom kernel: [   16.449671] amdgpu 0000:04:00.0: 
>> amdgpu: Fetched VBIOS from ROM BAR
>> Sep 19 19:43:06 freedom kernel: [   16.312367] amdgpu 0000:04:00.0: 
>> amdgpu: Fetched VBIOS from ROM BAR
>> Sep 19 21:31:28 freedom kernel: [   15.864131] amdgpu 0000:04:00.0: 
>> amdgpu: Fetched VBIOS from ROM BAR
>> Sep 20 09:12:39 freedom kernel: [   15.764786] amdgpu 0000:04:00.0: 
>> amdgpu: Fetched VBIOS from ROM BAR
>> Sep 20 11:31:36 freedom kernel: [   17.332211] amdgpu 0000:04:00.0: 
>> amdgpu: Fetched VBIOS from ROM BAR
>> Sep 20 13:23:19 freedom kernel: [   15.759616] amdgpu 0000:04:00.0: 
>> amdgpu: Fetched VBIOS from ROM BAR
>> Sep 20 13:45:07 freedom kernel: [   16.557215] amdgpu 0000:04:00.0: 
>> amdgpu: Fetched VBIOS from ROM BAR
>> Sep 20 14:01:17 freedom kernel: [   16.433437] amdgpu 0000:04:00.0: 
>> amdgpu: Fetched VBIOS from ROM BAR
>> Sep 20 14:24:14 freedom kernel: [   15.770057] amdgpu 0000:04:00.0: 
>> amdgpu: Fetched VBIOS from ROM BAR
>> Sep 20 14:47:27 freedom kernel: [   15.725150] amdgpu 0000:04:00.0: 
>> amdgpu: Fetched VBIOS from ROM BAR
>> Sep 20 15:02:31 freedom kernel: [   16.591276] amdgpu 0000:04:00.0: 
>> amdgpu: Fetched VBIOS from ROM BAR
>> Sep 20 15:19:44 freedom kernel: [   15.863542] amdgpu 0000:04:00.0: 
>> amdgpu: Fetched VBIOS from ROM BAR
>>
>> so not what quite what you were looking for, but when I run cat 
>> kern.log | grep Failed :
>>
>> Sep 15 11:53:43 freedom kernel: [   25.730013] uvcvideo 1-5.2:1.1: 
>> Failed to set UVC probe control : -32 (exp. 26).
>> Sep 15 13:58:04 freedom kernel: [   26.025432] uvcvideo 2-5.2:1.1: 
>> Failed to set UVC probe control : -32 (exp. 26).
>> Sep 15 14:38:23 freedom kernel: [   25.883820] uvcvideo 2-5.2:1.1: 
>> Failed to set UVC probe control : -32 (exp. 26).
>> Sep 16 09:40:52 freedom kernel: [   27.204539] uvcvideo 1-5.2:1.1: 
>> Failed to set UVC probe control : -32 (exp. 26).
>> Sep 16 14:41:22 freedom kernel: [   28.985885] uvcvideo 2-5.2:1.1: 
>> Failed to set UVC probe control : -32 (exp. 26).
>> Sep 16 19:03:50 freedom kernel: [   26.510748] uvcvideo 1-5.2:1.1: 
>> Failed to set UVC probe control : -32 (exp. 26).
>> Sep 17 09:48:50 freedom kernel: [   25.682372] uvcvideo 2-5.2:1.1: 
>> Failed to set UVC probe control : -32 (exp. 26).
>> Sep 17 10:31:23 freedom kernel: [   25.547899] uvcvideo 1-5.2:1.1: 
>> Failed to set UVC probe control : -32 (exp. 26).
>> Sep 18 09:43:12 freedom kernel: [   26.243232] uvcvideo 1-5.2:1.1: 
>> Failed to set UVC probe control : -32 (exp. 26).
>> Sep 19 09:32:07 freedom kernel: [   25.267332] uvcvideo 2-5.2:1.1: 
>> Failed to set UVC probe control : -32 (exp. 26).
>> Sep 19 12:04:46 freedom kernel: [   25.269450] uvcvideo 2-5.2:1.1: 
>> Failed to set UVC probe control : -32 (exp. 26).
>> Sep 19 15:37:35 freedom kernel: [   25.494803] uvcvideo 1-5.2:1.1: 
>> Failed to set UVC probe control : -32 (exp. 26).
>> Sep 19 19:43:06 freedom kernel: [   26.288598] uvcvideo 2-5.2:1.1: 
>> Failed to set UVC probe control : -32 (exp. 26).
>> Sep 20 09:12:39 freedom kernel: [   25.291743] uvcvideo 2-5.2:1.1: 
>> Failed to set UVC probe control : -32 (exp. 26).
>> Sep 20 13:23:19 freedom kernel: [   25.884358] uvcvideo 1-5.2:1.1: 
>> Failed to set UVC probe control : -32 (exp. 26).
>> Sep 20 14:24:14 freedom kernel: [   25.312379] uvcvideo 2-5.2:1.1: 
>> Failed to set UVC probe control : -32 (exp. 26).
>> Sep 20 14:47:27 freedom kernel: [   25.352905] uvcvideo 2-5.2:1.1: 
>> Failed to set UVC probe control : -32 (exp. 26).
>> Sep 20 15:19:44 freedom kernel: [   25.297893] uvcvideo 2-5.2:1.1: 
>> Failed to set UVC probe control : -32 (exp. 26).
>>
>>
>> Hopefully this helps.  Please mail me if you for more information.  I 
>> have changed my .config and set
>>
>> # CONFIG_DEBUG_KERNEL_DC is not set
>>
>> I am attempting to build 6.11.0.
>>
>> Thanks,
>>
>> Bob
>>
>>
>> On 2024-09-20 17:34, Alex Hung wrote:
>>>
>>>
>>> On 2024-09-20 17:00, Dr. David Alan Gilbert wrote:
>>>> * Bob Gill (gillb5@telus.net) wrote:
>>>>> Hello.  Kernel 6.11.0 crashes. 6.10.0 builds.  Al Viro and Dr. 
>>>>> David Alan
>>>>> Gilbert have been helpful, and asked that I
>>>>>
>>>>> post a git bisect log.  The last log step seems odd, but the 
>>>>> second last
>>>>> step "Remove useless function call" might be what broke.
>>>>
>>>> Thank you for doing this!
>>>>
>>>> My reading is that's fine, I think the next one:
>>>>
>>>> tree: git bisect bad
>>>> [a171cce57792b0a6206d532050179a381ad74f8f] drm/amd/display: Check 
>>>> and log for
>>>> function error codes
>>>>
>>>> or the one after it is the culprit?
>>>>
>>>> Adding the two Alex's from AMD back onto the thread.
>>>> (Also added the [REGRESSION] marker the notes tell us to add)
>>>
>>> The commit triggers debugger in case of in case of errors.
>>>
>>> Is the config CONFIG_DEBUG_KERNEL_DC (Enable kgdb break in DC) 
>>> enabled in .config, i.e. can you check "grep CONFIG_DEBUG_KERNEL_DC 
>>> .config"?
>>>
>>> If so, can you also try to disable it and check whether you can see 
>>> error messages "Failed to execute VBIOS command table" in kernel log?
>>>
>>>>
>>>>> My hardware is old corei7 quad core/8 thread Tylersberg/Nehalem 
>>>>> with an AMD
>>>>> RX 6500XT.  That's the odd combination.
>>>>>
>>>>> Thanks in advance,
>>>>
>>>> Thanks again for the bisect.
>>>>
>>>> Dave
>>>>
>>>>> Bob
>>>>>
>>>>> Config:  (.config)
>>>>> /data/kernel/bobtest6.10-64
>>>>>
>>>>> Build line: (last command tells me the job is finished)
>>>>> make menuconfig && make -j $(nproc) && make modules && make 
>>>>> modules_install
>>>>> && make install && /data/music/pl.sh
>>>>>
>>>>> Rule 1: Do not modify ANYTHING in the source tree
>>>>>
>>>>> git bisect start
>>>>> git bisect bad
>>>>> git bisect good v6.10
>>>>>
>>>>> Bisecting: 11273 revisions left to test after this (roughly 14 steps)
>>>>> [2c9b3512402ed192d1f43f4531fb5da947e72bd0] Merge tag 'for-linus' of
>>>>> git://git.kernel.org/pub/scm/virt/kvm/kvm
>>>>>
>>>>> latest kernel:
>>>>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>>>>> 6.10.0+
>>>>>
>>>>> RESULT:  boot 6.10.0+ fails
>>>>>           screen black for more than 2 minutes,
>>>>>           (caps lock key unresponsive, reset, power
>>>>>           buttons on computer case do nothing).  Reset with power 
>>>>> bar.
>>>>>
>>>>> tree: git bisect bad
>>>>> Bisecting: 5677 revisions left to test after this (roughly 13 steps)
>>>>> [280e36f0d5b997173d014c07484c03a7f7750668] nsfs: use cleanup guard
>>>>>
>>>>> latest kernel:
>>>>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>>>>> 6.10.0+
>>>>>
>>>>> RESULT: boot 6.10.0+ successful
>>>>> tree: git bisect good
>>>>> Bisecting: 2855 revisions left to test after this (roughly 12 steps)
>>>>> [dde1a0e1625c08cf4f958348a83434b2ddecf449] Merge tag 
>>>>> 'x86-percpu-2024-07-17'
>>>>> of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>>>>>
>>>>> latest kernel:
>>>>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>>>>> 6.10.0+
>>>>>
>>>>> RESULT: boot 6.10.0+ fails
>>>>>          screen black for more than 2 minutes,
>>>>>          (caps lock key unresponsive, reset, power
>>>>>          buttons on computer case do nothing).  Reset with power bar.
>>>>>
>>>>> tree: git bisect bad
>>>>> Bisecting: 1478 revisions left to test after this (roughly 11 steps)
>>>>> [32a120f52a4c0121bca8f2328d4680d283693d60] drm/i915/mtl: Skip PLL 
>>>>> state
>>>>> verification in TBT mode
>>>>>
>>>>> latest kernel:
>>>>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>>>>> 6.10.0-rc3+
>>>>>
>>>>> RESULT: boot 6.10.0-rc3+ successful
>>>>> tree: git bisect good
>>>>> Bisecting: 739 revisions left to test after this (roughly 10 steps)
>>>>> [b6a343df46d69070a7073405e470e6348180ea34] drm/amdgpu: initialize 
>>>>> GC IP
>>>>> v11.5.2
>>>>>
>>>>> latest kernel:
>>>>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>>>>> 6.10.0-rc3+
>>>>>
>>>>> RESULT: boot 6.10.0-rc3+ fails
>>>>>          screen black for more than 2 minutes,
>>>>>          (caps lock key unresponsive, reset, power
>>>>>          buttons on computer case do nothing).  Reset with power bar.
>>>>>
>>>>> tree: git bisect bad
>>>>> Bisecting: 369 revisions left to test after this (roughly 9 steps)
>>>>> [cf1d06ac53a15b83c0a63225606cfe175e33a8a0] accel/ivpu: Increase 
>>>>> autosuspend
>>>>> delay to 100ms on 40xx
>>>>>
>>>>> latest kernel:
>>>>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>>>>> 6.10.0-rc1+
>>>>>
>>>>> RESULT: boot 6.10.0-rc1+ successful
>>>>> tree: git bisect good
>>>>> Bisecting: 184 revisions left to test after this (roughly 8 steps)
>>>>> [0ca9f757a0e27a076395ec1b2002661bcf5c25e8] drm/amd/pm: powerplay: Add
>>>>> `__counted_by` attribute for flexible arrays
>>>>>
>>>>> latest kernel:
>>>>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>>>>> 6.9.0-rc5+
>>>>>
>>>>> RESULT: boot 6.9.0-rc5+ successful
>>>>> tree: git bisect good
>>>>> Bisecting: 92 revisions left to test after this (roughly 7 steps)
>>>>> [9862ef7bae47b9292a38a0a1b30bff7f56d7815b] drm/amd/display: Use 
>>>>> periodic
>>>>> detection for ipx/headless
>>>>>
>>>>> latest kernel:
>>>>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>>>>> 6.10.0-rc3+
>>>>>
>>>>> RESULT: boot 6.10.0-rc3+ fails
>>>>>          screen black for more than 2 minutes,
>>>>>          (caps lock key unresponsive, reset, power
>>>>>          buttons on computer case do nothing).  Reset with power bar.
>>>>>
>>>>> tree: git bisect bad
>>>>> Bisecting: 44 revisions left to test after this (roughly 6 steps)
>>>>> [a78313bb206e0c456a989f380c4cbd8af8af7c76] Merge tag
>>>>> 'drm-intel-gt-next-2024-06-12' of
>>>>> https://gitlab.freedesktop.org/drm/i915/kernel into drm-next
>>>>>
>>>>> latest kernel:
>>>>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>>>>> 6.10.0-rc3+
>>>>>
>>>>> RESULT: boot 6.10.0-rc3+ successful
>>>>> tree: git bisect good
>>>>> Bisecting: 22 revisions left to test after this (roughly 5 steps)
>>>>> [51dbe0239b1fc7c435867ce28e5eb4394b6641e1] drm/amd/display: Fix 
>>>>> cursor size
>>>>> issues
>>>>>
>>>>> latest kernel:
>>>>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>>>>> 6.10.0-rc3+
>>>>>
>>>>> RESULT: boot 6.10.0-rc3+ successful
>>>>> tree: git bisect good
>>>>> Bisecting: 11 revisions left to test after this (roughly 4 steps)
>>>>> [871512e36f9c1c2cb4e62eb860ca0438800e4d63] drm/amd/display: Add 
>>>>> workaround
>>>>> to restrict max frac urgent for DPM0
>>>>>
>>>>> latest kernel:
>>>>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>>>>> 6.10.0-rc3+
>>>>>
>>>>> RESULT: boot 6.10.0-rc3+ fails
>>>>>          screen black for more than 2 minutes,
>>>>>          (caps lock key unresponsive, reset, power
>>>>>          buttons on computer case do nothing).  Reset with power bar.
>>>>>
>>>>> tree: git bisect bad
>>>>> Bisecting: 5 revisions left to test after this (roughly 3 steps)
>>>>> [5d93060d430b359e16e7c555c8f151ead1ac614b] drm/amd/display: Check 
>>>>> HDCP
>>>>> returned status
>>>>>
>>>>> latest kernel:
>>>>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>>>>> 6.10.0-rc3+
>>>>>
>>>>> RESULT: boot 6.10.0-rc3+ fails
>>>>>          screen black for more than 2 minutes,
>>>>>          (caps lock key unresponsive, reset, power
>>>>>          buttons on computer case do nothing).  Reset with power bar.
>>>>>
>>>>> tree: git bisect bad
>>>>> Bisecting: 2 revisions left to test after this (roughly 1 step)
>>>>> [e094992bd1caa1fbd42221c7c305fc3b54172b5c] drm/amd/display: Remove 
>>>>> useless
>>>>> function call
>>>>>
>>>>> latest kernel:
>>>>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>>>>> 6.10.0-rc3+
>>>>>
>>>>> RESULT: boot 6.10.0-rc3+ successful
>>>>>
>>>>> tree: git bisect good
>>>>> [2c2ee1d1329881d8e6bb23c3b9f3b41df8a8055c] drm/amd/display: Check 
>>>>> and log
>>>>> for function error codes
>>>>>
>>>>> latest kernel:
>>>>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>>>>> 6.10.0-rc3+
>>>>>
>>>>> RESULT: boot 6.10.0-rc3+ fails
>>>>>          screen black for more than 2 minutes,
>>>>>          (caps lock key unresponsive, reset, power
>>>>>          buttons on computer case do nothing).  Reset with power bar.
>>>>>
>>>>> tree: git bisect bad
>>>>> [a171cce57792b0a6206d532050179a381ad74f8f] drm/amd/display: Check 
>>>>> and log
>>>>> for function error codes
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>

