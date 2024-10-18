Return-Path: <linux-kernel+bounces-372127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 488329A44C2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 19:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68F7D1C21A6B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E78205ADA;
	Fri, 18 Oct 2024 17:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BdCBp7la"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402D8205AC6
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 17:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729272675; cv=none; b=bUIcJ8UPFeZIh8lNrf+zMml49hOq/36qKH8qPE6YgxAgjzhs0xbpCBCxYGXnNmiSr6nw75hsdwRmqsWsk6Lhjw9/28EGwYnOHQO5iXGAlYsgfLjVxY9Ey8kej0Isw74EBhAcUVVyLiqDCr1kFdgOdTWXbAN2BjhH6KaSuhmNOzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729272675; c=relaxed/simple;
	bh=OtgBNzwT10q1fgJ73my79dtV2veuEsi813cYK1MYapI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cych6q8TS/0sf1gMAs3Vt7bdb6RaY6NZ4AI1xiPU/niVxK7I3NTAsBvMv49KWB2CVJhNHCwbs8+mc7kndcDewrdjsMgPMKcTFfvsY3cSBbqHtP48INMCU359gsalWHp1dkpGDxpXWZiorhHvJFKg9VJ4alttuxS0krCiKCwTtg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BdCBp7la; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7ea0ff74b15so1592197a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 10:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729272672; x=1729877472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=maqsHecWoRrqy0atrv0EioRwOZB99TyG0W2HP4lfnAU=;
        b=BdCBp7laJl9ycTaWhrrR/hUZfz/XPh/fUh4VqhkuSUQzB23NhxIyA60nhPspxtjydk
         ZVWBZLtMgYO7i8EMT6EHcFUP1Z7NVvP8a/esxdpZ895IIXfn2+K5M1JNIMhCfK8znAfq
         g8h4hTy0DNSYEbNTK1YgLtd0psgcV5WljTnj25dlEhEmcH+DRDghDqt0rC25aJZq/D5G
         6uc9iJbjAC7ctHKKwgjVQbYE1kjS2hpS2CbTD/HpDvUuP0y8CGo/JeJWt0H4WQi7BgW8
         jCOAf4sWxXK8DMA04dLdAh3Q+JmkzkoUhsLyAeqRd8WcTNp/lxHplMiELo90ygIIKBw9
         o7hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729272672; x=1729877472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=maqsHecWoRrqy0atrv0EioRwOZB99TyG0W2HP4lfnAU=;
        b=Nj2IXXX0ew9TE5fWvwZgqpD5fe6WilNQB009dU2sBXWfv3m0niEqhzWkeouy380yRM
         yFDXvKlQ8p2FTIJL7pzX0AxrDORYtPlaBQPy0Z7eAzIDlnH14DpVMXaL5tKLJvuep99N
         6PvkQ4DSrhr4Se9fVChImjgRo5jjVP6Oj5EoQs6H4LwKfy6IxC63yVU5ecrGR+O8a8Cw
         7KWMaEwwU+3YcWByHZVLafaL3wee792zEMxrarWNNH4stlk0ZdDAqI3iCh4hMxlbjPes
         5Okt2cwCw2od8btkSmHP245FE6oEOtNidAND/9Wuh0jRHGrd7q2QtOwJnKKkSzEomgUm
         cjKg==
X-Forwarded-Encrypted: i=1; AJvYcCW5hoxL4QPYekgGzobr+75ZejmcxO+TK7/W0wC5AjuP6HuhGepKImBm1LT15O+dJncuUVC9odTL6abp9Oc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ+Aa4N+ntQmP29bkvUXW3NkQEPySaxRgJc+vdMglKJSqm4UwB
	ZGyH4/GEUqJ8AK0Uxy+gtI1t+ifuggzPUNfDhfziAis4E5xSfUST
