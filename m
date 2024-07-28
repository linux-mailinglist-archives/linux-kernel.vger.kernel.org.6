Return-Path: <linux-kernel+bounces-264490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BEA93E417
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 10:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06EA6281DDB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 08:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BE4F9E6;
	Sun, 28 Jul 2024 08:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="hXhL/NnP"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B48110A09
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 08:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722154898; cv=none; b=mlLWkjoychE+RA63X6x3GHu63eGZp9BReydDOAY/oAyVK/tGK3wpxdI8aq+kFyHseF6N41WRBxQ/IfecEySYcLkn+lwoVR6ULVZMp4DaxZZ6h37BaJRt9KEzgB7Eo+1v0ve5bqzpiVZ8ZSXiqaR0m1ai8b9oxa5D6ZVZ2qID74k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722154898; c=relaxed/simple;
	bh=2dYeYTwc65VRvWrEGjw+svyR9CjEcD6M0/SIV5DPGdw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Cn9Q2FuZk+a7wvyX5U7TbPEORyTGaI7c+/+H1gFLjC4ZCgKb03/wTKCZnlUdOHwAVterPwVjT+RVRutu9GbEAWdqGev8NBbpDds2tlfKbyGcK33CZEU2uY3+VJuSRgI1qT2DxAMi3FekdheBBlh5yQklY71NfOFLi9k7bg105+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=hXhL/NnP; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2cd16900ec5so461844a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 01:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1722154895; x=1722759695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CYV8b+LjydiiVuSS5116P+J338BaY6Q5/cIwZHdu2WE=;
        b=hXhL/NnPamfHr91hvXv/kkEq0Sd96G1BzDd9h9qLx0jkIZPRpxsiza1u/k5tDTPxx5
         cWvTBGUCpTqviOJYiqhQks0rA3OS1SZDg3L5Jxjke02CoYJJw+JW9ljge+erGmWrfV2A
         XCuQK+lQYXCtl8qBH1QOfJRCUnbdsv6CIto9fI8A5rrQxNKYerleKrybz7DIdNH7iXXb
         unAKSIMTYy5GvYm2jk+peoI1I87Y3LnxR2QzC7XXvsP+FbzZk8LOeZBrk63gtL34+ITK
         Jb4ZqSMAO/BAP4QXkhKtBoL5OvHcT8JrwGw7duviwJq0+PVy4+lZmThCwZK8zd4nnlpE
         GHow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722154895; x=1722759695;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CYV8b+LjydiiVuSS5116P+J338BaY6Q5/cIwZHdu2WE=;
        b=YQ4bJ05JGAFnhgrXfg8KIJXK2u/5jCjcTd4cjH1Fg9sAx53f9qxftDda1XmsTTdjT8
         saZghFikhXqYig+o1iSG9T91rVV4lXfnSDbEQuMT8fJDC1XrZdb/S+y3HRq+wKEfsFic
         InqhiC9U9xWbFU4PcBJkwf9EsrHCogA5m6OcMxY1K5UB9BuFHTxWuSprRDGdzjD57H4A
         RuaSl+o59SNunXhnmKZ4AxCJQkLC3lFcxGR9D3RMrT9HnWI3HDxqG9lzNFzgbQqaJ3Jk
         2VuQuyuOfIIP16sAEC+VzV8Ca8MyxSKO3QiP86+EzNOz6ANvl/h61X6eBzZHIXPj+3Cq
         bGsQ==
X-Gm-Message-State: AOJu0YySEt/q7KzM7GrtYYlQ6Q0gkAiutmf5j0/8uEVI9hyDq0XFDIFh
	9N585IIAwoKUxB8yaax+ZkMoOuFEHx1oRJP5qEu0mOrr1hdyI/k76SMPv2AzGrHE+JJBmrOpmpj
	79fw=
