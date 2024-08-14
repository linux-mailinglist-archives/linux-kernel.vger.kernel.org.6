Return-Path: <linux-kernel+bounces-286141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE4F95172A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45689286425
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 08:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9C21494B9;
	Wed, 14 Aug 2024 08:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ZPNLao6K"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CD9144D15
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 08:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723625786; cv=none; b=q5mnpfOtXk8YNjInOVaJuyXmJf3P9LH6F5au9ObaQ5R0BbL/h1KlcEbBUQ4X064rKVVXxPXZP2fn1WqX8apJHPIDV2iFw8HrclUSAsbhyxqBK6X+HeVQD6hI5K4cSQvKfeiBoDDjyLPSpyQDMrZRLkHO+eqOcP/Np1RWOTs3S7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723625786; c=relaxed/simple;
	bh=QNPV6YAxAwjPr8tRapnFeYxKReX2lKJudVzzSx9QcNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eTWQgY5ZCO8LJO9ZymhW3WreWoGGSlxdeomNRpjiTdvTQ3UCB7LSrQI0FhMVBlVrsIANU5dlw5qJKuZStH/4dYm2WAyKfDVTz0UBGmOz2AXEW6C15uUel8iiXqm7BfVQl3N8Xz6hQo7fF+1BCr8IHzQlNs+/+xJWbBGpL9V9b+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=ZPNLao6K; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fd69e44596so4831535ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 01:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1723625784; x=1724230584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FOU7P9jn4wor6Rdt5JEa4HOxmny7NogNXhx9YRYE+tY=;
        b=ZPNLao6K7d04vCt4GbEAq7uH9+Pf3TgnIjHJ0DIRW2LIfnm2IcpTfyl2aBlyyKuws5
         jCvxU1/EKpcaX4sMWRezhmHKoGZcCFsvGeYHJ5VmHdPpdQKFwMxjJGqyFyDozGDXR/LA
         YMR+9rms2ay86hAUQoaJfAyBhRAvSIIZ0o8/jDupbvK02oWDSq1PgeT0Z2nhe6UmogpS
         T4JaR2aFJ+a+pxMZStiV5uI/r+RxxSNbThOeh8R6jxtnvCYkWe45tVLQJAXPpkYSmDZb
         PjGdNTZz3JxitDtAGQkbvRtfriKegaHfHkTpsCBHKQ36oDyvkyX8Ffj/uz4qwJXZ3VPH
         V7sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723625784; x=1724230584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FOU7P9jn4wor6Rdt5JEa4HOxmny7NogNXhx9YRYE+tY=;
        b=DqM+Gpc6SpT1b3XVMjf7kibUctv2gNcAKnE3oTXVyA3+pM1HVL0kCyGlbzCguW69Z/
         BoK5kVn9NBLZe+JDhZWVKE90Dn7nx8/ouNi8DJNhGo0Q+kocWiv/irmjlCu2fD8BJ7Rm
         5SS5GUC991MHfs93zX8ZxUSIIVcZ9wB8mN6IMo6ew4PVIYBWK9Y/AlNDMNBmkUkbLy46
         UIjtgNZ6PPgyo/amkfriuYrtyYqpQ7/gG1hyLWRCmzYGaiuq0qH0YI5FO6A0GHUa/yIg
         MrIClSGC55IE3CkD4dbf2Pxvd56ie+9sTwdMRBGvLTlqICGokEV9gInuG9xCCxxe/emH
         Paqg==
X-Forwarded-Encrypted: i=1; AJvYcCXvTssb4dUFzFdyRZRv9VrHW65DqJMIuTROnRi7/K873xG6tswTsGaUHnzXNQVrMMJS+zSk/M819QEdW1EFoS3aA6/HbE99NoDUrR+G
X-Gm-Message-State: AOJu0Ywfa4Hq2tdCjP5PZ1PXdLlh/AEeLZXzEgQHNCfhy3Gyt2HjVXxL
	rOw4YJO9ClID2mlTD/JXo6Q4dJ9VpbBOKFuIKTpL6hYubggOLYjzAdqKNeHeabA=
X-Google-Smtp-Source: AGHT+IHtUXL6qE88NcA742NNnvRZ3OwS1PEsV1FbKiWQihqr5xxMbeis8+zR2wt/Qw0zy68klcF0mw==
X-Received: by 2002:a17:902:e741:b0:201:dc7b:a88f with SMTP id d9443c01a7336-201dc7bae70mr15567155ad.25.1723625783955;
        Wed, 14 Aug 2024 01:56:23 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd14a7b8sm25439615ad.100.2024.08.14.01.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 01:56:23 -0700 (PDT)
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
Subject: [RFC PATCH 2/7] kasan: sw_tags: Check kasan_flag_enabled at runtime
Date: Wed, 14 Aug 2024 01:55:30 -0700
Message-ID: <20240814085618.968833-3-samuel.holland@sifive.com>
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

