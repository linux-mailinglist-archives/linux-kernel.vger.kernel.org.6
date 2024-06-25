Return-Path: <linux-kernel+bounces-228615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF3F916248
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 11:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A9AB283962
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 09:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2EF149C5E;
	Tue, 25 Jun 2024 09:25:09 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7306148838
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 09:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719307508; cv=none; b=Sl0ITVPix/H1FAaJZ/1NOGvAPflQxQKQzQp/M6D2+183sbdnI2rsFdNLoPw356CCnjKr7sKOo4dkPWbpxsAbFs/H7ja0pQ/5iWlUk7L1PJ74MVzLUrB2v7dOxlsPTWSLKVzy/GpDUaROfTl5RNZoYSH+dEYhMEdUApNI3tyNVsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719307508; c=relaxed/simple;
	bh=iwWMLnxsyiJ99LgfwKEducRDSs/Du+DFckUPSgl7l1E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WTo1aid5byTHFUB4eCh1MtxffJPNN70TZMeqC8ssp8y35z2PcWxiENaHXKMsCtQ93DT1UrC56y6SZGC2yeL6prwob+GQBXrs3jewnWXCSAoyzhF6JioHVHeWVKlmKgri4YfwZ2oA5prw0cut0DHXmF715evaoimW59TJ9s4RwRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4W7fT76qW3z2CkbL;
	Tue, 25 Jun 2024 17:20:59 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 053C7140360;
	Tue, 25 Jun 2024 17:24:59 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 25 Jun
 2024 17:24:58 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <oleg@redhat.com>,
	<tglx@linutronix.de>, <peterz@infradead.org>, <luto@kernel.org>,
	<kees@kernel.org>, <wad@chromium.org>, <ruanjinjie@huawei.com>,
	<rostedt@goodmis.org>, <arnd@arndb.de>, <ardb@kernel.org>,
	<broonie@kernel.org>, <mark.rutland@arm.com>, <rick.p.edgecombe@intel.com>,
	<leobras@redhat.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 0/3]  arm64: entry: Convert to generic entry
Date: Tue, 25 Jun 2024 17:27:56 +0800
Message-ID: <20240625092759.1533875-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi100008.china.huawei.com (7.221.188.57)

Currently, x86, Riscv, Loongarch use the generic entry. Convert arm64
to use the generic entry infrastructure from kernel/entry/*. The generic
entry makes maintainers' work easier and codes more elegant, which aslo
removed a lot of duplicate code.

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
 arch/arm64/kernel/ptrace.c            |  78 +++---
 arch/arm64/kernel/signal.c            |   3 +-
 arch/arm64/kernel/syscall.c           |  18 +-
 include/linux/entry-common.h          |  51 ++++
 kernel/entry/common.c                 |  49 +++-
 12 files changed, 294 insertions(+), 360 deletions(-)
 create mode 100644 arch/arm64/include/asm/entry-common.h

-- 
2.34.1


