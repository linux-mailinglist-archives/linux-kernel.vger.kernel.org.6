Return-Path: <linux-kernel+bounces-241813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7C5927FDA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 03:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 504171C21E6E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 01:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C0BF9C9;
	Fri,  5 Jul 2024 01:48:42 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6292572;
	Fri,  5 Jul 2024 01:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720144121; cv=none; b=sjfFtCc/A41XQfurlwa56v+OGUK8A68EiV1yw62uw7PUtrGFWUohg+9s7yJS+uNTq5cUmtju2jEPhspds4FQxQbcmYlHdQklmnY1ky7H8NoCWNFAEtXQZxcPw+7Se+qLD6D15FeI2q3inPZdyB/mIC4t9T0F2yaFpk2FRrWl6dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720144121; c=relaxed/simple;
	bh=i5Z1mggwFXAbkKpfaMKNhZLavFaVMMioMdMYnhUy4pM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=RAESPVdjPwUhudZVeBF4X6pyZqkEJwvWH/ViyTycd120SKnHM0UtHkF4i8VxhV7/kcbBOwseXMAc/N/sOlu9E4d3XumQ5Kowklif+cqpQZT9iAxgCUp4P1CZRKpNlEod8SDCWnf3yR4kZA1bfxQQdxU0vJqKCsXMhTxntnwEKGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.10.34])
	by gateway (Coremail) with SMTP id _____8Ax0PH1UIdmmSEBAA--.3832S3;
	Fri, 05 Jul 2024 09:48:37 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.10.34])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxJMX0UIdmxsI7AA--.62506S2;
	Fri, 05 Jul 2024 09:48:36 +0800 (CST)
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
Subject: [PATCH V2 1/2][RESEND] docs: Add advanced extended IRQ model description
Date: Fri,  5 Jul 2024 09:48:35 +0800
Message-Id: <20240705014835.15931-1-zhangtianyang@loongson.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8CxJMX0UIdmxsI7AA--.62506S2
X-CM-SenderInfo: x2kd0wxwld05hdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCFy8Gr17WryfWr4xXrW3twc_yoWrZrW3pr
	ZxCryIqF18Gry5Xr1UJr18Wr13G3Z3J3WDtF1xtry8Xr1DAr1Dtr1UtrykJFy7G34rAF1j
	qFWrJw4UJw1UJwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUk529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUtVW8ZwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
	XwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0xuctUUUUU==

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
index 7988f4192363..a90c78c8e5bb 100644
--- a/Documentation/arch/loongarch/irq-chip-model.rst
+++ b/Documentation/arch/loongarch/irq-chip-model.rst
@@ -85,6 +85,39 @@ to CPUINTC directly::
     | Devices |
     +---------+
 
+Advanced Extended IRQ model
+===========================
+
+In this model, IPI (Inter-Processor Interrupt) and CPU Local Timer interrupt go
+to CPUINTC directly, CPU UARTS interrupts go to LIOINTC, PCH-MSI interrupts go to AVEC,
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
index f1e9ab18206c..b54567380c90 100644
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
+CPU串口（UARTs）中断发送到LIOINTC，PCH-MSI中断发送到AVEC，而后通过AVEC送达CPUINTC，而
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


