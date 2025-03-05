Return-Path: <linux-kernel+bounces-546649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1DAA4FD44
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0BB57AA0F5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC582417D8;
	Wed,  5 Mar 2025 11:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQVzgAaS"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBBF235BE4;
	Wed,  5 Mar 2025 11:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741173022; cv=none; b=BgI3C7xTzNp0WbPEOIRxf8n7snYKGhClOEH0ImgSoGuCRvTFcMPDHgBMZkS3Kx3hOaYh62VTtpv4LeEZShU0/dq2lsefPa4fWxUwVPGNBkrBYMJrPCq0L5Z+RJ5qwQuLD0qaG0F/Fgoth358rOP3/QgbVZZoGodkBrTDjpZc2WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741173022; c=relaxed/simple;
	bh=+7XITjewWSl80gT0zr6uyJXg8p1d67Yg7lRhbz4DBTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WZn3twSmRSCkciQfZQS8gfowCH5i0dxmpqWFgoRQnG4Qy5ansYhB3f0Js7K/g7JzGROp5aS0Y9P9fiAsO/g2aGJIKAZcH/R+WGJPTJtuES7z9dJA6rZkXXsFASmunTo4/Gwv6cco5RtvtdRG7j64/ZpWWG8f9C9/PayVs1QB3Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQVzgAaS; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2fe848040b1so13649804a91.3;
        Wed, 05 Mar 2025 03:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741173020; x=1741777820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qp8W9ben9rFX3CxZ0d32TQyshtC6obDRIzvh0yrVOfk=;
        b=KQVzgAaSRMJDTsv9NUHTKGf8KLkeTfwCLJzemWuu8/zFdtOMFFU6J4pxhzDDrLzk96
         /i3i9itNbZxy/3zxt0y894Ma3ky+EP+KwrS0JvQh+kY+CVIh2H6M9OowOhn6Ewbd3Qt4
         QFnonUHHlQpnw/5/LlBLq7QbUqJdxwgYF3rYrlxdkCyWxe/XgKZ43fCJ1Y/tKA0IakSn
         eOR1B015CH8ZP189th4bicmRXHlfL+1b4TGzz50hYG1WB413fSzAsiScT9EA1nG3Re9J
         mXfCkwWgHCO90ljRuZMACzlPPtgZ29JnWNX6DvP+ApYwjXJSQyTqy/8sQEjk2xV998bC
         I1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741173020; x=1741777820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qp8W9ben9rFX3CxZ0d32TQyshtC6obDRIzvh0yrVOfk=;
        b=KMz0yTjIaFty6KCsGxp7EEGjhEXByFBmeuSBlA9ILJY9qSnZfj5g2wZ50dhW3POrBG
         WHB6XolpP5sh7fL7912VmtfZXnbaqp1e1QHqY5KMCxnH27+uyv1n2n+A3115TO5ZuChZ
         cWq0vJanygud/ZkZ4Nna+V4hGmZVmFi5eVWnXw/OfLuxgazbBmHbonhUT0d6vD39Tm+T
         fHxBdeT4HKopzjoppsvSHHxPrk4V7pssFJoGams9JlIvYOJvtv9cVCUd20t4zexbeA3X
         7bu1fRQehYVR1x+ylhyRC3e5FhI0Uqoxzrm6QqE/n0ZJyziDdJIfGbz6NkxHHBUXjJWu
         Orug==
X-Forwarded-Encrypted: i=1; AJvYcCUSKHei20HP/mb0/gmfP5wgG9QdwmaNkYQn+4m16vLKYtrS2FJ212/pSbTCwqeu7J+b0XH7o3rR2zFwt4s2dA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNckrtSf7wRvguGEslFGRzrQOw5seCUGDREsGskXnqLJBd6BS8
	Fk2KXr/uhu+2HJRB2j26Tfb+tSMbqNvPvL4Hw7cmdXJkG4ypx23YN+GResu1
X-Gm-Gg: ASbGncsEvgnmFQRjPkoOIesXJO7sysIWWKdaVsU5rCjtwbZi43FblaUoW8PshZEOiR7
	zYz2ZSWAk3XB9r8cM/8ZAJRXglfsRvVt5uQubxAx/9p2QKwE7nDW3BEm8hcslq461Nf+aUi8mk6
	RBlXyaowyOXGWGZtmChCBO+YhR8Ca9zinzAgly/IGPudberjDTccC/G9cmaZOy0b6DQzyUMvUDD
	QM0n+bE68nCLVEpsYd6pBGCG/4JCl/wVXIHFXC7sDlm2Z70kqFLRUW3Kc5lUDmjH/QqAiQeVeSb
	+VT/2pG8A/cTB4l7G+YVVH1eUIrWIQ1b0Mz467b2JWnzjB4LZMa2FQIVk/L0V7nOa/RGA+VNycX
	7fA3CUfRnwJGEX+ZtjlSV9A==
