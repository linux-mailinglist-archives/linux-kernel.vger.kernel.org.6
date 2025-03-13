Return-Path: <linux-kernel+bounces-560193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31352A5FF23
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 19:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCE8B19C4EE5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C381F0E38;
	Thu, 13 Mar 2025 18:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRy5k1v3"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326CE1EE03C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 18:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741890168; cv=none; b=pROIxqI81VVSgJw8te5YMSNIoX1B4WUa3JEZLjif0PF/qQocoZ8xoTekdDaQe71rQ73C6Nd5lPbjrZXqhSw4cZFUsDKuM0tWnZ6vHsqdz0nbAmrYt3UMNODQUP0TXON/SB5HVyUSfTznYCNcVHZ2L+lFrjucTKgMuVxdyDNYFRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741890168; c=relaxed/simple;
	bh=RlmYxCnBs/rCFIxe+5Q68BKDzVQHKXU407Jp3ZZc5q0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kfDk9315FSIwv9R4NBv98pIUVEWwkEfp5kmPAw+buUVgtzgCvkTHnFLVtHDs0MTaUr6fDuCc9SzTIbCzbznaYCgC4UTYhZFoTyOOOUJqeF2BIyAiB8YfqBTJn+Cvt+ZujWTWC87ejUnMm71clzJ8paxYjRj3ie4FOnD39cnfQ0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fRy5k1v3; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6ff1e375a47so12418827b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 11:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741890165; x=1742494965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=12rQoY5a8UAWCWk8IrNehGNSyS9d3OIS0IF6FX04+lc=;
        b=fRy5k1v39MKo1UvKvWPgGeTKA8YDCvddE5kw7be4/Fhm1C8uRzV1f/UiTdQtGalEME
         khuXqmIyu+tYpM8f/W/KQ/m3RclJO2h1KLcbLyXS7P/8N84jAZZMKlWApx/FECLRpbMV
         MCclNXXWtwZjTFlxJxT8BxzWTkauNsYdy9MUnKXosVjiiVJYYxLi86GuMQdW8E8KAIwQ
         B9XT7fZPXwoGvDvCiMhjc2y9qcbW/v+tbWi7wIQStzt1AisXk23oxDr68DEviBqGSUAp
         u7omSOIK3AYUYaBgnH89OJZcQI9O1rxQllRZDB2NM9XP0ulejmPbapE+lY7MtHrcbbYh
         /5eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741890165; x=1742494965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=12rQoY5a8UAWCWk8IrNehGNSyS9d3OIS0IF6FX04+lc=;
        b=nnI06s6FGLKedggykgCkoClZ3tiz1zu0YQv0IiLB2Fxf6T4fgYB194RFCd0RfuKedW
         gx6WIf55yzYxJONbswDu5M8DlYvZh6gf3R8qbD22bM79Y7Z60aI1WF0XMzZp8I+uXFL7
         Y4OTtpUcKG60Kg4tYVlYHqBJsys+jHuEUCccsGRFLddPsL4igpHNxMS8vm6oEy7qSFH4
         ImTkQWhaOGT82dsx3SarQw0EMHw70Kn4w+Lb0eLbWFE2hQvRQvmw9MD5vkOI3IzBzXK1
         9XQa/c3M6XFjAIt7HdTGXyEb8DpCI8iKGfXe83QQ+g4W+jcEHrVPm/X6C47dpxT5i0JG
         PJoQ==
X-Gm-Message-State: AOJu0YydApKznB4+33RCHEmYJS6/6VXgQlT1KX1cjiTzXnF+yXg91Cid
	r8gfidQ34WnJ7Zn0xSQsiUHCsW2mAhH3n/t939htw6No2mvhzqroT8PU
X-Gm-Gg: ASbGncve4TQqF1vE9tzhhuNwAfeV5VZGFz9UpgztTs957upHAaaV5Xekj5z2FfOnwd/
	z670zB3Ok2OLSuc1Zthxs0ucjQur7UTsD3opNpCQex/MmrChfU/Q+bCOkcBlesIgxmywc4xPTHH
	HOHqkkN7k9/xoMHyoVmHqUgmEktcJaD2WCU+PwUxS7viB2zGCO7NN4Nqlpx44IFqFB6VEYXtLFI
	YYRT4NvEpnnWyOfhZCNF7Xsqur3GDoIs0MvivkBSjfOJJwRPbP5USW9kZqa+qAHE0mln5u9ZkNC
	XuU/9mPpdrZeJc2sRkZHXv103Q==
