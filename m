Return-Path: <linux-kernel+bounces-339308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B4F9862DF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 818961C23F95
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 15:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E02A18DF98;
	Wed, 25 Sep 2024 15:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qrok5dzK"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514C3191F62
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 15:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727276555; cv=none; b=Dg02nrSfUITkz5A5zAQEvthj6EDWQWw8opSw4IioqyxMAGcPXO4gOC2ELr6Z/CGC7K6E9Uh/ELGjsBphQeagASh8bX/N9w1nvgXUbN1WSYAfHopxCMrRA+Rz3UC6x4BygJgfwYmtkeDBM5jq/wLP5fK592LzoE3ZMblDnViFzHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727276555; c=relaxed/simple;
	bh=w/P+2/7/i0/j2dzTpIfGv0L554wt2D6+DkL221lAYlA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iMsTD3911bM9uceQFrmEZOFeymwlyty249rUpRoZHdpq2AGTPyPA3guZdEPpmeygHkkuJpuVB38yvSVt0HpU7tF1Vd2ibl4TDyV0QRJeG0xbaETtPCxvdx2bwo2CERc8VsQWzmD7dRI+Dv+3vyLdPn98VyE+Flpl8WHJn/v39gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qrok5dzK; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-42cb374f0cdso5460665e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 08:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727276551; x=1727881351; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vAC8l3Y8WvFUyajZb+pirsZCUpFvZ3r8+BwrpQuj/SE=;
        b=Qrok5dzKpXydUx5M9TW32zg2YJHKEXJ61ctOadUBeAGB0KBhnYmDeES2ItYtzlQ2Iz
         83RXWxCohJTrwzWXBDmOBVxKe6VqAo2t8LYfZT/bLYT9u83sHWixLK1XVitYJRNU/4Cs
         bb77HlZaFm1QRsB7nJfWZ0p3iGuBnLTvkB9/lQp6uDm+ON3kaCp8gsqNFk3Y9/CGKqIE
         mBsiU79wsuaLlW3wl+quKZDfLd/CzlCAAq9B6bQ6OaoulHkoF0c/xiBT0Ptq3TE5N54G
         ykdnMzV1y3bDyPswuWKLS6zWQ7VCEkG5IeV+AzWbZ4q26npScA3CSzFd4kTH4K4/ONO0
         7t0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727276551; x=1727881351;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vAC8l3Y8WvFUyajZb+pirsZCUpFvZ3r8+BwrpQuj/SE=;
        b=H0nVFyZ/SY1rb1z8JHcGW2Yu6f+bW8rtOQE48E15vKP/h8qZk+wQ0IDD3U87jESOdU
         liVs55gea7VXeQk7db5clA93lO2d/yymIubbmUg96qMFSfY8ms+gK3w3x5ppFGIj/K5g
         Ym+Qo1FwhQ3XMBhGGWXSr61K8PJVMUm+RqdUju9NvyHgwXHN1kTZpoxbY9VVWza18mLH
         37Trarsud8ffeEXnCqUYsmgTYnR/p/PeEr3V50SbUnnlj4mdJaUMFwS2sog9mUOTzce9
         ju5K5rQRSJgOcc0nJITnczQJbrI/Kl35GO7+P6eF/NaMQTc3jfeQycSJ18a5/hNPWq7p
         d25A==
X-Gm-Message-State: AOJu0Yx5OHikM/BHMhTzWNo16+ny/Qe3qth2H8vuUw4ONUY6A8G1umLN
	ik4YKL8l3hLmIj+FVDUmP1Hd/nljM8XY57fTlb3sxwQQM0vjG2SGF+jvJlGAB9zcxatkjBsZwQr
	/uOLxRmSalzJfoaXSz5DlL5bYhdwC4GR9SZ8Gde2IH3BYCMaSRrOJRvm7FX/LGbrzX127U/Ymt2
	/afXmBNQxuH40m/I/U9slwyI2XR7yTfQ==
X-Google-Smtp-Source: AGHT+IGsHQZbBz7v7rjB2VogUNbzT3V2zpNGtAWZsXzYUPDihu4mWF0GF+yn2VIMs1ZNTkRqyJuf4PXN
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a05:600c:4ca2:b0:42c:acd5:c641 with SMTP id
 5b1f17b1804b1-42e96037975mr279665e9.2.1727276550412; Wed, 25 Sep 2024
 08:02:30 -0700 (PDT)
