Return-Path: <linux-kernel+bounces-250505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 096E292F8A5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 12:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EB2AB21317
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 10:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4F114D71D;
	Fri, 12 Jul 2024 10:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="G+IW7xGz"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D2D10F7
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 10:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720778714; cv=none; b=ZDLfIxg4ZMplfWc0O9fJ2FvUBCgRF9nf70N/5FDuQlhhUV2VgHhbXV5623SoUGa1JfhmBSVKiS3VONH8Dplx5zvEJwJ/Jqgj1ZvXUBOU8erqPfq3nJq0wQdcfLKd0bnX1FYHlIPmCZ1lql51GJAh/Y7mm2LGaeFPEd1NIEGqEjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720778714; c=relaxed/simple;
	bh=tc+7XzPcaoIQzEWHCG0PdKeJQPW2O3ZorjKvGoAOGpI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=amcecVdNWVphqhozGYG0owbo3+W8nlXfpjqJ72+F7N9wGxLB1IxTqzTZBhUbNoe0TDGiFSiehyisv5b5PVRji1vsnX4XgogV7gLojxSFutlN2mQohyd146OdLS3r7ystrVcD0Z4aF/Sozo1d7ZirooDPIScD30LO6VDTeyjAT+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=G+IW7xGz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46C9xGFx003333;
	Fri, 12 Jul 2024 10:05:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=pp1; bh=
	fs9MxcNcBzfjfLyxRv6XONbcW0OoYw1uxvs8C0QeYSc=; b=G+IW7xGzMU9Zi+NN
	rBFeqHKjdKa99MMRq3wZEMkcTsLRMy1RIni7CrcaZ0XMEorJUiB/pM3ggAXBocH6
	H3U6HuN5AzgEgEWPuUz8UWEzwazB4sSb2hllaCCBnZjWwMGaVQb8mF2W5T+3GEMT
	fkaEG6Vxi4waa7q7zy4RkzpArgWpucgkyzWpiN7WWk5Rr8EGUWE70U1QfVp6yyHG
	02Q/oqYf0tKRn8JynQeE7nidD6uTDHLSgPiwHM4R6bmb098Or6isk/i2+t2T+can
	kmRIN8jXYZEf84WWuM/xOp6Ms0V+h0a4+iqjegnVoYZoRVMJ6QaztjmzvXFxLRcc
	gX373A==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40b2b700f3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 10:05:06 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46C8A8kT014004;
	Fri, 12 Jul 2024 10:05:05 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 407jy3njm1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 10:05:05 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46CA52np29033008
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 10:05:05 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CABC25806D;
	Fri, 12 Jul 2024 10:05:02 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0AD7258068;
	Fri, 12 Jul 2024 10:05:01 +0000 (GMT)
Received: from li-34d1fccc-27cd-11b2-a85c-c167793e56f7.ibm.com (unknown [9.204.200.131])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 12 Jul 2024 10:05:00 +0000 (GMT)
Message-ID: <daf2370f5456cbf1660bbdc13621559fb3f2f6cc.camel@linux.ibm.com>
Subject: Re: [sched_ext/for-6.11]: Issue with BPF Scheduler during CPU
 Hotplug
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: Tejun Heo <tj@kernel.org>
Cc: void@manifault.com, linux-kernel@vger.kernel.org, aboorvad@linux.ibm.com
Date: Fri, 12 Jul 2024 15:34:59 +0530
In-Reply-To: <dde4b09001da2641f9679b9409727e2147c5e9a6.camel@linux.ibm.com>
References: <8cd0ec0c4c7c1bc0119e61fbef0bee9d5e24022d.camel@linux.ibm.com>
	 <Zo3PgETt43iFersn@slm.duckdns.org>
	 <dde4b09001da2641f9679b9409727e2147c5e9a6.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-25.el8_9) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _EHBRCpY41kMt5RXgNT1xWl0nvxKIq7U
X-Proofpoint-ORIG-GUID: _EHBRCpY41kMt5RXgNT1xWl0nvxKIq7U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_07,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 mlxscore=0 clxscore=1015 suspectscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2407120070

Hi Tejun,

On Thu, 2024-07-11 at 17:30 +0530, Aboorva Devarajan wrote:

