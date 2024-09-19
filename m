Return-Path: <linux-kernel+bounces-333080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC4597C334
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 05:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D2E3B21B15
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 03:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999D612E75;
	Thu, 19 Sep 2024 03:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="qQaEjJEl"
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40690FC0E
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 03:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726717392; cv=none; b=e/CTmQL2vKx4EoGry/BBvKYan8CxGOJKPmBWralLl3Wz2YWyFSdmJzfSNCE1DKYdZvpm63wFpxu15nSOefkDmWGsSWBlxTHGqKMy0EwULN4QYyJz0tTlsRiiJ7uFige6wnBqZnJwnSL3bk3a9Jp9EPR8zdZGh52KjGMY0QV9LRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726717392; c=relaxed/simple;
	bh=DGxeJgemhoDo5JKQYPlnG86DMJLcCfAUQs0cO+BoAK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bewzsBTsWy+h+qOOXoWio5Wo4Mo6hA+9IhBRCigp1umThRKh58B8nKTxyzchgHVw4pJ0y4rIftJmVMrxN6WiaZFd43Ql0jvpldoQ5NX8imbmiVYpBt7UKsgJMnQrgSYPLeSARLTqgdMb73YnqEiGqg78KOwJ3wQazFcKJjDbLYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=qQaEjJEl; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1726717356;
	bh=SgCHUiz82lndKjTeNsmeInw+/PdasPiFZ+8EYbiHHVQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=qQaEjJEl9LjxQ19FNBHEowYzzxMAbs8OqO9Xf4w0hdojDArQ8OZ6tE2cqafCAE2ky
	 s10gDMiqoCxHEvRul1aHwkhiYufpdqSf/PZwJVh8oRkA7tGfguwboynpSrXrKvcGXt
	 SHnSHbZcxAi8nglg5hPaApnscJnpYsU8qsy3+L3g=
X-QQ-mid: bizesmtp91t1726717345tc4qvn7k
X-QQ-Originating-IP: tfsA70aSzkRofVa6syLi67IHJ7ynHwMMwuML09155uQ=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 19 Sep 2024 11:42:23 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5706766640839109577
From: WangYuli <wangyuli@uniontech.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	samuel.holland@sifive.com,
	conor.dooley@microchip.com,
	charlie@rivosinc.com,
	macro@orcam.me.uk
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	atish.patra@wdc.com,
	anup@brainfault.org,
	guanwentao@uniontech.com,
	zhanjun@uniontech.com,
	tglx@linutronix.de,
	peterz@infradead.org,
	palmer@rivosinc.com,
	mikelley@microsoft.com,
	oleksandr@natalenko.name,
	deller@gmx.de,
	gpiccoli@igalia.com,
	WangYuli <wangyuli@uniontech.com>
Subject: [RESEND. PATCH v2] riscv: Use '%u' to format the output of 'cpu'
Date: Thu, 19 Sep 2024 11:41:46 +0800
Message-ID: <CC5FEE6571AB2A58+20240919034146.57207-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

'cpu' is an unsigned integer, so its conversion specifier should
be %u, not %d.

Suggested-by: Wentao Guan <guanwentao@uniontech.com>
Suggested-by: Maciej W. Rozycki <macro@orcam.me.uk>
Link: https://lore.kernel.org/all/alpine.DEB.2.21.2409122309090.40372@angie.orcam.me.uk/
Signed-off-by: WangYuli <wangyuli@uniontech.com>
Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Tested-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/kernel/cpu-hotplug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/cpu-hotplug.c b/arch/riscv/kernel/cpu-hotplug.c
index 28b58fc5ad19..a1e38ecfc8be 100644
--- a/arch/riscv/kernel/cpu-hotplug.c
+++ b/arch/riscv/kernel/cpu-hotplug.c
@@ -58,7 +58,7 @@ void arch_cpuhp_cleanup_dead_cpu(unsigned int cpu)
 	if (cpu_ops->cpu_is_stopped)
 		ret = cpu_ops->cpu_is_stopped(cpu);
 	if (ret)
-		pr_warn("CPU%d may not have stopped: %d\n", cpu, ret);
+		pr_warn("CPU%u may not have stopped: %d\n", cpu, ret);
 }
 
 /*
-- 
2.45.2


