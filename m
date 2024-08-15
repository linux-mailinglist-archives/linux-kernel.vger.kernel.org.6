Return-Path: <linux-kernel+bounces-287869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 371BC952D6D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 13:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AE251C21669
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 11:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824737DA9F;
	Thu, 15 Aug 2024 11:26:19 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861071AC8A5;
	Thu, 15 Aug 2024 11:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723721179; cv=none; b=qb1dzVB9VQUuFxBUEEYxPW5RY18eeab9LrS7nepUuC4iNMx6n6E4fBNjoZXtYBD/PFG3e3NWmjlIfnXojMM0ZHgqVNAtrCGLu15TYzx7/eeRthQuP7niu73c3Yx5CDxxQQqEdd3Jyal3eS0Foq5ydxnwz6cAaQsbwqGJvVRlndk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723721179; c=relaxed/simple;
	bh=N5rUYRNLTPBzWe5BfYzehBPfpIHvZyYW4Izw3kIKWsk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=G+dF+pN0EiyPXOI9mqR290aBLQ6T5sXhYqXHUlK3mcj1CzMrHSEvIWgd9Rm3CKHN5suhFCN1DItS8Qg21SOLr4HNH+y0ym3RRbzLF/yFha7hFYhPRSOdcu0tVZPGzYdKNbBRj7fklwV7/8fHJBO8bQCxxmKWgivlT+u+LPemKos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.10.34])
	by gateway (Coremail) with SMTP id _____8DxXpnW5b1mgsgUAA--.12056S3;
	Thu, 15 Aug 2024 19:26:14 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.10.34])
	by front1 (Coremail) with SMTP id qMiowMAxVODU5b1mwT4VAA--.33702S2;
	Thu, 15 Aug 2024 19:26:13 +0800 (CST)
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
Subject: [PATCH v10 0/2] Loongarch-avec support
Date: Thu, 15 Aug 2024 19:26:06 +0800
Message-Id: <20240815112608.26925-1-zhangtianyang@loongson.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxVODU5b1mwT4VAA--.33702S2
X-CM-SenderInfo: x2kd0wxwld05hdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGF1DZrW3Gw4DXrWxJFyxWFX_yoWrXr1rpF
	Zruryqyr48Gr97Crn2y34rury5Xrs7G3y2qa43G347uF4UXryDXr10yF98ZF1kXw4rCa4I
	gF1fW398Wa1UAagCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
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
 
Huacai Chen (1):
  irqchip/loongson-pch-msi: Switch to MSI parent domains

Tianyang Zhang (1):
  irqchip/loongarch-avec: Add AVEC irqchip support

 .../arch/loongarch/irq-chip-model.rst         |  32 ++
 .../zh_CN/arch/loongarch/irq-chip-model.rst   |  32 ++
 arch/loongarch/Kconfig                        |   1 +
 arch/loongarch/include/asm/cpu-features.h     |   1 +
 arch/loongarch/include/asm/cpu.h              |   2 +
 arch/loongarch/include/asm/hardirq.h          |   3 +-
 arch/loongarch/include/asm/hw_irq.h           |   2 +
 arch/loongarch/include/asm/irq.h              |  25 +-
 arch/loongarch/include/asm/loongarch.h        |  18 +-
 arch/loongarch/include/asm/smp.h              |   2 +
 arch/loongarch/kernel/cpu-probe.c             |   3 +-
 arch/loongarch/kernel/irq.c                   |  15 +-
 arch/loongarch/kernel/paravirt.c              |   5 +
 arch/loongarch/kernel/smp.c                   |   6 +
 drivers/irqchip/Kconfig                       |   1 +
 drivers/irqchip/Makefile                      |   2 +-
 drivers/irqchip/irq-loongarch-avec.c          | 426 ++++++++++++++++++
 drivers/irqchip/irq-loongarch-cpu.c           |   5 +-
 drivers/irqchip/irq-loongson-eiointc.c        |   7 +-
 drivers/irqchip/irq-loongson-pch-msi.c        |  82 ++--
 include/linux/cpuhotplug.h                    |   3 +-
 21 files changed, 615 insertions(+), 58 deletions(-)
 create mode 100644 drivers/irqchip/irq-loongarch-avec.c

-- 
2.20.1


