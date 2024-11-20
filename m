Return-Path: <linux-kernel+bounces-416332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3469D4366
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 22:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02B6D284261
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 21:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CA51BC9F7;
	Wed, 20 Nov 2024 21:09:38 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5046F2F2A
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 21:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732136978; cv=none; b=rRas29mK1cbtD+a9aL0Ityn/OvYH7BbiUbckmmnbUP1X6ksTHbg2SvwBtVveaB6yipl7p6F7fbFlxgehkvd1efCKhC9QktYqTy6SiSChiM9PLC8yVdQnwwjKU/vBfE5mamKzA0WMw5ZOqlZPxZnJ5AvxBM1U40N6BGmMjrWHsTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732136978; c=relaxed/simple;
	bh=BnvNHaN+1Ww3aWzWuvhj23W8joQlzMMqJtku+qUrZP0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=MGHZqrSTtbLr7QBYfVgGeAiWVfAtC+r2gKuw5LGTaEHUQFoUsKOESLUsx/5GcTQwVzHgjDHHzJu3i6P5K54vAhA1I9NRyGsECMqr1zXCUiamnMczguKiUBtwpY77MEvBQ+XE7R6rF5PNF78tN3jHJSJzQE0hHCRWNink+/C4E64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C500DC4CECD;
	Wed, 20 Nov 2024 21:09:35 +0000 (UTC)
Date: Wed, 20 Nov 2024 16:10:11 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Kreimer
 <algonell@gmail.com>, Ba Jing <bajing@cmss.chinamobile.com>, Eder Zulian
 <ezulian@redhat.com>, Gabriele Monaco <gmonaco@redhat.com>, Jan Stancek
 <jstancek@redhat.com>, Tomas Glozar <tglozar@redhat.com>, furkanonder
 <furkanonder@protonmail.com>
Subject: [GIT PULL] tracing/tools: Updates for v6.13
Message-ID: <20241120161011.2f5621c4@gandalf.local.home>
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

tracing/tools: Updates for 6.13

- Add ':' to getopt option 'trace-buffer-size' in timerlat_hist for
  consistency

- Remove unused sched_getattr define

- Rename sched_setattr() helper to syscall_sched_setattr() to avoid
  conflicts

- Update counters to long from int to avoid overflow

- Add libcpupower dependency detection

- Add --deepest-idle-state to timerlat to limit deep idle sleeps

- Other minor clean ups and documentation changes


Please pull the latest trace-tools-v6.13 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-tools-v6.13

Tag SHA1: 8207bfa366b221814c2d6000f6d22e048453d105
Head SHA1: 571f8b3f866a6d990a50fe5c89fe0ea78784d70b


Andrew Kreimer (1):
      rv: Fix a typo

Ba Jing (2):
      tools/rv: Correct the grammatical errors in the comments
      tools/rv: Correct the grammatical errors in the comments

Eder Zulian (1):
      rtla: use the definition for stdout fd when calling isatty()

Gabriele Monaco (2):
      rtla: Fix consistency in getopt_long for timerlat_hist
      verification/dot2: Improve dot parser robustness

Jan Stancek (2):
      tools/rtla: drop __NR_sched_getattr
      tools/rtla: fix collision with glibc sched_attr/sched_set_attr

Tomas Glozar (9):
      rtla/timerlat: Make timerlat_top_cpu->*_count unsigned long long
      rtla/timerlat: Make timerlat_hist_cpu->*_count unsigned long long
      tools/build: Add libcpupower dependency detection
      rtla: Add optional dependency on libcpupower
      rtla/utils: Add idle state disabling via libcpupower
      rtla/timerlat: Add --deepest-idle-state for top
      rtla/timerlat: Add --deepest-idle-state for hist
      rtla: Documentation: Mention --deepest-idle-state
      rtla/timerlat: Do not set params->user_workload with -U

furkanonder (3):
      tools/rtla: Improve code readability in timerlat_load.py
      tools/rtla: Enhance argument parsing in timerlat_load.py
      tools/rtla: Improve exception handling in timerlat_load.py

----
 .../tools/rtla/common_timerlat_options.rst         |   8 +
 kernel/trace/rv/rv.c                               |   2 +-
 tools/build/Makefile.feature                       |   1 +
 tools/build/feature/Makefile                       |   4 +
 tools/build/feature/test-libcpupower.c             |   8 +
 tools/tracing/rtla/Makefile                        |   2 +
 tools/tracing/rtla/Makefile.config                 |  10 ++
 tools/tracing/rtla/README.txt                      |   4 +
 tools/tracing/rtla/sample/timerlat_load.py         |  56 ++++---
 tools/tracing/rtla/src/osnoise_top.c               |   2 +-
 tools/tracing/rtla/src/timerlat_hist.c             |  64 +++++--
 tools/tracing/rtla/src/timerlat_top.c              |  54 +++++-
 tools/tracing/rtla/src/utils.c                     | 186 ++++++++++++++++++---
 tools/tracing/rtla/src/utils.h                     |  15 ++
 tools/verification/dot2/automata.py                |  18 +-
 tools/verification/rv/src/in_kernel.c              |   4 +-
 tools/verification/rv/src/trace.c                  |   2 +-
 17 files changed, 361 insertions(+), 79 deletions(-)
 create mode 100644 tools/build/feature/test-libcpupower.c
---------------------------

