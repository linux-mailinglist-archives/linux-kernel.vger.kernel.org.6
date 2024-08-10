Return-Path: <linux-kernel+bounces-281990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5E594DDE7
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 20:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA69FB217B2
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 18:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC3F15FCED;
	Sat, 10 Aug 2024 18:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cu93pLUh"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884B713B5AF
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 18:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723314286; cv=none; b=FXyqwUqMPLfOjMGirRrITz33+LvtNJfvbpU/GgnNXMUR46gIwavLD/EN8ktMAOaO/xyYMy8auMVMGRTMrQf9vZpv+I/pUsXkqvohDGe7FWkxdwtlnEB8ijGfKkKqQKqS80lmC4Gw2GCXk16pBJF+VROyAwBu27wP6K1qYauWtdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723314286; c=relaxed/simple;
	bh=menZzOs7CmVwQdiBKLCeby1UIPheoR/HohitGTbt7Mk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AU5BC7E05zLOGWSDdeoO9FmnDCa7LUplSDvRvlJB5XvL1d0rE9y8YBLBOWI9ZkqJMaVIy4+W+UoTjQ+JSTltJ1hmApWxaCygFhGvI3oVBgBjkTk3B4C4zurF/Xyhlv+Ds7AGxdSi/z1Ob6sTsYN63daVjugkaMEh7YCj2kIu0XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cu93pLUh; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47AFHej2024215;
	Sat, 10 Aug 2024 18:24:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	MIKFYJoOWbzRgvOVJRd/S7kKV2CA/64qa2OYU0wzB8w=; b=cu93pLUhSpemzccJ
	C1tO6UTgc7EpYP7taxog55VdEZiFtsQTLuurIiBmjj5/qUf0c1pQVWIvAj9Nnv5g
	+XCl4+VIV7Z7TEiDI7zWseZIBlWcM1j9mFWgm9ma9KxX4V3TiirINZ3Q2WsnzlhN
	bKzF3kZCH9c4ZNff/fOf9fZxzSzMsbI2JEdOWZT18MWIAFifHYO9oyWD2Vmm3a5z
	35uGKLjREfydU985svc6Dd2olNur2RJ5BtJd96g05F4szbk/NyjnXCKXfmgX3FBm
	4vyzoH3nAYVirQBjtqVuuRlEjTM+XCKM0I7iEFcGzHWOsnhKHY2SSqpaEqaH7o2N
	i3hwFg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40wyvvs787-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 10 Aug 2024 18:24:31 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 47AI03Gh030487;
	Sat, 10 Aug 2024 18:24:30 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40t1k3ryrf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 10 Aug 2024 18:24:30 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47AIOR2I4391476
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 10 Aug 2024 18:24:29 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB2B658054;
	Sat, 10 Aug 2024 18:24:27 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0FB595803F;
	Sat, 10 Aug 2024 18:24:26 +0000 (GMT)
Received: from li-34d1fccc-27cd-11b2-a85c-c167793e56f7.ibm.com (unknown [9.43.8.151])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 10 Aug 2024 18:24:25 +0000 (GMT)
Message-ID: <e3069da05fb1676f8faad88b9a4dfc4a6cef4175.camel@linux.ibm.com>
Subject: Re: [sched_ext/for-6.11]: Issue with BPF Scheduler during CPU
 Hotplug
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: Tejun Heo <tj@kernel.org>
Cc: void@manifault.com, linux-kernel@vger.kernel.org
Date: Sat, 10 Aug 2024 23:54:24 +0530
In-Reply-To: <Zq1NksrG9blyN-KR@slm.duckdns.org>
References: <8cd0ec0c4c7c1bc0119e61fbef0bee9d5e24022d.camel@linux.ibm.com>
	 <Zo3PgETt43iFersn@slm.duckdns.org>
	 <dde4b09001da2641f9679b9409727e2147c5e9a6.camel@linux.ibm.com>
	 <daf2370f5456cbf1660bbdc13621559fb3f2f6cc.camel@linux.ibm.com>
	 <Zq1NksrG9blyN-KR@slm.duckdns.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-25.el8_9) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YYRxzqghEukzl6kvTPHMv0BUcn_hKbdu
