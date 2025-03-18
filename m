Return-Path: <linux-kernel+bounces-565971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C78A671AA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7353619A3F4E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA00F20C477;
	Tue, 18 Mar 2025 10:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZ3Dlp3y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3356C2080D6
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 10:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742294440; cv=none; b=hnWGJDJ/89//ZAWX9TIUJ1inulzbmbo95VxvivTZw2l7AHKkODh3klnO3kvt/MZoWP5aPzOWVE57ihyoPFQh5XLLvLGcob6RmBpw+1nlORgjVVJd4lqB3yg5Q9ET63RdLVhSr4An+vg3j53wq3sAooEv9LpVGPik1GSFcecb4Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742294440; c=relaxed/simple;
	bh=ARme07aS1QExi5VZijNLmZGcs97PRzj21jmlFT3I4Gk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zao3o03jJ1gGQqGlJ8cbUpP9gxAH0BLhI6XublvvwmynKH1NfZPJAsnZW55Ids40/6t1uaQGkOvXKakOzYeIBNBVrs5fe7dyVqjjfrctUElvmlz7k1v25M/jMO9ceJRDkNkmxA0yxCgTKGuCLXxD8do9wsp+fabZfPjC2pTF3UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZ3Dlp3y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8CBDC4CEEE;
	Tue, 18 Mar 2025 10:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742294440;
	bh=ARme07aS1QExi5VZijNLmZGcs97PRzj21jmlFT3I4Gk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RZ3Dlp3yBCgnt0ZQa1RFg5B32HlT4gIhYK521+ye+IQgJldWZ1Zj8V2XTRIaU6vnD
	 nCbvkLXyrqlouBzTFTJKvIH+ebp8j8XO2zADjIz3tMTzb+tviAbBL/3btFW5CaYBLW
	 rMTcYO8jqYh5xv+xnlV4YZOlRvjnUi1wFA6Ooh0q45b7DaffOPsRTg2p4VKTK2bVMW
	 WnvtH9dT38t/3p6nn8moasbFzL38ZnU+cv/ohNjVwl08lXhD8u74VfN4ci0vHvapOx
	 ypSc7pABt0/zCYei/vJiL8ZCNDlWtdsVJaoeZQ35gG8km7AKSA/ry+fj+ciWk4wWNb
	 ifLwEQLaUbQxg==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 18 Mar 2025 11:40:09 +0100
Subject: [PATCH v3 15/18] nvmet-fc: free pending reqs on tgtport unregister
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-nvmet-fcloop-v3-15-05fec0fc02f6@kernel.org>
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
In-Reply-To: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

When nvmet_fc_unregister_targetport is called by the LLDD, it's not
possible to communicate with the host, thus all pending request will not
be process. Thus explicitly free them.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>

nvmet-fc: merge with f200af94ac9d ("nvmet-fc: free pending reqs on tgtport unregister")
---
 drivers/nvme/target/fc.c | 46 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 39 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index b2f5934209f9952679dc1235fb7c927818930688..d10ddcb57c1b09d871152f0d9a48f93ec6dc8685 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1591,6 +1591,44 @@ nvmet_fc_delete_ctrl(struct nvmet_ctrl *ctrl)
 	spin_unlock_irqrestore(&nvmet_fc_tgtlock, flags);
 }
 
+static void
+nvmet_fc_free_pending_reqs(struct nvmet_fc_tgtport *tgtport)
+{
+	struct nvmet_fc_ls_req_op *lsop;
+	struct nvmefc_ls_req *lsreq;
+	struct nvmet_fc_ls_iod *iod;
+	int i;
+
+	iod = tgtport->iod;
+	for (i = 0; i < NVMET_LS_CTX_COUNT; iod++, i++)
+		cancel_work(&iod->work);
+
+	/*
+	 * After this point the connection is lost and thus any pending
+	 * request can't be processed by the normal completion path. This
+	 * is likely a request from nvmet_fc_send_ls_req_async.
+	 */
+	for (;;) {
+		lsop = list_first_entry_or_null(&tgtport->ls_req_list,
+						struct nvmet_fc_ls_req_op,
+						lsreq_list);
+		if (!lsop)
+			break;
+
+		list_del(&lsop->lsreq_list);
+
+		if (!lsop->req_queued)
+			continue;
+
+		lsreq = &lsop->ls_req;
+		fc_dma_unmap_single(tgtport->dev, lsreq->rqstdma,
+				    (lsreq->rqstlen + lsreq->rsplen),
+				    DMA_BIDIRECTIONAL);
+		nvmet_fc_tgtport_put(tgtport);
+		kfree(lsop);
+	}
+}
+
 /**
  * nvmet_fc_unregister_targetport - transport entry point called by an
  *                              LLDD to deregister/remove a previously
@@ -1619,13 +1657,7 @@ nvmet_fc_unregister_targetport(struct nvmet_fc_target_port *target_port)
 
 	flush_workqueue(nvmet_wq);
 
-	/*
-	 * should terminate LS's as well. However, LS's will be generated
-	 * at the tail end of association termination, so they likely don't
-	 * exist yet. And even if they did, it's worthwhile to just let
-	 * them finish and targetport ref counting will clean things up.
-	 */
-
+	nvmet_fc_free_pending_reqs(tgtport);
 	nvmet_fc_tgtport_put(tgtport);
 
 	return 0;

-- 
2.48.1


