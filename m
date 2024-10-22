Return-Path: <linux-kernel+bounces-375428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B1E9A95D4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 03:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F2871C21A73
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 01:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3A913AA2B;
	Tue, 22 Oct 2024 01:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="YKXmlGj1"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A274A136671
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 01:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729562362; cv=none; b=ZGAuHyLRX9/3xPgY1l7pwIK7FYUIk5qnUPYL6tD36Au73LovJzHul59GYWsA8dl/Lis4usgLfkT/u83RlfX0YcphYvUbGsMr7KWinqK1QYzvpFKIkAtl+Ww/ecgqmbfdo5P6QXXRIsEAQnawp2rozfoVA4kjKooKB4KTOpPM9DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729562362; c=relaxed/simple;
	bh=HSEfPsPiUBnxTzmMef4BmRun0qrOrmSw4r/gFQ8im9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t4OC0AhH6Jv1BR4sekg45SDCGkTXbopxzH4XaBszFCyLR/zMLnSQ7jdTlno+cdSpsdkXXvos4PJaUg8MgaTrS44e+bkKrUhB1XlAV4YXfGBhEV9J++DRzmE1BRSVbvpsWd1sOvPsxIEOQychOvFVA5AwSb2eCkBW9h1amBq/ioA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=YKXmlGj1; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71e49ef3b2bso3629397b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 18:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1729562360; x=1730167160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Af9tK0JLBBTeDXRGuA1c/z94Xn/abI+OOOquUfcf3I8=;
        b=YKXmlGj1yCHMTZkg32W4z22Tjh10uDMRCk6zDwMQ2OcsLx0JJH5T3ji2XwxtLOv204
         FTBBszHAnBtLQYIUMNg8yPExoCY9Qw1lsTPnTHfMzA+AEoMIhupbjTT52E/skXUpfDr1
         /k17S2willGI/LkP2up8ATFHiEPT3hqpWSf0gwZtN/I+GXxwsNafkAwAxnjO64MKQD1i
         L7KDJ1hqOXBSnmIPBpjD0jN1SrzDr/FN4W1cf9QI7JByPBNJEd5/1sWjpeJI/iWsUyvE
         bh+hU+NKJeCjoC1LWsBN9H08hGv4D7vbCA/0/omqEYxs8vdjM+rbQJ8ZVzA713KdScKo
         qzpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729562360; x=1730167160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Af9tK0JLBBTeDXRGuA1c/z94Xn/abI+OOOquUfcf3I8=;
        b=GaOVzfTAxh3703cKgVcIm7L0h2jtH7h2nDKzd5LDPWtw1JtpbthygL7NsGfRBt7gdO
         zDW0smHKR+gCBG0+E40F2dt2FnSvYvJFwBmkJZ6xCKb8QGQNFofIOE8ZxOnZ8e86lZii
         BZ08iuKZIFoJk/PC/DjbfNPogcZZeg7iyLXOLnUiXViIrdwZyG6I3JCZ3WsLNwSzHYNp
         uSVyer6xlEEApaeCsj8Px8kdqAT+ZSNIK1k7Wec9SSeQCYBF76tVnRXmT7bhv/jv0RMJ
         ng5ExIk9v6wm/OSKUcuor2wHRaDUlytNSzZwyrJSAzb7YRpYCRG6pLllAwaoWS1kIyna
         y05g==
X-Forwarded-Encrypted: i=1; AJvYcCVfgBq51gFLROJ7duDV/wvi1+CprnrXOxLKwkK3ixo3QZqhIcE88kJYx4Nop/5rgGk9epNeSt9HwaahK08=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDiugBFA47cT//tX79tzRdm/hCei03sGPEyVW4e+17hg9ia8PN
	pB+urr2jCHGmdOhSrijOaY5p35HFyOVy0EbMcJ8aT6hAN9tlwJ/rxhw46yfVpZg=
X-Google-Smtp-Source: AGHT+IH5wPAzHdVfv0MMInx9ySs4Jc9bkPSFs6F+LS8CNw/7mEjClw2+t/2vEVp2yPC3jOJm28L3Qw==
X-Received: by 2002:a05:6a00:4610:b0:71e:6489:d06 with SMTP id d2e1a72fcca58-71edb972451mr3011651b3a.0.1729562359943;
        Mon, 21 Oct 2024 18:59:19 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec132ffdcsm3600710b3a.46.2024.10.21.18.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 18:59:19 -0700 (PDT)
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
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Will Deacon <will@kernel.org>,
	Evgenii Stepanov <eugenis@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v2 2/9] kasan: sw_tags: Check kasan_flag_enabled at runtime
Date: Mon, 21 Oct 2024 18:57:10 -0700
Message-ID: <20241022015913.3524425-3-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241022015913.3524425-1-samuel.holland@sifive.com>
References: <20241022015913.3524425-1-samuel.holland@sifive.com>
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

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v1)

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


