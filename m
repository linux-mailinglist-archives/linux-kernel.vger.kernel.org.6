Return-Path: <linux-kernel+bounces-210499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A98CF904498
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 21:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD1751C2332F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 19:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABC014AD3F;
	Tue, 11 Jun 2024 19:28:52 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8B82628D;
	Tue, 11 Jun 2024 19:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718134131; cv=none; b=P8ws9dEugkyfNBOtbmrtIRH0Vyifx5jAuOpySEUA9+n/kzbe/84ndg5lslnJ7khuA6tNMBQc9qV3cwTv1ixqbGjDi5CMiPPW14Aj2isYhXikqf2Oxvc4UxPBz3UFJK/t8DAZSOTGc6V41ekC+jquTle9G9xNClEWmNmLZhPqTrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718134131; c=relaxed/simple;
	bh=uDLUKFPJSd5Ts6o6hGD63umwFj6mprrLN/7tCjM1/K8=;
	h=Message-ID:Date:From:To:Cc:Subject; b=VSWWDJamnWGDQ1Qr7a2I3xXfzX2xmlsMJRhq4BSTtHnsxJP6y3N4Phe+scH0Bfbw0bRQViGQM1PY5ImNRb7jnA4o71ZuankIxLocmA5D+4iH55oXNP49PJSA0MmF7RY7hEIoVGc3I4zKr5dthhR9oRC0DNGp+NtxWNyTg/qhgnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 104D6C4AF1C;
	Tue, 11 Jun 2024 19:28:51 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sH7B5-00000001TpV-1ZZq;
	Tue, 11 Jun 2024 15:29:07 -0400
Message-ID: <20240611192828.691638177@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 11 Jun 2024 15:28:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vincent Donnefort <vdonnefort@google.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 suleiman@google.com,
 Thomas Gleixner <tglx@linutronix.de>,
 Vineeth Pillai <vineeth@bitbyteword.org>,
 Youssef Esmat <youssefesmat@google.com>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 Alexander Graf <graf@amazon.com>,
 Baoquan He <bhe@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 David Howells <dhowells@redhat.com>,
 Mike Rapoport <rppt@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Tony Luck <tony.luck@intel.com>,
 Guenter Roeck <linux@roeck-us.net>,
 Ross Zwisler <zwisler@google.com>,
 Kees Cook <keescook@chromium.org>
Subject: [PATCH v4 00/13] tracing: Persistent traces across a reboot or crash
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This is a way to map a ring buffer instance across reboots.
The requirement is that you have a memory region that is not erased.
I tested this on a Debian VM running on qemu on a Debian server,
and even tested it on a baremetal box running Fedora. I was
surprised that it worked on the baremetal box, but it does so
surprisingly consistently.

This series does not require the ring buffer mapping, but simply
takes a physical address that has been reserved via memmap (on x86 only)
An example of the kernel command line is:

  memmap=12M$0x285400000  trace_instance=boot_mapped@0x285400000:12M

The above will reserve 12M at physical address 0x285400000 (done by the
existing memmap command line option), and then the trace_instance option was
extended to take an address and size (@0x285400000:12M). It will then vmap()
that address and allocate a ring buffer in it. If a ring buffer already
exists, it will use it and expose the contents to user space.

The memory reserved is used by the ring buffer of this instance.
It acts like a memory mapped instance so it has some limitations. It does not
allow snapshots nor does it allow tracers which use a snapshot buffer (like
irqsoff and wakeup tracers).

On boot up, when setting up the ring buffer, it looks at the current
content and does a vigorous test to see if the content is valid.
It even walks the events in all the sub-buffers to make sure the
ring buffer meta data is correct. If it determines that the content
is valid, it will reconstruct the ring buffer to use the content
it has found.

If the buffer is valid, on the next boot, the boot_mapped instance
will contain the data from the previous boot. You can cat the
trace or trace_pipe file, or even run trace-cmd extract on it to
make a trace.dat file that holds the date. This is much better than
dealing with a ftrace_dump_on_opps (I wish I had this a decade ago!)

There are still some limitations of this buffer. One is that it assumes
that the kernel you are booting back into is the same one that crashed.
At least the trace_events (like sched_switch and friends) all have the
same ids. This would be true with the same kernel as the ids are determined
at link time.

Module events could possible be a problem as the ids may not match.

This version of the patch series saves a text function and a data
string address in the persistent memory, and this is used to calculate
the delta between text and data addresses of the new boot up. Now
function tracing and "%pS" still work across boots. Even the RCU
trace events that point to static strings work as well!

