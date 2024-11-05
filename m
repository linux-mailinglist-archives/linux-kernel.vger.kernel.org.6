Return-Path: <linux-kernel+bounces-396725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C86CF9BD146
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FCA21F22F0C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C452F17332C;
	Tue,  5 Nov 2024 15:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1D7eo1r"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9277F155758
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 15:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730822301; cv=none; b=T0dU21jKOwacg7mFG1oXpt9J83B0PeW8Dh1OqKTQ8H+8HGk8lQc6ARjJg3r4Q9S2xyfynsH5oaEeE9qkgg/OlEprBVZJpUPyTeJkD/Aj5L49jugp/5ShVTA1PimLKqStBM8koj2avDekx9Kn01rDmEebUaX/vy4mDQxEsn5tNM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730822301; c=relaxed/simple;
	bh=/0jvy4opjUK7nNzQpIuudVIb5O/dI4mApBK85ttWjrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Py7tF8KVCsQB/lGA9zLDjWkxufxNQeDAgSSBWxigj9bzKc8erod/80o0lwh1nQA5+VnAaHijvwM5/woZa8XqCMqxMWY4c0+5TlJEEz9DFjA7pFrzbzPnz4HTZ6Z9pPh4raI4OUcIz8WrnghsKMG1V7xNGmCJdSDuiuiaWCI+zu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P1D7eo1r; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b150dc7bc0so402515885a.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 07:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730822298; x=1731427098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+sNbSfN1SChlVpebOlxZ+5Kd3VmPuC24W4HBOzRBNg=;
        b=P1D7eo1rYsI8G6cRoEpHZUnOiok0hz3Gfqc6qEb7Wioh04BhjY6bo5tJZrD5UKQfGj
         tJl386jsQUS2kXRHDLJzcOKvhJ7aw4G1rJu/2tQkE4Wn3BxNUthE0tlcn3e7ekkEGSvA
         EXRfRFPXoqqHv/KegtY29Cvq2kUZtYgVv5EmVWM9tcCrS2ri2rRjF0guX/y6eRESXLJQ
         R9Kt9mNuEB8oSN0/rKmf80oXKEB/qmzxCG0CbWYLEaLi5kt/41ZyMC5CJ7CczkaC/Asu
         /G9qtcRFrMf3Pi/iGEeFXNnne5xjZlhTVaDBrnDTCbfNxwKdBQxVXiajwsKjDsT4X9Y3
         Q12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730822298; x=1731427098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I+sNbSfN1SChlVpebOlxZ+5Kd3VmPuC24W4HBOzRBNg=;
        b=jQ+Kx9DdBDFPI6a4dpjg9rZ1uMAvTe/Gpbv7ae0Y9Qt3xtSy9P6pdv9rtW0/oQKX+R
         c9s5fHIPVqo/VGDDzNpW/yr6nGDpVyoQi6v0hKKzsGuQl14kdLW8JpeBvIGJy375p/nJ
         sHYYT269GLgENHMMqZSVpuKpGdefKHHNpak06JOptCyOYixcOFWIpJN7uKiDiZ3ZZwEY
         faZNFV2y3WvCeTjNanyBkNATO1Y49lfoP8XN1PSJB6aHhm+fpwPq47PexdeuwR0ONPgR
         6a1q/0DoVEBe+nzA2wViqCREXEZY0M7IG9aSUI5fPuetJCe7Z7Yds36c7iV1Tfs22LU+
         LZsQ==
X-Gm-Message-State: AOJu0Yzw/Kgzsy4/uukRDncRp+ifRIg1H4a50yd6nW6zVDGF0Y24bnNf
	4K87/NoLINPtIU5uvOUhit8hH5G4oZjZ0r24G1gggomRO2BhriSopQAz
