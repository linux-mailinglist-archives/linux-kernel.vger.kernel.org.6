Return-Path: <linux-kernel+bounces-334714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B850D97DAF8
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 02:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4A271C20F1D
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 00:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD93B1878;
	Sat, 21 Sep 2024 00:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="Lbz0JHnL"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA106257B
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 00:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726878041; cv=none; b=QQGUHqmYzszUwqA/ohqVE0onHZsvPfGfHSs1qeYnFS8v/4M6L550QhTZYy/pWymJw/qc0ZED4Nf9AJxVnUtx9bfQD/4O/TR9brU3s8PtUDfzVqLAGZQKE1Ya2a89PEuhFQP1i4Bu9H/thkIEplkZ25et5hzXSfBu4CJ7QBh/eLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726878041; c=relaxed/simple;
	bh=7C1W/S8BIYW3A06wwAJ0C0i+69TNDHDPHJzttybg2WY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JVvfIpqTmO+H6x8HBM2u/80SfIXbM6VnKk/4nFWBtO6ELYcsIfeG4ADB1pme0IC6Uy+IqzIRubi0Y3bMj2OZfV0z6sQoVjhyVltGx6pwowLDbFSNtQg66Hiy2zWPXbbHjPWA8qkTJjRKjm3RZQDcMokroofo76mkS9ZoA2F4huw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net; spf=pass smtp.mailfrom=telus.net; dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b=Lbz0JHnL; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telus.net
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d87a57c06fso421500a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 17:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1726878039; x=1727482839; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i/1ZV76aZiZ4+eikaoIb5dis7MFCxUvFa2R9b3A6ecA=;
        b=Lbz0JHnLdrNFy4iIC4264eevE8zw3naudQ1VqEwwFfcrpLNYf5oRl/fnsY2hIGVt0S
         SckpPi5ANVNIXX5AWhKr0v7qE0g2tHRAPiyssiQtb0TzXlOYX7J4CZRflB+qf8YP/Cxl
         JnoiWJBo4WPE9gUKGl2Y3f7CpBHSO/8TVt5Dtf12a0xHWng/mQQF6hJ/4bxr6jCJNqyi
         F67MwpqSjIYz44iKr8sGriw3A6zLea9K6a+3+KjpPwhAbhiQlMltYITEIakUGKL5dmah
         okwC5LtVQDGh5t9EIJREzR6mEvZEcQbjJGO/JH1urMutTrI/F8xdEYH61qoNJ7Q4SOEv
         pf0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726878039; x=1727482839;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i/1ZV76aZiZ4+eikaoIb5dis7MFCxUvFa2R9b3A6ecA=;
        b=Wz2g4OyH4+y6+4Bq04Z5Dp3LZvZVZ43t4ha/6J42kQN4bZiB5mAXwoSoXhGDlye0mN
         VMtJl9GgyYgSbNpF5a7dffOf3c2msUUzk9qt+aXmIirxRLYN//uZNNTxtTOjYUWPjJUP
         mIkOH/P0B6NyfE0TDYBgDB19F691e/MB+rALeXRYqhuEYDjhPDf5ah15iGa6KIiyegD2
         dxua78zQBV+LFBQrePerYoYcxk1XQaRJumrTvK3zTDBH/NP4PqIeg15XEfb2rfUr+SDc
         PIRlmp59YXCn7i1MgiBCjN887lpBrWimJEPtHZq3sUrYTPMaqcwQTRkkaNur64MWzSpD
         qxug==
X-Gm-Message-State: AOJu0Yw4PCACK/J64yvttvNXlcwGpjJeXQxeGhiWp8Hscm5uM7jsj8NT
	t6RJ2+i36PSayKIfRfBzXCfN14cLaiJtDvsTUXAeC2nrBt/fxvR0ZHyWgTT6aBY=
X-Google-Smtp-Source: AGHT+IGLqwZe3h3U130qw4OhqYyLbYDj8Et1p/qwpF2wCQ9BUs+uU62wuLpIPOhBfFEF2RuVzoZPFw==
X-Received: by 2002:a17:902:da88:b0:207:14ca:f0c3 with SMTP id d9443c01a7336-208d856da04mr24338885ad.15.1726878038373;
        Fri, 20 Sep 2024 17:20:38 -0700 (PDT)
