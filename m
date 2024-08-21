Return-Path: <linux-kernel+bounces-295728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0068595A0D9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 17:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79B5A1F231D5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2A3130A73;
	Wed, 21 Aug 2024 15:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="3HmBCXzK"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646FB4D8CB
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 15:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724252658; cv=none; b=TMqg3rW9pz/sfR8nxLYBCWz8iiGxoki2RdOIxgREq+NjLJPTsDV75M/RoLCJ3HyF/jkO1RnFE94M0hgxon7oonU02VrYDgkDk5gUF/GtIT5sie4H0OfzA/5h0UQEsWir6wTMSv8sKf0oMtd9Qlz67Obu6sQnqzhuekpy0R+cEFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724252658; c=relaxed/simple;
	bh=kQAhxxciXsK73k7t1K/XvfDm2xyETB4CeAAPGg56gvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q5ko0pvBfy+kpwb7WMOk3q/IzUmalwBZwt5afQwOJB08M39YDYiABlv4/96DQQ7p+a0SXBut8l2lwpsPwxVXIDjzvhVGpOdG6j9i+AWZdFW/vVVEN037m6wqFkaIsfEHtPY8CPPs2T3TB0XJ582ldENmL9M2VoLZCXZQnaaLVLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=3HmBCXzK; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-39d311d8091so20801115ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 08:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1724252654; x=1724857454; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PrMKua0VqfdV1DUxMUuflf+WJjVJdBv6j+j/4+JbR1U=;
        b=3HmBCXzKhllTQHTCPJt+XLrneXkiGH3NrIl6ooaWQ18D/z5fOQa83wCcl0FylsVzWM
         OJh7cNu0uAIFDRQkiyfWlMaRDwKuMd2gMdyEFtGQsHHhPpC3HjEHqIHDo5qujbQCWHDU
         gDRMTcRRJSs3t9BX8BUGvhj+gfa3dGJuS4lgaw1io5vtLc3i6fUvL06evuOOozA2NFHN
         hTsJY/FvrKmuOIO3yp7Mt7/IUvcDcU/2E4skDULCiei3vSgaa211xxvg6EZCsaprPvPy
         lkETXW4eNXoEJqCshjo7kpIRzbSY7U3GQLY8J8jOVPMb/UHIn/FUzfD6eHwZnLjOSMdq
         iKzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724252654; x=1724857454;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PrMKua0VqfdV1DUxMUuflf+WJjVJdBv6j+j/4+JbR1U=;
        b=US4u8rO5RItBKgg1SUG/1IexRJQ/J8zckQVFpYL6klKJ0CGk2NpOUh0xbdEBSGpO2l
         dKmf9nEpnVwshP7EggTgFUaEk1J5LHYl1bWgcZ+K5ix80y5awu/K3wTT77VbX5eFFAyD
         t5D11+V69SX/J3v62lTNPUZIiUIovqnenWyhLgqW3vS3RNjGDfwFxZUHqKFoslXNIv8c
         JWbCpIMLnyFEf954HbjE6WzWcqytkQAsAq88iJmhcZvwLbK1qsTvw0XvJtOE5hRi1c06
         km8KVU+Unpi15QTYHNUJouzMY31/5EWZcYEqKYgSFpaqP4X2RNoVpNrjeHPOV2FXL3IJ
         mbIA==
X-Forwarded-Encrypted: i=1; AJvYcCVQe2MQ1GkRvdEGgdvXIgCg3iV+dVHriJSJ2aq68fr/WsaWquR3CgfSbCI/wo8lbCTkf03skuX9KZ/bJlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHTadffO/2XweuTndGxCZJvdGf9uWb3AyMyZOl5zU6e6wPXPSX
	ckL34LypmATnTidTlP8M5XXC6WtZmbedR+s+DhUUrr37bSfiMl+mdnPcUiZLxiY=
X-Google-Smtp-Source: AGHT+IEeSJu9YGEKFWHZ9j3oHNxcL0ihhp4xqYgEwuf42nHsZyiOfOluIympR7UcqvwATLFSx9AY8w==
X-Received: by 2002:a05:6e02:1d95:b0:375:c394:568b with SMTP id e9e14a558f8ab-39d6c3b0a06mr24212555ab.21.1724252654237;
        Wed, 21 Aug 2024 08:04:14 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ccd6e7d97dsm4652309173.26.2024.08.21.08.04.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 08:04:13 -0700 (PDT)
