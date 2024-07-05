Return-Path: <linux-kernel+bounces-241978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DED92821C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 08:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6201B24528
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 06:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A35143C7B;
	Fri,  5 Jul 2024 06:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gRhvcLb3"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24025143C5B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 06:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720161037; cv=none; b=FmtRltg08N+oKXZPGsSVMFox9A/W036axNIBeLb0FeSqVn3/lKkp3FvzA5bHXhMhCqCa5awk6oe6JvvfCY1JoJ4TWoLMX0pKHLf/Ydmpfu0tptHvZc7cg/PYfbNSw+toVslv1kj44fBW6fkJIrVg9E3emEoPF+ZXe9ehRD/LlWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720161037; c=relaxed/simple;
	bh=c+EkhjaiwBg9PfY5EaSjMQac2IkjnFQ778b6wqWH9QA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P9pyDBZdx7XUBMxoKBzNxPEgOT8vej2PmVqVMlAAtRCvyENw0TZYuv0cPIVJ6tPHpB96kCqEUYB7OiuSHGo1RpwTst2TSXF0wMFy8Rbu+F27+JBX6Tr5z/yvUEfVMT4ccst0lydRKWFH+v3MUXieHRNqwxVUk6Z8MsiMttBqPWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gRhvcLb3; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=mNQun
	qrILf+NqiwFMuOtQI8MYyYs8KBvDgiTEVQhXOQ=; b=gRhvcLb39dZTPRF2atguv
	ttA91ySmFE3qgd6xe1xs1MUzNM7cBrAnQWuFnZXzcrrC7Okhqb5eP/4a0GTVKLOT
	cbXPKz9kqQOQ9lxvnegeljxou9Vf2ukrDN7fP3IsqXCBxCGLw0vn4gQMjpMIj5SP
	5JCEEPm0RX0jSOE28zwPxU=
Received: from localhost.localdomain (unknown [139.227.195.66])
	by gzga-smtp-mta-g2-0 (Coremail) with SMTP id _____wDnL_DlkodmBufFBg--.53685S2;
	Fri, 05 Jul 2024 14:29:58 +0800 (CST)
From: Ping Gan <jacky_gam_2001@163.com>
To: sagi@grimberg.me,
	hch@lst.de,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: ping.gan@dell.com
Subject: Re: [PATCH 0/2] nvmet: support polling task for RDMA and TCP 
Date: Fri,  5 Jul 2024 14:28:59 +0800
Message-Id: <20240705062900.15228-1-jacky_gam_2001@163.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <61d73b28-c818-4a20-97b8-8a95b4c46c05@grimberg.me>
References: <61d73b28-c818-4a20-97b8-8a95b4c46c05@grimberg.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnL_DlkodmBufFBg--.53685S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Ar1Utr4xCF48Cr4DtrWfuFg_yoWxCw1Upr
	W5JF47tr4DJr1Yyr1Utw4DZr17Kw15Jr1UXr1rJryUJw1qv347Jr4Utry5CFykGr1xtr15
	tFyDJF9xZr1jyw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U4a0dUUUUU=
X-CM-SenderInfo: 5mdfy55bjdzsisqqiqqrwthudrp/1tbiEAkTKWXAlxwkYgAAsL

