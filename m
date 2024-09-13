Return-Path: <linux-kernel+bounces-328622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF89978686
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 19:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55BE11F21276
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 17:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3CD770E4;
	Fri, 13 Sep 2024 17:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MOoqBmrx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EF763C
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 17:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726247849; cv=none; b=Hr/CLeQmEoUxRTQIgD8TgfCT0pMcKtS8Otocu2RkaiC4oYIWiXkJM4IufG6U2YRA+C8LTf5ZW30zz/I9cRz3lKpDO0jpsZcS1TctwhQara3Wt9bc++izjpOvHqLc6W1moclJYRPx/b+oYp2PW8db1fjHzvgl1XhUvP6fHhtVqeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726247849; c=relaxed/simple;
	bh=3eG+Md+SrKGoBoAUTzRpmczQKZQJTpMGDyGoOsI5+vg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q6LvdJcyEWzgK+SxzR0NycJN2vAqekdMIlGxDXjJuegCdnX1VypzOZnexBblRBNN4tsMGZlWXzstzNDiOJM1IuAG7uSkpB1QXnPQlm//piXixmlJPyR3q580cW47eyDTctsGcma0GYGR9UYopcgvERqv+zptzkSdhEH1LqKixRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MOoqBmrx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726247846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q0Wj95DwpzRIl7GLVwqLSOncCPZS51VvSkkKu3Bc+p4=;
	b=MOoqBmrxBzHqwbvHd9B/QcRv54dm61tt40EAskTIkQUqVV6dmzkeTMCtkSGmbqT1oXuS3/
	vTxXpnzYmhrNiTr6GPcZzRJQO1PyhQtNZ3AWtgL1BSTMfMwWGzix4QneBB2HjV/3zmCnPZ
	BV8M3lSS7U01sJMjHf7c4AoyQQjGs5M=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-531-us3m5uDkMyySbDZWiOGXjA-1; Fri,
 13 Sep 2024 13:17:23 -0400
X-MC-Unique: us3m5uDkMyySbDZWiOGXjA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0AD1719560AE;
	Fri, 13 Sep 2024 17:17:21 +0000 (UTC)
Received: from [10.2.16.167] (unknown [10.2.16.167])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E401A19560AA;
	Fri, 13 Sep 2024 17:17:16 +0000 (UTC)
Message-ID: <3fd8aa75-ce1b-4d5a-aada-0b2cfbedb36c@redhat.com>
Date: Fri, 13 Sep 2024 13:17:15 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BQuestion=5D_sched=EF=BC=9Athe_load_is_unbalanced?=
 =?UTF-8?Q?_in_the_VM_overcommitment_scenario?=
To: zhengzucheng <zhengzucheng@huawei.com>, peterz@infradead.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, oleg@redhat.com,
 Frederic Weisbecker <frederic@kernel.org>, mingo@kernel.org,
 peterx@redhat.com, tj@kernel.org, tjcao980311@gmail.com
Cc: linux-kernel@vger.kernel.org
References: <20240725120315.212428-1-zhengzucheng@huawei.com>
 <3e68ccda-1606-9494-f57a-75be9668b83d@huawei.com>
 <cb3a3f3e-727a-4cbb-b4a8-f9469ed4f08d@redhat.com>
 <9982cb8d-9346-0640-dd9f-f68390f922e9@huawei.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <9982cb8d-9346-0640-dd9f-f68390f922e9@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 9/13/24 00:03, zhengzucheng wrote:
