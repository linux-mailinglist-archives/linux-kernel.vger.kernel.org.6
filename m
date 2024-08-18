Return-Path: <linux-kernel+bounces-291138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1289B955DD4
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 19:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 361851C20C46
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 17:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFB1146000;
	Sun, 18 Aug 2024 17:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohNw+xVN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358E217BA2
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 17:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724001405; cv=none; b=aZYh20pxsYbkMafngsHC0EjUb03/T2IQYlnKUo6AuvW7PyX1h10foYT2LzV/dCCk0KJ1drQoy2pnLHABXPtNTrOBsTY9LF86Y4u8c/9pRU91B2Qyb7k5rrpEWxQR1EpnL8UiDBwGDzCo2e0nnFhITnnBl2o9BPmqL87yrfbx9yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724001405; c=relaxed/simple;
	bh=IH5l4LKZ28y9FltSfBkh7Hp2MJxrD0m1qcEB7e+oW/g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bUhaOMQd7fIvhk+spF2PxumsO6US2YvWoXYpUEllpDYW/gg160REw0mqNw/pGcYB5bYnPk/UCk/ocgW0LP/cZ1JTwTImHWq0VLRO9ID2eGVFR4Hvdmo03zAGJBDo+isRHvT/pUQ+GFbXadGqaK0ff5uSlgd7UboSNnJxoRIlgsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohNw+xVN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA27EC32786;
	Sun, 18 Aug 2024 17:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724001404;
	bh=IH5l4LKZ28y9FltSfBkh7Hp2MJxrD0m1qcEB7e+oW/g=;
	h=From:To:Cc:Subject:Date:From;
	b=ohNw+xVNrV07olTSSScinCGnKaW2NQBJxyYrVLfIj2Vt+4ISHEkzmE5VfLIA4aqNA
	 5sZEwUKhTwFVzu8GjpxZGLY0aTPSrEkQbDtiN594DhCpbtic+OGWfIypl5WMq5xbt6
	 6F2pXek01DymPYZnYh4nbfDrUymyFy2rPAuxPe8Ez2NxTI+iPuZGy0XvNHrNx/Hh0Y
	 hHIvDmH99ENI6dlpZoiNHP5x5YYqzFC0htS3sUeNfHBP4xSKX8ecUrQC0oXEm2nc70
	 tNSukMzQs/qME7lN1K++wd614mA/FNImwSyCNDpg10hEMHnMiPu0vMajd7sehduOD6
	 2WeYDkpnqwoUQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1sfjWE-004hiP-I7;
	Sun, 18 Aug 2024 18:16:42 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Zhou Wang <wangzhou1@hisilicon.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2] irqchip/gic-v4: Fix ordering between vmapp and vpe locks
Date: Sun, 18 Aug 2024 18:16:25 +0100
Message-Id: <20240818171625.3030584-1-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, wangzhou1@hisilicon.com, tglx@linutronix.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

The (recently established) lock ordering mandates that the per-VM
vmapp_lock is acquired before we take the per-VPE lock.

As it turns out, its_vpe_set_affinity() takes the VPE lock, and
then calls into its_send_vmovp(), which itself takes the vmapp
lock. Obviously, this isn't what we want.

As its_send_vmovp() is only called from its_vpe_set_affinity(),
hoist the vmapp locking from the former into the latter, restoring
the expected order.

Fixes: f0eb154c39471 ("irqchip/gic-v4: Substitute vmovp_lock for a per-VM lock")
Reported-by: Zhou Wang <wangzhou1@hisilicon.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---

Notes:
    v2:
      - Dropped flags and rely on the irq_data being locked with interrupts
        disabled
    
      - Add extra documentation to explain why taking the vmapp_lock is
        dependent on the HW requiring the use of the ITS list
    
    v1: https://lore.kernel.org/r/20240723175203.3193882-1-maz@kernel.org

 drivers/irqchip/irq-gic-v3-its.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 9b34596b3542..fdec478ba5e7 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1329,12 +1329,6 @@ static void its_send_vmovp(struct its_vpe *vpe)
 		return;
 	}
 
-	/*
-	 * Protect against concurrent updates of the mapping state on
-	 * individual VMs.
-	 */
-	guard(raw_spinlock_irqsave)(&vpe->its_vm->vmapp_lock);
-
 	/*
 	 * Yet another marvel of the architecture. If using the
 	 * its_list "feature", we need to make sure that all ITSs
@@ -3824,7 +3818,14 @@ static int its_vpe_set_affinity(struct irq_data *d,
 	 * protect us, and that we must ensure nobody samples vpe->col_idx
 	 * during the update, hence the lock below which must also be
 	 * taken on any vLPI handling path that evaluates vpe->col_idx.
+	 *
+	 * Finally, we must protect ourselves against concurrent updates of
+	 * the mapping state on this VM should the ITS list be in use (see
+	 * the shortcut in its_send_vmovp() otherewise).
 	 */
+	if (its_list_map)
+		raw_spin_lock(&vpe->its_vm->vmapp_lock);
+
 	from = vpe_to_cpuid_lock(vpe, &flags);
 	table_mask = gic_data_rdist_cpu(from)->vpe_table_mask;
 
@@ -3854,6 +3855,9 @@ static int its_vpe_set_affinity(struct irq_data *d,
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
 	vpe_to_cpuid_unlock(vpe, flags);
 
+	if (its_list_map)
+		raw_spin_unlock(&vpe->its_vm->vmapp_lock);
+
 	return IRQ_SET_MASK_OK_DONE;
 }
 
-- 
2.39.2


