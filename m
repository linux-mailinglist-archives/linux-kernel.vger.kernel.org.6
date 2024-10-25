Return-Path: <linux-kernel+bounces-381468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 715CF9AFFA5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 12:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34CA32852CE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1ABE1FAC5E;
	Fri, 25 Oct 2024 10:08:46 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633DE1E5732
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 10:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729850926; cv=none; b=twMUFOEu61MKo94ixzjIMVVqFHl2L7tD7RWG0Oh+ZXuIf3mWcGAWz3TuBq3iYVOI+DEH0dT6KgHskaZVzvGOr66JForYIa9wz6AKQaHpgU5pMPGJoIdcHS+ht5aENShPPR41NnfhBmRaxqicc1v3YR3EDw2oUBOVbc3TOjLpCB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729850926; c=relaxed/simple;
	bh=H8EuLieIC77R6j2EtEuSulAlVvNnozvONuwW1MZqVXs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OEReEC/xDCbkQceEq2tdxcV9Q54WlbwUu43/r1fFOn2epwT0LMCZLjrwDj+wNAc/D0LyPT1+PYD/jSCiLql2Pfz2uUbDzaitAOgZ3TWRhKf013lRsaJWSYKCZ/GSPdsVUanNB46T9wwinJMqA2hoAjF3gUUBnPIeV2fvmPUGbrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XZdkB3WLkz1jvxM;
	Fri, 25 Oct 2024 18:07:14 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id F313F180043;
	Fri, 25 Oct 2024 18:08:39 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemg200008.china.huawei.com
 (7.202.181.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 25 Oct
 2024 18:08:38 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <oleg@redhat.com>, <linux@armlinux.org.uk>, <will@kernel.org>,
	<mark.rutland@arm.com>, <catalin.marinas@arm.com>, <sstabellini@kernel.org>,
	<maz@kernel.org>, <tglx@linutronix.de>, <peterz@infradead.org>,
	<luto@kernel.org>, <kees@kernel.org>, <wad@chromium.org>,
	<akpm@linux-foundation.org>, <samitolvanen@google.com>, <arnd@arndb.de>,
	<ojeda@kernel.org>, <rppt@kernel.org>, <hca@linux.ibm.com>,
	<aliceryhl@google.com>, <samuel.holland@sifive.com>, <paulmck@kernel.org>,
	<aquini@redhat.com>, <petr.pavlu@suse.com>, <ruanjinjie@huawei.com>,
	<viro@zeniv.linux.org.uk>, <rmk+kernel@armlinux.org.uk>, <ardb@kernel.org>,
	<wangkefeng.wang@huawei.com>, <surenb@google.com>,
	<linus.walleij@linaro.org>, <yangyj.ee@gmail.com>, <broonie@kernel.org>,
	<mbenes@suse.cz>, <puranjay@kernel.org>, <pcc@google.com>,
	<guohanjun@huawei.com>, <sudeep.holla@arm.com>,
	<Jonathan.Cameron@huawei.com>, <prarit@redhat.com>, <liuwei09@cestc.cn>,
	<dwmw@amazon.co.uk>, <oliver.upton@linux.dev>, <kristina.martsenko@arm.com>,
	<ptosi@google.com>, <frederic@kernel.org>, <vschneid@redhat.com>,
	<thiago.bauermann@linaro.org>, <joey.gouly@arm.com>,
	<liuyuntao12@huawei.com>, <leobras@redhat.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<xen-devel@lists.xenproject.org>
Subject: [PATCH -next v4 05/19] arm64: entry: Remove __exit_to_kernel_mode()
Date: Fri, 25 Oct 2024 18:06:46 +0800
Message-ID: <20241025100700.3714552-6-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025100700.3714552-1-ruanjinjie@huawei.com>
References: <20241025100700.3714552-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemg200008.china.huawei.com (7.202.181.35)

__exit_to_kernel_mode() is only called by exit_to_kernel_mode(),
remove it.

No functional changes.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/kernel/entry-common.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index a7fd4d6c7650..137481a3f0fa 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -69,9 +69,11 @@ static noinstr irqentry_state_t enter_from_kernel_mode(struct pt_regs *regs)
  * This is intended to match the logic in irqentry_exit(), handling the kernel
  * mode transitions only, and with preemption handled elsewhere.
  */
-static __always_inline void __exit_to_kernel_mode(struct pt_regs *regs,
-						  irqentry_state_t state)
+static void noinstr exit_to_kernel_mode(struct pt_regs *regs,
+					irqentry_state_t state)
 {
+	mte_check_tfsr_exit();
+
 	lockdep_assert_irqs_disabled();
 
 	if (!regs_irqs_disabled(regs)) {
@@ -90,13 +92,6 @@ static __always_inline void __exit_to_kernel_mode(struct pt_regs *regs,
 	}
 }
 
-static void noinstr exit_to_kernel_mode(struct pt_regs *regs,
-					irqentry_state_t state)
-{
-	mte_check_tfsr_exit();
-	__exit_to_kernel_mode(regs, state);
-}
-
 /*
  * Handle IRQ/context state management when entering from user mode.
  * Before this function is called it is not safe to call regular kernel code,
-- 
2.34.1


