Return-Path: <linux-kernel+bounces-555847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C218A5BD5F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 244B93AB055
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF4623A98C;
	Tue, 11 Mar 2025 10:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YvjEhBek"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861FD239579
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 10:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741687934; cv=none; b=oAeWJsAfeLFP557BYsegLM8nRWtrHYIS9nPvwD/CUcQU/x5w6KbM+yC2tjP3BCTUp7Dg5AbnY0YfvyjU6SAZXE+q/D+KJZx0tskkuZVO7eEDdGBvkRpZYDDKy9LEDVND8APawGn/Q33Vbog/DI9GJi2yCOOvZeOIXMGhA0Obf2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741687934; c=relaxed/simple;
	bh=IeQSZtd0MPY3LXioFxehoJwhXdwFjGUg/LwHWngWZ8s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bRu+LZ/ic8vFNfrRKDp3A9m0uYZfPHT+YXgt35+PejnEQls31rifwMuNL3TPO4EPu6EdDOvLzYQcj08HDcjlAeTxWT73nC6IH375tdE2aekHTJfbkgYJEJI3E22ZirWzGv8SW1eK7qouk5g0pcicnNi/bTFc3VAGPCLXyUMNcAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YvjEhBek; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9124C4CEEE;
	Tue, 11 Mar 2025 10:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741687934;
	bh=IeQSZtd0MPY3LXioFxehoJwhXdwFjGUg/LwHWngWZ8s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YvjEhBeko1ayMoipx+MMOD6l/48tG2RrdoA7v3xFh3KcqG3cI6MhExTbJCQgq+oSA
	 Q/2JzrqzQ/RjkXNIMfxlF/UBycsLvJI7KPpPhDJrXSZ6OThz/qmRmyL0dG84RUnJ1c
	 wA+HEotn1JvJ4u2LIEfsViCvourHOw8F/6R8IGRxgCWAE4iqChQkSJeOm6p3P9zuO1
	 mRZs07jkXILpuo5aycwXRSF16zQJcpVT+yqx9VwXIX6GGNutLtX0SDlvEzp3WYpZbQ
	 OvGrNi1Ba8/Xfk+1vgqGz4T9eEMVfZUfuQ+lVzkaWaFCDhYPloPxSPZdUmYKTRMV5H
	 a8iFJ2fbBZS9g==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 11 Mar 2025 11:11:39 +0100
Subject: [PATCH v2 13/15] nvmet-fc: inline nvmet_fc_free_hostport
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-nvmet-fcloop-v2-13-fc40cb64edea@kernel.org>
References: <20250311-nvmet-fcloop-v2-0-fc40cb64edea@kernel.org>
In-Reply-To: <20250311-nvmet-fcloop-v2-0-fc40cb64edea@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

No need for this tiny helper with only one user, let's inline it.

And since the hostport ref counter needs to stay in sync, it's not
optional anymore to give back the reference.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fc.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 7ff6f065fccb3f772b785e393c122e45d624c802..d8c7efa6b6937aa9f5b99735f6669da973bf9ed3 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1009,16 +1009,6 @@ nvmet_fc_hostport_get(struct nvmet_fc_hostport *hostport)
 	return kref_get_unless_zero(&hostport->ref);
 }
 
-static void
-nvmet_fc_free_hostport(struct nvmet_fc_hostport *hostport)
-{
-	/* if LLDD not implemented, leave as NULL */
-	if (!hostport || !hostport->hosthandle)
-		return;
-
-	nvmet_fc_hostport_put(hostport);
-}
-
 static struct nvmet_fc_hostport *
 nvmet_fc_match_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 {
@@ -1193,7 +1183,7 @@ nvmet_fc_target_assoc_free(struct kref *ref)
 	/* Send Disconnect now that all i/o has completed */
 	nvmet_fc_xmt_disconnect_assoc(assoc);
 
-	nvmet_fc_free_hostport(assoc->hostport);
+	nvmet_fc_hostport_put(assoc->hostport);
 	spin_lock_irqsave(&tgtport->lock, flags);
 	oldls = assoc->rcv_disconn;
 	spin_unlock_irqrestore(&tgtport->lock, flags);
@@ -1460,11 +1450,6 @@ nvmet_fc_free_tgtport(struct kref *ref)
 	struct nvmet_fc_tgtport *tgtport =
 		container_of(ref, struct nvmet_fc_tgtport, ref);
 	struct device *dev = tgtport->dev;
-	unsigned long flags;
-
-	spin_lock_irqsave(&nvmet_fc_tgtlock, flags);
-	list_del(&tgtport->tgt_list);
-	spin_unlock_irqrestore(&nvmet_fc_tgtlock, flags);
 
 	nvmet_fc_free_ls_iodlist(tgtport);
 
@@ -1656,6 +1641,11 @@ int
 nvmet_fc_unregister_targetport(struct nvmet_fc_target_port *target_port)
 {
 	struct nvmet_fc_tgtport *tgtport = targetport_to_tgtport(target_port);
+	unsigned long flags;
+
+	spin_lock_irqsave(&nvmet_fc_tgtlock, flags);
+	list_del(&tgtport->tgt_list);
+	spin_unlock_irqrestore(&nvmet_fc_tgtlock, flags);
 
 	nvmet_fc_portentry_unbind_tgt(tgtport);
 

-- 
2.48.1


