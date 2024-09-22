Return-Path: <linux-kernel+bounces-335065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDD097E083
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 10:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24E9D1C209A7
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 08:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7663156993;
	Sun, 22 Sep 2024 08:12:26 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3596F28F4
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 08:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726992746; cv=none; b=mkOE76WaMNsAMJD6lo8sQuSQb+L1xKdbvLGzJjdrXsWRMmbKJgNJQeC6kpMBpaBgkUciCQr2/aMW+Y5DKQvPIHMCwYKd3WSuzg2VtLl9m3/e72H7TDgmapU4j5rGJ7AumyZVPviozsbtdtbRCmo8TMmKEAQTQ4Z5938KVYmWf1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726992746; c=relaxed/simple;
	bh=3ud95PH78zSAE3tJ/PsX1w2swk30wIPtdSkCoKtmw8I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=uYcqW1hckBHCIDxf75VGt7qxQkUx0laR5V+5p7DTdAQCP9b8DVAMMotmrKqxJEqcwcmO8qC+dgXoKOoJwyAjzjm6/tDWyyTVFYshUDI3Gsw9KjnjP8NsraeJF9oi52BpsiSb06STaOamueOz+/eGltWCrb+HAm6BE9SzCbWID10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F171C4CEC3;
	Sun, 22 Sep 2024 08:12:23 +0000 (UTC)
Date: Sun, 22 Sep 2024 04:12:19 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, Thorsten Blum
 <thorsten.blum@toblux.com>, Vincent Donnefort <vdonnefort@google.com>
Subject: [GIT PULL] ring-buffer: Updates for 6.12
Message-ID: <20240922041219.2906a1ab@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Linus,

ring-buffer: Updates for v6.12:

- Merged v6.11-rc3 into trace/ring-buffer/core

  The v6.11 ring buffer pull request was not made due to Mathieu Desnoyers
  making a comment to the pull request. Mathieu and I resolved it on IRC,
  but we did not let Linus know that it was resolved. Linus did not do the
  pull thinking it still had some unresolved issues.

  The ring buffer work for 6.12 was dependent on both this pull request as
  well as the reserve_mem kernel command line option that was going upstream
  through the memory management tree. The ring buffer repo was being used by
  others so it could not be rebased. In order to continue the work, the
  v6.11-rc3 branch was pulled in to get access to the reserve_mem work.

This has the 6.11 pull request that did not make it into 6.11, which was:

  tracing/ring-buffer: Have persistent buffer across reboots

  This allows for the tracing instance ring buffer to stay persistent across
  reboots. The way this is done is by adding to the kernel command line:

    trace_instance=boot_map@0x285400000:12M

  This will reserve 12 megabytes at the address 0x285400000, and then map
  the tracing instance "boot_map" ring buffer to that memory. This will
  appear as a normal instance in the tracefs system:

    /sys/kernel/tracing/instances/boot_map

  A user could enable tracing in that instance, and on reboot or kernel
  crash, if the memory is not wiped by the firmware, it will recreate the
  trace in that instance. For example, if one was debugging a shutdown of a
  kernel reboot:

   # cd /sys/kernel/tracing
   # echo function > instances/boot_map/current_tracer
   # reboot
  [..]
   # cd /sys/kernel/tracing
   # tail instances/boot_map/trace
         swapper/0-1       [000] d..1.   164.549800: restore_boot_irq_mode <-native_machine_shutdown
         swapper/0-1       [000] d..1.   164.549801: native_restore_boot_irq_mode <-native_machine_shutdown
         swapper/0-1       [000] d..1.   164.549802: disconnect_bsp_APIC <-native_machine_shutdown
         swapper/0-1       [000] d..1.   164.549811: hpet_disable <-native_machine_shutdown
         swapper/0-1       [000] d..1.   164.549812: iommu_shutdown_noop <-native_machine_restart
         swapper/0-1       [000] d..1.   164.549813: native_machine_emergency_restart <-__do_sys_reboot
         swapper/0-1       [000] d..1.   164.549813: tboot_shutdown <-native_machine_emergency_restart
         swapper/0-1       [000] d..1.   164.549820: acpi_reboot <-native_machine_emergency_restart
         swapper/0-1       [000] d..1.   164.549821: acpi_reset <-acpi_reboot
         swapper/0-1       [000] d..1.   164.549822: acpi_os_write_port <-acpi_reboot

  On reboot, the buffer is examined to make sure it is valid. The validation
  check even steps through every event to make sure the meta data of the
  event is correct. If any test fails, it will simply reset the buffer, and
  the buffer will be empty on boot.

The new changes for 6.12 are:

- Allow the tracing persistent boot buffer to use the "reserve_mem" option

  Instead of having the admin find a physical address to store the persistent
  buffer, which can be very tedious if they have to administrate several
  different machines, allow them to use the "reserve_mem" option that will
  find a location for them. It is not as reliable because of KASLR, as the
  loading of the kernel in different locations can cause the memory
  allocated to be inconsistent. Booting with "nokaslr" can make reserve_mem
  more reliable.

