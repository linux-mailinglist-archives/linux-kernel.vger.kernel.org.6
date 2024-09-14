Return-Path: <linux-kernel+bounces-329218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0C4978EC1
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 09:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCAEBB28372
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 07:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7841CDFC1;
	Sat, 14 Sep 2024 07:03:55 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF811CDFBE
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 07:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726297434; cv=none; b=O1gXUxA7LeBNz0OfwuiYILi5m+IMXyBrDC4EVVLU+xYEqEF7e7Q9sQLUDzPHtnJePO932SFrbi8YLGkKgz90864+RwUf7wrMkzivQH+pepGZXLoKyqDmtpVPCSLghz+0avUNddWuj3Q+9NovJG3F6mrtMvY/qsxmqXgmUfyLhN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726297434; c=relaxed/simple;
	bh=s1gmTA2ZnBVq9e2XP2u4CSrS0wAzjkiHYt2rVCsi51Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lZ3ZeQ/UR+4FaFVWly3srBdKI+K3qkawLuh3DDMvAWVvrEBRmIxQpneTmYk09pg0iatBkeUb2A6BhWAClnirM/R51/VKn1CsuFyJf/nHFgBTnLn0zxRh1kTG6yuYUnnW6lRGldNjXcAPyhrhmWUrHeF2aXL3A16AVrn/fOSEmkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4X5MbH06MVz69WG;
	Sat, 14 Sep 2024 15:03:39 +0800 (CST)
Received: from kwepemd500019.china.huawei.com (unknown [7.221.188.86])
	by mail.maildlp.com (Postfix) with ESMTPS id 474121800CF;
	Sat, 14 Sep 2024 15:03:48 +0800 (CST)
Received: from [10.67.109.61] (10.67.109.61) by kwepemd500019.china.huawei.com
 (7.221.188.86) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 14 Sep
 2024 15:03:47 +0800
Message-ID: <f389a220-b628-575a-7af1-d897ee5730cc@huawei.com>
Date: Sat, 14 Sep 2024 15:03:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: =?UTF-8?Q?Re=3a_=5bQuestion=5d_sched=ef=bc=9athe_load_is_unbalanced?=
 =?UTF-8?Q?_in_the_VM_overcommitment_scenario?=
To: Vincent Guittot <vincent.guittot@linaro.org>
CC: Waiman Long <longman@redhat.com>, <peterz@infradead.org>,
	<juri.lelli@redhat.com>, <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
	<bsegall@google.com>, <mgorman@suse.de>, <vschneid@redhat.com>,
	<oleg@redhat.com>, Frederic Weisbecker <frederic@kernel.org>,
	<mingo@kernel.org>, <peterx@redhat.com>, <tj@kernel.org>,
	<tjcao980311@gmail.com>, <linux-kernel@vger.kernel.org>
References: <20240725120315.212428-1-zhengzucheng@huawei.com>
 <3e68ccda-1606-9494-f57a-75be9668b83d@huawei.com>
 <cb3a3f3e-727a-4cbb-b4a8-f9469ed4f08d@redhat.com>
 <9982cb8d-9346-0640-dd9f-f68390f922e9@huawei.com>
 <CAKfTPtCdfzZ9Wxr7+zH5WW171LJGttgzto4W2wH9mm4d0jcTLg@mail.gmail.com>
From: zhengzucheng <zhengzucheng@huawei.com>
In-Reply-To: <CAKfTPtCdfzZ9Wxr7+zH5WW171LJGttgzto4W2wH9mm4d0jcTLg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd500019.china.huawei.com (7.221.188.86)


在 2024/9/13 23:55, Vincent Guittot 写道:
> On Fri, 13 Sept 2024 at 06:03, zhengzucheng <zhengzucheng@huawei.com> wrote:
>> In the VM overcommitment scenario, the overcommitment ratio is 1:2, 8
>> CPUs are overcommitted to 2 x 8u VMs,
>> and 16 vCPUs are bound to 8 cpu. However, one VM obtains only 2 CPUs
>> resources, the other VM has 6 CPUs.
>> The host is configured with 80 CPUs in a sched domain and other CPUs are
>> in the idle state.
>> The root cause is that the load of the host is unbalanced, some vCPUs
>> exclusively occupy CPU resources.
>> when the CPU that triggers load balance calculates imbalance value,
>> env->imbalance = 0 is calculated because of
>> local->avg_load > sds->avg_load. As a result, the load balance fails.
>> The processing logic:
>> https://github.com/torvalds/linux/commit/91dcf1e8068e9a8823e419a7a34ff4341275fb70
>>
>>
>> It's normal from kernel load balance, but it's not reasonable from the
>> perspective of VM users.
>> In cgroup v1, set cpuset.sched_load_balance=0 to modify the schedule
>> domain to fix it.
>> Is there any other method to fix this problem? thanks.
> I'm not sure how to understand your setup and why the load balance is
> not balancing correctly 16 vCPU between the 8 CPUs.
>
> >From your test case description below,  you have 8 always running
> threads in cgroup A and 8 always running threads in cgroup B and the 2
> cgroups have only 8 CPUs among 80. This should not be a problem for
> load balance. I tried something similar although not exactly the same
> with cgroupv2 and rt-app and I don't have noticeable imbalance
>
> Do you have more details that you can share about your system ?
>
> Which kernel version are you using ? Which arch ?

