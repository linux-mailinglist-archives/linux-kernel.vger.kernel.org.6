Return-Path: <linux-kernel+bounces-438620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C77F59EA390
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 01:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59D34282BEA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 00:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96565433CA;
	Tue, 10 Dec 2024 00:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i550Pc1Z"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A2742056;
	Tue, 10 Dec 2024 00:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733789966; cv=none; b=hgjyp7gBs/HTkqubxaF52mYx1gm3sL26ke+iyQCI2qZz1bycSoTLAtcpRLhQZTk31MsJgCq5IW9XAPo6YaiRVM9Lk6WCQj/8gcWyTWxnMfB1oKdCWY716VJl+V5UDTVMZWbl6Po2SwngUbC3ONHmfNpsQmZAMLRIfCDFvEP1sEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733789966; c=relaxed/simple;
	bh=PphfExRm9WK9LCNvRjMF7+BNzJn3sHB2vfQS0MOjRdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HgJskCAqkwOfXZuIc4oGuqV9xIZ1gEuTX1rhQg47J2apaAr69kE5AUG94l47ivVEjsLaGTXmJRO0amcEF2MKGlvkHFhcaDs3jbYBsyczdg3YWN7LNNApNlN+zIpsmBcSPPogSPP5MCrr2IIweMVAkMn+Nso8FiEdrKbC8vkFBSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i550Pc1Z; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7258bce5289so3907255b3a.0;
        Mon, 09 Dec 2024 16:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733789964; x=1734394764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uE1ozcM0HS04q9lZpGc37IxiI38s9WgqP3M8QOeasQ4=;
        b=i550Pc1ZyLHxoan2IEL8SHeDoMVZ6cWa9nsl16kx3Qh664d0gue/9IcE5+EUbjrUYm
         DEb/yO2hWGtBgRQH6eDWCSpKdHEwLzgieVsIrWn6dcuOGAykQhW/3tp8HWMNtKvA1iD2
         maB6vCHu6yAbFuZTiDE0hv0KS5U1l4CG4UQOvDBhJA6Qp9tlsw38uAAIpF60OcOoW2z6
         lyzfc57A+3yjGrrGhHDVBNfDHIy6g2NFcwdzY1SdawiTHw/FA1J/inKU1dDpFm0W3MqQ
         SQq3nT5iSVqpwi6/zMVfCoF7FVPZDQVFeFCQFeMhS88h/y8mtpVeXx+Fr7KQZzHmr6yG
         +Cow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733789964; x=1734394764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uE1ozcM0HS04q9lZpGc37IxiI38s9WgqP3M8QOeasQ4=;
        b=ACjgO8g5aMtOXV/ISoTbeQVuK5/8HNI0cW4UA/lWK2w223k6rNRRSHmEVQczWt2hIv
         93Td8gUSpzJmWQd0Z3RfpqCk9Ay7yb6iyckDdtS68P9QvJWIabdGogRVBheQEKY+FT7E
         bqwwyjfSe5u/EPcxKqacpWI7jlDktQ2voTKmLPCkb+dHhKATicQAJFA4/PJFcDkCxiK7
         UC07sZi4h0WGAKnzoW8Io152R6EMSs6RLR7pTEJWlGNWoGVaxShrGBTmUX0DcILI9FXh
         PNgGJRrx+4Ru01UDcQfbsyCWyJukUT6kTxCyXhTWg8ZQGZMFAwRhEX/9kq/t3sZUBg24
         gAcg==
X-Forwarded-Encrypted: i=1; AJvYcCUxwcm220Ni8n3LugcHjuUgGjoi04T533i3eqTP/enWl2dWHLPhSy6ZuGJ9xN4eOx7Dmkhzdd65JlGwX2LomA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz4OurTa3jQyZWcX3ljYY7i5RO1HbyuMXxilN7OZ0q5wqLnNx1
	eTOOFbCGbaFJjaB4caZfTTRLU04W5h+MZzVptq9sVaT4blMUkEBT0h9f9SDU
X-Gm-Gg: ASbGncsJtOmzHxHUkUvEuV4g1A6NaIzKtn9lJSigbLQy3tvlt5cbXckBnxQ/7Ev0GLl
	rWkUFmTEzXFQfkzliPpz33xIK8PqqbBTksGa9Wn4ZdFumMoCVbguaUIyoQFAM9hENP1EGN2jvaD
	+/bAykd5nnb0aRJ2CXYl02d+iFtRTEzx3peIbKj5Jl/hg+OvftAEcuY08P9TBJErtDZy5z9qQI+
	ellPD3jWYTPUvUdBd/Ok2q8HpY5mxZtK8eJRsWqpBX0pQ9/Fc5aZ53shdUIraOWWfwpU23Q8PQp
	PB+WPRynkpJ4Fv7IA1mpSz5dGW0B
X-Google-Smtp-Source: AGHT+IE0sO05jto/zLfmn6/T151S8aCpOvFIvTm7U8rW5Jtk2M587AQu6vur1sMtmKA/fHe5aWFjDA==
X-Received: by 2002:a05:6a00:3e1b:b0:727:3935:dc83 with SMTP id d2e1a72fcca58-7273935f820mr4927070b3a.10.1733789963629;
        Mon, 09 Dec 2024 16:19:23 -0800 (PST)
Received: from mew.. (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725f1fba027sm2005005b3a.3.2024.12.09.16.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 16:19:23 -0800 (PST)
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
Subject: [PATCH v1 2/5] riscv/bug: Add ARCH_WARN_ASM macro for BUG/WARN asm code sharing with Rust
Date: Tue, 10 Dec 2024 09:17:58 +0900
Message-ID: <20241210001802.228725-3-fujita.tomonori@gmail.com>
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
 arch/riscv/include/asm/bug.h | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/arch/riscv/include/asm/bug.h b/arch/riscv/include/asm/bug.h
index 1aaea81fb141..ee6b9b787e46 100644
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
-- 
2.43.0


