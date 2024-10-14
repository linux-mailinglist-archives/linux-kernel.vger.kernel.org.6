Return-Path: <linux-kernel+bounces-364074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 850F199CAD5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 14:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45E5E281237
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 12:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071301AA7BC;
	Mon, 14 Oct 2024 12:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ocQweulr"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7AA1AA790
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 12:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728910637; cv=none; b=E+B+WEH8cjHx4aFZ9/jLftUKH6LH4JvzoCiKfT0iuGNhUFFm1wSGCP+8jpUQHW7vIzfU04+QBa1clfzQY/LJ1TQysHTJN9BOAn+lWyGJ9810grGLrzN+wls9gS7kU54HzzD8twgR1J8eImlpzFbcr6W1JsvCw7rcvH9eXbFYVIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728910637; c=relaxed/simple;
	bh=Y9/b/wtZYRsm/vDiOxMweK3dyx0nHcdUNMyHEeTnqgA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eoi3vOc2nAPjC71AljOxEWdfR4EyrxzBwAop82IQEARhvlm4+nMPn39f+W1mQLt1YKHOqYwO/mfm7kEv96lliXd4hEdyVYRokX22Zjc99cQa3CqGmSUdPlbq6+vlH6uFhHJ/iJBMN2K9ljjMiywCSYDucBrVzn1t0lIE+ZhGp3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ocQweulr; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e290222fde4so4607773276.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 05:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728910635; x=1729515435; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jr6gvJaG1W/UpmtkFcAoLuQg+5nDfK5k6tZ9Bo4jz64=;
        b=ocQweulrEcv8u2UdpI4qBkolFGNQq2FpEyZ9hZPQTs6WOirmtzdBg26QfHKV0KYypi
         szThnyLaPrv+fJmaYRbRBfzCoGyWIT94p0/vuNwD3zDrBS4CJ7N0xMOlDsH6MYAEu/X8
         1C+dnBsG8xoQKQSPzLVUlxAUuO8RqbdEGZYcaxTrUBouKFZHXP2Wiw3v++rQTTF0zf5h
         MCCqgHi10fHJiImQB3wNjYY9FYJo6DtXjjsP0LnclT1UW4b23lrUGJYXrPrewo5ZRqP8
         ysK4f3w4V+PNR1KCpG0SXukuSAIjr0LsWcIQDKnGLepfBkaxXjaUjN8ei+WwA7l/xR7j
         TdUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728910635; x=1729515435;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jr6gvJaG1W/UpmtkFcAoLuQg+5nDfK5k6tZ9Bo4jz64=;
        b=VEOKv5ycC5MlrE+h2JImxr+ouNgl2MkLoWOdeFXaAOSdDnUHonqsp4QMzi/zsbCvQx
         lyBtroADA1BpPIc9/dkvJ1rSsTF3x2hlDC4VJPERSlo4CchRSvytWx5CpTF1mf9hG4Ak
         HDX01CUBTMfiUh6fj1LNOfL3+x206xINIKPWr8gpkiLl1tWPOHcdvF9dEaawY+z/Zj+J
         tumPnGt5dwzQsQ1Bd8/JQSDyzsLCOhsfDf4oo3mNobu/CInCDkBtFUqJjw45rY9USOeP
         TZsRP3UV1IH6U5xrbWLBPwzpcO9RXHtubmdmzuNdVNjMXq5HLHuw4xyMmVW1knWTI/dz
         ynjg==
X-Gm-Message-State: AOJu0YwCcKA+MpWFGNhRs3k3lZeECbmNgNFrZl0lyQxdDNlYtccRAd7U
	cfJKgHrRxGX3X+AJB6RRK4sJh79RvUhmBYrzs7XJ0wr7ZvzSQWa2H7o2aU8jGhxDRhK6BjeQjc/
	QBSollTMYKy+LeQXH7x7v4wd4KLBeS3TPVNTdHQ7B0RsLxSmkeXEytYIoAbv1lg7WIcpdRrP+B2
	Tqn0SzWYlmFob6rYicJWm64XVp9nxGXg==
X-Google-Smtp-Source: AGHT+IEqZs2ag5HAsjw3w4ECPuvmKzmJ37fRfQ+HNG7wdnrxnT87LnWCSThnt7WZIiUCd09hr/MntVqv
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a25:9cc3:0:b0:e28:f1e8:6596 with SMTP id
 3f1490d57ef6-e2919d523eemr60405276.1.1728910634152; Mon, 14 Oct 2024 05:57:14
 -0700 (PDT)
Date: Mon, 14 Oct 2024 14:57:06 +0200
In-Reply-To: <20241014125703.2287936-4-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241014125703.2287936-4-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3929; i=ardb@kernel.org;
 h=from:subject; bh=XLQa+AmTzeuAR0O/nY3+iU4kWyjdOKPiaa9Oa0UT+Zo=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZ1XVPHlsnWbD98/su/dP/0/+j+yM89MPCgYbRZx6Vlc3
 Kze4Ev/OkpZGMQ4GGTFFFkEZv99t/P0RKla51myMHNYmUCGMHBxCsBEzOoYGX6YbYn+c8Bj/zI+
 9SddFwx59numHtmzpUlw8Y7dAceS/+xm+O/4RWHR6eO8juWFT38urWL+2Hi7LvHC398yx8w6NZf uNuUGAA==
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241014125703.2287936-6-ardb+git@google.com>
Subject: [PATCH 2/2] runtime-const: Use dot prefix for section names
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Sections typically use leading dots in their names, and deviating from
this breaks some assumptions in the existing code, e.g., in strip_relocs
on x86, as the linker prepends .rela to the section names when emitting
static relocations.

  [59] .relaruntime_ptr_dentry_hashtable RELA            0000000000000000 792c758 000078 18   I 56  38  8
  [60] .relaruntime_shift_d_hash_shift RELA            0000000000000000 792c7d0 000078 18   I 56  37  8

