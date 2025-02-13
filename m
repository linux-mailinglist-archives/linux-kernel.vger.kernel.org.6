Return-Path: <linux-kernel+bounces-513078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C292CA3415D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D4C73AC6CE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A08A271261;
	Thu, 13 Feb 2025 14:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThNgibgU"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AE9271263;
	Thu, 13 Feb 2025 14:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739455250; cv=none; b=OIfQxp7c9g9W/2CkVW7cl6rfLdK0cHw/RZ6e91hEQx8cyY6Qn/36Mf8T4EDB+aF3kh5L8VvH3e9y7rJShGQjjKbWfK2vfZmcAk9AZepasgo1QtdChu44A1My300wmMQj++mZPLb1q2p6Xi3XKfXKNuM80TVNkdb7H0cPpdcv7sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739455250; c=relaxed/simple;
	bh=h/3P2KY8vDMPXX5OJwI4gjMRRH8LzIOf17+FXLQKEXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rBB1LNBbvZpSgQsOUeNERL7VMIlMJMHlRVXnslcqaRrb6KKS43aOpQtBlqpA/o70dvtohgjqaTeTHvJG+hJ4dDJI8LHjGG+0ouRDyk9Yq2GXPWpAOyJLBq/AHVkXqDDlJKIgtX/n1ItAq2NQ09hpUHk/j8paiFpQ5b7Mj+2C70o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ThNgibgU; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21f7f03d856so15746925ad.1;
        Thu, 13 Feb 2025 06:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739455248; x=1740060048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gg/V+lwtqWQq5Y/Ly9J/s6hUNho4JthxgdaqasfoAcA=;
        b=ThNgibgU/ZjJGl5pSGhakIYskdqVOQbWlqIkehdjUex/gxEoTTerVviy71z5AiIqKb
         ssbL1oyoojIhFI/nHYmJjXbncvPXyngOSd5kwaupJMb8Rv3hbw7BWjvFpVWmJz6Li3eF
         8aL85mMKNAQoTMRftNQksEJak6q5oxSpall7UZaJ6S48FQ11qB4awfxaRW7CFdXl5gZL
         MR68hsmcv7ATR0RNpwjyFM82AOAxopYpgcZkBEYE/azjaWFhWLd0CysU8Ws2jyJGGcsy
         hSPrgmcGaF3VWTT2FP+m6Xj+aEAeRuqBBI8LL96lXcbwS9iIPF/BjO5XJgXFqvt2LiOc
         vgPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739455248; x=1740060048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gg/V+lwtqWQq5Y/Ly9J/s6hUNho4JthxgdaqasfoAcA=;
        b=El/NyTmWqhbuQlR/Xy3kTTzArQuJdkkaO7L3Ihcj8cr4le4E77Ke5mIM6f/Pt/okeR
         D/EkGSl4tcDI5JQJ+RYtt0clZ3ZEMxAMTAnuvHAUs8kEM52vtmkGzu9pWQFgod5WpH7z
         VPoLwGvJAY80IKaON8sycaNamvSUmI1yaCPh7W8jhUBp9syj2l3wrerVwqnWi+Ftsszt
         Wi0n7qNUT6WDsEsGvRbyummxT4Q0bk6ejD1aqg8mOoCvIpRs4UB5i5gi4DOzcS58w2RF
         2wmPYZYYk1Alq4cOjyRecwsIXDMEpAs4mDzQI8Yh8DJLN/qeaS6DyidrRXlvfaXUXvgM
         1V1A==
X-Forwarded-Encrypted: i=1; AJvYcCVoBuerRqz7eyyEKPRpSoS38a/k+e5I+eTin0Jzyutx9mOmj2BltXM9QarESdvddC52cRpJsEkk3tnZgsOtjw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Wrw2H5z/0cE09iPoH39FqjKOpjxXHHjAzJEXIRc8TxlBzpm2
	KIPhNmWn4y3XH0SxNZdcOVHMJcb7aDFppYRTGnI5cOlt1pIAq60cyGhR5TeY
X-Gm-Gg: ASbGncsgHGJqT0DiJsLptEgY/2IZRK5nnWZLG7LyL73pMUblp7L/RjGaY+QBs25PEVI
	+lM2lM7h0UqagZ6c8GWqXBC+LG0ioDDLLyBSh6I1dQhdBhA9EEFpsUhHxFLjYRf0spsFmtSCMDo
	QF5/uYdV8aNlKGxqg3FKUZe1/hnTWQukvCcmJ6YtkmRYh33woygX1pTz/NUMjtgTHgqnC4ObS1E
	zycdeDG6LELuiymtpVVYhQfUbaOXReavayyuGUP2PP+ybIkYApBn5k8mhBq5v4Yv+mI0K8O1XT0
	6sNUniBpuGuY64F83nTRt7+RRzGSiDqwKiaze8BuBTHek3BpEOPeDiajs0VY8lqglhc=
X-Google-Smtp-Source: AGHT+IFTuUUy1Wq3iWeeuJp7RF8h8HqcmzEsROtZ3HzF4SlUho3mcp66MzG3aF4wwbARFTyZlT5eFg==
X-Received: by 2002:a17:902:d58c:b0:20c:6399:d637 with SMTP id d9443c01a7336-220d2132be5mr57272645ad.40.1739455248450;
        Thu, 13 Feb 2025 06:00:48 -0800 (PST)
