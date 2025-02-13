Return-Path: <linux-kernel+bounces-513080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0E0A3415F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4770E16BCC7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37123274253;
	Thu, 13 Feb 2025 14:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmE8Q5hu"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3113E274244;
	Thu, 13 Feb 2025 14:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739455266; cv=none; b=CDgref3Wk6sAcSa8ZlUY7rZdSHQbRE8X8VE3Zdiq0wcWZrw8f8N2C2hkaMEUc69Nqn2J0mjp/P1XqQuUrensVNi4638oLJrk6kUP6Un7VjKKQtbJDzx9Iaenad0f4csghDDifJs8osZ89zR73n3YtYKka7DUPL71kwQ0uisyZ5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739455266; c=relaxed/simple;
	bh=Nn8KuzF9O6nRbRkZEq4R22MVH1XltQW/KfhFXKsiiKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sscfiPrvDijARzZr6IA5EXrvHXbbP7Ce9kOKHCghvi3y1w9qst0NOT3sDiV6GDHFHvXkXqhe++L0wtOv3GKtK2bTy5sGnbPdnlj4+vbfCGUJI0f5fh68TDw8NizzzZNGxOMnFr3JfYSQQvTK/66lS2xSxYwlll1l2mupIu7ybWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OmE8Q5hu; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21f44e7eae4so15296125ad.2;
        Thu, 13 Feb 2025 06:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739455264; x=1740060064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6YTck7L/TM6YT4d7fP2I9343oTdjN2yh7jLib0/ivQs=;
        b=OmE8Q5huspomm3W/DZd4aaiTB3AxD9fakvxGLfb57FTY9tlmnhZMf9wSK3kxsPMzSf
         Uw2aGIW5JAAyjm4XCKb0Ho7obwbEwxUwMt8QiZu4k/ID7jJjr1N92F04OipE3ouPR2P8
         uaZ0HF/MtaRM9+kndjtNYYdBFG68nFqdgaaHWPZN7Jo28fRA6T1DsU7xtyObLTNtLkjD
         7Z5UdexchfYo3rvQXFfSJllliEXeb/x1fpjoWlKPwJOMjVrSBIBIzlZGGiY4lzRkfobJ
         Z6t4Bg+oFkQq0N/PtkWF76CeCtfo6gYNJS/87MXraW4k0j7ABdqbaCVN5S8LnOVrSIry
         qTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739455264; x=1740060064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6YTck7L/TM6YT4d7fP2I9343oTdjN2yh7jLib0/ivQs=;
        b=DIgx21fN9OsLZDYuSVZcEHpMMFI+oXapQB3radS6ly/cwv8u4Y++YjqCadrfPo8tDV
         6d/QCgxYH8Pfl3U20q36gGU4k5i2El5myW6f+M4CZajGlr0lrUo7e+cpH1XKJLv52AAN
         PiZNA7Do8XMDdPPeSUn3jPwzkscv7hiTnx7vbdggzwXJrC1eSn7+HPbAEHXUlekbTfoL
         GsjDg6Xs5c2rNPCnYfOQOdi/aStj0CZaFupNLxgacVoJEEFCfDUhuiWyiiZ4TmSjE6NF
         P/783QjUDtuaOm38bPP3buxFWYpToeJ8uHWMJC/OwOCNJxEdnxxf3cJMcNGmqSTnQEwX
         3K0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXlNDp8JLoBtZCUjaIChLP9Y8rnYf5BQ/p90PoNwaJ7z/FJ0Fz8nxhiJVfd+V+UFE9E1C/e+h3ZgG/SKtJ3IA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCR8IN9/8b/hzEA3rA3yTa5ABrYqSD9q+2OWtHG+EnwOqBpBar
	kcj0CFv+e3QafVUszWDX2q7+Lt14v/Iq/0g6EyZX2sXQvLrSoeqnPdf36AhM
