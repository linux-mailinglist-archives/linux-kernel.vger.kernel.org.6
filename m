Return-Path: <linux-kernel+bounces-555005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC73A5A468
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AC4C16E733
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACFE1DD526;
	Mon, 10 Mar 2025 20:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FR6LuN6b"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDF11C68B6
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 20:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741637309; cv=none; b=twRiNiBLlAVUtQeBS0vCojpgJdn4Pcc/Uw3WImFEHHss8GFjobJ28+qLSRFl7EOi/kMvZxsJIbleZ9YVGKKU+404fyMFnZORt07sr0sU/ca2WbrVCMeOfrvAMsvyp9z+RNCyOVVu9fnlfHdpdI1SeYwvJzfBTZC+v9Kqgk17MqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741637309; c=relaxed/simple;
	bh=W4MnZsc68ld3lXP29vsYvWNJ6M+A46UOlKGhnwrc3wQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PVg/ORvWUjHcOBi6hE04rR/pnKn38IM0Zfm5FwZn49slT9A3tFBXGfpiJruC4wf+FwmZnty6/k0aUWhtQniND/XqGQsZ2W2N06W/q7sVayDt7TWt1+UqmJ2DO31iiQR4o50l/xD9DMpY0SpJ0TYrpYNELyR36reVJy+tD/15oTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FR6LuN6b; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aaecf50578eso838945566b.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 13:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741637306; x=1742242106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o7xn96mq2al+c78bVPnQ8eE3aKux8CyU08dkJOBHjIU=;
        b=FR6LuN6by343/3EXAlN5BTFkyejK9s2WkZf481wmKUvFrCbJQ1War+zTBESo9rSYHw
         lV1OQQnsHspC5gWjOG0lwi5ILcIhG0z9LfQrYoQTUUEnfvXj+whv5UNI40Of5MAUjNE/
         3AnrV/sU6Te2chRHa51KzzF8Ticvhgc/Epco1QM+U+kQaXaHt6lNWAHdO6XRuL3cXekQ
         UbcpvBE7AM4rfFZzjx8SFTTvF6anbj3UlbL9mFmloK24fltA+x8hJEXJp4abxgoOb734
         f2MVk2UoZ8VkGS//KmfnLyeTBp3AGnOO7myy2aahWqrIB3x/bwSrYFEyaTvR5tXEynOL
         dAew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741637306; x=1742242106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o7xn96mq2al+c78bVPnQ8eE3aKux8CyU08dkJOBHjIU=;
        b=m9zUqTauvEmUMJEaFBRZMr6+CYi1RIT4OedS+oNUCAPqrbVV8tsqMDTC5bAMQeRIul
         eVkJhCWb4AtHItZQU3Cybcp1bR6D+wZmO7tlmsCXYm0P2G13jRmN5iUDo2mcSuy5MsnO
         OJtsUoupt2DrfAYbqfAKxpikuVFRwNEdNZp2gIUfRBW8G5+hLPfYMG0JTwrPQ7ZYcIdI
         wE/rEqznsQnuV14VR9YlouYpCvXMV/o6pZ1VZnq2nSN4osxScsH7Amwe/5ODo6mCboUM
         0gW5CkI5TFnNLtIQ2A3r89jKEWbg9NIUYbXCtxPA0CxzST54g9q4HCszLo69HWIvjZyd
         1GYw==
X-Forwarded-Encrypted: i=1; AJvYcCWmUhLGMXETMAhOD0Z2EySFVeJ9Pn5QdRHQFa4sxtPX+lSYX5Axdv1UxF6moJ++nSLuu/aoEumnDHgy4DI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJicvDPwSSmECYREEkRXZUqeLxgdJxWTxP6vbexVtCudIlCi8Q
	P8w74ityNuqw1j//YgFkfrOCMSw0cwd/RfXViI/zWOh3VeVWpiq/
