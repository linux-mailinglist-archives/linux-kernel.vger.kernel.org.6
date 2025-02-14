Return-Path: <linux-kernel+bounces-515164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0F8A36116
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 983AF188DFF9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE5B266F05;
	Fri, 14 Feb 2025 15:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/YbsMXR"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB84266583
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 15:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739545784; cv=none; b=guWRnARwb6DFNUqHD3/t9BRu1/veQjY8rmQ3heNQ5aYYltC8VVH4nrQziLRE5qMD4Bsy152qf+mouH7pkU59aG7XojCC7q4LLCEJWUhLYe3M1XueBgurP16ApeKPjYro50BkuviTI+PWC86BMa2kTWqG9MOGPEh/3EP/PArHBcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739545784; c=relaxed/simple;
	bh=H60mwQfTdpJyI1H0dbAxC/qfJBS9DleIJCQJMqM2cRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eOlbNPUBhZdaeDejoYLq2ttHZpzaW6DkasYob7JPcrZqJOHEUb+4biHfZAzt/KRv7igwilLLtRQCyeOvxE06WWX52n1oLx30GvvOmFD9WHLc+0q5p2EYGWLL6wnAEffDzkUi5hlpO3GovOE6LfmuOR7856yhWRDSdBuX2RgH9jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/YbsMXR; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4396424d173so19320585e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 07:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739545781; x=1740150581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2zJBQ4YpMD9soorm1behI7kialp0O7eXmIoL4a6+Dak=;
        b=V/YbsMXRLngFfeqEsd1mQurbl5XKqYcmbgzKxkoeXOErcLzkj/4cXSF8v6sz38eaus
         J/2Lw0dmakd7KsTuhYBlZEtZo+ehO//PE1NTStox3pFMxqe2zN1Fr3CjND8tt0zyEjd8
         V3L4/96shQdHhZAwc/kMIKL0j6ae9QN7yrLgKs5AeRQe1kLG9byjZ9JKHmjl+Or1eNXf
         xuIj6psq/7AN125tTuviyyPf0gCTKHZ5E3fKqxM0MbsReEd1qY+vcrzNR6Uj7WF9DQ1k
         NDOSHyv/y17Y1Y6ylJ53Eq5uYHT7DwLrki0TRXDUSDgeMUniLAProD+9Odb/a/jfclUd
         TreA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739545781; x=1740150581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2zJBQ4YpMD9soorm1behI7kialp0O7eXmIoL4a6+Dak=;
        b=ZAzaZItI2J9IsJO08UULDN57ipLSuyfiBCXYlWr8+EIxyzk4wp6QfAvqGTxCwpVRde
         hwJ5x/5ZFx/8MUtzIdkM/+xm7B+XhyDTkF3UgUWf5FUzQXS0cngzP9q14XXsjHbY+kv5
         EdA7mQ++dbZhWSTst85UOTFzU/GCd3UPOCAEYZnThQhT03hwlMfHqvyS77dy8Zv/+zxz
         7LGfXYhO4OdcbiHBY2MCXI3h4GhVOcJyV06RENdSWWFALf9O89MYOaupDk42mUa/ksEI
         c4QcE3lU/z4gGUzvkE1tbAmuQvaWBzfwaOw2LYINZ0PGsTh1eN4AjREs2bWI7i0wrZRV
         CGvw==
X-Forwarded-Encrypted: i=1; AJvYcCUYLiGBHcZSnha8a5sSKRfJQwdUXiuH/fkrtYbF4dYSY2IPUwnyVVrzHGiy85TRyPh4sZe4jaLrPovVMSY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0ZC7QZf5E9Oba72n6J99ACptJG6PZAQAX/JC8ro79WCgIwWDA
	xcGsNS+W1EeUdsonb4I3Bg25kQ22RjG9ZCJADDDX/YtHuULmljH2
