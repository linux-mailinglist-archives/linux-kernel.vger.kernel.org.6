Return-Path: <linux-kernel+bounces-259549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FE0939832
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 04:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51FC4282257
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 02:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2AC139597;
	Tue, 23 Jul 2024 02:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="B0mA4hE7"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739E514287
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 02:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721701110; cv=none; b=qEGzPmsLyVq8F5M326FTzVKwVoZ2xdoOrqX92ULbf3Q7hiwjlkcnozpSVUFOkJpafPNkvXTcuoFYsyheb5mwu1ZKHtasss7ZE/Hiv5XjFbY+5T7G9+BSnQIMcOD39aJCsdJOg+NRau4GcFiQrJehlPa+2wbN08JAf40sPSYo3fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721701110; c=relaxed/simple;
	bh=TlFQ+RF9GqZyMqb1C2jFg3WDPDZBtU0oF+7pi8SS8Po=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZJ0EQRo68EJwV4iAnv1kPRK8rXqIaMO6SunLodUoWlcM7E60XfX4MVUWX+/HGaC5AjeJdjrl5gQnld32oVqfFzSlaxmN+gyS0msxT4Mh2+0ux3nqFN5Esm2vWOkQH9vi9CLeDyYZQDQT4gJGecMNoWP7yCK0UNgb1EHqCygtQro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=B0mA4hE7; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fc692abba4so2296515ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 19:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1721701109; x=1722305909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jCOgQc9KD2XGZH574ODgjuwFya0AxvNADd4TgDpsqGY=;
        b=B0mA4hE7PcyAN6vxGTn9uvRZ6aLKaJuY2TwqpfbKozSjJiLdsob9aW3iRIOWrOmnGp
         IenKm8seIoxAkE+LXqRg4Ub7R5F/G/1AZt4PchXYFRl+q1WLVd0dNE0u/wFLdd+YxyXF
         WY/ickH1z7jmlb4yaomBB509GyG2yfHJPSm6qdOx1ZA2mdXMIGbgmfBJzIJuJTNF4iJ1
         LW7ju3OGS6A8j++ezgLVMvOPq2vzG7pim3Ve0CDdc48F0lCnktA2c6zsUNuUFmB36FdG
         1YIuAhWXxL2iRp1OSX102OrALxERd/uZnB4tSMTmOakDV/LG3Td1mCu69KidVDa7OqZ4
         iPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721701109; x=1722305909;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jCOgQc9KD2XGZH574ODgjuwFya0AxvNADd4TgDpsqGY=;
        b=N1gyVpqjB4Yp5zWVyH2JZF71lhxZ+KzAB+iHmT6/oy4vAjQ4gSUjJfICBZpTGZOwTY
         tYEcAhGnxgm7pEOEbPDJ91wfahtYGOWcQpaJGqBZHyY5hy6TqLLIDAvpPki2LR95LITx
         ICQBeHlcAKt5Fs67Mdr3T3Gtyu9O6/w02F7ONfq5cvXIkGikA77QcYXA4kyqLE6Wwu8l
         2D9wOlYkkNysK0doZ5ZgomQlAFyjcK/+YMCSw/E3+tUeF2xQf15KywL0mtidZy6aQqFC
         vcWk79KbM+ZMRIbSqNJSexW7hcbyzcOo21LiJWPqKbeONXKBju1gbXAdlJjLwPOJeoaP
         BKsQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0pFdkX3Y9RlUxPpaLIqhJbnvjNDHQZO0YlZZs2DlA2t/o4RYAHlS0yvoOO+tQ7vb2Jx+F/VXVYpepJNU5vC+Psm9L71WhazIg9mJF
X-Gm-Message-State: AOJu0YwO2Lr4wU3o5yTl6ldLqe5LrfQZ/0aAeIC9BBol8aldHYRC4GF0
	BScosx9UZ+Br6JcH12WSZMd3r33wD3ogab6bHP/Oqs4hAH3OFFL3LAfFoCqBzis=
