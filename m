Return-Path: <linux-kernel+bounces-445926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD909F1D93
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 09:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 413C9168521
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 08:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171A113B58E;
	Sat, 14 Dec 2024 08:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KguZ/7z/"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B181611712
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 08:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734166038; cv=none; b=F3ZEoZGhqTJ84l22NpEIZm+HQJr5tNRHn16D0S4lQ0HizIHjsY9sgq3dZovkY4yrlfx1grcCFH9peRaRuID37OczHBiqbkZGZ0M4u272m6ylYFYLJ0+BNIw8khS5r4Qu/gQW0Z6zREV6nNq9qOyeZC0GIBY0Em0J6m5NnwAScsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734166038; c=relaxed/simple;
	bh=n1ee9IBnPmfq7/Shf20X2zWTYfJuZ7BnyFWM46LP9wI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gbuzmZy9n0Hk4AImV0PJYATyd1KvwLgeWKogy9I1SwiWylmQHcF6XQQBQcSrMjhA131p7HyFfn6zE5YaxIdsSp8+PlboNjwxoInW/V0Lb4IrEG/vajDul1tINBAW2V8Dw4lMWEppfcOI7eGS1teWsFpIYQWiA/8IC37JjsDgqUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KguZ/7z/; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9e8522445dso500014866b.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 00:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734166035; x=1734770835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JEZ0WMqPAm1483QfOwXmJttKh7VNBOs17fK+Ko3h7hM=;
        b=KguZ/7z/IBaBDSxOoioVXAuR964TPp99yghn4M+fIlHgV0FA1+j6XoQApqZePtdWyw
         TKWEI6M1VyOAim3dndg/MuU0Pk26bEXntb4PGv2g/Zxs6rDJlFc7w1eTWF8soyuegMXp
         l1amx891w7scuNRqpWfja5Zym/jqZ0FJiQ3Dp8vw5zkap8eCln6oFEMmcL/AyGes2nl7
         ysl9YaUHeEVY9p3wfcr8LQXostSUks2JJIW1uNFCpWmLy1eCiCkUxu0xjXD29UW+17cf
         LlrjDF27rxQS/wBJKRS3hiZ0x+G4DJg0cw9DTBgdBmZb/tQBxPmYEhuijYz3DwLZm7LR
         FHwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734166035; x=1734770835;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JEZ0WMqPAm1483QfOwXmJttKh7VNBOs17fK+Ko3h7hM=;
        b=NcKgOJci8YI4BI0EWhMzLnN/F4A8c6jq2UOhZozVuqOeuW7HjqhhqfpFcR6ha1XCPu
         lzPqHM4HtbO/4Bt/i4/auXD4vGjGLqnHkp2Nwo/lHaLlyCLp9ISRVboQ0O/EToVjpmVt
         m+LhkDaKt/uFrLnGSG/stNgGlPejwuRFI9z/d3ktoxnoKojabAhjdy3E0cLrQJ7apfXn
         KTjLreC36QMzmiqL2z6P7oBERvZDNC41gy+xHVB4FMNY1/7RpRsSL+Xz/b8kJG3OMzlD
         2KP1ZQSR1fq/X1oupZVhI+ZFcb+Op3/PZ9+JZUbQpar2BPV7c06bZurJ+2kPLe5fSGSZ
         Rj6A==
X-Forwarded-Encrypted: i=1; AJvYcCWW/PJzN6FOVa44UgC5jpwzUG99r8zxDpDncylb1jWoafObo8PBd1C1HCRH7CG0LLmoEYm6MBhU8thdMuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+l/vyR4yJHYRJmxkxTKHh3e0jzyeS6h5l4kx40olf/zMB1EgO
	Qy7GyOPuwrjBO241XvCwRsKw5QIuKQCJtbDdyVARXZMDyD8DNPSw
X-Gm-Gg: ASbGncskvhmcw1A75YtDm+7FpTMfJMSW7HxX+4t3r+34oKbe1GFeT4vYXkuMiEPWtAA
	e1QhXiQcSP0tQecbF6L0/7VfC8XFJupPGCyL/0tn72dam9iqPAUbGk8jl0MA2kHfcaVoQo3JvjS
	2NIJMvw6RXBP8ZrobgIXq0NS3P6t6IlcSwSh+YXS+CsUVfeqqFF7BzEaL14Reu+Xlzjeajr9E2y
	CMXyEKTBz6PWSbb6wuFRJJP5RD2KsGSImx3lYdnA6JjQzlCWESjtbmzTZXgQp50DA==
