Return-Path: <linux-kernel+bounces-565965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB470A671A2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBE1719A32BE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB0420B1EA;
	Tue, 18 Mar 2025 10:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXMbk/T+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9C120B203
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 10:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742294428; cv=none; b=uFZiEKsKjXt/jq5UqwB/YiH7csQr3NwyhU9K7hkZJMXJU1uHVNlAihFX7GeoizbfVq+7oZlzaO9xNQaq895bOVoymSOIlU2Awru7XbgbgY4f+FpIjMPv18h7ymZ1sGjZKUhftTpOx9MtDTJ2UdaatSp3VGpnbK1vzFM45ScyURk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742294428; c=relaxed/simple;
	bh=VkLrqF4T6wewDueSatUmlwjgltogJR25syVwXMTNSQs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=By2cJULZLutGoKAJKAceinxRwDPVcyId8L+3A1wufXnjzt6rwKGXb3Hp/tYBsloOVDIMCpM0sQl2ADtsA2AdAz1WyY6W/RYVNNoQimp9ZMvFHy0tgWBqod0JZTs6dOIxOnbXq8qxu9mZWQW3ip3Wl0BKhWM67tBDH00LkvkzSLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bXMbk/T+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 479FDC4CEDD;
	Tue, 18 Mar 2025 10:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742294427;
	bh=VkLrqF4T6wewDueSatUmlwjgltogJR25syVwXMTNSQs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bXMbk/T+KPVPo5LwxoAyPNuISC6IZjBtKd6KQvNUOoq5SEPQQQwTJBTZxnlON1/Ct
	 9YuQh/GfRrVFaOpkDnBm4+/KojezsJDnPsrqWb/dZizX/SkUn4nKvqkbFLGJgOEmhw
	 VVeOYaVyiVBTCumUD6BweKCNhEVOjIjapcdGQQoeTA5PmMKTQlQ17FdXgNTOtDOMWW
	 XuRBNOT1iiTl4Ath1/I6TtSdM6H3WjYAvX7jsuUzpUo+uSlL0/HBJAWC7pmv6V2AJt
	 ARwTfki1D8RxHsywsux6/p6I+oSagxFj04fT0NC9wA0GSfpNS6H0QoQzFFt2crXi2m
	 jpVZfJdmdKVjw==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 18 Mar 2025 11:40:04 +0100
Subject: [PATCH v3 10/18] nvmet-fcloop: allocate/free fcloop_lsreq directly
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-nvmet-fcloop-v3-10-05fec0fc02f6@kernel.org>
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
In-Reply-To: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

fcloop depends on the host or the target to allocate the fcloop_lsreq
object. This means that the lifetime of the fcloop_lsreq is tied to
either the host or the target. Consequently, the host or the target must
cooperate during shutdown.

Unfortunately, this approach does not work well when the target forces a
shutdown, as there are dependencies that are difficult to resolve in a
clean way.

The simplest solution is to decouple the lifetime of the fcloop_lsreq
object by managing them directly within fcloop. Since this is not a
performance-critical path and only a small number of LS objects are used
during setup and cleanup, it does not significantly impact performance
to allocate them during normal operation.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fcloop.c | 53 +++++++++++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 06f42da6a0335c53ae319133119d057aab12e07e..537fc6533a4cf5d39855cf850b82af739eeb3056 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -342,6 +342,7 @@ fcloop_rport_lsrqst_work(struct work_struct *work)
 		 * callee may free memory containing tls_req.
 		 * do not reference lsreq after this.
 		 */
+		kfree(tls_req);
 
 		spin_lock(&rport->lock);
 	}
