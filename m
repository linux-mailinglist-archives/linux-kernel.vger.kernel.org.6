Return-Path: <linux-kernel+bounces-521358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CABF9A3BC29
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 11:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BE977A79BC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 10:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C721DEFE3;
	Wed, 19 Feb 2025 10:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ODZ6S9zt"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6FE1DED4A
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 10:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739962570; cv=none; b=GXawNeH4cARExVV6Tb5+x3F/M9NtqLZbWPnGiddxXyrBAmVYev2M/ommM7NAwWpzuJ1VsRwF6+ZyGcQgKHtAKlSGUP+uB0om+1c4TyyOK5i/B3hYDpONKpczJFFBe2kbaXbwZ3R8wUKvMGzvtA8HvHmFK93ETU/CDtieN+YCDrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739962570; c=relaxed/simple;
	bh=8HT9szvWR537IjOWnHm7i96sWfQ7h7a832H6q37R63o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X/R2q4LIF/G3gNJDzKuCw2fr/1jzTn38BSDlxr/5NzE8P31KEuwirmRnGH97Jt1Hy2m9l/lud9tTxeCSJxqcvdzUQqoGSAWWlpVeySTovQvQkLIpFmzco8yZB9IJUCt0qzjaVkqoMYqri42n5Wku69eSyWSPYLL7gVT0ny9DVhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ODZ6S9zt; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4393e8738b3so53099575e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 02:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739962567; x=1740567367; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NatB0GoxLeeegbtgoKFbIBnXjn7tKR7HZgq3FUQHxOs=;
        b=ODZ6S9ztNho5hR8jzXljuENz+6ElQmTDyQrUNV0gucS8E8eel+KhNa80tuZXtqA4B0
         g5QTR6ztah5XcTW8fxZVPv1K7ArLoPMIg+upV6NzIgyFEL6UOakgVuFKLE+AotIxq6w1
         ZG9IYrL2nuT78fugGT1kts9QkUT+p4Wix8spkBVVdZUgG67QRv3a1N0d2o0+z5JdgpMF
         7Fz7WU/n02xULjKQDiZ8fSSXM4Dtx6PlNaQOvdtnvACCz+sJmVutftBYgFOpxCTyfmZo
         rWGqLm1VkyIXWA0kSJZluBqCe2nczixUphKhug3n7JEJdL0Ai2QagiVby9PA2KdNWRBZ
         FHyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739962567; x=1740567367;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NatB0GoxLeeegbtgoKFbIBnXjn7tKR7HZgq3FUQHxOs=;
        b=GrisTDNPWHkVX02nQ8nyQQW8VZ6Od+pPrg9QvjbkEjoFlVijMNbHP4rG4ip4N1jFLL
         Nvu7Diaq3LUFO0Cgak+pwOjieWRDXM99hSftEutAmh6Zi6BR2d0NI5Cu5eGcKyXmUAs7
         1WHpBETXXVoDKU/yQPoOm0nF52/sgJtv66DyOx3Wz4QTr8KtEyhUJUzgeiLlTS85Cu/q
         1UIXTOcLHmkphycg9pFOAsNdXnnk7OFKFKPiicURTYwUl2ZlmNFX3ROIdhv5lj52goic
         ktsHoHxr1k54YZMaozZ7tQhDOHc/BvNMgGQgnfTfDB0HpiW19dMSqTSORGDMuzAzTbws
         qIaw==
X-Gm-Message-State: AOJu0YyJgA7FjV7FuxHqKbqE2hYuEPGBCxtoIADWIyPViP07su2SPCqj
	7860wPGJh18IjnrUBFlhBtpPkf/AYi/vVy0Li83s99GN3ZL3pL59KfcFiSCiPVGWT82bKWdk0Ur
	69Rzx0k0HEhDH2mFk+EhywleB1fKiV/qGZ5D8iFza5jQAKVZcITnwtdnOFrk3lt7sJcJe/YCcIa
	XmQFuOuFbNkawJk5i+v5ApKqkxd6/LDw==
X-Google-Smtp-Source: AGHT+IFLcm9p0pvvZhlzSdMnVkq911EwhPuHFTm/rfMCU9R3UM8Gu2Hajk5yC4FIyDLBVb8LHLH3Qw7O
X-Received: from wmbay13.prod.google.com ([2002:a05:600c:1e0d:b0:439:8dbb:a84f])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:46ca:b0:439:8185:4ad4
 with SMTP id 5b1f17b1804b1-43999ddad86mr26513305e9.27.1739962567090; Wed, 19
 Feb 2025 02:56:07 -0800 (PST)
Date: Wed, 19 Feb 2025 11:55:45 +0100
In-Reply-To: <20250219105542.2418786-4-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250219105542.2418786-4-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3793; i=ardb@kernel.org;
 h=from:subject; bh=A+DKa9Dw1lZtxprByQY5fMjGI5jp/Yz2HzvZK4YM/EA=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIX3rjo39nlJTslIWHrz8e8Xk52+8+w1XxH682z3J7Kw29
 7HV4t+9OkpZGMQ4GGTFFFkEZv99t/P0RKla51myMHNYmUCGMHBxCsBEPuUw/E+9eZqnzcLtwTqd
 2hc/epM2rjvjpcg1OUdyUVfght5oeT1GhpVqO15v1dxy+f63P+0uG801D55rDjDmTH52N2RaSSH rDj4A
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250219105542.2418786-6-ardb+git@google.com>
Subject: [PATCH v2 2/2] objtool: Use fPIE compatible ELF sections for C jump tables
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Huacai Chen <chenhuacai@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

A C jump table (such as the one used by the BPF interpreter) is a const
global array of absolute code addresses, and this means that the actual
values in the table may not be known until the kernel is booted (e.g.,
when using KASLR or when the kernel VA space is sized dynamically).

When using -fPIE codegen, const global objects of this nature will
generally be placed in .data.rel.ro rather than .rodata by the compiler,
and forcing these C jump tables into .rodata like is done currently will
trigger warnings from the linker about combining read-only and
read-write input sections into the same output section.

Avoid such warnings by unconditionally emitting C jump tables into
.data.rel.ro, which will always be placed appropriately regardless of
whether -fPIE is actually being used.

Note that, while possible in theory, compiler generated jump tables are
unlikely to end up in .data.rel.ro, as the compiler will use relative
references when using -fPIE, and these can be resolved at build time.

This supersedes commit

  c5b1184decc8 ("compiler.h: specify correct attribute for .rodata..c_jump_table")

which addressed the linker warnings by injecting section attributes into
the __attribute__((section(""))) name string, but this turns out not to
work reliably across toolchains, and may result in missing ORC data in
some cases.

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


