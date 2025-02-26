Return-Path: <linux-kernel+bounces-534698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 363C2A46A09
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2172B7A246C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7CD239581;
	Wed, 26 Feb 2025 18:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TR2dhLX8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7EC23959A
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740595581; cv=none; b=caJWZARpF24MWIwhbaHTlX/TLnPsH+amc44fntfSv5y1Hoqmu0cpyfJYH61NVPMTNs7SrxTxb3vg70JSi8P6XGWIv8uagTTPxq/F/DXVp+lgSaJztKkTjR9XCmsWwMGs7tC86ITUR/N2Ev1xOMArcT4X93CqzK1QiQpajmkRDS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740595581; c=relaxed/simple;
	bh=KgJVfB3Qy7a1wCHTTv+5L+khTJcVq387laAYSWSU2L8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uf+AibaxmyAc5aJmuuZumRpPihhjUtv7EtmybYvUxvn6Bm4lmWdiZK5Mwv/2kBH55eHFjofxVgpOZzncEUnBGInN61vWj4lLScPVr6C8GNzF4KGhkTnivf3pbtmSQdDs2uT3y76cQG4UVBf6wQ+1JSMgJhh0VR2FV5reQklDeAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TR2dhLX8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D98CC4CEE8;
	Wed, 26 Feb 2025 18:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740595579;
	bh=KgJVfB3Qy7a1wCHTTv+5L+khTJcVq387laAYSWSU2L8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TR2dhLX8wKrboAjqPtRK1DUYiBpB8ZrwYVzlPSrNx26XOY0oj19EQrHrsYryWIVwY
	 2a0l+G1nnbFZyyB4VGEX1EXGunv2ishDz5J/X4YRHKDI7WeeDvXkdo1GrvtNx2Tfrh
	 Ow5jjjkYY38i57h/IvbeCRBVBfMxjt7OEQPZLx1OlP07F2wLN7ONj/WjoMdkUT1WBV
	 dMDuozEzNtYELhoVscT8TKNYKt8svxizS/OiaklcUsdCUw3lpEFIE5X6bmDTPxPW6r
	 hXbva8FgySMXlrR/HGsW1v3yrSTlTyUy1t/IAGvCAxnWHfEtFfJcNrj8c9nidX1114
	 IzAZxv0hz2r9w==
From: Daniel Wagner <wagi@kernel.org>
Date: Wed, 26 Feb 2025 19:46:01 +0100
Subject: [PATCH 09/11] nvmet-fc: free pending reqs on tgtport unregister
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-nvmet-fcloop-v1-9-c0bd83d43e6a@kernel.org>
References: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
In-Reply-To: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

When nvmet_fc_unregister_targetport is called by the LLDD, it's not
possible to communicate with the host, thus all pending request will not
be process. Thus explicitly free them.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fc.c | 39 ++++++++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 391917b4ce0115dbc0ad99d1fb363b1af6ee0685..a5f7cb18ac9f49e41626e1c9a031c3cc830af9ba 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1610,6 +1610,37 @@ nvmet_fc_delete_ctrl(struct nvmet_ctrl *ctrl)
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
@@ -1633,13 +1664,7 @@ nvmet_fc_unregister_targetport(struct nvmet_fc_target_port *target_port)
 
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


