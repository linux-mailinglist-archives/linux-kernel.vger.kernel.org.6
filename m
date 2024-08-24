Return-Path: <linux-kernel+bounces-300091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F042795DEB2
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 17:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 149A21C20F2F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 15:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D960176AC7;
	Sat, 24 Aug 2024 15:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="upDXeNmc"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D619475
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 15:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724513652; cv=none; b=fAtaqHuFw7WxwSkT0ywhMHfFKiEUGbrtXvjPqDZY9XV1smh0LfPQfe2I/vp/8TX9Kg2+aBii3h0H+qV8S0UdWh/DYNHzIc1tD7d14lBq93AdwrLLHKJPpZKcPBHRyi0kQlqePrdlP+tYyvIpxeXlNq5zWFgH3OgX2wmuo4Ae/w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724513652; c=relaxed/simple;
	bh=LpGFte/bJLu2fp5DnAjNFeoNKKu0Fz8JF3hNncqrBDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=agMXnyMkTfAhLR4vkIqAPe5wlA2LN7r7LadHkollAW4Jq5roTC9Mk6HwJ+eSoHAU18uYPFeA672ygp/S6SU93jWDLa8Fx3rkhtXUAAH1Wt/37xazdg1sKnzqInp1A7/kMwAZDRMhoXHySC+Cli2Ay+VxXbgCpl4CpfVgooSFx/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=upDXeNmc; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7143185edf2so2450559b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 08:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1724513648; x=1725118448; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZSXIKoihoddogN25WBIjDUpnPHwkybMIhSvoiXgO/zQ=;
        b=upDXeNmcAwsj4EcxqaTctkfU6TlgzdWZGiGQRQPP5uIf28wmlR7C11FaaIGOocKM0e
         fOiSDUjV+cBnIf1F0UxSftmUQ9r/IE+2OkmRiYnFS9rnxwutY2GCiMVVZCKL+ICsMMgr
         bOnGrmWj20ZQ9kd8VblO4nd+c6ifvMQb8pP2TRqPr0b2pshEuU9nI0zZ8wnKz8Fs5qaG
         0KMKQ7SrPLXThH1tL/OcgsNRc00t/ZLEv3zZrRAPTWEY4yQJbXZMZn944nKb/caF/I5w
         nu5Sb7PAmgb68fawAsBP7j+UiTcJauBAdLDq1uWWn/WPxX01/1HU+Ur50RhKzChatLdo
         J72A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724513648; x=1725118448;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZSXIKoihoddogN25WBIjDUpnPHwkybMIhSvoiXgO/zQ=;
        b=CKeJvuhxwqZMcLPheKwGNEil0kajB4ax0E2FFaceh1w2w5zifbZUlOdQNc3cFjYoOq
         vRn01bRIenzd3BAjduTxrlWp2zNpdoEfyUsAmQd7+k6mEpCyAxbWmMkar2PyDP58QdXZ
         wtJDYeEjyUzjf/RcfymT/c6+YAfCiHQdQitK9/FsiKwClq/y/Wev8xWOMN/06Veq0q8h
         9u1ky6EXFhey1WyeDpIkeTuJGBV8fM/LVZok4/DRDGU3ZeX3Gg0xjkobNlHkEsRPkNqH
         5GuUfTN5WVY/Hogto7dkJ0w8TLEAI0zHF+UP18eWjDb/NEIB/hY5qwAXpnGjszfF9PfK
         iiGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHnASGBL+nCDUOK5sFuwcfZZaX44SvI1zLHpVYdSpj7WF4BISiWUQxf2Dja2DUcoGM+aCmRRRtLsNhjkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyesonbNvvtGtE1qQedB18k+EvQgVbg/MdZpyM9Mvsgch+Q/UaU
	doAH/fTIvFNq7hl2ssp3UsZqgBgWnvAH21WHD5Ks5cA/omFVRkeLuQcsM7T0aEc=
X-Google-Smtp-Source: AGHT+IHikL7Sn4gbj154Bj3xA/2dv1RdXHysRWdUOFi6m4aHuzN4r5j/Vkh9on6X0yprxPvSzenQGg==
X-Received: by 2002:a05:6a00:3d54:b0:70d:34aa:6d57 with SMTP id d2e1a72fcca58-71445cbd264mr6932475b3a.4.1724513647459;
        Sat, 24 Aug 2024 08:34:07 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143432eda2sm4630200b3a.187.2024.08.24.08.34.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Aug 2024 08:34:06 -0700 (PDT)
