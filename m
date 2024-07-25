Return-Path: <linux-kernel+bounces-261876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 037FF93BD3E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 09:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5575AB21757
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 07:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B31816FF4B;
	Thu, 25 Jul 2024 07:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="CyIXRGJM"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7EB15FA72
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 07:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721893329; cv=none; b=N7Ap0GGY3ICB+AXQMD2GXAwtnVyi9pNdvaeac/IpJTvS4kwWwDoGZCd8Dor18cpr1UEQ/Bc8QT/yPB/q3pHCR1Xnw7ovyPbBJkp2mohL3Bk/cQdcMTsCj0ROCbwgqJSLt0RuER++aNAd/4C/yXlUWn2+G5JMZY+gL3pjSNlMEhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721893329; c=relaxed/simple;
	bh=Oj6wYi064jeOY276reYTawidsJMtfx4WmhlsEXzU6kY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=TXjiFBT+xYqn/Ld5ZRJOwKhEmAIfJZBvqYdpQhM1CFx5P/bvki4zXbJaCy/5yo7JAgIoaqtwZzOzo2AxnJTBD9z+vF9ILBZ/RA98FpXpF3BOt8Hz6wDxuY47yzaQ5vevZRAMiN/pCkiUqb49o+WzkJLBFkh6Q9PRRhTSGdKHtV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=CyIXRGJM; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-76cb5b6b3e4so440889a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 00:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1721893326; x=1722498126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5y15oCnd596cs9ptnOqqQNvBeeOGFsgLCTvbSMuHYA8=;
        b=CyIXRGJME9NPpGqzrqD0hnvGP32XVTLw1S1DjmDDLWDvCibtTiTceEFu2AamBd5wLu
         wq1gKK0n+0qRA1i05/gg0IS+cIcM+9oDyBi7aXCX5JZxC0XXjJf26b6QU+3u8Uo6pq2v
         rVJkAqZSMCxmTTU+BHVo7t7aEi5Ghmhbq+2i4jfUbTnuSvdQqNYBvJqIB8BFkMK2O5bN
         JIt0CPFEpaK9qh3BGtNBo4iKpWAxoZrMHgrV+hVJDwbO0W3Avp0iYhf/KBiX82IdnWGF
         tK2Ke5MsqqY6n12X6Q9j1VPwe5UmT9l9sh8bfQlJF4kjyclxxUIMEQrhmELpQ+vLc7GM
         E/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721893326; x=1722498126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5y15oCnd596cs9ptnOqqQNvBeeOGFsgLCTvbSMuHYA8=;
        b=ZeGuIA85NXIYVXGv/VrDMNzfQui6M9rIRVxHBFfA1QfehntI16q7i16pJNRGwoJxG3
         97VOBO8g5GFb6SFPnQxVZVucjsPG8DqwfeI1Fv7aP3l2psN3twqUo80LyRO+wrSuKLz7
         AIUiuN8Sa+YxFNCVMWdsgxBV3vOYgZaGBc4ogG09QlNNG52bgmnwNeu4pcOkh0xRw3Qr
         qVIdvYlSA99H5qwmcDdpebOyeGByyZvNCLV80TbtDO9yzyz79lNAYErf40Tl73rFqCOu
         4WoirA/7IsZTHfuqWsvKPB177iWGol4LY2+JNTRaD8uWFfT99HjKc5FDvfhZz8SGg26p
         mp7A==
X-Forwarded-Encrypted: i=1; AJvYcCX5p+sgw5rGpIhpYRNsKubINMw+KDewUFY4unTz7p5We76Yzk7mACZllm4ATylLYgDEYNTHu58mSdZLvHvIuU7xdPlJyDfGU5/2/1De
X-Gm-Message-State: AOJu0YwTXZCKDWbhmK3q0CCUQWR/rbuqRvwOTTW+7BeIkURAl/vZhHMr
	M5SF/9Dz3F1rikQoqXSntsylIrnnDMKOMsa+IZ+tWG/hJMOHEdJm7uRJmVznX88=
