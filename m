Return-Path: <linux-kernel+bounces-219666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E3990D63D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86FCB1C2453B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4867D156F5B;
	Tue, 18 Jun 2024 14:50:40 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1DB15623B
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 14:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718722239; cv=none; b=Q3T6sWfN9TlIyHvwJIxlj+3fFEmX+zqBIUS5fFJAzf/2NUZL8iuJRrQeLdUeZnWe4WCoJcVLQvBPFaIjhaVnGoYErBfYeWQnJ4YBkpIzrixz1nin0Phm02fQAbtTV8umuhBGIsEzPc/mGaAiuuqqHrQHG4x16d//50PfNIiyC4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718722239; c=relaxed/simple;
	bh=N9C4EcJ/VlzaLDIunlMZ84aF364AsJvgZz/5QDloHX8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=WydmtZMJ6SYMGUEOdHAlhuqDVoCRy1et521u8BapKrX4yOBu7vVU0JMVULxlo36NDwem8WXdcGOIlqkd0cbWCLjD4++fiZZz2qgB7FXVT935uuFlHVR9YXcq3D0OlY/i2mDVjPIBxGVxx9UEM/QzGLcTQgXN+BmT9ICAbK+mOzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F9F3C3277B;
	Tue, 18 Jun 2024 14:50:38 +0000 (UTC)
Date: Tue, 18 Jun 2024 10:50:36 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>
Subject: Crash when CONFIG_FORCE_NR_CPUS is set and nr_cpus does not match
Message-ID: <20240618105036.208a8860@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Not sure if this is considered an issue or not, but I've been working
on my user space libraries and in one of the self tests I run caused
the following crash:

