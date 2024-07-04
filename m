Return-Path: <linux-kernel+bounces-240702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 205FD927149
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 10:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 427F31C216EE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 08:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429111A3BB7;
	Thu,  4 Jul 2024 08:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PtoFs9RV"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712F610A35
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 08:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720080713; cv=none; b=oQ+mTM1MgAz3LA64AkqLji1rucryWkm7mwsiigS8P+4vdO8i/7tNCynN+19e1qGmjUBRnlvUc3cpOqQNbvyPX5ps1LzJ1j+t34QyH/8efC+NifPg2hn4jTu3dLeIcm7gM6hS3gJIlz/rG6YVb8fMtSyhBtYtE+NCnxWXd+/8bCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720080713; c=relaxed/simple;
	bh=fVMOXile9o/rYKe/nNqr1E61PhdXzD4ix3W3xkqYmvM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nADHq6wU4GyeTcdC6D7rpCs7HtY2cDbHQP57YxvxLsYyInV3Glxfx/zbPH5RGIC1D/oTfar16P0hg3bFxvbSo+/pSclCka6RAJQA9XDsNHCOv45d8gJGHv17eSJfZsk2eK1tpLdtODZu0cdY8sXgDYcBaYKGx1B9bOkcjSbC2A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PtoFs9RV; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=DV2gX
	wlXenb1u9gzd4mccSm85kw2mBaWW1Jbah9Yx/0=; b=PtoFs9RV+iOEk7UA66j/N
	C9xxA/6b1VnHIUr9Ed0znTIV7QRGrxYezhj3W/68/XrVOIuVxYEXT3M8hemjr8Rd
	DA5m2mG/ajiGlMplIrfUUcpKFQizaAopEOQnfOrm1lvL40fOWTM/Ous+IZZwYIUE
	S+L7nLkQLDlevE44TVKl4w=
Received: from localhost.localdomain (unknown [223.104.210.212])
	by gzga-smtp-mta-g3-5 (Coremail) with SMTP id _____wD3PwQbWYZmhnqWBg--.38788S2;
	Thu, 04 Jul 2024 16:11:10 +0800 (CST)
From: Ping Gan <jacky_gam_2001@163.com>
To: sagi@grimberg.me,
	hch@lst.de,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: ping.gan@dell.com
Subject: Re: [PATCH 0/2] nvmet: support polling task for RDMA and TCP 
Date: Thu,  4 Jul 2024 16:10:14 +0800
Message-Id: <20240704081015.63584-1-jacky_gam_2001@163.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <12556163-9efa-461f-826d-264350f4ca58@grimberg.me>
References: <12556163-9efa-461f-826d-264350f4ca58@grimberg.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3PwQbWYZmhnqWBg--.38788S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKF4fuw45tw1xZr4xKFy7GFg_yoW3WFy8pF
	WfJFW5Krs7JrWYyrn2vwsrZFyjkws3Jr4UXFyrGryUJwn093srJr4xtFy5uF97Gr18Kw1a
	qFyDXasxZF1qy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U4a0dUUUUU=
X-CM-SenderInfo: 5mdfy55bjdzsisqqiqqrwthudrp/1tbiEAISKWXAlwwdgwAAsJ

