Return-Path: <linux-kernel+bounces-429485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE069E1CBC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF2BA168786
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFAA1F1307;
	Tue,  3 Dec 2024 12:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uECPxY2y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1FF1F12FC
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 12:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733230092; cv=none; b=Dnx+xS8T6SZiwPQ1AIBsls3D1wOEZgw1NI50Bzdo2pXhrylbislMNATcbDVPkSnNSYhnClvDc7uhwjHOoVukIRAUoGUKgV98lkiZGuotM+qiMiM9Q01ic9TH0X8QdueepqlSvYFacAP+ZT7bZ8OklAaRDDOJmIn9x2tyxM3rKVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733230092; c=relaxed/simple;
	bh=fwkQ2FXE6pq57Zq+2np3KAdjth1F3BAf6kMutQobcPY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qcz8dL5CN4/DvMHqNDRip7voaAfKVMtZ/tCCQqwVrCzzgCg15sGJV8SLUZutIi7kvEnNCu4ohZH7xZw74qMUlawo6dMJcXN9SXBEYUMp8FuLQmW42GZFoEaBxrBq35z3p3puurHBrq5QVWPa9EIqn0i3URN1onzy1OOlgjMc5W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uECPxY2y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA78C4CECF;
	Tue,  3 Dec 2024 12:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733230091;
	bh=fwkQ2FXE6pq57Zq+2np3KAdjth1F3BAf6kMutQobcPY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uECPxY2yGDTQ96vqDI8oz8ZKkSYDhsE6FOJ+q/2wjZ0pJYpkWoqI7JXoWxmMjv1No
	 JPlnGyw/i4S5l/2DcfSALiOluwqInss7WhO5yjyPxjE0jmLKsYQvADY2/hIOOBHlmz
	 APAh7elCXYNs02IQQ7PiJDb1zWUEuBlegj+isdtZaV4S1GJf0RcVYU3nzSb4EAQkW2
	 Hj+1RSVRGVrtwlCfYWhD414y4jo7uI2qJZ+7v90KOjbisEg+XPh8BEl61ZYtQKZJRs
	 cnZegheuib6DkJdL0WR4cfk5IaplQYsaQjMKXONdbJSECGF8N5zvkRxSkHeMHyPy42
	 yS07ous1B5OQQ==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 03 Dec 2024 12:45:54 +0000
Subject: [PATCH 2/6] arm64/fp: Don't corrupt FPMR when streaming mode
 changes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-arm64-sme-reenable-v1-2-d853479d1b77@kernel.org>
References: <20241203-arm64-sme-reenable-v1-0-d853479d1b77@kernel.org>
In-Reply-To: <20241203-arm64-sme-reenable-v1-0-d853479d1b77@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=1433; i=broonie@kernel.org;
 h=from:subject:message-id; bh=fwkQ2FXE6pq57Zq+2np3KAdjth1F3BAf6kMutQobcPY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnTv4BcA+HNfWUMV0jBjkRtcw5Z8TgIMYMn0+FMt8+
 8FdSoVaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ07+AQAKCRAk1otyXVSH0KOMB/
 9c2BmpHnuajRU9qKEBELWI4QXCe3SSVNuHwY74LKEBjrA8LN2EW6J9MdYUqtSC91exM3H18GcOdtPf
 kSEYFZADm3h48TsP4aXgofFDty7s/LK/SmV9pGvmEGxzFgsLAlmFvM9PuPmPTrGNIocxNGN85Exhn1
 h9Z9VYduy9XzB91sdEGxS6cL3DwT1C4dIiqZyLfGErJx1FIYFmK1FFkFWjHmx+KKOTQDE2GDiSw1uC
 GPJgu5V3/TalyHuLYZF110vLpLWVYuhreG2JnasDGX8SMuXx9R7nh6i12CDNyDIVzmR297d6IR0880
 VkFbiwNqxJlS8lBoTT8NQ5eahcD7cl
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

When we enter or exit streaming more FPMR is reset to 0.  This means
that when restoring the floating point state from memory we need to
restore FPMR after we restore SVCR, otherwise if we are entering or
exiting streaming mode as part of loading the new state the value of
FPMR will be corrupted.

Fixes: 203f2b95a882 ("arm64/fpsimd: Support FEAT_FPMR")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/fpsimd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index eca0b6a2fc6fa25d8c850a5b9e109b4d58809f54..a3bb17c88942eba031d26e9f75ad46f37b6dc621 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -359,9 +359,6 @@ static void task_fpsimd_load(void)
 	WARN_ON(preemptible());
 	WARN_ON(test_thread_flag(TIF_KERNEL_FPSTATE));
 
-	if (system_supports_fpmr())
-		write_sysreg_s(current->thread.uw.fpmr, SYS_FPMR);
-
 	if (system_supports_sve() || system_supports_sme()) {
 		switch (current->thread.fp_type) {
 		case FP_STATE_FPSIMD:
@@ -413,6 +410,9 @@ static void task_fpsimd_load(void)
 			restore_ffr = system_supports_fa64();
 	}
 
+	if (system_supports_fpmr())
+		write_sysreg_s(current->thread.uw.fpmr, SYS_FPMR);
+
 	if (restore_sve_regs) {
 		WARN_ON_ONCE(current->thread.fp_type != FP_STATE_SVE);
 		sve_load_state(sve_pffr(&current->thread),

-- 
2.39.5