X-Proofpoint-GUID: YYRxzqghEukzl6kvTPHMv0BUcn_hKbdu
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-10_15,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=987 spamscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 phishscore=0 clxscore=1011 bulkscore=0 mlxscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408100137

On Fri, 2024-08-02 at 11:20 -1000, Tejun Heo wrote:

> Hello, Aboorva.
> 
> On Fri, Jul 12, 2024 at 03:34:59PM +0530, Aboorva Devarajan wrote:
> > Hi Tejun,
> > 
> > On Thu, 2024-07-11 at 17:30 +0530, Aboorva Devarajan wrote:
> > 
> > > > It could also be specific to ppc64 (e.g. there's something dependingon fork
> > > > during CPU hotplug), or at least doesn't happen on x86. I'll probe it a bit
> > > > more.
> > > 
> > > Sure, so far I haven't been able to reproduce the issue on x86, also I'm running
> > > some tests for a longer duration to see if it can be recreated on x86 as well
> > > inorder to rule out the possiblity of it being a ppc64 specific issue, it could
> > > be that the issue occurs much rarer on x86 when compared to ppc64.
> > > 
> > 
> > I have been able to recreate a similar issue on x86 as well, so this
> > rules out the possibility of it being ppc64 specific.
> 
> Can you please applying the following patchset and see whether the problem
> persists?
> 
>  http://lkml.kernel.org/r/20240802211850.1211737-1-tj@kernel.org
> 

Hi Tejun,

Sorry for the delayed response, I just got sometime on the machine to
run this test.

I applied the patchset on the latest sched-ext (for-next) branch and
tested it, but the issue still persists. I did the test on a PowerPC
system, as it is easier to reproduce the issue there compared to x86.

Here's the error log:

