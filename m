Return-Path: <linux-kernel+bounces-434865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C395E9E6C1E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 11:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BA372879E3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D772144C2;
	Fri,  6 Dec 2024 10:18:34 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E618213243
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 10:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733480314; cv=none; b=q18M1fjlLAjq0J+IGaBtnKqaGjJAWRz0eRpuscljZb5MQLFhZEFmU2G8HZoX/S98KQSJnhkMZC2SVVGT5IpGFa3MS8PTEOiNX83o5GstIi1Wi9UeP/RDS4pEChYyyDc5Kf9PhQBYdDwIoD4tQCm3T0KkqVjQK8uyN0bQFnFYDO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733480314; c=relaxed/simple;
	bh=f7XyUrdtuP1aaNG1OPRMBXP6UpthIf4nUXQznFhWvn0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bm3SEvOY6rcwcr6dtkRgvrFsWBqEJFK7FbK1cETxLNpSm1FKMwICfQRLLlJAXpXJ7+5vKSuEsFp3IsoHNLl2zvJz14A5bXTuhedVYi52cmTc7S1UfXFR1nVAzTzp2BjFu2u4hW0SE7/mkLqI9RFE7VXVBvsMZawDksIkFpzJZzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Y4S023RH5z1yrpl;
	Fri,  6 Dec 2024 18:18:42 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id 71C49180041;
	Fri,  6 Dec 2024 18:18:26 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemg200008.china.huawei.com
 (7.202.181.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Dec
 2024 18:18:25 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <oleg@redhat.com>,
	<sstabellini@kernel.org>, <tglx@linutronix.de>, <peterz@infradead.org>,
	<luto@kernel.org>, <mingo@redhat.com>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>, <kees@kernel.org>, <wad@chromium.org>,
	<akpm@linux-foundation.org>, <samitolvanen@google.com>,
	<masahiroy@kernel.org>, <hca@linux.ibm.com>, <aliceryhl@google.com>,
	<rppt@kernel.org>, <xur@google.com>, <paulmck@kernel.org>, <arnd@arndb.de>,
	<mbenes@suse.cz>, <puranjay@kernel.org>, <mark.rutland@arm.com>,
	<ruanjinjie@huawei.com>, <pcc@google.com>, <ardb@kernel.org>,
	<sudeep.holla@arm.com>, <guohanjun@huawei.com>, <rafael@kernel.org>,
	<liuwei09@cestc.cn>, <dwmw@amazon.co.uk>, <Jonathan.Cameron@huawei.com>,
	<liaochang1@huawei.com>, <kristina.martsenko@arm.com>, <ptosi@google.com>,
	<broonie@kernel.org>, <thiago.bauermann@linaro.org>, <kevin.brodsky@arm.com>,
	<joey.gouly@arm.com>, <liuyuntao12@huawei.com>, <leobras@redhat.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<xen-devel@lists.xenproject.org>
Subject: [PATCH -next v5 16/22] entry: Make syscall_exit_to_user_mode_prepare() not static
Date: Fri, 6 Dec 2024 18:17:38 +0800
Message-ID: <20241206101744.4161990-17-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206101744.4161990-1-ruanjinjie@huawei.com>
References: <20241206101744.4161990-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemg200008.china.huawei.com (7.202.181.35)

In order to switch to the generic entry for arm64, make
syscall_exit_to_user_mode_prepare() not static and can be used by
arm64.

No functional changes.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 include/linux/entry-common.h  | 1 +
 kernel/entry/syscall-common.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index b3233e8328c5..d11bdb4679b3 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -172,5 +172,6 @@ void syscall_exit_to_user_mode_work(struct pt_regs *regs);
  * compelling architectural reason to use the separate functions.
  */
 void syscall_exit_to_user_mode(struct pt_regs *regs);
+void syscall_exit_to_user_mode_prepare(struct pt_regs *regs);
 
 #endif
diff --git a/kernel/entry/syscall-common.c b/kernel/entry/syscall-common.c
index 0eb036986ad4..f78285097111 100644
--- a/kernel/entry/syscall-common.c
+++ b/kernel/entry/syscall-common.c
@@ -115,7 +115,7 @@ static void syscall_exit_work(struct pt_regs *regs, unsigned long work)
  * Syscall specific exit to user mode preparation. Runs with interrupts
  * enabled.
  */
-static void syscall_exit_to_user_mode_prepare(struct pt_regs *regs)
+void syscall_exit_to_user_mode_prepare(struct pt_regs *regs)
 {
 	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
 	unsigned long nr = syscall_get_nr(current, regs);
-- 
2.34.1