On RISC-V, the ISA extension required to dereference tagged pointers is
optional, and the interface to enable pointer masking requires firmware
support. Therefore, we must detect at runtime if sw_tags is usable on a
given machine. Reuse the logic from hw_tags to dynamically enable KASAN.

This commit makes no functional change to the KASAN_HW_TAGS code path.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 include/linux/kasan-enabled.h | 15 +++++----------
 mm/kasan/hw_tags.c            | 10 ----------
 mm/kasan/tags.c               | 10 ++++++++++
 3 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/include/linux/kasan-enabled.h b/include/linux/kasan-enabled.h
index 6f612d69ea0c..648bda9495b7 100644
--- a/include/linux/kasan-enabled.h
+++ b/include/linux/kasan-enabled.h
@@ -4,7 +4,7 @@
 
 #include <linux/static_key.h>
 
-#ifdef CONFIG_KASAN_HW_TAGS
+#if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
 
 DECLARE_STATIC_KEY_FALSE(kasan_flag_enabled);
 
@@ -13,23 +13,18 @@ static __always_inline bool kasan_enabled(void)
 	return static_branch_likely(&kasan_flag_enabled);
 }
 
-static inline bool kasan_hw_tags_enabled(void)
-{
-	return kasan_enabled();
-}
-
-#else /* CONFIG_KASAN_HW_TAGS */
+#else /* CONFIG_KASAN_SW_TAGS || CONFIG_KASAN_HW_TAGS */
 
 static inline bool kasan_enabled(void)
 {
 	return IS_ENABLED(CONFIG_KASAN);
 }
 
+#endif /* CONFIG_KASAN_SW_TAGS || CONFIG_KASAN_HW_TAGS */
+
 static inline bool kasan_hw_tags_enabled(void)
 {
-	return false;
+	return IS_ENABLED(CONFIG_KASAN_HW_TAGS) && kasan_enabled();
 }
 
-#endif /* CONFIG_KASAN_HW_TAGS */
-
 #endif /* LINUX_KASAN_ENABLED_H */
diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index 9958ebc15d38..c3beeb94efa5 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -43,13 +43,6 @@ static enum kasan_arg kasan_arg __ro_after_init;
 static enum kasan_arg_mode kasan_arg_mode __ro_after_init;
 static enum kasan_arg_vmalloc kasan_arg_vmalloc __initdata;
 
-/*
- * Whether KASAN is enabled at all.
- * The value remains false until KASAN is initialized by kasan_init_hw_tags().
- */
-DEFINE_STATIC_KEY_FALSE(kasan_flag_enabled);
-EXPORT_SYMBOL(kasan_flag_enabled);
-
 /*
  * Whether the selected mode is synchronous, asynchronous, or asymmetric.
  * Defaults to KASAN_MODE_SYNC.
@@ -257,9 +250,6 @@ void __init kasan_init_hw_tags(void)
 
 	kasan_init_tags();
 
-	/* KASAN is now initialized, enable it. */
-	static_branch_enable(&kasan_flag_enabled);
-
 	pr_info("KernelAddressSanitizer initialized (hw-tags, mode=%s, vmalloc=%s, stacktrace=%s)\n",
 		kasan_mode_info(),
 		kasan_vmalloc_enabled() ? "on" : "off",
diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
index d65d48b85f90..c111d98961ed 100644
--- a/mm/kasan/tags.c
+++ b/mm/kasan/tags.c
@@ -32,6 +32,13 @@ enum kasan_arg_stacktrace {
 
 static enum kasan_arg_stacktrace kasan_arg_stacktrace __initdata;
 
+/*
+ * Whether KASAN is enabled at all.
+ * The value remains false until KASAN is initialized by kasan_init_tags().
+ */
+DEFINE_STATIC_KEY_FALSE(kasan_flag_enabled);
+EXPORT_SYMBOL(kasan_flag_enabled);
+
 /* Whether to collect alloc/free stack traces. */
 DEFINE_STATIC_KEY_TRUE(kasan_flag_stacktrace);
 
@@ -92,6 +99,9 @@ void __init kasan_init_tags(void)
 		if (WARN_ON(!stack_ring.entries))
 			static_branch_disable(&kasan_flag_stacktrace);
 	}
+
+	/* KASAN is now initialized, enable it. */
+	static_branch_enable(&kasan_flag_enabled);
 }
 
 static void save_stack_info(struct kmem_cache *cache, void *object,
-- 
2.45.1


