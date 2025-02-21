Return-Path: <linux-kernel+bounces-525872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D171A3F6A6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6432864A82
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 13:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3561C20F088;
	Fri, 21 Feb 2025 13:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="viHjQw7b"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EAD192B74
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 13:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740146239; cv=none; b=jNX53oqloQSfeSoctihWFBVcHf5cA/9ply6kXjXzGXksLnKlhvzE84KdfMwOjxfo/CsZqZu51IrmJj2uio+6iQP9gjyqlucS1wY59C8aoDRT3GeFCzNmjefk33zPpYhAyYC+MamJlDF+OJ62RiNOwB8/1QRWqNJeWF4KBJ0Aom8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740146239; c=relaxed/simple;
	bh=a79Mmvb7KAIRH0fH5w9wctIAGHoCSn1TnROgyt4BGz8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m8dw1od2hsO4jpHt35jfEybSLusSYOrUZFvxMioVBxHH/V3k4DpGwtN6wyEwwT9xL38VWbi5o5+zH5Q6KxozX1yWqPYWUPubZbngPd2SMY2bdhklyGW/HxJgf38uRF6wenRJkYgk9d3ulWrV0V182N+7L/6k+03CQk1URKqI1MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=viHjQw7b; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43941ad86d4so10769625e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 05:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740146236; x=1740751036; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nzZpqR+jh487eF8Ng36zvgLqP3+9BSLuVj6q4tRe9h0=;
        b=viHjQw7bNr5zr+bpmuyAZukH0lIXokQAzAsaTUGXkUOAvyCNhHQwwnoaSDDy9YDf+/
         ZMUQvACgfNIB64e/1DOws6bc+8gSJJuQgTXEk5AkrKBqb01nUWmuyW6KRLjNlr5nUQOX
         PsDUuvn1+qWQVKWFFVbbCR14fQJz6ddjjdzDLA+r7jdj6jylZPcdYp/rxWfSQTcKth35
         kvRt3XMBEXDFJ1MRhQZIvrqyO2ZwsHeEgj600aGKmiBy10mwczvmmIJRNoB4YvHXMPe2
         Zq7p0rpyzzeKxI7n9BEEB6L9oIsWlNaIRMH1k8M7NOjCwAeXHgspGRWGRgd7L7G4v05X
         PeZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740146236; x=1740751036;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nzZpqR+jh487eF8Ng36zvgLqP3+9BSLuVj6q4tRe9h0=;
        b=Iyr7M05bFH0V//VbinFJLJeJ6Mfyw2QyO/3VU8ZoNmEbUOhGNgXBI/pzvCrXjFsYdJ
         1B74yaBa9QF7TEhOuBTkAtlp3G9VLcobH5yccQdRANcfXYOYVH6Xkof1oeuZxPDrOgND
         V7dYoGMowVPWwlY2uoeGYHWS6YC7ivi5F5rMdsgYV3oo9qgeFfclZ75Fk7hDoBt0GSA1
         igi8ueU89eGz9+2H9cQRefg8MLZloINLorrpvA3Fg07cpQOi5VtfXNuso9a4Ibnd/Pi/
         J5VP/icsyta19Vyuiz/aZFUD9AsUxAiq9u7CYRtfPB4Za2+13zCrnZSUmlPAGwLD0jQN
         cjew==
X-Gm-Message-State: AOJu0YyADmnQpLSn1FT6hvg+c5n9YItXi5HrTb44oz+e6JlmENkHpfP8
	9GtB//9WI9umJPqJqdh8dTkhCFoTx6BHRxOaMGoQ9nsZ8j49x3B/ozeEnYg0YrLdY0Ue1SpUNLq
	Uq+IDAhZy4Ri2YItcqhe3BYl+cwmQRCdgg9M7wntkPoFyuPD6pE6l1HxdqGd+M6Pby135OylNV/
	YUx4nZBFB0BDlkXUvSz3iznHFNxjGFaA==
X-Google-Smtp-Source: AGHT+IGgf8XLXw/Ci0RSrUYzS5I2txYam9Si6B3hNT5owr59LtHbugsfNJ7/J6gIMtKHEm3CNmAAlPdj
X-Received: from wmbay22.prod.google.com ([2002:a05:600c:1e16:b0:439:66ab:de64])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:5106:b0:439:a25a:1686
 with SMTP id 5b1f17b1804b1-439aebda0bbmr20908835e9.25.1740146236005; Fri, 21
 Feb 2025 05:57:16 -0800 (PST)
