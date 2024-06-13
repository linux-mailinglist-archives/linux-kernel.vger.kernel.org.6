Return-Path: <linux-kernel+bounces-212712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45253906533
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 09:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3B841F213B6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 07:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0F613CFAD;
	Thu, 13 Jun 2024 07:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="IuA+BP23"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED81E13C9D5
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 07:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718263974; cv=none; b=NlZ3p6dyIr0VcbRiBTMix/6uGCCqsq+938pgsM+XO4NYNfmDnLQNs0+/1nzuMgRipUJMQRbXIEsBnuh4hPFtxlP7FBKRYrBlLBgV8vLUdd159GcSVTWqoRO4uVBUi6JzCKkbrh2RsqQs9CDPKDTBLdlifHkoccJgS3MguYV3Upk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718263974; c=relaxed/simple;
	bh=bMHErU1rLfk/wyX5o/DIX3M08fOpuNP508e8HYuo5pE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iL0BSOrN045TQgMO1gj80v6jJ7dp8Kp9wwd5tsr1HN2LBtpkE7wXk8gnIjm38AU4/mo7Pz+37nWetinYMvYZXUgCo3DfuGvE4FbPDVDq8QnlgcLrNTGg1ZanB8vugHVzRSKC+DKEbiRJL8mxzyx9X8Aun5gbkwfz22CrZJrP77k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=IuA+BP23; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5b9706c84e5so412742eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 00:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1718263972; x=1718868772; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KqGOcRG4MSO17L8Yoo0My/BpQLJGME/lNuiKW2jExFw=;
        b=IuA+BP23jxTOAG9lmxUL54VkgwxfKT7HwSd5s95zMFIDgJ7RuTNGy2P4AR2H3o8t7y
         Kb3a3HjAHdsi1CIHd+HNjleYdHbBWUsDwsmZ8SrlnqZascKvZhD95KtoZNVAXPY/QnFf
         wvifrYumjMjlLQJtVJa8x24s8NquzgrXB62yKa0qAQfdiNlMssbHUj+ih0zRU8/+3nZP
         TPGePrh9SiEcBt5FT6VbPcMtB9VNluBIrS9Au3Vx9NlVZZU9OSCtP/lFGTOUERF7cxZ6
         Jws9Vfx1Jx6xbbaVkpqJT9cQfRRWTsSL+873EI33gP95bfCjWt5bf4BPAT1rBc/EM4jp
         NyBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718263972; x=1718868772;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KqGOcRG4MSO17L8Yoo0My/BpQLJGME/lNuiKW2jExFw=;
        b=COfTkVVzgJ5c7PcNBjOZzgLMYhOWEx7iQ+n4wJc5Y/fF0L2E4Ctzug1EDZurPm520S
         I0FMSpEXkOB4OYBUsvMO24gjRjVZewtYQOugTN65759ALNNUbdTPhZpICLrf6kKkLYxD
         Pe5JG0MHWzY3Aux5cvJT3bMYUmcj4YNodvm2X9C7mlbSxyRsC+bwv0Ybj2Rg+D4PKsju
         N+WIwX5LAqjZqNILySm5jQL2kHlW3d1C3P0g3TdoDO9cSs+DmY7nkhHO4eDVdm8DJD/G
         Z/7+JcFrG7XZQWk2DSUi57OhCDmPGJm6ezf0a9E4++s+XKIxRVLLIcn9OoncoLdaAJSP
         /mcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPeED0CP4wgLWZobU8StwubeTeSZ8bINaphGfAhrBGfBylBguPgUx5UMAc4eMajpXRl6nFiMs9NSmZ3r1gaSZCGZwiTFhrjvXXVIFn
X-Gm-Message-State: AOJu0Yy223JUq82cQlbua2EXKxvcVCHmjM8eoX6kGd30WhWWG8S+ieMv
	iOIPiQSSk+4Fn1/dMm4/6RX8m8Yl3qWK3h5hhVfy1WrWtku7MxFclGgIHa4IElI=
X-Google-Smtp-Source: AGHT+IH5DuWNaDmtQxAXDaBzm13SBjMPGjRqC4tR8s/HjfQ0ZY47iBUeJz4hi/y6Ws3uKj9ioyrEhA==
X-Received: by 2002:a05:6871:b29:b0:254:b3cc:a6da with SMTP id 586e51a60fabf-25514c664afmr4230304fac.29.1718263971977;
        Thu, 13 Jun 2024 00:32:51 -0700 (PDT)
