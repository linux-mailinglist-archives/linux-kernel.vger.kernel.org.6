Return-Path: <linux-kernel+bounces-390935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A4C9B803C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 17:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 324DC282E24
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6D21BD501;
	Thu, 31 Oct 2024 16:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="dcZVxfsb"
Received: from mail-il1-f228.google.com (mail-il1-f228.google.com [209.85.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E841BCA01
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 16:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730392531; cv=none; b=FXPWyn/n8IN9J6eXWYckUnoF6/H8PqN7DX8VosOnIY7Rpc9U2rvmtvNIm8lb132XiscVgqam7JLIZTjbJbvscgLSr4gp7fxARz8f1VyfIlUEcaQHeiT+qw7y2BlkT42G8EMhXJDtma1izC+br5xgXbrYRLYkvfmIYJSBC6bzcgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730392531; c=relaxed/simple;
	bh=zzXkOlh5hiXCUUbO0nb3qEfXdj5SDjtx+GReFyrR2uY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rdXfG7YJW3Ey5F/DXWbbPP3ovcp9ZxDeVWTw+o9vXqXGgMoP4VRAhgPxTc4j+p9V7mVBuz1WTeRu1hHNSWyDK0geGuYRd1oAxmmr2TLBIVDH478twFqlgEPNpIeiv5Co0CuBkj90lU4TdclJwz6tYw2V6gWRzhMx92D1/QUpvM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=dcZVxfsb; arc=none smtp.client-ip=209.85.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-il1-f228.google.com with SMTP id e9e14a558f8ab-3a4cd2780d8so584735ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 09:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1730392528; x=1730997328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=udAzS3synZF4yyevrFcTMKxh/yzcEiLj9OsuKAlgjEw=;
        b=dcZVxfsbeX7w/erZua2YgpuRLXGBIbHVaPVTSTxsdbYRAyqd9NF4IVCn3uRW+HUuqv
         M+2XrQWtmvrxlE3dZkTniO4NwPTWQHuUreISfuXIu3qgdEfHiL5oZWaKA44Pc0icxCiZ
         xTX9XHvDT5Uz78KYPXKBSKmLIO43PnlS8x4QNftNIC7b2KZGqB95C6UfanF/jPgvuF2n
         x4I8QefRZUcrkj7RoXXlSW93u8G3Nw0AeZbe6uYxFGrRkYa1eswW3mvJ9U1llA1uWIk8
         hkbYaD2+Ti8JpXvNWDtbXR0oKov4kr28D6oGyxXmVBEk9Xqf12sVK0M1QkKcib9FFlnp
         pYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730392528; x=1730997328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=udAzS3synZF4yyevrFcTMKxh/yzcEiLj9OsuKAlgjEw=;
        b=OWOlbSpPYxKon7V5VXqQdyaAsYnRAqpB/8zoFq/Aeo84THY6OEZDshh8WUAgHJ8fRy
         EFgqIGm9C+x3jamvcSvmzS65vZQ/O6mGmf8/fOuF3PwVVDAdx/zqYyqZHnAuBuBX0PMB
         sFEotw/JZGLzKNs7UvNOgmVylFMgE7Cr+5R+OGkte/BJ5M7BpsUfIBqIbIz+F6b8BaXZ
         waDLq55AD9cvnxSpphdXoq+/FhxPAOf2s33GVKBEnkEaF0koZRacZxLl14aMr/DvN0TU
         MjK0bYPj01RfUGvwuVYTEImYhMBHGWCoPZcBNxm7hKu+9ISjCSZnAdulhA2k34rduC9N
         D3Ow==
X-Forwarded-Encrypted: i=1; AJvYcCWybVENoRrHJnBF8+Sv3GvSZKLNeajXkznNWjmPgxxUOoj70Ji+J4z5mfug3yr3oDDSu7OK0CN93uvbGaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSq63S2LZEAtEeeil+wKniaQh2XPXb8ektJyygL4clIxb42+Jt
	RhnegeXvYX8vpqBBqNDaslgND9S6M6brErkpfAueMvxKKnYzFcMZH1a2ljkebHvLGctTjwQL6NR
	RnfxKdovH45Ob34DRwtqxbkncl+S64huB
X-Google-Smtp-Source: AGHT+IEYmpCcSU6QWW+t6z0zTGotJqUuLejQfvFP4zbbC+HVoj6SgAYoVUSoRJHnl37w89QnTTjsluh+rPSv
X-Received: by 2002:a92:c54e:0:b0:3a3:b4ec:b409 with SMTP id e9e14a558f8ab-3a4ed2ee8c1mr53844515ab.3.1730392528000;
        Thu, 31 Oct 2024 09:35:28 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-4de0496ef08sm57822173.53.2024.10.31.09.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 09:35:27 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 068F7340590;
	Thu, 31 Oct 2024 10:35:27 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id EF9CBE484BE; Thu, 31 Oct 2024 10:34:56 -0600 (MDT)
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
Subject: [PATCH net-next v3] mlx5/core: Schedule EQ comp tasklet only if necessary
Date: Thu, 31 Oct 2024 10:34:25 -0600
Message-ID: <20241031163436.3732948-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <CY8PR12MB7195C97EB164CD3A0E9A99F9DC552@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <CY8PR12MB7195C97EB164CD3A0E9A99F9DC552@CY8PR12MB7195.namprd12.prod.outlook.com>
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
v3: revise commit message
v2: reorder variable declarations, describe CPU profile results

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


