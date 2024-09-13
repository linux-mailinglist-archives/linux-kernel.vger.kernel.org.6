Return-Path: <linux-kernel+bounces-327860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA1E977BFC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 11:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74934B231A9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 09:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF83F1D6C7A;
	Fri, 13 Sep 2024 09:13:28 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449C41D6C57
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 09:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726218808; cv=none; b=bm2ubhSawQo3LnvMwI3NuLxuaVsDnttz8wpclkAV7uXnti3jXMjBxLlge5x4zdoPByP1LNds40uVA05/ONNVh/3gi9brv3pHCZhQk2f6tM4HbqaMaJ6j5IAI1F7TwR6c8Ya6/eqZJzimayx+CZ2otdVrNgZTlD3MLrhJXJzZa4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726218808; c=relaxed/simple;
	bh=0Z5HKK+AhlLh8QfJrbwPkv9I4sQ/FVl7bCDpfNDaZOQ=;
	h=Message-ID:Date:MIME-Version:To:CC:From:Subject:Content-Type; b=du5Wm1oiH9ymnJrZOrHLSTpAQbEViAPwJkY1usVsoGj9LFhtjiPSZnx4dIpqYwKpqYRgL336STDMCRYE6Dbybc2Sbvc0+cw9kl5+LZFZZTrJDTd5HBFnMobyR+Y2bEsuzvprbgayGGk+nBZ7q8GwNG4+nn6erVjWyTsZDmONGk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4X4pWQ0w5Xz1xv4f;
	Fri, 13 Sep 2024 17:13:22 +0800 (CST)
Received: from kwepemd500019.china.huawei.com (unknown [7.221.188.86])
	by mail.maildlp.com (Postfix) with ESMTPS id EB9BA140134;
	Fri, 13 Sep 2024 17:13:22 +0800 (CST)
Received: from [10.67.109.61] (10.67.109.61) by kwepemd500019.china.huawei.com
 (7.221.188.86) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 13 Sep
 2024 17:13:22 +0800
Message-ID: <67060b2c-b2bb-b01e-c24a-6346e9ccc1fb@huawei.com>
Date: Fri, 13 Sep 2024 17:13:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
To: Peter Zijlstra <peterz@infradead.org>, <mingo@redhat.com>,
	<juri.lelli@redhat.com>, <vincent.guittot@linaro.org>, <rostedt@goodmis.org>,
	<bsegall@google.com>, <mgorman@suse.de>, <vschneid@redhat.com>,
	<vincent.guittot@linaro.org>, <tjcao980311@gmail.com>, zhengzucheng
	<zhengzucheng@huawei.com>
CC: <linux-kernel@vger.kernel.org>
From: zhengzucheng <zhengzucheng@huawei.com>
Subject: =?UTF-8?Q?=5bQuestion=5d_sched=ef=bc=9athe_load_is_unbalanced_in_th?=
 =?UTF-8?Q?e_VM_overcommitment_scenario?=
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd500019.china.huawei.com (7.221.188.86)

