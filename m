Return-Path: <linux-kernel+bounces-241942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2497B928198
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 07:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4911D1C2224A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 05:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7796413C833;
	Fri,  5 Jul 2024 05:59:31 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D705C13C3F9
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 05:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720159170; cv=none; b=YwtwA/zMchhCVgP0wmZBGHEIa9/zsJiNh0xu7GQCVfYTN1yKHcm2s5TGiF3OfSTHFzctpO0+6EwxY6vdnaZKRLvQ3T2jlr1JmhUSamId9odVGUTq0FjZrAExHXuYtcfjZxWQbgwcJSVZsMVnEBFhlGkTSps+ZPssTXrjwv+Tb6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720159170; c=relaxed/simple;
	bh=dTHLgU2RNE0+CLbtZUETbcxf1ngz2RWpTYpQQsJtiUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FEV8eKj9WNnv2BJtTf1vjLTbP+YjcR5s7xpjjnLQp7I0VYNuHHxvZjtGXc9bO3asLHd8LdeCxcKXiLpEXy3dHdVaZ9ZGkjElG0fntUFcQIfaT/zd2wtTzT//qqLqq7MQQrCL4IFXQUTvbKNcuJFWjyJ8BuxqtgvjCEfxbO9Ats0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-424a3d36c28so1304465e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 22:59:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720159167; x=1720763967;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qOFWQf+FmtssRjh9fb8oLKyhXKW8Q2mBHM5TAimpaAE=;
        b=HH0gF2l202F+YZAK9moAJ5NMwklowSV/6nKNy8oPUkyLd8joPZ4gZebHq2P7oAZX0t
         Vp07Oan0QQoRray13O69L+t5lprW6mlpmI++8IybmcSL7Ofyh7wdRtB11STRZnfJCCkG
         uH7CdgVDiYrAUkmm+8EBjNYDZWPxQSI1lY2Iku14uMDaoCjxpFSz49OLAsmVRTlt5Y+Y
         VLBMi0C/39r791VjiN8bZPCc1V1Gc92hGQPfuHBjX0qG3NTSqtMiSG9d3p2coYaLXyT7
         tEISvhbut36WLVM5upKIoreSqJdkUV0G5Z4/kWIuwpIWATcuKC6oEkIbK2G//qge6+5j
         rmmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXjSuvCXTHfxNzfw4wJfhJGEICfKuYqHQ5rn3MOi5IkPrcEKNDHfpnoad3sKzYFd0uh7ztFDxUuXBrwJDxBSia5ssNpipx9qVL7JLo
X-Gm-Message-State: AOJu0YxhD/wws7P6PK9FFyTe22UEPnM8NiH1cfAvQZ1P/DByEzcCUjJ9
	yRlCavmm94QBYHUL9cail/WktegaNdtLHxzbUKM/xK92m8l32X02
X-Google-Smtp-Source: AGHT+IGXBbXqpvxifA8CtOQixJf+StFGVkPBe/fheZZUEN6PENcSaXA4Y5d9M0PYPlfmJhXEKsXeZw==
X-Received: by 2002:a5d:5f84:0:b0:365:da7f:6c17 with SMTP id ffacd0b85a97d-3679de750fdmr2433985f8f.7.1720159166802;
        Thu, 04 Jul 2024 22:59:26 -0700 (PDT)
