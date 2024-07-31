Return-Path: <linux-kernel+bounces-268706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 531F6942820
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 09:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DCE4B222C9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 07:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE171A721A;
	Wed, 31 Jul 2024 07:36:17 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0356739851
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 07:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722411377; cv=none; b=uWudCcVNswiW71G2yq5Eed/mm8p5VP8Sb6COWc8gp1F7bt4mX1mB771K1gwTLVjj2rfGoQHJ8my5deiy78e9fXwBQIKTmR3CeJNqIx1sxA+vtIl94s2jO7zcJz5z6id46qZiFyeLYthZC94EipY8tDsmmcbQnu3yIzdIyTT+VCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722411377; c=relaxed/simple;
	bh=GuN3AsiI7kZlxgXWW3YTEt3lOrQHWtcb9D2hxFMGoU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IlkcJLX0F/AZOfrO9i54IAZyOcR7Qm4ox6xmo52QoUxuLnabQE5HSWlu8fIiN5cYMhK1VrUtfkOqjRcz27kVXC+26TeKojhbdTgIy2tR7k1zvQnYtCcCfRYgIgfpqTckA8vJv4iHGry57WBCFeD9KCoVvZp2wAU6eVqy41BN/Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4280772333eso2492005e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 00:36:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722411373; x=1723016173;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tOBK1zJNwfmeMZXC2+EpO9wUpnyhnQvvJPepSNwqT3Q=;
        b=HKMqLoYyID6pqrEN2xGNF1NIynIEAvIUeDPbdRtCzGxFkep9ZqmSWKEFf7AMDNP4GN
         svZgkz0vhgUdXEq9u1k55WQ2T1RzoXLALaFQVPeyr0n0a4ZOgwXwYu98bD56t3yyLYCx
         OdCKnMQ49+ygTMNFurSu5d6MeSz2kARjq2SAdvm0Jd/BVCVACI8Or8Aq2PhWF2vNuKx2
         RUGJlpmrr+aDnK7WUh7OZI6cqUyTY52YAT+FM6ZqoTwHbE0mjRzvXtRQFNurae2M3NGy
         55HmEFBAmchYGcc8XJsfQJXNey2O2KUn4bnVA/wINItxS/opVlGZFID30Tgvnv7vt681
         SAvg==
X-Forwarded-Encrypted: i=1; AJvYcCU/Pw75gy5aPgbdaKxUJplvbv91gbe53bL/gDEkh/b8tS6xJHjyIm+zu8PhRwlSiKNlZWcwBwJmXZ54dzY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp0C8d20tLXf68i0hfB8OBYG++JEmAWXW4NcC9dr3OZ+R7gtI8
	FRmoCFO+G56PR7tm9RbKKsECb2UEUjDKS891XHYffekjtQpUKPL/
X-Google-Smtp-Source: AGHT+IF2cezuJo8yOeS138rccPai1NJ7yKJaEb65sPtEzO5RvWWH8dE9KvK1wlJMwvgPIXRWHa9KgQ==
X-Received: by 2002:a05:600c:4511:b0:425:7ac6:96f9 with SMTP id 5b1f17b1804b1-428053c0936mr86157575e9.0.1722411372784;
        Wed, 31 Jul 2024 00:36:12 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282baccccfsm10971445e9.29.2024.07.31.00.36.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 00:36:12 -0700 (PDT)
Message-ID: <ae3047fc-bdeb-4b63-91ac-f4cc39434415@grimberg.me>
Date: Wed, 31 Jul 2024 10:36:11 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] nvmet: use unbound_wq for RDMA and TCP by default
To: Ping Gan <jacky_gam_2001@163.com>, hare@suse.de, hch@lst.de
Cc: ping.gan@dell.com, kch@nvidia.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <b3592bca-015f-451e-b689-8db820cbc7a6@grimberg.me>
 <20240731070326.76090-1-jacky_gam_2001@163.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240731070326.76090-1-jacky_gam_2001@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit




