Return-Path: <linux-kernel+bounces-190527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0338CFF8E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1460E281CF9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E69315DBC8;
	Mon, 27 May 2024 12:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jFL4dlRy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386141581E2
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 12:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716811625; cv=none; b=Wg8cow73W9NkNUC0SP97LU0V+kAT9wBB8hhmHWIBQ5unCW39fUoO4nVtjz5EU+9tMqyUb7esvzX6ZbWYf/y5BdQ/QG5+mdwcT3Yd/eMdZVGSk8fmlMIH6CzJsKaMBa4Q1r9U85HDOAwuH7KYlsIx6Y6OJcrS2AvvLT/uUHnh00I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716811625; c=relaxed/simple;
	bh=5XYYGyI3+Gd7oGhQNziV1gdnkEUbXZhVwzEu+HExuMw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=idc7DwrA0C4cBv2VIMKlF27kDYjemSI/ba2ECa04O4UN9c9z/bsh9D9E3btFuoSi8AVPURFzpFFr7vproD/3hjWxuU7aClID4n077dvRXV4pUA5QStVGDLvS49D50CUIyplfYGC5utooMCRsK4novMBcvywJDs+yiLa5dgu9aWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jFL4dlRy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B99C2BBFC;
	Mon, 27 May 2024 12:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716811624;
	bh=5XYYGyI3+Gd7oGhQNziV1gdnkEUbXZhVwzEu+HExuMw=;
	h=From:To:Cc:Subject:Date:From;
	b=jFL4dlRya6g2/FZk2OqWE2Q3YJ+9Z4LavcvJn+MFNmm18AZJ1yOne7KBRn2G7URCH
	 bljoWU52CPGtzzUrTasVCMD9GOTggoFECYwphfwLQqXohdV1ZHVpS/dCA3Ok6H8Ugy
	 qy2to9trrFYU277W2f78LzOR5xCklf+PWxsvEyQDAq+wu/egnR5FglgZtDmYaAuPPX
	 S2UNVzlS1+iee5kZkVNhCzp/7iyB9IZUiDTDiJHrPvK2bG/ZDuUbABJWeqaX/YBmRP
	 k93hTaKrmIYE+4w5kR5fgAZYL5wXkuJuqozqc4M7NqoA/cma56jVV6S/5JBGkAuhXB
	 INTeXObYXuY3Q==
From: Daniel Bristot de Oliveira <bristot@kernel.org>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
	Thomas Gleixner <tglx@linutronix.de>,
	Joel Fernandes <joel@joelfernandes.org>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	bristot@kernel.org,
	Phil Auld <pauld@redhat.com>,
	Suleiman Souhlal <suleiman@google.com>,
	Youssef Esmat <youssefesmat@google.com>
Subject: [PATCH V7 0/9] SCHED_DEADLINE server infrastructure
Date: Mon, 27 May 2024 14:06:46 +0200
Message-ID: <cover.1716811043.git.bristot@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v7 of Peter's SCHED_DEADLINE server infrastructure
implementation [1].

SCHED_DEADLINE servers can help fixing starvation issues of low priority
tasks (e.g., SCHED_OTHER) when higher priority tasks monopolize CPU
cycles. Today we have RT Throttling; DEADLINE servers should be able to
replace and improve that.

In the v1 there was discussion raised about the consequence of using
deadline based servers on the fixed-priority workloads. For a demonstration
here is the baseline of timerlat scheduling latency as-is, with kernel
build background workload:

 # rtla timerlat top -u -d 10m

  --------------------- %< ------------------------
                                     Timer Latency
  0 01:42:24   |          IRQ Timer Latency (us)        |         Thread Timer Latency (us)      |    Ret user Timer Latency (us)
CPU COUNT      |      cur       min       avg       max |      cur       min       avg       max |      cur       min       avg       max
  0 #6143559   |        0         0         0        92 |        2         1         3        98 |        4         1         5       100
  1 #6143559   |        1         0         0        97 |        7         1         5       101 |        9         1         7       103
  2 #6143559   |        0         0         0        88 |        3         1         5        95 |        5         1         7        99
  3 #6143559   |        0         0         0        90 |        6         1         5       103 |       10         1         7       126
  4 #6143558   |        1         0         0        81 |        7         1         4        86 |        9         1         7        90
  5 #6143558   |        0         0         0        74 |        3         1         5        79 |        4         1         7        83
  6 #6143558   |        0         0         0        83 |        2         1         5        89 |        3         0         7       108
  7 #6143558   |        0         0         0        85 |        3         1         4       126 |        5         1         6       137
  --------------------- >% ------------------------

And this is the same tests with DL server activating without any delay:
  --------------------- %< ------------------------
  0 00:10:01   |          IRQ Timer Latency (us)        |         Thread Timer Latency (us)      |    Ret user Timer Latency (us)
