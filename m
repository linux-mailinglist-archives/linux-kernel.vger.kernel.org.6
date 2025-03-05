Return-Path: <linux-kernel+bounces-546978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56984A5016F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7D593A86BD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E203324CEE1;
	Wed,  5 Mar 2025 14:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aaEjXS+Z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5433724BC1D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 14:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741183583; cv=none; b=W8h39vaK0gIx54RmE+21lvNoPKt0D6y5yAcnz/oLhCQpq+8Mi3K5gk2LXsEl+l0jBrzeX8arlmNE/vXbfr1pKh35w3QAb/9sAX1FpMc7PdFA+KOKQ0e5Wv73i8xB1e3DO5gNDUm58+JEJyDv4/6DZldxJXyueltKXAjGt6sgd6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741183583; c=relaxed/simple;
	bh=IY7DU1BhjQRR5Coi7wNZ7++4LSEJz4/d+wLFVatOJNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ffM7Tk53zwaRAOdTTK4O1CKNmq3i4ehWrZ2W+za9+oFIO7qhUuQEKjgUZAskVxl7cK9A8oXvmb2t5m2E+BefnErmooPUh0QOqOzh4XmHVxKQST4C1msFC0v9VgF+wjDJnSx2E8jtCH1iuRUquawfIuB8BGMea1Osb5rAE3KrDxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aaEjXS+Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741183580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rPPwrQnu9UKt/4NbsUXxMh/AuN498RxwAC9aj1izwuk=;
	b=aaEjXS+ZW/9pPGWqzTPbIGN8a+GsoBl2cex9Zuofx76964cU/6MkbrhJLWBUkr1ll99txP
	n0vlVIe3oHh4EG6XAONv7BO+sZgcZ+98jML0IJmQMl3+w9Q4WCI38W1B0fIBA0wpt5F6EM
	6zlmEOcjv22SduxqPeQFlUL/riwqg9M=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-336-lmc4OM4COHaAvJetnIsSxw-1; Wed,
 05 Mar 2025 09:06:02 -0500
X-MC-Unique: lmc4OM4COHaAvJetnIsSxw-1
X-Mimecast-MFC-AGG-ID: lmc4OM4COHaAvJetnIsSxw_1741183561
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 58A6A1AAA6E9;
	Wed,  5 Mar 2025 14:05:16 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.45.226.192])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D8DE7300070B;
	Wed,  5 Mar 2025 14:05:11 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-doc@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH v5 8/9] Documentation/rv: Add docs for the sched monitors
Date: Wed,  5 Mar 2025 15:04:01 +0100
Message-ID: <20250305140406.350227-9-gmonaco@redhat.com>
In-Reply-To: <20250305140406.350227-1-gmonaco@redhat.com>
References: <20250305140406.350227-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add man page and kernel documentation for the sched monitors, as sched
is a container of other monitors, document all in the same page.
sched is the first nested monitor, also explain what is a nested monitor
and how enabling containers or children monitors work.

To: Ingo Molnar <mingo@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 Documentation/tools/rv/rv-mon-sched.rst  |  69 +++++++++
 Documentation/trace/rv/monitor_sched.rst | 171 +++++++++++++++++++++++
 2 files changed, 240 insertions(+)
 create mode 100644 Documentation/tools/rv/rv-mon-sched.rst
 create mode 100644 Documentation/trace/rv/monitor_sched.rst

diff --git a/Documentation/tools/rv/rv-mon-sched.rst b/Documentation/tools/rv/rv-mon-sched.rst
new file mode 100644
index 0000000000000..da0fe4c79ae52
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
index 0000000000000..24b2c62a3bc26
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
2.48.1


