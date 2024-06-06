Return-Path: <linux-kernel+bounces-203414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFCC8FDAC5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 01:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 833611F22087
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 23:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD8A167DAE;
	Wed,  5 Jun 2024 23:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="buqO5gCV"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDBF15FA60;
	Wed,  5 Jun 2024 23:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717630964; cv=none; b=J8OiZfSFwBqbOB2IJTGReLs1FCVSWG4JG9hNSek7hmUcTNrHUzmjQKMgqcq0u4+bguXTviyPxB+AKLSYOwDeiDYXB76u9UUYp88lpuwNStZOfBKYxXGkU/m0sr9TQA1ZK0wQoOTLycI38QwkwlPo5Dip0077glN2Vr0mgdsmB30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717630964; c=relaxed/simple;
	bh=WXQt7Uz1x9EKnoB6ZUegkyyVkyiPMN/xWa/2uN6wzYw=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=ShWfrQkvg1CGCYjSlEiNrFpTfgYKjdCVB6cOi+pYjy5utWnHB7KOM/vuftJYOAp0Hpab1rpag2HaNBkQBmK5liWBfJ+sQfVY01gKUhZrYqkywijqjhzgSnDt8F79K2iiYf3MTOANlf4FUyIjkW4n5qhs8R5tGY4d11J2BOxSn7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=buqO5gCV; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.196.39] (unknown [131.107.174.167])
	by linux.microsoft.com (Postfix) with ESMTPSA id A666D20682B1;
	Wed,  5 Jun 2024 16:42:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A666D20682B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1717630959;
	bh=vve1ErkSwKOMRBM3voRK1wKMFHNom7+f5fqKsm8C88k=;
	h=Date:From:To:Cc:Subject:From;
	b=buqO5gCVL1/1ZHwGWA/0XzDyNvFXb6m8w1pWHGOIwYkU6a53UZ0b6d1CgNw7bWFZq
	 9P8TMtF2upo6ETCMEpj+jYIkEDft6tIJOw2zKrbqon4Qj7xN38yrc6C0C3Y6lvwgrC
	 U3mjQ5ZordDZ+A490YNAuSUrb9XjCqbU4Inm+9Jw=
Message-ID: <1386cd49-36d0-4a5c-85e9-bc42056a5a38@linux.microsoft.com>
Date: Wed, 5 Jun 2024 16:42:39 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Rachel Menge <rachelmenge@linux.microsoft.com>
To: linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Content-Language: en-US
Cc: Wei Fu <fuweid89@gmail.com>, apais@linux.microsoft.com,
 Sudhanva Huruli <Sudhanva.Huruli@microsoft.com>, fuweid89@gmail.com,
 Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
 Oleg Nesterov <oleg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 Mike Christie <michael.christie@oracle.com>,
 Joel Granados <j.granados@samsung.com>, Mateusz Guzik <mjguzik@gmail.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>
Subject: [RCU] zombie task hung in synchronize_rcu_expedited
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

We are facing a soft lockup on our systems which appears to be related 
to rcu scheduling.

The bug appears as high CPU usage. Dmesg shows a soft lock which is 
associated with "zap_pid_ns_processes". I have confirmed the behavior on 
5.15 and 6.8 kernels.

This example was taken from an Ubuntu 22.04 VM running in a hyper-v 
environment.
rachel@ubuntu:~$ uname -a
Linux ubuntu 5.15.0-107-generic #117-Ubuntu SMP Fri Apr 26 12:26:49 UTC 
2024 x86_64 x86_64 x86_64 GNU/Linux

