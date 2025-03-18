Return-Path: <linux-kernel+bounces-565957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BADAA67198
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91A0F3BD4A5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E16C209F41;
	Tue, 18 Mar 2025 10:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZtXEn89D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5BC209F4A
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 10:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742294407; cv=none; b=nRDC/APDD1UUE5ORMQ2qqGAINZHZf94359tl3Wr0QVx/pNnSm93jDHDr0Fuz3oNcPbR9bnfJ/yBkV6PciHcBc4JbIQctWJleYvOh7QW9bYxj0a75Gy5M+Ef6Lnih1bCCbPHQeaj3sT/isyU4OwVng638iBKD+XQvW+oa+ObxoNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742294407; c=relaxed/simple;
	bh=uYbbJ9Lv9B3WY9bnHVcEuJUkAEU2zR7VmzonuvW3zrI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=okVeqfvScz9tUudiiHgemI8liVYzJJ4npPnOm5roSxCQ4bE9sUrB7RUG0OMQ3AP5ZWX5m5PogtPI0JG4v3cC5MUB6p51oonopIS25P9jJA9ylewEhYc8aR0iOhiqdrzFToqwqyAezbLZHCm1kVIsn1qw6J2jWxTCZ5jE2xQeolQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZtXEn89D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611C0C4CEE3;
	Tue, 18 Mar 2025 10:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742294407;
	bh=uYbbJ9Lv9B3WY9bnHVcEuJUkAEU2zR7VmzonuvW3zrI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZtXEn89DkL7cjlYUGmmA9hqR/oWTB7wDcEXCOH7GG6L3tu9JMgKAHYYFogak98jvi
	 Sq9b1ZUzUSFPvoOibUcrG3YQd8KpUDK8Ocx1ETIJPWbxRtmXn6ZLI/2bp3HcyezFhD
	 Vbjj/MqkYamStI/qa3B6uehOEzpx6vz+kluMyD9CUgEvZwfUCZ25f3ZUZnAzKKXRlo
	 gQJPg+Yi1kWyW8m9gphxBKABOLbmTUrEAAqGsrEXRIhTtBsNazPeB4v5cAGSbO55HC
	 JZcOyOKP1GAGEu2gi3AA4XK5A1LfefxBKPwEOE+5R8jpmv8k8I+Ol4QnahpcuOor5k
	 VpUMieQrBpTTQ==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 18 Mar 2025 11:39:56 +0100
Subject: [PATCH v3 02/18] nvmet-fcloop: replace kref with refcount
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-nvmet-fcloop-v3-2-05fec0fc02f6@kernel.org>
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
In-Reply-To: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
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
index 09546c3161fd9828234e58641de3e53519e27824..cfce70d1b11ff305b203d716f78fad23f114e9c3 100644
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
@@ -273,7 +273,7 @@ struct fcloop_fcpreq {
 	u32				inistate;
 	bool				active;
 	bool				aborted;
-	struct kref			ref;
+	refcount_t			ref;
 	struct work_struct		fcp_rcv_work;
 	struct work_struct		abort_rcv_work;
 	struct work_struct		tio_done_work;
@@ -533,24 +533,18 @@ fcloop_tgt_discovery_evt(struct nvmet_fc_target_port *tgtport)
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
@@ -747,7 +741,7 @@ fcloop_fcp_req(struct nvme_fc_local_port *localport,
 	INIT_WORK(&tfcp_req->fcp_rcv_work, fcloop_fcp_recv_work);
 	INIT_WORK(&tfcp_req->abort_rcv_work, fcloop_fcp_abort_recv_work);
 	INIT_WORK(&tfcp_req->tio_done_work, fcloop_tgt_fcprqst_done_work);
-	kref_init(&tfcp_req->ref);
+	refcount_set(&tfcp_req->ref, 1);
 
 	queue_work(nvmet_wq, &tfcp_req->fcp_rcv_work);
 
@@ -1000,12 +994,13 @@ fcloop_fcp_abort(struct nvme_fc_local_port *localport,
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
@@ -1013,16 +1008,10 @@ fcloop_nport_free(struct kref *ref)
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
@@ -1253,7 +1242,7 @@ fcloop_alloc_nport(const char *buf, size_t count, bool remoteport)
 		newnport->port_role = opts->roles;
 	if (opts->mask & NVMF_OPT_FCADDR)
 		newnport->port_id = opts->fcaddr;
-	kref_init(&newnport->ref);
+	refcount_set(&newnport->ref, 1);
 
 	spin_lock_irqsave(&fcloop_lock, flags);
 

-- 
2.48.1


