Return-Path: <linux-kernel+bounces-256223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF45934B09
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 11:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 360B21F2483E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 09:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E8682866;
	Thu, 18 Jul 2024 09:37:11 +0000 (UTC)
Received: from mail.valinux.co.jp (mail.valinux.co.jp [210.128.90.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B185325634
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 09:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.128.90.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721295430; cv=none; b=jcbykHcvIHiDNYboKsLzUFciZjMZIOLzDE+dJz4orASohw8KhU2uFhxOF4wtyvON34Z7sqAqndHOGqQqmu3FefzmqhuIUDnc1O7tv8yx1DiCE67iFzpF0CCauFtoUvtqQBI/xuAp5c6+qdT7roJ6HVkUhtWWNPEOOS1CFaRImm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721295430; c=relaxed/simple;
	bh=sJbPNxK5gRhIDyjMLN+0i8DFfx8g3MhG6j4IptBLT8s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NC/34UV3RZazCFGUOJbJQtfVwVm7fhQ6eO34GPXiikXwIjJ/ZXogLJs0R6z1UQhMdCsEfiSG9ISGcjSY23GPG3WZgulF5XW2Q/kAByzcxckysnv/FW6d+xXtGISOuQl04hNtkWfZ//zuDHcmdhKbf6CVFI6lf6zZEqqHTwL+ai0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; arc=none smtp.client-ip=210.128.90.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Received: from localhost (localhost [127.0.0.1])
	by mail.valinux.co.jp (Postfix) with ESMTP id F07ACA9D5E;
	Thu, 18 Jul 2024 18:37:06 +0900 (JST)
X-Virus-Scanned: Debian amavisd-new at valinux.co.jp
Received: from mail.valinux.co.jp ([127.0.0.1])
	by localhost (mail.valinux.co.jp [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UzITp37JSzLc; Thu, 18 Jul 2024 18:37:06 +0900 (JST)
Received: from DESKTOP-NBGHJ1C.local.valinux.co.jp (vagw.valinux.co.jp [210.128.90.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.valinux.co.jp (Postfix) with ESMTPSA id C2B36A9606;
	Thu, 18 Jul 2024 18:37:06 +0900 (JST)
From: takakura@valinux.co.jp
To: palmer@dabbelt.com,
	bjorn@kernel.org,
	paul.walmsley@sifive.com,
	akpm@linux-foundation.org,
	aou@eecs.berkeley.edu,
	apatel@ventanamicro.com,
	arnd@arndb.de,
	atishp@rivosinc.com,
	bmeng.cn@gmail.com,
	conor.dooley@microchip.com,
	daniel.thompson@linaro.org,
	samuel.holland@sifive.com,
	sfr@canb.auug.org.au
Cc: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	taka@valinux.co.jp,
	Ryo Takakura <takakura@valinux.co.jp>
Subject: [PATCH v2] RISC-V: Enable IPI CPU Backtrace
Date: Thu, 18 Jul 2024 18:36:59 +0900
Message-Id: <20240718093659.158912-1-takakura@valinux.co.jp>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ryo Takakura <takakura@valinux.co.jp>

Add arch_trigger_cpumask_backtrace() which is a generic infrastructure 
for sampling other CPUs' backtrace using IPI.

The feature is used when lockups are detected or in case of oops/panic 
if parameters are set accordingly.

Below is the case of oops with the oops_all_cpu_backtrace enabled.

$ sysctl kernel.oops_all_cpu_backtrace=1

triggering oops shows:
[  212.214237] NMI backtrace for cpu 1
[  212.214390] CPU: 1 PID: 610 Comm: in:imklog Tainted: G           OE      6.10.0-rc6 #1
[  212.214570] Hardware name: riscv-virtio,qemu (DT)
[  212.214690] epc : fallback_scalar_usercopy+0x8/0xdc
[  212.214809]  ra : _copy_to_user+0x20/0x40
[  212.214913] epc : ffffffff80c3a930 ra : ffffffff8059ba7e sp : ff20000000eabb50
[  212.215061]  gp : ffffffff82066f90 tp : ff6000008e958000 t0 : 3463303866660000
[  212.215210]  t1 : 000000000000005b t2 : 3463303866666666 s0 : ff20000000eabb60
[  212.215358]  s1 : 0000000000000386 a0 : 00007ff6e81df926 a1 : ff600000824df800
[  212.215505]  a2 : 000000000000003f a3 : 7fffffffffffffc0 a4 : 0000000000000000
[  212.215651]  a5 : 000000000000003f a6 : 0000000000000000 a7 : 0000000000000000
[  212.215857]  s2 : ff600000824df800 s3 : ffffffff82066cc0 s4 : 0000000000001c1a
[  212.216074]  s5 : ffffffff8206a5a8 s6 : 00007ff6e81df926 s7 : ffffffff8206a5a0
[  212.216278]  s8 : ff600000824df800 s9 : ffffffff81e25de0 s10: 000000000000003f
[  212.216471]  s11: ffffffff8206a59d t3 : ff600000824df812 t4 : ff600000824df812
[  212.216651]  t5 : ff600000824df818 t6 : 0000000000040000
[  212.216796] status: 0000000000040120 badaddr: 0000000000000000 cause: 8000000000000001
[  212.217035] [<ffffffff80c3a930>] fallback_scalar_usercopy+0x8/0xdc
[  212.217207] [<ffffffff80095f56>] syslog_print+0x1f4/0x2b2
[  212.217362] [<ffffffff80096e5c>] do_syslog.part.0+0x94/0x2d8
[  212.217502] [<ffffffff800979e8>] do_syslog+0x66/0x88
[  212.217636] [<ffffffff803a5dda>] kmsg_read+0x44/0x5c
[  212.217764] [<ffffffff80392dbe>] proc_reg_read+0x7a/0xa8
[  212.217952] [<ffffffff802ff726>] vfs_read+0xb0/0x24e
[  212.218090] [<ffffffff803001ba>] ksys_read+0x64/0xe4
[  212.218264] [<ffffffff8030025a>] __riscv_sys_read+0x20/0x2c
[  212.218453] [<ffffffff80c4af9a>] do_trap_ecall_u+0x60/0x1d4
[  212.218664] [<ffffffff80c56998>] ret_from_exception+0x0/0x64

Signed-off-by: Ryo Takakura <takakura@valinux.co.jp>

---

Changes since V1:
https://lore.kernel.org/lkml/20240417050711.41930-1-takakura@valinux.co.jp/
- fix build failure when SMP=n as @Palmer pointed out

---
 arch/riscv/include/asm/irq.h |  5 +++++
 arch/riscv/kernel/smp.c      | 16 ++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/riscv/include/asm/irq.h b/arch/riscv/include/asm/irq.h
index 8e10a9443..8330d16b0 100644
--- a/arch/riscv/include/asm/irq.h
+++ b/arch/riscv/include/asm/irq.h
@@ -12,6 +12,11 @@
 
 #include <asm-generic/irq.h>
 
+#ifdef CONFIG_SMP
+void arch_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude_cpu);
+#define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
+#endif
+
 void riscv_set_intc_hwnode_fn(struct fwnode_handle *(*fn)(void));
 
 struct fwnode_handle *riscv_get_intc_hwnode(void);
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index 8e6eb6445..9b0478997 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -21,6 +21,7 @@
 #include <linux/delay.h>
 #include <linux/irq.h>
 #include <linux/irq_work.h>
+#include <linux/nmi.h>
 
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
@@ -33,6 +34,7 @@ enum ipi_message_type {
 	IPI_CPU_CRASH_STOP,
 	IPI_IRQ_WORK,
 	IPI_TIMER,
+	IPI_CPU_BACKTRACE,
 	IPI_MAX
 };
 
@@ -136,6 +138,9 @@ static irqreturn_t handle_IPI(int irq, void *data)
 		tick_receive_broadcast();
 		break;
 #endif
+	case IPI_CPU_BACKTRACE:
+		nmi_cpu_backtrace(get_irq_regs());
+		break;
 	default:
 		pr_warn("CPU%d: unhandled IPI%d\n", smp_processor_id(), ipi);
 		break;
@@ -203,6 +208,7 @@ static const char * const ipi_names[] = {
 	[IPI_CPU_CRASH_STOP]	= "CPU stop (for crash dump) interrupts",
 	[IPI_IRQ_WORK]		= "IRQ work interrupts",
 	[IPI_TIMER]		= "Timer broadcast interrupts",
+	[IPI_CPU_BACKTRACE]     = "CPU backtrace interrupts",
 };
 
 void show_ipi_stats(struct seq_file *p, int prec)
@@ -323,3 +329,13 @@ void arch_smp_send_reschedule(int cpu)
 	send_ipi_single(cpu, IPI_RESCHEDULE);
 }
 EXPORT_SYMBOL_GPL(arch_smp_send_reschedule);
+
+static void riscv_backtrace_ipi(cpumask_t *mask)
+{
+	send_ipi_mask(mask, IPI_CPU_BACKTRACE);
+}
+
+void arch_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude_cpu)
+{
+	nmi_trigger_cpumask_backtrace(mask, exclude_cpu, riscv_backtrace_ipi);
+}
-- 
2.34.1


