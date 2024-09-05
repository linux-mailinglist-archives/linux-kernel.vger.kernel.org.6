Return-Path: <linux-kernel+bounces-316454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FE696CFCE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E742C1F229DF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 06:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591591925A4;
	Thu,  5 Sep 2024 06:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7c+iywC"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB7A15624C
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 06:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725519286; cv=none; b=jOznFE2x6sE6RV8IbNX+70qQzWK7IO90G4jqA0FbGELPQNENu+1ZC+ygPQzDFM7rO4CSXVNvIEIr+0eN3nI3xboFAXNFdOdkWsW7g/OpgU3cb2mfKmzyJ7Jmhx77aB7Xg2WZIwrxHH37manewCXACgS6TGScy8TMrOL4r8r3Xsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725519286; c=relaxed/simple;
	bh=QDgXDBvyQJOMWeoFGPVE0g8L+AOYRGndhi4MRkAUOHI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X8DfifGAUEDzamGXRjqYLi13IClOM5L9Nakqq2ueaLR5W6im4c76uGnbxD6+DycC+Qiu1hpneRuECXMy+JXTIijbl6jmOreq4qbZkpPAEy4OMqI3A+FOjyWK0/8rYvwPVvzdbVOuTcZMTAapcdS203f6BWSlOdVOFPT29VMFXTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7c+iywC; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42c94eb9822so2555675e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 23:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725519283; x=1726124083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qyslWu7uboUrkYXcGmXap3x8F7eNeExx5bL2W+WbMOw=;
        b=X7c+iywCsYw9udGEN+EH3QszIxlKFkqEM/yUE/r1LOXpT2wjvLjDW/aSi5PfBW4ARx
         UsdpMkktkwom2vIpKf4eMpLZaBcTEhZ91xjTnMSLFIPX7vP81JfTHNldEvnoFgXhAhwf
         TJctC4W6uBRtteTM+gurzVRTFenii4b0bHah3RFU6IqMayrEowlYqrKqBFUXOx0SHWFK
         yPJ+c8L2JrgRLp0VJs96JyHS4TxAeLRl4ynx070DwlU7TUpP3WhTnaZCmYgkz4pBQJjQ
         1/8hhre2tuFE6xThJoD7nQVSbQ3aKuXVJsftBuEGtwpT3Olx+6BQJKgTGmXg5p6slVmc
         6o6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725519283; x=1726124083;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qyslWu7uboUrkYXcGmXap3x8F7eNeExx5bL2W+WbMOw=;
        b=rWq5eac/DTRvoA5nxFz2gEXInxthK3166IT1/DOt1TqePUXqcFSuvaLV/hLVaQXXjB
         gdpsj4dIwN/Sj1Rue0EgUGGgf5tYDrJCYkOspP8EmpwsiasJrzHQes3tOuAqtHcPR4AY
         SI907tdSXtoPpFf4FsryUZso5Bsogx8yYaNPo5YcxQB7pFZtBLEsj7fRHVrjHETCfmhm
         8YB6rxrExGRlAaibzCxI6sMRvR2NleYBoEVkjZs9SZiw599moe8tpXElL+l58fCZoRKM
         4uNbv0kI9lNL2umQqn+BgdzKZKa9eu/0ye0kfK4nQZ52YRbffGB7AN4gxQROTWBpf41+
         G3Sw==
X-Forwarded-Encrypted: i=1; AJvYcCVrjFOY1ZqgQXktrEUXEenTeETp6rxsDoO7YFuIgVcuB/RqjVyUntfHNpRQZ2OaBaMJRQR/qQncW/nlKTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSxOuBoFE3gi79L11t5Ei5mIs/BR19wxtLzT2b6Ejkk/TTsU7c
	M23EyW1umz4VLF7HeqqtVlkk9TbHl7J5b4nfxocQcAsoZQLCj5T2
