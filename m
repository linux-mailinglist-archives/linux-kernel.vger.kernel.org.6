Return-Path: <linux-kernel+bounces-198596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 240CE8D7ACD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 06:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 474C11C21712
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 04:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803C817C77;
	Mon,  3 Jun 2024 04:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="Hun3mTKj"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9809722075
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 04:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717389537; cv=none; b=PXU6JW9twO0GkOkAVaSN4NSP6upeIK+kOdW2joKC/hVo6NdRG1dhAgjFnf80fCql93gcuPnmjt3g/8pnq0AjkqWB2fcB85ELb+OJ5aJrr/52p9h+sQJ9GKvNw4gUrXTNongJux366H4VN3u5EOrEL+siKa9Aw8nPWLDipZ+238c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717389537; c=relaxed/simple;
	bh=HT2RJQzODI8X1LUeizuMEThdjBgTTIczO4lb7eSemaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NDHtlrD7PdO+XOF33dWJiH4JGJpF0BdF9A0KbN6IFn+PDhZ43U+smEDbvSHqtsEifGTDDe78S7UH+F7PZxloxo4nCNvL8dwIPCIyG+KVqpYOvnpCI3l0mgz06fsA7U3FGAvZKnDgqwK6Uxea85AgdjI5UDxlxC44zsbe9stDWgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=Hun3mTKj; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f60a17e3e7so2985375ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 21:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1717389533; x=1717994333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6k5sK+Hr2ZSGgW+wJxFNZmjPnb3EAslefUHNzs6g9pE=;
        b=Hun3mTKjxQRkg0xk+pG0IxE3n5NHEwmd3aumKWftA2yeFJzlMl83gQ2d/JwR0FtqkP
         hbls2qBFbBtPVj8UDfp0tF5vFDJWfpD2ZZ4idaSyE6WaaEJHNFQGfQGXGlhy9ih9r6Fd
         MP4jO6/qLwcRqV7ISEn1ZUmiZ5j+hrq6VJNKjbT8y50B2OcqCP70KJNy3kZ5poL6hXeu
         uzSFht39P12FL+mfiHuryDmYEGYHTYg3cbRvyHUOC6EbSaX/a/VBXEr5AowxgFLNKR8M
         DGSIgW/U4Z87JWCFWZ+I/ZJ3bvvpxmDIu9jVFOSePCkJ0EGfceqHE/BINPrRcxI5cFAR
         ltWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717389533; x=1717994333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6k5sK+Hr2ZSGgW+wJxFNZmjPnb3EAslefUHNzs6g9pE=;
        b=MXjSy3roSq0M7YIOrE3lH+owXUhth1RwD9JzayAZjEH+bk//Z6hOfHTyZ6/29LB102
         lP5uFrNsXPaFCmPLxoc/qkVqSYlEHzuto8eyHkS5yBf+7qNYGyRVxvN7/dPuGeUSuq/L
         R25P2EGLb3RlP1ZTSgJh0uvOT6PtkOTlB86hLX7ffQIeBxHHn5q74vUCk6pN33wvKfVW
         gRRN1OestdNNTvM1Aw3pAWSs4dmrtTFtiphuZ1RZJ456gE+MiKMBvy0nXLvm+HDcOpxo
         Krrc0Z4w4pAOVN5nFmR+R+/MbdiOhQT+v3T5ffqTNpwJSYSmoWIJOvO77IBEi1uxNy4b
         SHuA==
X-Forwarded-Encrypted: i=1; AJvYcCVXLRONdLwHCqb3aqnoTmumNLoFqVKJw977lH54A7dwqeQGJp7AUxxj0JaYqnSM6gZ4mXk712iB1Z7Pguxuk+3GLvW0rCcg9bDHb1qQ
X-Gm-Message-State: AOJu0YzklcUDU955ZrPj95q4plDZidwcVSVvfU05egdmdPEEzl2wLpPW
	Xbm536tZy8eZdceVECxbeVGmF2R3O6gwW9ZyPOJDmh0Ge6STRIWv+DFGDf645dSGPl+ugAA58Ri
	Gud2GidRt5ef5wt9figelhCVsVYy4qYgzMMOm
