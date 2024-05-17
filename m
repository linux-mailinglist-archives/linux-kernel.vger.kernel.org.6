Return-Path: <linux-kernel+bounces-182128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 248008C86E7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 15:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA6191F24587
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 13:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0EB4F8A3;
	Fri, 17 May 2024 13:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="twrr19Ft"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595524EB36
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 13:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715950889; cv=none; b=ZCMKQiLWmmLmPfyK9yokN08NuAoHiEK0Uanp3WQnJQXuwPX9Zi/DcX8Sa1RKhDLftS8cz0sLSr47+xdibrXGdCUl3PhtBoBPopONXZCYR3HDPSLD75RnBjSzhWCKBlBHTKxI0qPxmwakgfo/4wgyRnuARE2FbfbOm242roEhpxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715950889; c=relaxed/simple;
	bh=XrfQQMZY/fsslR0RZ1eBc6qZG6NENlkA9f/21v9tMtk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mrJggKbEvNnCYRynW23tozLNi8BYHtCdKARivmdU+WgK30II8pQZdadLszaMBLyabNxIPjmovHy1yIX0l+zuJhq6bCX98xP1Mbh0AEpfiXmFbBqRZOHf7XdoVopoax+6fh5BbXbKnZX/enCw9DJe5VhH1XJwkS5jNn+Jl87tMeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=twrr19Ft; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: elver@google.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715950885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tyN60hwyyyZujQaT4M6CmN3OZiKg7vscoBXPblyi5YU=;
	b=twrr19FtZFJhnMK2v+2f28RrN946+7BrzNyj1S55GO3spUzE3hAx5r6VPCxP6XmssMJaKN
	Nk5CmJu1U7SA464VU/C/Q+JGY53nj/ySWvo5jyO5ydRoS5bscXhBoKXs5eX0yVPgshmw5z
	4SVvRcTTxUrv4QyUihstdKk1NTcXDgk=
X-Envelope-To: andreyknvl@gmail.com
X-Envelope-To: glider@google.com
X-Envelope-To: dvyukov@google.com
X-Envelope-To: ryabinin.a.a@gmail.com
X-Envelope-To: kasan-dev@googlegroups.com
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: erhard_f@mailbox.org
X-Envelope-To: npache@redhat.com
X-Envelope-To: dja@axtens.net
X-Envelope-To: linux-kernel@vger.kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: andrey.konovalov@linux.dev
To: Marco Elver <elver@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	kasan-dev@googlegroups.com,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	Erhard Furtner <erhard_f@mailbox.org>,
	Nico Pache <npache@redhat.com>,
	Daniel Axtens <dja@axtens.net>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kasan, fortify: properly rename memintrinsics
Date: Fri, 17 May 2024 15:01:18 +0200
Message-Id: <20240517130118.759301-1-andrey.konovalov@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Andrey Konovalov <andreyknvl@gmail.com>

After commit 69d4c0d32186 ("entry, kasan, x86: Disallow overriding mem*()
functions") and the follow-up fixes, with CONFIG_FORTIFY_SOURCE enabled,
even though the compiler instruments meminstrinsics by generating calls
to __asan/__hwasan_ prefixed functions, FORTIFY_SOURCE still uses
uninstrumented memset/memmove/memcpy as the underlying functions.

As a result, KASAN cannot detect bad accesses in memset/memmove/memcpy.
This also makes KASAN tests corrupt kernel memory and cause crashes.

To fix this, use __asan_/__hwasan_memset/memmove/memcpy as the underlying
functions whenever appropriate. Do this only for the instrumented code
(as indicated by __SANITIZE_ADDRESS__).

Reported-by: Erhard Furtner <erhard_f@mailbox.org>
Reported-by: Nico Pache <npache@redhat.com>
Closes: https://lore.kernel.org/all/20240501144156.17e65021@outsider.home/
Fixes: 69d4c0d32186 ("entry, kasan, x86: Disallow overriding mem*() functions")
Fixes: 51287dcb00cc ("kasan: emit different calls for instrumentable memintrinsics")
Fixes: 36be5cba99f6 ("kasan: treat meminstrinsic as builtins in uninstrumented files")
Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>
---
 include/linux/fortify-string.h | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index 85fc0e6f0f7f..bac010cfc42f 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -75,17 +75,30 @@ void __write_overflow_field(size_t avail, size_t wanted) __compiletime_warning("
 	__ret;							\
 })
 
-#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
+#if defined(__SANITIZE_ADDRESS__)
+
+#if !defined(CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX) && !defined(CONFIG_GENERIC_ENTRY)
+extern void *__underlying_memset(void *p, int c, __kernel_size_t size) __RENAME(memset);
+extern void *__underlying_memmove(void *p, const void *q, __kernel_size_t size) __RENAME(memmove);
+extern void *__underlying_memcpy(void *p, const void *q, __kernel_size_t size) __RENAME(memcpy);
+#elif defined(CONFIG_KASAN_GENERIC)
+extern void *__underlying_memset(void *p, int c, __kernel_size_t size) __RENAME(__asan_memset);
+extern void *__underlying_memmove(void *p, const void *q, __kernel_size_t size) __RENAME(__asan_memmove);
+extern void *__underlying_memcpy(void *p, const void *q, __kernel_size_t size) __RENAME(__asan_memcpy);
+#else /* CONFIG_KASAN_SW_TAGS */
+extern void *__underlying_memset(void *p, int c, __kernel_size_t size) __RENAME(__hwasan_memset);
+extern void *__underlying_memmove(void *p, const void *q, __kernel_size_t size) __RENAME(__hwasan_memmove);
+extern void *__underlying_memcpy(void *p, const void *q, __kernel_size_t size) __RENAME(__hwasan_memcpy);
+#endif
+
 extern void *__underlying_memchr(const void *p, int c, __kernel_size_t size) __RENAME(memchr);
 extern int __underlying_memcmp(const void *p, const void *q, __kernel_size_t size) __RENAME(memcmp);
-extern void *__underlying_memcpy(void *p, const void *q, __kernel_size_t size) __RENAME(memcpy);
-extern void *__underlying_memmove(void *p, const void *q, __kernel_size_t size) __RENAME(memmove);
-extern void *__underlying_memset(void *p, int c, __kernel_size_t size) __RENAME(memset);
 extern char *__underlying_strcat(char *p, const char *q) __RENAME(strcat);
 extern char *__underlying_strcpy(char *p, const char *q) __RENAME(strcpy);
 extern __kernel_size_t __underlying_strlen(const char *p) __RENAME(strlen);
 extern char *__underlying_strncat(char *p, const char *q, __kernel_size_t count) __RENAME(strncat);
 extern char *__underlying_strncpy(char *p, const char *q, __kernel_size_t size) __RENAME(strncpy);
+
 #else
 
 #if defined(__SANITIZE_MEMORY__)
@@ -110,6 +123,7 @@ extern char *__underlying_strncpy(char *p, const char *q, __kernel_size_t size)
 #define __underlying_strlen	__builtin_strlen
 #define __underlying_strncat	__builtin_strncat
 #define __underlying_strncpy	__builtin_strncpy
+
 #endif
 
 /**
-- 
2.25.1


