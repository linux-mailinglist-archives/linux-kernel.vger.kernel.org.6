Return-Path: <linux-kernel+bounces-553979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A64BFA59175
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 583C03A9D23
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C0F226CE4;
	Mon, 10 Mar 2025 10:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ey2USqJi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FF316D9C2
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 10:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741603391; cv=none; b=CMkos9S38/muWyiuyY/qb7OGvAkAvIq0rvUE/9jtUtiVqpj8B/QYpUAkicF4jwYy9kHfq0YIBqQ/6pTkya2zli4K0ZCGUAczlcj0lr6cqaUeigIiOtQuVR2c7aQVuDDihNTI8XJeW5HZ6B+ztIcbAhK/nOUYsU7DykxpXELImeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741603391; c=relaxed/simple;
	bh=hMeWuCvMqMM2XK2LTK3bmeSSJHc1JoA//jmrqXFW2eo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EnNyGM5VySNJjVenJUaoF3xlejS1H0b94UP/RjfC5CQ1xepqbQ7uAwN/yV12Tykry2BtEgnV/K5UhCyA3rErxFixp8Om8xGLgONXBv3ci7/1JhsIuwcvSs+CGEQIHEQjLMeAGLbwzkRZVT8kll3EgZvInPFlxdoMSrjkGfoxKw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ey2USqJi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741603388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6mm4Jt51ps/yUdZgt6BsXEfzvmwqH2SSAiWbu167zlU=;
	b=Ey2USqJiaG+/xeaB45oXddd46qxl/Gc0ICBcZei/hVdLPTVNXadxdUJgeydbtu1oF+OsOY
	uNxlGPx3OP+W5jZOBS0jCwNNGsvUqZNjlBnn4/1wOLpDmAYCrccW19s3AmNFspXlYMyW22
	tV4IhJZugqzHSKcX54XcADpNBXBm6yQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-370-agH1E7mxMmKRjDE2gu16wA-1; Mon,
 10 Mar 2025 06:43:03 -0400
X-MC-Unique: agH1E7mxMmKRjDE2gu16wA-1
X-Mimecast-MFC-AGG-ID: agH1E7mxMmKRjDE2gu16wA_1741603381
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F0EC3180035C;
	Mon, 10 Mar 2025 10:43:00 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.226.133])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7F88219560AD;
	Mon, 10 Mar 2025 10:42:58 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] x86: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi headers
Date: Mon, 10 Mar 2025 11:42:56 +0100
Message-ID: <20250310104256.123527-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

__ASSEMBLY__ is only defined by the Makefile of the kernel, so
this is not really useful for uapi headers (unless the userspace
Makefile defines it, too). Let's switch to __ASSEMBLER__ which
gets set automatically by the compiler when compiling assembly
code.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/x86/include/uapi/asm/bootparam.h  | 4 ++--
 arch/x86/include/uapi/asm/e820.h       | 4 ++--
 arch/x86/include/uapi/asm/ldt.h        | 4 ++--
 arch/x86/include/uapi/asm/msr.h        | 4 ++--
 arch/x86/include/uapi/asm/ptrace-abi.h | 6 +++---
 arch/x86/include/uapi/asm/ptrace.h     | 4 ++--
 arch/x86/include/uapi/asm/setup_data.h | 4 ++--
 arch/x86/include/uapi/asm/signal.h     | 8 ++++----
 8 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
index 9b82eebd7add5..dafbf581c515d 100644
--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@ -26,7 +26,7 @@
 #define XLF_5LEVEL_ENABLED		(1<<6)
 #define XLF_MEM_ENCRYPTION		(1<<7)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/types.h>
 #include <linux/screen_info.h>
