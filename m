Return-Path: <linux-kernel+bounces-312705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A77969A0C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 12:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37A711C23389
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D3F1AD27B;
	Tue,  3 Sep 2024 10:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTOBBCpO"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB251A0BD1
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 10:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725359031; cv=none; b=anp+C7AiMoCJ3OO3kYeHC4A11fRsZbBm2VpVPj2zGn7ToJpH2OcpZce1Z0GK1QXkxHv+n31zPgHQMtTj2G0qoFvNpfGsmFfdAz0BprSXKMkXD/tJRcdK0UfM+RZL9MwHml9swNoWoGSJePm6Zscy4ipasxPzn5FQ92b64KCQe2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725359031; c=relaxed/simple;
	bh=uDUb6Kl+yRsf202h+UBICiKjtl7trH+w4Hzt+76v/Og=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=glFei+eirkJl62LiX2I2DUapgqI6z333zwbNOru7cKCSAiQVTvlieoL22yo3MDdVIAPsShdw3CaeK7yoIdP3oaTBqUCRmfLavi7/qIEEp/07uz0U0flNl0xpjrdCmKdT2V5lp1bA0ArueXASceim2yVFE9wwtNPxRWrW9/KDeBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eTOBBCpO; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42bbd16fca8so32929155e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 03:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725359028; x=1725963828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yuL2Wilyj58PiNHXcsKnDwClQnWoQYNkYuKGppGZI2Y=;
        b=eTOBBCpOovRHc821MA62mxb3HU6iR6hxgmX9Uy4u/fGXqNqgmp4AVXoB0oqxzmBwwX
         8iGPf6gqLDHJe7ZRtB7ykVkO3D1vSjzp8RJlsxU7YFH4rrenfGvhQyIwoVvbODI/0NLy
         wcS+4fo7RpkqTrTyLCh6U3lauhCI9rn1xcK9rk3Bh8kOzcTLEcmT1aETBoEdFwk9/8MJ
         JG3GjcHhXo5dmINdrF+tdVtCEkFwGcOLOcNG/SwWDdCb0Fa167KdD3qmBQUPuy04bOv1
         YvMOOy7NpufG+abqUIxNiPz47Kiwh7EeMacbuUNgf4o1GVbnyqDS97Rexf+Dr0IdcfGz
         WMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725359028; x=1725963828;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yuL2Wilyj58PiNHXcsKnDwClQnWoQYNkYuKGppGZI2Y=;
        b=qrkEWDTXov0CU+pYFKs7cZoaLWAYL4ZTEXPiOHNzh/EgonKR+rAE5wtzzSUbjW9jgU
         3+1QgchRvWsCb820Pr/oQt4iHUYRXfHSTq3kHXlosIKztqzL1B8i8JlH744Wx8D1gPJ1
         UhOrjOGqzhZ66nHKX3Lw8e5Ocq8bgsHky3hXrU/7gUyMaMEDVr72LmOl4fmFS0UTP2LH
         QBScgjBJNS+NEcOZW2VhIG4SHfqMMCnpdk4VGAsZrtXoFMIqxSEeMRAhtBZTfxWxTnq6
         mgMmsn9kO4JqlZlV+23Mig7NkuydJ8F2pCXu9jrlnOE1kwgKI8kNKqK+zMbb82AGyu2/
         bWQQ==
X-Forwarded-Encrypted: i=1; AJvYcCV04zyz0m/5+h34AxpN/JI53eYR2lVZLvodwLqsZr8LtLMFZHroO9MDx535gp8BgMsTW3TdgjgRIiE+mZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWeJgjl6cymd5JJGfXFYisyaDej8k67aGMapi1I/P0jM93h7+v
	iMpVR2bs45cZPsM9rWYW007pdwScARk8HUYA0l6ltTy2kfH53zuF
