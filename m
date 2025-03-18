Return-Path: <linux-kernel+bounces-565966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8714A6719F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 282B03BD44B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589D420B7EB;
	Tue, 18 Mar 2025 10:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nKvRs/2O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DDD20969D
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 10:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742294430; cv=none; b=c0bnLQJqr4HiZKD0TwsU57E2rKGuSe1XJ5WtxN6OZh6u/MFkaiAQsn9e8ndjhMhwPc6L5Bi6tvnfJYWlqmvmWbKEekU1hbGhDk/j8gWiZxgZBrTeA35FoKSskeXsgCV3FKL2KqPqROiRqmwNsq7NazsQ/y+/qTByaPHwNT4plsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742294430; c=relaxed/simple;
	bh=l5T+lHKE6WpThvpfNbpbK6W7jMYdmU6ezmfxslSOgOc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AeFKeTk5GVpkd/6+x/B70Ja1zjS+aIxu0wxqEn8SeBQg7yW2m2LW+pHdM0S+m6Zw2FkCbHMrT95M35yolu6nEYYDAJrJj7UBgiqkY7UnjzzM72YrV9blFnIMVnKOfUgrGdwt3zUr+0Xb/dnq7JrWUDx2o6qyxz0g5aDSiw2YHRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nKvRs/2O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A97C4CEF1;
	Tue, 18 Mar 2025 10:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742294430;
	bh=l5T+lHKE6WpThvpfNbpbK6W7jMYdmU6ezmfxslSOgOc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nKvRs/2O/M2buEmMQtl+vqHVLCEpcjHpvGBN7mGenAWyFhODGcqFbwuCb6ax/pGxM
	 KX3hJjYIhtYT3P7LDxjcvIlW8jD8SoECx8/+0yp5jRrgC8/80yfW7ERCkmjODD/19I
	 zCEbvF5lXoPBuQ5j1AEcYOh3CsYuHXzuRWeXdsOf5TVVXKUfbXr2830pOrdm7wYAmc
	 pTNnqwSuL8SSU8LbPfVV5v7UzAk/RFbi7EPrs1WtluKowEIgbD+PN0M2YZqrST8WxI
	 fbgKaKc2fySQGSySZUPTyHuBWw+qjscRTKSBhUDdXl6qWR9q67SKpJNjZJTC51xX6i
	 duF99/rxgxOCw==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 18 Mar 2025 11:40:05 +0100
Subject: [PATCH v3 11/18] nvmet-fc: inline nvmet_fc_delete_assoc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-nvmet-fcloop-v3-11-05fec0fc02f6@kernel.org>
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
In-Reply-To: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

No need for this tiny helper with only one user, just inline it.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fc.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 8edb2b7f7a70d0a0a366f59f7db7af371e3799a0..05290506602469fc98d8463d0f1fcb6cf2422fde 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1087,13 +1087,6 @@ nvmet_fc_alloc_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 	return newhost;
 }
 
-static void
-nvmet_fc_delete_assoc(struct nvmet_fc_tgt_assoc *assoc)
-{
-	nvmet_fc_delete_target_assoc(assoc);
-	nvmet_fc_tgt_a_put(assoc);
-}
-
 static void
 nvmet_fc_delete_assoc_work(struct work_struct *work)
 {
@@ -1101,7 +1094,8 @@ nvmet_fc_delete_assoc_work(struct work_struct *work)
 		container_of(work, struct nvmet_fc_tgt_assoc, del_work);
 	struct nvmet_fc_tgtport *tgtport = assoc->tgtport;
 
-	nvmet_fc_delete_assoc(assoc);
+	nvmet_fc_delete_target_assoc(assoc);
+	nvmet_fc_tgt_a_put(assoc);
 	nvmet_fc_tgtport_put(tgtport);
 }
 

-- 
2.48.1


