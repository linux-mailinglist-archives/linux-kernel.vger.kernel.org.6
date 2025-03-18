Return-Path: <linux-kernel+bounces-565534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28818A66A32
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 07:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 434E2189A9C0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 06:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9A41DE4CA;
	Tue, 18 Mar 2025 06:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="O5CQAGiB"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1919919B3EE
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 06:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742278521; cv=none; b=qWuVl5lCZREB43NjJdjLBDL0akgSt52F80NVNGgjJeGUDJTmC8VYunBmU6aj/vVqQCuyaE37iCOj2Amt/Fcb0du15o5742ZgKFxi/STHaa5xGQX8gg0t2e5XW8TD6VEXa9yzmxyCqOzrHKE7HiLJBok9xlE92OO+u7gt3dcMZP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742278521; c=relaxed/simple;
	bh=OyHO91umNeTvoAyNEoyZRtv9B+u3OndEt7OlSnX3SIs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M2IfIgEgS7MJCyEHTYeRt632UTU6Lg7/VU8iEbz5ucMyRIOpk1nn7Fv/diIWYr6j3WZLc1wJzjfYGzfShcnuvjLa0VCywUqwbJA+cvmmy1e3IPTRgnjn/FMDN4P6DPJjuscYY2j9V3v0r2RvYTXE0bjFEGG/Uh4Wlpw+XFR23C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=O5CQAGiB; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3f7f7b70aebso1990490b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 23:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1742278519; x=1742883319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Rz7GbyOPq3wyNoMRzcZSnc3xOAtIOrgSgwyUJM88Lo=;
        b=O5CQAGiBkRIPY2xaRHQlBWo24oYqyxRLa6+4/2MEbxkQJuK61qM17oXO4el680kxUy
         sN7+v59wyC5Rh897bihJsTPo2tDCNyEaAy+sFEtu1qxjzX1v+I0uYKhYJiwlxbg660jT
         nMaxEO4cuHsJK++kGxiWsrP1tagxWnJ3T6ii8bjrXOLuf9OV0AsOulHa8xLu0JrsNTPS
         GUUnTSSlmnDo9Cry0VaYGijCjJmwHGEuNnf3kwUwGjGSCTI5CeSKdGQpjchOcANQlmj2
         BFvdV2axSJx8Qu11LxfZ214Trj3rZaaUVm3yOaF7k2vMjAddZPHqOsmfRFx7IkZ2+AgB
         hrcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742278519; x=1742883319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Rz7GbyOPq3wyNoMRzcZSnc3xOAtIOrgSgwyUJM88Lo=;
        b=rhIjf5hUHw02362sIqDx12rKJ2DQFDGeQ+UWl44Cwi7p4rfmua+n9bfPjeb/FiQW5j
         JAjh2huFdYyp6b2qbXXqotxEAmqfnXp+dKolEIs9f5sxDY1jPOAD8x15J2iaMwHvQeur
         TQR8DMPJlBY4lHnroAhkTkfDjzCLuuJb7v0fVrjkwyu4yCrJ7i7gPaYQBeT49SYH/gg7
         4FczhJ6f6Xiq3QDZsqrP+O5E7y6D/7K/A8GfyjnBueZtOe0S6mbGKlbteOzeq/53h0Xt
         9CedVBqE/i3PlA5ktr2v26nD05hVAyeOg1jQ5BHZ/hA+ZCGYzjV4+slEUqqTzBsPD4JG
         GaJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvCUMf9c4LHD3rvNS3XLpTxaE56BeUyHnpp3K0JgiL4+nW88YKD1jaWO/Cw06nICYoC37CpNeWVdZr7aY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz42VpVtpyX+MWu7JtcsQ5skT3VdPaThYdkhSXiGIxcVL3K+XUM
	nv4HBXIkfyp+KclIDxoR/kK3LlapsXOq1BbYwvZWuwQiRJqEMTmyaoRBtfiDSQ==
X-Gm-Gg: ASbGncv999s9+X/xcgPCIWdBPIh2AAjLQKFfxxqCSVWNkvcZRRxI5efuLabu0yjEomF
	UECmN/0bhn4OUXf+tSA0PMx14lcjymaYcglu3tNXMaoWMwdftVq3qCzjZvHLq0rn+G8lOj5jlPk
	UG8n6xKEWpN6/H7hHlZ85cVevKREGVMvZIpvsNESnkwKw+MUyzYu3i774uG016zrLDz91pnlNl0
	Zs/FH0Uwcq6fIjWymSbEwQgXgc7Tk1jR5sznfz9Zi1zBA0Y4idph4FhQOL4Rkx9tQsckilwdEnO
	iAouFKQUqCZUh/4KPmkvSj4Jql3LEp0Tl4RgmTauuwV0oO9tUoE8uhwVMr0Cybs=
X-Google-Smtp-Source: AGHT+IHjTlUJ8udAjH/mkkQoHGmHBU7+KcdMu+hMBhRq6iTs6DPSX4yEs5XtvzKJa+RBjf2KhPoFlQ==
X-Received: by 2002:a05:6808:3507:b0:3f8:587:dacb with SMTP id 5614622812f47-3fdee93092fmr8770534b6e.9.1742278519108;
        Mon, 17 Mar 2025 23:15:19 -0700 (PDT)
Received: from aus-ird.tenstorrent.com ([38.104.49.66])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3fcd403b882sm2051642b6e.8.2025.03.17.23.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 23:15:18 -0700 (PDT)
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
Subject: [PATCH v4 2/5] riscv: implement user_access_begin() and families
Date: Tue, 18 Mar 2025 06:15:11 +0000
Message-Id: <20250318061514.1223111-3-cyrilbur@tenstorrent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250318061514.1223111-1-cyrilbur@tenstorrent.com>
References: <20250318061514.1223111-1-cyrilbur@tenstorrent.com>
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
index fee56b0c8058..d7fef81b7969 100644
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
+	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u64, unsafe_get_user, label);	\
+	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u32, unsafe_get_user, label);	\
+	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u16, unsafe_get_user, label);	\
+	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u8, unsafe_get_user, label);	\
+} while (0)
+
+#define unsafe_copy_from_user(_dst, _src, _len, label)			\
+do {									\
+	char *__ucu_dst = (_dst);					\
+	const char __user *__ucu_src = (_src);				\
+	size_t __ucu_len = (_len);					\
+	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u64, unsafe_put_user, label);	\
+	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u32, unsafe_put_user, label);	\
+	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u16, unsafe_put_user, label);	\
+	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u8, unsafe_put_user, label);	\
+} while (0)
+
 #else /* CONFIG_MMU */
 #include <asm-generic/uaccess.h>
 #endif /* CONFIG_MMU */
-- 
2.34.1


