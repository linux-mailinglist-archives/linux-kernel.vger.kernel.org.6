Return-Path: <linux-kernel+bounces-519010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCA0A3970B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 011C218996B0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4801B22FDEE;
	Tue, 18 Feb 2025 09:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lt3SDBU0"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8A422FAE1
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739870761; cv=none; b=aLQLML2TtHjcgZ4CIWou9JO1jfO6mLuO6pnARPnHuJwiHzToTLeJv4ZN4Lb4blMwP1OpeezmKqo+ceY9fgZImklrRvMxWiO8+gjvhZowGTT5IYt9WthtQetBah+H4B978bgMNZEFEDMxHuRRu3O1Rectos994UkvofwoW1cfFQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739870761; c=relaxed/simple;
	bh=lXEEO7T0FqH+VLpJEc2Q4UgwwBiDSkZ5WTm8/MKCJFs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Rfd2h5ZHVYiFvi+pAk7ACxMnXTOCQy7463TMvRr9sEioXwWTm4sDCHRkkSDap7fRaXL+pTVcuhMOF0UR6Atj9SwcspHa53zO5mULaW1xp/fQYSxshr2PcXBt2YVBmswBEcF2Hgqlk9YHBlGEScnFlUppgdb8atsywsvbjEI5s+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lt3SDBU0; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43935bcec79so31317305e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 01:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739870758; x=1740475558; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wjOOduKDGHcT8Vgb0X/9k4qlO1QFwJodZck5hVXfSro=;
        b=lt3SDBU0PpCi/IIwfsyRDeQJBEI/EbkoOcvDtZO/M0kIOC4Xnyp9REVRur6OrPdUKM
         PM6eCGTCUq4ibrYVNeiNTkbcQBBe6hNcyKX89Bm1itEgMknLkuJW1IQQoXYt+xLYMD41
         gIBQO6z/cr4JRI+YU0NFqP9YCkCYldGLMIJyh965f3xdC9rSMuBe5tVSlPMzZZqKenHg
         N5IeJ9qEykulve8Grfxmao5n3Kb3HgndHJ7jtwwhcNjnUfVralG29RvIwhMRyNv2UlWp
         l3dtIKKa3SsbnWjGILlAufIGqMyU2HMR+7mEcAcoKkpbGH482I0HpKKTei2HH1Rrm71g
         c6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739870758; x=1740475558;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wjOOduKDGHcT8Vgb0X/9k4qlO1QFwJodZck5hVXfSro=;
        b=tdHjVAW0/MFBycvIwrtkNWToMEUFZi9o4em1Kt/L1NG1vVpyjbXo7XozSPPTO1LmCi
         m4DLqawCmKI5AFIuF25qkcrGvjTLQa+D1IuPzGjKWkjwV5Kx2FWmEfBwBPI7tBSAwxld
         SQIte1yOWYMuGT4xXn4pC3Q0Dmv5T0u36z8YM9RJ+2ZqCBujKmC0IEPMwJcUc25A9Q32
         KkQ58eGJFXVJAxPv6Mzfmtk9WZNel6qXBEpre8+DbXxTDesowzJ5uPme616XMFDJ9Y9G
         R6riGVcmClIQlXe6a6OiCj36mK7XDPw8sjTEI//kp9QQiAVv68hTJh1aGZ0jSWlzC3Od
         eNRw==
X-Gm-Message-State: AOJu0YyKAbULRAFleMWDRzg7ReFHUvr2YHxT7cRbAOeF6EskhdqXtuOh
	6JJIjYtKYm6hC1lt1OTIPTwXhIu+4Lg5BDEkWNZuNIdSIq8gzSioHwaWu/ygeGVlW+5Y8nMYpBT
	0D3EHokHbaBepNR3TP70BXNb4t0jZ0dxWF0hFNL4hpLiDKR0e7nCVQ3HFf9Yhz3fOGlIAg9bGAF
	zePqTuq8SQ3x1CEr6RWhShnp/F70kMVw==
X-Google-Smtp-Source: AGHT+IHcTvBIELiae2jbCaKIsj4xk3ATQLL5XhCJbvPQHbKb742vkXjlO0fwV+jT1j+KyB6AvuRIICCz
X-Received: from wmbea5.prod.google.com ([2002:a05:600c:6745:b0:439:82a0:5431])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4586:b0:439:94ef:3766
 with SMTP id 5b1f17b1804b1-43994ef39e2mr10247935e9.19.1739870758266; Tue, 18
 Feb 2025 01:25:58 -0800 (PST)