> > It could also be specific to ppc64 (e.g. there's something dependingon fork
> > during CPU hotplug), or at least doesn't happen on x86. I'll probe it a bit
> > more.
> 
> Sure, so far I haven't been able to reproduce the issue on x86, also I'm running
> some tests for a longer duration to see if it can be recreated on x86 as well
> inorder to rule out the possiblity of it being a ppc64 specific issue, it could
> be that the issue occurs much rarer on x86 when compared to ppc64.
> 

I have been able to recreate a similar issue on x86 as well, so this
rules out the possibility of it being ppc64 specific.

---------------------------------------------------------------
Kernel Version:
6.10.0-rc7-next-20240711-sched-ext

System information:
# lscpu
Architecture:         x86_64
CPU op-mode(s):       32-bit, 64-bit
Address sizes:        46 bits physical, 48 bits virtual
Byte Order:           Little Endian
CPU(s):               32
On-line CPU(s) list:  0-31
Vendor ID:            GenuineIntel
Model name:           Intel(R) Xeon(R) CPU E5-2470 0 @ 2.30GHz
CPU family:           6
Model:                45
Thread(s) per core:   2
Core(s) per socket:   8
Socket(s):            2
Stepping:             7
CPU max MHz:          3100.0000
CPU min MHz:          1200.0000

---------------------------------------------------------------
Steps to recreate:

- Run the scx_simple scheduler.

- Run the following script to online and offline CPUs:

    while true
    do
      # Turn off CPUs except 0
      for i in {1..31}
      do
        echo 0 > /sys/devices/system/cpu/cpu$i/online
      done

      # Turn on CPUs
      for i in {1..31}
      do
        echo 1 > /sys/devices/system/cpu/cpu$i/online
      done
    done

- The crash is intermittent and can occur only after hours of running
  the script on x86.

---------------------------------------------------------------
Here's the crash log:

