Return-Path: <linux-kernel+bounces-231981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F0D91A11C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 10:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5B061F229A7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 08:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B4B78C9A;
	Thu, 27 Jun 2024 08:09:34 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C177641E
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 08:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719475774; cv=none; b=AhHjJX5J1CPC8phoCb4Qu5/bjgIwKgom/QmR0Drup8XEw2nK3WJDFBLFRmNhLqBW411TAmczsbSQueIbw1kPO2xcAg04oNopU9/khlIW3UTRA71QGAApSUT/X8srUhsSo5U269hkuctfTaTStfVgJokjBoE/eUfVn9aWeM5xOiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719475774; c=relaxed/simple;
	bh=URJJ0VTb5At2bI+ZPx3Z/uEYy8l7ogZI+Fom0NkP9LM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sEmCrApmd5sJsJJMaBnlPZe/ptA406yXd0tDMlS0VohoxBX2p7Faxbp9iZDiB+IlzVQD84Dt9yvZLb1sFMGZYet/aSNP4RmaSC9tdJ/EMcbcd/swt4WEY/7eibA2lXO1KBirxt4uUeufyhMOVy9SFRyhGid0JG+sSK2P3qXMfnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4W8rhy73NQz1X4Pw;
	Thu, 27 Jun 2024 16:05:22 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 1B8BC140157;
	Thu, 27 Jun 2024 16:09:24 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 27 Jun
 2024 16:09:23 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <oleg@redhat.com>,
	<tglx@linutronix.de>, <peterz@infradead.org>, <luto@kernel.org>,
	<kees@kernel.org>, <wad@chromium.org>, <ruanjinjie@huawei.com>,
	<rostedt@goodmis.org>, <arnd@arndb.de>, <ardb@kernel.org>,
	<broonie@kernel.org>, <mark.rutland@arm.com>, <rick.p.edgecombe@intel.com>,
	<leobras@redhat.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 0/3] arm64: entry: Convert to generic entry
Date: Thu, 27 Jun 2024 16:12:06 +0800
Message-ID: <20240627081209.3511918-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi100008.china.huawei.com (7.221.188.57)

Currently, x86, Riscv, Loongarch use the generic entry. Convert arm64
to use the generic entry infrastructure from kernel/entry/*. The generic
entry makes maintainers' work easier and codes more elegant, which aslo
removed a lot of duplicate code.

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
 arch/arm64/include/asm/entry-common.h |  60 +++++
 arch/arm64/include/asm/ptrace.h       |   5 +
 arch/arm64/include/asm/stacktrace.h   |   5 +-
 arch/arm64/include/asm/syscall.h      |   6 +-
 arch/arm64/include/asm/thread_info.h  |  23 +-
 arch/arm64/kernel/entry-common.c      | 355 ++++++--------------------
 arch/arm64/kernel/ptrace.c            |  81 +++---
 arch/arm64/kernel/signal.c            |   3 +-
 arch/arm64/kernel/syscall.c           |  18 +-
 include/linux/entry-common.h          |  51 ++++
 kernel/entry/common.c                 |  48 +++-
 12 files changed, 294 insertions(+), 362 deletions(-)
 create mode 100644 arch/arm64/include/asm/entry-common.h

-- 
2.34.1