X-Google-Smtp-Source: AGHT+IF4SSNvaMqlS2cpgt71oC2HT/Sf8GceujAINQ8cBf6ufvg4L3ntBiyTMEsc1uSvfaDFCtVkMw==
X-Received: by 2002:a05:6214:338a:b0:6cc:2d3c:6472 with SMTP id 6a1803df08f44-6d35c0e9a48mr221799966d6.14.1730822298007;
        Tue, 05 Nov 2024 07:58:18 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d353fc6d07sm61710586d6.44.2024.11.05.07.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 07:58:17 -0800 (PST)
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
Subject: [PATCH v5 03/16] x86/stackprotector: Remove stack protector test scripts
Date: Tue,  5 Nov 2024 10:57:48 -0500
Message-ID: <20241105155801.1779119-4-brgerst@gmail.com>
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

With GCC 8.1 now the minimum supported compiler for x86, these scripts
are no longer needed.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/Kconfig                          | 11 +----------
 scripts/gcc-x86_32-has-stack-protector.sh |  8 --------
 scripts/gcc-x86_64-has-stack-protector.sh |  4 ----
 3 files changed, 1 insertion(+), 22 deletions(-)
 delete mode 100755 scripts/gcc-x86_32-has-stack-protector.sh
 delete mode 100755 scripts/gcc-x86_64-has-stack-protector.sh

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index aa7fac6817c5..45021d57fd9f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -278,7 +278,7 @@ config X86
 	select HAVE_FUNCTION_ARG_ACCESS_API
 	select HAVE_SETUP_PER_CPU_AREA
 	select HAVE_SOFTIRQ_ON_OWN_STACK
-	select HAVE_STACKPROTECTOR		if CC_HAS_SANE_STACKPROTECTOR
+	select HAVE_STACKPROTECTOR
 	select HAVE_STACK_VALIDATION		if HAVE_OBJTOOL
 	select HAVE_STATIC_CALL
 	select HAVE_STATIC_CALL_INLINE		if HAVE_OBJTOOL
@@ -418,15 +418,6 @@ config PGTABLE_LEVELS
 	default 3 if X86_PAE
 	default 2
 
-config CC_HAS_SANE_STACKPROTECTOR
-	bool
-	default $(success,$(srctree)/scripts/gcc-x86_64-has-stack-protector.sh $(CC) $(CLANG_FLAGS)) if 64BIT
-	default $(success,$(srctree)/scripts/gcc-x86_32-has-stack-protector.sh $(CC) $(CLANG_FLAGS))
-	help
-	  We have to make sure stack protector is unconditionally disabled if
-	  the compiler produces broken code or if it does not let us control
-	  the segment on 32-bit kernels.
-
 menu "Processor type and features"
 
 config SMP
diff --git a/scripts/gcc-x86_32-has-stack-protector.sh b/scripts/gcc-x86_32-has-stack-protector.sh
deleted file mode 100755
index 9459ca4f0f11..000000000000
--- a/scripts/gcc-x86_32-has-stack-protector.sh
+++ /dev/null
@@ -1,8 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-
-# This requires GCC 8.1 or better.  Specifically, we require
-# -mstack-protector-guard-reg, added by
-# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81708
-
-echo "int foo(void) { char X[200]; return 3; }" | $* -S -x c -m32 -O0 -fstack-protector -mstack-protector-guard-reg=fs -mstack-protector-guard-symbol=__stack_chk_guard - -o - 2> /dev/null | grep -q "%fs"
diff --git a/scripts/gcc-x86_64-has-stack-protector.sh b/scripts/gcc-x86_64-has-stack-protector.sh
deleted file mode 100755
index f680bb01aeeb..000000000000
--- a/scripts/gcc-x86_64-has-stack-protector.sh
+++ /dev/null
@@ -1,4 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-
-echo "int foo(void) { char X[200]; return 3; }" | $* -S -x c -m64 -O0 -mcmodel=kernel -fno-PIE -fstack-protector - -o - 2> /dev/null | grep -q "%gs"
-- 
2.47.0


