Return-Path: <linux-kernel+bounces-432973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C29139E5287
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7939F284E41
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236AA1D4600;
	Thu,  5 Dec 2024 10:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="OoWhgIVU"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DE41DACB4
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 10:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733395081; cv=none; b=R7TioWbHX9pMBQKRDPdAvaPpsrmXD731GqvYzu2BiVbg9ic4nQ2eIjsce7Y7kwzt0Zj3T/0iIoCqnATP7h74h9S8hqTQU3RccLPTxoZ9QMPK1dP/RhfWW0sW4NGKOGY4U7oClxjxVFcRnvsnWXUH/q8bNqed4BV0N64sUg8loyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733395081; c=relaxed/simple;
	bh=Vm9Zkyv13t259pbyXmOKGdd1ewdyriURgjYtEXU6Jc0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gE9PMC5YDFIGjORDhqMpnRWM8i+gDMdr0GZo8iuMlM55BrqEYAURxu4HAxLM+EZJftL+7w2o0FqBbsqUpp91LI922kzlGwvQMa79NfMzurpH0E/ww04tUqOP0hg1WKwv9u7S0SpirZw9koDFbSVK/VhBqecCdEtGDZWC0dbdA3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=OoWhgIVU; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7fc22a88bcbso609494a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 02:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733395079; x=1733999879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qR1jHqy2cDl06AgpV8oSKqeRVPpykz0hiLJxVMX/VM=;
        b=OoWhgIVUaX73GDZdtsN/xgz6J7uPp9UO3QkM5upoNXgphW2o/UlCzPyL8EVs4j6mdV
         cCtJDDdqM5QzNmi6yoNiPPByFSCJr0SzahyU0k90SWUoxQVT8Iymli7MnLU7cFrWnY8c
         27Y8wmi/sZhxKypUCTL7GzzzXtGPEzxYhHWJ086JDX/iRXU3AN5Uoq9l+sQtkqnFloX4
         EpTxT8ZBmTW0SboZEB6OAFAimcIQgIKsL5uZey2vgdXegsaLN/iK+vrgBkR09toux42u
         K4FjiHSJM8Az8pYssvupVL2LoGOLje3ReQ1EH6rg/9YYiskLdYenLZS/VwMUe3D2bbnp
         S1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733395079; x=1733999879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7qR1jHqy2cDl06AgpV8oSKqeRVPpykz0hiLJxVMX/VM=;
        b=bp3+3P2l+utIqN3N3oIuIa7VdMioTBXaxbbpTLOKbOsTipB7nOM5FtYVGMGxYeYcHl
         p3VhWZbYtsZxQA13BvvdzXvA29hMbYkYDvK3lCj81rW4DY4w2PuBnFbRNM2fie9X9Kaq
         f51K1zWzgc6zlIA7+yek9jOEWB/TPF7IOE4EZNVOkkELDC8ePg/N8j2UYlQ0hNdNMJdi
         7mPV694P+ljMYTt6+Z85M/CU16clyTnIJCpjFIPY517Fi1X9N9VQK2vBDXxYvR8jQApR
         /7zhOk/2hymso9RhnKG5q5cTM3zmqIhv1Na+yjgazJRJZAouZwwUU+s5W85G72c2dd2D
         pH+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVcfHnfVv2FN3uhlBIYwe9epR13e07i1dBT8Jr350vaduVcMzinQyGVPi9W5l1acxfZLDcBgiz9Tq8zpaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzShhkXhvuzfnnlf89bEnIL/neif8FQ1Y8/8mFmQs+cI1FTlBCj
	PJNbOSk/Fv7sAPjHeGgBHdNvNaDPv7YzqANSCQGuXDctRLldYGZEetXZKAz8dJc=
X-Gm-Gg: ASbGncsipUcxCD+b2QtTjbCeK5z7jcMaql9Gs20C3KBkWnmbUwTN2810t76hDnC6hDP
	iLqdf5tPMQ3wI2Ku9R1pz086m84KIBPSNOcLrGybfbvvZwEi7BbYtpheg9wtF2UntFCEddacyYZ
	uI30qshI1YXO2aRRFkPgHSFkOqiDrzrPEO+SPmdxahXJyvDGGsoenKR7toQK+vsjGLSaOqCzUSF
	5Pn+HPHdJf0lToBa5yjkn1fHNSD9iPTtuzM8Ned8Aufe+gis0FYLzfN42LpTzQP7rXLBHVtb2k0
	hm3Bk+BEe18YfQLnPkAV9wdt4O4aGhDr
