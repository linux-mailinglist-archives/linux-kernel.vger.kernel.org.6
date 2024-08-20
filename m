Return-Path: <linux-kernel+bounces-293404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EB8957EE9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A484AB21C58
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 07:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A88454652;
	Tue, 20 Aug 2024 07:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ktj9OTDW"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059F218E35D
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 07:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724137428; cv=none; b=mhPAaxZMbpC54kJOZq62EXryXcq4V2+OpfYuecLlweMQDCnDW8l+2YOa0qWlVExQXspQzoEhrfQEWqJIN/nCZoWODFgik9IK/dGHU7qqNLbinrB1IDPbn2dmVZteiBH0UhiFjDmB1pygEqto6vyEWtzWfpC88p9qICs7r5GDYBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724137428; c=relaxed/simple;
	bh=AA+jeEnNuZu75rlWl1xmf6sNlgeP9iNdJDpL8dgE9qA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=hU0b67wOfeK6MnlLkM6HJ6BsttYS3ovX65P1P1sa6IGP2SPYi2AKUv1PdHPYdunBMjklypfOCVigiaY9dbkEF/hgvT0oGL/79UpA5rfA5X4tOhJdj/FOm5vW+cTRv0bSE3L6lHFu4dVfwfUsARtTfLTBWou4/IuLQgKYBRdJvXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ktj9OTDW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47JGjkZ1032420;
	Tue, 20 Aug 2024 07:03:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=pp1; bh=
	TzelmddzG4C2UQOtLQfYIWBw2jDS2CxQ9aMjzYC1biQ=; b=ktj9OTDWulKQN/5f
	n2DN0tJ7sXdzr3aUT6NE1FQ+zHmehdF2ziTTAfXRYzZuJKsTWLJ4ffwDhTcKxQ8E
	FC+eFGOf0ADh7pXwVBFYEJFJnmT5+EKmOIjZ8anemVO37ZrD+3E06dctwkXy9LPC
	vtsRZ8/HqW9yuiSSSHSmDhje+oL+ODq7QYnEmbS/BI0qf0oT7cY1U4DJ3FPws1nj
	1EZVQMHuUwnZAFrSU6S3XEaFwB5yz95WfxdqsmQi3VboKnF0/xMry61gzXiJsMa+
	fqXIrBV2t7U4LsAAr60qCi5fEslPVvSJGx2Fb0Kgy8pJPo20GvJIZWqX2bA0j2DG
	owYhxg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mbfuv5p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 07:03:40 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47K2PVFU014171;
	Tue, 20 Aug 2024 07:03:39 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4137pmsmg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 07:03:39 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47K73b1j27525744
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 07:03:39 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4493C58051;
	Tue, 20 Aug 2024 07:03:37 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A4A35805A;
	Tue, 20 Aug 2024 07:03:35 +0000 (GMT)
Received: from li-34d1fccc-27cd-11b2-a85c-c167793e56f7.ibm.com (unknown [9.43.62.216])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 20 Aug 2024 07:03:35 +0000 (GMT)
Message-ID: <fa56b39990dd0b90f971018f5abb7352c60af3b1.camel@linux.ibm.com>
Subject: Re: [sched_ext/for-6.11]: Issue with BPF Scheduler during CPU
 Hotplug
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: Tejun Heo <tj@kernel.org>
Cc: void@manifault.com, linux-kernel@vger.kernel.org, aboorvad@linux.ibm.com
Date: Tue, 20 Aug 2024 12:33:34 +0530
In-Reply-To: <Zru5_UmEmWhNaPyo@slm.duckdns.org>
References: <8cd0ec0c4c7c1bc0119e61fbef0bee9d5e24022d.camel@linux.ibm.com>
	 <Zo3PgETt43iFersn@slm.duckdns.org>
	 <dde4b09001da2641f9679b9409727e2147c5e9a6.camel@linux.ibm.com>
	 <daf2370f5456cbf1660bbdc13621559fb3f2f6cc.camel@linux.ibm.com>
	 <Zq1NksrG9blyN-KR@slm.duckdns.org>
	 <e3069da05fb1676f8faad88b9a4dfc4a6cef4175.camel@linux.ibm.com>
	 <Zru5_UmEmWhNaPyo@slm.duckdns.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-26.el8_10) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0BKsMyCNXBZGh-CGzLOi1AHlU8o0tZnt
X-Proofpoint-ORIG-GUID: 0BKsMyCNXBZGh-CGzLOi1AHlU8o0tZnt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_16,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 bulkscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 phishscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408200051

On Tue, 2024-08-13 at 09:54 -1000, Tejun Heo wrote:
> Hello,
> 
> On Sat, Aug 10, 2024 at 11:54:24PM +0530, Aboorva Devarajan wrote:
> ...
> ...

> Can you trigger sysrq-t when the system is stuck? Also, can you see whether
> the problem is reproducible on x86 w/ the wq changes applied?

Hi Tejun,

I couldn't trigger sysrq-t so far as the system becomes unresponsive,
will get back if I can successfully trigger this via console. 

And yes, this issue also occurs on x86 when applying the proposed workqueue
patch on top of the recent sched-ext for-6.12 tree. However, it takes
significantly longer to hit the issue, and the stack trace differs
a bit.

