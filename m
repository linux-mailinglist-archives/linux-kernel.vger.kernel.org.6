Return-Path: <linux-kernel+bounces-273718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 450EB946CDC
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 08:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE9E11F21F1F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 06:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031C21400A;
	Sun,  4 Aug 2024 06:53:21 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA8E11711
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 06:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722754400; cv=none; b=TBp5fsMj+HGFKUmSwfIbwF010EAd0QpFSgcxiwRbcs0qFqGUHyPrNC9phybuqyq+j/dq7LZLtFx/ImDeBuGiJcBukCCkkVCLxG7ZhhL3ynBscHaYWfbtiA17Cmz0Kq4qmB5IKajWv8cvDr8NtHIKKSOx3JFOOY8SphYZIbpF1WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722754400; c=relaxed/simple;
	bh=bRhzhthEAoUj5RBo9IdM4L8TlS8+VYaYHwVRAES+WYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ap30X8fPqm597jk0knsJ0x2kw5MDWlhYrXKMXWA07we8fRBgTk+zvcLfzi0uxX8CXrX7vGQVMHCs44OEndqfZnUgAOds1ZZZbMHFwd1O9ZgrR64QBKGivSh+MUppdAeruXRI253LzGS1WDIX93wDPSYIMGfDr2AmMhqOjDHAIzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3684c05f7afso1203708f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 03 Aug 2024 23:53:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722754397; x=1723359197;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aQ3fFs0zirKgueE/jg0W4+3mQDUKFrLvd69SWwZOho8=;
        b=usdOjFkWfRk6AAMqoIUbv3Bn0PIoMCWVZ3NMo3Jxg7xFl26tRWIjt2CXQ+gGlr5cXv
         MvrFDK6ALA2AdcrCxpIyrVSlfvRh3JLeVBCoIFH7bFsu9D0OzP7IwQjlOqf5Wa1wmKTJ
         094826AnNVOaVA5xn7PxJA0np1ZjUczulQt6DDOflr1Q52bhV83q3671ECKDQGqViV8t
         Xcm1S1EIL6TfubZnGcOfYoQESHdcAdbhWxXjDo5W/regaVjGM6u0lejSfEXsQ1Gs8C0f
         V50O6EVlwyW2TyUoDex/7hsFK24O5FUVwmuV4cOCpLJb/nTaSWlFQEBeYbJudRsPLBo+
         5X6w==
X-Forwarded-Encrypted: i=1; AJvYcCXFVf2YHzDXvfXG6pJQaJ/lH24KiYUgh4D2eh42IkqzMkLo3p0S9i9fRpHVVe+ADsMQ3MMyxC64pN9jhtw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeLz+1mdSsGbX2POYpaZ8g5nx4tAIRmsLcNQdxWFKiK1Zi/n4Y
	9OmPmRcimJN7wQ4i3y6KHjeUwfpl7idK0Di2WPCQG8aY7Sn6S3E2
X-Google-Smtp-Source: AGHT+IEMso4KTi2NOFueaIe44ywRC+jaeDCRkIzUDPdeLej2S6FDKEEGrzEg8ImsyWD/NQ172QxWlA==
X-Received: by 2002:a5d:47af:0:b0:35f:2929:8460 with SMTP id ffacd0b85a97d-36bbc0c82e6mr3501231f8f.3.1722754396351;
        Sat, 03 Aug 2024 23:53:16 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbcf1e0bcsm5991008f8f.30.2024.08.03.23.53.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Aug 2024 23:53:15 -0700 (PDT)
Message-ID: <d61a36d8-ed26-43e8-b960-58f458ba13e1@grimberg.me>
Date: Sun, 4 Aug 2024 09:53:14 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v30/2] nvmet: use unbound_wq for RDMA and TCP by default
To: Ping Gan <jacky_gam_2001@163.com>, hare@suse.de, hch@lst.de
Cc: ping.gan@dell.com, kch@nvidia.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <ae3047fc-bdeb-4b63-91ac-f4cc39434415@grimberg.me>
 <20240802033952.125753-1-jacky_gam_2001@163.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240802033952.125753-1-jacky_gam_2001@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit




