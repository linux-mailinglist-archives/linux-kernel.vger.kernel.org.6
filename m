Return-Path: <linux-kernel+bounces-429686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8089E1FF5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4FDE164FEB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E7D1F707A;
	Tue,  3 Dec 2024 14:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gvoxUqP2"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E871F669E
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 14:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733237406; cv=none; b=jyeM6uLVA/0Ljt4QSbOFG4JDlxPSAeIt+5EAxpo5id7T3pzkgp/M17WI00XhOrIaZBbHhVMcGfNDiD4W2nklD/R/CuMRBaB6VzU/NNHxDm5J7Dd9ydpcqWUskeRk/oxqRpI5LJ9B1rKYGNY4t0EcLHDTXzAEBcVrvmQABp6OeZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733237406; c=relaxed/simple;
	bh=n3T7k1PIyhRMKbsZAsV+8QvVmX+a7xUVdhdwPFsMVK8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kqbiAaAkh1DVNeEQUrZmPUVJIYx/w9xPEfAQD9kUp9Xve3CFPZPBr1RklzLsRZqwEWJHNRb5KJ/som/ZuFN3IEWs4mAZI67Yi9wKpi4jabqVRnfwTX/Wi/67RynqAz4Xvp5DpsO+ii/4rpOC5YNpbx00ryIhB9yTr4M+KfX+k14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=gvoxUqP2; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-724e14b90cfso5616752b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 06:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733237404; x=1733842204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FrAO0BF6tefsoE4f/cw6SIDUzZ1JJZKOB2UgvpR12pQ=;
        b=gvoxUqP2sfEarkAkkQTwl/6yFnwDOYGmiXVT2WjaseOg2kkKtZQS2zKdptCJGBTtjX
         TQnee3X7aem9me7ZwxUjHrca3DLb1c5aL+FINz0kjkb+VWQGxdsblNkj5Xy6ghgqI0rP
         mMQCAmIsW2zu7WrlEVkn9hRO6npAAlFka674w31DlRaigEJ0myjbD5lf6ZQPsSFc++qP
         VK/pANksvaeby6fbIjhM0IwmBWRPKy2xQ50HaizkPdisLgWHE2kqeYo23sOEzNhw7wQK
         INWLXfi776kx8INc28AB1JD5OLpHUP1d4Ri/HoScjVY0oK36MhPHPvOa80C5JIQ+IdLs
         BTww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733237404; x=1733842204;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FrAO0BF6tefsoE4f/cw6SIDUzZ1JJZKOB2UgvpR12pQ=;
        b=xSsd1rpTjROn2M46EvXBmOt9pjwajp2PPr141T3V68LU74dYFPnM5zwI5MUY7f0jyi
         TDJKG/kbT7qeL84be7LfQcA18KtJBxeNTeigPlZ+Rbkffzy6vfp7Ei+BD2klirYANeVz
         /JOGTFMfpQmj9fMs22bsjSlkOXpjqFLjR4ycgRXM+WkhbAQB2dfFV/ELPnvDwnznO7NW
         962QgMtKfGpq7SxooiHXCsJ5l4eYM4UVvGTccELtW3nrHH5ppK98jMifTCxIzXYYDcJc
         EdNfPjZiDW8sx0b4fV8EKebVpSlfKseRxSR9Ttuo73eL/Szm8NYgbfLmbv2Wf1w0k5xS
         Smlw==
X-Forwarded-Encrypted: i=1; AJvYcCWZjbCNfKKZqFZSuK1bYgPdcmVSfZWrEvsJ0tc3mp9rykTuwccjwbcG+3P61x1vI89A9xMtFSO1/GUdgJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPrPMeWGLtF1TB6Pu8pfJYbo0+/rA3lIAOns34Dltp9Y5OMC9V
	OJktxrnF8SMdqtPY14CdhgwNMotqMTV3oZQEHcAM/byFdDVmqqr8uL6UMbzrA3A=
X-Gm-Gg: ASbGncsCLwVNDc/Ss4bKbV113cLFEmuF0Gbc1BQ8tswcwwaw+dqGjkp816bKKT0177P
	XL+gwF0af2V9XM/dvNXJYzsTf/MyczcmEZG63oML+OCb+Xhx9UKdpawUnmw8wP+DsMHu3KqKZzO
	LmqaIgtM+toPlceyxdbShQ2yw+GzDpFO0YhdHm3I0/HjFx0hkLIjQrkmUhJYA2Dp6KXG52n6M6D
	ROVk4L+qVJxCHAALTBZdiAQLMJeemrDh7imCgKmtKfJc3lXoNWZPNJkOO6L+HHKbIfWLOh2IZY7
	Op8fW+BLgvrK8DHpe5sW+npE5y4QSluC
