Return-Path: <linux-kernel+bounces-568596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E411CA6981D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C746F426A8D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 18:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA4E206F11;
	Wed, 19 Mar 2025 18:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="oZBJfn6J"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F17C208969
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 18:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742409335; cv=none; b=mb1/JOvOCItU5VUQkprcYegdq+lbz2yZklx/Llej7auQUhhxY/MCN99LZmarlaf+cOXAlwvuJirHC0A5Wz3pZ6LJSGWW5kodJBIROaCwnlrupMgjSFBMVom0ZqxvxPNSculxvzKV+Ks8VapxJG9SMCC4uJZa/D/HszbU6/o6PAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742409335; c=relaxed/simple;
	bh=jcUMUpSTP0w83s8S9BETds7fzlXnkTNKzrbHYn+Xbas=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OF9WNC6VHusElHiS66Wl2CgQZ8i46PBvOmb803i2CpicW6GeniIebb/5YDr1oq1ekw1dDywMB7ghiJ+lKBGmIq+cneCFKVzWI0cyK7pX2y7Sps9prlH+FGJ28gZIb4PZISG+x36CodzgoYgn0HM1c6IXf3eHt/d+4RqAYuPPtto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=oZBJfn6J; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22580c9ee0aso129418085ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 11:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1742409332; x=1743014132; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uR51xah4xxVpBSnTg/IV2alN19Fnn1YAZeJAKTDPRYQ=;
        b=oZBJfn6J8e1I1RR3TSXpin8y3GUwoJ/0w/Mv0eVB/KEgLjCsIBWPZZhK+YhfeAYfKL
         wsw+0WTsxsoE693WUGHER019/1CXbBku94mVty/ZzOC5TsDrhxoMulH2fg3ixwLxkdus
         hpOtd8PqaSwBgy38yvemR1ERGeOWNFU5auxm6XXEmF2zXufCWRZr+GPARNKtNFiT+KYl
         ISRuXVYJLsQCQqKj7hx+CFU2f60yBlNyqadaI8FJRDXiEfJ6BY1F83A9AOe27XiAIvb0
         ix6kft3caaFVxLeqLIMXVqJJWeUCcL6o6lluSdTj6tOkLGRP1b+r+GkyvzSh9SmEyjkL
         A6Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742409332; x=1743014132;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uR51xah4xxVpBSnTg/IV2alN19Fnn1YAZeJAKTDPRYQ=;
        b=fzD02681QrwcAUOvKLvKmP/+1qYAlHvjPmh6KNOE1M2GBDRMYOmLDAssw//agIDoFU
         9YhL+G8XzhGKDngWBktuvTOGIcptNTny0RPqtGIEur21EonFj4PGh+OL4FrmXgXQ0jsG
         /YTJiwgFixBxaz9Y4TqpVThT4QZRpLWNccaL8tmAZ70rXUe5v0JcjU8Pkr2wGToUyEiP
         zL3QpvxWsBXzgO+slW0NWUwD58bLOzIFBA8ch48BRXE4Kmdobn8yQdjqDxM/GhK6HW6r
         PqnPazcP1ZjE1zAdSpAITHN0C1YF4ncgPpKZqbz9Wl+kAAfJ+On4NTepRrxXz0L53/8A
         q0+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXeREPiV1eaeryAJMd0wh3NJRDEYuAa0txNEvOzInr7TqL+TWsRZN31XClYhbb41C2Yk+hpSJIACoxL4jM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF8F1NBnC+/HvmEY4qvLPC3G27spgCZiDQjuItqfKX1iIgQZ5J
	t1luoKARi5KnB0sFWp11UPaA+vpEh+9xQhtq+lykZaIt324mPD5m2CL/XhQMgIA=
X-Gm-Gg: ASbGncsCPGzm4VOgoMIhpyabvZaXYTTtl1sSrSHjNfNp3lAEg8JizNlsXPrcw4BliWH
	T/i+X9yppQcv4iH0l8+xAMd2xQSJVz1R+1mE9/L++1iyVU/C9E8en8iuAInjNHBbg0wOJ3YO1Xc
	hU+y14CG93HFKCfJW7S4UkdsEfjL6CmMkrUauisfXJyEC6gEdz1sMKgYB/gvI25lyhXPa+EzZoa
	e0LNJSE65O2fg7FkDzJuCaicpXkC0qrVQou+gLgF/TPPR4v2DGl8ZEVfCi9jpnm+dXYDmILREtJ
	k7XTbkgn7NLaLkfU0scK/5fLX0frvOE+N8hhomPitlDMjLjtlxsrTtOGewqY
X-Google-Smtp-Source: AGHT+IGVWjR9gQffmmSDn2uRl9PI4o0YcgivPHUzO9gwlKWf+ydGj9+4bhZ79+++dyKX8S+kHEzYqQ==
X-Received: by 2002:a05:6a00:1486:b0:736:3979:369e with SMTP id d2e1a72fcca58-7377a83e678mr333529b3a.9.1742409331719;
        Wed, 19 Mar 2025 11:35:31 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7371167e109sm11993844b3a.115.2025.03.19.11.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 11:35:30 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 19 Mar 2025 11:35:19 -0700