dmesg snippet:
watchdog: BUG: soft lockup - CPU#0 stuck for 212s! [npm start:306207]
Modules linked in: veth nf_conntrack_netlink xt_conntrack nft_chain_nat 
xt_MASQUERADE nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 
xfrm_user xfrm_algo nft_counter xt_addrtype nft_compat nf_tables 
nfnetlink binfmt_misc nls_iso8859_1 intel_rapl_msr serio_raw 
intel_rapl_common hyperv_fb hv_balloon joydev mac_hid sch_fq_codel 
dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua overlay 
iptable_filter ip6table_filter ip6_tables br_netfilter bridge stp llc 
arp_tables msr efi_pstore ip_tables x_tables autofs4 btrfs 
blake2b_generic zstd_compress raid10 raid456 async_raid6_recov 
async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid1 
raid0 multipath linear hyperv_drm drm_kms_helper syscopyarea sysfillrect 
sysimgblt fb_sys_fops crct10dif_pclmul cec hv_storvsc crc32_pclmul 
hid_generic hv_netvsc ghash_clmulni_intel scsi_transport_fc rc_core 
sha256_ssse3 hid_hyperv drm sha1_ssse3 hv_utils hid hyperv_keyboard 
aesni_intel crypto_simd cryptd hv_vmbus
CPU: 0 PID: 306207 Comm: npm start Tainted: G             L 
5.15.0-107-generic #117-Ubuntu
Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, 
BIOS Hyper-V UEFI Release v4.1 04/06/2022
RIP: 0010:_raw_spin_unlock_irqrestore+0x25/0x30
Code: eb 8d cc cc cc 0f 1f 44 00 00 55 48 89 e5 e8 3a b8 36 ff 66 90 f7 
c6 00 02 00 00 75 06 5d e9 e2 cb 22 00 fb 66 0f 1f 44 00 00 <5d> e9 d5 
cb 22 00 0f 1f 44 00 00 0f 1f 44 00 00 55 48 89 e5 8b 07
RSP: 0018:ffffb15fc915bc60 EFLAGS: 00000206
RAX: 0000000000000001 RBX: ffffb15fc915bcf8 RCX: 0000000000000000
RDX: ffff9d4713f9c828 RSI: 0000000000000246 RDI: ffff9d4713f9c820
RBP: ffffb15fc915bc60 R08: ffff9d4713f9c828 R09: ffff9d4713f9c828
R10: 0000000000000228 R11: ffffb15fc915bcf0 R12: ffff9d4713f9c820
R13: 0000000000000004 R14: ffff9d47305a9980 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff9d4643c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd63a1b6008 CR3: 0000000288bd6003 CR4: 0000000000370ef0
Call Trace:
  <IRQ>
  ? show_trace_log_lvl+0x1d6/0x2ea
  ? show_trace_log_lvl+0x1d6/0x2ea
  ? add_wait_queue+0x6b/0x80
  ? show_regs.part.0+0x23/0x29
  ? show_regs.cold+0x8/0xd
  ? watchdog_timer_fn+0x1be/0x220
  ? lockup_detector_update_enable+0x60/0x60
  ? __hrtimer_run_queues+0x107/0x230
  ? read_hv_clock_tsc_cs+0x9/0x30
  ? hrtimer_interrupt+0x101/0x220
  ? hv_stimer0_isr+0x20/0x30
  ? __sysvec_hyperv_stimer0+0x32/0x70
  ? sysvec_hyperv_stimer0+0x7b/0x90
  </IRQ>
  <TASK>
  ? asm_sysvec_hyperv_stimer0+0x1b/0x20
  ? _raw_spin_unlock_irqrestore+0x25/0x30
  add_wait_queue+0x6b/0x80
  do_wait+0x52/0x310
  kernel_wait4+0xaf/0x150
  ? thread_group_exited+0x50/0x50
  zap_pid_ns_processes+0x111/0x1a0
  forget_original_parent+0x348/0x360
  exit_notify+0x4a/0x210
  do_exit+0x24f/0x3c0
  do_group_exit+0x3b/0xb0
  __x64_sys_exit_group+0x18/0x20
  x64_sys_call+0x1937/0x1fa0
  do_syscall_64+0x56/0xb0
  ? do_user_addr_fault+0x1e7/0x670
  ? exit_to_user_mode_prepare+0x37/0xb0
  ? irqentry_exit_to_user_mode+0x17/0x20
  ? irqentry_exit+0x1d/0x30
  ? exc_page_fault+0x89/0x170
  entry_SYSCALL_64_after_hwframe+0x67/0xd1
RIP: 0033:0x7f60019daf8e
Code: Unable to access opcode bytes at RIP 0x7f60019daf64.
RSP: 002b:00007fff2812a468 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f5ffeda01b0 RCX: 00007f60019daf8e
RDX: 00007f6001a560c0 RSI: 0000000000000000 RDI: 0000000000000001
RBP: 00007fff2812a4b0 R08: 0000000000000024 R09: 0000000800000000
R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000000001
R13: 00007f60016f4a90 R14: 0000000000000000 R15: 00007f5ffede4d50
  </TASK>

