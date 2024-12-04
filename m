Return-Path: <linux-kernel+bounces-431498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCFF9E3E21
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC9A1281E24
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D3B20D50E;
	Wed,  4 Dec 2024 15:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2H5PksU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F8420C037
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 15:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733325756; cv=none; b=rxCukOFrKNg8nEHKtGEwywS0JK3lTKdWWkaUWR4k2aRO2gdEGDptZfrIFtNBHQtSbm6WfgHoM76aWsZ9xZS7clFP2AaDIMiSdpzwo0Wa7qxa4uM/VVDMkDPs9bKgxUkrCptvDIuvD1eejD4AxgG/QpjiSc29ALoHzmwm+2546Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733325756; c=relaxed/simple;
	bh=eI1tefeXL+TZyNSuc2hjvlfnxnuJuAFK0jlaMH14RBU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bw7CAZvo1gAVNn0qOYBfmuBkxuxgJX76CjPP3m9ofHNRhODHRoE90cRSfPTtXlaBXhqfSQqhIdPe54GZkI87m5JgA/Fvgclcb/XhvzV+PqSPyDn3jbklCEDNkh9iozzxvXtiW+hk9krFt5fXyARuK+Zt15Dgsy4WjlGb4aoqh6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2H5PksU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F690C4CEDF;
	Wed,  4 Dec 2024 15:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733325755;
	bh=eI1tefeXL+TZyNSuc2hjvlfnxnuJuAFK0jlaMH14RBU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=U2H5PksU7VxBODqWz2wkYH4LpAtnVsXX9z0m1U6UHr9xf3Mz60c2cwzBGe0OdEHeK
	 AiJpxyx8wCcVM+GNXBDa3APp0BX7UR6/spg0ulXp2kfOp8eBcGiqp4/zalFoj2ZmaN
	 uof4Fpe7ihF7CNTHN2HQx5NjZLF5VlSsclah/ASRl9I3L9K2cMVHxcGLvnMG28HAUH
	 eb5FyM+2ylC9RY5vOnX/TWOtO8ixxCK+Urj0xrcl4/qaEhQw1iqZIGhVqIgyzOEpzR
	 rRzc8vXhVFhss/etgemsRrn1Y26AG3j5GMFNecPlJj2D+JUWAzILrV11+L/IjLJDTd
	 C7thHSskPOXQw==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 04 Dec 2024 15:20:54 +0000
Subject: [PATCH v2 6/6] arm64/signal: Consistently invalidate the in
 register FP state in restore
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241204-arm64-sme-reenable-v2-6-bae87728251d@kernel.org>
References: <20241204-arm64-sme-reenable-v2-0-bae87728251d@kernel.org>
In-Reply-To: <20241204-arm64-sme-reenable-v2-0-bae87728251d@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Dave Martin <Dave.Martin@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=7574; i=broonie@kernel.org;
 h=from:subject:message-id; bh=eI1tefeXL+TZyNSuc2hjvlfnxnuJuAFK0jlaMH14RBU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnUHOsbe0GDhU62lb7UKSWwAgaI1b1a8VR3tzw/dfD
 1mu3GAGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ1BzrAAKCRAk1otyXVSH0KOCB/
 4p5VAQLLhXOeFnoHp6R0itwyVFkGH1spAboKblwKdR8i+wqsNaLIfICVhZ54UQPw9jtYPjjsrh9Ea0
 sw9jRxJVbGL4BAy/5Msu9vVYaLkHZxOHLSCJA0eQcUIRTslxqGe6W6JpOXliPSNmckmbRgUIzv5f/h
 G/u6atg61wUf3tSb7goYClKr1P18RjSPc18DXBPJu0SLbv7O40nmjB44MYbkrlbkT6sSLpX2qciaL8
 E/ALIsLrT5CpzQVsGxYn5KC+F64l9hr5B/2JPX0QIK3TM+iOG87JsOgcMyMXAtVT7CDOCjYHnHidmk
 NrfcXRH9OO26RGKlEzPPQWNigcd/O/
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

