Return-Path: <linux-kernel+bounces-192496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CCF8D1E04
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA8F6283E55
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A771716F29E;
	Tue, 28 May 2024 14:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJH0LDtI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBC016D9C7
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 14:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716905388; cv=none; b=GK0mMZOtfuZpgLTFlMBIF9kyxBDFpinxicyEJAlEDArtZtflIpbgetg5oI3d972EYejEI3/6bFBS4bJ71HIOOB8YBd8g6qO/eGXFXW1K2ypLxO3rPhm6uLVcvlowXSr7UB4yumOPmKjoDn575HcxFpgtONtik21F4hHx7ToZ0EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716905388; c=relaxed/simple;
	bh=RhVZPDHTydObrUYFqmG3YLqwSNvx8ezX4NP6vBujhGw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Jh2myuZVs6GcoO7sxGZwQSW3LX/TI4VUP8KQmTcoOwPtmC4OzL6wbifQKEDU+ufQ49Z5+Q3JFXBM8wEtI8H08UUiC/SuQXJk5d/R90qGqMUQleoIH0iQ2srkPHvPgohV2Zk/++ohqpr8HA/XII3pnqt2SLKItA/Si0VwgobePq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJH0LDtI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF87BC3277B;
	Tue, 28 May 2024 14:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716905388;
	bh=RhVZPDHTydObrUYFqmG3YLqwSNvx8ezX4NP6vBujhGw=;
	h=Date:From:To:Cc:Subject:From;
	b=oJH0LDtIyOuD4tup6MYXaLjhu1lgFW5NxjsHG0Qqsy87hMYEJ0l3MorJFZAK9gO51
	 gObNGBWGtqbdgU6lV+GfAw8NddDMcSHmZUNblpW0Np6kyt75poYdGM1K5tCJxRPJG7
	 1ntZS3qrS0TKeQQ0KBT7pNZUGhIdEXCOiSLNlOrgDcNBXgvEW7bZGENPWbGyilPiV0
	 949mjqkdI+J5Zrlb4W9DzxVu5hoUuYsAJt08ggWHJNXuYFGy+YBbAnvFGAgC9+eip3
	 ibg5819nX8lN8A0InUjM/8rHdu/tD8tuzZo5YjMwH2H9BiM+L1SDvGvtltReP7vqnb
	 kCjRGT03OdwVg==
Date: Tue, 28 May 2024 11:09:39 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	H J Lu <hjl.tools@gmail.com>, Ian Rogers <irogers@google.com>,
	Ingo Molnar <mingo@kernel.org>, Jeff Xu <jeffxu@chromium.org>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 1/1 fyi] tools headers: Update the syscall tables and
 unistd.h, mostly to support the new 'mseal' syscall
Message-ID: <ZlXlo4TNcba4wnVZ@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tldr; Just FYI, I'm carrying this on the perf tools tree.

Full explanation:

There used to be no copies, with tools/ code using kernel headers
directly. From time to time tools/perf/ broke due to legitimate kernel
hacking. At some point Linus complained about such direct usage. Then we
adopted the current model.

The way these headers are used in perf are not restricted to just
including them to compile something.

There are sometimes used in scripts that convert defines into string
tables, etc, so some change may break one of these scripts, or new MSRs
may use some different #define pattern, etc.