Date: Tue, 18 Feb 2025 10:25:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4143; i=ardb@kernel.org;
 h=from:subject; bh=vPCezmZ+PGpGlf5Likdmm/yzVp+kHiUqsi9ldxgZUAA=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIX1LkPCUDx9qqvRkaqqLZfbclhf5fCIrLbhhU9hps7/s2
 e66G+w7SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwER+7GZk+Lbq3j7HBazbRf8k
 XO2w4DywuNNAfOnCJnf7TNfrdkm/qhkZ/t8raHGJ/d0lmni8Ye3/7x39V1fy/PL4KLeE/6PlRg5 TRgA=
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250218092538.1903204-2-ardb+git@google.com>
Subject: [PATCH] objtool: Use idiomatic section name for relocatable rodata
 under PIE
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Huacai Chen <chenhuacai@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

When running in PIE mode, the compiler will emit const global objects
into .data.rel.ro rather than into .rodata if those objects contain
statically initialized fields carrying addresses that are subject to
runtime relocation (e.g., function pointers).

This is needed so that the user space runtime linker can identify which
parts of the executable image need to be writable initially, but can be
converted into read-only before the image starts executing.

This distinction does not matter for the kernel, but when using the
compiler in PIE mode (such as when building for LoongArch), those
.data.rel.ro sections need to be treated as .rodata as well.

It also means that manually placed const global objects that contain
absolute addresses (such as the non-JIT BPF jump table) need to be
emitted into .data.rel.ro too so that the linker does not complain about
conflicting permissions.

Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
Please consider this approach instead of the ..rodata hack - thanks.

 include/asm-generic/vmlinux.lds.h       | 2 +-
 include/linux/compiler.h                | 6 +++++-
 tools/objtool/check.c                   | 7 +++----
 tools/objtool/include/objtool/special.h | 2 +-
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 91a7e824ed8b..337d3336e175 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -457,7 +457,7 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 	. = ALIGN((align));						\
 	.rodata           : AT(ADDR(.rodata) - LOAD_OFFSET) {		\
 		__start_rodata = .;					\
-		*(.rodata) *(.rodata.*) *(..rodata.*)			\
+		*(.rodata) *(.rodata.*) *(.data.rel.ro*)		\
 		SCHED_DATA						\
 		RO_AFTER_INIT_DATA	/* Read only after init */	\
 		. = ALIGN(8);						\
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 3d013f1412e0..27024a128a6a 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -110,7 +110,11 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 /* Unreachable code */
 #ifdef CONFIG_OBJTOOL
 /* Annotate a C jump table to allow objtool to follow the code flow */
-#define __annotate_jump_table __section("..rodata.c_jump_table")
+#ifndef __pie__
+#define __annotate_jump_table __section(".rodata.c_jump_table")
+#else
+#define __annotate_jump_table __section(".data.rel.ro.c_jump_table")
+#endif
 #else /* !CONFIG_OBJTOOL */
 #define __annotate_jump_table
 #endif /* CONFIG_OBJTOOL */
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 1398ffc20b16..898d0cee4565 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2471,14 +2471,13 @@ static void mark_rodata(struct objtool_file *file)
 	 *
 	 * - .rodata: can contain GCC switch tables
 	 * - .rodata.<func>: same, if -fdata-sections is being used
-	 * - ..rodata.c_jump_table: contains C annotated jump tables
+	 * - .data.rel.ro: same when using -fPIE codegen
 	 *
 	 * .rodata.str1.* sections are ignored; they don't contain jump tables.
 	 */
 	for_each_sec(file, sec) {
-		if ((!strncmp(sec->name, ".rodata", 7) ||
-		    !strncmp(sec->name, "..rodata", 8)) &&
-		    !strstr(sec->name, ".str1.")) {
+		if ((!strncmp(sec->name, ".rodata", 7) && !strstr(sec->name, ".str1.")) ||
+		    !strncmp(sec->name, ".data.rel.ro", 12)) {
 			sec->rodata = true;
 			found = true;
 		}
diff --git a/tools/objtool/include/objtool/special.h b/tools/objtool/include/objtool/special.h
index 34acf4ae5fab..e049679bb17b 100644
--- a/tools/objtool/include/objtool/special.h
+++ b/tools/objtool/include/objtool/special.h
@@ -10,7 +10,7 @@
 #include <objtool/check.h>
 #include <objtool/elf.h>
 
-#define C_JUMP_TABLE_SECTION "..rodata.c_jump_table"
+#define C_JUMP_TABLE_SECTION ".data.rel.ro.c_jump_table"
 
 struct special_alt {
 	struct list_head list;
-- 
2.48.1.601.g30ceb7b040-goog