Here is the trace on x86:
...
9.374534] sched_ext: BPF scheduler "simple" disabled (unregistered from the main kernel)
[10779.374809] smpboot: Booting Node 1 Processor 27 APIC 0x27
[10779.594551] sched_ext: BPF scheduler "simple" disabled (unregistered from the main kernel)
[10779.594788] smpboot: Booting Node 1 Processor 28 APIC 0x29
[10779.790551] sched_ext: BPF scheduler "simple" disabled (unregistered from the main kernel)
[10779.790804] smpboot: Booting Node 1 Processor 29 APIC 0x2b
[10779.990527] sched_ext: BPF scheduler "simple" disabled (unregistered from the main kernel)
[10779.990762] smpboot: Booting Node 1 Processor 30 APIC 0x2d
[10780.186553] sched_ext: BPF scheduler "simple" disabled (unregistered from the main kernel)
[10780.198737] smpboot: Booting Node 1 Processor 31 APIC 0x2f
[10780.556624] smpboot: CPU 1 is now offline
[10780.773765] smpboot: CPU 2 is now offline
[10780.984782] smpboot: CPU 3 is now offline
[10781.030533] sched_ext: BPF scheduler "simple" disabled (unregistered from the main kernel)
[10781.224421] smpboot: CPU 4 is now offline
[10781.408442] smpboot: CPU 5 is now offline
[10781.627324] smpboot: CPU 6 is now offline
[10781.824777] smpboot: CPU 7 is now offline
[10781.878540] sched_ext: BPF scheduler "simple" disabled (unregistered from the main kernel)
[10782.088456] smpboot: CPU 8 is now offline
[10782.296472] smpboot: CPU 9 is now offline
[10782.504424] smpboot: CPU 10 is now offline
[10782.696423] smpboot: CPU 11 is now offline
[10782.734601] sched_ext: BPF scheduler "simple" disabled (unregistered from the main kernel)
[10782.948499] smpboot: CPU 12 is now offline
[10999.932491] INFO: task kthreadd:2 blocked for more than 120 seconds.
[10999.939871]       Not tainted 6.11.0-rc1-sched-ext-g2f88de3b86bf #2
[10999.946938] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[10999.955740] task:kthreadd        state:D stack:0     pid:2     tgid:2     ppid:0      flags:0x00004000
[10999.966210] Sched_ext: simple (disabling)
[10999.966220] Call Trace:
[10999.973536]  <TASK>
[10999.975926]  __schedule+0x47e/0x19d0
[10999.979993]  ? __this_cpu_preempt_check+0x17/0x20
[10999.985351]  schedule+0x4b/0x1a0
[10999.989000]  percpu_rwsem_wait+0x118/0x140
[10999.993639]  ? __pfx_percpu_rwsem_wake_function+0x10/0x10
[10999.999745]  __percpu_down_read+0x7b/0xb0
[11000.004255]  scx_pre_fork+0xd1/0xf0
[11000.008194]  sched_fork+0x59/0x1c0
[11000.012034]  copy_process+0xa69/0x2b10
[11000.016279]  ? sched_clock_noinstr+0xd/0x20
[11000.021006]  kernel_clone+0xa0/0x3d0
[11000.025040]  kernel_thread+0x70/0x90
[11000.029099]  ? __pfx_kthread+0x10/0x10
[11000.033340]  kthreadd+0x2f6/0x3a0
[11000.037097]  ? __pfx_kthreadd+0x10/0x10
[11000.041423]  ret_from_fork+0x40/0x60
[11000.045468]  ? __pfx_kthreadd+0x10/0x10
[11000.049800]  ret_from_fork_asm+0x1a/0x30
[11000.054265]  </TASK>
[11000.056781] INFO: task rcu_tasks_trace:15 blocked for more than 120 seconds.
[11000.064719]       Not tainted 6.11.0-rc1-sched-ext-g2f88de3b86bf #2
[11000.071751] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[11000.080538] task:rcu_tasks_trace state:D stack:0     pid:15    tgid:15    ppid:2      flags:0x00004000
[11000.090982] Sched_ext: simple (disabling)
[11000.090986] Call Trace:
[11000.098249]  <TASK>
[11000.100620]  __schedule+0x47e/0x19d0
[11000.104685]  ? __this_cpu_preempt_check+0x17/0x20
[11000.109982]  schedule+0x4b/0x1a0
[11000.113619]  percpu_rwsem_wait+0x118/0x140
[11000.118211]  ? __pfx_percpu_rwsem_wake_function+0x10/0x10
[11000.124325]  __percpu_down_read+0x7b/0xb0
[11000.128836]  cpus_read_lock+0xd1/0xf0
[11000.132964]  rcu_tasks_trace_pregp_step+0xa2/0x700
[11000.138362]  ? __mutex_lock+0x388/0x8e0
[11000.142710]  rcu_tasks_wait_gp+0x5f/0x430
[11000.147208]  ? __this_cpu_preempt_check+0x17/0x20
[11000.152499]  rcu_tasks_one_gp+0x474/0x4e0
[11000.157028]  ? __pfx_rcu_tasks_kthread+0x10/0x10
[11000.162205]  rcu_tasks_kthread+0xb8/0xe0
[11000.166642]  kthread+0xfa/0x130
[11000.170171]  ? __pfx_kthread+0x10/0x10
[11000.174416]  ret_from_fork+0x40/0x60
[11000.178434]  ? __pfx_kthread+0x10/0x10
[11000.182667]  ret_from_fork_asm+0x1a/0x30
[11000.187096]  </TASK>
[11000.189581] INFO: task cpuhp/13:95 blocked for more than 121 seconds.
[11000.196833]       Not tainted 6.11.0-rc1-sched-ext-g2f88de3b86bf #2
[11000.203863] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[11000.212646] task:cpuhp/13        state:D stack:0     pid:95    tgid:95    ppid:2      flags:0x00004000
[11000.223106] Sched_ext: simple (disabling)
[11000.223111] Call Trace:
[11000.230370]  <TASK>
[11000.232777]  __schedule+0x47e/0x19d0
[11000.236807]  ? __this_cpu_preempt_check+0x17/0x20
[11000.242121]  schedule+0x4b/0x1a0
[11000.245758]  schedule_timeout+0x116/0x120
[11000.250280]  ? _raw_spin_unlock_irq+0x2c/0x60
[11000.255176]  ? __this_cpu_preempt_check+0x17/0x20
[11000.260482]  ? lockdep_hardirqs_on+0xce/0x150
[11000.265377]  ? trace_hardirqs_on+0x51/0x60
[11000.270014]  __wait_for_common+0x91/0x180
[11000.274519]  ? __pfx_schedule_timeout+0x10/0x10
[11000.279630]  ? __flush_work+0x232/0x610
[11000.283940]  wait_for_completion+0x28/0x30
[11000.288565]  __flush_work+0x2d4/0x610
[11000.292693]  ? __pfx_wq_barrier_func+0x10/0x10
[11000.297728]  ? __wait_for_common+0x3e/0x180
[11000.302424]  work_on_cpu_key+0x9c/0xc0
[11000.306641]  ? __pfx_work_for_cpu_fn+0x10/0x10
[11000.311629]  ? __pfx_tmigr_trigger_active+0x10/0x10
[11000.317136]  tmigr_cpu_offline+0x1dd/0x260
[11000.321742]  ? __pfx_tmigr_cpu_offline+0x10/0x10
[11000.326935]  cpuhp_invoke_callback+0x159/0x2f0
[11000.331936]  cpuhp_thread_fun+0x1e8/0x280
[11000.336452]  smpboot_thread_fn+0x196/0x240
[11000.341070]  ? __pfx_smpboot_thread_fn+0x10/0x10
[11000.346267]  kthread+0xfa/0x130
[11000.349805]  ? __pfx_kthread+0x10/0x10
[11000.354028]  ret_from_fork+0x40/0x60
[11000.358070]  ? __pfx_kthread+0x10/0x10
[11000.362288]  ret_from_fork_asm+0x1a/0x30
[11000.366740]  </TASK>
[11000.369243] INFO: task systemd-journal:790 blocked for more than 121 seconds.
[11000.377250]       Not tainted 6.11.0-rc1-sched-ext-g2f88de3b86bf #2
[11000.384277] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[11000.393062] task:systemd-journal state:D stack:0     pid:790   tgid:790   ppid:1      flags:0x00000002
[11000.403510] Sched_ext: simple (disabling)
[11000.403514] Call Trace:
[11000.410789]  <TASK>
[11000.413177]  __schedule+0x47e/0x19d0
[11000.417215]  ? __this_cpu_preempt_check+0x17/0x20
[11000.422510]  schedule+0x4b/0x1a0
[11000.426168]  percpu_rwsem_wait+0x118/0x140
[11000.430773]  ? __pfx_percpu_rwsem_wake_function+0x10/0x10
[11000.436846]  __percpu_down_read+0x7b/0xb0
[11000.441361]  scx_pre_fork+0xd1/0xf0
[11000.445284]  sched_fork+0x59/0x1c0
[11000.449117]  copy_process+0xa69/0x2b10
[11000.453346]  ? timerfd_read_iter+0x136/0x290
[11000.458160]  ? sched_clock_noinstr+0xd/0x20
[11000.462862]  ? _copy_to_iter+0xb9/0x630
[11000.467188]  kernel_clone+0xa0/0x3d0
[11000.471208]  ? copy_clone_args_from_user+0xa3/0x290
[11000.476733]  __do_sys_clone3+0xc8/0x110
[11000.481068]  ? __secure_computing+0x89/0xe0
[11000.485785]  __x64_sys_clone3+0x1a/0x20
[11000.490096]  x64_sys_call+0x1800/0x20d0
[11000.494438]  do_syscall_64+0x8b/0x140
[11000.498561]  ? do_syscall_64+0x97/0x140
[11000.502887]  ? __this_cpu_preempt_check+0x17/0x20
[11000.508186]  ? lockdep_hardirqs_on+0xce/0x150
[11000.513096]  ? syscall_exit_to_user_mode+0xd5/0x210
[11000.518568]  ? do_syscall_64+0x97/0x140
[11000.522881]  ? __lock_acquire+0xac8/0x28c0
[11000.527511]  ? sigprocmask+0xad/0xe0
[11000.531526]  ? sched_clock_noinstr+0xd/0x20
[11000.536239]  ? _raw_spin_unlock_irq+0x2c/0x60
[11000.541158]  ? __this_cpu_preempt_check+0x17/0x20
[11000.546431]  ? lockdep_hardirqs_on+0xce/0x150
[11000.551346]  ? do_syscall_64+0x97/0x140
[11000.555656]  ? __this_cpu_preempt_check+0x17/0x20
[11000.560955]  ? lockdep_hardirqs_on+0xce/0x150
[11000.565850]  ? syscall_exit_to_user_mode+0xd5/0x210
[11000.571340]  ? do_syscall_64+0x97/0x140
[11000.575655]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[11000.581333] RIP: 0033:0x7ffa9a32683d
[11000.585368] RSP: 002b:00007ffc04eb0418 EFLAGS: 00000202 ORIG_RAX: 00000000000001b3
[11000.593859] RAX: ffffffffffffffda RBX: 00007ffc04eb0460 RCX: 00007ffa9a32683d
[11000.601849] RDX: 00007ffa9a2947d0 RSI: 0000000000000058 RDI: 00007ffc04eb0460
[11000.609863] RBP: fffffffffffffdc8 R08: 00007ffa97800640 R09: 00007ffc04eb057f
[11000.617868] R10: 0000000000000008 R11: 0000000000000202 R12: 00007ffa97800640
[11000.625863] R13: 0000000000000002 R14: 00007ffa9a2947d0 R15: 00007ffc04eb05c0
[11000.633887]  </TASK>
[11000.636366] INFO: task udisksd:1584 blocked for more than 121 seconds.
[11000.643691]       Not tainted 6.11.0-rc1-sched-ext-g2f88de3b86bf #2
[11000.650730] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[11000.659506] task:udisksd         state:D stack:0     pid:1584  tgid:1584  ppid:1      flags:0x00000002
[11000.669935] Sched_ext: simple (disabling)
[11000.669939] Call Trace:
[11000.677214]  <TASK>
[11000.679584]  __schedule+0x47e/0x19d0
[11000.683620]  ? __this_cpu_preempt_check+0x17/0x20
[11000.688932]  schedule+0x4b/0x1a0
[11000.692578]  percpu_rwsem_wait+0x118/0x140
[11000.697207]  ? __pfx_percpu_rwsem_wake_function+0x10/0x10
[11000.703295]  __percpu_down_read+0x7b/0xb0
[11000.707808]  scx_pre_fork+0xd1/0xf0
[11000.711747]  sched_fork+0x59/0x1c0
[11000.715598]  copy_process+0xa69/0x2b10
[11000.719847]  ? __lock_acquire+0xac8/0x28c0
[11000.724498]  kernel_clone+0xa0/0x3d0
[11000.728515]  ? copy_clone_args_from_user+0xa3/0x290
[11000.734029]  __do_sys_clone3+0xc8/0x110
[11000.738378]  ? do_syscall_64+0x97/0x140
[11000.742712]  ? do_syscall_64+0x4c/0x140
[11000.747036]  ? __this_cpu_preempt_check+0x17/0x20
[11000.752340]  __x64_sys_clone3+0x1a/0x20
[11000.756665]  x64_sys_call+0x1800/0x20d0
[11000.760999]  do_syscall_64+0x8b/0x140
[11000.765146]  ? do_syscall_64+0x97/0x140
[11000.769462]  ? __this_cpu_preempt_check+0x17/0x20
[11000.774754]  ? lockdep_hardirqs_on+0xce/0x150
[11000.779668]  ? syscall_exit_to_user_mode+0xd5/0x210
[11000.785151]  ? do_syscall_64+0x97/0x140
[11000.789459]  ? do_syscall_64+0x97/0x140
[11000.793766]  ? syscall_exit_to_user_mode+0xd5/0x210
[11000.799248]  ? do_syscall_64+0x97/0x140
[11000.803560]  ? do_syscall_64+0x97/0x140
[11000.807878]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[11000.813549] RIP: 0033:0x7f0fe352683d
[11000.817566] RSP: 002b:00007ffed86d7578 EFLAGS: 00000202 ORIG_RAX: 00000000000001b3
[11000.826059] RAX: ffffffffffffffda RBX: 00007ffed86d75c0 RCX: 00007f0fe352683d
[11000.834058] RDX: 00007f0fe34947d0 RSI: 0000000000000058 RDI: 00007ffed86d75c0
[11000.842053] RBP: fffffffffffffea0 R08: 00007f0fe2000640 R09: 00007ffed86d76df
[11000.850054] R10: 0000000000000008 R11: 0000000000000202 R12: 00007f0fe2000640
[11000.858050] R13: 0000000000000002 R14: 00007f0fe34947d0 R15: 00007ffed86d7720
[11000.866079]  </TASK>
[11000.868534] INFO: task cron:1820 blocked for more than 121 seconds.
[11000.875563]       Not tainted 6.11.0-rc1-sched-ext-g2f88de3b86bf #2
[11000.882609] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[11000.891391] task:cron            state:D stack:0     pid:1820  tgid:1820  ppid:1      flags:0x00000002
[11000.901817] Sched_ext: simple (disabling)
[11000.901820] Call Trace:
[11000.909094]  <TASK>
[11000.911466]  __schedule+0x47e/0x19d0
[11000.915490]  ? __this_cpu_preempt_check+0x17/0x20
[11000.920810]  schedule+0x4b/0x1a0
[11000.924449]  percpu_rwsem_wait+0x118/0x140
[11000.929054]  ? __pfx_percpu_rwsem_wake_function+0x10/0x10
[11000.935120]  __percpu_down_read+0x7b/0xb0
[11000.939639]  scx_pre_fork+0xd1/0xf0
[11000.943564]  sched_fork+0x59/0x1c0
[11000.947396]  copy_process+0xa69/0x2b10
[11000.951607]  ? mntput_no_expire+0x9a/0x4c0
[11000.956244]  kernel_clone+0xa0/0x3d0
[11000.960271]  __do_sys_clone+0x66/0x90
[11000.964399]  __x64_sys_clone+0x29/0x30
[11000.968630]  x64_sys_call+0x1d80/0x20d0
[11000.972946]  do_syscall_64+0x8b/0x140
[11000.977062]  ? lockdep_hardirqs_on+0xce/0x150
[11000.981960]  ? syscall_exit_to_user_mode+0xd5/0x210
[11000.987440]  ? do_syscall_64+0x97/0x140
[11000.991773]  ? __do_sys_newfstatat+0x3e/0x60
[11000.996583]  ? do_syscall_64+0x97/0x140
[11001.000897]  ? __this_cpu_preempt_check+0x17/0x20
[11001.006189]  ? lockdep_hardirqs_on+0xce/0x150
[11001.011088]  ? syscall_exit_to_user_mode+0xd5/0x210
[11001.016577]  ? do_syscall_64+0x97/0x140
[11001.020892]  ? syscall_exit_to_user_mode+0xd5/0x210
[11001.026372]  ? do_syscall_64+0x97/0x140
[11001.030689]  ? syscall_exit_to_user_mode+0xd5/0x210
[11001.036178]  ? do_syscall_64+0x97/0x140
[11001.040496]  ? do_syscall_64+0x97/0x140
[11001.044811]  ? syscall_exit_to_user_mode+0xd5/0x210
[11001.050290]  ? do_syscall_64+0x97/0x140
[11001.054605]  ? do_syscall_64+0x97/0x140
[11001.058929]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[11001.064608] RIP: 0033:0x7fc230eeab57
[11001.068633] RSP: 002b:00007fff0ef6db58 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
[11001.077128] RAX: ffffffffffffffda RBX: 00007fc231195040 RCX: 00007fc230eeab57
[11001.085123] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
[11001.093120] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000020
[11001.101126] R10: 00007fc231031b10 R11: 0000000000000246 R12: 0000000000000001
[11001.109121] R13: 00005564ce386af0 R14: 000055649c0af0a1 R15: 00005564ce36dd00
[11001.117134]  </TASK>
[11001.119642] INFO: task scx_simple:3632 blocked for more than 122 seconds.
[11001.127291]       Not tainted 6.11.0-rc1-sched-ext-g2f88de3b86bf #2
[11001.134342] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[11001.143146] task:scx_simple      state:D stack:0     pid:3632  tgid:3632  ppid:3619   flags:0x00004002
[11001.153597] Sched_ext: simple (disabling)
[11001.153609] Call Trace:
[11001.160883]  <TASK>
[11001.163242]  __schedule+0x47e/0x19d0
[11001.167297]  ? __this_cpu_preempt_check+0x17/0x20
[11001.172592]  schedule+0x4b/0x1a0
[11001.176200]  percpu_rwsem_wait+0x118/0x140
[11001.180863]  ? __pfx_percpu_rwsem_wake_function+0x10/0x10
[11001.186919]  __percpu_down_read+0x7b/0xb0
[11001.191468]  cpus_read_lock+0xd1/0xf0
[11001.195586]  scx_ops_enable.constprop.0+0x341/0xae0
[11001.201105]  ? __this_cpu_preempt_check+0x17/0x20
[11001.206397]  ? debug_smp_processor_id+0x1b/0x30
[11001.211519]  ? rcu_is_watching+0x17/0x70
[11001.215954]  ? trace_contention_end+0x6c/0xa0
[11001.220871]  ? __mutex_lock+0x388/0x8e0
[11001.225190]  ? __anon_inode_getfile+0x8b/0x180
[11001.230217]  ? bpf_struct_ops_link_create+0x105/0x180
[11001.235896]  ? lockdep_init_map_type+0x5a/0x290
[11001.241016]  bpf_scx_reg+0x12/0x20
[11001.244859]  bpf_struct_ops_link_create+0x124/0x180
[11001.250375]  __sys_bpf+0x2088/0x2b90
[11001.254411]  ? mutex_unlock+0x16/0x20
[11001.258604]  __x64_sys_bpf+0x1e/0x30
[11001.262614]  x64_sys_call+0x1b2e/0x20d0
[11001.266966]  do_syscall_64+0x8b/0x140
[11001.271089]  ? map_update_elem+0x252/0x310
[11001.275737]  ? __sys_bpf+0x12a2/0x2b90
[11001.279949]  ? do_syscall_64+0x97/0x140
[11001.284328]  ? __rseq_handle_notify_resume+0x440/0x630
[11001.290138]  ? do_syscall_64+0x97/0x140
[11001.294490]  ? __this_cpu_preempt_check+0x17/0x20
[11001.299766]  ? lockdep_hardirqs_on+0xce/0x150
[11001.304688]  ? syscall_exit_to_user_mode+0xd5/0x210
[11001.310173]  ? do_syscall_64+0x97/0x140
[11001.314500]  ? sysvec_apic_timer_interrupt+0x76/0xf0
[11001.320109]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[11001.325807] RIP: 0033:0x7f1e1911e88d
[11001.329816] RSP: 002b:00007ffdb1b0ed08 EFLAGS: 00000202 ORIG_RAX: 0000000000000141
[11001.338343] RAX: ffffffffffffffda RBX: 00000000ffffffff RCX: 00007f1e1911e88d
[11001.346368] RDX: 0000000000000040 RSI: 00007ffdb1b0edf0 RDI: 000000000000001c
[11001.354379] RBP: 00007ffdb1b0ed20 R08: 00007ffdb1b0edf0 R09: 00007ffdb1b0edf0
[11001.362395] R10: 000055722ade9500 R11: 0000000000000202 R12: 00005571f595a2cd
[11001.370419] R13: 00005571f595a200 R14: 00007ffdb1b0ef28 R15: 000055722ae06f50
[11001.378447]  </TASK>
[11001.380974] INFO: task sched_ext_ops_h:3633 blocked for more than 122 seconds.
[11001.389131]       Not tainted 6.11.0-rc1-sched-ext-g2f88de3b86bf #2
[11001.396167] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[11001.404971] task:sched_ext_ops_h state:D stack:0     pid:3633  tgid:3633  ppid:2      flags:0x00004000
[11001.415378] Sched_ext: simple (disabling)
[11001.415381] Call Trace:
[11001.422636]  <TASK>
[11001.425007]  __schedule+0x47e/0x19d0
[11001.429051]  ? __this_cpu_preempt_check+0x17/0x20
[11001.434342]  schedule+0x4b/0x1a0
[11001.437986]  schedule_preempt_disabled+0x1c/0x30
[11001.443162]  __mutex_lock+0x50a/0x8e0
[11001.447320]  ? scx_ops_disable_workfn+0xe0/0x580
[11001.452525]  mutex_lock_nested+0x1f/0x30
[11001.456916]  ? mutex_lock_nested+0x1f/0x30
[11001.461529]  scx_ops_disable_workfn+0xe0/0x580
[11001.466538]  ? __this_cpu_preempt_check+0x17/0x20
[11001.471834]  ? kthread_worker_fn+0x76/0x2e0
[11001.476506]  ? sched_clock_noinstr+0xd/0x20
[11001.481231]  ? _raw_spin_unlock_irq+0x2c/0x60
[11001.486138]  ? __this_cpu_preempt_check+0x17/0x20
[11001.491422]  kthread_worker_fn+0xbb/0x2e0
[11001.495911]  ? __pfx_scx_ops_disable_workfn+0x10/0x10
[11001.501593]  ? __pfx_kthread_worker_fn+0x10/0x10
[11001.506770]  kthread+0xfa/0x130
[11001.510321]  ? __pfx_kthread+0x10/0x10
[11001.514545]  ret_from_fork+0x40/0x60
[11001.518573]  ? __pfx_kthread+0x10/0x10
[11001.522780]  ret_from_fork_asm+0x1a/0x30
[11001.527229]  </TASK>
[11001.529701] INFO: task bash:3660 blocked for more than 122 seconds.
[11001.536731]       Not tainted 6.11.0-rc1-sched-ext-g2f88de3b86bf #2
[11001.543746] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[11001.552539] task:bash            state:D stack:0     pid:3660  tgid:3660  ppid:3640   flags:0x00004002
[11001.562963] Sched_ext: simple (disabling)
[11001.562966] Call Trace:
[11001.570197]  <TASK>
[11001.572571]  __schedule+0x47e/0x19d0
[11001.576603]  ? __this_cpu_preempt_check+0x17/0x20
[11001.581895]  schedule+0x4b/0x1a0
[11001.585535]  schedule_timeout+0x116/0x120
[11001.590054]  ? _raw_spin_unlock_irq+0x2c/0x60
[11001.594938]  ? __this_cpu_preempt_check+0x17/0x20
[11001.600242]  ? lockdep_hardirqs_on+0xce/0x150
[11001.605129]  ? trace_hardirqs_on+0x51/0x60
[11001.609735]  __wait_for_common+0x91/0x180
[11001.614261]  ? __pfx_schedule_timeout+0x10/0x10
[11001.619343]  ? __flush_work+0x232/0x610
[11001.623656]  wait_for_completion+0x28/0x30
[11001.628285]  __flush_work+0x2d4/0x610
[11001.632410]  ? __pfx_wq_barrier_func+0x10/0x10
[11001.637427]  ? __wait_for_common+0x3e/0x180
[11001.642134]  work_on_cpu_key+0x9c/0xc0
[11001.646361]  ? __pfx_work_for_cpu_fn+0x10/0x10
[11001.651337]  ? __pfx___cpu_down_maps_locked+0x10/0x10
[11001.657013]  cpu_down_maps_locked+0xbf/0xd0
[11001.661737]  cpu_device_down+0x2e/0x50
[11001.665966]  cpu_subsys_offline+0x12/0x20
[11001.670472]  device_offline+0xf0/0x120
[11001.674732]  online_store+0x64/0xe0
[11001.678684]  dev_attr_store+0x1b/0x30
[11001.682824]  sysfs_kf_write+0x4f/0x70
[11001.686975]  kernfs_fop_write_iter+0x172/0x230
[11001.691988]  vfs_write+0x378/0x540
[11001.695841]  ksys_write+0x71/0xf0
[11001.699585]  __x64_sys_write+0x1d/0x30
[11001.703786]  x64_sys_call+0x1685/0x20d0
[11001.708122]  do_syscall_64+0x8b/0x140
[11001.712246]  ? do_syscall_64+0x97/0x140
[11001.716539]  ? __this_cpu_preempt_check+0x17/0x20
[11001.721819]  ? lockdep_hardirqs_on+0xce/0x150
[11001.726734]  ? syscall_exit_to_user_mode+0xd5/0x210
[11001.732205]  ? do_syscall_64+0x97/0x140
[11001.736517]  ? lockdep_hardirqs_on+0xce/0x150
[11001.741432]  ? syscall_exit_to_user_mode+0xd5/0x210
[11001.746899]  ? do_syscall_64+0x97/0x140
[11001.751209]  ? lockdep_hardirqs_on+0xce/0x150
[11001.756105]  ? syscall_exit_to_user_mode+0xd5/0x210
[11001.761608]  ? do_syscall_64+0x97/0x140
[11001.765901]  ? syscall_exit_to_user_mode+0xd5/0x210
[11001.771371]  ? do_syscall_64+0x97/0x140
[11001.775689]  ? do_syscall_64+0x97/0x140
[11001.780019]  ? irqentry_exit+0x6f/0xa0
[11001.784217]  ? sysvec_call_function+0x76/0xf0
[11001.789114]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[11001.794793] RIP: 0033:0x7f48b4914887
[11001.798807] RSP: 002b:00007ffc30aa2b48 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[11001.807309] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f48b4914887
[11001.815287] RDX: 0000000000000002 RSI: 00005593f11663b0 RDI: 0000000000000001
[11001.823275] RBP: 00005593f11663b0 R08: 00007f48b49d1460 R09: 000000007fffffff
[11001.831270] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
[11001.839262] R13: 00007f48b4a1b780 R14: 00007f48b4a17600 R15: 00007f48b4a16a00
[11001.847287]  </TASK>
[11001.849780] INFO: task kworker/0:1:8931 blocked for more than 122 seconds.
[11001.857471]       Not tainted 6.11.0-rc1-sched-ext-g2f88de3b86bf #2
[11001.864516] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[11001.873290] task:kworker/0:1     state:D stack:0     pid:8931  tgid:8931  ppid:2      flags:0x00004000
[11001.883720] Workqueue: events vmstat_shepherd
[11001.888608] Sched_ext: simple (disabling)
[11001.888630] Call Trace:
[11001.895884]  <TASK>
[11001.898248]  __schedule+0x47e/0x19d0
[11001.902293]  ? __this_cpu_preempt_check+0x17/0x20
[11001.907598]  schedule+0x4b/0x1a0
[11001.911223]  percpu_rwsem_wait+0x118/0x140
[11001.915836]  ? __pfx_percpu_rwsem_wake_function+0x10/0x10
[11001.921910]  __percpu_down_read+0x7b/0xb0
[11001.926409]  cpus_read_lock+0xd1/0xf0
[11001.930536]  vmstat_shepherd+0x20/0x120
[11001.934863]  process_one_work+0x21e/0x680
[11001.939358]  ? __this_cpu_preempt_check+0x17/0x20
[11001.944672]  worker_thread+0x194/0x340
[11001.948888]  ? __pfx_worker_thread+0x10/0x10
[11001.953689]  kthread+0xfa/0x130
[11001.957226]  ? __pfx_kthread+0x10/0x10
[11001.961446]  ret_from_fork+0x40/0x60
[11001.965465]  ? __pfx_kthread+0x10/0x10
[11001.969679]  ret_from_fork_asm+0x1a/0x30
[11001.974106]  </TASK>
[11001.976563] Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings
[11001.985786] 
[11001.985786] Showing all locks held in the system:
[11001.992741] 1 lock held by kthreadd/2:
[11001.996931]  #0: ffffffff94ec3c00 (scx_fork_rwsem){++++}-{0:0}, at: sched_fork+0x59/0x1c0
[11002.006155] 2 locks held by rcu_tasks_trace/15:
[11002.011223]  #0: ffffffff94fb1780 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{4:4}, at: rcu_tasks_one_gp+0x341/0x4e0
[11002.022633]  #1: ffffffff94ea3d20 (cpu_hotplug_lock){++++}-{0:0}, at: rcu_tasks_trace_pregp_step+0xa2/0x700
[11002.033587] 2 locks held by cpuhp/13/95:
[11002.037976]  #0: ffffffff94ea3d20 (cpu_hotplug_lock){++++}-{0:0}, at: cpuhp_thread_fun+0x87/0x280
[11002.047933]  #1: ffffffff94ea6400 (cpuhp_state-down){+.+.}-{0:0}, at: cpuhp_thread_fun+0x87/0x280
[11002.057916] 1 lock held by khungtaskd/247:
[11002.062498]  #0: ffffffff94fb24e0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x3b/0x200
[11002.072578] 1 lock held by systemd-journal/790:
[11002.077646]  #0: ffffffff94ec3c00 (scx_fork_rwsem){++++}-{0:0}, at: sched_fork+0x59/0x1c0
[11002.086846] 1 lock held by in:imklog/1591:
[11002.091427]  #0: ffff9aa01164eed8 (&f->f_pos_lock){+.+.}-{4:4}, at: __fdget_pos+0x7c/0xc0
[11002.100635] 1 lock held by udisksd/1584:
[11002.105024]  #0: ffffffff94ec3c00 (scx_fork_rwsem){++++}-{0:0}, at: sched_fork+0x59/0x1c0
[11002.114238] 1 lock held by cron/1820:
[11002.118344]  #0: ffffffff94ec3c00 (scx_fork_rwsem){++++}-{0:0}, at: sched_fork+0x59/0x1c0
[11002.127562] 2 locks held by sh/1940:
[11002.131580]  #0: ffff9aab88e248a8 (&tty->ldisc_sem){++++}-{0:0}, at: ldsem_down_read+0x29/0x40
[11002.141249]  #1: ffffb4458dd7b2f8 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x563/0x690
[11002.151519] 4 locks held by scx_simple/3632:
[11002.156310]  #0: ffffffff950ba1d0 (update_mutex){+.+.}-{4:4}, at: bpf_struct_ops_link_create+0x105/0x180
[11002.166926]  #1: ffffffff94ec3cb0 (scx_ops_enable_mutex){+.+.}-{4:4}, at: scx_ops_enable.constprop.0+0x60/0xae0
[11002.178233]  #2: ffffffff94ec3c00 (scx_fork_rwsem){++++}-{0:0}, at: scx_ops_enable.constprop.0+0x33c/0xae0
[11002.189062]  #3: ffffffff94ea3d20 (cpu_hotplug_lock){++++}-{0:0}, at: scx_ops_enable.constprop.0+0x341/0xae0
[11002.200077] 1 lock held by sched_ext_ops_h/3633:
[11002.205267]  #0: ffffffff94ec3cb0 (scx_ops_enable_mutex){+.+.}-{4:4}, at: scx_ops_disable_workfn+0xe0/0x580
[11002.216182] 6 locks held by bash/3660:
[11002.220387]  #0: ffff9aab83cfd450 (sb_writers#6){.+.+}-{0:0}, at: ksys_write+0x71/0xf0
[11002.229260]  #1: ffff9aa011637090 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x122/0x230
[11002.239216]  #2: ffff9aa0051ef4e0 (kn->active#150){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x12a/0x230
[11002.249553]  #3: ffffffff951e9070 (device_hotplug_lock){+.+.}-{4:4}, at: online_store+0x47/0xe0
[11002.259315]  #4: ffff9ab74d404d98 (&dev->mutex){....}-{4:4}, at: device_offline+0x97/0x120
[11002.268593]  #5: ffffffff94ea3dd0 (cpu_add_remove_lock){+.+.}-{4:4}, at: cpu_device_down+0x24/0x50
[11002.278664] 3 locks held by kworker/0:1/8931:
[11002.283545]  #0: ffff9aa000051358 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x3f5/0x680
[11002.294083]  #1: ffffb4458b617e40 ((shepherd).work){+.+.}-{0:0}, at: process_one_work+0x1d6/0x680
[11002.304037]  #2: ffffffff94ea3d20 (cpu_hotplug_lock){++++}-{0:0}, at: vmstat_shepherd+0x20/0x120
[11002.313888] 3 locks held by kworker/0:11/8939:
[11002.318874]  #0: ffff9aa000051358 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x3f5/0x680
[11002.329403]  #1: ffffb4458b847e40 ((work_completion)(&wfc.work)#3){+.+.}-{0:0}, at: process_one_work+0x1d6/0x680
[11002.340812]  #2: ffffffff94ea3d20 (cpu_hotplug_lock){++++}-{0:0}, at: _cpu_down+0x7d/0x460
[11002.350102] 4 locks held by kworker/13:2/9104:
[11002.355081]  #0: ffff9aa000051358 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x3f5/0x680
[11002.365619]  #1: ffffb4458923fe40 (rebuild_sd_work){+.+.}-{0:0}, at: process_one_work+0x1d6/0x680
[11002.375578]  #2: ffffffff94ec7130 (sched_energy_mutex){+.+.}-{4:4}, at: rebuild_sd_workfn+0x1b/0x40
[11002.385732]  #3: ffffffff94ea3d20 (cpu_hotplug_lock){++++}-{0:0}, at: rebuild_sched_domains+0x12/0x40
[11002.396090] 
[11002.397783] =============================================


