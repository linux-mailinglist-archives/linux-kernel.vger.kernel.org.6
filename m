Return-Path: <linux-kernel+bounces-419010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A589D687E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 10:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F15A7B21224
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 09:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39A718B467;
	Sat, 23 Nov 2024 09:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OixYiWnu"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A92618A6B8
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 09:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732355269; cv=none; b=fG0XKf64M/Ca2a1WtuewWYmsjJtZebRlwNFiJaMAzFrLOTT1zliyUBuzmJEkrtCARPW63ZeXfBCyX1O/IEtqIi+CoS23O4bFpz83WjkqnsiSLs9KdUnxrY2SqpHmlbCVtoWtDusm/BImUlSzc/xcs5cshVsSqGxaHe68YXOSH4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732355269; c=relaxed/simple;
	bh=/weL+RHxYRT2sc4snfesaJ/PKodr3pweOq0UKMGWplk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l6iD19U3iUkiO6XuSO8ctCFgfc9brkGCIWBt/eQklfpqcByXu0c5rrDxuQQFFDCfna6gN4XeVTVnSE1Ycfdfx5ukUVy7or/yP+ar56n0/Z1AuL3RYlE0EWt9dQGqjjXHZUK8aI2PSA9ulxD3kdj9MKWgBHePDvxigIKxL9gVoCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OixYiWnu; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5cfa90e04c2so3217372a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 01:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732355265; x=1732960065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QNBz0MU3962msQGvdaa4ePqZV5jTJbWC+jhpcScGK1I=;
        b=OixYiWnuEg+YH0AX/ROCCx3uAtgLmZyhsh3LMi5gCSXuKhknlzmQ2XDrQLJO35E3l/
         ifP0LOdizw3IeUJhT+a/Ai5yhg+ttqlKUxkdyzrFYh/O5fZngzeR+rbxtF7enRvReu3Q
         V2HqzHoRmtLtxUXi45T4P1nMGullz5PiCnS3kNwO0hSuKzHiQKCr0pjIh6hXhLET62db
         kvyMNkPrsdg3APoMuLfZ5tX7IjHzT4PNhMF1cEjsawoWkHR61Bd5VG/5DGiEHwTonrEK
         uCVIdraEGcZKQd+e/C/ScW029dLE0AObeR8wlFpb3oEm5bE3G/8fLKVw97ht3NkwXqPQ
         1lIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732355265; x=1732960065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QNBz0MU3962msQGvdaa4ePqZV5jTJbWC+jhpcScGK1I=;
        b=t99dciaSeV9VhcXI4wsEaKdq1nF0gKy4chqM8fRSbsjlYjF6jQvCh4JV0IgaCOb9Iv
         X3UYUYMw1H/hhZKnhOKRP3I8qiUo+z4dRwHvuroqXYO8ssZ1z5pncPLWzgIqIp6BtyfS
         cuRtOXeih8jZcTzoEQVm3BG+GCKhklhAkqJhp4w2iiuZYMYrSUCS0LiUtTS+lUofRhFn
         bTXzZTHfMdmntVdVfJLdF7IRzvwTiZwXzP7Cz0RJw/8eqZr+Z7aZ3YLecYdVONsQ1inY
         OC0mgACQ6s9YiueQLF367MVK/wJ0pCdyrDbWBt/kwmRk0zupwR/StKUs3Vh/tAjfSXLi
         L4sw==
X-Gm-Message-State: AOJu0YxZxrMaoW0wQ+vEoZiMjhW+/EUQSOFdwcXy9sTlC5LmDPIq30G0
	tNuftUiA3hVHqoMld3rfm52DzIMzCgv2qA8VKJUFwN0k+49mdB9W
X-Gm-Gg: ASbGncvRT+KtIFodYgmvr3Npk1u4LBrXL/nD2ivK3fbO9M3xxZ905Rsh2ncp2Tx+IB/
	zyZyQc5Z59BKQ1mNB3VTW4lLoDTrAw3hfX9ZPWSerwmBSAGLuw3u0DaXKNexnIf3C7+HgsoN0M5
	hBDRRHiEZ0+QfSgqSVtD9GxMxWITSQE8GN8AIyNBeH390wo9oEtmJAjCiEhkRMrg1bOgTAEtXGf
	IccDlS3jgN2W1ixeJfaFRjzxklBHKG/ovRBrRdOWmj/7mBlhcZQVvWRO+L0cpQw+Q==
X-Google-Smtp-Source: AGHT+IG44IU6wFCJFK+Qg05WJ38hwIHfPCaheO1jvBiDGmynuqeMQ3Cp8+11X6SHlYc2OCdlF5/WaA==
X-Received: by 2002:a05:6402:35c8:b0:5cf:d8aa:3f14 with SMTP id 4fb4d7f45d1cf-5d0207929camr4471223a12.22.1732355265301;
        Sat, 23 Nov 2024 01:47:45 -0800 (PST)
Received: from f.. (cst-prg-93-87.cust.vodafone.cz. [46.135.93.87])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01d3c2294sm1817427a12.53.2024.11.23.01.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2024 01:47:44 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: tglx@linutronix.de,
	bp@alien8.de,
	andy@kernel.org,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 2/2] string: retire bcmp()