The delta is exported by a new file in the instance called "last_boot_info"
that has something like this:

     # cat last_boot_info
     text delta:    -268435456
     data delta:    -268435456

This can be used by trace-cmd that reads the trace_pipe_raw data and
now can figure out how to map the print_formats and kallsyms to the raw
data in the buffers.

This can be used to debug kernel shutdown. I ran the following:

  # trace-cmd start -B boot_mapped -p function
  # reboot

[after reboot]

  # trace-cmd show -B boot_mapped | tail -20
       swapper/0-1       [000] d..1.    63.479667: preempt_count_add <-delay_tsc
       swapper/0-1       [000] d..2.    63.479669: preempt_count_sub <-delay_tsc
       swapper/0-1       [000] d..1.    63.479671: disable_local_APIC <-native_stop_other_cpus
       swapper/0-1       [000] d..1.    63.479673: clear_local_APIC.part.0 <-disable_local_APIC
       swapper/0-1       [000] d..1.    63.479716: mcheck_cpu_clear <-native_stop_other_cpus
       swapper/0-1       [000] d..1.    63.479718: mce_intel_feature_clear <-native_stop_other_cpus
       swapper/0-1       [000] d..1.    63.479720: lmce_supported <-mce_intel_feature_clear
       swapper/0-1       [000] d..1.    63.479732: lapic_shutdown <-native_machine_shutdown
       swapper/0-1       [000] d..1.    63.479735: disable_local_APIC <-native_machine_shutdown
       swapper/0-1       [000] d..1.    63.479736: clear_local_APIC.part.0 <-disable_local_APIC
       swapper/0-1       [000] d..1.    63.479763: restore_boot_irq_mode <-native_machine_shutdown
       swapper/0-1       [000] d..1.    63.479763: native_restore_boot_irq_mode <-native_machine_shutdown
       swapper/0-1       [000] d..1.    63.479764: disconnect_bsp_APIC <-native_machine_shutdown
       swapper/0-1       [000] d..1.    63.479777: hpet_disable <-native_machine_shutdown
       swapper/0-1       [000] d..1.    63.479778: iommu_shutdown_noop <-native_machine_restart
       swapper/0-1       [000] d..1.    63.479779: native_machine_emergency_restart <-__do_sys_reboot
       swapper/0-1       [000] d..1.    63.479779: tboot_shutdown <-native_machine_emergency_restart
       swapper/0-1       [000] d..1.    63.479790: acpi_reboot <-native_machine_emergency_restart
       swapper/0-1       [000] d..1.    63.479791: acpi_reset <-acpi_reboot
       swapper/0-1       [000] d..1.    63.479791: acpi_os_write_port <-acpi_reboot

Enjoy...

Changes since v3: https://lore.kernel.org/all/20240606211735.684785459@goodmis.org/

- Removed an unused variable

- Fixed enable_instances() as the path without memory using the memory location
  in the command line parameter passed in "tok" where it now needs to be
  "name" for creating the snapshot buffer, otherwise it would pass in NULL
  which could crash the kernel on boot.

Changes since v2: https://lore.kernel.org/all/20240411012541.285904543@goodmis.org/

- Rebased on top of 6.10-rc2 that has the memory mapped ring buffer code.

- Added hard coded address to map to (from memmap=nn$ss), instead of relying
  on using reserve_mem (which I still want to add).

- Updated comments

- Restructured the validate code as the previous version broke the ring
  buffer timestamp validation code.


Steven Rostedt (Google) (13):
      ring-buffer: Allow mapped field to be set without mapping
      ring-buffer: Add ring_buffer_alloc_range()
      ring-buffer: Add ring_buffer_meta data
      tracing: Implement creating an instance based on a given memory region
      ring-buffer: Add output of ring buffer meta page
      ring-buffer: Add test if range of boot buffer is valid
      ring-buffer: Validate boot range memory events
      tracing: Add option to use memmapped memory for trace boot instance
      ring-buffer: Save text and data locations in mapped meta data
      tracing/ring-buffer: Add last_boot_info file to boot instance
      tracing: Handle old buffer mappings for event strings and functions
      tracing: Update function tracing output for previous boot buffer
      tracing: Add last boot delta offset for stack traces

----
 Documentation/admin-guide/kernel-parameters.txt |   9 +
 include/linux/ring_buffer.h                     |  20 +
 kernel/trace/ring_buffer.c                      | 853 +++++++++++++++++++++---
 kernel/trace/trace.c                            | 242 ++++++-
 kernel/trace/trace.h                            |   8 +
 kernel/trace/trace_output.c                     |  12 +-
 6 files changed, 1036 insertions(+), 108 deletions(-)

