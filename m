Return-Path: <linux-kernel+bounces-258449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 895BB93880A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 06:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FEEF1F214DC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 04:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78AB315AF6;
	Mon, 22 Jul 2024 04:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="McmO9zOF"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815E6107A0
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 04:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721622052; cv=none; b=saXZUF6L497/9+JjES1Rpi+KUw5nwoXCxDFWMH1+bgL4ieaeVNqmhNfOiwgBCaNvQ+MjCr7oz4pAEejgNccxnyjymZDBTWAdueza/SscG1OWXa8HDM+1CCGgQmgZF82VL4IY2PX7adYN7jNog6R7gemx6+4jHp3QfFjbyh7ZStY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721622052; c=relaxed/simple;
	bh=MCHdMjDmkw+I2haDA7VmzctibtDty8BUy5xUGnwjQM0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C5jcR2mTwXhL+r4LWjHKAq0MJ4f9D68Oq0NY4osTAkTO4mOxBLVlm5sEwRpMrJzAdCnMlusWEkXWnanJQNpt+GgvuoIpYC0ECOWpOou/jW6OySYayC8aHyjCsvsX8MZjBOxqCNdnffKQir/U9Txis5jh1fMjekm0p3Cov3LWCnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=McmO9zOF; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70d2ae44790so191864b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 21:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1721622050; x=1722226850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p54eG25IX4K7qH1am1LIVsFIDVdw1nNvCzAAhUWsgsw=;
        b=McmO9zOF0Sdm1rVi8P6evVa2iftApL91hYTxFj+ki1Xs1vzZfo5vD2FRBCWgluwiVH
         PGmcbKkYvqwJAtcCiXd1BLCYWQm801rP9OLbLNoSq85qXeoHjVi+BUgdaNb21vTko75k
         JZSeWHEpkOHDqZCfMj5XLBZ/juQbCbqHKZ3/V7lWG0PFq9+pffPpNrBOwDkDKwPH0MoM
         iRLTkAmfQWaYpuSw/1NPfaE30ar5SL62NHSu9IUXyKjaICnWJ5HM8BU8/42bj+Bm50H0
         MW9WxoCQf8ehEr/t6XNizb23CaxX3K/+uU96raXMhBwZSwbtp/t6J4UOE0KbinOzocDr
         k8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721622050; x=1722226850;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p54eG25IX4K7qH1am1LIVsFIDVdw1nNvCzAAhUWsgsw=;
        b=Oo5ZvANDyoCMNOUMVogdMAqV6hn2IOOJjpNPaArOIokT65saM9qdq4/t512PRDWpPE
         lxVbER2NPqqg3rUdRZvxnAI3lvN2u02Ifi6FEv6IwmxnduBD93655/xs+c9q49ZYGiCB
         Aw0kWO9u9wjW0/KWEXWeif8PxCL8fGaSc31AMnvFoS3GxeppLX8048Qv3WaRraS0BpYr
         kw6TFYBlBpQCPsEVhZEM5qlCav0916VoksfEIzBG2nckTpVSdH/SqiOIoaS+YeR9TcUC
         G28l3A8Ochbrkc0X9B3omXPGy0bxaVpnWb1CfnH8r5HXhYDUiyGuBXBthEvmVdajl79/
         40Fg==
X-Forwarded-Encrypted: i=1; AJvYcCUEUVx4b1futcCDaYvxUneqE5or/tG2Tnws/6wY2cDPqSA6DxrhU2CygaKLpNUDwz3LeQ3D1SJXb23PyHWTJ0wfJB+zeqit64yarf6V
X-Gm-Message-State: AOJu0YwuY0vpTTwugZgiStCkkosltmLn2TiuCkjw6eoJ0JCsOy65Tl2P
	pib1t5j6uFD+sXmepMvCwqdm5x5DgYIQFB1nCV5Q6jdv78uddpi5j+QbRdFbrIg=
X-Google-Smtp-Source: AGHT+IH8fTq3s2tWLINAZyA5rbZ0LM6s0MZ12d2PMJTOXBz/IbcNiG5imYLZzJZ18BdDsyJ9KnNiwA==
X-Received: by 2002:a05:6a00:3cc2:b0:70d:2a4d:2edc with SMTP id d2e1a72fcca58-70d2a4d3191mr1296928b3a.20.1721622049629;
        Sun, 21 Jul 2024 21:20:49 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-79f0f267834sm3225618a12.79.2024.07.21.21.20.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 21 Jul 2024 21:20:49 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: punit.agrawal@bytedance.com,
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
Cc: Yunhui Cui <cuiyunhui@bytedance.com>
Subject: [PATCH v2] riscv/mm/fault: add show_pte() before die()
Date: Mon, 22 Jul 2024 12:20:37 +0800
Message-Id: <20240722042037.27934-1-cuiyunhui@bytedance.com>
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
---
 arch/riscv/mm/fault.c | 53 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 5224f3733802..666d282a8bf4 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -22,6 +22,58 @@
 
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
+	pr_alert("Current %s pgtable: %luK pagesize, %d-bit VAs, pgdp=0x%016lx\n",
+		 current->comm, PAGE_SIZE/SZ_1K, VA_BITS,
+		 (mm == &init_mm ? __pa_symbol(mm->pgd) :
+		 (unsigned long)virt_to_phys(mm->pgd)));
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
@@ -31,6 +83,7 @@ static void die_kernel_fault(const char *msg, unsigned long addr,
 		addr);
 
 	bust_spinlocks(0);
+	show_pte(addr);
 	die(regs, "Oops");
 	make_task_dead(SIGKILL);
 }
-- 
2.39.2


