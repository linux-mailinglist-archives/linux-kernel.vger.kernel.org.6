Return-Path: <linux-kernel+bounces-267578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB811941309
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 15:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF58B1C23283
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 13:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C311A00F1;
	Tue, 30 Jul 2024 13:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGUXq1iz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5C218FC6E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 13:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722345732; cv=none; b=kbBZVXNH+VHlABRHH0hIYUGJUn305Hglc0CI6SMHV+nGOrUOg05i+pEOGrI769WF5H0oL0XhiaTv4olyjOnaJzD8I7+mt0/Dg6MGMIdAyIWAals499LisG6p0Lp8vM5EcZ4yOsqYfnb/J+4gGk8KyKUwTC4Wrs7VweagVvA4r4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722345732; c=relaxed/simple;
	bh=W7lJY3bzOABRqvUWM6KFYTlVCpB5MdMRNVXQKOMosnE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZUOfF6RhSjvRaFwX2xa75v0GJUsmRpvmmVIKd4TxAit71rQ6iivsQLl2r4kTJT8stuiMCpYnMwfNiNFxBdB1Z2TsBBeDaET2nQcgZ1/wWbXJXMO1RNUM9gLkRWmuqx6p6ozh+awhMW3mKoq9OSdO+Zib1bEgvwhgcHsNLShkirM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGUXq1iz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC4FC4AF0E;
	Tue, 30 Jul 2024 13:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722345732;
	bh=W7lJY3bzOABRqvUWM6KFYTlVCpB5MdMRNVXQKOMosnE=;
	h=From:Date:Subject:To:Cc:From;
	b=XGUXq1izI3s8JRbbK48O5vw33lrnrJH8GPYCwHYzpinng3U4XI4NIisUr2kJoIGzl
	 X7ccRSGCfZostXWMqyw5W7WC8EJsFbL1fPI46dh5XPbypQfsUjsmAA02bpXt8ioONh
	 2brHlMY4OUeosKSzAfYDWQ/zxkUobyqhVNR6ZRBR/0xiGeuOOMYoqM+PEJTZRjbgZt
	 FgqNBmMna8WmL6a+gDMdbOdBAlDuxdRRoRwgG2ocIiPolxOhfuysrG57nb+ozK+krN
	 3/I8lOQRjk04RtxiUlwFL4XR5a0zDddNmT+5RJHKFVzxK+a7fhI52piatHOczIbdKb
	 MtpwMU++33oWg==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 30 Jul 2024 14:15:55 +0100
Subject: [PATCH v2] arm64/fpsimd: Ensure we don't contend a SMCU from
 idling CPUs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240730-arm64-sme-no-cpuidle-v2-1-497d3177a6b9@kernel.org>
X-B4-Tracking: v=1; b=H4sIAIrnqGYC/22NwQ6CMBBEf4Xs2TW0klI9+R+GAykLbISWbLXRE
 P7dSuLNzOlNMm9WiCRMES7FCkKJIwefQR8KcGPrB0LuMoMudVUaVWMrs6kwzoQ+oFue3E2E1hl
 LvTV0qkvI00Wo59euvTWZR46PIO/9Jalv+xPa/8KkMKcjW2tS5qz6653E03QMMkCzbdsH8mK40
 LkAAAA=
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=3946; i=broonie@kernel.org;
 h=from:subject:message-id; bh=W7lJY3bzOABRqvUWM6KFYTlVCpB5MdMRNVXQKOMosnE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmqOkBa0goL5wZI8Cvc3DG0UVlpOHllEY5e9Xu4ZOC
 hAsFqm2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZqjpAQAKCRAk1otyXVSH0B/vB/
 9vC3B5MHyGB+TIz+QaSvJ0o1FpYcciyZ0nED2mC/yVIIwkpbcMkn+HcfVhQXPsXH/QQKOUR6qjWZyp
 reiRp5D0R5KCGraEm0Ydj9OEj9PhVLVCq1DBB6GdAawliSRNi5O6Ek004s688IG5fZXhk6sHcjtMFr
 6S9tekQOBLGu8THpZQNrgjfrtNN44mjO466ILPK1PHrgktKTV6HdZDnGVTft13uWIOuyuuwBSO4gma
 EHLz2Bi6aJOpKRqf5X6j8QY86RMmH0haDZ46INLfzqfLtiTaQ3g99hO//LmiINlzhn0/RkW2FjCfo8
 EJY7Zoz+gDIC19VuVxBmFcd3/z2ZnJ
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

