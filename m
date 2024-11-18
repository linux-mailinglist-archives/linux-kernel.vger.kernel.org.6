Return-Path: <linux-kernel+bounces-413597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E029D1B7F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 00:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7937280CA9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 23:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3954D1EABB4;
	Mon, 18 Nov 2024 23:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="IE8FrBqp"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2351E9065
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 23:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731970891; cv=none; b=G5/tCMKvgc+SESRTKLwZnVcQPOWM/wiyk5K/z43L0r+MfplkN0O0qzwq+x5gm8Y9mz+DIvo5RLwf9BHc8IL+yRqxPmbBNL+GRTfv9cnP0L9nwbJ7KlfBFT29m4XmZO3JGR7c99cTJW7skbzp6xF9RXA2KDN6HLGaa4sSzW7o0K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731970891; c=relaxed/simple;
	bh=ws7tXnWf+U6DHt9H3UXfoIBpPUQt9MU+Vr1IUARhf/s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c8U7ijEP5WEbeuPAwhOITLkmrzS9z/lKXhKlVST9e4qX7hL9JB/Y6tj4rQUJLRiyxqdsBHWxYZkTEClur3eBtyl0W52qNS9qGPqrtIAvDaP5PwWniRCnu+UMl1RtcNTZU5f74EeQ1y1qTuT03CgwkZZHmlYJG6FrfY1ue4xymnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=IE8FrBqp; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a761e21ddeso8479995ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 15:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1731970889; x=1732575689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YFqjIC8plnN7ShAhD1wilwVRTqQH/DMgtflcfXOVYkY=;
        b=IE8FrBqpP0gpBSaRh6vVvHW7DBQpULtsMi+mkcKcrLcNPMhlFLYDafriz8nUUNYj2c
         U8vdZu46HvLBux5mnAQ3XsoM8tcUP2wK+jPvW2h5DLg/e2f4sCwsWQ4UgpxRFrfvk6Td
         TCVuuvqkMLV7BvrttC7138HJCiBvVNJsmBG2PbtKwdqpS36Gk29XmT6njDveXd/5ty9U
         E2fnIeskGUBXzqATlsqL+A1Uq5nnxP1ArVvbfCWZjrnx8MogaTusszih9KDmELa7XDS1
         82cYeQ6VUxyurVycbOXQPtv2lJ0vx4T6G9AHMDkEGq5by+xZ4Hg+CPXwHgsC05oFfTuz
         cNLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731970889; x=1732575689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YFqjIC8plnN7ShAhD1wilwVRTqQH/DMgtflcfXOVYkY=;
        b=eLX4NEEEfWhyKarZJeQY4q+uIuzUI2MbH3W3r5lfaz2p1w/SnfbDqBtVzsfBHFxUCS
         g0XX+HZbpsBV8uGuTjtkQjZF3eQMPBtYMfG47OqSU5Y+g57WVnlmRNz/z5Q35W7oF8Ad
         Hmz5d2+iAY7dtTR0C/wwXv+puSCkp5pShd8LmhP007ISB/K5YMz5w/dmC+bgy6+ipgXu
         0SSU1qdmPBeMgMPl7AR0bhTRUt7vsk/Am8GAzHHrlFq2Lcewvs+N1Qnn5hvelettm1to
         L7qpkEDw+oBCwvAtkh3gugYOsvQa9nXENVw5IOdHMGNKNqMHeK2gNNTWWL/XkQNROV3O
         //Qw==
X-Forwarded-Encrypted: i=1; AJvYcCVHJJMEAvDOIZ3mfl/5Q6ONqYIzS+uFssB2MkjKjQlPKsR3jpz0myFwQpXRclEpH5XliNSDfcZwvlrPl/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOMyVa8DRymCLlbw3y/tKYOqicwRQrAatFYttFE4sZ3+U7pIeS
	UpzrNbjPA4YaCE+kA/waREZYG+ULGEC9AeU/f2Kk6Y6gpg0WopUbUAg9Xcse/Q==
X-Google-Smtp-Source: AGHT+IFvCHXxvHQVpV+bK5VdC3xSTjSvs5zHAHvFSeEEYYdE9811W5YkCAlHdEbeZSHxbdsnrW17KA==
X-Received: by 2002:a05:6e02:1949:b0:3a0:5642:c78 with SMTP id e9e14a558f8ab-3a748082c35mr142193715ab.15.1731970888729;
        Mon, 18 Nov 2024 15:01:28 -0800 (PST)
Received: from aus-ird.local.tenstorrent.com ([38.104.49.66])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b37a897eebsm35344185a.94.2024.11.18.15.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 15:01:27 -0800 (PST)
From: Cyril Bur <cyrilbur@tenstorrent.com>
To: palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	paul.walmsley@sifive.com
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jisheng Zhang <jszhang@kernel.org>
Subject: [PATCH v2 1/4] riscv: implement user_access_begin and families
Date: Mon, 18 Nov 2024 23:01:09 +0000
Message-Id: <20241118230112.2872978-2-cyrilbur@tenstorrent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241118230112.2872978-1-cyrilbur@tenstorrent.com>
References: <20241118230112.2872978-1-cyrilbur@tenstorrent.com>
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

By implementing user_access_begin and families, the protection
is disabled at the beginning of the copy and enabled at the end.

The __inttype macro is borrowed from x86 implementation.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Signed-off-by: Cyril Bur <cyrilbur@tenstorrent.com>
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
2.34.1


