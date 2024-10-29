Return-Path: <linux-kernel+bounces-387498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC9C9B51FB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 19:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EAA728516B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 18:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156B92076B9;
	Tue, 29 Oct 2024 18:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+J1avRw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731CF2076AE
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 18:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730227220; cv=none; b=HgBETEmbLXJeLonC0F0TvODqW/J9SjTQTb8pnEbvY3lPb3nDU1Bo+IURnv3EoL6dMOTljK4t/5B7GXTkztieY+aVZuAbPE7+w4c8UhrqFsf68QRHARmQQygPiHLdCYcGhXwxLTpIpWZI8R62ckAkC7Kj4KVGIZF1saM/sUfnfY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730227220; c=relaxed/simple;
	bh=YipPWOMTdVKjtMIdpDJ7zD4aTB5Vym5i0pgmtjyFGsE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qWrshZ1ia37xpT2S+hSvgA55yey/gupmfSW1b8h5iVjQ4/rTcRxqMLXlkdjL25wi/46iEX61T2njZlVLz9xK3e92cqxKJS//uNlYlIkbRbSHaFvL623c7CPXKtFW2ktdENxAeyts6yyTecoCJTiMq74FAlBOULN04LdAPyR11lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+J1avRw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8715C4CEE4;
	Tue, 29 Oct 2024 18:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730227220;
	bh=YipPWOMTdVKjtMIdpDJ7zD4aTB5Vym5i0pgmtjyFGsE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=M+J1avRwzeSpv63jmRTtzo4bbGYbYTpfRQOQf15yuBhEnpYDLJ6pyzZRgsLh6gBNw
	 e8TXysIPRfcIMtX7U94mGHiVE0eRF7Jb/8TvkGp5KL6BICoGF/XTbKTcCFLrlnYqjb
	 XSusce0LRRSaJwoGdwscfD2P7z0jOsJiSiasRMlfczEuEQozc1UQL+7FRSGS4Pote8
	 1m8UYYCeS79l0jmUL3j0eVuuyfNN/TMnEN/gniMAxfpON9MOJj7+9SjqlBm9bh594c
	 afVfDqW9KIPT/0URXOnDxvukXhB8vat4Kt9919ERvLW45ezoO6/vY72TQ/btxk1mLo
	 wSJbppD4SG6hQ==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 29 Oct 2024 19:40:12 +0100
Subject: [PATCH v2 2/2] nvme: handle connectivity loss in
 nvme_set_queue_count
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-nvme-fc-handle-com-lost-v2-2-5b0d137e2a0a@kernel.org>
References: <20241029-nvme-fc-handle-com-lost-v2-0-5b0d137e2a0a@kernel.org>
In-Reply-To: <20241029-nvme-fc-handle-com-lost-v2-0-5b0d137e2a0a@kernel.org>
To: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@suse.de>, Paul Ely <paul.ely@broadcom.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

nvme_set_queue_count is called when setting up the IO queues. When
updating of the queue number fails, the function will ignore all NVME
errors. The assumption is that the controller is in degraded state, the
admin queue is up and running but not the IO queues.

In this state it's still possible to issues admin commands to the
controller to mitigate the problem, that's whay the controller
is allowed to enter the LIVE state.

Though by filtering out all error, it filters out a connectivity loss
event for fabric controllers:

     1) nvme nvme10: NVME-FC{10}: create association : ...
     2) nvme nvme10: NVME-FC{10}: controller connectivity lost. Awaiting Reconnect
        nvme nvme10: queue_size 128 > ctrl maxcmd 32, reducing to maxcmd
     3) nvme nvme10: Could not set queue count (880)
        nvme nvme10: Failed to configure AEN (cfg 900)
     4) nvme nvme10: NVME-FC{10}: controller connect complete
     5) nvme nvme10: failed nvme_keep_alive_end_io error=4

A new connection attempt is started 1) and while connecting the host
receives a connectivity loss event 2). 3) is the point where the connect
code observes a problem but ignores it and enters LIVE state at 4). The
keep alive command eventually times out 5) but again, this type of error
is ignored.

Note the status in nvme_keep_alive_end_io is EINTR, the real reason got
lost at this point (connectivity loss).

Thus catch the error early where we still have the exact reason why the
nvme_set_features has failed and bail out from there.

Fixes: 9a0be7abb62f ("nvme: refactor set_queue_count")
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/host/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 84cb859a911d09dbe71b2f1ac473ae687c4dc687..cc5ed6daf61f6cbc6fdf7b48687e25225bfd9f17 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1664,7 +1664,12 @@ int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count)
 
 	status = nvme_set_features(ctrl, NVME_FEAT_NUM_QUEUES, q_count, NULL, 0,
 			&result);
-	if (status < 0)
+	/*
+	 * It's either a kernel error or the host observed a connection
+	 * lost. In either case it's not possible communicate with the
+	 * controller and thus enter the error code path.
+	 */
+	if (status < 0 || status == NVME_SC_HOST_PATH_ERROR)
 		return status;
 
 	/*

-- 
2.47.0