When restoring the SVE and SME specific floating point register states we
flush the task floating point state, marking the hardware state as stale so
that preemption does not result in us saving register state from the signal
handler on top of the restored context and forcing a reload from memory.
For the plain FPSIMD state we don't do this, we just copy the state from
userspace and then force an immediate reload of the register state.
This isn't racy against context switch since we copy the incoming data
onto the stack rather than directly into the task struct but it's still
messy and inconsistent.

Simplify things and avoid a potential source of error by moving the
invalidation of the CPU state to the main restore_sigframe() and
reworking the restore of the FPSIMD state to update the task struct and
rely on loading as part of the general do_notify_resume() handling for
return to user like we do for the SVE and SME state.

As a result of this the only user of fpsimd_update_current_state() is
the 32 bit signal code which should not have any SVE state, add an
assert there that we don't have SVE enabled.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/fpsimd.c |  9 +++---
 arch/arm64/kernel/signal.c | 70 +++++++++++++++-------------------------------
 2 files changed, 27 insertions(+), 52 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 2b045d4d8f71ace5bf01a596dda279285a0998a5..74080204073d06819838873996b8cb60043d89de 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1868,7 +1868,8 @@ void fpsimd_update_current_state(struct user_fpsimd_state const *state)
 	get_cpu_fpsimd_context();
 
 	current->thread.uw.fpsimd_state = *state;
-	if (test_thread_flag(TIF_SVE))
+	/* This should only ever be used for 32 bit processes */
+	if (WARN_ON_ONCE(test_thread_flag(TIF_SVE)))
 		fpsimd_to_sve(current);
 
 	task_fpsimd_load();