Received: from mew.. (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d55858d6sm12565225ad.223.2025.02.13.06.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 06:00:48 -0800 (PST)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	x86@kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	catalin.marinas@arm.com,
	will@kernel.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	tangyouling@loongson.cn,
	hejinyang@loongson.cn,
	yangtiezhu@loongson.cn,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu
Subject: [PATCH v3 1/5] x86/bug: Add ARCH_WARN_ASM macro for BUG/WARN asm code sharing with Rust
Date: Thu, 13 Feb 2025 22:57:55 +0900
Message-ID: <20250213135759.190006-2-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250213135759.190006-1-fujita.tomonori@gmail.com>
References: <20250213135759.190006-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add new ARCH_WARN_ASM macro for BUG/WARN assembly code sharing with
Rust to avoid the duplication.

No functional changes.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 arch/x86/include/asm/bug.h | 56 +++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index e85ac0c7c039..61570ec9464c 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -28,45 +28,42 @@
 #ifdef CONFIG_GENERIC_BUG
 
 #ifdef CONFIG_X86_32
-# define __BUG_REL(val)	".long " __stringify(val)
+# define __BUG_REL(val)	".long " val
 #else
-# define __BUG_REL(val)	".long " __stringify(val) " - ."
+# define __BUG_REL(val)	".long " val " - ."
 #endif
 
 #ifdef CONFIG_DEBUG_BUGVERBOSE
+#define __BUG_ENTRY(file, line, flags)					\
+	"2:\t" __BUG_REL("1b") "\t# bug_entry::bug_addr\n"		\
+	"\t" __BUG_REL(file)   "\t# bug_entry::file\n"			\
+	"\t.word " line        "\t# bug_entry::line\n"			\
+	"\t.word " flags       "\t# bug_entry::flags\n"
+#else
+#define __BUG_ENTRY(file, ine, flags)					\
+	"2:\t" __BUG_REL("1b") "\t# bug_entry::bug_addr\n"		\
+	"\t.word " flags       "\t# bug_entry::flags\n"
+#endif
+
+#define _BUG_FLAGS_ASM(ins, file, line, flags, size, extra)		\
+	"1:\t" ins "\n"							\
+	".pushsection __bug_table,\"aw\"\n"				\
+	__BUG_ENTRY(file, line, flags)					\
+	"\t.org 2b + " size "\n"					\
+	".popsection\n"							\
+	extra
 
 #define _BUG_FLAGS(ins, flags, extra)					\
 do {									\
-	asm_inline volatile("1:\t" ins "\n"				\
-		     ".pushsection __bug_table,\"aw\"\n"		\
-		     "2:\t" __BUG_REL(1b) "\t# bug_entry::bug_addr\n"	\
-		     "\t"  __BUG_REL(%c0) "\t# bug_entry::file\n"	\
-		     "\t.word %c1"        "\t# bug_entry::line\n"	\
-		     "\t.word %c2"        "\t# bug_entry::flags\n"	\
-		     "\t.org 2b+%c3\n"					\
-		     ".popsection\n"					\
-		     extra						\
+	asm_inline volatile(_BUG_FLAGS_ASM(ins, "%c0",			\
+					   "%c1", "%c2", "%c3", extra)	\
 		     : : "i" (__FILE__), "i" (__LINE__),		\
 			 "i" (flags),					\
 			 "i" (sizeof(struct bug_entry)));		\
 } while (0)
 
-#else /* !CONFIG_DEBUG_BUGVERBOSE */
-
-#define _BUG_FLAGS(ins, flags, extra)					\
-do {									\
-	asm_inline volatile("1:\t" ins "\n"				\
-		     ".pushsection __bug_table,\"aw\"\n"		\
-		     "2:\t" __BUG_REL(1b) "\t# bug_entry::bug_addr\n"	\
-		     "\t.word %c0"        "\t# bug_entry::flags\n"	\
-		     "\t.org 2b+%c1\n"					\
-		     ".popsection\n"					\
-		     extra						\
-		     : : "i" (flags),					\
-			 "i" (sizeof(struct bug_entry)));		\
-} while (0)
-
-#endif /* CONFIG_DEBUG_BUGVERBOSE */
+#define ARCH_WARN_ASM(file, line, flags, size)				\
+	_BUG_FLAGS_ASM(ASM_UD2, file, line, flags, size, "")
 
 #else
 
@@ -88,11 +85,14 @@ do {								\
  * were to trigger, we'd rather wreck the machine in an attempt to get the
  * message out than not know about it.
  */
+
+#define ARCH_WARN_REACHABLE	ANNOTATE_REACHABLE(1b)
+
 #define __WARN_FLAGS(flags)					\
 do {								\
 	__auto_type __flags = BUGFLAG_WARNING|(flags);		\
 	instrumentation_begin();				\
-	_BUG_FLAGS(ASM_UD2, __flags, ANNOTATE_REACHABLE(1b));	\
+	_BUG_FLAGS(ASM_UD2, __flags, ARCH_WARN_REACHABLE);	\
 	instrumentation_end();					\
 } while (0)
 
-- 
2.43.0


