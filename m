Return-Path: <linux-kernel+bounces-348236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F28598E46E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 22:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB9671C2215B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A8721730E;
	Wed,  2 Oct 2024 20:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2VPB6lg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46638F5B
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 20:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727902208; cv=none; b=cDx+lZpghQ9CrLQFQb6Ak5TdoIJvZTC5U6tS+u8ljHFiaBaq4Gz10PjnC/E0CVJ9Rhvu8KerRaUQzXqK7oYa1QtlMnoM0+7K3/yhD9PPbOYS9WIKM2lUG1rHX0m2E6irQdQTXRQCfegIoEWDQvtBgrXnIpzUF/8mP8VcJZYD6d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727902208; c=relaxed/simple;
	bh=EzAhzhPe4Btd9G9e7PzjRjwWjnMieddv+xz93hivynI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s/cjCL4qF+3DB4oRWvMszS5Z8lLUYO4qtZtE5oSZD5ZiJeat73LshbvKObsr4RYCqudRJbJdlM0Iza2pA4NkQJJsTWnBXROLNWTn6Lz4vSAIfhVnqWkNsqb7Ip9z+QSafeP6RAZuNBGUBfUw+2yUwnfFd2K969ekhCpnun+RfK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2VPB6lg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE77C4CEC2;
	Wed,  2 Oct 2024 20:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727902207;
	bh=EzAhzhPe4Btd9G9e7PzjRjwWjnMieddv+xz93hivynI=;
	h=From:To:Cc:Subject:Date:From;
	b=J2VPB6lgrQRlbMn32RI8kDgiXJ4DrV/0PH7buNEoS0ajLdLYaKbuPOIf8KLiMDX7A
	 weezhlga6Mgwhue6EgZk8vtgxbmcHS8Gy3IZBhfkfrf4nv2c9n9UgycYR+FcG5h3Xv
	 td94ypQHitLcSJ+ArMjjOW50lGEUDl1Bc3bPZWe+zsA06aDsG3fd/KS0H3V1wz/hYx
	 7xqNn2gYpyf87ezfwedo16JTtK1EvNrYX2GbkQr9/zGTrCX9ef/mBrRKx1iFJbIkyK
	 LP/Up8n8Fgt/QStZtDjItG4AegVeDFP5JSVgJTYZDPpFFQw90IpjHsxVkPTGD4pWmJ
	 di2qvGVF13+jA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1sw6IP-00HA78-IN;
	Wed, 02 Oct 2024 21:50:05 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Kunkun Jiang <jiangkunkun@huawei.com>
Subject: [PATCH] irqchip/gic-v4: Don't allow a VMOVP on a dying VPE
Date: Wed,  2 Oct 2024 21:49:59 +0100
Message-Id: <20241002204959.2051709-1-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tglx@linutronix.de, jiangkunkun@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

Kunkun Jiang reports that there is a small window of opportunity for
userspace to force a change of affinity for a VPE while the VPE has
already been unmapped, but the corresponding doorbell interrupt still
visible in /proc/irq/.

Plug the race by checking the value of vmapp_count, which tracks whether
the VPE is mapped ot not, and returning an error in this case.

This involves making vmapp_count common to both GICv4.1 and its v4.0
ancestor.

Reported-by: Kunkun Jiang <jiangkunkun@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/c182ece6-2ba0-ce4f-3404-dba7a3ab6c52@huawei.com
---
 drivers/irqchip/irq-gic-v3-its.c   | 18 ++++++++++++------
 include/linux/irqchip/arm-gic-v4.h |  4 +++-
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index fdec478ba5e7..ab597e74ba08 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -797,8 +797,8 @@ static struct its_vpe *its_build_vmapp_cmd(struct its_node *its,
 	its_encode_valid(cmd, desc->its_vmapp_cmd.valid);
 
 	if (!desc->its_vmapp_cmd.valid) {
+		alloc = !atomic_dec_return(&desc->its_vmapp_cmd.vpe->vmapp_count);
 		if (is_v4_1(its)) {
-			alloc = !atomic_dec_return(&desc->its_vmapp_cmd.vpe->vmapp_count);
 			its_encode_alloc(cmd, alloc);
 			/*
 			 * Unmapping a VPE is self-synchronizing on GICv4.1,
@@ -817,13 +817,13 @@ static struct its_vpe *its_build_vmapp_cmd(struct its_node *its,
 	its_encode_vpt_addr(cmd, vpt_addr);
 	its_encode_vpt_size(cmd, LPI_NRBITS - 1);
 
+	alloc = !atomic_fetch_inc(&desc->its_vmapp_cmd.vpe->vmapp_count);
+
 	if (!is_v4_1(its))
 		goto out;
 
 	vconf_addr = virt_to_phys(page_address(desc->its_vmapp_cmd.vpe->its_vm->vprop_page));
 
-	alloc = !atomic_fetch_inc(&desc->its_vmapp_cmd.vpe->vmapp_count);
-
 	its_encode_alloc(cmd, alloc);
 
 	/*
@@ -3806,6 +3806,13 @@ static int its_vpe_set_affinity(struct irq_data *d,
 	struct cpumask *table_mask;
 	unsigned long flags;
 
+	/*
+	 * Check if we're racing against a VPE being destroyed, for
+	 * which we don't want to allow a VMOVP.
+	 */
+	if (!atomic_read(&vpe->vmapp_count))
+		return -EINVAL;
+
 	/*
 	 * Changing affinity is mega expensive, so let's be as lazy as
 	 * we can and only do it if we really have to. Also, if mapped
@@ -4463,9 +4470,8 @@ static int its_vpe_init(struct its_vpe *vpe)
 	raw_spin_lock_init(&vpe->vpe_lock);
 	vpe->vpe_id = vpe_id;
 	vpe->vpt_page = vpt_page;
-	if (gic_rdists->has_rvpeid)
-		atomic_set(&vpe->vmapp_count, 0);
-	else
+	atomic_set(&vpe->vmapp_count, 0);
+	if (!gic_rdists->has_rvpeid)
 		vpe->vpe_proxy_event = -1;
 
 	return 0;
diff --git a/include/linux/irqchip/arm-gic-v4.h b/include/linux/irqchip/arm-gic-v4.h
index ecabed6d3307..7f1f11a5e4e4 100644
--- a/include/linux/irqchip/arm-gic-v4.h
+++ b/include/linux/irqchip/arm-gic-v4.h
@@ -66,10 +66,12 @@ struct its_vpe {
 				bool	enabled;
 				bool	group;
 			}			sgi_config[16];
-			atomic_t vmapp_count;
 		};
 	};
 
+	/* Track the VPE being mapped */
+	atomic_t vmapp_count;
+
 	/*
 	 * Ensures mutual exclusion between affinity setting of the
 	 * vPE and vLPI operations using vpe->col_idx.
-- 
2.39.2