Date: Wed, 25 Sep 2024 17:01:16 +0200
In-Reply-To: <20240925150059.3955569-30-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240925150059.3955569-30-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2723; i=ardb@kernel.org;
 h=from:subject; bh=tMElkct6gfSM6gp7MMWL/mRF1vGpc7RrYvn7ljZWXyE=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIe2L6iGZPaJMr8LDnd//b/RW8SszXOfdmXXq3NuftZV75
 oQv+lfaUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACZy4w/DHw7GS21Or9/PeKL6
 7ZX8zCMs6WX7p7QFXu6zKz6oZDhn3S9GhnkFPcEfOSfJKv9IYrKOXfBu+/X/Xl4zqlnSnqz7v02 4kwsA
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240925150059.3955569-46-ardb+git@google.com>
Subject: [RFC PATCH 16/28] x86/entry_64: Use RIP-relative addressing
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Uros Bizjak <ubizjak@gmail.com>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Juergen Gross <jgross@suse.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Masahiro Yamada <masahiroy@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Keith Packard <keithp@keithp.com>, 
	Justin Stitt <justinstitt@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-doc@vger.kernel.org, 
	linux-pm@vger.kernel.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-efi@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-sparse@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Fix up a couple of occurrences in the x86_64 entry code where we take
the absolute address of a symbol while we could use RIP-relative
addressing just the same. This avoids relocation fixups at boot for
these quantities.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/entry/calling.h  |  9 +++++----
 arch/x86/entry/entry_64.S | 12 +++++++-----
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index ea81770629ee..099da5aaf929 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -375,8 +375,8 @@ For 32-bit we have the following conventions - kernel is built with
 .endm
 
 .macro SAVE_AND_SET_GSBASE scratch_reg:req save_reg:req
+	GET_PERCPU_BASE \scratch_reg \save_reg
 	rdgsbase \save_reg
-	GET_PERCPU_BASE \scratch_reg
 	wrgsbase \scratch_reg
 .endm
 
@@ -412,15 +412,16 @@ For 32-bit we have the following conventions - kernel is built with
  * Thus the kernel would consume a guest's TSC_AUX if an NMI arrives
  * while running KVM's run loop.
  */
-.macro GET_PERCPU_BASE reg:req
+.macro GET_PERCPU_BASE reg:req scratch:req
 	LOAD_CPU_AND_NODE_SEG_LIMIT \reg
 	andq	$VDSO_CPUNODE_MASK, \reg
-	movq	__per_cpu_offset(, \reg, 8), \reg
+	leaq	__per_cpu_offset(%rip), \scratch
+	movq	(\scratch, \reg, 8), \reg
 .endm
 
 #else
 
-.macro GET_PERCPU_BASE reg:req
+.macro GET_PERCPU_BASE reg:req scratch:req
 	movq	pcpu_unit_offsets(%rip), \reg
 .endm
 
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 1b5be07f8669..6509e12b6329 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1038,7 +1038,8 @@ SYM_CODE_START(error_entry)
 	movl	%ecx, %eax			/* zero extend */
 	cmpq	%rax, RIP+8(%rsp)
 	je	.Lbstep_iret
-	cmpq	$.Lgs_change, RIP+8(%rsp)
+	leaq	.Lgs_change(%rip), %rcx
+	cmpq	%rcx, RIP+8(%rsp)
 	jne	.Lerror_entry_done_lfence
 
 	/*
@@ -1250,10 +1251,10 @@ SYM_CODE_START(asm_exc_nmi)
 	 * the outer NMI.
 	 */
 
-	movq	$repeat_nmi, %rdx
+	leaq	repeat_nmi(%rip), %rdx
 	cmpq	8(%rsp), %rdx
 	ja	1f
-	movq	$end_repeat_nmi, %rdx
+	leaq	end_repeat_nmi(%rip), %rdx
 	cmpq	8(%rsp), %rdx
 	ja	nested_nmi_out
 1:
@@ -1307,7 +1308,8 @@ nested_nmi:
 	pushq	%rdx
 	pushfq
 	pushq	$__KERNEL_CS
-	pushq	$repeat_nmi
+	leaq	repeat_nmi(%rip), %rdx
+	pushq	%rdx
 
 	/* Put stack back */
 	addq	$(6*8), %rsp
@@ -1346,7 +1348,7 @@ first_nmi:
 	addq	$8, (%rsp)	/* Fix up RSP */
 	pushfq			/* RFLAGS */
 	pushq	$__KERNEL_CS	/* CS */
-	pushq	$1f		/* RIP */
+	pushq	1f@GOTPCREL(%rip) /* RIP */
 	iretq			/* continues at repeat_nmi below */
 	UNWIND_HINT_IRET_REGS
 1:
-- 
2.46.0.792.g87dc391469-goog


