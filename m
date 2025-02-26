Return-Path: <linux-kernel+bounces-534697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B0CA46A0A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 860A03A7327
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA792238D50;
	Wed, 26 Feb 2025 18:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRxP5h0k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57687238D2E
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740595577; cv=none; b=W8/e/vSmqIOBT9VstLGfkNN9qO0aP4IjG6nh+tOq4NeLBU55Rs4vAmDJJkbRgkWRHDR6mPbgyjjEcopizbKutqvXoOO7/BvV73rU5dTcdtGNI5ujIfpQiZyuv6/FnTCHoQ+8eUl39iXXWvwBUPxagLpEIvrxWEJremuF66mx1pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740595577; c=relaxed/simple;
	bh=LWNcOUyHSpm76/r8wsTzzymlSz71tkb01XzMtOR6qcc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a9Avgrplw+RyhO10q92wJbbRXdiIV3DT4mPmGP1mt/9/lvJZumB1YWK7vB1RzwLxFVXhonwWCcrc2mUr7dolCYP8C1uzeaKhfVGVWZ4QJ6p6krYGht51F/oMuNBGqOqkdBwF3Fad3JN9S5gyQgCMnBHn20p70DT8XKUZrZ7v218=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRxP5h0k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1AD9C4CEEC;
	Wed, 26 Feb 2025 18:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740595577;
	bh=LWNcOUyHSpm76/r8wsTzzymlSz71tkb01XzMtOR6qcc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WRxP5h0kukCPaOyW+ojFaAMhTV7G6BMdg1nMeYkDaXUszhMdm9K2XPTZNtLRe5s0J
	 j6Ty7zKCZ2XJ0FX931zzsUBuwBLgwZeHkgFPlvqpopcdsQFLdfmDQQR9856n7nCSsb
	 xBzDcZbp6Jt5ZpoZIxCwR1ZcmMyhrUvVe2D6wHPdlAAXXplcsOXsGhI489VEEYxbhz
	 jJNxBZAL7CroR8cIbwFlNg7xs9Ws/NrH3XoVTKfiZSGZLCPlAarc9Z/CCfw1cS8nS9
	 joAx4V5ZKmf4kNxKoQo1fkEuXUHDEBfpP0D+jHrdL7iw35yvrGLPV85IDzi4EO7Snv
	 AUpqGCePvBtBQ==
From: Daniel Wagner <wagi@kernel.org>
Date: Wed, 26 Feb 2025 19:46:00 +0100
Subject: [PATCH 08/11] nvmet-fc: take tgtport reference only once
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-nvmet-fcloop-v1-8-c0bd83d43e6a@kernel.org>
References: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
In-Reply-To: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
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
 drivers/nvme/target/fc.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index b807b4c05cac7fe4764df3df76f8fa50f4bab6ba..391917b4ce0115dbc0ad99d1fb363b1af6ee0685 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1046,29 +1046,16 @@ nvmet_fc_alloc_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
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
@@ -1077,6 +1064,7 @@ nvmet_fc_alloc_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 		kfree(newhost);
 		newhost = match;
 	} else {
+		nvmet_fc_tgtport_get(tgtport);
 		newhost->tgtport = tgtport;
 		newhost->hosthandle = hosthandle;
 		INIT_LIST_HEAD(&newhost->host_list);

-- 
2.48.1


