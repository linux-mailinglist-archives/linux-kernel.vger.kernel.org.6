Return-Path: <linux-kernel+bounces-228274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F0C915D8C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 06:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BDBA1F22711
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 04:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFDF13BAE7;
	Tue, 25 Jun 2024 04:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpRC/okP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7BC13A888
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 04:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719289146; cv=none; b=gEuyBshwxehJMjJmddmsE7X6LBv0R6lS45hpXBgR+XU5CfTSst+7v8+1r91i4lGnLGYdIpMjZYDZkMS8CePdKgMy6+tY0vJwGkh7ZL3tz0rbhCosyMMZVov5m0+Gy2pqH4bJPf2geM8gCPLAPgOhHYXDnCyGJpU1KAsEriINA4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719289146; c=relaxed/simple;
	bh=UfjAcFpr8p8BwnGzYbUElRJhzruRcMixG1Jm7hb8oUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HoJCSsuDlbXWmhtfsSfad2mO+MzBAXcZ/Gi5KDWExcxZRILu32lplVd2tHURmjsdBm09Av38ZIZ8vPXxCqHVTCHcI4Vgi1XuKMiIgykXj9YO8xDjlJ9bVZ7Y3s0CXLjoKQJzf/sLQJYJuuTPhWmFZwPugn+dxxacbQp185z5WdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpRC/okP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3092AC4AF07;
	Tue, 25 Jun 2024 04:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719289146;
	bh=UfjAcFpr8p8BwnGzYbUElRJhzruRcMixG1Jm7hb8oUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BpRC/okPkhIdo+qkN/KxzojnzWMXXLSWgDUsNqqQk/96MorhbdA8LZAro5cxbC/k1
	 Q0Vi1KInfuqas151KodJ8uSN/XhkDilKMJQBtkF3XjT4e6kDh6AZ0OQ5LTLlKzjn1A
	 VPq+Y0hdGbM/VjLPOwuDTosc/RLTxKzCQvkgyxiDHY9Me28ItVGsFR31VlAn7W8zbo
	 yKmF+T+sOqdrt0xq+AAJjRrSIwIlOCQxBRVFFBoe5O1Y7jg2gH6VmE+oONOc1dXnKm
	 XMdsC0ol9TOyyiPmdxw2aeeWT2iqtDizAnqzpdtxdQVMmunM/hj4FPtYBpa/895ubl
	 bQWrYCHlpot1A==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] riscv: implement user_access_begin and families
Date: Tue, 25 Jun 2024 12:04:57 +0800
Message-ID: <20240625040500.1788-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240625040500.1788-1-jszhang@kernel.org>
References: <20240625040500.1788-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, when a function like strncpy_from_user() is called,
the userspace access protection is disabled and enabled
for every word read.

By implementing user_access_begin and families, the protection
is disabled at the beginning of the copy and enabled at the end.

The __inttype macro is borrowed from x86 implementation.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/include/asm/uaccess.h | 63 ++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
index 72ec1d9bd3f3..09d4ca37522c 100644
--- a/arch/riscv/include/asm/uaccess.h
+++ b/arch/riscv/include/asm/uaccess.h
@@ -28,6 +28,19 @@
 #define __disable_user_access()							\
 	__asm__ __volatile__ ("csrc sstatus, %0" : : "r" (SR_SUM) : "memory")
 
+/*
+ * This is the smallest unsigned integer type that can fit a value
+ * (up to 'long long')
+ */
+#define __inttype(x) __typeof__(		\
+	__typefits(x,char,			\
+	  __typefits(x,short,			\
+	    __typefits(x,int,			\
+	      __typefits(x,long,0ULL)))))
+
+#define __typefits(x,type,not) \
+	__builtin_choose_expr(sizeof(x)<=sizeof(type),(unsigned type)0,not)
+
 /*
  * The exception table consists of pairs of addresses: the first is the
  * address of an instruction that is allowed to fault, and the second is
@@ -335,6 +348,56 @@ do {									\
 		goto err_label;						\
 } while (0)
 
+static __must_check __always_inline bool user_access_begin(const void __user *ptr, size_t len)
+{
+	if (unlikely(!access_ok(ptr,len)))
+		return 0;
+	__enable_user_access();
+	return 1;
+}
+#define user_access_begin(a,b)	user_access_begin(a,b)
+#define user_access_end()	__disable_user_access();
+
+static inline unsigned long user_access_save(void) { return 0UL; }
+static inline void user_access_restore(unsigned long enabled) { }
+
+#define unsafe_put_user(x, ptr, label)	do {				\
+	long __kr_err = 0;						\
+	__put_user_nocheck(x, (ptr), __kr_err);				\
+	if (__kr_err) goto label;					\
+} while (0)
+
+#define unsafe_get_user(x, ptr, label)	do {				\
+	long __kr_err = 0;						\
+	__inttype(*(ptr)) __gu_val;					\
+	__get_user_nocheck(__gu_val, (ptr), __kr_err);			\
+	(x) = (__force __typeof__(*(ptr)))__gu_val;			\
+	if (__kr_err) goto label;					\
+} while (0)
+
+/*
+ * We want the unsafe accessors to always be inlined and use
+ * the error labels - thus the macro games.
+ */
+#define unsafe_copy_loop(dst, src, len, type, label)				\
+	while (len >= sizeof(type)) {						\
+		unsafe_put_user(*(type *)(src),(type __user *)(dst),label);	\
+		dst += sizeof(type);						\
+		src += sizeof(type);						\
+		len -= sizeof(type);						\
+	}
+
+#define unsafe_copy_to_user(_dst,_src,_len,label)			\
+do {									\
+	char __user *__ucu_dst = (_dst);				\
+	const char *__ucu_src = (_src);					\
+	size_t __ucu_len = (_len);					\
+	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u64, label);	\
+	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u32, label);	\
+	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u16, label);	\
+	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u8, label);	\
+} while (0)
+
 #else /* CONFIG_MMU */
 #include <asm-generic/uaccess.h>
 #endif /* CONFIG_MMU */
-- 
2.43.0


