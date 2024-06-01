Return-Path: <linux-kernel+bounces-197873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D44218D703C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 15:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FA0728251E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 13:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54EC71514F2;
	Sat,  1 Jun 2024 13:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OuU2BLIO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A464824AF
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 13:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717248934; cv=none; b=N6ugH2es97pieBb9/ZKlx0drRrl61oY1ksE7WTHeUhz9lGWk7Ito7kMOFwSwXwAH801gQiapMazJe/CqSsRvF1XbT8Bx2mSp/VoM3oIM56AgZZLnAZIkWv27aM0Jfl3ZEgkPd6CDLIe3vjDNn+8t1oGjgETFijO6EveWoAzEEvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717248934; c=relaxed/simple;
	bh=JiTSl7JBicjiXWGa8n+n3pZllni9FozR6cvrsMHpZOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FiMX921JKOWtnPciOtygW9ghHAantAMEB0KOnuuj0kE/WUmyrLSk3quJ6vI4LAt8zQ9jSAbzkpEWydiU4Lhg5l2eOuCO5tpYXE8eBUU9CNht1DWuq3lB0LC24dV5zWO+G/imEa3lfAt3dOdVXTL/U1R63oCpNf9qE/7EavWCJHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OuU2BLIO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F5BC116B1;
	Sat,  1 Jun 2024 13:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717248934;
	bh=JiTSl7JBicjiXWGa8n+n3pZllni9FozR6cvrsMHpZOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OuU2BLIOKPUdisGm/qv7+yh2X+cSqGwyYHqFqWTNY0wvIu4lFM1KPZkchK9GBHqSE
	 qeizHQZTz+uBao790qeRX1OIVgZnOZRakm7N+kjec1IvWFFKsGiY0/5sXUogIDurgU
	 3Y6IefIV6PnE+a8IJljRWCn0wuFIS5EjTxHYwkU8CNHRADzudWNLSjhbLZwk6+9RSr
	 5JdOzWXvLW9TiEL55EvnGqR6LL7KQxvY82ykphSoiCrwTSux9PezeaYNPmRoP7BbHf
	 LrZfcnh//TYL2vWwxxbcZ4lJfXJEPAtiXoS6jz6HCdTGWMXKOn7om7SxwkQ8VWd1yK
	 wPkgx2b53nMZQ==
Date: Sat, 1 Jun 2024 15:35:28 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 0/4 v3] perf: Fix leaked sigtrap events
Message-ID: <ZlsjoMycgmZ5hmIG@localhost.localdomain>
References: <20240516140936.13694-1-frederic@kernel.org>
 <Zln59lKDPwuBT1GZ@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zln59lKDPwuBT1GZ@x1>

Le Fri, May 31, 2024 at 01:25:26PM -0300, Arnaldo Carvalho de Melo a écrit :
> With Frederic's patchset:
> 
> [acme@nine linux]$ b4 am -ctsl --cc-trailers 20240516140936.13694-1-frederic@kernel.org
> Grabbing thread from lore.kernel.org/all/20240516140936.13694-1-frederic@kernel.org/t.mbox.gz
> Checking for newer revisions
> Grabbing search results from lore.kernel.org
> Analyzing 5 messages in the thread
> Looking for additional code-review trailers on lore.kernel.org
> <SNIP>
> Total patches: 4
> ---
> Cover: ./v3_20240516_frederic_perf_fix_leaked_sigtrap_events.cover
>  Link: https://lore.kernel.org/r/20240516140936.13694-1-frederic@kernel.org
>  Base: not specified
>        git am ./v3_20240516_frederic_perf_fix_leaked_sigtrap_events.mbx
> [acme@nine linux]$        git am ./v3_20240516_frederic_perf_fix_leaked_sigtrap_events.mbx
> Applying: task_work: s/task_work_cancel()/task_work_cancel_func()/
> Applying: task_work: Introduce task_work_cancel() again
> Applying: perf: Fix event leak upon exit
> Applying: perf: Fix event leak upon exec and file release
> [acme@nine linux]$
> 
> [acme@nine linux]$ git log --oneline -9
> 1f88fa6e3adb (HEAD -> linux-rt-devel-6.10.y-rt-sigtrap-fix-frederic-v3) perf: Fix event leak upon exec and file release
> 44cde14a096c perf: Fix event leak upon exit
> 512f8f5cbaed task_work: Introduce task_work_cancel() again
> e7bee294ec69 task_work: s/task_work_cancel()/task_work_cancel_func()/
> 4de7b8e17201 Revert "perf: Move irq_work_queue() where the event is prepared."
> 5efa195af234 Revert "perf: Enqueue SIGTRAP always via task_work."
> 26ac4dfa180a Revert "perf: Remove perf_swevent_get_recursion_context() from perf_pending_task()."
> c2fb5208a68e Revert "perf: Split __perf_pending_irq() out of perf_pending_irq()"
> 6d20efa57a89 (tag: v6.10-rc1-rt1-rebase, tag: v6.10-rc1-rt1, linux-rt-devel/linux-6.10.y-rt-rebase, linux-rt-devel/linux-6.10.y-rt, linux-rt-devel/for-kbuild-bot/prepare-release, linux-rt-devel/for-kbuild-bot/current-stable) Add localversion for -RT release
> [acme@nine linux]$
> 
> The workload that is used to do that, as a reminder, is 'perf test sigtrap'.
> 
> [  121.217475] BUG: scheduling while atomic: perf/7955/0x00000002
> [  121.217478] BUG: scheduling while atomic: perf/7956/0x00000002
> <SNIP list of modules>
> [  121.217492] BUG: scheduling while atomic: perf/7954/0x00000002
> <SNIP list of modules>
> [  121.217570] Preemption disabled at:
> <SNIP>
> [  121.217571] [<0000000000000000>] 0x0
> <SNIP>
> [  121.217609] Preemption disabled at:
> <SNIP>
> [  121.217610] [<0000000000000000>] 0x0

Right because my patchset doesn't fix the pre-existing RT issue where
perf_sigtrap takes a sleeping lock while preemption is disabled. Sebastian
will need to rebase on top of this patchset and then also convert the perf
recursion context to be per task on RT to avoid preemption disablement.

Thanks.