E.g.:

  $ ls -1 tools/perf/trace/beauty/*.sh | head -5
  tools/perf/trace/beauty/arch_errno_names.sh
  tools/perf/trace/beauty/drm_ioctl.sh
  tools/perf/trace/beauty/fadvise.sh
  tools/perf/trace/beauty/fsconfig.sh
  tools/perf/trace/beauty/fsmount.sh
  $
  $ tools/perf/trace/beauty/fadvise.sh
  static const char *fadvise_advices[] = {
        [0] = "NORMAL",
        [1] = "RANDOM",
        [2] = "SEQUENTIAL",
        [3] = "WILLNEED",
        [4] = "DONTNEED",
        [5] = "NOREUSE",
  };
  $

The tools/perf/check-headers.sh script, part of the tools/ build
process, points out changes in the original files.

So its important not to touch the copies in tools/ when doing changes in
the original kernel headers, that will be done later, when
check-headers.sh inform about the change to the perf tools hackers.

But also to wire up shadow stacks on 32-bit x86, picking up those
changes from these csets:

  ff388fe5c481d39c ("mseal: wire up mseal syscall")
  2883f01ec37dd866 ("x86/shstk: Enable shadow stacks for x32")

This makes 'perf trace' support it, now its possible, for instance to
do:

  # perf trace -e mseal --max-stack=16

Here is an example with the 'sendmmsg' syscall:

  root@x1:~# perf trace -e sendmmsg --max-stack 16 --max-events=1
       0.000 ( 0.062 ms): dbus-broker/1012 sendmmsg(fd: 150, mmsg: 0x7ffef57cca50, vlen: 1, flags: DONTWAIT|NOSIGNAL) = 1
                                         syscall_exit_to_user_mode_prepare ([kernel.kallsyms])
                                         syscall_exit_to_user_mode_prepare ([kernel.kallsyms])
                                         syscall_exit_to_user_mode ([kernel.kallsyms])
                                         do_syscall_64 ([kernel.kallsyms])
                                         entry_SYSCALL_64 ([kernel.kallsyms])
                                         [0x117ce7] (/usr/lib64/libc.so.6 (deleted))
  root@x1:~#

To do a system wide tracing of the new 'mseal' syscall with a backtrace
of at most 16 entries.

This addresses these perf tools build warnings:

  Warning: Kernel ABI header differences:
    diff -u tools/include/uapi/asm-generic/unistd.h include/uapi/asm-generic/unistd.h
    diff -u tools/perf/arch/x86/entry/syscalls/syscall_64.tbl arch/x86/entry/syscalls/syscall_64.tbl
    diff -u tools/perf/arch/powerpc/entry/syscalls/syscall.tbl arch/powerpc/kernel/syscalls/syscall.tbl
    diff -u tools/perf/arch/s390/entry/syscalls/syscall.tbl arch/s390/kernel/syscalls/syscall.tbl
    diff -u tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl arch/mips/kernel/syscalls/syscall_n64.tbl

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: H J Lu <hjl.tools@gmail.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jeff Xu <jeffxu@chromium.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/asm-generic/unistd.h             | 5 ++++-
 tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl | 1 +
 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl  | 1 +
 tools/perf/arch/s390/entry/syscalls/syscall.tbl     | 1 +
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl   | 3 ++-
 5 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
index 75f00965ab1586cd..d983c48a3b6af175 100644
--- a/tools/include/uapi/asm-generic/unistd.h
+++ b/tools/include/uapi/asm-generic/unistd.h
@@ -842,8 +842,11 @@ __SYSCALL(__NR_lsm_set_self_attr, sys_lsm_set_self_attr)
 #define __NR_lsm_list_modules 461
 __SYSCALL(__NR_lsm_list_modules, sys_lsm_list_modules)
 
+#define __NR_mseal 462
+__SYSCALL(__NR_mseal, sys_mseal)
+
 #undef __NR_syscalls
-#define __NR_syscalls 462
+#define __NR_syscalls 463
 
 /*
  * 32 bit systems traditionally used different
diff --git a/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl b/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
index 532b855df589577b..1464c6be6eb3c752 100644
--- a/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
+++ b/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
@@ -376,3 +376,4 @@
 459	n64	lsm_get_self_attr		sys_lsm_get_self_attr
 460	n64	lsm_set_self_attr		sys_lsm_set_self_attr
 461	n64	lsm_list_modules		sys_lsm_list_modules
+462	n64	mseal				sys_mseal
diff --git a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
index 17173b82ca21dca2..3656f1ca7a21c659 100644
--- a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
@@ -548,3 +548,4 @@
 459	common	lsm_get_self_attr		sys_lsm_get_self_attr
 460	common	lsm_set_self_attr		sys_lsm_set_self_attr
 461	common	lsm_list_modules		sys_lsm_list_modules
+462	common	mseal				sys_mseal
diff --git a/tools/perf/arch/s390/entry/syscalls/syscall.tbl b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
index 095bb86339a7d378..bd0fee24ad10a3d1 100644
--- a/tools/perf/arch/s390/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
@@ -464,3 +464,4 @@
 459  common	lsm_get_self_attr	sys_lsm_get_self_attr		sys_lsm_get_self_attr
 460  common	lsm_set_self_attr	sys_lsm_set_self_attr		sys_lsm_set_self_attr
 461  common	lsm_list_modules	sys_lsm_list_modules		sys_lsm_list_modules
+462  common	mseal			sys_mseal			sys_mseal
diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
index 7e8d46f4147f5741..a396f6e6ab5bf97d 100644
--- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
@@ -374,7 +374,7 @@
 450	common	set_mempolicy_home_node	sys_set_mempolicy_home_node
 451	common	cachestat		sys_cachestat
 452	common	fchmodat2		sys_fchmodat2
-453	64	map_shadow_stack	sys_map_shadow_stack
+453	common	map_shadow_stack	sys_map_shadow_stack
 454	common	futex_wake		sys_futex_wake
 455	common	futex_wait		sys_futex_wait
 456	common	futex_requeue		sys_futex_requeue
@@ -383,6 +383,7 @@
 459	common	lsm_get_self_attr	sys_lsm_get_self_attr
 460	common	lsm_set_self_attr	sys_lsm_set_self_attr
 461	common	lsm_list_modules	sys_lsm_list_modules
+462 	common  mseal			sys_mseal
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
-- 
2.44.0


