Return-Path: <linux-kernel+bounces-565956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B5AA67195
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B700174627
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E417F209F33;
	Tue, 18 Mar 2025 10:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+Wxssv1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504C520896A
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 10:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742294405; cv=none; b=M4qUeDgjvjAluhrYjRhDnF+Cr9jTT2Ru/lYRNgyEQIPsjWyvFyWVjBHJ1OgnYPiXnfJNqJslbdTvwyqoLe8LMcFNAL/TBlvqeRtQ8XPgd2b9ZAe60d24I0uEhYy7osRk6RG0t//KP3mv9BgryABXWSt58hxd8UFM7HvyVloSITU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742294405; c=relaxed/simple;
	bh=MWm8eqM6Uuk9iRoCyRSd03Uok+xmCB8TLkbHS2USEkw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GfIaUQPwydHNugoO1YcfC743tsjwD2IpsSzzurlxxnoCP+gP0la+FhzZBLWCVbgo+V/bsSjw+r9XshnZNEHS4RNzWcRLW31IPLHKQ4rZaaOOLbpgSmZMmRUJbuVXHTEY+fqBbR8L/rykThc4r2w/CyVaTrECo7CPQVBssdCKT/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+Wxssv1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACEC0C4CEDD;
	Tue, 18 Mar 2025 10:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742294405;
	bh=MWm8eqM6Uuk9iRoCyRSd03Uok+xmCB8TLkbHS2USEkw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=T+Wxssv1ktILToEPxp0tOGXSSNJ5BxgwAzRuiNw98ibxuMAycNI6FdRmPLWoNVw5Y
	 +zeVd9+Z/dzdWAkU2XfRDbs4KupVE+TGcgMMliWNyS67G9Sl40fhRXkskYNe8Zg+qJ
	 RNju43IlP6EcgB16p8WdMcpBF2xGrhuRGW7U49SUrFINpY+sxQ9asuYcD3XHqtTcf8
	 NO5Pb66yAO2jzrZ2wxHpyKeJ6fXNd1LrRK3swJu/X3yHLt728bv2eA/cJEkkyvJEzd
	 86FgohH+DoSQb5s8Sjd6j2aFQuRVWJEOPsCfMbMXcIGi2TXCo0pXD73FrhTPLQMe7j
	 /GG0hWuYVhRGg==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 18 Mar 2025 11:39:55 +0100
Subject: [PATCH v3 01/18] nvmet-fcloop: remove nport from list on last user
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-nvmet-fcloop-v3-1-05fec0fc02f6@kernel.org>
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
In-Reply-To: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

The nport object has an association with the rport and lport object,
that means we can only remove an nport object from the global nport_list
after the last user of an rport or lport is gone.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fcloop.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 3390215b1c1f040001985a0d33741e57f1f80cb3..09546c3161fd9828234e58641de3e53519e27824 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -1004,6 +1004,11 @@ fcloop_nport_free(struct kref *ref)
 {
 	struct fcloop_nport *nport =
 		container_of(ref, struct fcloop_nport, ref);
+	unsigned long flags;
+
+	spin_lock_irqsave(&fcloop_lock, flags);
+	list_del(&nport->nport_list);
+	spin_unlock_irqrestore(&fcloop_lock, flags);
 
 	kfree(nport);
 }
@@ -1362,8 +1367,6 @@ __unlink_remote_port(struct fcloop_nport *nport)
 		nport->tport->remoteport = NULL;
 	nport->rport = NULL;
 
-	list_del(&nport->nport_list);
-
 	return rport;
 }
 

-- 
2.48.1


