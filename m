Return-Path: <linux-kernel+bounces-555839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9F2A5BD51
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A738C3AA8C9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A7D231A24;
	Tue, 11 Mar 2025 10:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mimU9cS+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C96236424
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 10:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741687917; cv=none; b=k1XSrSL2/G18jh4u0kODRFTUnXHAT0uQ+VYjKZdlO4aOkNS7Co7IXPoQOEIGVapUXDzN6zwJWOFdymsXSlrTIyE9f9SKb28ps++i1DVSeF6QmMQ+taAaOMKSK/OidpuVnJSIRaQZ+b/IyPUyB8unB5s5/R237jVEQidM0FRENXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741687917; c=relaxed/simple;
	bh=WuWDNDHHzrGny6+h1sSdaUEL5TBI+E+NIa9o1p6FHAA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pZJH+DJCZTHNJc2JYdCRVWZTi9Rx2wVe/1G27mdmWNGccy5HwTD5StVtPuVAKUOE5KK+/AvelHfbNkjS2Cjj5xJmW7WhK4F9TOtRLX+YRBq3gnSSFoze+VK8IlxCHBwVROCpOVgNSOQGN5qeWkHJqY92gXxegMycf03eifcj7Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mimU9cS+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596A7C4CEEB;
	Tue, 11 Mar 2025 10:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741687916;
	bh=WuWDNDHHzrGny6+h1sSdaUEL5TBI+E+NIa9o1p6FHAA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mimU9cS+iBZ6gq1l225MeyExGzBL28c+J84+zWNSAb+vLCeSc3jQGEfQ9PhGXx3vL
	 CkId2rgb3mvQwAKn4KM39jwiU1i2KMk5dm2IUy0C8nDMkHDLlGNBlPpZv4euZ1VuW6
	 CQhsOfalIHm2+DqI6a0OSCY8v1CzfkNzmKDaJqnQfb8Cr7PgQbcOUsI4jP7Wo6sr5X
	 9rHq9oNswUSzX96j98hL6LbK5PsQ7nPtolZpX8E8WBWBTgBbNh/tMuLPgexP21Vzq5
	 OSYhBX7Ese0cDRcMVJogjwhsMDPvKotuPx19uQ4RMNzTuf6ZOam8l1OVqnomThgxlQ
	 BL3pATp303xWg==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 11 Mar 2025 11:11:32 +0100
Subject: [PATCH v2 06/15] nvmet-fcloop: sync targetport removal
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-nvmet-fcloop-v2-6-fc40cb64edea@kernel.org>
References: <20250311-nvmet-fcloop-v2-0-fc40cb64edea@kernel.org>
In-Reply-To: <20250311-nvmet-fcloop-v2-0-fc40cb64edea@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

The nvmet-fc uses references on the targetport to ensure no UAFs
happens. The consequence is that when the targetport is unregistered,
not all resources are freed immediately. Ensure that all activities from
the unregister call have been submitted (deassocication) before
continuing with the shutdown sequence.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fcloop.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index d7c1a0beeccc5778977e4bc5836345e401adaa1c..2ad213c9041ee19893b2f7e8d8c82119ba412a46 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -239,6 +239,7 @@ struct fcloop_nport {
 	struct fcloop_rport *rport;
 	struct fcloop_tport *tport;
 	struct fcloop_lport *lport;
+	struct completion tport_unreg_done;
 	struct list_head nport_list;
 	refcount_t ref;
 	u64 node_name;
@@ -1079,6 +1080,8 @@ fcloop_targetport_delete(struct nvmet_fc_target_port *targetport)
 	tport->nport->tport = NULL;
 	spin_unlock_irqrestore(&fcloop_lock, flags);
 
+	complete(&tport->nport->tport_unreg_done);
+
 	/* nport ref put: tport */
 	fcloop_nport_put(tport->nport);
 }
@@ -1508,7 +1511,17 @@ __unlink_target_port(struct fcloop_nport *nport)
 static int
 __targetport_unreg(struct fcloop_nport *nport, struct fcloop_tport *tport)
 {
-	return nvmet_fc_unregister_targetport(tport->targetport);
+	int ret;
+
+	init_completion(&nport->tport_unreg_done);
+
+	ret = nvmet_fc_unregister_targetport(tport->targetport);
+	if (ret)
+		return ret;
+
+	wait_for_completion(&nport->tport_unreg_done);
+
+	return 0;
 }
 
 static ssize_t

-- 
2.48.1


