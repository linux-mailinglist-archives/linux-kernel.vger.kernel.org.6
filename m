Return-Path: <linux-kernel+bounces-348388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE2A98E708
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 01:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE21428373C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 23:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF30419F432;
	Wed,  2 Oct 2024 23:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TbLpxUKk"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0655319FA8C
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 23:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727912067; cv=none; b=iQxjPatUWkRXkm+rlnGhaaM1DSV98rqYD32jKuqZmJ5cKrk0nHnz/ZIB01g+3LwUSUrr2hw6RRHfrNT4eXmRWeU6Pmusx8ImYMb1BD0/JCUGSDdpzDRp/ZE5mMgCiss5qlxfS4YsRli3BZk/neMLKozOP0y3UICMAJI9EFbAYbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727912067; c=relaxed/simple;
	bh=HEWLg94lHcfcX7O0hjC6KFou33+KNhu6rRzJHa0B/cU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=V3Mumj28On+g5idF2xGE6eKHsl4I/oE8ZyG93zvEDpEhIykS8wvRyWUgdGK6F04UUw0LUeMCIq+9TBjkFqOYCqaNBairtktjCldaWoQ6Ob5XccNN1Bmk17TRbrt88iEe/xgVzZ42FWWHenhjS/yBv/48/rZYrZZAWb+RPwpuf0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--xur.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TbLpxUKk; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--xur.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ddbcc96984so6724867b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 16:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727912065; x=1728516865; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KR/7S/qOw5pwSaOTb7JyOKPjhhpLATlydtN1CkOVSds=;
        b=TbLpxUKkHozVi66rLLJVm8eYkoX2hvCZPYW0HPiqSyOhu9WRHd2Vr6f4zf4hjZ7ZDU
         OzkpY0Rzzqo83i6yTWgTytHb9okormvaBedxN/m1gHTcjx4umsoizKmcJgakkHrAmkuu
         SU90N5w64fIubhixgm3VTi92gntGmB5DROu6RhZr4CvuPwZaMTj2BntBV8587dYGm1XP
         iKbJPeAp1jKIQH1nRibNQsJjbDgmqMYNTPt5MiCqn6WGSzX3vmWR1OlFv0X3DQVW1FCk
         dvh8sFQQG0CYm3rSSkR/CHYY8tMXutyCQgUhqbl4kUNxc98CRXzzSelSvs67YZpHdl7t
         SxHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727912065; x=1728516865;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KR/7S/qOw5pwSaOTb7JyOKPjhhpLATlydtN1CkOVSds=;
        b=P7RkCrO/hBxgc4YyN5NuacYiDp7iIRmtX+mQq2Y2QnYUlW7sCM9Gb94DpbUBnJU76U
         /wgKVhBpzUWCctPWOhWxunWD1Tavzjgp4Yd03KwvUt6I4RcvnRxcz0H2ZI0otG5pIBRd
         ibLgiCs/qupBeDfk4gVC+dEqVD1e1BtlsrWSR3eciPOgLa55z8XQS+hfQqlKhgjrXYOx
         qRWFYiBBA+6oSvtQHL916ifJQaV5K11Rd1rpanOHYOT3VWTOPkna4aIFupv/H0t+eOyn
         rFhYPztydfXg1BpcMYjFregAd8B7MtKGky/HIRjfOtLC4YmQ2Xohs01OXNAZHEXzKmjQ
         f/ug==
X-Forwarded-Encrypted: i=1; AJvYcCU2EtP2OF12K2glgqXBFnh1ojbsh8tSLxyluqbrN0Hc7oYHyDa6IQQlVKAIB9U3Wd79bCEMphs59iKmYu0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6dozJbKYMR8YdE89rCSUPR6BYcODbJ21ALVWwpb9VqUjzXMHo
	yf2BwmV7mrJ/nCysrWEJzGJ7Rz6hz1WDfXMhwT4cfb8YYm9pW2pHn2U70ARvIbtVpA==
X-Google-Smtp-Source: AGHT+IGtSRk7MTIglmEkTfvd6+ZSJGdRNh+Fp2nkpaXXYORf+k6X+OIhPZQKfZ6wOw9GZPzt+lVcc/w=
X-Received: from xur.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2330])
 (user=xur job=sendgmr) by 2002:a25:b303:0:b0:e25:cea9:b0e with SMTP id
 3f1490d57ef6-e2638432ffamr2877276.9.1727912064775; Wed, 02 Oct 2024 16:34:24
 -0700 (PDT)
Date: Wed,  2 Oct 2024 16:34:03 -0700
In-Reply-To: <20241002233409.2857999-1-xur@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241002233409.2857999-1-xur@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20241002233409.2857999-5-xur@google.com>
Subject: [PATCH v2 4/6] AutoFDO: Enable -ffunction-sections for the AutoFDO build
From: Rong Xu <xur@google.com>
To: Rong Xu <xur@google.com>, Han Shen <shenhan@google.com>, 
	Sriraman Tallam <tmsriram@google.com>, David Li <davidxl@google.com>, 
	Krzysztof Pszeniczny <kpszeniczny@google.com>, Alice Ryhl <aliceryhl@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Bill Wendling <morbo@google.com>, Borislav Petkov <bp@alien8.de>, Breno Leitao <leitao@debian.org>, 
	Brian Gerst <brgerst@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Heiko Carstens <hca@linux.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, 
	Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Juergen Gross <jgross@suse.com>, Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>, 
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, Masahiro Yamada <masahiroy@kernel.org>, 
	"Mike Rapoport (IBM)" <rppt@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Nicolas Schier <nicolas@fjasle.eu>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Samuel Holland <samuel.holland@sifive.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Wei Yang <richard.weiyang@gmail.com>, workflows@vger.kernel.org, x86@kernel.org, 
	"Xin Li (Intel)" <xin@zytor.com>
