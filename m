Return-Path: <linux-kernel+bounces-264861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CAC93E95C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 22:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 351C81F217D9
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 20:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3AE77F10;
	Sun, 28 Jul 2024 20:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f6BjeUdH"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204387D3EF
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 20:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722198666; cv=none; b=tzv161CpbQ3c70proLbGGVXtAgP05tFQIe9oqyQvmSgnG/n5DYIDkikLHRWNELQkYBgs5ekjVuI/p2iGZwdH2X+xD3RCk2zn2IT2/gn2GidfT/jlMUqM4cAmwZB1zwiWw60f6+P4g3UMwzIuAqH7S84pvzbmqhjwHFNx6/8oBwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722198666; c=relaxed/simple;
	bh=jgG0TSTo1c+hpUBT22yEfSilFpbm6otN2MQr5+RKpfs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E4p2wyWI94ekucsNBr+RW+qBTGcOgUgQ3HIFaFJLSc33QzdCKw0iFHBDYuioQC3goGkhEpsaiDvJbr0JgAofR24zr+c7TllfxdqU+kLx/d4RMSJyDfD5D81AtN+CDfA0YG0LXaPdTd9cKzTFYHuX81bH23wTUXc042N+rNUYXnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--xur.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f6BjeUdH; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--xur.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-64c3f08ca52so43794417b3.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 13:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722198663; x=1722803463; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tokg3sFCTTXy/Tg/kyuYTkBel/otDfHpuf9TI5sSKRc=;
        b=f6BjeUdHR36Kg9BILRErBF2TT4LyUUUeWe/2pIZ5RJ+8bUz3/NbWjd66ppYH8KLMcg
         wybYF/uZjne3GMXh1E+X1zAYra/WCpKEUBjZOVjjzz0/kOx4veBmncDp4c0wvtTsPXg5
         Q7gXKDwUc91Ffz70gcy8siG+Z0Z8BHkr4mNeJMykTEEKau1hFbkhlp/9cmPjSSyWsQTe
         MpRwuxKr7a7JOtgdouDxBAK4YVsVaopo8toXBrxqtqBLzkmJ/gJ/volGOdGKRdngDgrw
         IAbShFBlEXNFgyUQgorAI/NfrnUVubUQo28Ed5qPYkmr/8FVyRU0slQDy9KU844a+4q/
         YX4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722198663; x=1722803463;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tokg3sFCTTXy/Tg/kyuYTkBel/otDfHpuf9TI5sSKRc=;
        b=h+/jHpg3pXF4bmiV06RO/ZwFCD8PITMDwSRTdj7xV73LQ3QMuTq0u2Bxm6RhyEQRJC
         ljhBTbz2K+SF/+SFn5dpG/ChzlJ9fMx5rmT5vD7fiTVH0Q7+VXSG7GwPsQnURgikdruZ
         HKnbvWnM811M4VQr994JZ+6ivG1S4UfhZWs9jBbIO2HiAUT9cSKIyHyEkhCZ4mKpCpeb
         xzaGuq17dutT3yU0AulRiZ/526f3ki08GaVml9knLv35euYQtOokbkWFaVFq1WJHKllW
         /0LG5+EpBt4SHz3cICycd415RDJAB6VUd2gmasY7v3d7lx3U7dOXU3v6hQcxd2rIz1/e
         Dmyg==
X-Forwarded-Encrypted: i=1; AJvYcCWItpbVMKdZVAuM0NzpX5WmN+UtjAISqZuk9YKBwIbSmADEpEZzL0Y48wg5SinkaQokFyLSANU8faury9u+j7JaX3qTzJmcDBwSu8qM
X-Gm-Message-State: AOJu0YwSuIBaBWLDl5GRAzHBUeZ3bu0IFei4JMwU5NEqqYwoVLc7s6gu
	SNmrpuOMwVdikK26hDlaUVB3B/TbWg3aJ7ae9KdrIpCR3b15IEdDw1anemyJST5Ikw==
X-Google-Smtp-Source: AGHT+IGFJCBpCGKio3GvIQMtPQU0FwuQLnvFXOWRFKgHtvK/N12utXtZSpDgbRkZ6jpM9dmXhNWYM7k=
X-Received: from xur.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2330])
 (user=xur job=sendgmr) by 2002:a05:690c:827:b0:667:8a45:d0f9 with SMTP id
 00721157ae682-67a004a2775mr1250767b3.0.1722198663143; Sun, 28 Jul 2024
 13:31:03 -0700 (PDT)
