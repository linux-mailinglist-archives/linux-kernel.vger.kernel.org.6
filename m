Return-Path: <linux-kernel+bounces-540840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DB8A4B5AC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 01:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 866F63AE908
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 00:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F79678F40;
	Mon,  3 Mar 2025 00:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RgZ3dpBx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D90478F26
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 00:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740963130; cv=none; b=RasYizKw72xGCZIbidDMaUTYN8qUwEsEv3RNVWui8ilvIey3+8FAyl+TJZi4F2oKzB2wVOg0CsP92osZB13fEAxba7hflXIp1PfVy/u59Cxmn71Y7sulmFaXhHVIgGrHAE28BAtD9ieuWO7BwF63BP6S71te1WJSjzwCdAyc6Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740963130; c=relaxed/simple;
	bh=67Myc9vHnFLpNDtsgMsjmTqZdSwRKVnxSgxvxX2NNdA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BqDAQkAjCOaorIkZxJTyux9/1LyswTbFAlbaQjm+OhlH/AL2AMAZrLP/EZFQYVLDvRmc6H7AwQ45L/QLV1SBwO6HeW7GJ++QJJmB9LJ80SurV842xyEfYHq5778jVPq8tu6LLal+J0uT02neNTGoIbpg3XXqNZ6ur0V1QJtTTPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RgZ3dpBx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C055C4CED6;
	Mon,  3 Mar 2025 00:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740963129;
	bh=67Myc9vHnFLpNDtsgMsjmTqZdSwRKVnxSgxvxX2NNdA=;
	h=From:To:Cc:Subject:Date:From;
	b=RgZ3dpBxIPl86j4sAWFSmcmpueS++fGR/1ZS45Jyk50yulGm6zlENcmwtmVPE+Krv
	 PDH6B/0Hmp8GJl4uMrd7/P4YJmnXsyPDx6g9Oq8G31qj6sSxo1euCIX7stVklnw849
	 fUkH0GJZUJx0r3CdGixRN7G6G3CgvcCpiXeVzDDodHULDxu+JrzUX6A/EE2+I88UVd
	 4RJ/sFJXkmIRc5+d5frEPHzzvH8TYruI2JGxTkLcVttxWz55FhyqkO0Vv4YjZzx62Q
	 fj2i3nJ/WrZ/tJwaVNQVUoAQKOXBE9UUnVivJVgZwYykAzpCSQLAMw/+Pwd7R7rigG
	 1a4vMBaCeTIiw==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-kernel@vger.kernel.org,
	Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH] x86/smp: Fix mwait_play_dead() and acpi_processor_ffh_play_dead() noreturn behavior
Date: Sun,  2 Mar 2025 16:48:51 -0800
Message-ID: <e885c6fa9e96a61471b33e48c2162d28b15b14c5.1740962711.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix some related issues (done in a single patch to avoid introducing
intermediate bisect warnings):

  1) The SMP version of mwait_play_dead() doesn't return, but its
     !SMP counterpart does.  Make its calling behavior consistent by
     resolving the !SMP version to a BUG().  It should never be called
     anyway, this just enforces that at runtime and enables its callers
     to be marked as __noreturn.

  2) While the SMP definition of mwait_play_dead() is annotated as
     __noreturn, the declaration isn't.  Nor is it listed in
     tools/objtool/noreturns.h.  Fix that.

  3) Similar to #1, the SMP version of acpi_processor_ffh_play_dead()
     doesn't return but its !SMP counterpart does.  Make the !SMP
     version a BUG().  It should never be called.

  4) acpi_processor_ffh_play_dead() doesn't return, but is lacking any
     __noreturn annotations.  Fix that.

This fixes the following warnings:

  vmlinux.o: warning: objtool: acpi_processor_ffh_play_dead+0x67: mwait_play_dead() is missing a __noreturn annotation
  vmlinux.o: warning: objtool: acpi_idle_play_dead+0x3c: acpi_processor_ffh_play_dead() is missing a __noreturn annotation

