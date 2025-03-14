Return-Path: <linux-kernel+bounces-561658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FE0A61496
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 250817AC5CC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A43202F76;
	Fri, 14 Mar 2025 15:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3lM2exS"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762AB202C33
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 15:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741965165; cv=none; b=nYeCRL0xHg4nBbfAAggnpLAmDAXr6keBZxvcP0PyHzQ/hiH7e0JT8soKR5B+HSBizZGXpkQbr+cr1Hm1FbrFy7qqEgV4f2vzF6O+HdzgINzI5m1T6gC4YcYfKgzVmfBtiHwqhBBbQ98GOqqB4YSY/0Wik8cJGU78nNOJ/8chLe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741965165; c=relaxed/simple;
	bh=KfIUC6vHrnWsZFhqX8PmZ3NcRke3NRhejMT28SIgMmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jK0gt0ff+rD/HSrIHE1gO3DLlyHeQIOZf24Gg+pI4JSKhmB6zZfTUba4pQljO2M3Xoufor7I+FGxieHylJsYjb3wyzsMTcT+YuzpPwc/kWK5rk565Tr+Po9VX6meejDGdDTz9TsbvDg3QLt+8PJuHeF1JntyfhNZx7/NvOmlLAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3lM2exS; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2c12f9e9449so1141977fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 08:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741965162; x=1742569962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhSNGE7xuts5hKV7orGt15bPAyx5e48naMNL2aOpQTE=;
        b=Y3lM2exSCM3XW7XELikAdqNJFlNSXGGwLsa/7YaJtf+2zpTx05a5DUfXGveDJNnF0N
         cYQ27j/pLSfxZW7HKVIvAuX9vk9VaauB33bnO7X3xiJvsbr2jsWGy8OjkiMmP931XNka
         /mbQguHOCQiMwsFO1w+McmwPc2DJqY3GcOeI35Lk6JM4dgxF5n0xi3eVMZDhdBdW/sYx
         r7eCJRqUH/ilHZN5KxfhZOUfU5attZEJnFf6DF+HK8jyLqMjMzVhi+SkJukTtMvRbo8I
         FDJzWdQoyMfDJbjo5OnmEGRr3n9ZQCLp6xhpTCOuGS9FQHhgclcYTJN8Txw0oJQzApkE
         wx8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741965162; x=1742569962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zhSNGE7xuts5hKV7orGt15bPAyx5e48naMNL2aOpQTE=;
        b=aDF2WpKLCQ+DoYFNDw8LZ2/VC90o+V+o2kt1lPdM9BcPZ92TtH3Wm3BW5VcRRWKdMN
         Au4rjlQV8m51AOa+vGAreg7YttWAPXbqW9jtl9DJJXiXlSt6ZelJArcGeIWiiZe/sNK+
         fmeAzsgu2LdrtMNW7U1aZxocaulTo/WbBkm3KLZ7wdr9wK/lKjCWxr1rcgvjoKPYnE5N
         ohmJQluM/LXwALFF8GqupHty4ftkkZj+pPXxvPM7jbuD78omPV29YpRbDyP5g2x11H6B
         0uVtBx28V8WQ0KtE5CVzM5cm6Ccdw4AyIZVS2lfq/bHYTQM5H8AQu3jrVg+5Y56quJNt
         4oEA==
X-Gm-Message-State: AOJu0YwmCeeJMY/hwXaF5vYSAAG1pl/dutp38wH+lANkJXlbuIF/BrfN
	KcLGgT2HPojpkEdWrXyS4HjHybkAfV1TVU8FfgSvQbwFUhvjrFMsCxww
X-Gm-Gg: ASbGncvh4mZIwrLKOqaUGsRDF3faAqPtTBFf2mLf2lm5vtpidMiwImTV1Frdsw8h14N
	y1N4gxziYdjjLCCHHw5i/I69eW5/uLVDSQylHmCax4/bDEomVGlXqIfCg/Ex3IvlxQ0wpbuN3aX
	82glQriC/Ou/dSghHuzlaoacHgun5Aqua/bA8X8bmBN1U9Weg0dpJDpaWJz89kb+teXN7XC21bG
	mGwcOq30zbQbsl3AMtzwbKqSwRg3NtjXgFAMjj0jl5nR8dzbj0BCM2+CxaYK9aGnuCetkxCFWuJ
	ze6EpC4mwDz3N8qMut/EiqOfAQ==