X-Google-Smtp-Source: AGHT+IGS/JQfmk0q0ZLbJQ7wvdlvLFCpoE0OEzYlQawKoJxSaifXyBH+XjMva5HN775Mk1IPgrZOi1teF8vm46OvDF8=
X-Received: by 2002:a17:90a:fe0a:b0:2bf:bcde:d2b0 with SMTP id
 98e67ed59e1d1-2c1dc6136f0mr7170757a91.4.1717389532791; Sun, 02 Jun 2024
 21:38:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231225040018.1660554-1-antonb@tenstorrent.com> <ZYpO/pfbea7hWu3r@gmail.com>
In-Reply-To: <ZYpO/pfbea7hWu3r@gmail.com>
From: Cyril Bur <cyrilbur@tenstorrent.com>
Date: Mon, 3 Jun 2024 14:38:41 +1000
Message-ID: <CANtDSirRq0W7AhA8xi0c-3a7_e27RKHWbkK27AR9JhZfW+pTwg@mail.gmail.com>
Subject: Re: [PATCH] riscv: Improve exception and system call latency
To: Guo Ren <guoren@kernel.org>
Cc: Anton Blanchard <antonb@tenstorrent.com>, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[ apologies, I think my mailer is going to mess up the formatting ]

On 26 Dec 2023, at 2:56=E2=80=AFPM, Guo Ren <guoren@kernel.org> wrote:

On Sun, Dec 24, 2023 at 08:00:18PM -0800, Anton Blanchard wrote:

Many CPUs implement return address branch prediction as a stack. The
RISCV architecture refers to this as a return address stack (RAS). If
this gets corrupted then the CPU will mispredict at least one but
potentally many function returns.

There are two issues with the current RISCV exception code:

- We are using the alternate link stack (x5/t0) for the indirect branch
 which makes the hardware think this is a function return. This will
 corrupt the RAS.

- We modify the return address of handle_exception to point to
 ret_from_exception. This will also corrupt the RAS.

Testing the null system call latency before and after the patch:

Visionfive2 (StarFive JH7110 / U74)
baseline: 189.87 ns
patched:  176.76 ns

Lichee pi 4a (T-Head TH1520 / C910)
baseline: 666.58 ns
patched:  636.90 ns

Just over 7% on the U74 and just over 4% on the C910.


Yes, the wrong "jalr zero, t0/ra" would pop RAS and destroy the RAS
layout of the hardware for the userspace. How about giving a fake push
for the RAS to connect "jalr zero, ra" of sub-function call return? I'm
curious if you could measure the difference with only one RAS
misprediction.

diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 54ca4564a926..94c7d2be35d0 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -93,7 +93,8 @@ SYM_CODE_START(handle_exception)
       bge s4, zero, 1f

       /* Handle interrupts */
-       tail do_irq
+       auipc t0, do_irq
+       jalr  t0, t0
1:
       /* Handle other exceptions */
       slli t0, s4, RISCV_LGPTR
@@ -103,9 +104,10 @@ SYM_CODE_START(handle_exception)
       /* Check if exception code lies within bounds */
       bgeu t0, t2, 1f
       REG_L t0, 0(t0)
-       jr t0
+       jalr t0, t0
1:
-       tail do_trap_unknown
+       auipc t0, do_trap_unknown
+       jalr  t0, t0
SYM_CODE_END(handle_exception)

You could prepare a deeper userspace stack calling if you want better
measurement results.


Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
Reviewed-by: Jisheng Zhang <jszhang@kernel.org>
---

This introduces some complexity in the stackframe walk code. PowerPC
resolves the multiple exception exit paths issue by placing a value into
the exception stack frame (basically the word "REGS") that the stack frame
code can look for. Perhaps something to look at.

arch/riscv/kernel/entry.S      | 21 ++++++++++++++-------
arch/riscv/kernel/stacktrace.c | 14 +++++++++++++-
2 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 54ca4564a926..89af35edbf6c 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -84,7 +84,6 @@ SYM_CODE_START(handle_exception)
scs_load_current_if_task_changed s5

