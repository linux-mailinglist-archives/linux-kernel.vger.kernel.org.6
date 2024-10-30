Return-Path: <linux-kernel+bounces-388452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B92D9B5FE5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 11:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EBDE1C21541
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 10:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2CD1E4938;
	Wed, 30 Oct 2024 10:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nXMB3F2t"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B917C1E47DD
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 10:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730283517; cv=none; b=JXOeKZS8Cj37yAZS9SzpLW8pGCb7lxb1RdTLmJq223OcdDwhfrnKN/AK/mYecKL3O2u6xku9MTvYj5ZOth5ESx55ok+JkQ9rbFTJGXsI8Mu9x6Pl4TSCO1GQNsBa5NFY1CJpTXHmBWyCT7jm3RKMTb4oAeATzfOntSty8D+it5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730283517; c=relaxed/simple;
	bh=CAWOBa+/q8Fl95r1rKiNb6jU2ylK++oliRDXXg0Hfts=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=feiihbCkD8pGFPz+V1V5oQezL/n4J7agvX4XSgOR3ZWc9AyoIPbSveAS5LWe9n2plr7CmbCNZekXLCwnf3lSlbpoZGRAa/ZadV+Nw+UE34YVzjeqGiL+YH7FPFS/EWFfAJo3c53wiIZtCRqXvX6wLFLbdrEcww3N4H50SZOcHnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nXMB3F2t; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e29142c79d6so8541445276.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 03:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730283513; x=1730888313; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GiSNJuUVqUmThi4ywhxxBlIx/VAibAab/TSDDvzR4DQ=;
        b=nXMB3F2ttDYaoVdjZ9pHgsXTgD3eRQX8bvJe0mte/Qcx5tbzkh1+vXUS/dgE1zfOwl
         ZHpC+4QR7//NaI0CxoFnCcVyJqZUDiAQruRgBNU5KVfo1erZ4Z/FIKqvTeg/l106qw0p
         fpIK6Iv3wpx9ytiOB/dDhEx9luP/c/Iyz1Kf/OxssCf1Ho49jxycDQPhhDjy/7Ku2CkY
         173me2hF2R577zAyu8C07FRxW/Ml3ttGxrVXWP3SqKKV11hWeTJklsTGod/ARLfDHVdF
         AxQVkFo1OHWwKzV6rF+9Aum/iWqhUC72HNYgny+YwnkaRIrUOkeh5Ntz35yXdI+AgZkt
         K1cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730283513; x=1730888313;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GiSNJuUVqUmThi4ywhxxBlIx/VAibAab/TSDDvzR4DQ=;
        b=mvP78gl/WRonvS5wbikAc4zgOhRI935f4AB84KyyMbXF7HGsOj/h83D+BZk+iml2zH
         nCr/AARGdYzt9w0O+xaGv7+qgXF8P1+9YAKpr+L8c8kFMXxYyr2meKFs7Q3iznvQmImh
         exmmBeiQn3ccRk2G31+ktvpR+b4egBbcLSQ2tPAUBX1ll7rhjc3R7XXovQ5K857h5m4u
         l2l93GxhN1l0o2sll9jJJutau7m4dhbtBqo4bpz8bDWKHeErFcFZemPfzAjrJQQ/36zc
         VzdfyohfSTDMWUSbjVzmzWEGbzJJ0/GAOsnO+fnQryO83sc213R/wJMe7Oh/GofAfP/5
         xVtw==
X-Gm-Message-State: AOJu0YxYsTIPxb8zYpes5e9KGnm5sFTtRmcYMV9hEXy58t0B0/VlyJw3
	9Pbrxjar6jy9jwiQz3uJh75m9MGqYEArgZ+ntpCKePPDD5lZo0dpD51ofgMkXSZrgtzPyw==
X-Google-Smtp-Source: AGHT+IGnzByXmSferZ3znjFU1DAilPqK1hmhAoXGiKFphTF4R0E903gJtI58oxzNWHclXhOgvzUE8ntq
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a25:9c82:0:b0:e30:d445:a7c with SMTP id
 3f1490d57ef6-e30d4450d48mr1746276.1.1730283513173; Wed, 30 Oct 2024 03:18:33
 -0700 (PDT)
