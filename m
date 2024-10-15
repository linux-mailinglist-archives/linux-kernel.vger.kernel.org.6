Return-Path: <linux-kernel+bounces-364970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 912E699DBBE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 03:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4A111C22281
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 01:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2681C1714B5;
	Tue, 15 Oct 2024 01:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvPbvqy0"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7FF18BB88
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 01:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728956082; cv=none; b=pz/mk8OE0BdvOX5NJaL8+NeIpCPL+WOTqcrt/Nc0OYOqlL7Y9RbPxNmo7yVAaPnHHjaAOJ/E6iosuLA071Jkck0pDlOQOpzMa9V6w2sQ8tpp5Kgx6QUVBrbx4AJuuuA9YbVC6tDNQ1grSAzi5g4HiyiF1B/NeDQnB4SGlE0a9LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728956082; c=relaxed/simple;
	bh=fMHk4IyW0Ffe4ScDjse+ggRYbCEftOSHs3jid3aXfU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IEW8oisHyewmLjzTOB7irwCWmu3HatGurwkezbtE4x0twNqsfMjna9etZw7n5qR2tntvCkAtvfPc/4usbj8POWs/QWIc2C98K4DzPbpWckLj4a0iZ7CTRcoYwL0DlsOa9+CKe7LwGEgcp6eNENgWeF9Iu8EnJwwmW60TG+RfrSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JvPbvqy0; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71e70c32cd7so717787b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 18:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728956080; x=1729560880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vbK+DyWhNFTOskVhv1fyi/tJ2PP4Ej6g6TRuPbyIjZc=;
        b=JvPbvqy0zbDDCf6wIolTcQdaqbSX0iGz5s5XHreqyE+VN0t6NASXf+KjndiVaLH9Oz
         nIThrUg/vd22n8f/85wAwOnE4FJT1AEkxfMLZwwsO7C1hnEsMTG+NFd4daIOUgfBwC9X
         VG2CFcKKpfwOgKK1AvKJ79oQ1OzCDat+UiAlCWeAf7fMC1S0bx+hBbyd16CbHBnG/3O1
         GDvFRQa2g8k2jJi3vNj3tzsrZDLA0JRnwFoFoFCOVf1ePjaYwZEWdL1XiBFWoWF8pwaw
         gghRMtavYYT5f5yPRA38Y7MGIzP7OQ/MklH1MzwYe8Wahdrv5jOImmXxvclZk3xw7+ul
         5kNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728956080; x=1729560880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vbK+DyWhNFTOskVhv1fyi/tJ2PP4Ej6g6TRuPbyIjZc=;
        b=lsQ0nJKjrmrW2o9JkBwh/fFF5VrX7PpaFjN48DGkbT/OYvZlPf3Ul2SXMvU9ilm0wU
         kHZJ3n9Ps+yD8sPGwS6nTzKhn7EBye7Y6VLiu50312O/rKnwjx6B74BBUR7Z4ImdOXUO
         zYzP4ikaO+D07AbchURKtJ0bYxfcpWYd980JcVeYFPsmjk8+rtcj68Gult3I06J5ykgd
         TFPjBTsTVJJQZ+AhgLFYh1a1fVrIA3fTFJub1STwGivdyUmNCNcIAqK03eLwZXxU2eeZ
         p/hC7JDWBhv9gwDD+XkRe7wJO4/tiY4Ad+VT9kGXaTGFxhUJmab+wSYKNfHZPRs1XA7n
         MUog==
X-Forwarded-Encrypted: i=1; AJvYcCVQTwi/fHaCZOOLvlUk4EF1V+apSuk2uJ7zwrkI8H08UpqahTK3Ymexs7FRx9lhvCvUb75dl1mhJUyPemI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpIEqCA8r+dQjLkwtRmKA4gnRAIJX7jnfp6LOBAgxAg3ngvzp7
	LE/CvMElkUrrswWjIhpYBKkgUp0xb0CkMpcM+gYhnQfXF5/UCA5c
X-Google-Smtp-Source: AGHT+IHF1r2QtlGKVN6HtXXxcFg+k0gYJd/nSgLWyKs83ZTBLQXCdo//6FQThWun5q5jEjrAv0//bA==
X-Received: by 2002:a05:6a00:189d:b0:71e:768b:700a with SMTP id d2e1a72fcca58-71e768b7107mr1328450b3a.23.1728956080395;
        Mon, 14 Oct 2024 18:34:40 -0700 (PDT)
Received: from dw-tp.. ([171.76.80.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e77508562sm189349b3a.186.2024.10.14.18.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 18:34:39 -0700 (PDT)
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
Subject: [RFC RESEND v2 11/13] book3s64/radix: Refactoring common kfence related functions
Date: Tue, 15 Oct 2024 07:03:34 +0530
Message-ID: <a0ebddc6250441d7750c9f94f7d1fc64db406b20.1728954719.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1728954719.git.ritesh.list@gmail.com>
References: <cover.1728954719.git.ritesh.list@gmail.com>
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
index 5a4a75369043..374542528080 100644
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


