Return-Path: <linux-kernel+bounces-245352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9984C92B198
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 09:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B0852811C6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 07:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D01314EC5E;
	Tue,  9 Jul 2024 07:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F0DEirRU"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A3814B97B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 07:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720511514; cv=none; b=KBPHnkhpLEQMHe8vB1MPyNR2AA1qScmCjj9uaEaLaPRwnu8fNZyTmGBccWu181oUmLpsBhzg9dXc/mmonWLgV1iqPC2v9m0m/Qp8hb9XeUOveK1sdZiwfPJLZjfGeua6qOBgP8yyWcT8NfKilD8KiN6MnKxjbPgHO406xe9gE9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720511514; c=relaxed/simple;
	bh=tKkgWJH0vCG3c2BmH0hSj3sbhNW2IDddJlr5TME0X6M=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:Mime-Version; b=U0KOMNbwa0bXjfmxHCwaESZt2EDbRMQSg61+U/dPpAs7zSNCFYOFsnqwtlWvht0qnMRdLT4S8HqcI7b6M9JjTyskQroD+TsnoHra1zjtckCZidfk7decgGhrxA5H9N1NQHQUVRRbwhFP3QovpDMSyAPYLw2RI905Z7gIJXQE648=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=F0DEirRU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4693upqN019636;
	Tue, 9 Jul 2024 07:51:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:content-type:mime-version
	:content-transfer-encoding; s=pp1; bh=zoRUfNJa/8sJydrqTVzdVEdRN7
	egCVwFYhtTy61zdEU=; b=F0DEirRUhm1P0IAjhWYz8/oqXKJODFziJguNGQRQSE
	BdJwEX2B2oyaUzWMAO7VAWCb6+nGOq3MZc0W2EZWGbbtAvhbS8oQ94RrcIbBSu8v
	jYiptlcx0QkSLoE+XXUBYaKML1OBVtsQU5d1IxhAkr/AgQnwYFsTPTPgRSy6BjUn
	+uuXRu6rnUbIj7NQJcLtsof+QN3MUcdKNIRTs0CAbZ9I32l8GJx7YDc4z8JRgJ9Z
	YfOn0poAJIqe227o4pE7Pz5X5guwvPES33QAKzLViPIZxV1EMaZrtSCbq4xcQfbE
	Zy1moEBY78AvpeRGqQLeckO2XJMf8D3pA0i122VfvENw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 408v13rpun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 07:51:46 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4695ptsA006921;
	Tue, 9 Jul 2024 07:51:45 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 407jfmb0v1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 07:51:45 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4697pgaE36241976
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jul 2024 07:51:44 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA91B58045;
	Tue,  9 Jul 2024 07:51:42 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8137158054;
	Tue,  9 Jul 2024 07:51:40 +0000 (GMT)
Received: from li-34d1fccc-27cd-11b2-a85c-c167793e56f7.ibm.com (unknown [9.43.106.244])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jul 2024 07:51:40 +0000 (GMT)
Message-ID: <8cd0ec0c4c7c1bc0119e61fbef0bee9d5e24022d.camel@linux.ibm.com>
Subject: [sched_ext/for-6.11]: Issue with BPF Scheduler during CPU Hotplug
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: tj@kernel.org, void@manifault.com
Cc: aboorvad@linux.ibm.com, linux-kernel@vger.kernel.org
Date: Tue, 09 Jul 2024 13:21:38 +0530
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
X-Proofpoint-ORIG-GUID: 1Goc-iNXq3YPdqDpVeDl_w4f_RqXbfNT
X-Proofpoint-GUID: 1Goc-iNXq3YPdqDpVeDl_w4f_RqXbfNT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_15,2024-07-08_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407090048

I'm currently experimenting with sched_ext schedulers and have
encountered an issue with CPU hotplug when running scx_simple
scheduler, this issue is intermittent and doesn't happen frequently.
However, it appears to be a common problem when performing CPU
hotplug with any external scheduler.

---------------------------------------------------------------

Here is the system info:

Kernel Version:  Latest sched-ext (for-next) tree with patches to
support struct_ops on ppc64le.