On 02/08/2024 6:39, Ping Gan wrote:
>> On 31/07/2024 10:03, Ping Gan wrote:
>>>> On 26/07/2024 5:34, Ping Gan wrote:
>>>>>> On 19/07/2024 12:19, Ping Gan wrote:
>>>>>>> When running nvmf on SMP platform, current nvme target's RDMA and
>>>>>>> TCP use bounded workqueue to handle IO, but when there is other
>>>>>>> high
>>>>>>> workload on the system(eg: kubernetes), the competition between
>>>>>>> the
>>>>>>> bounded kworker and other workload is very radical. To decrease
>>>>>>> the
>>>>>>> resource race of OS among them, this patchset will switch to
>>>>>>> unbounded
>>>>>>> workqueue for nvmet-rdma and nvmet-tcp; besides that, it can also
>>>>>>> get some performance improvement. And this patchset bases on
>>>>>>> previous
>>>>>>> discussion from below session.
>>>>>>>
>>>>>>> https://lore.kernel.org/lkml/20240719084953.8050-1-jacky_gam_2001@163.com/
>>>>>> Hold your horses.
>>>>>>
>>>>>> This cannot be just switched without a thorough testing and actual
>>>>>> justification/proof of
>>>>>> a benefit beyond just a narrow use-case brought initially by Ping
>>>>>> Gan.
>>>>>>
>>>>>> If the ask is to universally use an unbound workqueue, please
>>>>>> provide
>>>>>> detailed
>>>>>> benchmarking convincing us that this makes sense.
>>>>> So you think we should not do a radical change for the narrow
>>>>> usecase
>>>>> but
>>>>> keep the parameter to enable it in previous version patch, right?
>>>> What I'm saying is that if you want to change the default, please
>>>> provide
>>>> justification in the form of benchmarks that support the change.
>>>> This
>>>> benchmarks should include both throughput, iops and latency
>>>> measurements
>>>> and without the cpu-set constraints you presented originally.
>>> We tested it on our testbed which has 4 numa 96 cores, 190GB memory
>>> and 24 nvme disks, it seems unbound_wq has pretty improvment.  The
>>> creating target test script is below:
>>>
>>> #!/bin/bash
>>> if [ "$#" -ne 3 ] ; then
>>> echo "$0 addr_trtype(tcp/rdma) target_IP target_port"
>>> exit -1
>>> fi
>>> addr_trtype=$1
>>> target_IP=$2
>>> target_port=$3
>>> # there are 24 nvme disks on the testbed
>>> disk_list=(nvme0n1 nvme1n1 nvme2n1 nvme3n1 nvme4n1 nvme5n1 nvme6n1
>>> nvme7n1 nvme8n1 nvme9n1 nvme10n1 nvme11n1 nvme12n1 nvme13n1 nvme14n1
>>> nvme15n1 nvme16n1 nvme17n1 nvme18n1 nvme19n1 nvme20n1 nvme21n1
>>> nvme22n1
>>> nvme23n1)
>>> # create target with multiple disks
>>> create_target_multi_disks() {
>>>           local nqn_name=$1
>>>           local svr_ip=$2
>>>           local svr_port=$3
>>>           local i
>>>           local blk_dev
>>>           local blk_dev_idx=0
>>>           local port_idx=25
>>>           echo "create target: $nqn_name $svr_ip $svr_port"
>>>           mkdir /sys/kernel/config/nvmet/subsystems/${nqn_name}
>>>           echo 1
>>>> /sys/kernel/config/nvmet/subsystems/${nqn_name}/attr_allow_any_host
>>>           for((i=0;i<${#disk_list[@]};i++)); do
>>>                   blk_dev_idx=$((${blk_dev_idx}+1))
>>>                   blk_dev=/dev/${disk_list[$i]}
>>>                   mkdir
>>> /sys/kernel/config/nvmet/subsystems/${nqn_name}/namespaces/${blk_dev_idx}
>>>                   echo  ${blk_dev} >
>>> /sys/kernel/config/nvmet/subsystems/${nqn_name}/namespaces/${blk_dev_idx}/device_path
>>>                   echo 1 >
>>> /sys/kernel/config/nvmet/subsystems/${nqn_name}/namespaces/${blk_dev_idx}/enable
>>>           done
>>>           mkdir /sys/kernel/config/nvmet/ports/${port_idx}
>>>           echo ${addr_trtype}
>>>> /sys/kernel/config/nvmet/ports/${port_idx}/addr_trtype
>>>           echo ipv4
>>>> /sys/kernel/config/nvmet/ports/${port_idx}/addr_adrfam
>>>           echo ${svr_ip}
>>>> /sys/kernel/config/nvmet/ports/${port_idx}/addr_traddr
>>>           echo ${svr_port}
>>>> /sys/kernel/config/nvmet/ports/${port_idx}/addr_trsvcid
>>>           ln -s /sys/kernel/config/nvmet/subsystems/${nqn_name}/
>>> /sys/kernel/config/nvmet/ports/${port_idx}/subsystems/${nqn_name}
>>> }
>>> nvmetcli clear
>>> nqn_name="testnqn_25"
>>> mkdir /sys/kernel/config/nvmet/hosts/hostnqn
>>> create_target_multi_disks ${nqn_name} ${target_IP} ${target_port}
>>>
>>> And the simulation of high workload program is below:
>>>
>>> #define _GNU_SOURCE
>>> #include <stdio.h>
>>> #include <unistd.h>
>>> #include <string.h>
>>> #include <stdlib.h>
>>> #include <pthread.h>
>>> #include <sched.h>
>>> #define THREAD_NUM  (85)
>>> #define MALLOC_SIZE (104857600)
>>> void *loopcostcpu(void *args)
>>> {
>>>           sleep(1);
>>>           int *core_id = (int *)args;
>>>           cpu_set_t cpuset;
>>>           CPU_ZERO(&cpuset);
>>>           CPU_SET(*core_id, &cpuset);
>>>           sched_setaffinity(0, sizeof(cpuset), &cpuset);
>>>           nice(-20);
>>>           long *pt = malloc(MALLOC_SIZE*sizeof(long));
>>>           if (!pt) {
>>>                   printf("error malloc\n");
>>>                   return;
>>>           }
>>>           long i = 0;
>>>           while (1) {
>>>                   for (i = 0; i < MALLOC_SIZE; i++) {
>>>                           pt[i] = i;
>>>                   }
>>>                   //sleep 10ms
>>>                   usleep(10000);
>>>           }
>>>           return;
>>> }
>>> int main(int argc, char *argv[])
>>> {
>>>           pthread_t tid[THREAD_NUM];
>>>           int core_id[THREAD_NUM];
>>>           int result, i, j = 1;
>>>           for (i = 0; i < THREAD_NUM; i++) {
>>>                   core_id[i] = j;
>>>                   j++;
>>>                   result = pthread_create(&tid[i], NULL, loopcostcpu,
>>> 									(void*)
>>> &core_id[i]);
>>>                   if (result) {
>>>                           printf("create thread %d failure\n", i);
>>>                   }
>>>           }
>>>           while(1)
>>>                   sleep(5);
>>>           return 0;
>>> }
>>>
>>> When running above program on target testbed, and we reserved 8
>>> cores(88-95) for nvmet target io threads(both rdma and tcp), then we
>>> used spdk perf(V20.04) as initiator to create 8 IO queues and per
>>> queue has 32 queue depths and 1M randrw io size on another testbed
>>> to verify it.
>>> TCP's test command shown below:
>>> ./spdk_perf_tcp -q 32 -S -P 8 -s 4096 -w randrw -t 300 -c 0xff00000
>>> -o
>>> 1048576 -M 50 -r 'trtype:TCP adrfam:IPv4 traddr:169.254.2.104
>>> trsvcid:4444'
>>> RDMA's test command shown below:
>>> ./spkd_perf_rdma -q 32 -S -P 8 -s 4096 -w randrw -t 300 -c 0xff00000
>>> -o
>>> 1048576 -M 50 -r 'trtype:RDMA adrfam:IPv4 traddr:169.254.2.104
>>> trsvcid:4444'
>>> And we got below test results:
>>> TCP's unbound_wq:  IOPS:4585.64, BW:4585.64 MiB/s, Avglat:167515.56us
>>> TCP's bound_wq:    IOPS:3588.40, BW:3588.40 MiB/s, Avglat:214088.55us
>>> RDMA's unbound_wq: IOPS:6421.47, BW:6421.47 MiB/s, Avglat:119605.17us
>>> RDMA's bound_wq:   IOPS:5919.94, BW:5919.94 MiB/s, Avglat:129744.70us
>>>
>>> It seems using unbound_wq to decreasing competition of CPU between
>>> target IO worker thread and other high workload does make sense.
>> It makes sense for the use case, I agree. What I was asking is to test
>> outside this use-case, where nvmet is used as a JBOF, and not
>> competing
>> with other intensive workloads. Does unbound workqueues damage
>> performance?
>> Back in 2016 it absolutely did.
>>
>> What I would also want to see is a test that addresses latency
>> sensitive
>> workloads, such
>> that the load is not high with large block size, but rather small
>> block
>> size, with medium/low
>> load and see what is the latency for the two options.
> We had done two group tests for unbound_wq and bound_wq; per group had
> 6 round tests which included TCP 1M IO size without other workload,
> TCP 4K IO size without other workload, TCP 4K IO size with medium
> workload(about 45% CPU cost and 25% memory cost), RDMA 1M IO size
> without other workload, RDMA 4K IO size without other workload,
> RDMA 4K IO size with medium workload. And every round test we used
> 8 IO queues, per queue had 32 queue depths and no CPU affinity with
> randrw disk to run 1 hour test and we got below results.
>
> TCP 1M bound_wq:   IOPS:8120.38, BW:8120.38 MiB/s, Avglat:94577.77us
> TCP 1M unbound_wq: IOPS:8236.16, BW:8236.16 MiB/s, Avglat:93248.18us
>
> TCP 4K bound_wq:   IOPS:1326767.00, BW:5182.68 MiB/s, Avglat:578.83us
> TCP 4K unbound_wq: IOPS:952239.52,  BW:3719.69 MiB/s, Avglat:806.49us
>
> TCP 4K with medium workload bound_wq:
>                     IOPS:944414.21, BW:3689.12 MiB/s, Avglat:813.18us
> TCP 4K with medium workload unbound_wq:
>                     IOPS:855103.18, BW:3340.25 MiB/s, Avglat:898.11us
>
> RDMA 1M bound_wq:  IOPS:10111.35, BW:10111.35 MiB/s, Avglat:75954.55us
> RDMA 1M unbound_wq:IOPS:10108.84, BW:10108.84 MiB/s, Avglat:75973.39us
>
> RDMA 4K bound_wq:  IOPS:2645207.01, BW:10332.84 MiB/s, Avglat:290.31us
> RDMA 4K unbound_wq:IOPS:2644785.78, BW:10331.19 MiB/s, Avglat:290.35us
>
> RDMA 4K with medium workload bound_wq:
>                     IOPS:2595758.58, BW:10139.68 MiB/s, Avglat:295.84us
> RDMA 4K with medium workload unbound_wq:
>                     IOPS:2551177.45, BW:9965.54 MiB/s, Avglat:301.01us
>
> It seems in TCP small block size case the unbound_wq has tremendous
> performance drop.

That is consistent with what I saw back in 2016.

>   So I think we should not radically change the default
> workqueue as unbounded but keep the previous patch with parameter to
> support the narrow case for performance improvement.

Interestingly though, rdma does not seem to have the same 
characteristics, although
I do expect that in *some* workloads the overhead is meaningful.

My position is that this change should be presented as a modparam. In 
the long run, I'd think
we want to introduce polling threads to nvmet and move the scheduling to 
it, but it is a larger project,
and when when that happens, I'd rather deprecate the modparam instead of 
introducing this change
that impacts performance in any meaningful way.

