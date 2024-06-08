Return-Path: <linux-kernel+bounces-206927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF713900FFD
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 09:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE4211C21D26
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 07:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AAB1779B4;
	Sat,  8 Jun 2024 07:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIoQz9rv"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5970E176FB0
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 07:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717831943; cv=none; b=aUuZzClYrpDwWs5ZVQbmeu/WyLM1QWM7uXJEj9wBPUlHUipTSFKkBUWLDiYbPkuu2DIx1WgaAyl7MWIOkO2vpW0ca1tp4uKX7lo1r395lAZGHMUGtG3S53wl93tZLv0cq/gTmuGkSSKgc2A7vk1Br/E72UMnYMjurSdXvFKOHYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717831943; c=relaxed/simple;
	bh=F+af4rxe7d7IoVbuM2DptpY8oZNWyOTUT9YFS5HcTCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SchDhjl7QvMJ8xuAvO7lBraDsnqzT69uC+Y/ZuP+mUm4V7PJfsMEW7LXryFhCOX+zcJRZeGhZsdXFk3c9rwugA9/56BnsFNWLsEQ2EASbxPkw4+VHMIKvAFH/XALs5iKpglcC3ZVnrDNptR+QhwhvIWtzYgB5NzcgEVnnfNQtns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dIoQz9rv; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a6c7ae658d0so371978266b.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2024 00:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717831939; x=1718436739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TkNzPEoAERYPXrD8RfGzPSQCNStah0bla1ynxf0VLJE=;
        b=dIoQz9rvdHNED8+6xYzD0lDTNamReGNlKL1fqdkdFSmfJ2S0PvPG+aXu2oUTcvsf5m
         O2Cd7dKVI63j07u86EpGbPCGqzEk2/aiqbwryGT/rcDzJ7oBhjjwMhtf98NrGn/sDZew
         8bfj1BZ9ChjnAfRvM41+q6GB6dEvw5P9DzlVuAky3JayT0gC8T6ghgVeDysjZ6kcn3SK
         NZMLbbZhZUv/iX7vqxSZ/Y/iYQGDD2lrIhTQbvsBlQ9H5afiSFVeGg6q56p9QshFzOf7
         ezhth42jOlbOIh8JQw+OGtax5w90KRJITAenStzZT9KZNimmcSDxg5Q8gxLov0po6H8w
         cIPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717831939; x=1718436739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TkNzPEoAERYPXrD8RfGzPSQCNStah0bla1ynxf0VLJE=;
        b=e50FCtmhoeeijHVWiP1X23+pcBmknvuvzQ73W+/IvWLQuK7DCpBX5hQ9gygGu9RyWP
         gq8+/sgcjptNObaquTfrkrFYE1h3QTOk9nQXAEvU4MNpQc1TCzUi3RIpWFlCmg4ILA4H
         o+CDImn6u3xWq53hoocQAzD/RE73dCtpMqGXEJdupQSLjauzV+dNXNGqeqwvBxgcuj1z
         JNm2Sm1PWK7/ahioiOYvkiIOA0XOJa82BU3jE35ystL8RZjwDE8pnKCTL0+2V8mEFjzV
         mxO1eRsVLfwaLFJO1ifCdb3gz4fvP/miOgV/cetlsQTd4ssRRRuDSMBnaBsiOYh22JmU
         TQqQ==
X-Gm-Message-State: AOJu0YxU8Jt9vhuTOvc3KXwcD9qOMP/rFvhfSc3ALenL0oh6rMc3syps
	Lnrruxs0rh9gnmSSjMSX5xDqwhXIShfAs1LWRRurbj1uZP0vRYZxQ4d+ypOJ
X-Google-Smtp-Source: AGHT+IEzkOIgiL/eEMAuGS396TaiIbDbyUoPQ2xIZN8upFRyHLr7w5g1uSAfCeA2B1OfV3KzjBnSiw==
X-Received: by 2002:a17:906:49a:b0:a69:10b9:d7ea with SMTP id a640c23a62f3a-a6cd7891a31mr352696266b.41.1717831939387;
        Sat, 08 Jun 2024 00:32:19 -0700 (PDT)