root@ltc # lscpu
Architecture:                         ppc64le
Byte Order:                           Little Endian
CPU(s):                               128
On-line CPU(s) list:                  0-127
Thread(s) per core:                   4
Core(s) per socket:                   16
Socket(s):                            2
NUMA node(s):                         8
Model:                                2.3 (pvr 004e 1203)
Model name:                           POWER9, altivec supported
Frequency boost:                      enabled
CPU max MHz:                          3800.0000
CPU min MHz:                          2300.0000
L1d cache:                            1 MiB
L1i cache:                            1 MiB
L2 cache:                             8 MiB
L3 cache:                             160 MiB
NUMA node0 CPU(s):                    0-63
NUMA node8 CPU(s):                    64-127

---------------------------------------------------------------

Steps to reproduce the issue:

- Run the scx_simple scheduler.
- Randomly offline and online CPUs from 1 to 127.

During the CPU hotplug, the custom scheduler successfully
unregisters and registers itself without issues. However, it
occasionally encounters a crash and the system becomes unresponsive.

---------------------------------------------------------------

Here is the crash log:

[64650.796448] INFO: task rcu_tasks_trace:14 blocked for more than 120 seconds.
[64650.796557]       Not tainted 6.10.0-rc2+ #4
[64650.796630] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[64650.796688] task:rcu_tasks_trace state:D stack:0     pid:14    tgid:14    ppid:2      flags:0x00000000
[64650.796748] Sched_ext: simple (prepping)
[64650.796771] Call Trace:
[64650.796841] [c000000ddf0c3700] [c0000000016f0c06] scx_dump_state.trunc_marker+0x2078/0x5d2a (unreliable)
[64650.796950] [c000000ddf0c38b0] [c00000000001dd68] __switch_to+0x238/0x310
[64650.797041] [c000000ddf0c3910] [c0000000013e6170] __schedule+0xa10/0xf80
[64650.797126] [c000000ddf0c3a10] [c0000000013e6764] schedule+0x84/0x128
[64650.797208] [c000000ddf0c3a40] [c00000000023f4dc] percpu_rwsem_wait+0x13c/0x1a0
[64650.797299] [c000000ddf0c3ac0] [c0000000013ee7ec] __percpu_down_read+0xac/0x21c
[64650.797371] [c000000ddf0c3b40] [c0000000001739b8] cpus_read_lock+0x158/0x180
[64650.797468] [c000000ddf0c3b80] [c000000000285a94] check_all_holdout_tasks_trace+0x84/0x450
[64650.797564] [c000000ddf0c3cc0] [c000000000284c68] rcu_tasks_wait_gp+0x318/0x430
[64650.797657] [c000000ddf0c3dd0] [c000000000284394] rcu_tasks_one_gp+0x4f4/0x5e0
[64650.797747] [c000000ddf0c3f00] [c0000000002850ac] rcu_tasks_kthread+0x12c/0x150
[64650.797838] [c000000ddf0c3f80] [c0000000001be158] kthread+0x1c8/0x1e0
[64650.797867] [c000000ddf0c3fe0] [c00000000000d030] start_kernel_thread+0x14/0x18
[64650.799240] INFO: task kworker/0:3:1216 blocked for more than 120 seconds.
[64650.799324]       Not tainted 6.10.0-rc2+ #4
[64650.799419] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[64650.799487] task:kworker/0:3     state:D stack:0     pid:1216  tgid:1216  ppid:2      flags:0x00000000
[64650.799575] Workqueue: events vmstat_shepherd
[64650.799666] Sched_ext: simple (prepping)
[64650.799696] Call Trace:
[64650.799830] [c000000ec40af8e0] [c0000000016f0c06] scx_dump_state.trunc_marker+0x2078/0x5d2a (unreliable)
[64650.800001] [c000000ec40afa90] [c00000000001dd68] __switch_to+0x238/0x310
[64650.800139] [c000000ec40afaf0] [c0000000013e6170] __schedule+0xa10/0xf80
[64650.800234] [c000000ec40afbf0] [c0000000013e6764] schedule+0x84/0x128
[64650.800336] [c000000ec40afc20] [c00000000023f4dc] percpu_rwsem_wait+0x13c/0x1a0
[64650.800443] [c000000ec40afca0] [c0000000013ee7ec] __percpu_down_read+0xac/0x21c
[64650.800550] [c000000ec40afd20] [c0000000001739b8] cpus_read_lock+0x158/0x180
[64650.800694] [c000000ec40afd60] [c00000000051bb88] vmstat_shepherd+0x48/0x1b0
[64650.800798] [c000000ec40afdd0] [c0000000001b0208] process_one_work+0x2c8/0x6d0
[64650.800884] [c000000ec40afed0] [c0000000001b3c88] worker_thread+0x3d8/0x560
[64650.800948] [c000000ec40aff80] [c0000000001be158] kthread+0x1c8/0x1e0
[64650.801051] [c000000ec40affe0] [c00000000000d030] start_kernel_thread+0x14/0x18
[64650.801563] INFO: task scx_simple:11214 blocked for more than 120 seconds.
[64650.801668]       Not tainted 6.10.0-rc2+ #4
[64650.801734] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[64650.801834] task:scx_simple      state:D stack:0     pid:11214 tgid:11214 ppid:11013  flags:0x00040080
[64650.801949] Sched_ext: simple (prepping)
[64650.801978] Call Trace:
[64650.802062] [c000000e9bdf35b0] [c0000000016f0c06] scx_dump_state.trunc_marker+0x2078/0x5d2a (unreliable)
[64650.802231] [c000000e9bdf3760] [c00000000001dd68] __switch_to+0x238/0x310
[64650.802437] [c000000e9bdf37c0] [c0000000013e6170] __schedule+0xa10/0xf80
[64650.802599] [c000000e9bdf38c0] [c0000000013e6764] schedule+0x84/0x128
[64650.802700] [c000000e9bdf38f0] [c00000000023f4dc] percpu_rwsem_wait+0x13c/0x1a0
[64650.802807] [c000000e9bdf3970] [c0000000013ee7ec] __percpu_down_read+0xac/0x21c
[64650.802926] [c000000e9bdf39f0] [c0000000001739b8] cpus_read_lock+0x158/0x180
[64650.803065] [c000000e9bdf3a30] [c00000000021fd88] bpf_scx_reg+0x5d8/0xb80
[64650.803161] [c000000e9bdf3c10] [c00000000049e308] bpf_struct_ops_link_create+0x158/0x200
[64650.803259] [c000000e9bdf3c80] [c000000000407628] link_create+0x78/0x3b0
[64650.803319] [c000000e9bdf3cd0] [c0000000004026fc] __sys_bpf+0x39c/0x560
[64650.803389] [c000000e9bdf3dc0] [c000000000400b00] sys_bpf+0x50/0x80
[64650.803449] [c000000e9bdf3e00] [c00000000003218c] system_call_exception+0x10c/0x2b0
[64650.803559] [c000000e9bdf3e50] [c00000000000c7d4] system_call_common+0xf4/0x258
[64650.803679] --- interrupt: c00 at 0x737414d42474
[64650.803783] NIP:  0000737414d42474 LR: 000004382701451c CTR: 0000000000000000
[64650.803848] REGS: c000000e9bdf3e80 TRAP: 0c00   Not tainted  (6.10.0-rc2+)
[64650.803953] MSR:  900000000000d033 <SF,HV,EE,PR,ME,IR,DR,RI,LE>  CR: 28048824  XER: 00000000
[64650.804202] IRQMASK: 0 
[64650.804202] GPR00: 0000000000000169 00007fffc9ebc2b0 0000737414e37100 000000000000001c 
[64650.804202] GPR04: 00007fffc9ebc430 0000000000000040 0000000000000001 0000043827017f00 
[64650.804202] GPR08: 000000000000001c 0000000000000000 0000000000000000 0000000000000000 
[64650.804202] GPR12: 0000000000000000 000073741514b9c0 00000438656ced30 000004382705bd48 
[64650.804202] GPR16: 000004382705bcb0 000004382705bf00 ffffffffffffffff 00000438270a0430 
[64650.804202] GPR20: 0000737414e318c8 00007fffc9ebc600 00007fffc9ebc580 00000000ffffffff 
[64650.804202] GPR24: 0000000000000001 00000438270a0438 00007fffc9ebcae8 000004382705bea8 
[64650.804202] GPR28: 000004382705bff0 000004382705bd00 0000000000000001 00007fffc9ebc2b0 
[64650.804953] NIP [0000737414d42474] 0x737414d42474
[64650.805045] LR [000004382701451c] 0x4382701451c
[64650.805118] --- interrupt: c00
[64650.805275] INFO: task hotplug.sh:11440 blocked for more than 120 seconds.
[64650.805369]       Not tainted 6.10.0-rc2+ #4
[64650.805451] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[64650.805532] task:hotplug.sh      state:D stack:0     pid:11440 tgid:11440 ppid:10770  flags:0x00040080
[64650.805629] Sched_ext: simple (prepping)
[64650.805653] Call Trace:
[64650.805756] [c00020006ef233e0] [c0000000016f0c06] scx_dump_state.trunc_marker+0x2078/0x5d2a (unreliable)
[64650.805860] [c00020006ef23590] [c00000000001dd68] __switch_to+0x238/0x310
[64650.805980] [c00020006ef235f0] [c0000000013e6170] __schedule+0xa10/0xf80
[64650.806088] [c00020006ef236f0] [c0000000013e6764] schedule+0x84/0x128
[64650.806182] [c00020006ef23720] [c0000000013f2a48] schedule_timeout+0x48/0x128
[64650.806374] [c00020006ef23800] [c0000000013e703c] wait_for_common+0x118/0x1f4
[64650.806519] [c00020006ef23880] [c00000000017889c] cpuhp_kick_ap+0x13c/0x2a0
[64650.806618] [c00020006ef238e0] [c000000000177a18] cpuhp_invoke_callback+0x278/0xac0
[64650.806691] [c00020006ef239f0] [c000000000175978] _cpu_up+0x238/0x420
[64650.806782] [c00020006ef23ab0] [c000000000174d18] cpu_up+0x168/0x1b0
[64650.806842] [c00020006ef23b40] [c000000000cf382c] cpu_subsys_online+0x6c/0x1b0
[64650.806925] [c00020006ef23b90] [c000000000ce5b20] online_store+0xe0/0x1a0
[64650.807008] [c00020006ef23bf0] [c000000000ce554c] dev_attr_store+0x6c/0xb0
[64650.807072] [c00020006ef23c40] [c000000000765798] sysfs_kf_write+0xd8/0x110
[64650.807138] [c00020006ef23c90] [c0000000007624f4] kernfs_fop_write_iter+0x1b4/0x260
[64650.807208] [c00020006ef23cf0] [c000000000643fb8] vfs_write+0x288/0x370
[64650.807285] [c00020006ef23da0] [c0000000006442dc] ksys_write+0x9c/0x120
[64650.807332] [c00020006ef23e00] [c00000000003218c] system_call_exception+0x10c/0x2b0
[64650.807409] [c00020006ef23e50] [c00000000000c7d4] system_call_common+0xf4/0x258
[64650.807459] --- interrupt: c00 at 0x7f4acef33614
[64650.807483] NIP:  00007f4acef33614 LR: 00007f4acee9f374 CTR: 0000000000000000
[64650.807549] REGS: c00020006ef23e80 TRAP: 0c00   Not tainted  (6.10.0-rc2+)
[64650.807625] MSR:  900000000000d033 <SF,HV,EE,PR,ME,IR,DR,RI,LE>  CR: 28422488  XER: 00000000
[64650.807800] IRQMASK: 0 
[64650.807800] GPR00: 0000000000000004 00007ffff045b7f0 00007f4acf037100 0000000000000001 
[64650.807800] GPR04: 0000077e966d2f10 0000000000000002 0000000000000010 0000000000000020 
[64650.807800] GPR08: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
[64650.807800] GPR12: 0000000000000000 00007f4acf21b330 0000077e966d6130 0000077e79ceb738 
[64650.807800] GPR16: 0000077e79c00ac0 0000000000000000 0000000020000000 0000077e966d2d70 
[64650.807800] GPR20: 0000000000000000 0000000000000001 0000077e79c93c80 00007ffff045b9e4 
[64650.807800] GPR24: 00007ffff045b9e0 0000077e79ceb0d0 00007f4acf02c0d8 00007f4acf02ca08 
[64650.807800] GPR28: 0000000000000002 00007f4acf0317e8 0000077e966d2f10 0000000000000002 
[64650.808157] NIP [00007f4acef33614] 0x7f4acef33614
[64650.808215] LR [00007f4acee9f374] 0x7f4acee9f374
[64650.808272] --- interrupt: c00
[64650.808330] 

