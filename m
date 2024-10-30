Return-Path: <linux-kernel+bounces-389257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D44399B6AAA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 18:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E9C71F26125
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 17:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7FC21832D;
	Wed, 30 Oct 2024 17:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="JawHfHZc"
Received: from mail-oa1-f98.google.com (mail-oa1-f98.google.com [209.85.160.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035EB2170CB
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 17:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730308042; cv=none; b=HtQVs4hl3UekSyidNjeWAzYlGUSuLw+ugZgGcVg8JzW2yslfj23uy8EaM0tc0sGJS0TtA1ofAvrDR1w6/hfghxocs4ueh5noX98k0Om+KKpqTdtM1cxPyBlIvZZmxpyfdm82/5lNEmNAyn1ZgbVLcYGv14Ade/tyCDCw0I/dzmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730308042; c=relaxed/simple;
	bh=sscV9c36s+nmYEYc5d7ETnwRVHtNENWYWlf4AeFX+zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fv1aTHTG1gOS96Ci/McHHtjHOa/7MHVR2ORZTVawrEt2+B9KAjYFSJ64JXBr1nUVM8ELt5wZsdcO0X5nd7C6sWsUcKK0jLMwOzv9S2JU38+YyfZ1gsMI2WVRiLlycyagxOLEasSbmoM1hJV6+y0IAf2DsAxaOtzFY6B9R/YPXBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=JawHfHZc; arc=none smtp.client-ip=209.85.160.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-oa1-f98.google.com with SMTP id 586e51a60fabf-28c5f01eea5so10626fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 10:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1730308038; x=1730912838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RbWXoubdOFjc0J90dYCjMPhouSyIa4++HhnBIkRskoA=;
        b=JawHfHZcTtKnyld/0z2+jIuBs8ajmXjoINzJSbI48EB1V2zKpWLSYKoG24eMwq1Pxh
         pmo/efce7ublymZepZ5Yp+W5Bi86wC3luMNzEW0SQAnsbm50AkEPpW/9517u+YGB3QVH
         lXk1+o2f99JwpHqeTNm+ltg+PU+MmXRKkyQp7dJ7cDt14mq40AJryBwhdPEIxad1LMBs
         dg0HUNDshOFrpOMkqnsavyZ465zqWKGNlFYEMzc04+LWcq0Ll3E8KOaaSr6OU6rWoFuR
         K/6OhHzdbD5Ne2psH/DSsG/RaiYtQvUdgb1pdzWS6ZLeQ79gvj0mXOD+gXD1FZJZiXbD
         fNJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730308038; x=1730912838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RbWXoubdOFjc0J90dYCjMPhouSyIa4++HhnBIkRskoA=;
        b=Ak3TghGbL3+dZTyFnd6It39LtkzG5aNzhlnLRhNs9YoxLmL2s4K1vaeteOgUDqbAye
         sdPCn8iqFVdJ/fhvpMZxOSJhBsTr+GQrSpwfMz2qX6rAVhqdEKZb6DIrFhccRGPyTYrS
         EnGqosAxerRvtUnwE4Syha0xM7CDb1kkcqSts364ZppRpYbnvJ8xUYTQfD4fadEbI9Qq
         LKZZ3vpJ2165bfY/iSjd/ldYddsEga1p7IRpoXqii6anKDO34qGGooeY8YZFPvud6v2Z
         PH8rgy31OVEMGba1WVNnUHeOKmA1vamavglyMP0mn6A1e/mIWqPgJ69sa3eJVmME3IfX
         nMrA==
X-Forwarded-Encrypted: i=1; AJvYcCWzT3lTamDMy0f82XVKKkJFsSMzFzU3Wpa8lnm65e9i4fG1a5fX+uSH1p7EYY/M1BEBE6wYPNHGGD1p+rk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQJlMtZM4KvQPZevTOolUfTT6DIUmFmLVM0chjo2Sd4/8Xf5Vy
	IBS1arDHv5J6DbYOvdlK4bCA5xHMmcxryi55O1j7/fu4dgGmRA6umoChU1ge4mnIW43KPZWTW/5
	qSnOZhWtbtZjnEHB4KeE6srQNrCPpJaHP2jkTkk6lM7wqykxj
X-Google-Smtp-Source: AGHT+IFZ1ja9hOm6xMDtpK+g/fuGzrKd8ri+RB3+ls3i5NMQT1baHJAWIH9aQoyhyCOGJDr0RPF9+sujZcx7
X-Received: by 2002:a05:6870:b513:b0:27b:56b1:9ded with SMTP id 586e51a60fabf-29051b6d026mr4285823fac.5.1730308038088;
        Wed, 30 Oct 2024 10:07:18 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-29035d10eccsm264258fac.2.2024.10.30.10.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 10:07:18 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id DF5EC3406B0;
	Wed, 30 Oct 2024 11:07:16 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id D28C1E40BBB; Wed, 30 Oct 2024 11:06:46 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Parav Pandit <parav@nvidia.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] mlx5: only schedule EQ comp tasklet if necessary
Date: Wed, 30 Oct 2024 11:06:18 -0600
Message-ID: <20241030170619.3126428-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <CY8PR12MB7195672F740581A045ADBF8CDC542@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <CY8PR12MB7195672F740581A045ADBF8CDC542@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the mlx5_eq_comp_int() interrupt handler schedules a tasklet
to call mlx5_cq_tasklet_cb() if it processes any completions. For CQs
whose completions don't need to be processed in tasklet context, this
adds unnecessary overhead. In a heavy TCP workload, we see 4% of CPU
time spent on the tasklet_trylock() in tasklet_action_common(), with a
smaller amount spent on the atomic operations in tasklet_schedule(),
tasklet_clear_sched(), and locking the spinlock in mlx5_cq_tasklet_cb().
TCP completions are handled by mlx5e_completion_event(), which schedules
NAPI to poll the queue, so they don't need tasklet processing.

Schedule the tasklet in mlx5_add_cq_to_tasklet() instead to avoid this
overhead. mlx5_add_cq_to_tasklet() is responsible for enqueuing the CQs
to be processed in tasklet context, so it can schedule the tasklet. CQs
that need tasklet processing have their interrupt comp handler set to
mlx5_add_cq_to_tasklet(), so they will schedule the tasklet. CQs that
don't need tasklet processing won't schedule the tasklet. To avoid
scheduling the tasklet multiple times during the same interrupt, only
schedule the tasklet in mlx5_add_cq_to_tasklet() if the tasklet work
queue was empty before the new CQ was pushed to it.

The additional branch in mlx5_add_cq_to_tasklet(), called for each EQE,
may add a small cost for the userspace Infiniband CQs whose completions
are processed in tasklet context. But this seems worth it to avoid the
tasklet overhead for CQs that don't need it.

Note that the mlx4 driver works the same way: it schedules the tasklet
in mlx4_add_cq_to_tasklet() and only if the work queue was empty before.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/cq.c | 5 +++++
 drivers/net/ethernet/mellanox/mlx5/core/eq.c | 5 +----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cq.c b/drivers/net/ethernet/mellanox/mlx5/core/cq.c
index 4caa1b6f40ba..25f3b26db729 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/cq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cq.c
@@ -69,22 +69,27 @@ void mlx5_cq_tasklet_cb(struct tasklet_struct *t)
 static void mlx5_add_cq_to_tasklet(struct mlx5_core_cq *cq,
 				   struct mlx5_eqe *eqe)
 {
 	unsigned long flags;
 	struct mlx5_eq_tasklet *tasklet_ctx = cq->tasklet_ctx.priv;
+	bool schedule_tasklet = false;
 
 	spin_lock_irqsave(&tasklet_ctx->lock, flags);
 	/* When migrating CQs between EQs will be implemented, please note
 	 * that you need to sync this point. It is possible that
 	 * while migrating a CQ, completions on the old EQs could
 	 * still arrive.
 	 */
 	if (list_empty_careful(&cq->tasklet_ctx.list)) {
 		mlx5_cq_hold(cq);
+		schedule_tasklet = list_empty(&tasklet_ctx->list);
 		list_add_tail(&cq->tasklet_ctx.list, &tasklet_ctx->list);
 	}
 	spin_unlock_irqrestore(&tasklet_ctx->lock, flags);
+
+	if (schedule_tasklet)
+		tasklet_schedule(&tasklet_ctx->task);
 }
 
 /* Callers must verify outbox status in case of err */
 int mlx5_create_cq(struct mlx5_core_dev *dev, struct mlx5_core_cq *cq,
 		   u32 *in, int inlen, u32 *out, int outlen)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
index 859dcf09b770..3fd2091c11c8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
@@ -112,14 +112,14 @@ static int mlx5_eq_comp_int(struct notifier_block *nb,
 	struct mlx5_eq_comp *eq_comp =
 		container_of(nb, struct mlx5_eq_comp, irq_nb);
 	struct mlx5_eq *eq = &eq_comp->core;
 	struct mlx5_eqe *eqe;
 	int num_eqes = 0;
-	u32 cqn = -1;
 
 	while ((eqe = next_eqe_sw(eq))) {
 		struct mlx5_core_cq *cq;
+		u32 cqn;
 
 		/* Make sure we read EQ entry contents after we've
 		 * checked the ownership bit.
 		 */
 		dma_rmb();
@@ -142,13 +142,10 @@ static int mlx5_eq_comp_int(struct notifier_block *nb,
 			break;
 	}
 
 	eq_update_ci(eq, 1);
 
-	if (cqn != -1)
-		tasklet_schedule(&eq_comp->tasklet_ctx.task);
-
 	return 0;
 }
 
 /* Some architectures don't latch interrupts when they are disabled, so using
  * mlx5_eq_poll_irq_disabled could end up losing interrupts while trying to
-- 
2.45.2


