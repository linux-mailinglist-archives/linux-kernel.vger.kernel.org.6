Return-Path: <linux-kernel+bounces-546650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A5FA4FD45
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD01B7AA3B9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B2A242905;
	Wed,  5 Mar 2025 11:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1RRQbA/"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760CB23875A;
	Wed,  5 Mar 2025 11:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741173028; cv=none; b=VSaUZU0vRc9ONLlaLy6sHAH/2OvjtJYZcXZMhUj/W3mDIPl5qQfk9LNg7krLtb2H7OOr6UvINGVMWBof6xd164PJcd1l9Linn/hbOe/F5qg57bxYamFDt1BpB0IlPDe3MY/35LfpIhAnr7VL/wzuWe6FJDb1clBWNtXCMFxScns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741173028; c=relaxed/simple;
	bh=mdMjqDgKLmfSj3Eltmr/eklydzSfhT7tfE+JI7T4puc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=baITr5WgBe9lkqFYaiiyy5zq2ETDK/9WUiRf4UpCm/CkKc6jMSz6p+28uOe3U9SjZDz9GK7Cf1PXgy8b0a/kLcFR9MrOq0HylvW1jIPoNKJ6fCv2BbbYxLDmwIpjOu9NsBfAVFu20FrzcRc9Gxoa6xHnMPGzhTDIjHw3JJOzc/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b1RRQbA/; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2febaaf175fso8609959a91.3;
        Wed, 05 Mar 2025 03:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741173026; x=1741777826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/DonzYY8ky0NPr6wCGSqroH7cDtAqrs9o10+/q7fXY=;
        b=b1RRQbA/bRlQvPauZXsRdoPbN26wO9WPghhtQDqJ5VWY4HM+3pwKPwUzQ0aqAVxS+A
         ivDX2tjyKhSTLj/996rokeC5LGYh1mHUA7sPmDQcmm6kSskwSW9a3W0LnY7tsWeM6l2O
         gG7Ue/U8zn28gF2OTT4UjzSkz/AsYtj/ggl4I+uDHPUGZMipdEf6l18+L6Gh1PG3R1sn
         b8S1wiyM6OTywz0CJCu0jtOzhfFidy1PRCQSfLlCeQIB88dyxzrhSJ02yhbXlzsRsqFe
         k/ctWJJ6PLXHyaSn73g5CSu+7AT7eSquRlQ88CB6TMlh3v+3gxJ8qWjO3JA4u2Zq68+z
         ITFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741173026; x=1741777826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t/DonzYY8ky0NPr6wCGSqroH7cDtAqrs9o10+/q7fXY=;
        b=gHGkFoSfduzL+oakuZnRMKlNBEfrWHE+6GydtC74ZnNAsZ5t52+B+r9NyWclAffJzd
         nXty3LVdemTpz041P+HRsIRfqm1Puqnip8Dj7sRhjr1WttcgcbQDNhIHKqxWJkYx+wLd
         TRybfHdTAkJCQV2fIA4ehuwX7KpsjiJMkVVo8b635Py0djrebHqAehRXl+DhnpK2xikI
         /DaqEXnXmajGO5Q0qVKnzSiEBOm7ntSd/qUN1LLLjAWytKIbesK2YAxRTbRbHjpT9/dB
         QJ/EpsH6zoWe6VwRdMm18kMeofUzz/oXYNla+zoUmTuK6HhCIkDP62C7v1fnpOjMGTf1
         1mIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiLSEfaUjI97zxa/XZbxei/3JuKHPueYxo3LN2HFoVbxgkJaYGT4d0WCu70/XRG8XVPQUpuKzirmIWma+6Vw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzRr34ED2+MrUUX2ILPvqcDiyv3Lhy7oazhQav1l4ysKfRvuu79
	G0ugWT1cwQM+ahbpO37ntFBpaaI36aFq2Lhn5d3k5RDQN5s54y+G2i0CxTOR
X-Gm-Gg: ASbGncvr591uHnClaMqp9I2NthUPkvw0eLzuaBPWMW857412y+s/J2Aq5pa2cTzZw3z
	kkaqQSLaKvHJcyvN57Jl9FX0lNKJ1TAThPktT7IuAiKXaOglY0MgROk78hvzrF9qYkoq7m5Td4J
	txt1hqn4VlOofac0/pHg4o5ZHxicplBaQzY5+kxTXcqxsdo00kc5sTUj7hkeoyFlHvBl9pWPqhV
	UyvD7gy8tk/Y9YRYLiN5pi+TFISThK5tK1gy657K1hEOTxkfAh0zeGWypBY9QHPeLPyy/Hy7HQc
	uwl0PYa1lVp53rzmHk4+hSOShjSDHQJZbVPE5jJTDyeXppvbg1jadskPvl5vYViP9nFV3rM0hdr
	V48y+T/rH9XsDTf47ZpOm7g==
X-Google-Smtp-Source: AGHT+IHP0xBykbnwKXKfbmIat/96KZep+usQi4KEOXfaQ1XfgMnIYfTVt4U0//4lVI6PNsYEyT+Ccw==
X-Received: by 2002:a17:90b:1d45:b0:2f5:63a:449c with SMTP id 98e67ed59e1d1-2ff49840804mr4412875a91.28.1741173026565;
        Wed, 05 Mar 2025 03:10:26 -0800 (PST)
Received: from mew.. (p4204131-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.160.176.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4e7737a5sm1060925a91.13.2025.03.05.03.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 03:10:26 -0800 (PST)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
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
Subject: [PATCH v4 3/4] arm64/bug: Add ARCH_WARN_ASM macro for BUG/WARN asm code sharing with Rust
Date: Wed,  5 Mar 2025 20:08:13 +0900
Message-ID: <20250305110814.272792-4-fujita.tomonori@gmail.com>
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

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
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


