Return-Path: <linux-kernel+bounces-555844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B1EA5BD59
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 812F93AAA8A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9AE23817D;
	Tue, 11 Mar 2025 10:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnK+x604"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF6B225A32
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 10:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741687927; cv=none; b=B1af/MHG51ZbTl/56PO50PMu4mkDfeL4DtieyeuWDjrUxVNWRwudUpqvQOGbApC3ln2pf/k/UhepPEnX8gXLvEb/DeDacRWM0kJksUV0PAX9o8O01hw1f+l3K6CycYYXh550EBnRqzBwvhFwrYSIqTpWy94sb86T/engAOs6PoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741687927; c=relaxed/simple;
	bh=RAKG7b+K3W6se3CetZF6A6LvgujI6q/m6r/L62MSc70=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CLXULtnFQW3GCgErhKchMZZ5CRV2h58B2fO4ux7DgAlrfLbmKzhbd2+brI5Q25gu7LfdGk3463TdFfZpGn8n7/L1DZjlQX/UxcGOBXiPrHwfG7grO7C3bRb5F7MPiVHdVZea9ql0q06/Edl51o6Y6Obve/Go0DnvZfY2m92F3iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jnK+x604; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B73CC4CEEB;
	Tue, 11 Mar 2025 10:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741687926;
	bh=RAKG7b+K3W6se3CetZF6A6LvgujI6q/m6r/L62MSc70=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jnK+x604C7gLT1bWGwOP2HzqajJydDHq9NDFDQ0rPy36t6TspmFAIuaGLNOBl4E+/
	 vGHYmQgbC3EJp6HrJyBesq4ea+sjoreRNqyUCdw4UkW09Dfv7VP3VferR7kkYckcuS
	 PLx7ryFtFMVSWmLhRhrcuVAW8/36Hu8Tt84N055ZEKe70ewHnWXlKX/ovbbUoVMMk3
	 iAzQKARk+WHvEV1Rvi0oSFq25X55WIu0oCtj8XxQ+UX5fRSYLF8JpIi4zPYN/PCond
	 1H7FoKe+DoME7nu5BA7rDIfPoTtlMFLOQs0e/cI1/gTjT0nd/gyKsn9leDVesHc6By
	 1lFp82VIxT/lQ==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 11 Mar 2025 11:11:36 +0100
Subject: [PATCH v2 10/15] nvmet-fc: take tgtport reference only once
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-nvmet-fcloop-v2-10-fc40cb64edea@kernel.org>
References: <20250311-nvmet-fcloop-v2-0-fc40cb64edea@kernel.org>
In-Reply-To: <20250311-nvmet-fcloop-v2-0-fc40cb64edea@kernel.org>
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
index b807b4c05cac7fe4764df3df76f8fa50f4bab6ba..810aff9901da725086f8bd76f3320fb31696468f 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1042,33 +1042,26 @@ nvmet_fc_alloc_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
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
@@ -1077,6 +1070,7 @@ nvmet_fc_alloc_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 		kfree(newhost);
 		newhost = match;
 	} else {
+		nvmet_fc_tgtport_get(tgtport);
 		newhost->tgtport = tgtport;
 		newhost->hosthandle = hosthandle;
 		INIT_LIST_HEAD(&newhost->host_list);

-- 
2.48.1


