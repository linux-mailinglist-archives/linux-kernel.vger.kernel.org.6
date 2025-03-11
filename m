Return-Path: <linux-kernel+bounces-555835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E245DA5BD4D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B54D3A80D4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB81233153;
	Tue, 11 Mar 2025 10:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1kbDNsl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE0E233150
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 10:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741687907; cv=none; b=JWRl97sb3juHFL+lgDAc7HzIeY8hxuVGAbnW8ZZZ7cnzhX5Os79FR3RNZGFQS+h2j7fng91rrDHJMLhCoLNd5Tkh+Fj/zWpkNpfXICyiEiteneCHgh2rOWsNds5yW3QZBxpMyNSXdg5yOiEeK/ahKHIXuIhf3X+ejkBnR5XagMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741687907; c=relaxed/simple;
	bh=Re6JnAPJGLA4JFG856r1n2YeoKiYwnht9Nqi1eaEqH8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fVQw1oIEX/rweS+ljautEbrWSBdc9CnNqfiUONHuvBTp0ZdlEypzoAshCquTGVymBlIY6+HKqhGtBZ5TKz5OdqbQyJbYHjuplTLRi/KD2cp2SRAqDGjsyNai7OcrjZsZFquW5vVyTfxV4fKb1Pj0sESwThK1CxeCsVJ/hIOaxSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N1kbDNsl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CBE9C4CEEB;
	Tue, 11 Mar 2025 10:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741687906;
	bh=Re6JnAPJGLA4JFG856r1n2YeoKiYwnht9Nqi1eaEqH8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=N1kbDNslx4aTMEsQ+rbRNO6W1ROODIG85ZYCmLbBynyX9gWsFHOe6MdiPi9c0g6JN
	 Qs4uMQjeO2D2hijfZcwfUx5lbNZS9WnllzBCZrYk27FoNrs+err3D0gCkPmAZXtbKu
	 s6E45tbvhmQicCRWFjSKLGOMd11CBvWtBYsYjf8vm7vbU271qYfd3Ep1jd6s05Yd5y
	 Y6/vHQQ2JbO79uwq6DBjLt/K6WQws0HRsthlJNUeaQRgMj4VzVxzq9KEuGJFs3lvai
	 SiZu2U/Ts7bXsSCWDMpVr1UBJYhSZFumtxdXkPa/6YMAO/oGjeoSOghmOz0hRe4C8E
	 S3Np8mqgfjuDw==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 11 Mar 2025 11:11:28 +0100
Subject: [PATCH v2 02/15] nvmet-fcloop: replace kref with refcount
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-nvmet-fcloop-v2-2-fc40cb64edea@kernel.org>
References: <20250311-nvmet-fcloop-v2-0-fc40cb64edea@kernel.org>
In-Reply-To: <20250311-nvmet-fcloop-v2-0-fc40cb64edea@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

The kref wrapper is not really adding any value ontop of refcount. Thus
replace the kref API with the refcount API.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fcloop.c | 37 +++++++++++++------------------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 5493677a948d34391c7c08055dfefd91cc3ff33f..762ba908130b37bbd41f6888c9cb2a56ef3b7afe 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -239,7 +239,7 @@ struct fcloop_nport {
 	struct fcloop_tport *tport;
 	struct fcloop_lport *lport;
 	struct list_head nport_list;
-	struct kref ref;
+	refcount_t ref;
 	u64 node_name;
 	u64 port_name;
 	u32 port_role;
@@ -274,7 +274,7 @@ struct fcloop_fcpreq {
 	u32				inistate;
 	bool				active;
 	bool				aborted;
-	struct kref			ref;
+	refcount_t			ref;
 	struct work_struct		fcp_rcv_work;
 	struct work_struct		abort_rcv_work;
 	struct work_struct		tio_done_work;
@@ -534,24 +534,18 @@ fcloop_tgt_discovery_evt(struct nvmet_fc_target_port *tgtport)
 }
 
 static void
-fcloop_tfcp_req_free(struct kref *ref)
+fcloop_tfcp_req_put(struct fcloop_fcpreq *tfcp_req)
 {
-	struct fcloop_fcpreq *tfcp_req =
-		container_of(ref, struct fcloop_fcpreq, ref);
+	if (!refcount_dec_and_test(&tfcp_req->ref))
+		return;
 
 	kfree(tfcp_req);
 }
 
-static void
-fcloop_tfcp_req_put(struct fcloop_fcpreq *tfcp_req)
-{
-	kref_put(&tfcp_req->ref, fcloop_tfcp_req_free);
-}
-
 static int
 fcloop_tfcp_req_get(struct fcloop_fcpreq *tfcp_req)
 {
-	return kref_get_unless_zero(&tfcp_req->ref);
+	return refcount_inc_not_zero(&tfcp_req->ref);
 }
 
 static void
@@ -748,7 +742,7 @@ fcloop_fcp_req(struct nvme_fc_local_port *localport,
 	INIT_WORK(&tfcp_req->fcp_rcv_work, fcloop_fcp_recv_work);
 	INIT_WORK(&tfcp_req->abort_rcv_work, fcloop_fcp_abort_recv_work);
 	INIT_WORK(&tfcp_req->tio_done_work, fcloop_tgt_fcprqst_done_work);
-	kref_init(&tfcp_req->ref);
+	refcount_set(&tfcp_req->ref, 1);
 
 	queue_work(nvmet_wq, &tfcp_req->fcp_rcv_work);
 
@@ -1001,12 +995,13 @@ fcloop_fcp_abort(struct nvme_fc_local_port *localport,
 }
 
 static void
-fcloop_nport_free(struct kref *ref)
+fcloop_nport_put(struct fcloop_nport *nport)
 {
-	struct fcloop_nport *nport =
-		container_of(ref, struct fcloop_nport, ref);
 	unsigned long flags;
 
+	if (!refcount_dec_and_test(&nport->ref))
+		return;
+
 	spin_lock_irqsave(&fcloop_lock, flags);
 	list_del(&nport->nport_list);
 	spin_unlock_irqrestore(&fcloop_lock, flags);
@@ -1014,16 +1009,10 @@ fcloop_nport_free(struct kref *ref)
 	kfree(nport);
 }
 
-static void
-fcloop_nport_put(struct fcloop_nport *nport)
-{
-	kref_put(&nport->ref, fcloop_nport_free);
-}
-
 static int
 fcloop_nport_get(struct fcloop_nport *nport)
 {
-	return kref_get_unless_zero(&nport->ref);
+	return refcount_inc_not_zero(&nport->ref);
 }
 
 static void
@@ -1254,7 +1243,7 @@ fcloop_alloc_nport(const char *buf, size_t count, bool remoteport)
 		newnport->port_role = opts->roles;
 	if (opts->mask & NVMF_OPT_FCADDR)
 		newnport->port_id = opts->fcaddr;
-	kref_init(&newnport->ref);
+	refcount_set(&newnport->ref, 1);
 
 	spin_lock_irqsave(&fcloop_lock, flags);
 

-- 
2.48.1