X-Google-Smtp-Source: AGHT+IHrwCBKmGYt/ccAQjBCckFmsCXZfrXeH3Y7Hi3e54urUfcnDVX84kS2hpPfaV2F7eemo244qA==
X-Received: by 2002:a05:6a21:3a46:b0:1c0:e263:77dd with SMTP id adf61e73a8af0-1c4773796damr8317753637.1.1722154895243;
        Sun, 28 Jul 2024 01:21:35 -0700 (PDT)
Received: from mozart.vkv.me (192-184-160-110.fiber.dynamic.sonic.net. [192.184.160.110])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f817aebasm5402704a12.28.2024.07.28.01.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 01:21:34 -0700 (PDT)
From: Calvin Owens <calvin@wbinvd.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	Russell King <linux@armlinux.org.uk>,
	Ard Biesheuvel <ardb@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Calvin Owens <calvin@wbinvd.org>
Subject: [PATCH] ARM: vfp: Use asm volatile in fmrx/fmxr macros
Date: Sun, 28 Jul 2024 01:16:32 -0700
Message-Id: <92a00580828a1bdf96e7e36545f6d229809af04f.1722154575.git.calvin@wbinvd.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Floating point instructions in userspace can crash some arm kernels
built with clang/LLD 17.0.6:

    BUG: unsupported FP instruction in kernel mode
    FPEXC == 0xc0000780
    Internal error: Oops - undefined instruction: 0 [#1] ARM
    CPU: 0 PID: 196 Comm: vfp-reproducer Not tainted 6.10.0 #1
    Hardware name: BCM2835
    PC is at vfp_support_entry+0xc8/0x2cc
    LR is at do_undefinstr+0xa8/0x250
    pc : [<c0101d50>]    lr : [<c010a80c>]    psr: a0000013
    sp : dc8d1f68  ip : 60000013  fp : bedea19c
    r10: ec532b17  r9 : 00000010  r8 : 0044766c
    r7 : c0000780  r6 : ec532b17  r5 : c1c13800  r4 : dc8d1fb0
    r3 : c10072c4  r2 : c0101c88  r1 : ec532b17  r0 : 0044766c
    Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
    Control: 00c5387d  Table: 0251c008  DAC: 00000051
    Register r0 information: non-paged memory
    Register r1 information: vmalloc memory
    Register r2 information: non-slab/vmalloc memory
    Register r3 information: non-slab/vmalloc memory
    Register r4 information: 2-page vmalloc region
    Register r5 information: slab kmalloc-cg-2k
    Register r6 information: vmalloc memory
    Register r7 information: non-slab/vmalloc memory
    Register r8 information: non-paged memory
    Register r9 information: zero-size pointer
    Register r10 information: vmalloc memory
    Register r11 information: non-paged memory
    Register r12 information: non-paged memory
    Process vfp-reproducer (pid: 196, stack limit = 0x61aaaf8b)
    Stack: (0xdc8d1f68 to 0xdc8d2000)
    1f60:                   0000081f b6f69300 0000000f c10073f4 c10072c4 dc8d1fb0
    1f80: ec532b17 0c532b17 0044766c b6f9ccd8 00000000 c010a80c 00447670 60000010
    1fa0: ffffffff c1c13800 00c5387d c0100f10 b6f68af8 00448fc0 00000000 bedea188
    1fc0: bedea314 00000001 00448ebc b6f9d000 00447608 b6f9ccd8 00000000 bedea19c
    1fe0: bede9198 bedea188 b6e1061c 0044766c 60000010 ffffffff 00000000 00000000
    Call trace:
    [<c0101d50>] (vfp_support_entry) from [<c010a80c>] (do_undefinstr+0xa8/0x250)
    [<c010a80c>] (do_undefinstr) from [<c0100f10>] (__und_usr+0x70/0x80)
    Exception stack(0xdc8d1fb0 to 0xdc8d1ff8)
    1fa0:                                     b6f68af8 00448fc0 00000000 bedea188
    1fc0: bedea314 00000001 00448ebc b6f9d000 00447608 b6f9ccd8 00000000 bedea19c
    1fe0: bede9198 bedea188 b6e1061c 0044766c 60000010 ffffffff
    Code: 0a000061 e3877202 e594003c e3a09010 (eef16a10)
    ---[ end trace 0000000000000000 ]---
    Kernel panic - not syncing: Fatal exception in interrupt
    ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

This is a minimal userspace reproducer on a Raspberry Pi Zero W:

    #include <stdio.h>
    #include <math.h>

    int main(void)
    {
            double v = 1.0;
            printf("%f\n", NAN + *(volatile double *)&v);
            return 0;
    }

Another way to consistently trigger the oops is:

    calvin@raspberry-pi-zero-w ~$ python -c "import json"

The bug reproduces only when the kernel is built with DYNAMIC_DEBUG=n,
because the pr_debug() calls act as barriers even when not activated.

This is the output from the same kernel source built with the same
compiler and DYNAMIC_DEBUG=y, where the userspace reproducer works as
expected:

    VFP: bounce: trigger ec532b17 fpexc c0000780
    VFP: emulate: INST=0xee377b06 SCR=0x00000000
    VFP: bounce: trigger eef1fa10 fpexc c0000780
    VFP: emulate: INST=0xeeb40b40 SCR=0x00000000
    VFP: raising exceptions 30000000

    calvin@raspberry-pi-zero-w ~$ ./vfp-reproducer
    nan

Crudely grepping for vmsr/vmrs instructions in the otherwise nearly
idential text for vfp_support_entry() makes the problem obvious:

    vmlinux.llvm.good [0xc0101cb8] <+48>:  vmrs   r7, fpexc
    vmlinux.llvm.good [0xc0101cd8] <+80>:  vmsr   fpexc, r0
    vmlinux.llvm.good [0xc0101d20] <+152>: vmsr   fpexc, r7
    vmlinux.llvm.good [0xc0101d38] <+176>: vmrs   r4, fpexc
    vmlinux.llvm.good [0xc0101d6c] <+228>: vmrs   r0, fpscr
    vmlinux.llvm.good [0xc0101dc4] <+316>: vmsr   fpexc, r0
    vmlinux.llvm.good [0xc0101dc8] <+320>: vmrs   r0, fpsid
    vmlinux.llvm.good [0xc0101dcc] <+324>: vmrs   r6, fpscr
    vmlinux.llvm.good [0xc0101e10] <+392>: vmrs   r10, fpinst
    vmlinux.llvm.good [0xc0101eb8] <+560>: vmrs   r10, fpinst2

    vmlinux.llvm.bad  [0xc0101cb8] <+48>:  vmrs   r7, fpexc
    vmlinux.llvm.bad  [0xc0101cd8] <+80>:  vmsr   fpexc, r0
    vmlinux.llvm.bad  [0xc0101d20] <+152>: vmsr   fpexc, r7
    vmlinux.llvm.bad  [0xc0101d30] <+168>: vmrs   r0, fpscr
    vmlinux.llvm.bad  [0xc0101d50] <+200>: vmrs   r6, fpscr  <== BOOM!
    vmlinux.llvm.bad  [0xc0101d6c] <+228>: vmsr   fpexc, r0
    vmlinux.llvm.bad  [0xc0101d70] <+232>: vmrs   r0, fpsid
    vmlinux.llvm.bad  [0xc0101da4] <+284>: vmrs   r10, fpinst
    vmlinux.llvm.bad  [0xc0101df8] <+368>: vmrs   r4, fpexc
    vmlinux.llvm.bad  [0xc0101e5c] <+468>: vmrs   r10, fpinst2

I think LLVM's reordering is valid as the code is currently written: the
compiler doesn't know the instructions have side effects in hardware.

Fix by using "asm volatile" in fmxr() and fmrx(), so they cannot be
reordered with respect to each other. The original compiler now produces
working kernels on my hardware with DYNAMIC_DEBUG=n.

This is the relevant piece of the diff of the vfp_support_entry() text,
from the original oopsing kernel to a working kernel with this patch:

         vmrs r0, fpscr
         tst r0, #4096
         bne 0xc0101d48
         tst r0, #458752
         beq 0xc0101ecc
         orr r7, r7, #536870912
         ldr r0, [r4, #0x3c]
         mov r9, #16
        -vmrs r6, fpscr
         orr r9, r9, #251658240
         add r0, r0, #4
         str r0, [r4, #0x3c]
         mvn r0, #159
         sub r0, r0, #-1207959552
         and r0, r7, r0
         vmsr fpexc, r0
         vmrs r0, fpsid
        +vmrs r6, fpscr
         and r0, r0, #983040
         cmp r0, #65536
         bne 0xc0101d88

Fixes: 4708fb041346 ("ARM: vfp: Reimplement VFP exception entry in C code")
Signed-off-by: Calvin Owens <calvin@wbinvd.org>
---
 arch/arm/vfp/vfpinstr.h | 48 ++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 22 deletions(-)

diff --git a/arch/arm/vfp/vfpinstr.h b/arch/arm/vfp/vfpinstr.h
index 3c7938fd40aa..32090b0fb250 100644
--- a/arch/arm/vfp/vfpinstr.h
+++ b/arch/arm/vfp/vfpinstr.h
@@ -64,33 +64,37 @@
 
 #ifdef CONFIG_AS_VFP_VMRS_FPINST
 
-#define fmrx(_vfp_) ({			\
-	u32 __v;			\
-	asm(".fpu	vfpv2\n"	\
-	    "vmrs	%0, " #_vfp_	\
-	    : "=r" (__v) : : "cc");	\
-	__v;				\
- })
-
-#define fmxr(_vfp_,_var_)		\
-	asm(".fpu	vfpv2\n"	\
-	    "vmsr	" #_vfp_ ", %0"	\
-	   : : "r" (_var_) : "cc")
+#define fmrx(_vfp_) ({				\
+	u32 __v;				\
+	asm volatile (".fpu	vfpv2\n"	\
+		      "vmrs	%0, " #_vfp_	\
+		     : "=r" (__v) : : "cc");	\
+	__v;					\
+})
+
+#define fmxr(_vfp_, _var_) ({			\
+	asm volatile (".fpu	vfpv2\n"	\
+		      "vmsr	" #_vfp_ ", %0"	\
+		     : : "r" (_var_) : "cc");	\
+})
 
 #else
 
 #define vfpreg(_vfp_) #_vfp_
 
-#define fmrx(_vfp_) ({			\
-	u32 __v;			\
-	asm("mrc p10, 7, %0, " vfpreg(_vfp_) ", cr0, 0 @ fmrx	%0, " #_vfp_	\
-	    : "=r" (__v) : : "cc");	\
-	__v;				\
- })
-
-#define fmxr(_vfp_,_var_)		\
-	asm("mcr p10, 7, %0, " vfpreg(_vfp_) ", cr0, 0 @ fmxr	" #_vfp_ ", %0"	\
-	   : : "r" (_var_) : "cc")
+#define fmrx(_vfp_) ({						\
+	u32 __v;						\
+	asm volatile ("mrc p10, 7, %0, " vfpreg(_vfp_) ","	\
+		      "cr0, 0 @ fmrx	%0, " #_vfp_		\
+		     : "=r" (__v) : : "cc");			\
+	__v;							\
+})
+
+#define fmxr(_vfp_, _var_) ({					\
+	asm volatile ("mcr p10, 7, %0, " vfpreg(_vfp_) ","	\
+		      "cr0, 0 @ fmxr	" #_vfp_ ", %0"		\
+		     : : "r" (_var_) : "cc");			\
+})
 
 #endif
 
-- 
2.39.2