Received: from ?IPV6:2001:56a:f979:1f00:b558:973b:b5c5:4c5a? ([2001:56a:f979:1f00:b558:973b:b5c5:4c5a])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db4999cfb7sm11595883a12.79.2024.09.20.17.20.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2024 17:20:37 -0700 (PDT)
Message-ID: <894c29d5-0997-422c-9013-d1a17990b8a0@telus.net>
Date: Fri, 20 Sep 2024 18:20:35 -0600
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
Content-Language: en-US
From: Bob Gill <gillb5@telus.net>
In-Reply-To: <1ab1991a-382f-4b59-9e07-76a696159631@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi.  Sorry for the late reply.  My config has
CONFIG_DEBUG_KERNEL_DC=y

I will set it to # CONFIG_DEBUG_KERNEL_DC is not set

also,

cat /var/log/kern.log | grep VBIOS       gives

Sep 15 11:53:43 freedom kernel: [   16.372684] amdgpu 0000:04:00.0: 
amdgpu: Fetched VBIOS from ROM BAR
Sep 15 13:58:04 freedom kernel: [   16.705182] amdgpu 0000:04:00.0: 
amdgpu: Fetched VBIOS from ROM BAR
Sep 15 14:20:05 freedom kernel: [   17.043288] amdgpu 0000:04:00.0: 
amdgpu: Fetched VBIOS from ROM BAR
Sep 15 14:38:23 freedom kernel: [   16.625105] amdgpu 0000:04:00.0: 
amdgpu: Fetched VBIOS from ROM BAR
Sep 16 09:40:52 freedom kernel: [   16.780135] amdgpu 0000:04:00.0: 
amdgpu: Fetched VBIOS from ROM BAR
Sep 16 09:52:39 freedom kernel: [   15.764412] amdgpu 0000:04:00.0: 
amdgpu: Fetched VBIOS from ROM BAR
Sep 16 14:59:23 freedom kernel: [   16.077181] amdgpu 0000:04:00.0: 
amdgpu: Fetched VBIOS from ROM BAR
Sep 16 19:03:50 freedom kernel: [   16.613359] amdgpu 0000:04:00.0: 
amdgpu: Fetched VBIOS from ROM BAR
Sep 16 19:18:13 freedom kernel: [   15.895630] amdgpu 0000:04:00.0: 
amdgpu: Fetched VBIOS from ROM BAR
Sep 16 22:01:53 freedom kernel: [   15.768717] amdgpu 0000:04:00.0: 
amdgpu: Fetched VBIOS from ROM BAR
Sep 17 09:48:50 freedom kernel: [   15.758361] amdgpu 0000:04:00.0: 
amdgpu: Fetched VBIOS from ROM BAR
Sep 17 10:31:23 freedom kernel: [   15.762467] amdgpu 0000:04:00.0: 
amdgpu: Fetched VBIOS from ROM BAR
Sep 18 09:43:12 freedom kernel: [   16.086531] amdgpu 0000:04:00.0: 
amdgpu: Fetched VBIOS from ROM BAR
Sep 19 09:32:07 freedom kernel: [   16.034418] amdgpu 0000:04:00.0: 
amdgpu: Fetched VBIOS from ROM BAR
Sep 19 12:04:46 freedom kernel: [   15.771447] amdgpu 0000:04:00.0: 
amdgpu: Fetched VBIOS from ROM BAR
Sep 19 13:54:41 freedom kernel: [   15.791940] amdgpu 0000:04:00.0: 
amdgpu: Fetched VBIOS from ROM BAR
Sep 19 15:37:35 freedom kernel: [   15.749058] amdgpu 0000:04:00.0: 
amdgpu: Fetched VBIOS from ROM BAR
Sep 19 17:25:04 freedom kernel: [   16.449671] amdgpu 0000:04:00.0: 
amdgpu: Fetched VBIOS from ROM BAR
Sep 19 19:43:06 freedom kernel: [   16.312367] amdgpu 0000:04:00.0: 
amdgpu: Fetched VBIOS from ROM BAR
Sep 19 21:31:28 freedom kernel: [   15.864131] amdgpu 0000:04:00.0: 
amdgpu: Fetched VBIOS from ROM BAR
Sep 20 09:12:39 freedom kernel: [   15.764786] amdgpu 0000:04:00.0: 
amdgpu: Fetched VBIOS from ROM BAR
Sep 20 11:31:36 freedom kernel: [   17.332211] amdgpu 0000:04:00.0: 
amdgpu: Fetched VBIOS from ROM BAR
Sep 20 13:23:19 freedom kernel: [   15.759616] amdgpu 0000:04:00.0: 
amdgpu: Fetched VBIOS from ROM BAR
Sep 20 13:45:07 freedom kernel: [   16.557215] amdgpu 0000:04:00.0: 
amdgpu: Fetched VBIOS from ROM BAR
Sep 20 14:01:17 freedom kernel: [   16.433437] amdgpu 0000:04:00.0: 
amdgpu: Fetched VBIOS from ROM BAR
Sep 20 14:24:14 freedom kernel: [   15.770057] amdgpu 0000:04:00.0: 
amdgpu: Fetched VBIOS from ROM BAR
Sep 20 14:47:27 freedom kernel: [   15.725150] amdgpu 0000:04:00.0: 
amdgpu: Fetched VBIOS from ROM BAR
Sep 20 15:02:31 freedom kernel: [   16.591276] amdgpu 0000:04:00.0: 
amdgpu: Fetched VBIOS from ROM BAR
Sep 20 15:19:44 freedom kernel: [   15.863542] amdgpu 0000:04:00.0: 
amdgpu: Fetched VBIOS from ROM BAR

