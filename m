Return-Path: <linux-kernel+bounces-432974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF399E5288
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2662F18823CA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1E01DE2B3;
	Thu,  5 Dec 2024 10:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PMiUc5nt"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB601DE2AC
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 10:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733395085; cv=none; b=dFnC9YepkoD4w/MXtDw85XxSQCC5USKPBqji7q+OHKcZnl045JP0XcTHdQ21ph3zOFh4TXKUgVr5bvOVhB0yQwSk/kdvh2Da1I88l4RjMIOKTg28HRuZor43BiLJ/76mK6YoHTyyp4Sl6RBHppZaMdbRE7wk98UffEeKUSAAXRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733395085; c=relaxed/simple;
	bh=n5ObmEMSgZ6wjmUYK4IExflSlCXOnNpiwrBV7NJsDhs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qRgutOiMYeAi4iFEnRHBtgfD2506+bHbt72cdtXWa1m2716rIguuQkGV5AKlyJ+tF5RrXtO9WMdFUhtw38WrWxAO029jXq/3NucjWQDgJ+Ji7Ar2qIRBZ8GD+E9ZrAnnK7+C5QPmH14YCq6oypeteUQZJM6JTOKTzFce4iUpxpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PMiUc5nt; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-71d46ace74aso371754a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 02:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733395083; x=1733999883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XbXb8+gIbpPc0seecsAjhzRbpNpiwhPRJnpv+Yg3m9U=;
        b=PMiUc5ntK1X3HF5d6pDLQvBXxh4+o13sxAcg9wThcutXqhn6LImGc7Zyvx8wP3nZsp
         fbzfj9Q9lnzd/kGAiyL/mOczEZ9E3IR3SZ0nAVtQhYrJIrPMT/PMYjw9/yGpXt2X8XwR
         RE8e8gFoGk5+mamE+91Mma0A8PUhuYD0G6BRkJXe+9COBo32zrqZahkCJxfzlxKSBAoo
         p2/KQwuU7xboMFmYKyg7x+hCxI518cUvFIwWcOMTh6fOjxvLb1U1AUQnvZ1lWFEUPfgm
         1dnu8QENuw58jbFy6qQCSHKY4r8JAUeosVkykc8p4oBZ7QxHaI9bZo2N7KWpt4uBPUXO
         p6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733395083; x=1733999883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XbXb8+gIbpPc0seecsAjhzRbpNpiwhPRJnpv+Yg3m9U=;
        b=tdvDrT1lMMm9e8mrhq/sW2ii1keBRiZKaK4405edLkrIWco5DShWQbZHvL2MVldJ3n
         ll4yhNUU+AikJPyFYOw3oYE6cUaQIwrW1MR46ynE/K8uGiCbq03SsZsYEiJTfl0w5yBO
         6WKas+6WZ7PCTIG4tBDVOwNL2pKG6kWAqoseZ2cI+OgLP67otT0oJUVqQ/A4jgQUGMw8
         2u+E+rMKQVGcXa33GQkFr/mm8yyoZHgpbycYCKvI1+G3R8UoRmTOi9CTndExFxmgn78F
         Xe5EbbfdzgcoWBBjFMFHwsDsPRWfvawdupFXvi+gmiD7cI28zNzaYuuss810/dDUXGK0
         YDwg==
X-Forwarded-Encrypted: i=1; AJvYcCWYd2xpWeeA7dvSQfs7Pv2m7dQyMZfyfgjbjKUdNMx4c7pbya+eLePdgNbSPyzgrGBrpSo869H+FV25tPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfHkTbrKZB97mQSSJat9s9av/xr1TImpahlI/lwNLUg0QTD1N0
	OvJq5NGyhwqO82qTRyl4jFmwgSBk2v4rWg2OpmzRLU77ih1tvbHMloDlpa8L17Q=
X-Gm-Gg: ASbGncuwCvCx6aEeSw1ztYp1tCZ/dwLEXKY6iFoeBpfvPkgueYfg5qkwsJB4Z9GsI/F
	EHtpmTpB6wtiL+kYhTpoccYHzAKCu5/lXrrchICaz4ux3VjX8Ny6P4A2j1bQgJZPczttWE69OAg
	kFgodd7S89ysvJOXqdi76282JuXcmu9sUcR2NJjyXp10wwo/RpyZRNt6QXPceKT8H8z82pxsSww
	LJSW4BfgiSbiVZoHSlPmh7wKDliCYkEJQPuXQKZrj0eU4Qsjwvy/ZyBPjYC0smvD0OTdKtL5ync
	pBJDMjtfrivD5OyPnrrZIKvdLBm229/y
X-Google-Smtp-Source: AGHT+IEx3vS74gMj6raF1dIqh7j7ldd5iu4wb4DU/N4Y4QqLjAI1/NclGnjqcHYWmLe9eo91DygJAQ==
X-Received: by 2002:a05:6830:d1a:b0:71a:6c7a:e23b with SMTP id 46e09a7af769-71dad652d39mr12397021a34.16.1733395083206;
        Thu, 05 Dec 2024 02:38:03 -0800 (PST)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd156f048csm886826a12.39.2024.12.05.02.37.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Dec 2024 02:38:02 -0800 (PST)
From: Xu Lu <luxu.kernel@bytedance.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	ardb@kernel.org,
	anup@brainfault.org,
	atishp@atishpatra.org
