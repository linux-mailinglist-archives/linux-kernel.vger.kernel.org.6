Return-Path: <linux-kernel+bounces-241811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA3A927FD3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 03:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 197181C2184E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 01:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8C3101F2;
	Fri,  5 Jul 2024 01:41:55 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C31833DD;
	Fri,  5 Jul 2024 01:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720143714; cv=none; b=LTS4MZ2SVVBh48LwzVqvZLcWgfN9FTsc1lpC59PxI3EXf5o02ONB37S8qbAx6Ig/8DRHNgFwa/O0tMUwBop2I5elVJobobyKab8BEi4C9fSKv4VL5nVg53Rli5s8zS7SJCcpCXV2L4CPXgoRYD1QtzIspGQwHLtZiXEdeBBHM5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720143714; c=relaxed/simple;
	bh=W9sjv8d6kmkNuqYduzOoNs3ODRPG9F3zv56JdhCF8vc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=MKyZbxKEzIRspwK398UdLrxcnmrk05NVy0XYSo2AjOc0SMV8mcvzLqGNGtm/G2PJGwZHDfL7V4e9JPZxfj/qC3CM2qTRcKM2E5shOOYgotkV9BcfKC2BSvMisUv/Pjp9wJULQK5IN4lS7avbLOV11+kVcbwQCbgZuwKxbIJ3dNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.10.34])
	by gateway (Coremail) with SMTP id _____8BxL_FdT4dm3CABAA--.3951S3;
	Fri, 05 Jul 2024 09:41:49 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.10.34])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Bx28ZcT4dm_cA7AA--.7061S2;
	Fri, 05 Jul 2024 09:41:49 +0800 (CST)
From: Tianyang Zhang <zhangtianyang@loongson.cn>
To: chenhuacai@kernel.org,
	kernel@xen0n.name,
	corbet@lwn.net,
	alexs@kernel.org,
	siyanteng@loongson.cn
Cc: loongarch@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tianyang Zhang <zhangtianyang@loongson.cn>
Subject: [PATCH 1/2] docs: Add advanced extended IRQ model description
Date: Fri,  5 Jul 2024 09:41:44 +0800
Message-Id: <20240705014144.14750-1-zhangtianyang@loongson.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Bx28ZcT4dm_cA7AA--.7061S2
X-CM-SenderInfo: x2kd0wxwld05hdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCFy8Gr17WryfWr4xXrW3twc_yoWrZryDpr
	ZxCryIqF18Gry5Xr17Jr18Wr13G3Z3J3WDtF1xtry8Xr1kAr1Utr1UtrykJFy7G34rAF1j
	qFyrJw1UJw1UJwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1WlkUUUUU=

From 3C6000, Loongarch began to support advanced extended
interrupt mode, in which each CPU has an independent interrupt
vector number.This will enhance the architecture's ability
to support modern devices

Signed-off-by: Tianyang Zhang <zhangtianyang@loongson.cn>
---
 .../arch/loongarch/irq-chip-model.rst         | 33 +++++++++++++++++
 .../zh_CN/arch/loongarch/irq-chip-model.rst   | 37 +++++++++++++++++--
 2 files changed, 67 insertions(+), 3 deletions(-)

diff --git a/Documentation/arch/loongarch/irq-chip-model.rst b/Documentation/arch/loongarch/irq-chip-model.rst
index 7988f4192363..369df16b48d0 100644
--- a/Documentation/arch/loongarch/irq-chip-model.rst
+++ b/Documentation/arch/loongarch/irq-chip-model.rst
@@ -85,6 +85,39 @@ to CPUINTC directly::
     | Devices |
     +---------+
 
