Return-Path: <linux-kernel+bounces-547247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A36EA504D0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D3F53AA9CD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1C52512F8;
	Wed,  5 Mar 2025 16:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dypaf9OB"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587642512C1
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 16:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741192022; cv=none; b=By9HUWYNdzttYuyBp6ExbuyG8FObqBbx3PSGxvspRs7IyjOI2cZ6GkxGj2qILlsflBjmRzCfA6c6jX2HpKT+iyh+ECSetLnJGztGNQYGyKPDEeydvMLY4MNLXRQySZhtObsaCgJjh76N2V8UIxeADkavvIoZi3ylAFMXTdswWqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741192022; c=relaxed/simple;
	bh=NufEolRxNPU40ht+CZp74NctFQAb3wfmh8Gc5PxIQeE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kUrRi+/XFS24MpVOvVcJMeURje6maehBAqZSpD/HcRWSJljOZy1kOMHnkLfUPkEn6b3BfGtaxqKAi6z9p9V3PWi70Qs4Q9AKNPqmLpXlw+Jg/p4I7esI28qmPdZocZgCOd3aD9zuRCmWB0P1p519olycy4xT1Lxl0kO2k1d8MMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dypaf9OB; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso1290753966b.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 08:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741192018; x=1741796818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IB1gjJRKzsGUjoFlHcs0x65GD8vsyFDAaTOj7W/RGZ0=;
        b=Dypaf9OB1Cq9jcpqxoq5+vyMBp4yhQTlq+fNEXaXZ096E/S1Zjv7rXcnWLm/mZ5haU
         yZvUpqarSfLspivXv+YPutOM2+tIIflS/jSKEfjAeQ/lJKKsh5aUjS9EHTAvhmm93DTa
         5tR7lXk9W2LLqXmH716HdAqCuoL9nmaM7Tn0TrYeDAIOAWSQoxCP7ZuV/wcALlp5h7lA
         0G22Aq14n1rKeSrkbhGEjAkj+oybZTS2b8EMjFUVF3gUJa/a24GGuTncqCAmnZvJLrIi
         zQDecEZbhtjr0A8527GaFSvwKWsVpwf1EIQOVyEWGnazXQbdrcmcRohm7a5uLLTN7rWa
         2+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741192018; x=1741796818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IB1gjJRKzsGUjoFlHcs0x65GD8vsyFDAaTOj7W/RGZ0=;
        b=dvWK6LVvqOFCFsQjK2Oe1yv1b27bVkcTgO1IiyFVecT+VKSXbJAB38vanqBe2Nj5po
         yA3OOD3ypMxfSRwEABOw4i1sKv1XHrEzCKH4JczYeh84P+mepRPTNxe8ObE5z72p2Guk
         a0HetW6CwXyjC2rlovarghIwIeoZVn+Bx8CcQTTNmeRe7g8ssYClmyxDyZ08b+LT7z5x
         HPOUTi11osB0MI4x9t4TTcGK1FK68lHLdLCLgn6uYDRwvczWHXmvJbTknlaqpgqzO+bJ
         Cz2mD0y4DLIEcXdU6xcGjG0RYE9VqlieE313lLxJQQR/yLi62PLQ+Fl6RXWywn+V1a1j
         sOJA==
X-Forwarded-Encrypted: i=1; AJvYcCV11p7HoCCAbVseAKDZ+xeIA3GGVKw23Ph6HUuj4IvVPTwo5ylJ8ZCjML3q9JgzdvOvHYhAvWKf12JgGko=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWA4KVd8HfF8g7JrlT/Fo94O/WAbs2/8NCzXvdQ+OlN06eNp74
	sDvL0eglzVbHxQk34+WZBmQRjjguWxdDfbyp24ttTAzueu3aYxY5
X-Gm-Gg: ASbGncsvqCvZkdImDbi9Toh9xRksc9/1oJNKkjR3f50sbtbNZRq7WALfmPsIfoP/u2f
	/cIlOpRxgxfpcqo91k1tAOeydY5OO5s9MK+zYBL6Hx13yMAOscKjVfqMtIgH9+E+UBvT4ZKvnoe
	uVD99t6qbVs3X5Raj2red5tcoRzSDYjMSuosveMNLOywJrTZPZJqG7V4s+qtFAEK63jgdoSKg/Z
	quA5UZsot6gtzLZFE/EIE5QEDxfN2DSgzaDEy8LMcewuAP3FNBOp3G3LbA0TPuCwdUhmMOM7Qaw
	nhviYjgJKvu08NQx1RSPUKe3W3/mHASknU+Rh2MkNVzstA50h1E6/g==
X-Google-Smtp-Source: AGHT+IFwGVTvFx5WFAKAaoE6f1+EmkdqxbwAa5lkpI8zjwVRBoWJlwXMvIrXWlkoT34bi8OCXCjt5Q==
X-Received: by 2002:a17:906:7314:b0:ac1:17fe:c773 with SMTP id a640c23a62f3a-ac20da86f0cmr447062466b.41.1741192018293;
        Wed, 05 Mar 2025 08:26:58 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac1fa431529sm281412066b.148.2025.03.05.08.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 08:26:57 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/kexec: Merge x86_32 and x86_64 code using macros from asm.h
Date: Wed,  5 Mar 2025 17:26:37 +0100
Message-ID: <20250305162649.130270-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Merge common x86_32 and x86_64 code in crash_setup_regs()
using macros from asm/asm.h.

