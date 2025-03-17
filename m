Return-Path: <linux-kernel+bounces-565127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56EB9A66164
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 23:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFE6442007B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 22:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C6A205AC2;
	Mon, 17 Mar 2025 22:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOpF6Xxw"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D71B204F99
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 22:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742249932; cv=none; b=DUFbtIAnJQAzEI6vILyvWchTL8Dt7CXZ9jtK2wmtZ2rSLO60CgzyyBViuVGRhNqraUCKM8ctRkD0XJdM6AAmTqEKzyfY2UZlstv54WgvaD7CjmsnzvNQfcB4ywewqH53yaTTpLRyrBIXqxS2bPLokWPG6rtcEe+2owjtYDLMcQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742249932; c=relaxed/simple;
	bh=21hyvfAgw0UCXSu4Bb7SLxAPr3QZnlntthYvDyrDKoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s+s2N6uQPM94RWVvGUh/m4nXp/+AEydqLACQPdx7Ddp72+2Gc58dYtikSp9tTvvnyCHPgSOJQQivpg0IuiXY7PbJ015kyfsXYFVchIiFVB8THz0j9WkpTDKfgJrZzYJHRobGKJ1CtBbfIAx6vKCqqDpCAfpx/yvdDe1yA6kSTzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aOpF6Xxw; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac339f53df9so326268066b.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 15:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742249929; x=1742854729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FGTDbMbl7rJNc1xMOaRIKrwNGnAZ9yjWyI/0GLpPStk=;
        b=aOpF6Xxwf0ZoCg8iZpSi6UtMNUaEdkehNUEk3s+C1q2oNWE6VFEFcFDwP3qCFpgTBg
         Y7O/QH3eZ3tPjp4TM/I6vQYlqGv9Q4xSu6x57Kb4chI6p4iDHLIGW9CpFJCxd1/047PV
         OgJbsnOH2RyeobHPKmXnyRkxEliaHmhkrWnqMprrLHbrhgWInsgzzFiKm50XprEN6FNF
         DHPLWA+qgsxlnXDiICrui6yBF9Y5zwWoBh/YeCnm6AGdPbz6eCG18IFGWAEOPfYWw1x1
         reI8LVQZy5tDNCMbkVmkqhAcGTcgVk1R1GIc4WI1RDpf/q/fWosfD69vK5XiZknYa7Rl
         +9mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742249929; x=1742854729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FGTDbMbl7rJNc1xMOaRIKrwNGnAZ9yjWyI/0GLpPStk=;
        b=SVdoxhIxRkGPB4aJocYz9QaW82WbVtNIegoqj05qAF3JxA70Z3aivUUshoE6g37GHP
         IDLYViil4z6f8L1vBRDinr0v9mybN2esT7Vl76PBbHwomOnkm/0HR/M99cCLB/TOtBN8
         Uwx3kZDylMTXgWuUjsZsJMTQ8GcgY/KHIeesW2xwU5XtDuzOEu2KwoXQn79noAmQJdk4
         Oc5dIlVi9/pvwG50WQYanY+VMwtOoujf/K5LGktnG9BAtBaqOyrOE8EpQc/svtmGKOIq
         chTSz1VdNUp6KgSP8kd3rCfB0jUitVnAGPAuRCI78A5tVv4dEEfeaaTKaWEbXzTvR4uz
         9Zkw==
X-Gm-Message-State: AOJu0YwzkF2XmvI1NhZ1jrULOupVCENuakP32w0gjYC+EFaBF8yYp+Rs
	9frQomg4a7ctW3onkt5VgSMM2nUcMl3rxj/WfUJmacxb1GzjIr8WdjWlvRak
X-Gm-Gg: ASbGncvV/cVpLvlYMsH6/NVbzdNAoj096AmE0jq/VnpRCwGHhm4drFxq9YwN5I427Nn
	NqCBF10ZY/J+5+ICq1gmu8HrC9pt3G8Kgj0QZRxKIl04bb7bZWCsF7AdCODrdNJB5wf+adAbMCT
	3m+rPB50D+DLurwLe4IsenpC2+mwJQSZhJhlb8pzgatLllCZYjQ8EIz+tlFgTMpb8O0MSEZMrhS
	qoOgHfFYJYF0LoTRch7e59SbP1p6Q1vmtYx6er3NtQl2pAjIADS2rnU10FjGZtoklTSIu2oercM
	IO2YmuxiCgU9RFY+B9JRttZHcIr23OgyKsR8EK1+ZUZswIQ87BARLNU35fynpnN8bQ==
X-Google-Smtp-Source: AGHT+IGQzCbssnsxCRIDN7nP+aVnUTvQCvb9vk8Zvp+QnPkf9eOEfnjbK/mBdxUK7p+CX5VvjxvbAg==
X-Received: by 2002:a17:907:2d89:b0:ac2:7fd5:774 with SMTP id a640c23a62f3a-ac33048970bmr1474047366b.56.1742249928451;
        Mon, 17 Mar 2025 15:18:48 -0700 (PDT)
