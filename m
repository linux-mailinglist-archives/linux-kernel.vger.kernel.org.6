Return-Path: <linux-kernel+bounces-576224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2ACA70C83
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 23:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11A2C188F34A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 22:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE905267B9D;
	Tue, 25 Mar 2025 22:04:45 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68905190664
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 22:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742940285; cv=none; b=rRu1RNpxBVGP1zqGC5sZxKnHeLCP5aESfbdWN0jinI2OEiqGhx3p0wpgGbbOcUKKzeV97MwbR7ptutKh0yzpdlinWe6a70HxyhtZIzJGKj/VwcvK0G+q54AzNaw4FeY4lJTV/TlM9EzxEbSrbwtapIiBb6StT8ingL7qfJDq1S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742940285; c=relaxed/simple;
	bh=MLfg3tCA0imUiAHq1ZnK2Iheihjk6nU8lsCCEgkW230=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=eE9C/RBU2czgj7/Q90yp66aSA2X+iCDELM0i51sSbsl+0SJJE/uWdsVWeJWTdCszs2IZ7MrJuOXjIvUcyQg5zFfm+aKx/IxdUy3lCCWdalfdKsV8G5DJ0pDfJWpdpIiCkAaGLvYX9YausJt3FHdElPZPsAxzivHYykQE8BVGMC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 868D8C4CEE4;
	Tue, 25 Mar 2025 22:04:43 +0000 (UTC)
Date: Tue, 25 Mar 2025 18:05:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mark Rutland <mark.rutland@arm.com>, Masahiro Yamada
 <masahiroy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mark
 Brown <broonie@kernel.org>, "Arnd Bergmann" <arnd@arndb.de>, Nathan
 Chancellor <nathan@kernel.org>
Subject: [GIT PULL] tracing: scripts/sorttable: Updates for v6.15
Message-ID: <20250325180527.5fc0a1fa@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit



Linus,

tracing and sorttable updates for 6.15:

- Implement arm64 build time sorting of the mcount location table

  When gcc is used to build arm64, the mcount_loc section is all zeros in
  the vmlinux elf file. The addresses are stored in the Elf_Rela location.
  To sort at build time, an array is allocated and the addresses are added
  to it via the content of the mcount_loc section as well as he Elf_Rela
  data. After sorting, the information is put back into the Elf_Rela which
  now has the section sorted.

- Make sorting of mcount location table for arm64 work with clang as well

  When clang is used, the mcount_loc section contains the addresses, unlike
  the gcc build. An array is still created and the sorting works for both
  methods.

- Remove weak functions from the mcount_loc section

  Have the sorttable code pass in the data of functions defined via nm -S
  which shows the functions as well as their sizes. Using this information
  the sorttable code can determine if a function in the mcount_loc section
  was weak and overridden. If the function is not found, it is set to be
  zero. On boot, when the mcount_loc section is read and the ftrace table is
  created, if the address in the mcount_loc is not in the kernel core text
  then it is removed and not added to the ftrace_filter_functions (the
  functions that can be attached by ftrace callbacks).

- Update and fix the reporting of how much data is used for ftrace functions

  On boot, a report of how many pages were used by the ftrace table as well
  as how they were grouped (the table holds a list of sections that are
  groups of pages that were able to be allocated). The removing of the weak
  functions required the accounting to be updated.


Please pull the latest trace-sorttable-v6.15 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-sorttable-v6.15

Tag SHA1: 77e26125a028422c57c40da1c29b4bea889a21f2
Head SHA1: dc208c69c033d3caba0509da1ae065d2b5ff165f


Steven Rostedt (10):
      arm64: scripts/sorttable: Implement sorting mcount_loc at boot for arm64
      scripts/sorttable: Have mcount rela sort use direct values
      scripts/sorttable: Always use an array for the mcount_loc sorting
      scripts/sorttable: Zero out weak functions in mcount_loc table
      ftrace: Update the mcount_loc check of skipped entries
      ftrace: Have ftrace pages output reflect freed pages
      ftrace: Test mcount_loc addr before calling ftrace_call_addr()
      ftrace: Check against is_kernel_text() instead of kaslr_offset()
      scripts/sorttable: Use normal sort if theres no relocs in the mcount section
      scripts/sorttable: Allow matches to functions before function entry

----
 arch/arm64/Kconfig      |   1 +
 kernel/trace/ftrace.c   |  55 ++++++-
 scripts/link-vmlinux.sh |   4 +-
 scripts/sorttable.c     | 411 +++++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 457 insertions(+), 14 deletions(-)
---------------------------