Message-ID: <9a0f2192-b897-4952-b4ea-7fe229f33001@kernel.dk>
Date: Wed, 21 Aug 2024 09:04:12 -0600
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
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <c8cd6339-c168-4409-8cc4-e85e7ad92914@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/21/24 8:54 AM, Christian Loehle wrote:
> On 8/19/24 16:39, Jens Axboe wrote:
>> Hi,
>>
>> This is v6 of the patchset where the current in_iowait state is split
>> into two parts:
>>
>> 1) The "task is sleeping waiting on IO", and would like cpufreq goodness
>>    in terms of sleep and wakeup latencies.
>> 2) The above, and also accounted as such in the iowait stats.
>>
>> The current ->in_iowait covers both, this series splits it into two types
>> of state so that each can be controlled seperately.
> 
> Hi Jens,
> I wanted to give a brief update on where I think we're at in terms
> of iowait behavior regarding cpuidle and cpufreq.
> I'm still working on getting both removed, given the discussions had
> on the list [0] and at OSPM [1] this seems realistic and the best way
> forward IMO.
> That would then naturally make this series and the iowait workaround in
> io_uring/io_uring.c unnecessary.
> 
> 1. For cpuidle:
> Main issue with relying on nr_iowaiters is that there is no guarantee
> whatsoever that these tasks will wakeup where they went to sleep so if
> we can achieve the same throughput without nr_iowaiters it shouldn't
> be relevant.
> I spent quite some time in fixing teo [2], because untangling nr_iowaiters
> from menu seems hard, essentially nobody has worked on menu seriously for
> a while now. Thus the plan here is to replace menu by teo eventually.
> For your io_uring workloads I see throughput on par for teo (doesn't rely
> on iowait) and menu.
> 
> # echo teo > /sys/devices/system/cpu/cpuidle/current_governor
> #  ./io_uring -r 5 -X0 -d 1 -s 1 -c 1 -p 0 -S 1 -R 0 /dev/nvme0n1 
> submitter=0, tid=206, file=/dev/nvme0n1, node=-1
> polled=0, fixedbufs=1/0, register_files=1, buffered=0, QD=1
> Engine=preadv2
> IOPS=22500, BW=87MiB/s, IOS/call=0/0
> IOPS=21916, BW=85MiB/s, IOS/call=1/0
> IOPS=21774, BW=85MiB/s, IOS/call=1/0
> IOPS=22467, BW=87MiB/s, IOS/call=1/0
> Exiting on timeout
> Maximum IOPS=22500
> # echo menu > /sys/devices/system/cpu/cpuidle/current_governor
> [  178.754571] cpuidle: using governor menu
> #  ./io_uring -r 5 -X0 -d 1 -s 1 -c 1 -p 0 -S 1 -R 0 /dev/nvme0n1 
> submitter=0, tid=209, file=/dev/nvme0n1, node=-1
> polled=0, fixedbufs=1/0, register_files=1, buffered=0, QD=1
> Engine=preadv2
> IOPS=21452, BW=83MiB/s, IOS/call=0/0
> IOPS=21778, BW=85MiB/s, IOS/call=1/0
> IOPS=21120, BW=82MiB/s, IOS/call=1/0
> IOPS=20903, BW=81MiB/s, IOS/call=1/0
> Exiting on timeout
> Maximum IOPS=21778
> 
> Please do give it a try for yourself as well!
> 
> 2. For cpufreq:
> Main issue for IO-bound workloads with iowait boosting is we're punishing
> the 'good' workloads (that don't have iowait sleeps in their throughput-critical
> part, which is already bad because of the scheduling overhead induced) by
> making them energy-inefficient to make synthetic benchmarks happy.
> A study of more realistic workloads show that they don't suffer from a problem
> of building up utilization, not util_est anyway, so they don't actually benefit
> from a cpufreq boost.
> This leads me to the conclusion that cpufreq iowait boosting can be scrapped
> altogether if we accept some degradation of benchmarks like
> ./io_uring -r 5 -X0 -d 1 -s 1 -c 1 -p 0 -S 1 -R 0 /dev/nvme0n1
> or
> fio --name=fio --rw=randread --bs=4k --runtime=5 --time_based --filename=/dev/nvme0n1 --iodepth=1 --numjobs=1
> (non-io_uring) for that matter.

The original iowait addition came because a big regression was seen
compared to not setting iowait, it was around 20% iirc. That's big, and
not in the realm of "some degradation" that will be acceptable. And that
will largely depend on the system being used. On some systems, it'll be
less, and on some it'll be more.

> For io_uring where the expected case is probably not single-threaded
> sync IO (or iodepth=1) the cpufreq iowait boost is just hurting
> use-cases by pushing it to less efficient frequencies that might not
> be needed.

People do all sorts of things, and sync (or low queue depth) IO is
certainly one of the use cases. In fact that's where the above report
came from, on the postgres aio side.

> I know you want your problem (io_uring showing up as 100% busy even
> though it's just sleeping) to be solved like yesterday and my opinion
> on a future timeline might not be enough to convince you of much. I
> wanted to share it anyway. I don't see an issue with the actual code
> you're proposing, but it does feel like a step in the wrong direction
> to me.

As mentioned in my original reply, I view this as entirely orthogonal,
and while I appreciate your efforts in this area, I'm a little tired of
this being brought up as a gatekeeping metric when it's not there.

If we can eliminate iowait for boosting down the line, then I'm all for
it. But this has now been pending for > 6 months and I don't think it's
far to keep stringing this along on a future promise. This isn't a lot
of code and it solves the issue for now, if the code will get removed
down the line as not needed, then that's certainly fine. For now, we
need it.

-- 
Jens Axboe


