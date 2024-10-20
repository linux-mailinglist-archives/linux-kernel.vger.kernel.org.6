Return-Path: <linux-kernel+bounces-373190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF329A538C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 12:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BEFAB243F7
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 10:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0CB13635F;
	Sun, 20 Oct 2024 10:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="FboQTjrC"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493756AA7
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 10:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729421418; cv=none; b=U1XrceidFVfShk5gTQ87BRQiGS5cBie8VildFXp+o6quAE/XWW44E1Tvu++ojJZuyMuGITxxYjRfAcM3iFLYFlIvd+hv6PByuGyf811tWbYhb1ursWEVDdzlWrSxyLbvcqe2BEfZZwZxcTqRdJH21dEEbQ8VmmD5JeVoqLZPJwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729421418; c=relaxed/simple;
	bh=/vkAoORVzQWQ7sKSmBmAtwXU8uwoz6O0GcwsNu+qXxA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nvv0zZQuuGaHC2GAvPs6XxUrY7Z+OQVB84lMiPm3ha1iZAwigWSstxPClgAneFslcZVFQ4g3Nq/cUWfHcHL3TG5aiR9CanNDQug7YD8JY9JtQZDAAdIDzQe3DWsoga0NDxF9HiDzTcwjqgBS7SyNSdtvu/rggODRjPau7zQe3HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=FboQTjrC; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B905240E0192;
	Sun, 20 Oct 2024 10:50:12 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id HpwJv61zr_Tq; Sun, 20 Oct 2024 10:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729421408; bh=jlSK7zjcvzqzIeOBWhyQmurtrs5+V1+66kqN2y2wVv4=;
	h=Date:From:To:Cc:Subject:From;
	b=FboQTjrCC/EtnaZk1Har2HFDNMAs/2htY/LkXEZxQmzuLnkrP3hQv1j5PmQeqfMDT
	 LQUsmkn9YsLLYO1fbYmCkjvuBtmO+K+Fff0bbXxAFEgi4XWUt55tMydjgxfBUct5UV
	 GJ0ZCcUQsEe8BTjBQCXhpgsB0mUfJO/nfThWiuaRlnhvWVkJ9S2nSYkVzD4GEEI8lm
	 UiOV5gOl+ZAcRmzum1dobsUxbvJylHPKXAT3b550SvhAt5Y4omE6+mLQ+d09DNJ6C+
	 +hOa2tQjBJhE2sB4WmmHWDgAOM3DQwMxfDVXyqZ5L1BcAQOaLdpIZ0onwOCm+E63C1
	 MosGRi2VGw1UB0b8GIGJm3ypjRjDw+LwEeyxB2qJ5+MFMO8ANv1C86+azwo/GkXeA/
	 aQFSYfs9uaw2m3RHPcNlCXiuDVBTa3HStnITUYFejwa6EkK2bsoYq4ePjMPS4UFB3x
	 wctSxHaQ75w4+5VUS5Gxm5fmcuSQUN/Lh/qVXxSmPV0XfjvMTibq18SVY6SJtEHqZl
	 n2fYvfjIYYZh2hTcOW1xwqNrcs3YrMVIjm3LXLxfDJ28TYUcuCNLOOcJcgYEiNhqF6
	 W05P6V9ePs2NBzr3J+sBEQm2bCXMJxab1xzMXpBeUVTywdyM7nC1dPvqFVhbPe9t+q
	 gXPgS9U4T/QF+DPESLGwExKE=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 426B240E0169;
	Sun, 20 Oct 2024 10:50:05 +0000 (UTC)
Date: Sun, 20 Oct 2024 12:49:57 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sched/urgent for v6.12-rc4
Message-ID: <20241020104957.GAZxTgVRnWOwSC1EnE@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the sched/urgent lineup for v6.12-rc4.

Thx.

---

The following changes since commit c964ced7726294d40913f2127c3f185a92cb4a41:

  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma (2024-10-16 13:37:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/sched_urgent_for_v6.12_rc4

for you to fetch changes up to 5ec36fe24bd2d529ba415b9eaed44a689ab543ed:

  MAINTAINERS: Add an entry for PREEMPT_RT. (2024-10-17 21:33:30 +0200)

----------------------------------------------------------------
- Add PREEMPT_RT maintainers

- Fix another aspect of delayed dequeued tasks wrt determining their state,
  i.e., whether they're runnable or blocked

- Handle delayed dequeued tasks and their migration wrt PSI properly

- Fix the situation where a delayed dequeue task gets enqueued into a new
  class, which should not happen

- Fix a case where memory allocation would happen while the runqueue lock is
  held, which is a no-no

- Do not over-schedule when tasks with shorter slices preempt the currently
  running task

- Make sure delayed to deque entities are properly handled before unthrottling

- Other smaller cleanups and improvements

----------------------------------------------------------------
Chen Yu (1):
      sched/eevdf: Fix wakeup-preempt by checking cfs_rq->nr_running

Ingo Molnar (1):
      Merge branch 'linus' into sched/urgent, to resolve conflict

Johannes Weiner (1):
      sched/psi: Fix mistaken CPU pressure indication after corrupted task state bug

Mike Galbraith (1):
      sched: Fix sched_delayed vs cfs_bandwidth

Peter Zijlstra (3):
      sched: Fix delayed_dequeue vs switched_from_fair()
      sched/core: Dequeue PSI signals for blocked tasks that are delayed
      sched/fair: Fix external p->on_rq users

Phil Auld (1):
      sched/deadline: Use hrtick_enabled_dl() before start_hrtick_dl()

Sebastian Andrzej Siewior (1):
      MAINTAINERS: Add an entry for PREEMPT_RT.

Waiman Long (1):
      sched/core: Disable page allocation in task_tick_mm_cid()

 MAINTAINERS                   |  8 ++++++
 include/linux/sched.h         |  5 ++++
 include/linux/task_work.h     |  5 +++-
 kernel/events/core.c          |  2 +-
 kernel/freezer.c              |  7 ++++-
 kernel/rcu/tasks.h            |  9 +++++++
 kernel/sched/core.c           | 61 +++++++++++++++++++++++++++----------------
 kernel/sched/deadline.c       |  2 +-
 kernel/sched/ext.c            |  4 +--
 kernel/sched/fair.c           | 27 +++++--------------
 kernel/sched/sched.h          |  2 +-
 kernel/sched/stats.h          | 48 +++++++++++++++++++++++-----------
 kernel/sched/syscalls.c       | 13 ++++++---
 kernel/task_work.c            | 15 +++++++++--
 kernel/time/tick-sched.c      |  6 +++++
 kernel/trace/trace_selftest.c |  2 +-
 virt/kvm/kvm_main.c           |  2 +-
 17 files changed, 146 insertions(+), 72 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

