Return-Path: <linux-kernel+bounces-565970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1ED4A671A9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 899463BDF19
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE9D20C027;
	Tue, 18 Mar 2025 10:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MK4R0uxt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3909620B817
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 10:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742294438; cv=none; b=KLZW7HnRzw10RSp3bczy/1K5PWanRp2p16MFVOanav8CPSVPS3DmJgnfv6z9CBVo4HZWl+sk+NWKyuKuux2WFCML65UztPLWi/S0X5ZjepW+H/4V8DUd3avM0OHolG9w4ciddWo9wCYSfuhyJEmrY1sNumFDzSUxesfA/9Lj2SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742294438; c=relaxed/simple;
	bh=4nbEl4sZ5VwAwk80/F9WKLpZmL99SeHa3v/TXRfobLQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aoHgNGKS22fK48f4n1aY0QTf6cacSsBQxNSyzoQHIogTzRWS0iOEUsq/Z6+YWsNkuW6hJxfNlGhlslPhbvgXBSUr4+XnabBxrCD7TUxDGRXJUm+na/H/g7mt1z50nhaZUSFRxNl/3GjyUiPCBYc63z1RZ3mHANFll0i+8lbp7f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MK4R0uxt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F51C4CEE3;
	Tue, 18 Mar 2025 10:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742294437;
	bh=4nbEl4sZ5VwAwk80/F9WKLpZmL99SeHa3v/TXRfobLQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MK4R0uxtKc2gU7pAryVQtYYERXpPBPW/8V+tFKdV62sYntJL9Z22VGO3z/VAxMxK8
	 Y1mDCG0/ezeMvpvp8vqg0jBeJWiH8voOHIq5QqcS7aeEqFCqTnBaKaF7eHpJ7/EOYC
	 THlqOxAVOc3C4a/R7EEPAnE5KXppmiJChHAokx5UpEcrl58oXTIOVPwPKYGOpE4QIQ
	 lxpUslBXR2m67DwklLaLA+tNAwBQe0D/EVi2PvTeNQ/+5hhX2LjFtNdsObsBkBoji6
	 FMcvStZT0br0bIDqhjAzpsZAWhYBF5LMxEhOsC+r7X6Xq/Fy3EQaqMGNX5qKHSrqmH
	 AbyNpXpvU60WA==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 18 Mar 2025 11:40:08 +0100
Subject: [PATCH v3 14/18] nvmet-fc: take tgtport reference only once
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-nvmet-fcloop-v3-14-05fec0fc02f6@kernel.org>
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
In-Reply-To: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

The reference counting code can be simplified. Instead taking a tgtport
refrerence at the beginning of nvmet_fc_alloc_hostport and put it back
if not a new hostport object is allocated, only take it when a new
hostport object is allocated.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fc.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 8b14947906948c8b4914932837b4ec90921b419d..b2f5934209f9952679dc1235fb7c927818930688 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1030,33 +1030,26 @@ nvmet_fc_alloc_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 	struct nvmet_fc_hostport *newhost, *match = NULL;
 	unsigned long flags;
 
+	/*
+	 * A ref on tgtport is being held while executing this function,
+	 * thus there is no need to take first one and give it back on
+	 * exit.
+	 */
+
 	/* if LLDD not implemented, leave as NULL */
 	if (!hosthandle)
 		return NULL;
 
-	/*
-	 * take reference for what will be the newly allocated hostport if
-	 * we end up using a new allocation
-	 */
-	if (!nvmet_fc_tgtport_get(tgtport))
-		return ERR_PTR(-EINVAL);
-
 	spin_lock_irqsave(&tgtport->lock, flags);
 	match = nvmet_fc_match_hostport(tgtport, hosthandle);
 	spin_unlock_irqrestore(&tgtport->lock, flags);
 
-	if (match) {
-		/* no new allocation - release reference */
-		nvmet_fc_tgtport_put(tgtport);
+	if (match)
 		return match;
-	}
 
 	newhost = kzalloc(sizeof(*newhost), GFP_KERNEL);
-	if (!newhost) {
-		/* no new allocation - release reference */
-		nvmet_fc_tgtport_put(tgtport);
+	if (!newhost)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	spin_lock_irqsave(&tgtport->lock, flags);
 	match = nvmet_fc_match_hostport(tgtport, hosthandle);
@@ -1065,6 +1058,7 @@ nvmet_fc_alloc_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 		kfree(newhost);
 		newhost = match;
 	} else {
+		nvmet_fc_tgtport_get(tgtport);
 		newhost->tgtport = tgtport;
 		newhost->hosthandle = hosthandle;
 		INIT_LIST_HEAD(&newhost->host_list);

-- 
2.48.1