--------------------------------------------------------------------------------------------------------------------------------

Meanwhile, I spent some time investigating the circular dependency issue on
PowerPC.

Here are some details:

During continuous CPU online and offline operations, the scx_simple scheduler
unregisters and registers itself. This process can lead to a potential deadlock.

Below is an example of a common circular dependency that is frequently observed
on PowerPC, though other scenarios may also exist:

Note: The entire stack trace is not included to keep the flow simple.
------------------------------------------------------------------------------------------------------------------------
Time     | CPU 1 (scx_simple)                 | CPU 7 (hotplug.sh)                   | CPU 3 (kthreadd)               |
------------------------------------------------------------------------------------------------------------------------
T1       | bpf_scx_reg                        | cpu_device_up                        | -                              |
------------------------------------------------------------------------------------------------------------------------
T2       | scx_ops_enable                     | _cpu_up                              | -                              |
------------------------------------------------------------------------------------------------------------------------
T3       | scx_fork_rwsem taken (#1)          | cpus_write_lock taken (#2)           | -                              |
         | (Holds scx_fork_rwsem)             | (Holds cpus_write_lock)              |                                |
------------------------------------------------------------------------------------------------------------------------
T4       | Waiting on CPU 7                   | cpuhp_invoke_callback                | -                              |
         | (To take cpus_read_lock)           |                                      |                                |
------------------------------------------------------------------------------------------------------------------------
T5       | Waiting on CPU 7                   | smpboot_create_threads               | -                              |
         | (To take cpus_read_lock)           |                                      |                                |
------------------------------------------------------------------------------------------------------------------------
T6       | Waiting on CPU 7                   | kthread_create_on_cpu                | -                              |
         | (To take cpus_read_lock)           |                                      |                                |
------------------------------------------------------------------------------------------------------------------------
T7       | Waiting on CPU 7                   | __kthread_create_on_node             | -                              |
         | (To take cpus_read_lock)           |                                      |                                |
------------------------------------------------------------------------------------------------------------------------
T8       | Waiting on CPU 7                   | spawn kthread                        | -                              |
         | (To take cpus_read_lock)           |                                      |                                |
------------------------------------------------------------------------------------------------------------------------
T9       | Waiting on CPU 7                   | Waits for kthread completion ------> | kthreadd (#3)                  |
         | (To take cpus_read_lock)           |                                      |                                |
------------------------------------------------------------------------------------------------------------------------
T10      | Waiting on CPU 7                   | Waits on CPU 3                       | create_kthread                 |
         | (To take cpus_read_lock)           | (For kthread completion)             |                                |
------------------------------------------------------------------------------------------------------------------------
T11      | Waiting on CPU 7                   | Waits on CPU 3                       | sched_fork                     |
         | (To take cpus_read_lock)           | (For kthread completion)             |                                |
------------------------------------------------------------------------------------------------------------------------
T12      | Waiting on CPU 7                   | Waits on CPU 3                       | scx_pre_fork                   |
         | (To take cpus_read_lock)           | (For kthread completion)             |                                |
------------------------------------------------------------------------------------------------------------------------
T13      | Waiting on CPU 7                   | Waits on CPU 3                       | Trying to hold scx_fork_rwsem  |
         | (To take cpus_read_lock)           | (For kthread completion)             | but it is held by #1           |
------------------------------------------------------------------------------------------------------------------------
T14      | Waiting on CPU 7                   | Waits on CPU 3                       | Waits on CPU 1                 |
         | (To take cpus_read_lock)           | (For kthread completion)             | (To release scx_fork_rwsem)    |
         | (Dependent on #2)                  | (Dependent on #3)                    | (Dependent on #1)              |
------------------------------------------------------------------------------------------------------------------------

Summary of events:

T1-T3: CPU 1 takes scx_fork_rwsem (#1), and CPU 7 takes cpus_write_lock (#2).

T4-T13: CPU 1 is waiting for CPU 7 to take cpus_read_lock, while CPU 7 is
performing a sequence of hotplug callbacks involving kthread creation and
waiting for the kthread completion on CPU 3.

T14: Circular dependency forms:
CPU 1 is waiting on CPU 7 (dependent on lock #2 to be released).
CPU 7 is waiting on CPU 3 (dependent on completion of #3).
CPU 3 is waiting on CPU 1 (dependent on lock #1 to be released).


This results in a deadlock where each CPU is waiting on another to release
a lock or complete an operation, creating a clear circular dependency
where none of the CPUs can progress.


Could I be missing something here, please let me know your thoughts?

Thanks,
Aboorva


