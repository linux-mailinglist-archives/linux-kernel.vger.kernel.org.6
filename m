Return-Path: <linux-kernel+bounces-253143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0043B931D2F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 00:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC1102825D8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 22:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5789F13C83D;
	Mon, 15 Jul 2024 22:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nh5wj+l7"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F29313C9CD
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 22:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721082737; cv=none; b=kTeLyJiNpu808PPyzDbWeFjEQtnpj4e6MYl5ufXkBFjyXocMXOZbfdOoFHQco7FOZl8yWuiWYS05jT+yGYoZfDXmCTU0zC8uIieNBsdiJfeabS+oZPPT3CiBCNXSzh4cwNjpjgl9QdIUbg4J3j9v/lZnro7vO3giisYlK+Vb2Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721082737; c=relaxed/simple;
	bh=cCQ/dDZtLxFAq6kNJolNSC2nyFw75yy5poaboJqO7qE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZMh2VUvr3bA68eHQK/vfx8+2f6/FKlsMjK6FjnP7O0ktUAVpKnlJNdz6yzV72BH0AquuEEaZM4fQT0Dyc+Z8MzspcvlBX4hNnPaFSSinc9PrBhraushlaT5s8mRIQWEAAiCCAyJIHEDQKsbkBSqTzPjQGc13hY8s+P7UkgAxtsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nh5wj+l7; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70af5fbf0d5so2991256b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 15:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721082734; x=1721687534; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=hQTmg6gNoZ2A3Wv6/0cVS+L9bdYEbBsPvzgZFph3pGI=;
        b=Nh5wj+l7qABqH8XEKLHDcift4ARgwNdHLNPapyoKChjabRkNKCCS0N9W3Zmw+fHQBY
         VGAio7rUVa51cT0OHPWLwUTRvi7ZhnGovzEjJRkxf+/X/ALZPKTfknhsZT2FyKKVQr03
         IOYfEdAwDGbR/hpwFTcJZHGXkJbZmvBq2UEzWC6ZV+ov4T1nr8TcyiUIW4gIWEpHYdLi
         3C5q+e2tUL8lqJwMPlaAE710IDDuaE/e8RXYW3mEeczT0aBXziMTZi2ZEIpZNBkouZVX
         2gV9zozPYOcxG1L/TniJn3rmp7Oxr8ZenWzzBa1/7e+CxzpNs/UnQHfad/Gu1P6djzWs
         AXVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721082734; x=1721687534;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hQTmg6gNoZ2A3Wv6/0cVS+L9bdYEbBsPvzgZFph3pGI=;
        b=VGqDvfrNB8ywR9SzyW9PBLAGsrOJmzjUH41Z59CpGpGm5cl7957AQBEf3MxBKtlq3z
         6MOccvmF4ctoIQ+3lhupnVxsP3Yl0sxT2ImE522Y9oFkCW9W7CjWfEoKbbkJX71u7SK8
         X+CKRoTxXhDBzVkHmxkadS8HC9CxDJUHLTXtxNq8Z1+7Rm0H5uzKWKrOR1XRSwF+lMBl
         rVeRT5/2VRqj+r7FE9TC/VEmehNKUv98lYFsyHrX0/UnOR6X26u1TpRUioIWZOjtHFM3
         vAs9PfAEi5wcBTNKWN/1dPdplaz5LV/FpMa4jTXgY7POcIRQiR0u/iHkzcHM0keaACSa
         Mdfw==
X-Gm-Message-State: AOJu0Yy79PRz6Mxpb7NZqQLpjOaBHMbFR6Evn66dylLx9L33DlOK5/ok
	afo+FdSBB9ZApWVDMlrywo/z8Cn9QHog1BfX9aLIKHGHX1DGNntI
X-Google-Smtp-Source: AGHT+IHWQDyGo/3otgvkhIlF9s1aakNlCiNUbnrgmfYXPhl0xBrHBVboPM/3mwgX9WCl91f1hGbIlA==
X-Received: by 2002:a05:6a20:8427:b0:1c0:ebca:963d with SMTP id adf61e73a8af0-1c3f1e73544mr68164637.4.1721082734339;
        Mon, 15 Jul 2024 15:32:14 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ebb6a44sm4890009b3a.67.2024.07.15.15.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 15:32:13 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 15 Jul 2024 12:32:12 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [GIT PULL] sched_ext: Initial pull request for v6.11
Message-ID: <ZpWjbCQPtuUcvo8r@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

