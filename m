Return-Path: <linux-kernel+bounces-555846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D5BA5BD5D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C5963AAE7B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABA5233701;
	Tue, 11 Mar 2025 10:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u5mnjd80"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187EB23315A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 10:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741687932; cv=none; b=SUPdlWwQJvyLpuvRphjrMjc+gT0dRSE3qvSuOQDiTaq7jp068X/Gl5YYfiBV63S4aEuiNx0ct9xySuZ30Og21l9NFzjWQTtS/90ty7fmcn7V1OiyrlczwMXmJ7q7ilurNCwQIcYFqH1ynE0G4liblg64K7xD3ZCPLLYvY4HyOAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741687932; c=relaxed/simple;
	bh=CD731s+uEHZveFfZilmbRuxJuovCqXftk6Ub+7Y6yYM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ajvaKAAC1qsDb8rDPRXzmLI44AKiFIWW/xqqFhVYsz7pJpf/uqvNh46PkG3EH1E8HN46yIq/3gx+FOPi61AgdxaTwTeWR/KSeh0hwO2YMu7AYYvqO7hUdn8LbYqtiYGmDONznM59IzUHRnxEfo5nIT5Nw0f2SE3dbfqUGApNuGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u5mnjd80; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 352E3C4CEEE;
	Tue, 11 Mar 2025 10:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741687931;
	bh=CD731s+uEHZveFfZilmbRuxJuovCqXftk6Ub+7Y6yYM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=u5mnjd80BVVpEvBjzJs3RCYFCAjBomGn7iQOnvdQWPohG1i/swLa5n6Uxg15i5AEJ
	 LXjOGXUzUOos5cZLvkuHkjvKQzJSFuHTCrP+NdKPdKn5tNV16dg1/MSB+6VpDl82vv
	 mwiwHfmZ+sG1RiNnQb31iIdyxhl8tn8m5g8tCXowvkF+nt2EKFyBkp2OSsEsY1RyiM
	 qx3A2QEZ/a3wjsdda4+lx6NGaFCTBfac6jqyP5T0EfkpwtEqv5MMn8CIDqk+yPbwIF
	 YU2/1CFcKKdYx8z/NAeniVpoo3B+SAs0IG8j79vQt9+jwGuVdwHWbMR1TZaUQqbqGB
	 bFwpLLSiDo00g==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 11 Mar 2025 11:11:38 +0100
Subject: [PATCH v2 12/15] nvmet-fc: inline nvmet_fc_delete_assoc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-nvmet-fcloop-v2-12-fc40cb64edea@kernel.org>
References: <20250311-nvmet-fcloop-v2-0-fc40cb64edea@kernel.org>
In-Reply-To: <20250311-nvmet-fcloop-v2-0-fc40cb64edea@kernel.org>
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
index c579810f0225eedaadf84eb24e1d890629327623..7ff6f065fccb3f772b785e393c122e45d624c802 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1083,13 +1083,6 @@ nvmet_fc_alloc_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
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
@@ -1097,7 +1090,8 @@ nvmet_fc_delete_assoc_work(struct work_struct *work)
 		container_of(work, struct nvmet_fc_tgt_assoc, del_work);
 	struct nvmet_fc_tgtport *tgtport = assoc->tgtport;
 
-	nvmet_fc_delete_assoc(assoc);
+	nvmet_fc_delete_target_assoc(assoc);
+	nvmet_fc_tgt_a_put(assoc);
 	nvmet_fc_tgtport_put(tgtport);
 }
 

-- 
2.48.1


