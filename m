Return-Path: <linux-kernel+bounces-180522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAFE8C6FA7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 02:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58E16283D75
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 00:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A8B10E6;
	Thu, 16 May 2024 00:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cCo7iv5A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22EB7E1
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 00:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715820741; cv=none; b=DMWQIw1c3727dPpxWVdm8XIE/o7vIbPnaCRTS3/F0tbE4LmqGdcfnB1f4TOVW/eD5sYYNGcVdVQ6njSMbriBQ4v7EDzhbloUXzoYLOI6RK37NQN9+r/zJSRI7e2J65mO17nZuW/0sjXw8HGV8q8XrXukHTEW+dHnechLAjynECg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715820741; c=relaxed/simple;
	bh=MQChwxKevYNr8Xg3kmsYXwROXzpolSJQuiBbTDSvSYk=;
	h=Date:From:To:Cc:Subject:Message-Id:Mime-Version:Content-Type; b=EDV9bVfJMHCX53ehJVtM92Td1OMf8Kg71CYlUbysW8dWE5V70pd99AJ9htPG6HokDYXqfNFsnKh7g2Xy1ZtZKuUsYZOv3saiUkJyUJXCGnRkstxLLylVwbQ56k+OXNybjJx2S6vghR89ySNnPEqGY1J7caR2J8yoVAuwNpdXNnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cCo7iv5A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B468BC116B1;
	Thu, 16 May 2024 00:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715820741;
	bh=MQChwxKevYNr8Xg3kmsYXwROXzpolSJQuiBbTDSvSYk=;
	h=Date:From:To:Cc:Subject:From;
	b=cCo7iv5AR9P3RbcFteeyuA/PH4M7SM/Vx3x9DExTPnpozu9/QecLwzeqSvSjCj9+T
	 eIDm++0m00yFX8DVrks/UA+rUW7d/y5BBw1LO1uMRsQyqELG9flY7XO2H2d1AoI1kc
	 RyUnQYGejIT3xz1hP5ph/5fVjTHivV+GaK5WIAN3TcZCpHHXVBAxDO8boWl8q3zYay
	 IsQNGjMo1Dhs8s6jc6M+yEqxSEcyMqApj+OybOmggRxl8Y/j3bvy/gBKwkh1hkOabw
	 5cFIQQaxnKYhfC5bdEBC1/3vGUDOwTjsU/8Dp0ATO0i78z7ejWnEpgPMDwv3C5YNIp
	 2c0k6nFt1tWQA==
Date: Thu, 16 May 2024 09:52:16 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Jonathan Haslam <jonathan.haslam@gmail.com>, Kui-Feng Lee
 <thinker.li@gmail.com>, Masami Hiramatsu (Google) <mhiramat@kernel.org>,
 Stephen Brennan <stephen.s.brennan@oracle.com>, Ye Bin
 <yebin10@huawei.com>, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] probes updates for v6.10
Message-Id: <20240516095216.ac9a0fd13357450cc5f2e491@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Linus,

Probes updates for v6.10:

- tracing/probes: Adding new pseudo-types %pd and %pD support for dumping
  dentry name from 'struct dentry *' and file name from 'struct file *'.

- uprobes: Some performance optimizations have been done.
 . Speed up the BPF uprobe event by delaying the fetching of the uprobe
   event arguments that are not used in BPF.
 . Avoid locking by speculatively checking whether uprobe event is valid.
 . Reduce lock contention by using read/write_lock instead of spinlock for
   uprobe list operation. This improved BPF uprobe benchmark result 43% on
   average.

- rethook: Removes non-fatal warning messages when tracing stack from BPF
  and skip rcu_is_watching() validation in rethook if possible.

- objpool: Optimizing objpool (which is used by kretprobes and fprobe as
  rethook backend storage) by inlining functions and avoid caching nr_cpu_ids
  because it is a const value.

- fprobe: Add entry/exit callbacks types (code cleanup)
- kprobes: Check ftrace was killed in kprobes if it uses ftrace.


Please pull the latest probes-v6.10 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
probes-v6.10

Tag SHA1: 9c42dca969de36a7aaa9573844a863bb306dcafc
Head SHA1: 1a7d0890dd4a502a202aaec792a6c04e6e049547


Andrii Nakryiko (7):
      uprobes: encapsulate preparation of uprobe args buffer
      uprobes: prepare uprobe args buffer lazily
      uprobes: add speculative lockless system-wide uprobe filter check
      ftrace: make extra rcu_is_watching() validation check optional
      rethook: honor CONFIG_FTRACE_VALIDATE_RCU_IS_WATCHING in rethook_try_get()
      objpool: enable inlining objpool_push() and objpool_pop() operations
      objpool: cache nr_possible_cpus() and avoid caching nr_cpu_ids

Jiri Olsa (1):
      fprobe: Add entry/exit callbacks types

Jonathan Haslam (1):
      uprobes: reduce contention on uprobes_tree access

Kui-Feng Lee (1):
      rethook: Remove warning messages printed for finding return address of a frame.

Masami Hiramatsu (Google) (1):
      selftests/ftrace: Fix required features for VFS type test case

Stephen Brennan (1):
      kprobe/ftrace: bail out if ftrace was killed

Ye Bin (5):
      tracing/probes: support '%pd' type for print struct dentry's name
      tracing/probes: support '%pD' type for print struct file's name
      Documentation: tracing: add new type '%pd' and '%pD' for kprobe
      selftests/ftrace: add kprobe test cases for VFS type "%pd" and "%pD"
      selftests/ftrace: add fprobe test cases for VFS type "%pd" and "%pD"

----
 Documentation/trace/kprobetrace.rst                |   8 +-
 arch/csky/kernel/probes/ftrace.c                   |   3 +
 arch/loongarch/kernel/ftrace_dyn.c                 |   3 +
 arch/parisc/kernel/ftrace.c                        |   3 +
 arch/powerpc/kernel/kprobes-ftrace.c               |   3 +
 arch/riscv/kernel/probes/ftrace.c                  |   3 +
 arch/s390/kernel/ftrace.c                          |   3 +
 arch/x86/kernel/kprobes/ftrace.c                   |   3 +
 include/linux/fprobe.h                             |  18 ++--
 include/linux/kprobes.h                            |   7 ++
 include/linux/objpool.h                            | 105 ++++++++++++++++++-
 include/linux/trace_recursion.h                    |   2 +-
 kernel/events/uprobes.c                            |  22 ++--
 kernel/kprobes.c                                   |   6 ++
 kernel/trace/Kconfig                               |  13 +++
 kernel/trace/ftrace.c                              |   1 +
 kernel/trace/rethook.c                             |   4 +-
 kernel/trace/trace.c                               |   2 +-
 kernel/trace/trace_fprobe.c                        |   6 ++
 kernel/trace/trace_kprobe.c                        |   6 ++
 kernel/trace/trace_probe.c                         |  63 ++++++++++++
 kernel/trace/trace_probe.h                         |   2 +
 kernel/trace/trace_uprobe.c                        | 103 +++++++++++--------
 lib/objpool.c                                      | 112 ++-------------------
 .../ftrace/test.d/dynevent/fprobe_args_vfs.tc      |  41 ++++++++
 .../ftrace/test.d/kprobe/kprobe_args_vfs.tc        |  40 ++++++++
 26 files changed, 406 insertions(+), 176 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/fprobe_args_vfs.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_vfs.tc
-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