[  487.476415] INFO: task systemd:1 blocked for more than 120 seconds.
[  487.483476]       Tainted: G        W          6.10.0-rc7-next-20240711-sched-ext #6
[  487.492190] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  487.500976] task:systemd         state:D stack:0     pid:1     tgid:1     ppid:0      flags:0x00000002
[  487.511415] Sched_ext: simple (disabling)
[  487.511423] Call Trace:
[  487.518693]  <TASK>
[  487.521094]  __schedule+0x44b/0x1930
[  487.525143]  ? __this_cpu_preempt_check+0x17/0x20
[  487.530462]  schedule+0x4b/0x1a0
[  487.534094]  percpu_rwsem_wait+0x118/0x140
[  487.538715]  ? __pfx_percpu_rwsem_wake_function+0x10/0x10
[  487.544775]  __percpu_down_read+0x7b/0xb0
[  487.549289]  cpus_read_lock+0x86/0x90
[  487.553416]  cpuset_css_online+0x28/0x500
[  487.557935]  online_css+0x31/0xa0
[  487.561673]  cgroup_apply_control_enable+0x25b/0x400
[  487.567248]  cgroup_mkdir+0x16a/0x4d0
[  487.571369]  kernfs_iop_mkdir+0x63/0x90
[  487.575689]  vfs_mkdir+0x18f/0x250
[  487.579532]  do_mkdirat+0x117/0x160
[  487.583473]  __x64_sys_mkdir+0x4d/0x70
[  487.587689]  x64_sys_call+0x1c5a/0x2140
[  487.591996]  do_syscall_64+0x6f/0x110
[  487.596112]  ? debug_smp_processor_id+0x1b/0x30
[  487.601196]  ? irqentry_exit_to_user_mode+0x72/0x1a0
[  487.606773]  ? irqentry_exit+0x3f/0x50
[  487.610980]  ? exc_page_fault+0x96/0x2a0
[  487.615377]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  487.621049] RIP: 0033:0x7f5c8131445b
[  487.625069] RSP: 002b:00007ffd6d569808 EFLAGS: 00000202 ORIG_RAX: 0000000000000053
[  487.633543] RAX: ffffffffffffffda RBX: 000055989335bd00 RCX: 00007f5c8131445b
[  487.641521] RDX: 0000000000000000 RSI: 00000000000001ed RDI: 0000559893389d70
[  487.649514] RBP: 00007f5c818011e8 R08: 0000000000000000 R09: 0000000000000000
[  487.657508] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
[  487.665484] R13: 00000000000007ad R14: 000055989335bd00 R15: 0000000000000003
[  487.673503]  </TASK>
[  487.675971] INFO: task kthreadd:2 blocked for more than 121 seconds.
[  487.683082]       Tainted: G        W          6.10.0-rc7-next-20240711-sched-ext #6
[  487.691745] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  487.700517] task:kthreadd        state:D stack:0     pid:2     tgid:2     ppid:0      flags:0x00004000
[  487.710932] Sched_ext: simple (disabling)
[  487.710940] Call Trace:
[  487.718168]  <TASK>
[  487.720528]  __schedule+0x44b/0x1930
[  487.724542]  ? __this_cpu_preempt_check+0x17/0x20
[  487.729822]  schedule+0x4b/0x1a0
[  487.733440]  percpu_rwsem_wait+0x118/0x140
[  487.738028]  ? __pfx_percpu_rwsem_wake_function+0x10/0x10
[  487.744079]  __percpu_down_read+0x7b/0xb0
[  487.748578]  scx_pre_fork+0x86/0x90
[  487.752505]  sched_fork+0x59/0x1c0
[  487.756313]  copy_process+0x9a8/0x2840
[  487.760544]  ? __this_cpu_preempt_check+0x17/0x20
[  487.765821]  kernel_clone+0xa0/0x4c0
[  487.769821]  ? raw_spin_rq_unlock+0x14/0x40
[  487.774506]  ? sched_clock_noinstr+0xd/0x20
[  487.779197]  ? local_clock_noinstr+0x12/0xf0
[  487.783991]  kernel_thread+0x70/0x90
[  487.787996]  ? __pfx_kthread+0x10/0x10
[  487.792200]  kthreadd+0x2de/0x370
[  487.795937]  ? __pfx_kthreadd+0x10/0x10
[  487.800236]  ret_from_fork+0x40/0x60
[  487.804245]  ? __pfx_kthreadd+0x10/0x10
[  487.808543]  ret_from_fork_asm+0x1a/0x30
[  487.812958]  </TASK>
[  487.815407] INFO: task kworker/0:0:8 blocked for more than 121 seconds.
[  487.822803]       Tainted: G        W          6.10.0-rc7-next-20240711-sched-ext #6
[  487.831468] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  487.840229] task:kworker/0:0     state:D stack:0     pid:8     tgid:8     ppid:2      flags:0x00004000
[  487.850634] Workqueue: events vmstat_shepherd
[  487.855521] Sched_ext: simple (disabling)
[  487.855524] Call Trace:
[  487.862764]  <TASK>
[  487.865124]  __schedule+0x44b/0x1930
[  487.869162]  ? __this_cpu_preempt_check+0x17/0x20
[  487.874438]  schedule+0x4b/0x1a0
[  487.878065]  percpu_rwsem_wait+0x118/0x140
[  487.882664]  ? __pfx_percpu_rwsem_wake_function+0x10/0x10
[  487.888712]  __percpu_down_read+0x7b/0xb0
[  487.893202]  cpus_read_lock+0x86/0x90
[  487.897307]  vmstat_shepherd+0x20/0x120
[  487.901614]  process_one_work+0x21e/0x680
[  487.906120]  ? __this_cpu_preempt_check+0x17/0x20
[  487.911398]  worker_thread+0x194/0x340
[  487.915597]  ? __pfx_worker_thread+0x10/0x10
[  487.920378]  kthread+0xfa/0x130
[  487.923904]  ? __pfx_kthread+0x10/0x10
[  487.928110]  ret_from_fork+0x40/0x60
[  487.932112]  ? __pfx_kthread+0x10/0x10
[  487.936312]  ret_from_fork_asm+0x1a/0x30
[  487.940736]  </TASK>
[  487.943187] INFO: task rcu_tasks_trace:15 blocked for more than 121 seconds.
[  487.951067]       Tainted: G        W          6.10.0-rc7-next-20240711-sched-ext #6
[  487.959732] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  487.968491] task:rcu_tasks_trace state:D stack:0     pid:15    tgid:15    ppid:2      flags:0x00004000
[  487.978897] Sched_ext: simple (disabling)
[  487.978899] Call Trace:
[  487.986129]  <TASK>
[  487.988496]  __schedule+0x44b/0x1930
[  487.992539]  ? __this_cpu_preempt_check+0x17/0x20
[  487.997830]  schedule+0x4b/0x1a0
[  488.001460]  percpu_rwsem_wait+0x118/0x140
[  488.006056]  ? __pfx_percpu_rwsem_wake_function+0x10/0x10
[  488.012112]  __percpu_down_read+0x7b/0xb0
[  488.016608]  cpus_read_lock+0x86/0x90
[  488.020712]  check_all_holdout_tasks_trace+0x40/0x470
[  488.026409]  rcu_tasks_wait_gp+0x1f5/0x360
[  488.031013]  rcu_tasks_one_gp+0x452/0x4c0
[  488.035514]  ? __pfx_rcu_tasks_kthread+0x10/0x10
[  488.040682]  rcu_tasks_kthread+0xb8/0xe0
[  488.045088]  kthread+0xfa/0x130
[  488.048609]  ? __pfx_kthread+0x10/0x10
[  488.052812]  ret_from_fork+0x40/0x60
[  488.056832]  ? __pfx_kthread+0x10/0x10
[  488.061033]  ret_from_fork_asm+0x1a/0x30
[  488.065448]  </TASK>
[  488.067938] INFO: task systemd-journal:800 blocked for more than 121 seconds.
[  488.075917]       Tainted: G        W          6.10.0-rc7-next-20240711-sched-ext #6
[  488.084573] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  488.093348] task:systemd-journal state:D stack:0     pid:800   tgid:800   ppid:1      flags:0x00000002
[  488.103755] Sched_ext: simple (disabling)
[  488.103758] Call Trace:
[  488.111007]  <TASK>
[  488.113381]  __schedule+0x44b/0x1930
[  488.117423]  ? __this_cpu_preempt_check+0x17/0x20
[  488.122690]  schedule+0x4b/0x1a0
[  488.126334]  percpu_rwsem_wait+0x118/0x140
[  488.130935]  ? __pfx_percpu_rwsem_wake_function+0x10/0x10
[  488.137002]  __percpu_down_read+0x7b/0xb0
[  488.141486]  scx_pre_fork+0x86/0x90
[  488.145407]  sched_fork+0x59/0x1c0
[  488.149247]  copy_process+0x9a8/0x2840
[  488.153462]  ? sched_clock_noinstr+0xd/0x20
[  488.158166]  ? sched_clock_noinstr+0xd/0x20
[  488.162872]  kernel_clone+0xa0/0x4c0
[  488.166870]  ? copy_clone_args_from_user+0xa3/0x290
[  488.172362]  __do_sys_clone3+0xc8/0x110
[  488.176706]  ? __secure_computing+0x89/0xe0
[  488.181389]  __x64_sys_clone3+0x1a/0x20
[  488.185710]  x64_sys_call+0x1fca/0x2140
[  488.190006]  do_syscall_64+0x6f/0x110
[  488.194138]  ? syscall_exit_to_user_mode+0x87/0x1c0
[  488.199615]  ? do_syscall_64+0x7b/0x110
[  488.203904]  ? syscall_exit_to_user_mode+0x87/0x1c0
[  488.209390]  ? do_syscall_64+0x7b/0x110
[  488.213679]  ? exc_page_fault+0x96/0x2a0
[  488.218079]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  488.223758] RIP: 0033:0x7f643752683d
[  488.227757] RSP: 002b:00007ffe57fd63b8 EFLAGS: 00000202 ORIG_RAX: 00000000000001b3
[  488.236258] RAX: ffffffffffffffda RBX: 00007ffe57fd6400 RCX: 00007f643752683d
[  488.244239] RDX: 00007f64374947d0 RSI: 0000000000000058 RDI: 00007ffe57fd6400
[  488.252212] RBP: fffffffffffffdc8 R08: 00007f6435a00640 R09: 00007ffe57fd651f
[  488.260213] R10: 0000000000000008 R11: 0000000000000202 R12: 00007f6435a00640
[  488.268203] R13: 0000000000000002 R14: 00007f64374947d0 R15: 00007ffe57fd6560
[  488.276217]  </TASK>
[  488.278715] INFO: task anacron:1537 blocked for more than 121 seconds.
[  488.286010]       Tainted: G        W          6.10.0-rc7-next-20240711-sched-ext #6
[  488.294677] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  488.303426] task:anacron         state:D stack:0     pid:1537  tgid:1537  ppid:1      flags:0x00000002
[  488.313858] Sched_ext: simple (disabling)
[  488.313869] Call Trace:
[  488.321100]  <TASK>
[  488.323444]  __schedule+0x44b/0x1930
[  488.327457]  ? __this_cpu_preempt_check+0x17/0x20
[  488.332736]  schedule+0x4b/0x1a0
[  488.336352]  percpu_rwsem_wait+0x118/0x140
[  488.340945]  ? __pfx_percpu_rwsem_wake_function+0x10/0x10
[  488.346985]  __percpu_down_read+0x7b/0xb0
[  488.351507]  scx_pre_fork+0x86/0x90
[  488.355410]  sched_fork+0x59/0x1c0
[  488.359254]  copy_process+0x9a8/0x2840
[  488.363463]  ? __do_sys_newfstatat+0x3e/0x60
[  488.368266]  kernel_clone+0xa0/0x4c0
[  488.372263]  ? do_syscall_64+0x7b/0x110
[  488.376607]  ? debug_smp_processor_id+0x1b/0x30
[  488.381668]  __do_sys_clone+0x66/0x90
[  488.385819]  __x64_sys_clone+0x29/0x30
[  488.390011]  x64_sys_call+0x1ac3/0x2140
[  488.394311]  do_syscall_64+0x6f/0x110
[  488.398438]  ? syscall_exit_to_user_mode+0x87/0x1c0
[  488.403895]  ? do_syscall_64+0x7b/0x110
[  488.408196]  ? do_syscall_64+0x7b/0x110
[  488.412488]  ? exc_page_fault+0x96/0x2a0
[  488.416884]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  488.422530] RIP: 0033:0x7f3671aeab57
[  488.426530] RSP: 002b:00007ffc8cff27c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
[  488.435009] RAX: ffffffffffffffda RBX: 00007f3671e0d040 RCX: 00007f3671aeab57
[  488.443000] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
[  488.450975] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[  488.458966] R10: 00007f3671db6a10 R11: 0000000000000246 R12: 0000000000000001
[  488.466954] R13: 000055d8160b0f60 R14: 00007ffc8cff2980 R15: 0000000000000005
[  488.474964]  </TASK>
[  488.477487] INFO: task scx_simple:3628 blocked for more than 121 seconds.
[  488.485109]       Tainted: G        W          6.10.0-rc7-next-20240711-sched-ext #6
[  488.493763] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  488.502542] task:scx_simple      state:D stack:0     pid:3628  tgid:3628  ppid:3536   flags:0x00004002
[  488.512957] Sched_ext: simple (disabling)
[  488.512970] Call Trace:
[  488.520204]  <TASK>
[  488.522556]  __schedule+0x44b/0x1930
[  488.526597]  ? __this_cpu_preempt_check+0x17/0x20
[  488.531864]  schedule+0x4b/0x1a0
[  488.535496]  percpu_rwsem_wait+0x118/0x140
[  488.540109]  ? __pfx_percpu_rwsem_wake_function+0x10/0x10
[  488.546157]  __percpu_down_read+0x7b/0xb0
[  488.550673]  cpus_read_lock+0x86/0x90
[  488.554770]  scx_ops_enable.constprop.0+0x36f/0xbd0
[  488.560243]  ? __this_cpu_preempt_check+0x17/0x20
[  488.565516]  ? debug_smp_processor_id+0x1b/0x30
[  488.570594]  ? rcu_is_watching+0x17/0x70
[  488.575031]  ? trace_contention_end+0x6c/0xa0
[  488.579914]  ? __mutex_lock+0x399/0x900
[  488.584249]  ? __anon_inode_getfile+0x8b/0x180
[  488.589220]  ? bpf_struct_ops_link_create+0x105/0x180
[  488.594909]  bpf_scx_reg+0x12/0x20
[  488.598718]  bpf_struct_ops_link_create+0x124/0x180
[  488.604214]  __sys_bpf+0x2005/0x28e0
[  488.608242]  ? syscall_exit_to_user_mode+0x87/0x1c0
[  488.613706]  ? do_syscall_64+0x7b/0x110
[  488.618043]  __x64_sys_bpf+0x1e/0x30
[  488.622042]  x64_sys_call+0x2038/0x2140
[  488.626365]  do_syscall_64+0x6f/0x110
[  488.630461]  ? syscall_exit_to_user_mode+0x87/0x1c0
[  488.635929]  ? do_syscall_64+0x7b/0x110
[  488.640247]  ? debug_smp_processor_id+0x1b/0x30
[  488.645328]  ? syscall_exit_to_user_mode+0x87/0x1c0
[  488.650794]  ? do_syscall_64+0x7b/0x110
[  488.655103]  ? syscall_exit_to_user_mode+0x87/0x1c0
[  488.660591]  ? do_syscall_64+0x7b/0x110
[  488.664881]  ? syscall_exit_to_user_mode+0x87/0x1c0
[  488.670347]  ? do_syscall_64+0x7b/0x110
[  488.674669]  ? debug_smp_processor_id+0x1b/0x30
[  488.679756]  ? syscall_exit_to_user_mode+0x87/0x1c0
[  488.685212]  ? do_syscall_64+0x7b/0x110
[  488.689512]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  488.695170] RIP: 0033:0x7f0e8a11e88d
[  488.699167] RSP: 002b:00007ffc0fac4ad8 EFLAGS: 00000202 ORIG_RAX: 0000000000000141
[  488.707663] RAX: ffffffffffffffda RBX: 00000000ffffffff RCX: 00007f0e8a11e88d
[  488.715637] RDX: 0000000000000040 RSI: 00007ffc0fac4bc0 RDI: 000000000000001c
[  488.723627] RBP: 00007ffc0fac4af0 R08: 00007ffc0fac4bc0 R09: 00007ffc0fac4bc0
[  488.731599] R10: 00005577269fbb30 R11: 0000000000000202 R12: 00005577257de2cd
[  488.739590] R13: 00005577257de200 R14: 00007ffc0fac4cf8 R15: 00005577269a9460
[  488.747607]  </TASK>
[  488.750096] INFO: task sched_ext_ops_h:3629 blocked for more than 122 seconds.
[  488.758223]       Tainted: G        W          6.10.0-rc7-next-20240711-sched-ext #6
[  488.766883] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  488.775646] task:sched_ext_ops_h state:D stack:0     pid:3629  tgid:3629  ppid:2      flags:0x00004000
[  488.786079] Sched_ext: simple (disabling)
[  488.786082] Call Trace:
[  488.793303]  <TASK>
[  488.795648]  __schedule+0x44b/0x1930
[  488.799679]  ? __this_cpu_preempt_check+0x17/0x20
[  488.804958]  schedule+0x4b/0x1a0
[  488.808583]  schedule_preempt_disabled+0x1c/0x30
[  488.813748]  __mutex_lock+0x51b/0x900
[  488.817880]  ? scx_ops_disable_workfn+0xe0/0x580
[  488.823071]  mutex_lock_nested+0x1f/0x30
[  488.827448]  ? mutex_lock_nested+0x1f/0x30
[  488.832044]  scx_ops_disable_workfn+0xe0/0x580
[  488.837048]  ? _raw_spin_unlock+0x31/0x60
[  488.841531]  ? raw_spin_rq_unlock+0x14/0x40
[  488.846213]  ? sched_clock_noinstr+0xd/0x20
[  488.850900]  ? local_clock_noinstr+0x12/0xf0
[  488.855709]  ? sched_clock_noinstr+0xd/0x20
[  488.860398]  ? __this_cpu_preempt_check+0x17/0x20
[  488.865697]  kthread_worker_fn+0xbb/0x2e0
[  488.870188]  ? __pfx_scx_ops_disable_workfn+0x10/0x10
[  488.875848]  ? __pfx_kthread_worker_fn+0x10/0x10
[  488.881021]  kthread+0xfa/0x130
[  488.884548]  ? __pfx_kthread+0x10/0x10
[  488.888744]  ret_from_fork+0x40/0x60
[  488.892747]  ? __pfx_kthread+0x10/0x10
[  488.896939]  ret_from_fork_asm+0x1a/0x30
[  488.901359]  </TASK>
[  488.903798] INFO: task bash:3633 blocked for more than 122 seconds.
[  488.910811]       Tainted: G        W          6.10.0-rc7-next-20240711-sched-ext #6
[  488.919477] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  488.928258] task:bash            state:D stack:0     pid:3633  tgid:3633  ppid:3599   flags:0x00004006
[  488.938670] Sched_ext: simple (disabling)
[  488.938672] Call Trace:
[  488.945926]  <TASK>
[  488.948280]  __schedule+0x44b/0x1930
[  488.952329]  ? __this_cpu_preempt_check+0x17/0x20
[  488.957616]  schedule+0x4b/0x1a0
[  488.961239]  schedule_timeout+0x116/0x120
[  488.965767]  __wait_for_common+0x91/0x180
[  488.970270]  ? __pfx_schedule_timeout+0x10/0x10
[  488.975360]  wait_for_completion+0x28/0x30
[  488.979943]  __cpuhp_kick_ap+0x6c/0x80
[  488.984156]  cpuhp_bringup_ap+0x149/0x260
[  488.988677]  ? __pfx_cpuhp_bringup_ap+0x10/0x10
[  488.993746]  cpuhp_invoke_callback+0x159/0x2f0
[  488.998743]  ? __pfx_trace_rb_cpu_prepare+0x10/0x10
[  489.004231]  __cpuhp_invoke_callback_range+0x79/0xf0
[  489.009814]  _cpu_up+0x10e/0x290
[  489.013453]  cpu_up+0xb0/0x110
[  489.016893]  cpu_device_up+0x1d/0x30
[  489.020899]  cpu_subsys_online+0x5e/0x130
[  489.025436]  device_online+0x6f/0x90
[  489.029472]  online_store+0xa4/0xe0
[  489.033378]  dev_attr_store+0x1b/0x30
[  489.037513]  sysfs_kf_write+0x4f/0x70
[  489.041613]  kernfs_fop_write_iter+0x172/0x230
[  489.046615]  vfs_write+0x369/0x480
[  489.050478]  ksys_write+0x71/0xf0
[  489.054210]  __x64_sys_write+0x1d/0x30
[  489.058413]  x64_sys_call+0x16b3/0x2140
[  489.062714]  do_syscall_64+0x6f/0x110
[  489.066842]  ? debug_smp_processor_id+0x1b/0x30
[  489.071921]  ? syscall_exit_to_user_mode+0x87/0x1c0
[  489.077407]  ? do_syscall_64+0x7b/0x110
[  489.081695]  ? do_syscall_64+0x7b/0x110
[  489.085995]  ? syscall_exit_to_user_mode+0x87/0x1c0
[  489.091481]  ? do_syscall_64+0x7b/0x110
[  489.095777]  ? sysvec_call_function+0x76/0xf0
[  489.100681]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  489.106348] RIP: 0033:0x7f468e314887
[  489.110345] RSP: 002b:00007fffe2d5bf68 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[  489.118830] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f468e314887
[  489.126812] RDX: 0000000000000002 RSI: 0000561770d46100 RDI: 0000000000000001
[  489.134802] RBP: 0000561770d46100 R08: 00007f468e3d1460 R09: 000000007fffffff
[  489.142785] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
[  489.150760] R13: 00007f468e41b780 R14: 00007f468e417600 R15: 00007f468e416a00
[  489.158759]  </TASK>
[  489.161225] 
[  489.161225] Showing all locks held in the system:
[  489.168159] 4 locks held by systemd/1:
[  489.172351]  #0: ffff9b2b46118450 (sb_writers#9){....}-{0:0}, at: filename_create+0x63/0x160
[  489.181808]  #1: ffff9b2c2025c988 (&type->i_mutex_dir_key#7/1){....}-{3:3}, at: filename_create+0xa2/0x160
[  489.192633]  #2: ffffffffa8487790 (cgroup_mutex){....}-{3:3}, at: cgroup_kn_lock_live+0x52/0x150
[  489.202477]  #3: ffffffffa82a38a0 (cpu_hotplug_lock){....}-{0:0}, at: cpuset_css_online+0x28/0x500
[  489.212540] 1 lock held by kthreadd/2:
[  489.216731]  #0: ffffffffa82c2ba0 (scx_fork_rwsem){....}-{0:0}, at: sched_fork+0x59/0x1c0
[  489.225908] 3 locks held by kworker/0:0/8:
[  489.230486]  #0: ffff9b2b40051358 ((wq_completion)events){....}-{0:0}, at: process_one_work+0x3f5/0x680
[  489.241008]  #1: ffffab14001b7e40 ((shepherd).work){....}-{0:0}, at: process_one_work+0x1d6/0x680
[  489.250955]  #2: ffffffffa82a38a0 (cpu_hotplug_lock){....}-{0:0}, at: vmstat_shepherd+0x20/0x120
[  489.260816] 2 locks held by rcu_tasks_trace/15:
[  489.265880]  #0: ffffffffa83af720 (rcu_tasks_trace.tasks_gp_mutex){....}-{3:3}, at: rcu_tasks_one_gp+0x31f/0x4c0
[  489.277272]  #1: ffffffffa82a38a0 (cpu_hotplug_lock){....}-{0:0}, at: check_all_holdout_tasks_trace+0x40/0x470
[  489.288486] 3 locks held by cpuhp/8/65:
[  489.292780]  #0: ffffffffa82a38a0 (cpu_hotplug_lock){....}-{0:0}, at: cpuhp_thread_fun+0x87/0x260
[  489.302712]  #1: ffffffffa82a5fc0 (cpuhp_state-up){....}-{0:0}, at: cpuhp_thread_fun+0x87/0x260
[  489.312450]  #2: ffffffffa82b1e70 (wq_pool_mutex){....}-{3:3}, at: workqueue_online_cpu+0x3d/0x3c0
[  489.322522] 1 lock held by khungtaskd/216:
[  489.327103]  #0: ffffffffa83b0040 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x3b/0x140
[  489.337164] 1 lock held by systemd-journal/800:
[  489.342229]  #0: ffffffffa82c2ba0 (scx_fork_rwsem){....}-{0:0}, at: sched_fork+0x59/0x1c0
[  489.351415] 1 lock held by wqtimer/2197:
[  489.355802]  #0: ffffffffa82c2ba0 (scx_fork_rwsem){....}-{0:0}, at: sched_fork+0x59/0x1c0
[  489.364980] 1 lock held by anacron/1537:
[  489.369366]  #0: ffffffffa82c2ba0 (scx_fork_rwsem){....}-{0:0}, at: sched_fork+0x59/0x1c0
[  489.378541] 1 lock held by in:imklog/1594:
[  489.383121]  #0: ffff9b42a8abf0d8 (&f->f_pos_lock){....}-{3:3}, at: __fdget_pos+0x4d/0x70
[  489.392309] 1 lock held by gdm3/1906:
[  489.396405]  #0: ffffffffa82c2ba0 (scx_fork_rwsem){....}-{0:0}, at: sched_fork+0x59/0x1c0
[  489.405585] 2 locks held by sh/1963:
[  489.409582]  #0: ffff9b2c204508a8 (&tty->ldisc_sem){....}-{0:0}, at: ldsem_down_read+0x29/0x40
[  489.419224]  #1: ffffab140dcaf2f8 (&ldata->atomic_read_lock){....}-{3:3}, at: n_tty_read+0x563/0x690
[  489.429483] 4 locks held by scx_simple/3628:
[  489.434258]  #0: ffffffffa84b4e50 (update_mutex){....}-{3:3}, at: bpf_struct_ops_link_create+0x105/0x180
[  489.444892]  #1: ffffffffa82c2c50 (scx_ops_enable_mutex){....}-{3:3}, at: scx_ops_enable.constprop.0+0x60/0xbd0
[  489.456199]  #2: ffffffffa82c2ba0 (scx_fork_rwsem){....}-{0:0}, at: scx_ops_enable.constprop.0+0x36a/0xbd0
[  489.467021]  #3: ffffffffa82a38a0 (cpu_hotplug_lock){....}-{0:0}, at: scx_ops_enable.constprop.0+0x36f/0xbd0
[  489.478027] 1 lock held by sched_ext_ops_h/3629:
[  489.483198]  #0: ffffffffa82c2c50 (scx_ops_enable_mutex){....}-{3:3}, at: scx_ops_disable_workfn+0xe0/0x580
[  489.494120] 7 locks held by bash/3633:
[  489.498319]  #0: ffff9b2b44385450 (sb_writers#6){....}-{0:0}, at: ksys_write+0x71/0xf0
[  489.507193]  #1: ffff9b2c22223c90 (&of->mutex){....}-{3:3}, at: kernfs_fop_write_iter+0x122/0x230
[  489.517141]  #2: ffff9b2b44b11148 (kn->active#150){....}-{0:0}, at: kernfs_fop_write_iter+0x12a/0x230
[  489.527500]  #3: ffffffffa85de5b0 (device_hotplug_lock){....}-{3:3}, at: online_store+0x47/0xe0
[  489.537245]  #4: ffff9b424fa04b98 (&dev->mutex){....}-{3:3}, at: device_online+0x29/0x90
[  489.546326]  #5: ffffffffa82a3950 (cpu_add_remove_lock){....}-{3:3}, at: cpu_up+0x7d/0x110
[  489.555585]  #6: ffffffffa82a38a0 (cpu_hotplug_lock){....}-{0:0}, at: _cpu_up+0x49/0x290
[  489.564673] 
[  489.566342] =============================================
[  489.566342] 


Thanks,
Aboorva


