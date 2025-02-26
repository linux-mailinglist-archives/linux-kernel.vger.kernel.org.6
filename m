Return-Path: <linux-kernel+bounces-534700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B0AA46A0C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B59816C46F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDED23771E;
	Wed, 26 Feb 2025 18:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSVuxNPs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCAD2397B4
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740595584; cv=none; b=uPKufKoWTuAUquR/YbKvHpWxQFjIIGB4E/U51vMyEMoGKFruTkkAC2mdGs6dDZTf+ZAfTI28of4oknuRdIqlWz/PXPLdLhOaulXeZcKu2aaEkPTPcfz/XoUyfiBESsbnk2KKAZs9UQaV3V2iOAgI0DjMhSN1JePxRQ5ZAeXB+eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740595584; c=relaxed/simple;
	bh=J6AUMJGnaDgNqGbm3jWxZfLL/F5J/3cqMBGDn8TxEhU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HagxXijL4JYGdy2r1b47Lf3IanJ6jC0xgkQOMC1yGpkwEJueKlu094vBwbmI28og0OFWSjq+ztqnQadNMFl2KS+pRLtPtL67kPiZfpTIf4Xp987LtFiFBeTjvXCUWD01gP5les+Yd7x5AYTW4EvqgzIKdAFZj06kKiSmyjj2PW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSVuxNPs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F2AC4CEEA;
	Wed, 26 Feb 2025 18:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740595584;
	bh=J6AUMJGnaDgNqGbm3jWxZfLL/F5J/3cqMBGDn8TxEhU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kSVuxNPsr5z8gfv9sJnCSxMOn+PWP4P+YDtvlktP6ScmbMxgDBaNrzz9Q07Pn7ZQE
	 pwUlgw/TVx7Kv5tYf6IGsEpAQaTx9+/BRsbhZA+OcLiiyW1I4TNjMd65o9mqLwcwaE
	 I5eR3wVxFGSrT8BqHtK4KmNmYgFFQlodkWkW/LL6kta96lvFSrgVRKT0AoijUxJTey
	 ofCBjfdtdvvPBS11BETaVNzn/ugQ4Hp8JTFgoYJIIHgCgTkt1pEqHoQZJR0ZArHz4J
	 gkc26nTWMd3gvh7qI9poiRsrE1i6Ij7g1+a1IkmqnfXmvmAJ9MHQCl4HWlJ/0swl7F
	 Soj5jWtWNqWnA==
From: Daniel Wagner <wagi@kernel.org>
Date: Wed, 26 Feb 2025 19:46:03 +0100
Subject: [PATCH 11/11] nvmet-fc: inline nvmet_fc_free_hostport
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-nvmet-fcloop-v1-11-c0bd83d43e6a@kernel.org>
References: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
In-Reply-To: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

No need for this tiny helper with only user, let's inline it.
And since the hostport ref counter needs to stay in sync, it's not
optional anymore to give back the reference.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fc.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index fcf191aa1c6bf73e7fb84213bbb7eb76a486734f..f42f7c674f69b87a43bf06639a8da60d14a48509 100644
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
@@ -1187,7 +1177,7 @@ nvmet_fc_target_assoc_free(struct kref *ref)
 	/* Send Disconnect now that all i/o has completed */
 	nvmet_fc_xmt_disconnect_assoc(assoc);
 
-	nvmet_fc_free_hostport(assoc->hostport);
+	nvmet_fc_hostport_put(assoc->hostport);
 	spin_lock_irqsave(&tgtport->lock, flags);
 	oldls = assoc->rcv_disconn;
 	spin_unlock_irqrestore(&tgtport->lock, flags);

-- 
2.48.1


