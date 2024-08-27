Return-Path: <linux-kernel+bounces-302725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12203960290
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 08:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4F232836EC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 06:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2DC149DF4;
	Tue, 27 Aug 2024 06:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/mXZwQ4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B67712F5B1
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 06:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724741822; cv=none; b=r3mSbk2LLgTjMTd8b1JALQm+pjZrlq6QCJpPVcfk1bLyayCRWPiu2M++22Xhg5C5ZN34HZ95yNrOoxnQgFqgsHnw0tqaKoPva762fVaP8oHe6dO+gzh39j07hmrhTQUv8S3I+4WVBYtbon9BDIXmylWj9wZR4dt9XNgS34lePgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724741822; c=relaxed/simple;
	bh=ezhnBn+svLypWWak/HUTqxPGsQXmRMP/Q4mzTULYzAc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=auq3iCKcqU2lLkiHsnN7m+cPI/PGmYrxiQqvntnyMQhWUSO5hEmTVjjYamKiwmw0NsaS8FKsw41pwfTbxDaYNJzmtjfBlRSNbhmRwduxTlh+hv07vW2P7A0/2WFddvR/umKH8Z2tqUqr53ToXeaXjYJeHzSzGHSCfBevMqkdX0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/mXZwQ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E149C4FDFE;
	Tue, 27 Aug 2024 06:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724741822;
	bh=ezhnBn+svLypWWak/HUTqxPGsQXmRMP/Q4mzTULYzAc=;
	h=From:To:Cc:Subject:Date:From;
	b=L/mXZwQ47kWxN4a+CjbnQ7NtOVz3VaodLK8eirEzAz04dIUTv38Q6osnaPtdJxEmo
	 rQgpgJbrn/ULTtWkt6wE1TdnPEKiy2OOncGJaulLl+o1e9nwL2uNp46zIdweeDYISg
	 S1/sUFPEYYY3JlATY4c4SWTYLdfNd5Ly78NlxKSopuPNazQMJhHtxvQ65Fv+Z3tca+
	 2BsHgo+SycewF4C5IzR6eScYbFolbzEem9mzBHFzJRlifI/w9i50dYxCiRtIlvltM8
	 QAU0idAsoGAzP/gerWl/sHxl0AQnidIw+fvwqW8UjlRvdZd8GN0ZACPY4qz3kR6nTr
	 0dRITXVTDOQkA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1siq8S-0077T8-5S;
	Tue, 27 Aug 2024 07:57:00 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Kunkun Jiang <jiangkunkun@huawei.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2] genirq: Get rid of global lock in irq_do_set_affinity()
Date: Tue, 27 Aug 2024 07:56:36 +0100
Message-Id: <20240827065636.3904806-1-maz@kernel.org>
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

Notes:
    v2: Move the per-CPU data outside of irq_do_set_affinity() so that
        it doesn't break with weak per-CPU requirements.

 kernel/irq/manage.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index dd53298ef1a5..3c3fd2b2498c 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -218,21 +218,20 @@ static void irq_validate_effective_affinity(struct irq_data *data)
 static inline void irq_validate_effective_affinity(struct irq_data *data) { }
 #endif
 
+static DEFINE_PER_CPU(struct cpumask, __tmp_mask);
+
 int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
 			bool force)
 {
 	struct irq_desc *desc = irq_data_to_desc(data);
 	struct irq_chip *chip = irq_data_get_irq_chip(data);
+	struct cpumask *tmp_mask = this_cpu_ptr(&__tmp_mask);
 	const struct cpumask  *prog_mask;
 	int ret;
 
-	static DEFINE_RAW_SPINLOCK(tmp_mask_lock);
-	static struct cpumask tmp_mask;
-
 	if (!chip || !chip->irq_set_affinity)
 		return -EINVAL;
 
-	raw_spin_lock(&tmp_mask_lock);
 	/*
 	 * If this is a managed interrupt and housekeeping is enabled on
 	 * it check whether the requested affinity mask intersects with
@@ -258,11 +257,11 @@ int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
 
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
@@ -272,16 +271,14 @@ int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
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


