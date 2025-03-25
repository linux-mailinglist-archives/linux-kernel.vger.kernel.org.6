Return-Path: <linux-kernel+bounces-575539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EE5A703CB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29E13169859
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F3D25C6F9;
	Tue, 25 Mar 2025 14:34:21 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132AF25A638
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 14:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742913259; cv=none; b=UjrOuKAmREix4f8yDVXFk/aYcJNU/yko2ePl4soFaGw9HExK6KFkGp7Hey63PVQTl2UOCfE8uapPwagM8SvkP+vTXPfgqkh9IfR+COG7cqaMm7NnOmK8Ym5jKLtHZE9BPW0C/R5i8kg5AB+5BjeT34w4tFQY7kOpvp978K1OBSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742913259; c=relaxed/simple;
	bh=PrCjgwJXdAKGTLy2RDPqMHQOsl2AIO8OBNqwsAnQgms=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=VjuZNzNRKbjUay0nxyd82ehkGKfYOCcfGG0OnP00o31WJp8WzeiOUyt6V7/JtDIJrt5fdCxgTH/BGb+c0g3MhNC3CfWru8vjZOTuovHyehcWd/50MdydzRWSQeUk5qFrjd2pyTab/wojxXygk81zvcpgE2zOn3UAZyUwHXOwdTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E23B7C4AF0C;
	Tue, 25 Mar 2025 14:34:18 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tx5Mt-00000002P2L-1FVl;
	Tue, 25 Mar 2025 10:35:03 -0400
Message-ID: <20250325143503.142711804@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 25 Mar 2025 10:34:44 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Clark Williams <williams@redhat.com>,
 Gabriele Monaco <gmonaco@redhat.com>
Subject: [for-next][PATCH 8/9] Documentation/rv: Add docs for the sched monitors
References: <20250325143436.168114339@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Gabriele Monaco <gmonaco@redhat.com>

Add man page and kernel documentation for the sched monitors, as sched
is a container of other monitors, document all in the same page.
sched is the first nested monitor, also explain what is a nested monitor
and how enabling containers or children monitors work.

To: Ingo Molnar <mingo@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: John Kacur <jkacur@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Link: https://lore.kernel.org/20250305140406.350227-9-gmonaco@redhat.com
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Documentation/tools/rv/rv-mon-sched.rst  |  69 +++++++++
 Documentation/trace/rv/monitor_sched.rst | 171 +++++++++++++++++++++++
 2 files changed, 240 insertions(+)
 create mode 100644 Documentation/tools/rv/rv-mon-sched.rst
 create mode 100644 Documentation/trace/rv/monitor_sched.rst

