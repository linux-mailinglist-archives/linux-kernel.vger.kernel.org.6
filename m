Return-Path: <linux-kernel+bounces-567125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C325A6819F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 01:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BD323BECE1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 00:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D20135A53;
	Wed, 19 Mar 2025 00:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="aaimI3YY"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA7B1C6B4
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 00:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742344742; cv=none; b=XSxiooCRWWOKzmgK//hq9aVHJKs92/QR7Ds3StVeDUg/+KCw7ChXGxIs9D7F/IPSYhhe1Yhpv1Na8bmxQjG+LLmFWZl2Pa5dOLIb0KtUGMgVEPIfJA4G+uYZuB4JifrpiWu64PsBiNiyCE6p1MXeTwy/a7vHSkXHEYDZPsJDpME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742344742; c=relaxed/simple;
	bh=nHhYXQAzGWOBz+fiRV2cBI9NDuh7wsnPI3XSuTaljL8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a2ipNFjvnAqM9QBHqTjE9G3dVmrwdhBuo9re7ck+ZBKLlP3rKmxSgVEFclYdHLdI9svwBsVnyUMsHP2D0CQ/HRuigbn6Ihu2YKpXchkpnBK3SLZEL6lkes5CZSmvvQQEWWn8nLSfeigmUquh/tV0+abx9TNC/feox0kzw4VZHFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=aaimI3YY; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2255003f4c6so112565015ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 17:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1742344740; x=1742949540; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=znX+QMoNxhiOCpRdgKYwDs//uH3bTTrb7rEQK3e8tjw=;
        b=aaimI3YYqprcrqZfRbml56AIKFV6BGdb7vIvoynd1ZhIMLgMV+LC/hzmnogm79rzEw
         WQdBPrb/oZWLNpK8fQ2+kDtuw3XbCusRKPYlOI3Xoo7zqxZlXJmr4KvouVlYVwHwQqEm
         0ihb/GI/wgbzN4Xp/QmxQzQFgyDWpkhp54XVNOpBeOgAfKfZXhrriqaGM2Clkf1MChwa
         jeOUJ/2Kj3UW0dcnMpGfZxtebn2Ad+ZsZgE/xFUm0T+y6YSXdmSmZxsOwdRqphuFf50c
         SCNhZ2CAPSeSWnALGyRy3DO2bNSG7oms5/ulABB8GoCaUgqy/iuqehgkd2BACsxb8HLB
         lQ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742344740; x=1742949540;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=znX+QMoNxhiOCpRdgKYwDs//uH3bTTrb7rEQK3e8tjw=;
        b=rnyKHsZDzCKv+libggjL8qtut5V0r/JulRCAKRK74iGSLfAtdOrKqjuyxsdw/PXIjm
         FDyahxSTQpnQvYkWVhkFDCW8EZzpkLhKpDSrziPDztuHl1xZjvkjhLhJxBmzcDtZ8Lfr
         RB434Hy8WYmbPBLBnLKHbVmqFrV3IZgvp1d2ZoloYzRBTm19+cvn251ewsdGBcho1DLG
         Z9mC6lEYPn/Zpm5CBXishZK3ZCbA1ZiCrmaJU3c3HTGgjhblYNracI//Wsgb8K7cNitw
         BYbyf0NiyApq3H8RGs6j+r+tguUIG5vLl1OhlucQgv1a8FiedPwA+d90afegBfrnyRTe
         Nrqg==
X-Forwarded-Encrypted: i=1; AJvYcCU2VLIN3oabqOe0jqWXp8m9TJhQ7KD/kjfJVgX7APx8L8G9fN1QYsMDJr0GjOhfAG00fSEgxmruBlba+ps=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNs//nW5VSf2c0zzqztUKYEbwmKW0M5sRuXgj3RIubuBejA260
	OW9/PWIQE0QJzToF6NxL7SOnUom5crPqSAN2WlJzqD3QPvEAfyRTVEBJaEPTZd4=