When we enter the kernel we currently don't update any of the floating
point register state until either something else uses floating point or we
get a CPU_PM_ENTER notification during suspend or cpuidle. This means that
for a system which has been configured with both suspend and cpuidle
disabled we will leave whatever floating point state was loaded in the
registers present while a CPU is idling.

For SME this may cause an idling CPU to interfere with the operation of
other CPUs, SME may be implemented as a SMCU shared with between multiple
CPUs. Leaving ZA or especially streaming mode enabled may be taken by
the hardware as an indication that SME is active use by the CPU and cause
resources to be allocated to it at the expense of other CPUs.

Since we exit streaming mode on entering syscalls we are unlikely to be
idling the CPU in streaming mode due to a blocking syscall, most likely
it will be a task being scheduled to a different CPU or potentially
fault handling.  The former will result in the loaded state being
invalidated, the latter is a slow path anyway.  For ZA we do allow it to
be enabled during syscalls so we could see a blocking syscall for that,
although the strong recommendation is that it be disabled as much as
possible so it should also be an uncommon case.

Add an arch_cpu_idle_enter() implementation which disables SME if it is
active when we idle the CPU, ensuring that we don't create any spurious
contention even if cpuidle is not enabled.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v2:
- Rebase onto v6.11-rc1.
- Tweak commit message.
- Link to v1: https://lore.kernel.org/r/20240618-arm64-sme-no-cpuidle-v1-1-1de872e1691f@kernel.org
---
 arch/arm64/include/asm/fpsimd.h |  2 ++
 arch/arm64/kernel/fpsimd.c      | 14 ++++++++++++++
 arch/arm64/kernel/process.c     |  5 +++++
 3 files changed, 21 insertions(+)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index bc69ac368d73..e1453a1d261d 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -82,6 +82,8 @@ extern void fpsimd_restore_current_state(void);
 extern void fpsimd_update_current_state(struct user_fpsimd_state const *state);
 extern void fpsimd_kvm_prepare(void);
 
+extern void fpsimd_idle_enter(void);
+
 struct cpu_fp_state {
 	struct user_fpsimd_state *st;
 	void *sve_state;
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 77006df20a75..d9596a7d8676 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -2126,6 +2126,20 @@ static void __init fpsimd_pm_init(void)
 static inline void fpsimd_pm_init(void) { }
 #endif /* CONFIG_CPU_PM */
 
+void fpsimd_idle_enter(void)
+{
+	/*
+	 * Leaving SME enabled may leave this core contending with
+	 * other cores if we have a SMCU, disable whenever we enter
+	 * idle to avoid this.  Only do this if they're actually
+	 * enabled to avoid overhead in cases where we don't enter a
+	 * low enough power state to loose register state.
+	 */
+	if (system_supports_sme() &&
+	    (read_sysreg_s(SYS_SVCR) & (SVCR_SM_MASK | SVCR_ZA_MASK)))
+		fpsimd_save_and_flush_cpu_state();
+}
+
 #ifdef CONFIG_HOTPLUG_CPU
 static int fpsimd_cpu_dead(unsigned int cpu)
 {
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 4ae31b7af6c3..fd616882cd49 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -68,6 +68,11 @@ EXPORT_SYMBOL(__stack_chk_guard);
 void (*pm_power_off)(void);
 EXPORT_SYMBOL_GPL(pm_power_off);
 
+void arch_cpu_idle_enter(void)
+{
+       fpsimd_idle_enter();
+}
+
 #ifdef CONFIG_HOTPLUG_CPU
 void __noreturn arch_cpu_idle_dead(void)
 {

---
base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
change-id: 20240617-arm64-sme-no-cpuidle-8c68ef86e370

Best regards,
-- 
Mark Brown <broonie@kernel.org>


