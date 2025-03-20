Return-Path: <linux-kernel+bounces-570487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4DDA6B12F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 23:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11F288A3284
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 22:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01B222A7FD;
	Thu, 20 Mar 2025 22:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="VUIAL8a2"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43869223707
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 22:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742510670; cv=none; b=X+2BVyrMm30fRnY7Xs7RIl4IzK9qKWzvKr4MZvLcuYYrg6lfJmgjxJFG/kS2zqJBqUjMkhDbyBf0imiwbG7HW5ykTvpEeUE9ZjOxIsS3rKslGB3nJWts9M7Iw+LlGesr4Xl6ezUy7ep3pS+wtyz2CZSy3CYqP5vyaehfgKHunGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742510670; c=relaxed/simple;
	bh=p7gn8HCoRfmei461kdKTMrhmaoZ+R8QG+5SxtGUWr5I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aywzQjdhBGxoXa/mIu34ECKJUFfTk4+povjEugwVG7GtGYaLebh/vFJXqI67kCXLJs1jlXwg5ilfvtR2WCwq/fpvMvUmN42HPXsmHMuTpZ0riP/Qe8FkKOUndPfgM6OwACu+OAjDop5nqO94I4Sp2WJVYrE8jVaWCVftg9VgrrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=VUIAL8a2; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3f3f4890596so755580b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 15:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1742510668; x=1743115468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vvw7nYWiLBIqfTSpurYIsb0A2VRmihRadD2HqJzvOMM=;
        b=VUIAL8a2f7OpfpEGUQzRdhUPoA5r4jlbbhRg7IU0fhWRf2aKjtPtF47I8H8LWSGXfZ
         PjsBCYNga7BtCfs3S7DdT/RLOqvzYrpRy99nxyBAkobMRp5A6sZxZhfuQ7lJjXpTIQxF
         ZEAfF/3+l5u5uHxh3l2sh3P/dZiXrch3d0Dameuirktz1p2NC5Q6pgMGIUQYx7Hs9Bjs
         rqNPqOzloOgv0VsQcrEa8FybtC94F3G2xMK+PDo9GIaMj5AoRv0foY8y8R3q5mKJ8bFi
         Kv+UvfLLpIHrwErPmSkei0Q+wQdweCzN3RyK4xzmAl80acDBOksQqNNYKpDsyRA2/dms
         pBQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742510668; x=1743115468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vvw7nYWiLBIqfTSpurYIsb0A2VRmihRadD2HqJzvOMM=;
        b=W2DyHP2ekdNNHaFsdd2xUTSABucCH+GM5BvwmVYMDVePTPHVw5oMjA+KztDf8sfuTq
         rrn6wE5PCrOM629YDFoPu8uuzCZvkweDumXXTcWtoYPsSRqYRh4wEKIR87q06zPOiWlS
         CwTc7nwjffdGSL8swRtf6fz27NsCZFuc2VUvBLaG9mAqSx9tHwxrIfyVrLRDUm7qrAQv
         P/DUBFUd2y0yzptOd1u0hG2nDPOp6D8RVURpQ3azWhzSzqCK7WF+wRnUymjq2jtPxref
         +RDdhEFVyPNp9VOO0+elvHHkL6jZDtE/F9JgwG2INuBVsGkQP8dXPGsUtxJq+KezBlaN
         ZP7w==
X-Forwarded-Encrypted: i=1; AJvYcCURcHNdXUvv8xKZ76IqW5sjaWokOPSYRtKtin+gsr6h+2sr2/L3THkgvSrwAsq/gassU8NZvCTHyxcZ5jk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD/B64WZfzwXo2osLxnu6DjRPofnsFM22WOFL7Qywhl8DLxXBI
	vp47zJzw/8JXw0BVK/yC3SyV7avzMRcjNU14TZ8FcwB35MhLLmIZqeMso5QM8w==
X-Gm-Gg: ASbGncv/q5f/bNGN1g7o19OXDxNDd0zQ+N6c7KVoRhOyUR04MK/MrOciGannE0uaIHf
	3vOCttOk/7yDeo3I3XK46fstFwv63xQprdmdPIi4RIt6De86XZ1W30nv1sdYuCKe8z2t1b9kgwq
	nIKEndlBzt/xLM6+CAnUIxjlCqRa7SuKWFEf3wMYhADp9XTvp4WvTKI6Ttzuf9B4/MMxf5X3DOb
	wb+SgUklIA/Zdxw+Ge+ngJv0ypPgBuHGUqeHN7UUCXlYc3m1bJmURGMIUSHMQJf8gyZMt4WXWhH
	FhEBpwzu2s4zqf5hFc66+AoBgwzpCUoe6jJr7/EVD3k0g2I00kWUtTv+2bz3ClE=
X-Google-Smtp-Source: AGHT+IFJedQeXWVCp8Wwl18/3gDvFSbrwpqc13CUW17x0vVkYsJlg/z2sLYvBni60TXj6/O4eMplxg==
X-Received: by 2002:a05:6808:1495:b0:3fa:d6c:cdb8 with SMTP id 5614622812f47-3febf79528emr596590b6e.38.1742510668153;
        Thu, 20 Mar 2025 15:44:28 -0700 (PDT)
