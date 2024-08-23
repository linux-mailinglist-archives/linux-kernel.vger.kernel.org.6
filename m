Return-Path: <linux-kernel+bounces-298710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8D695CA85
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 12:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C2DB2873F7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D44516EB4B;
	Fri, 23 Aug 2024 10:33:46 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C57186E57;
	Fri, 23 Aug 2024 10:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724409226; cv=none; b=RYjtUjFffdRT07MEgQEEA1TSwbZ4lFkEouoV4H3Vh7f8e3rerNOsGU8QWZHnkuyRByYVC2neq0wtxwqpqX2wjTcwxeXTVZhp/TzT15G7VYvvf1qu9APa9anp3ldMyTLwWb0EDBtyoo/CSFhOuKM+x6KUqeDXLd/MsqdqplZY29A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724409226; c=relaxed/simple;
	bh=xqkYFoIeKHjvyXYSScBmkIwYsS+h8/BO5Dlwp5j/f4c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=fJeAKYObFCgb3iSatlXcCgEabsBSetkAR5jWkYZyCv3KGDG8rSIrrvr5P5qea2mFr145QvOj9+YL+2745qT6JRPk6Wc67oTNhxFEv2OVX9udc7QH6xzT0cHwMW4G5RjPoTIT3b/+WXWEJPdm3brM9iZaUqULt8RKEDjw162RhWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.10.34])
	by gateway (Coremail) with SMTP id _____8DxfZuEZchmo1MdAA--.35984S3;
	Fri, 23 Aug 2024 18:33:40 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.10.34])
	by front1 (Coremail) with SMTP id qMiowMAxVOCDZchmmDYfAA--.5401S2;
	Fri, 23 Aug 2024 18:33:39 +0800 (CST)
From: Tianyang Zhang <zhangtianyang@loongson.cn>
To: corbet@lwn.net,
	alexs@kernel.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	tglx@linutronix.de,
	jiaxun.yang@flygoat.com,
	gaoliang@loongson.cn,
	wangliupu@loongson.cn,
	lvjianmin@loongson.cn,
	zhangtianyang@loongson.cn,
	yijun@loongson.cn,
	mhocko@suse.com,
	akpm@linux-foundation.org,
	dianders@chromium.org,
	maobibo@loongson.cn,
	xry111@xry111.site,
	zhaotianrui@loongson.cn,
	nathan@kernel.org,
	yangtiezhu@loongson.cn,
	zhoubinbin@loongson.cn
Cc: loongarch@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v11 0/7] Loongarch-avec support
Date: Fri, 23 Aug 2024 18:33:29 +0800
Message-Id: <20240823103337.23602-1-zhangtianyang@loongson.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxVOCDZchmmDYfAA--.5401S2
X-CM-SenderInfo: x2kd0wxwld05hdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGF1DZrW3Gw4DXrWxJFyxWFX_yoWrtr4kpF
	W7Cryqvr48CryxCrnak34rury5Xr4xK3y2qay3K347uryDJ34DWr10yF1DZF18Jw4rGa4I
	gF1rW3yUWa1UAacCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8svtJUUUUU==

This series of patches introduces support for advanced extended 
interrupt controllers (AVECINTC), and this hardware feature will 
be supported on 3C6000 for the first time

