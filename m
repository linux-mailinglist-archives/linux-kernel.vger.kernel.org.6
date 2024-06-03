Return-Path: <linux-kernel+bounces-198719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3168D7C88
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 09:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DACCD283A57
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 07:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B664D43ADC;
	Mon,  3 Jun 2024 07:36:37 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7995025E
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 07:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717400197; cv=none; b=FpM0GSMKWsY4LL0leC9mkBRLpHWqOSzafNLBIXjogYef4aCFZZmaQYn1acNgomSO0iqjIg2LigQlWS4IDuv+6eO5J3ABjYROfx5RiLMdN80n3TSmfUSZnHODVXKWu1EEBivSa76g/nqZLCFGcMOCfsr7z0JPtPSNqtsmcIoFZPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717400197; c=relaxed/simple;
	bh=G/MXFcAbevnD2OMNzuTpAk/1J7svRArLtuFEReb3Z8w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QDLgbx70kL1M/glIe6Wp8NvkPTBcogx70NDuUr/GzQoqt0i7LVW7G189eqfwhG5ioXVwGw30lsz/jSEMcWqFvyTkk16+GIeNz7uGxCxXiMv+RvkiCvdBjTAoCvtBYaHWfEmOcvIikb6nUVdLXldNIeMW9jQMdPn/2yTYBI4D89o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Vt5691BQkz1JC47;
	Mon,  3 Jun 2024 15:32:33 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
	by mail.maildlp.com (Postfix) with ESMTPS id CD2D91400D7;
	Mon,  3 Jun 2024 15:36:26 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 3 Jun
 2024 15:36:26 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <linux@armlinux.org.uk>, <oleg@redhat.com>, <arnd@arndb.de>, <afd@ti.com>,
	<akpm@linux-foundation.org>, <rmk+kernel@armlinux.org.uk>,
	<linus.walleij@linaro.org>, <eric.devolder@oracle.com>, <robh@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH] ARM: Add HAVE_FUNCTION_ARG_ACCESS_API support
Date: Mon, 3 Jun 2024 15:37:51 +0800
Message-ID: <20240603073751.2282024-1-ruanjinjie@huawei.com>
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
 kwepemi500008.china.huawei.com (7.221.188.139)

Currently, kprobe on ARM32 can not use the '$argx' syntax available on
other architecture. So implement regs_get_kernel_argument() and add
HAVE_FUNCTION_ARG_ACCESS_API support.

Before there is a following error:
	echo 'p:kprobe_submit_bio submit_bio bio=$arg1' > kprobe_events
	sh: write error: Invalid argument

After:
	# echo 'p:kprobe_submit_bio submit_bio bio=$arg1' > kprobe_events
	# echo  1 > events/kprobes/enable
	# echo  1 > events/kprobes/kprobe_submit_bio/enable
	# echo 0 > tracing_on
	# echo > trace
	# echo 1 > tracing_on
	# cat trace
		kworker/u19:0-36      [002] d....    54.175322: kprobe_submit_bio: (submit_bio+0x0/0xf8) bio=0xc24e6000

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm/Kconfig              |  1 +
 arch/arm/include/asm/ptrace.h | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ee5115252aac..4ed504139763 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -102,6 +102,7 @@ config ARM
 	select HAVE_EXIT_THREAD
 	select HAVE_GUP_FAST if ARM_LPAE
 	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
+	select HAVE_FUNCTION_ARG_ACCESS_API
 	select HAVE_FUNCTION_ERROR_INJECTION
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_TRACER if !XIP_KERNEL
diff --git a/arch/arm/include/asm/ptrace.h b/arch/arm/include/asm/ptrace.h
index 6eb311fb2da0..da5dd4cd0324 100644
--- a/arch/arm/include/asm/ptrace.h
+++ b/arch/arm/include/asm/ptrace.h
@@ -52,6 +52,28 @@ struct svc_pt_regs {
 #define fast_interrupts_enabled(regs) \
 	(!((regs)->ARM_cpsr & PSR_F_BIT))
 
+/**
+ * regs_get_kernel_argument() - get Nth function argument in kernel
+ * @regs:	pt_regs of that context
+ * @n:		function argument number (start from 0)
+ *
+ * regs_get_argument() returns @n th argument of the function call.
+ *
+ * Note that this chooses the most likely register mapping. In very rare
+ * cases this may not return correct data, for example, if one of the
+ * function parameters is 16 bytes or bigger. In such cases, we cannot
+ * get access the parameter correctly and the register assignment of
+ * subsequent parameters will be shifted.
+ */
+static inline unsigned long regs_get_kernel_argument(struct pt_regs *regs,
+						     unsigned int n)
+{
+#define NR_REG_ARGUMENTS 4
+	if (n < NR_REG_ARGUMENTS)
+		return regs->uregs[n];
+	return 0;
+}
+
 /* Are the current registers suitable for user mode?
  * (used to maintain security in signal handlers)
  */
-- 
2.34.1


