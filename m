Return-Path: <linux-kernel+bounces-399031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BB09BF9DA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 00:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 156101C21B12
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 23:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473AD20D4E9;
	Wed,  6 Nov 2024 23:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cvvh2Kh+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89D11DE2CD
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 23:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730935194; cv=none; b=rV/BEIr47HXCfBg+z6Qwm/2qqJehP1kUmqYsOizCljDpWNCQVnkLD3BD2VNsriYwFrJ52tG15AD4g07vW/7WQdHoDk7fH/33H+ZTRTRAUjErHw9ziOCG6heekJwE1rilhrZC8HxMtD31FSeY4ORNHHXeYh1f1SwH7XzmZY4CU4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730935194; c=relaxed/simple;
	bh=xa0JnPmZ/CyZNTM4J3xKzey4B7+1QOg2HfgQ0FKNFiE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NEDr6qloZ6VRW3RajXplmhjOTJfui7iOVHn0/SfSKddClHNHTsG0/ATPIYBKV10txglFsV6mdbX5SrWTQt0bmBhKp9o81U4Q9WKuLd7S1+WTZtqIMIPLuSrsbj+zWytxxx8MNJiAGofF7zpFkRxLWbdIW/JxtkdVILel1PTblt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cvvh2Kh+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C03C4CEC6;
	Wed,  6 Nov 2024 23:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730935194;
	bh=xa0JnPmZ/CyZNTM4J3xKzey4B7+1QOg2HfgQ0FKNFiE=;
	h=From:Date:Subject:To:Cc:From;
	b=cvvh2Kh+7g63DNA3sO+QbwCD86FZW5m2zE4w+q/GHfYwWiEDvIdSSckJgVFK+ycpd
	 mAcmCDMmbV9stDIaxueYLfeX+x1+dc/No+GmVB/otvZ67Gwew9DY6f7Wyslh5GfEyR
	 9aLx0au0Um1wvVW0qkBkiqFsn0g+lNirIYhCklNCDg2Y6qyP+xsMVOBJRULCEhbywJ
	 ddoFrE1XpHCGNqCQ4ILZeq2buDDZT51mb25s85ub1k4/B4FVqcQaSotbh8ajqR5751
	 ey7yVm21i6X7JjejoPpA5UqbG320LIGnBWLfLdwNWNbH8bs1ztckxtHBwAEDovYVpS
	 2T4iorAl8HJ0w==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 06 Nov 2024 23:18:23 +0000
Subject: [PATCH] arm64/fp: Don't corrupt FPMR when streaming mode changes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241106-arm64-fpmr-context-switch-v1-1-e6dbad4acd05@kernel.org>
X-B4-Tracking: v=1; b=H4sIAD75K2cC/x3MTQqEMAxA4atI1hNotf7gVYZZ1Bg1C6ukZRTEu
 1tcfov3LoiswhH64gLlv0TZQob9FECLDzOjjNlQmtJZaxr0ujYOp31VpC0kPhPGQxItWA+uI+t
 aqkYDud+VJznf9/d33w9C89hPawAAAA==
X-Change-ID: 20241106-arm64-fpmr-context-switch-5b48c147c3d0
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=1595; i=broonie@kernel.org;
 h=from:subject:message-id; bh=xa0JnPmZ/CyZNTM4J3xKzey4B7+1QOg2HfgQ0FKNFiE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnK/mXMlHYIabf/0jKlvAJv0pWizypnJT8W8eZIS9p
 g/ZIAgiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZyv5lwAKCRAk1otyXVSH0DZqB/
 9OJoVadk3tAZ9FcMjaQlY5N++mRnnc5OZM2FtP9digYoDTUQccC1WDyYoxjpAVEiqfY88V88tDGv0A
 it1hxnnacubY+Ah7a91E9fLF1XPxggH6EmpRKbdchAZTchLGmvhxTyDvcKHzqboASO45rXcZT3ls4W
 QM/wxa16v9dVEz2OiyGJYkvzbmuFPIUDNSW2m3LyMFd/YzQmRZc3/bAPgXnXGXTwORnkArEHfB3h9Q
 jD62XtbsZWOnZKdBNGQIXo4WrrCab/lAdGZ4IzBocBPAGuzJvwc1AFe/5tQZsc3Sp8TRdDwSgv+H4M
 Mk0gklXvhfEgLpuv3D2HgqSqfna467
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
index 77006df20a75aee7c991cf116b6d06bfe953d1a4..b26d93a444ce6cb2a0f1759240cb1fe88e7c76a0 100644
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

---
base-commit: 8e929cb546ee42c9a61d24fae60605e9e3192354
change-id: 20241106-arm64-fpmr-context-switch-5b48c147c3d0

Best regards,
-- 
Mark Brown <broonie@kernel.org>