diff --git a/Documentation/tools/rv/rv-mon-sched.rst b/Documentation/tools/rv/rv-mon-sched.rst
new file mode 100644
index 000000000000..da0fe4c79ae5
--- /dev/null
+++ b/Documentation/tools/rv/rv-mon-sched.rst
@@ -0,0 +1,69 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============
+rv-mon-sched
+============
+-----------------------------
+Scheduler monitors collection
+-----------------------------
+
+:Manual section: 1
+
+SYNOPSIS
+========
+
+**rv mon sched** [*OPTIONS*]
+
+**rv mon <NESTED_MONITOR>** [*OPTIONS*]
+
+**rv mon sched:<NESTED_MONITOR>** [*OPTIONS*]
+
+DESCRIPTION
+===========
+
+The scheduler monitor collection is a container for several monitors to model
+the behaviour of the scheduler. Each monitor describes a specification that
+the scheduler should follow.
+
+As a monitor container, it will enable all nested monitors and set them
+according to OPTIONS.
+Nevertheless nested monitors can also be activated independently both by name
+and by specifying sched: , e.g. to enable only monitor tss you can do any of:
+
+    # rv mon sched:tss
+
+    # rv mon tss
+
+See kernel documentation for further information about this monitor:
+<https://docs.kernel.org/trace/rv/monitor_sched.html>
+
+OPTIONS
+=======
+
+.. include:: common_ikm.rst
+
+NESTED MONITOR
+==============
+
+The available nested monitors are:
+  * scpd: schedule called with preemption disabled
+  * snep: schedule does not enable preempt
+  * sncid: schedule not called with interrupt disabled
+  * snroc: set non runnable on its own context
+  * sco: scheduling context operations
+  * tss: task switch while scheduling
+
+SEE ALSO
+========
+
+**rv**\(1), **rv-mon**\(1)
+
+Linux kernel *RV* documentation:
+<https://www.kernel.org/doc/html/latest/trace/rv/index.html>
+
+AUTHOR
+======
+
+Written by Gabriele Monaco <gmonaco@redhat.com>
+
+.. include:: common_appendix.rst
diff --git a/Documentation/trace/rv/monitor_sched.rst b/Documentation/trace/rv/monitor_sched.rst
new file mode 100644
index 000000000000..24b2c62a3bc2
--- /dev/null
+++ b/Documentation/trace/rv/monitor_sched.rst
@@ -0,0 +1,171 @@
+Scheduler monitors
+==================
+
+- Name: sched
+- Type: container for multiple monitors
+- Author: Gabriele Monaco <gmonaco@redhat.com>, Daniel Bristot de Oliveira <bristot@kernel.org>
+
+Description
+-----------
+
+Monitors describing complex systems, such as the scheduler, can easily grow to
+the point where they are just hard to understand because of the many possible
+state transitions.
+Often it is possible to break such descriptions into smaller monitors,
+sharing some or all events. Enabling those smaller monitors concurrently is,
+in fact, testing the system as if we had one single larger monitor.
+Splitting models into multiple specification is not only easier to
+understand, but gives some more clues when we see errors.
+
+The sched monitor is a set of specifications to describe the scheduler behaviour.
+It includes several per-cpu and per-task monitors that work independently to verify
+different specifications the scheduler should follow.
+
+To make this system as straightforward as possible, sched specifications are *nested*
+monitors, whereas sched itself is a *container*.
+From the interface perspective, sched includes other monitors as sub-directories,
+enabling/disabling or setting reactors to sched, propagates the change to all monitors,
+however single monitors can be used independently as well.
+
+It is important that future modules are built after their container (sched, in
+this case), otherwise the linker would not respect the order and the nesting
+wouldn't work as expected.
+To do so, simply add them after sched in the Makefile.
+
+Specifications
+--------------
+
+The specifications included in sched are currently a work in progress, adapting the ones
+defined in by Daniel Bristot in [1].
+
+Currently we included the following:
+
+Monitor tss
+~~~~~~~~~~~
+
+The task switch while scheduling (tss) monitor ensures a task switch happens
+only in scheduling context, that is inside a call to `__schedule`::
+
+                     |
+                     |
+                     v
+                   +-----------------+
+                   |     thread      | <+
+                   +-----------------+  |
+                     |                  |
+                     | schedule_entry   | schedule_exit
+                     v                  |
+    sched_switch                        |
+  +---------------                      |
+  |                       sched         |
+  +-------------->                     -+
+
+Monitor sco
+~~~~~~~~~~~
+
+The scheduling context operations (sco) monitor ensures changes in a task state
+happen only in thread context::
+
+
+                        |
+                        |
+                        v
+    sched_set_state   +------------------+
+  +------------------ |                  |
+  |                   |  thread_context  |
+  +-----------------> |                  | <+
+                      +------------------+  |
+                        |                   |
+                        | schedule_entry    | schedule_exit
+                        v                   |
+                                            |
+                       scheduling_context  -+
+
+Monitor snroc
+~~~~~~~~~~~~~
+
+The set non runnable on its own context (snroc) monitor ensures changes in a
+task state happens only in the respective task's context. This is a per-task
+monitor::
+
+                        |
+                        |
+                        v
+                      +------------------+
+                      |  other_context   | <+
+                      +------------------+  |
+                        |                   |
+                        | sched_switch_in   | sched_switch_out
+                        v                   |
+    sched_set_state                         |
+  +------------------                       |
+  |                       own_context       |
+  +----------------->                      -+
+
+Monitor scpd
+~~~~~~~~~~~~
+
+The schedule called with preemption disabled (scpd) monitor ensures schedule is
+called with preemption disabled::
+
+                       |
+                       |
+                       v
+                     +------------------+
+                     |    cant_sched    | <+
+                     +------------------+  |
+                       |                   |
+                       | preempt_disable   | preempt_enable
+                       v                   |
+    schedule_entry                         |
+    schedule_exit                          |
+  +-----------------      can_sched        |
+  |                                        |
+  +---------------->                      -+
+
+Monitor snep
+~~~~~~~~~~~~
+
+The schedule does not enable preempt (snep) monitor ensures a schedule call
+does not enable preemption::
+
+                        |
+                        |
+                        v
+    preempt_disable   +------------------------+
+    preempt_enable    |                        |
+  +------------------ | non_scheduling_context |
+  |                   |                        |
+  +-----------------> |                        | <+
+                      +------------------------+  |
+                        |                         |
+                        | schedule_entry          | schedule_exit
+                        v                         |
+                                                  |
+                          scheduling_contex      -+
+
+Monitor sncid
+~~~~~~~~~~~~~
+
+The schedule not called with interrupt disabled (sncid) monitor ensures
+schedule is not called with interrupt disabled::
+
+                       |
+                       |
+                       v
+    schedule_entry   +--------------+
+    schedule_exit    |              |
+  +----------------- |  can_sched   |
+  |                  |              |
+  +----------------> |              | <+
+                     +--------------+  |
+                       |               |
+                       | irq_disable   | irq_enable
+                       v               |
+                                       |
+                        cant_sched    -+
+
+References
+----------
+
+[1] - https://bristot.me/linux-task-model
-- 
2.47.2