X-Google-Smtp-Source: AGHT+IH2eSO5dVRpZfQrO0mycl+1zvAZDwU3KlrIDKDzNpcS47TGnHWji2K5rHzupBDupL/ugdamUQ==
X-Received: by 2002:a17:90b:524f:b0:2fe:ba82:ca5 with SMTP id 98e67ed59e1d1-2ff497283aamr4865930a91.11.1741173020419;
        Wed, 05 Mar 2025 03:10:20 -0800 (PST)
Received: from mew.. (p4204131-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.160.176.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4e7737a5sm1060925a91.13.2025.03.05.03.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 03:10:20 -0800 (PST)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	x86@kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	peterz@infradead.org,
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
Subject: [PATCH v4 2/4] riscv/bug: Add ARCH_WARN_ASM macro for BUG/WARN asm code sharing with Rust
Date: Wed,  5 Mar 2025 20:08:12 +0900
Message-ID: <20250305110814.272792-3-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250305110814.272792-1-fujita.tomonori@gmail.com>
References: <20250305110814.272792-1-fujita.tomonori@gmail.com>
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

Acked-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 arch/riscv/include/asm/bug.h | 37 +++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/arch/riscv/include/asm/bug.h b/arch/riscv/include/asm/bug.h
index 1aaea81fb141..6ab13b56feb0 100644
--- a/arch/riscv/include/asm/bug.h
+++ b/arch/riscv/include/asm/bug.h
@@ -31,40 +31,45 @@ typedef u32 bug_insn_t;
 
 #ifdef CONFIG_GENERIC_BUG_RELATIVE_POINTERS
 #define __BUG_ENTRY_ADDR	RISCV_INT " 1b - ."
-#define __BUG_ENTRY_FILE	RISCV_INT " %0 - ."
+#define __BUG_ENTRY_FILE(file)	RISCV_INT " " file " - ."
 #else
 #define __BUG_ENTRY_ADDR	RISCV_PTR " 1b"
-#define __BUG_ENTRY_FILE	RISCV_PTR " %0"
+#define __BUG_ENTRY_FILE(file)	RISCV_PTR " " file
 #endif
 
 #ifdef CONFIG_DEBUG_BUGVERBOSE
-#define __BUG_ENTRY			\
+#define __BUG_ENTRY(file, line, flags)	\
 	__BUG_ENTRY_ADDR "\n\t"		\
-	__BUG_ENTRY_FILE "\n\t"		\
-	RISCV_SHORT " %1\n\t"		\
-	RISCV_SHORT " %2"
+	__BUG_ENTRY_FILE(file) "\n\t"	\
+	RISCV_SHORT " " line "\n\t"	\
+	RISCV_SHORT " " flags
 #else
-#define __BUG_ENTRY			\
-	__BUG_ENTRY_ADDR "\n\t"		\
-	RISCV_SHORT " %2"
+#define __BUG_ENTRY(file, line, flags)		\
+	__BUG_ENTRY_ADDR "\n\t"			\
+	RISCV_SHORT " " flags
 #endif
 
 #ifdef CONFIG_GENERIC_BUG
-#define __BUG_FLAGS(flags)					\
-do {								\
-	__asm__ __volatile__ (					\
+
+#define ARCH_WARN_ASM(file, line, flags, size)			\
 		"1:\n\t"					\
 			"ebreak\n"				\
 			".pushsection __bug_table,\"aw\"\n\t"	\
 		"2:\n\t"					\
-			__BUG_ENTRY "\n\t"			\
-			".org 2b + %3\n\t"                      \
-			".popsection"				\
+		__BUG_ENTRY(file, line, flags) "\n\t"		\
+			".org 2b + " size "\n\t"                \
+			".popsection\n"				\
+
+#define __BUG_FLAGS(flags)					\
+do {								\
+	__asm__ __volatile__ (					\
+		ARCH_WARN_ASM("%0", "%1", "%2", "%3")		\
 		:						\
 		: "i" (__FILE__), "i" (__LINE__),		\
 		  "i" (flags),					\
 		  "i" (sizeof(struct bug_entry)));              \
 } while (0)
+
 #else /* CONFIG_GENERIC_BUG */
 #define __BUG_FLAGS(flags) do {					\
 	__asm__ __volatile__ ("ebreak\n");			\
@@ -78,6 +83,8 @@ do {								\
 
 #define __WARN_FLAGS(flags) __BUG_FLAGS(BUGFLAG_WARNING|(flags))
 
+#define ARCH_WARN_REACHABLE
+
 #define HAVE_ARCH_BUG
 
 #include <asm-generic/bug.h>
-- 
2.43.0