NOTE: I couldn't get git-request-pull to generate the correct diffstat. The
      diffstat at the end is generated against the merged base and should
      match the diff when sched_ext-for-6.11 is pulled after tip/sched/core
      and bpf/for-next.

The following changes since commit d329605287020c3d1c3b0dadc63d8208e7251382:

  sched/fair: set_load_weight() must also call reweight_task() for SCHED_IDLE tasks (2024-07-04 15:59:52 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/ tags/sched_ext-for-6.11

for you to fetch changes up to 8bb30798fd6ee79e4041a32ca85b9f70345d8671:

  sched_ext: Fixes incorrect type in bpf_scx_init() (2024-07-14 18:10:10 -1000)

----------------------------------------------------------------
sched_ext: Initial pull request for v6.11

This is the initial pull request of sched_ext. The v7 patchset
(https://lkml.kernel.org/r/20240618212056.2833381-1-tj@kernel.org) is
applied on top of tip/sched/core + bpf/for-next as of Jun 18th.

  tip/sched/core 793a62823d1c ("sched/core: Drop spinlocks on contention iff kernel is preemptible")
  bpf/for-next   f6afdaf72af7 ("Merge branch 'bpf-support-resilient-split-btf'")

Since then, the following changes:

- cpuperf support which was a part of the v6 patchset was posted separately
  and then applied after reviews.

- tip/sched/core is pulled into resolve the conflicts between

    e83edbf88f18 ("sched: Add sched_class->reweight_task()")
    d32960528702 ("sched/fair: set_load_weight() must also call reweight_task() for SCHED_IDLE tasks")

  The former makes reweight_task() a sched_class operation for sched_ext
  while the latter fixed a bug around idle weight handling in the same area.
  The conflicts are not trivial although not that complicated either.

- Improve integration with sched core.

- DSQ iterator which was a part of the v6 patchset was posted separately.
  The iterator itself was applied after a couple revisions. The associated
  selective consumption kfunc can use further improvements and is still
  being worked on.

- The BPF scheduler couldn't directly dispatch to the local DSQ of another
  CPU using a SCX_DSQ_LOCAL_ON verdict. This caused difficulties around
  handling non-wakeup enqueues. Updated so that SCX_DSQ_LOCAL_ON can be used
  in the enqueue path too.

- Various fixes and improvements.

As the branch is based on top of tip/sched/core + bpf/for-next, please merge
after both are applied.

----------------------------------------------------------------
Aboorva Devarajan (1):
      sched_ext: Documentation: Remove mentions of scx_bpf_switch_all

Andrea Righi (2):
      sched_ext: fix typo in set_weight() description
      sched_ext: add CONFIG_DEBUG_INFO_BTF dependency

Colin Ian King (1):
      sched_ext: Fix spelling mistake: "intead" -> "instead"

David Vernet (6):
      sched_ext: Implement runnable task stall watchdog
      sched_ext: Print sched_ext info when dumping stack
      sched_ext: Implement SCX_KICK_WAIT
      sched_ext: Implement sched_ext_ops.cpu_acquire/release()
      sched_ext: Add selftests
      sched_ext: Make scx_bpf_cpuperf_set() @cpu arg signed

Hongyan Xia (1):
      sched/ext: Add BPF function to fetch rq

Jiapeng Chong (1):
      sched_ext: Fixes incorrect type in bpf_scx_init()

Tejun Heo (48):
      sched: Restructure sched_class order sanity checks in sched_init()
      sched: Allow sched_cgroup_fork() to fail and introduce sched_cancel_fork()
      sched: Add sched_class->reweight_task()
      sched: Add sched_class->switching_to() and expose check_class_changing/changed()
      sched: Factor out cgroup weight conversion functions
      sched: Factor out update_other_load_avgs() from __update_blocked_others()
      sched: Add normal_policy()
      sched_ext: Add boilerplate for extensible scheduler class
      sched_ext: Implement BPF extensible scheduler class
      sched_ext: Add scx_simple and scx_example_qmap example schedulers
      sched_ext: Add sysrq-S which disables the BPF scheduler
      sched_ext: Allow BPF schedulers to disallow specific tasks from joining SCHED_EXT
      sched_ext: Print debug dump after an error exit
      tools/sched_ext: Add scx_show_state.py
      sched_ext: Implement scx_bpf_kick_cpu() and task preemption support
      sched_ext: Add a central scheduler which makes all scheduling decisions on one CPU
      sched_ext: Make watchdog handle ops.dispatch() looping stall
      sched_ext: Add task state tracking operations
      sched_ext: Implement tickless support
      sched_ext: Track tasks that are subjects of the in-flight SCX operation
      sched_ext: Implement sched_ext_ops.cpu_online/offline()
      sched_ext: Bypass BPF scheduler while PM events are in progress
      sched_ext: Implement core-sched support
      sched_ext: Add vtime-ordered priority queue to dispatch_q's
      sched_ext: Documentation: scheduler: Document extensible scheduler class
      sched, sched_ext: Replace scx_next_task_picked() with sched_class->switch_class()
      cpufreq_schedutil: Refactor sugov_cpu_is_busy()
      sched_ext: Add cpuperf support
      sched_ext: Drop tools_clean target from the top-level Makefile
      sched_ext: Swap argument positions in kcalloc() call to avoid compiler warning
      Merge branch 'sched/core' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip into for-6.11
      sched, sched_ext: Simplify dl_prio() case handling in sched_fork()
      sched_ext: Account for idle policy when setting p->scx.weight in scx_ops_enable_task()
      sched_ext: Disallow loading BPF scheduler if isolcpus= domain isolation is in effect
      sched_ext: Minor cleanups in kernel/sched/ext.h
      sched, sched_ext: Open code for_balance_class_range()
      sched, sched_ext: Move some declarations from kernel/sched/ext.h to sched.h
      sched_ext: Take out ->priq and ->flags from scx_dsq_node
      sched_ext: Implement DSQ iterator
      sched_ext/scx_qmap: Add an example usage of DSQ iterator
      sched_ext: Reimplement scx_bpf_reenqueue_local()
      sched_ext: Make scx_bpf_reenqueue_local() skip tasks that are being migrated
      sched: Move struct balance_callback definition upward
      sched_ext: Open-code task_linked_on_dsq()
      sched_ext: Unpin and repin rq lock from balance_scx()
      sched_ext: s/SCX_RQ_BALANCING/SCX_RQ_IN_BALANCE/ and add SCX_RQ_IN_WAKEUP
      sched_ext: Allow SCX_DSQ_LOCAL_ON for direct dispatches
      sched_ext/scx_qmap: Pick idle CPU for direct dispatch on !wakeup enqueues

 Documentation/scheduler/index.rst                                   |    1
 Documentation/scheduler/sched-ext.rst                               |  316 +
 MAINTAINERS                                                         |   13
 drivers/tty/sysrq.c                                                 |    1
 include/asm-generic/vmlinux.lds.h                                   |    1
 include/linux/cgroup.h                                              |    4
 include/linux/sched.h                                               |    5
 include/linux/sched/ext.h                                           |  206
 include/linux/sched/task.h                                          |    3
 include/trace/events/sched_ext.h                                    |   32
 include/uapi/linux/sched.h                                          |    1
 init/init_task.c                                                    |   12
 kernel/Kconfig.preempt                                              |   26
 kernel/fork.c                                                       |   17
 kernel/sched/build_policy.c                                         |   11
 kernel/sched/core.c                                                 |  192
 kernel/sched/cpufreq_schedutil.c                                    |   50
 kernel/sched/debug.c                                                |    3
 kernel/sched/ext.c                                                  | 6537 ++++++++++++++++++++++++++
 kernel/sched/ext.h                                                  |   69
 kernel/sched/fair.c                                                 |   22
 kernel/sched/idle.c                                                 |    2
 kernel/sched/sched.h                                                |  158
 kernel/sched/syscalls.c                                             |   26
 lib/dump_stack.c                                                    |    1
 tools/Makefile                                                      |   10
 tools/sched_ext/.gitignore                                          |    2
 tools/sched_ext/Makefile                                            |  246
 tools/sched_ext/README.md                                           |  258 +
 tools/sched_ext/include/bpf-compat/gnu/stubs.h                      |   11
 tools/sched_ext/include/scx/common.bpf.h                            |  401 +
 tools/sched_ext/include/scx/common.h                                |   75
 tools/sched_ext/include/scx/compat.bpf.h                            |   28
 tools/sched_ext/include/scx/compat.h                                |  186
 tools/sched_ext/include/scx/user_exit_info.h                        |  111
 tools/sched_ext/scx_central.bpf.c                                   |  361 +
 tools/sched_ext/scx_central.c                                       |  135
 tools/sched_ext/scx_qmap.bpf.c                                      |  706 ++
 tools/sched_ext/scx_qmap.c                                          |  144
 tools/sched_ext/scx_show_state.py                                   |   39
 tools/sched_ext/scx_simple.bpf.c                                    |  156
 tools/sched_ext/scx_simple.c                                        |  107
 tools/testing/selftests/sched_ext/.gitignore                        |    6
 tools/testing/selftests/sched_ext/Makefile                          |  218
 tools/testing/selftests/sched_ext/config                            |    9
 tools/testing/selftests/sched_ext/create_dsq.bpf.c                  |   58
 tools/testing/selftests/sched_ext/create_dsq.c                      |   57
 tools/testing/selftests/sched_ext/ddsp_bogus_dsq_fail.bpf.c         |   42
 tools/testing/selftests/sched_ext/ddsp_bogus_dsq_fail.c             |   57
 tools/testing/selftests/sched_ext/ddsp_vtimelocal_fail.bpf.c        |   39
 tools/testing/selftests/sched_ext/ddsp_vtimelocal_fail.c            |   56
 tools/testing/selftests/sched_ext/dsp_local_on.bpf.c                |   65
 tools/testing/selftests/sched_ext/dsp_local_on.c                    |   58
 tools/testing/selftests/sched_ext/enq_last_no_enq_fails.bpf.c       |   21
 tools/testing/selftests/sched_ext/enq_last_no_enq_fails.c           |   60
 tools/testing/selftests/sched_ext/enq_select_cpu_fails.bpf.c        |   43
 tools/testing/selftests/sched_ext/enq_select_cpu_fails.c            |   61
 tools/testing/selftests/sched_ext/exit.bpf.c                        |   84
 tools/testing/selftests/sched_ext/exit.c                            |   55
 tools/testing/selftests/sched_ext/exit_test.h                       |   20
 tools/testing/selftests/sched_ext/hotplug.bpf.c                     |   61
 tools/testing/selftests/sched_ext/hotplug.c                         |  168
 tools/testing/selftests/sched_ext/hotplug_test.h                    |   15
 tools/testing/selftests/sched_ext/init_enable_count.bpf.c           |   53
 tools/testing/selftests/sched_ext/init_enable_count.c               |  166
 tools/testing/selftests/sched_ext/maximal.bpf.c                     |  132
 tools/testing/selftests/sched_ext/maximal.c                         |   51
 tools/testing/selftests/sched_ext/maybe_null.bpf.c                  |   36
 tools/testing/selftests/sched_ext/maybe_null.c                      |   49
 tools/testing/selftests/sched_ext/maybe_null_fail_dsp.bpf.c         |   25
 tools/testing/selftests/sched_ext/maybe_null_fail_yld.bpf.c         |   28
 tools/testing/selftests/sched_ext/minimal.bpf.c                     |   21
 tools/testing/selftests/sched_ext/minimal.c                         |   58
 tools/testing/selftests/sched_ext/prog_run.bpf.c                    |   32
 tools/testing/selftests/sched_ext/prog_run.c                        |   78
 tools/testing/selftests/sched_ext/reload_loop.c                     |   75
 tools/testing/selftests/sched_ext/runner.c                          |  201
 tools/testing/selftests/sched_ext/scx_test.h                        |  131
 tools/testing/selftests/sched_ext/select_cpu_dfl.bpf.c              |   40
 tools/testing/selftests/sched_ext/select_cpu_dfl.c                  |   72
 tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.bpf.c   |   89
 tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.c       |   72
 tools/testing/selftests/sched_ext/select_cpu_dispatch.bpf.c         |   41
 tools/testing/selftests/sched_ext/select_cpu_dispatch.c             |   70
 tools/testing/selftests/sched_ext/select_cpu_dispatch_bad_dsq.bpf.c |   37
 tools/testing/selftests/sched_ext/select_cpu_dispatch_bad_dsq.c     |   56
 tools/testing/selftests/sched_ext/select_cpu_dispatch_dbl_dsp.bpf.c |   38
 tools/testing/selftests/sched_ext/select_cpu_dispatch_dbl_dsp.c     |   56
 tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c            |   92
 tools/testing/selftests/sched_ext/select_cpu_vtime.c                |   59
 tools/testing/selftests/sched_ext/test_example.c                    |   49
 tools/testing/selftests/sched_ext/util.c                            |   71
 tools/testing/selftests/sched_ext/util.h                            |   13
 93 files changed, 13834 insertions(+), 95 deletions(-)