- Have function graph tracer handle offsets from a previous boot.

  The ring buffer output from a previous boot may have different addresses
  due to kaslr. Have the function graph tracer handle these by using the
  delta from the previous boot to the new boot address space.

- Only reset the saved meta offset when the buffer is started or reset

  In the persistent memory meta data, it holds the previous address space
  information, so that it can calculate the delta to have function tracing
  work. But this gets updated after being read to hold the new address
  space. But if the buffer isn't used for that boot, on reboot, the delta is
  now calculated from the previous boot and not the boot that holds the data
  in the ring buffer. This causes the functions not to be shown. Do not save
  the address space information of the current kernel until it is being
  recorded.

- Add a magic variable to test the valid meta data

  Add a magic variable in the meta data that can also be used for
  validation. The validator of the previous buffer doesn't need this magic
  data, but it can be used if the meta data is changed by a new kernel, which
  may have the same format that passes the validator but is used
  differently. This magic number can also be used as a "versioning" of the
  meta data.

- Align user space mapped ring buffer sub buffers to improve TLB entries

  Linus mentioned that the mapped ring buffer sub buffers were misaligned
  between the meta page and the sub-buffers, so that if the sub-buffers were
  bigger than PAGE_SIZE, it wouldn't allow the TLB to use bigger entries.

- Add new kernel command line "traceoff" to disable tracing on boot for instances

  If tracing is enabled for a boot instance, there needs a way to be able to
  disable it on boot so that new events do not get entered into the ring
  buffer and be mixed with events from a previous boot, as that can be
  confusing.

- Allow trace_printk() to go to other instances

  Currently, trace_printk() can only go to the top level instance. When
  debugging with a persistent buffer, it is really useful to be able to add
  trace_printk() to go to that buffer, so that you have access to them after
  a crash.

- Do not use "bin_printk()" for traces to a boot instance

  The bin_printk() saves only a pointer to the printk format in the ring
  buffer, as the reader of the buffer can still have access to it. But this
  is not the case if the buffer is from a previous boot. If the
  trace_printk() is going to a "persistent" buffer, it will use the slower
  version that writes the printk format into the buffer.

- Add command line option to allow trace_printk() to go to an instance

  Allow the kernel command line to define which instance the trace_printk()
  goes to, instead of forcing the admin to set it for every boot via the
  tracefs options.

- Start a document that explains how to use tracefs to debug the kernel

- Add some more kernel selftests to test user mapped ring buffer


Please pull the latest trace-ring-buffer-v6.12 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-ring-buffer-v6.12

Tag SHA1: a75472cfcdca7aab3512c18a4be525b1054b5c0f
Head SHA1: 75d7ff9aa0ae1a8d1b3f9c8c87dde3a4fbe9a2cf


Dan Carpenter (1):
      tracing: Fix NULL vs IS_ERR() check in enable_instances()

Steven Rostedt (10):
      Merge tag 'v6.11-rc3' into trace/ring-buffer/core
      tracing: Fix ifdef of snapshots to not prevent last_boot_info file
      tracing/fgraph: Have fgraph handle previous boot function addresses
      ring-buffer: Don't reset persistent ring-buffer meta saved addresses
      ring-buffer: Add magic and struct size to boot up meta data
      tracing: Add "traceoff" flag to boot time tracing instances
      tracing: Allow trace_printk() to go to other instance buffers
      tracing: Have trace_printk not use binary prints if boot buffer
      tracing: Add option to set an instance to be the trace_printk destination
      tracing/Documentation: Start a document on how to debug with tracing

Steven Rostedt (Google) (14):
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
      tracing: Allow boot instances to use reserve_mem boot memory

Thorsten Blum (1):
      ring-buffer: Use vma_pages() helper function

Vincent Donnefort (3):
      ring-buffer: Align meta-page to sub-buffers for improved TLB usage
      selftests/ring-buffer: Verify the entire meta-page padding
      selftests/ring-buffer: Handle meta-page bigger than the system

----
 Documentation/admin-guide/kernel-parameters.txt |  45 ++
 Documentation/trace/debugging.rst               | 159 ++++
 Documentation/trace/ftrace.rst                  |  12 +
 include/linux/ring_buffer.h                     |  20 +
 kernel/trace/ring_buffer.c                      | 949 +++++++++++++++++++++---
 kernel/trace/trace.c                            | 372 +++++++++-
 kernel/trace/trace.h                            |  14 +-
 kernel/trace/trace_functions_graph.c            |  23 +-
 kernel/trace/trace_output.c                     |  17 +-
 tools/testing/selftests/ring-buffer/map_test.c  |  24 +
 10 files changed, 1483 insertions(+), 152 deletions(-)
 create mode 100644 Documentation/trace/debugging.rst
---------------------------

