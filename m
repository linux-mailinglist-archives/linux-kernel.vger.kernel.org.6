Return-Path: <linux-kernel+bounces-549155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AE5A54E4A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0A233A6A41
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F32188734;
	Thu,  6 Mar 2025 14:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="beSj5sk9"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3D21898EA
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 14:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741272744; cv=none; b=NoaeHef9JD4Z5ChvYaxasPUsn03sx6hCKY6rgf3Z/N4Z3nJYiiOdR055hgGh0Xw8/AUuBMpxnRGpfzD1078kPGk4nJCZ57P2iPnnRdSWfj3lX0XLMFSrSY/kS/ba/TZ/mknrtWYOL0+f2xR5VJCe8Tq5kkiwnujfmxL6JJZWi+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741272744; c=relaxed/simple;
	bh=t+0MFjYbojqkmAaDKeAez/OXijMH3eBI6IA4jptE+Hw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nnktHiuSgiY4EVqXOWZQyW9lY06tnDezPaLR+t2JhQOYz8soFUm9ENmL7aVDrhCLkH/SmBbh99d+hIvGId7k8tM6WwAlC2DdqgTRoG9OOJZX7QvdJT58oeM9/FFs1zVfmi4nnNfFffxxWSQF4znYbnZB/JM70DNnfZtAVgQB/Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=beSj5sk9; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-abf4802b242so148984866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 06:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741272741; x=1741877541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=myf0UszRqCLMjM8DUdDYCWj2MfctkXdpk0LAGknuQAw=;
        b=beSj5sk9EhVakMDljGaVd3oJED7gy+ZKZ9sxRVqZ5TPIYpppYzQ0XwO0BveBJDdAK6
         kF9wRqEiuEFC6IPzszP9nvnCAnD+WcJ114c/z5FxGxGEjCSFgJB8Kk3T5q1Zcw7tq7Dg
         sFFdIH/nmCTSC4xd8v1SwF+plnaYT6JBVAoTKqq2/qP2qHqeRWeqJLz9lAeCmcSPL4tx
         /aCDSb20jSSd9vJ1iVvG6x2VgpY2fGnlZf1VhG2m7k/prrOIcAf1nRECb04MjKiDbbCQ
         kTcnMsW9CeSOouw6DGEzzUBTS9XTskqla6qE3H4ZKEGdAFq4ZBJbd9+YEzNxRN4FuDDd
         4FoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741272741; x=1741877541;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=myf0UszRqCLMjM8DUdDYCWj2MfctkXdpk0LAGknuQAw=;
        b=ZOm+az+lLQYliAAMErc1/ZxwPeBXqmYlqyGtLNBU7R1ShLVeRgEQW5+bZLTrFzSXne
         X7wQIy78fAVXaG+w6LiHuhZB/iSQocSGHqXsqDvBUlbnCMwvYqwHJbWmmKqhsGFzTBlf
         Mk7IOXfeKAsb/5EthnSanvTOZeG2xXuaE5gX0vTT7qXVo67giJATbSFtNNFyyjZZkL6K
         bXzsG05kg756EZM/AgfAsmGfjaV0uwrHQ5QPW1VzV+iwLHXCTmFe4w1czguY21mkCKaJ
         hjOb22s6JnJGxEK8Jxz7XIbSkJggqxBzSDdGN0XEffebCLxZAqTGAYujiJucYXwVgjzY
         CXRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJ93jdHvoG6bajiyqtCjyjuWmj0lOrJC7UGLTf6PEjZkXrRTAJpJUCj51iMTSH/b4QwqJXSa8AFy3kgEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZIN3h7PP2jJxQ64V6qVFXoqTy8yVgRMRQvI5VioZxJe9eGgt7
	zaGycn+BH0NcB/MpJmca2s1SBTJUDLvSSI3ZI4kzGYtFBqFdyMlT
X-Gm-Gg: ASbGnctbsT2xtpxLJYeHc1jc/LoaPAUT4RWhBvtTrbscO1tBsyzLMtKO0ZxuBLMNvO9
	9ldqN5mOSRYK/CfkzZW+z/4zy6Cw2zSmPe59tCLfEQhIVHPnwgXrdLFQFCowBmMeRjX8xa+S7Mb
	FM8ainTbzQatVnoEMX5km9P358J0SOLcoA7ZpQGUB6HNAgAB32/R7MQTVKyqz/ilaqQWoq7e009
	U7drl3mvRByvN9htdJTTS3/qvHoTyW9t18lcYfGAsc3MaSmee0oxHqlt/nImaVRc3/AOEQzkBeD
	ZW/9qnTX7lLSxmhA6tKSbABHyQCZ25Iyf7S6