> On 02/07/2024 13:02, Ping Gan wrote:
>>> On 01/07/2024 10:42, Ping Gan wrote:
>>>>> Hey Ping Gan,
>>>>>
>>>>>
>>>>> On 26/06/2024 11:28, Ping Gan wrote:
>>>>>> When running nvmf on SMP platform, current nvme target's RDMA and
>>>>>> TCP use kworker to handle IO. But if there is other high workload
>>>>>> in the system(eg: on kubernetes), the competition between the
>>>>>> kworker and other workload is very radical. And since the kworker
>>>>>> is scheduled by OS randomly, it's difficult to control OS
>>>>>> resource
>>>>>> and also tune the performance. If target support to use delicated
>>>>>> polling task to handle IO, it's useful to control OS resource and
>>>>>> gain good performance. So it makes sense to add polling task in
>>>>>> rdma-rdma and rdma-tcp modules.
>>>>> This is NOT the way to go here.
>>>>>
>>>>> Both rdma and tcp are driven from workqueue context, which are
>>>>> bound
>>>>> workqueues.
>>>>>
>>>>> So there are two ways to go here:
>>>>> 1. Add generic port cpuset and use that to direct traffic to the
>>>>> appropriate set of cores
>>>>> (i.e. select an appropriate comp_vector for rdma and add an
>>>>> appropriate
>>>>> steering rule
>>>>> for tcp).
>>>>> 2. Add options to rdma/tcp to use UNBOUND workqueues, and allow
>>>>> users
>>>>> to
>>>>> control
>>>>> these UNBOUND workqueues cpumask via sysfs.
>>>>>
>>>>> (2) will not control interrupts to steer to other workloads cpus,
>>>>> but
>>>>> the handlers may
>>>>> run on a set of dedicated cpus.
>>>>>
>>>>> (1) is a better solution, but harder to implement.
>>>>>
>>>>> You also should look into nvmet-fc as well (and nvmet-loop for
>>>>> that
>>>>> matter).
>>>> hi Sagi Grimberg,
>>>> Thanks for your reply, actually we had tried the first advice you
>>>> suggested, but we found the performance was poor when using spdk
>>>> as initiator.
>>> I suggest that you focus on that instead of what you proposed.
>>> What is the source of your poor performance?
>> Before these patches, we had used linux's RPS to forward the packets
>> to a fixed cpu set for nvmet-tcp. But when did that we can still not
>> cancel the competition between softirq and workqueue since nvme
>> target's
>> kworker cpu core bind on socket's cpu which is from skb. Besides that
>> we found workqueue's wait latency was very high even we enabled
>> polling
>> on nvmet-tcp by module parameter idle_poll_period_usecs. So when
>> initiator
>> is polling mode, the target of workqueue is the bottleneck. Below is
>> work's wait latency trace log of our test on our cluster(per node
>> uses
>> 4 numas 96 cores, 192G memory, one dual ports mellanox CX4LX(25Gbps X
>> 2)
>> ethernet adapter and randrw 1M IO size) by RPS to 6 cpu cores. And
>> system's CPU and memory were used about 80%.

> I'd try a simple unbound CPU case, steer packets to say cores [0-5]
> and 
> assign
> the cpumask of the unbound workqueue to cores [6-11].

Okay, thanks for your guide.

>> ogden-brown:~ #/usr/share/bcc/tools/wqlat -T -w nvmet_tcp_wq 1 2
>> 01:06:59
>>       usecs               : count     distribution
>>           0 -> 1          : 0        |                              |
>>           2 -> 3          : 0        |                              |
>>           4 -> 7          : 0        |                              |
>>           8 -> 15         : 3        |                              |
>>          16 -> 31         : 10       |                              |
>>          32 -> 63         : 3        |                              |
>>          64 -> 127        : 2        |                              |
>>         128 -> 255        : 0        |                              |
>>         256 -> 511        : 5        |                              |
>>         512 -> 1023       : 12       |                              |
>>        1024 -> 2047       : 26       |*                             |
>>        2048 -> 4095       : 34       |*                             |
>>        4096 -> 8191       : 350      |************                  |
>>        8192 -> 16383      : 625      |******************************|
>>       16384 -> 32767      : 244      |*********                     |
>>       32768 -> 65535      : 39       |*                             |
>>
>> 01:07:00
>>       usecs               : count     distribution
>>           0 -> 1          : 1        |                              |
>>           2 -> 3          : 0        |                              |
>>           4 -> 7          : 4        |                              |
>>           8 -> 15         : 3        |                              |
>>          16 -> 31         : 8        |                              |
>>          32 -> 63         : 10       |                              |
>>          64 -> 127        : 3        |                              |
>>         128 -> 255        : 6        |                              |
>>         256 -> 511        : 8        |                              |
>>         512 -> 1023       : 20       |*                             |
>>        1024 -> 2047       : 19       |*                             |
>>        2048 -> 4095       : 57       |**                            |
>>        4096 -> 8191       : 325      |****************              |
>>        8192 -> 16383      : 647      |******************************|
>>       16384 -> 32767      : 228      |***********                   |
>>       32768 -> 65535      : 43       |**                            |
>>       65536 -> 131071     : 1        |                              |
>>
>> And the bandwidth of a node is only 3100MB. While we used the patch
>> and enable 6 polling task, the bandwidth can be 4000MB. It's a good
>> improvement.
>
> I think you will see similar performance with unbound workqueue and
> rps.

