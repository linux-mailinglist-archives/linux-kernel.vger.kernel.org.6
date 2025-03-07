Return-Path: <linux-kernel+bounces-550721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2121A56344
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC365175919
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A475D1E1E09;
	Fri,  7 Mar 2025 09:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pkgh4Sw9"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B101DE2CC
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 09:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741338619; cv=none; b=k7oc9kEkWqRUAWpzIz2Tj9zcB8z6npFs/YDFKSq3MK5M2x2ctRn0fNOkOIi3uii6mMDp+lIURs43lZL9mW8x+YNgiS3CRYq/zLhiESPgiYNeXk6Luh9huuemEBaxOBcD7kDjjMAyhchP3CWDPtF5+W/qehNlJRd1qiNbvyMvm/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741338619; c=relaxed/simple;
	bh=IGm+yBhG9miftesjI8i8TLMAFLcnfjfk8TQ4w9ar0Ww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QHN/tA9fDIVvuf64UG5Fx9aQV1IeuIpCV2ZCnBdD+Nn+zFdWw9uuNWH0VCAuUoHbJ0dcBOooNLb1tP3MVKElQSjGWSOtIiDyyhw3ne9RxSd0XoTc+58Ih2UMAaBccRuPFpwgkHe8svfyOC7RvyfKx+8rFP48G/NV2C39+PiGGLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pkgh4Sw9; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e5e1a38c1aso819181a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 01:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741338615; x=1741943415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2OBmKxutCA3PjGE+9J4xr+//nfl2kxxGWalGepjmI9A=;
        b=Pkgh4Sw99YustOvI61sMRMXaA+LJ92dSLEJS5iB6gF8tJ4JEmElAnY0w7GaXQwKjOn
         nF2xaYEgE8yh4lHiINJUL/qYUleYp8LS9pfIaCJyUB2vNw9mqeqWbPWjD0vUl19v4kfV
         3TjSZLJh3gZ8UzHJX+hgZDSWox4bsDQVNumyqWVdGca2UsZuFc96rR2gnXfnhFW0gMKk
         lft7eTqsNce0vaPjB2IY2OaJ4h67bLk2po3umuyTBTfo6pkkNlLR8za+eflj34ofmcVD
         L9ZRuSnVRvRbgxw8GIpj0UXQIbuuK6lPZhbc35K3+hFWXIhjH1cTwYsPrsvRh73Ap8eP
         /WWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741338615; x=1741943415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2OBmKxutCA3PjGE+9J4xr+//nfl2kxxGWalGepjmI9A=;
        b=sV1XYh2CvF3P3Io6YirYMW4LsZkZ3ry3VobMCVdsBWzZzgZymzKoohA1eCH67eij4L
         U/AlhCIjWTb+Sw6ZNBMaC+RlHSjKDgShminW3N9V2raWzDR1Pxpl51C64yofWYOu/jP9
         +zP8bYwl2MFcvpixxPVhAQjwAA6/kKKX4l9hvqpHT65v5F5o6LnxmvR8ozw8ePrXN0qk
         Feg39LhbvBY7Nv9Qwargf2QDXmAeWSzmhwR3qy7rOMer25NgIHd1xwXX66Kuj1uKdNAR
         07S8Qak7nAugrrzHgMcexWxdWmZYSC5Vkx+GS1lX3JznPLwt/jWvTyuXLOLqvQQYaUlS
         KMVg==
X-Forwarded-Encrypted: i=1; AJvYcCWUECHmQopBaW4fpEv7FBpZJaxdIfM+zu6bUf9wsibcf3qavKbnyDTjxbO3SZ5qzsYMTESrlQ2GeoKjPBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgFcyBjOYSvvT6xtseyIBya7dnUwuCFQV2CgVJF1yzjeUeZjg9
	c1KHOyWi2Hk6M3u3bX/nxX+8rWElE04jUb3zaPNSa0NOt0tcqO1zMfPgG/d2
X-Gm-Gg: ASbGnctgCY9mdzHnmUrpzVBmXKrsQ7KYJb9WdZz+fOUVC9Lug/83bh9qLcg1fneabhA
	PrML5WN+r+kXx5NDbRb7zNccllg15lkq2bE+KfsbbKHjIIXzZ8IdNLzqVDa91gISXs47Qd3NAdi
	GpiAxcYGGI3FUOiYKqaWXVOn6f6c8XxVdxqDZHnnb8+vmz3jJmDH6Om+jc35UiakudUYfCdbssn
	vY2s0PijBYwIpohTdEfL9VTEUF1JIh12LI9L+TILzBPZfw0Q/kT5q6z1tEE2yotLcN6e2EzhKtr
	Wj+CKGhdy1Uho2NnAGmR2inONt/PzZ3Qu8ow