Content-Type: text/plain; charset="UTF-8"

Enable -ffunction-sections by default for the AutoFDO build.

With -ffunction-sections, the compiler places each function in its own
section named .text.function_name instead of placing all functions in
the .text section. In the AutoFDO build, this allows the linker to
utilize profile information to reorganize functions for improved
utilization of iCache and iTLB.

Co-developed-by: Han Shen <shenhan@google.com>
Signed-off-by: Han Shen <shenhan@google.com>
Signed-off-by: Rong Xu <xur@google.com>
Suggested-by: Sriraman Tallam <tmsriram@google.com>
---
 include/asm-generic/vmlinux.lds.h | 37 ++++++++++++++++++++++++-------
 scripts/Makefile.autofdo          |  2 +-
 2 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 5df589c60401..ace617d1af9b 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -95,18 +95,25 @@
  * With LTO_CLANG, the linker also splits sections by default, so we need
  * these macros to combine the sections during the final link.
  *
+ * With LTO_CLANG, the linker also splits sections by default, so we need
+ * these macros to combine the sections during the final link.
+ *
  * RODATA_MAIN is not used because existing code already defines .rodata.x
  * sections to be brought in with rodata.
  */
-#if defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || defined(CONFIG_LTO_CLANG)
+#if defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || defined(CONFIG_LTO_CLANG) || \
+defined(CONFIG_AUTOFDO_CLANG)
 #define TEXT_MAIN .text .text.[0-9a-zA-Z_]*
+#else
+#define TEXT_MAIN .text
+#endif
+#if defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || defined(CONFIG_LTO_CLANG)
 #define DATA_MAIN .data .data.[0-9a-zA-Z_]* .data..L* .data..compoundliteral* .data.$__unnamed_* .data.$L*
 #define SDATA_MAIN .sdata .sdata.[0-9a-zA-Z_]*
 #define RODATA_MAIN .rodata .rodata.[0-9a-zA-Z_]* .rodata..L*
 #define BSS_MAIN .bss .bss.[0-9a-zA-Z_]* .bss..L* .bss..compoundliteral*
 #define SBSS_MAIN .sbss .sbss.[0-9a-zA-Z_]*
 #else
-#define TEXT_MAIN .text
 #define DATA_MAIN .data
 #define SDATA_MAIN .sdata
 #define RODATA_MAIN .rodata
@@ -549,6 +556,20 @@
 		__cpuidle_text_end = .;					\
 		__noinstr_text_end = .;
 
+#ifdef CONFIG_AUTOFDO_CLANG
+#define TEXT_HOT							\
+		__hot_text_start = .;					\
+		*(.text.hot .text.hot.*)				\
+		__hot_text_end = .;
+#define TEXT_UNLIKELY							\
+		__unlikely_text_start = .;				\
+		*(.text.unlikely .text.unlikely.*)			\
+		__unlikely_text_end = .;
+#else
+#define TEXT_HOT *(.text.hot .text.hot.*)
+#define TEXT_UNLIKELY *(.text.unlikely .text.unlikely.*)
+#endif
+
 /*
  * .text section. Map to function alignment to avoid address changes
  * during second ld run in second ld pass when generating System.map
@@ -557,30 +578,30 @@
  * code elimination or function-section is enabled. Match these symbols
  * first when in these builds.
  */
-#if defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || defined(CONFIG_LTO_CLANG)
+#if defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || defined(CONFIG_LTO_CLANG) || \
+defined(CONFIG_AUTOFDO_CLANG)
 #define TEXT_TEXT							\
 		ALIGN_FUNCTION();					\
 		*(.text.asan.* .text.tsan.*)				\
 		*(.text.unknown .text.unknown.*)			\
-		*(.text.unlikely .text.unlikely.*)			\
+		TEXT_UNLIKELY						\
 		. = ALIGN(PAGE_SIZE);					\
-		*(.text.hot .text.hot.*)				\
+		TEXT_HOT						\
 		*(TEXT_MAIN .text.fixup)				\
 		NOINSTR_TEXT						\
 		*(.ref.text)
 #else
 #define TEXT_TEXT							\
 		ALIGN_FUNCTION();					\
-		*(.text.hot .text.hot.*)				\
+		TEXT_HOT						\
 		*(TEXT_MAIN .text.fixup)				\
-		*(.text.unlikely .text.unlikely.*)			\
+		TEXT_UNLIKELY						\
 		*(.text.unknown .text.unknown.*)			\
 		NOINSTR_TEXT						\
 		*(.ref.text)						\
 		*(.text.asan.* .text.tsan.*)
 #endif
 
-
 /* sched.text is aling to function alignment to secure we have same
  * address even at second ld pass when generating System.map */
 #define SCHED_TEXT							\
diff --git a/scripts/Makefile.autofdo b/scripts/Makefile.autofdo
index 1c9f224bc221..9c9a530ef090 100644
--- a/scripts/Makefile.autofdo
+++ b/scripts/Makefile.autofdo
@@ -10,7 +10,7 @@ ifndef CONFIG_DEBUG_INFO
 endif
 
 ifdef CLANG_AUTOFDO_PROFILE
-  CFLAGS_AUTOFDO_CLANG += -fprofile-sample-use=$(CLANG_AUTOFDO_PROFILE)
+  CFLAGS_AUTOFDO_CLANG += -fprofile-sample-use=$(CLANG_AUTOFDO_PROFILE) -ffunction-sections
 endif
 
 ifdef CONFIG_LTO_CLANG_THIN
-- 
2.46.1.824.gd892dcdcdd-goog


