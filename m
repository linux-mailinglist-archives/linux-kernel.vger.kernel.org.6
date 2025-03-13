Return-Path: <linux-kernel+bounces-559536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E873FA5F51F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DCFD3B36C4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FFE2676F2;
	Thu, 13 Mar 2025 13:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uy5yJGUL"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1C71754B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 13:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741870961; cv=none; b=Ch2tJ29+HuCx1OiozZwCn46pCpq4hCqjhN6lDYG6VzUwwm1LYlFsa0ljfwpHbNaY0AbZn+T3SwU1K6zoLyKKTpxHcd2KdtoZJpzfJtKMQbn5LD2ndUm9wasa0nqZ7ba23IlH5nMXW/5zuUlmKaNQv2hEsYPEDQvjCn6XE2tJI9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741870961; c=relaxed/simple;
	bh=o0DclmRwlFXyQgT3v5Tk9sYeNUcxfabNF9fq01Et8hE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jz1oXlyAHyf8SMcQ+IL8vXIxUwSIRWZ8uSKz9c3ZAKbdEf0pcEtrVxE6u9YWAaMZGw/QbAISXbvRE2GNl0ZMCQhmCZsIQy794KAU979KKZDiG8ERK2kSp2gpic9LyZRvHypDHAcvvxvtGQqs+pAOrv3n+DeKV7lpoBRBsB+h3Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uy5yJGUL; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac2ed007aacso191992766b.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 06:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741870958; x=1742475758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n3LY/SRYvxlV4NEg6utLUEJ9zrccG6OpFAv04Yl9fx4=;
        b=Uy5yJGULkrGj+Q7eInV6EefsIDCqjjbbiuUji6ORt1Ct3j6VMjXsvLeEiN83jCObZo
         gN7gTru6UBdtgd3hmlORDIz+sET+yuGfk7mEjgiCyb5fcsymlMOfnKO9ZBGTn8AFiKfn
         LDVm1wGqjCWoKcVuiyXnHN3IVlMiNMifBTOC9zN4H8+HmfD/vG27xE8j95/cNwY3ckRl
         6SQB9Y9debDS2Jf0iF14wfnU1t6varcXHSd3OtMGhOS3Ymrh9j1LBZX+seO94GvElCCI
         YfSSocXDge8v66wSahQ7JGI6iUwNJuA0zDnJG+mANAyzqfh/LQWuszApFu26xkf5MaiU
         miNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741870958; x=1742475758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n3LY/SRYvxlV4NEg6utLUEJ9zrccG6OpFAv04Yl9fx4=;
        b=hk7uUcRwY+j8xGlZXzONshhZA6JobcVzh/7T1JH2kKGB4EdbeATHROZuKcVw97O3XS
         B+A/lprY/MfMM9NJKYjqmQR0EUB0qOKYVR7K7xoUUyRvyr/i1JCq4FmM94H+ELILhvpL
         dmHo9VJM/wXresw7KOnpcjl5nBVdZkcZba02qSIxaEcUlT2IPUl85kML43Af/bZDHs6P
         XwfZ09JrCqrcwlcYggWlX6PgiaWx4tM3xRwE4GBHDwEJeiTDrEEZWKsTyuuwr1a15jQW
         GwXBX4Q+8fxrCJHZ+wUHFNWYrXAZntnUzNAoX92MTCDhCsA4x0d/HcHLQ0CfcrucCgNp
         mSKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJD0WcVwpNnvKd8IhHMvle4KDMKI2Q9nKB4jHp8/iCvgHt4RgVcHKOv3v8xlCH1MiZH8JPI1bxBjwPGNM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpc41oDv+ZaGSIcobMMIN3yIyc6XUM237YX0kOaORGZsP9503g
	cYLrhs+q8vud29KNEgF3ZzzguLz37U5tPg1bQlCi+1MEqhYNB4L8
X-Gm-Gg: ASbGncsQZ5Xh1eC2XhBplbNIatjjFhBtzYl8jg3j9qlWFZ1e+c2W+JFyOp35I9kI6aW
	bD6rDoO/zEABpY4tL8fCNGVffi16gRGBmw9qUPwfylmgCW4MqaRgBoBnZWJ4GkyKlKX814YAAXZ
	d3fhavGKFaMhskTX6fhpW0dY2h3nrUiMnv9TD44xqJl1bpM/kXgRuik9WIAIfIwDVI0x1Y/RF6K
	UkSxLb4VOdF5mN62aSZ9VEqlf6rCfRwDrBooMKhLYwg5dlfwHHOxk0uzR5cfGwFSBQ4EBBAq6qg
	tVYxEj6UQheOUtgHw8nh30/um+B+3HWgWiQe