Received: from aus-ird.tenstorrent.com ([38.104.49.66])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3febf6dcc09sm103524b6e.12.2025.03.20.15.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 15:44:27 -0700 (PDT)
From: Cyril Bur <cyrilbur@tenstorrent.com>
To: palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	paul.walmsley@sifive.com,
	charlie@rivosinc.com,
	jrtc27@jrtc27.com,
	ben.dooks@codethink.co.uk,
	alex@ghiti.fr
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jszhang@kernel.org
Subject: [PATCH v5 2/5] riscv: implement user_access_begin() and families
Date: Thu, 20 Mar 2025 22:44:20 +0000
Message-Id: <20250320224423.1838493-3-cyrilbur@tenstorrent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250320224423.1838493-1-cyrilbur@tenstorrent.com>
References: <20250320224423.1838493-1-cyrilbur@tenstorrent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jisheng Zhang <jszhang@kernel.org>

Currently, when a function like strncpy_from_user() is called,
the userspace access protection is disabled and enabled
for every word read.

By implementing user_access_begin() and families, the protection
is disabled at the beginning of the copy and enabled at the end.

The __inttype macro is borrowed from x86 implementation.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Signed-off-by: Cyril Bur <cyrilbur@tenstorrent.com>
---
 arch/riscv/include/asm/uaccess.h | 76 ++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
index fee56b0c8058..c9a461467bf4 100644
--- a/arch/riscv/include/asm/uaccess.h
+++ b/arch/riscv/include/asm/uaccess.h
@@ -61,6 +61,19 @@ static inline unsigned long __untagged_addr_remote(struct mm_struct *mm, unsigne
 #define __disable_user_access()							\
 	__asm__ __volatile__ ("csrc sstatus, %0" : : "r" (SR_SUM) : "memory")
 
+/*
+ * This is the smallest unsigned integer type that can fit a value
+ * (up to 'long long')
+ */
+#define __inttype(x) __typeof__(		\
+	__typefits(x, char,			\
+	  __typefits(x, short,			\
+	    __typefits(x, int,			\
+	      __typefits(x, long, 0ULL)))))
+
+#define __typefits(x, type, not) \
+	__builtin_choose_expr(sizeof(x) <= sizeof(type), (unsigned type)0, not)
+
 /*
  * The exception table consists of pairs of addresses: the first is the
  * address of an instruction that is allowed to fault, and the second is
@@ -368,6 +381,69 @@ do {									\
 		goto err_label;						\
 } while (0)
 
+static __must_check __always_inline bool user_access_begin(const void __user *ptr, size_t len)
+{
+	if (unlikely(!access_ok(ptr, len)))
+		return 0;
+	__enable_user_access();
+	return 1;
+}
+#define user_access_begin user_access_begin
+#define user_access_end __disable_user_access
+
+static inline unsigned long user_access_save(void) { return 0UL; }
+static inline void user_access_restore(unsigned long enabled) { }
+
+/*
+ * We want the unsafe accessors to always be inlined and use
+ * the error labels - thus the macro games.
+ */
+#define unsafe_put_user(x, ptr, label)	do {				\
+	long __err = 0;							\
+	__put_user_nocheck(x, (ptr), __err);				\
+	if (__err)							\
+		goto label;						\
+} while (0)
+
+#define unsafe_get_user(x, ptr, label)	do {				\
+	long __err = 0;							\
+	__inttype(*(ptr)) __gu_val;					\
+	__get_user_nocheck(__gu_val, (ptr), __err);			\
+	(x) = (__force __typeof__(*(ptr)))__gu_val;			\
+	if (__err)							\
+		goto label;						\
+} while (0)
+
+#define unsafe_copy_loop(dst, src, len, type, op, label)		\
+	while (len >= sizeof(type)) {					\
+		op(*(type *)(src), (type __user *)(dst), label);	\
+		dst += sizeof(type);					\
+		src += sizeof(type);					\
+		len -= sizeof(type);					\
+	}
+
+#define unsafe_copy_to_user(_dst, _src, _len, label)			\
+do {									\
+	char __user *__ucu_dst = (_dst);				\
+	const char *__ucu_src = (_src);					\
+	size_t __ucu_len = (_len);					\
+	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u64, unsafe_put_user, label);	\
+	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u32, unsafe_put_user, label);	\
+	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u16, unsafe_put_user, label);	\
+	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u8, unsafe_put_user, label);	\
+} while (0)
+
+#define unsafe_copy_from_user(_dst, _src, _len, label)			\
+do {									\
+	char *__ucu_dst = (_dst);					\
+	const char __user *__ucu_src = (_src);				\
+	size_t __ucu_len = (_len);					\
+	unsafe_copy_loop(__ucu_src, __ucu_dst, __ucu_len, u64, unsafe_get_user, label);	\
+	unsafe_copy_loop(__ucu_src, __ucu_dst, __ucu_len, u32, unsafe_get_user, label);	\
+	unsafe_copy_loop(__ucu_src, __ucu_dst, __ucu_len, u16, unsafe_get_user, label);	\
+	unsafe_copy_loop(__ucu_src, __ucu_dst, __ucu_len, u8, unsafe_get_user, label);	\
+} while (0)
+
 #else /* CONFIG_MMU */
 #include <asm-generic/uaccess.h>
 #endif /* CONFIG_MMU */
-- 
2.34.1


