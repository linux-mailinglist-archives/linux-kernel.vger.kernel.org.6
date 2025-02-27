Return-Path: <linux-kernel+bounces-535675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B458A475DA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 07:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 972E43AFA4D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 06:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D9953E23;
	Thu, 27 Feb 2025 06:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I9b/HtHc"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F188C1A238B
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 06:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740636787; cv=none; b=WbqKIpuFlbSLHfK8rSy/aAJ2eVZDkvP9TnPWN552MPevw+IQ1m3yXf4+wZFsB4vs0b8j5MuIOweGPqG1l/REobHL3mjt88fbWnOHzEHm4WF2xihkJyDl6bRNo7v98Z/l/HL/MdOQxZ5PZ84IrXi5vvbYW0ET/m/UhpbXTh+D8d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740636787; c=relaxed/simple;
	bh=9J81SQoYHsfHuQNlO6dXXiKaclPkwFctCUcS7bQFdZ4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=MRppBZceqk4OcsCDYoM+9oCyJlkv37ZQX5J9mJOyNyvmbEkqJmqsLr88FgZ81h9sFuNFyntbghst0/ZiGDOsfjzCyjAI9qQmi/iENNGNdMGylV2ShRNFylHBw/YyAFSTuhTPZqvqkumVIGbW0XCKj6kUMjSLSYBArFN17alY5RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I9b/HtHc; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-abb7520028bso63716566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 22:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740636784; x=1741241584; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CuxSuk4eRgxWynJJEawNIcvcHNqZ5bgfZDjnTmQkJOo=;
        b=I9b/HtHccFKhDUROzvR4MmfLvyk6dOb6hLRofbQnE0BpV5xzTdA0CfddD0JWGno+Cb
         7FIyDJQU3E4rRGHX9Su80Aq0+BkWzagdwg/RJcjtZ2IrAIbRC+idfnToaihYH4J76XNT
         hlTmNKYhDPd4vezH7TwD7NL4WubQIy2ZtyqoIExgXOeVG+tYvb4F9TK+bHbtwfAgu2jd
         SE/ZAG8luW+nLCpBgE9+Y9lPQdw+uF6TWLErPALnF3ZehELshVDiJ4gerO9vf1zhvdUr
         3RwnbVMVbfBcU2bLkcyxemcXZlKST9FUMTlSP9ZYzksuJaUxDSpkOns6ij9Ner3xNP+1
         y8DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740636784; x=1741241584;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CuxSuk4eRgxWynJJEawNIcvcHNqZ5bgfZDjnTmQkJOo=;
        b=JB78wSy1Vh2IXOXYKVdlvmP1IDNkdY9r4GIi30vjzt3diGTrxcLj38RxjDxMUHiLPh
         HhBsiM50Nq2pzP1agVbHyC86XdQrULkdRY8a1LE7EE4UpelEzAhrjxEocCLfJoW/VSo9
         zSogSFV1hNgOSxMXTDvsTV1Z6aCglWwvJvhxsAI/oeWS1oCTPcgRCv/nGft6CCvHnOnP
         4qSxPBSZg8o17RacUNq9WmC9eGqzfhWvw2tAjtb3EaGfiE3q2XOlPicO9ZrVs1eHvLnN
         QVP1WFgGIUlIAqiw1L2eimSlKLkO349zgWL2CQIfcbM2EYk9WwM81ilO8mJ3cxkLFsZ3
         Ojjg==
X-Forwarded-Encrypted: i=1; AJvYcCXIb5+lcJt+LbI2jQ59K2flXcl6qYiW4R3UrH1duU0Hl1z3CNSThrTzHOP7ujp6S0rs7U8lmMCoydPWrl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD3v512Q/Ss5onD5gGze+D4h8l3roacw6675FoDSwR65VPWq0E
	TlNTAvBd1P5UHUQgAoH8AxHaqPeL5m2nuI1AEZfdbAqlOv8fbnW1OO52+sk/sWtDUWsablRJSue
	QiIDzKfWWWUyidi6AMOdTbZC1RTE+8YaeTcw=
