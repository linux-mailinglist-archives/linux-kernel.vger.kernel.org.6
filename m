Return-Path: <linux-kernel+bounces-546972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D16A8A50155
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 114B816DC25
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B50A24C077;
	Wed,  5 Mar 2025 14:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="erzLKyJ3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4166B24A06E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 14:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741183533; cv=none; b=JV0E/nUU8KBsNwLIZODPQK4BUW4zqw4E4BCojk4yFn6qyLJ5i2xVX3rDblzvpximhhYNLotcUU9Yah+UjheTbYjg1ms1G/qCsLlqjsfNxRaOqxgMwMfmQE+JImTxGs5ALA2R7dBtOvL7qD4syEIipMMX99OlD0cO5NSTq/CC7iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741183533; c=relaxed/simple;
	bh=LJBiD5vySMA848rOxRHS1v2dZHdxu3GgB4iaBonbetc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VeqXcAyWQogFM+RBEFEm94ek1clvJ5ds2bt8lKsmZ4+g70HMKiC9g5tk/9AFAYPKjnsa26Mk/TR5/QsLJa5y35EngEs0yxsxgKCcc7xqN7jpojIUzMBfRtTse6L6B/A1j5FUyFjB1/sVX/QJI0Eykh8Ch+viZ2rcxBjnuS+Yg/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=erzLKyJ3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741183530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FIF96MJLsJ+EV77svV8v30mxOaOCR1SrMLFcp0J3ao0=;
	b=erzLKyJ3GmXkWbyoIpyuNjD9TNucVydDwJ0PtqCIn4X0n/Fft8lTeOI4u6kBt06iCxZUCG
	zTLFFkArpVrTqvP5go1CdzIljQZ0XMfwgtg1D0JwiIi06/Vs0ZEyKkSa/lv05Sg0OfZMrT
	hNJtHMaoXmUJtsuaAqmWIogrhlQu8qs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-286-dibCAbDsN-y2W9Imy10HLg-1; Wed,
 05 Mar 2025 09:05:25 -0500
X-MC-Unique: dibCAbDsN-y2W9Imy10HLg-1
X-Mimecast-MFC-AGG-ID: dibCAbDsN-y2W9Imy10HLg_1741183524
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3373C18E98FA;
	Wed,  5 Mar 2025 14:04:38 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.45.226.192])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1442A3000708;
	Wed,  5 Mar 2025 14:04:32 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v5 0/9] rv: Add scheduler specification monitors
Date: Wed,  5 Mar 2025 15:03:53 +0100
Message-ID: <20250305140406.350227-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This patchset starts including adapted scheduler specifications from
Daniel's task model [1].
As the model is fairly complicated, it is split in several generators
and specifications. The tool used to create the model can output a
unified model, but that would be hardly readable (9k states).

RV allows monitors to run and react concurrently. Running the cumulative
model is equivalent to running single components using the same
reactors, with the advantage that it's easier to point out which
specification failed in case of error.

We allow this by introducing nested monitors, in short, the sysfs
monitor folder will contain a monitor named sched, which is nothing but
an empty container for other monitors. Controlling the sched monitor
(enable, disable, set reactors) controls all nested monitors.

The task model proposed by Daniel includes 12 generators and 33
specifications. The generators are good for documentation but are
usually implied in some specifications.
Not all monitors work out of the box, mainly because of those reasons:
* need to distinguish if preempt disable leads to schedule
* need to distinguish if irq disable comes from an actual irq
* assumptions not always true on SMP

The original task model was designed for PREEMPT_RT and this patchset is
only tested on an upstream kernel with full preemption enabled.

In patch 3-5 are included only some specifications that work without
further modifications. Ideally, we would adapt all specifications and
add them gradually to the sched monitor.

The series is based on 1-2/11 from V4 and won't build without at least
1/11 applied, those two patches are included separately during review.

Patch 1 adds some additional tracepoints in the scheduler's code to
complete the model, the tracepoints were already defined in Daniel's
patches but, as far as I understand, were never submitted

Patch 2 adds the empty sched monitor container and the infrastructure
for nested monitors

Patch 3 adds 2 per-cpu monitors using the tracepoints defined in 2

Patch 4 adds a per-task monitor using the tracepoints defined in 2

Patch 5 adds 3 more per-cpu monitors using the tracepoints defined in 2
and preemptirq tracepoints

Patch 6 adjusts the rv tool to support nested monitors

Patch 7 adjusts the dot2k tool to support nested monitors

Patch 8 adds some documentation for the sched monitors, including
a description of the included specifications

Patch 9 adapts the rv tool to list also filtering by container

Changes since V4:
* fix state given to tracepoint in current_restore_rtlock_saved_state
* removed first 2 patches, added separately

Changes since V3:
* revert skip static_branch_unlikely
* remove argument curr_state from set_state tracepoint
* fix typo

Changes since V2:
* fix reported compilation warnings:
    - missing __do_trace_ function if tracepoints are disabled
    - remove unused DA_MON_EVENT in sched's Kconfig
