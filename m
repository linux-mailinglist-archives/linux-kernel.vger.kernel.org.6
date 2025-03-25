Return-Path: <linux-kernel+bounces-575532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD11A703E4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8CB53B7E1A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D82E25A351;
	Tue, 25 Mar 2025 14:34:18 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3418B197A7A
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 14:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742913258; cv=none; b=siLT8d6xFd763W6XYGonn6K1WeNE1nbq+YcCDApSJTczC80sYrZp1+udu4C5J45efj4vFaScAXso/sOp+9/hVtsoJHMjzjlXv8bPJdrl07DUUnaOYpjfFgwW2YT25SSkE0jpQhPAxx+oZhAHUmnGzewToLvE71bugvVChT5Du34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742913258; c=relaxed/simple;
	bh=CvKuAYlNINIidt8CdiB5wzYSKP/PszRrKzsYeGd2G+A=;
	h=Message-ID:Date:From:To:Cc:Subject; b=ciyGndRQ55mKwlda0Oe16QM7Hm3yYpNGLSOne1ehAG6CETI6+QDSup0RQffTfqL/3MviCzwclr0yex7vbm7TONmKhW1cxvkB2vsTMqVnv+2fMQQpxBAYF3sO5IK+lwRoVtSjMM6xQ+LdsaabI0AhN9vSnhChT0OUN311oBhkItY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8100C4CEE4;
	Tue, 25 Mar 2025 14:34:17 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tx5Mr-00000002OyP-3t9M;
	Tue, 25 Mar 2025 10:35:01 -0400
Message-ID: <20250325143436.168114339@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 25 Mar 2025 10:34:36 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>
Subject: [for-next][PATCH 0/9] rv: Updates for 6.15
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
latency/for-next

Head SHA1: 4ffef9579ffc51647c5eb55869fb310f3c1e2db2


Gabriele Monaco (9):
      sched: Add sched tracepoints for RV task model
      rv: Add option for nested monitors and include sched
      rv: Add sco and tss per-cpu monitors
      rv: Add snroc per-task monitor
      rv: Add scpd, snep and sncid per-cpu monitors
      tools/rv: Add support for nested monitors
      verification/dot2k: Add support for nested monitors
      Documentation/rv: Add docs for the sched monitors
      tools/rv: Allow rv list to filter for container

----
 Documentation/tools/rv/rv-mon-sched.rst            |  69 ++++++
 Documentation/trace/rv/monitor_sched.rst           | 171 ++++++++++++++
 include/linux/rv.h                                 |   4 +-
 include/linux/sched.h                              |  16 ++
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
 kernel/trace/rv/monitors/wip/wip.c                 |   2 +-
 kernel/trace/rv/monitors/wwnr/wwnr.c               |   2 +-
 kernel/trace/rv/rv.c                               | 154 +++++++++++--
 kernel/trace/rv/rv.h                               |   4 +
 kernel/trace/rv/rv_reactors.c                      |  28 ++-
 kernel/trace/rv/rv_trace.h                         |   6 +
 tools/verification/dot2/dot2k                      |  27 ++-
 tools/verification/dot2/dot2k.py                   |  79 +++++--
 tools/verification/dot2/dot2k_templates/Kconfig    |   1 +
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
 57 files changed, 2007 insertions(+), 127 deletions(-)
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

