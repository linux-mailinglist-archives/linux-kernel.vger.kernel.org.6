Return-Path: <linux-kernel+bounces-560194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 313BEA5FF24
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 19:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DB2E17E72C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9D81F1501;
	Thu, 13 Mar 2025 18:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKjOtqHG"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4810E1EF363
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 18:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741890169; cv=none; b=cAQh6xMUArjeB5SqBstIZNmCYT+9Vyl89kve/OWTWR6qvHEA9+ebADJqdjIwktMMS2sbOVnIySvUjr+/ZcPDqmgb+paylYQsT+PNrAaxHdzVRrZuaNysUaJx0AeZ0sIJKl3LsbhKlTxB4VYiKWEtqelkFgjQkXRSwmZncHF4UVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741890169; c=relaxed/simple;
	bh=KfIUC6vHrnWsZFhqX8PmZ3NcRke3NRhejMT28SIgMmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aq0JDQMC85zexTHY/NHkJtxQ9bIPVZ7Zd5aV7xgDLq7uRdJvnUpWft3Dc3nRFq0vxGh9hUNi0RLO4BNe3nyoviZHn0G9vtyh7+mSPaK+acJEzxWJDqz3f3fwlgjtjbyruf8Z8+olHA/S/FZ/4Vqcm00djwM0gvH0WSdEFIeLbYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AKjOtqHG; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6fee50bfea5so13023687b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 11:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741890167; x=1742494967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhSNGE7xuts5hKV7orGt15bPAyx5e48naMNL2aOpQTE=;
        b=AKjOtqHGXqji1d0+zKw8h2oUsmsegQbsyOEEUMsUH0p6toTM33zyzwBNoX2eB7HMm7
         OvZPZ8ggZvKYRi7wqAs/wIFp0jApwnjA0mZirmTvaRvtu0XehCTv5lSuB8KuSbm81mYt
         sQNjUZa8voqHRKYhtUmZL2azhkVHkAmnSWVI5/LWgmHk7TWq3pW6dGV2CicL3AnD2zTA
         LQikY5C4U9QJdgH63r6JcEeYfVHycGu6qnLrSb8kg0sm9RsxagYtNvWGUMDP5fp7rCfF
         z32ftQvb3GzRIhSrdGgCB71d8eEHclOdkFQY2tTZOe0+o/9fgmCTEVhFO6taSgevLdFu
         G5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741890167; x=1742494967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zhSNGE7xuts5hKV7orGt15bPAyx5e48naMNL2aOpQTE=;
        b=SZHhcgpAF7ma3At62ZznRBbH9BcoMlkYlhOHLuTeF2DYuDjCxOETYpLqKXWgGoRv55
         11hxpqsfNPC8vUg/Nq4GfMJSLWKmhDufkHn1rGu4jMuIL8OYEpnKMQp6WFnBRNaWQ3zk
         2UCi2qndko3/kKgESUDh0SsHdlypIbs5HAxLCnYiz//ZZx/uDIKjNcerEuR61nLaJD9F
         uQfDi/zhcsrF7age7sFoAT1lwSQ9x+40m4A3Zvp2R3Z+ncBNjk2B8s0lFhsLYJMsVBHi
         a8j/5atVr/sqiExLi9fJCkyOaaeaOW0FlPa5cCxbXrPjCTZhzN54fuk86E/ylJrD+aqu
         RFFQ==
X-Gm-Message-State: AOJu0YzCavT8Rdx3n5X7/wGoewm1dsnvsLVMkWzY9kg4krnSjX7QaaKI
	scjEZ0FwPr6Xk5h3s/LWJB+I6KIZm8FqkE2KHKDNsBfg3brrYqwEHCZM
X-Gm-Gg: ASbGncv/cMmUxc1K5OdBSw2nhkGUaB9IhtofIR5njh+/igESiB0YtAhElGr4tOj6+Qv
	6PTNvOCip+Ug3YI+Bm534xYkScbXOGdFJdoUA5r7XFvWhvy/AgCRV4AbUwFcDEtS0BoTYmV/9+D
	1uE/YvyUYYgQZdC0PzxAgOeVqgoscu0dYHmow92oQzNGX2uWDSmOv7KrGbsYo+g/klAaY3nA2OA
	/2d72HGgaHBI4MW42uGjfzPoFCAtuYrWJ8yOC+ctJr4trXcD/dqsl8VNWoNhqljjPaASbQeS56r
	CIE/o6UIIROC3mF1iB5mOOLsAg==
X-Google-Smtp-Source: AGHT+IH9E20QB2aVzr5D7lj1u2ad8uec6Gt0tQ0BuwaWlKmFEiW/LLc9k9ppyBrayEUzn3AHVM+neg==
X-Received: by 2002:a05:690c:4807:b0:6fb:b2de:a2bd with SMTP id 00721157ae682-6ff42041178mr8430417b3.16.1741890166693;
        Thu, 13 Mar 2025 11:22:46 -0700 (PDT)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ff3288f0absm4910347b3.54.2025.03.13.11.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 11:22:46 -0700 (PDT)
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
Subject: [PATCH 5/5] x86/syscall: Move sys_ni_syscall()
Date: Thu, 13 Mar 2025 14:22:36 -0400
Message-ID: <20250313182236.655724-6-brgerst@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250313182236.655724-1-brgerst@gmail.com>
References: <20250313182236.655724-1-brgerst@gmail.com>
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


