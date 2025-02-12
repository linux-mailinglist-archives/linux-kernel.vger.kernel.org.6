Return-Path: <linux-kernel+bounces-510268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3544A31A83
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 01:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3E6C3A6E8B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 00:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5D6B665;
	Wed, 12 Feb 2025 00:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KPyjScDS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890C98489
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 00:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739320249; cv=none; b=hVis2komaMe6K+niP3B71tW3a0u848xxTHiX9A+GmWrOgOULHmdPrZRSEaIetOjovF4Y9cz58++Zl3AaWo09S5rS0594Zrgew3x05KevMaRQ5yaNbyU+zVYiiUwt09cdlU9B6ZAxP3CB4fU/VO0OySU4FlJrfj3QTasfWwdSldE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739320249; c=relaxed/simple;
	bh=NJ/KIhRbLqKKRZOIuLEK+yaV4RpOOTdBF4uFF/FtH8c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mMz365xVgouiLWKxeAdSttOF75fGr3n3yTZu0GWPpfvxG4RYibO/oQ0gN/aYwEXhJjaX59EfQVUPuex+gRf/A8sxwJDhqbEEyP/fGEBqzQi7XDxsJCj3uIZDESJzesn6DO/xS/FsbIxvUXk8eojtj8jGQpi7JRQ/uSoulSU2CSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KPyjScDS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCA3FC4CEDD;
	Wed, 12 Feb 2025 00:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739320249;
	bh=NJ/KIhRbLqKKRZOIuLEK+yaV4RpOOTdBF4uFF/FtH8c=;
	h=From:Date:Subject:To:Cc:From;
	b=KPyjScDSvbFkYyWQdp+eI6YuMaJZIqR+icltgr/z63FhS1M13Dj2AM5zF3rUWyoT5
	 OG2BcP0tc2yCG9jCnsGvqdzDtmbYvv0zba+DK7Z4vNjKOru8kaX/7T4b+SfSg8cKuJ
	 Ig5O5na0GUIwcKGDeIbmEw4xIMzvv6Wgza7WdbSdjWtAUYul2i5kpRnZHRmIRBmGf6
	 AoUBNQstEt3ll4OBmdvSc/2J8bHy/1MxhxOchFQk1bVZvMJJWSe8w2aIMxSsHYuVJT
	 PYO4DU2VzgJG7QOf/LLscisq86NSDHBTI04W1awbBKjdignPABR3tyn+7nO0lqtVM9
	 fi2/lp0fjKWyA==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 12 Feb 2025 00:30:42 +0000
Subject: [PATCH v2] arm64: Add missing registrations of hwcaps
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-arm64-fix-2024-dpisa-v2-1-67a1c11d6001@kernel.org>
X-B4-Tracking: v=1; b=H4sIALHrq2cC/22NwQ6CMBBEf4Xs2TVtoW3w5H8YDhUW2KiUbA3RE
 P7dSjx6fJOZNyskEqYEp2IFoYUTxymDORTQjmEaCLnLDEYZq4zyGOThKuz5hTmqsJs5BXSlDbZ
 22qm6hTydhXJj116azCOnZ5T3/rLob/oTavVfuGjU2HnfV2Xrr8aW5xvJRPdjlAGabds+2dEcd
 bkAAAA=