Received: from starship.. (1F2EF046.nat.pool.telekom.hu. [31.46.240.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314a481absm727454966b.155.2025.03.17.15.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 15:18:47 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	"Ahmed S . Darwish" <darwi@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	John Ogness <john.ogness@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 3/5] x86/cpuid: Clean up <asm/cpuid/api.h>
Date: Mon, 17 Mar 2025 23:18:22 +0100
Message-ID: <20250317221824.3738853-4-mingo@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250317221824.3738853-1-mingo@kernel.org>
References: <20250317221824.3738853-1-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

 - Include <asm/cpuid/types.h> first, as is customary. This also has
   the side effect of build-testing the header dependency assumptions
   in the types header.

 - No newline necessary after the SPDX line

 - Newline necessary after inline function definitions

 - Rename native_cpuid_reg() to NATIVE_CPUID_REG(): it's a CPP macro,
   whose name we capitalize in such cases.

 - Prettify the CONFIG_PARAVIRT_XXL inclusion block a bit

 - Standardize register references in comments to EAX/EBX/ECX/etc.,
   from the hodgepodge of references.

 - s/cpus/CPUs because why add noise to common acronyms?

 - Use u32 instead of uint32_t in hypervisor_cpuid_base(). Yes, I realize
   uint32_t is used in Xen code, but this is a core x86 architecture header
   and we should standardize on the type that is being used overwhelmingly
   in x86 architecture code. The two types are the same so there should be
   no build warnings.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Ahmed S. Darwish <darwi@linutronix.de>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: x86-cpuid@lists.linux.dev
Link: https://lore.kernel.org/r/20250317164745.4754-3-darwi@linutronix.de
---
 arch/x86/include/asm/cpuid/api.h | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/cpuid/api.h b/arch/x86/include/asm/cpuid/api.h
index 4d1da9cc8b6f..f26926ba5289 100644
--- a/arch/x86/include/asm/cpuid/api.h
+++ b/arch/x86/include/asm/cpuid/api.h
@@ -1,16 +1,16 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-
 #ifndef _ASM_X86_CPUID_API_H
 #define _ASM_X86_CPUID_API_H
 
+#include <asm/cpuid/types.h>
+
 #include <linux/build_bug.h>
 #include <linux/types.h>
 
-#include <asm/cpuid/types.h>
 #include <asm/string.h>
 
 /*
- * Raw CPUID accessors
+ * Raw CPUID accessors:
  */
 
 #ifdef CONFIG_X86_32
@@ -21,6 +21,7 @@ static inline bool have_cpuid_p(void)
 	return true;
 }
 #endif
+
 static inline void native_cpuid(unsigned int *eax, unsigned int *ebx,
 				unsigned int *ecx, unsigned int *edx)
 {
@@ -34,7 +35,7 @@ static inline void native_cpuid(unsigned int *eax, unsigned int *ebx,
 	    : "memory");
 }
 
-#define native_cpuid_reg(reg)					\
+#define NATIVE_CPUID_REG(reg)					\
 static inline unsigned int native_cpuid_##reg(unsigned int op)	\
 {								\
 	unsigned int eax = op, ebx, ecx = 0, edx;		\
@@ -45,22 +46,23 @@ static inline unsigned int native_cpuid_##reg(unsigned int op)	\
 }
 
 /*
- * Native CPUID functions returning a single datum.
+ * Native CPUID functions returning a single datum:
  */
-native_cpuid_reg(eax)
-native_cpuid_reg(ebx)
-native_cpuid_reg(ecx)
-native_cpuid_reg(edx)
+NATIVE_CPUID_REG(eax)
+NATIVE_CPUID_REG(ebx)
+NATIVE_CPUID_REG(ecx)
+NATIVE_CPUID_REG(edx)
 
 #ifdef CONFIG_PARAVIRT_XXL
-#include <asm/paravirt.h>
+# include <asm/paravirt.h>
 #else
-#define __cpuid			native_cpuid
+# define __cpuid native_cpuid
 #endif
 
 /*
  * Generic CPUID function
- * clear %ecx since some cpus (Cyrix MII) do not set or clear %ecx
+ *
+ * Clear ECX since some CPUs (Cyrix MII) do not set or clear ECX
  * resulting in stale register contents being returned.
  */
 static inline void cpuid(unsigned int op,
@@ -72,7 +74,7 @@ static inline void cpuid(unsigned int op,
 	__cpuid(eax, ebx, ecx, edx);
 }
 
-/* Some CPUID calls want 'count' to be placed in ecx */
+/* Some CPUID calls want 'count' to be placed in ECX */
 static inline void cpuid_count(unsigned int op, int count,
 			       unsigned int *eax, unsigned int *ebx,
 			       unsigned int *ecx, unsigned int *edx)
@@ -83,7 +85,7 @@ static inline void cpuid_count(unsigned int op, int count,
 }
 
 /*
- * CPUID functions returning a single datum
+ * CPUID functions returning a single datum:
  */
 
 static inline unsigned int cpuid_eax(unsigned int op)
-- 
2.45.2


