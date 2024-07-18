Return-Path: <linux-kernel+bounces-255889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE12C93463C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 04:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AEC31C21AD1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 02:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78114849C;
	Thu, 18 Jul 2024 02:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="N5PcYFZS"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5061F1DFFB
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 02:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721269203; cv=none; b=SAgCVxfHA0JLrgUZGn2SLqHSv2tfvcqE/WML3yo4VLxtUM/7GXF2RailBIs/Bm6MVxmSj+c+JmrIBRQNPaZ599+PgpTEH1UK6Ju9wYf3tNRDs3yDGCq7eOWYeqGLsQ1Z8rfPJ0kTGPNgzW2wOMf+VGgphgllnQLxUerPNI2whUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721269203; c=relaxed/simple;
	bh=dZnxHmEM4CYiMLSggfRNQF9bA8Zj9YwdQLne1Mi4OjM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c35YDjM5vSgIfJ0uStlT3kkSimbNqW33XlzgK4t9UtEAhxduPuBF5h+MfWfRA2krH5ybdKjIO9Hk46XNwNAhuhrFmH0G9T9If+FUe3GoAD0IIlaJ1V6wYGVokqPLz0Cw7RmUvDNVaxqjYZkzMRzTawVOjJIUgf8FcGwTTz8vb5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=N5PcYFZS; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fbfb7cdb54so2760375ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 19:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1721269200; x=1721874000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T9SZYdZsUUoeIjJIREJT2CI+WWVTiYc+Wvm2FRooJHI=;
        b=N5PcYFZSnDKWsBhU5rl1kO9/uwgfspvifeRtYU59/MuBOsv9+sge+A9pNkkx+2dEQe
         fsuJDBx7aaYz4q5TfvWiRwWIYKuT3WzRoVVmSwGQ6EuoDeP2/T7yIzFkrKW1H+sh6x0I
         l9jLV7C11RImacdmcbJgdFyTF3Dn85LIJnzR/vMeDzJRb/d5jmgXyEPLMKkfTpUFKEzu
         UCfwM9y00NwDo3hRyhjnGgvOcXUFshvC7Zi2iJLi53Y/mnMRCLmE1JPwiTx/g7NVpnH8
         GeLi4xEyDcoOBAKJHXO/9wr/JsNb2GNW+kdoplfs70wH069//CarTkqtquvxduXO4M/j
         Aoag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721269200; x=1721874000;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T9SZYdZsUUoeIjJIREJT2CI+WWVTiYc+Wvm2FRooJHI=;
        b=MKfRD2KaLO21uwuMmlesX98AmFvfErklv351t2GV1Ir1nBbYrjoWFMYuO44LVY/sdW
         e7C0T1O3LrNtsLd60PM5bpTHFK75XobxErqacDwMuVBxRZo06AZEktnXFowwG5fNcxhO
         H0q5iBEgsUxn/RRd1ZzRPds95lPa74qDE/xQPFWL0Rgkbg6dUQ5zsex4xjJL7v8fw0Ic
         SG84nj0tl1xsckjk4dMvsQ5GpveAlxn8heOGdkXVCnXTVtHUrzlCtgYQ9szO0HE3dHa5
         KPbAhaAUeZwi+mdzJSkNJKWEw2SZVCeHiBUT884NjehncnV2RTYRB8kJRdQsZRdsQ9vt
         r+1A==
X-Forwarded-Encrypted: i=1; AJvYcCWDblvdzEyX1khROqDWLjHk6bXqzVGQRcmDA4s0H9ww8tAxVztb/6P/JBMGlXiKVxetp5786fBlRWOw41zIHF0ZD4HxFU2jWNqtMtB3
X-Gm-Message-State: AOJu0Yw5EuGmF34HstFP6XiZsuOIeCZJrtEZMOsRBK9KLQoSiSqYip6d
	VlVllAy1g5hjUrNUM1GxWWUMdWBOtCIi6ZJO9X/1VzLbDK1thl0zTWjQV36kA+o=
X-Google-Smtp-Source: AGHT+IGHbBfQu2e2YWhJChF1C+hZkw/qVjCPVvObxOb7FpH7Ohyx7cX+w8+p0XCiuteXdW56LLgYZw==
X-Received: by 2002:a17:902:db0d:b0:1fb:1b16:eb80 with SMTP id d9443c01a7336-1fc4e15c311mr28657665ad.26.1721269200464;
        Wed, 17 Jul 2024 19:20:00 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bb70060sm83732525ad.58.2024.07.17.19.19.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 17 Jul 2024 19:20:00 -0700 (PDT)
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
Subject: [PATCH] riscv/mm/fault: add show_pte() before die()
Date: Thu, 18 Jul 2024 10:09:35 +0800
Message-Id: <20240718020935.12803-1-cuiyunhui@bytedance.com>
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
---
 arch/riscv/mm/fault.c | 47 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 90d4ba36d1d0..dfe3ce38e16b 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -22,6 +22,52 @@
 
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
+	pgdp = pgd_offset(mm, addr);
+	pgd = READ_ONCE(*pgdp);
+	pr_alert("[%016lx] pgd=%016lx", addr, pgd_val(pgd));
+	if (pgd_none(pgd) || pgd_bad(pgd))
+		goto out;
+
+	p4dp = p4d_offset(pgdp, addr);
+	p4d = READ_ONCE(*p4dp);
+	pr_cont(", p4d=%016lx", p4d_val(p4d));
+	if (p4d_none(p4d) || p4d_bad(p4d))
+		goto out;
+
+	pudp = pud_offset(p4dp, addr);
+	pud = READ_ONCE(*pudp);
+	pr_cont(", pud=%016lx", pud_val(pud));
+	if (pud_none(pud) || pud_bad(pud))
+		goto out;
+
+	pmdp = pmd_offset(pudp, addr);
+	pmd = READ_ONCE(*pmdp);
+	pr_cont(", pmd=%016lx", pmd_val(pmd));
+	if (pmd_none(pmd) || pmd_bad(pmd))
+		goto out;
+
+	ptep = pte_offset_map(pmdp, addr);
+	if (!ptep)
+		goto out;
+
+	pte = READ_ONCE(*ptep);
+	pr_cont(", pte=%016lx", pte_val(pte));
+	pte_unmap(ptep);
+out:
+	pr_cont("\n");
+}
+
 static void die_kernel_fault(const char *msg, unsigned long addr,
 		struct pt_regs *regs)
 {
@@ -31,6 +77,7 @@ static void die_kernel_fault(const char *msg, unsigned long addr,
 		addr);
 
 	bust_spinlocks(0);
+	show_pte(addr);
 	die(regs, "Oops");
 	make_task_dead(SIGKILL);
 }
-- 
2.39.2