X-Gm-Gg: ASbGncuRZHmzV04+U9Qq26V2g9jsR7jbhCjbMlgXrLUm8SUkuXGWoEQIxclRNQld7w0
	yGHCPQDZIQGe7HPr8CrpKtoXNSz8HvkYxtzyu+993w/P+6RbwNq330vLvu6Ag9sZot9pRgJCLN9
	59zWSx3U+Y8sKns0XlrjVEIm6TaC1VMr2gF+os33eqtGwkroBXBloupc83i6eMFM98TTusoASTo
	Npx3+vgZ9UodDeV+MQDeZBafU8IKANSkttEY3Ua6bV+Wn/BP7mpHRKAOb6j/omiuMsvkEbtixTk
	2/gqqZbskwq9l+tx5893lTPczEYHRY6KzhU9ywrMCyajWGcIxAFuzQ==
X-Google-Smtp-Source: AGHT+IF7taUyj2bYo5YC5LTMjrwZ/C0oavXSrSwzWPTl/ZiNmWXcfiY+FqvsHNe0yJwIjI8Mkl8yaA==
X-Received: by 2002:a17:907:8283:b0:ac2:7a97:87fb with SMTP id a640c23a62f3a-ac27a978b3bmr1016676966b.33.1741637305997;
        Mon, 10 Mar 2025 13:08:25 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac292098998sm307072066b.182.2025.03.10.13.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 13:08:25 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/hweight: Fix and improve __arch_hweight{32,64}() assembly
Date: Mon, 10 Mar 2025 21:08:04 +0100
Message-ID: <20250310200817.33581-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

a) Use ASM_CALL_CONSTRAINT to prevent inline asm that includes call
instruction from being scheduled before the frame pointer gets set
up by the containing function, causing objtool to print a "call
without frame pointer save/setup" warning.

b) Use asm_inline to instruct the compiler that the size of asm()
is the minimum size of one instruction, ignoring how many instructions
the compiler thinks it is. ALTERNATIVE macro that expands to several
pseudo directives causes instruction length estimate to count
more than 20 instructions.

c) Use named operands in inline asm.

More inlining causes slight increase in the code size:

   text    data     bss     dec     hex filename
27261832        4640296  814660 32716788        1f337f4 vmlinux-new.o
27261222        4640320  814660 32716202        1f335aa vmlinux-old.o

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/include/asm/arch_hweight.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/arch_hweight.h b/arch/x86/include/asm/arch_hweight.h
index ba88edd0d58b..20b0633744e4 100644
--- a/arch/x86/include/asm/arch_hweight.h
+++ b/arch/x86/include/asm/arch_hweight.h
@@ -16,10 +16,10 @@ static __always_inline unsigned int __arch_hweight32(unsigned int w)
 {
 	unsigned int res;
 
-	asm (ALTERNATIVE("call __sw_hweight32", "popcntl %1, %0", X86_FEATURE_POPCNT)
-			 : "="REG_OUT (res)
-			 : REG_IN (w));
-
+	asm_inline (ALTERNATIVE("call __sw_hweight32",
+				"popcntl %[val], %[cnt]", X86_FEATURE_POPCNT)
+			 : [cnt] "="REG_OUT (res), ASM_CALL_CONSTRAINT
+			 : [val] REG_IN (w));
 	return res;
 }
 
@@ -44,10 +44,10 @@ static __always_inline unsigned long __arch_hweight64(__u64 w)
 {
 	unsigned long res;
 
-	asm (ALTERNATIVE("call __sw_hweight64", "popcntq %1, %0", X86_FEATURE_POPCNT)
-			 : "="REG_OUT (res)
-			 : REG_IN (w));
-
+	asm_inline (ALTERNATIVE("call __sw_hweight64",
+				"popcntq %[val], %[cnt]", X86_FEATURE_POPCNT)
+			 : [cnt] "="REG_OUT (res), ASM_CALL_CONSTRAINT
+			 : [val] REG_IN (w));
 	return res;
 }
 #endif /* CONFIG_X86_32 */
-- 
2.42.0


