Return-Path: <linux-kernel+bounces-429707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BBB9E2153
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6CB8B458ED
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4711F7547;
	Tue,  3 Dec 2024 15:02:43 +0000 (UTC)
Received: from michel.telenet-ops.be (michel.telenet-ops.be [195.130.137.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205EA1F7065
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 15:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733238163; cv=none; b=TS1n2oZXqwkruMCDKjIsC80CfRhc/GUMX7fsGf26KfTkY/rXfbjoHYSJkd7+Y8SsaEFHxPZFUATR+nOLPUsba02G7Q9diums6+BC7EP/11wRgq6U39b774G4qR4JGpUdE7bm/FFCHdd9wh4JOojyAW+RApo50Ozq35mZfdd9qnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733238163; c=relaxed/simple;
	bh=MGNwTxer6Wojlw0jDQ1+rTgbvF66jcgH60ZHbXXFv+o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UX5nu2Ooe18mqRhbhrR8OtOMKbIg/qs8qL+0L9J0kV+f8bu6I6oAb9KS56aY6973V6PvtEXZtsJMsqrelGS7/LKAhsaM4VKIXVU6JHmCmkppEf1oQuklO4b6bUULQZAlzAPiu0J2faL6422xwAVjb6WdAYQr0hUw2PWvnI/ogZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:829d:a1e7:5b32:5d8e])
	by michel.telenet-ops.be with cmsmtp
	id kF2Z2D00i3sLyzB06F2ZSS; Tue, 03 Dec 2024 16:02:39 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tIUQ5-000Cx8-Og;
	Tue, 03 Dec 2024 16:02:33 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tIUQ5-009WLQ-K9;
	Tue, 03 Dec 2024 16:02:33 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	David Wang <00107082@163.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] genirq: Remove leading space from .irq_print_chip() callbacks
Date: Tue,  3 Dec 2024 16:02:31 +0100
Message-Id: <a779f3f44c24716d783d782c935be9fe4f410bff.1733238060.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The space separator was factored out from the multiple chip name prints,
but several irq_chip.irq_print_chip() callbacks still print a leading
space.  Remove the superfluous double spaces.

Fixes: 9d9f204bdf7243bf ("genirq/proc: Add missing space separator back")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Not even compile-tested...

Feel free to fold this into the original, and fix the spelling
s/previosuly/previously/ while at it.
---
 arch/powerpc/sysdev/fsl_msi.c          | 2 +-
 drivers/bus/moxtet.c                   | 2 +-
 drivers/irqchip/irq-partition-percpu.c | 2 +-
 drivers/soc/qcom/smp2p.c               | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index 1aa0cb097c9c9d7c..7b9a5ea9cad9d3c7 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -75,7 +75,7 @@ static void fsl_msi_print_chip(struct irq_data *irqd, struct seq_file *p)
 	srs = (hwirq >> msi_data->srs_shift) & MSI_SRS_MASK;
 	cascade_virq = msi_data->cascade_array[srs]->virq;
 
-	seq_printf(p, " fsl-msi-%d", cascade_virq);
+	seq_printf(p, "fsl-msi-%d", cascade_virq);
 }
 
 
diff --git a/drivers/bus/moxtet.c b/drivers/bus/moxtet.c
index 6276551d79680e85..1e57ebfb76229aa0 100644
--- a/drivers/bus/moxtet.c
+++ b/drivers/bus/moxtet.c
@@ -657,7 +657,7 @@ static void moxtet_irq_print_chip(struct irq_data *d, struct seq_file *p)
 
 	id = moxtet->modules[pos->idx];
 
-	seq_printf(p, " moxtet-%s.%i#%i", mox_module_name(id), pos->idx,
+	seq_printf(p, "moxtet-%s.%i#%i", mox_module_name(id), pos->idx,
 		   pos->bit);
 }
 
diff --git a/drivers/irqchip/irq-partition-percpu.c b/drivers/irqchip/irq-partition-percpu.c
index 8e76d2913e6bebbf..4441ffe149ea0d96 100644
--- a/drivers/irqchip/irq-partition-percpu.c
+++ b/drivers/irqchip/irq-partition-percpu.c
@@ -98,7 +98,7 @@ static void partition_irq_print_chip(struct irq_data *d, struct seq_file *p)
 	struct irq_chip *chip = irq_desc_get_chip(part->chained_desc);
 	struct irq_data *data = irq_desc_get_irq_data(part->chained_desc);
 
-	seq_printf(p, " %5s-%lu", chip->name, data->hwirq);
+	seq_printf(p, "%5s-%lu", chip->name, data->hwirq);
 }
 
 static struct irq_chip partition_irq_chip = {
diff --git a/drivers/soc/qcom/smp2p.c b/drivers/soc/qcom/smp2p.c
index 4783ab1adb8d953b..a3e88ced328a91f1 100644
--- a/drivers/soc/qcom/smp2p.c
+++ b/drivers/soc/qcom/smp2p.c
@@ -365,7 +365,7 @@ static void smp2p_irq_print_chip(struct irq_data *irqd, struct seq_file *p)
 {
 	struct smp2p_entry *entry = irq_data_get_irq_chip_data(irqd);
 
-	seq_printf(p, " %8s", dev_name(entry->smp2p->dev));
+	seq_printf(p, "%8s", dev_name(entry->smp2p->dev));
 }
 
 static struct irq_chip smp2p_irq_chip = {
-- 
2.34.1


