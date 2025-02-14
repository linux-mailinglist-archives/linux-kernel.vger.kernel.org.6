Return-Path: <linux-kernel+bounces-514551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A741EA3585B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C34F188DBB6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 08:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1552248A6;
	Fri, 14 Feb 2025 08:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZO0sCpMz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04FA223339
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 08:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739520141; cv=none; b=Q9b01RkczouaqngFFlsTVIH2otbsNJJNpNih0Du6DIvqgGzOC9rjSnGZ5RB2cDiveen7J7dfX4DoqReuvJi/eHTWZ9WXMZNyiu8styV+tOD2y0wMWGEuwIaMyTm8dhNuJmeq1ScYS8MVW5PlBT5oZ7fFuj0e2zHT/5vrzVy7Rs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739520141; c=relaxed/simple;
	bh=6ot0G2iFVigygGMqCsMTInCfit6lwFharUKHIkt+eaM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZugCxX37gNsrpRlnbgLNCJf0waqzCEAU8mJl57ZKDb0NfhYEil0Dj6MHaERZGff06qKDVwWyvqszG5jvSP3MoP4y9j2+nNX9xBqSNqKPj6wMbEYvHhHbvT3uKpwE7bWmptwUvUpLByY5LXKz+DX+F50F5DnR901PEmLmAXvr9pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZO0sCpMz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72432C4CEE7;
	Fri, 14 Feb 2025 08:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739520140;
	bh=6ot0G2iFVigygGMqCsMTInCfit6lwFharUKHIkt+eaM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZO0sCpMzW5i1JHDcwqkVxEaiefDVopcRgUWrAUzsk3uh/pnhuLLHyO7bQLNtxbqtE
	 /5Tuo+MV2+K1dOnB7IrHX/pO58HnjEJZvPW9ZdS6kTFlnXx4d10WC0W8OifNC115TW
	 PpmREhCUcDMws4SyPE/SrmNmK7FO6ECiqlX5pCC+9J+EjXAoP/8fR34b30RkunThg1
	 pK/H+RVkovqHZ02Fyz/xv3+Ycdmp9QjJqallqHZjrdLKxL+rII+NjHw3QXJHmKFNGg
	 joJvlNOLohYecp/6WX8GJxm5Q97YnFyaMDLgBGIiopJcCiwjwImceUywDfgXflzFkp
	 b1OSSPM/iYqAA==
From: Daniel Wagner <wagi@kernel.org>
Date: Fri, 14 Feb 2025 09:02:04 +0100
Subject: [PATCH 2/2] nvme-fc: rely on state transitions to handle
 connectivity loss
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-nvme-fc-fixes-v1-2-7a05d557d5cc@kernel.org>
References: <20250214-nvme-fc-fixes-v1-0-7a05d557d5cc@kernel.org>
In-Reply-To: <20250214-nvme-fc-fixes-v1-0-7a05d557d5cc@kernel.org>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 James Smart <james.smart@broadcom.com>, Hannes Reinecke <hare@suse.de>, 
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

It's not possible to call nvme_state_ctrl_state with holding a spin
lock, because nvme_state_ctrl_state calls cancel_delayed_work_sync
when fastfail is enabled.

Instead syncing the ASSOC_FLAG and state transitions using a lock, it's
possible to only rely on the state machine transitions. That means
nvme_fc_ctrl_connectivity_loss should unconditionally call
nvme_reset_ctrl which avoids the read race on the ctrl state variable.
Actually, it's not necessary to test in which state the ctrl is, the
reset work will only scheduled when the state machine is in LIVE state.