X-Google-Smtp-Source: AGHT+IFKBBlMA+9E4SXdpvP/Xqus6rCM2Hoqb6fQcZFMBZj0ZPxFI89+gNpLWjZycp+/afSTxWiu2A==
X-Received: by 2002:a17:906:dd5:b0:ac2:1793:adc3 with SMTP id a640c23a62f3a-ac21793af5bmr671284666b.41.1741272740320;
        Thu, 06 Mar 2025 06:52:20 -0800 (PST)
Received: from fedora.. ([193.77.86.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac239438117sm106297766b.26.2025.03.06.06.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 06:52:19 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2] x86/kexec: Merge x86_32 and x86_64 code using macros from asm.h
Date: Thu,  6 Mar 2025 15:52:11 +0100
Message-ID: <20250306145227.55819-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.48.1
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
v2: Remove size suffixes from instructions.
---
 arch/x86/include/asm/kexec.h | 58 ++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 33 deletions(-)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 8ad187462b68..e3589d6aec24 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -18,6 +18,7 @@
 #include <linux/string.h>
 #include <linux/kernel.h>
 
+#include <asm/asm.h>
 #include <asm/page.h>
 #include <asm/ptrace.h>
 
@@ -71,41 +72,32 @@ static inline void crash_setup_regs(struct pt_regs *newregs,
 	if (oldregs) {
 		memcpy(newregs, oldregs, sizeof(*newregs));
 	} else {
+		asm volatile("mov %%" _ASM_BX ",%0" : "=m"(newregs->bx));
+		asm volatile("mov %%" _ASM_CX ",%0" : "=m"(newregs->cx));
+		asm volatile("mov %%" _ASM_DX ",%0" : "=m"(newregs->dx));
+		asm volatile("mov %%" _ASM_SI ",%0" : "=m"(newregs->si));
+		asm volatile("mov %%" _ASM_DI ",%0" : "=m"(newregs->di));
+		asm volatile("mov %%" _ASM_BP ",%0" : "=m"(newregs->bp));
+		asm volatile("mov %%" _ASM_AX ",%0" : "=m"(newregs->ax));
+		asm volatile("mov %%" _ASM_SP ",%0" : "=m"(newregs->sp));
+#ifdef CONFIG_X86_64
+		asm volatile("mov %%r8,%0" : "=m"(newregs->r8));
+		asm volatile("mov %%r9,%0" : "=m"(newregs->r9));
+		asm volatile("mov %%r10,%0" : "=m"(newregs->r10));
+		asm volatile("mov %%r11,%0" : "=m"(newregs->r11));
+		asm volatile("mov %%r12,%0" : "=m"(newregs->r12));
+		asm volatile("mov %%r13,%0" : "=m"(newregs->r13));
+		asm volatile("mov %%r14,%0" : "=m"(newregs->r14));
+		asm volatile("mov %%r15,%0" : "=m"(newregs->r15));
+#endif
+		asm volatile("mov %%ss,%k0" : "=a"(newregs->ss));
+		asm volatile("mov %%cs,%k0" : "=a"(newregs->cs));
 #ifdef CONFIG_X86_32
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
-		asm volatile("movq %%r8,%0" : "=m"(newregs->r8));
-		asm volatile("movq %%r9,%0" : "=m"(newregs->r9));
-		asm volatile("movq %%r10,%0" : "=m"(newregs->r10));
-		asm volatile("movq %%r11,%0" : "=m"(newregs->r11));
-		asm volatile("movq %%r12,%0" : "=m"(newregs->r12));
-		asm volatile("movq %%r13,%0" : "=m"(newregs->r13));
-		asm volatile("movq %%r14,%0" : "=m"(newregs->r14));
-		asm volatile("movq %%r15,%0" : "=m"(newregs->r15));
-		asm volatile("movl %%ss, %%eax;" :"=a"(newregs->ss));
-		asm volatile("movl %%cs, %%eax;" :"=a"(newregs->cs));
-		asm volatile("pushfq; popq %0" :"=m"(newregs->flags));
+		asm volatile("mov %%ds,%k0" : "=a"(newregs->ds));
+		asm volatile("mov %%es,%k0" : "=a"(newregs->es));
 #endif
+		asm volatile("pushf\n\t"
+			     "pop %0" : "=m"(newregs->flags));
 		newregs->ip = _THIS_IP_;
 	}
 }
-- 
2.48.1