Fixes: a7dd183f0b38 ("x86/smp: Allow calling mwait_play_dead with an arbitrary hint")
Fixes: 541ddf31e300 ("ACPI/processor_idle: Add FFH state handling")
Reported-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/include/asm/smp.h    | 4 ++--
 arch/x86/kernel/acpi/cstate.c | 2 +-
 include/acpi/processor.h      | 6 +++---
 tools/objtool/noreturns.h     | 2 ++
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 80f8bfd83fc7..1d3b11eba084 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -114,7 +114,7 @@ void wbinvd_on_cpu(int cpu);
 int wbinvd_on_all_cpus(void);
 
 void smp_kick_mwait_play_dead(void);
-void mwait_play_dead(unsigned int eax_hint);
+void __noreturn mwait_play_dead(unsigned int eax_hint);
 
 void native_smp_send_reschedule(int cpu);
 void native_send_call_func_ipi(const struct cpumask *mask);
@@ -166,7 +166,7 @@ static inline struct cpumask *cpu_llc_shared_mask(int cpu)
 	return (struct cpumask *)cpumask_of(0);
 }
 
-static inline void mwait_play_dead(unsigned int eax_hint) { }
+static inline void __noreturn mwait_play_dead(unsigned int eax_hint) { BUG(); }
 #endif /* CONFIG_SMP */
 
 #ifdef CONFIG_DEBUG_NMI_SELFTEST
diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
index 86c87c01d23d..d25584255ab8 100644
--- a/arch/x86/kernel/acpi/cstate.c
+++ b/arch/x86/kernel/acpi/cstate.c
@@ -206,7 +206,7 @@ int acpi_processor_ffh_cstate_probe(unsigned int cpu,
 }
 EXPORT_SYMBOL_GPL(acpi_processor_ffh_cstate_probe);
 
-void acpi_processor_ffh_play_dead(struct acpi_processor_cx *cx)
+void __noreturn acpi_processor_ffh_play_dead(struct acpi_processor_cx *cx)
 {
 	unsigned int cpu = smp_processor_id();
 	struct cstate_entry *percpu_entry;
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 63a37e72b721..d0eccbd920e5 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -280,7 +280,7 @@ int acpi_processor_ffh_cstate_probe(unsigned int cpu,
 				    struct acpi_processor_cx *cx,
 				    struct acpi_power_register *reg);
 void acpi_processor_ffh_cstate_enter(struct acpi_processor_cx *cstate);
-void acpi_processor_ffh_play_dead(struct acpi_processor_cx *cx);
+void __noreturn acpi_processor_ffh_play_dead(struct acpi_processor_cx *cx);
 #else
 static inline void acpi_processor_power_init_bm_check(struct
 						      acpi_processor_flags
@@ -301,9 +301,9 @@ static inline void acpi_processor_ffh_cstate_enter(struct acpi_processor_cx
 {
 	return;
 }
-static inline void acpi_processor_ffh_play_dead(struct acpi_processor_cx *cx)
+static inline void __noreturn acpi_processor_ffh_play_dead(struct acpi_processor_cx *cx)
 {
-	return;
+	BUG();
 }
 #endif
 
diff --git a/tools/objtool/noreturns.h b/tools/objtool/noreturns.h
index b2174894f9f7..5a4aec4c4639 100644
--- a/tools/objtool/noreturns.h
+++ b/tools/objtool/noreturns.h
@@ -16,6 +16,7 @@ NORETURN(__tdx_hypercall_failed)
 NORETURN(__ubsan_handle_builtin_unreachable)
 NORETURN(__x64_sys_exit)
 NORETURN(__x64_sys_exit_group)
+NORETURN(acpi_processor_ffh_play_dead)
 NORETURN(arch_cpu_idle_dead)
 NORETURN(bch2_trans_in_restart_error)
 NORETURN(bch2_trans_restart_error)
@@ -34,6 +35,7 @@ NORETURN(kunit_try_catch_throw)
 NORETURN(machine_real_restart)
 NORETURN(make_task_dead)
 NORETURN(mpt_halt_firmware)
+NORETURN(mwait_play_dead)
 NORETURN(nmi_panic_self_stop)
 NORETURN(panic)
 NORETURN(panic_smp_self_stop)
-- 
2.48.1


