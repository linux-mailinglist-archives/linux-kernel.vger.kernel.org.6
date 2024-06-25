Return-Path: <linux-kernel+bounces-228988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7487B916977
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A69EB1C2100F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 13:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFF81607A7;
	Tue, 25 Jun 2024 13:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nhR1tCYL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EE317C98
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 13:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719323569; cv=none; b=clMA8wSIVnnEKdymclPbsvUDMWYHbGfVbU659WZgTHAeSZD5p1d/T+5uaWHZOpR9a2FPCxBkedFXT7tw3ty7ZpCtLmKILgrJV5mXtPFyew6vXvBT1lfoUeyd/G50wmrNEl4ITzKhCfNpmk3D5uWlhJAdKLz+yhGIFef1oX0nMoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719323569; c=relaxed/simple;
	bh=BC4qK3DsBmqdIUaOmuZX01WAZfNyPQ9l9M1VKKaYk7M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iPmZpk/EMcVplpiQkzP3T0QuTiankYml3oD7isU+F6w7DADgxXeJuCA4c2jzcvrcqmmTJc2FOOrdwDvTprxdoesoBqeuyjzPl4loxsd1sYrzIao0TSe0O/DwXDXU5qSMDbqGurXC3Xgg8P/OzIfhLp45aPv0f9XyM4pUxR0HeX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nhR1tCYL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17EA8C32781;
	Tue, 25 Jun 2024 13:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719323569;
	bh=BC4qK3DsBmqdIUaOmuZX01WAZfNyPQ9l9M1VKKaYk7M=;
	h=From:To:Cc:Subject:Date:From;
	b=nhR1tCYLP6IVEu/BMnZ1CVjBZpweG+jQrNpUg+0BYCZ84XiysMrLdrR4BBq/E9UCe
	 xw3xSrJOmIIKy8MmmOdARRRGTiYICa8h+Sr17PfL3ogV90gN2jaz6HgRCXdHFJi+L6
	 e04L+izmRVDF1ldx68cbLLxvTG5B47kdWIww8JtX1SUxURRjEY5E6YrY5pN63/v5C+
	 Pd9YQk5V9y0BZ7Q3raWzr5kLbpsy0abwDUcyae+ka5UkF3RzwB+WWa5h6JJ/IYhUOi
	 UOFCocAdEeUnOyERJnxfvsQFmgf+1UjuM73NjSsMvBaB2M/aDw00vfc+aTX8LuFZuz
	 RLIUcseCBBlaA==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Oleg Nesterov <oleg@redhat.com>
Subject: [RFC PATCH 0/6] mm: LRU drain flush on nohz_full
Date: Tue, 25 Jun 2024 15:52:38 +0200
Message-ID: <20240625135244.20227-1-frederic@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When LRUs are pending, the drain can be triggered remotely, whether the
remote CPU is running in userspace in nohz_full mode or not. This kind
of noise is expected to be caused by preparatory work before a task
runs isolated in userspace. This patchset is a proposal to flush that
before the task starts its critical work in userspace.

Frederic Weisbecker (6):
  task_work: Provide means to check if a work is queued
  sched/fair: Use task_work_queued() on numa_work
  sched: Use task_work_queued() on cid_work
  tick/nohz: Move nohz_full related fields out of hot task struct's
    places
  sched/isolation: Introduce isolated task work
  mm: Drain LRUs upon resume to userspace on nohz_full CPUs

 include/linux/sched.h           | 15 +++++++++------
 include/linux/sched/isolation.h | 17 +++++++++++++++++
 include/linux/swap.h            |  1 +
 include/linux/task_work.h       | 12 ++++++++++++
 kernel/sched/core.c             |  6 ++----
 kernel/sched/fair.c             |  4 +---
 kernel/sched/isolation.c        | 32 ++++++++++++++++++++++++++++++++
 kernel/sched/sched.h            |  1 +
 kernel/task_work.c              |  1 +
 mm/swap.c                       |  5 ++++-
 10 files changed, 80 insertions(+), 14 deletions(-)

-- 
2.45.2


