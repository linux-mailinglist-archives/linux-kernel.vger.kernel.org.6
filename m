Return-Path: <linux-kernel+bounces-563125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BDBA63745
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 20:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E93DE3A5BB1
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 19:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D7118DB17;
	Sun, 16 Mar 2025 19:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="PPGS1zKv"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C048CD53C
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 19:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742154374; cv=none; b=sNu1XAQFFop3BEMTv0gDXHgudALjTzYfB+VKnWrCmycXAaxyA9zC+dxpjs34Y3u1WnoEKV5gSa2UsDED8ALVFRI+asOonurPBJVibgjssLomp3IM8oqrPk8IP/AWXHh6vVgF4FIshApjMizJIZPCmEt8Ce/BjNM0vXJ8RLrlkvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742154374; c=relaxed/simple;
	bh=jl+bNLVuMAGGELY1hU9A76TQSwNYN2VYQrcUxSGUbdE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Q8vR7flO86qHQYCH4sSXQQKwBl5CIw6qa0erj0kQ1x22tb0rLpIfZjeptgIDC3BOJSL9Mj0mjSVYwoO0/U8x0NlEbRjoyzpW5c5ovDDZUvmD5a28oqBytxasM9SozCsnsXo0QeMzLyAc7wXqLRrE4ysq0FGJelj/WX1i3GvWqOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=PPGS1zKv; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1742154367;
	bh=jl+bNLVuMAGGELY1hU9A76TQSwNYN2VYQrcUxSGUbdE=;
	h=From:Date:Subject:To:Cc:From;
	b=PPGS1zKv/v2FcP0uBtZiLj4sgPP2Z7d+zEbymSdzcUrLTAxJWDbaO+DtYiI065DLe
	 Bq92LtMVORERRBztbejy6NYc6HohUCNmwbzzjvqeBxhoIA1ZTduGxPhmGKi2vm42Kf
	 0sgE2TyWqZXvnabBzYvflayWhCRo1d5MPHNdrzms=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 16 Mar 2025 20:46:07 +0100
Subject: [PATCH] tools/nolibc: drop manual stack pointer alignment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250316-nolibc-sp-align-v1-1-1e1fb073ca1e@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAH4q12cC/x3MTQqAIBBA4avErBuosejnKtHCbLIBsVCIQLx70
 vJbvJcgchCOMFcJAj8S5fIFbV2BObW3jLIXAzXUN0Qj+svJZjDeqJ1Yj5Pq9abagTpDUKo78CH
 vf1zWnD/x2JCsYQAAAA==
X-Change-ID: 20250228-nolibc-sp-align-935ab31724c2
To: Willy Tarreau <w@1wt.eu>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742154367; l=7130;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=jl+bNLVuMAGGELY1hU9A76TQSwNYN2VYQrcUxSGUbdE=;
 b=I5Fk89Nu5i2y0yDZAAvANiHLnVzgbGCuVJGZc8ynuEiSMoXtY2nACrvozjPT2l/tV4QZ516ub
 P+EwZcWMvHNB83wwN+6T981g+cKvX95Korums66hiAIH3CO9tLs6Cq1
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The stack pointer is already aligned by the kernel to a multiple of 16.
See STACK_ROUND() in fs/binfmt_elf.c.

The manual realignment is unnecessary, drop it.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
MIPS is not adapted in this patch, but in [0].

[0] https://lore.kernel.org/lkml/20250225-nolibc-mips-n32-v2-2-664b47d87fa0@weissschuh.net/
---
 tools/include/nolibc/arch-aarch64.h   | 1 -
 tools/include/nolibc/arch-arm.h       | 2 --
 tools/include/nolibc/arch-i386.h      | 2 --
 tools/include/nolibc/arch-loongarch.h | 7 -------
 tools/include/nolibc/arch-powerpc.h   | 2 --
 tools/include/nolibc/arch-riscv.h     | 1 -
 tools/include/nolibc/arch-x86_64.h    | 1 -
 7 files changed, 16 deletions(-)

