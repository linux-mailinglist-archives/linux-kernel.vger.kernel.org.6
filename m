Return-Path: <linux-kernel+bounces-225664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 442EF91336D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 13:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C541A1F226B9
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 11:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D7C1553B3;
	Sat, 22 Jun 2024 11:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codasip.com header.i=@codasip.com header.b="Cxh70sUP"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5625154C03
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 11:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719056579; cv=none; b=rgojvh9vvP/z/HnZ6quTuS60X060U06jZQU3OkZ4OxFpB6h0rcJurARRfLu0DYozSP9g/QYenKH9hDT44IjCXjv7SqL2nuFuUCDleQ5TNnJJfkr6ZEAhUO4BEOkrJ1Pc2ZUMZjKO28huLlPCGjLszdErGlGnQwdy6MO3vPo23vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719056579; c=relaxed/simple;
	bh=I3dUpzUdhVOM6uBckH1AsRInajkVm/ZJONBSbNtfLOA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IFu9PWjKWBz0H0MtV4QTPxAXk4D0tJfKoGwi9+0qbGgEEDNfcRtyaUblPxae7c84NANOgkaqkFRaaAjgXhBxw7hRzjwrnyvSqwD8TwrN0OYE1GUgTn6OSFIlX9RiHX9rRm2e5CqgmWOFaCshKC3AP3dXrjRn+o2FGcKcKtCobDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=codasip.com; spf=pass smtp.mailfrom=codasip.com; dkim=pass (2048-bit key) header.d=codasip.com header.i=@codasip.com header.b=Cxh70sUP; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=codasip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codasip.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52c89d6b4adso2717654e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 04:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codasip.com; s=google; t=1719056576; x=1719661376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E477aB1ECVE/ZvIxn1l+Qdf3yr4/bnJp1j4La8gD7OI=;
        b=Cxh70sUPK9VAI/vQ6cakJkHxcA67ViEUUiNm0xhRXHOP7+yqdm1tSzvAIkDwStnmza
         LKkCxllSvEvGChjNmHEPo7NHpjUAzbFPa8VKq/hdyGF3B0J4eO2/cTLZnEzLVS9sXbT8
         WvfkcjcRnKnqzmMgqo+cZ7qlxtQUPEWGudrQa8tbmAOze2hvkiXcVTR0C/EcGVFpfPoq
         Jj2MKCRW6qmzMgbo3h9eZX5Q60s8R+wmOaGiBr5g+mz6nX47SfYoRbBVHbGGWexQm8ZS
         trNCXrqY8oortLmOWJjm7lrAi4vpDsyjuIIkemNOZEqW+bloG+UZVIIcuAlwW0MID64f
         ggzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719056576; x=1719661376;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E477aB1ECVE/ZvIxn1l+Qdf3yr4/bnJp1j4La8gD7OI=;
        b=cE9Kd1JslgSV00AjjZYdLJE77rCmtZGrzO+pzeHhy+fHLyJcblfKkMIxTkoswWNSry
         srfSzWkU1o4HmtXv4P2m1hdljRhU06KAGrzx1Pgf+5f6Jet23+lmhd0zrFfx6Yc/Yezp
         D54fHIzDAEa18PRLQxmkocmIwFQzF4zqLFM9og5i/XXCjVNTY8wRU6Ro0c3BtCtk8ZVh
         MmLOPwYiQeIdVhwd+O8xOCtLVwWcKGIP3BLSiVShZV7n8A5uowErhhYZH5woOszy3iwp
         Uvy6aEm98M3Zg5TCpobedOB+YeAYF8djCiR5CP2gqQ6qbZaFuZrDrZytUuRWnYBq1Jjp
         tOdw==
X-Forwarded-Encrypted: i=1; AJvYcCV/ZdN67rngdeXeHpmXjQGCeyqKFJJ9E6ZXT4EfRyA8M0jYFq9j2IiaU6J2NaTDQeTf6jSH8VRtTgVonu8/w+/UT9qbuyYfdGuQeBXj
X-Gm-Message-State: AOJu0YwOvGqnJo1lMgBJQH4AGeY03vVg6U5hSiRP5NMCUKLeJe9IWgST
	xS4WTVEpq1mdV9oKTUCPRoXMtJqq3eBIJXpeKye4FgGLZx+XAb7fHCANo2DutkI=