Received: from [10.100.102.67] (85.65.198.251.dynamic.barak-online.net. [85.65.198.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36788e37b53sm8459532f8f.45.2024.07.04.22.59.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 22:59:26 -0700 (PDT)
Message-ID: <61d73b28-c818-4a20-97b8-8a95b4c46c05@grimberg.me>
Date: Fri, 5 Jul 2024 08:59:24 +0300
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
References: <2797ce03-a52a-459a-a1a1-7591233f51cd@grimberg.me>
 <20240704103533.68118-1-jacky_gam_2001@163.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240704103533.68118-1-jacky_gam_2001@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/4/24 13:35, Ping Gan wrote:
>> On 7/4/24 11:10, Ping Gan wrote:
>>>> On 02/07/2024 13:02, Ping Gan wrote:
>>>>>> On 01/07/2024 10:42, Ping Gan wrote:
>>>>>>>> Hey Ping Gan,
>>>>>>>>
>>>>>>>>
>>>>>>>> On 26/06/2024 11:28, Ping Gan wrote:
>>>>>>>>> When running nvmf on SMP platform, current nvme target's RDMA
>>>>>>>>> and
>>>>>>>>> TCP use kworker to handle IO. But if there is other high
>>>>>>>>> workload
>>>>>>>>> in the system(eg: on kubernetes), the competition between the
>>>>>>>>> kworker and other workload is very radical. And since the
>>>>>>>>> kworker
>>>>>>>>> is scheduled by OS randomly, it's difficult to control OS
>>>>>>>>> resource
>>>>>>>>> and also tune the performance. If target support to use
>>>>>>>>> delicated
>>>>>>>>> polling task to handle IO, it's useful to control OS resource
>>>>>>>>> and
>>>>>>>>> gain good performance. So it makes sense to add polling task in
>>>>>>>>> rdma-rdma and rdma-tcp modules.
>>>>>>>> This is NOT the way to go here.
>>>>>>>>
>>>>>>>> Both rdma and tcp are driven from workqueue context, which are
>>>>>>>> bound
>>>>>>>> workqueues.
>>>>>>>>
>>>>>>>> So there are two ways to go here:
>>>>>>>> 1. Add generic port cpuset and use that to direct traffic to the
>>>>>>>> appropriate set of cores
>>>>>>>> (i.e. select an appropriate comp_vector for rdma and add an
>>>>>>>> appropriate
>>>>>>>> steering rule
>>>>>>>> for tcp).
>>>>>>>> 2. Add options to rdma/tcp to use UNBOUND workqueues, and allow
>>>>>>>> users
>>>>>>>> to
>>>>>>>> control
>>>>>>>> these UNBOUND workqueues cpumask via sysfs.
>>>>>>>>
>>>>>>>> (2) will not control interrupts to steer to other workloads
>>>>>>>> cpus,
>>>>>>>> but
>>>>>>>> the handlers may
>>>>>>>> run on a set of dedicated cpus.
>>>>>>>>
>>>>>>>> (1) is a better solution, but harder to implement.
>>>>>>>>
>>>>>>>> You also should look into nvmet-fc as well (and nvmet-loop for
>>>>>>>> that
>>>>>>>> matter).
>>>>>>> hi Sagi Grimberg,
>>>>>>> Thanks for your reply, actually we had tried the first advice you
>>>>>>> suggested, but we found the performance was poor when using spdk
>>>>>>> as initiator.
>>>>>> I suggest that you focus on that instead of what you proposed.
>>>>>> What is the source of your poor performance?
>>>>> Before these patches, we had used linux's RPS to forward the
>>>>> packets
>>>>> to a fixed cpu set for nvmet-tcp. But when did that we can still
>>>>> not
>>>>> cancel the competition between softirq and workqueue since nvme
>>>>> target's
>>>>> kworker cpu core bind on socket's cpu which is from skb. Besides
>>>>> that
>>>>> we found workqueue's wait latency was very high even we enabled
>>>>> polling
>>>>> on nvmet-tcp by module parameter idle_poll_period_usecs. So when
>>>>> initiator
>>>>> is polling mode, the target of workqueue is the bottleneck. Below
>>>>> is
>>>>> work's wait latency trace log of our test on our cluster(per node
>>>>> uses
>>>>> 4 numas 96 cores, 192G memory, one dual ports mellanox CX4LX(25Gbps
>>>>> X
>>>>> 2)
>>>>> ethernet adapter and randrw 1M IO size) by RPS to 6 cpu cores. And
>>>>> system's CPU and memory were used about 80%.
>>>> I'd try a simple unbound CPU case, steer packets to say cores [0-5]
>>>> and
>>>> assign
>>>> the cpumask of the unbound workqueue to cores [6-11].
>>> Okay, thanks for your guide.
>>>
>>>>> ogden-brown:~ #/usr/share/bcc/tools/wqlat -T -w nvmet_tcp_wq 1 2
>>>>> 01:06:59
>>>>>     usecs               : count     distribution
>>>>>         0 -> 1          : 0        |                              |
>>>>>         2 -> 3          : 0        |                              |
>>>>>         4 -> 7          : 0        |                              |
>>>>>         8 -> 15         : 3        |                              |
>>>>>        16 -> 31         : 10       |                              |
>>>>>        32 -> 63         : 3        |                              |
>>>>>        64 -> 127        : 2        |                              |
>>>>>       128 -> 255        : 0        |                              |
>>>>>       256 -> 511        : 5        |                              |
>>>>>       512 -> 1023       : 12       |                              |
>>>>>      1024 -> 2047       : 26       |*                             |
>>>>>      2048 -> 4095       : 34       |*                             |
>>>>>      4096 -> 8191       : 350      |************                  |
>>>>>      8192 -> 16383      : 625      |******************************|
>>>>>     16384 -> 32767      : 244      |*********                     |
>>>>>     32768 -> 65535      : 39       |*                             |
>>>>>
>>>>> 01:07:00
>>>>>     usecs               : count     distribution
>>>>>         0 -> 1          : 1        |                              |
>>>>>         2 -> 3          : 0        |                              |
>>>>>         4 -> 7          : 4        |                              |
>>>>>         8 -> 15         : 3        |                              |
>>>>>        16 -> 31         : 8        |                              |
>>>>>        32 -> 63         : 10       |                              |
>>>>>        64 -> 127        : 3        |                              |
>>>>>       128 -> 255        : 6        |                              |
>>>>>       256 -> 511        : 8        |                              |
>>>>>       512 -> 1023       : 20       |*                             |
>>>>>      1024 -> 2047       : 19       |*                             |
>>>>>      2048 -> 4095       : 57       |**                            |
>>>>>      4096 -> 8191       : 325      |****************              |
>>>>>      8192 -> 16383      : 647      |******************************|
>>>>>     16384 -> 32767      : 228      |***********                   |
>>>>>     32768 -> 65535      : 43       |**                            |
>>>>>     65536 -> 131071     : 1        |                              |
>>>>>
>>>>> And the bandwidth of a node is only 3100MB. While we used the patch
>>>>> and enable 6 polling task, the bandwidth can be 4000MB. It's a good
>>>>> improvement.
>>>> I think you will see similar performance with unbound workqueue and
>>>> rps.
>>> Yes, I remodified the nvmet-tcp/nvmet-rdma code for supporting
>>> unbound
>>> workqueue, and in same prerequisites of above to run test, and
>>> compared
>>> the result of unbound workqueue and polling mode task. And I got a
>>> good
>>> performance for unbound workqueue. For unbound workqueue TCP we got
>>> 3850M/node, it's almost equal to polling task. And also tested
>>> nvmet-rdma
>>> we get 5100M/node for unbound workqueue RDMA versus 5600M for polling
>>> task,
>>> seems the diff is very small. Anyway, your advice is good.
>> I'm a bit surprised that you see ~10% delta here. I would look into
>> what
>> is the root-cause of
>> this difference. If indeed the load is high, the overhead of the
>> workqueue mgmt should be
>> negligible. I'm assuming you used IB_POLL_UNBOUND_WORKQUEUE ?
> Yes, we used IB_POLL_UNBOUND_WORKQUEUE to create ib CQ. And I observed
> 3% CPU
> usage of unbound workqueue versus 6% of polling task.
>
>>>    Do you think
>>> we
>>> should submit the unbound workqueue patches for nvmet-tcp and
>>> nvmet-rdma
>>> to upstream nvmet?
>> For nvmet-tcp, I think there is merit to split socket processing from
>> napi context. For nvmet-rdma
>> I think the only difference is if you have multiple CQs assigned with
>> the same comp_vector.
>>
>> How many queues do you have in your test?
> We used 24 IO queues to nvmet-rdma target. I think this may also be
> related to workqueue's wait latency. We still see some several ms wait
> latency for unbound workqueue of RMDA. You can see below trace log.

What is the queue size of each? what rdma device are you using?