X-Google-Smtp-Source: AGHT+IGXdcb1PcXS18T/DF+tMQrCmpJ3aqEFdTn7rhawFPZkk6XxcHmob7PNovbBuO2DM+K4+H4q9w==
X-Received: by 2002:a05:6a20:2d24:b0:1bd:deac:c052 with SMTP id adf61e73a8af0-1c47b117d86mr1267871637.1.1721893325857;
        Thu, 25 Jul 2024 00:42:05 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb73b32cbsm2886437a91.17.2024.07.25.00.41.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 25 Jul 2024 00:42:05 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: punit.agrawal@bytedance.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alexghiti@rivosinc.com,
	cuiyunhui@bytedance.com,
	samitolvanen@google.com,
	gregkh@linuxfoundation.org,
	suagrfillet@gmail.com,
	akpm@linux-foundation.org,
	shikemeng@huaweicloud.com,
	willy@infradead.org,
	charlie@rivosinc.com,
	xiao.w.wang@intel.com,
	conor.dooley@microchip.com,
	chenjiahao16@huawei.com,
	guoren@kernel.org,
	jszhang@kernel.org,
	ajones@ventanamicro.com,
	bhe@redhat.com,
	vishal.moola@gmail.com,
	ndesaulniers@google.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] riscv: mm: add paging_check() before paging_init()
Date: Thu, 25 Jul 2024 15:41:55 +0800
Message-Id: <20240725074155.20565-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When establishing a linear mapping, the virtual address is obtained
through __va(). If the physical address is too large, such as 1TB, then
the virtual address will overflow in the address space of sv39.
The log is as follows:
[    0.000000] Unable to handle kernel paging request at virtual address 000000d97fdf7ad8
[    0.000000] [000000d97fdf7ad8] pgd=000000407ff7e801, p4d=000000407ff7e801, pud=000000407ff7e801
[    0.000000] Unable to handle kernel paging request at virtual address 000000d97fdfaff0
[    0.000000] [000000d97fdfaff0] pgd=000000407ff7e801, p4d=000000407ff7e801, pud=000000407ff7e801
...
[    0.000000] Insufficient stack space to handle exception!
[    0.000000] Task stack:     [0xffffffff81400000..0xffffffff81404000]
[    0.000000] Overflow stack: [0xffffffff80c67370..0xffffffff80c68370]
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G        W          6.6.3-00133-g60497fad461d-dirty #71
[    0.000000] epc : die_kernel_fault+0x158/0x1c8
[    0.000000]  ra : die_kernel_fault+0x12a/0x1c8
[    0.000000] epc : ffffffff808cde36 ra : ffffffff808cde08 sp : ffffffff813fff80
[    0.000000]  gp : ffffffff815a1678 tp : 0000000000000000 t0 : 0000003130386537
[    0.000000]  t1 : 0000000000000031 t2 : 6537666637303430 s0 : ffffffff813fffc0
[    0.000000]  s1 : ffffffff815b0b28 a0 : 0000000000000016 a1 : ffffffff81495298
[    0.000000]  a2 : 0000000000000010 a3 : ffffffff81495298 a4 : 00000000000001fe
[    0.000000]  a5 : 000000d97fdfa000 a6 : ffffffff814250d0 a7 : 0000000000000030
[    0.000000]  s2 : 000000d97fdfaff0 s3 : ffffffff81400040 s4 : 000000d97fdfaff0
[    0.000000]  s5 : ffffffff815a0ed0 s6 : 0000000000000000 s7 : 000000008f604390
[    0.000000]  s8 : 0000000000000000 s9 : ffffffffffffffff s10: 0000000000000000
[    0.000000]  s11: 0000000000000000 t3 : ffffffff815baa9b t4 : ffffffff815baa9b
[    0.000000]  t5 : ffffffff815baa88 t6 : ffffffff813ffda8
[    0.000000] status: 0000000200000100 badaddr: 000000d97fdfaff0 cause: 000000000000000d
[    0.000000] Kernel panic - not syncing: Kernel stack overflow
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G        W          6.6.3-00133-g60497fad461d-dirty #71
[    0.000000] Call Trace:
[    0.000000] [<ffffffff800066bc>] dump_backtrace+0x28/0x30
[    0.000000] [<ffffffff808cdac8>] show_stack+0x38/0x44
[    0.000000] [<ffffffff808d9d40>] dump_stack_lvl+0x44/0x5c
[    0.000000] [<ffffffff808d9d70>] dump_stack+0x18/0x20
[    0.000000] [<ffffffff808cdfb6>] panic+0x110/0x2f2
[    0.000000] [<ffffffff80006532>] walk_stackframe+0x0/0x120
[    0.000000] [<ffffffff808cde08>] die_kernel_fault+0x12a/0x1c8
[    0.000000] ---[ end Kernel panic - not syncing: Kernel stack overflow ]---

