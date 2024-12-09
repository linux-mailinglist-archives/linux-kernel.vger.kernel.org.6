Return-Path: <linux-kernel+bounces-437097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C9B9E8F1E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7EF7282A69
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B3A216380;
	Mon,  9 Dec 2024 09:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="k97tDR5l"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8EA83CD2
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 09:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733737727; cv=none; b=UNs0U5RDGT65vqlHJXFZp01Na/66Fh5Xleq4ZpGeLCR0zMKbGI7WAZ+jIlWRYko+AQuP1C0tk4xWgWRaDA/Z+xbRvBk12lowCyHY8wJF+024RU2bXZxKdE1zhfnadDJ+iUOBh7xqaKIrZQ6Tau5ge/0gruVWASRT8WRA8RdtcjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733737727; c=relaxed/simple;
	bh=AsygOVspIhtyqvDx8QABCIR75hbMEQ6gwYW/xra7QZs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SKmK0yQLTAC1b75vdSLf64qegAh3HkdV76SQFBxck7+abWRpYV1REBQksEg32iwt4fMPruYC59OmlCUA4f0iqVaVEQXqhNIWkHRdX4No1dj+JVb87GY1H3f1VtJ2KgFIiZTWDJOwLIOt0NeccMWnP276dj9oOaAvV686Xq9NPv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=k97tDR5l; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 343AE40E015F;
	Mon,  9 Dec 2024 09:48:35 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id WHty9okuicmi; Mon,  9 Dec 2024 09:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1733737712; bh=T3PRiGfHB5A1yLUSHbG4DsQfPwKRoCT6uNTpwcPjaLM=;
	h=Date:From:To:Cc:Subject:From;
	b=k97tDR5lHvBJEXQRIm2eZqSCrUGDezcGQoiFClZkr/gOwU+9ix/uHtOvncolQjLQs
	 Urkra3yMt5oCGpINYxa7FXYhJEBYOeWrpzSaDDruDhMaFYguc7+0BpXIufnLx5vya7
	 ANEA3qoaR/uAiRJas3Ax5tYbePt8pRZS4LhqPhZ6h0+CSbcWzC91RAvPuuRnkiegzx
	 U3nNc8P/+lYzu8f5BsDP8kU/2EQz84cqoMpLJsbVaHuTMDj68AZpqqwmi6g/wLRz5v
	 dAcpwS0tx6/qM3vwkKVV89Zd9V8D7evT5I+234BC1MdGPSGeoRS+yfQoydPSxU4oAl
	 2d6HGgJOCgwmAFTkTGDM/3h5n4tcjhVDzFWIb+6Q8k286DpqvLnB5ICYhz8o5pzFOc
	 FmqAze3KN/gXpQrRunaGK9+n9BeN/BQlx0LCFjfXgjiTF6FYj5ZaFrn3nQ40hnB9NZ
	 eP0ZhR6TWVS7nv0o8iT47p68rOY7AGxYPlNp3edJBfKA+ZuHmq5xvhvEU62G4HxzQ0
	 kKPw0pSD7p9gYSCUCtNQyU6Sh0eiFkfSj/MtmXUFrFtUpwisxHro8dz8IwmcDvTxZH
	 v3+h9MTzKuFNWR+TrSriV8/LUMcEgkTs6MvSipIRWZ674jmlKDOCacq+ZYVLTrOQaO
	 VSSr+owG8tz4S0kMhObAHtMA=
Received: from zn.tnic (p200300eA971F9346329c23fffEa6A903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:9346:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E271440E015E;
	Mon,  9 Dec 2024 09:48:28 +0000 (UTC)
Date: Mon, 9 Dec 2024 10:48:22 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sched/urgent for v6.13-rc3
Message-ID: <20241209094822.GAZ1a85tp2J_T7_Ctd@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the sched/urgent lineup for v6.13-rc3.

Thx.

---

The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/sched_urgent_for_v6.13_rc3

for you to fetch changes up to 82f9cc094975240885c93effbca7f4603f5de1bf:

  locking: rtmutex: Fix wake_q logic in task_blocks_on_rt_mutex (2024-12-02 12:01:29 +0100)

----------------------------------------------------------------
- Remove wrong enqueueing of a task for a later wakeup when a task blocks on
  a RT mutex

- Do not setup a new deadline entity on a boosted task as that has happened
  already

- Update preempt= kernel command line param

- Prevent needless softirqd wakeups in the idle task's context

- Detect the case where the idle load balancer CPU becomes busy and avoid
  unnecessary load balancing invocation

- Remove an unnecessary load balancing need_resched() call in nohz_csd_func()

- Allow for raising of SCHED_SOFTIRQ softirq type on RT but retain the warning
  to catch any other cases

- Remove a wrong warning when a cpuset update makes the task affinity no
  longer a subset of the cpuset

----------------------------------------------------------------
John Stultz (1):
      locking: rtmutex: Fix wake_q logic in task_blocks_on_rt_mutex

Josh Don (1):
      sched: fix warning in sched_setaffinity

Juri Lelli (1):
      sched/deadline: Fix replenish_dl_new_period dl_server condition

K Prateek Nayak (4):
      softirq: Allow raising SCHED_SOFTIRQ from SMP-call-function on RT kernel
      sched/core: Remove the unnecessary need_resched() check in nohz_csd_func()
      sched/fair: Check idle_cpu() before need_resched() to detect ilb CPU turning busy
      sched/core: Prevent wakeup of ksoftirqd during idle load balance

Sebastian Andrzej Siewior (1):
      sched/core: Update kernel boot parameters for LAZY preempt.

Wander Lairson Costa (1):
      sched/deadline: Fix warning in migrate_enable for boosted tasks

 Documentation/admin-guide/kernel-parameters.txt |  5 +++++
 kernel/locking/rtmutex.c                        |  3 ---
 kernel/sched/core.c                             |  4 ++--
 kernel/sched/deadline.c                         |  3 ++-
 kernel/sched/fair.c                             |  2 +-
 kernel/sched/syscalls.c                         |  2 +-
 kernel/softirq.c                                | 15 +++++++++++----
 7 files changed, 22 insertions(+), 12 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

