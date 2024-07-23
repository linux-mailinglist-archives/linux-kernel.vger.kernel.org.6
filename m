Return-Path: <linux-kernel+bounces-260262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E999E93A521
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 19:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A484C283F33
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 17:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD162158206;
	Tue, 23 Jul 2024 17:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Slsn31Z3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5F7381B1
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 17:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721757132; cv=none; b=jkfAijt/H6vja7EDZGCcOeAZU5lRR/Ks7igBwzzIukUwJ6WcPDqATkHm+T7vAPMKEXNZKEMNnoTxJElCQKUtaHMB6eGt9SVHEnLLmSZS77L7n1wh5v4+Nf3fUtPegnJSkwhTCJunfMpa1U2f5xUNSjWj/zKrzd5stz3euJ5sWyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721757132; c=relaxed/simple;
	bh=5Vid5ceHiFFWZuNy4oItL9vBhbm1P/wz2ZcWpglh3NI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jH16B4S69qdu9uF0BzvDLslkiZwsfdriH6dnaFqqiqu0k0FiSydWWioIu+ba8mHNpcWyS+PUuMbZHfE1GJZyQM3FTJso8Yzqi3yE27k+E/82IuRMG2j7tScCj5J+IjqxtIHvMcueFjggTlxqlRq1HgK52LTji3o1BMn+nCmFV4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Slsn31Z3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D78C4AF0A;
	Tue, 23 Jul 2024 17:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721757131;
	bh=5Vid5ceHiFFWZuNy4oItL9vBhbm1P/wz2ZcWpglh3NI=;
	h=From:To:Cc:Subject:Date:From;
	b=Slsn31Z3HS1rCiq7noZ/fe9lMibmtTs8AxDQ1S7O5AzClrE9Ik9qvUZDwsuHi4Ddu
	 Q2VzE098efUYrUDs+aLZ+DM/fft7PnWCFkSzNmnfN5rz54fN+hk5/Fl+nF25oFDe+6
	 f9dTPLDEebgoZvJCgJSWZU6ZQUqsj9VFg29OrPSbCaXeN/5e973374K/MeX9+VCX0X
	 xNCPcvY4F5UxjMdBWDb+fT8d9v9q5C2y7EdVpt+CYHO00hL78JfQgAGZ1Z021krgMn
	 ThYGz7NabeIdGlGIi29HwY2DD71Cu1GY+xqMDMzjrt4rb9jySCaay4U0ZKQXgNOhii
	 iK+DT+7X3XW4A==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1sWJgH-00EnZ4-Ue;
	Tue, 23 Jul 2024 18:52:10 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Zhou Wang <wangzhou1@hisilicon.com>
Subject: [PATCH] irqchip/gic-v4: Fix ordering between vmapp and vpe locks
Date: Tue, 23 Jul 2024 18:52:03 +0100
Message-Id: <20240723175203.3193882-1-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tglx@linutronix.de, wangzhou1@hisilicon.com
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
---
 drivers/irqchip/irq-gic-v3-its.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 951ec140bcea2..b88c6011c8771 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1328,12 +1328,6 @@ static void its_send_vmovp(struct its_vpe *vpe)
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
@@ -3808,7 +3802,7 @@ static int its_vpe_set_affinity(struct irq_data *d,
 	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
 	unsigned int from, cpu = nr_cpu_ids;
 	struct cpumask *table_mask;
-	unsigned long flags;
+	unsigned long flags, vmapp_flags;
 
 	/*
 	 * Changing affinity is mega expensive, so let's be as lazy as
@@ -3822,7 +3816,14 @@ static int its_vpe_set_affinity(struct irq_data *d,
 	 * protect us, and that we must ensure nobody samples vpe->col_idx
 	 * during the update, hence the lock below which must also be
 	 * taken on any vLPI handling path that evaluates vpe->col_idx.
+	 *
+	 * Finally, we must protect ourselves against concurrent
+	 * updates of the mapping state on this VM should the ITS list
+	 * be in use.
 	 */
+	if (its_list_map)
+		raw_spin_lock_irqsave(&vpe->its_vm->vmapp_lock, vmapp_flags);
+
 	from = vpe_to_cpuid_lock(vpe, &flags);
 	table_mask = gic_data_rdist_cpu(from)->vpe_table_mask;
 
@@ -3852,6 +3853,9 @@ static int its_vpe_set_affinity(struct irq_data *d,
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
 	vpe_to_cpuid_unlock(vpe, flags);
 
+	if (its_list_map)
+		raw_spin_unlock_irqrestore(&vpe->its_vm->vmapp_lock, vmapp_flags);
+
 	return IRQ_SET_MASK_OK_DONE;
 }
 
-- 
2.39.2