Changes log:
 V0->V1:
         1.Modified some formats and declarations
         2.Removed kmalloc/kfree when adding affinity related data to pending_list,
           and used moving tag to replace the original behavior
         3.Adjusted the process that enables AVEC interrupts, now it is at the end of all processes
         4.Removed CPUHP related callbacks, now irq_matrix_online/irq_matrix_offline is completed in start_secondary/loongson_cpu_disable
         5.Adjusted compatibility issues for CONFIG_ACPI
         6.About question:
         > irr = csr_read64(LOONGARCH_CSR_IRR0 + vector / 64);
         > should be good enough, no?
         csr_read64 was built-in as __csrrd_d, it doesn't seem to support variables as parameters
         >>>>
         drivers/irqchip/irq-loongarch-avec.c: In function ‘complete_irq_moving’:
         ./arch/loongarch/include/asm/loongarch.h:164:25: error: invalid argument to built-in function
           164 | #define csr_read64(reg) __csrrd_d(reg)
               |                         ^~~~~~~~~
         drivers/irqchip/irq-loongarch-avec.c:170:23: note: in expansion of macro ‘csr_read64’
           170 |                 irr = csr_read64(LOONGARCH_CSR_IRR_BASE + vector / VECTORS_PER_REG);
               |                       ^~~~~~~~~~
         >>>>
         So we have temporarily retained the previous implementation.
 
 V1->V2:
         Fixed up coding style. Made on/offline functions void
         Added compatibility when CONFIG_SMP is turned off
 
 V2->V3:
 	Squash two patches into one
 
 V3->V4:
 	Update NR_IRQS
 	Update Register's name
 	Fixed up coding style
 V4->V5:
	Retain feature CPUCFG1_MSGINT	
 	Fixed up coding style
	Delete the test code introduced by V4, and now msi msg address still uses the 32-bit address
 V5->V6:
	Fix definition of NR_IRQS
	Define arch_probe_nr_irqs()
	Handle all avecintc interrupts in one dispatch
	Use cpuhotplug callbacks instead of direct call to avec_online_cpu()/avec_offline_cpu()
	Rename {SMP,ACTION}_CLEAR_VECT to {SMP,ACTION}_CLEAR_VECTOR
	Use avecintc_ prefix instead of loongarch_avec_ to keep consistancy
 V6->V7:
	Fixed compatibility issue with cpuhp_setup_state_nocalls when CONFIG_SMP is turned off
	Rename avecintc_online/offline_cpu as avecintc_cpu_online/offline
	Use pch_msi_handle[0] as default value of get_pch_msi_handle
	Rework commit-message
 V7->V8:
	Fixed up coding style
	Support per-device-MSI domain
	Replaced spin_lock ops with guard/scope_guard
	Always execute irq_metrix_offline while the CPU is offline
 V8->V9:
	Fixed up coding style and potential bugs 
 V9->V10:
	Add a cover of series patch
 V10->V11:
	Separate the original patch into 7 small patches
	Correcting memory operations in critical areas
	Fixed up other coding style problem

Huacai Chen (5):
  Docs/LoongArch: Add advanced extended IRQ model description
  LoongArch: Define ARCH_IRQ_INIT_FLAGS as IRQ_NOPROBE
  LoongArch: Move irqchip function prototypes to irq-loongson.h
  LoongArch: Architectural preparation for AVEC irqchip
  irqchip/loongson-eiointc: Rename CPUHP_AP_IRQ_LOONGARCH_STARTING

Tianyang Zhang (2):
  irqchip/loongson-pch-msi: Prepare get_pch_msi_handle() for AVECINTC
  irqchip/loongarch-avec: Add AVEC irqchip support

 .../arch/loongarch/irq-chip-model.rst         |  32 ++
 .../zh_CN/arch/loongarch/irq-chip-model.rst   |  32 ++
 arch/loongarch/Kconfig                        |   1 +
 arch/loongarch/include/asm/cpu-features.h     |   1 +
 arch/loongarch/include/asm/cpu.h              |   2 +
 arch/loongarch/include/asm/hardirq.h          |   3 +-
 arch/loongarch/include/asm/hw_irq.h           |   2 +
 arch/loongarch/include/asm/irq.h              |  31 +-
 arch/loongarch/include/asm/loongarch.h        |  18 +-
 arch/loongarch/include/asm/smp.h              |   2 +
 arch/loongarch/kernel/cpu-probe.c             |   3 +-
 arch/loongarch/kernel/irq.c                   |  15 +-
 arch/loongarch/kernel/paravirt.c              |   5 +
 arch/loongarch/kernel/smp.c                   |   6 +
 drivers/irqchip/Makefile                      |   2 +-
 drivers/irqchip/irq-loongarch-avec.c          | 425 ++++++++++++++++++
 drivers/irqchip/irq-loongarch-cpu.c           |   7 +-
 drivers/irqchip/irq-loongson-eiointc.c        |   9 +-
 drivers/irqchip/irq-loongson-htvec.c          |   2 +
 drivers/irqchip/irq-loongson-liointc.c        |   2 +
 drivers/irqchip/irq-loongson-pch-lpc.c        |   2 +
 drivers/irqchip/irq-loongson-pch-msi.c        |  25 +-
 drivers/irqchip/irq-loongson-pch-pic.c        |   2 +
 drivers/irqchip/irq-loongson.h                |  27 ++
 include/linux/cpuhotplug.h                    |   3 +-
 25 files changed, 624 insertions(+), 35 deletions(-)
 create mode 100644 drivers/irqchip/irq-loongarch-avec.c
 create mode 100644 drivers/irqchip/irq-loongson.h

-- 
2.20.1