Cc: xieyongji@bytedance.com,
	lihangjing@bytedance.com,
	punit.agrawal@bytedance.com,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [RFC PATCH v2 06/21] riscv: mm: Avoid pte constructor during pte conversion
Date: Thu,  5 Dec 2024 18:37:14 +0800
Message-Id: <20241205103729.14798-7-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241205103729.14798-1-luxu.kernel@bytedance.com>
References: <20241205103729.14798-1-luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit converts ptes at different level via directly converting pte
type instead of using pte constructor, as ptes from different levels has
different constructors.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/include/asm/pgtable.h | 52 +++++++++++++++++++++++++-------
 1 file changed, 41 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index f7b51c52b815..d3da8aee213c 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -351,6 +351,26 @@ static inline pgd_t pte_pgd(pte_t pte)
 	return (pgd_t)pte;
 }
 
+static inline pte_t pte_set_flag(pte_t pte, unsigned long flag)
+{
+	unsigned int i;
+
+	for (i = 0; i < HW_PAGES_PER_PAGE; i++)
+		pte.ptes[i] |= flag;
+
+	return pte;
+}
+
+static inline pte_t pte_clear_flag(pte_t pte, unsigned long flag)
+{
+	unsigned int i;
+
+	for (i = 0; i < HW_PAGES_PER_PAGE; i++)
+		pte.ptes[i] &= (~flag);
+
+	return pte;
+}
+
 #else /* CONFIG_RISCV_USE_SW_PAGE */
 
 static inline pte_t pmd_pte(pmd_t pmd)
@@ -393,6 +413,16 @@ static inline pgd_t pte_pgd(pte_t pte)
 	return __pgd(pte_val(pte));
 }
 
+static inline pte_t pte_set_flag(pte_t pte, unsigned long flag)
+{
+	return __pte(pte_val(pte) | flag);
+}
+
+static inline pte_t pte_clear_flag(pte_t pte, unsigned long flag)
+{
+	return __pte(pte_val(pte) & (~flag));
+}
+
 #endif /* CONFIG_RISCV_USE_SW_PAGE */
 
 #ifdef CONFIG_RISCV_ISA_SVNAPOT
@@ -537,46 +567,46 @@ static inline int pte_devmap(pte_t pte)
 
 static inline pte_t pte_wrprotect(pte_t pte)
 {
-	return __pte(pte_val(pte) & ~(_PAGE_WRITE));
+	return pte_clear_flag(pte, _PAGE_WRITE);
 }
 
 /* static inline pte_t pte_mkread(pte_t pte) */
 
 static inline pte_t pte_mkwrite_novma(pte_t pte)
 {
-	return __pte(pte_val(pte) | _PAGE_WRITE);
+	return pte_set_flag(pte, _PAGE_WRITE);
 }
 
 /* static inline pte_t pte_mkexec(pte_t pte) */
 
 static inline pte_t pte_mkdirty(pte_t pte)
 {
-	return __pte(pte_val(pte) | _PAGE_DIRTY);
+	return pte_set_flag(pte, _PAGE_DIRTY);
 }
 
 static inline pte_t pte_mkclean(pte_t pte)
 {
-	return __pte(pte_val(pte) & ~(_PAGE_DIRTY));
+	return pte_clear_flag(pte, _PAGE_DIRTY);
 }
 
 static inline pte_t pte_mkyoung(pte_t pte)
 {
-	return __pte(pte_val(pte) | _PAGE_ACCESSED);
+	return pte_set_flag(pte, _PAGE_ACCESSED);
 }
 
 static inline pte_t pte_mkold(pte_t pte)
 {
-	return __pte(pte_val(pte) & ~(_PAGE_ACCESSED));
+	return pte_clear_flag(pte, _PAGE_ACCESSED);
 }
 
 static inline pte_t pte_mkspecial(pte_t pte)
 {
-	return __pte(pte_val(pte) | _PAGE_SPECIAL);
+	return pte_set_flag(pte, _PAGE_SPECIAL);
 }
 
 static inline pte_t pte_mkdevmap(pte_t pte)
 {
-	return __pte(pte_val(pte) | _PAGE_DEVMAP);
+	return pte_set_flag(pte, _PAGE_DEVMAP);
 }
 
 static inline pte_t pte_mkhuge(pte_t pte)
@@ -612,7 +642,7 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 
 	ALT_THEAD_PMA(newprot_val);
 
-	return __pte((pte_val(pte) & _PAGE_CHG_MASK) | newprot_val);
+	return pte_set_flag(pte_clear_flag(pte, ~_PAGE_CHG_MASK), newprot_val);
 }
 
 #define pgd_ERROR(e) \
@@ -1017,12 +1047,12 @@ static inline int pte_swp_exclusive(pte_t pte)
 
 static inline pte_t pte_swp_mkexclusive(pte_t pte)
 {
-	return __pte(pte_val(pte) | _PAGE_SWP_EXCLUSIVE);
+	return pte_set_flag(pte, _PAGE_SWP_EXCLUSIVE);
 }
 
 static inline pte_t pte_swp_clear_exclusive(pte_t pte)
 {
-	return __pte(pte_val(pte) & ~_PAGE_SWP_EXCLUSIVE);
+	return pte_clear_flag(pte, _PAGE_SWP_EXCLUSIVE);
 }
 
 #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
-- 
2.20.1