In the VM overcommitment scenario, the overcommitment ratio is 1:2, 8 
CPUs are overcommitted to 2 x 8u VMs,
and 16 vCPUs are bound to 8 cpu. However, one VM obtains only 2 CPUs 
resources, the other VM has 6 CPUs.
The host is configured with 80 CPUs in a sched domain and other CPUs are 
in the idle state.
The root cause is that the load of the host is unbalanced, some vCPUs 
exclusively occupy CPU resources.
when the CPU that triggers load balance calculates imbalance value, 
env->imbalance = 0 is calculated because of
local->avg_load > sds->avg_load. As a result, the load balance fails.
(https://github.com/torvalds/linux/commit/91dcf1e8068e9a8823e419a7a34ff4341275fb70) 


It's normal from kernel load balance, but it's not reasonable from the 
perspective of VM users.
In cgroup v1, set cpuset.sched_load_balance=0 to modify the schedule 
domain to fix it.
Is there any other method to fix this problem? thanks!

Abstracted reproduction case：
1.environment information：
[root@localhost ~]# cat /proc/schedstat
cpu0
domain0 00000000,00000000,00010000,00000000,00000001
domain1 00000000,00ffffff,ffff0000,000000ff,ffffffff
domain2 ffffffff,ffffffff,ffffffff,ffffffff,ffffffff
cpu1
domain0 00000000,00000000,00020000,00000000,00000002
domain1 00000000,00ffffff,ffff0000,000000ff,ffffffff
domain2 ffffffff,ffffffff,ffffffff,ffffffff,ffffffff
cpu2
domain0 00000000,00000000,00040000,00000000,00000004
domain1 00000000,00ffffff,ffff0000,000000ff,ffffffff
domain2 ffffffff,ffffffff,ffffffff,ffffffff,ffffffff
cpu3
domain0 00000000,00000000,00080000,00000000,00000008
domain1 00000000,00ffffff,ffff0000,000000ff,ffffffff
domain2 ffffffff,ffffffff,ffffffff,ffffffff,ffffffff

2.test case:
vcpu.c
#include <stdio.h>
#include <unistd.h>

int main()
{
         sleep(20);
         while (1);
         return 0;
}

gcc vcpu.c -o vcpu
-----------------------------------------------------------------
test.sh

#!/bin/bash

#vcpu1
mkdir /sys/fs/cgroup/cpuset/vcpu_1
echo '0-3, 80-83' > /sys/fs/cgroup/cpuset/vcpu_1/cpuset.cpus
echo 0 > /sys/fs/cgroup/cpuset/vcpu_1/cpuset.mems
for i in {1..8}
do
         ./vcpu &
         pid=$!
         sleep 1
         echo $pid > /sys/fs/cgroup/cpuset/vcpu_1/tasks
done

#vcpu2
mkdir /sys/fs/cgroup/cpuset/vcpu_2
echo '0-3, 80-83' > /sys/fs/cgroup/cpuset/vcpu_2/cpuset.cpus
echo 0 > /sys/fs/cgroup/cpuset/vcpu_2/cpuset.mems
for i in {1..8}
do
         ./vcpu &
         pid=$!
         sleep 1
         echo $pid > /sys/fs/cgroup/cpuset/vcpu_2/tasks
done
------------------------------------------------------------------
[root@localhost ~]# ./test.sh
[root@localhost ~]# top -d 1 -c -p $(pgrep -d',' -f vcpu)
14591 root      20   0    2448   1012    928 R 100.0   0.0 13:10.73 ./vcpu
14582 root      20   0    2448   1012    928 R 100.0   0.0 13:12.71 ./vcpu
14606 root      20   0    2448    872    784 R 100.0   0.0 13:09.72 ./vcpu
14620 root      20   0    2448    916    832 R 100.0   0.0 13:07.72 ./vcpu
14622 root      20   0    2448    920    836 R 100.0   0.0 13:06.72 ./vcpu
14629 root      20   0    2448    920    832 R 100.0   0.0 13:05.72 ./vcpu
14643 root      20   0    2448    924    836 R  21.0   0.0 2:37.13 ./vcpu
14645 root      20   0    2448    868    784 R  21.0   0.0 2:36.51 ./vcpu
14589 root      20   0    2448    900    816 R  20.0   0.0 2:45.16 ./vcpu
14608 root      20   0    2448    956    872 R  20.0   0.0 2:42.24 ./vcpu
14632 root      20   0    2448    872    788 R  20.0   0.0 2:38.08 ./vcpu
14638 root      20   0    2448    924    840 R  20.0   0.0 2:37.48 ./vcpu
14652 root      20   0    2448    928    844 R  20.0   0.0 2:36.42 ./vcpu
14654 root      20   0    2448    924    840 R  20.0   0.0 2:36.14 ./vcpu
14663 root      20   0    2448    900    816 R  20.0   0.0 2:35.38 ./vcpu
14669 root      20   0    2448    868    784 R  20.0   0.0 2:35.70 ./vcpu