X-Gm-Gg: ASbGnctdVVPZSiZPBrRu5Q4WAxnBmHLk304jzYxQY2nMs5VpLoqvyvmbE+ouON+FSTD
	nbJLBvo8X1E8cHofKG34E547KeO7O/Af9TsH7lYyCwyrRoQiQoXyyvkSqbtMdDgpy8WpVxcKqQL
	oyqOv13NY6ZKgZIQ9hb5/L+go6vpEzRHLGFmc4dN7PHY9amZlPSie9BNy6YYde4gS696Gq/0tDC
	E+iOfnImpQRGIph7t8kYuv66ZEVWvhdu7KOMneS52s3710efc5PIOOVIiBMrawprCu8ZCxtkzOV
	GMGF4U1vg+BlMBtIgCfGsIJjVtGI/uGpGduGhOrD1LJ7prd6bmfp8KCFpxBuImUsWiI=
X-Google-Smtp-Source: AGHT+IH1x9tK23DwJyRFWv8i5Lca//kx4EQ6K/f/4h09IEIvt0Nq6qmEVopHA91pvULj+H6RHqZ0EQ==
X-Received: by 2002:a17:902:e750:b0:220:e392:c73 with SMTP id d9443c01a7336-220e3920eebmr20624875ad.22.1739455264110;
        Thu, 13 Feb 2025 06:01:04 -0800 (PST)
Received: from mew.. (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d55858d6sm12565225ad.223.2025.02.13.06.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 06:01:03 -0800 (PST)
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
Subject: [PATCH v3 3/5] arm64/bug: Add ARCH_WARN_ASM macro for BUG/WARN asm code sharing with Rust
Date: Thu, 13 Feb 2025 22:57:57 +0900
Message-ID: <20250213135759.190006-4-fujita.tomonori@gmail.com>
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
 arch/arm64/include/asm/asm-bug.h | 33 ++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/asm-bug.h b/arch/arm64/include/asm/asm-bug.h
index 6e73809f6492..a5f13801b784 100644
--- a/arch/arm64/include/asm/asm-bug.h
+++ b/arch/arm64/include/asm/asm-bug.h
@@ -21,16 +21,21 @@
 #endif
 
 #ifdef CONFIG_GENERIC_BUG
-
-#define __BUG_ENTRY(flags) 				\
+#define __BUG_ENTRY_START				\
 		.pushsection __bug_table,"aw";		\
 		.align 2;				\
 	14470:	.long 14471f - .;			\
-_BUGVERBOSE_LOCATION(__FILE__, __LINE__)		\
-		.short flags; 				\
+
+#define __BUG_ENTRY_END					\
 		.align 2;				\
 		.popsection;				\
 	14471:
+
+#define __BUG_ENTRY(flags)				\
+		__BUG_ENTRY_START			\
+_BUGVERBOSE_LOCATION(__FILE__, __LINE__)		\
+		.short flags;				\
+		__BUG_ENTRY_END
 #else
 #define __BUG_ENTRY(flags)
 #endif
@@ -41,4 +46,24 @@ _BUGVERBOSE_LOCATION(__FILE__, __LINE__)		\
 
 #define ASM_BUG()	ASM_BUG_FLAGS(0)
 
+#ifdef CONFIG_DEBUG_BUGVERBOSE
+#define __BUG_LOCATION_STRING(file, line)		\
+		".long " file "- .;"			\
+		".short " line ";"
+#else
+#define __BUG_LOCATION_STRING(file, line)
+#endif
+
+#define __BUG_ENTRY_STRING(file, line, flags)		\
+		__stringify(__BUG_ENTRY_START)		\
+		__BUG_LOCATION_STRING(file, line)	\
+		".short " flags ";"			\
+		__stringify(__BUG_ENTRY_END)
+
+#define ARCH_WARN_ASM(file, line, flags, size)		\
+	__BUG_ENTRY_STRING(file, line, flags)		\
+	__stringify(brk BUG_BRK_IMM)
+
+#define ARCH_WARN_REACHABLE
+
 #endif /* __ASM_ASM_BUG_H */
-- 
2.43.0


