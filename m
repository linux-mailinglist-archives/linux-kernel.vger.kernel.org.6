Return-Path: <linux-kernel+bounces-577298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A54B0A71B1B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2B6A7A7123
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A191F4196;
	Wed, 26 Mar 2025 15:50:24 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8271F416B
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 15:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743004224; cv=none; b=Y2+X+ZNMO3BHk6u7tbzPBsGJNGDhz90zw0m8I+0GmhBKWKdNAucVjRkflDef/D+KqRZC41W72GGuXvNgPnGcn34CWG+o2Gx1rilPeR2wvRXmZL5sc+kC3Fggc/NimrHWZk9jk7yViAVyW+7HZnEAYyK+PRbwWmz6xRDDidVLSeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743004224; c=relaxed/simple;
	bh=LzbKBR9wIboXNKQE+6dzB2GsBy+0kqdV+lC+GtAyOlY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=eS3Dc2JBid6w7YYkU0JwGJmkgLT9q0FdeJvVMJDBtUHYDBIqZo8l/0i/cDnbQb3r0RxVdBFXIUwZjALqcup6AxSLIhqjtRqMTD+OBDk+jtwLjUwaxlJt9rx0vkXNkGJ8Pf1p6AHDuqNoziUpReM0UTxo9OcxHEvLlr2PM4EokAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2097BC4CEE2;
	Wed, 26 Mar 2025 15:50:23 +0000 (UTC)
Date: Wed, 26 Mar 2025 11:51:09 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Gabriele Monaco <gmonaco@redhat.com>, Tomas Glozar
 <tglozar@redhat.com>
Subject: [GIT PULL] latency tracing: Updates for 6.15
Message-ID: <20250326115109.32b69701@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Linus,

Latency tracing changes for v6.15:

- Add some trace events to osnoise and timerlat sample generation

  This adds more information to the osnoise and timerlat tracers as well as
  allows BPF programs to be attached to these locations to extract even more
  data.

- Fix to DECLARE_TRACE_CONDITION() macro

  It wasn't used but now will be and it happened to be broken causing the
  build to fail.

- Add scheduler specification monitors to runtime verifier (RV)

  This is a continuation of Daniel Bristot's work.

  RV allows monitors to run and react concurrently. Running the cumulative
  model is equivalent to running single components using the same
  reactors, with the advantage that it's easier to point out which
  specification failed in case of error.

  This update introduces nested monitors to RV, in short, the sysfs
  monitor folder will contain a monitor named sched, which is nothing but
  an empty container for other monitors. Controlling the sched monitor
  (enable, disable, set reactors) controls all nested monitors.

  The following scheduling monitors are added:

  * sco: scheduling context operations
      Monitor to ensure sched_set_state happens only in thread context
  * tss: task switch while scheduling
      Monitor to ensure sched_switch happens only in scheduling context
  * snroc: set non runnable on its own context
      Monitor to ensure set_state happens only in the respective task's context
  * scpd: schedule called with preemption disabled
      Monitor to ensure schedule is called with preemption disabled
  * snep: schedule does not enable preempt
      Monitor to ensure schedule does not enable preempt
  * sncid: schedule not called with interrupt disabled
      Monitor to ensure schedule is not called with interrupt disabled


Please pull the latest trace-latency-v6.15 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-latency-v6.15

Tag SHA1: 8b5e36dd7793df531fdf118ea07c1e7a9389d044
Head SHA1: 4ffef9579ffc51647c5eb55869fb310f3c1e2db2


Gabriele Monaco (11):
      tracing: Fix DECLARE_TRACE_CONDITION
      rv: Add license identifiers to monitor files
      sched: Add sched tracepoints for RV task model
      rv: Add option for nested monitors and include sched
      rv: Add sco and tss per-cpu monitors
      rv: Add snroc per-task monitor
      rv: Add scpd, snep and sncid per-cpu monitors
      tools/rv: Add support for nested monitors
      verification/dot2k: Add support for nested monitors
      Documentation/rv: Add docs for the sched monitors
      tools/rv: Allow rv list to filter for container

