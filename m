Return-Path: <linux-kernel+bounces-281875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 728EA94DC5D
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 12:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A51EF1C20C4B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 10:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8195715852C;
	Sat, 10 Aug 2024 10:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="PEumRTuJ"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD19150996
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 10:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723287294; cv=none; b=ZxuGqSqv/XnZE4Sr53tf/o31hqf/XHMtlw4hszGJnaV1VajUrPZ1PpO0FIDZXNiCBhTeFXgPd+fjMP8JbBv4oq/VRhmimrVceIybumSHEARC1QAnPiSw9EOmeJzKDdSa+Bro6DGOXTAVw9QxnhOroDPvDjpkIfpk+bHmNhOOfBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723287294; c=relaxed/simple;
	bh=cGwHAKfERKI5sQ+r87zSxLZ/oZCmGAEV09XlpQjon3g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RpMPwSehq3F6GQzdtjZZGmAotRzSkhaI5xXQ3Ua2qUYgV2RQ1w4uLrIEMk/1f4epJTf51MErLcmVVD34faVCe9aFG1b3Vjg4Od3rP+vINClinI5dAtWvnNboMOmNIl0K+MhN3S6fdj5TBO4hcLqrXg5TPQGSLkBQQwWm+AsBHXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=PEumRTuJ; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1723287289;
	bh=cGwHAKfERKI5sQ+r87zSxLZ/oZCmGAEV09XlpQjon3g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PEumRTuJSQaUebh63q09OBT7vMRphs3o9LjUZAZw2MMB/K0eNYHpdWRnKZ9f8VWlt
	 ujsbPjKAl3Nkr0x0ChQfQKz+sN1E7vOC+WKingxsuxmlHN8aenDUb9xZOCIlet0HwB
	 81XtGJuDeRpY6aXCXfWnjJC2zUlqmWtFeBg0606I=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 10 Aug 2024 12:54:46 +0200
Subject: [PATCH 3/3] tools/nolibc: x86_64: wrap asm functions in functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240810-nolibc-lto-v1-3-a86e514c7fc1@weissschuh.net>
References: <20240810-nolibc-lto-v1-0-a86e514c7fc1@weissschuh.net>
In-Reply-To: <20240810-nolibc-lto-v1-0-a86e514c7fc1@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>
Cc: Ammar Faizi <ammarfaizi2@gnuweeb.org>, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723287288; l=3197;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=cGwHAKfERKI5sQ+r87zSxLZ/oZCmGAEV09XlpQjon3g=;
 b=pxhMoc4sMKT6LD83WJ9WfI4uZpnrkecV6c3aWRQXSPEcjvRWGH/lrAYr3YEBlTKTyvvjU2sfR
 w8UqqOvB/uwCYktVMYaUZ59ucAEOB0rwjayQNpm5kkbCaueejuZA7d4
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The bare asm usage does not work well together with LTO.
It leads to errors:

  /tmp/ccIHTYT6.s: Assembler messages:
  /tmp/ccIHTYT6.s:36: Error: symbol `memmove' is already defined
  /tmp/ccIHTYT6.s:37: Error: symbol `memcpy' is already defined
  /tmp/ccIHTYT6.s:46: Error: symbol `.Lbackward_copy' is already defined
  /tmp/ccIHTYT6.s:54: Error: symbol `memset' is already defined

Wrap the asm in naked functions, which leads to the same object code but
avoids the errors.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/arch-x86_64.h | 80 +++++++++++++++++++++-----------------
 1 file changed, 44 insertions(+), 36 deletions(-)

diff --git a/tools/include/nolibc/arch-x86_64.h b/tools/include/nolibc/arch-x86_64.h
index 3c3b703d9b0c..efbea173fb74 100644
--- a/tools/include/nolibc/arch-x86_64.h
+++ b/tools/include/nolibc/arch-x86_64.h
@@ -174,45 +174,53 @@ void __attribute__((weak, noreturn)) __nolibc_naked __no_stack_protector _start(
 }
 
 #define NOLIBC_ARCH_HAS_MEMMOVE
-void *memmove(void *dst, const void *src, size_t len);
+__attribute__((weak,unused,section(".text.nolibc_memmove")))
+__nolibc_naked __no_stack_protector
+void *memmove(void *dst __attribute__((unused)),
+	      const void *src __attribute__((unused)),
+	      size_t len __attribute__((unused)))
+{
+	__asm__ volatile (
+		"movq %rdx, %rcx\n\t"
+		"movq %rdi, %rax\n\t"
+		"movq %rdi, %rdx\n\t"
+		"subq %rsi, %rdx\n\t"
+		"cmpq %rcx, %rdx\n\t"
+		"jb   .Lbackward_copy\n\t"
+		"rep movsb\n\t"
+		"retq\n"
+		".Lbackward_copy:"
+		"leaq -1(%rdi, %rcx, 1), %rdi\n\t"
+		"leaq -1(%rsi, %rcx, 1), %rsi\n\t"
+		"std\n\t"
+		"rep movsb\n\t"
+		"cld\n\t"
+		"retq\n"
+	);
+	__nolibc_naked_epilogue();
+}
 
 #define NOLIBC_ARCH_HAS_MEMCPY
-void *memcpy(void *dst, const void *src, size_t len);
+static __inline__ void *memcpy(void *dst, const void *src, size_t len)
+{
+	return memmove(dst, src, len);
+}
 
 #define NOLIBC_ARCH_HAS_MEMSET
-void *memset(void *dst, int c, size_t len);
-
-__asm__ (
-".section .text.nolibc_memmove_memcpy\n"
-".weak memmove\n"
-".weak memcpy\n"
-"memmove:\n"
-"memcpy:\n"
-	"movq %rdx, %rcx\n\t"
-	"movq %rdi, %rax\n\t"
-	"movq %rdi, %rdx\n\t"
-	"subq %rsi, %rdx\n\t"
-	"cmpq %rcx, %rdx\n\t"
-	"jb   .Lbackward_copy\n\t"
-	"rep movsb\n\t"
-	"retq\n"
-".Lbackward_copy:"
-	"leaq -1(%rdi, %rcx, 1), %rdi\n\t"
-	"leaq -1(%rsi, %rcx, 1), %rsi\n\t"
-	"std\n\t"
-	"rep movsb\n\t"
-	"cld\n\t"
-	"retq\n"
-
-".section .text.nolibc_memset\n"
-".weak memset\n"
-"memset:\n"
-	"xchgl %eax, %esi\n\t"
-	"movq  %rdx, %rcx\n\t"
-	"pushq %rdi\n\t"
-	"rep stosb\n\t"
-	"popq  %rax\n\t"
-	"retq\n"
-);
+__attribute__((weak,unused,section(".text.nolibc_memset")))
+__nolibc_naked __no_stack_protector
+void *memset(void *dst __attribute__((unused)), int c __attribute__((unused)),
+	     size_t len __attribute__((unused)))
+{
+	__asm__ volatile (
+		"xchgl %eax, %esi\n\t"
+		"movq  %rdx, %rcx\n\t"
+		"pushq %rdi\n\t"
+		"rep stosb\n\t"
+		"popq  %rax\n\t"
+		"retq\n"
+	);
+	__nolibc_naked_epilogue();
+}
 
 #endif /* _NOLIBC_ARCH_X86_64_H */

-- 
2.46.0


