Return-Path: <linux-kernel+bounces-555845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69330A5BD5C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E9463AABAC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAF4225A32;
	Tue, 11 Mar 2025 10:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VsGfpi1F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D1B238D2F
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 10:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741687929; cv=none; b=QCnsHTHAHLRoR2dxf6mshzlmcvjiB05rtwyTrf3ZyPEo3hI2YbQIyrREMYMPNniOzHLlf4VcKL7xzqpXX+a43S9x0gR80Yi+n7nERN65Wz3HKSrO8FmuSZOzZSUN+H9kL75gw0NViVvKjreuMFp7KPGYKED0L1D2gijvuvrEHaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741687929; c=relaxed/simple;
	bh=vL5pMsi2oen3+xGkZg2MC9buTgMFVXZ352mKlFaYiM8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L/FxqsimqtsPY2TqnC/X69T+B2lFUHUXmGC7bOkaOcTgNoYJpWfMXwjfHSXDXsziErBlqnI7pw57rIy2B9IlvVuuoLZwmgvPl+dnhcP87lfVmrL9aNqmfb7wV9tEpyBEltveDeOo4QwI2mK5nwLBHg5cUzSqPGXbweVCpcC06lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VsGfpi1F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C10C0C4CEEE;
	Tue, 11 Mar 2025 10:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741687929;
	bh=vL5pMsi2oen3+xGkZg2MC9buTgMFVXZ352mKlFaYiM8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VsGfpi1FGqamoKl9avuKGZcoYK4o36a+BDQS6N3QhUSbKbMDazVnSdDsJEWxHEnDN
	 C1wd2hieRh154W2XnBy/f/DR3HqsUCfbQysJKhQmnsJ5cKsJKc7IRr7V1jl1mZDpQJ
	 cw2I/swiOVoi/k2M+HCB4D7wnQXEtvEh7RPdUQVNT0HZif1acR1dcmrL8jFHJKjKur
	 NbLDFgSftxvQ2H1MN/sbRoPdrwnN9UQro0mG36S9ziQMBa7NvQhW04If4KOIlUthB4
	 QiFQRtIMBNu9jZrZ2q0K+zGiWl/tQVvbdm80J0rHKpGkoJErxPWzB+byhIVGxMHrgc
	 J8vEE2dnraKkw==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 11 Mar 2025 11:11:37 +0100
Subject: [PATCH v2 11/15] nvmet-fc: free pending reqs on tgtport unregister
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-nvmet-fcloop-v2-11-fc40cb64edea@kernel.org>
References: <20250311-nvmet-fcloop-v2-0-fc40cb64edea@kernel.org>
In-Reply-To: <20250311-nvmet-fcloop-v2-0-fc40cb64edea@kernel.org>
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
---
 drivers/nvme/target/fc.c | 39 ++++++++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 810aff9901da725086f8bd76f3320fb31696468f..c579810f0225eedaadf84eb24e1d890629327623 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1616,6 +1616,37 @@ nvmet_fc_delete_ctrl(struct nvmet_ctrl *ctrl)
 	spin_unlock_irqrestore(&nvmet_fc_tgtlock, flags);
 }
 
+static void
+nvmet_fc_free_pending_reqs(struct nvmet_fc_tgtport *tgtport)
+{
+	struct nvmet_fc_ls_req_op *lsop;
+	struct nvmefc_ls_req *lsreq;
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
+	}
+}
+
 /**
  * nvmet_fc_unregister_targetport - transport entry point called by an
  *                              LLDD to deregister/remove a previously
@@ -1639,13 +1670,7 @@ nvmet_fc_unregister_targetport(struct nvmet_fc_target_port *target_port)
 
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


