Return-Path: <linux-kernel+bounces-565967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AD4A671A4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFFFE19A5628
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9830420B806;
	Tue, 18 Mar 2025 10:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xp3U6+ri"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A5020B7F8
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 10:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742294433; cv=none; b=QuKe6U51RfdV47dr9oqjVG1DY0FmnTyLVzTlWFrqXQbHkFtXMtZ6Z6rKUXrkEEOX3QjQHGBUTB14YzvEoDxbUxHP3MHAsk0Q7Wxlzt0anodycRaLbfrKNuqe1/Tur1IUdhS1o+tncWOmc6g6LrE+1rNd3FoLQtCd7SheiefhVuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742294433; c=relaxed/simple;
	bh=JC937a4WiT0yhSJrrMII/tHbHGidchlnnE5lLue4zIg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A92JoxQeliMsTUY95wZAS7xvS8vGlFV0ybp8NInRizmz6qB/6Rh06Je9vvrd0pDtFc0ixXGqw+5JGQdOwWebz5blclZus9AEI9F2c+BHfazHOMCVavKJG+yWOk0+ZLoABj8Q9KI0pLBl0reGc3eEWX0PuO/K45eAadWguvwe6hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xp3U6+ri; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3427BC4CEDD;
	Tue, 18 Mar 2025 10:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742294432;
	bh=JC937a4WiT0yhSJrrMII/tHbHGidchlnnE5lLue4zIg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Xp3U6+ri9/AyBtjKRjeCoDwn8OB2dqNIF6QZ6v46Y1dU0qna4dGYJ+GsAAI7CRBQq
	 J6C4FW8kc/vbT6AOCXIJLwes7r2YKs5gd+Sr9Cl22k/6HWxZYMiYX98PGA0Ykt2ek6
	 rtA+UrjowDSFqo7MmsdskHEsCxfQpXXukFmYNZJGjyw9iWdJHLvwn8hy75Ynebys4s
	 d6wjiUffsXL9h3aKsv0XIc8RFlEFDSLIdFy5bDeuEFajAhKEZC/sxUI9gqOEpP7TRc
	 WVs0Phb4JoahLHxkThtmkqoIYqDOFsjHGtlBoYFOApnwPInx/RvqSofEkBcCTXfJeE
	 PJ8LYKGfGwbaA==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 18 Mar 2025 11:40:06 +0100
Subject: [PATCH v3 12/18] nvmet-fc: inline nvmet_fc_free_hostport
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-nvmet-fcloop-v3-12-05fec0fc02f6@kernel.org>
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
In-Reply-To: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
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
index 05290506602469fc98d8463d0f1fcb6cf2422fde..20ea3acd7a5ff6f7c27b55b8c00f22b2a0768b7b 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1007,16 +1007,6 @@ nvmet_fc_hostport_get(struct nvmet_fc_hostport *hostport)
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
@@ -1196,7 +1186,7 @@ nvmet_fc_target_assoc_free(struct kref *ref)
 	/* Send Disconnect now that all i/o has completed */
 	nvmet_fc_xmt_disconnect_assoc(assoc);
 
-	nvmet_fc_free_hostport(assoc->hostport);
+	nvmet_fc_hostport_put(assoc->hostport);
 	spin_lock_irqsave(&tgtport->lock, flags);
 	oldls = assoc->rcv_disconn;
 	spin_unlock_irqrestore(&tgtport->lock, flags);
@@ -1459,11 +1449,6 @@ nvmet_fc_free_tgtport(struct kref *ref)
 	struct nvmet_fc_tgtport *tgtport =
 		container_of(ref, struct nvmet_fc_tgtport, ref);
 	struct device *dev = tgtport->dev;
-	unsigned long flags;
-
-	spin_lock_irqsave(&nvmet_fc_tgtlock, flags);
-	list_del(&tgtport->tgt_list);
-	spin_unlock_irqrestore(&nvmet_fc_tgtlock, flags);
 
 	nvmet_fc_free_ls_iodlist(tgtport);
 
@@ -1624,6 +1609,11 @@ int
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