Subject: [PATCH v10 1/2] riscv: Move nop definition to insn-def.h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-runtime_const_riscv-v10-1-745b31a11d65@rivosinc.com>
References: <20250319-runtime_const_riscv-v10-0-745b31a11d65@rivosinc.com>
In-Reply-To: <20250319-runtime_const_riscv-v10-0-745b31a11d65@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Ard Biesheuvel <ardb@kernel.org>, 
 Ben Dooks <ben.dooks@codethink.co.uk>, 
 Pasha Bouzarjomehri <pasha@rivosinc.com>, 
 Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 Alexandre Ghiti <alexghiti@rivosinc.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Peter Zijlstra <peterz@infradead.org>, 
 Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, 
 Andrew Jones <ajones@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3767; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=jcUMUpSTP0w83s8S9BETds7fzlXnkTNKzrbHYn+Xbas=;
 b=owGbwMvMwCXWx5hUnlvL8Y3xtFoSQ/ptvvxq/RDmibtNz5uscts8ac62l2u5nj+7yXlDs8vcN
 ps55eeBjlIWBjEuBlkxRRaeaw3MrXf0y46Klk2AmcPKBDKEgYtTACZy5zzD/3pjQ+OmwJJV33kz
 FGoiNDfuCTmU2Fq+7kRMp678tu+vohj+2RW06e8ocriTLtd+/Ud0QlCJo3+K71TJ0yvj5u59eU+
 KCQA=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

We have duplicated the definition of the nop instruction in ftrace.h and
in jump_label.c. Move this definition into the generic file insn-def.h
so that they can share the definition with each other and with future
files.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/ftrace.h   | 1 -
 arch/riscv/include/asm/insn-def.h | 3 +++
 arch/riscv/kernel/ftrace.c        | 6 +++---
 arch/riscv/kernel/jump_label.c    | 4 ++--
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
index c4721ce44ca474654b37b3d51bc0a63d46bc1eff..b7f361a50f6445d02a0d88eef5547ee27c1fb52e 100644
--- a/arch/riscv/include/asm/ftrace.h
+++ b/arch/riscv/include/asm/ftrace.h
@@ -79,7 +79,6 @@ struct dyn_arch_ftrace {
 #define AUIPC_RA		(0x00000097)
 #define JALR_T0			(0x000282e7)
 #define AUIPC_T0		(0x00000297)
-#define NOP4			(0x00000013)
 
 #define to_jalr_t0(offset)						\
 	(((offset & JALR_OFFSET_MASK) << JALR_SHIFT) | JALR_T0)
diff --git a/arch/riscv/include/asm/insn-def.h b/arch/riscv/include/asm/insn-def.h
index 9a913010cdd93cdfdd93f467e7880e20cce0dd2b..71060a2f838e24200e3eb4ad8dfb32ef6bd2f57a 100644
--- a/arch/riscv/include/asm/insn-def.h
+++ b/arch/riscv/include/asm/insn-def.h
@@ -199,5 +199,8 @@
 #define RISCV_PAUSE	".4byte 0x100000f"
 #define ZAWRS_WRS_NTO	".4byte 0x00d00073"
 #define ZAWRS_WRS_STO	".4byte 0x01d00073"
+#define RISCV_NOP4	".4byte 0x00000013"
+
+#define RISCV_INSN_NOP4	_AC(0x00000013, U)
 
 #endif /* __ASM_INSN_DEF_H */
diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index 3524db5e4fa014a4594465f849d898a030bfb7b8..674dcdfae7a149c339f1e791adb450535f22991b 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -36,7 +36,7 @@ static int ftrace_check_current_call(unsigned long hook_pos,
 				     unsigned int *expected)
 {
 	unsigned int replaced[2];
-	unsigned int nops[2] = {NOP4, NOP4};
+	unsigned int nops[2] = {RISCV_INSN_NOP4, RISCV_INSN_NOP4};
 
 	/* we expect nops at the hook position */
 	if (!expected)
@@ -68,7 +68,7 @@ static int __ftrace_modify_call(unsigned long hook_pos, unsigned long target,
 				bool enable, bool ra)
 {
 	unsigned int call[2];
-	unsigned int nops[2] = {NOP4, NOP4};
+	unsigned int nops[2] = {RISCV_INSN_NOP4, RISCV_INSN_NOP4};
 
 	if (ra)
 		make_call_ra(hook_pos, target, call);
@@ -97,7 +97,7 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
 		    unsigned long addr)
 {
-	unsigned int nops[2] = {NOP4, NOP4};
+	unsigned int nops[2] = {RISCV_INSN_NOP4, RISCV_INSN_NOP4};
 
 	if (patch_insn_write((void *)rec->ip, nops, MCOUNT_INSN_SIZE))
 		return -EPERM;
diff --git a/arch/riscv/kernel/jump_label.c b/arch/riscv/kernel/jump_label.c
index 654ed159c830b3d5e34ac58bf367107066eb73a1..b4c1a6a3fbd28533552036194f27ed206bea305d 100644
--- a/arch/riscv/kernel/jump_label.c
+++ b/arch/riscv/kernel/jump_label.c
@@ -11,8 +11,8 @@
 #include <asm/bug.h>
 #include <asm/cacheflush.h>
 #include <asm/text-patching.h>
+#include <asm/insn-def.h>
 
-#define RISCV_INSN_NOP 0x00000013U
 #define RISCV_INSN_JAL 0x0000006fU
 
 bool arch_jump_label_transform_queue(struct jump_entry *entry,
@@ -33,7 +33,7 @@ bool arch_jump_label_transform_queue(struct jump_entry *entry,
 			(((u32)offset & GENMASK(10,  1)) << (21 -  1)) |
 			(((u32)offset & GENMASK(20, 20)) << (31 - 20));
 	} else {
-		insn = RISCV_INSN_NOP;
+		insn = RISCV_INSN_NOP4;
 	}
 
 	if (early_boot_irqs_disabled) {

-- 
2.43.0