X-Gm-Gg: ASbGncvDC8g7Vuv5nLY2RxEnKVtR3vW0iZahEjZCopKbDFo+zuIEIIboBxbffJLcC+0
	PJGMANDKRHHTKL69VjeJYgWbivhZfGxOnZqrqc/nRj7cRSqTjnCinl9ty6LuCEjKNf1rBszNSln
	PullvDfat7M2GIGPE3iOPf+EGJKY0R6BZhcy335a2CRrwZKfOJEPApXI7uReRRc4ptHFmvmWQPO
	MegwfQz7PhL92x6ob7S/hqpf5oK63sKA7DXy/UEv313IhhnWqqB/GvPkArb17m+eAvmpWpty/Qz
	AWX/+NhPZM9bdeWK73wLlpSq
X-Google-Smtp-Source: AGHT+IFum9XwSDM3eHz0B6ljntzlQn+pA3NOKxdBCEjZBiROAFX1QudujE8vXpbeAXil4HYQjBINIg==
X-Received: by 2002:a5d:47c9:0:b0:38d:d5af:29b4 with SMTP id ffacd0b85a97d-38f24526116mr10583092f8f.45.1739545780313;
        Fri, 14 Feb 2025 07:09:40 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba533bee9dsm357447266b.173.2025.02.14.07.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 07:09:39 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH v2 2/2] x86/locking: Use asm_inline for {,try_}cmpxchg{64,128} emulations
Date: Fri, 14 Feb 2025 16:07:47 +0100
Message-ID: <20250214150929.5780-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20250214150929.5780-1-ubizjak@gmail.com>
References: <20250214150929.5780-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to [1], the usage of asm pseudo directives in the asm template
can confuse the compiler to wrongly estimate the size of the generated
code.  ALTERNATIVE macro expands to several asm pseudo directives,
so its usage in {,try_}cmpxchg{64,128} causes instruction length estimate
to fail by an order of magnitude (the specially instrumented compiler
reports the estimated length of these asm templates to be more than 20
instructions long). This wrong estimate further causes unoptimal inlining
decisions, unoptimal instruction scheduling and unoptimal code block
alignments for functions that use these locking primitives.

Use asm_inline [2], a feature that makes GCC pretend some inline
assembler code is tiny (while it would think it is huge), instead of
just asm. For code size estimation, the size of the asm is then taken as
the minimum size of one instruction, ignoring how many instructions
compiler thinks it is.

The effect of this patch on x86_64 target is minor, since 128-bit
functions are rarely used on this target. The code size of the resulting
defconfig object file stays the same:

   text    data     bss     dec     hex filename
27456612        4638523  814148 32909283        1f627e3 vmlinux-old.o
27456612        4638523  814148 32909283        1f627e3 vmlinux-new.o

but the patch has minor effect on code layout due to the different
scheduling decisions in functions containing changed macros.

There is no effect on x64_32 target, the code size of the resulting
defconfig object file and the code layout stays the same:

   text    data     bss     dec     hex filename
18883870        2679275 1707916 23271061        1631695 vmlinux-old.o
18883870        2679275 1707916 23271061        1631695 vmlinux-new.o

[1] https://gcc.gnu.org/onlinedocs/gcc/Size-of-an-asm.html
[2] https://gcc.gnu.org/pipermail/gcc-patches/2018-December/512349.html

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
---
v2: Expand commit message with the explanation of asm_inline
    the explanation of benefits of the patch and with some code
    size measurements.
---
 arch/x86/include/asm/cmpxchg_32.h | 32 +++++++------
 arch/x86/include/asm/percpu.h     | 77 +++++++++++++++----------------
 2 files changed, 55 insertions(+), 54 deletions(-)