Tomas Glozar (1):
      trace/osnoise: Add trace events for samples

----
 Documentation/tools/rv/rv-mon-sched.rst            |  69 ++++++
 Documentation/trace/rv/monitor_sched.rst           | 171 ++++++++++++++
 include/linux/rv.h                                 |   4 +-
 include/linux/sched.h                              |  16 ++
 include/trace/define_trace.h                       |   7 +
 include/trace/events/osnoise.h                     |  96 ++++++++
 include/trace/events/sched.h                       |  13 ++
 kernel/sched/core.c                                |  23 +-
 kernel/trace/rv/Kconfig                            |   7 +
 kernel/trace/rv/Makefile                           |   7 +
 kernel/trace/rv/monitors/sched/Kconfig             |  11 +
 kernel/trace/rv/monitors/sched/sched.c             |  38 +++
 kernel/trace/rv/monitors/sched/sched.h             |   3 +
 kernel/trace/rv/monitors/sco/Kconfig               |  14 ++
 kernel/trace/rv/monitors/sco/sco.c                 |  88 +++++++
 kernel/trace/rv/monitors/sco/sco.h                 |  47 ++++
 kernel/trace/rv/monitors/sco/sco_trace.h           |  15 ++
 kernel/trace/rv/monitors/scpd/Kconfig              |  15 ++
 kernel/trace/rv/monitors/scpd/scpd.c               |  96 ++++++++
 kernel/trace/rv/monitors/scpd/scpd.h               |  49 ++++
 kernel/trace/rv/monitors/scpd/scpd_trace.h         |  15 ++
 kernel/trace/rv/monitors/sncid/Kconfig             |  15 ++
 kernel/trace/rv/monitors/sncid/sncid.c             |  96 ++++++++
 kernel/trace/rv/monitors/sncid/sncid.h             |  49 ++++
 kernel/trace/rv/monitors/sncid/sncid_trace.h       |  15 ++
 kernel/trace/rv/monitors/snep/Kconfig              |  15 ++
 kernel/trace/rv/monitors/snep/snep.c               |  96 ++++++++
 kernel/trace/rv/monitors/snep/snep.h               |  49 ++++
 kernel/trace/rv/monitors/snep/snep_trace.h         |  15 ++
 kernel/trace/rv/monitors/snroc/Kconfig             |  14 ++
 kernel/trace/rv/monitors/snroc/snroc.c             |  85 +++++++
 kernel/trace/rv/monitors/snroc/snroc.h             |  47 ++++
 kernel/trace/rv/monitors/snroc/snroc_trace.h       |  15 ++
 kernel/trace/rv/monitors/tss/Kconfig               |  14 ++
 kernel/trace/rv/monitors/tss/tss.c                 |  91 ++++++++
 kernel/trace/rv/monitors/tss/tss.h                 |  47 ++++
 kernel/trace/rv/monitors/tss/tss_trace.h           |  15 ++
 kernel/trace/rv/monitors/wip/Kconfig               |   2 +
 kernel/trace/rv/monitors/wip/wip.c                 |   2 +-
 kernel/trace/rv/monitors/wip/wip.h                 |   1 +
 kernel/trace/rv/monitors/wwnr/Kconfig              |   2 +
 kernel/trace/rv/monitors/wwnr/wwnr.c               |   2 +-
 kernel/trace/rv/monitors/wwnr/wwnr.h               |   1 +
 kernel/trace/rv/rv.c                               | 154 +++++++++++--
 kernel/trace/rv/rv.h                               |   4 +
 kernel/trace/rv/rv_reactors.c                      |  28 ++-
 kernel/trace/rv/rv_trace.h                         |   6 +
 kernel/trace/trace_osnoise.c                       |  55 ++---
 tools/verification/dot2/dot2k                      |  27 ++-
 tools/verification/dot2/dot2k.py                   |  80 +++++--
 tools/verification/dot2/dot2k_templates/Kconfig    |   3 +
 tools/verification/dot2/dot2k_templates/main.c     |   4 +-
 .../dot2/dot2k_templates/main_container.c          |  38 +++
 .../dot2/dot2k_templates/main_container.h          |   3 +
 tools/verification/models/sched/sco.dot            |  18 ++
 tools/verification/models/sched/scpd.dot           |  18 ++
 tools/verification/models/sched/sncid.dot          |  18 ++
 tools/verification/models/sched/snep.dot           |  18 ++
 tools/verification/models/sched/snroc.dot          |  18 ++
 tools/verification/models/sched/tss.dot            |  18 ++
 tools/verification/rv/include/in_kernel.h          |   2 +-
 tools/verification/rv/include/rv.h                 |   3 +-
 tools/verification/rv/src/in_kernel.c              | 256 ++++++++++++++++-----
 tools/verification/rv/src/rv.c                     |  38 +--
 64 files changed, 2135 insertions(+), 166 deletions(-)
 create mode 100644 Documentation/tools/rv/rv-mon-sched.rst
 create mode 100644 Documentation/trace/rv/monitor_sched.rst
 create mode 100644 kernel/trace/rv/monitors/sched/Kconfig
 create mode 100644 kernel/trace/rv/monitors/sched/sched.c
 create mode 100644 kernel/trace/rv/monitors/sched/sched.h
 create mode 100644 kernel/trace/rv/monitors/sco/Kconfig
 create mode 100644 kernel/trace/rv/monitors/sco/sco.c
 create mode 100644 kernel/trace/rv/monitors/sco/sco.h
 create mode 100644 kernel/trace/rv/monitors/sco/sco_trace.h
 create mode 100644 kernel/trace/rv/monitors/scpd/Kconfig
 create mode 100644 kernel/trace/rv/monitors/scpd/scpd.c
 create mode 100644 kernel/trace/rv/monitors/scpd/scpd.h
 create mode 100644 kernel/trace/rv/monitors/scpd/scpd_trace.h
 create mode 100644 kernel/trace/rv/monitors/sncid/Kconfig
 create mode 100644 kernel/trace/rv/monitors/sncid/sncid.c
 create mode 100644 kernel/trace/rv/monitors/sncid/sncid.h
 create mode 100644 kernel/trace/rv/monitors/sncid/sncid_trace.h
 create mode 100644 kernel/trace/rv/monitors/snep/Kconfig
 create mode 100644 kernel/trace/rv/monitors/snep/snep.c
 create mode 100644 kernel/trace/rv/monitors/snep/snep.h
 create mode 100644 kernel/trace/rv/monitors/snep/snep_trace.h
 create mode 100644 kernel/trace/rv/monitors/snroc/Kconfig
 create mode 100644 kernel/trace/rv/monitors/snroc/snroc.c
 create mode 100644 kernel/trace/rv/monitors/snroc/snroc.h
 create mode 100644 kernel/trace/rv/monitors/snroc/snroc_trace.h
 create mode 100644 kernel/trace/rv/monitors/tss/Kconfig
 create mode 100644 kernel/trace/rv/monitors/tss/tss.c
 create mode 100644 kernel/trace/rv/monitors/tss/tss.h
 create mode 100644 kernel/trace/rv/monitors/tss/tss_trace.h
 create mode 100644 tools/verification/dot2/dot2k_templates/main_container.c
 create mode 100644 tools/verification/dot2/dot2k_templates/main_container.h
 create mode 100644 tools/verification/models/sched/sco.dot
 create mode 100644 tools/verification/models/sched/scpd.dot
 create mode 100644 tools/verification/models/sched/sncid.dot
 create mode 100644 tools/verification/models/sched/snep.dot
 create mode 100644 tools/verification/models/sched/snroc.dot
 create mode 100644 tools/verification/models/sched/tss.dot
---------------------------

