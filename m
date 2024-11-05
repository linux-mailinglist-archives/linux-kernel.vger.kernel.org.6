Return-Path: <linux-kernel+bounces-396729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AD09BD15C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08EBBB24299
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6844E186E38;
	Tue,  5 Nov 2024 15:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wgt5mGlE"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF3817BEBF
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 15:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730822305; cv=none; b=LVUjQj0MRsGlf+I7skQx2KQh2nvWay25S3DdZUtyYPL4xKhO0Lz2V6I1L2x/iA1C5z1n0LFzcutk3lF7KNwRpy/43zFmo135XwIiuYAZ/v25mVgKISS7SBntjT1HoHEoWNehwMhHWLNh6qj7SiknylVnVzN8jltIJMdumIKaKG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730822305; c=relaxed/simple;
	bh=uM7fZITeS4kzRvKYIAo9m9PY8ycUoTWCRTIzN1uC3eY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jb0Phlt2FNhzPFE5V5sDDLyzHlxvMckCX6w9SLXVtPpJSeiOMYTjzTaJM7Xn6xe0uNOxucqxXEa4KsyBfLBsH8dqjMMl2Xpmg19VEjGuyORqsvpWiuzQodHxaqR2fb+onW0PF8o74f4ucAvw/bkF1EBn1i68K/y20NgHFkwz7hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wgt5mGlE; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6d18dff41cdso34562646d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 07:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730822302; x=1731427102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mn3qXuCprKkV0lHxekStETofBm7VBuDAWcIvFmwwo7o=;
        b=Wgt5mGlEDnb1v4ES4coVxgMJOqno5PWuQPvHVeo93Q6yFUnwXp5fQ3bPaGJAnW3rOk
         PXDqoRnR7dNqdG8rycQ/D986ULvsTeRtbSpzj4IlOt68J5BPOSpccx+5+vPKTtUD9QgV
         wyPsox1i5qPgs+7mn0dTDsmq0ffjo9JBeL+YF02VPUN0yISfrMjDTGiH5vmlRJKKIcen
         eVk3qLAfrYEaNUWnb5Ok/oFhxDTRIYA9QerRVEZSIAz5PUr1TyVoN0EO1gT2o1Xywoxr
         d+zxVsi2sJoFmROidOAPo+NpsCE/yF49gvwUQ+05uNk5Q21EQtS6umjd8OTxt/99iB/A
         P/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730822302; x=1731427102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mn3qXuCprKkV0lHxekStETofBm7VBuDAWcIvFmwwo7o=;
        b=AkQeydAz+4faltMBRVcEi0aB6WOLbgeAZFQcQFsLArPEuuC/22n3tRr3GfBNnE9VKH
         9p7rAlVc7bEFGThPHBUJ4exSQNiYhnKxaJbicsoKxpEx04UAhPAJeFivwEoX8zV7sPF3
         1onoEDIsVilDPY81AH3qik4wjzfvR0hS6/BregR/VusrSlsETtt+H7hYf3H2owMW3psp
         2SgnUArKrnKemznPqPp7xIUMmyQB8AF8wbZd5yHOTrme9JI/9a7x040gleI/aOD8qAHq
         v6KqK/4XHLvlU73rKSaQvxrZp2WzkLCqhcM81UpUgOT4MQt3fqbPDYo6rB4XGcgjbpGg
         Llxw==
X-Gm-Message-State: AOJu0Yz/JxANKyBUKf/BEiG74uLR/JqnVGfPj46tNQOEs44jbpLwCjS3
	J8tn2e9DAT9d26yewG/IGIWe7D101KZDVS7E5yi1+C7w3zcbEYYUVuVY
X-Google-Smtp-Source: AGHT+IH8VROdhfa/CG+F5KGBYGr5o73Mev4N5h/q/3VZ7frzZivyO1+3kC+hCYIYV0hMoBqTnS46IQ==
X-Received: by 2002:a05:6214:5901:b0:6cb:2456:537 with SMTP id 6a1803df08f44-6d1856fa07amr485554546d6.29.1730822302429;
        Tue, 05 Nov 2024 07:58:22 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d353fc6d07sm61710586d6.44.2024.11.05.07.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 07:58:22 -0800 (PST)
From: Brian Gerst <brgerst@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v5 07/16] x86/module: Deal with GOT based stack cookie load on Clang < 17
Date: Tue,  5 Nov 2024 10:57:52 -0500
Message-ID: <20241105155801.1779119-8-brgerst@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241105155801.1779119-1-brgerst@gmail.com>
References: <20241105155801.1779119-1-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ard Biesheuvel <ardb@kernel.org>

Clang versions before 17 will not honour -fdirect-access-external-data
for the load of the stack cookie emitted into each function's prologue
and epilogue.

This is not an issue for the core kernel, as the linker will relax these
loads into LEA instructions that take the address of __stack_chk_guard
directly. For modules, however, we need to work around this, by dealing
with R_X86_64_REX_GOTPCRELX relocations that refer to __stack_chk_guard.

In this case, given that this is a GOT load, the reference should not
refer to __stack_chk_guard directly, but to a memory location that holds
its address. So take the address of __stack_chk_guard into a static
variable, and fix up the relocations to refer to that.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/include/asm/elf.h |  3 ++-
 arch/x86/kernel/module.c   | 15 +++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index 1fb83d47711f..0d6ca771549d 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -55,7 +55,8 @@ typedef struct user_i387_struct elf_fpregset_t;
 #define R_X86_64_JUMP_SLOT	7	/* Create PLT entry */
 #define R_X86_64_RELATIVE	8	/* Adjust by program base */
 #define R_X86_64_GOTPCREL	9	/* 32 bit signed pc relative
-					   offset to GOT */
+#define R_X86_64_GOTPCRELX	41	   offset to GOT */
+#define R_X86_64_REX_GOTPCRELX	42
 #define R_X86_64_32		10	/* Direct 32 bit zero extended */
 #define R_X86_64_32S		11	/* Direct 32 bit sign extended */
 #define R_X86_64_16		12	/* Direct 16 bit zero extended */
diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index 837450b6e882..9929be7a76e7 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -19,6 +19,7 @@
 #include <linux/jump_label.h>
 #include <linux/random.h>
 #include <linux/memory.h>
+#include <linux/stackprotector.h>
 
 #include <asm/text-patching.h>
 #include <asm/page.h>
@@ -130,6 +131,20 @@ static int __write_relocate_add(Elf64_Shdr *sechdrs,
 				goto overflow;
 			size = 4;
 			break;
+#if defined(CONFIG_STACKPROTECTOR) && \
+    defined(CONFIG_CC_IS_CLANG) && CONFIG_CLANG_VERSION < 170000
+		case R_X86_64_REX_GOTPCRELX: {
+			static unsigned long __percpu *const addr = &__stack_chk_guard;
+
+			if (sym->st_value != (u64)addr) {
+				pr_err("%s: Unsupported GOTPCREL relocation\n", me->name);
+				return -ENOEXEC;
+			}
+
+			val = (u64)&addr + rel[i].r_addend;
+			fallthrough;
+		}
+#endif
 		case R_X86_64_PC32:
 		case R_X86_64_PLT32:
 			val -= (u64)loc;
-- 
2.47.0