------------------------------------------------------
[  605.329686] INFO: task systemd:1 blocked for more than 120 seconds.
[  605.329716]       Not tainted 6.11.0-rc1+ #13
[  605.329728] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  605.329752] task:systemd         state:D stack:0     pid:1     tgid:1     ppid:0      flags:0x00040000
[  605.329772] Sched_ext: simple (prepping)
[  605.329773] Call Trace:
[  605.329788] [c000000dddecf620] [0000000000000001] 0x1 (unreliable)
[  605.329814] [c000000dddecf7d0] [c00000000001d2d8] __switch_to+0x238/0x300
[  605.329840] [c000000dddecf830] [c0000000012b8958] __schedule+0x6f8/0xbac
[  605.329866] [c000000dddecf920] [c0000000012b8ec8] schedule+0xbc/0x174
[  605.329890] [c000000dddecf990] [c0000000002243d4] percpu_rwsem_wait+0x184/0x1d0
[  605.329917] [c000000dddecfa00] [c0000000012be358] __percpu_down_read+0x58/0x108
[  605.329952] [c000000dddecfa40] [c0000000001707a8] cpus_read_lock+0x88/0xa0
[  605.329968] [c000000dddecfa70] [c0000000004730f0] static_key_slow_inc+0x30/0x70
[  605.329986] [c000000dddecfaa0] [c0000000005ab80c] mem_cgroup_css_alloc+0x4ec/0x6c0
[  605.330022] [c000000dddecfb40] [c0000000002c9048] cgroup_apply_control_enable+0x208/0x600
[  605.330057] [c000000dddecfc40] [c0000000002c8bfc] cgroup_mkdir+0x39c/0x5e0
[  605.330090] [c000000dddecfcc0] [c0000000006dee7c] kernfs_iop_mkdir+0xdc/0x170
[  605.330133] [c000000dddecfd10] [c0000000005ea5cc] vfs_mkdir+0x13c/0x1f0
[  605.330169] [c000000dddecfd60] [c0000000005ea768] do_mkdirat+0xe8/0x2e0
[  605.330213] [c000000dddecfdc0] [c0000000005eaa40] sys_mkdir+0x50/0x80
[  605.330246] [c000000dddecfe00] [c000000000030cac] system_call_exception+0xfc/0x290
[  605.330294] [c000000dddecfe50] [c00000000000c7d4] system_call_common+0xf4/0x258
[  605.330342] --- interrupt: c00 at 0x7bff27d33038
[  605.330365] NIP:  00007bff27d33038 LR: 00007bff27958278 CTR: 0000000000000000
[  605.330398] REGS: c000000dddecfe80 TRAP: 0c00   Not tainted  (6.11.0-rc1+)
[  605.330421] MSR:  900000000000d033 <SF,HV,EE,PR,ME,IR,DR,RI,LE>  CR: 24004422  XER: 00000000
[  605.330452] IRQMASK: 0 
[  605.330452] GPR00: 0000000000000027 00007fffed2f4ae0 00007bff27e37100 00000ff04a9b6940 
[  605.330452] GPR04: 00000000000001ed 0000000000000000 0000000000000000 0000000000000000 
[  605.330452] GPR08: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
[  605.330452] GPR12: 0000000000000000 00007bff266a7780 00000ff029879080 0000000000000000 
[  605.330452] GPR16: 0000000000000000 00000ff04a9490c0 0000000000000000 fffffffffffffffe 
[  605.330452] GPR20: 0000000000000000 fffffffffffffffd 00007fffed2f5338 0000000000000020 
[  605.330452] GPR24: fffffffffffffc0c 00000ff04a8f59f0 0000000000000001 00000000ffffff0c 
[  605.330452] GPR28: 0000000000000001 00000ff04a8f59f0 00007bff27a99588 0000000000000000 
[  605.330717] NIP [00007bff27d33038] 0x7bff27d33038
[  605.330746] LR [00007bff27958278] 0x7bff27958278
[  605.330777] --- interrupt: c00
[  605.330795] INFO: task kworker/0:1:9 blocked for more than 120 seconds.
[  605.330837]       Not tainted 6.11.0-rc1+ #13
[  605.330857] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  605.330891] task:kworker/0:1     state:D stack:0     pid:9     tgid:9     ppid:2      flags:0x00000000
[  605.330939] Workqueue: events vmstat_shepherd
[  605.330973] Sched_ext: simple (prepping)
[  605.330974] Call Trace:
[  605.331006] [c000000ddde8b920] [c0000000001e65a4] update_cfs_rq_load_avg+0x194/0x1e0 (unreliable)
[  605.331069] [c000000ddde8bad0] [c00000000001d2d8] __switch_to+0x238/0x300
[  605.331103] [c000000ddde8bb30] [c0000000012b8958] __schedule+0x6f8/0xbac
[  605.331128] [c000000ddde8bc20] [c0000000012b8ec8] schedule+0xbc/0x174
[  605.331163] [c000000ddde8bc90] [c0000000002243d4] percpu_rwsem_wait+0x184/0x1d0
[  605.331209] [c000000ddde8bd00] [c0000000012be358] __percpu_down_read+0x58/0x108
[  605.331255] [c000000ddde8bd40] [c0000000001707a8] cpus_read_lock+0x88/0xa0
[  605.331300] [c000000ddde8bd70] [c0000000004b6d38] vmstat_shepherd+0x48/0x1b0
[  605.331344] [c000000ddde8bde0] [c0000000001a6508] process_scheduled_works+0x268/0x520
[  605.331391] [c000000ddde8bee0] [c0000000001a9bb0] worker_thread+0x3f0/0x590
[  605.331423] [c000000ddde8bf80] [c0000000001b35b0] kthread+0x1a0/0x1c0
[  605.331457] [c000000ddde8bfe0] [c00000000000d030] start_kernel_thread+0x14/0x18
[  605.331493] INFO: task rcu_tasks_trace:14 blocked for more than 120 seconds.
[  605.331529]       Not tainted 6.11.0-rc1+ #13
[  605.331568] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  605.331603] task:rcu_tasks_trace state:D stack:0     pid:14    tgid:14    ppid:2      flags:0x00000000
[  605.331649] Sched_ext: simple (prepping)
[  605.331650] Call Trace:
[  605.331694] [c000000dddea77e0] [c000000ddde1f900] 0xc000000ddde1f900 (unreliable)
[  605.331738] [c000000dddea7990] [c00000000001d2d8] __switch_to+0x238/0x300
[  605.331784] [c000000dddea79f0] [c0000000012b8958] __schedule+0x6f8/0xbac
[  605.331811] [c000000dddea7ae0] [c0000000012b8ec8] schedule+0xbc/0x174
[  605.331864] [c000000dddea7b50] [c0000000002243d4] percpu_rwsem_wait+0x184/0x1d0
[  605.331901] [c000000dddea7bc0] [c0000000012be358] __percpu_down_read+0x58/0x108
[  605.331949] [c000000dddea7c00] [c0000000001707a8] cpus_read_lock+0x88/0xa0
[  605.331982] [c000000dddea7c30] [c0000000002525fc] rcu_tasks_trace_pregp_step+0xec/0x580
[  605.332019] [c000000dddea7cf0] [c000000000251fdc] rcu_tasks_wait_gp+0xac/0x360
[  605.332046] [c000000dddea7e00] [c000000000251ab0] rcu_tasks_one_gp+0x540/0x620
[  605.332063] [c000000dddea7f10] [c0000000002523ec] rcu_tasks_kthread+0xfc/0x120
[  605.332099] [c000000dddea7f80] [c0000000001b35b0] kthread+0x1a0/0x1c0
[  605.332133] [c000000dddea7fe0] [c00000000000d030] start_kernel_thread+0x14/0x18
[  605.332171] INFO: task systemd-journal:426 blocked for more than 120 seconds.
[  605.332226]       Not tainted 6.11.0-rc1+ #13
[  605.332267] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  605.332282] task:systemd-journal state:D stack:0     pid:426   tgid:426   ppid:1      flags:0x00040400
[  605.332327] Sched_ext: simple (prepping)
[  605.332329] Call Trace:
[  605.332371] [c000000e86bef750] [0000000000000001] 0x1 (unreliable)
[  605.332405] [c000000e86bef900] [c00000000001d2d8] __switch_to+0x238/0x300
[  605.332439] [c000000e86bef960] [c0000000012b8958] __schedule+0x6f8/0xbac
[  605.332475] [c000000e86befa50] [c0000000012b8ec8] schedule+0xbc/0x174
[  605.332501] [c000000e86befac0] [c0000000002243d4] percpu_rwsem_wait+0x184/0x1d0
[  605.332538] [c000000e86befb30] [c0000000012be358] __percpu_down_read+0x58/0x108
[  605.332607] [c000000e86befb70] [c0000000001f7c78] scx_pre_fork+0x88/0xa0
[  605.332692] [c000000e86befba0] [c0000000001cbbb8] sched_fork+0x88/0x230
[  605.332781] [c000000e86befbe0] [c00000000016a80c] copy_process+0x55c/0xfa0
[  605.332958] [c000000e86befcb0] [c00000000016cc3c] kernel_clone+0xcc/0x410
[  605.333028] [c000000e86befd30] [c00000000016d394] sys_clone+0xa4/0xe0
[  605.333094] [c000000e86befe00] [c000000000030cac] system_call_exception+0xfc/0x290
[  605.333193] [c000000e86befe50] [c00000000000c7d4] system_call_common+0xf4/0x258
[  605.333279] --- interrupt: c00 at 0x777e7434ba24
[  605.333351] NIP:  0000777e7434ba24 LR: 0000777e737e6bc4 CTR: 0000000000000000
[  605.333425] REGS: c000000e86befe80 TRAP: 0c00   Not tainted  (6.11.0-rc1+)
[  605.333498] MSR:  900000000000d033 <SF,HV,EE,PR,ME,IR,DR,RI,LE>  CR: 24044420  XER: 00000000
[  605.333598] IRQMASK: 0 
[  605.333598] GPR00: 0000000000000078 00007fffc0151d30 0000777e74437100 00000000003d0f00 
[  605.333598] GPR04: 0000777e5320e7c0 0000777e5320eff0 0000777e53216690 0000777e5320eff0 
[  605.333598] GPR08: 0000777e53216690 0000000000000000 0000000000000000 0000000000000000 
[  605.333598] GPR12: 0000000000000000 0000777e74447780 0000777e73824410 0000000000000000 
[  605.333598] GPR16: 0000777e74660000 0000777e73820320 0000777e5320efe0 0000777e73824420 
[  605.333598] GPR20: 0000000000000000 0000000000000000 00000e5e33bf8c70 0000777e73e7c680 
[  605.333598] GPR24: 00000e5e33bf8de0 0000777e5320f690 0000777e5320e820 00007fffc0151e10 
[  605.333598] GPR28: 00007fffc0151e0f 00000000003d0f00 0000777e737e8750 0000777e5320ef20 
[  605.334310] NIP [0000777e7434ba24] 0x777e7434ba24
[  605.334366] LR [0000777e737e6bc4] 0x777e737e6bc4
[  605.334411] --- interrupt: c00
[  605.334454] INFO: task irqbalance:1262 blocked for more than 120 seconds.
[  605.334527]       Not tainted 6.11.0-rc1+ #13
[  605.334572] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  605.334649] task:irqbalance      state:D stack:0     pid:1262  tgid:1262  ppid:1      flags:0x00040080
[  605.334747] Sched_ext: simple (prepping)
[  605.334748] Call Trace:
[  605.334836] [c000000e5b69f5b0] [0000000000000001] 0x1 (unreliable)
[  605.334894] [c000000e5b69f760] [c00000000001d2d8] __switch_to+0x238/0x300
[  605.334957] [c000000e5b69f7c0] [c0000000012b8958] __schedule+0x6f8/0xbac
[  605.335031] [c000000e5b69f8b0] [c0000000012b8ec8] schedule+0xbc/0x174
[  605.335100] [c000000e5b69f920] [c0000000012b9028] schedule_preempt_disabled+0x28/0x48
[  605.335199] [c000000e5b69f950] [c0000000012bb5d0] __mutex_lock+0x390/0x9e8
[  605.335281] [c000000e5b69f9f0] [c000000000c3abf4] online_show+0x44/0xb0
[  605.335373] [c000000e5b69fa70] [c000000000c3a670] dev_attr_show+0x60/0xd0
[  605.335433] [c000000e5b69faf0] [c0000000006e3f44] sysfs_kf_seq_show+0xe4/0x190
[  605.335510] [c000000e5b69fb80] [c0000000006e244c] kernfs_seq_show+0x6c/0xa0
[  605.335596] [c000000e5b69fbc0] [c00000000061b988] seq_read_iter+0x1c8/0x560
[  605.335685] [c000000e5b69fca0] [c0000000006e0e78] kernfs_fop_read_iter+0x98/0x230
[  605.335779] [c000000e5b69fd00] [c0000000005cd6a8] vfs_read+0x2b8/0x330
[  605.335844] [c000000e5b69fda0] [c0000000005ce13c] ksys_read+0x9c/0x120
[  605.335921] [c000000e5b69fe00] [c000000000030cac] system_call_exception+0xfc/0x290
[  605.336019] [c000000e5b69fe50] [c00000000000c7d4] system_call_common+0xf4/0x258
[  605.336098] --- interrupt: c00 at 0x7344fed3356c
[  605.336150] NIP:  00007344fed3356c LR: 00007344fed33550 CTR: 0000000000000000
[  605.336242] REGS: c000000e5b69fe80 TRAP: 0c00   Not tainted  (6.11.0-rc1+)
[  605.336303] MSR:  900000000000d033 <SF,HV,EE,PR,ME,IR,DR,RI,LE>  CR: 24004284  XER: 00000000
[  605.336412] IRQMASK: 0 
[  605.336412] GPR00: 0000000000000003 00007fffd6167fd0 00007344fee37100 0000000000000007 
[  605.336412] GPR04: 00000eab8d894ea0 0000000000002000 0000000000000001 00007344ff507978 
[  605.336412] GPR08: 0000000000000002 0000000000000000 0000000000000000 0000000000000000 
[  605.336412] GPR12: 0000000000000000 00007344ff50efe0 0000000000000000 0000000065646f6e 
[  605.336412] GPR16: 0000000000000000 0000000000000000 0000000000000000 00000eab8d8a7eb0 
[  605.336412] GPR20: 00000eab53340ae8 00000eab533404d8 00007fffd6168468 00007fffd6168868 
[  605.336412] GPR24: 00000eab53340248 00000eab5334005c 000000000000000a 00007344fee2cca8 
[  605.336412] GPR28: 0000000000000bd0 0000000000000000 0000000000000007 0000000000002000 
[  605.337155] NIP [00007344fed3356c] 0x7344fed3356c
[  605.337211] LR [00007344fed33550] 0x7344fed33550
[  605.337280] --- interrupt: c00
[  605.337319] INFO: task dockerd:1935 blocked for more than 120 seconds.
[  605.337384]       Not tainted 6.11.0-rc1+ #13
[  605.337441] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  605.337512] task:dockerd         state:D stack:0     pid:1935  tgid:1866  ppid:1      flags:0x00040080
[  605.337615] Sched_ext: simple (prepping)
[  605.337616] Call Trace:
[  605.337690] [c000000de4287750] [c000000ea246d800] 0xc000000ea246d800 (unreliable)
[  605.337790] [c000000de4287900] [c00000000001d2d8] __switch_to+0x238/0x300
[  605.337870] [c000000de4287960] [c0000000012b8958] __schedule+0x6f8/0xbac
[  605.337934] [c000000de4287a50] [c0000000012b8ec8] schedule+0xbc/0x174
[  605.338028] [c000000de4287ac0] [c0000000002243d4] percpu_rwsem_wait+0x184/0x1d0
[  605.338103] [c000000de4287b30] [c0000000012be358] __percpu_down_read+0x58/0x108
[  605.338169] [c000000de4287b70] [c0000000001f7c78] scx_pre_fork+0x88/0xa0
[  605.338257] [c000000de4287ba0] [c0000000001cbbb8] sched_fork+0x88/0x230
[  605.338345] [c000000de4287be0] [c00000000016a80c] copy_process+0x55c/0xfa0
[  605.338441] [c000000de4287cb0] [c00000000016cc3c] kernel_clone+0xcc/0x410
[  605.338500] [c000000de4287d30] [c00000000016d394] sys_clone+0xa4/0xe0
[  605.338585] [c000000de4287e00] [c000000000030cac] system_call_exception+0xfc/0x290
[  605.338666] [c000000de4287e50] [c00000000000c7d4] system_call_common+0xf4/0x258
[  605.338764] --- interrupt: c00 at 0x2c4f62c635c
[  605.338810] NIP:  000002c4f62c635c LR: 000002c4f62bb118 CTR: 0000000000000000
[  605.338904] REGS: c000000de4287e80 TRAP: 0c00   Not tainted  (6.11.0-rc1+)
[  605.338975] MSR:  900000000000d033 <SF,HV,EE,PR,ME,IR,DR,RI,LE>  CR: 24444444  XER: 00000000
[  605.339081] IRQMASK: 0 
[  605.339081] GPR00: 0000000000000078 000000c00059c560 000002c4f9757f00 0000000000004111 
[  605.339081] GPR04: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
[  605.339081] GPR08: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
[  605.339081] GPR12: 0000000000000000 00007f0632616750 0000000000000000 0000000000000000 
[  605.339081] GPR16: ffffffffffffffff 0000000000000084 0000000000000004 0000000000000000 
[  605.339081] GPR20: 0000000000000000 0000000000000000 000000c00059a3a0 0000000000000000 
[  605.339081] GPR24: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
[  605.339081] GPR28: 0000000000000000 000002c4f7d15780 000000c000783860 000002c4f62bb0c0 
[  605.339783] NIP [000002c4f62c635c] 0x2c4f62c635c
[  605.339838] LR [000002c4f62bb118] 0x2c4f62bb118
[  605.339899] --- interrupt: c00
[  605.339941] INFO: task scx_simple:2676 blocked for more than 120 seconds.
[  605.340034]       Not tainted 6.11.0-rc1+ #13
[  605.340076] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  605.340139] task:scx_simple      state:D stack:0     pid:2676  tgid:2676  ppid:2480   flags:0x00040080
[  605.340254] Sched_ext: simple (prepping)
[  605.340255] Call Trace:
[  605.340335] [c000000e5b6af5d0] [0000000000000001] 0x1 (unreliable)
[  605.340403] [c000000e5b6af780] [c00000000001d2d8] __switch_to+0x238/0x300
[  605.340495] [c000000e5b6af7e0] [c0000000012b8958] __schedule+0x6f8/0xbac
[  605.340587] [c000000e5b6af8d0] [c0000000012b8ec8] schedule+0xbc/0x174
[  605.340659] [c000000e5b6af940] [c0000000002243d4] percpu_rwsem_wait+0x184/0x1d0
[  605.340743] [c000000e5b6af9b0] [c0000000012be358] __percpu_down_read+0x58/0x108
[  605.340827] [c000000e5b6af9f0] [c0000000001707a8] cpus_read_lock+0x88/0xa0
[  605.340923] [c000000e5b6afa20] [c0000000002091cc] bpf_scx_reg+0x5dc/0xc50
[  605.340991] [c000000e5b6afc20] [c000000000443a80] bpf_struct_ops_link_create+0x150/0x1f0
[  605.341098] [c000000e5b6afc80] [c0000000003b75e8] link_create+0x78/0x430
[  605.341162] [c000000e5b6afcd0] [c0000000003b284c] __sys_bpf+0x39c/0x560
[  605.341248] [c000000e5b6afdc0] [c0000000003b0ee0] sys_bpf+0x50/0x80
[  605.341334] [c000000e5b6afe00] [c000000000030cac] system_call_exception+0xfc/0x290
[  605.341433] [c000000e5b6afe50] [c00000000000c7d4] system_call_common+0xf4/0x258
[  605.341504] --- interrupt: c00 at 0x78acc9142474
[  605.341578] NIP:  000078acc9142474 LR: 000001d33e92451c CTR: 0000000000000000
[  605.341644] REGS: c000000e5b6afe80 TRAP: 0c00   Not tainted  (6.11.0-rc1+)
[  605.341703] MSR:  900000000000d033 <SF,HV,EE,PR,ME,IR,DR,RI,LE>  CR: 28048824  XER: 00000000
[  605.341812] IRQMASK: 0 
[  605.341812] GPR00: 0000000000000169 00007fffe6869100 000078acc9237100 000000000000001c 
[  605.341812] GPR04: 00007fffe6869280 0000000000000040 0000000000000001 000001d33e927f00 
[  605.341812] GPR08: 000000000000001c 0000000000000000 0000000000000000 0000000000000000 
[  605.341812] GPR12: 0000000000000000 000078acc95bb9c0 000001d373e5ede0 000001d33e96bd48 
[  605.341812] GPR16: 000001d33e96bcb0 000001d33e96bf00 ffffffffffffffff 000001d33e9b0430 
[  605.341812] GPR20: 000078acc92318c8 00007fffe6869450 00007fffe68693d0 00000000ffffffff 
[  605.341812] GPR24: 0000000000000001 000001d33e9b0438 00007fffe6869938 000001d33e96bea8 
[  605.341812] GPR28: 000001d33e96bff0 000001d33e96bd00 0000000000000001 00007fffe6869100 
[  605.342533] NIP [000078acc9142474] 0x78acc9142474
[  605.342590] LR [000001d33e92451c] 0x1d33e92451c
[  605.342633] --- interrupt: c00
------------------------------------------------------

I'll see if I can collect more details, and if there's anything else
you'd want me check, please let me know.


Thanks,
Aboorva