X-Google-Smtp-Source: AGHT+IF7MZvAtBKuz4c9P8nwmOub3Lo2otH53DBxGmOt+Qd2HkzMuMi190KpoHVTrOk3oGsiOOV+qg==
X-Received: by 2002:a05:6a00:14d5:b0:71e:68ae:aaed with SMTP id d2e1a72fcca58-7257fa3a687mr2971544b3a.1.1733237403820;
        Tue, 03 Dec 2024 06:50:03 -0800 (PST)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7254176fd6fsm10926946b3a.62.2024.12.03.06.49.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Dec 2024 06:50:02 -0800 (PST)
From: Xu Lu <luxu.kernel@bytedance.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alexghiti@rivosinc.com,
	bjorn@rivosinc.com
Cc: lihangjing@bytedance.com,
	xieyongji@bytedance.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [PATCH v2] riscv: mm: Fix alignment of phys_ram_base
Date: Tue,  3 Dec 2024 22:49:54 +0800
Message-Id: <20241203144954.91731-1-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit fixes the alignment of phys_ram_base in RISC-V.

In sparse vmemmap model, the virtual address of vmemmap is calculated as:
((struct page *)VMEMMAP_START - (phys_ram_base >> PAGE_SHIFT)).
And the struct page's va can be calculated with an offset:
(vmemmap + (pfn)).

However, when initializing struct pages, kernel actually starts from the
first page from the same section that phys_ram_base belongs to. If the
first page's physical address is not (phys_ram_base >> PAGE_SHIFT), then
we get an va below VMEMMAP_START when calculating va for it's struct page.

For example, if phys_ram_base starts from 0x82000000 with pfn 0x82000, the
first page in the same section is actually pfn 0x80000. During
init_unavailable_range(), we will initialize struct page for pfn 0x80000
with virtual address ((struct page *)VMEMMAP_START - 0x2000), which is
below VMEMMAP_START as well as PCI_IO_END.

This commit fixes this bug by aligning phys_ram_base with SECTION_SIZE.

Fixes: c3bcc65d4d2e ("riscv: Start of DRAM should at least be aligned on PMD size for the direct mapping")
Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/mm/init.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 0e8c20adcd98..974cafa7c85e 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -33,6 +33,9 @@
 #include <asm/pgtable.h>
 #include <asm/sections.h>
 #include <asm/soc.h>
+#ifdef CONFIG_SPARSEMEM
+#include <asm/sparsemem.h>
+#endif
 #include <asm/tlbflush.h>
 
 #include "../kernel/head.h"
@@ -59,6 +62,12 @@ EXPORT_SYMBOL(pgtable_l4_enabled);
 EXPORT_SYMBOL(pgtable_l5_enabled);
 #endif
 
+#ifdef CONFIG_SPARSEMEM
+#define RISCV_MEMSTART_ALIGN	(1UL << SECTION_SIZE_BITS)
+#else
+#define RISCV_MEMSTART_ALIGN	PMD_SIZE
+#endif
+
 phys_addr_t phys_ram_base __ro_after_init;
 EXPORT_SYMBOL(phys_ram_base);
 
@@ -239,9 +248,13 @@ static void __init setup_bootmem(void)
 	/*
 	 * Make sure we align the start of the memory on a PMD boundary so that
 	 * at worst, we map the linear mapping with PMD mappings.
+	 *
+	 * Also, make sure we align the start of the memory on a SECTION boundary
+	 * when CONFIG_SPARSEMEM_VMEMMAP is enabled to ensure the correctness of
+	 * pfn_to_page().
 	 */
 	if (!IS_ENABLED(CONFIG_XIP_KERNEL))
-		phys_ram_base = memblock_start_of_DRAM() & PMD_MASK;
+		phys_ram_base = round_down(memblock_start_of_DRAM(), RISCV_MEMSTART_ALIGN);
 
 	/*
 	 * In 64-bit, any use of __va/__pa before this point is wrong as we
-- 
2.20.1