So use a leading dot for the runtime const sections.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/runtime-const.h | 4 ++--
 arch/s390/include/asm/runtime-const.h  | 4 ++--
 arch/x86/include/asm/runtime-const.h   | 4 ++--
 include/asm-generic/vmlinux.lds.h      | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/runtime-const.h b/arch/arm64/include/asm/runtime-const.h
index be5915669d23..2c3521765cfe 100644
--- a/arch/arm64/include/asm/runtime-const.h
+++ b/arch/arm64/include/asm/runtime-const.h
@@ -14,7 +14,7 @@
 		"movk %0, #0x89ab, lsl #16\n\t"			\
 		"movk %0, #0x4567, lsl #32\n\t"			\
 		"movk %0, #0x0123, lsl #48\n\t"			\
-		".pushsection runtime_ptr_" #sym ",\"a\"\n\t"	\
+		".pushsection .runtime_ptr_" #sym ",\"a\"\n\t"	\
 		".long 1b - .\n\t"				\
 		".popsection"					\
 		:"=r" (__ret));					\
@@ -24,7 +24,7 @@
 	unsigned long __ret;					\
 	asm_inline("1:\t"					\
 		"lsr %w0,%w1,#12\n\t"				\
-		".pushsection runtime_shift_" #sym ",\"a\"\n\t"	\
+		".pushsection .runtime_shift_" #sym ",\"a\"\n\t"\
 		".long 1b - .\n\t"				\
 		".popsection"					\
 		:"=r" (__ret)					\
diff --git a/arch/s390/include/asm/runtime-const.h b/arch/s390/include/asm/runtime-const.h
index 17878b1d048c..d19f54567d48 100644
--- a/arch/s390/include/asm/runtime-const.h
+++ b/arch/s390/include/asm/runtime-const.h
@@ -11,7 +11,7 @@
 	asm_inline(						\
 		"0:	iihf	%[__ret],%[c1]\n"		\
 		"	iilf	%[__ret],%[c2]\n"		\
-		".pushsection runtime_ptr_" #sym ",\"a\"\n"	\
+		".pushsection .runtime_ptr_" #sym ",\"a\"\n"	\
 		".long 0b - .\n"				\
 		".popsection"					\
 		: [__ret] "=d" (__ret)				\
@@ -26,7 +26,7 @@
 								\
 	asm_inline(						\
 		"0:	srl	%[__ret],12\n"			\
-		".pushsection runtime_shift_" #sym ",\"a\"\n"	\
+		".pushsection .runtime_shift_" #sym ",\"a\"\n"	\
 		".long 0b - .\n"				\
 		".popsection"					\
 		: [__ret] "+d" (__ret));			\
diff --git a/arch/x86/include/asm/runtime-const.h b/arch/x86/include/asm/runtime-const.h
index 24e3a53ca255..0de5a40ee6d0 100644
--- a/arch/x86/include/asm/runtime-const.h
+++ b/arch/x86/include/asm/runtime-const.h
@@ -5,7 +5,7 @@
 #define runtime_const_ptr(sym) ({				\
 	typeof(sym) __ret;					\
 	asm_inline("mov %1,%0\n1:\n"				\
-		".pushsection runtime_ptr_" #sym ",\"a\"\n\t"	\
+		".pushsection .runtime_ptr_" #sym ",\"a\"\n\t"	\
 		".long 1b - %c2 - .\n\t"			\
 		".popsection"					\
 		:"=r" (__ret)					\
@@ -19,7 +19,7 @@
 #define runtime_const_shift_right_32(val, sym) ({		\
 	typeof(0u+(val)) __ret = (val);				\
 	asm_inline("shrl $12,%k0\n1:\n"				\
-		".pushsection runtime_shift_" #sym ",\"a\"\n\t"	\
+		".pushsection .runtime_shift_" #sym ",\"a\"\n\t"\
 		".long 1b - 1 - .\n\t"				\
 		".popsection"					\
 		:"+r" (__ret));					\
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index eeadbaeccf88..da097ba2d4d8 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -914,8 +914,8 @@
 
 #define NAMED_SECTION(name) \
 	. = ALIGN(8); \
-	name : AT(ADDR(name) - LOAD_OFFSET) \
-	{ BOUNDED_SECTION_PRE_LABEL(name, name, __start_, __stop_) }
+	. ## name : AT(ADDR(. ## name) - LOAD_OFFSET) \
+	{ BOUNDED_SECTION_PRE_LABEL(. ## name, name, __start_, __stop_) }
 
 #define RUNTIME_CONST(t,x) NAMED_SECTION(runtime_##t##_##x)
 
-- 
2.47.0.rc1.288.g06298d1525-goog