* improve condition to detect empty monitor containers

Changes since V1:
* skip static_branch_unlikely in function exporting the tracepoint
* rename function and make clear it should not be called directly
* add missing parameter documentation in rv_register_monitor

Changes since RFC:
* use static_branch_unlikely to trace set_state via external function
* allow nested monitors to be disabled via Kconfig
    - they are enabled by default if the container is enabled
* remove need_resched tracepoint as it needs a bit more work
    - will come in a following patch together with a monitor using it

[1] - https://bristot.me/linux-task-model
[2] - https://lore.kernel.org/linux-trace-kernel/20250128111926.303093-1-gmonaco@redhat.com

To: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: Tomas Glozar <tglozar@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org

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

 Documentation/tools/rv/rv-mon-sched.rst       |  69 +++++
 Documentation/trace/rv/monitor_sched.rst      | 171 ++++++++++++
 include/linux/rv.h                            |   4 +-
 include/linux/sched.h                         |  16 ++
 include/trace/events/sched.h                  |  13 +
 kernel/sched/core.c                           |  23 +-
 kernel/trace/rv/Kconfig                       |   7 +
 kernel/trace/rv/Makefile                      |   7 +
 kernel/trace/rv/monitors/sched/Kconfig        |  11 +
 kernel/trace/rv/monitors/sched/sched.c        |  38 +++
 kernel/trace/rv/monitors/sched/sched.h        |   3 +
 kernel/trace/rv/monitors/sco/Kconfig          |  14 +
 kernel/trace/rv/monitors/sco/sco.c            |  88 ++++++
 kernel/trace/rv/monitors/sco/sco.h            |  47 ++++
 kernel/trace/rv/monitors/sco/sco_trace.h      |  15 +
 kernel/trace/rv/monitors/scpd/Kconfig         |  15 +
 kernel/trace/rv/monitors/scpd/scpd.c          |  96 +++++++
 kernel/trace/rv/monitors/scpd/scpd.h          |  49 ++++
 kernel/trace/rv/monitors/scpd/scpd_trace.h    |  15 +
 kernel/trace/rv/monitors/sncid/Kconfig        |  15 +
 kernel/trace/rv/monitors/sncid/sncid.c        |  96 +++++++
 kernel/trace/rv/monitors/sncid/sncid.h        |  49 ++++
 kernel/trace/rv/monitors/sncid/sncid_trace.h  |  15 +
 kernel/trace/rv/monitors/snep/Kconfig         |  15 +
 kernel/trace/rv/monitors/snep/snep.c          |  96 +++++++
 kernel/trace/rv/monitors/snep/snep.h          |  49 ++++
 kernel/trace/rv/monitors/snep/snep_trace.h    |  15 +
 kernel/trace/rv/monitors/snroc/Kconfig        |  14 +
 kernel/trace/rv/monitors/snroc/snroc.c        |  85 ++++++
 kernel/trace/rv/monitors/snroc/snroc.h        |  47 ++++
 kernel/trace/rv/monitors/snroc/snroc_trace.h  |  15 +
 kernel/trace/rv/monitors/tss/Kconfig          |  14 +
 kernel/trace/rv/monitors/tss/tss.c            |  91 +++++++
 kernel/trace/rv/monitors/tss/tss.h            |  47 ++++
 kernel/trace/rv/monitors/tss/tss_trace.h      |  15 +
 kernel/trace/rv/monitors/wip/wip.c            |   2 +-
 kernel/trace/rv/monitors/wwnr/wwnr.c          |   2 +-
 kernel/trace/rv/rv.c                          | 154 +++++++++--
 kernel/trace/rv/rv.h                          |   4 +
 kernel/trace/rv/rv_reactors.c                 |  28 +-
 kernel/trace/rv/rv_trace.h                    |   6 +
 tools/verification/dot2/dot2k                 |  27 +-
 tools/verification/dot2/dot2k.py              |  79 ++++--
 .../verification/dot2/dot2k_templates/Kconfig |   1 +
 .../verification/dot2/dot2k_templates/main.c  |   4 +-
 .../dot2/dot2k_templates/main_container.c     |  38 +++
 .../dot2/dot2k_templates/main_container.h     |   3 +
 tools/verification/models/sched/sco.dot       |  18 ++
 tools/verification/models/sched/scpd.dot      |  18 ++
 tools/verification/models/sched/sncid.dot     |  18 ++
 tools/verification/models/sched/snep.dot      |  18 ++
 tools/verification/models/sched/snroc.dot     |  18 ++
 tools/verification/models/sched/tss.dot       |  18 ++
 tools/verification/rv/include/in_kernel.h     |   2 +-
 tools/verification/rv/include/rv.h            |   3 +-
 tools/verification/rv/src/in_kernel.c         | 256 ++++++++++++++----
 tools/verification/rv/src/rv.c                |  38 ++-
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


base-commit: 5860c6175c02e9f45af8cf5e6e32772232f5c2f3
-- 
2.48.1


