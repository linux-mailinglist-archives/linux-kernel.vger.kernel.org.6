Return-Path: <linux-kernel+bounces-240738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF4F9271E7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 10:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A0A4B22C3B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 08:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465DB1A4F03;
	Thu,  4 Jul 2024 08:40:40 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA35918FC7F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 08:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720082439; cv=none; b=R/HwbVP4oLjJ2c9ZvKo5hOhsAwJdJTiRxA/saxoVfuAc4aft2ld/7AGbJ1IX/8pedkbO4Z1dKELWE0mfXcRp4gn9uPvwfCVeuxDOvmPZCkbBIGT3cZpaZHun8ld1fqnpOs+qQiYHqBBd0QLvF0E+/8rj45Vx3Mgp124gCUVOUrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720082439; c=relaxed/simple;
	bh=rH9yh2NtbowO0YmOdSirehkCnWA9tDwwrd5j5ZH4R14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xtw1OyqllpAaM+vBrdz5SbkJ+1E/ghfABkSep/4T7ulzFn2etzgc444dGWHNR7XgVnQQCw8bT44puxskmCtufSn5bash4EghKtmpoKquFyCwW4NG3Q6sspI9uwPFZMvsy44OzbaTDn1K2SHKyejm2tmij51PU7ViCFO1zD0LbtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3679483091aso50119f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 01:40:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720082436; x=1720687236;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IYBlTdrZUgjISIJYMq6+MlcUs6AYSjd/8QIqfvR08SA=;
        b=q6JZI38JD8X2pIm5nscn5TErjT7e2i9yl8q3+cqWZbp9hEWdaWo0digG+QbFia7qTv
         qhWjR/sSN0Uv+HX2H+tuSsfO7VjLhbGeuRqL+aKX9g2iKJjHvxvxinrNDE9LJcBSmkUm
         04B5TlbkC+XNVugbSGaXwJ1gWjLSwA/H0c98aADiv0aPLmLhU6pjUryUWX4La74gPhNN
         Aw3xCU809un74SMvz+DliggmGjJ0e21TCQ264Y3KbpAld3QiaLC7stoeU8s12TIH3ApG
         QM4DucxcESCrOYOuimkc/mgCybw6JZPcTWdc9HRE5RF2AqjSce45nfCadKgyR3xqJ3wX
         KrAg==
X-Forwarded-Encrypted: i=1; AJvYcCVFuan6nwU6ZCYarzv4/kPOGCh7OEMi2Y9BOfERSZXPc0FbtRSMxSJZGtuuX1wMFmuBCHbjkiJrlc39A0NNpSfAd8T1RU/0AhrJw6kv
X-Gm-Message-State: AOJu0YzeudVh7Y7f+ww/I9nmNsTFsSjZHg6v4QidyTf8hM9C2tLjx3mO
	cem+fr7Ah/HA+4x5HwMhg4m3WYohfXzhA5P7Hgok1kmu7Io97mHG
X-Google-Smtp-Source: AGHT+IHsNp/mibsJMIyFOSzIjqkf8UrySPWlefn9Vt+BC0D77gnb4DLjkadNaWisWIAQMCp6y0StNw==
X-Received: by 2002:a05:600c:510d:b0:426:4920:2842 with SMTP id 5b1f17b1804b1-4264a45f67amr7138385e9.4.1720082435610;
        Thu, 04 Jul 2024 01:40:35 -0700 (PDT)