On 31/07/2024 10:03, Ping Gan wrote:
>> On 26/07/2024 5:34, Ping Gan wrote:
>>>> On 19/07/2024 12:19, Ping Gan wrote:
>>>>> When running nvmf on SMP platform, current nvme target's RDMA and
>>>>> TCP use bounded workqueue to handle IO, but when there is other
>>>>> high
>>>>> workload on the system(eg: kubernetes), the competition between the
>>>>> bounded kworker and other workload is very radical. To decrease the
>>>>> resource race of OS among them, this patchset will switch to
>>>>> unbounded
>>>>> workqueue for nvmet-rdma and nvmet-tcp; besides that, it can also
>>>>> get some performance improvement. And this patchset bases on
>>>>> previous
>>>>> discussion from below session.
>>>>>
>>>>> https://lore.kernel.org/lkml/20240719084953.8050-1-jacky_gam_2001@163.com/
>>>> Hold your horses.
>>>>
>>>> This cannot be just switched without a thorough testing and actual
>>>> justification/proof of
>>>> a benefit beyond just a narrow use-case brought initially by Ping
>>>> Gan.
>>>>
>>>> If the ask is to universally use an unbound workqueue, please
>>>> provide
>>>> detailed
>>>> benchmarking convincing us that this makes sense.
>>> So you think we should not do a radical change for the narrow usecase
>>> but
>>> keep the parameter to enable it in previous version patch, right?
>> What I'm saying is that if you want to change the default, please
>> provide
>> justification in the form of benchmarks that support the change. This
>> benchmarks should include both throughput, iops and latency
>> measurements
>> and without the cpu-set constraints you presented originally.
> We tested it on our testbed which has 4 numa 96 cores, 190GB memory
> and 24 nvme disks, it seems unbound_wq has pretty improvment.  The
> creating target test script is below:
>
> #!/bin/bash
> if [ "$#" -ne 3 ] ; then
> echo "$0 addr_trtype(tcp/rdma) target_IP target_port"
> exit -1
> fi
> addr_trtype=$1
> target_IP=$2
> target_port=$3
> # there are 24 nvme disks on the testbed
> disk_list=(nvme0n1 nvme1n1 nvme2n1 nvme3n1 nvme4n1 nvme5n1 nvme6n1
> nvme7n1 nvme8n1 nvme9n1 nvme10n1 nvme11n1 nvme12n1 nvme13n1 nvme14n1
> nvme15n1 nvme16n1 nvme17n1 nvme18n1 nvme19n1 nvme20n1 nvme21n1 nvme22n1
> nvme23n1)
> # create target with multiple disks
> create_target_multi_disks() {
>          local nqn_name=$1
>          local svr_ip=$2
>          local svr_port=$3
>          local i
>          local blk_dev
>          local blk_dev_idx=0
>          local port_idx=25
>          echo "create target: $nqn_name $svr_ip $svr_port"
>          mkdir /sys/kernel/config/nvmet/subsystems/${nqn_name}
>          echo 1
>> /sys/kernel/config/nvmet/subsystems/${nqn_name}/attr_allow_any_host
>          for((i=0;i<${#disk_list[@]};i++)); do
>                  blk_dev_idx=$((${blk_dev_idx}+1))
>                  blk_dev=/dev/${disk_list[$i]}
>                  mkdir
> /sys/kernel/config/nvmet/subsystems/${nqn_name}/namespaces/${blk_dev_idx}
>                  echo  ${blk_dev} >
> /sys/kernel/config/nvmet/subsystems/${nqn_name}/namespaces/${blk_dev_idx}/device_path
>                  echo 1 >
> /sys/kernel/config/nvmet/subsystems/${nqn_name}/namespaces/${blk_dev_idx}/enable
>          done
>          mkdir /sys/kernel/config/nvmet/ports/${port_idx}
>          echo ${addr_trtype}
>> /sys/kernel/config/nvmet/ports/${port_idx}/addr_trtype
>          echo ipv4
>> /sys/kernel/config/nvmet/ports/${port_idx}/addr_adrfam
>          echo ${svr_ip}
>> /sys/kernel/config/nvmet/ports/${port_idx}/addr_traddr
>          echo ${svr_port}
>> /sys/kernel/config/nvmet/ports/${port_idx}/addr_trsvcid
>          ln -s /sys/kernel/config/nvmet/subsystems/${nqn_name}/
> /sys/kernel/config/nvmet/ports/${port_idx}/subsystems/${nqn_name}
> }
> nvmetcli clear
> nqn_name="testnqn_25"
> mkdir /sys/kernel/config/nvmet/hosts/hostnqn
> create_target_multi_disks ${nqn_name} ${target_IP} ${target_port}
>
> And the simulation of high workload program is below:
>
> #define _GNU_SOURCE
> #include <stdio.h>
> #include <unistd.h>
> #include <string.h>
> #include <stdlib.h>
> #include <pthread.h>
> #include <sched.h>
> #define THREAD_NUM  (85)
> #define MALLOC_SIZE (104857600)
> void *loopcostcpu(void *args)
> {
>          sleep(1);
>          int *core_id = (int *)args;
>          cpu_set_t cpuset;
>          CPU_ZERO(&cpuset);
>          CPU_SET(*core_id, &cpuset);
>          sched_setaffinity(0, sizeof(cpuset), &cpuset);
>          nice(-20);
>          long *pt = malloc(MALLOC_SIZE*sizeof(long));
>          if (!pt) {
>                  printf("error malloc\n");
>                  return;
>          }
>          long i = 0;
>          while (1) {
>                  for (i = 0; i < MALLOC_SIZE; i++) {
>                          pt[i] = i;
>                  }
>                  //sleep 10ms
>                  usleep(10000);
>          }
>          return;
> }
> int main(int argc, char *argv[])
> {
>          pthread_t tid[THREAD_NUM];
>          int core_id[THREAD_NUM];
>          int result, i, j = 1;
>          for (i = 0; i < THREAD_NUM; i++) {
>                  core_id[i] = j;
>                  j++;
>                  result = pthread_create(&tid[i], NULL, loopcostcpu,
> 									(void*)
> &core_id[i]);
>                  if (result) {
>                          printf("create thread %d failure\n", i);
>                  }
>          }
>          while(1)
>                  sleep(5);
>          return 0;
> }
>
> When running above program on target testbed, and we reserved 8
> cores(88-95) for nvmet target io threads(both rdma and tcp), then we
> used spdk perf(V20.04) as initiator to create 8 IO queues and per
> queue has 32 queue depths and 1M randrw io size on another testbed
> to verify it.
> TCP's test command shown below:
> ./spdk_perf_tcp -q 32 -S -P 8 -s 4096 -w randrw -t 300 -c 0xff00000 -o
> 1048576 -M 50 -r 'trtype:TCP adrfam:IPv4 traddr:169.254.2.104
> trsvcid:4444'
> RDMA's test command shown below:
> ./spkd_perf_rdma -q 32 -S -P 8 -s 4096 -w randrw -t 300 -c 0xff00000 -o
> 1048576 -M 50 -r 'trtype:RDMA adrfam:IPv4 traddr:169.254.2.104
> trsvcid:4444'
> And we got below test results:
> TCP's unbound_wq:  IOPS:4585.64, BW:4585.64 MiB/s, Avglat:167515.56us
> TCP's bound_wq:    IOPS:3588.40, BW:3588.40 MiB/s, Avglat:214088.55us
> RDMA's unbound_wq: IOPS:6421.47, BW:6421.47 MiB/s, Avglat:119605.17us
> RDMA's bound_wq:   IOPS:5919.94, BW:5919.94 MiB/s, Avglat:129744.70us
>
> It seems using unbound_wq to decreasing competition of CPU between
> target IO worker thread and other high workload does make sense.

It makes sense for the use case, I agree. What I was asking is to test
outside this use-case, where nvmet is used as a JBOF, and not competing
with other intensive workloads. Does unbound workqueues damage performance?
Back in 2016 it absolutely did.

What I would also want to see is a test that addresses latency sensitive 
workloads, such
that the load is not high with large block size, but rather small block 
size, with medium/low
load and see what is the latency for the two options.

