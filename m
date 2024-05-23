Return-Path: <linux-kernel+bounces-188056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F82E8CDC59
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 23:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8AF51C232ED
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 21:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312F3127E30;
	Thu, 23 May 2024 21:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ha/k6JC7"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D17AD2C
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 21:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716501053; cv=none; b=KZBxSPG2HYRqFIZl77iwwZxbJFh02iVIL3T+WLX0wgSBFgCYhZvaomXYYbNUhyN0eqfTqmV0S09rQMnwzVGLOpcN/pNjE1tT5IG6WYx3E6ARFThJttjatAXMdnV6msLODPl/lXHOlAooQQAyuCx2+2M6Ux+a0yEMlttNIt946Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716501053; c=relaxed/simple;
	bh=fNMYSSsAJRBo4fs0gdkSV2BYwikfeE91Y4o8L9Z1cLc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=RcRlj+KpR9barw0ALhXVyEn6pr/VZkVAKf0EHo7q1Up8YpiRSZNPjEKUVVqk4F+09VlnRTdCwYn+ux2MeeXyk673c6CbYjfPanJ+IKsOEyujRli/XRPaZ6d9ZvU0l6CL3iYV0+cjr0Yh8q/6b9ubNCu6SS41FhsyooU+TBqdWHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ha/k6JC7; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a6267778b3aso13309366b.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 14:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716501050; x=1717105850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cL3CjB9yMkr+C9cTAGf3ev6sBpUayp6G2aVmnb0yyJM=;
        b=Ha/k6JC7V3EQnKOcnrkKE2LaZbNjtEZieyXua9GA1zqooLjvhZ8CjFLXGAhK7LDkil
         lSbUHLVFoiridWyXW7xfLKQwELgG2yjcjwJO+7xHWMbAmjxQMbhTE6Or/6QJfSdExdYc
         ZnXI5BTwv63VZTjIipYAtu87wZBcEBreU248MV57sKF+i09znp6+Y6CIlpbti0aFtHAW
         OT2cxr3nD9z3qPi1rDSIDWmKnyTzEq5IttnkGwffZJfypNKJY3LcnJlG3D7sG9vvVNfx
         yjAnYZBEMY2zlIBMrQ/f3O9Um5X9px44R/S9A+RygTvf/eq7mn7p/RD6oKnRaH9FddDC
         IKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716501050; x=1717105850;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cL3CjB9yMkr+C9cTAGf3ev6sBpUayp6G2aVmnb0yyJM=;
        b=PcwFGVCDddMWuXDNlJQHglkBizKtlteF5j3olohKav+KE5I/Jt/9ctWBGAjx64jPuQ
         +Hwk0J5NL7ZvCxCgyc/IMQp2x6v+RFoYv7+wGncWuC6DCyZr1NY7xsrTixAOkXWkKQ4q
         2oH1DQUx1pOss7HP5nO2rJlR9nU6OcrO1dVKcF9Snp6A8nYqzeUqzmZ6DeqMcs0S3uV8
         HGIwNYaj0TYKQ3RzHajgigvv+aHbayjrdLvY8S4mO0tqaHBSAF2vS9POdhY+OTPXhOy2
         EOsN2wLBHKTfi51XrWLuHZmFUQwCVWN5l91vCoJdSaci9oJjlJ0z2PGYnJkwkRMjnxBN
         H+1Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/kA22NhHkWck9DbSwqx7Z/UYN7hKzU/YIO3RdYOgeu2z0Fl7y0uj+//9JAxHJaftHZIo85q4liuzDpQJTzY7PMec977hRf7+rS/5y
X-Gm-Message-State: AOJu0YynOJbK0IgolwmNWSFbWQCRdxUut+43MGlLW5g9oYXmc2qVUTKT
	CrJr0ckJHJOlV+83mj7jJ/Oh9Gf5mD1qUaWtfXwTnDzP3StJuvGk
X-Google-Smtp-Source: AGHT+IEC29YV+fMUmucu9I5TgwKcefAI5pI1xIvRh1BI4PbX9ZTy6D9SemY9LzkPKBy+JescYy+cvQ==
X-Received: by 2002:a17:906:a252:b0:a58:eba0:6716 with SMTP id a640c23a62f3a-a6265128466mr23580566b.60.1716501049956;
        Thu, 23 May 2024 14:50:49 -0700 (PDT)
Received: from rex.hwlab.vusec.net (lab-4.lab.cs.vu.nl. [192.33.36.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cda9248sm14971066b.225.2024.05.23.14.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 14:50:49 -0700 (PDT)
From: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
To: Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86: kmsan: Fix hook for unaligned accesses
Date: Thu, 23 May 2024 23:50:29 +0200
Message-Id: <20240523215029.4160518-1-bjohannesmeyer@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When called with a 'from' that is not 4-byte-aligned,
string_memcpy_fromio() calls the movs() macro to copy the first few bytes,
so that 'from' becomes 4-byte-aligned before calling rep_movs(). This
movs() macro modifies 'to', and the subsequent line modifies 'n'.

As a result, on unaligned accesses, kmsan_unpoison_memory() uses the
updated (aligned) values of 'to' and 'n'. Hence, it does not unpoison the
entire region.

This patch saves the original values of 'to' and 'n', and passes those to
kmsan_unpoison_memory(), so that the entire region is unpoisoned.

Signed-off-by: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
---
 arch/x86/lib/iomem.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/lib/iomem.c b/arch/x86/lib/iomem.c
index e0411a3774d4..5eecb45d05d5 100644
--- a/arch/x86/lib/iomem.c
+++ b/arch/x86/lib/iomem.c
@@ -25,6 +25,9 @@ static __always_inline void rep_movs(void *to, const void *from, size_t n)
 
 static void string_memcpy_fromio(void *to, const volatile void __iomem *from, size_t n)
 {
+	const void *orig_to = to;
+	const size_t orig_n = n;
+
 	if (unlikely(!n))
 		return;
 
@@ -39,7 +42,7 @@ static void string_memcpy_fromio(void *to, const volatile void __iomem *from, si
 	}
 	rep_movs(to, (const void *)from, n);
 	/* KMSAN must treat values read from devices as initialized. */
-	kmsan_unpoison_memory(to, n);
+	kmsan_unpoison_memory(orig_to, orig_n);
 }
 
 static void string_memcpy_toio(volatile void __iomem *to, const void *from, size_t n)
-- 
2.34.1