X-Google-Smtp-Source: AGHT+IG7a/7PC8L6V63PjZG2vdWRcpHaI+5y8+7xoEPqoqFgeb1dCY+yS9+wPWqhU8YNx1eNmBiXsA==
X-Received: by 2002:a05:600c:5110:b0:426:6710:223c with SMTP id 5b1f17b1804b1-42c880ef921mr25143895e9.9.1725359027108;
        Tue, 03 Sep 2024 03:23:47 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bacaac810sm185955585e9.33.2024.09.03.03.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 03:23:46 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] longsoon/percpu: Simplify _percpu_read() and _percpu_write()
Date: Tue,  3 Sep 2024 12:23:18 +0200
Message-ID: <20240903102342.36957-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

_percpu_read() and _percpu_write() macros call __percpu_read()
and __percpu_write() static inline functions that result in a single
assembly instruction. Percpu infrastructure expects its leaf
definitions to encode the size of their percpu variable, so the patch
merges asm clauses from the static inline function into the
corresponding leaf macros.

The secondary effect of this change is to avoid explicit __percpu
function arguments. Currently, __percpu macro is defined in
include/linux/compiler_types.h, but with proposed patch [1],
__percpu definition will need macros from include/asm-generic/percpu.h,
creating forward dependency loop.

The proposed solution is the same as x86 architecture uses.

Patch is compile tested only.

[1] https://lore.kernel.org/lkml/20240812115945.484051-4-ubizjak@gmail.com/

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 arch/loongarch/include/asm/percpu.h | 120 ++++++++--------------------
 1 file changed, 35 insertions(+), 85 deletions(-)

diff --git a/arch/loongarch/include/asm/percpu.h b/arch/loongarch/include/asm/percpu.h
index 8f290e5546cf..c0f8e787223c 100644
--- a/arch/loongarch/include/asm/percpu.h
+++ b/arch/loongarch/include/asm/percpu.h
@@ -68,74 +68,36 @@ PERCPU_OP(and, and, &)
 PERCPU_OP(or, or, |)
 #undef PERCPU_OP
 
-static __always_inline unsigned long __percpu_read(void __percpu *ptr, int size)
-{
-	unsigned long ret;
+#define __pcpu_op_1(op)		op ".b "
+#define __pcpu_op_2(op)		op ".h "
+#define __pcpu_op_4(op)		op ".w "
+#define __pcpu_op_8(op)		op ".d "
 
-	switch (size) {
-	case 1:
-		__asm__ __volatile__ ("ldx.b %[ret], $r21, %[ptr]	\n"
-		: [ret] "=&r"(ret)
-		: [ptr] "r"(ptr)
-		: "memory");
-		break;
-	case 2:
-		__asm__ __volatile__ ("ldx.h %[ret], $r21, %[ptr]	\n"
-		: [ret] "=&r"(ret)
-		: [ptr] "r"(ptr)
-		: "memory");
-		break;
-	case 4:
-		__asm__ __volatile__ ("ldx.w %[ret], $r21, %[ptr]	\n"
-		: [ret] "=&r"(ret)
-		: [ptr] "r"(ptr)
-		: "memory");
-		break;
-	case 8:
-		__asm__ __volatile__ ("ldx.d %[ret], $r21, %[ptr]	\n"
-		: [ret] "=&r"(ret)
-		: [ptr] "r"(ptr)
-		: "memory");
-		break;
-	default:
-		ret = 0;
-		BUILD_BUG();
-	}
+#define _percpu_read(size, _pcp)					\
+({									\
+	unsigned long __pcp_ret;					\
+									\
+	__asm__ __volatile__ (__pcpu_op_##size("ldx") "%[ret], $r21, %[ptr]	\n" \
+		: [ret] "=&r"(__pcp_ret)				\
+		: [ptr] "r"(&(_pcp))					\
+		: "memory");						\
+	(typeof(_pcp))__pcp_ret;					\
+})
 
-	return ret;
-}
+#define __pcpu_cast_1(val)	(((unsigned long) val) & 0xff)
+#define __pcpu_cast_2(val)	(((unsigned long) val) & 0xffff)
+#define __pcpu_cast_4(val)	(((unsigned long) val) & 0xffffffff)
+#define __pcpu_cast_8(val)	(val)
 