Date: Wed, 30 Oct 2024 11:18:07 +0100
In-Reply-To: <20241030101803.2037606-10-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241030101803.2037606-10-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2846; i=ardb@kernel.org;
 h=from:subject; bh=nfmkIc8BC3bWhOA+Opu1lUMycwYGYNKNBpiB1H0YnYE=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIV2J/UH+r80LJJV36/2bn/fVcbvkiewdvStu6spqL742U
 VLoXcOGjlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjAR3SKGv6IZp6KznvSxqaob
 LI4S9fjedylpPveSTdkKDSy8/9+2fmRkmHzAzrl1hl3Vm5i4GR/3zr74UM1a9uafK/x/l5StPxy 3iREA
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241030101803.2037606-13-ardb+git@google.com>
Subject: [RFC PATCH 3/8] arm64: Kconfig: eliminate 64k/48-bit VA combination
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Now that the vmemmap region is sized dynamically based on the actual
size of the kernel VA space, there are no longer any material
differences between supporting 48-bit and 52-bit VA space sizes for 64k
pages, which use the same number of translation levels. And if needed,
52-bit virtual addressing can be disabled at boot on systems that do
support it but where 48-bit virtual addressing is preferred.

The only remaining difference is the size of a root level user page
table, which grows from 512 bytes to 8k when 52-bit virtual addressing
is enabled, but given that both are less than the size of a page, this
is easily fixed in the pgd_alloc init code. (In all other possible cases
where vabits_actual < VABITS holds, the effective PGD_SIZE equals the
page size, and so this change has no effect.)

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/Kconfig  | 5 +++--
 arch/arm64/mm/pgd.c | 9 +++++----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index ac8e7550430b..6a73fd61b4aa 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -379,11 +379,11 @@ config PGTABLE_LEVELS
 	int
 	default 2 if ARM64_16K_PAGES && ARM64_VA_BITS_36
 	default 2 if ARM64_64K_PAGES && ARM64_VA_BITS_42
-	default 3 if ARM64_64K_PAGES && (ARM64_VA_BITS_48 || ARM64_VA_BITS_52)
 	default 3 if ARM64_4K_PAGES && ARM64_VA_BITS_39
 	default 3 if ARM64_16K_PAGES && ARM64_VA_BITS_47
+	default 3 if ARM64_64K_PAGES
 	default 4 if ARM64_16K_PAGES && (ARM64_VA_BITS_48 || ARM64_VA_BITS_52)
-	default 4 if !ARM64_64K_PAGES && ARM64_VA_BITS_48
+	default 4 if ARM64_VA_BITS_48
 	default 5 if ARM64_4K_PAGES && ARM64_VA_BITS_52
 
 config ARCH_SUPPORTS_UPROBES
@@ -1361,6 +1361,7 @@ config ARM64_VA_BITS_47
 
 config ARM64_VA_BITS_48
 	bool "48-bit"
+	depends on !PAGE_SIZE_64KB
 
 config ARM64_VA_BITS_52
 	bool "52-bit"
diff --git a/arch/arm64/mm/pgd.c b/arch/arm64/mm/pgd.c
index 0c501cabc238..ecc4b1ec235c 100644
--- a/arch/arm64/mm/pgd.c
+++ b/arch/arm64/mm/pgd.c
@@ -48,20 +48,21 @@ void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 
 void __init pgtable_cache_init(void)
 {
+	unsigned int size = PGD_SIZE >> (VA_BITS - vabits_actual);
+
 	if (pgdir_is_page_size())
 		return;
 
-#ifdef CONFIG_ARM64_PA_BITS_52
 	/*
 	 * With 52-bit physical addresses, the architecture requires the
 	 * top-level table to be aligned to at least 64 bytes.
 	 */
-	BUILD_BUG_ON(PGD_SIZE < 64);
-#endif
+	if (IS_ENABLED(CONFIG_ARM64_PA_BITS_52))
+		size = max(size, 64);
 
 	/*
 	 * Naturally aligned pgds required by the architecture.
 	 */
-	pgd_cache = kmem_cache_create("pgd_cache", PGD_SIZE, PGD_SIZE,
+	pgd_cache = kmem_cache_create("pgd_cache", size, size,
 				      SLAB_PANIC, NULL);
 }
-- 
2.47.0.163.g1226f6d8fa-goog