X-Google-Smtp-Source: AGHT+IGCcfcvV3hhkWCRVZ4L4+07qgofxPBOFcgBhHnT233XbATfjI7cFHkLMcuk8gJsatcgaCUiZQ==
X-Received: by 2002:a05:6a20:43a0:b0:1d9:a90:8879 with SMTP id adf61e73a8af0-1d92c502994mr4770966637.21.1729272672394;
        Fri, 18 Oct 2024 10:31:12 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([171.76.80.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ea3311f51sm1725242b3a.36.2024.10.18.10.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 10:31:11 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Hari Bathini <hbathini@linux.ibm.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Donet Tom <donettom@linux.vnet.ibm.com>,
	Pavithra Prakash <pavrampu@linux.vnet.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v3 10/12] book3s64/radix: Refactoring common kfence related functions
Date: Fri, 18 Oct 2024 22:59:51 +0530
Message-ID: <f4a787224fbe5bb787158ace579780c0257f6602.1729271995.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1729271995.git.ritesh.list@gmail.com>
References: <cover.1729271995.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both radix and hash on book3s requires to detect if kfence
early init is enabled or not. Hash needs to disable kfence
if early init is not enabled because with kfence the linear map is
mapped using PAGE_SIZE rather than 16M mapping.
We don't support multiple page sizes for slb entry used for kernel
linear map in book3s64.

This patch refactors out the common functions required to detect kfence
early init is enabled or not.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/include/asm/kfence.h        |  8 ++++++--
 arch/powerpc/mm/book3s64/pgtable.c       | 13 +++++++++++++
 arch/powerpc/mm/book3s64/radix_pgtable.c | 12 ------------
 arch/powerpc/mm/init-common.c            |  1 +
 4 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/kfence.h b/arch/powerpc/include/asm/kfence.h
index fab124ada1c7..1f7cab58ab2c 100644
--- a/arch/powerpc/include/asm/kfence.h
+++ b/arch/powerpc/include/asm/kfence.h
@@ -15,7 +15,7 @@
 #define ARCH_FUNC_PREFIX "."
 #endif
 
-#ifdef CONFIG_KFENCE
+extern bool kfence_early_init;
 extern bool kfence_disabled;
 
 static inline void disable_kfence(void)
@@ -27,7 +27,11 @@ static inline bool arch_kfence_init_pool(void)
 {
 	return !kfence_disabled;
 }
-#endif
+
+static inline bool kfence_early_init_enabled(void)
+{
+	return IS_ENABLED(CONFIG_KFENCE) && kfence_early_init;
+}
 
 #ifdef CONFIG_PPC64
 static inline bool kfence_protect_page(unsigned long addr, bool protect)
diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
index f4d8d3c40e5c..1563a8c28feb 100644
--- a/arch/powerpc/mm/book3s64/pgtable.c
+++ b/arch/powerpc/mm/book3s64/pgtable.c
@@ -37,6 +37,19 @@ EXPORT_SYMBOL(__pmd_frag_nr);
 unsigned long __pmd_frag_size_shift;
 EXPORT_SYMBOL(__pmd_frag_size_shift);
 
+#ifdef CONFIG_KFENCE
+extern bool kfence_early_init;
+static int __init parse_kfence_early_init(char *arg)
+{
+	int val;
+
+	if (get_option(&arg, &val))
+		kfence_early_init = !!val;
+	return 0;
+}
+early_param("kfence.sample_interval", parse_kfence_early_init);
+#endif
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 /*
  * This is called when relaxing access to a hugepage. It's also called in the page
diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index b0d927009af8..311e2112d782 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -363,18 +363,6 @@ static int __meminit create_physical_mapping(unsigned long start,
 }
 
 #ifdef CONFIG_KFENCE
-static bool __ro_after_init kfence_early_init = !!CONFIG_KFENCE_SAMPLE_INTERVAL;
-
-static int __init parse_kfence_early_init(char *arg)
-{
-	int val;
-
-	if (get_option(&arg, &val))
-		kfence_early_init = !!val;
-	return 0;
-}
-early_param("kfence.sample_interval", parse_kfence_early_init);
-
 static inline phys_addr_t alloc_kfence_pool(void)
 {
 	phys_addr_t kfence_pool;
diff --git a/arch/powerpc/mm/init-common.c b/arch/powerpc/mm/init-common.c
index 2978fcbe307e..745097554bea 100644
--- a/arch/powerpc/mm/init-common.c
+++ b/arch/powerpc/mm/init-common.c
@@ -33,6 +33,7 @@ bool disable_kuep = !IS_ENABLED(CONFIG_PPC_KUEP);
 bool disable_kuap = !IS_ENABLED(CONFIG_PPC_KUAP);
 #ifdef CONFIG_KFENCE
 bool __ro_after_init kfence_disabled;
+bool __ro_after_init kfence_early_init = !!CONFIG_KFENCE_SAMPLE_INTERVAL;
 #endif
 
 static int __init parse_nosmep(char *p)
-- 
2.46.0


