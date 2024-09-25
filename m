Return-Path: <linux-kernel+bounces-339317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3945B986333
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4A91289F9F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 15:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DDD19CC1B;
	Wed, 25 Sep 2024 15:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y3T3x26s"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BF4199958
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 15:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727276579; cv=none; b=kixYM258kBGE5RyzJNC/wkRgzkV8a5af7cVPuvSf0rqGNlLjN7TF1n5UWjn/MWg799FHcAITx4FwjzvZOzG6FUIoX8pc4ZBM5RtJ9VUCWf78COCoXt2RS8y+0Fj5I3Ny/4vCm3NY7MkryXVM3OjAj9diP+mDwQxd1Gyh/Xk1HEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727276579; c=relaxed/simple;
	bh=Ojp+f8Ba/j3ywSUpNkHMxJUaSZwEN3iyyriDyS6ns1Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Dsj/5FjQbD2OpLiWrQTMbQrR22exFiVMaEpMaDqK/PCk50w/vJeeXWX0LsnEwcmRZ1oeQBe4oycIUymeCf2T0V8XOVuSa0By1BD5GaTvEegcvCvcLcbpQWGrRdf0rCU4qL+oS7vUhNAbP5lsTraB5pFEs7Y10ZClYq+ISNd8omA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y3T3x26s; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-42cb998fd32so47878575e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 08:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727276574; x=1727881374; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=O/+lA7axzWVX738v6MDlUUydsjXBcrFQn3zDJoV9Zlw=;
        b=y3T3x26sz6jhlZueXjpSSXL3amdsXx8Mbpd1yomI+UJdyfjbVZ3wxXIZu2eFjNJyEa
         mz+UPaOC2MS77QuK67CtQ5Ghwzedq/bAumcKNVhhTn5ZpFdC5dp8EDQ03RLeUZ0grXOy
         KY3BxHG2sAY3nwi4+XO4ywe7lyqJIYoly693zeMzurddsEafa5E2cPy88tCerp9YJVdi
         6Y3CyMU3Q0DBNUkQVq63MZ5CVm7Wp/FdNAHI7XmYd7QbqrQcJPUcoAmiXiEa/WaJIyYp
         /AdSxodOvEYDXTWJ/4FTOoB8osxnYELNuHCDU3NUTwyEyIpVyXxbTS5RqNlxXpr3CMMW
         CbmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727276574; x=1727881374;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O/+lA7axzWVX738v6MDlUUydsjXBcrFQn3zDJoV9Zlw=;
        b=RoFaFri1c07zD1Fs4IVFMVTFC6BjA9dAtefc3YM7ijShaafIslyPxlJeQgG84YAOOs
         QnSbzij6X70MbiloRvJV+a0d+hahKtuIv+0+ZOpQSBKaMO94AQdZfJoBkIP9Mkp68Qy8
         s4lkpcY/G2KE51eGlHVxhDOv95e9tTobOv7YgL+/Xlj0RY+40rYpV9El0lqK4Whz8FuR
         ZrCNymDSiYY4EUy1HM6XL/9g9xoiPkBt7IcpJSMGOXeljDb7b3gXtr4zwQhxXgEOSguQ
         a8J3f8a8FBP6jh7Cyx5I7Hd1SRLAm0VZcwYSwf6UIGLieccNpAZcnmi5tCHo/yQ6x9Np
         lfgg==
X-Gm-Message-State: AOJu0YxcrS9rh01I9KraMAEZWwAv6BxXpTQy9Bu23+S8aOXv+p/0ez4/
	dttm5Efeul4J7fidgJgojS0IA05vI7Chve6GLuOiIg66Q+Qq9xye+MpB+7+pq7mBsGf5+jQaK9T
	Z7PUw+oAaAatidLyMJpFysQG88S8a7Cwr3ZPke9n52oY+S+5MrHhTZuBE2A7zNdAw5aPYv2B/5h
	TkeGOiQQXsQ7LKh5EKMSoGS2/A9oOwbg==
X-Google-Smtp-Source: AGHT+IFNuvMvba4376xFzsyJ1BUDwRQ77lLDg4NDppuY0o3Frk8EdeKG+tmu68nrB2OUMQBq6qGzN/uY
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a5d:54cc:0:b0:374:c4ab:a87 with SMTP id
 ffacd0b85a97d-37cc24daa31mr1689f8f.10.1727276573709; Wed, 25 Sep 2024
 08:02:53 -0700 (PDT)
Date: Wed, 25 Sep 2024 17:01:25 +0200
In-Reply-To: <20240925150059.3955569-30-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240925150059.3955569-30-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4435; i=ardb@kernel.org;
 h=from:subject; bh=kANZ4hMlm4/UDKey8x5hppB+h4SVBsDN4bipEdg9xMY=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIe2L6vknrr8ZmOQrG7s3Nc2KdXJ4vibh1dcKsQf8Readb
 AEJHvkdpSwMYhwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCKL/Rj+Z1Y035g4dcnETV4f
 AzeGy0dnuYj7Gs68XGu9U01C7fDJWEaGptn9D/zPzyrzzArfXiITGJrvprug4muz0/qrb5bc6L/ LCQA=
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240925150059.3955569-55-ardb+git@google.com>
Subject: [RFC PATCH 25/28] x86: Use PIE codegen for the core kernel
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

