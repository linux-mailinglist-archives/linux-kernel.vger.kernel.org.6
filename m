Return-Path: <linux-kernel+bounces-285570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3678950FD3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 00:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2710C1C219E8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 22:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9BF1AB506;
	Tue, 13 Aug 2024 22:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZG6A2Cxz"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075F916BE34
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 22:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723588841; cv=none; b=eOAUlSkeZP2qkeEwPev9Zvka82x1FgUgQrLYAGO4EDJLjiDnmVUCcXmdJrw/Gx8RVMC2oUOu4Uxl7ErfxP8mgZbmofFH2AUJCnranKUkeApUnWnVihVmyyIJyzqITGouLh1AddvbZE8k3pZdNP39Za5x5xkfvOtCUukkWUF5O+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723588841; c=relaxed/simple;
	bh=HFtufnLXcUm/aLnJLNF7pXmlfu91vt7rw8Zgg/bJBzI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f6YUTaM5TTh6WJrhrpGJll14bcNa02TrQUSV9OKsQ0mVwT35VTblIH/Mwy1U/KldqsJCV+8wKUpc+4Fueh66/5UreY+XWhNQK5qg5/Kx/7GTUUOy2ZF3XIL97nmPDF76XGhRTFvuZDhtaieEupNUZopIbobM8R5JuRm4YOECiZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZG6A2Cxz; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723588836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ROfZ7+FlItYIEY2a1H0ZOdv21L9gnBvePHx9MzL+ryA=;
	b=ZG6A2CxzyNqBWcnrUSisSO1zgP1W5vYO1OHHeRg0tYTRmKK70oBvGAA2oHJlw7k2P3b4uT
	nS9fgk0Yw2Ik8XAxY1DdctABZ5PCP7qxbhL75C8qMbp/H+srNwAtCDpDf84eRHZtOP5S4f
	T7nPHar1FHd6KTBRSe72lMMbe7wul+Y=
From: andrey.konovalov@linux.dev
To: Marco Elver <elver@google.com>,
	Matthew Maurer <mmaurer@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	kasan-dev@googlegroups.com,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	Miguel Ojeda <ojeda@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kasan: simplify and clarify Makefile
Date: Wed, 14 Aug 2024 00:40:27 +0200
Message-Id: <20240813224027.84503-1-andrey.konovalov@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Andrey Konovalov <andreyknvl@gmail.com>

When KASAN support was being added to the Linux kernel, GCC did not yet
support all of the KASAN-related compiler options. Thus, the KASAN
Makefile had to probe the compiler for supported options.

Nowadays, the Linux kernel GCC version requirement is 5.1+, and thus we
don't need the probing of the -fasan-shadow-offset parameter: it exists in
all 5.1+ GCCs.

Simplify the KASAN Makefile to drop CFLAGS_KASAN_MINIMAL.

Also add a few more comments and unify the indentation.

Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>
---
 scripts/Makefile.kasan | 43 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/scripts/Makefile.kasan b/scripts/Makefile.kasan
index 390658a2d5b74..04b108f311d24 100644
--- a/scripts/Makefile.kasan
+++ b/scripts/Makefile.kasan
@@ -22,30 +22,29 @@ endif
 ifdef CONFIG_KASAN_GENERIC
 
 ifdef CONFIG_KASAN_INLINE
+	# When the number of memory accesses in a function is less than this
+	# call threshold number, the compiler will use inline instrumentation.
+	# 10000 is chosen offhand as a sufficiently large number to make all
+	# kernel functions to be instrumented inline.
 	call_threshold := 10000
 else
 	call_threshold := 0
 endif
 
-CFLAGS_KASAN_MINIMAL := -fsanitize=kernel-address
-
-# -fasan-shadow-offset fails without -fsanitize
-CFLAGS_KASAN_SHADOW := $(call cc-option, -fsanitize=kernel-address \
-			-fasan-shadow-offset=$(KASAN_SHADOW_OFFSET), \
-			$(call cc-option, -fsanitize=kernel-address \
-			-mllvm -asan-mapping-offset=$(KASAN_SHADOW_OFFSET)))
-
-ifeq ($(strip $(CFLAGS_KASAN_SHADOW)),)
-	CFLAGS_KASAN := $(CFLAGS_KASAN_MINIMAL)
-else
-	# Now add all the compiler specific options that are valid standalone
-	CFLAGS_KASAN := $(CFLAGS_KASAN_SHADOW) \
-	 $(call cc-param,asan-globals=1) \
-	 $(call cc-param,asan-instrumentation-with-call-threshold=$(call_threshold)) \
-	 $(call cc-param,asan-instrument-allocas=1)
-endif
-
-CFLAGS_KASAN += $(call cc-param,asan-stack=$(stack_enable))
+# First, enable -fsanitize=kernel-address together with providing the shadow
+# mapping offset, as for GCC, -fasan-shadow-offset fails without -fsanitize
+# (GCC accepts the shadow mapping offset via -fasan-shadow-offset instead of
+# a normal --param). Instead of ifdef-checking the compiler, rely on cc-option.
+CFLAGS_KASAN := $(call cc-option, -fsanitize=kernel-address \
+		-fasan-shadow-offset=$(KASAN_SHADOW_OFFSET), \
+		$(call cc-option, -fsanitize=kernel-address \
+		-mllvm -asan-mapping-offset=$(KASAN_SHADOW_OFFSET)))
+
+# Now, add other parameters enabled in a similar way with GCC and Clang.
+CFLAGS_KASAN += $(call cc-param,asan-instrumentation-with-call-threshold=$(call_threshold)) \
+		$(call cc-param,asan-stack=$(stack_enable)) \
+		$(call cc-param,asan-instrument-allocas=1) \
+		$(call cc-param,asan-globals=1)
 
 # Instrument memcpy/memset/memmove calls by using instrumented __asan_mem*()
 # instead. With compilers that don't support this option, compiler-inserted
@@ -57,9 +56,9 @@ endif # CONFIG_KASAN_GENERIC
 ifdef CONFIG_KASAN_SW_TAGS
 
 ifdef CONFIG_KASAN_INLINE
-    instrumentation_flags := $(call cc-param,hwasan-mapping-offset=$(KASAN_SHADOW_OFFSET))
+	instrumentation_flags := $(call cc-param,hwasan-mapping-offset=$(KASAN_SHADOW_OFFSET))
 else
-    instrumentation_flags := $(call cc-param,hwasan-instrument-with-calls=1)
+	instrumentation_flags := $(call cc-param,hwasan-instrument-with-calls=1)
 endif
 
 CFLAGS_KASAN := -fsanitize=kernel-hwaddress \
@@ -70,7 +69,7 @@ CFLAGS_KASAN := -fsanitize=kernel-hwaddress \
 
 # Instrument memcpy/memset/memmove calls by using instrumented __hwasan_mem*().
 ifeq ($(call clang-min-version, 150000)$(call gcc-min-version, 130000),y)
-CFLAGS_KASAN += $(call cc-param,hwasan-kernel-mem-intrinsic-prefix=1)
+	CFLAGS_KASAN += $(call cc-param,hwasan-kernel-mem-intrinsic-prefix=1)
 endif
 
 endif # CONFIG_KASAN_SW_TAGS
-- 
2.25.1


