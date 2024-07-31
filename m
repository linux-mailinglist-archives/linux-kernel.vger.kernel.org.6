Return-Path: <linux-kernel+bounces-268653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA61942759
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 09:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A68CC284151
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 07:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69821A4B48;
	Wed, 31 Jul 2024 07:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="aCZ3bIua"
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F98216CD03
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 07:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722409497; cv=none; b=oBLubQLDqShojfot3NEbvSzze54FDO80tSZWhe2Wvr6q/6YF7f2W7FXr5tChzAWECrpnlh0RuZSvQ3nsR3rNzTE9AcZnwMun2+vNh7x+zXvWOk0kugBk0vyknKxd72m5T9sZErZwluXTV/ZgPvbdHHQ11LFpjLpd0ouC1cTXAQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722409497; c=relaxed/simple;
	bh=JHWrdN3XPtAoJsvyecTXCrelaYVl1H0OyHD5tiDwsXM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GZMhFUNZi0z93m+OjsZbeZAnRuh9iYqTdh9YcM5xfco6JIvOPMLbIL/LDd1QuVGYI2V2WjEmJT4AkbBGb5KYYYXZI0xHMuiO1t5eDaCl3lm+VWqnoagL06yDLi7+Dekh/jHNEEvh8nWgdpnuHv9jmJIRjWO9pHKjsJl5/Lvv9Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=aCZ3bIua; arc=none smtp.client-ip=45.254.50.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=KTm95
	tSB4EIVW6oc69ri6UXWlXFR3I0/IZFpduIfOq8=; b=aCZ3bIuaVEAaSIMrDd6+k
	8om68qu8hUh/+MOVWyiflNV3L/6yTUv9jwoYJN8b3EnctehkjgMV4mHq0KK16ree
	v9Vy9Yk1CW1Id4b6IGHqO/P3E/RS13oN3uzRp4rmTIPD437/FpDLWT0dBrqswqMp
	WtljbbZuRPAeTKhxROYZ6E=
Received: from localhost.localdomain (unknown [139.227.195.24])
	by gzga-smtp-mta-g0-3 (Coremail) with SMTP id _____wC3fyb24almN152FA--.15610S2;
	Wed, 31 Jul 2024 15:04:23 +0800 (CST)
From: Ping Gan <jacky_gam_2001@163.com>
To: sagi@grimberg.me,
	hare@suse.de,
	hch@lst.de
Cc: ping.gan@dell.com,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] nvmet: use unbound_wq for RDMA and TCP by default
Date: Wed, 31 Jul 2024 15:03:25 +0800
Message-Id: <20240731070326.76090-1-jacky_gam_2001@163.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <b3592bca-015f-451e-b689-8db820cbc7a6@grimberg.me>
References: <b3592bca-015f-451e-b689-8db820cbc7a6@grimberg.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3fyb24almN152FA--.15610S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3ArWkWFW3tryxWw18WFyUZFb_yoW7tr48pF
	WrAa4UtFZrCFW3G39rWFyIkr17Ca1xXw15X3W8uryjkryYvFy3ArWvyw43X3Z2gr10g34U
	ZFWDXrs0ya9Iqa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U7HUkUUUUU=
X-CM-SenderInfo: 5mdfy55bjdzsisqqiqqrwthudrp/1tbiKBwtKWXAmjsqGAABsH

> On 26/07/2024 5:34, Ping Gan wrote:
>>> On 19/07/2024 12:19, Ping Gan wrote:
>>>> When running nvmf on SMP platform, current nvme target's RDMA and
>>>> TCP use bounded workqueue to handle IO, but when there is other
>>>> high
>>>> workload on the system(eg: kubernetes), the competition between the
>>>> bounded kworker and other workload is very radical. To decrease the
>>>> resource race of OS among them, this patchset will switch to
>>>> unbounded
>>>> workqueue for nvmet-rdma and nvmet-tcp; besides that, it can also
>>>> get some performance improvement. And this patchset bases on
>>>> previous
>>>> discussion from below session.
>>>>
>>>> https://lore.kernel.org/lkml/20240719084953.8050-1-jacky_gam_2001@163.com/
>>> Hold your horses.
>>>
>>> This cannot be just switched without a thorough testing and actual
>>> justification/proof of
>>> a benefit beyond just a narrow use-case brought initially by Ping
>>> Gan.
>>>
>>> If the ask is to universally use an unbound workqueue, please
>>> provide
>>> detailed
>>> benchmarking convincing us that this makes sense.
>> So you think we should not do a radical change for the narrow usecase
>> but
>> keep the parameter to enable it in previous version patch, right?
>
> What I'm saying is that if you want to change the default, please
> provide
> justification in the form of benchmarks that support the change. This
> benchmarks should include both throughput, iops and latency
> measurements
> and without the cpu-set constraints you presented originally.

We tested it on our testbed which has 4 numa 96 cores, 190GB memory
and 24 nvme disks, it seems unbound_wq has pretty improvment.  The 
creating target test script is below:

