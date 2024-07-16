Return-Path: <linux-kernel+bounces-254378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A19B933274
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B9521C22E9D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C053E479;
	Tue, 16 Jul 2024 19:51:21 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D8C4687
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 19:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721159481; cv=none; b=MiSc8AWebP4GeFCsoryV2NWQuFqt9SmK0UjhGQ8k7+bXtIJ09Y5ylucZhjVHlO+VdgSjOoI+FDzmXgfnH6Uz26ulvxdKwZfN6PuLv9LxrwxPPVKzJ7NezoGD7KbhsDN0ryvHvJCjV6puZzCXB/QAQ8+vIajAv0ipO6kSWvUJ4hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721159481; c=relaxed/simple;
	bh=e+h+iaZib6jK7FvNdjDhQvqwY5343ycZsXjkJKaK3Zw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=seaqiBH+6yrvVI7AQm7mcfdBIwfXAUURyCe7jpPzP3H/44tVxdwoy2245D7xWJujI0PygwdSfLQNq79LDMVarVvcjOoQYZcwaWE94pCODYsBpsxWKBKAUP58C4gyub8nZhEWbYY9rLa5KGxn+5TSKlK66tPxse75OzNM5PHYtvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AEAFC116B1;
	Tue, 16 Jul 2024 19:51:19 +0000 (UTC)
Date: Tue, 16 Jul 2024 15:51:18 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, Thorsten Blum
 <thorsten.blum@toblux.com>
Subject: [GIT PULL] ring-buffer: Updates for 6.11
Message-ID: <20240716155118.152dea35@rorschach.local.home>
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


Please pull the latest ring-buffer-v6.11 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
ring-buffer-v6.11

Tag SHA1: d3d32acdae295a7eb0600aa878ff33f4fe52460d
Head SHA1: b96c312551b241bc17226c5347c6d6b38a1efd3e


Dan Carpenter (1):
      tracing: Fix NULL vs IS_ERR() check in enable_instances()

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

Thorsten Blum (1):
      ring-buffer: Use vma_pages() helper function

----
 Documentation/admin-guide/kernel-parameters.txt |   9 +
 include/linux/ring_buffer.h                     |  20 +
 kernel/trace/ring_buffer.c                      | 886 +++++++++++++++++++++---
 kernel/trace/trace.c                            | 244 ++++++-
 kernel/trace/trace.h                            |  10 +-
 kernel/trace/trace_output.c                     |  12 +-
 6 files changed, 1061 insertions(+), 120 deletions(-)
---------------------------