Message-ID: <0524d3fa-c70e-45a5-96e1-317431f6ce8d@kernel.dk>
Date: Sat, 24 Aug 2024 09:34:05 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET v6 0/4] Split iowait into two states
To: Christian Loehle <christian.loehle@arm.com>, linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, tglx@linutronix.de,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Qais Yousef <qyousef@layalina.io>, "Rafael J. Wysocki" <rafael@kernel.org>
References: <20240819154259.215504-1-axboe@kernel.dk>
 <c8cd6339-c168-4409-8cc4-e85e7ad92914@arm.com>
 <9a0f2192-b897-4952-b4ea-7fe229f33001@kernel.dk>
 <5dd66e38-2b00-4b89-8b8c-cc25ad39dcb8@arm.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <5dd66e38-2b00-4b89-8b8c-cc25ad39dcb8@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/21/24 9:57 AM, Christian Loehle wrote:
> On 8/21/24 16:04, Jens Axboe wrote:
>> On 8/21/24 8:54 AM, Christian Loehle wrote:
>>> On 8/19/24 16:39, Jens Axboe wrote:
>>>> Hi,
>>>>
>>>> This is v6 of the patchset where the current in_iowait state is split
>>>> into two parts:
>>>>
>>>> 1) The "task is sleeping waiting on IO", and would like cpufreq goodness
>>>>    in terms of sleep and wakeup latencies.
>>>> 2) The above, and also accounted as such in the iowait stats.
>>>>
>>>> The current ->in_iowait covers both, this series splits it into two types
>>>> of state so that each can be controlled seperately.
>>>
>>> Hi Jens,
>>> I wanted to give a brief update on where I think we're at in terms
>>> of iowait behavior regarding cpuidle and cpufreq.
>>> I'm still working on getting both removed, given the discussions had
>>> on the list [0] and at OSPM [1] this seems realistic and the best way
>>> forward IMO.
>>> That would then naturally make this series and the iowait workaround in
>>> io_uring/io_uring.c unnecessary.
>>>
>>> 1. For cpuidle:
>>> Main issue with relying on nr_iowaiters is that there is no guarantee
>>> whatsoever that these tasks will wakeup where they went to sleep so if
>>> we can achieve the same throughput without nr_iowaiters it shouldn't
>>> be relevant.
>>> I spent quite some time in fixing teo [2], because untangling nr_iowaiters
>>> from menu seems hard, essentially nobody has worked on menu seriously for
>>> a while now. Thus the plan here is to replace menu by teo eventually.
>>> For your io_uring workloads I see throughput on par for teo (doesn't rely
>>> on iowait) and menu.
>>>
>>> # echo teo > /sys/devices/system/cpu/cpuidle/current_governor
>>> #  ./io_uring -r 5 -X0 -d 1 -s 1 -c 1 -p 0 -S 1 -R 0 /dev/nvme0n1 
>>> submitter=0, tid=206, file=/dev/nvme0n1, node=-1
>>> polled=0, fixedbufs=1/0, register_files=1, buffered=0, QD=1
>>> Engine=preadv2
>>> IOPS=22500, BW=87MiB/s, IOS/call=0/0
>>> IOPS=21916, BW=85MiB/s, IOS/call=1/0
>>> IOPS=21774, BW=85MiB/s, IOS/call=1/0
>>> IOPS=22467, BW=87MiB/s, IOS/call=1/0
>>> Exiting on timeout
>>> Maximum IOPS=22500
>>> # echo menu > /sys/devices/system/cpu/cpuidle/current_governor
>>> [  178.754571] cpuidle: using governor menu
>>> #  ./io_uring -r 5 -X0 -d 1 -s 1 -c 1 -p 0 -S 1 -R 0 /dev/nvme0n1 
>>> submitter=0, tid=209, file=/dev/nvme0n1, node=-1
>>> polled=0, fixedbufs=1/0, register_files=1, buffered=0, QD=1
>>> Engine=preadv2
>>> IOPS=21452, BW=83MiB/s, IOS/call=0/0
>>> IOPS=21778, BW=85MiB/s, IOS/call=1/0
>>> IOPS=21120, BW=82MiB/s, IOS/call=1/0
>>> IOPS=20903, BW=81MiB/s, IOS/call=1/0
>>> Exiting on timeout
>>> Maximum IOPS=21778
>>>
>>> Please do give it a try for yourself as well!
>>>
>>> 2. For cpufreq:
>>> Main issue for IO-bound workloads with iowait boosting is we're punishing
>>> the 'good' workloads (that don't have iowait sleeps in their throughput-critical
>>> part, which is already bad because of the scheduling overhead induced) by
>>> making them energy-inefficient to make synthetic benchmarks happy.
>>> A study of more realistic workloads show that they don't suffer from a problem
>>> of building up utilization, not util_est anyway, so they don't actually benefit
>>> from a cpufreq boost.
>>> This leads me to the conclusion that cpufreq iowait boosting can be scrapped
>>> altogether if we accept some degradation of benchmarks like
>>> ./io_uring -r 5 -X0 -d 1 -s 1 -c 1 -p 0 -S 1 -R 0 /dev/nvme0n1
>>> or
>>> fio --name=fio --rw=randread --bs=4k --runtime=5 --time_based --filename=/dev/nvme0n1 --iodepth=1 --numjobs=1
>>> (non-io_uring) for that matter.
>>
>> The original iowait addition came because a big regression was seen
>> compared to not setting iowait, it was around 20% iirc. That's big, and
>> not in the realm of "some degradation" that will be acceptable. And that
>> will largely depend on the system being used. On some systems, it'll be
>> less, and on some it'll be more.
> 
> We are also talking about power regressions of 1000% easily FWIW for
> e.g. fio --name=fio --rw=randread --bs=4k --runtime=10 --time_based
> --filename=/dev/nvme0n1 --iodepth=32 --numjobs=nr_cpus
> --ioengine=io_uring (without any throughput gain).