kernel version: 6.11.0-rc7
arch: X86_64 and cgroup v1

>> Abstracted reproduction case：
>> 1.environment information：
>>
>> [root@localhost ~]# cat /proc/schedstat
>>
>> cpu0
>> domain0 00000000,00000000,00010000,00000000,00000001
>> domain1 00000000,00ffffff,ffff0000,000000ff,ffffffff
>> domain2 ffffffff,ffffffff,ffffffff,ffffffff,ffffffff
>> cpu1
>> domain0 00000000,00000000,00020000,00000000,00000002
>> domain1 00000000,00ffffff,ffff0000,000000ff,ffffffff
>> domain2 ffffffff,ffffffff,ffffffff,ffffffff,ffffffff
>> cpu2
>> domain0 00000000,00000000,00040000,00000000,00000004
>> domain1 00000000,00ffffff,ffff0000,000000ff,ffffffff
>> domain2 ffffffff,ffffffff,ffffffff,ffffffff,ffffffff
>> cpu3
>> domain0 00000000,00000000,00080000,00000000,00000008
>> domain1 00000000,00ffffff,ffff0000,000000ff,ffffffff
>> domain2 ffffffff,ffffffff,ffffffff,ffffffff,ffffffff
> Is it correct to assume that domain0 is SMT, domain1 MC and domain2 PKG  ?
>   and cpu80-83 are in the other group of PKG ? and LLC is at domain1 level ?

domain0 is SMT and domain1 is MC
thread_siblings_list:0,80. 1,81. 2,82. 3,83
LLC is at domain1 level

>> 2.test case:
>>
>> vcpu.c
>> #include <stdio.h>
>> #include <unistd.h>
>>
>> int main()
>> {
>>           sleep(20);
>>           while (1);
>>           return 0;
>> }
>>
>> gcc vcpu.c -o vcpu
>> -----------------------------------------------------------------
>> test.sh
>>
>> #!/bin/bash
>>
>> #vcpu1
>> mkdir /sys/fs/cgroup/cpuset/vcpu_1
>> echo '0-3, 80-83' > /sys/fs/cgroup/cpuset/vcpu_1/cpuset.cpus
>> echo 0 > /sys/fs/cgroup/cpuset/vcpu_1/cpuset.mems
>> for i in {1..8}
>> do
>>           ./vcpu &
>>           pid=$!
>>           sleep 1
>>           echo $pid > /sys/fs/cgroup/cpuset/vcpu_1/tasks
>> done
>>
>> #vcpu2
>> mkdir /sys/fs/cgroup/cpuset/vcpu_2
>> echo '0-3, 80-83' > /sys/fs/cgroup/cpuset/vcpu_2/cpuset.cpus
>> echo 0 > /sys/fs/cgroup/cpuset/vcpu_2/cpuset.mems
>> for i in {1..8}
>> do
>>           ./vcpu &
>>           pid=$!
>>           sleep 1
>>           echo $pid > /sys/fs/cgroup/cpuset/vcpu_2/tasks
>> done
>> ------------------------------------------------------------------
>> [root@localhost ~]# ./test.sh
>>
>> [root@localhost ~]# top -d 1 -c -p $(pgrep -d',' -f vcpu)
>>
>> 14591 root      20   0    2448   1012    928 R 100.0   0.0 13:10.73 ./vcpu
>> 14582 root      20   0    2448   1012    928 R 100.0   0.0 13:12.71 ./vcpu
>> 14606 root      20   0    2448    872    784 R 100.0   0.0 13:09.72 ./vcpu
>> 14620 root      20   0    2448    916    832 R 100.0   0.0 13:07.72 ./vcpu
>> 14622 root      20   0    2448    920    836 R 100.0   0.0 13:06.72 ./vcpu
>> 14629 root      20   0    2448    920    832 R 100.0   0.0 13:05.72 ./vcpu
>> 14643 root      20   0    2448    924    836 R  21.0   0.0 2:37.13 ./vcpu
>> 14645 root      20   0    2448    868    784 R  21.0   0.0 2:36.51 ./vcpu
>> 14589 root      20   0    2448    900    816 R  20.0   0.0 2:45.16 ./vcpu
>> 14608 root      20   0    2448    956    872 R  20.0   0.0 2:42.24 ./vcpu
>> 14632 root      20   0    2448    872    788 R  20.0   0.0 2:38.08 ./vcpu
>> 14638 root      20   0    2448    924    840 R  20.0   0.0 2:37.48 ./vcpu
>> 14652 root      20   0    2448    928    844 R  20.0   0.0 2:36.42 ./vcpu
>> 14654 root      20   0    2448    924    840 R  20.0   0.0 2:36.14 ./vcpu
>> 14663 root      20   0    2448    900    816 R  20.0   0.0 2:35.38 ./vcpu
>> 14669 root      20   0    2448    868    784 R  20.0   0.0 2:35.70 ./vcpu
>>
> .