[  406.491501] BUG: unable to handle page fault for address: ffffffffad02bc08
[  406.494714] #PF: supervisor read access in kernel mode
[  406.496689] #PF: error_code(0x0000) - not-present page
[  406.499033] PGD 175018067 P4D 175018067 PUD 175019063 PMD 10c51e063 PTE 800ffffe8a7d4062
[  406.502285] Oops: Oops: 0000 [#1] PREEMPT SMP PTI
[  406.504432] CPU: 0 PID: 14 Comm: rcu_tasks_rude_ Tainted: G        W          6.10.0-rc2-test-dirty #7
[  406.507979] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  406.511249] RIP: 0010:rcu_tasks_one_gp+0x331/0x3e0
[  406.513690] Code: e5 e9 de 00 48 8b 8b b8 00 00 00 48 c7 c0 e8 7a 61 ac eb 10 48 83 c0 08 48 3d e0 7c 61 ac 0f 84 ca fe ff ff 48 8b 10 48 01 ca <48> 8b 52 48 48 85 d2 74 e1 0f 0b eb dd 48 8b b3 28 01 00 00 48 c7
[  406.523889] RSP: 0018:ffff9f8a0007be78 EFLAGS: 00010086
[  406.525887] RAX: ffffffffac617b20 RBX: ffffffffac92e800 RCX: 000000000001cbc0
[  406.529585] RDX: ffffffffad02bbc0 RSI: 0000000000000000 RDI: 0000000000000000
[  406.532222] RBP: ffffffffac92e808 R08: 0000000000000000 R09: 0000000000000000
[  406.534815] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000202
[  406.537591] R13: 0000000000000293 R14: 0000000000000001 R15: 0000000000000003
[  406.540339] FS:  0000000000000000(0000) GS:ffff8f3c3de00000(0000) knlGS:0000000000000000
[  406.543448] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  406.545751] CR2: ffffffffad02bc08 CR3: 0000000175016001 CR4: 0000000000170ef0
[  406.548460] Call Trace:
[  406.549621]  <TASK>
[  406.550665]  ? __die+0x1f/0x70
[  406.552017]  ? page_fault_oops+0x15c/0x470
[  406.553532]  ? search_module_extables+0x15/0x60
[  406.555166]  ? search_bpf_extables+0x5b/0x90
[  406.556715]  ? exc_page_fault+0x142/0x150
[  406.558119]  ? asm_exc_page_fault+0x22/0x30
[  406.561599]  ? rcu_tasks_one_gp+0x331/0x3e0
[  406.563041]  ? rcu_tasks_one_gp+0x1d7/0x3e0
[  406.564432]  ? __pfx_rcu_tasks_kthread+0x10/0x10
[  406.565945]  rcu_tasks_kthread+0xb5/0xc0
[  406.567812]  kthread+0xce/0x100
[  406.569417]  ? __pfx_kthread+0x10/0x10
[  406.570987]  ret_from_fork+0x30/0x50
[  406.572648]  ? __pfx_kthread+0x10/0x10
[  406.574538]  ret_from_fork_asm+0x1a/0x30
[  406.576534]  </TASK>
[  406.577873] Modules linked in: qrtr hid_generic usbhid iTCO_wdt iTCO_vendor_support intel_rapl_msr intel_rapl_common snd_hda_codec_generic crct10dif_pclmul crc32_pclmul ghash_clmulni_intel snd_hda_intel sha512_ssse3 sha256_ssse3 snd_intel_dspcfg sha1_ssse3 snd_hda_codec aesni_intel snd_hwdep ahci psmouse crypto_simd snd_hda_core cryptd virtio_rng i2c_i801 vmw_vsock_virtio_transport libahci lpc_ich vmw_vsock_virtio_transport_common i2c_smbus vsock snd_pcm xhci_pci xhci_pci_renesas snd_timer input_leds evbug serio_raw mac_hid ip_tables x_tables
[  406.595464] CR2: ffffffffad02bc08
[  406.596443] ---[ end trace 0000000000000000 ]---
[  406.597624] RIP: 0010:rcu_tasks_one_gp+0x331/0x3e0
[  406.598841] Code: e5 e9 de 00 48 8b 8b b8 00 00 00 48 c7 c0 e8 7a 61 ac eb 10 48 83 c0 08 48 3d e0 7c 61 ac 0f 84 ca fe ff ff 48 8b 10 48 01 ca <48> 8b 52 48 48 85 d2 74 e1 0f 0b eb dd 48 8b b3 28 01 00 00 48 c7
[  406.602946] RSP: 0018:ffff9f8a0007be78 EFLAGS: 00010086
[  406.604253] RAX: ffffffffac617b20 RBX: ffffffffac92e800 RCX: 000000000001cbc0
[  406.605923] RDX: ffffffffad02bbc0 RSI: 0000000000000000 RDI: 0000000000000000
[  406.607590] RBP: ffffffffac92e808 R08: 0000000000000000 R09: 0000000000000000
[  406.609266] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000202
[  406.610932] R13: 0000000000000293 R14: 0000000000000001 R15: 0000000000000003
[  406.612626] FS:  0000000000000000(0000) GS:ffff8f3c3de00000(0000) knlGS:0000000000000000
[  406.614534] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  406.615941] CR2: ffffffffad02bc08 CR3: 0000000175016001 CR4: 0000000000170ef0
[  406.617604] note: rcu_tasks_rude_[14] exited with irqs disabled
[  406.619075] note: rcu_tasks_rude_[14] exited with preempt_count 1

At first I thought it may have to do with some of my work on eventfs.
And started looking at where it started. I tested 6.10-rc2, 6.9, 6.8,
6.7, 6.6 and they had the same crash. I know I added a lot of code in
6.6, and was thinking it had to do with that. But then I tested 6.5 and
it crashed the same way too!

Now I went back to 6.10-rc2 to debug in normally. I found that the
crash can happen if you do:

 # cd /sys/kernel/tracing
 # mkdir instance/foo
 # echo function > instance/foo/current_tracer
 # echo nop > instance/foo/current_tracer

Note, it only crashed when function tracing was started on an instance
and not at the top level. That's because the top level uses a global
descriptor to keep track of what functions are being traced, where as
an instance would allocate one, and when disabled, it must call RCU for
synchronization to be done to free that descriptor. That's where the
crash occurred.

 I found the crash happened here:

 rcu_tasks_need_gpcb():

		if (rtp->percpu_dequeue_lim == 1) {
			for (cpu = rtp->percpu_dequeue_lim; cpu < nr_cpu_ids; cpu++) {
				struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rtp->rtpcpu, cpu);

				WARN_ON_ONCE(rcu_segcblist_n_cbs(&rtpcp->cblist));
			}
		}