X-Google-Smtp-Source: AGHT+IH7jF6BfIEvHXvgKAn4ClDz7PtsE4enzXuv5kmRVMCKWooyX5tppAdjT7IzKGtDo/2kCOjBVQ==
X-Received: by 2002:a05:6402:518f:b0:5dc:6e27:e6e8 with SMTP id 4fb4d7f45d1cf-5e5e246875fmr5606564a12.24.1741338614846;
        Fri, 07 Mar 2025 01:10:14 -0800 (PST)
Received: from fedora.. ([193.77.86.199])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c768f213sm2197614a12.74.2025.03.07.01.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 01:10:14 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/boot: Do not test if AC and ID eflags are changeable on x86_64
Date: Fri,  7 Mar 2025 10:10:03 +0100
Message-ID: <20250307091022.181136-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test for the changeabitily of AC and ID eflags is used to
distinguish between i386 and i486 processors (AC) and to test
for cpuid instruction support (ID).

Skip these tests on x86_64 processors as they always supports cpuid.

Also change the return type of has_eflag() to bool.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/boot/cpuflags.c | 26 +++++++++-----------------
 arch/x86/boot/cpuflags.h |  6 +++++-
 2 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/arch/x86/boot/cpuflags.c b/arch/x86/boot/cpuflags.c
index d75237ba7ce9..2150a016176f 100644
--- a/arch/x86/boot/cpuflags.c
+++ b/arch/x86/boot/cpuflags.c
@@ -29,40 +29,32 @@ static int has_fpu(void)
 	return fsw == 0 && (fcw & 0x103f) == 0x003f;
 }
 
+#ifdef CONFIG_X86_32
 /*
  * For building the 16-bit code we want to explicitly specify 32-bit
  * push/pop operations, rather than just saying 'pushf' or 'popf' and
- * letting the compiler choose. But this is also included from the
- * compressed/ directory where it may be 64-bit code, and thus needs
- * to be 'pushfq' or 'popfq' in that case.
+ * letting the compiler choose.
  */
-#ifdef __x86_64__
-#define PUSHF "pushfq"
-#define POPF "popfq"
-#else
-#define PUSHF "pushfl"
-#define POPF "popfl"
-#endif
-
-int has_eflag(unsigned long mask)
+bool has_eflag(unsigned long mask)
 {
 	unsigned long f0, f1;
 
-	asm volatile(PUSHF "	\n\t"
-		     PUSHF "	\n\t"
+	asm volatile("pushfl	\n\t"
+		     "pushfl	\n\t"
 		     "pop %0	\n\t"
 		     "mov %0,%1	\n\t"
 		     "xor %2,%1	\n\t"
 		     "push %1	\n\t"
-		     POPF "	\n\t"
-		     PUSHF "	\n\t"
+		     "popfl	\n\t"
+		     "pushfl	\n\t"
 		     "pop %1	\n\t"
-		     POPF
+		     "popfl"
 		     : "=&r" (f0), "=&r" (f1)
 		     : "ri" (mask));
 
 	return !!((f0^f1) & mask);
 }
+#endif
 
 void cpuid_count(u32 id, u32 count, u32 *a, u32 *b, u32 *c, u32 *d)
 {
diff --git a/arch/x86/boot/cpuflags.h b/arch/x86/boot/cpuflags.h
index fdcc2aa4c3c4..a398d9204ad0 100644
--- a/arch/x86/boot/cpuflags.h
+++ b/arch/x86/boot/cpuflags.h
@@ -15,7 +15,11 @@ struct cpu_features {
 extern struct cpu_features cpu;
 extern u32 cpu_vendor[3];
 
-int has_eflag(unsigned long mask);
+#ifdef CONFIG_X86_32
+bool has_eflag(unsigned long mask);
+#else
+static inline bool has_eflag(unsigned long mask) { return true; }
+#endif
 void get_cpuflags(void);
 void cpuid_count(u32 id, u32 count, u32 *a, u32 *b, u32 *c, u32 *d);
 bool has_cpuflag(int flag);
-- 
2.48.1


