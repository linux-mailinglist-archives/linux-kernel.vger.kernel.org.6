Return-Path: <linux-kernel+bounces-560786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA0BA60973
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E877719C2E87
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 07:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6868B16DED2;
	Fri, 14 Mar 2025 07:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BuWPNGkr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039451624E8
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 07:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741936253; cv=none; b=YEvNYZ7WV18tpLsfSvHcOSCzlG6pc4xk4H6oAklTMK/J/3ysBO6IwydPcsSw248tcS0U6h7u2g0MOamzsjT0TtE87M0xN+CB7LLLGhSZwu3gdArM21k+TKtMWb5TWzWvfrWovI1hChaIr30lzeiPghqXOIT7ADhtxTG5AX02wuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741936253; c=relaxed/simple;
	bh=OdduD8QSG1xOkPTD3j8qzTiY9mvPoBO3gEJheiHgrik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JPXYO5SBacz9vZ2Uo2zhzIxsz/JUq6+upV+Me21pL+nzQNCElXLbU8p1FONzyiPdNLu9zjp07j8OBw2F0FjB7zzQJXDHck5E3slJwocp558niZR9YahZEhWalPEaLzajmIbeN6OnT7bP3sjGOvvKe/sBeUtjPvIn8e1B7qtMD68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BuWPNGkr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741936250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KJMF2S80j4N2JEhusaXzar9nZ6KOLkUaFI2GrWAbcp0=;
	b=BuWPNGkr7n+3SLP2L5bPMuVQyBF/y0JK0Q/zFYG810Hsr1nQBUF3wXVHpEAIYa7O1CMlPX
	yZoIQwiDmIz36xQzZUpJ2JS/6OF5y2lSbOWeKINIXiW00X8E234b6z0zwx3wUQYN38VXhN
	IbsOgJdjTq5F7kqvJyTjnflCUrHZOEY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-OZAWj1JCOn6go3cn9jiAbg-1; Fri,
 14 Mar 2025 03:10:49 -0400
X-MC-Unique: OZAWj1JCOn6go3cn9jiAbg-1
X-Mimecast-MFC-AGG-ID: OZAWj1JCOn6go3cn9jiAbg_1741936248
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2FC07180036E;
	Fri, 14 Mar 2025 07:10:48 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.82])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1219218001D4;
	Fri, 14 Mar 2025 07:10:43 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	Thomas Huth <thuth@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	linux-alpha@vger.kernel.org
Subject: [PATCH 03/41] alpha: Replace __ASSEMBLY__ with __ASSEMBLER__ in the alpha headers
Date: Fri, 14 Mar 2025 08:09:34 +0100
Message-ID: <20250314071013.1575167-4-thuth@redhat.com>
In-Reply-To: <20250314071013.1575167-1-thuth@redhat.com>
References: <20250314071013.1575167-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

While the GCC and Clang compilers already define __ASSEMBLER__
automatically when compiling assembly code, __ASSEMBLY__ is a
macro that only gets defined by the Makefiles in the kernel.
This can be very confusing when switching between userspace
and kernelspace coding, or when dealing with uapi headers that
rather should use __ASSEMBLER__ instead. So let's standardize on
the __ASSEMBLER__ macro that is provided by the compilers now.

This is a completely mechanical patch (done with a simple "sed -i"
statement).

Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Matt Turner <mattst88@gmail.com>
Cc: linux-alpha@vger.kernel.org
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/alpha/include/asm/console.h     | 4 ++--
 arch/alpha/include/asm/page.h        | 4 ++--
 arch/alpha/include/asm/pal.h         | 4 ++--
 arch/alpha/include/asm/thread_info.h | 8 ++++----
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/alpha/include/asm/console.h b/arch/alpha/include/asm/console.h
index 088b7b9eb15ae..1cabdb6064bbe 100644
--- a/arch/alpha/include/asm/console.h
+++ b/arch/alpha/include/asm/console.h
@@ -4,7 +4,7 @@
 
 #include <uapi/asm/console.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 extern long callback_puts(long unit, const char *s, long length);
 extern long callback_getc(long unit);
 extern long callback_open_console(void);
@@ -26,5 +26,5 @@ struct crb_struct;
 struct hwrpb_struct;
 extern int callback_init_done;
 extern void * callback_init(void *);
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* __AXP_CONSOLE_H */
diff --git a/arch/alpha/include/asm/page.h b/arch/alpha/include/asm/page.h
index 5ec4c77e432e0..d2c6667d73e9e 100644
--- a/arch/alpha/include/asm/page.h
+++ b/arch/alpha/include/asm/page.h
@@ -6,7 +6,7 @@
 #include <asm/pal.h>
 #include <vdso/page.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #define STRICT_MM_TYPECHECKS
 
@@ -74,7 +74,7 @@ typedef struct page *pgtable_t;
 #define PAGE_OFFSET		0xfffffc0000000000
 #endif
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #define __pa(x)			((unsigned long) (x) - PAGE_OFFSET)
 #define __va(x)			((void *)((unsigned long) (x) + PAGE_OFFSET))
diff --git a/arch/alpha/include/asm/pal.h b/arch/alpha/include/asm/pal.h
index db2b3b18b34c7..799a64c051984 100644
--- a/arch/alpha/include/asm/pal.h
+++ b/arch/alpha/include/asm/pal.h
@@ -4,7 +4,7 @@
 
 #include <uapi/asm/pal.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 extern void halt(void) __attribute__((noreturn));
 #define __halt() __asm__ __volatile__ ("call_pal %0 #halt" : : "i" (PAL_halt))
@@ -183,5 +183,5 @@ qemu_get_vmtime(void)
 	return v0;
 }
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 #endif /* __ALPHA_PAL_H */
diff --git a/arch/alpha/include/asm/thread_info.h b/arch/alpha/include/asm/thread_info.h
index 4a4d00b37986e..98ccbca64984c 100644
--- a/arch/alpha/include/asm/thread_info.h
+++ b/arch/alpha/include/asm/thread_info.h
@@ -4,14 +4,14 @@
 
 #ifdef __KERNEL__
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <asm/processor.h>
 #include <asm/types.h>
 #include <asm/hwrpb.h>
 #include <asm/sysinfo.h>
 #endif
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 struct thread_info {
 	struct pcb_struct	pcb;		/* palcode state */
 
@@ -44,7 +44,7 @@ register struct thread_info *__current_thread_info __asm__("$8");
 
 register unsigned long *current_stack_pointer __asm__ ("$30");
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 /* Thread information allocation.  */
 #define THREAD_SIZE_ORDER 1
@@ -110,7 +110,7 @@ register unsigned long *current_stack_pointer __asm__ ("$30");
 	put_user(res, (int __user *)(value));				\
 	})
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 extern void __save_fpu(void);
 
 static inline void save_fpu(void)
-- 
2.48.1