move a0, sp /* pt_regs */
- la ra, ret_from_exception

/*
* MSB of cause differentiates between
@@ -93,7 +92,10 @@ SYM_CODE_START(handle_exception)
bge s4, zero, 1f

/* Handle interrupts */
- tail do_irq
+ call do_irq
+.globl ret_from_irq_exception
+ret_from_irq_exception:
+ j ret_from_exception
1:
/* Handle other exceptions */
slli t0, s4, RISCV_LGPTR
@@ -101,11 +103,16 @@ SYM_CODE_START(handle_exception)
la t2, excp_vect_table_end
add t0, t1, t0
/* Check if exception code lies within bounds */
- bgeu t0, t2, 1f
- REG_L t0, 0(t0)
- jr t0
-1:
- tail do_trap_unknown
+ bgeu t0, t2, 3f
+ REG_L t1, 0(t0)
+2: jalr ra,t1
+.globl ret_from_other_exception
+ret_from_other_exception:
+ j ret_from_exception
+3:
+
+ la t1, do_trap_unknown
+ j 2b
SYM_CODE_END(handle_exception)

/*
diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.=
c
index 64a9c093aef9..b9cd131bbc4c 100644
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -17,6 +17,18 @@
#ifdef CONFIG_FRAME_POINTER

extern asmlinkage void ret_from_exception(void);
+extern asmlinkage void ret_from_irq_exception(void);
+extern asmlinkage void ret_from_other_exception(void);
+
+static inline bool is_exception_frame(unsigned long pc)
+{
+ if ((pc =3D=3D (unsigned long)ret_from_exception) ||
+    (pc =3D=3D (unsigned long)ret_from_irq_exception) ||
+    (pc =3D=3D (unsigned long)ret_from_other_exception))
+ return true;
+
+ return false;
+}

We needn't put too many .globl in the entry.S, and just check that pc is
in SYM_CODE_START/END(handle_exception), then entry.S would be cleaner:

Hi Guo,

I've taken this patch over from Anton, mostly just to tidy it up. I'd
like to incorporate
what you mention here but I'm not sure how to achieve it. Have I
missed something
obvious? As things currently stand there doesn't seem to be a way to get th=
e end
(or size) of handle_exception in C code.

Your advice is greatly appreciated,

Thanks,

Cyril

diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 54ca4564a926..d452d5f12b1b 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -84,7 +84,6 @@ SYM_CODE_START(handle_exception)
       scs_load_current_if_task_changed s5

       move a0, sp /* pt_regs */

       /*
        * MSB of cause differentiates between
@@ -93,7 +92,8 @@ SYM_CODE_START(handle_exception)
       bge s4, zero, 1f

       /* Handle interrupts */
       call do_irq
       j ret_from_exception
1:
       /* Handle other exceptions */
       slli t0, s4, RISCV_LGPTR
@@ -102,10 +102,12 @@ SYM_CODE_START(handle_exception)
       add t0, t1, t0
       /* Check if exception code lies within bounds */
       bgeu t0, t2, 1f
       REG_L ra, 0(t0)
       jalr ra, ra
       j ret_from_exception
1:
       call do_trap_unknown
       j ret_from_exception
SYM_CODE_END(handle_exception)



void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs=
,
    bool (*fn)(void *, unsigned long), void *arg)
@@ -62,7 +74,7 @@ void notrace walk_stackframe(struct task_struct
*task, struct pt_regs *regs,
fp =3D frame->fp;
pc =3D ftrace_graph_ret_addr(current, NULL, frame->ra,
  &frame->ra);
- if (pc =3D=3D (unsigned long)ret_from_exception) {
+ if (is_exception_frame(pc)) {
if (unlikely(!__kernel_text_address(pc) || !fn(arg, pc)))
break;

--=20
2.25.1


_______________________________________________
linux-riscv mailing list
linux-riscv@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-riscv