As an intermediate step towards enabling PIE linking for the 64-bit x86
kernel, enable PIE codegen for all objects that are linked into the
kernel proper.

This substantially reduces the number of relocations that need to be
processed when booting a relocatable KASLR kernel.

Before (size in bytes of the reloc table):

  797372 arch/x86/boot/compressed/vmlinux.relocs

After:

  400252 arch/x86/boot/compressed/vmlinux.relocs

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/Makefile                 | 11 ++++++++++-
 arch/x86/boot/Makefile            |  1 +
 arch/x86/boot/compressed/Makefile |  2 +-
 arch/x86/entry/vdso/Makefile      |  1 +
 arch/x86/realmode/rm/Makefile     |  1 +
 include/asm-generic/vmlinux.lds.h |  1 +
 6 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index b78b7623a4a9..83d20f402535 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -193,13 +193,22 @@ else
         KBUILD_RUSTFLAGS += -Cno-redzone=y
         KBUILD_RUSTFLAGS += -Ccode-model=kernel
 
+        PIE_CFLAGS-y := -fpie -mcmodel=small \
+                        -include $(srctree)/include/linux/hidden.h
+
+        PIE_CFLAGS-$(CONFIG_CC_IS_GCC) += $(call cc-option.-mdirect-extern-access)
+        PIE_CFLAGS-$(CONFIG_CC_IS_CLANG) += -fdirect-access-external-data
+
         ifeq ($(CONFIG_STACKPROTECTOR),y)
                 KBUILD_CFLAGS += -mstack-protector-guard-symbol=fixed_percpu_data
+
+                # the 'small' C model defaults to %fs
+                PIE_CFLAGS-$(CONFIG_SMP) += -mstack-protector-guard-reg=gs
         endif
 
         # Don't emit relaxable GOTPCREL relocations
         KBUILD_AFLAGS_KERNEL += -Wa,-mrelax-relocations=no
-        KBUILD_CFLAGS_KERNEL += -Wa,-mrelax-relocations=no
+        KBUILD_CFLAGS_KERNEL += -Wa,-mrelax-relocations=no $(PIE_CFLAGS-y)
 endif
 
 #
diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index 9cc0ff6e9067..4d3ba35cb619 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -57,6 +57,7 @@ KBUILD_AFLAGS	:= $(KBUILD_CFLAGS) -D__ASSEMBLY__
 KBUILD_CFLAGS	+= $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
 KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables
 KBUILD_CFLAGS	+= $(CONFIG_CC_IMPLICIT_FALLTHROUGH)
+KBUILD_CFLAGS_KERNEL :=
 
 $(obj)/bzImage: asflags-y  := $(SVGA_MODE)
 
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index f2051644de94..c362d36b5b69 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -73,7 +73,7 @@ LDFLAGS_vmlinux += -T
 hostprogs	:= mkpiggy
 HOST_EXTRACFLAGS += -I$(srctree)/tools/include
 
-sed-voffset := -e 's/^\([0-9a-fA-F]*\) [ABCDGRSTVW] \(_text\|__start_rodata\|__bss_start\|_end\)$$/\#define VO_\2 _AC(0x\1,UL)/p'
+sed-voffset := -e 's/^\([0-9a-fA-F]*\) [ABbCDdGRSTtVW] \(_text\|__start_rodata\|__bss_start\|_end\)$$/\#define VO_\2 _AC(0x\1,UL)/p'
 
 quiet_cmd_voffset = VOFFSET $@
       cmd_voffset = $(NM) $< | sed -n $(sed-voffset) > $@
diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index c9216ac4fb1e..7af9fecf9abb 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -141,6 +141,7 @@ endif
 endif
 
 $(obj)/vdso32.so.dbg: KBUILD_CFLAGS = $(KBUILD_CFLAGS_32)
+$(obj)/vdso32.so.dbg: KBUILD_CFLAGS_KERNEL :=
 
 $(obj)/vdso32.so.dbg: $(obj)/vdso32/vdso32.lds $(vobjs32) FORCE
 	$(call if_changed,vdso_and_check)
diff --git a/arch/x86/realmode/rm/Makefile b/arch/x86/realmode/rm/Makefile
index a0fb39abc5c8..70bf0a26da91 100644
--- a/arch/x86/realmode/rm/Makefile
+++ b/arch/x86/realmode/rm/Makefile
@@ -67,3 +67,4 @@ KBUILD_CFLAGS	:= $(REALMODE_CFLAGS) -D_SETUP -D_WAKEUP \
 		   -I$(srctree)/arch/x86/boot
 KBUILD_AFLAGS	:= $(KBUILD_CFLAGS) -D__ASSEMBLY__
 KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables
+KBUILD_CFLAGS_KERNEL :=
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 2b079f73820f..3a084ac77109 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -349,6 +349,7 @@
 	*(DATA_MAIN)							\
 	*(.data..decrypted)						\
 	*(.ref.data)							\
+	*(.data.rel*)							\
 	*(.data..shared_aligned) /* percpu related */			\
 	*(.data.unlikely)						\
 	__start_once = .;						\
-- 
2.46.0.792.g87dc391469-goog