Date: Sun, 28 Jul 2024 13:29:58 -0700
In-Reply-To: <20240728203001.2551083-1-xur@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240728203001.2551083-1-xur@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240728203001.2551083-6-xur@google.com>
Subject: [PATCH 5/6] AutoFDO: Enable machine function split optimization for AutoFDO
From: Rong Xu <xur@google.com>
To: Rong Xu <xur@google.com>, Han Shen <shenhan@google.com>, 
	Sriraman Tallam <tmsriram@google.com>, David Li <davidxl@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Vegard Nossum <vegard.nossum@oracle.com>, 
	John Moon <john@jmoon.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Samuel Holland <samuel.holland@sifive.com>, Mike Rapoport <rppt@kernel.org>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Rafael Aquini <aquini@redhat.com>, Petr Pavlu <petr.pavlu@suse.com>, 
	Eric DeVolder <eric.devolder@oracle.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Benjamin Segall <bsegall@google.com>, 
	Breno Leitao <leitao@debian.org>, Wei Yang <richard.weiyang@gmail.com>, 
	Brian Gerst <brgerst@gmail.com>, Juergen Gross <jgross@suse.com>, 
	Palmer Dabbelt <palmer@rivosinc.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Kees Cook <kees@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Xiao Wang <xiao.w.wang@intel.com>, Jan Kiszka <jan.kiszka@siemens.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-arch@vger.kernel.org, llvm@lists.linux.dev, 
	Krzysztof Pszeniczny <kpszeniczny@google.com>
Content-Type: text/plain; charset="UTF-8"

Enable the machine function split optimization for AutoFDO in Clang.

Machine function split (MFS) is a pass in the Clang compiler that
splits a function into hot and cold parts. The linker groups all
cold blocks across functions together. This decreases hot code
fragmentation and improves iCache and iTLB utilization.

MFS requires a profile so this is enabled only for the AutoFDO builds.

Co-developed-by: Han Shen <shenhan@google.com>
Signed-off-by: Han Shen <shenhan@google.com>
Signed-off-by: Rong Xu <xur@google.com>
Suggested-by: Sriraman Tallam <tmsriram@google.com>
Suggested-by: Krzysztof Pszeniczny <kpszeniczny@google.com>
---
 include/asm-generic/vmlinux.lds.h | 6 ++++++
 scripts/Makefile.autofdo          | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 97c8399e5532..7d9dc8a3c046 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -593,9 +593,14 @@ defined(CONFIG_AUTOFDO_CLANG)
 		__unlikely_text_start = .;				\
 		*(.text.unlikely .text.unlikely.*)			\
 		__unlikely_text_end = .;
+#define TEXT_SPLIT							\
+		__split_text_start = .;					\
+		*(.text.split .text.split.[0-9a-zA-Z_]*)		\
+		__split_text_end = .;
 #else
 #define TEXT_HOT *(.text.hot .text.hot.*)
 #define TEXT_UNLIKELY *(.text.unlikely .text.unlikely.*)
+#define TEXT_SPLIT
 #endif
 
 /*
@@ -611,6 +616,7 @@ defined(CONFIG_AUTOFDO_CLANG)
 #define TEXT_TEXT							\
 		*(.text.asan.* .text.tsan.*)				\
 		*(.text.unknown .text.unknown.*)			\
+		TEXT_SPLIT						\
 		TEXT_UNLIKELY						\
 		ALIGN_FUNCTION();					\
 		TEXT_HOT						\
diff --git a/scripts/Makefile.autofdo b/scripts/Makefile.autofdo
index f765bd9e81d7..80ad06689947 100644
--- a/scripts/Makefile.autofdo
+++ b/scripts/Makefile.autofdo
@@ -6,6 +6,7 @@ CFLAGS_AUTOFDO_CLANG := -fdebug-info-for-profiling -mllvm -enable-fs-discriminat
 
 ifdef CLANG_AUTOFDO_PROFILE
 CFLAGS_AUTOFDO_CLANG += -fprofile-sample-use=$(CLANG_AUTOFDO_PROFILE) -ffunction-sections
+CFLAGS_AUTOFDO_CLANG += -fsplit-machine-functions
 endif
 
 ifdef CONFIG_LTO_CLANG
@@ -14,6 +15,7 @@ ifdef CLANG_AUTOFDO_PROFILE
 KBUILD_LDFLAGS += --lto-sample-profile=$(CLANG_AUTOFDO_PROFILE)
 endif
 KBUILD_LDFLAGS += --mllvm=-enable-fs-discriminator=true --mllvm=-improved-fs-discriminator=true -plugin-opt=thinlto
+KBUILD_LDFLAGS += -plugin-opt=-split-machine-functions
 endif
 endif
 
-- 
2.46.0.rc1.232.g9752f9e123-goog