X-Google-Smtp-Source: AGHT+IHLVAW18zN+0gBUE02az2jmDMGy7YkWcLa5yHJa8UE1dySgQEyZHI7Dqpt3Zk8tPEcJDeKN4g==
X-Received: by 2002:a17:902:e885:b0:1fb:8e25:e631 with SMTP id d9443c01a7336-1fd74520f53mr68006945ad.8.1721701108701;
        Mon, 22 Jul 2024 19:18:28 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f31a2d8sm62496825ad.121.2024.07.22.19.18.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 22 Jul 2024 19:18:28 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: conor@kernel.org,
	punit.agrawal@bytedance.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	akpm@linux-foundation.org,
	surenb@google.com,
	peterx@redhat.com,
	alexghiti@rivosinc.com,
	willy@infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Yunhui Cui <cuiyunhui@bytedance.com>,
	Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v3] riscv/mm/fault: add show_pte() before die()
Date: Tue, 23 Jul 2024 10:18:20 +0800
Message-Id: <20240723021820.87718-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the kernel displays "Unable to handle kernel paging request at
virtual address", we would like to confirm the status of the virtual
address in the page table. So add show_pte() before die().

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/mm/fault.c | 52 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 5224f3733802..c72e6c7c09ef 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -22,6 +22,57 @@
 
 #include "../kernel/head.h"
 
+static void show_pte(unsigned long addr)
+{
+	pgd_t *pgdp, pgd;
+	p4d_t *p4dp, p4d;
+	pud_t *pudp, pud;
+	pmd_t *pmdp, pmd;
+	pte_t *ptep, pte;
+	struct mm_struct *mm = current->mm;
+
+	if (!mm)
+		mm = &init_mm;
+
+	pr_alert("Current %s pgtable: %luK pagesize, %d-bit VAs, pgdp=0x%016llx\n",
+		 current->comm, PAGE_SIZE / SZ_1K, VA_BITS,
+		 mm == &init_mm ? (u64)__pa_symbol(mm->pgd) : virt_to_phys(mm->pgd));
+
+	pgdp = pgd_offset(mm, addr);
+	pgd = pgdp_get(pgdp);
+	pr_alert("[%016lx] pgd=%016lx", addr, pgd_val(pgd));
+	if (pgd_none(pgd) || pgd_bad(pgd) || pgd_leaf(pgd))
+		goto out;
+
+	p4dp = p4d_offset(pgdp, addr);
+	p4d = p4dp_get(p4dp);
+	pr_cont(", p4d=%016lx", p4d_val(p4d));
+	if (p4d_none(p4d) || p4d_bad(p4d) || p4d_leaf(p4d))
+		goto out;
+
+	pudp = pud_offset(p4dp, addr);
+	pud = pudp_get(pudp);
+	pr_cont(", pud=%016lx", pud_val(pud));
+	if (pud_none(pud) || pud_bad(pud) || pud_leaf(pud))
+		goto out;
+
+	pmdp = pmd_offset(pudp, addr);
+	pmd = pmdp_get(pmdp);
+	pr_cont(", pmd=%016lx", pmd_val(pmd));
+	if (pmd_none(pmd) || pmd_bad(pmd) || pmd_leaf(pmd))
+		goto out;
+
+	ptep = pte_offset_map(pmdp, addr);
+	if (!ptep)
+		goto out;
+
+	pte = ptep_get(ptep);
+	pr_cont(", pte=%016lx", pte_val(pte));
+	pte_unmap(ptep);
+out:
+	pr_cont("\n");
+}
+
 static void die_kernel_fault(const char *msg, unsigned long addr,
 		struct pt_regs *regs)
 {
@@ -31,6 +82,7 @@ static void die_kernel_fault(const char *msg, unsigned long addr,
 		addr);
 
 	bust_spinlocks(0);
+	show_pte(addr);
 	die(regs, "Oops");
 	make_task_dead(SIGKILL);
 }
-- 
2.39.2


