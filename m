Return-Path: <linux-kernel+bounces-441551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 457D89ED012
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28C2D16532F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 15:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6711DE3A6;
	Wed, 11 Dec 2024 15:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mYw0sj+q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0091D1D6DBE
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 15:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733931662; cv=none; b=sTVRX/LgBmyxGymmnmOM7epLE3HaYkXh4rlPTwHQoaKzpMzs5dyfg77lAvQz8e9xmei5ihAT6F4cuiUU9gew6593jQOg84y5oNxI4Cmj7vVO8V7lxSeTcVPNcBwtFNdJODyDT6L9OWaDoQh/0y3gPNCwMrTN8l209OumtPj/CsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733931662; c=relaxed/simple;
	bh=SttYBIaPdboWBtK12Elu3Y3FOH6DeoWnLomHDvHV02Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RPPTQn+fBhqTHEe+wyRMC8TvCRVpFnpSS9VeUJgVZSI1qSaM7UeCNUDPG/wLXxySsdFxqufhUNxLKRRpwuihYDUm5O1hveabQ/ftcvtxRUHO1timODIuKCswo4428gtOXe2XSOzqO2XBG7omiCiow3h04pscVzRizYtFwEhTmVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYw0sj+q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 623CDC4CED7;
	Wed, 11 Dec 2024 15:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733931661;
	bh=SttYBIaPdboWBtK12Elu3Y3FOH6DeoWnLomHDvHV02Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mYw0sj+q/mBmDx9+S6IeuLGcwZNfy2BKlDKl+Y3ZlGab1TVTEbydl0TzP8CrhQkya
	 9pstwO+mfcY0cGN3+tF/1zopZx9jleeiVCjS8RGVS2fwyhtRNraQ7rgSCDS2PJ7JLh
	 eMYU6k1fyRPRM1U42HLm8I9KMFP8UHsl/POCmxzB5rR63xJ1SzhcmDVK2wNmCjvEca
	 lVGMG1Xb5qtlrLUkPoA65a7Y+R8WOU+BkJGa747KXqFKIj19toA6VixTrZC6HYGMLf
	 3NQdwPu34x9ycRtuFGOnvDIM4mn++yvbBMyRVWkLlPplIMu+y4yYg8BkSvOOTi8ftS
	 XBFX+hygt8Eww==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 09/19] arm64: Exclude nohz_full CPUs from 32bits el0 support
Date: Wed, 11 Dec 2024 16:40:22 +0100
Message-ID: <20241211154035.75565-10-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241211154035.75565-1-frederic@kernel.org>
References: <20241211154035.75565-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nohz full CPUs are not a desirable fallback target to run 32bits el0
applications. If present, prefer a set of housekeeping CPUs that can do
the job instead. Otherwise just don't support el0 32 bits. Should the
need arise, appropriate support can be introduced in the future.

Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 Documentation/arch/arm64/asymmetric-32bit.rst | 9 +++++++++
 arch/arm64/kernel/cpufeature.c                | 6 +++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/arch/arm64/asymmetric-32bit.rst b/Documentation/arch/arm64/asymmetric-32bit.rst
index 64a0b505da7d..0c762cfc0f34 100644
--- a/Documentation/arch/arm64/asymmetric-32bit.rst
+++ b/Documentation/arch/arm64/asymmetric-32bit.rst
@@ -153,3 +153,12 @@ asymmetric system, a broken guest at EL1 could still attempt to execute
 mode will return to host userspace with an ``exit_reason`` of
 ``KVM_EXIT_FAIL_ENTRY`` and will remain non-runnable until successfully
 re-initialised by a subsequent ``KVM_ARM_VCPU_INIT`` operation.
+
+NOHZ FULL
+--------
+
+Nohz full CPUs are not a desirable fallback target to run 32bits el0
+applications. If present, a set of housekeeping CPUs that can do
+the job instead is preferred. Otherwise 32-bit EL0 is not supported.
+Should the need arise, appropriate support can be introduced in the
+future.
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 6ce71f444ed8..7ce1b8ab417f 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -75,6 +75,7 @@
 #include <linux/cpu.h>
 #include <linux/kasan.h>
 #include <linux/percpu.h>
+#include <linux/sched/isolation.h>
 
 #include <asm/cpu.h>
 #include <asm/cpufeature.h>
@@ -3742,7 +3743,10 @@ static int enable_mismatched_32bit_el0(unsigned int cpu)
 	static int lucky_winner = -1;
 
 	struct cpuinfo_arm64 *info = &per_cpu(cpu_data, cpu);
-	bool cpu_32bit = id_aa64pfr0_32bit_el0(info->reg_id_aa64pfr0);
+	bool cpu_32bit = false;
+
+	if (id_aa64pfr0_32bit_el0(info->reg_id_aa64pfr0) && housekeeping_cpu(cpu, HK_TYPE_TICK))
+		cpu_32bit = true;
 
 	if (cpu_32bit) {
 		cpumask_set_cpu(cpu, cpu_32bit_el0_mask);
-- 
2.46.0