so not what quite what you were looking for, but when I run cat kern.log 
| grep Failed :

Sep 15 11:53:43 freedom kernel: [   25.730013] uvcvideo 1-5.2:1.1: 
Failed to set UVC probe control : -32 (exp. 26).
Sep 15 13:58:04 freedom kernel: [   26.025432] uvcvideo 2-5.2:1.1: 
Failed to set UVC probe control : -32 (exp. 26).
Sep 15 14:38:23 freedom kernel: [   25.883820] uvcvideo 2-5.2:1.1: 
Failed to set UVC probe control : -32 (exp. 26).
Sep 16 09:40:52 freedom kernel: [   27.204539] uvcvideo 1-5.2:1.1: 
Failed to set UVC probe control : -32 (exp. 26).
Sep 16 14:41:22 freedom kernel: [   28.985885] uvcvideo 2-5.2:1.1: 
Failed to set UVC probe control : -32 (exp. 26).
Sep 16 19:03:50 freedom kernel: [   26.510748] uvcvideo 1-5.2:1.1: 
Failed to set UVC probe control : -32 (exp. 26).
Sep 17 09:48:50 freedom kernel: [   25.682372] uvcvideo 2-5.2:1.1: 
Failed to set UVC probe control : -32 (exp. 26).
Sep 17 10:31:23 freedom kernel: [   25.547899] uvcvideo 1-5.2:1.1: 
Failed to set UVC probe control : -32 (exp. 26).
Sep 18 09:43:12 freedom kernel: [   26.243232] uvcvideo 1-5.2:1.1: 
Failed to set UVC probe control : -32 (exp. 26).
Sep 19 09:32:07 freedom kernel: [   25.267332] uvcvideo 2-5.2:1.1: 
Failed to set UVC probe control : -32 (exp. 26).
Sep 19 12:04:46 freedom kernel: [   25.269450] uvcvideo 2-5.2:1.1: 
Failed to set UVC probe control : -32 (exp. 26).
Sep 19 15:37:35 freedom kernel: [   25.494803] uvcvideo 1-5.2:1.1: 
Failed to set UVC probe control : -32 (exp. 26).
Sep 19 19:43:06 freedom kernel: [   26.288598] uvcvideo 2-5.2:1.1: 
Failed to set UVC probe control : -32 (exp. 26).
Sep 20 09:12:39 freedom kernel: [   25.291743] uvcvideo 2-5.2:1.1: 
Failed to set UVC probe control : -32 (exp. 26).
Sep 20 13:23:19 freedom kernel: [   25.884358] uvcvideo 1-5.2:1.1: 
Failed to set UVC probe control : -32 (exp. 26).
Sep 20 14:24:14 freedom kernel: [   25.312379] uvcvideo 2-5.2:1.1: 
Failed to set UVC probe control : -32 (exp. 26).
Sep 20 14:47:27 freedom kernel: [   25.352905] uvcvideo 2-5.2:1.1: 
Failed to set UVC probe control : -32 (exp. 26).
Sep 20 15:19:44 freedom kernel: [   25.297893] uvcvideo 2-5.2:1.1: 
Failed to set UVC probe control : -32 (exp. 26).


Hopefully this helps.  Please mail me if you for more information.  I 
have changed my .config and set

# CONFIG_DEBUG_KERNEL_DC is not set

I am attempting to build 6.11.0.

Thanks,

Bob