Received: from [127.0.1.1] (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc78a1a0sm730028b3a.0.2024.06.13.00.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 00:32:51 -0700 (PDT)
From: Andy Chiu <andy.chiu@sifive.com>
Date: Thu, 13 Jun 2024 15:11:08 +0800
Subject: [PATCH 3/8] riscv: ftrace: support fastcc in Clang for WITH_ARGS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240613-dev-andyc-dyn-ftrace-v4-v1-3-1a538e12c01e@sifive.com>
References: <20240613-dev-andyc-dyn-ftrace-v4-v1-0-1a538e12c01e@sifive.com>
In-Reply-To: <20240613-dev-andyc-dyn-ftrace-v4-v1-0-1a538e12c01e@sifive.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alexghiti@rivosinc.com>, Zong Li <zong.li@sifive.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Puranjay Mohan <puranjay@kernel.org>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, Evgenii Shatokhin <e.shatokhin@yadro.com>, 
 Andy Chiu <andy.chiu@sifive.com>
X-Mailer: b4 0.12.4

Some caller-saved registers which are not defined as function arguments
in the ABI can still be passed as arguments when the kernel is compiled
with Clang. As a result, we must save and restore those registers to
prevent ftrace from clobbering them.

- [1]: https://reviews.llvm.org/D68559
Reported-by: Evgenii Shatokhin <e.shatokhin@yadro.com>
Closes: https://lore.kernel.org/linux-riscv/7e7c7914-445d-426d-89a0-59a9199c45b1@yadro.com/
Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
---
 arch/riscv/include/asm/ftrace.h |  7 +++++++
 arch/riscv/kernel/asm-offsets.c |  7 +++++++
 arch/riscv/kernel/mcount-dyn.S  | 16 ++++++++++++++--
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
index 9eb31a7ea0aa..5f81c53dbfd9 100644
--- a/arch/riscv/include/asm/ftrace.h
+++ b/arch/riscv/include/asm/ftrace.h
@@ -144,6 +144,13 @@ struct ftrace_regs {
 			unsigned long a5;
 			unsigned long a6;
 			unsigned long a7;
+#ifdef CONFIG_CC_IS_CLANG
+			unsigned long t2;
+			unsigned long t3;
+			unsigned long t4;
+			unsigned long t5;
+			unsigned long t6;
+#endif
 		};
 	};
 };
diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
index b09ca5f944f7..db5a26fcc9ae 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -497,6 +497,13 @@ void asm_offsets(void)
 	DEFINE(FREGS_SP,	    offsetof(struct ftrace_regs, sp));
 	DEFINE(FREGS_S0,	    offsetof(struct ftrace_regs, s0));
 	DEFINE(FREGS_T1,	    offsetof(struct ftrace_regs, t1));
+#ifdef CONFIG_CC_IS_CLANG
+	DEFINE(FREGS_T2,	    offsetof(struct ftrace_regs, t2));
+	DEFINE(FREGS_T3,	    offsetof(struct ftrace_regs, t3));
+	DEFINE(FREGS_T4,	    offsetof(struct ftrace_regs, t4));
+	DEFINE(FREGS_T5,	    offsetof(struct ftrace_regs, t5));
+	DEFINE(FREGS_T6,	    offsetof(struct ftrace_regs, t6));
+#endif
 	DEFINE(FREGS_A0,	    offsetof(struct ftrace_regs, a0));
 	DEFINE(FREGS_A1,	    offsetof(struct ftrace_regs, a1));
 	DEFINE(FREGS_A2,	    offsetof(struct ftrace_regs, a2));
diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount-dyn.S
index 745dd4c4a69c..e988bd26b28b 100644
--- a/arch/riscv/kernel/mcount-dyn.S
+++ b/arch/riscv/kernel/mcount-dyn.S
@@ -96,7 +96,13 @@
 	REG_S	x8,  FREGS_S0(sp)
 #endif
 	REG_S	x6,  FREGS_T1(sp)
-
+#ifdef CONFIG_CC_IS_CLANG
+	REG_S	x7,  FREGS_T2(sp)
+	REG_S	x28, FREGS_T3(sp)
+	REG_S	x29, FREGS_T4(sp)
+	REG_S	x30, FREGS_T5(sp)
+	REG_S	x31, FREGS_T6(sp)
+#endif
 	// save the arguments
 	REG_S	x10, FREGS_A0(sp)
 	REG_S	x11, FREGS_A1(sp)
@@ -115,7 +121,13 @@
 	REG_L	x8, FREGS_S0(sp)
 #endif
 	REG_L	x6,  FREGS_T1(sp)
-
+#ifdef CONFIG_CC_IS_CLANG
+	REG_L	x7,  FREGS_T2(sp)
+	REG_L	x28, FREGS_T3(sp)
+	REG_L	x29, FREGS_T4(sp)
+	REG_L	x30, FREGS_T5(sp)
+	REG_L	x31, FREGS_T6(sp)
+#endif
 	// restore the arguments
 	REG_L	x10, FREGS_A0(sp)
 	REG_L	x11, FREGS_A1(sp)

-- 
2.43.0