@@ -353,10 +354,13 @@ fcloop_h2t_ls_req(struct nvme_fc_local_port *localport,
 			struct nvme_fc_remote_port *remoteport,
 			struct nvmefc_ls_req *lsreq)
 {
-	struct fcloop_lsreq *tls_req = lsreq->private;
 	struct fcloop_rport *rport = remoteport->private;
+	struct fcloop_lsreq *tls_req;
 	int ret = 0;
 
+	tls_req = kmalloc(sizeof(*tls_req), GFP_KERNEL);
+	if (!tls_req)
+		return -ENOMEM;
 	tls_req->lsreq = lsreq;
 	INIT_LIST_HEAD(&tls_req->ls_list);
 
@@ -387,19 +391,23 @@ fcloop_h2t_xmt_ls_rsp(struct nvmet_fc_target_port *targetport,
 	struct nvme_fc_remote_port *remoteport = tport->remoteport;
 	struct fcloop_rport *rport;
 
+
+	if (!remoteport) {
+		kfree(tls_req);
+		return -ECONNREFUSED;
+	}
+
 	memcpy(lsreq->rspaddr, lsrsp->rspbuf,
 		((lsreq->rsplen < lsrsp->rsplen) ?
 				lsreq->rsplen : lsrsp->rsplen));
 
 	lsrsp->done(lsrsp);
 
-	if (remoteport) {
-		rport = remoteport->private;
-		spin_lock(&rport->lock);
-		list_add_tail(&tls_req->ls_list, &rport->ls_list);
-		spin_unlock(&rport->lock);
-		queue_work(nvmet_wq, &rport->ls_work);
-	}
+	rport = remoteport->private;
+	spin_lock(&rport->lock);
+	list_add_tail(&tls_req->ls_list, &rport->ls_list);
+	spin_unlock(&rport->lock);
+	queue_work(nvmet_wq, &rport->ls_work);
 
 	return 0;
 }
@@ -426,6 +434,7 @@ fcloop_tport_lsrqst_work(struct work_struct *work)
 		 * callee may free memory containing tls_req.
 		 * do not reference lsreq after this.
 		 */
+		kfree(tls_req);
 
 		spin_lock(&tport->lock);
 	}
@@ -436,8 +445,8 @@ static int
 fcloop_t2h_ls_req(struct nvmet_fc_target_port *targetport, void *hosthandle,
 			struct nvmefc_ls_req *lsreq)
 {
-	struct fcloop_lsreq *tls_req = lsreq->private;
 	struct fcloop_tport *tport = targetport->private;
+	struct fcloop_lsreq *tls_req;
 	int ret = 0;
 
 	/*
@@ -445,6 +454,10 @@ fcloop_t2h_ls_req(struct nvmet_fc_target_port *targetport, void *hosthandle,
 	 * hosthandle ignored as fcloop currently is
 	 * 1:1 tgtport vs remoteport
 	 */
+
+	tls_req = kmalloc(sizeof(*tls_req), GFP_KERNEL);
+	if (!tls_req)
+		return -ENOMEM;
 	tls_req->lsreq = lsreq;
 	INIT_LIST_HEAD(&tls_req->ls_list);
 
@@ -461,6 +474,9 @@ fcloop_t2h_ls_req(struct nvmet_fc_target_port *targetport, void *hosthandle,
 	ret = nvme_fc_rcv_ls_req(tport->remoteport, &tls_req->ls_rsp,
 				 lsreq->rqstaddr, lsreq->rqstlen);
 
+	if (ret)
+		kfree(tls_req);
+
 	return ret;
 }
 
@@ -475,18 +491,21 @@ fcloop_t2h_xmt_ls_rsp(struct nvme_fc_local_port *localport,
 	struct nvmet_fc_target_port *targetport = rport->targetport;
 	struct fcloop_tport *tport;
 
+	if (!targetport) {
+		kfree(tls_req);
+		return -ECONNREFUSED;
+	}
+
 	memcpy(lsreq->rspaddr, lsrsp->rspbuf,
 		((lsreq->rsplen < lsrsp->rsplen) ?
 				lsreq->rsplen : lsrsp->rsplen));
 	lsrsp->done(lsrsp);
 
-	if (targetport) {
-		tport = targetport->private;
-		spin_lock(&tport->lock);
-		list_add_tail(&tport->ls_list, &tls_req->ls_list);
-		spin_unlock(&tport->lock);
-		queue_work(nvmet_wq, &tport->ls_work);
-	}
+	tport = targetport->private;
+	spin_lock(&tport->lock);
+	list_add_tail(&tport->ls_list, &tls_req->ls_list);
+	spin_unlock(&tport->lock);
+	queue_work(nvmet_wq, &tport->ls_work);
 
 	return 0;
 }
@@ -1129,7 +1148,6 @@ static struct nvme_fc_port_template fctemplate = {
 	/* sizes of additional private data for data structures */
 	.local_priv_sz		= sizeof(struct fcloop_lport_priv),
 	.remote_priv_sz		= sizeof(struct fcloop_rport),
-	.lsrqst_priv_sz		= sizeof(struct fcloop_lsreq),
 	.fcprqst_priv_sz	= sizeof(struct fcloop_ini_fcpreq),
 };
 
@@ -1152,7 +1170,6 @@ static struct nvmet_fc_target_template tgttemplate = {
 	.target_features	= 0,
 	/* sizes of additional private data for data structures */
 	.target_priv_sz		= sizeof(struct fcloop_tport),
-	.lsrqst_priv_sz		= sizeof(struct fcloop_lsreq),
 };
 
 static ssize_t

-- 
2.48.1


