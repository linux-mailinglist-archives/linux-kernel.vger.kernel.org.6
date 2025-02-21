Return-Path: <linux-kernel+bounces-524945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C8BA3E903
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 01:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B07DA17E4A9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 00:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E13779EA;
	Fri, 21 Feb 2025 00:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="WycCcGS4"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A686BA50
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 00:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740096571; cv=none; b=t+lSBzcBk+azvgd8N+t3XMB4JnA98Kaq7jzDsVCi4cdRLh6GHUsexnzebAo1SkmSocg8WHv26ixvw9XU8v+9jTsCIlvCVgFyue6/L+YJIgBUPvY3dGzD8jSu7CESovEvIrnd/6E/eu45Jv6SQXc+cyxatJt/gm5+CL+MiFWkAQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740096571; c=relaxed/simple;
	bh=VggzceCPBii46RbE0l34G01cdRhcCActrNbfcOljT7w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bYTlEbFYBcaZdDatxyj/cBzbnsYyijCUHwC00mvKj8zZ8ymWyltKIcyDI3tymgr/wNRDsym02d2NZl1vgEWxUQ+fzqRjHEHvIWLCVT2l+gddUD9+St+6zjQfJGTLxmtjEGKTIzHy97NWG/C9JPVvkz9W6AhC5qB84SLITDLcN0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=WycCcGS4; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2bc607b33d5so857348fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1740096567; x=1740701367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ynQVfR/dFk01f+alSHWcouno+EVl3KD0yb8OXJAhnGc=;
        b=WycCcGS4Me9/ilDac+iLEw/DzPVkJFEdjjhePFX1/D8Bi/SxMB99FdRmHVcjWlhGdF
         BpTH6XTjnBmv6dPFZ5e7SQFti72EUJ1Af4IBT5m7mujdE9LRP/bYHrNqyqLSGsnb7gdz
         zaGrmE3hOlk4358koKqwI8bCARnwbzQp87v+XnARCKxDApJISX9TBzFGDhkTchZiL7rv
         1107YODm53+awPetybOr0QT+W/qXSFmEdRjTvZjzwXkG1s2ObpupT7AEnh8n4Jb9P04L
         JRJVBc0Vk1ruRx/vkuBA3E8KY7+jKoXlaHYHbZJpWKLol2Kd2jtUVfvTs/vLfACJ3G1L
         rSKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740096567; x=1740701367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ynQVfR/dFk01f+alSHWcouno+EVl3KD0yb8OXJAhnGc=;
        b=E4mn9a9Ez7hNoHDjJlDu0T2/ltIEoe8BVqz4fVDbREPYljWnFNEeO5pstzCmEfVN/d
         DUnt8fJicBOKuui4iSg7vXR60cpTQv44hl4Rsc+c3Wxf5hsZ0WCrabDivJQOoZTIDHx0
         heE+tApDvHrPZVKWX9fxpURYDs9w2appQ3EWeGl3cs2tjlgt1REsxgucWfwyNyTA+jYw
         xIA6LR8endAiGPn8/UF0KIteCWz+MM9diEcyV4FCxL1t2BYM0ezHkoLw9g+MD/QKPEql
         Q7qT8fJiKuzuHycogvZO/1DZca/PLbNKJbC6oY5IQuseAkx4CISFM9Li1cO0Ak62vOJk
         uh9w==
X-Forwarded-Encrypted: i=1; AJvYcCXlGVYGsExD2nodZbIlASsY0jApUFnRDn7AKzNc6ouMD/zPj6T+w3ixsHHco2ttQhRC07HsluzNTDWfpJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCq7lNkbpkLHvZ/zhsdlVVEtk4jCyzCaGikZ26Tfgw5nl548sp
	U8N/gFs/9Qb7h5NUAb6ZuDMyjgga705Qj6J7Tu3VXkHNCrhhcmg6QjMVJY7kCw==
X-Gm-Gg: ASbGncusVcAdVzIWP1tSXAcoue04zQ1JGxW4LxetseM1nR0j/haIWQXj/iU8k0e8SnF
	F7HlhQ5wYuAYV+Cj3xueX+IgsdkEt23Gpr2SwH80XG1UjQOWjhI2z9xJ+rymRRbZGvPPNtKQAnH
	Rrr2S0kULN41TWg/RDBx/z5HFfmNBnMOPR0zcrAipRMPFqHXDGHg3mbf1RoGEMSRmHSaj9P0txa
	Y+j5nXWwY4rNWn6xShz2CMxt9fW4m/FRw79+c7lfzSEdVIt9rtAg3ofLa+THLpxzn7x0LVWP7CA
	gz0JUcvS3NLe1hivZkF/M8cbb/ZkLs5CEg==
X-Google-Smtp-Source: AGHT+IFhyE2QRwXal+GO2Cm8WYvshkYyOzXF4EFDI4EcmkmeGlVmtYav3txhL7PD6lMOsijhkF4Ggg==
X-Received: by 2002:a05:6808:384b:b0:3f4:b0c:ab6 with SMTP id 5614622812f47-3f42469dfc3mr1403840b6e.1.1740096567630;
        Thu, 20 Feb 2025 16:09:27 -0800 (PST)
Received: from aus-ird.tenstorrent.com ([38.104.49.66])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f40b027906sm1573401b6e.42.2025.02.20.16.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 16:09:26 -0800 (PST)
From: Cyril Bur <cyrilbur@tenstorrent.com>
To: palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	paul.walmsley@sifive.com,
	charlie@rivosinc.com,
	jrtc27@jrtc27.com,
	ben.dooks@codethink.co.uk
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jszhang@kernel.org
Subject: [PATCH v3 1/4] riscv: implement user_access_begin() and families
Date: Fri, 21 Feb 2025 00:09:21 +0000
Message-Id: <20250221000924.734006-2-cyrilbur@tenstorrent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221000924.734006-1-cyrilbur@tenstorrent.com>
References: <20250221000924.734006-1-cyrilbur@tenstorrent.com>
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
 arch/riscv/include/asm/uaccess.h | 63 ++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
index fee56b0c8058..43db1d9c2f99 100644
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
@@ -368,6 +381,56 @@ do {									\
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
+#define user_access_end()	__disable_user_access()
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
+	if (__err) goto label;						\
+} while (0)
+
+#define unsafe_get_user(x, ptr, label)	do {				\
+	long __err = 0;							\
+	__inttype(*(ptr)) __gu_val;					\
+	__get_user_nocheck(__gu_val, (ptr), __err);			\
+	(x) = (__force __typeof__(*(ptr)))__gu_val;			\
+	if (__err) goto label;						\
+} while (0)
+
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