X-Change-ID: 20250207-arm64-fix-2024-dpisa-635a5961609c
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=openpgp-sha256; l=2294; i=broonie@kernel.org;
 h=from:subject:message-id; bh=NJ/KIhRbLqKKRZOIuLEK+yaV4RpOOTdBF4uFF/FtH8c=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnq+u2MYEJMHcoB61+KLJFvAOZqDPmOsElNgJ/zTde
 0HBaoVCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ6vrtgAKCRAk1otyXVSH0I6UB/
 4jM3gyMSYvWY6GmGz4t2iIx+eAB7faBazfS2nutpETqdnRqubc7jOuPrAwJdHCxUpNg9QckoXCSsZI
 ZDNCSayXq++pwEhxVpBxjHLyzisAgiKvu2d70uxc7fM2Qw5kwUKon9EjfogJ3oCjLOaMK8HEnH6nbz
 XxF3gZCn2TMkendPIq0bexYYTbb35YOnrn3YOIaNX8O7PthY/f9iOQQykUkpNzgZ0Yb9H38pggCSFI
 16eS5p0D4EFQ1kVV28DJVjvmG79JqmCl8XUhBU3aUOrjRcHUX6MIDp0jW2Ar2hdr/Hj/nGycGk+dNm
 +wquF9ny8qGqAFWd+JLXDk+YyfM7zE
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Commit 819935464cb2 ("arm64/hwcap: Describe 2024 dpISA extensions to
userspace") added definitions for HWCAP_FPRCVT, HWCAP_F8MM8 and
HWCAP_F8MM4 but did not include the crucial registration in
arm64_elf_hwcaps.  Add it.

Fixes: 819935464cb2 ("arm64/hwcap: Describe 2024 dpISA extensions to userspace")
Reported-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v2:
- Add FPRCVT.
- Link to v1: https://lore.kernel.org/r/20250210-arm64-fix-2024-dpisa-v1-1-d77f43c7b253@kernel.org
---
 arch/arm64/kernel/cpufeature.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index f0910f20fbf8c18fbeb63bcee18abf13371b1d5e..d561cf3b8ac7b11784282dc889852ef52a7b8f6e 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -3091,6 +3091,7 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_CAP(ID_AA64ISAR0_EL1, TS, FLAGM, CAP_HWCAP, KERNEL_HWCAP_FLAGM),
 	HWCAP_CAP(ID_AA64ISAR0_EL1, TS, FLAGM2, CAP_HWCAP, KERNEL_HWCAP_FLAGM2),
 	HWCAP_CAP(ID_AA64ISAR0_EL1, RNDR, IMP, CAP_HWCAP, KERNEL_HWCAP_RNG),
+	HWCAP_CAP(ID_AA64ISAR3_EL1, FPRCVT, IMP, CAP_HWCAP, KERNEL_HWCAP_FPRCVT),
 	HWCAP_CAP(ID_AA64PFR0_EL1, FP, IMP, CAP_HWCAP, KERNEL_HWCAP_FP),
 	HWCAP_CAP(ID_AA64PFR0_EL1, FP, FP16, CAP_HWCAP, KERNEL_HWCAP_FPHP),
 	HWCAP_CAP(ID_AA64PFR0_EL1, AdvSIMD, IMP, CAP_HWCAP, KERNEL_HWCAP_ASIMD),
@@ -3190,6 +3191,8 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_CAP(ID_AA64FPFR0_EL1, F8FMA, IMP, CAP_HWCAP, KERNEL_HWCAP_F8FMA),
 	HWCAP_CAP(ID_AA64FPFR0_EL1, F8DP4, IMP, CAP_HWCAP, KERNEL_HWCAP_F8DP4),
 	HWCAP_CAP(ID_AA64FPFR0_EL1, F8DP2, IMP, CAP_HWCAP, KERNEL_HWCAP_F8DP2),
+	HWCAP_CAP(ID_AA64FPFR0_EL1, F8MM8, IMP, CAP_HWCAP, KERNEL_HWCAP_F8MM8),
+	HWCAP_CAP(ID_AA64FPFR0_EL1, F8MM4, IMP, CAP_HWCAP, KERNEL_HWCAP_F8MM4),
 	HWCAP_CAP(ID_AA64FPFR0_EL1, F8E4M3, IMP, CAP_HWCAP, KERNEL_HWCAP_F8E4M3),
 	HWCAP_CAP(ID_AA64FPFR0_EL1, F8E5M2, IMP, CAP_HWCAP, KERNEL_HWCAP_F8E5M2),
 #ifdef CONFIG_ARM64_POE

---
base-commit: 21fed7c223e20e694b91dbf25936d922a50c8b19
change-id: 20250207-arm64-fix-2024-dpisa-635a5961609c

Best regards,
-- 
Mark Brown <broonie@kernel.org>


