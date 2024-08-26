Return-Path: <linux-kernel+bounces-300997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AF295EB62
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F35991F2419C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4607C2D052;
	Mon, 26 Aug 2024 08:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ao3m1FOn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB6812BF25
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 08:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724659584; cv=none; b=pcT/kJ+N01n0WQvcBpe5yRWR71tGIdXBYQeiQ1Ll5vX0oGbdI1WLVxXQUjWxhG4+atIhhULdNOBLBGflKUhvWNan3k6dgbSC7Yo2u312LPhAy/O6yjDEdNVWvLIgUhmuBpfzNDhu2yCV45wviSMLP+DbTrZ2o9sYk5hl3r5bEL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724659584; c=relaxed/simple;
	bh=b3tXBYNEPnAge+PKHiarJ/PDWxcHzKSL3eoOZCdOqRk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K6cYstxS7C8EnfNM4gUYOKZBfdCQ05wgBU2zuXe/Xb1ChXgb5suwJ9tAjEbAM4T5qyPm4dttDsGZ/HIrKyqmRMXwAAabTZ9byP0rx8yy300o/8u8LIG+RFM8Ft+wW3G7coUNVMMIFjI1wX4o1LkQhKHgxDNN/DQYk+PSpCtsHzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ao3m1FOn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2311AC568AA;
	Mon, 26 Aug 2024 08:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724659584;
	bh=b3tXBYNEPnAge+PKHiarJ/PDWxcHzKSL3eoOZCdOqRk=;
	h=From:To:Cc:Subject:Date:From;
	b=Ao3m1FOn2t/0WoHCZgJT8Q6gVJRx6xVkS6HR0hxTRTt8WIXhffrnSdnap6G84EB/9
	 PRTKuplazHl+4vyT+DvjDHTBqLbEbGbBWsMonJoKijIKAI3QMAg3aWdTfPMsKXXT2k
	 BUfTEdP/hJEShHzKaL+nasH3LMRYZeeZ+uN2lHHsTQFDkjtOaQdVb1FeuJx8FPW0LM
	 s0cClXuevP1KeI75U8YzurD9kH4RcLQCObgOiFwmcLrhvA5Za5bahdI81/DpGS37uL
	 CzKu0yZljJBg0VC/+DRQgYYYN2W9wLXBPYUPk8vaPxRizXCYd/LZ91fYuB1t/epTVl
	 qgnDyCxxPl5Cw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1siUk2-006oGA-0G;
	Mon, 26 Aug 2024 09:06:22 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Kunkun Jiang <jiangkunkun@huawei.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] genirq: Get rid of global lock in irq_do_set_affinity()
Date: Mon, 26 Aug 2024 09:06:18 +0100
Message-Id: <20240826080618.3886694-1-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, jiangkunkun@huawei.com, tglx@linutronix.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

Kunkun Jiang reports that for a workload involving the simultaneous
startup of a large number of VMs (for a total of about 200 vcpus),
a lot of CPU time gets spent on spinning on the tmp_mask_lock that
exists as a static raw spinlock in irq_do_set_affinity(). This lock
protects a global cpumask (tmp_mask) that is used as a temporary
variable to compute the resulting affinity.

While this is triggered by KVM issuing a irq_set_affinity() call
each time a vcpu is about to execute, it is obvious that having
a single global resource is not very scalable, and that we could
do something better.

Since a cpumask can be a fairly large structure on systems with
a high core count, a stack allocation is not really appropriate.
Instead, turn the global cpumask into a per-CPU variable, removing
the need for locking altogether as we are not preemptible at this
point.

Reported-by: Kunkun Jiang <jiangkunkun@huawei.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 kernel/irq/manage.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index dd53298ef1a5..b6aa259ac749 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -224,15 +224,16 @@ int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
 	struct irq_desc *desc = irq_data_to_desc(data);
 	struct irq_chip *chip = irq_data_get_irq_chip(data);
 	const struct cpumask  *prog_mask;
+	struct cpumask *tmp_mask;
 	int ret;
 
-	static DEFINE_RAW_SPINLOCK(tmp_mask_lock);
-	static struct cpumask tmp_mask;
+	static DEFINE_PER_CPU(struct cpumask, __tmp_mask);
 
 	if (!chip || !chip->irq_set_affinity)
 		return -EINVAL;
 
-	raw_spin_lock(&tmp_mask_lock);
+	tmp_mask = this_cpu_ptr(&__tmp_mask);
+
 	/*
 	 * If this is a managed interrupt and housekeeping is enabled on
 	 * it check whether the requested affinity mask intersects with
@@ -258,11 +259,11 @@ int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
 
 		hk_mask = housekeeping_cpumask(HK_TYPE_MANAGED_IRQ);
 
-		cpumask_and(&tmp_mask, mask, hk_mask);
-		if (!cpumask_intersects(&tmp_mask, cpu_online_mask))
+		cpumask_and(tmp_mask, mask, hk_mask);
+		if (!cpumask_intersects(tmp_mask, cpu_online_mask))
 			prog_mask = mask;
 		else
-			prog_mask = &tmp_mask;
+			prog_mask = tmp_mask;
 	} else {
 		prog_mask = mask;
 	}
@@ -272,16 +273,14 @@ int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
 	 * unless we are being asked to force the affinity (in which
 	 * case we do as we are told).
 	 */
-	cpumask_and(&tmp_mask, prog_mask, cpu_online_mask);
-	if (!force && !cpumask_empty(&tmp_mask))
-		ret = chip->irq_set_affinity(data, &tmp_mask, force);
+	cpumask_and(tmp_mask, prog_mask, cpu_online_mask);
+	if (!force && !cpumask_empty(tmp_mask))
+		ret = chip->irq_set_affinity(data, tmp_mask, force);
 	else if (force)
 		ret = chip->irq_set_affinity(data, mask, force);
 	else
 		ret = -EINVAL;
 
-	raw_spin_unlock(&tmp_mask_lock);
-
 	switch (ret) {
 	case IRQ_SET_MASK_OK:
 	case IRQ_SET_MASK_OK_DONE:
-- 
2.39.2


