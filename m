Return-Path: <linux-kernel+bounces-524987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B0DA3E977
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 01:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E94C4251A2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 00:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DF81DDC1B;
	Fri, 21 Feb 2025 00:54:17 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C749770821
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 00:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740099255; cv=none; b=CTLIhsWbgFlVEE4rrJCFyIT1If2YzT5G7x1F5W5Tu9pcpzDisXX6+orlZwiLMVkOF+hP/L51s0a1H4y1t+0k0CFdIHqMXfP66cHIHSUprkImicqpGBmkvA6zy5o/W3g6XeZWViJHgDavfVtX1r31NATb/Qiyt8S0w0/+DrTpDCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740099255; c=relaxed/simple;
	bh=7Ur973CKetMBn5zmhRv0qT9We1mdtC41rXMQOT5O3Nk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q70URFERh88+PvArL+WQ3MKFXfwO1chhoq9dbuQaVV4U20s/B1U8NlK8UtxL/kYjrYmcZd/l0IXnZXFoNTo8Kjn/imoEFXFD8m7coCfoqBCkJMScdkIvY+WLDBedW+jspJPwegWEcZLm8jYC0i8jstbWCzgBHuO5iB/vv7K89ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tlHIZ-000000003Qf-1z6G;
	Thu, 20 Feb 2025 19:53:47 -0500
From: Rik van Riel <riel@surriel.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	bp@alien8.de,
	peterz@infradead.org,
	dave.hansen@linux.intel.com,
	zhengqi.arch@bytedance.com,
	nadav.amit@gmail.com,
	thomas.lendacky@amd.com,
	kernel-team@meta.com,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	jackmanb@google.com,
	jannh@google.com,
	mhklinux@outlook.com,
	andrew.cooper3@citrix.com,
	Manali.Shukla@amd.com,
	Rik van Riel <riel@surriel.com>
Subject: [PATCH v12 14/16] x86/mm: enable AMD translation cache extensions
Date: Thu, 20 Feb 2025 19:53:13 -0500
Message-ID: <20250221005345.2156760-15-riel@surriel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250221005345.2156760-1-riel@surriel.com>
References: <20250221005345.2156760-1-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: riel@surriel.com

With AMD TCE (translation cache extensions) only the intermediate mappings
that cover the address range zapped by INVLPG / INVLPGB get invalidated,
rather than all intermediate mappings getting zapped at every TLB invalidation.

This can help reduce the TLB miss rate, by keeping more intermediate
mappings in the cache.

From the AMD manual:

Translation Cache Extension (TCE) Bit. Bit 15, read/write. Setting this bit
to 1 changes how the INVLPG, INVLPGB, and INVPCID instructions operate on
TLB entries. When this bit is 0, these instructions remove the target PTE
from the TLB as well as all upper-level table entries that are cached
in the TLB, whether or not they are associated with the target PTE.
When this bit is set, these instructions will remove the target PTE and
only those upper-level entries that lead to the target PTE in
the page table hierarchy, leaving unrelated upper-level entries intact.

Signed-off-by: Rik van Riel <riel@surriel.com>
Tested-by: Manali Shukla <Manali.Shukla@amd.com>
Tested-by: Brendan Jackman <jackmanb@google.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
---
 arch/x86/include/asm/msr-index.h       | 2 ++
 arch/x86/kernel/cpu/amd.c              | 4 ++++
 tools/arch/x86/include/asm/msr-index.h | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 9a71880eec07..a7ea9720ba3c 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -25,6 +25,7 @@
 #define _EFER_SVME		12 /* Enable virtualization */
 #define _EFER_LMSLE		13 /* Long Mode Segment Limit Enable */
 #define _EFER_FFXSR		14 /* Enable Fast FXSAVE/FXRSTOR */
+#define _EFER_TCE		15 /* Enable Translation Cache Extensions */
 #define _EFER_AUTOIBRS		21 /* Enable Automatic IBRS */
 
 #define EFER_SCE		(1<<_EFER_SCE)
@@ -34,6 +35,7 @@
 #define EFER_SVME		(1<<_EFER_SVME)
 #define EFER_LMSLE		(1<<_EFER_LMSLE)
 #define EFER_FFXSR		(1<<_EFER_FFXSR)
+#define EFER_TCE		(1<<_EFER_TCE)
 #define EFER_AUTOIBRS		(1<<_EFER_AUTOIBRS)
 
 /*
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 54194f5995de..b9b67d44c279 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1073,6 +1073,10 @@ static void init_amd(struct cpuinfo_x86 *c)
 
 	/* AMD CPUs don't need fencing after x2APIC/TSC_DEADLINE MSR writes. */
 	clear_cpu_cap(c, X86_FEATURE_APIC_MSRS_FENCE);
+
+	/* Enable Translation Cache Extension */
+	if (cpu_feature_enabled(X86_FEATURE_TCE))
+		msr_set_bit(MSR_EFER, _EFER_TCE);
 }
 
 #ifdef CONFIG_X86_32
diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index 3ae84c3b8e6d..dc1c1057f26e 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -25,6 +25,7 @@
 #define _EFER_SVME		12 /* Enable virtualization */
 #define _EFER_LMSLE		13 /* Long Mode Segment Limit Enable */
 #define _EFER_FFXSR		14 /* Enable Fast FXSAVE/FXRSTOR */
+#define _EFER_TCE		15 /* Enable Translation Cache Extensions */
 #define _EFER_AUTOIBRS		21 /* Enable Automatic IBRS */
 
 #define EFER_SCE		(1<<_EFER_SCE)
@@ -34,6 +35,7 @@
 #define EFER_SVME		(1<<_EFER_SVME)
 #define EFER_LMSLE		(1<<_EFER_LMSLE)
 #define EFER_FFXSR		(1<<_EFER_FFXSR)
+#define EFER_TCE		(1<<_EFER_TCE)
 #define EFER_AUTOIBRS		(1<<_EFER_AUTOIBRS)
 
 /*
-- 
2.47.1


