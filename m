Return-Path: <linux-kernel+bounces-234865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E05491CBC0
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 10:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBF2DB22405
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 08:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962AE3D0AD;
	Sat, 29 Jun 2024 08:53:22 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338002E651
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 08:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719651202; cv=none; b=AWJRh8j2miSp0wVuh6LD1KKHhsgTe6fkIQ73djNytl9RBKtM4N5eymLIIk8yIri4xjrcgzRNIiL342v+cyC8AuSBKmSR+q+D16zhIkZTlTrA26akxuD5yETj/56B0bTo+zwFH8ahrmYk9UjAq3KXILdvaiZDlhC8blvxoYjgGf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719651202; c=relaxed/simple;
	bh=N23JfvemXKqh7VqUX0O6fy3MfH1Q0h9yZIHi7l1ghpQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E0IygG7bqnXFaKAJR6iAE52hz8DeRlyIPJ/nd9oUa6UWmFQs3fsPqbUYhc/dproGz915+7gUhhnqu66Lgm8q3N5gLtVo9JFzXIz84xzqnAz7bKZH9BmTikZ4D5y6cAakkaz9WxXtXTu59k8waxALToxHSohvK6R4K2y5dm45Vfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WB5g122w0znYVL;
	Sat, 29 Jun 2024 16:53:01 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id E7ACC18006F;
	Sat, 29 Jun 2024 16:53:11 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sat, 29 Jun
 2024 16:53:11 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <oleg@redhat.com>,
	<tglx@linutronix.de>, <peterz@infradead.org>, <luto@kernel.org>,
	<kees@kernel.org>, <wad@chromium.org>, <ruanjinjie@huawei.com>,
	<rostedt@goodmis.org>, <arnd@arndb.de>, <ardb@kernel.org>,
	<broonie@kernel.org>, <mark.rutland@arm.com>, <rick.p.edgecombe@intel.com>,
	<leobras@redhat.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 0/3] arm64: entry: Convert to generic entry
Date: Sat, 29 Jun 2024 16:55:58 +0800
Message-ID: <20240629085601.470241-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi100008.china.huawei.com (7.221.188.57)

Currently, x86, Riscv, Loongarch use the generic entry. Convert arm64
to use the generic entry infrastructure from kernel/entry/*. The generic
entry makes maintainers' work easier and codes more elegant, which aslo
removed a lot of duplicate code.

Changes in v3:
- Test the MTE test cases.
- Handle forget_syscall() in arch_post_report_syscall_entry()
- Make the arch funcs not use __weak as Thomas suggested, so move
  the arch funcs to entry-common.h, and make arch_forget_syscall() folded
  in arch_post_report_syscall_entry() as suggested.
- Move report_single_step() to thread_info.h for arm64
- Change __always_inline() to inline, add inline for the other arch funcs.
- Remove unused signal.h for entry-common.h.
- Add Suggested-by.
- Update the commit message.

Changes in v2:
- Add tested-by.
- Fix a bug that not call arch_post_report_syscall_entry() in
  syscall_trace_enter() if ptrace_report_syscall_entry() return not zero.
- Refactor report_syscall().
- Add comment for arch_prepare_report_syscall_exit().
- Adjust entry-common.h header file inclusion to alphabetical order.
- Update the commit message.

Jinjie Ruan (3):
  entry: Add some arch funcs to support arm64 to use generic entry
  arm64: Prepare to switch to generic entry
  arm64: entry: Convert to generic entry

 arch/arm64/Kconfig                    |   1 +
 arch/arm64/include/asm/entry-common.h | 172 ++++++++++++
 arch/arm64/include/asm/ptrace.h       |   5 +
 arch/arm64/include/asm/stacktrace.h   |   5 +-
 arch/arm64/include/asm/syscall.h      |   6 +-
 arch/arm64/include/asm/thread_info.h  |  23 +-
 arch/arm64/kernel/entry-common.c      | 368 +++++---------------------
 arch/arm64/kernel/ptrace.c            |  90 -------
 arch/arm64/kernel/signal.c            |   3 +-
 arch/arm64/kernel/syscall.c           |  18 +-
 include/linux/entry-common.h          |  90 +++++++
 include/linux/thread_info.h           |  13 +
 kernel/entry/common.c                 |  37 +--
 13 files changed, 395 insertions(+), 436 deletions(-)
 create mode 100644 arch/arm64/include/asm/entry-common.h

-- 
2.34.1