Specifically it was here:

 /* Return number of callbacks in segmented callback list. */
 static inline long rcu_segcblist_n_cbs(struct rcu_segcblist *rsclp)
 {
 #ifdef CONFIG_RCU_NOCB_CPU
	return atomic_long_read(&rsclp->len);
 #else
	return READ_ONCE(rsclp->len);   <<<<------------ CRASH
 #endif
 }

I was confused to how rtpcp could be passing in a NULL pointer as it is
a per cpu variable set up at boot. But I also noticed I was hitting
this warning at boot up which I've been ignoring but now find it is
related:

[    0.128523] ------------[ cut here ]------------
[    0.129275] WARNING: CPU: 0 PID: 0 at include/linux/cpumask.h:48 setup_nr_cpu_ids+0x11/0x30
[    0.130625] Modules linked in:
[    0.131119] CPU: 0 PID: 0 Comm: swapper Tainted: G        W          6.10.0-rc2-test-dirty #7
[    0.132507] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[    0.134006] RIP: 0010:setup_nr_cpu_ids+0x11/0x30
[    0.134751] Code: 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 e8 db 37 df fd 48 8b 05 f4 16 5a ff 48 85 c0 75 09 <0f> 0b 31 c0 e9 f6 90 cb fe 48 0f bd c0 83 f8 3f 75 ee 31 c0 e9 e6
[    0.137819] RSP: 0000:ffffffffbec03ef8 EFLAGS: 00010093 ORIG_RAX: 0000000000000000
[    0.139042] RAX: 0000000000000007 RBX: 0000000000000000 RCX: 0000000000000000
[    0.140187] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[    0.141333] RBP: ffffffffbf51c020 R08: 0000000000000000 R09: 0000000000000000
[    0.142473] R10: ffffa0c9c62c86c0 R11: 0000000000000000 R12: fffffffffffffff8
[    0.143622] R13: 0000000000000000 R14: 0000000000000000 R15: 000000000008a000
[    0.144775] FS:  0000000000000000(0000) GS:ffffffffbf40f000(0000) knlGS:0000000000000000
[    0.146074] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.146996] CR2: ffffa0c89ea01000 CR3: 000000015dc16000 CR4: 00000000000200b0
[    0.148147] Call Trace:
[    0.148557]  <TASK>
[    0.148895]  ? __warn+0x7c/0x120
[    0.149415]  ? setup_nr_cpu_ids+0x11/0x30
[    0.150060]  ? report_bug+0x16e/0x1a0
[    0.150649]  ? early_fixup_exception+0xc5/0xe0
[    0.151467]  ? early_idt_handler_common+0x2f/0x40
[    0.152228]  ? setup_nr_cpu_ids+0x11/0x30
[    0.152883]  ? setup_nr_cpu_ids+0x5/0x30
[    0.153513]  start_kernel+0x20c/0x870
[    0.154103]  x86_64_start_reservations+0x14/0x30
[    0.154846]  x86_64_start_kernel+0xa8/0xc0
[    0.155504]  common_startup_64+0x13b/0x148
[    0.156166]  </TASK>
[    0.156522] ---[ end trace 0000000000000000 ]---

That warning is:

 static inline void set_nr_cpu_ids(unsigned int nr)
 {
 #if (NR_CPUS == 1) || defined(CONFIG_FORCE_NR_CPUS)
	WARN_ON(nr != nr_cpu_ids);
 #else
	nr_cpu_ids = nr;
 #endif
 }

Looking at my config (which I used to help someone else debug a
problem, but never reset it[*]), it has:

 CONFIG_FORCE_NR_CPUS=y
 CONFIG_NR_CPUS=64

Disabling CONFIG_FORCE_NR_CPUS makes both the warning and the crash go
away.

My question is:  Is this something we should be concerned with?

Do we want to be robust enough to handle this case. It appears if we
force the NR_CPUS to something greater than what we have, things can
break in strange ways. Maybe that's OK. But as I spent a few hours
debugging this, I figured I report it and see if this is something we
care about.

-- Steve



[*] hmm, that bug still exists, I wonder if this is related to that too!