X-Google-Smtp-Source: AGHT+IEUKSwiJ64FZ3Pe2Otsaz2xFzyoQCTrZnVdkwgamPJ8aR60BE+SnfSU6DdJI6PGfNndTdnNkA==
X-Received: by 2002:a05:6a21:99a2:b0:1db:e358:48a8 with SMTP id adf61e73a8af0-1e1653b91d0mr15785669637.10.1733395079129;
        Thu, 05 Dec 2024 02:37:59 -0800 (PST)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd156f048csm886826a12.39.2024.12.05.02.37.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Dec 2024 02:37:58 -0800 (PST)
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
Subject: [RFC PATCH v2 05/21] riscv: mm: Reimplement conversion functions between page table entry
Date: Thu,  5 Dec 2024 18:37:13 +0800
Message-Id: <20241205103729.14798-6-luxu.kernel@bytedance.com>
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

Some code will convert high level pte into low level pte to reuse pte
functions. For example, pmd_dirty() will convert pmd struct into pte
struct to check whether it is dirty using pte_dirty(). As pte struct at
different level has different constructor now, we can not apply pte
constructor during conversion. Thus, this commit converts ptes by directly
converting structure type.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/include/asm/pgtable.h | 81 ++++++++++++++++++++++++++++++--
 1 file changed, 76 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 1d5f533edbd5..f7b51c52b815 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -309,6 +309,50 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
 	return (unsigned long)pfn_to_virt(__page_val_to_pfn(pmd_val(pmd)));
 }
 
+#ifdef CONFIG_RISCV_USE_SW_PAGE
+
+static inline pte_t pmd_pte(pmd_t pmd)
+{
+	return (pte_t)pmd;
+}
+
+static inline pte_t pud_pte(pud_t pud)
+{
+	return (pte_t)pud;
+}
+
+static inline pte_t p4d_pte(p4d_t p4d)
+{
+	return (pte_t)p4d;
+}
+
+static inline pte_t pgd_pte(pgd_t pgd)
+{
+	return (pte_t)pgd;
+}
+
+static inline pmd_t pte_pmd(pte_t pte)
+{
+	return (pmd_t)pte;
+}
+
+static inline pud_t pte_pud(pte_t pte)
+{
+	return (pud_t)pte;
+}
+
+static inline p4d_t pte_p4d(pte_t pte)
+{
+	return (p4d_t)pte;
+}
+
+static inline pgd_t pte_pgd(pte_t pte)
+{
+	return (pgd_t)pte;
+}
+
+#else /* CONFIG_RISCV_USE_SW_PAGE */
+
 static inline pte_t pmd_pte(pmd_t pmd)
 {
 	return __pte(pmd_val(pmd));
@@ -319,6 +363,38 @@ static inline pte_t pud_pte(pud_t pud)
 	return __pte(pud_val(pud));
 }
 
+static inline pte_t p4d_pte(p4d_t p4d)
+{
+	return __pte(p4d_val(p4d));
+}
+
+static inline pte_t pgd_pte(pgd_t pgd)
+{
+	return __pte(pgd_val(pgd));
+}
+
+static inline pmd_t pte_pmd(pte_t pte)
+{
+	return __pmd(pte_val(pte));
+}
+
+static inline pud_t pte_pud(pte_t pte)
+{
+	return __pud(pte_val(pte));
+}
+
+static inline p4d_t pte_p4d(pte_t pte)
+{
+	return __p4d(pte_val(pte));
+}
+
+static inline pgd_t pte_pgd(pte_t pte)
+{
+	return __pgd(pte_val(pte));
+}
+
+#endif /* CONFIG_RISCV_USE_SW_PAGE */
+
 #ifdef CONFIG_RISCV_ISA_SVNAPOT
 #include <asm/cpufeature.h>
 
@@ -728,11 +804,6 @@ static inline pgprot_t pgprot_writecombine(pgprot_t _prot)
 /*
  * THP functions
  */
-static inline pmd_t pte_pmd(pte_t pte)
-{
-	return __pmd(pte_val(pte));
-}
-
 static inline pmd_t pmd_mkhuge(pmd_t pmd)
 {
 	return pmd;
-- 
2.20.1