In other words, the maximum value of the physical address needs to meet
Documentation/riscv/vm-layout.rst to ensure that there is no overflow.
For sv48/57, the actual virtual address space is huge, so this problem
is generally not triggered, but it is also checked in the code.

We give a warning for the overflowed physical address region and reverve it
so that the kernel can bringup successfully.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/include/asm/page.h    |  9 +++++++++
 arch/riscv/include/asm/pgtable.h |  1 +
 arch/riscv/kernel/setup.c        |  1 +
 arch/riscv/mm/init.c             | 30 ++++++++++++++++++++++++++++++
 4 files changed, 41 insertions(+)

diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index 57e887bfa34c..f6c0f6e14ecb 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -38,6 +38,15 @@
  */
 #define PAGE_OFFSET_L4		_AC(0xffffaf8000000000, UL)
 #define PAGE_OFFSET_L3		_AC(0xffffffd800000000, UL)
+
+/*
+ * See vm-layout.rst, the size of L3 direct mapping of all physical
+ * memory 124GB, L4 is 64TB, L5 is 32PB.
+ */
+#define MAX_PFN_MEM_ADDR_L5	(0x80000000000000ULL)
+#define MAX_PFN_MEM_ADDR_L4	(0x400000000000ULL)
+#define MAX_PFN_MEM_ADDR_L3	(0x1F00000000ULL)
+
 #else
 #define PAGE_OFFSET		_AC(CONFIG_PAGE_OFFSET, UL)
 #endif /* CONFIG_64BIT */
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index c8e8867c42f6..e4835de5a743 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -915,6 +915,7 @@ extern uintptr_t _dtb_early_pa;
 #endif /* CONFIG_XIP_KERNEL */
 extern u64 satp_mode;
 
+void paging_check(void);
 void paging_init(void);
 void misc_mem_init(void);
 
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 2a79d4ed2660..366918578544 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -273,6 +273,7 @@ void __init setup_arch(char **cmdline_p)
 	parse_early_param();
 
 	efi_init();
+	paging_check();
 	paging_init();
 
 	/* Parse the ACPI tables for possible boot-time configuration */
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index b0cc28f7595f..aa25dcf8a0ff 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -1482,6 +1482,36 @@ static void __init reserve_crashkernel(void)
 	crashk_res.end = crash_base + crash_size - 1;
 }
 
+static void __init phymem_addr_overflow(void)
+{
+	phys_addr_t end = memblock_end_of_DRAM();
+
+	if (pgtable_l5_enabled) {
+		if (end > MAX_PFN_MEM_ADDR_L5) {
+			memblock_reserve(MAX_PFN_MEM_ADDR_L5, end - MAX_PFN_MEM_ADDR_L5);
+			WARN(true, "Phymem addr 0x%llx overflowed, reserve [0x%llx-0x%llx] directly.",
+			     end, MAX_PFN_MEM_ADDR_L5, end);
+		}
+	}
+	if (pgtable_l4_enabled) {
+		if (end > MAX_PFN_MEM_ADDR_L4) {
+			memblock_reserve(MAX_PFN_MEM_ADDR_L4, end - MAX_PFN_MEM_ADDR_L4);
+			WARN(true, "Phymem addr 0x%llx overflowed, reserve [0x%llx-0x%llx] directly.",
+			     end, MAX_PFN_MEM_ADDR_L4, end);
+		}
+	}
+	if (end > MAX_PFN_MEM_ADDR_L3) {
+		memblock_reserve(MAX_PFN_MEM_ADDR_L3, end - MAX_PFN_MEM_ADDR_L3);
+		WARN(true, "Phymem addr 0x%llx overflowed, reserve [0x%llx-0x%llx] directly.",
+		     end, MAX_PFN_MEM_ADDR_L3, end);
+	}
+}
+
+void __init paging_check(void)
+{
+	phymem_addr_overflow();
+}
+
 void __init paging_init(void)
 {
 	setup_bootmem();
-- 
2.39.2