Yes, I remodified the nvmet-tcp/nvmet-rdma code for supporting unbound
workqueue, and in same prerequisites of above to run test, and compared
the result of unbound workqueue and polling mode task. And I got a good 
performance for unbound workqueue. For unbound workqueue TCP we got 
3850M/node, it's almost equal to polling task. And also tested
nvmet-rdma
we get 5100M/node for unbound workqueue RDMA versus 5600M for polling
task,
seems the diff is very small. Anyway, your advice is good. Do you think
we
should submit the unbound workqueue patches for nvmet-tcp and nvmet-rdma 
to upstream nvmet?
BTW I have another question: Will nvmet of upstream have the plan to
support 
polling queue when doing submit_bio in future? 
 
>>
>>>>    You know this patch is not only resolving OS resource
>>>> competition issue, but also the perf issue. We have analyzed if we
>>>> still use workqueue(kworker) as target when initiator is polling
>>>> driver(eg: spdk), then workqueue/kworker target is the bottleneck
>>>> since every nvmf request may have a wait latency from queuing on
>>>> workqueue to begin processing,
>>> That is incorrect, the work context polls the cq until it either
>>> drains
>>> it
>>> completely, or exhaust a quota of IB_POLL_BUDGET_WORKQUEUE (or
>>> NVMET_TCP_IO_WORK_BUDGET). Not every command gets its own workqueue
>>> queuing delay.
>>>
>>> And, what does the spdk initiator has to do with it? Didn't
>>> understand...
>> Yes, target workqueue implementation will poll a quota; but when the
>> work
>> load was high we found many work will wait too long(some of them at
>> several
>> ms to hundred ms shown above histogram). We use the spdk initiator(by
>> polling mode) to send IO's read/write to nvme disks of a kubernetes
>> cluster's remote node.
>
> The initiator is an orthogonal detail here. the same issue exists 
> regardless of
> spdk afaiu. Let's ignore it, its confusing.
>
>>
>>>>    and the latency can be traced by wqlat
>>>> of bcc (https://github.com/iovisor/bcc/blob/master/tools/wqlat.py).
>>>> We think the latency is a disaster for the polling driver data
>>>> plane,
>>>> right?
>>> If you need a target that polls all the time, you should probably
>>> resort
>>> to spdk.
>>> If there is room for optimization in nvmet we'll gladly take it, but
>>> this is not the
>>> way to go IMO.
>> Yes, in the begining we did use the spdk as polling target driver,
>> but we suffered from spdk target could not support disk hot
>> plug/unplug
>> well, sometimes it will cause data loss when did disk hot
>> plug/unplug.
>> So we switch to kernel target driver because in production customer's
>> data security is first priority. And for kernel's target it has no
>> polling mode target driver, so we implemented these patches.
>
> Well, its a hard sell for upstream nvmet.
>>
>>
>>>> So we think adding a polling task mode on nvmet side to handle
>>>> IO does really make sense; what's your opinion about this?
>>> I personally think that adding a polling kthread is questionable.
>>> However there is a precedent, io_uring sqthreads. So please look
>>> into what is done there. I don't mind having something like
>>> IB_POLL_IOTASK (or
>>> io_task threads in nvmet-tcp) if its done correctly (leverages
>>> common
>>> code).
>> Yes, we have studied io_uring's code before implementing the patches.
>> Actually we followed io_uring's design idea in these patches.
>
> I'm talking about reusing what io_uring sqpoll tasks. Move them to
> common
> code, generalizing it to address what you need, and reuse that. 
> Implementing a
> half-baked inspired version in nvmet is not going to fly here. Sorry.
Okay, got it.


Thanks,
Ping



