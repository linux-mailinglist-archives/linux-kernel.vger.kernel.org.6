Return-Path: <linux-kernel+bounces-406028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D639C5A3D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74A851F2529F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 14:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9512003BC;
	Tue, 12 Nov 2024 14:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ax+Ywrn1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6DE2003D1
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 14:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731421402; cv=none; b=j8Zse9d5FiixYyyB9Hxen4LxgcZ84HemJ56nVlaWPcdqZmEtKks+HRLO4JqRIXU6l4jU7/smxqZmIgU0XG2Zy06nbEbk3/qrEpfXuXKyoxQ7Ye858JNUA/8qQoymFku8RjzJE4H2n24DbzMSdaD5bsD/jWwYq3CgzWAmJNozVoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731421402; c=relaxed/simple;
	bh=rrl5Cf3sGFo9Tm43JqFtYQb0O1dldmbe1HOCsSTldCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YPppnGTVG94IbbM0yEcZsp6IJKKuIFpEC5pSFNa46wOGAW3bJKisYpZ0vQfWLrEYASuz4DSuM812+fIe+S29Szz+PWwVGDTcSxNv+DMW1dJEOjYrUX3N7wYUi6Efj/rQ5EY32Qur3UB4RxfQZ8Um+MaPhifF7HYJmCDy2xCV1pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ax+Ywrn1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B004DC4CED0;
	Tue, 12 Nov 2024 14:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731421402;
	bh=rrl5Cf3sGFo9Tm43JqFtYQb0O1dldmbe1HOCsSTldCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ax+Ywrn1Wt/6DkjiZaZMN7opdu7msl9gpeZ79VYbOgLeTO/q3w1JVhW+F66f/A73L
	 dwq+RWTelZfE7RC8W3R55W84IMlbRH5T2Q9Zj8KrMon5/c/xSo5XV/sk/CEI+YHfkg
	 9PXPxWgjswqeqjyai7v3eSVC51Jo7cpIrbUICOCXTjnnxOtpMFni/lRI4kz/Wwwh83
	 F7+W8K5nq0rqv9gtgNFjAsUK5lzkSp7VHBb5CoWYWhXGH7SJ1copcnbaN2QSLLROI2
	 RnwdQVq37WWUBOZ58+NTY7u8z/0SVwxDfVzhy5iijltVtD37KFBMseZIGCMKUdltIj
	 lKPK/jTjmeAaA==
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
Subject: [PATCH 11/21] arm64: Keep first mismatched 32bits el0 capable CPU online through its callbacks
Date: Tue, 12 Nov 2024 15:22:35 +0100
Message-ID: <20241112142248.20503-12-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241112142248.20503-1-frederic@kernel.org>
References: <20241112142248.20503-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first mismatched 32bits el0 capable CPU is designated as the last
resort CPU for compat 32 bits tasks. As such this CPU is forbidden to
go offline.

However this restriction is applied to the device object of the CPU,
which is not easy to revert later if needed because other components may
have forbidden the target to be offline and they are not tracked.

But the task cpu possible mask is going to be made aware of housekeeping
CPUs. In that context, a better 32 bits el0 last resort CPU may be found
later on boot. When that happens, the old fallback can be made
offlineable again.

To make this possible and more flexible, drive the offlineable decision
from the cpuhotplug callbacks themselves.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 arch/arm64/kernel/cpufeature.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 718728a85430..53ee8ce38d5b 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -3591,15 +3591,15 @@ void __init setup_user_features(void)
 	minsigstksz_setup();
 }
 
-static int enable_mismatched_32bit_el0(unsigned int cpu)
-{
-	/*
-	 * The first 32-bit-capable CPU we detected and so can no longer
-	 * be offlined by userspace. -1 indicates we haven't yet onlined
-	 * a 32-bit-capable CPU.
-	 */
-	static int lucky_winner = -1;
+/*
+ * The first 32-bit-capable CPU we detected and so can no longer
+ * be offlined by userspace. -1 indicates we haven't yet onlined
+ * a 32-bit-capable CPU.
+ */
+static int cpu_32bit_unofflineable = -1;
 
+static int mismatched_32bit_el0_online(unsigned int cpu)
+{
 	struct cpuinfo_arm64 *info = &per_cpu(cpu_data, cpu);
 	bool cpu_32bit = id_aa64pfr0_32bit_el0(info->reg_id_aa64pfr0);
 
@@ -3611,7 +3611,7 @@ static int enable_mismatched_32bit_el0(unsigned int cpu)
 	if (cpumask_test_cpu(0, cpu_32bit_el0_mask) == cpu_32bit)
 		return 0;
 
-	if (lucky_winner >= 0)
+	if (cpu_32bit_unofflineable < 0)
 		return 0;
 
 	/*
@@ -3619,16 +3619,20 @@ static int enable_mismatched_32bit_el0(unsigned int cpu)
 	 * 32-bit EL0 online so that is_cpu_allowed() doesn't end up rejecting
 	 * every CPU in the system for a 32-bit task.
 	 */
-	lucky_winner = cpu_32bit ? cpu : cpumask_any_and(cpu_32bit_el0_mask,
-							 cpu_active_mask);
-	get_cpu_device(lucky_winner)->offline_disabled = true;
+	cpu_32bit_unofflineable = cpu_32bit ? cpu : cpumask_any_and(cpu_32bit_el0_mask,
+								    cpu_active_mask);
 	setup_elf_hwcaps(compat_elf_hwcaps);
 	elf_hwcap_fixup();
 	pr_info("Asymmetric 32-bit EL0 support detected on CPU %u; CPU hot-unplug disabled on CPU %u\n",
-		cpu, lucky_winner);
+		cpu, cpu_32bit_unofflineable);
 	return 0;
 }
 
+static int mismatched_32bit_el0_offline(unsigned int cpu)
+{
+	return cpu == cpu_32bit_unofflineable ? -EBUSY : 0;
+}
+
 static int __init init_32bit_el0_mask(void)
 {
 	if (!allow_mismatched_32bit_el0)
@@ -3639,7 +3643,7 @@ static int __init init_32bit_el0_mask(void)
 
 	return cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
 				 "arm64/mismatched_32bit_el0:online",
-				 enable_mismatched_32bit_el0, NULL);
+				 mismatched_32bit_el0_online, mismatched_32bit_el0_offline);
 }
 subsys_initcall_sync(init_32bit_el0_mask);
 
-- 
2.46.0


