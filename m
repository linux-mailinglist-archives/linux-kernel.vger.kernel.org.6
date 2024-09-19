Return-Path: <linux-kernel+bounces-333066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AB597C307
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 04:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF99CB223BA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 02:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54B4EEC9;
	Thu, 19 Sep 2024 02:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHpPGvpa"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1A02D611
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 02:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726714640; cv=none; b=ZxFAEAkb94AQu7d6KPrT2y2bsLFhHkuQ4FQf5VVXyxi4BAijhXgBYT6CxfD3PP6fl/RH2FRwjcwPKcPBFUhRnpjhDvtQg0OwVYhI3oxnesYiWiTrXL6q0+ASjhrBGyrS+K2CeBNMZ2iaCckRdnD5ksXnOeaO92p9KnJ4Uy41PJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726714640; c=relaxed/simple;
	bh=IrvocGPAGOkqMhnkbOHlfXSKlsgjDUpOdoDHwplLjvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B0OGiaUh+StDudk6KqoElKs9RGJ77tyig7TY+yCvmtK+skipwB0QDm9z2Lz3OY6sxjuUK5eY9CqvnlNp6HO2/AB5JjnCZFzM1+bXzltTqEJ8Sp5YlMqOiQdHnoL1iyi+u1U5kD53mJVySjVJQkqol0jLKrS0JoemIWbUk1Hyt4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DHpPGvpa; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-208ccde82e6so3158935ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 19:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726714638; x=1727319438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AV6BxL5gMqFPtklTutfX47z8PwIuU3wFqvoyRitrLCw=;
        b=DHpPGvpaMRK5let+p6SuU2zIRyhiP6z2olKV68met5ghc3PQ11dKd54g5nogXUQMLO
         /vTObbFihh9fLmyM1kKK1+oSBNRoveYyCYK6Xo8fdG2AK2w5UL6oLVLLr+EN8uC3P9xp
         AKxbUwWQWM7n/Qc1SPdiQHnYKpyFFrFRr9erBXZNoG8an4b49OABh9cGBFzuoAlyQzJy
         NwebU+yh62knaPqJEXOiYrjXnbkwO/NY5n9aW5ornU7rCOM2leJqHfzp13CBIZf6g0ml
         FqnmuJAQbiBILmIEpbU/Uqyt5DT4Fx3yzH+HFKLOnpX1lOidhYUapxKXowgQWB9rLD8m
         apVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726714638; x=1727319438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AV6BxL5gMqFPtklTutfX47z8PwIuU3wFqvoyRitrLCw=;
        b=buNfMNWS2847GCXKb5ltosxyGJq5upS2j81VcgZtAqHpQcwnEavkW34K2Af+Asnc37
         HirsooSRU0XyZgIajW2El+JsUQfdJfB/bN/roDhCC13LtdnNnoAP7Lvu9dclfMKncibn
         m/buABrvV4fEBmQi8mokm3OpFaLc4wl+6DsGDRsnhXrl/vkCCFGEOhxqC0CLZ95ibywU
         ZKcqQYNlwzqLwnB92egZvfL0tOG/hdLrPLGumzocHr7FvMX8Jxv1F831MiGP7FJ567bG
         C6EcxIXg33z2oNYsFjBNAm3EAadyXrtqpuwVKc0NKu47JS6V6AADXCH+4cPVO1btnmHm
         u+ZA==
X-Forwarded-Encrypted: i=1; AJvYcCXHE8D3+/x9mMGEUYJ7hXeHSUqkKpKyuJ6qiVe0t00tE4ZuvsxDGQ/KQmWeb86HQAs6xy/2qiywkY6b9S4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz39Y66SVIgHWO1rN4CMkm3clB0v1MiRLAmdcNpnslwgIknDmKy
	I+gcEssLcxzCQ3a/Q7ul5mQI727l0Zoc3bKB1WfKecjvLsSAlhSD
X-Google-Smtp-Source: AGHT+IEcNBq8l5FK/5juI+RUhRkCIsvdP0Nu+zueXcpdJJCPT6m3f88Yiku2lxjEo/N6lofe8UkElQ==
X-Received: by 2002:a17:902:e545:b0:205:7db3:fdd1 with SMTP id d9443c01a7336-2076e3b7821mr382291845ad.36.1726714637877;
        Wed, 18 Sep 2024 19:57:17 -0700 (PDT)
Received: from dw-tp.. ([171.76.85.129])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946d2823sm71389105ad.148.2024.09.18.19.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 19:57:17 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Hari Bathini <hbathini@linux.ibm.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Donet Tom <donettom@linux.vnet.ibm.com>,
	Pavithra Prakash <pavrampu@linux.vnet.ibm.com>,
	Nirjhar Roy <nirjhar@linux.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	kasan-dev@googlegroups.com,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC v2 11/13] book3s64/radix: Refactoring common kfence related functions
Date: Thu, 19 Sep 2024 08:26:09 +0530
Message-ID: <0711340e9050001020c284154064b3a4cf781045.1726571179.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1726571179.git.ritesh.list@gmail.com>
References: <cover.1726571179.git.ritesh.list@gmail.com>
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
index 9b4a675eb8f8..85875820b113 100644
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


