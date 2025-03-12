Return-Path: <linux-kernel+bounces-557529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9691BA5DA68
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EDE1179901
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 10:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB86723C8D7;
	Wed, 12 Mar 2025 10:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4rlvSfFT"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6AD238D34
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 10:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741775268; cv=none; b=QZt9ccXjwoMBiBb9JDiJatRwHgWs8chKdFWVIIvkLubsCkjGcU1w6QRAJGt43Gz8ZQvb2FdPr/cgGoscLlJpxyqp/74PbR1k520CMa2F6aATvQ2V0uvC7FoAl+FgTmEsXgDva1v7EzP/soCJsvGrS4dJfnIMXeM6CZGllitfGvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741775268; c=relaxed/simple;
	bh=+R/nfa+6sr/q7ce+eZjlkJdFAJtHGVCAAGgYI45Hb2Q=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=N7yRLL1FiCX1xWuUiRSWXkyItZG5vK+BqEFtBUuCsOKwVukxbORGCx2yuPZuB5ttOek27/dfjz6mYezI7srnz0Tk+C5YQzVv2fEdFCYzu74MA6PA4X5dhbmjjC7TFiQMLSfmnyD0rOxyBCVybJo1HsgEm08UFIGH7H8ms0rZeJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4rlvSfFT; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43941ad86d4so32120055e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 03:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741775265; x=1742380065; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NEJPr0RAeLicfIPWbYkCZmxmoGwmaoBCPjUbsG9foM0=;
        b=4rlvSfFTqSh1lDbVZqHRM24wP8p6GqcDU35SSEJe43rncgYUbV3r0G3mNzcDW7x+t5
         dfr2oextMgA8YqGKXxs+kv81Fosb/6F21D2LS9QdLJA2ZukjhK5ssxZYJOiWTI2oWkJt
         7yPNesbmvwn6UigGdr4IK0EHJ4yF8jgrF1B4WA2GfTWpRn42L4gtDH7MlIfAvajNuq89
         1IFN71VUWUyFke+Xwb2yEKtQ1X/0/Fa0Pm6vJ5FyXRqoD3rtdaYkaLakCQ0ZkTQfW3n6
         EuMMIrcHzEAR+bd/1TgFf+Ka2lWrEd55j2JHYzFdrzA9fZWSJsagzZgfB9Pb/17CCCaT
         5d6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741775265; x=1742380065;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NEJPr0RAeLicfIPWbYkCZmxmoGwmaoBCPjUbsG9foM0=;
        b=cLtYq/bb3hxbCt8cxaJ4f2eVnK9s30VGS2dogdcFQQ2YbTzRBi1Ko4Ha8ThPVctWWX
         by98QBxpgGNlwpitPCyla08FJlBPjX+gvwjm9EN0nTRNqo0Ul5tefgli2SzzF4wgc1Od
         3lV5f7asxPBYtWSTpcKS7PIOjofhAV5UtzwMcPkpKvA6sqyvtdSZ6UVgEZTHqXajvvql
         OviIbrPchya95mY0CV0cCM+0HqWNmxE57ldfmi59TodkQqsf73OnbsjevUEHQb6sPjY6
         dpqB8ky5EBszBodF/10MZy/2fh4C+Iy25uuCvSiBl6aOkmR6TMYWnrlZ2FnD5qmx18RJ
         2oWg==
X-Gm-Message-State: AOJu0YwQQP5FfflaEgCt9ku4aPPZQ2pt3VO0XYTTfYfDKkFagJNDVTOs
	IUOdzXlNIxUh2PN2rf39uUV47HDcVuIhV7CgFxs8C1y/PGgGExlIg17M4N4qJqjjf9I2VNBY664
	BfGF/OHs4SO7CRGZZbjKUTg21GZk818BN11uGdFnwGS7WFGNLwzdGRydzh0mn95/uaLkQHKr17V
	kQRcSY7Rqeqy60AhbvKut2V0Re2cJwDA==
