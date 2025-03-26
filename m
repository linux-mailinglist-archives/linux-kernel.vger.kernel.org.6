Return-Path: <linux-kernel+bounces-577219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D31A71A10
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB56B1887E5A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443541F3BAE;
	Wed, 26 Mar 2025 15:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUSKv+J8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A579C1E1DE8
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 15:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743001932; cv=none; b=SusMEBWu49nK8PMaHuZbU0FYzxgcsHTFr4D/xQKb4Nw8bLZJNTsJGKl3YLSSgZCWOTvN/Dza3yMrIHEqx9T8yJ4sPui5A0ujhUHHSw0AUyBfqWZPdBVnp6njKsn5+Xq9ZaA8L1xCry2zWIWof7es25ayg5KWMqRQvHc9zC6stXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743001932; c=relaxed/simple;
	bh=RgW2RYZH8Jk2OBNHrGZlinViA1WDXRjln/86bf50J/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JvqcVjdQDQNcTSUNPrI8MHzn82ETRNllluVU0NBLwjTl3wit7b17w4e4hNDIDNtqVNW7X7nG+G2FlZkfcnhpiMuLvYsjOIYqS2zsgnoD7md0lXOMRIRp7oAl651AhYQhmYmqAYftwjyt8NFU+72/dPwlmjxW4Wc0X3EGtNfJgFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUSKv+J8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A31AC4CEE2;
	Wed, 26 Mar 2025 15:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743001932;
	bh=RgW2RYZH8Jk2OBNHrGZlinViA1WDXRjln/86bf50J/8=;
	h=From:To:Cc:Subject:Date:From;
	b=WUSKv+J8xIsS2r1eWsmcTVPPaOToDWi+DnVr/wvxN0HRZJno+PxJ5u/1zyLE2ONVN
	 M+vNynJjwMHr4tk87E5IWSd4RrkwatgeNrIjeuri+/tIBmSGz1yGR4QA3AwYET1AC1
	 el8wlu10YnWm65yCHPJMmLi+chVE8Qe5mUC0yDqCz6XBNr4tTUqEJmtV2qS7zgNQME
	 +CZOH63FfBKGD/PF4dc3j/OmH703SZw7KyZRquLBOruiPOzNZdRtQM5rwcj7UEHnWC
	 vd9II/R6+SBZoR7qYXSKSyjyCEm4YoAR04CKoS/sxtB7oQv+muUW/1l+wLSMtJQcly
	 qB2J+Fc4JomEw==
From: carlos.bilbao@kernel.org
To: tglx@linutronix.de
Cc: bilbao@vt.edu,
	pmladek@suse.com,
	akpm@linux-foundation.org,
	jan.glauber@gmail.com,
	jani.nikula@intel.com,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	takakura@valinux.co.jp,
	john.ogness@linutronix.de,
	Carlos Bilbao <cbilbao@digitalocean.com>
Subject: [PATCH 0/2] Reduce CPU usage when finished handling panic
Date: Wed, 26 Mar 2025 10:12:02 -0500
Message-ID: <20250326151204.67898-1-carlos.bilbao@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Carlos Bilbao <cbilbao@digitalocean.com>

After the kernel has finished handling a panic, it enters a busy-wait loop.
But, this unnecessarily consumes CPU power and electricity. Plus, in VMs,
this negatively impacts the throughput of other VM guests running on the
same hypervisor.

This patch set introduces a weak function cpu_halt_after_panic() to give
architectures the option to halt the CPU during this state while still
allowing interrupts to be processed. Do so for arch/x86 by defining the
weak function and calling safe_halt().

Here's some numbers to support my claim, the perf stats from the hypervisor
after triggering a panic on a guest Linux kernel.

Samples: 55K of event 'cycles:P', Event count (approx.): 36090772574
Overhead  Command          Shared Object            Symbol
  42.20%  CPU 5/KVM        [kernel.kallsyms]        [k] vmx_vmexit
  19.07%  CPU 5/KVM        [kernel.kallsyms]        [k] vmx_spec_ctrl_restore_host
   9.73%  CPU 5/KVM        [kernel.kallsyms]        [k] vmx_vcpu_enter_exit
   3.60%  CPU 5/KVM        [kernel.kallsyms]        [k] __flush_smp_call_function_queue
   2.91%  CPU 5/KVM        [kernel.kallsyms]        [k] vmx_vcpu_run
   2.85%  CPU 5/KVM        [kernel.kallsyms]        [k] native_irq_return_iret
   2.67%  CPU 5/KVM        [kernel.kallsyms]        [k] native_flush_tlb_one_user
   2.16%  CPU 5/KVM        [kernel.kallsyms]        [k] llist_reverse_order
   2.10%  CPU 5/KVM        [kernel.kallsyms]        [k] __srcu_read_lock
   2.08%  CPU 5/KVM        [kernel.kallsyms]        [k] flush_tlb_func
   1.52%  CPU 5/KVM        [kernel.kallsyms]        [k] vcpu_enter_guest.constprop.0

And here are the results from the guest VM after applying my patch:

Samples: 51  of event 'cycles:P', Event count (approx.): 37553709
Overhead  Command          Shared Object            Symbol
   7.94%  qemu-system-x86  [kernel.kallsyms]        [k] __schedule
   7.94%  qemu-system-x86  libc.so.6                [.] 0x00000000000a2702
   7.94%  qemu-system-x86  qemu-system-x86_64       [.] 0x000000000057603c
   7.43%  qemu-system-x86  libc.so.6                [.] malloc
   7.43%  qemu-system-x86  libc.so.6                [.] 0x00000000001af9c0
   6.37%  IO mon_iothread  libglib-2.0.so.0.7200.4  [.] g_mutex_unlock
   5.21%  IO mon_iothread  [kernel.kallsyms]        [k] __pollwait
   4.70%  IO mon_iothread  [kernel.kallsyms]        [k] clear_bhb_loop
   3.56%  IO mon_iothread  [kernel.kallsyms]        [k] __secure_computing
   3.56%  IO mon_iothread  libglib-2.0.so.0.7200.4  [.] g_main_context_query
   3.15%  IO mon_iothread  [kernel.kallsyms]        [k] __hrtimer_start_range_ns
   3.15%  IO mon_iothread  [kernel.kallsyms]        [k] _raw_spin_lock_irq
   2.88%  IO mon_iothread  libglib-2.0.so.0.7200.4  [.] g_main_context_prepare
   2.83%  qemu-system-x86  libglib-2.0.so.0.7200.4  [.] g_slist_foreach
   2.58%  IO mon_iothread  qemu-system-x86_64       [.] 0x00000000004e820d
   2.21%  qemu-system-x86  libc.so.6                [.] 0x0000000000088010
   1.94%  IO mon_iothread  [kernel.kallsyms]        [k] arch_exit_to_user_mode_prepar

As you can see, CPU consumption is significantly reduced after applying the
proposed change after panic logic, with KVM-related functions (e.g.,
vmx_vmexit()) dropping from more than 70% of CPU usage to virtually
nothing. Also, the num of samples decreased from 55K to 51 and the event
count dropped from 36.09 billion to 37.55 million.

Carlos Bilbao at DigitalOcean (2):
  panic: Allow archs to reduce CPU consumption after panic
  x86/panic: Use safe_halt() for CPU halt after panic

---

 arch/x86/kernel/Makefile |  1 +
 arch/x86/kernel/panic.c  |  9 +++++++++
 kernel/panic.c           | 12 +++++++++++-
 3 files changed, 21 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/kernel/panic.c