@@ -210,6 +210,6 @@ enum x86_hardware_subarch {
 	X86_NR_SUBARCHS,
 };
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_X86_BOOTPARAM_H */
diff --git a/arch/x86/include/uapi/asm/e820.h b/arch/x86/include/uapi/asm/e820.h
index 2f491efe3a126..55bc668671560 100644
--- a/arch/x86/include/uapi/asm/e820.h
+++ b/arch/x86/include/uapi/asm/e820.h
@@ -54,7 +54,7 @@
  */
 #define E820_RESERVED_KERN        128
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/types.h>
 struct e820entry {
 	__u64 addr;	/* start of memory segment */
@@ -76,7 +76,7 @@ struct e820map {
 #define BIOS_ROM_BASE		0xffe00000
 #define BIOS_ROM_END		0xffffffff
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 
 #endif /* _UAPI_ASM_X86_E820_H */
diff --git a/arch/x86/include/uapi/asm/ldt.h b/arch/x86/include/uapi/asm/ldt.h
index d62ac5db093b4..a82c039d8e6a7 100644
--- a/arch/x86/include/uapi/asm/ldt.h
+++ b/arch/x86/include/uapi/asm/ldt.h
@@ -12,7 +12,7 @@
 /* The size of each LDT entry. */
 #define LDT_ENTRY_SIZE	8
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 /*
  * Note on 64bit base and limit is ignored and you cannot set DS/ES/CS
  * not to the default values if you still want to do syscalls. This
@@ -44,5 +44,5 @@ struct user_desc {
 #define MODIFY_LDT_CONTENTS_STACK	1
 #define MODIFY_LDT_CONTENTS_CODE	2
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 #endif /* _ASM_X86_LDT_H */
diff --git a/arch/x86/include/uapi/asm/msr.h b/arch/x86/include/uapi/asm/msr.h
index e7516b402a00f..4b8917ca28fe7 100644
--- a/arch/x86/include/uapi/asm/msr.h
+++ b/arch/x86/include/uapi/asm/msr.h
@@ -2,7 +2,7 @@
 #ifndef _UAPI_ASM_X86_MSR_H
 #define _UAPI_ASM_X86_MSR_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/types.h>
 #include <linux/ioctl.h>
@@ -10,5 +10,5 @@
 #define X86_IOC_RDMSR_REGS	_IOWR('c', 0xA0, __u32[8])
 #define X86_IOC_WRMSR_REGS	_IOWR('c', 0xA1, __u32[8])
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* _UAPI_ASM_X86_MSR_H */
diff --git a/arch/x86/include/uapi/asm/ptrace-abi.h b/arch/x86/include/uapi/asm/ptrace-abi.h
index 16074b9c93bb5..5823584dea132 100644
--- a/arch/x86/include/uapi/asm/ptrace-abi.h
+++ b/arch/x86/include/uapi/asm/ptrace-abi.h
@@ -25,7 +25,7 @@
 
 #else /* __i386__ */
 
-#if defined(__ASSEMBLY__) || defined(__FRAME_OFFSETS)
+#if defined(__ASSEMBLER__) || defined(__FRAME_OFFSETS)
 /*
  * C ABI says these regs are callee-preserved. They aren't saved on kernel entry
  * unless syscall needs a complete, fully filled "struct pt_regs".
@@ -57,7 +57,7 @@
 #define EFLAGS 144
 #define RSP 152
 #define SS 160
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 /* top of stack page */
 #define FRAME_SIZE 168
@@ -87,7 +87,7 @@
 
 #define PTRACE_SINGLEBLOCK	33	/* resume execution until next branch */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/types.h>
 #endif
 
diff --git a/arch/x86/include/uapi/asm/ptrace.h b/arch/x86/include/uapi/asm/ptrace.h
index 85165c0edafc8..e0b5b4f6226b1 100644
--- a/arch/x86/include/uapi/asm/ptrace.h
+++ b/arch/x86/include/uapi/asm/ptrace.h
@@ -7,7 +7,7 @@
 #include <asm/processor-flags.h>
 
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #ifdef __i386__
 /* this struct defines the way the registers are stored on the
@@ -81,6 +81,6 @@ struct pt_regs {
 
 
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif /* _UAPI_ASM_X86_PTRACE_H */
diff --git a/arch/x86/include/uapi/asm/setup_data.h b/arch/x86/include/uapi/asm/setup_data.h
index b111b0c185449..50c45ead4e7c9 100644
--- a/arch/x86/include/uapi/asm/setup_data.h
+++ b/arch/x86/include/uapi/asm/setup_data.h
@@ -18,7 +18,7 @@
 #define SETUP_INDIRECT			(1<<31)
 #define SETUP_TYPE_MAX			(SETUP_ENUM_MAX | SETUP_INDIRECT)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/types.h>
 
@@ -78,6 +78,6 @@ struct ima_setup_data {
 	__u64 size;
 } __attribute__((packed));
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _UAPI_ASM_X86_SETUP_DATA_H */
diff --git a/arch/x86/include/uapi/asm/signal.h b/arch/x86/include/uapi/asm/signal.h
index f777346450ec3..1067efabf18b5 100644
--- a/arch/x86/include/uapi/asm/signal.h
+++ b/arch/x86/include/uapi/asm/signal.h
@@ -2,7 +2,7 @@
 #ifndef _UAPI_ASM_X86_SIGNAL_H
 #define _UAPI_ASM_X86_SIGNAL_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/types.h>
 #include <linux/compiler.h>
 
@@ -16,7 +16,7 @@ struct siginfo;
 typedef unsigned long sigset_t;
 
 #endif /* __KERNEL__ */
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 
 #define SIGHUP		 1
@@ -68,7 +68,7 @@ typedef unsigned long sigset_t;
 
 #include <asm-generic/signal-defs.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 
 # ifndef __KERNEL__
@@ -106,6 +106,6 @@ typedef struct sigaltstack {
 	__kernel_size_t ss_size;
 } stack_t;
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _UAPI_ASM_X86_SIGNAL_H */
-- 
2.48.1