X-Gm-Gg: ASbGncvjK8OcOO6ws9t01iYdu+dMcFaGC+3gJHMkKL39AwHy00hYFW0udwK4YptmGe6
	EFoJkmh4ztzhv/zFqe9pHKW3wreuJA1IXrwhT8PnesDLxxF9squOsC3hXm/GnS/VMV17hanNKC1
	v127KDcC3qkhMX3GbtrYW6wBHc8bo2G+c7pV1QHIf7XhqcjbhVDJrcjnhdniAenhYuttHY5MSlH
	df9iI0NzBX8HcqY9ftWuRFenySQLDptHj71S0rg8et+YEeb0CYVGKZl+LK4gQbpGRen7VAA8Iwh
	7lDH0qmH0Ur4M7V6mIvScDiZ2hkAiJV3EdWss6STlsTn60+wKPnnXhD2Q4mi
X-Google-Smtp-Source: AGHT+IFyJ4hb7nayIdP+tvFD7Z7530OShgxEwdBAXSBZTDT2fdC6UBXUk1X+51NVWEghPe5O6/ayXA==
X-Received: by 2002:a17:902:d4c5:b0:224:18b0:86a0 with SMTP id d9443c01a7336-22649a7c1c5mr9920255ad.37.1742344739870;
        Tue, 18 Mar 2025 17:38:59 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bbe890sm100843415ad.188.2025.03.18.17.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 17:38:59 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 18 Mar 2025 17:38:45 -0700
Subject: [PATCH v9 1/2] riscv: Move nop definition to insn-def.h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-runtime_const_riscv-v9-1-ddd3534d3e8e@rivosinc.com>
References: <20250318-runtime_const_riscv-v9-0-ddd3534d3e8e@rivosinc.com>
In-Reply-To: <20250318-runtime_const_riscv-v9-0-ddd3534d3e8e@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Ard Biesheuvel <ardb@kernel.org>, 
 Ben Dooks <ben.dooks@codethink.co.uk>, 
 Pasha Bouzarjomehri <pasha@rivosinc.com>, 
 Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 Alexandre Ghiti <alexghiti@rivosinc.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Peter Zijlstra <peterz@infradead.org>, 
 Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3569; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=nHhYXQAzGWOBz+fiRV2cBI9NDuh7wsnPI3XSuTaljL8=;
 b=owGbwMvMwCXWx5hUnlvL8Y3xtFoSQ/otIfkQ3duf1/8PsCmcejzUoDqoafJJ0wPHu/yXPd5/Q
 51lfo17RykLgxgXg6yYIgvPtQbm1jv6ZUdFyybAzGFlAhnCwMUpABMRPsLwm+Ww5w7x5kVMnLa8
 t+LDbVX0Y9PnnD4mHne38uwli52eUYwMa/Z8viB16td7F4dtzs18h594F500+n7n1QaOeyl/vrP
 P5wQA
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

We have duplicated the definition of the nop instruction in ftrace.h and
in jump_label.c. Move this definition into the generic file insn-def.h
so that they can share the definition with each other and with future
files.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/ftrace.h   | 1 -
 arch/riscv/include/asm/insn-def.h | 2 ++
 arch/riscv/kernel/ftrace.c        | 6 +++---
 arch/riscv/kernel/jump_label.c    | 4 ++--
 4 files changed, 7 insertions(+), 6 deletions(-)

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
index 9a913010cdd93cdfdd93f467e7880e20cce0dd2b..0a1fc5134f29da190554c59f8cee3b5374c9aa2d 100644
--- a/arch/riscv/include/asm/insn-def.h
+++ b/arch/riscv/include/asm/insn-def.h
@@ -200,4 +200,6 @@
 #define ZAWRS_WRS_NTO	".4byte 0x00d00073"
 #define ZAWRS_WRS_STO	".4byte 0x01d00073"
 
+#define RISCV_INSN_NOP4	0x00000013U
+
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