> In the VM overcommitment scenario, the overcommitment ratio is 1:2, 8 
> CPUs are overcommitted to 2 x 8u VMs,
> and 16 vCPUs are bound to 8 cpu. However, one VM obtains only 2 CPUs 
> resources, the other VM has 6 CPUs.
> The host is configured with 80 CPUs in a sched domain and other CPUs 
> are in the idle state.
> The root cause is that the load of the host is unbalanced, some vCPUs 
> exclusively occupy CPU resources.
> when the CPU that triggers load balance calculates imbalance value, 
> env->imbalance = 0 is calculated because of
> local->avg_load > sds->avg_load. As a result, the load balance fails.
> The processing logic: 
> https://github.com/torvalds/linux/commit/91dcf1e8068e9a8823e419a7a34ff4341275fb70
>
>
> It's normal from kernel load balance, but it's not reasonable from the 
> perspective of VM users.
> In cgroup v1, set cpuset.sched_load_balance=0 to modify the schedule 
> domain to fix it.
> Is there any other method to fix this problem? thanks.
>
> Abstracted reproduction case：
> 1.environment information：
>
> [root@localhost ~]# cat /proc/schedstat
>
> cpu0
> domain0 00000000,00000000,00010000,00000000,00000001
> domain1 00000000,00ffffff,ffff0000,000000ff,ffffffff
> domain2 ffffffff,ffffffff,ffffffff,ffffffff,ffffffff
> cpu1
> domain0 00000000,00000000,00020000,00000000,00000002
> domain1 00000000,00ffffff,ffff0000,000000ff,ffffffff
> domain2 ffffffff,ffffffff,ffffffff,ffffffff,ffffffff
> cpu2
> domain0 00000000,00000000,00040000,00000000,00000004
> domain1 00000000,00ffffff,ffff0000,000000ff,ffffffff
> domain2 ffffffff,ffffffff,ffffffff,ffffffff,ffffffff
> cpu3
> domain0 00000000,00000000,00080000,00000000,00000008
> domain1 00000000,00ffffff,ffff0000,000000ff,ffffffff
> domain2 ffffffff,ffffffff,ffffffff,ffffffff,ffffffff
>
> 2.test case:
>
> vcpu.c
> #include <stdio.h>
> #include <unistd.h>
>
> int main()
> {
>         sleep(20);
>         while (1);
>         return 0;
> }
>
> gcc vcpu.c -o vcpu
> -----------------------------------------------------------------
> test.sh
>
> #!/bin/bash
>
> #vcpu1
> mkdir /sys/fs/cgroup/cpuset/vcpu_1
> echo '0-3, 80-83' > /sys/fs/cgroup/cpuset/vcpu_1/cpuset.cpus
> echo 0 > /sys/fs/cgroup/cpuset/vcpu_1/cpuset.mems
> for i in {1..8}
> do
>         ./vcpu &
>         pid=$!
>         sleep 1
>         echo $pid > /sys/fs/cgroup/cpuset/vcpu_1/tasks
> done
>
> #vcpu2
> mkdir /sys/fs/cgroup/cpuset/vcpu_2
> echo '0-3, 80-83' > /sys/fs/cgroup/cpuset/vcpu_2/cpuset.cpus
> echo 0 > /sys/fs/cgroup/cpuset/vcpu_2/cpuset.mems
> for i in {1..8}
> do
>         ./vcpu &
>         pid=$!
>         sleep 1
>         echo $pid > /sys/fs/cgroup/cpuset/vcpu_2/tasks
> done
> ------------------------------------------------------------------
> [root@localhost ~]# ./test.sh
>
> [root@localhost ~]# top -d 1 -c -p $(pgrep -d',' -f vcpu)
>
> 14591 root      20   0    2448   1012    928 R 100.0   0.0 13:10.73 
> ./vcpu
> 14582 root      20   0    2448   1012    928 R 100.0   0.0 13:12.71 
> ./vcpu
> 14606 root      20   0    2448    872    784 R 100.0   0.0 13:09.72 
> ./vcpu
> 14620 root      20   0    2448    916    832 R 100.0   0.0 13:07.72 
> ./vcpu
> 14622 root      20   0    2448    920    836 R 100.0   0.0 13:06.72 
> ./vcpu
> 14629 root      20   0    2448    920    832 R 100.0   0.0 13:05.72 
> ./vcpu
> 14643 root      20   0    2448    924    836 R  21.0   0.0 2:37.13 ./vcpu
> 14645 root      20   0    2448    868    784 R  21.0   0.0 2:36.51 ./vcpu
> 14589 root      20   0    2448    900    816 R  20.0   0.0 2:45.16 ./vcpu
> 14608 root      20   0    2448    956    872 R  20.0   0.0 2:42.24 ./vcpu
> 14632 root      20   0    2448    872    788 R  20.0   0.0 2:38.08 ./vcpu
> 14638 root      20   0    2448    924    840 R  20.0   0.0 2:37.48 ./vcpu
> 14652 root      20   0    2448    928    844 R  20.0   0.0 2:36.42 ./vcpu
> 14654 root      20   0    2448    924    840 R  20.0   0.0 2:36.14 ./vcpu
> 14663 root      20   0    2448    900    816 R  20.0   0.0 2:35.38 ./vcpu
> 14669 root      20   0    2448    868    784 R  20.0   0.0 2:35.70 ./vcpu
>
Your script creates two cpusets with the same set of CPUs. The 
scheduling aspect of the tasks, however, are not controlled by cpuset. 
It is controlled by cpu cgroup. I suppose that all these tasks are in 
the same cpu cgroup. It is possible that commit you mentioned might have 
caused some unfairness in allocating CPU time to different processes 
within the same cpu cgroup. Maybe you can try to put them into separate 
cpu cgroups as well with equal weight to see if that can improve the 
scheduling fairness?

BTW, you don't actually need to use 2 different cpusets if they all get 
the same set of CPUs and memory nodes. Also setting 
cpuset.sched_load_balance=0 may not actually get what you want unless 
all the cpusets that use those CPUs have cpuset.sched_load_balance set 0 
including the root cgroup. Turning off this flag may disable load 
balancing, but it may not guarantee fairness depending on what CPUs are 
being used by those tasks when they start unless you explicitly assign 
the CPUs to them when starting these tasks.

Cheers,
Longman


