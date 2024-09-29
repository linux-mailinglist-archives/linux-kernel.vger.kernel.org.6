Return-Path: <linux-kernel+bounces-342831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D21989367
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 09:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 097D72816C6
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 07:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9DC13A41F;
	Sun, 29 Sep 2024 07:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjZGxv6P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C0B2B9BB
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 07:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727594210; cv=none; b=Opdwc0HQ3pd/SGnqWnQyc7QtgrrByIA4ej7uMm6rXf6ZQHOGJ+opm7eojkn4OfLvk7GHCw1q1uSVLcjh+MvBryfM/znxtoKw9JwcGXaPTliqPJ3nY9+m4cMmnYW1jmJTU1YkUMCFYeax6OXi46gaIXhevEnQ/bi6F9ayVnUNtOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727594210; c=relaxed/simple;
	bh=ZYdYzEStCBBmKJFpl270gXKBj5EN0y9Cpun2+SiImbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition; b=E+U3cZWyxMjE0QrmzDkt4+UmQqz02SwxMM3O7/xve5/l0yYIKXKcwx/Ei9WR/5yW6HYeWuGx2las77SgdBC5nApOcdjYNpoQsZfcu1ZWDqGdGFtaOVnEDRBwHt69dR9v7lIzTpuIM9HokSruE6u79WgsJJXFjukF8YopGhgtEzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjZGxv6P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8C3EC4CEC7;
	Sun, 29 Sep 2024 07:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727594210;
	bh=ZYdYzEStCBBmKJFpl270gXKBj5EN0y9Cpun2+SiImbY=;
	h=Date:From:To:Cc:Subject:References:From;
	b=CjZGxv6PSfH9PRe2YZoOmYSQ0QNrzy4c2BajQP1Y31VTZMzEQ8cgZblmzpOg+vqMb
	 gpApR1n/vjl7jlrpwIQvNZlGBbfIvij7IjKf2Sp3AXjyjDizdRP9M0GfCbHqtbATWc
	 kJkJRvQQCgGveOKSRG350KgLb2D963T3nqCf55j/KFQGnIK1QzZihcCLv0RQnMjl5/
	 TwyHSGrMorbteu97OIFVwKgWL2XwbvM2FkPhoC3wnFhvGeEHVdrV9/YKo798pWP/HK
	 xXR6cQhfRH/NEWOEX+uOyUaA489qhPlmvyLI9l+A7L/5kfdCecU3heQam69c+eVlxo
	 hdhJaZ1LR7exQ==
Date: Sun, 29 Sep 2024 09:16:30 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [GIT PULL] x86 fixes
Message-ID: <Zvj-zvhfI81nB2s5@gmail.com>
References: <Zm1NIOnj0NR3U8om@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest x86/urgent Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2024-09-29

   # HEAD: d1fb034b75a8a96fcb4bf01a7c0e1421eef833a3 x86/cpu: Add two Intel CPU model numbers

Fix TDX MMIO #VE fault handling, and add two new Intel model numbers
for "Pantherlake" and "Diamond Rapids".

 Thanks,

	Ingo

------------------>
Alexey Gladkov (Intel) (1):
      x86/tdx: Fix "in-kernel MMIO" check

Tony Luck (1):
      x86/cpu: Add two Intel CPU model numbers


 arch/x86/coco/tdx/tdx.c             | 6 ++++++
 arch/x86/include/asm/intel-family.h | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index da8b66dce0da..327c45c5013f 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -16,6 +16,7 @@
 #include <asm/insn-eval.h>
 #include <asm/pgtable.h>
 #include <asm/set_memory.h>
+#include <asm/traps.h>
 
 /* MMIO direction */
 #define EPT_READ	0
@@ -433,6 +434,11 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 			return -EINVAL;
 	}
 
+	if (!fault_in_kernel_space(ve->gla)) {
+		WARN_ONCE(1, "Access to userspace address is not supported");
+		return -EINVAL;
+	}
+
 	/*
 	 * Reject EPT violation #VEs that split pages.
 	 *
diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index f81a851c46dc..17d899da4650 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -191,6 +191,8 @@
 #define INTEL_FAM6_LUNARLAKE_M		0xBD
 #define INTEL_LUNARLAKE_M		IFM(6, 0xBD)
 
+#define INTEL_PANTHERLAKE_L		IFM(6, 0xCC)
+
 /* "Small Core" Processors (Atom/E-Core) */
 
 #define INTEL_FAM6_ATOM_BONNELL		0x1C /* Diamondville, Pineview */
@@ -257,4 +259,7 @@
 #define INTEL_FAM5_QUARK_X1000		0x09 /* Quark X1000 SoC */
 #define INTEL_QUARK_X1000		IFM(5, 0x09) /* Quark X1000 SoC */
 
+/* Family 19 */
+#define INTEL_PANTHERCOVE_X		IFM(19, 0x01) /* Diamond Rapids */
+
 #endif /* _ASM_X86_INTEL_FAMILY_H */

