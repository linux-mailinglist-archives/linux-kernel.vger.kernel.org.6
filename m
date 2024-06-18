Return-Path: <linux-kernel+bounces-219523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8756B90D4B0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E571AB28D1D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A75154420;
	Tue, 18 Jun 2024 13:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bUpWukeJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0275153837
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 13:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719163; cv=none; b=rTiaNAdW11+j4SXKScJzyTJkBVFS/x+5HqJ3C3RrUrhR+3n3EEDenh1GCnxou+NhAoZG+hUJ2sZG4eHpzWJ7hG09LlbIKY205huy6929T/x0x0qtdaOIPDMH020gYTNKsJ/bC87I0+Fn4YQ8nVAUr98CGxB6BnC0Mz8kAZ3F1+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719163; c=relaxed/simple;
	bh=yFqQs9J5f3hKHooWIJesv4Gl/Jx8cGiryXHB4+vtKtM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=t3ML3oLUnV4e+HXs/Z0k2DTVj663tR+UL60dGN78901jH+yFEP3i7i30UAIKT/cQaMAW4tCdZENhgqKBv5bVZe/0OgW5TIonV+i6udd9dHZQkKCFIOckMEQPuSPBfPXGGCTauJ8h/Kj9oQCtiT07WCJ+M7GfTgkyfhGyGtv+KmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bUpWukeJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB63C4AF49;
	Tue, 18 Jun 2024 13:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718719162;
	bh=yFqQs9J5f3hKHooWIJesv4Gl/Jx8cGiryXHB4+vtKtM=;
	h=From:Date:Subject:To:Cc:From;
	b=bUpWukeJFa30OXgp7ZJXsq1RCryTVMBKowfY7oBgBnRCCZVnOmx6fwXz142VoZNCD
	 cnOpdyWftNb9YBObHfbpRwHL6Zep0sMed5iyNYSFcwT+CQ7tX6uwG9N2wfSnSlLK+c
	 EvGu0qRreeX78n+N44+ajFFRYv629uCZ4Fz2fx0PXjLqzzDJNyuImFugH4ED+pshn+
	 H3wZy71PPaAJSz9YtM/dSJRVU12VNRP7/RlqOxoIfYC6K5kpW6flZL/KeWE5wjRyc5
	 W5rZHimAOzqDoaiuHRlSPoz72tLIOn7hpw7VSzZW/dAVhzNwy4UyXk5WMeQpgUGxeS
	 NxYgOGRk37VSA==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 18 Jun 2024 14:57:42 +0100
Subject: [PATCH] arm64/fpsimd: Ensure we don't contend a SMCU from idling
 CPUs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240618-arm64-sme-no-cpuidle-v1-1-1de872e1691f@kernel.org>
X-B4-Tracking: v=1; b=H4sIAFWScWYC/x3MSwqAIBRG4a3EHXfBHpi0lWgg9lsXykIpgmjvS
 cNvcM5DCVGQqC8eirgkyR4yqrIgt9gwg2XKplrVrdJVxzZuuuW0gcPO7jhlWsHGaQNvNJpOUU6
 PCC/3vx3G9/0AlbqJt2YAAAA=
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.14-dev-d4707
X-Developer-Signature: v=1; a=openpgp-sha256; l=3224; i=broonie@kernel.org;
 h=from:subject:message-id; bh=yFqQs9J5f3hKHooWIJesv4Gl/Jx8cGiryXHB4+vtKtM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmcZK4Slm0rZd9/kE6PWh72D0/61Db7oZv1qHT3/Yl
 JpdUpn6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZnGSuAAKCRAk1otyXVSH0AHeB/
 4hHcpVXVpe5QmBcScbuyD5pbhHT0554FSXu9hTjZemlDfYYxg59lqedNGaFzWilJgJbS64QVgPEUS2
 GE5Vy9JLQ+zZMzfSL0H3Z27nbbyPg8dHlJTxlmp3wBh7f+LTTORZb6287zXy+tcRjbg0tMWhCSgukP
 BHWZ09TzFfxxG7h5UUExQKk7cuohFhrCkveQibStRm4ifKrHkbKY5FtfwczW8VqNupPR8C+TQmzHPC
 JY7n0q7R9Ol1TgDQDj4lvPTzcdaSWe58Y7d75uGI9gJdc+KKOtleGwg8tdFPMIL2838zaVolnDVbTK
 M9s4jQ9inQXtZlOv4u/bvBhYeY2MJ5
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

Add an arch_cpu_idle_enter() implementation which disables SME if it is
active when we idle the CPU, ensuring that we don't create any spurious
contention even if cpuidle is not enabled.

Signed-off-by: Mark Brown <broonie@kernel.org>
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
index 82e8a6017382..400eaad374a2 100644
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
base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
change-id: 20240617-arm64-sme-no-cpuidle-8c68ef86e370

Best regards,
-- 
Mark Brown <broonie@kernel.org>


