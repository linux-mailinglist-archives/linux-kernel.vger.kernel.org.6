Return-Path: <linux-kernel+bounces-513081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B07A3417B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96FE9189391A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5604E23A99C;
	Thu, 13 Feb 2025 14:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gty/lcmo"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556F023A999;
	Thu, 13 Feb 2025 14:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739455274; cv=none; b=aYfLImkKggQDMxfPBnlqmzLpCu2CjnetEz5M+b0qof6lvTa7PbampM92Vvk8hZZAS32OuDAOvfiUWJI1pn/xbx442gbB9106hgrKAxP65Ow1Me40Bm+1WzOCmrlOyiuBbxIhWp4vLILGZWzga9f+Cwl2A7bSgIBHXG1ojMDEFCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739455274; c=relaxed/simple;
	bh=Pc3gxOcC/v5C7xqsjNR+BS+knJ4bCgit2eFUJojWgkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=szNP6tlkvcl8YUiGIO4LCS2tKMGb2YJP365MBQcqWTy3FZ1nQ+9IvhO1D7ARI2UJiwX0PScdswSEN3kO4XnzxPejRVXYJFCO8qIFPrEpxTy3qdXw7nYCDWwx0HqrOvSgyq51BmcKZ4rD84Z3VSOocUA9YL+6LnLBgV78ocSth7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gty/lcmo; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21f49837d36so11104245ad.3;
        Thu, 13 Feb 2025 06:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739455272; x=1740060072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNM9wcMBMuP84PLY2t7KRndWObkL1hWNmjkX5I560RQ=;
        b=Gty/lcmoztVRlDaEsDnQk5xlxHNXloZTJj1yOEaKf2xg3SVvkNtT7+0lHDZXIJzL0k
         0SiCvx5NUfpVtwmd2EPSTDnYxWF/7RHzPXkAd5mNoUdSGO6NJkQECTtthPSAzv8mI92v
         3d3oDyT4mBHup1PT8ttrcvto78wgAFJ4v9rx+1V9WiRTlkHbuTyoSBNt1NQTHDg3qHdm
         QaREipeZF721maPHmxImnTHsEAl/wkagWEPpRkmnqBRVSSUMNmYQICD0mkrwBBLJrj8B
         uiljzwmwZOVTGUgoR7MVWlKz36ucUzNNnvS9MtypObqJUaZkcfVVhh0WhqypU/O+L0Hj
         mNxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739455272; x=1740060072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HNM9wcMBMuP84PLY2t7KRndWObkL1hWNmjkX5I560RQ=;
        b=Y6PaOTdV4ya6tkeoRKsQizYMVKANyW0FIkGbgL9uMOlUQQaaaF1MN3jLQGekOBkOgf
         03x34It9+1eGXoE0gkDJkPxg6ddET+r3ObgtfWMMnlnIHiqEAw/dWGA4TUiS3zeE6kfC
         yFWeT3ylChF9+EV4EijqJHalfKS0I0Qx/A1P3n3McDT0w11J6Xxr6puybSmOEx+v5UW/
         LCpxN81+RqoOm7eQbfH7zsFzWYOi4h+y7zw5bYOK72d1ZQlURnzYO8hA3QlY5yDovS6C
         Xeu6a5Dnsd6IZpsUOauOO34ZQPpbXHXY5vOfO7Rs1bKh1ppzRJ9ny/OTwQOhkoQIOZU+
         eAbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVMrCEHu8dpZBbOzZmY+Th2Sw3Ab+OdlNqLtAhkoy+lgwiy8A/SOtm6TJ0CNi9tzAKqwzQ3vTmVtZsHXhS0A==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywoq2UE0spSo0zup0eVnQsl+b7uYwnMP7J0LLBmi4tPN56vsCcr
	BlFdcmLAdi10ZdHEd2//fJjlQia0zC+KfyotQmFav/a69cznKKgwXedUWw5s
