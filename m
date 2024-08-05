Return-Path: <linux-kernel+bounces-275209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BF89481D7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 20:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DA011F21CB8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 18:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A93166F0B;
	Mon,  5 Aug 2024 18:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOEPiif0"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98310165F08
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 18:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722883241; cv=none; b=Ib7YwdA1abGExTt6pnZ5ZbPTzh3ByB6DfJF52UoGgMpHJs2yrMXB1Er2Uz+md746g4ZImWPyMQl3cHXGjQCMZP4byvLeAmiDfVFziX+BbuWrNJAJAkh8LVqW8yhF8jxVJsgYf3qe5FrmRTj0JHvuhiis4zqI715KelXR6Oe5bgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722883241; c=relaxed/simple;
	bh=24P15Bx9ElCDUMAi4OqJDf1LJ44qOrvW6LopdQr9Ts0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kfT45csCZSnUlXJHMzNoaOydzG31HkJkJCyXvaWuF4SMwcIz7aDBpSuSQbhHwfY4sybMJJvPhcRHjtJJKQLu/QuhpqpuRWKma4FaCvyqognk94gRcuNDWR7Q4PVi0KbI56xuuqGGC9t5Ls5ymKQ5pkfN5mrZm0w+mKy5MbLwno0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LOEPiif0; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a7a8e73b29cso904813066b.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 11:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722883238; x=1723488038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zriScYxEubY60jokktbaWFHqZ5TIRBloyPdl3CM/JiM=;
        b=LOEPiif06VbgwIxjUtFDlnaswSvT9s+J+gkoUurUqyR6vKbZEwaFKkLsM2PjUqXaN5
         lyL/csz47YE38ml2abONr/354u0gu+j7jPMjYCaJWvnqC9gx8Aynye89IlXgUL7UAADz
         kFmG6PPbHVwsSPqrZ0SYDfJ+gS+4xPdTorR4PhoZeX+Yr0/Zd265AHtZB6bEjxgojdtR
         /aMjo3UjqCoA8EqPQiHR6rBUDcuaUViLN8TeQT6VPiWIJoJsnOfS/dzJs2NiW/OgXWDV
         rh1jev2Eqyako5o3CUaxXXM0WVjMTmd3+QcCLq6M7in42nsOMqechpvUsMx+koGC5Erb
         YVcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722883238; x=1723488038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zriScYxEubY60jokktbaWFHqZ5TIRBloyPdl3CM/JiM=;
        b=TtkNNuuEiAnqQAPw9YSId5ae5TbUbcGsWfPvALnFTv2crX9Y786qrt368cwaVcEPSH
         27JLMKJy9H9kKt9TwGNa/0Ly6JrhjGppUql/esaOIczLrVePcrpxK0HnaRJys0EZDQkR
         FIz1eOK4n1uv/iTRKbPtbJKGOUUcgDLpkcHGgAybcfJ+sGRdYrO3eA6KShRRSQnTDdSJ
         ph5498ZwOE+SHT1l1T+afHi25QCV2L3jDTbRgbmG/c1CNa8gCQ9w0HAZT/MqZiP3Z3si
         1ODWU4LId/IUl51++1JQhKV1lcIyhTlzIrJSLzrZdlVhcGR9hzm9CYH/VGqtgQA+IfzA
         go9g==
X-Forwarded-Encrypted: i=1; AJvYcCVWy3N0U317L5fKTBzSlPJwYozY2o5dcFa1FcjyGj28V6ommfiWpeph7pqety2E8OKE+a+A4X1GF7fr020P7OBnmsErMkw09cKzaeBV
X-Gm-Message-State: AOJu0YxLquNifikDb8U+6b7/iz5pCo6Jf/OcNErgQS/s2pZ/kAl+A64U
	rDI161yEgwayChRd796S3XEDD1e5NRf18GSVpuTV8VPY0nzuGdTH
X-Google-Smtp-Source: AGHT+IEGo7Vm5zvJp9nEVud6phcEtTDIKhjtj5nfoLZd1H8ajHYipyEgr8snqKHgp24J3b5WtV8biQ==
X-Received: by 2002:a17:907:868e:b0:a7d:a29e:5c33 with SMTP id a640c23a62f3a-a7dc4fc9544mr744489266b.28.1722883237795;
        Mon, 05 Aug 2024 11:40:37 -0700 (PDT)
Received: from localhost.localdomain (93-103-32-68.dynamic.t-2.net. [93.103.32.68])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c12ad3sm478517266b.88.2024.08.05.11.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 11:40:37 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Andy Lutomirski <luto@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Nadav Amit <nadav.amit@gmail.com>,
	Brian Gerst <brgerst@gmail.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 3/3] percpu/x86: [RFH] Enable strict percpu checks via named AS qualifiers
Date: Mon,  5 Aug 2024 20:39:01 +0200
Message-ID: <20240805184012.358023-4-ubizjak@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240805184012.358023-1-ubizjak@gmail.com>
References: <20240805184012.358023-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch declares percpu variables in __seg_gs/__seg_fs named AS
and keeps them named AS qualified until they are dereferenced with
percpu accessor. This approach enables various compiler check
for corss-namespace variable assignments.

RFH: The patch hijacks __percpu tag and repurposes it as a named
address space qualifier. While this works surprisingly well in
this RFC patchset, I would really appreciate some help on how
to rewrite this hack into some "production ready" code.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Nadav Amit <nadav.amit@gmail.com>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 arch/x86/include/asm/percpu.h  | 15 ++++++++++++---
 include/linux/compiler_types.h |  2 +-
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 4d31203eb0d2..40916bbd2f11 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -95,9 +95,18 @@
 
 #endif /* CONFIG_SMP */
 
-#define __my_cpu_type(var)	typeof(var) __percpu_seg_override
-#define __my_cpu_ptr(ptr)	(__my_cpu_type(*(ptr))*)(__force uintptr_t)(ptr)
-#define __my_cpu_var(var)	(*__my_cpu_ptr(&(var)))
+#if defined(CONFIG_USE_X86_SEG_SUPPORT) && defined(CONFIG_CC_HAS_TYPEOF_UNQUAL)
+# define __my_cpu_type(var)	typeof(var)
+# define __my_cpu_ptr(ptr)	(ptr)
+# define __my_cpu_var(var)	(var)
+# define __percpu_qual		__percpu_seg_override
+#else
+# define __my_cpu_type(var)	typeof(var) __percpu_seg_override
+# define __my_cpu_ptr(ptr)	(__my_cpu_type(*(ptr))*)(__force uintptr_t)(ptr)
+# define __my_cpu_var(var)	(*__my_cpu_ptr(&(var)))
+# define __percpu_qual
+#endif
+
 #define __percpu_arg(x)		__percpu_prefix "%" #x
 #define __force_percpu_arg(x)	__force_percpu_prefix "%" #x
 
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index f14c275950b5..47c95a06a0ec 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -57,7 +57,7 @@ static inline void __chk_io_ptr(const volatile void __iomem *ptr) { }
 #  define __user	BTF_TYPE_TAG(user)
 # endif
 # define __iomem
-# define __percpu	BTF_TYPE_TAG(percpu)
+# define __percpu	__percpu_qual BTF_TYPE_TAG(percpu)
 # define __rcu		BTF_TYPE_TAG(rcu)
 
 # define __chk_user_ptr(x)	(void)0
-- 
2.45.2


