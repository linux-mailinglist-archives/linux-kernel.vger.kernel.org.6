Return-Path: <linux-kernel+bounces-228616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2778916249
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 11:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F158284D16
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 09:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFB514A087;
	Tue, 25 Jun 2024 09:25:10 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304091487D4
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 09:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719307510; cv=none; b=LYdWA6o1akYU9+RLnh7lYpAQRltXlOwnV8GPo1z2OI7flkLw1zS3uhX0ZcCn5u4CsN0cY1aRfP2aPaO5czGnYI6SIED+t4kEOP6vAdRTdHWK/ARAkXyiwbvcD9DUXiijokpgfW7Xwq2Oc+hgjWJRC0xA6Y1du4/Whzz8KUbAETE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719307510; c=relaxed/simple;
	bh=Rin1Ni3+ZDJWcC+UmNwtou9kx5hUa+/ow7PysdlWC7s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VSWFGcE8wNmPshva1oKq5YxRnbO0anCdW8wodB6P16WPz1RDZGRoC2NOzF2pNBvzWyVA/sD/DMS2WHNqA8e4A3hh3At9uTMsXVhEAqs51mxf8an7G9FUOmlnKrSEodGoWBzmRFwVtFgb8joHlM4RPy3364Ww/m0wUYIShZiMENU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4W7fYk5y51znXdY;
	Tue, 25 Jun 2024 17:24:58 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 6B5BD18006E;
	Tue, 25 Jun 2024 17:25:03 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 25 Jun
 2024 17:25:02 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <oleg@redhat.com>,
	<tglx@linutronix.de>, <peterz@infradead.org>, <luto@kernel.org>,
	<kees@kernel.org>, <wad@chromium.org>, <ruanjinjie@huawei.com>,
	<rostedt@goodmis.org>, <arnd@arndb.de>, <ardb@kernel.org>,
	<broonie@kernel.org>, <mark.rutland@arm.com>, <rick.p.edgecombe@intel.com>,
	<leobras@redhat.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 2/3] arm64: Prepare to switch to generic entry
Date: Tue, 25 Jun 2024 17:27:58 +0800
Message-ID: <20240625092759.1533875-3-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625092759.1533875-1-ruanjinjie@huawei.com>
References: <20240625092759.1533875-1-ruanjinjie@huawei.com>
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

Prepare to switch to generic entry for arm64:

 - Implement regs_irqs_disabled() using interrupts_enabled() macro.

 - Make on_thread_stack() compatible with generic entry.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/include/asm/ptrace.h     | 5 +++++
 arch/arm64/include/asm/stacktrace.h | 5 ++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index 47ec58031f11..1857748ff017 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -360,6 +360,11 @@ static inline unsigned long regs_get_kernel_argument(struct pt_regs *regs,
 	return 0;
 }
 
+static inline int regs_irqs_disabled(struct pt_regs *regs)
+{
+	return !interrupts_enabled(regs);
+}
+
 /* We must avoid circular header include via sched.h */
 struct task_struct;
 int valid_user_regs(struct user_pt_regs *regs, struct task_struct *task);
diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/asm/stacktrace.h
index 66ec8caa6ac0..36bc1831f906 100644
--- a/arch/arm64/include/asm/stacktrace.h
+++ b/arch/arm64/include/asm/stacktrace.h
@@ -57,7 +57,10 @@ static inline bool on_task_stack(const struct task_struct *tsk,
 	return stackinfo_on_stack(&info, sp, size);
 }
 
-#define on_thread_stack()	(on_task_stack(current, current_stack_pointer, 1))
+static __always_inline bool on_thread_stack(void)
+{
+	return on_task_stack(current, current_stack_pointer, 1);
+}
 
 #ifdef CONFIG_VMAP_STACK
 DECLARE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)], overflow_stack);
-- 
2.34.1