@@ -1894,9 +1895,9 @@ void fpsimd_flush_task_state(struct task_struct *t)
 {
 	t->thread.fpsimd_cpu = NR_CPUS;
 	/*
-	 * If we don't support fpsimd, bail out after we have
-	 * reset the fpsimd_cpu for this task and clear the
-	 * FPSTATE.
+	 * If we don't support fpsimd, bail out after we have reset
+	 * the fpsimd_cpu for this task and clear the FPSTATE.  We
+	 * check here rather than forcing callers to check.
 	 */
 	if (!system_supports_fpsimd())
 		return;
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 79c9c5cd0802149b3cde20b398617437d79181f2..335c2327baf74eac9634cf594855dbf26a7d6b01 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -271,7 +271,7 @@ static int preserve_fpsimd_context(struct fpsimd_context __user *ctx)
 
 static int restore_fpsimd_context(struct user_ctxs *user)
 {
-	struct user_fpsimd_state fpsimd;
+	struct user_fpsimd_state *fpsimd = &current->thread.uw.fpsimd_state;
 	int err = 0;
 
 	/* check the size information */
@@ -279,18 +279,14 @@ static int restore_fpsimd_context(struct user_ctxs *user)
 		return -EINVAL;
 
 	/* copy the FP and status/control registers */
-	err = __copy_from_user(fpsimd.vregs, &(user->fpsimd->vregs),
-			       sizeof(fpsimd.vregs));
-	__get_user_error(fpsimd.fpsr, &(user->fpsimd->fpsr), err);
-	__get_user_error(fpsimd.fpcr, &(user->fpsimd->fpcr), err);
+	err = __copy_from_user(fpsimd->vregs, &(user->fpsimd->vregs),
+			       sizeof(fpsimd->vregs));
+	__get_user_error(fpsimd->fpsr, &(user->fpsimd->fpsr), err);
+	__get_user_error(fpsimd->fpcr, &(user->fpsimd->fpcr), err);
 
 	clear_thread_flag(TIF_SVE);
 	current->thread.fp_type = FP_STATE_FPSIMD;
 
-	/* load the hardware registers from the fpsimd_state structure */
-	if (!err)
-		fpsimd_update_current_state(&fpsimd);
-
 	return err ? -EFAULT : 0;
 }
 
@@ -396,7 +392,7 @@ static int restore_sve_fpsimd_context(struct user_ctxs *user)
 {
 	int err = 0;
 	unsigned int vl, vq;
-	struct user_fpsimd_state fpsimd;
+	struct user_fpsimd_state *fpsimd = &current->thread.uw.fpsimd_state;
 	u16 user_vl, flags;
 
 	if (user->sve_size < sizeof(*user->sve))
@@ -439,16 +435,6 @@ static int restore_sve_fpsimd_context(struct user_ctxs *user)
 	if (user->sve_size < SVE_SIG_CONTEXT_SIZE(vq))
 		return -EINVAL;
 
-	/*
-	 * Careful: we are about __copy_from_user() directly into
-	 * thread.sve_state with preemption enabled, so protection is
-	 * needed to prevent a racing context switch from writing stale
-	 * registers back over the new data.
-	 */
-
-	fpsimd_flush_task_state(current);
-	/* From now, fpsimd_thread_switch() won't touch thread.sve_state */
-
 	sve_alloc(current, true);
 	if (!current->thread.sve_state) {
 		clear_thread_flag(TIF_SVE);
@@ -471,14 +457,10 @@ static int restore_sve_fpsimd_context(struct user_ctxs *user)
 fpsimd_only:
 	/* copy the FP and status/control registers */
 	/* restore_sigframe() already checked that user->fpsimd != NULL. */
-	err = __copy_from_user(fpsimd.vregs, user->fpsimd->vregs,
-			       sizeof(fpsimd.vregs));
-	__get_user_error(fpsimd.fpsr, &user->fpsimd->fpsr, err);
-	__get_user_error(fpsimd.fpcr, &user->fpsimd->fpcr, err);
-
-	/* load the hardware registers from the fpsimd_state structure */
-	if (!err)
-		fpsimd_update_current_state(&fpsimd);
+	err = __copy_from_user(fpsimd->vregs, user->fpsimd->vregs,
+			       sizeof(fpsimd->vregs));
+	__get_user_error(fpsimd->fpsr, &user->fpsimd->fpsr, err);
+	__get_user_error(fpsimd->fpcr, &user->fpsimd->fpcr, err);
 
 	return err ? -EFAULT : 0;
 }
@@ -587,16 +569,6 @@ static int restore_za_context(struct user_ctxs *user)
 	if (user->za_size < ZA_SIG_CONTEXT_SIZE(vq))
 		return -EINVAL;
 
-	/*
-	 * Careful: we are about __copy_from_user() directly into
-	 * thread.sme_state with preemption enabled, so protection is
-	 * needed to prevent a racing context switch from writing stale
-	 * registers back over the new data.
-	 */
-
-	fpsimd_flush_task_state(current);
-	/* From now, fpsimd_thread_switch() won't touch thread.sve_state */
-
 	sme_alloc(current, true);
 	if (!current->thread.sme_state) {
 		current->thread.svcr &= ~SVCR_ZA_MASK;
@@ -664,16 +636,6 @@ static int restore_zt_context(struct user_ctxs *user)
 	if (nregs != 1)
 		return -EINVAL;
 
-	/*
-	 * Careful: we are about __copy_from_user() directly into
-	 * thread.zt_state with preemption enabled, so protection is
-	 * needed to prevent a racing context switch from writing stale
-	 * registers back over the new data.
-	 */
-
-	fpsimd_flush_task_state(current);
-	/* From now, fpsimd_thread_switch() won't touch ZT in thread state */
-
 	err = __copy_from_user(thread_zt_state(&current->thread),
 			       (char __user const *)user->zt +
 					ZT_SIG_REGS_OFFSET,
@@ -1028,6 +990,18 @@ static int restore_sigframe(struct pt_regs *regs,
 	if (err == 0)
 		err = parse_user_sigframe(&user, sf);
 
+	/*
+	 * Careful: we are about __copy_from_user() directly into
+	 * thread floating point state with preemption enabled, so
+	 * protection is needed to prevent a racing context switch
+	 * from writing stale registers back over the new data. Mark
+	 * the register floating point state as invalid and unbind the
+	 * task from the CPU to force a reload before we return to
+	 * userspace. fpsimd_flush_task_state() has a check for FP
+	 * support.
+	 */
+	fpsimd_flush_task_state(current);
+
 	if (err == 0 && system_supports_fpsimd()) {
 		if (!user.fpsimd)
 			return -EINVAL;

-- 
2.39.5