In nvme_fc_create_association, the LIVE state can only be entered if it
was previously CONNECTING. If this is not possible then the reset
handler got triggered. Thus just error out here.

Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Closes: https://lore.kernel.org/all/denqwui6sl5erqmz2gvrwueyxakl5txzbbiu3fgebryzrfxunm@iwxuthct377m/
Fixes: ee59e3820ca9 ("nvme-fc: do not ignore connectivity loss during connecting")
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/host/fc.c | 67 +++++---------------------------------------------
 1 file changed, 6 insertions(+), 61 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index f4f1866fbd5b8b05730a785c7d256108c9344e62..b9929a5a7f4e3f3a03953379aceb90f0c1a0b561 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -781,61 +781,12 @@ nvme_fc_abort_lsops(struct nvme_fc_rport *rport)
 static void
 nvme_fc_ctrl_connectivity_loss(struct nvme_fc_ctrl *ctrl)
 {
-	enum nvme_ctrl_state state;
-	unsigned long flags;
-
 	dev_info(ctrl->ctrl.device,
 		"NVME-FC{%d}: controller connectivity lost. Awaiting "
 		"Reconnect", ctrl->cnum);
 
-	spin_lock_irqsave(&ctrl->lock, flags);
 	set_bit(ASSOC_FAILED, &ctrl->flags);
-	state = nvme_ctrl_state(&ctrl->ctrl);
-	spin_unlock_irqrestore(&ctrl->lock, flags);
-
-	switch (state) {
-	case NVME_CTRL_NEW:
-	case NVME_CTRL_LIVE:
-		/*
-		 * Schedule a controller reset. The reset will terminate the
-		 * association and schedule the reconnect timer.  Reconnects
-		 * will be attempted until either the ctlr_loss_tmo
-		 * (max_retries * connect_delay) expires or the remoteport's
-		 * dev_loss_tmo expires.
-		 */
-		if (nvme_reset_ctrl(&ctrl->ctrl)) {
-			dev_warn(ctrl->ctrl.device,
-				"NVME-FC{%d}: Couldn't schedule reset.\n",
-				ctrl->cnum);
-			nvme_delete_ctrl(&ctrl->ctrl);
-		}
-		break;
-
-	case NVME_CTRL_CONNECTING:
-		/*
-		 * The association has already been terminated and the
-		 * controller is attempting reconnects.  No need to do anything
-		 * futher.  Reconnects will be attempted until either the
-		 * ctlr_loss_tmo (max_retries * connect_delay) expires or the
-		 * remoteport's dev_loss_tmo expires.
-		 */
-		break;
-
-	case NVME_CTRL_RESETTING:
-		/*
-		 * Controller is already in the process of terminating the
-		 * association.  No need to do anything further. The reconnect
-		 * step will kick in naturally after the association is
-		 * terminated.
-		 */
-		break;
-
-	case NVME_CTRL_DELETING:
-	case NVME_CTRL_DELETING_NOIO:
-	default:
-		/* no action to take - let it delete */
-		break;
-	}
+	nvme_reset_ctrl(&ctrl->ctrl);
 }
 
 /**
@@ -3071,7 +3022,6 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 	struct nvmefc_ls_rcv_op *disls = NULL;
 	unsigned long flags;
 	int ret;
-	bool changed;
 
 	++ctrl->ctrl.nr_reconnects;
 
@@ -3177,23 +3127,18 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 		else
 			ret = nvme_fc_recreate_io_queues(ctrl);
 	}
+	if (!ret && test_bit(ASSOC_FAILED, &ctrl->flags))
+		ret = -EIO;
 	if (ret)
 		goto out_term_aen_ops;
 
-	spin_lock_irqsave(&ctrl->lock, flags);
-	if (!test_bit(ASSOC_FAILED, &ctrl->flags))
-		changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
-	else
+	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE)) {
 		ret = -EIO;
-	spin_unlock_irqrestore(&ctrl->lock, flags);
-
-	if (ret)
 		goto out_term_aen_ops;
+	}
 
 	ctrl->ctrl.nr_reconnects = 0;
-
-	if (changed)
-		nvme_start_ctrl(&ctrl->ctrl);
+	nvme_start_ctrl(&ctrl->ctrl);
 
 	return 0;	/* Success */
 

-- 
2.48.1