X-Google-Smtp-Source: AGHT+IE/TXG3fOuCpU+RcDGLzyLz2FXHj81+VC9o1W4DUSuoU3W7IrdcOroIDd+Il9dmAqWXd9KTUQ==
X-Received: by 2002:a05:600c:5122:b0:428:1d27:f3db with SMTP id 5b1f17b1804b1-42c7b5f0fe4mr94861595e9.35.1725519282410;
        Wed, 04 Sep 2024 23:54:42 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bba57bb20sm201169855e9.4.2024.09.04.23.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 23:54:42 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Xi Ruoyao <xry111@xry111.site>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v3] LoongArch/percpu: Simplify _percpu_read() and _percpu_write()
Date: Thu,  5 Sep 2024 08:54:07 +0200
Message-ID: <20240905065438.802898-1-ubizjak@gmail.com>
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
Cc: Xi Ruoyao <xry111@xry111.site>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
v2: Add a missing cast and a missing coma in the asm template,
    reported by kernel test robot. Some formatting changes.
v3: Check the type of _val in _percpu_write().
---
 arch/loongarch/include/asm/percpu.h | 135 ++++++++++------------------
 1 file changed, 46 insertions(+), 89 deletions(-)

diff --git a/arch/loongarch/include/asm/percpu.h b/arch/loongarch/include/asm/percpu.h
index 8f290e5546cf..90ece62ec24c 100644
--- a/arch/loongarch/include/asm/percpu.h
+++ b/arch/loongarch/include/asm/percpu.h
@@ -68,75 +68,6 @@ PERCPU_OP(and, and, &)
 PERCPU_OP(or, or, |)
 #undef PERCPU_OP
 
-static __always_inline unsigned long __percpu_read(void __percpu *ptr, int size)
-{
-	unsigned long ret;
-
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
-
-	return ret;
-}
-
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
-
 static __always_inline unsigned long __percpu_xchg(void *ptr, unsigned long val, int size)
 {
 	switch (size) {
@@ -157,6 +88,44 @@ static __always_inline unsigned long __percpu_xchg(void *ptr, unsigned long val,
 	return 0;
 }
 
+#define __pcpu_op_1(op)		op ".b "
+#define __pcpu_op_2(op)		op ".h "
+#define __pcpu_op_4(op)		op ".w "
+#define __pcpu_op_8(op)		op ".d "
+
+#define _percpu_read(size, _pcp)					\
+({									\
+	unsigned long __pcp_ret;					\
+									\
+	__asm__ __volatile__(						\
+		__pcpu_op_##size("ldx") "%[ret], $r21, %[ptr]	\n"	\
+		: [ret] "=&r"(__pcp_ret)				\
+		: [ptr] "r"(&(_pcp))					\
+		: "memory");						\
+	(typeof(_pcp))__pcp_ret;					\
+})
+
+#define __pcpu_cast_1(val)	(((unsigned long) val) & 0xff)
+#define __pcpu_cast_2(val)	(((unsigned long) val) & 0xffff)
+#define __pcpu_cast_4(val)	(((unsigned long) val) & 0xffffffff)
+#define __pcpu_cast_8(val)	((unsigned long) val)
+
+#define _percpu_write(size, _pcp, _val)					\
+do {									\
+	unsigned long __pcp_val = __pcpu_cast_##size(_val);		\
+									\
+	if (0) {		                                        \
+		typeof(_pcp) pto_tmp__;					\
+		pto_tmp__ = (_val);					\
+		(void)pto_tmp__;					\
+	}								\
+	__asm__ __volatile__(						\
+		__pcpu_op_##size("stx") "%[val], $r21, %[ptr]	\n"	\
+		:							\
+		: [val] "r"(__pcp_val), [ptr] "r"(&(_pcp))		\
+		: "memory");						\
+} while (0)
+
 /* this_cpu_cmpxchg */
 #define _protect_cmpxchg_local(pcp, o, n)			\
 ({								\
@@ -167,18 +136,6 @@ static __always_inline unsigned long __percpu_xchg(void *ptr, unsigned long val,
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
@@ -215,15 +172,15 @@ do {									\
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