Received: from kepler.. (1F2EF20A.nat.pool.telekom.hu. [31.46.242.10])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6efe5262cdsm61350466b.117.2024.06.08.00.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jun 2024 00:32:19 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Andy Lutomirski <luto@amacapital.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Hansen <dave@sr71.net>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>,
	Brian Gerst <brgerst@gmail.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uros Bizjak <ubizjak@gmail.com>
Subject: [PATCH 4/9] x86/fpu: Remove the thread::fpu pointer
Date: Sat,  8 Jun 2024 09:31:29 +0200
Message-ID: <20240608073134.264210-5-mingo@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240608073134.264210-1-mingo@kernel.org>
References: <20240608073134.264210-1-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As suggested by Oleg, remove the thread::fpu pointer, as we can
calculate it via x86_task_fpu() at compile-time.

This improves code generation a bit:

   kepler:~/tip> size vmlinux.before vmlinux.after
   text        data        bss        dec         hex        filename
   26475405    10435342    1740804    38651551    24dc69f    vmlinux.before
   26475339    10959630    1216516    38651485    24dc65d    vmlinux.after

Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Uros Bizjak <ubizjak@gmail.com>
Link: https://lore.kernel.org/r/20240605083557.2051480-3-mingo@kernel.org
---
 arch/x86/include/asm/processor.h | 5 +----
 arch/x86/kernel/fpu/core.c       | 4 +---
 arch/x86/kernel/fpu/init.c       | 1 -
 arch/x86/kernel/process.c        | 2 --
 arch/x86/kernel/vmlinux.lds.S    | 4 ++++
 5 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 64509c7f26c8..3de609aad0af 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -502,12 +502,9 @@ struct thread_struct {
 
 	struct thread_shstk	shstk;
 #endif
-
-	/* Floating point and extended processor state */
-	struct fpu		*fpu;
 };
 
-#define x86_task_fpu(task) ((task)->thread.fpu)
+#define x86_task_fpu(task)	((struct fpu *)((void *)(task) + sizeof(*(task))))
 
 /*
  * X86 doesn't need any embedded-FPU-struct quirks:
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index f0c4367804b3..167a9c7ed6d3 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -591,13 +591,11 @@ int fpu_clone(struct task_struct *dst, unsigned long clone_flags, bool minimal,
 	 * This is safe because task_struct size is a multiple of cacheline size.
 	 */
 	struct fpu *src_fpu = x86_task_fpu(current);
-	struct fpu *dst_fpu = (void *)dst + sizeof(*dst);
+	struct fpu *dst_fpu = x86_task_fpu(dst);
 
 	BUILD_BUG_ON(sizeof(*dst) % SMP_CACHE_BYTES != 0);
 	BUG_ON(!src_fpu);
 
-	dst->thread.fpu = dst_fpu;
-
 	/* The new task's FPU state cannot be valid in the hardware. */
 	dst_fpu->last_cpu = -1;
 
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 4e8d37b5a90b..794682b52373 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -78,7 +78,6 @@ static void __init fpu__init_system_early_generic(void)
 	int this_cpu = smp_processor_id();
 
 	fpstate_reset(&x86_init_fpu);
-	current->thread.fpu = &x86_init_fpu;
 	per_cpu(fpu_fpregs_owner_ctx, this_cpu) = &x86_init_fpu;
 	x86_init_fpu.last_cpu = this_cpu;
 
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 5bb73bc0e31a..4184c085627e 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -96,8 +96,6 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 #ifdef CONFIG_VM86
 	dst->thread.vm86 = NULL;
 #endif
-	/* Drop the copied pointer to current's fpstate */
-	dst->thread.fpu = NULL;
 
 	return 0;
 }
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 3509afc6a672..226244a894da 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -170,6 +170,10 @@ SECTIONS
 		/* equivalent to task_pt_regs(&init_task) */
 		__top_init_kernel_stack = __end_init_stack - TOP_OF_KERNEL_STACK_PADDING - PTREGS_SIZE;
 
+		__x86_init_fpu_begin = .;
+		. = __x86_init_fpu_begin + 128*PAGE_SIZE;
+		__x86_init_fpu_end = .;
+
 #ifdef CONFIG_X86_32
 		/* 32 bit has nosave before _edata */
 		NOSAVE_DATA
-- 
2.43.0