diff --git a/arch/x86/include/asm/cmpxchg_32.h b/arch/x86/include/asm/cmpxchg_32.h
index fd1282a783dd..95b5f990ca88 100644
--- a/arch/x86/include/asm/cmpxchg_32.h
+++ b/arch/x86/include/asm/cmpxchg_32.h
@@ -91,12 +91,14 @@ static __always_inline bool __try_cmpxchg64_local(volatile u64 *ptr, u64 *oldp,
 	union __u64_halves o = { .full = (_old), },			\
 			   n = { .full = (_new), };			\
 									\
-	asm volatile(ALTERNATIVE(_lock_loc				\
-				 "call cmpxchg8b_emu",			\
-				 _lock "cmpxchg8b %a[ptr]", X86_FEATURE_CX8) \
-		     : ALT_OUTPUT_SP("+a" (o.low), "+d" (o.high))	\
-		     : "b" (n.low), "c" (n.high), [ptr] "S" (_ptr)	\
-		     : "memory");					\
+	asm_inline volatile(						\
+		ALTERNATIVE(_lock_loc					\
+			    "call cmpxchg8b_emu",			\
+			    _lock "cmpxchg8b %a[ptr]", X86_FEATURE_CX8)	\
+		: ALT_OUTPUT_SP("+a" (o.low), "+d" (o.high))		\
+		: "b" (n.low), "c" (n.high),				\
+		  [ptr] "S" (_ptr)					\
+		: "memory");						\
 									\
 	o.full;								\
 })
@@ -119,14 +121,16 @@ static __always_inline u64 arch_cmpxchg64_local(volatile u64 *ptr, u64 old, u64
 			   n = { .full = (_new), };			\
 	bool ret;							\
 									\
-	asm volatile(ALTERNATIVE(_lock_loc				\
-				 "call cmpxchg8b_emu",			\
-				 _lock "cmpxchg8b %a[ptr]", X86_FEATURE_CX8) \
-		     CC_SET(e)						\
-		     : ALT_OUTPUT_SP(CC_OUT(e) (ret),			\
-				     "+a" (o.low), "+d" (o.high))	\
-		     : "b" (n.low), "c" (n.high), [ptr] "S" (_ptr)	\
-		     : "memory");					\
+	asm_inline volatile(						\
+		ALTERNATIVE(_lock_loc					\
+			    "call cmpxchg8b_emu",			\
+			    _lock "cmpxchg8b %a[ptr]", X86_FEATURE_CX8) \
+		CC_SET(e)						\
+		: ALT_OUTPUT_SP(CC_OUT(e) (ret),			\
+				"+a" (o.low), "+d" (o.high))		\
+		: "b" (n.low), "c" (n.high),				\
+		  [ptr] "S" (_ptr)					\
+		: "memory");						\
 									\
 	if (unlikely(!ret))						\
 		*(_oldp) = o.full;					\
diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 0ab991fba7de..08f5f61690b7 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -348,15 +348,14 @@ do {									\
 	old__.var = _oval;						\
 	new__.var = _nval;						\
 									\
-	asm qual (ALTERNATIVE("call this_cpu_cmpxchg8b_emu",		\
-			      "cmpxchg8b " __percpu_arg([var]), X86_FEATURE_CX8) \
-		  : ALT_OUTPUT_SP([var] "+m" (__my_cpu_var(_var)),	\
-				  "+a" (old__.low),			\
-				  "+d" (old__.high))			\
-		  : "b" (new__.low),					\
-		    "c" (new__.high),					\
-		    "S" (&(_var))					\
-		  : "memory");						\
+	asm_inline qual (						\
+		ALTERNATIVE("call this_cpu_cmpxchg8b_emu",		\
+			    "cmpxchg8b " __percpu_arg([var]), X86_FEATURE_CX8) \
+		: ALT_OUTPUT_SP([var] "+m" (__my_cpu_var(_var)),	\
+				"+a" (old__.low), "+d" (old__.high))	\
+		: "b" (new__.low), "c" (new__.high),			\
+		  "S" (&(_var))						\
+		: "memory");						\
 									\
 	old__.var;							\
 })