X-Google-Smtp-Source: AGHT+IFcgN7dNOuus/q8jsBVrvzVyHNsGFwthZiwtvR8aGkddj0IiyJeHXh2Nq9GOLBCxFX5hoTq8w==
X-Received: by 2002:a17:907:96a5:b0:aa6:9c08:cd3 with SMTP id a640c23a62f3a-aab77ec88d2mr574788066b.48.1734166034751;
        Sat, 14 Dec 2024 00:47:14 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab963913d1sm67719166b.165.2024.12.14.00.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 00:47:13 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jan Beulich <JBeulich@suse.com>
Subject: [PATCH RESEND] locking/atomic/x86: Use ALT_OUTPUT_SP() for percpu_{,try_}cmpxchg{64,128}_op()
Date: Sat, 14 Dec 2024 09:46:37 +0100
Message-ID: <20241214084700.3684-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

percpu_{,try_}cmpxchg{64,128}() macros use CALL instruction inside
asm statement in one of their alternatives. Use ALT_OUTPUT_SP()
macro to add required dependence on %esp register.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Jan Beulich <JBeulich@suse.com>
---
 arch/x86/include/asm/percpu.h | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index e525cd85f999..5496e712c1d5 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -350,9 +350,9 @@ do {									\
 									\
 	asm qual (ALTERNATIVE("call this_cpu_cmpxchg8b_emu",		\
 			      "cmpxchg8b " __percpu_arg([var]), X86_FEATURE_CX8) \
-		  : [var] "+m" (__my_cpu_var(_var)),			\
-		    "+a" (old__.low),					\
-		    "+d" (old__.high)					\
+		  : ALT_OUTPUT_SP([var] "+m" (__my_cpu_var(_var)),	\
+				  "+a" (old__.low),			\
+				  "+d" (old__.high))			\
 		  : "b" (new__.low),					\
 		    "c" (new__.high),					\
 		    "S" (&(_var))					\
@@ -381,10 +381,10 @@ do {									\
 	asm qual (ALTERNATIVE("call this_cpu_cmpxchg8b_emu",		\
 			      "cmpxchg8b " __percpu_arg([var]), X86_FEATURE_CX8) \
 		  CC_SET(z)						\
-		  : CC_OUT(z) (success),				\
-		    [var] "+m" (__my_cpu_var(_var)),			\
-		    "+a" (old__.low),					\
-		    "+d" (old__.high)					\
+		  : ALT_OUTPUT_SP (CC_OUT(z) (success),			\
+				   [var] "+m" (__my_cpu_var(_var)),	\
+				   "+a" (old__.low),			\
+				   "+d" (old__.high))			\
 		  : "b" (new__.low),					\
 		    "c" (new__.high),					\
 		    "S" (&(_var))					\
@@ -421,9 +421,9 @@ do {									\
 									\
 	asm qual (ALTERNATIVE("call this_cpu_cmpxchg16b_emu",		\
 			      "cmpxchg16b " __percpu_arg([var]), X86_FEATURE_CX16) \
-		  : [var] "+m" (__my_cpu_var(_var)),			\
-		    "+a" (old__.low),					\
-		    "+d" (old__.high)					\
+		  : ALT_OUTPUT_SP ([var] "+m" (__my_cpu_var(_var)),	\
+				   "+a" (old__.low),			\
+				   "+d" (old__.high))			\
 		  : "b" (new__.low),					\
 		    "c" (new__.high),					\
 		    "S" (&(_var))					\
@@ -452,10 +452,10 @@ do {									\
 	asm qual (ALTERNATIVE("call this_cpu_cmpxchg16b_emu",		\
 			      "cmpxchg16b " __percpu_arg([var]), X86_FEATURE_CX16) \
 		  CC_SET(z)						\
-		  : CC_OUT(z) (success),				\
-		    [var] "+m" (__my_cpu_var(_var)),			\
-		    "+a" (old__.low),					\
-		    "+d" (old__.high)					\
+		  : ALT_OUTPUT_SP (CC_OUT(z) (success),			\
+				   [var] "+m" (__my_cpu_var(_var)),	\
+				   "+a" (old__.low),			\
+				   "+d" (old__.high))			\
 		  : "b" (new__.low),					\
 		    "c" (new__.high),					\
 		    "S" (&(_var))					\
-- 
2.42.0