X-Google-Smtp-Source: AGHT+IHDeEUgdIT4fwqMBles1//pJUHZV/RGbqVM3A8ak9OgOK7Jn2405LcuZBZYq6+FTBf0vueeGw==
X-Received: by 2002:a05:690c:3612:b0:6f9:8910:38a3 with SMTP id 00721157ae682-6ff42157179mr6246967b3.37.1741890165238;
        Thu, 13 Mar 2025 11:22:45 -0700 (PDT)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ff3288f0absm4910347b3.54.2025.03.13.11.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 11:22:44 -0700 (PDT)
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
Subject: [PATCH 4/5] x86/syscall/x32: Move x32 syscall table
Date: Thu, 13 Mar 2025 14:22:35 -0400
Message-ID: <20250313182236.655724-5-brgerst@gmail.com>
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

Since commit:

  2e958a8a510d ("x86/entry/x32: Rename __x32_compat_sys_* to
		 __x64_compat_sys_*"),

the ABI prefix for x32 syscalls is the same as native 64-bit
syscalls.  Move the x32 syscall table to syscall_64.c

No functional changes.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/entry/Makefile      |  1 -
 arch/x86/entry/syscall_64.c  | 13 +++++++++++++
 arch/x86/entry/syscall_x32.c | 25 -------------------------
 3 files changed, 13 insertions(+), 26 deletions(-)
 delete mode 100644 arch/x86/entry/syscall_x32.c

diff --git a/arch/x86/entry/Makefile b/arch/x86/entry/Makefile
index 5fd28abfd5a0..e870f8aa936c 100644
--- a/arch/x86/entry/Makefile
+++ b/arch/x86/entry/Makefile
@@ -27,4 +27,3 @@ CFLAGS_REMOVE_entry_fred.o	+= -pg $(CC_FLAGS_FTRACE)
 obj-$(CONFIG_X86_FRED)		+= entry_64_fred.o entry_fred.o
 
 obj-$(CONFIG_IA32_EMULATION)	+= entry_64_compat.o syscall_32.o
-obj-$(CONFIG_X86_X32_ABI)	+= syscall_x32.o
diff --git a/arch/x86/entry/syscall_64.c b/arch/x86/entry/syscall_64.c
index 9e0ba339013c..b96f5621a2aa 100644
--- a/arch/x86/entry/syscall_64.c
+++ b/arch/x86/entry/syscall_64.c
@@ -19,6 +19,9 @@
 #define __SYSCALL(nr, sym) extern long __x64_##sym(const struct pt_regs *);
 #define __SYSCALL_NORETURN(nr, sym) extern long __noreturn __x64_##sym(const struct pt_regs *);
 #include <asm/syscalls_64.h>
+#ifdef CONFIG_X86_X32_ABI
+#include <asm/syscalls_x32.h>
+#endif
 #undef  __SYSCALL
 
 #undef  __SYSCALL_NORETURN
@@ -44,6 +47,16 @@ long x64_sys_call(const struct pt_regs *regs, unsigned int nr)
 	}
 };
 
+#ifdef CONFIG_X86_X32_ABI
+long x32_sys_call(const struct pt_regs *regs, unsigned int nr)
+{
+	switch (nr) {
+	#include <asm/syscalls_x32.h>
+	default: return __x64_sys_ni_syscall(regs);
+	}
+};
+#endif
+
 static __always_inline bool do_syscall_x64(struct pt_regs *regs, int nr)
 {
 	/*
diff --git a/arch/x86/entry/syscall_x32.c b/arch/x86/entry/syscall_x32.c
deleted file mode 100644
index fb77908f44f3..000000000000
--- a/arch/x86/entry/syscall_x32.c
+++ /dev/null
@@ -1,25 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* System call table for x32 ABI. */
-
-#include <linux/linkage.h>
-#include <linux/sys.h>
-#include <linux/cache.h>
-#include <linux/syscalls.h>
-#include <asm/syscall.h>
-
-#define __SYSCALL(nr, sym) extern long __x64_##sym(const struct pt_regs *);
-#define __SYSCALL_NORETURN(nr, sym) extern long __noreturn __x64_##sym(const struct pt_regs *);
-#include <asm/syscalls_x32.h>
-#undef  __SYSCALL
-
-#undef  __SYSCALL_NORETURN
-#define __SYSCALL_NORETURN __SYSCALL
-
-#define __SYSCALL(nr, sym) case nr: return __x64_##sym(regs);
-long x32_sys_call(const struct pt_regs *regs, unsigned int nr)
-{
-	switch (nr) {
-	#include <asm/syscalls_x32.h>
-	default: return __x64_sys_ni_syscall(regs);
-	}
-};
-- 
2.48.1


