Return-Path: <linux-kernel+bounces-251761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51105930976
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 11:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BBD4B211FF
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 09:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6604644361;
	Sun, 14 Jul 2024 09:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="lU5B9bvR"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC0DB65A
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 09:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720949507; cv=none; b=Nnu9cUz4E7Y59VDNVrZ1SKNWavbt0dxvX4US24vUeDhBdHWSuYz5w8uVvcXq+9lh4jE10/05mzE3FCQTQlwZRn+C7Zvij9tZkFLtjlwQFWwl47tmWrlXn2q7hKx70fyIZO2dW9YxW8EAMgqIZl+Lc+TCAGAiMePh+3A8lyKMsZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720949507; c=relaxed/simple;
	bh=u2L2bFVF/bUkL0Afb/7SR7DQPMUm+H8EcrPeB1KlHAA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=s8dMBrcOIY5xdTfZDnKRFD4ZlaHHkPUxU/j6VxsGlAEK8nsEgC/5rqAkEbHY640zfFw4VQhYYNRGD9A5rnrF9GqDyjloC6db72V+7ipwcVxfuaCyr52l/cJEz6q0jm2S72vUgQljSvLj5qvf+K2BSUAImkfXYkokAHyRiWLHZZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=lU5B9bvR; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3AF9340E021F;
	Sun, 14 Jul 2024 09:31:43 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id hi5oRY8mcAU9; Sun, 14 Jul 2024 09:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1720949500; bh=gmcR1+NELxNM8wxl3bcfi9ydjX+ZK57VZicNoi27lew=;
	h=Date:From:To:Cc:Subject:From;
	b=lU5B9bvR5NI/EO+MieT9ZNv5HwZPfdsYMcGfB9PjRBANn+42e3FibXx0cXQY7/kXF
	 iXF54jO0Qxf4bKyQ0pnoJLQWu/RXndDyxISgTYJHUBTo+WwDcVKtSWe151266T9aCw
	 e1rVUNFZGw/vm0CInbgx9Qz+lfTzZyIKmtiS5bWZyN420Fn9lbePN9V5N9Zu3SSNcn
	 yKDPLnZknToDZI8T+aD2MyZ/6U5vOzIcfJVtoL2NUkqaokNzzR6HIm5UOxIFA3DZJW
	 oWSA2aXrnjfVrKiVVjPaNZRCJ4cXTGWD0vFIhHh42ATj4mbbR80xpy0u38JiBUM35M
	 fTQIowqkPCJzSpmRpo2iW3iFv4i+wdA30Ra2LJcfhY7/9/Hre8Si2IO7P9wqp489EB
	 wLw2WhiStw0INUHX30vxuPTCvwyfCTA/Nj3olQn/9lJ7BB2H5UE/BS4BjgmZT/7Xkk
	 cSxNmI8KfE4BiFux4Ie6bdzWOi0aZ52FDPVDNpZRb01MjNDZ/AKNFCp4bmwbXVFbNZ
	 l+GiyRHSGJJhO4QGosy6Ai+nVhha7g8m1T3zTw2VwVdIk2GNMxwMoM5aJAaCG2J00o
	 R1qrTdAdE6GP6NKZVlpZpspDiNCbHq2/ZhMc8CWW820KYTLVYCypmvafIcwbfL9JpC
	 xFEU+Dn+pDpKfs1w2QQ4IG6o=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 17C8440E0027;
	Sun, 14 Jul 2024 09:31:37 +0000 (UTC)
Date: Sun, 14 Jul 2024 11:31:30 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sched/urgent for v6.10
Message-ID: <20240714093130.GAZpOa8kG3Aq6nfwQi@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the last three sched urgent fixes for v6.10.

Thx.

---

The following changes since commit f2661062f16b2de5d7b6a5c42a9a5c96326b8454:

  Linux 6.10-rc5 (2024-06-23 17:08:54 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/sched_urgent_for_v6.10

for you to fetch changes up to ddae0ca2a8fe12d0e24ab10ba759c3fbd755ada8:

  sched: Move psi_account_irqtime() out of update_rq_clock_task() hotpath (2024-07-01 13:01:44 +0200)

----------------------------------------------------------------
- Fix a performance regression when measuring the CPU time of a thread
  (clock_gettime(CLOCK_THREAD_CPUTIME_ID,...)) due to the addition of
  PSI IRQ time accounting in the hotpath

- Fix a task_struct leak due to missing to decrement the refcount when
  the task is enqueued before the timer which is supposed to do that,
  expires

- Revert an attempt to expedite detaching of movable tasks, as finding
  those could become very costly. Turns out the original issue wasn't
  even hit by anyone

----------------------------------------------------------------
John Stultz (1):
      sched: Move psi_account_irqtime() out of update_rq_clock_task() hotpath

Josh Don (1):
      Revert "sched/fair: Make sure to try to detach at least one movable task"

Wander Lairson Costa (1):
      sched/deadline: Fix task_struct reference leak

 kernel/sched/core.c     |  7 +++++--
 kernel/sched/deadline.c |  7 ++++++-
 kernel/sched/fair.c     | 12 +++---------
 kernel/sched/psi.c      | 21 ++++++++++++++++-----
 kernel/sched/sched.h    |  1 +
 kernel/sched/stats.h    | 11 ++++++++---
 6 files changed, 39 insertions(+), 20 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

