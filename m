Return-Path: <linux-kernel+bounces-300205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9099C95E059
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 01:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11A8C1F21E4B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 23:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905521448F6;
	Sat, 24 Aug 2024 23:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=illinois-edu.20230601.gappssmtp.com header.i=@illinois-edu.20230601.gappssmtp.com header.b="NnKogAAV"
Received: from mail-io1-f66.google.com (mail-io1-f66.google.com [209.85.166.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9A014533E
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 23:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724540854; cv=none; b=ibLgC86J60b/dyOlDrtpJd1pR76cYfDfVii4ZN3OqZmyUWIcDXF1uHembv1QEnmmD1v87mYnpvxRuvVQO8EoPEC8zh/1xYr2gqKHxHbeZAMv9ErIuj/CtqsiDGyTyGmPRQwzzBQ8wPudRL6q9xVS2OQzbMm7Q6q96fH7215X9W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724540854; c=relaxed/simple;
	bh=y7rZxTKpyl0JwzsBx4Lq7x9Sp+C4O7QrJbTBCbHGnoU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uxQhW3M7XP717yzVD2AQjiyiUvzHlX6neFIvwRpRGZOxW2wYqVm/tUovuJ5s9Xoi4cF5hl+uDImqo6fI/iOrlyq+KvFv2P/MHpM/KlylE18zUUp6KYZPO1hfL3fRW2dnklamu+1xiWSLIGiyFMNG/TL2JnDtoMkHPgUn/Y2e8mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu; spf=pass smtp.mailfrom=illinois.edu; dkim=pass (2048-bit key) header.d=illinois-edu.20230601.gappssmtp.com header.i=@illinois-edu.20230601.gappssmtp.com header.b=NnKogAAV; arc=none smtp.client-ip=209.85.166.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=illinois.edu
Received: by mail-io1-f66.google.com with SMTP id ca18e2360f4ac-81f921c40f2so116373839f.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 16:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=illinois-edu.20230601.gappssmtp.com; s=20230601; t=1724540852; x=1725145652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pI1ahIsPt9dhXQGKmSRkAPO4yB+V9yLk9R0g7YeqYis=;
        b=NnKogAAVgsa4Frhgb3ibrJ4dLtjjzNajsG5zsyO0jpTii+SrxAAUR3BhuB/3VwSCsW
         em5Kg6MG7JfMk0zHCDNGCcR/+LGYMhWN3e8BpHrP7UlHMWIAX42BOn2L5+2HJMKOZxcn
         8z1lPsawUQ8O2U8zPzJ3T50H64Dn/svAKY9IotUi4t71SfN7Ya+jzHpxG+n8cakluBEJ
         ZIHoN3sUJFqrFuPabV/tnocDYLpTDlTs0tFtpy4EjvVuvR3AN+svR/GMqHGJWGBC/SG/
         YeuZaJfwP05r+O7T+t/cg2zi00ihGrbEYaKc8aIVBTQXxy6jBDFsPFxriXKw6w9H9LTR
         i4XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724540852; x=1725145652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pI1ahIsPt9dhXQGKmSRkAPO4yB+V9yLk9R0g7YeqYis=;
        b=jSlyt8/RywjRM2TXWryOd1Dh9skFbrn8mXLKnNO5uB8pHZb+iaIif0ILRX+rwiQ2zD
         XHFYPX7Pv7INLw3DxiwTQrb9WBCncs3FebKdSjcZumD3YhHkwCYGsQnoIqyKEetaJR1o
         qbyXf6gTfqqZaEdyziTIqrv8grgaS1exhEe43zAjLnoE77xx1feqZnI9s46MjIbSRxcX
         uEaAWxxyhmDHtmnn6Y0hd5+CU723+CUA1XMjw8VJPfAE3Mhzz2Tz3mb69T3r93xEJxuC
         xiB/s5EPMnGir6Oo2D77hkfuM26ZrCK1m9sfmZzsqQQdOgrIAD+xXnuCR07Fy8Db2RLs
         4qGg==
X-Forwarded-Encrypted: i=1; AJvYcCWTrxe/faDN/9roH/S4mFoet8MRY5otUV9dDbDpwIuGnVjTfCPCXdTKNMLZBay38o3eNEm8V+4/r5i3vAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB2yacFwzJm8e5WWcr7od0mQDuYPLLcWc8u0JFlJ2XBXmCQvW2
	I9Rw5P7EzRXyzYadq6zcltmkU036J7NIhNxZ6WRqn8nCfcXXI+V2gNUPipLqJw==
X-Google-Smtp-Source: AGHT+IFl2rO8s4tG2IK/76OuZILBkQM0bjWjC93REDF+iiyuiQbUEz5yxBnC5GLBkdA4N6JUhLkQxw==
X-Received: by 2002:a05:6602:6103:b0:825:2f0:9f74 with SMTP id ca18e2360f4ac-8278739c0famr756294039f.16.1724540852172;
        Sat, 24 Aug 2024 16:07:32 -0700 (PDT)
Received: from shizuku.. (mobile-130-126-255-62.near.illinois.edu. [130.126.255.62])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ce70f85671sm1563938173.80.2024.08.24.16.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2024 16:07:31 -0700 (PDT)
From: Wentao Zhang <wentaoz5@illinois.edu>
To: linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-arch@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	x86@kernel.org
Cc: wentaoz5@illinois.edu,
	marinov@illinois.edu,
	tyxu@illinois.edu,
	jinghao7@illinois.edu,
	tingxur@illinois.edu,
	steven.h.vanderleest@boeing.com,
	chuck.wolber@boeing.com,
	matthew.l.weber3@boeing.com,
	Matt.Kelly2@boeing.com,
	andrew.j.oppelt@boeing.com,
	samuel.sarkisian@boeing.com,
	morbo@google.com,
	samitolvanen@google.com,
	masahiroy@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	ardb@kernel.org,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	arnd@arndb.de,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	oberpar@linux.ibm.com,
	akpm@linux-foundation.org,
	paulmck@kernel.org,
	bhelgaas@google.com,
	kees@kernel.org,
	jpoimboe@kernel.org,
	peterz@infradead.org,
	kent.overstreet@linux.dev,
	nathan@kernel.org,
	hpa@zytor.com,
	mathieu.desnoyers@efficios.com,
	ndesaulniers@google.com,
	justinstitt@google.com,
	maskray@google.com,
	dvyukov@google.com
Subject: [RFC PATCH 3/3] llvm-cov: add Clang's MC/DC support
Date: Sat, 24 Aug 2024 18:06:41 -0500
Message-Id: <20240824230641.385839-4-wentaoz5@illinois.edu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240824230641.385839-1-wentaoz5@illinois.edu>
References: <20240824230641.385839-1-wentaoz5@illinois.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Clang flags and kconfig options for measuring the kernel's modified
condition/decision coverage (MC/DC).

As of Clang 19, users can determine the max number of conditions in a
decision to measure via option LLVM_COV_KERNEL_MCDC_MAX_CONDITIONS,
which controls -fmcdc-max-conditions flag of Clang cc1 [1]. Since MC/DC
implementation utilizes bitmaps to track the execution of test vectors,
more memory is consumed if larger decisions are getting counted. The
maximum value supported by Clang is 32767. According to local
experiments, the working maximum for Linux kernel is 44, with the
largest decisions in kernel codebase (with 45 conditions) excluded,
otherwise the kernel image size limit will be exceeded. The largest
decisions in kernel are contributed for example by macros checking
CPUID.

Code exceeding LLVM_COV_KERNEL_MCDC_MAX_CONDITIONS will produce compiler
warnings.

As of LLVM 19, certain expressions are still not covered, and will produce
build warnings when they are encountered:

"[...] if a boolean expression is embedded in the nest of another boolean
 expression but separated by a non-logical operator, this is also not
 supported. For example, in x = (a && b && c && func(d && f)), the d && f
 case starts a new boolean expression that is separated from the other
 conditions by the operator func(). When this is encountered, a warning
 will be generated and the boolean expression will not be
 instrumented." [2]

[1] https://discourse.llvm.org/t/rfc-coverage-new-algorithm-and-file-format-for-mc-dc/76798
[2] https://clang.llvm.org/docs/SourceBasedCodeCoverage.html#mc-dc-instrumentation

Signed-off-by: Wentao Zhang <wentaoz5@illinois.edu>
Signed-off-by: Chuck Wolber <chuck.wolber@boeing.com>
---
 Makefile                |  6 ++++++
 kernel/llvm-cov/Kconfig | 36 ++++++++++++++++++++++++++++++++++++
 scripts/Makefile.lib    | 11 +++++++++++
 3 files changed, 53 insertions(+)

diff --git a/Makefile b/Makefile
index 1750a2b7dfe8..4aa263e5f67f 100644
--- a/Makefile
+++ b/Makefile
@@ -740,6 +740,12 @@ all: vmlinux
 CFLAGS_LLVM_COV := -fprofile-instr-generate -fcoverage-mapping
 export CFLAGS_LLVM_COV
 
+CFLAGS_LLVM_COV_MCDC := -fcoverage-mcdc
+ifdef CONFIG_LLVM_COV_KERNEL_MCDC_MAX_CONDITIONS
+CFLAGS_LLVM_COV_MCDC += -Xclang -fmcdc-max-conditions=$(CONFIG_LLVM_COV_KERNEL_MCDC_MAX_CONDITIONS)
+endif
+export CFLAGS_LLVM_COV_MCDC
+
 CFLAGS_GCOV	:= -fprofile-arcs -ftest-coverage
 ifdef CONFIG_CC_IS_GCC
 CFLAGS_GCOV	+= -fno-tree-loop-im
diff --git a/kernel/llvm-cov/Kconfig b/kernel/llvm-cov/Kconfig
index 505eba5bd23c..40b6a4fd590e 100644
--- a/kernel/llvm-cov/Kconfig
+++ b/kernel/llvm-cov/Kconfig
@@ -26,4 +26,40 @@ config LLVM_COV_KERNEL
 	  Note that the debugfs filesystem has to be mounted to access the raw
 	  profile.
 
+config LLVM_COV_KERNEL_MCDC
+	bool "Enable measuring modified condition/decision coverage (MC/DC)"
+	depends on LLVM_COV_KERNEL
+	depends on CLANG_VERSION >= 180000
+	help
+	  This option enables modified condition/decision coverage (MC/DC)
+	  code coverage instrumentation.
+
+	  If unsure, say N.
+
+	  This will add Clang's Source-based Code Coverage MC/DC
+	  instrumentation to your kernel. As of LLVM 19, certain expressions
+	  are still not covered, and will produce build warnings when they are
+	  encountered.
+
+	  "[...] if a boolean expression is embedded in the nest of another
+	   boolean expression but separated by a non-logical operator, this is
+	   also not supported. For example, in
+	   x = (a && b && c && func(d && f)), the d && f case starts a new
+	   boolean expression that is separated from the other conditions by the
+	   operator func(). When this is encountered, a warning will be
+	   generated and the boolean expression will not be instrumented."
+
+	   https://clang.llvm.org/docs/SourceBasedCodeCoverage.html#mc-dc-instrumentation
+
+config LLVM_COV_KERNEL_MCDC_MAX_CONDITIONS
+	int "Maximum number of conditions in a decision to instrument"
+	range 6 32767
+	depends on LLVM_COV_KERNEL_MCDC
+	depends on CLANG_VERSION >= 190000
+	default "6"
+	help
+	  This value is passed to "-fmcdc-max-conditions" flag of Clang cc1.
+	  Expressions whose number of conditions is greater than this value will
+	  produce warnings and will not be instrumented.
+
 endmenu
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index b9ceaee34b28..b8dfad01cb52 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -168,6 +168,17 @@ _c_flags += $(if $(patsubst n%,, \
 		$(CFLAGS_LLVM_COV))
 endif
 
+#
+# Flag that turns on modified condition/decision coverage (MC/DC) measurement
+# with Clang's Source-based Code Coverage. Enable the flag for a file or
+# directory depending on variables LLVM_COV_PROFILE_obj.o and LLVM_COV_PROFILE.
+#
+ifeq ($(CONFIG_LLVM_COV_KERNEL_MCDC),y)
+_c_flags += $(if $(patsubst n%,, \
+		$(LLVM_COV_PROFILE_$(basetarget).o)$(LLVM_COV_PROFILE)y), \
+		$(CFLAGS_LLVM_COV_MCDC))
+endif
+
 #
 # Enable address sanitizer flags for kernel except some files or directories
 # we don't want to check (depends on variables KASAN_SANITIZE_obj.o, KASAN_SANITIZE)
-- 
2.45.2


