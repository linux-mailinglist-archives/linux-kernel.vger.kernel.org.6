Return-Path: <linux-kernel+bounces-539258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 645AAA4A289
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C92CB1899EEC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE33277030;
	Fri, 28 Feb 2025 19:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rqcx2yEO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97DA1B87FB
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 19:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740770233; cv=none; b=A525c3hT0Q2q1At7zCq8t9RJunlO/387lFYQZLSaR3Vpd7s+L9iAcoe8wBML30P7wrUx4jrrSgxNfeLuu5BGOka23ccR6ib+CeV0owwJJ3/7tzqLjwYmjZ7I0z2HXpOXShtgnRKu/m+d+XGQqHQX2Pv9V3RmL7vXIXYJIKnR1L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740770233; c=relaxed/simple;
	bh=GSLa+/ofIygcHiomx3NmL3qV6YrsCvX1jBYbk/gqezc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kyAn3uIpeb9f7jPelKi6KHIJ7rih4g96qeU6ow8tq7lSkCAWgoMUHvz0FrddDPsT1l9AL74J9RqIlmV5uSETQZKhmk6f/fX6e8H09LiHRxq2VHGsS+RXXLLnyYvK9Gu0UgNjuphmwoPcw0rqeg9jWS6OMFwop0vktEujxn34DAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rqcx2yEO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0443C4CED6;
	Fri, 28 Feb 2025 19:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740770232;
	bh=GSLa+/ofIygcHiomx3NmL3qV6YrsCvX1jBYbk/gqezc=;
	h=Date:From:To:Cc:Subject:From;
	b=rqcx2yEOalfeikAsIpTdq2SbLuMB9ZOLn9iWM4+0Fd+oWvoeKYZwhtTfLI/8mqp6G
	 GVa/QXVZLnMH8hQTkSlozItecITWRE1brJPYLZyJesIZKWMr/BgcyQhOqxEJKQrQ2J
	 7/dsr7U5NN/PSXZxVlandugg0NFCWpwnt7lvHqqIDikcU2r8kPPn4LtwqoEQq8GfnR
	 rMSj1URc29gaWIkvQ63GN5uZ4te8VIPxsJGxhUaldtCqCgD+qAJ67JLqCjptm7yxs3
	 KciEi7lAMGtMzk1nWhzp7T/g0gW3b9AzhLAQu9YATXeRqy8r4SqCzS3wAIGMEywTVY
	 Vb5QGMszXfBNQ==
Date: Fri, 28 Feb 2025 20:17:03 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [GIT PULL] perf events fixes
Message-ID: <Z8ILr7mcMg6x46nA@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest perf/urgent Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2025-02-28

   # HEAD: f8c857238a392f21d5726d07966f6061007c8d4f uprobes: Remove too strict lockdep_assert() condition in hprobe_expire()

Miscellaneous perf events fixes and a minor HW enablement change:

 - Fix missing RCU protection in perf_iterate_ctx()

 - Fix pmu_ctx_list ordering bug

 - Reject the zero page in uprobes

 - Fix a family of bugs related to low frequency sampling

 - Add Intel Arrow Lake U CPUs to the generic Arrow Lake
   RAPL support table

 - Fix a lockdep-assert false positive in uretprobes

 Thanks,

	Ingo

------------------>
Aaron Ma (1):
      perf/x86/rapl: Add support for Intel Arrow Lake U

Andrii Nakryiko (1):
      uprobes: Remove too strict lockdep_assert() condition in hprobe_expire()

Breno Leitao (1):
      perf/core: Add RCU read lock protection to perf_iterate_ctx()

Kan Liang (3):
      perf/x86: Fix low freqency setting issue
      perf/core: Fix low freq setting via IOC_PERIOD
      perf/x86/intel: Use better start period for frequency mode

Luo Gengkun (1):
      perf/core: Order the PMU list to fix warning about unordered pmu_ctx_list

Tong Tiangen (1):
      uprobes: Reject the shared zeropage in uprobe_write_opcode()


 arch/x86/events/core.c       |  2 +-
 arch/x86/events/intel/core.c | 85 ++++++++++++++++++++++++++++++++++++++++++++
 arch/x86/events/rapl.c       |  1 +
 kernel/events/core.c         | 31 ++++++++++------
 kernel/events/uprobes.c      | 15 ++++++--
 5 files changed, 119 insertions(+), 15 deletions(-)