Date: Fri, 21 Feb 2025 14:57:07 +0100
In-Reply-To: <20250221135704.431269-4-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250221135704.431269-4-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4143; i=ardb@kernel.org;
 h=from:subject; bh=FEOqxJKJWN1Zy4dD53yjp/vbwnfOa33qirxv86HFvWo=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIX1Hm/Hr+3xb9nD982AOq347O72p6diSG3mTds1dyvxmy
 u4bq10zO0pZGMQ4GGTFFFkEZv99t/P0RKla51myMHNYmUCGMHBxCsBE/rgw/NPw+du77bjnNqW7
 Zr4cy7Y7XFWVEZ8zryshlPvz/hP3H4sxMqxZXn5V8avA7QuhjYLTrp71OmK8uOewHtuWNL6lc6/ aH2ICAA==
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250221135704.431269-6-ardb+git@google.com>
Subject: [PATCH v3 2/2] objtool: Fix C jump table annotations for Clang
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Huacai Chen <chenhuacai@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

A C jump table (such as the one used by the BPF interpreter) is a const
global array of absolute code addresses, and this means that the actual
values in the table may not be known until the kernel is booted (e.g.,
when using KASLR or when the kernel VA space is sized dynamically).

When using PIE codegen, the compiler will default to placing such const
global objects in .data.rel.ro (which is annotated as writable), rather
than .rodata (which is annotated as read-only). As C jump tables are
explicitly emitted into .rodata, this used to result in warnings for
LoongArch builds (which uses PIE codegen for the entire kernel) like

  Warning: setting incorrect section attributes for .rodata..c_jump_table

due to the fact that the explicitly specified .rodata section inherited
the read-write annotation that the compiler uses for such objects when
using PIE codegen.

This warning was suppressed by explicitly adding the read-only
annotation to the __attribute__((section(""))) string, by commit

  c5b1184decc8 ("compiler.h: specify correct attribute for .rodata..c_jump_table")

Unfortunately, this hack does not work on Clang's integrated assembler,
which happily interprets the appended section type and permission
specifiers as part of the section name, which therefore no longer
matches the hard-coded pattern '.rodata..c_jump_table' that objtool
expects, causing it to emit a warning

  kernel/bpf/core.o: warning: objtool: ___bpf_prog_run+0x20: sibling call from callable instruction with modified stack frame

Work around this, by emitting C jump tables into .data.rel.ro instead,
which is treated as .rodata by the linker script for all builds, not
just PIE based ones.

Fixes: c5b1184decc8 ("compiler.h: specify correct attribute for .rodata..c_jump_table")
Tested-by: Tiezhu Yang <yangtiezhu@loongson.cn> # on LoongArch
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 include/linux/compiler.h                | 2 +-
 tools/objtool/check.c                   | 7 ++++---
 tools/objtool/include/objtool/special.h | 2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 200fd3c5bc70..155385754824 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -110,7 +110,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 /* Unreachable code */
 #ifdef CONFIG_OBJTOOL
 /* Annotate a C jump table to allow objtool to follow the code flow */
-#define __annotate_jump_table __section(".rodata..c_jump_table,\"a\",@progbits #")
+#define __annotate_jump_table __section(".data.rel.ro.c_jump_table")
 #else /* !CONFIG_OBJTOOL */
 #define __annotate_jump_table
 #endif /* CONFIG_OBJTOOL */
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index be18a0489303..ce973d9d8e6d 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2472,13 +2472,14 @@ static void mark_rodata(struct objtool_file *file)
 	 *
 	 * - .rodata: can contain GCC switch tables
 	 * - .rodata.<func>: same, if -fdata-sections is being used
-	 * - .rodata..c_jump_table: contains C annotated jump tables
+	 * - .data.rel.ro.c_jump_table: contains C annotated jump tables
 	 *
 	 * .rodata.str1.* sections are ignored; they don't contain jump tables.
 	 */
 	for_each_sec(file, sec) {
-		if (!strncmp(sec->name, ".rodata", 7) &&
-		    !strstr(sec->name, ".str1.")) {
+		if ((!strncmp(sec->name, ".rodata", 7) &&
+		     !strstr(sec->name, ".str1.")) ||
+		    !strncmp(sec->name, ".data.rel.ro", 12)) {
 			sec->rodata = true;
 			found = true;
 		}
diff --git a/tools/objtool/include/objtool/special.h b/tools/objtool/include/objtool/special.h
index e7ee7ffccefd..e049679bb17b 100644
--- a/tools/objtool/include/objtool/special.h
+++ b/tools/objtool/include/objtool/special.h
@@ -10,7 +10,7 @@
 #include <objtool/check.h>
 #include <objtool/elf.h>
 
-#define C_JUMP_TABLE_SECTION ".rodata..c_jump_table"
+#define C_JUMP_TABLE_SECTION ".data.rel.ro.c_jump_table"
 
 struct special_alt {
 	struct list_head list;
-- 
2.48.1.601.g30ceb7b040-goog