On 2024-09-20 17:34, Alex Hung wrote:
>
>
> On 2024-09-20 17:00, Dr. David Alan Gilbert wrote:
>> * Bob Gill (gillb5@telus.net) wrote:
>>> Hello.  Kernel 6.11.0 crashes.  6.10.0 builds.  Al Viro and Dr. 
>>> David Alan
>>> Gilbert have been helpful, and asked that I
>>>
>>> post a git bisect log.  The last log step seems odd, but the second 
>>> last
>>> step "Remove useless function call" might be what broke.
>>
>> Thank you for doing this!
>>
>> My reading is that's fine, I think the next one:
>>
>> tree: git bisect bad
>> [a171cce57792b0a6206d532050179a381ad74f8f] drm/amd/display: Check and 
>> log for
>> function error codes
>>
>> or the one after it is the culprit?
>>
>> Adding the two Alex's from AMD back onto the thread.
>> (Also added the [REGRESSION] marker the notes tell us to add)
>
> The commit triggers debugger in case of in case of errors.
>
> Is the config CONFIG_DEBUG_KERNEL_DC (Enable kgdb break in DC) enabled 
> in .config, i.e. can you check "grep CONFIG_DEBUG_KERNEL_DC .config"?
>
> If so, can you also try to disable it and check whether you can see 
> error messages "Failed to execute VBIOS command table" in kernel log?
>
>>
>>> My hardware is old corei7 quad core/8 thread Tylersberg/Nehalem with 
>>> an AMD
>>> RX 6500XT.  That's the odd combination.
>>>
>>> Thanks in advance,
>>
>> Thanks again for the bisect.
>>
>> Dave
>>
>>> Bob
>>>
>>> Config:  (.config)
>>> /data/kernel/bobtest6.10-64
>>>
>>> Build line: (last command tells me the job is finished)
>>> make menuconfig && make -j $(nproc) && make modules && make 
>>> modules_install
>>> && make install && /data/music/pl.sh
>>>
>>> Rule 1: Do not modify ANYTHING in the source tree
>>>
>>> git bisect start
>>> git bisect bad
>>> git bisect good v6.10
>>>
>>> Bisecting: 11273 revisions left to test after this (roughly 14 steps)
>>> [2c9b3512402ed192d1f43f4531fb5da947e72bd0] Merge tag 'for-linus' of
>>> git://git.kernel.org/pub/scm/virt/kvm/kvm
>>>
>>> latest kernel:
>>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>>> 6.10.0+
>>>
>>> RESULT:  boot 6.10.0+ fails
>>>           screen black for more than 2 minutes,
>>>           (caps lock key unresponsive, reset, power
>>>           buttons on computer case do nothing).  Reset with power bar.
>>>
>>> tree: git bisect bad
>>> Bisecting: 5677 revisions left to test after this (roughly 13 steps)
>>> [280e36f0d5b997173d014c07484c03a7f7750668] nsfs: use cleanup guard
>>>
>>> latest kernel:
>>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>>> 6.10.0+
>>>
>>> RESULT: boot 6.10.0+ successful
>>> tree: git bisect good
>>> Bisecting: 2855 revisions left to test after this (roughly 12 steps)
>>> [dde1a0e1625c08cf4f958348a83434b2ddecf449] Merge tag 
>>> 'x86-percpu-2024-07-17'
>>> of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>>>
>>> latest kernel:
>>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>>> 6.10.0+
>>>
>>> RESULT: boot 6.10.0+ fails
>>>          screen black for more than 2 minutes,
>>>          (caps lock key unresponsive, reset, power
>>>          buttons on computer case do nothing).  Reset with power bar.
>>>
>>> tree: git bisect bad
>>> Bisecting: 1478 revisions left to test after this (roughly 11 steps)
>>> [32a120f52a4c0121bca8f2328d4680d283693d60] drm/i915/mtl: Skip PLL state
>>> verification in TBT mode
>>>
>>> latest kernel:
>>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>>> 6.10.0-rc3+
>>>
>>> RESULT: boot 6.10.0-rc3+ successful
>>> tree: git bisect good
>>> Bisecting: 739 revisions left to test after this (roughly 10 steps)
>>> [b6a343df46d69070a7073405e470e6348180ea34] drm/amdgpu: initialize GC IP
>>> v11.5.2
>>>
>>> latest kernel:
>>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>>> 6.10.0-rc3+
>>>
>>> RESULT: boot 6.10.0-rc3+ fails
>>>          screen black for more than 2 minutes,
>>>          (caps lock key unresponsive, reset, power
>>>          buttons on computer case do nothing).  Reset with power bar.
>>>
>>> tree: git bisect bad
>>> Bisecting: 369 revisions left to test after this (roughly 9 steps)
>>> [cf1d06ac53a15b83c0a63225606cfe175e33a8a0] accel/ivpu: Increase 
>>> autosuspend
>>> delay to 100ms on 40xx
>>>
>>> latest kernel:
>>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>>> 6.10.0-rc1+
>>>
>>> RESULT: boot 6.10.0-rc1+ successful
>>> tree: git bisect good
>>> Bisecting: 184 revisions left to test after this (roughly 8 steps)
>>> [0ca9f757a0e27a076395ec1b2002661bcf5c25e8] drm/amd/pm: powerplay: Add
>>> `__counted_by` attribute for flexible arrays
>>>
>>> latest kernel:
>>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>>> 6.9.0-rc5+
>>>
>>> RESULT: boot 6.9.0-rc5+ successful
>>> tree: git bisect good
>>> Bisecting: 92 revisions left to test after this (roughly 7 steps)
>>> [9862ef7bae47b9292a38a0a1b30bff7f56d7815b] drm/amd/display: Use 
>>> periodic
>>> detection for ipx/headless
>>>
>>> latest kernel:
>>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>>> 6.10.0-rc3+
>>>
>>> RESULT: boot 6.10.0-rc3+ fails
>>>          screen black for more than 2 minutes,
>>>          (caps lock key unresponsive, reset, power
>>>          buttons on computer case do nothing).  Reset with power bar.
>>>
>>> tree: git bisect bad
>>> Bisecting: 44 revisions left to test after this (roughly 6 steps)
>>> [a78313bb206e0c456a989f380c4cbd8af8af7c76] Merge tag
>>> 'drm-intel-gt-next-2024-06-12' of
>>> https://gitlab.freedesktop.org/drm/i915/kernel into drm-next
>>>
>>> latest kernel:
>>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>>> 6.10.0-rc3+
>>>
>>> RESULT: boot 6.10.0-rc3+ successful
>>> tree: git bisect good
>>> Bisecting: 22 revisions left to test after this (roughly 5 steps)
>>> [51dbe0239b1fc7c435867ce28e5eb4394b6641e1] drm/amd/display: Fix 
>>> cursor size
>>> issues
>>>
>>> latest kernel:
>>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>>> 6.10.0-rc3+
>>>
>>> RESULT: boot 6.10.0-rc3+ successful
>>> tree: git bisect good
>>> Bisecting: 11 revisions left to test after this (roughly 4 steps)
>>> [871512e36f9c1c2cb4e62eb860ca0438800e4d63] drm/amd/display: Add 
>>> workaround
>>> to restrict max frac urgent for DPM0
>>>
>>> latest kernel:
>>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>>> 6.10.0-rc3+
>>>
>>> RESULT: boot 6.10.0-rc3+ fails
>>>          screen black for more than 2 minutes,
>>>          (caps lock key unresponsive, reset, power
>>>          buttons on computer case do nothing).  Reset with power bar.
>>>
>>> tree: git bisect bad
>>> Bisecting: 5 revisions left to test after this (roughly 3 steps)
>>> [5d93060d430b359e16e7c555c8f151ead1ac614b] drm/amd/display: Check HDCP
>>> returned status
>>>
>>> latest kernel:
>>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>>> 6.10.0-rc3+
>>>
>>> RESULT: boot 6.10.0-rc3+ fails
>>>          screen black for more than 2 minutes,
>>>          (caps lock key unresponsive, reset, power
>>>          buttons on computer case do nothing).  Reset with power bar.
>>>
>>> tree: git bisect bad
>>> Bisecting: 2 revisions left to test after this (roughly 1 step)
>>> [e094992bd1caa1fbd42221c7c305fc3b54172b5c] drm/amd/display: Remove 
>>> useless
>>> function call
>>>
>>> latest kernel:
>>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>>> 6.10.0-rc3+
>>>
>>> RESULT: boot 6.10.0-rc3+ successful
>>>
>>> tree: git bisect good
>>> [2c2ee1d1329881d8e6bb23c3b9f3b41df8a8055c] drm/amd/display: Check 
>>> and log
>>> for function error codes
>>>
>>> latest kernel:
>>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>>> 6.10.0-rc3+
>>>
>>> RESULT: boot 6.10.0-rc3+ fails
>>>          screen black for more than 2 minutes,
>>>          (caps lock key unresponsive, reset, power
>>>          buttons on computer case do nothing).  Reset with power bar.
>>>
>>> tree: git bisect bad
>>> [a171cce57792b0a6206d532050179a381ad74f8f] drm/amd/display: Check 
>>> and log
>>> for function error codes
>>>
>>>
>>>
>>>
>>>
>>>