Oh I believe it, for some embeded or low power cpus. And it is on our
list, to make this selectable. Ideally what I think should happen is
that the application gives you a hint on how long it expects to sleep,
and we'll pass that on and let the lower layers decide what's the most
appropriate state to enter. The current iowait usage isn't very pretty
(in io_uring or otherwise, it's too coarse of a hint), but it's what we
have/had, and we needed it to solve a problem that would otherwise be a
regression on a much more common setup than really lower power devices.

>>> For io_uring where the expected case is probably not single-threaded
>>> sync IO (or iodepth=1) the cpufreq iowait boost is just hurting
>>> use-cases by pushing it to less efficient frequencies that might not
>>> be needed.
>>
>> People do all sorts of things, and sync (or low queue depth) IO is
>> certainly one of the use cases. In fact that's where the above report
>> came from, on the postgres aio side.
> 
> I have looked at that and (on the platforms I've tested) that was indeed
> from cpuidle FWIW. Moving away from menu did remedy this with the
> mainlined teo fixes.
> 
>>> I know you want your problem (io_uring showing up as 100% busy even
>>> though it's just sleeping) to be solved like yesterday and my opinion
>>> on a future timeline might not be enough to convince you of much. I
>>> wanted to share it anyway. I don't see an issue with the actual code
>>> you're proposing, but it does feel like a step in the wrong direction
>>> to me.
>>
>> As mentioned in my original reply, I view this as entirely orthogonal,
>> and while I appreciate your efforts in this area, I'm a little tired of
>> this being brought up as a gatekeeping metric when it's not there.
> 
> I can understand you being tired of me bringing this up, but I'm not
> gatekeeping this series, not intentionally anyway.

Well it does feel like that, because this orthogonal (imho) development
is being brought up as a means to not needing to do this. Not just this
posting, but past ones too. Meanwhile, I'd like this problem solved, and
this just adds noise to it as far as I'm concerned. It would be a lot
better to split those two discussions up.

>> If we can eliminate iowait for boosting down the line, then I'm all for
>> it. But this has now been pending for > 6 months and I don't think it's
>> far to keep stringing this along on a future promise. This isn't a lot
>> of code and it solves the issue for now, if the code will get removed
>> down the line as not needed, then that's certainly fine. For now, we
>> need it.
> 
> I'm fine with carrying a revert of the series along my patchset.

OK that's fine, and let's hope we end up in a place down the line that's
a lot better than the iowait on/off we have now, with guesswork based on
past behavior (iow, mostly wrong) on the other end on how long the we
expect to sleep. I'd certainly be all for that, I just don't want future
promises to stop fixing a real issue we have now. If this series goes
away down the line because we don't need it, I surely won't cry over it!

-- 
Jens Axboe