CPU COUNT      |      cur       min       avg       max |      cur       min       avg       max |      cur       min       avg       max
  0 #579147    |        0         0         0        54 |        2         1        52     61095 |        2         2        56     61102
  1 #578766    |        0         0         0        83 |        2         1        49     55824 |        3         2        53     55831
  2 #578559    |        0         0         1        59 |        2         1        50     55760 |        3         2        54     55770
  3 #578318    |        0         0         0        76 |        2         1        49     55751 |        3         2        54     55760
  4 #578611    |        0         0         0        64 |        2         1        49     55811 |        3         2        53     55820
  5 #578347    |        0         0         1        40 |        2         1        50     56121 |        3         2        55     56133
  6 #578938    |        0         0         1        75 |        2         1        49     55755 |        3         2        53     55764
  7 #578631    |        0         0         1        36 |        3         1        51     55528 |        4         2        55     55541
  --------------------- >% ------------------------

The problem with DL server only implementation is that FIFO tasks might
suffer preemption from NORMAL even when spare CPU cycles are available.
In fact, fair deadline server is enqueued right away when NORMAL tasks
wake up and they are first scheduled by the server, thus potentially
preempting a well behaving FIFO task. This is of course not ideal.

We had discussions about it, and one of the possibilities would be
using a different scheduling algorithm for this. But IMHO that is
an overkill.

Juri and I discussed this and though about delaying the server
activation for the (period - runtime), thus enabling the server
only if the fair scheduler is about to starve. We called it
the defer server.

The defer the server start to the (absolute deadline - runtime)
point in time. This is achieved by starting the dl server throttled,
with a next replenishing time set to activate the server at
(absolute deadline - runtime).

The server is enqueued with the runtime replenished. As the fair
scheduler runs without boost, its runtime is consumed. If the
fair server has its runtime before the runtime - deadline time,
the a new period is set, and the timer armed for the new
deadline.

The interface is per CPU and has two knobs:
	fair_server_runtime (950 ms)
	fair_server_period  (1s)

With defer enabled on CPUs [0:3], the results get better, having a
behavior similar to the one we have with the rt throttling.

  --------------------- %< ------------------------
                                     Timer Latency                                                                                       
  0 00:10:01   |          IRQ Timer Latency (us)        |         Thread Timer Latency (us)      |    Ret user Timer Latency (us)
CPU COUNT      |      cur       min       avg       max |      cur       min       avg       max |      cur       min       avg       max
  0 #599979    |        0         0         0        64 |        4         1         4        67 |        6         1         5        69
  1 #599979    |        0         0         1        17 |        6         1         5        50 |       10         2         7        71
  2 #599984    |        1         0         1        22 |        4         1         5        78 |        5         2         7       107
  3 #599986    |        0         0         1        72 |        7         1         5        79 |       10         2         7        82
  4 #581580    |        1         0         1        37 |        6         1        38     52797 |       10         2        41     52805
  5 #583270    |        1         0         1        41 |        9         1        36     52617 |       12         2        38     52623
  6 #581240    |        0         0         1        25 |        7         1        39     52870 |       11         2        41     52876
  7 #581208    |        0         0         1        69 |        6         1        39     52917 |        9         2        41     52923
  --------------------- >% ------------------------

Here are some osnoise measurement, with osnoise threads running as FIFO:1 with
different setups (defer enabled):
 - CPU 2 isolated
 - CPU 3 isolated shared with a CFS busy loop task
 - CPU 8 non-isolated
 - CPU 9 non-isolated shared with a CFS busy loop task

  --------------------- %< ------------------------
 ~# pgrep ktimer | while read pid; do chrt -p -f 2 $pid; done # for RT kernel
 ~# tuna  isolate -c 2
 ~# tuna  isolate -c 3
 ~# taskset -c 3 ./f &
 ~# taskset -c 9 ./f &
 ~# osnoise -P f:1 -c 2,3,8,9 -T 1 -d 10m -H 1
                                          Operating System Noise
duration:   0 00:10:00 | time is in us
CPU Period       Runtime        Noise  % CPU Aval   Max Noise   Max Single          HW          NMI          IRQ      Softirq       Thread
  2 #599       599000000          178    99.99997          18            2           0            0          270            0            0
  3 #598       598054434     31351553    94.75774      104442       104442           0            0      2837523            0         1794
  8 #599       599000001       567456    99.90526        3260         2375           2           89       620490            0        13539
  9 #598       598021196     31742537    94.69207       71707        53357           0           90      3411023            0         1762
   --------------------- >% ------------------------