The compiled object files before and after the patch are unchanged.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/include/asm/asm.h   |  2 ++
 arch/x86/include/asm/kexec.h | 44 +++++++++++++++---------------------
 2 files changed, 20 insertions(+), 26 deletions(-)

diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index 975ae7a9397e..2bccc063d30b 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -41,6 +41,8 @@
 #define _ASM_SUB	__ASM_SIZE(sub)
 #define _ASM_XADD	__ASM_SIZE(xadd)
 #define _ASM_MUL	__ASM_SIZE(mul)
+#define _ASM_PUSHF	__ASM_SIZE(pushf)
+#define _ASM_POP	__ASM_SIZE(pop)
 
 #define _ASM_AX		__ASM_REG(ax)
 #define _ASM_BX		__ASM_REG(bx)
diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 8ad187462b68..56040ae6bda0 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -18,6 +18,7 @@
 #include <linux/string.h>
 #include <linux/kernel.h>
 
+#include <asm/asm.h>
 #include <asm/page.h>
 #include <asm/ptrace.h>
 
@@ -71,29 +72,15 @@ static inline void crash_setup_regs(struct pt_regs *newregs,
 	if (oldregs) {
 		memcpy(newregs, oldregs, sizeof(*newregs));
 	} else {
-#ifdef CONFIG_X86_32
-		asm volatile("movl %%ebx,%0" : "=m"(newregs->bx));
-		asm volatile("movl %%ecx,%0" : "=m"(newregs->cx));
-		asm volatile("movl %%edx,%0" : "=m"(newregs->dx));
-		asm volatile("movl %%esi,%0" : "=m"(newregs->si));
-		asm volatile("movl %%edi,%0" : "=m"(newregs->di));
-		asm volatile("movl %%ebp,%0" : "=m"(newregs->bp));
-		asm volatile("movl %%eax,%0" : "=m"(newregs->ax));
-		asm volatile("movl %%esp,%0" : "=m"(newregs->sp));
-		asm volatile("movl %%ss, %%eax;" :"=a"(newregs->ss));
-		asm volatile("movl %%cs, %%eax;" :"=a"(newregs->cs));
-		asm volatile("movl %%ds, %%eax;" :"=a"(newregs->ds));
-		asm volatile("movl %%es, %%eax;" :"=a"(newregs->es));
-		asm volatile("pushfl; popl %0" :"=m"(newregs->flags));
-#else
-		asm volatile("movq %%rbx,%0" : "=m"(newregs->bx));
-		asm volatile("movq %%rcx,%0" : "=m"(newregs->cx));
-		asm volatile("movq %%rdx,%0" : "=m"(newregs->dx));
-		asm volatile("movq %%rsi,%0" : "=m"(newregs->si));
-		asm volatile("movq %%rdi,%0" : "=m"(newregs->di));
-		asm volatile("movq %%rbp,%0" : "=m"(newregs->bp));
-		asm volatile("movq %%rax,%0" : "=m"(newregs->ax));
-		asm volatile("movq %%rsp,%0" : "=m"(newregs->sp));
+		asm volatile(_ASM_MOV " %%" _ASM_BX ",%0" : "=m"(newregs->bx));
+		asm volatile(_ASM_MOV " %%" _ASM_CX ",%0" : "=m"(newregs->cx));
+		asm volatile(_ASM_MOV " %%" _ASM_DX ",%0" : "=m"(newregs->dx));
+		asm volatile(_ASM_MOV " %%" _ASM_SI ",%0" : "=m"(newregs->si));
+		asm volatile(_ASM_MOV " %%" _ASM_DI ",%0" : "=m"(newregs->di));
+		asm volatile(_ASM_MOV " %%" _ASM_BP ",%0" : "=m"(newregs->bp));
+		asm volatile(_ASM_MOV " %%" _ASM_AX ",%0" : "=m"(newregs->ax));
+		asm volatile(_ASM_MOV " %%" _ASM_SP ",%0" : "=m"(newregs->sp));
+#ifdef CONFIG_X86_64
 		asm volatile("movq %%r8,%0" : "=m"(newregs->r8));
 		asm volatile("movq %%r9,%0" : "=m"(newregs->r9));
 		asm volatile("movq %%r10,%0" : "=m"(newregs->r10));
@@ -102,10 +89,15 @@ static inline void crash_setup_regs(struct pt_regs *newregs,
 		asm volatile("movq %%r13,%0" : "=m"(newregs->r13));
 		asm volatile("movq %%r14,%0" : "=m"(newregs->r14));
 		asm volatile("movq %%r15,%0" : "=m"(newregs->r15));
-		asm volatile("movl %%ss, %%eax;" :"=a"(newregs->ss));
-		asm volatile("movl %%cs, %%eax;" :"=a"(newregs->cs));
-		asm volatile("pushfq; popq %0" :"=m"(newregs->flags));
 #endif
+		asm volatile("movl %%ss,%k0" :"=a"(newregs->ss));
+		asm volatile("movl %%cs,%k0" :"=a"(newregs->cs));
+#ifdef CONFIG_X86_32
+		asm volatile("movl %%ds,%k0" :"=a"(newregs->ds));
+		asm volatile("movl %%es,%k0" :"=a"(newregs->es));
+#endif
+		asm volatile(_ASM_PUSHF "\n\t"
+			     _ASM_POP " %0" : "=m"(newregs->flags));
 		newregs->ip = _THIS_IP_;
 	}
 }
-- 
2.42.0