---------------------------------------------------------------

More info provided by lockdep:

[64650.808330] Showing all locks held in the system:
[64650.808391] 1 lock held by kthreadd/2:
[64650.808431]  #0: c0000000029259c8 (scx_fork_rwsem){++++}-{0:0}, at: sched_fork+0x80/0x240
[64650.808578] 2 locks held by rcu_tasks_trace/14:
[64650.808647]  #0: c000000002a0c550 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{4:4}, at: rcu_tasks_one_gp+0x494/0x5e0
[64650.808764]  #1: c000000002913278 (cpu_hotplug_lock){++++}-{0:0}, at: check_all_holdout_tasks_trace+0x84/0x450
[64650.808868] 3 locks held by cpuhp/8/64:
[64650.808935]  #0: c000000002913278 (cpu_hotplug_lock){++++}-{0:0}, at: lockdep_acquire_cpus_lock+0x24/0x80
[64650.809004]  #1: c0000000029133a8 (cpuhp_state-up){+.+.}-{0:0}, at: cpuhp_lock_acquire+0xc/0x80
[64650.809135]  #2: c00000000291e448 (wq_pool_mutex){+.+.}-{4:4}, at: workqueue_online_cpu+0x84/0x6c0
[64650.809351] 1 lock held by khungtaskd/843:
[64650.809399]  #0: c000000002a0c110 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire+0x8/0x60
[64650.809522] 3 locks held by kworker/0:3/1216:
[64650.809581]  #0: c000000004809958 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x218/0x6d0
[64650.809697]  #1: c000000ec40afe40 ((shepherd).work){+.+.}-{0:0}, at: process_one_work+0x244/0x6d0
[64650.809835]  #2: c000000002913278 (cpu_hotplug_lock){++++}-{0:0}, at: vmstat_shepherd+0x48/0x1b0
[64650.809965] 1 lock held by systemd-journal/1389:
[64650.809983]  #0: c0000000029259c8 (scx_fork_rwsem){++++}-{0:0}, at: sched_fork+0x80/0x240
[64650.810122] 1 lock held by in:imklog/2498:
[64650.810194]  #0: c000000e135cb6d8 (&f->f_pos_lock){+.+.}-{4:4}, at: __fdget_pos+0xd0/0x130
[64650.810333] 5 locks held by rs:main Q:Reg/2499:
[64650.810515] 4 locks held by scx_simple/11214:
[64650.810606]  #0: c000000002a609b0 (update_mutex){+.+.}-{4:4}, at: bpf_struct_ops_link_create+0x134/0x200
[64650.810781]  #1: c000000002927170 (scx_ops_enable_mutex){+.+.}-{4:4}, at: bpf_scx_reg+0x80/0xb80
[64650.810886]  #2: c0000000029259c8 (scx_fork_rwsem){++++}-{0:0}, at: bpf_scx_reg+0x5d0/0xb80
[64650.811023]  #3: c000000002913278 (cpu_hotplug_lock){++++}-{0:0}, at: bpf_scx_reg+0x5d8/0xb80
[64650.811174] 7 locks held by hotplug.sh/11440:
[64650.811240]  #0: c000000e9bfe6450 (sb_writers#6){.+.+}-{0:0}, at: vfs_write+0xcc/0x370
[64650.811362]  #1: c000000e11b31e90 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x10c/0x260
[64650.811514]  #2: c000000df2892620 (kn->active#73){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x118/0x260
[64650.811675]  #3: c000000002aebc08 (device_hotplug_lock){+.+.}-{4:4}, at: online_store+0x6c/0x1a0
[64650.811814]  #4: c000007ff4ce0128 (&dev->mutex){....}-{4:4}, at: online_store+0x94/0x1a0
[64650.811929]  #5: c000000002913168 (cpu_add_remove_lock){+.+.}-{4:4}, at: cpu_up+0xa4/0x1b0
[64650.812061]  #6: c000000002913278 (cpu_hotplug_lock){++++}-{0:0}, at: _cpu_up+0x78/0x420
[64650.812224] 
[64650.812274] =============================================
[64650.812274] 

---------------------------------------------------------------

This issue occurs when the CPU comes back online and the BPF scheduler
attempts to re-register. I'll keep looking into it and share any
additional information I find.


Thanks,
Aboorva