X-Google-Smtp-Source: AGHT+IGDa+BSdAbGTt2M+zzG1cRtau9tLWxQrf2jnl0EBkYcFyFDHgA4nWjWnbkPR59rqmT7w2yN6Hyt
X-Received: from wmbay38.prod.google.com ([2002:a05:600c:1e26:b0:43d:1c3:bf33])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3586:b0:43c:ec4c:25b1
 with SMTP id 5b1f17b1804b1-43cec4c26d2mr115743225e9.23.1741775264936; Wed, 12
 Mar 2025 03:27:44 -0700 (PDT)
Date: Wed, 12 Mar 2025 11:27:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2530; i=ardb@kernel.org;
 h=from:subject; bh=gFdtL5JFQVUCKEBUAsZ/feLWQgtFaoLOAgy2VQ1UqH8=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIf1i4lwL5plvtTRb/R/fNOWoCJdd5zdzroj20lfMy4o/i
 kcy77LuKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABP5qcTIcJWbe6ttaU6tY1Ny
 u/D3PbvdX+9r0PldEXe63Dz5pvuvOIb/5WyuJiodS1ynGbHcs+O9z2LlklK9WHDyn+TtB38c21H KBQA=
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250312102740.602870-2-ardb+git@google.com>
Subject: [PATCH] x86/head/64: Avoid Clang < 17 stack protector in startup code
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Brian Gerst <brgerst@gmail.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Clang versions before 17 will not honour -fdirect-access-external-data
for the load of the stack cookie emitted into each function's prologue
and epilogue, and will emit a GOT based reference instead, e.g.,

  4c 8b 2d 00 00 00 00    mov    0x0(%rip),%r13
          18a: R_X86_64_REX_GOTPCRELX     __ref_stack_chk_guard-0x4
  65 49 8b 45 00          mov    %gs:0x0(%r13),%rax

This is inefficient, but at least, the linker will usually follow the
rules of the x86 psABI, and relax the GOT load into a RIP-relative LEA
instruction.  This is still suboptimal, as the per-CPU load could use a
RIP-relative reference directly, but at least it gets rid of the first
load from memory.

However, Boris reports that in some cases, when using distro builds of
Clang/LLD 15, the first load gets relaxed into

  49 c7 c6 20 c0 55 86 	mov    $0xffffffff8655c020,%r14
  ffffffff8373bf0f: R_X86_64_32S	__ref_stack_chk_guard
  65 49 8b 06          	mov    %gs:(%r14),%rax

instead, which is fine in principle, as MOV may be cheaper than LEA on
some micro-architectures. However, such absolute references assume that
the variable in question can be accessed via the kernel virtual mapping,
and this is not guaranteed for the startup code residing in .head.text.

This is therefore a true positive, that was caught using the recently
introduced relocs check for absolute references in the startup code:

  Absolute reference to symbol '__ref_stack_chk_guard' not permitted in .head.text

Work around the issue by disabling the stack protector in the startup
code for Clang versions older than 17.

Fixes: 80d47defddc0 ("x86/stackprotector/64: Convert to normal per-CPU variable")
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/init.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/init.h b/arch/x86/include/asm/init.h
index 0e82ebc5d1e1..8b1b1abcef15 100644
--- a/arch/x86/include/asm/init.h
+++ b/arch/x86/include/asm/init.h
@@ -2,7 +2,11 @@
 #ifndef _ASM_X86_INIT_H
 #define _ASM_X86_INIT_H
 
+#if defined(CONFIG_CC_IS_CLANG) && CONFIG_CLANG_VERSION < 170000
+#define __head	__section(".head.text") __no_sanitize_undefined __no_stack_protector
+#else
 #define __head	__section(".head.text") __no_sanitize_undefined
+#endif
 
 struct x86_mapping_info {
 	void *(*alloc_pgt_page)(void *); /* allocate buf for page table */
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