@@ -378,17 +377,16 @@ do {									\
 	old__.var = *_oval;						\
 	new__.var = _nval;						\
 									\
-	asm qual (ALTERNATIVE("call this_cpu_cmpxchg8b_emu",		\
-			      "cmpxchg8b " __percpu_arg([var]), X86_FEATURE_CX8) \
-		  CC_SET(z)						\
-		  : ALT_OUTPUT_SP(CC_OUT(z) (success),			\
-				  [var] "+m" (__my_cpu_var(_var)),	\
-				  "+a" (old__.low),			\
-				  "+d" (old__.high))			\
-		  : "b" (new__.low),					\
-		    "c" (new__.high),					\
-		    "S" (&(_var))					\
-		  : "memory");						\
+	asm_inline qual (						\
+		ALTERNATIVE("call this_cpu_cmpxchg8b_emu",		\
+			    "cmpxchg8b " __percpu_arg([var]), X86_FEATURE_CX8) \
+		CC_SET(z)						\
+		: ALT_OUTPUT_SP(CC_OUT(z) (success),			\
+				[var] "+m" (__my_cpu_var(_var)),	\
+				"+a" (old__.low), "+d" (old__.high))	\
+		: "b" (new__.low), "c" (new__.high),			\
+		  "S" (&(_var))						\
+		: "memory");						\
 	if (unlikely(!success))						\
 		*_oval = old__.var;					\
 									\
@@ -419,15 +417,14 @@ do {									\
 	old__.var = _oval;						\
 	new__.var = _nval;						\
 									\
-	asm qual (ALTERNATIVE("call this_cpu_cmpxchg16b_emu",		\
-			      "cmpxchg16b " __percpu_arg([var]), X86_FEATURE_CX16) \
-		  : ALT_OUTPUT_SP([var] "+m" (__my_cpu_var(_var)),	\
-				  "+a" (old__.low),			\
-				  "+d" (old__.high))			\
-		  : "b" (new__.low),					\
-		    "c" (new__.high),					\
-		    "S" (&(_var))					\
-		  : "memory");						\
+	asm_inline qual (						\
+		ALTERNATIVE("call this_cpu_cmpxchg16b_emu",		\
+			    "cmpxchg16b " __percpu_arg([var]), X86_FEATURE_CX16) \
+		: ALT_OUTPUT_SP([var] "+m" (__my_cpu_var(_var)),	\
+				"+a" (old__.low), "+d" (old__.high))	\
+		: "b" (new__.low), "c" (new__.high),			\
+		  "S" (&(_var))						\
+		: "memory");						\
 									\
 	old__.var;							\
 })
@@ -449,19 +446,19 @@ do {									\
 	old__.var = *_oval;						\
 	new__.var = _nval;						\
 									\
-	asm qual (ALTERNATIVE("call this_cpu_cmpxchg16b_emu",		\
-			      "cmpxchg16b " __percpu_arg([var]), X86_FEATURE_CX16) \
-		  CC_SET(z)						\
-		  : ALT_OUTPUT_SP(CC_OUT(z) (success),			\
-				  [var] "+m" (__my_cpu_var(_var)),	\
-				  "+a" (old__.low),			\
-				  "+d" (old__.high))			\
-		  : "b" (new__.low),					\
-		    "c" (new__.high),					\
-		    "S" (&(_var))					\
-		  : "memory");						\
+	asm_inline qual (						\
+		ALTERNATIVE("call this_cpu_cmpxchg16b_emu",		\
+			    "cmpxchg16b " __percpu_arg([var]), X86_FEATURE_CX16) \
+		CC_SET(z)						\
+		: ALT_OUTPUT_SP(CC_OUT(z) (success),			\
+				[var] "+m" (__my_cpu_var(_var)),	\
+				"+a" (old__.low), "+d" (old__.high))	\
+		: "b" (new__.low), "c" (new__.high),			\
+		  "S" (&(_var))						\
+		: "memory");						\
 	if (unlikely(!success))						\
 		*_oval = old__.var;					\
+									\
 	likely(success);						\
 })
 
-- 
2.42.0