-static __always_inline void __percpu_write(void __percpu *ptr, unsigned long val, int size)
-{
-	switch (size) {
-	case 1:
-		__asm__ __volatile__("stx.b %[val], $r21, %[ptr]	\n"
-		:
-		: [val] "r" (val), [ptr] "r" (ptr)
-		: "memory");
-		break;
-	case 2:
-		__asm__ __volatile__("stx.h %[val], $r21, %[ptr]	\n"
-		:
-		: [val] "r" (val), [ptr] "r" (ptr)
-		: "memory");
-		break;
-	case 4:
-		__asm__ __volatile__("stx.w %[val], $r21, %[ptr]	\n"
-		:
-		: [val] "r" (val), [ptr] "r" (ptr)
-		: "memory");
-		break;
-	case 8:
-		__asm__ __volatile__("stx.d %[val], $r21, %[ptr]	\n"
-		:
-		: [val] "r" (val), [ptr] "r" (ptr)
-		: "memory");
-		break;
-	default:
-		BUILD_BUG();
-	}
-}
+#define _percpu_write(size, _pcp, _val)					\
+do {									\
+	unsigned long __pcp_val = __pcpu_cast_##size(_val);		\
+									\
+	__asm__ __volatile__ (__pcpu_op_##size("stx") "%[val] $r21, %[ptr]	\n" \
+		:							\
+		: [val] "r"(__pcp_val), [ptr] "r"(&(_pcp))		\
+		: "memory");						\
+} while (0)
 
 static __always_inline unsigned long __percpu_xchg(void *ptr, unsigned long val, int size)
 {
@@ -167,18 +129,6 @@ static __always_inline unsigned long __percpu_xchg(void *ptr, unsigned long val,
 	__ret;							\
 })
 
-#define _percpu_read(pcp)						\
-({									\
-	typeof(pcp) __retval;						\
-	__retval = (typeof(pcp))__percpu_read(&(pcp), sizeof(pcp));	\
-	__retval;							\
-})
-
-#define _percpu_write(pcp, val)						\
-do {									\
-	__percpu_write(&(pcp), (unsigned long)(val), sizeof(pcp));	\
-} while (0)								\
-
 #define _pcp_protect(operation, pcp, val)			\
 ({								\
 	typeof(pcp) __retval;					\
@@ -215,15 +165,15 @@ do {									\
 #define this_cpu_or_4(pcp, val) _percpu_or(pcp, val)
 #define this_cpu_or_8(pcp, val) _percpu_or(pcp, val)
 
-#define this_cpu_read_1(pcp) _percpu_read(pcp)
-#define this_cpu_read_2(pcp) _percpu_read(pcp)
-#define this_cpu_read_4(pcp) _percpu_read(pcp)
-#define this_cpu_read_8(pcp) _percpu_read(pcp)
+#define this_cpu_read_1(pcp) _percpu_read(1, pcp)
+#define this_cpu_read_2(pcp) _percpu_read(2, pcp)
+#define this_cpu_read_4(pcp) _percpu_read(4, pcp)
+#define this_cpu_read_8(pcp) _percpu_read(8, pcp)
 
-#define this_cpu_write_1(pcp, val) _percpu_write(pcp, val)
-#define this_cpu_write_2(pcp, val) _percpu_write(pcp, val)
-#define this_cpu_write_4(pcp, val) _percpu_write(pcp, val)
-#define this_cpu_write_8(pcp, val) _percpu_write(pcp, val)
+#define this_cpu_write_1(pcp, val) _percpu_write(1, pcp, val)
+#define this_cpu_write_2(pcp, val) _percpu_write(2, pcp, val)
+#define this_cpu_write_4(pcp, val) _percpu_write(4, pcp, val)
+#define this_cpu_write_8(pcp, val) _percpu_write(8, pcp, val)
 
 #define this_cpu_xchg_1(pcp, val) _percpu_xchg(pcp, val)
 #define this_cpu_xchg_2(pcp, val) _percpu_xchg(pcp, val)
-- 
2.46.0


