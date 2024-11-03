Return-Path: <linux-kernel+bounces-393778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E019BA51F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 11:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16878B218C1
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 10:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90FA1632FB;
	Sun,  3 Nov 2024 10:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vCHae+lJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QwveuwGA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E6C4430
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 10:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730629868; cv=none; b=TRFTGVCUmPGXokiky3gOWqn01d6pwfP8/N3mmbEo7YskkmJ5lZtjXSVCUjp9mdTakmWwWqpKtv01n8vdGTJ6aLG0xzryB43iNy8LUgyAqSeN8YFtshDXJtv6qm+YW1sp2hE7BYWT5t6+8iAhYIoiUJR8Pd1n7XaXgRI8vcqHwak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730629868; c=relaxed/simple;
	bh=8J/scv9Yyfqwu5ZtC/SJgA9Fvxvj/0VMQERlNo5mD9Y=;
	h=From:To:Cc:Subject:Message-ID:Content-Type:MIME-Version:Date; b=JmpfS6FfV7yoNAmHR7IDJSsKtXwQL+05DJvYCV/GdtFEnQ76qPq377UwpsZnIaunUVcRuFGJ8yFn4amnH3Wz9kwNIsQ3hFPKKeWY7orp2m3AA645XvEj15IF0q6jMq9WBhjoZpZLdVgIpP4PUCOccL5YA2YHkAEkMV9QoGywC4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vCHae+lJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QwveuwGA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730629859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=l6YyKt+6h2EhcE1sCOji1ntKCWQwCB5CQ3dFyB6GSwE=;
	b=vCHae+lJNpB/CImaLUc4YB1VLOdkST3irWp7mu3mi2FFIMq/fe3QTreqnKqgWIiOJjd6TM
	JuqVCAn3MJ5a+H3qaBelmaXAxOKV2/qaWcbZDXqjBi/E3WgPl33WMwsOE/MdEAO3EXC8mk
	umHo9vnKtjEVjVrZo+jMNajWoudit+QQZ2tzPvocbao0tGa+d7HXJyZ8qsBOcDKWvtj44x
	GCN/dSUTbztpTwiHwd4aglgEr3AqBl9WjdOQD9Ok2RBA3DCvn75PshHfQHPIGwjcg/bLZT
	LxLWkFlYDxfXlrEbw8a6NEQMeg5jrqp1+OkUlff24spTZWQBIduYGg4MuQndkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730629859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=l6YyKt+6h2EhcE1sCOji1ntKCWQwCB5CQ3dFyB6GSwE=;
	b=QwveuwGAZ0gbtHl3dJC1WcEIuOwqDKq0N2dQlin+xNs/7dAyDO1oj6LOCbUxneJvMVLsSD
	mtyL/WqccleWibBg==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/urgent for v6.12-rc6
Message-ID: <173062982864.1467946.2540622433845043721.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun,  3 Nov 2024 11:30:58 +0100 (CET)

Linus,

please pull the latest irq/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2024-=
11-03

up to:  e6c24e2d05bb: irqchip/gic-v4: Correctly deal with set_affinity on laz=
ily-mapped VPEs

Two fixes for the interrupt subsystem:

  - Fix an off-by-one error in the failure path of msi_domain_alloc(),
    which causes the cleanup loop to terminate early and leaking the first
    allocated interrupt.

  - Handle a corner case in GIC-V4 versus a lazily mapped Virtual
    Processing Element (VPE). If the VPE has not been mapped because the
    guest has not yet emitted a mapping command, then the set_affinity()
    callback returns an error code, which causes the vCPU management to fail.

    Return success in this case without touching the hardware. This will be
    done later when the guest issues the mapping command.


Thanks,

	tglx

------------------>
Jinjie Ruan (1):
      genirq/msi: Fix off-by-one error in msi_domain_alloc()

Marc Zyngier (1):
      irqchip/gic-v4: Correctly deal with set_affinity on lazily-mapped VPEs


 drivers/irqchip/irq-gic-v3-its.c | 14 ++++++++++++--
 kernel/irq/msi.c                 |  2 +-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-it=
s.c
index ab597e74ba08..52f625e07658 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3810,8 +3810,18 @@ static int its_vpe_set_affinity(struct irq_data *d,
 	 * Check if we're racing against a VPE being destroyed, for
 	 * which we don't want to allow a VMOVP.
 	 */
-	if (!atomic_read(&vpe->vmapp_count))
-		return -EINVAL;
+	if (!atomic_read(&vpe->vmapp_count)) {
+		if (gic_requires_eager_mapping())
+			return -EINVAL;
+
+		/*
+		 * If we lazily map the VPEs, this isn't an error and
+		 * we can exit cleanly.
+		 */
+		cpu =3D cpumask_first(mask_val);
+		irq_data_update_effective_affinity(d, cpumask_of(cpu));
+		return IRQ_SET_MASK_OK_DONE;
+	}
=20
 	/*
 	 * Changing affinity is mega expensive, so let's be as lazy as
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 3a24d6b5f559..396a067a8a56 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -718,7 +718,7 @@ static int msi_domain_alloc(struct irq_domain *domain, un=
signed int virq,
 		ret =3D ops->msi_init(domain, info, virq + i, hwirq + i, arg);
 		if (ret < 0) {
 			if (ops->msi_free) {
-				for (i--; i > 0; i--)
+				for (i--; i >=3D 0; i--)
 					ops->msi_free(domain, info, virq + i);
 			}
 			irq_domain_free_irqs_top(domain, virq, nr_irqs);


