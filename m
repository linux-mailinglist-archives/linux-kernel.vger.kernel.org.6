Return-Path: <linux-kernel+bounces-546648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B022A4FD43
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 284E21885836
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CD9241669;
	Wed,  5 Mar 2025 11:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aiuv6em/"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD91A23372E;
	Wed,  5 Mar 2025 11:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741173016; cv=none; b=dULfcU3HkW0Qu2l7NxQNKLzpHED/uJqe491ElSLEz1HuGgZEjd2YvlU3zSG/IXHpT1+XFg25nfUwxzTSnr0PQuB7sJ2XGiJcGP2qNblp9vF+YT5jjLD6E9dofg1YSr4sdmHCbT6LvT4R8+ivvjvBt9HnyBy0HIPTlXRMv/WJL1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741173016; c=relaxed/simple;
	bh=h/3P2KY8vDMPXX5OJwI4gjMRRH8LzIOf17+FXLQKEXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HWydlrJ3YKYCucBpGPchMBeG1O++nAy8tv6fWOVVelIskNspol6DJVUi/h3D6NO+3HIPLL9XU4G2be3a7aKkQw5thW5vQ0DheZ9xOq5+Oiwn3eNA6gDSLgaS9kGMj3A4xB4stEjnqIx5M71FXTSibY6nfSJZqTASSyLdQDh6/ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aiuv6em/; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2fec13a4067so8226681a91.2;
        Wed, 05 Mar 2025 03:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741173014; x=1741777814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gg/V+lwtqWQq5Y/Ly9J/s6hUNho4JthxgdaqasfoAcA=;
        b=Aiuv6em/bRJ7cH/JhqbDZDB0KZ27FUq7BOiRxB4bHaqce+l+SfUmkN8VKPSXMcTQsU
         3zQ8vgrGEvh2xZaPR2uveQXn+TUqzHXhkJMpKiEbkmRNg1ZePiyq2WBh1yws9udi4kAU
         ugIgt9/JEXKHD82qs1MLag+DDftUXUL3Im3oD6SCFNu8bBhB1uQsll/Z4odgTQGRGdFs
         dVaWNo/Rf6UhXpBVOUunoMXcE8EEcM1YnZytKpgnYFD0xJTsaoDMgVQcGqcYi7hy7DsG
         jpmugPfV/SXfFyLekI+UiTwMPxwl+djjm5q2fINdpT3DLKBskNpWWmF3I0tijheM8R+O
         fLGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741173014; x=1741777814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gg/V+lwtqWQq5Y/Ly9J/s6hUNho4JthxgdaqasfoAcA=;
        b=jj7cAMsWZhFQJ2eJmCGHvTJkdSQBLCyfvpbr3R3lktCY3vtDnb1jovLQlJnY843tx+
         +hekIvXoX2x72NrcxspDFMovn+2qrKsDejvhyKoJ4eWSPmdqtsnk84ZvaP/lyTs9FCqd
         S840NCPkVrNTmci/RpVHdB4LpsUNPVwxyLY8zqxnNtOLddvbX2ixXxzlLPgladEeGYf2
         giT5vp2q/hlAR7iikN1BwiRQPKg6ytaBfnsipKnPOkyEftq7a5pyGXiD7a+oPXk2syS0
         1szytgjcGrwsYZxBPFvoYnz3N3zD6QF2Miugv9BV1r3Pxdef5mcvqZpiO9GD+cNnmBzA
         DqbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUD/OBLFek8modYOSbOp1zWqPZ6AKuIgiExs2RhWMHMlbyVksoEmZQ8j1UvoQdX5cW1fh/frPzbzarOcoDk8g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yylqy2bmuq4oC2eP7eNE0hrMHYun2Uv/4UdmMaEHOvuMji7/qi1
	HGmI30VfosvDTLWERlZTMZAa1gD6+TW5hNo6/2YU4rsTleMHUuls5tyOLwRA
X-Gm-Gg: ASbGncsqhv1TwUcgDHnYAzgBIx5uj34foOWIUg/Qs1wdVe2w3wQIEBTHnsA4KUghI2K
	T/4XFBdRHW0HwmBF0S7CWkWbHBI+koYSos/OodlGHe5PbNhNnT9+pYlwCkuLzq04q1HUwNtueVn
	znLQU0m0HLmd4kEvptUaz8GXBCXm/mhmg0ov6zl1wIEiyjV7iIejcc+bzvhyzf1e+zqBB/zp5EU
	5t+wA1ScbxQGPAU8NUVNPjK7pwsJHJ9RfGiI0HOioP+4ycXa6zBz3KYsUxBpNNkDv/afjZDhcLI
	fNm5Zjo55aXiiP9xDAiIIJNNhqMw/J6V+KOnGQysGSDIjZ6iBkj/PLO7pOwxv1pSFGqeloaBkix
	rrT4r1uREUAErn9wdZ/bxyA==
X-Google-Smtp-Source: AGHT+IGT4sqxYXWLlVa8YluGkM22xVpQMVO/t8msCjLv92geQSngVV+IoJoiRn7vgEXbNQJrnp5b6w==
X-Received: by 2002:a17:90b:2405:b0:2ff:58c7:a71f with SMTP id 98e67ed59e1d1-2ff58c7a78emr497795a91.32.1741173013960;
        Wed, 05 Mar 2025 03:10:13 -0800 (PST)
Received: from mew.. (p4204131-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.160.176.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4e7737a5sm1060925a91.13.2025.03.05.03.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 03:10:13 -0800 (PST)
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
Subject: [PATCH v4 1/4] x86/bug: Add ARCH_WARN_ASM macro for BUG/WARN asm code sharing with Rust
Date: Wed,  5 Mar 2025 20:08:11 +0900
Message-ID: <20250305110814.272792-2-fujita.tomonori@gmail.com>
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