#!/bin/bash
if [ "$#" -ne 3 ] ; then
echo "$0 addr_trtype(tcp/rdma) target_IP target_port"
exit -1
fi
addr_trtype=$1
target_IP=$2
target_port=$3
# there are 24 nvme disks on the testbed
disk_list=(nvme0n1 nvme1n1 nvme2n1 nvme3n1 nvme4n1 nvme5n1 nvme6n1
nvme7n1 nvme8n1 nvme9n1 nvme10n1 nvme11n1 nvme12n1 nvme13n1 nvme14n1
nvme15n1 nvme16n1 nvme17n1 nvme18n1 nvme19n1 nvme20n1 nvme21n1 nvme22n1
nvme23n1)
# create target with multiple disks
create_target_multi_disks() {
        local nqn_name=$1
        local svr_ip=$2
        local svr_port=$3
        local i
        local blk_dev
        local blk_dev_idx=0
        local port_idx=25
        echo "create target: $nqn_name $svr_ip $svr_port"
        mkdir /sys/kernel/config/nvmet/subsystems/${nqn_name}
        echo 1
>/sys/kernel/config/nvmet/subsystems/${nqn_name}/attr_allow_any_host
        for((i=0;i<${#disk_list[@]};i++)); do
                blk_dev_idx=$((${blk_dev_idx}+1))
                blk_dev=/dev/${disk_list[$i]}
                mkdir
/sys/kernel/config/nvmet/subsystems/${nqn_name}/namespaces/${blk_dev_idx}
                echo  ${blk_dev} >
/sys/kernel/config/nvmet/subsystems/${nqn_name}/namespaces/${blk_dev_idx}/device_path
                echo 1 >
/sys/kernel/config/nvmet/subsystems/${nqn_name}/namespaces/${blk_dev_idx}/enable
        done
        mkdir /sys/kernel/config/nvmet/ports/${port_idx}
        echo ${addr_trtype}
>/sys/kernel/config/nvmet/ports/${port_idx}/addr_trtype
        echo ipv4
>/sys/kernel/config/nvmet/ports/${port_idx}/addr_adrfam
        echo ${svr_ip}
>/sys/kernel/config/nvmet/ports/${port_idx}/addr_traddr
        echo ${svr_port}
>/sys/kernel/config/nvmet/ports/${port_idx}/addr_trsvcid
        ln -s /sys/kernel/config/nvmet/subsystems/${nqn_name}/
/sys/kernel/config/nvmet/ports/${port_idx}/subsystems/${nqn_name}
}
nvmetcli clear
nqn_name="testnqn_25"
mkdir /sys/kernel/config/nvmet/hosts/hostnqn
create_target_multi_disks ${nqn_name} ${target_IP} ${target_port}

And the simulation of high workload program is below:

#define _GNU_SOURCE
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <pthread.h>
#include <sched.h>
#define THREAD_NUM  (85)
#define MALLOC_SIZE (104857600)
void *loopcostcpu(void *args)
{
        sleep(1);
        int *core_id = (int *)args;
        cpu_set_t cpuset;
        CPU_ZERO(&cpuset);
        CPU_SET(*core_id, &cpuset);
        sched_setaffinity(0, sizeof(cpuset), &cpuset);
        nice(-20);
        long *pt = malloc(MALLOC_SIZE*sizeof(long));
        if (!pt) {
                printf("error malloc\n");
                return;
        }
        long i = 0;
        while (1) {
                for (i = 0; i < MALLOC_SIZE; i++) {
                        pt[i] = i;
                }
                //sleep 10ms
                usleep(10000);
        }
        return;
}
int main(int argc, char *argv[])
{
        pthread_t tid[THREAD_NUM];
        int core_id[THREAD_NUM];
        int result, i, j = 1;
        for (i = 0; i < THREAD_NUM; i++) {
                core_id[i] = j;
                j++;
                result = pthread_create(&tid[i], NULL, loopcostcpu,
									(void*)
&core_id[i]);
                if (result) {
                        printf("create thread %d failure\n", i);
                }
        }
        while(1)
                sleep(5);
        return 0;
}

When running above program on target testbed, and we reserved 8
cores(88-95) for nvmet target io threads(both rdma and tcp), then we
used spdk perf(V20.04) as initiator to create 8 IO queues and per
queue has 32 queue depths and 1M randrw io size on another testbed 
to verify it. 
TCP's test command shown below:
./spdk_perf_tcp -q 32 -S -P 8 -s 4096 -w randrw -t 300 -c 0xff00000 -o
1048576 -M 50 -r 'trtype:TCP adrfam:IPv4 traddr:169.254.2.104
trsvcid:4444'
RDMA's test command shown below:
./spkd_perf_rdma -q 32 -S -P 8 -s 4096 -w randrw -t 300 -c 0xff00000 -o
1048576 -M 50 -r 'trtype:RDMA adrfam:IPv4 traddr:169.254.2.104
trsvcid:4444'
And we got below test results:
TCP's unbound_wq:  IOPS:4585.64, BW:4585.64 MiB/s, Avglat:167515.56us
TCP's bound_wq:    IOPS:3588.40, BW:3588.40 MiB/s, Avglat:214088.55us
RDMA's unbound_wq: IOPS:6421.47, BW:6421.47 MiB/s, Avglat:119605.17us
RDMA's bound_wq:   IOPS:5919.94, BW:5919.94 MiB/s, Avglat:129744.70us

It seems using unbound_wq to decreasing competition of CPU between 
target IO worker thread and other high workload does make sense.

Thanks,
Ping



