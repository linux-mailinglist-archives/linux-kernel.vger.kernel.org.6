Return-Path: <linux-kernel+bounces-379767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DDD9AE371
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 13:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AD621C21D2B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 11:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E241C9ECD;
	Thu, 24 Oct 2024 11:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqNmRswk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9C51B3944
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 11:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729768072; cv=none; b=pwVLTzlqgJbBRLwqhFee4T72aWNWVmMw4CC8YR2McVyA06Ngg/O64bFigPDZW5kkRmn2sQSFbOdCf7M+Tve900vG7lF+02o28j9K38qWUN4SMwqPXBnm+gCzw4loLRO2T3HYOhVW7b3ykFptSbSPkc5QooSmUWEWsWraQwHjU1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729768072; c=relaxed/simple;
	bh=3u4MB5fzt4B4URpnmS1cFnecFjFi0U4J8+oHzjRXNFc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oxsXRhffdJnWY2T+o2QRVfVAnVzMXnrzN+FkRGcwrXMuBAwPAdpdC3TezckJz2tQalWPf/6j7oZsMeWGhaCzjpyQKDPSG+R0qvuzZNyymeonGMkbw1Y+c25Y3nOi8JO3tdc+fJMD7E+tMm4jUIZV83YFB9OIeLruLXLprMOU6tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqNmRswk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98707C4CEC7;
	Thu, 24 Oct 2024 11:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729768072;
	bh=3u4MB5fzt4B4URpnmS1cFnecFjFi0U4J8+oHzjRXNFc=;
	h=From:Date:Subject:To:Cc:From;
	b=cqNmRswks3sQEtF9sXALrcrZ8xOPReinoA9Jl/lcbNSxGECx5gJ5hmCNQ7HYCHawW
	 gXz0oJ7rmrKm+sP0HGor9TOMT5iigGaVbMsIk5lN5lbdTBCBt/2ORk3vxZFAcg88Se
	 +v4/3oOUdpjT05Hn0vJWxAwEA4yeuQGN1BCAfPXAJDGXvyjM04aRe10/RywsccbDEV
	 qkxCZVlIrnoQQGaL1z8HiBVLrdOKwhQmGFSCYdOzWTUZN8LwNgA7y4lcOvkKaNfu5Q
	 NTXpod3T9SC4A8jT0LygRmI0CbT3IP/a2dhT1Hlhl2IgZ+kbx1IFMGbZ/2Y53l+RA/
	 G3Eh2/KnZM08g==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 24 Oct 2024 12:06:42 +0100
Subject: [PATCH] arm64/signal: Consistently invalidate the in register FP
 state in restore
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241024-arm64-fp-sig-flush-v1-1-05148eb92a84@kernel.org>
X-B4-Tracking: v=1; b=H4sIAEIqGmcC/x3MTQqAIBBA4avErBtIs6CuEi1MRxvoD4ciiO6et
 PwW7z0glJgE+uKBRBcL71uGKgtws90iIfts0JU2qtI12rS2BsOBwhHDcsqMZJR3nWvsRB3k8Eg
 U+P6nw/i+H+pSWTBkAAAA
X-Change-ID: 20241023-arm64-fp-sig-flush-e41dc9c5abe9
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Dave Martin <Dave.Martin@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=6416; i=broonie@kernel.org;
 h=from:subject:message-id; bh=3u4MB5fzt4B4URpnmS1cFnecFjFi0U4J8+oHzjRXNFc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnGiqFEOxzTMkfhPBnTWTIFQZyU/t2zA4Qi1/mdz4D
 kSuonjGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZxoqhQAKCRAk1otyXVSH0JL3B/
 0Z9vAnd4lxDbFQQWjIPda2uhIWErXyDn5gl+tMeU8RnUgU1AqsmGYG8DHcTO/TUNhgkD3d0yYWpm0v
 j95tQP4R3MtezAEW7LreC2XSh9svhyTBjNHByXAcJ6tmqY9RJckOsXlobvvDpGtmbcPzkCBPRQzdk3
 SmLG/Gj7W9k9BanzEg0q71PN/jToajUy4I7hvfxN0o4rbh9nBF6ddOQmIH/5XFrm5EJjMzfpL2BfCI
 ame4rVqvNvBclRnC2NU8hJcSMhT6q1hoGYGIOxSqI+nzsjsCFkhBKfPJoMepge9xpttwlifNCeFsr3
 Qpio13QGlRSSLN1I0pehGGL9OsVB/v
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

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/signal.c | 70 +++++++++++++++-------------------------------
 1 file changed, 22 insertions(+), 48 deletions(-)

diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 5619869475304776fc005fe24a385bf86bfdd253..a536d65b1f11957fa0f84094df542175d050e00a 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -210,7 +210,7 @@ static int preserve_fpsimd_context(struct fpsimd_context __user *ctx)
 
 static int restore_fpsimd_context(struct user_ctxs *user)
 {
-	struct user_fpsimd_state fpsimd;
+	struct user_fpsimd_state *fpsimd = &current->thread.uw.fpsimd_state;
 	int err = 0;
 
 	/* check the size information */
@@ -218,18 +218,14 @@ static int restore_fpsimd_context(struct user_ctxs *user)
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
 
@@ -333,7 +329,7 @@ static int restore_sve_fpsimd_context(struct user_ctxs *user)
 {
 	int err = 0;
 	unsigned int vl, vq;
-	struct user_fpsimd_state fpsimd;
+	struct user_fpsimd_state *fpsimd = &current->thread.uw.fpsimd_state;
 	u16 user_vl, flags;
 
 	if (user->sve_size < sizeof(*user->sve))
@@ -376,16 +372,6 @@ static int restore_sve_fpsimd_context(struct user_ctxs *user)
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
@@ -408,14 +394,10 @@ static int restore_sve_fpsimd_context(struct user_ctxs *user)
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
@@ -524,16 +506,6 @@ static int restore_za_context(struct user_ctxs *user)
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
@@ -601,16 +573,6 @@ static int restore_zt_context(struct user_ctxs *user)
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
@@ -876,6 +838,18 @@ static int restore_sigframe(struct pt_regs *regs,
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

---
base-commit: 8e929cb546ee42c9a61d24fae60605e9e3192354
change-id: 20241023-arm64-fp-sig-flush-e41dc9c5abe9

Best regards,
-- 
Mark Brown <broonie@kernel.org>


