Return-Path: <linux-kernel+bounces-235803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C6691D9D4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2B701F22933
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620CB82485;
	Mon,  1 Jul 2024 08:22:37 +0000 (UTC)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF721804A
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 08:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719822156; cv=none; b=E/fLCtDFoaL7aGG+A7mJ5N4zahbBmt15Hzz3+XTtVHBJUU46hd7Pm3PSuBznbcCTAu68n83jABcOnIdDI05BWNxTGBqsS2jHZZ2E4t93We27sqZCeqoIGmbwgnE5xmoO7khDB6DrUDIZMQ4Q6Jihx7BGoGKWkQVD0JbtBHaj1/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719822156; c=relaxed/simple;
	bh=v/2qpsEwD7OSRBonyA/hkKS8oFZjbfyp0gW9bfe+RJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fmm9BMoOToR5YLGBDQQTcSR310xnp6UEA52gphV4JoX+biTtctw4jgrU3tUVFPz3Ngb4Os1zsPYoWhwTf1go55fqilRYTh3eaxZcAryQ4pJ9KNKCRpIOQlbxxjS6C+2jLX0tHpQ3ngT9Emswl6oKnOKECqwIQOym92lS9MkyPcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ec89b67bfcso2034271fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 01:22:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719822153; x=1720426953;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gaP5w0WmO/BebCNFZntsO+CPAvXO89ZzwU0nrSMDmXQ=;
        b=OlRSO/WYAg1rOrwOpigJiVANXt4vaxU3cdOL7WBuheBLI0cX1lz+atF6tGWKgcNSTu
         8XS3hDS2DvWfdGujsACXKUh75cZRWe33on7gGdLNH/CGyv2LznB6lsYugb6wsRSEVO6K
         AoOvKvrMaf2lCKO5yggtvK2dAyhPAbNkmbDajvsYNsl+moO/+pensEO8AVCvD3JjXWR/
         /aREzGm+p1UsrSNzQt9cPXT/SaR+/ex/tImlV9EPqyRrwSmZzLzuFwFyZJrWMuytg7uT
         fOBgnEIUM0JPtrbzJrDnTj+sUQEUwbgY4bTWOV7fvEWz8GsZp7uxwmQrdyyBMmT3+/au
         EOJQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4DVmSOPbPS2lqOWswa+SKdvn2ZF3yFmpU5g82RwjtDZtOJXQjIfeyOJapk/FfIf12VukmoUkdeK+vjSh/RrqsQvelOvAhE39Whqwh
X-Gm-Message-State: AOJu0Yw+3OA9OTneExzGiIC/ZNGbuelVJgqJL3qchCVEwg63hHaoK46Y
	DhUEIxcBC4nw5DB05nTG49MQ3kMUspIfnw5yChIX5F2AFu22d7Ej
X-Google-Smtp-Source: AGHT+IFuX/aRh+/2oeCaBxwgLCJAgVDmsxLq+dFmpsqq5OOpdob4L+PPh5M5IZYik62pZtZDjvVrxw==
X-Received: by 2002:a2e:8e90:0:b0:2ec:31d9:16e1 with SMTP id 38308e7fff4ca-2ee5e6e745emr24732201fa.5.1719822152602;
        Mon, 01 Jul 2024 01:22:32 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256f55c4b5sm128104555e9.43.2024.07.01.01.22.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 01:22:32 -0700 (PDT)
Message-ID: <f9828eb4-39be-498b-8b90-2cb7ce42d3c7@grimberg.me>
Date: Mon, 1 Jul 2024 11:22:31 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] nvmet: support polling task for RDMA and TCP
To: hch@lst.de, kch@nvidia.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: ping.gan@dell.com
References: <0779b376-38e3-42ef-b32a-a9cfab2749f2@grimberg.me>
 <20240701074245.73348-1-jacky_gam_2001@163.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240701074245.73348-1-jacky_gam_2001@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 01/07/2024 10:42, Ping Gan wrote:
>> Hey Ping Gan,
>>
>>
>> On 26/06/2024 11:28, Ping Gan wrote:
>>> When running nvmf on SMP platform, current nvme target's RDMA and
>>> TCP use kworker to handle IO. But if there is other high workload
>>> in the system(eg: on kubernetes), the competition between the
>>> kworker and other workload is very radical. And since the kworker
>>> is scheduled by OS randomly, it's difficult to control OS resource
>>> and also tune the performance. If target support to use delicated
>>> polling task to handle IO, it's useful to control OS resource and
>>> gain good performance. So it makes sense to add polling task in
>>> rdma-rdma and rdma-tcp modules.
>> This is NOT the way to go here.
>>
>> Both rdma and tcp are driven from workqueue context, which are bound
>> workqueues.
>>
>> So there are two ways to go here:
>> 1. Add generic port cpuset and use that to direct traffic to the
>> appropriate set of cores
>> (i.e. select an appropriate comp_vector for rdma and add an appropriate
>> steering rule
>> for tcp).
>> 2. Add options to rdma/tcp to use UNBOUND workqueues, and allow users
>> to
>> control
>> these UNBOUND workqueues cpumask via sysfs.
>>
>> (2) will not control interrupts to steer to other workloads cpus, but
>> the handlers may
>> run on a set of dedicated cpus.
>>
>> (1) is a better solution, but harder to implement.
>>
>> You also should look into nvmet-fc as well (and nvmet-loop for that
>> matter).
> hi Sagi Grimberg,
> Thanks for your reply, actually we had tried the first advice you
> suggested, but we found the performance was poor when using spdk
> as initiator.

I suggest that you focus on that instead of what you proposed.
What is the source of your poor performance?

>   You know this patch is not only resolving OS resource
> competition issue, but also the perf issue. We have analyzed if we
> still use workqueue(kworker) as target when initiator is polling
> driver(eg: spdk), then workqueue/kworker target is the bottleneck
> since every nvmf request may have a wait latency from queuing on
> workqueue to begin processing,

That is incorrect, the work context polls the cq until it either drains it
completely, or exhaust a quota of IB_POLL_BUDGET_WORKQUEUE (or
NVMET_TCP_IO_WORK_BUDGET). Not every command gets its own workqueue
queuing delay.

And, what does the spdk initiator has to do with it? Didn't understand...

>   and the latency can be traced by wqlat
> of bcc (https://github.com/iovisor/bcc/blob/master/tools/wqlat.py).
> We think the latency is a disaster for the polling driver data plane,
> right?

If you need a target that polls all the time, you should probably resort 
to spdk.
If there is room for optimization in nvmet we'll gladly take it, but 
this is not the
way to go IMO.

> So we think adding a polling task mode on nvmet side to handle
> IO does really make sense; what's your opinion about this?

I personally think that adding a polling kthread is questionable.
However there is a precedent, io_uring sqthreads. So please look
into what is done there. I don't mind having something like 
IB_POLL_IOTASK (or
io_task threads in nvmet-tcp) if its done correctly (leverages common code).

>   And you
> mentioned we should also look into nvmet-fc, I agree with you.
> However currently we have no nvmf-fc's testbed; if we get the testbed,
> will do that.

There is fcloop, you should use that to test, same for loop. We don't want
the transports to diverge in functionality.

