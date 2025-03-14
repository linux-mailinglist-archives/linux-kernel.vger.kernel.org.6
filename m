Return-Path: <linux-kernel+bounces-561657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EECA61493
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D105B461CA9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38475202C41;
	Fri, 14 Mar 2025 15:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5O4o9K6"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031DF20299A
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 15:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741965163; cv=none; b=bcVSbS3nQpoPce8bCdfoeHDt2Jo/70Hfbueyw9IM+xQFzEqopxId2ssWLQ5kGIcbfk32j7BgZPwZq77ZWaByvCoHV4noA2umH23NLgbYS9laYijwj9mu0kvFtVpoSRL0VQ6hAbQFNC9FEMsn3Ueszc9G5tl4u3RcjlJw/HfplU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741965163; c=relaxed/simple;
	bh=sas9Ug/riFyXIKbTfKxtLCM2Iclr6aWcnrwxaMWMiKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HAGvQ63ENTbK7FJrNb5lEXj7xx7aZWPuJeJpMUBX0JEzgrAGzds+d3pznTJnqXnn/HaGvNjM/5g1sfnkncpnpkD3pGXiesrTbj2QCI74RDyuKX97H3j29ryR7lSdihOOtv5sTNTPUl2W9DOx1ZmKg/DezF8hmGX+8u1YqgX765o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O5O4o9K6; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-72bbd3a3928so414467a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 08:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741965161; x=1742569961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9F5BBXrLUjRxyzY0tkrR6J3ro2XGDN/sMXDBFq6KU5Q=;
        b=O5O4o9K6oB6jQcl4SDMnQkXqTCkM6Ma5+6T3MQpAvbS8WPz0cMhfc5WXXQ/o7/uUqc
         r1zMN94Vi//FGDhvf2XqxTNosQztLtHNYE9djqHqlN6ApaA7AFsGbl4mT+7Lh2nckszL
         RL+lnudCA0qD8UO6ioWfZhEraQZqOGqxUPV0hr1GpouZJtVZI6/SU7u/Fc/OdhtlVY2i
         bLmMo+t/yLzaN9plP6lG5X1axoJpzWbAIZrU8GAYB3yMscNCyd5AF6lxwEoHfPuiyYFK
         uXbwYbe1HmjHPLOYS12nFWad4Rp3D4hxTTlnLbQqS8co+DO+idW/OF9oLVcH8FPkTlEH
         y5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741965161; x=1742569961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9F5BBXrLUjRxyzY0tkrR6J3ro2XGDN/sMXDBFq6KU5Q=;
        b=qYIdQc+7dJUqSE6bIGVS4PEAsFewE+PWX9elLYsyQeHzWM5Hu5fQTMsGuK7h6p1chx
         CVzG38pUgvgonTIyIfNYgrTTxUTnPLS9Te1+fhggz1naRzRSym65UwVXc13nFAbJf+zf
         4i3gcoDSpp7vTMhjwxWgCddITkBsB0o8BhaPZqVNepqV/g49OzL210lMIDkXfGsf+Ud/
         I7LCvP8Yiv1JovTWuCAlFOubpoXvamqHpV0RwxfwLcte8WI5ovAWEApRYcP1kB7F1nft
         4df60XH/0xdQ9m9Gt+ZlheD4s/tsOFYy86p+G4vAHjx1QUI1RRP9YKZRqCzytgA0cTNz
         JlSA==
X-Gm-Message-State: AOJu0Yx89kEwrLtVKzzFhd3PBdgK8LZFbYwRYIgAJhOezxvQiCJUE131
	0oUcZGYfJdGZ8+n/V+3Vrp7VierS/1lbQ2sK6SxKUU7C4vosztZYRCoe
X-Gm-Gg: ASbGncunnJ75PD25DrvEHjjtFcj1hXo5UN9JdIAY1z7gduSepgnbz4xL8Aq45q314Jj
	A/pgo7ksH5BqqV3N98lCI4owQAVX9m6MZLknpMTYBMX+l49PlIUCV6pA0cmRy+qyYdOSQS45b7w
	1Slj03ORS3SMPLpbdtTQMbpI4wiuMIeL3649ueFEogqIuP7syYKqbjf4YyyJpGHOzn4krm2CCMJ
	jtS8KM3meTH2lYSfMH29aI6rQlnVe46AGP2/ImMpZq9MQH0b4dc+KLTruAoedm3XwjXx8aODKqd
	3wfnNfMPWXggM0JAD2l51Ybv0c9ATDiangFg
X-Google-Smtp-Source: AGHT+IGV1Xe//W6ld93j5vPoE0yoRrQCRf4SEVnlQ0VJ+baGBRTg72jQKkhvLvzZ34GZ62urDen4gA==
X-Received: by 2002:a05:6830:3498:b0:72b:9387:84be with SMTP id 46e09a7af769-72bbc245665mr1321993a34.1.1741965160772;
        Fri, 14 Mar 2025 08:12:40 -0700 (PDT)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c6710f21efsm883026fac.30.2025.03.14.08.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 08:12:39 -0700 (PDT)
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
Subject: [PATCH v2 4/7] x86/syscall/x32: Move x32 syscall table
Date: Fri, 14 Mar 2025 11:12:17 -0400
Message-ID: <20250314151220.862768-5-brgerst@gmail.com>
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
index e0c62d5a397c..a05f7be8a0e2 100644
--- a/arch/x86/entry/syscall_64.c
+++ b/arch/x86/entry/syscall_64.c
@@ -12,6 +12,9 @@
 #define __SYSCALL(nr, sym) extern long __x64_##sym(const struct pt_regs *);
 #define __SYSCALL_NORETURN(nr, sym) extern long __noreturn __x64_##sym(const struct pt_regs *);
 #include <asm/syscalls_64.h>
+#ifdef CONFIG_X86_X32_ABI
+#include <asm/syscalls_x32.h>
+#endif
 #undef  __SYSCALL
 
 #undef  __SYSCALL_NORETURN
@@ -37,6 +40,16 @@ long x64_sys_call(const struct pt_regs *regs, unsigned int nr)
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


