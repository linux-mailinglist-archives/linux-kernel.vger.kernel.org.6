Return-Path: <linux-kernel+bounces-414206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B77C9D24B5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 12:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50CD8283531
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 11:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C422D1C68BE;
	Tue, 19 Nov 2024 11:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NhYSuQqs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F091C4A18
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 11:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732015300; cv=none; b=jg4TT2PB8yla6PgN5JGkNniWSbAXsklJ6UfSse3JwITj4w7BAOTxphqUfgG/vSqQYCeuzmGzgt9dp5/Ukg6ZbCTtRicEWXczZGTRTLwZpKevOCDhOfRayIGpMr+1iBNuAtKd52OzTJSqErZT7kLO/xdWszUXfsTt65ZGlAIvQdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732015300; c=relaxed/simple;
	bh=+gTimwg+pDYm36w0G+MzGiFoZmx6xYCclJH9gmKwKdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QB6kK9ZwZVGeMypDKRmS/JjSkNDyUPPyAwOmo/gtYog6ZKCYJE8gt4cciSUXM0304ihaFknxDAx2ZKE31DYBiUlpB5HFqTgNf2YzCowj1kMHh2Zt5QfHOCr3zSCFYOnkbwwYtPUV9yrtU0AxDBHtenFqmN/mGeg/SevxqglST/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NhYSuQqs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65BD6C4CED2;
	Tue, 19 Nov 2024 11:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732015299;
	bh=+gTimwg+pDYm36w0G+MzGiFoZmx6xYCclJH9gmKwKdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NhYSuQqsfMi5wRpgeA9oeouvX1sb7/EH8kXVI7DGyZcGe8mWwzsSI724Bx22PmAYh
	 /pqaQUstMyE4BYbUA6bYvNV8YtfpqSVa78zGfVRBQR63I3hTEldgTcUor5fIchUs4j
	 eHIzsIS0qygWHn3vG+FgYhZl49WtPdOU4uTRW0nDVaciWI245/4FEZLje8TbwVTQyQ
	 ervlSaqx+9pai8B3vKqXkpyrA5J6e9UWMmwBRcs6BKYUumEnzi7YdjSfKy2W6cFbpJ
	 Er9OIsVAVXQikKWKN0sXNFKSbSWevnXWU0yzt62gyMo1MvTs9rulhLWtO8dTQ/FXVX
	 nCJojlxTtKl+Q==
From: Borislav Petkov <bp@kernel.org>
To: X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Thomas De Schampheleire <thomas.de_schampheleire@nokia.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	stable@kernel.org
Subject: [PATCH 2/2] x86/microcode/AMD: Flush patch buffer mapping after application
Date: Tue, 19 Nov 2024 12:21:33 +0100
Message-ID: <20241119112133.20552-2-bp@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241119112133.20552-1-bp@kernel.org>
References: <ZyulbYuvrkshfsd2@antipodes>
 <20241119112133.20552-1-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Due to specific requirements while applying microcode patches on Zen1
and 2, the patch buffer mapping needs to be flushed from the TLB after
application. Do so.

If not, unncesessary and unnatural delays happen in the boot process.

Reported-by: Thomas De Schampheleire <thomas.de_schampheleire@nokia.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Thomas De Schampheleire <thomas.de_schampheleire@nokia.com>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/r/ZyulbYuvrkshfsd2@antipodes
---
 arch/x86/kernel/cpu/microcode/amd.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 31a73715d755..fb5d0c67fbab 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -34,6 +34,7 @@
 #include <asm/setup.h>
 #include <asm/cpu.h>
 #include <asm/msr.h>
+#include <asm/tlb.h>
 
 #include "internal.h"
 
@@ -483,11 +484,25 @@ static void scan_containers(u8 *ucode, size_t size, struct cont_desc *desc)
 	}
 }
 
-static int __apply_microcode_amd(struct microcode_amd *mc)
+static int __apply_microcode_amd(struct microcode_amd *mc, unsigned int psize)
 {
+	unsigned long p_addr = (unsigned long)&mc->hdr.data_code;
 	u32 rev, dummy;
 
-	native_wrmsrl(MSR_AMD64_PATCH_LOADER, (u64)(long)&mc->hdr.data_code);
+	native_wrmsrl(MSR_AMD64_PATCH_LOADER, p_addr);
+
+	if (x86_family(bsp_cpuid_1_eax) == 0x17) {
+		unsigned long p_addr_end = p_addr + psize - 1;
+
+		invlpg(p_addr);
+
+		/*
+		 * Flush next page too if patch image is crossing a page
+		 * boundary.
+		 */
+		if (p_addr >> PAGE_SHIFT != p_addr_end >> PAGE_SHIFT)
+			invlpg(p_addr_end);
+	}
 
 	/* verify patch application was successful */
 	native_rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
@@ -529,7 +544,7 @@ static bool early_apply_microcode(u32 old_rev, void *ucode, size_t size)
 	if (old_rev > mc->hdr.patch_id)
 		return ret;
 
-	return !__apply_microcode_amd(mc);
+	return !__apply_microcode_amd(mc, desc.psize);
 }
 
 static bool get_builtin_microcode(struct cpio_data *cp)
@@ -745,7 +760,7 @@ void reload_ucode_amd(unsigned int cpu)
 	rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
 
 	if (rev < mc->hdr.patch_id) {
-		if (!__apply_microcode_amd(mc))
+		if (!__apply_microcode_amd(mc, p->size))
 			pr_info_once("reload revision: 0x%08x\n", mc->hdr.patch_id);
 	}
 }
@@ -798,7 +813,7 @@ static enum ucode_state apply_microcode_amd(int cpu)
 		goto out;
 	}
 
-	if (__apply_microcode_amd(mc_amd)) {
+	if (__apply_microcode_amd(mc_amd, p->size)) {
 		pr_err("CPU%d: update failed for patch_level=0x%08x\n",
 			cpu, mc_amd->hdr.patch_id);
 		return UCODE_ERROR;
-- 
2.43.0