X-Google-Smtp-Source: AGHT+IHSZ8ayR4uLRulHxCdWN5OkqWhFpeJ+VWyWM+iaDruaLmDqzCj9Q0mReoHFMJLAW/RgQ0jG4w==
X-Received: by 2002:ac2:4e09:0:b0:52c:df6d:e52e with SMTP id 2adb3069b0e04-52ce0643d82mr233017e87.16.1719056575968;
        Sat, 22 Jun 2024 04:42:55 -0700 (PDT)
Received: from nb152.home ([2a00:23c6:2008:8201:ed43:a615:7f98:da0d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4248179d3afsm65786175e9.5.2024.06.22.04.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 04:42:55 -0700 (PDT)
From: Stuart Menefy <stuart.menefy@codasip.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: Stuart Menefy <stuart.menefy@codasip.com>,
	David McKay <david.mckay@codasip.com>,
	Palmer Dabbelt <palmerdabbelt@google.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: Fix linear mapping checks for non-contiguous memory regions
Date: Sat, 22 Jun 2024 12:42:16 +0100
Message-ID: <20240622114217.2158495-1-stuart.menefy@codasip.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RISC-V kernel already has checks to ensure that memory which would
lie outside of the linear mapping is not used. However those checks
use memory_limit, which is used to implement the mem= kernel command
line option (to limit the total amount of memory, not its address
range). When memory is made up of two or more non-contiguous memory
banks this check is incorrect.

Two changes are made here:
 - add a call in setup_bootmem() to memblock_cap_memory_range() which
   will cause any memory which falls outside the linear mapping to be
   removed from the memory regions.
 - remove the check in create_linear_mapping_page_table() which was
   intended to remove memory which is outside the liner mapping based
   on memory_limit, as it is no longer needed. Note a check for
   mapping more memory than memory_limit (to implement mem=) is
   unnecessary because of the existing call to
   memblock_enforce_memory_limit().

This issue was seen when booting on a SV39 platform with two memory
banks:
  0x00,80000000 1GiB
  0x20,00000000 32GiB
This memory range is 158GiB from top to bottom, but the linear mapping
is limited to 128GiB, so the lower block of RAM will be mapped at
PAGE_OFFSET, and the upper block straddles the top of the linear
mapping.

This causes the following Oops:
[    0.000000] Linux version 6.10.0-rc2-gd3b8dd5b51dd-dirty (stuart.menefy@codasip.com) (riscv64-codasip-linux-gcc (GCC) 13.2.0, GNU ld (GNU Binutils) 2.41.0.20231213) #20 SMP Sat Jun 22 11:34:22 BST 2024
[    0.000000] memblock_add: [0x0000000080000000-0x00000000bfffffff] early_init_dt_add_memory_arch+0x4a/0x52
[    0.000000] memblock_add: [0x0000002000000000-0x00000027ffffffff] early_init_dt_add_memory_arch+0x4a/0x52
...
[    0.000000] memblock_alloc_try_nid: 23724 bytes align=0x8 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 early_init_dt_alloc_memory_arch+0x1e/0x48
[    0.000000] memblock_reserve: [0x00000027ffff5350-0x00000027ffffaffb] memblock_alloc_range_nid+0xb8/0x132
[    0.000000] Unable to handle kernel paging request at virtual address fffffffe7fff5350
[    0.000000] Oops [#1]
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 6.10.0-rc2-gd3b8dd5b51dd-dirty #20
[    0.000000] Hardware name: codasip,a70x (DT)
[    0.000000] epc : __memset+0x8c/0x104
[    0.000000]  ra : memblock_alloc_try_nid+0x74/0x84
[    0.000000] epc : ffffffff805e88c8 ra : ffffffff806148f6 sp : ffffffff80e03d50
[    0.000000]  gp : ffffffff80ec4158 tp : ffffffff80e0bec0 t0 : fffffffe7fff52f8
[    0.000000]  t1 : 00000027ffffb000 t2 : 5f6b636f6c626d65 s0 : ffffffff80e03d90
[    0.000000]  s1 : 0000000000005cac a0 : fffffffe7fff5350 a1 : 0000000000000000
[    0.000000]  a2 : 0000000000005cac a3 : fffffffe7fffaff8 a4 : 000000000000002c
[    0.000000]  a5 : ffffffff805e88c8 a6 : 0000000000005cac a7 : 0000000000000030
[    0.000000]  s2 : fffffffe7fff5350 s3 : ffffffffffffffff s4 : 0000000000000000
[    0.000000]  s5 : ffffffff8062347e s6 : 0000000000000000 s7 : 0000000000000001
[    0.000000]  s8 : 0000000000002000 s9 : 00000000800226d0 s10: 0000000000000000
[    0.000000]  s11: 0000000000000000 t3 : ffffffff8080a928 t4 : ffffffff8080a928
[    0.000000]  t5 : ffffffff8080a928 t6 : ffffffff8080a940
[    0.000000] status: 0000000200000100 badaddr: fffffffe7fff5350 cause: 000000000000000f
[    0.000000] [<ffffffff805e88c8>] __memset+0x8c/0x104
[    0.000000] [<ffffffff8062349c>] early_init_dt_alloc_memory_arch+0x1e/0x48
[    0.000000] [<ffffffff8043e892>] __unflatten_device_tree+0x52/0x114
[    0.000000] [<ffffffff8062441e>] unflatten_device_tree+0x9e/0xb8
[    0.000000] [<ffffffff806046fe>] setup_arch+0xd4/0x5bc
[    0.000000] [<ffffffff806007aa>] start_kernel+0x76/0x81a
[    0.000000] Code: b823 02b2 bc23 02b2 b023 04b2 b423 04b2 b823 04b2 (bc23) 04b2 
[    0.000000] ---[ end trace 0000000000000000 ]---
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---

The problem is that memblock (unaware that some physical memory cannot
be used) has allocated memory from the top of memory but which is
outside the linear mapping region.

Signed-off-by: Stuart Menefy <stuart.menefy@codasip.com>
Fixes: c99127c45248 ("riscv: Make sure the linear mapping does not use the kernel mapping")
Reviewed-by: David McKay <david.mckay@codasip.com>

---
 arch/riscv/mm/init.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index e3405e4b99af..7e25606f858a 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -233,8 +233,6 @@ static void __init setup_bootmem(void)
 	 */
 	memblock_reserve(vmlinux_start, vmlinux_end - vmlinux_start);
 
-	phys_ram_end = memblock_end_of_DRAM();
-
 	/*
 	 * Make sure we align the start of the memory on a PMD boundary so that
 	 * at worst, we map the linear mapping with PMD mappings.
@@ -249,6 +247,16 @@ static void __init setup_bootmem(void)
 	if (IS_ENABLED(CONFIG_64BIT) && IS_ENABLED(CONFIG_MMU))
 		kernel_map.va_pa_offset = PAGE_OFFSET - phys_ram_base;
 
+	/*
+	 * The size of the linear page mapping may restrict the amount of
+	 * usable RAM.
+	 */
+	if (IS_ENABLED(CONFIG_64BIT)) {
+		max_mapped_addr = __pa(PAGE_OFFSET) + KERN_VIRT_SIZE;
+		memblock_cap_memory_range(phys_ram_base,
+					  max_mapped_addr - phys_ram_base);
+	}
+
 	/*
 	 * Reserve physical address space that would be mapped to virtual
 	 * addresses greater than (void *)(-PAGE_SIZE) because:
@@ -265,6 +273,7 @@ static void __init setup_bootmem(void)
 		memblock_reserve(max_mapped_addr, (phys_addr_t)-max_mapped_addr);
 	}
 
+	phys_ram_end = memblock_end_of_DRAM();
 	min_low_pfn = PFN_UP(phys_ram_base);
 	max_low_pfn = max_pfn = PFN_DOWN(phys_ram_end);
 	high_memory = (void *)(__va(PFN_PHYS(max_low_pfn)));
@@ -1289,8 +1298,6 @@ static void __init create_linear_mapping_page_table(void)
 		if (start <= __pa(PAGE_OFFSET) &&
 		    __pa(PAGE_OFFSET) < end)
 			start = __pa(PAGE_OFFSET);
-		if (end >= __pa(PAGE_OFFSET) + memory_limit)
-			end = __pa(PAGE_OFFSET) + memory_limit;
 
 		create_linear_mapping_range(start, end, 0);
 	}
-- 
2.43.0