the system runs fine!
	- no crashes (famous last words)
	- FIFO property is kept
	- per cpu interface because it is more flexible - and to detach this from
	  the throttling concept.
	In addition:
	 - This version is on my korg repo for three weeks without any
	   0 robot compaining.
	 - no regressions found on basic cfs tests, like kernel compilation.
	 - also tested with PREEMPT_RT 6.9-rt.

Global breaks only if the fair server activates (which is fair as RT
tasks are not behaving anyways).

The selftest mentioned in the sched/core patches is here:
	https://lore.kernel.org/all/20240313012451.1693807-8-joel@joelfernandes.org/

Thanks people at google for testing/suggesting:
 - Suleiman Souhlal <suleiman@google.com>
 - Youssef Esmat <youssefesmat@google.com>
 - Joel Fernandes (Google) <joel@joelfernandes.org>
 - Vineeth Pillai <vineeth@bitbyteword.org>

Changes from v6:
  - Rebased on top of v6.10-rc1
  - Improved comments (Daniel)
  - Fix division by 0 on adding bw to the rq (Daniel)
  - Use guard and scoped_guard (Peter)
  - Remove the defer knob (Peter)
  - Adjusted comments and code styling (Peter)
  - Be aware of cfs throttling (Vineeth)
  - Split the fixes and the feature from the basic fair server (Peter)
Changes from V5:
  - Fixes DL server for core scheduling (patches 3 and 4)
  (Joel/Vineeth/Suleiman)
  - Add a function to attach the fair server bandwidth to the
    new root domain when the rq changes root domain (Daniel)
  - Postpone the replenishment timer of the server if the defer reservation
    could consume runtime while waiting to boost (patch 2) (Daniel)
  - Add the running state to defer mode avoid forcing the defer mechanism
    if the server continues to be activated due to starvation (patch 2)
    (Daniel)
  - Consider idle time as time for the defer server to avoid penalty on RT
    tasks (patch 2) (Daniel)
  - Mark DL server as unthrottled before enqueue (patch 2)(Joel)
  - Make start_dl_timer callers more robust (patch 2) (Joel)
  - Do not restart the DL server on replenish from timer (patch 2)(Joel)
  - Fix Reverse args to dl_time_before in replenish (patch 2) (Suleiman Souhlal)
  - Removed the negative runtime optimization (patch 2)
  - Start the dl server as disabled in patch 1, enabling it only after
    removing the RT throttling, to avoid having two mechanism together
    by default (patch 1) (Daniel).
  - Added a check need resched after dl_server_start (patch 1) (Daniel)
  - reset dl_server pointer at put_prev_task_balance (patch 1) (Joel)
  - Do not include the already merged patches
  - Rebased to 6.9-rc2
Changes from V4:
  - Enable the server when nr fair tasks is > 0 (peter)
  - Consume runtime if the zerolax server is not boosted (peterz)
  - Adjust interface to deal with admission control (peterz)
  - Rebased to 6.6
Changes from V3:
  - Add the defer server (Daniel)
  - Add an per rq interface (Daniel with peter's feedback)
  - Add an option not defer the server
  - Typos and 1-liner fixes (Valentin, Luca, Peter)
  - Fair scheduler running on dl server do not account as RT task (Daniel)
  - Changed the condition to enable the server (RT & fair tasks) (Daniel)
Changes from v2:
  - Refactor/rephrase/typos changes
  - Defferable server using throttling
  - The server starts when RT && Fair tasks are enqueued
  - Interface with runtime/period/defer option
Changes from v1:
  - rebased on 6.4-rc1 tip/sched/core

Daniel Bristot de Oliveira (3):
  sched/deadline: Comment sched_dl_entity::dl_server variable
  sched/deadline: Deferrable dl server
  sched/fair: Fair server interface

Joel Fernandes (Google) (3):
  sched/core: Add clearing of ->dl_server in put_prev_task_balance()
  sched/core: Fix priority checking for DL server picks
  sched/core: Fix picking of tasks for core scheduling with DL server

Peter Zijlstra (2):
  sched/fair: Add trivial fair server
  sched/rt: Remove default bandwidth control

Youssef Esmat (1):
  sched/core: Clear prev->dl_server in CFS pick fast path

 include/linux/sched.h   |  17 +-
 kernel/sched/core.c     |  56 +++--
 kernel/sched/deadline.c | 449 ++++++++++++++++++++++++++++++++++------
 kernel/sched/debug.c    | 162 +++++++++++++++
 kernel/sched/fair.c     |  75 ++++++-
 kernel/sched/idle.c     |   2 +
 kernel/sched/rt.c       | 242 ++++++++++------------
 kernel/sched/sched.h    |  17 +-
 kernel/sched/topology.c |   8 +
 9 files changed, 813 insertions(+), 215 deletions(-)

-- 
2.45.1