+Advanced Extended IRQ model
+===========================
+
+In this model, IPI (Inter-Processor Interrupt) and CPU Local Timer interrupt go
+to CPUINTC directly, CPU UARTS interrupts go to LIOINTC, MSI interrupts go to AVEC,
+and then go to CPUINTC, Other devices interrupts go to PCH-PIC/PCH-LPC and gathered
+by EIOINTC, and then go to CPUINTC directly::
+
+ +-----+     +--------------------------+     +-------+
+ | IPI | --> |           CPUINTC        | <-- | Timer |
+ +-----+     +--------------------------+     +-------+
+              ^        ^             ^
+              |        |             |
+      +--------+  +---------+ +---------+     +-------+
+      | AVEC   |  | EIOINTC | | LIOINTC | <-- | UARTs |
+      +--------+  +---------+ +---------+     +-------+
+           ^            ^
+           |            |
+         +---------+  +---------+
+         | PCH-MSI |  | PCH-PIC |
+         +---------+  +---------+
+            ^          ^       ^
+            |          |       |
+    +---------+ +---------+ +---------+
+    | Devices | | PCH-LPC | | Devices |
+    +---------+ +---------+ +---------+
+                     ^
+                     |
+                +---------+
+                | Devices |
+                +---------+
+
+
 ACPI-related definitions
 ========================
 
diff --git a/Documentation/translations/zh_CN/arch/loongarch/irq-chip-model.rst b/Documentation/translations/zh_CN/arch/loongarch/irq-chip-model.rst
index f1e9ab18206c..15965e191cd1 100644
--- a/Documentation/translations/zh_CN/arch/loongarch/irq-chip-model.rst
+++ b/Documentation/translations/zh_CN/arch/loongarch/irq-chip-model.rst
@@ -9,9 +9,8 @@
 LoongArch的IRQ芯片模型（层级关系）
 ==================================
 
-目前，基于LoongArch的处理器（如龙芯3A5000）只能与LS7A芯片组配合工作。LoongArch计算机
-中的中断控制器（即IRQ芯片）包括CPUINTC（CPU Core Interrupt Controller）、LIOINTC（
-Legacy I/O Interrupt Controller）、EIOINTC（Extended I/O Interrupt Controller）、
+LoongArch计算机中的中断控制器（即IRQ芯片）包括CPUINTC（CPU Core Interrupt Controller）、
+LIOINTC（Legacy I/O Interrupt Controller）、EIOINTC（Extended I/O Interrupt Controller）、
 HTVECINTC（Hyper-Transport Vector Interrupt Controller）、PCH-PIC（LS7A芯片组的主中
 断控制器）、PCH-LPC（LS7A芯片组的LPC中断控制器）和PCH-MSI（MSI中断控制器）。
 
@@ -87,6 +86,38 @@ PCH-LPC/PCH-MSI，然后被EIOINTC统一收集，再直接到达CPUINTC::
     | Devices |
     +---------+
 
+高级扩展IRQ模型
+=======================
+
+在这种模型里面，IPI（Inter-Processor Interrupt）和CPU本地时钟中断直接发送到CPUINTC，
+CPU串口（UARTs）中断发送到LIOINTC，MSI中断发送到AVEC，而后通过AVEC送达CPUINTC，而
+其他所有设备的中断则分别发送到所连接的PCH-PIC/PCH-LPC，然后由EIOINTC统一收集，再直
+接到达CPUINTC::
+
+ +-----+     +--------------------------+     +-------+
+ | IPI | --> |           CPUINTC        | <-- | Timer |
+ +-----+     +--------------------------+     +-------+
+              ^        ^             ^
+              |        |             |
+      +--------+  +---------+ +---------+     +-------+
+      | AVEC   |  | EIOINTC | | LIOINTC | <-- | UARTs |
+      +--------+  +---------+ +---------+     +-------+
+              ^        ^
+              |        |
+      +---------+  +-------------+
+      | PCH-MSI |  |   PCH-PIC   |
+      +---------+  +-------------+
+            ^          ^       ^
+            |          |       |
+    +---------+ +---------+ +---------+
+    | Devices | | PCH-LPC | | Devices |
+    +---------+ +---------+ +---------+
+                     ^
+                     |
+                +---------+
+                | Devices |
+                +---------+
+
 ACPI相关的定义
 ==============
 
-- 
2.20.1