X-Gm-Gg: ASbGncu0XiSJ1Mjb83YqUCGMWGrt9LwtYte6/7YU4AZftw4O2yAIYFw44UC8HugYxRb
	L8QJSu2qaE4NE2Ca9hLhRciYx2hrIH545PyOyB0BqMfFFNkg1oWYOvZYq86oSu1UShiVJ+RPuAc
	YjUmvl
X-Google-Smtp-Source: AGHT+IEgJXsQWOrOPhuyDiqYa5ObWU7mCLEWr74aJZ2+hsjWBPxMvycAsBVKLy9JZ2u4XFnZXPgBLyMLQe3dM8dy6ys=
X-Received: by 2002:a17:906:3105:b0:ab7:f2da:8122 with SMTP id
 a640c23a62f3a-abeeecfd662mr707407366b.3.1740636784177; Wed, 26 Feb 2025
 22:13:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Bill Wendling <morbo@google.com>
Date: Wed, 26 Feb 2025 22:12:47 -0800
X-Gm-Features: AQ5f1Jovhh9LtaEfZAB9uuTkphZJ0I-qXJT238fUHcidB3rX9MNwIcr8OFeNbcQ
Message-ID: <CAGG=3QVi27WRYVxmsk9+HLpJw9ZJrpfLjU8G4exuXm-vUA-KqQ@mail.gmail.com>
Subject: [PATCH] x86/crc32: use builtins to improve code generation
To: Bill Wendling <morbo@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Eric Biggers <ebiggers@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Justin Stitt <justinstitt@google.com>, 
	LKML <linux-kernel@vger.kernel.org>, linux-crypto@vger.kernel.org, 
	clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

For both gcc and clang, crc32 builtins generate better code than the
inline asm. GCC improves, removing unneeded "mov" instructions. Clang
does the same and unrolls the loops. GCC has no changes on i386, but
Clang's code generation is vastly improved, due to Clang's "rm"
constraint issue.

The number of cycles improved by ~0.1% for GCC and ~1% for Clang, which
is expected because of the "rm" issue. However, Clang's performance is
better than GCC's by ~1.5%, most likely due to loop unrolling.

Link: https://github.com/llvm/llvm-project/issues/20571#issuecomment-2649330009
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>
Cc: Justin Stitt <justinstitt@google.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-crypto@vger.kernel.org
Cc: llvm@lists.linux.dev
Signed-off-by: Bill Wendling <morbo@google.com>
---
 arch/x86/Makefile         | 3 +++
 arch/x86/lib/crc32-glue.c | 8 ++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 5b773b34768d..241436da1473 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -114,6 +114,9 @@ else
 KBUILD_CFLAGS += $(call cc-option,-fcf-protection=none)
 endif

+# Enables the use of CRC32 builtins.
+KBUILD_CFLAGS += -mcrc32
+
 ifeq ($(CONFIG_X86_32),y)
         BITS := 32
         UTS_MACHINE := i386
diff --git a/arch/x86/lib/crc32-glue.c b/arch/x86/lib/crc32-glue.c
index 2dd18a886ded..fdb94bff25f4 100644
--- a/arch/x86/lib/crc32-glue.c
+++ b/arch/x86/lib/crc32-glue.c
@@ -48,9 +48,9 @@ u32 crc32_le_arch(u32 crc, const u8 *p, size_t len)
 EXPORT_SYMBOL(crc32_le_arch);

 #ifdef CONFIG_X86_64
-#define CRC32_INST "crc32q %1, %q0"
+#define CRC32_INST __builtin_ia32_crc32di
 #else
-#define CRC32_INST "crc32l %1, %0"
+#define CRC32_INST __builtin_ia32_crc32si
 #endif

 /*
@@ -78,10 +78,10 @@ u32 crc32c_le_arch(u32 crc, const u8 *p, size_t len)

        for (num_longs = len / sizeof(unsigned long);
             num_longs != 0; num_longs--, p += sizeof(unsigned long))
-               asm(CRC32_INST : "+r" (crc) : "rm" (*(unsigned long *)p));
+               crc = CRC32_INST(crc,  *(unsigned long *)p);

        for (len %= sizeof(unsigned long); len; len--, p++)
-               asm("crc32b %1, %0" : "+r" (crc) : "rm" (*p));
+               crc = __builtin_ia32_crc32qi(crc, *p);

        return crc;
 }
-- 
2.48.1.711.g2feabab25a-goog