Date: Sat, 23 Nov 2024 10:47:29 +0100
Message-ID: <20241123094729.1099378-3-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241123094729.1099378-1-mjguzik@gmail.com>
References: <20241123094729.1099378-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While architectures could override it thanks to __HAVE_ARCH_BCMP, none
of them did. Instead it was implemented as a call to memcmp().

These routines differ in the API contract: memcmp()'s result indicates
which way the difference goes (making it usable for sorting), whereas
bcmp()'s result merely states whether the buffers differ in any way.

This means that a dedicated optimized bcmp() is cheaper to execute than
memcmp() for differing buffers as there is no need to compute the return
value.

However, per the above nobody bothered to write one and it is unclear if
it makes sense to do it.

Users which really want to compare stuff may want to handle it
differently (like e.g., the path lookup).

As there are no users and the code is merely a wrapper around memcmp(),
just whack it.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 arch/x86/boot/string.c |  8 --------
 arch/x86/boot/string.h |  1 -
 include/linux/string.h |  3 ---
 lib/Makefile           |  3 +--
 lib/string.c           | 19 -------------------
 5 files changed, 1 insertion(+), 33 deletions(-)

diff --git a/arch/x86/boot/string.c b/arch/x86/boot/string.c
index c23f3b9c84fe..e8095abf03df 100644
--- a/arch/x86/boot/string.c
+++ b/arch/x86/boot/string.c
@@ -37,14 +37,6 @@ int memcmp(const void *s1, const void *s2, size_t len)
 	return diff;
 }
 
-/*
- * Clang may lower `memcmp == 0` to `bcmp == 0`.
- */
-int bcmp(const void *s1, const void *s2, size_t len)
-{
-	return memcmp(s1, s2, len);
-}
-
 int strcmp(const char *str1, const char *str2)
 {
 	const unsigned char *s1 = (const unsigned char *)str1;
diff --git a/arch/x86/boot/string.h b/arch/x86/boot/string.h
index e5d2c6b8c2f1..cf83faee78cc 100644
--- a/arch/x86/boot/string.h
+++ b/arch/x86/boot/string.h
@@ -11,7 +11,6 @@ void *memcpy(void *dst, const void *src, size_t len);
 void *memmove(void *dst, const void *src, size_t len);
 void *memset(void *dst, int c, size_t len);
 int memcmp(const void *s1, const void *s2, size_t len);
-int bcmp(const void *s1, const void *s2, size_t len);
 
 /* Access builtin version by default. */
 #define memcpy(d,s,l) __builtin_memcpy(d,s,l)
diff --git a/include/linux/string.h b/include/linux/string.h
index 0dd27afcfaf7..d4904951b627 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -267,9 +267,6 @@ extern void * memscan(void *,int,__kernel_size_t);
 #ifndef __HAVE_ARCH_MEMCMP
 extern int memcmp(const void *,const void *,__kernel_size_t);
 #endif
-#ifndef __HAVE_ARCH_BCMP
-extern int bcmp(const void *,const void *,__kernel_size_t);
-#endif
 #ifndef __HAVE_ARCH_MEMCHR
 extern void * memchr(const void *,int,__kernel_size_t);
 #endif
diff --git a/lib/Makefile b/lib/Makefile
index 773adf88af41..c382b43fe37e 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -265,8 +265,7 @@ obj-$(CONFIG_IRQ_POLL) += irq_poll.o
 obj-$(CONFIG_POLYNOMIAL) += polynomial.o
 
 # stackdepot.c should not be instrumented or call instrumented functions.
-# Prevent the compiler from calling builtins like memcmp() or bcmp() from this
-# file.
+# Prevent the compiler from calling builtins like memcmp() from this file.
 CFLAGS_stackdepot.o += -fno-builtin
 obj-$(CONFIG_STACKDEPOT) += stackdepot.o
 KASAN_SANITIZE_stackdepot.o := n
diff --git a/lib/string.c b/lib/string.c
index 76327b51e36f..3a319d1c5aae 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -680,25 +680,6 @@ __visible int memcmp(const void *cs, const void *ct, size_t count)
 EXPORT_SYMBOL(memcmp);
 #endif
 
-#ifndef __HAVE_ARCH_BCMP
-/**
- * bcmp - returns 0 if and only if the buffers have identical contents.
- * @a: pointer to first buffer.
- * @b: pointer to second buffer.
- * @len: size of buffers.
- *
- * The sign or magnitude of a non-zero return value has no particular
- * meaning, and architectures may implement their own more efficient bcmp(). So
- * while this particular implementation is a simple (tail) call to memcmp, do
- * not rely on anything but whether the return value is zero or non-zero.
- */
-int bcmp(const void *a, const void *b, size_t len)
-{
-	return memcmp(a, b, len);
-}
-EXPORT_SYMBOL(bcmp);
-#endif
-
 #ifndef __HAVE_ARCH_MEMSCAN
 /**
  * memscan - Find a character in an area of memory.
-- 
2.43.0