> On 7/4/24 13:35, Ping Gan wrote:
>>> On 7/4/24 11:10, Ping Gan wrote:
>>>>> On 02/07/2024 13:02, Ping Gan wrote:
>>>>>>> On 01/07/2024 10:42, Ping Gan wrote:
>>>>>>>>> Hey Ping Gan,
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 26/06/2024 11:28, Ping Gan wrote:
>>>>>>>>>> When running nvmf on SMP platform, current nvme target's RDMA
>>>>>>>>>> and
>>>>>>>>>> TCP use kworker to handle IO. But if there is other high
>>>>>>>>>> workload
>>>>>>>>>> in the system(eg: on kubernetes), the competition between the
>>>>>>>>>> kworker and other workload is very radical. And since the
>>>>>>>>>> kworker
>>>>>>>>>> is scheduled by OS randomly, it's difficult to control OS
>>>>>>>>>> resource
>>>>>>>>>> and also tune the performance. If target support to use
>>>>>>>>>> delicated
>>>>>>>>>> polling task to handle IO, it's useful to control OS resource
>>>>>>>>>> and
>>>>>>>>>> gain good performance. So it makes sense to add polling task
>>>>>>>>>> in
>>>>>>>>>> rdma-rdma and rdma-tcp modules.
>>>>>>>>> This is NOT the way to go here.
>>>>>>>>>
>>>>>>>>> Both rdma and tcp are driven from workqueue context, which are
>>>>>>>>> bound
>>>>>>>>> workqueues.
>>>>>>>>>
>>>>>>>>> So there are two ways to go here:
>>>>>>>>> 1. Add generic port cpuset and use that to direct traffic to
>>>>>>>>> the
>>>>>>>>> appropriate set of cores
>>>>>>>>> (i.e. select an appropriate comp_vector for rdma and add an
>>>>>>>>> appropriate
>>>>>>>>> steering rule
>>>>>>>>> for tcp).
>>>>>>>>> 2. Add options to rdma/tcp to use UNBOUND workqueues, and
>>>>>>>>> allow
>>>>>>>>> users
>>>>>>>>> to
>>>>>>>>> control
>>>>>>>>> these UNBOUND workqueues cpumask via sysfs.
>>>>>>>>>
>>>>>>>>> (2) will not control interrupts to steer to other workloads
>>>>>>>>> cpus,
>>>>>>>>> but
>>>>>>>>> the handlers may
>>>>>>>>> run on a set of dedicated cpus.
>>>>>>>>>
>>>>>>>>> (1) is a better solution, but harder to implement.
>>>>>>>>>
>>>>>>>>> You also should look into nvmet-fc as well (and nvmet-loop for
>>>>>>>>> that
>>>>>>>>> matter).
>>>>>>>> hi Sagi Grimberg,
>>>>>>>> Thanks for your reply, actually we had tried the first advice
>>>>>>>> you
>>>>>>>> suggested, but we found the performance was poor when using
>>>>>>>> spdk
>>>>>>>> as initiator.
>>>>>>> I suggest that you focus on that instead of what you proposed.
>>>>>>> What is the source of your poor performance?
>>>>>> Before these patches, we had used linux's RPS to forward the
>>>>>> packets
>>>>>> to a fixed cpu set for nvmet-tcp. But when did that we can still
>>>>>> not
>>>>>> cancel the competition between softirq and workqueue since nvme
>>>>>> target's
>>>>>> kworker cpu core bind on socket's cpu which is from skb. Besides
>>>>>> that
>>>>>> we found workqueue's wait latency was very high even we enabled
>>>>>> polling
>>>>>> on nvmet-tcp by module parameter idle_poll_period_usecs. So when
>>>>>> initiator
>>>>>> is polling mode, the target of workqueue is the bottleneck. Below
>>>>>> is
>>>>>> work's wait latency trace log of our test on our cluster(per node
>>>>>> uses
>>>>>> 4 numas 96 cores, 192G memory, one dual ports mellanox
>>>>>> CX4LX(25Gbps
>>>>>> X
>>>>>> 2)
>>>>>> ethernet adapter and randrw 1M IO size) by RPS to 6 cpu cores.
>>>>>> And
>>>>>> system's CPU and memory were used about 80%.
>>>>> I'd try a simple unbound CPU case, steer packets to say cores
>>>>> [0-5]
>>>>> and
>>>>> assign
>>>>> the cpumask of the unbound workqueue to cores [6-11].
>>>> Okay, thanks for your guide.
>>>>
>>>>>> ogden-brown:~ #/usr/share/bcc/tools/wqlat -T -w nvmet_tcp_wq 1 2
>>>>>> 01:06:59
>>>>>>     usecs               : count     distribution
>>>>>>      0 -> 1          : 0        |                              |
>>>>>>      2 -> 3          : 0        |                              |
>>>>>>      4 -> 7          : 0        |                              |
>>>>>>      8 -> 15         : 3        |                              |
>>>>>>     16 -> 31         : 10       |                              |
>>>>>>     32 -> 63         : 3        |                              |
>>>>>>     64 -> 127        : 2        |                              |
>>>>>>    128 -> 255        : 0        |                              |
>>>>>>    256 -> 511        : 5        |                              |
>>>>>>    512 -> 1023       : 12       |                              |
>>>>>>   1024 -> 2047       : 26       |*                             |
>>>>>>   2048 -> 4095       : 34       |*                             |
>>>>>>   4096 -> 8191       : 350      |************                  |
>>>>>>   8192 -> 16383      : 625      |******************************|
>>>>>>  16384 -> 32767      : 244      |*********                     |
>>>>>>  32768 -> 65535      : 39       |*                             |
>>>>>>
>>>>>> 01:07:00
>>>>>>     usecs               : count     distribution
>>>>>>      0 -> 1          : 1        |                              |
>>>>>>      2 -> 3          : 0        |                              |
>>>>>>      4 -> 7          : 4        |                              |
>>>>>>      8 -> 15         : 3        |                              |
>>>>>>     16 -> 31         : 8        |                              |
>>>>>>     32 -> 63         : 10       |                              |
>>>>>>     64 -> 127        : 3        |                              |
>>>>>>    128 -> 255        : 6        |                              |
>>>>>>    256 -> 511        : 8        |                              |
>>>>>>    512 -> 1023       : 20       |*                             |
>>>>>>   1024 -> 2047       : 19       |*                             |
>>>>>>   2048 -> 4095       : 57       |**                            |
>>>>>>   4096 -> 8191       : 325      |****************              |
>>>>>>   8192 -> 16383      : 647      |******************************|
>>>>>>  16384 -> 32767      : 228      |***********                   |
>>>>>>  32768 -> 65535      : 43       |**                            |
>>>>>>  65536 -> 131071     : 1        |                              |
>>>>>>
>>>>>> And the bandwidth of a node is only 3100MB. While we used the
>>>>>> patch
>>>>>> and enable 6 polling task, the bandwidth can be 4000MB. It's a
>>>>>> good
>>>>>> improvement.
>>>>> I think you will see similar performance with unbound workqueue
>>>>> and
>>>>> rps.
>>>> Yes, I remodified the nvmet-tcp/nvmet-rdma code for supporting
>>>> unbound
>>>> workqueue, and in same prerequisites of above to run test, and
>>>> compared
>>>> the result of unbound workqueue and polling mode task. And I got a
>>>> good
>>>> performance for unbound workqueue. For unbound workqueue TCP we got
>>>> 3850M/node, it's almost equal to polling task. And also tested
>>>> nvmet-rdma
>>>> we get 5100M/node for unbound workqueue RDMA versus 5600M for
>>>> polling
>>>> task,
>>>> seems the diff is very small. Anyway, your advice is good.
>>> I'm a bit surprised that you see ~10% delta here. I would look into
>>> what
>>> is the root-cause of
>>> this difference. If indeed the load is high, the overhead of the
>>> workqueue mgmt should be
>>> negligible. I'm assuming you used IB_POLL_UNBOUND_WORKQUEUE ?
>> Yes, we used IB_POLL_UNBOUND_WORKQUEUE to create ib CQ. And I
>> observed
>> 3% CPU
>> usage of unbound workqueue versus 6% of polling task.
>>
>>>>    Do you think
>>>> we
>>>> should submit the unbound workqueue patches for nvmet-tcp and
>>>> nvmet-rdma
>>>> to upstream nvmet?
>>> For nvmet-tcp, I think there is merit to split socket processing
>>> from
>>> napi context. For nvmet-rdma
>>> I think the only difference is if you have multiple CQs assigned
>>> with
>>> the same comp_vector.
>>>
>>> How many queues do you have in your test?
>> We used 24 IO queues to nvmet-rdma target. I think this may also be
>> related to workqueue's wait latency. We still see some several ms
>> wait
>> latency for unbound workqueue of RMDA. You can see below trace log.
>
> What is the queue size of each? what rdma device are you using?

All the queue's IO size is 1M and queue depth is 32. The rdma deive is
Mellanox CX4LX dual ports bonding. And in poll task we used
IB_POLL_DIRECT
to create CQ versus IB_POLL_UNBOUND_WORKQUEUE for workqueue.

Thanks,
Ping



