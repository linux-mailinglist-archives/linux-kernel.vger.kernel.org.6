Return-Path: <linux-kernel+bounces-286146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D18495172F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8AD01F25E67
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 08:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9736714B943;
	Wed, 14 Aug 2024 08:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="dFL29Ifp"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBE614AD0C
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 08:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723625794; cv=none; b=nvuZaNqr3CDesTHI5TZAyLTA6hOUCKunCQyoBMxTZBwpleoqDdsDnWKcbM3YwDm3OyqIHZmz3PixTS2UFipt6AXKPjY3yWw4uWu6Xbt3largNQiEK4ywaod6PVPiVQgz7bnBuw1HV/VYD1o6z07xnubOwgwTaGnuZwUAb9hCBlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723625794; c=relaxed/simple;
	bh=geArp4vYpOuxeLfSy4kt6ZtrgC6/R3zfTRXVcdxhuWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gsSu9VOEIDTohZJ/q022VuohelfYk55vKlX0Cgqz0czc2qijOTE2M29RFtIaQC2Rz7Zycl6BWIoHLHQkQv+yXHdoXmw7BNGa54CqmfEpwln+lEpS10X6sNXqodtngff58X0YVc4p9B7hGMvpOMOxGI6XIJuem00Uyzqey99rcfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=dFL29Ifp; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fd78c165eeso51138265ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 01:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1723625793; x=1724230593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9hz49lwxt/ore9sEZ/uYZptf0bZHlG9fVMF8g6BZbdk=;
        b=dFL29IfpyaGAY64wYINowXBUIhXplg6sZU09wO1knUB6YujqQYMGDMSa8ZvkNEVhUs
         YCSQH1XQFBG+pgcsT7NPhDpQPy2QhanzPqT6HHBahCZx8xPEl6kJly7cLLU9TLvTSyVU
         PlEGSof9B09/8y+U81EQaTkDX+ZkqwxI8iMJPrq9/OS5kXwsvWi3iGc2+fHipuRGwuw7
         GhWEEQRncvRltZ+ZWqcfcDksCILpr05bAylz/lJalcoxfHTO6fNY1SO2BJOMmtfscSKe
         BLTEp7ryWT1VSRIc7CAfLds+g8titT0Me6RQbLTjH+253f+Mu2HQ9tS1UCHdLwtnL0NO
         Ajzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723625793; x=1724230593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9hz49lwxt/ore9sEZ/uYZptf0bZHlG9fVMF8g6BZbdk=;
        b=MiPzHkNhI6b2pB9MUtoeUadJ1lSECBcZbMEATqFg4UH+R4T5NLksHNgh4LFM+Wqtb/
         T6XpfE5zFQ+4j60OZ2ieWP5Pl1zMLharZLNjOAg6eoyMwzlDrkCku0uKeVcfBrjSibJU
         UnguQrP+04SJ09/nj4t8ooWz9wj+Ixi1+63tYSCM3+KUzFrrDE8Dc6AXL6w//7VTLwCa
         ze0L4XRzxTMSsFt+MovbuAzhLbMTNYS3OudQ0vkrcV6vOr+N9XETfiPowZLSCM+s9ZwW
         1erhQfjC75B8VgUQsEXEUj614ohoPbX3iq2Sj2O1sbs0P3VAe+dEnSfJSWwfQEJVO+OW
         g2Vg==
X-Forwarded-Encrypted: i=1; AJvYcCXhN7vWidiv1DTbDXBP6dh8cj9JLBQvbHCTsi3Rc2MyvMXH6saHqjLVYxbNQIf0uPCZfXpBWc1UPc8QD6URhIGS5GTCSGNEoUTGNHG0
X-Gm-Message-State: AOJu0YyU0AstgRk8HFzx3ywJoKZwFGa3NPYnjsGLLvJTNTMLopdlk+LQ
	+Sg6zkWP0GVWFzKkgYGaHz3NKHnG6kRh8/jBx/kPBmmPVdCDA2dZa6ZqwN+zX2c=
X-Google-Smtp-Source: AGHT+IEjBmXCU7mNTlJDHLEXVaA9qjlxh2UbxM2PLdod3xVt/jyJ0BnNxQ5PpAdVoFfN1q2eB+NLCQ==
X-Received: by 2002:a17:903:1c9:b0:1fc:2ee3:d46f with SMTP id d9443c01a7336-201d638d797mr29420295ad.11.1723625792838;
        Wed, 14 Aug 2024 01:56:32 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd14a7b8sm25439615ad.100.2024.08.14.01.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 01:56:32 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	kasan-dev@googlegroups.com
Cc: llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Evgenii Stepanov <eugenis@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [RFC PATCH 7/7] kasan: sw_tags: Support runtime stack tagging control for RISC-V
Date: Wed, 14 Aug 2024 01:55:35 -0700
Message-ID: <20240814085618.968833-8-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240814085618.968833-1-samuel.holland@sifive.com>
References: <20240814085618.968833-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This allows the kernel to boot on systems without pointer masking
support when stack tagging is enabled.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 mm/kasan/kasan.h       | 2 ++
 mm/kasan/sw_tags.c     | 9 +++++++++
 scripts/Makefile.kasan | 5 +++++
 3 files changed, 16 insertions(+)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index fb2b9ac0659a..01e945cb111d 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -630,6 +630,8 @@ void *__asan_memset(void *addr, int c, ssize_t len);
 void *__asan_memmove(void *dest, const void *src, ssize_t len);
 void *__asan_memcpy(void *dest, const void *src, ssize_t len);
 
+u8 __hwasan_generate_tag(void);
+
 void __hwasan_load1_noabort(void *);
 void __hwasan_store1_noabort(void *);
 void __hwasan_load2_noabort(void *);
diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
index 220b5d4c6876..32435d33583a 100644
--- a/mm/kasan/sw_tags.c
+++ b/mm/kasan/sw_tags.c
@@ -70,6 +70,15 @@ u8 kasan_random_tag(void)
 	return (u8)(state % (KASAN_TAG_MAX + 1));
 }
 
+u8 __hwasan_generate_tag(void)
+{
+	if (!kasan_enabled())
+		return KASAN_TAG_KERNEL;
+
+	return kasan_random_tag();
+}
+EXPORT_SYMBOL(__hwasan_generate_tag);
+
 bool kasan_check_range(const void *addr, size_t size, bool write,
 			unsigned long ret_ip)
 {
diff --git a/scripts/Makefile.kasan b/scripts/Makefile.kasan
index 390658a2d5b7..f64c1aca3e97 100644
--- a/scripts/Makefile.kasan
+++ b/scripts/Makefile.kasan
@@ -73,6 +73,11 @@ ifeq ($(call clang-min-version, 150000)$(call gcc-min-version, 130000),y)
 CFLAGS_KASAN += $(call cc-param,hwasan-kernel-mem-intrinsic-prefix=1)
 endif
 
+# RISC-V requires dynamically determining if stack tagging can be enabled.
+ifdef CONFIG_RISCV
+CFLAGS_KASAN += $(call cc-param,hwasan-generate-tags-with-calls=1)
+endif
+
 endif # CONFIG_KASAN_SW_TAGS
 
 export CFLAGS_KASAN CFLAGS_KASAN_NOSANITIZE
-- 
2.45.1