Looking at the running processes, there are zombie threads
root@ubuntu:/home/rachel# ps aux | grep Z
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
rachel    305832  0.5  0.0      0     0 ?        Zsl  01:55   0:00 [npm 
start] <defunct>
rachel    308234  0.3  0.0      0     0 ?        Zl   01:55   0:00 [npm 
run zombie] <defunct>
rachel    308987  0.0  0.0      0     0 ?        Z    01:55   0:00 [sh] 
<defunct>
root      345328  0.0  0.0   6480  2220 pts/5    S+   01:56   0:00 grep 
--color=auto Z

"308234" zombie thread group shows a thread is stuck on 
synchronize_rcu_expedited
root@ubuntu:/home/rachel# ls /proc/308234/task
308234  308312
root@ubuntu:/home/rachel# cat /proc/308312/stack
[<0>] exp_funnel_lock+0x1eb/0x230
[<0>] synchronize_rcu_expedited+0x6d/0x1b0
[<0>] namespace_unlock+0xd6/0x1b0
[<0>] put_mnt_ns+0x74/0xa0
[<0>] free_nsproxy+0x1c/0x1b0
[<0>] switch_task_namespaces+0x5e/0x70
[<0>] exit_task_namespaces+0x10/0x20
[<0>] do_exit+0x212/0x3c0
[<0>] io_sq_thread+0x457/0x5b0
[<0>] ret_from_fork+0x22/0x30

To consistently reproduce the issue, disable "CONFIG_PREEMPT_RCU". It is 
unclear if this completely prevents the issue, but it is much easier to 
reproduce with preemption off. I was able to reproduce on the Ubuntu 
22.04 5.15.0-107-generic and 24.04 6.8.0-30-generic. There are 2 methods 
of reproducing. Both methods are hosted at 
https://github.com/rlmenge/rcu-soft-lock-issue-repro .

Repro using npm and docker:
Get the script here: 
https://github.com/rlmenge/rcu-soft-lock-issue-repro/blob/main/rcu-npm-repro.sh
# get image so that script doesn't keep pulling for images
$ sudo docker run telescope.azurecr.io/issue-repro/zombie:v1.1.11
$ sudo ./rcu-npm-repro.sh

This script creates several containers. Each container runs in new pid 
and mount namespaces. The container's entrypoint is `npm run task && npm 
start`.
npm run task: This command is to run `npm run zombie & npm run done` 
command.
npm run zombie: It's to run `while true; do echo zombie; sleep 1; done`. 
Infinite loop to print zombies.
npm run done: It's to run `echo done`. Short live process.
npm start: It's also a short live process. It will exit in a few seconds.

When `npm start` exits, the process tree in that pid namespace will be like
npm start (pid 1)
    |__npm run zombie
            |__ sh -c "whle true; do echo zombie; sleep 1; done"

Repro using golang:
Use the go module found here: 
https://github.com/rlmenge/rcu-soft-lock-issue-repro/blob/main/rcudeadlock.go

Run
$ go mod init rcudeadlock.go
$ go mod tidy
$ CGO_ENABLED=0 go build -o ./rcudeadlock ./
$ sudo ./rcudeadlock

This golang program is to simulate the npm reproducer without involving 
docker as dependency. This binary is using re-exec self to support 
multiple subcommands. It  also sets up processes in new pid and mount 
namespaces by unshare, since the `put_mnt_ns` is a critical code path in 
the kernel to reproduce this issue. Both mount and pid namespaces are 
required in this issue.

The entrypoint of new pid and mount namespaces is `rcudeadlock task && 
rcudeadlock start`.
rcudeadlock task: This command is to run `rcudeadlock zombie & 
rcudeadlock done`
rcudeadlock zombie: It's to run `bash -c "while true; do echo zombie; 
sleep 1; done"`. Infinite loop to print zombies.
rcudeadlock done: Prints done and exits.
rcudeadlock start: Prints `AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA` 10 times 
and exits.

When `rcudeadlock start` exits, the process tree in that pid namespace 
will be like
rcudeadlock start (pid 1)
    |__rcudeadlock zombie
            |__bash -c "while true; do echo zombie; sleep 1; done".

Each rcudeadlock process will set up 4 idle io_uring threads before 
handling commands, like `task`, `zombie`, `done` and `start`. That is 
similar to npm reproducer. Not sure that it's related to io_uring. But 
with io_uring idle threads, it's easy to reproduce this issue.

Thank you,
Rachel

