Return-Path: <linux-kernel+bounces-213022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF509069F1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 12:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C89F0284CC2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AB41428EA;
	Thu, 13 Jun 2024 10:27:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7341428E0
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 10:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718274446; cv=none; b=EZerKai8G9n0a+qyoIRvrj53XBkC9zC0s+pU5wgXy5imcky04iH6myHFxTkolfnBYx5zNKOCXCTYOsSrHnscXXb+D5lj4F0ptTLUMWnt9zPBWL/7ENrhzBLRSdf+vCR/Fo4KNQPgIHJVdKmAmREkr0HZ9O8Ij7cEtxewn/O57o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718274446; c=relaxed/simple;
	bh=dTKmwEKAj9gD/2+0/9oNTSzv1cgKOsCjl/Z5hSuHaqU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MfgMlDC6VSrkGispulCr00/LoMGAMfvPyjKbLT8CGFVO4fTXSxnRm7uxUxH56nt/m8ob3VwX3B2Y9MSLggWYhoWUZQ9iEmG2rAryK1NHRRrezoWjFM38hO/fVIZ0sZfVNOChpseZedjhpzljPsdh1B1ODRLjrDJwe4Yjw//EJr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F1AE1063;
	Thu, 13 Jun 2024 03:27:49 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.44.128])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E8B033F5A1;
	Thu, 13 Jun 2024 03:27:20 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: mark.rutland@arm.com,
	ryan.roberts@arm.com,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/2] KVM: arm64: Replace custom macros with fields from ID_AA64PFR0_EL1
Date: Thu, 13 Jun 2024 15:57:09 +0530
Message-Id: <20240613102710.3295108-2-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240613102710.3295108-1-anshuman.khandual@arm.com>
References: <20240613102710.3295108-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This replaces custom macros usage (i.e ID_AA64PFR0_EL1_ELx_64BIT_ONLY and
ID_AA64PFR0_EL1_ELx_32BIT_64BIT) and instead directly uses register fields
from ID_AA64PFR0_EL1 sysreg definition.

Cc: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: kvmarm@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/kvm/hyp/include/nvhe/fixed_config.h | 10 +++++-----
 arch/arm64/kvm/hyp/nvhe/pkvm.c                 |  4 ++--
 arch/arm64/kvm/hyp/nvhe/sys_regs.c             |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/fixed_config.h b/arch/arm64/kvm/hyp/include/nvhe/fixed_config.h
index 51f043649146..f957890c7e38 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/fixed_config.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/fixed_config.h
@@ -52,11 +52,11 @@
  *	Supported by KVM
  */
 #define PVM_ID_AA64PFR0_RESTRICT_UNSIGNED (\
-	FIELD_PREP(ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_EL0), ID_AA64PFR0_EL1_ELx_64BIT_ONLY) | \
-	FIELD_PREP(ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_EL1), ID_AA64PFR0_EL1_ELx_64BIT_ONLY) | \
-	FIELD_PREP(ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_EL2), ID_AA64PFR0_EL1_ELx_64BIT_ONLY) | \
-	FIELD_PREP(ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_EL3), ID_AA64PFR0_EL1_ELx_64BIT_ONLY) | \
-	FIELD_PREP(ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_RAS), ID_AA64PFR0_EL1_RAS_IMP) \
+	SYS_FIELD_PREP_ENUM(ID_AA64PFR0_EL1, EL0, IMP) | \
+	SYS_FIELD_PREP_ENUM(ID_AA64PFR0_EL1, EL1, IMP) | \
+	SYS_FIELD_PREP_ENUM(ID_AA64PFR0_EL1, EL2, IMP) | \
+	SYS_FIELD_PREP_ENUM(ID_AA64PFR0_EL1, EL3, IMP) | \
+	SYS_FIELD_PREP_ENUM(ID_AA64PFR0_EL1, RAS, IMP) \
 	)
 
 /*
diff --git a/arch/arm64/kvm/hyp/nvhe/pkvm.c b/arch/arm64/kvm/hyp/nvhe/pkvm.c
index 26dd9a20ad6e..58da2fec89b2 100644
--- a/arch/arm64/kvm/hyp/nvhe/pkvm.c
+++ b/arch/arm64/kvm/hyp/nvhe/pkvm.c
@@ -31,9 +31,9 @@ static void pvm_init_traps_aa64pfr0(struct kvm_vcpu *vcpu)
 
 	/* Protected KVM does not support AArch32 guests. */
 	BUILD_BUG_ON(FIELD_GET(ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_EL0),
-		PVM_ID_AA64PFR0_RESTRICT_UNSIGNED) != ID_AA64PFR0_EL1_ELx_64BIT_ONLY);
+		PVM_ID_AA64PFR0_RESTRICT_UNSIGNED) != ID_AA64PFR0_EL1_EL0_IMP);
 	BUILD_BUG_ON(FIELD_GET(ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_EL1),
-		PVM_ID_AA64PFR0_RESTRICT_UNSIGNED) != ID_AA64PFR0_EL1_ELx_64BIT_ONLY);
+		PVM_ID_AA64PFR0_RESTRICT_UNSIGNED) != ID_AA64PFR0_EL1_EL1_IMP);
 
 	/*
 	 * Linux guests assume support for floating-point and Advanced SIMD. Do
diff --git a/arch/arm64/kvm/hyp/nvhe/sys_regs.c b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
index edd969a1f36b..2860548d4250 100644
--- a/arch/arm64/kvm/hyp/nvhe/sys_regs.c
+++ b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
@@ -276,7 +276,7 @@ static bool pvm_access_id_aarch32(struct kvm_vcpu *vcpu,
 	 * of AArch32 feature id registers.
 	 */
 	BUILD_BUG_ON(FIELD_GET(ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_EL1),
-		     PVM_ID_AA64PFR0_RESTRICT_UNSIGNED) > ID_AA64PFR0_EL1_ELx_64BIT_ONLY);
+		     PVM_ID_AA64PFR0_RESTRICT_UNSIGNED) > ID_AA64PFR0_EL1_EL1_IMP);
 
 	return pvm_access_raz_wi(vcpu, p, r);
 }
-- 
2.30.2


