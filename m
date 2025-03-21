Return-Path: <linux-kernel+bounces-571078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B51A6B8D1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 11:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DFE01892ECB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 10:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1939215078;
	Fri, 21 Mar 2025 10:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFKjrIGB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241EF212FB3
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 10:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742553314; cv=none; b=Cznh+0Xl1ZY3flsgoG+Njos07pRuu1bUnZtlZnIJszFnE/Fvuzv23+ZOMMpLefJmJLwsrjAbZB2zAwhORsMFdoWtcg0wru2pwUrhRD2b7Kg9nqxh+Ta4rJKv7Pl/dDRk6XTYnpBA5z15/2QUvLjsOOQ72gMzMt9boHIlx07Yrfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742553314; c=relaxed/simple;
	bh=o2LAxUcdAJQypI7wFLXVqIJxOg3Jp/yzOs2b57HK+uM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TbjLC+Q5bUtA/4PXuHn27rmuDZ9zWDXO16YUf+lQy1jKERbWoQtTB4zey3Ev/lkgK/Zxd1aRurYX5LEgKTWpR1K1yDVbgBK+sTLmv4Tv+ZsImjNuOLI3Tyks3CpTFcnWVzijxAW73aWuN+Q1z31Kgctd6ThDGj8+pDvrYYhMsWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFKjrIGB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC68C4CEE3;
	Fri, 21 Mar 2025 10:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742553313;
	bh=o2LAxUcdAJQypI7wFLXVqIJxOg3Jp/yzOs2b57HK+uM=;
	h=Date:From:To:Cc:Subject:From;
	b=TFKjrIGBezc8pjoVgepQt8QpVzoyEBhO9vnjcTl2FmtJfCUttDkxxdjXOiMapuvDr
	 sEGLmnIBhG3KqEo9OLoG7kBeOHhKhxbIMpsSUchlr4/zhSx+PP4HDLXAlr5JPxclA2
	 iYejxxjgKAT6QAC6zlWJCZiUMVoqpiUpVEUEoMd6C4rtLdGkpBEzgcVd/icE4Ons4x
	 EKYKfe2ABaCv5HdPmHXh/GrP/7KDjW3rSDfhYiPFuuS/Ss/bhyt4HV+MPSA1cxctH4
	 k2QfIxp5LoRfX90Gu/bHig/SYR2XqX3ltbqWoR4JltONXjvKvYmWbJoG1mWek9964h
	 bIQzmozYBctnA==
Date: Fri, 21 Mar 2025 11:35:07 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [GIT PULL] scheduler fix
Message-ID: <Z91A2-z01UOBKTN9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest sched/urgent Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2025-03-21

   # HEAD: 76f970ce51c80f625eb6ddbb24e9cb51b977b598 Revert "sched/core: Reduce cost of sched_move_task when config autogroup"

Revert a scheduler performance optimization that regressed other workloads.

[ Merge note: this is admittedly a bit late in the cycle, and the 
  regression is old, but the performance impact is substantial for the 
  affected workloads so I didn't want to delay this fix. ]

 Thanks,

	Ingo

------------------>
Dietmar Eggemann (1):
      Revert "sched/core: Reduce cost of sched_move_task when config autogroup"


 kernel/sched/core.c | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

