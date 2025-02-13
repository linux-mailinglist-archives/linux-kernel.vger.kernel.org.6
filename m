Return-Path: <linux-kernel+bounces-513758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C472DA34E4C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 20:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D85893A9CBA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 19:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAAE206F2A;
	Thu, 13 Feb 2025 19:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYMl15Sn"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51B824A048
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 19:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739474116; cv=none; b=VMPITWKB+kHUteVYQk3pYPaJaXIWFe1P4ygN5adXqnw0eKWg3xsArsEcpYq9Gbnl3SnwDLgupYDPie1fS+CAZ0Y+8Hay5VVV6sp4y9Rw55sdakkTLI0cTTyKf7MdqPKTq4zNGPcFxchFE51o9ZwsR9wAbPZSEBChkRhWhzlRjzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739474116; c=relaxed/simple;
	bh=3nHtG7PoyixUCtDxS+Y49PjpO3dsXgDgWOyYmD4MGGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZYgxWp++26PJneodVXto7JI6q/xIt54dvtWecQSSKWlbThIfLqGbKJjExddQ0eRSIR9A2TlvgkIQUxcG+c1gXM/hXcP6n5FnLrNUoYNbDf2snEozQkO36ddjd+VvpI78Sh0c8dAwMSZyy/5DeZyRPhMM8sjPDpvKuIjTOQ3dHkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aYMl15Sn; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5de849a0b6cso2299474a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 11:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739474113; x=1740078913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ll3EDDTY/6Dh7a8MWuMvGIgfSvEqbbqhDX1OHStQPk=;
        b=aYMl15SnQSuN7Wv93pbJ9LZkE/CjHBLpM8uS6bgOBJXzxxhNjKD0gp4quXiH9jZdNq
         IVd1pKbrYgF0l67VjK5/5mXFHv2YGMYMcE2VoPAkRRlP+lustFkTXxcSS01JWYAb7LGV
         SmJiC79DuneYNBA0vJNlNtXCRgG30/4+FUlLefW5ePqBL8bUUMpt2+OMz55/+VupUTld
         hL0Pk/y9Gv5ikefvLiHtwZnqL6/VTWMNFmfoRKW02j9yCTeUo9nlkF7Nio2rBEt1D+Mf
         Ie9lebxZhOON/6fn7ihm/dEmsJFnUCX3PtZqnQJnIIA1fCW6JqSNvTVJgtIL/WY+aUAu
         wJww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739474113; x=1740078913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ll3EDDTY/6Dh7a8MWuMvGIgfSvEqbbqhDX1OHStQPk=;
        b=CQIpMmT6VBYw1QooFBgKzg8g013XO3cQs+AyaXno+QWOl/e+LHdBne7gle5i3ejT5v
         6HirGclqivrPiPOYw7yZTOzOauqz5/Cai4D0SsBg3xT4SGlxaKsAqqU08pvtUMA4TUTq
         m4d9TaaMnnnO96at6dbiXIdURG8oFenAlwzCj3ilaTGndXz9LaWyzNOS9YNQzyCf3u/O
         NnWsrNc3rBe8z3CzjFQ1OOp5GMj+uih9fjSdA7hogNLoQWjTXiRzBZzeCHifCD8iZ5cy
         s0CZqbShESQrRs3CbV5bYVzdxzgaSjoh/S3oDR4Y/lRT4UJ3PETOiZL4BRBcbCjJnSxw
         EIGA==
X-Forwarded-Encrypted: i=1; AJvYcCXimiBdgvr3fg9D3uToLH4cyueJvtFvIZAqvEy1uIgDysEssC7wPyk+DgvJXXPeLpkrLdAoCV+nW592sB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbQvwmAfdM++GTRbW6vdC0AoWaZW/gIXrzO6VsvbEx8a0CRv+3
	DjJBf9F0hlBHumTPfz7j3+Yth6S2aibqYLr9KK56BrwOzbuVnpSg
X-Gm-Gg: ASbGncv/lH6q+U9Ry+A5jLT768OocivYT/Qtw3KQvhr45e/G99WXibszFG72XGOf1L2
	Jsd6qxI+FOTuUWFG6xIuHjXJ1oqbObz72c9/jETvvRdcR0OXWdt/4c6OmH2SUmfwLnSyA9RVri1
	Mg9p1H8GR1WXQ2REFfO8RxUpEFrUQJChW1MaPadFCmuQnUL/UhGIzKTzGx4nD64EUAhRZPY6uhz
	6VaymyCDL1lkqc6yEEfsoiNQMSqM/QObiqw5qDqrqxCDUxcArpCYeRGS32U3w3DiyBIXVsBe4/u
	Ebmim6qoI7gPHBhIEi2tmH+G
X-Google-Smtp-Source: AGHT+IExUVZvjx/iFh1WkVP3rRpgO7ilttlIBKKBcGqGbRT5JPyBk2NmKS1r9fk+bJSkDogTrrzUaQ==
X-Received: by 2002:a05:6402:5d1:b0:5d9:a62:32b with SMTP id 4fb4d7f45d1cf-5dec9d326b0mr4771387a12.7.1739474112708;
        Thu, 13 Feb 2025 11:15:12 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece288e2dsm1634508a12.80.2025.02.13.11.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 11:15:12 -0800 (PST)
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
Subject: [PATCH RESEND 2/2] x86/locking: Use asm_inline for {,try_}cmpxchg{64,128} emulations
Date: Thu, 13 Feb 2025 20:14:26 +0100
Message-ID: <20250213191457.12377-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20250213191457.12377-1-ubizjak@gmail.com>
References: <20250213191457.12377-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to [1], the usage of asm pseudo directives in the asm template
can confuse the compiler to wrongly estimate the size of the generated
code. ALTERNATIVE macro expands to several asm pseudo directives, so
its usage in {,try_}cmpxchg{64,128} causes instruction length estimate
to fail by an order of magnitude (the compiler estimates the length of
an asm to be more than 20 instructions). This wrong estimate further
causes unoptimal inlining decisions for functions that use these
locking primitives.

Use asm_inline instead of just asm. For inlining purposes, the size of
the asm is then taken as the minimum size, ignoring how many instructions
compiler thinks it is.

[1] https://gcc.gnu.org/onlinedocs/gcc/Size-of-an-asm.html

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