X-Google-Smtp-Source: AGHT+IE9Pun8M/69Oxe8hQDoyrnp8Z9x9GZqaeDu3Qdflly84bIPP8ymG4VTYORwAOl4HqYWr89uRg==
X-Received: by 2002:a05:6870:9690:b0:29f:e018:df85 with SMTP id 586e51a60fabf-2c690fc4385mr1441737fac.22.1741965161985;
        Fri, 14 Mar 2025 08:12:41 -0700 (PDT)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c6710f21efsm883026fac.30.2025.03.14.08.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 08:12:41 -0700 (PDT)
From: Brian Gerst <brgerst@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Andy Lutomirski <luto@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v2 5/7] x86/syscall: Move sys_ni_syscall()
Date: Fri, 14 Mar 2025 11:12:18 -0400
Message-ID: <20250314151220.862768-6-brgerst@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250314151220.862768-1-brgerst@gmail.com>
References: <20250314151220.862768-1-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move sys_ni_syscall() to kernel/process.c, and remove the now empty
entry/common.c

No functional changes.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/entry/Makefile   |  3 ---
 arch/x86/entry/common.c   | 38 --------------------------------------
 arch/x86/kernel/process.c |  5 +++++
 3 files changed, 5 insertions(+), 41 deletions(-)
 delete mode 100644 arch/x86/entry/common.c

diff --git a/arch/x86/entry/Makefile b/arch/x86/entry/Makefile
index e870f8aa936c..72cae8e0ce85 100644
--- a/arch/x86/entry/Makefile
+++ b/arch/x86/entry/Makefile
@@ -7,16 +7,13 @@ KASAN_SANITIZE := n
 UBSAN_SANITIZE := n
 KCOV_INSTRUMENT := n
 
-CFLAGS_REMOVE_common.o		= $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_syscall_32.o	= $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_syscall_64.o	= $(CC_FLAGS_FTRACE)
 
-CFLAGS_common.o			+= -fno-stack-protector
 CFLAGS_syscall_32.o		+= -fno-stack-protector
 CFLAGS_syscall_64.o		+= -fno-stack-protector
 
 obj-y				:= entry.o entry_$(BITS).o syscall_$(BITS).o
-obj-y				+= common.o
 
 obj-y				+= vdso/
 obj-y				+= vsyscall/
diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
deleted file mode 100644
index 5bd448c0664f..000000000000
--- a/arch/x86/entry/common.c
+++ /dev/null
@@ -1,38 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * common.c - C code for kernel entry and exit
- * Copyright (c) 2015 Andrew Lutomirski
- *
- * Based on asm and ptrace code by many authors.  The code here originated
- * in ptrace.c and signal.c.
- */
-
-#include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/sched/task_stack.h>
-#include <linux/entry-common.h>
-#include <linux/mm.h>
-#include <linux/smp.h>
-#include <linux/errno.h>
-#include <linux/ptrace.h>
-#include <linux/export.h>
-#include <linux/nospec.h>
-#include <linux/syscalls.h>
-#include <linux/uaccess.h>
-#include <linux/init.h>
-
-#include <asm/apic.h>
-#include <asm/desc.h>
-#include <asm/traps.h>
-#include <asm/vdso.h>
-#include <asm/cpufeature.h>
-#include <asm/fpu/api.h>
-#include <asm/nospec-branch.h>
-#include <asm/io_bitmap.h>
-#include <asm/syscall.h>
-#include <asm/irq_stack.h>
-
-SYSCALL_DEFINE0(ni_syscall)
-{
-	return -ENOSYS;
-}
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 9c75d701011f..91f6ff618852 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -1068,3 +1068,8 @@ SYSCALL_DEFINE2(arch_prctl, int, option, unsigned long, arg2)
 
 	return -EINVAL;
 }
+
+SYSCALL_DEFINE0(ni_syscall)
+{
+	return -ENOSYS;
+}
-- 
2.48.1