diff --git a/tools/include/nolibc/arch-aarch64.h b/tools/include/nolibc/arch-aarch64.h
index 06fdef7b291a0b276948c08fdec7858f51616546..937a348da42e1b134d9736a5a0f6920df6e4709d 100644
--- a/tools/include/nolibc/arch-aarch64.h
+++ b/tools/include/nolibc/arch-aarch64.h
@@ -146,7 +146,6 @@ void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _s
 {
 	__asm__ volatile (
 		"mov x0, sp\n"          /* save stack pointer to x0, as arg1 of _start_c */
-		"and sp, x0, -16\n"     /* sp must be 16-byte aligned in the callee      */
 		"bl  _start_c\n"        /* transfer to c runtime                         */
 	);
 	__nolibc_entrypoint_epilogue();
diff --git a/tools/include/nolibc/arch-arm.h b/tools/include/nolibc/arch-arm.h
index 6180ff99ab43dff1751f9ac22b518382a0e917c7..1f66e7e5a444b2506150f0b4f4f11f296902b2bc 100644
--- a/tools/include/nolibc/arch-arm.h
+++ b/tools/include/nolibc/arch-arm.h
@@ -189,8 +189,6 @@ void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _s
 {
 	__asm__ volatile (
 		"mov r0, sp\n"          /* save stack pointer to %r0, as arg1 of _start_c */
-		"and ip, r0, #-8\n"     /* sp must be 8-byte aligned in the callee        */
-		"mov sp, ip\n"
 		"bl  _start_c\n"        /* transfer to c runtime                          */
 	);
 	__nolibc_entrypoint_epilogue();
diff --git a/tools/include/nolibc/arch-i386.h b/tools/include/nolibc/arch-i386.h
index ff5afc35bbd8be0876cbd9ae6361c3a07fb2d734..7c9b38e9641831b6b08432f833365b9f6a2b2f41 100644
--- a/tools/include/nolibc/arch-i386.h
+++ b/tools/include/nolibc/arch-i386.h
@@ -167,8 +167,6 @@ void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _s
 	__asm__ volatile (
 		"xor  %ebp, %ebp\n"       /* zero the stack frame                                */
 		"mov  %esp, %eax\n"       /* save stack pointer to %eax, as arg1 of _start_c     */
-		"add  $12, %esp\n"        /* avoid over-estimating after the 'and' & 'sub' below */
-		"and  $-16, %esp\n"       /* the %esp must be 16-byte aligned on 'call'          */
 		"sub  $12, %esp\n"        /* sub 12 to keep it aligned after the push %eax       */
 		"push %eax\n"             /* push arg1 on stack to support plain stack modes too */
 		"call _start_c\n"         /* transfer to c runtime                               */
diff --git a/tools/include/nolibc/arch-loongarch.h b/tools/include/nolibc/arch-loongarch.h
index fb519545959edf44f939093e21bb73a532d9ac9b..5511705303ea908209d5a8be62722491c2987f82 100644
--- a/tools/include/nolibc/arch-loongarch.h
+++ b/tools/include/nolibc/arch-loongarch.h
@@ -142,18 +142,11 @@
 	_arg1;                                                                \
 })
 
-#if __loongarch_grlen == 32
-#define LONG_BSTRINS "bstrins.w"
-#else /* __loongarch_grlen == 64 */
-#define LONG_BSTRINS "bstrins.d"
-#endif
-
 /* startup code */
 void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _start(void)
 {
 	__asm__ volatile (
 		"move          $a0, $sp\n"         /* save stack pointer to $a0, as arg1 of _start_c */
-		LONG_BSTRINS " $sp, $zero, 3, 0\n" /* $sp must be 16-byte aligned                    */
 		"bl            _start_c\n"         /* transfer to c runtime                          */
 	);
 	__nolibc_entrypoint_epilogue();
diff --git a/tools/include/nolibc/arch-powerpc.h b/tools/include/nolibc/arch-powerpc.h
index ee2fdb8d601dcc0796e1fee89b7121dc7184a523..204564bbcd328ed51a804ecbbdb55d578dee132e 100644
--- a/tools/include/nolibc/arch-powerpc.h
+++ b/tools/include/nolibc/arch-powerpc.h
@@ -201,7 +201,6 @@ void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _s
 
 	__asm__ volatile (
 		"mr     3, 1\n"         /* save stack pointer to r3, as arg1 of _start_c */
-		"clrrdi 1, 1, 4\n"      /* align the stack to 16 bytes                   */
 		"li     0, 0\n"         /* zero the frame pointer                        */
 		"stdu   1, -32(1)\n"    /* the initial stack frame                       */
 		"bl     _start_c\n"     /* transfer to c runtime                         */
@@ -209,7 +208,6 @@ void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _s
 #else
 	__asm__ volatile (
 		"mr     3, 1\n"         /* save stack pointer to r3, as arg1 of _start_c */
-		"clrrwi 1, 1, 4\n"      /* align the stack to 16 bytes                   */
 		"li     0, 0\n"         /* zero the frame pointer                        */
 		"stwu   1, -16(1)\n"    /* the initial stack frame                       */
 		"bl     _start_c\n"     /* transfer to c runtime                         */
diff --git a/tools/include/nolibc/arch-riscv.h b/tools/include/nolibc/arch-riscv.h
index 8827bf936212416f9fbc3da7428cb04664cbd702..885383a86c38b186bb6eb269e670080b36c9d982 100644
--- a/tools/include/nolibc/arch-riscv.h
+++ b/tools/include/nolibc/arch-riscv.h
@@ -148,7 +148,6 @@ void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _s
 		"lla  gp, __global_pointer$\n"
 		".option pop\n"
 		"mv   a0, sp\n"           /* save stack pointer to a0, as arg1 of _start_c */
-		"andi sp, a0, -16\n"      /* sp must be 16-byte aligned                    */
 		"call _start_c\n"         /* transfer to c runtime                         */
 	);
 	__nolibc_entrypoint_epilogue();
diff --git a/tools/include/nolibc/arch-x86_64.h b/tools/include/nolibc/arch-x86_64.h
index 1e40620a2b33da501b7e06dda2472903f7e2bfed..67305e24dbefdcd4fd1fc6fd8fdb98d74a34c2d9 100644
--- a/tools/include/nolibc/arch-x86_64.h
+++ b/tools/include/nolibc/arch-x86_64.h
@@ -166,7 +166,6 @@ void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _s
 	__asm__ volatile (
 		"xor  %ebp, %ebp\n"       /* zero the stack frame                            */
 		"mov  %rsp, %rdi\n"       /* save stack pointer to %rdi, as arg1 of _start_c */
-		"and  $-16, %rsp\n"       /* %rsp must be 16-byte aligned before call        */
 		"call _start_c\n"         /* transfer to c runtime                           */
 		"hlt\n"                   /* ensure it does not return                       */
 	);

---
base-commit: bceb73904c855c78402dca94c82915f078f259dd
change-id: 20250228-nolibc-sp-align-935ab31724c2

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