Received: from [10.100.102.67] (85.65.198.251.dynamic.barak-online.net. [85.65.198.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1dd902sm14956595e9.12.2024.07.04.01.40.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 01:40:35 -0700 (PDT)
Message-ID: <2797ce03-a52a-459a-a1a1-7591233f51cd@grimberg.me>
Date: Thu, 4 Jul 2024 11:40:33 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] nvmet: support polling task for RDMA and TCP
To: Ping Gan <jacky_gam_2001@163.com>, hch@lst.de, kch@nvidia.com,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: ping.gan@dell.com
References: <12556163-9efa-461f-826d-264350f4ca58@grimberg.me>
 <20240704081015.63584-1-jacky_gam_2001@163.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240704081015.63584-1-jacky_gam_2001@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/4/24 11:10, Ping Gan wrote:
>> On 02/07/2024 13:02, Ping Gan wrote:
>>>> On 01/07/2024 10:42, Ping Gan wrote:
>>>>>> Hey Ping Gan,
>>>>>>
>>>>>>
>>>>>> On 26/06/2024 11:28, Ping Gan wrote:
>>>>>>> When running nvmf on SMP platform, current nvme target's RDMA and
>>>>>>> TCP use kworker to handle IO. But if there is other high workload
>>>>>>> in the system(eg: on kubernetes), the competition between the
>>>>>>> kworker and other workload is very radical. And since the kworker
>>>>>>> is scheduled by OS randomly, it's difficult to control OS
>>>>>>> resource
>>>>>>> and also tune the performance. If target support to use delicated
>>>>>>> polling task to handle IO, it's useful to control OS resource and
>>>>>>> gain good performance. So it makes sense to add polling task in
>>>>>>> rdma-rdma and rdma-tcp modules.
>>>>>> This is NOT the way to go here.
>>>>>>
>>>>>> Both rdma and tcp are driven from workqueue context, which are
>>>>>> bound
>>>>>> workqueues.
>>>>>>
>>>>>> So there are two ways to go here:
>>>>>> 1. Add generic port cpuset and use that to direct traffic to the
>>>>>> appropriate set of cores
>>>>>> (i.e. select an appropriate comp_vector for rdma and add an
>>>>>> appropriate
>>>>>> steering rule
>>>>>> for tcp).
>>>>>> 2. Add options to rdma/tcp to use UNBOUND workqueues, and allow
>>>>>> users
>>>>>> to
>>>>>> control
>>>>>> these UNBOUND workqueues cpumask via sysfs.
>>>>>>
>>>>>> (2) will not control interrupts to steer to other workloads cpus,
>>>>>> but
>>>>>> the handlers may
>>>>>> run on a set of dedicated cpus.
>>>>>>
>>>>>> (1) is a better solution, but harder to implement.
>>>>>>
>>>>>> You also should look into nvmet-fc as well (and nvmet-loop for
>>>>>> that
>>>>>> matter).
>>>>> hi Sagi Grimberg,
>>>>> Thanks for your reply, actually we had tried the first advice you
>>>>> suggested, but we found the performance was poor when using spdk
>>>>> as initiator.
>>>> I suggest that you focus on that instead of what you proposed.
>>>> What is the source of your poor performance?
>>> Before these patches, we had used linux's RPS to forward the packets
>>> to a fixed cpu set for nvmet-tcp. But when did that we can still not
>>> cancel the competition between softirq and workqueue since nvme
>>> target's
>>> kworker cpu core bind on socket's cpu which is from skb. Besides that
>>> we found workqueue's wait latency was very high even we enabled
>>> polling
>>> on nvmet-tcp by module parameter idle_poll_period_usecs. So when
>>> initiator
>>> is polling mode, the target of workqueue is the bottleneck. Below is
>>> work's wait latency trace log of our test on our cluster(per node
>>> uses
>>> 4 numas 96 cores, 192G memory, one dual ports mellanox CX4LX(25Gbps X
>>> 2)
>>> ethernet adapter and randrw 1M IO size) by RPS to 6 cpu cores. And
>>> system's CPU and memory were used about 80%.
>> I'd try a simple unbound CPU case, steer packets to say cores [0-5]
>> and
>> assign
>> the cpumask of the unbound workqueue to cores [6-11].
> Okay, thanks for your guide.
>
>>> ogden-brown:~ #/usr/share/bcc/tools/wqlat -T -w nvmet_tcp_wq 1 2
>>> 01:06:59
>>>        usecs               : count     distribution
>>>            0 -> 1          : 0        |                              |
>>>            2 -> 3          : 0        |                              |
>>>            4 -> 7          : 0        |                              |
>>>            8 -> 15         : 3        |                              |
>>>           16 -> 31         : 10       |                              |
>>>           32 -> 63         : 3        |                              |
>>>           64 -> 127        : 2        |                              |
>>>          128 -> 255        : 0        |                              |
>>>          256 -> 511        : 5        |                              |
>>>          512 -> 1023       : 12       |                              |
>>>         1024 -> 2047       : 26       |*                             |
>>>         2048 -> 4095       : 34       |*                             |
>>>         4096 -> 8191       : 350      |************                  |
>>>         8192 -> 16383      : 625      |******************************|
>>>        16384 -> 32767      : 244      |*********                     |
>>>        32768 -> 65535      : 39       |*                             |
>>>
>>> 01:07:00
>>>        usecs               : count     distribution
>>>            0 -> 1          : 1        |                              |
>>>            2 -> 3          : 0        |                              |
>>>            4 -> 7          : 4        |                              |
>>>            8 -> 15         : 3        |                              |
>>>           16 -> 31         : 8        |                              |
>>>           32 -> 63         : 10       |                              |
>>>           64 -> 127        : 3        |                              |
>>>          128 -> 255        : 6        |                              |
>>>          256 -> 511        : 8        |                              |
>>>          512 -> 1023       : 20       |*                             |
>>>         1024 -> 2047       : 19       |*                             |
>>>         2048 -> 4095       : 57       |**                            |
>>>         4096 -> 8191       : 325      |****************              |
>>>         8192 -> 16383      : 647      |******************************|
>>>        16384 -> 32767      : 228      |***********                   |
>>>        32768 -> 65535      : 43       |**                            |
>>>        65536 -> 131071     : 1        |                              |
>>>
>>> And the bandwidth of a node is only 3100MB. While we used the patch
>>> and enable 6 polling task, the bandwidth can be 4000MB. It's a good
>>> improvement.
>> I think you will see similar performance with unbound workqueue and
>> rps.
> Yes, I remodified the nvmet-tcp/nvmet-rdma code for supporting unbound
> workqueue, and in same prerequisites of above to run test, and compared
> the result of unbound workqueue and polling mode task. And I got a good
> performance for unbound workqueue. For unbound workqueue TCP we got
> 3850M/node, it's almost equal to polling task. And also tested
> nvmet-rdma
> we get 5100M/node for unbound workqueue RDMA versus 5600M for polling
> task,
> seems the diff is very small. Anyway, your advice is good.

I'm a bit surprised that you see ~10% delta here. I would look into what 
is the root-cause of
this difference. If indeed the load is high, the overhead of the 
workqueue mgmt should be
negligible. I'm assuming you used IB_POLL_UNBOUND_WORKQUEUE ?



>   Do you think
> we
> should submit the unbound workqueue patches for nvmet-tcp and nvmet-rdma
> to upstream nvmet?

For nvmet-tcp, I think there is merit to split socket processing from 
napi context. For nvmet-rdma
I think the only difference is if you have multiple CQs assigned with 
the same comp_vector.

How many queues do you have in your test?

> BTW I have another question: Will nvmet of upstream have the plan to
> support
> polling queue when doing submit_bio in future?

No plans that I know of. Don't have a coherent idea of how that would work.

