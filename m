Return-Path: <linux-kernel+bounces-513079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86AD8A3415E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8715D3A4ADC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6626C27128D;
	Thu, 13 Feb 2025 14:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJr9EAYK"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5490B271281;
	Thu, 13 Feb 2025 14:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739455258; cv=none; b=m0gCTUGGShaarxa2quRy0f2GiMMnI07jBrUTXh72P9UXx3q9K2MyHMwONcA3kboBMDZmF0NKZWMZV2FJA2VJS/6mD8XyL5iMgH/oHBNQ2mMczdkADPvsaCNtXOZ5UzhIzRd+vMTm7YEb2uU0Lv6Hnwss0f8EtwCq0OEpwn/BVWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739455258; c=relaxed/simple;
	bh=zKjcSUryVoDbQCRZ2x8lBFB/w5Bku/XsU/5WIanvQhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r1zrgdT61Gr71JlsQ2nWFhRU3fTsAAZUZaib+rOTxwqiMUrpZy7tgYewUOS0dbKkeMqipDdURZ8UuWZSFE7FYtA0GhvtygiH9NiYMajtnlzPQn3pwAQpUIIpoyhh3iS2KO8xA+rD1nRUkGkrm6CS0W1RJ/LAQhureRycr51TcJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJr9EAYK; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220c92c857aso14349415ad.0;
        Thu, 13 Feb 2025 06:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739455256; x=1740060056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2+y6Ck4nUrrnZ5J/UDrnc3xAlfWqC0MtemaHjWH6P0w=;
        b=IJr9EAYKlQ8C49VIlTdchnW4gRyzsff2+c2kyBhYAJMJH1RH7yBZ9HU4pR9Ha5yUN3
         iyAg7tPAthjcQh6XgLILTTVAmAgC+6WRdLdE8d6RCKB1n/qGzBBysN22+TnCGBnqcajQ
         XtxIY2pPTIxbmF7fJA+Iv5y7JQi0rroeqKwF4Q4EpR2/3CAhNfYo60R83vWiVQ3aS/EN
         aycT+sGHY86fSODeSDDV7hW0A0py2mFDV3Jx3Zb4GXlqG7AtEjWoofszs72q/M573VNM
         mj8xrQHkH8qZvZFUPzGUj3mRaxmBEqPYRGSjWPcwALHCPfj3Q24HkvNw3KWvfQX9fbBG
         9MSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739455256; x=1740060056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2+y6Ck4nUrrnZ5J/UDrnc3xAlfWqC0MtemaHjWH6P0w=;
        b=aw787/UBQNYvN0pcfHNT0JhywJ1ri+ZQlMf4I/XGTYKBNeJfAa6joSqQ6FpPlkbu1d
         IMEGcxxU1iJBNFwhTR1Fx42Xe4k+W2pO2/w7LY/zak63Py/pr0jwDc4l2SLCrbSAJWj+
         Ax+FYt3TKmbUHD+fBlnNvqrjVr2HHMRIwo/TKImiSKIMwXmhrOX2HaH7Z8DITpGO/SSX
         tznNFtkPTMwCyOA5PBG/eJwo6g7qBM7ZEFeXmOV1JXNdVcCgCcT801T+9Up1WN7kGVL6
         8imHFXSyz8bKi2V0ewQfaWM3Evu0Q1E4kgFk0j5zKK5SnEqHaQlJc75qb/cWZkY49p2X
         X1fg==
X-Forwarded-Encrypted: i=1; AJvYcCWWCmphQcf86q0UYzH9/vcBzM2N8pKuKO6tfxV+v5VTRphUtJxEGc16U6Q/ZWTemXcM2Z/Yn4BufT2WxUmW8A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3q/jrVrB7AsGdpXznpoqlIL1xmDrebZNlJV5s11OecR9xYT/z
	XEqV0r9B+qdhnk2TvSdFyQMDjjbu227ablYh07EjqsI5+F4nFnBn4BgybG0l
X-Gm-Gg: ASbGncuMBsRvKQ4QiO0HZCeMCInWWQXrznukY2msdEWlyghzn9rdeSpvGxLpJj+KHd2
	3EN0Kakuqj5ITJtiUwtqvaBOxxq98XLrg2HGhZIYYUcyFRQEjaBxstgOrzKg+54DJXTCsCMb+rH
	zubSOCjOcTPC3kfIeWqABl4ZpAv4OdVJKLhS4tVYrSZm7rLivgVP3yJ+JuZZb3+Uhidqja3uDQK
	v4to9JJh3DhVmDNOP3ZzjKfFUeaiaUrBsxLpQioXcp1wIbLZ83y3u4gykErF8rGgnLIocX+0IqP
	cjpG80TUlv/ClmyqzAYG6Owp5NC/x7ACfPa3PP5Jn8+H2yWy92uJiNhGU/y8dJayvPw=
X-Google-Smtp-Source: AGHT+IH1Zqo9tPEvVGN2+sG3MuJAeMqjgEOo7xAq67fk4VjOAgBOooytYfL4WucnOp0CvNreEK3WqQ==
X-Received: by 2002:a17:903:94b:b0:220:cfb7:56eb with SMTP id d9443c01a7336-220d376f061mr46259805ad.26.1739455256258;
        Thu, 13 Feb 2025 06:00:56 -0800 (PST)
Received: from mew.. (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d55858d6sm12565225ad.223.2025.02.13.06.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 06:00:55 -0800 (PST)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: x86@kernel.org,
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
Subject: [PATCH v3 2/5] riscv/bug: Add ARCH_WARN_ASM macro for BUG/WARN asm code sharing with Rust
Date: Thu, 13 Feb 2025 22:57:56 +0900
Message-ID: <20250213135759.190006-3-fujita.tomonori@gmail.com>
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