X-Google-Smtp-Source: AGHT+IEYIgRhvf9h4wG2PQf1gAsvv+5/KkAAYYriEsdqfpLq/LWfDieYAzMMnL5sD5vPAc+uZEP1gw==
X-Received: by 2002:a17:907:6d25:b0:ac2:2ba5:5471 with SMTP id a640c23a62f3a-ac2b9de98d7mr1551417166b.24.1741870956853;
        Thu, 13 Mar 2025 06:02:36 -0700 (PDT)
Received: from fedora.. ([193.77.86.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3149d0bcdsm79041766b.90.2025.03.13.06.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 06:02:36 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/fpu: Use XSAVE{,OPT,C,S} and XRSTOR{,S} mnemonics in xstate.h
Date: Thu, 13 Mar 2025 14:02:27 +0100
Message-ID: <20250313130251.383204-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current minimum required version of binutils is 2.25, which
supports XSAVE{,OPT,C,S} and XRSTOR{,S} instruction mnemonics.

Replace the byte-wise specification of XSAVE{,OPT,C,S}
and XRSTOR{,S} with these proper mnemonics.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/kernel/fpu/xstate.h | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index aa16f1a1bbcf..1418423bc4c9 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -94,18 +94,17 @@ static inline int update_pkru_in_sigframe(struct xregs_state __user *buf, u64 ma
 /* XSAVE/XRSTOR wrapper functions */
 
 #ifdef CONFIG_X86_64
-#define REX_PREFIX	"0x48, "
+#define REX_SUFFIX	"64"
 #else
-#define REX_PREFIX
+#define REX_SUFFIX
 #endif
 
-/* These macros all use (%edi)/(%rdi) as the single memory argument. */
-#define XSAVE		".byte " REX_PREFIX "0x0f,0xae,0x27"
-#define XSAVEOPT	".byte " REX_PREFIX "0x0f,0xae,0x37"
-#define XSAVEC		".byte " REX_PREFIX "0x0f,0xc7,0x27"
-#define XSAVES		".byte " REX_PREFIX "0x0f,0xc7,0x2f"
-#define XRSTOR		".byte " REX_PREFIX "0x0f,0xae,0x2f"
-#define XRSTORS		".byte " REX_PREFIX "0x0f,0xc7,0x1f"
+#define XSAVE		"xsave" REX_SUFFIX " %[xa]"
+#define XSAVEOPT	"xsaveopt" REX_SUFFIX " %[xa]"
+#define XSAVEC		"xsavec" REX_SUFFIX " %[xa]"
+#define XSAVES		"xsaves" REX_SUFFIX " %[xa]"
+#define XRSTOR		"xrstor" REX_SUFFIX " %[xa]"
+#define XRSTORS		"xrstors" REX_SUFFIX " %[xa]"
 
 /*
  * After this @err contains 0 on success or the trap number when the
@@ -114,10 +113,10 @@ static inline int update_pkru_in_sigframe(struct xregs_state __user *buf, u64 ma
 #define XSTATE_OP(op, st, lmask, hmask, err)				\
 	asm volatile("1:" op "\n\t"					\
 		     "xor %[err], %[err]\n"				\
-		     "2:\n\t"						\
+		     "2:\n"						\
 		     _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_FAULT_MCE_SAFE)	\
 		     : [err] "=a" (err)					\
-		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
+		     : [xa] "m" (*(st)), "a" (lmask), "d" (hmask)	\
 		     : "memory")
 
 /*
@@ -137,12 +136,12 @@ static inline int update_pkru_in_sigframe(struct xregs_state __user *buf, u64 ma
 				   XSAVEOPT, X86_FEATURE_XSAVEOPT,	\
 				   XSAVEC,   X86_FEATURE_XSAVEC,	\
 				   XSAVES,   X86_FEATURE_XSAVES)	\
-		     "\n"						\
+		     "\n\t"						\
 		     "xor %[err], %[err]\n"				\
 		     "3:\n"						\
 		     _ASM_EXTABLE_TYPE_REG(1b, 3b, EX_TYPE_EFAULT_REG, %[err]) \
 		     : [err] "=r" (err)					\
-		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
+		     : [xa] "m" (*(st)), "a" (lmask), "d" (hmask)	\
 		     : "memory")
 
 /*
@@ -156,7 +155,7 @@ static inline int update_pkru_in_sigframe(struct xregs_state __user *buf, u64 ma
 		     "3:\n"						\
 		     _ASM_EXTABLE_TYPE(1b, 3b, EX_TYPE_FPU_RESTORE)	\
 		     :							\
-		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
+		     : [xa] "m" (*(st)), "a" (lmask), "d" (hmask)	\
 		     : "memory")
 
 #if defined(CONFIG_X86_64) && defined(CONFIG_X86_DEBUG_FPU)
-- 
2.48.1


