Return-Path: <linux-kernel+bounces-438622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 767EE9EA392
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 01:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF3E116560D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 00:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEAC67A0D;
	Tue, 10 Dec 2024 00:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSTSM3yv"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4773B182D2;
	Tue, 10 Dec 2024 00:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733789978; cv=none; b=NOvVdNgL5pri+QpHCpWth6nLF3PmnrrlUPg8IZ797d6tEZiAZrXCk9887jpTsudSHZRvKKoe81AvryHUWUbQevHy93F6x7k24P2Vrs7XvgnQpZYdp4/mUPnI7o4c0t3qP9H6SGMD4NITyYvg79QwI0tC0rx9Alul+dXyCWC4fCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733789978; c=relaxed/simple;
	bh=tLULYhncvqXuSEEMkRa308bOiD43z3dLIb09npubBjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZDOsn+/L/Nz5l5quxOXqgHNovsiXpfWPY5t1xp/mH1icHQnRbQbd0ZEq6Oxo6ktX5OEmz+D2W2ZfMEEsW7+1ilzqm6eKL87wQ3jLfOwWUbgVXDUhbpPaEU0LFPkMdn7KcKd0SIVA6FKF3buMI+k+41JAFI48RjSSguUhR0EkKYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HSTSM3yv; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7e9e38dd5f1so4000744a12.0;
        Mon, 09 Dec 2024 16:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733789976; x=1734394776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Og2RZIwk2Fmm4a1enxRaJzgczmbvkc80VyX2Z+HeAaA=;
        b=HSTSM3yvD5ywLgXaMOcDHKC+xDMlQeZ7LIaq21S5Qq0JojalEuLZeI8tdJOmZ1I5bH
         NFpjU48Ivspmbc711qBuIOBcCAcXF4Fb0CgG2xfA6h45y0qYPNhNW1NxjnXWJf3qQXNH
         ELB99IcCQDqYtvmT0R+FwPulX8pRVbpYpmQPSRePFNCZKjjsXrgdcEWiSoCjugr0rRDy
         +gMTtHL7KCoO7aZqthY+kY9LDpU2sRNzvDqliPhhVl92B6vlJhfMu0p4FX5dcyX3ybV2
         fehUWo/ojV3y9AZlZ6sP0kPzAys5FsHsexynsNzajy0829GAf6qdQ6iS70YUsaLfbt/m
         e98g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733789976; x=1734394776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Og2RZIwk2Fmm4a1enxRaJzgczmbvkc80VyX2Z+HeAaA=;
        b=G9ugq1qixQwK1r5JFC0o+mqa3lxX8IPV3TDVmHb5PDZa3F2lGs7+5Z64AsJEaSKifk
         ROY9VfHp+/xFdjtuIJPCxyMV1GKyww6J5ovGRrbsVeeDusle4gtTErhuAkugqcHT/rYU
         jxgUf9AJVOSbw2o8szRhwqPve9jzMhDFe9rz2P+8Pz30pE9/bxoHEpZvuFiUOhH7XTmT
         mFiYvGcY2J1m0rbGUAB6p4JwWarw956k+cZD3sCjStH+6I1lRrXYbHd7YE75QNoRHjMv
         T8HhNA3BYE2ZoxowBwam3GBrQksB6D/gL9TcW0u5qNxwIKFj7iQ9KI+OshbnFwUwbRVi
         gorA==
X-Forwarded-Encrypted: i=1; AJvYcCU5lblk/o9/7npLxqyU4o85QwV72oMpZPqiDVSxA3umaIbIXhGqCb5vT7BwbBGozFLPTT8RP8bQyQw9MQBbCw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxslh7Fxjl4h9fffwK9EDuUouvEYFD2qpjMR3YJ3XrUxtPUEEKi
	LBPlHJEOQzd6dPLt/ioz/vbw7Yro0Siheh6UCFmx77C9Wmmzz7kkC/dCAugJ
X-Gm-Gg: ASbGncvrnGfKw/BttlkonBePpmNZVrc4fW1t1WXDXfttcGGjUMTXixr3oANiN7BbcKg
	tLubRAlrbQ7pNSb704SlKxt9SauQtyhox0S3zGQGbenl/jLk5n+VaMHo86cWI2PWMVZsXYdPorq
	+9SJjGjl4p8VbPj76Q55AsL4PiZ0bpYuzhRSeLRNH/R/TCw+ksjlbCl8NjNHKZYMAO1SA1YqvNg
	rdJa9rgN6dSs8CoJBAzkefbcMtiEUZb9C3j4gsTL6ggDIBj+X57Ej8Gv9xNwdT1gbF7r0LuFEty
	hZXq6cMbPVTC5bAkpf3P+ov9RY9d
X-Google-Smtp-Source: AGHT+IFzrftQzGze1g0ifR+gfHYjdPe8pRM5le+6CFZEL33/9GPgGvUcXSJX0JYy+N5Of4n1uRZr/g==
X-Received: by 2002:a05:6a21:8cc7:b0:1d9:c78f:4207 with SMTP id adf61e73a8af0-1e1870bb625mr22034147637.11.1733789976324;
        Mon, 09 Dec 2024 16:19:36 -0800 (PST)
Received: from mew.. (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725f1fba027sm2005005b3a.3.2024.12.09.16.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 16:19:36 -0800 (PST)
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
Subject: [PATCH v1 4/5] loongarch/bug: Add ARCH_WARN_ASM macro for BUG/WARN asm code sharing with Rust
Date: Tue, 10 Dec 2024 09:18:00 +0900
Message-ID: <20241210001802.228725-5-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210001802.228725-1-fujita.tomonori@gmail.com>
References: <20241210001802.228725-1-fujita.tomonori@gmail.com>
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
 arch/loongarch/include/asm/bug.h | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/arch/loongarch/include/asm/bug.h b/arch/loongarch/include/asm/bug.h
index 08388876ade4..2343c4226595 100644
--- a/arch/loongarch/include/asm/bug.h
+++ b/arch/loongarch/include/asm/bug.h
@@ -21,14 +21,21 @@
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
@@ -55,6 +62,24 @@ do {								\
 	unreachable();						\
 } while (0)
 
+#ifdef CONFIG_DEBUG_BUGVERBOSE
+#define __BUG_LOCATION_STRING(file, line)		\
+		".long " file "- .;"			\
+		".short " line ";"
+#else
+#define __BUG_LOCATION_STRING(_file, _line)
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
+	__stringify(break BRK_BUG) ";"
+
 #define HAVE_ARCH_BUG
 
 #include <asm-generic/bug.h>
-- 
2.43.0