X-Gm-Gg: ASbGncvMexgZxwD9FJjwXf4wagjeihhobmnNusEz993+P6llUIxAS5HDOLKXPI/lUCX
	txbhxwFNwPyhIjT5XKFk34jM8p1nFiNZ36sJ11Rz8g4HX9q4cOkhcExbHmMAd4apXMg3EanLd0s
	nntndkec6lwFBXraDAgHJYJvKlUACNp5HWmgphgCoKvdWZcpE9GAkToeMjpyPmO56Cl+ZP5Vsa/
	kGhLY3qYibag3NXqmVso5oLJM8mSf1zzKtbeBHek4pEA1xmDinjcnLboOQ74kHb4FhU1dPySMqT
	nq9kF1NhZnN6UYxSgOAXTzafKVHBCmRiOF8HGtT+FjB/wUaPju5K50RQO0saRUEFKR8=
X-Google-Smtp-Source: AGHT+IFfgCF1ArRZmNz2DsvrIgfU+ShH60hN/cRDjxK0gXLSiUzxtydzUB1xCTWoBREuB6sO6ZsxDg==
X-Received: by 2002:a17:902:f706:b0:21b:d2b6:ca7f with SMTP id d9443c01a7336-220d2110efcmr56668855ad.32.1739455271912;
        Thu, 13 Feb 2025 06:01:11 -0800 (PST)
Received: from mew.. (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d55858d6sm12565225ad.223.2025.02.13.06.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 06:01:11 -0800 (PST)
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
Subject: [PATCH v3 4/5] loongarch/bug: Add ARCH_WARN_ASM macro for BUG/WARN asm code sharing with Rust
Date: Thu, 13 Feb 2025 22:57:58 +0900
Message-ID: <20250213135759.190006-5-fujita.tomonori@gmail.com>
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
 arch/loongarch/include/asm/bug.h | 35 ++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/arch/loongarch/include/asm/bug.h b/arch/loongarch/include/asm/bug.h
index f6f254f2c5db..06903aef1101 100644
--- a/arch/loongarch/include/asm/bug.h
+++ b/arch/loongarch/include/asm/bug.h
@@ -22,14 +22,21 @@
 #ifndef CONFIG_GENERIC_BUG
 #define __BUG_ENTRY(flags)
 #else
-#define __BUG_ENTRY(flags) 					\
+
+#define __BUG_ENTRY_START					\
 		.pushsection __bug_table, "aw";			\
 		.align 2;					\
 	10000:	.long 10001f - .;				\
-		_BUGVERBOSE_LOCATION(__FILE__, __LINE__)	\
-		.short flags; 					\
+
+#define __BUG_ENTRY_END						\
 		.popsection;					\
 	10001:
+
+#define __BUG_ENTRY(flags)					\
+		__BUG_ENTRY_START			\
+		_BUGVERBOSE_LOCATION(__FILE__, __LINE__)	\
+		.short flags;					\
+		__BUG_ENTRY_END
 #endif
 
 #define ASM_BUG_FLAGS(flags)					\
@@ -42,10 +49,12 @@
 	asm_inline volatile (__stringify(ASM_BUG_FLAGS(flags))		\
 			     extra);
 
+#define ARCH_WARN_REACHABLE	ANNOTATE_REACHABLE(10001b)
+
 #define __WARN_FLAGS(flags)					\
 do {								\
 	instrumentation_begin();				\
-	__BUG_FLAGS(BUGFLAG_WARNING|(flags), ANNOTATE_REACHABLE(10001b));\
+	__BUG_FLAGS(BUGFLAG_WARNING|(flags), ARCH_WARN_REACHABLE);\
 	instrumentation_end();					\
 } while (0)
 
@@ -56,6 +65,24 @@ do {								\
 	unreachable();						\
 } while (0)
 
+#ifdef CONFIG_DEBUG_BUGVERBOSE
+#define __BUG_LOCATION_STRING(file, line)			\
+		".long " file "- .;"				\
+		".short " line ";"
+#else
+#define __BUG_LOCATION_STRING(file, line)
+#endif
+
+#define __BUG_ENTRY_STRING(file, line, flags)			\
+		__stringify(__BUG_ENTRY_START)			\
+		__BUG_LOCATION_STRING(file, line)		\
+		".short " flags ";"				\
+		__stringify(__BUG_ENTRY_END)
+
+#define ARCH_WARN_ASM(file, line, flags, size)			\
+	__BUG_ENTRY_STRING(file, line, flags)			\
+	__stringify(break BRK_BUG) ";"
+
 #define HAVE_ARCH_BUG
 
 #include <asm-generic/bug.h>
-- 
2.43.0


