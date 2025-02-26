Return-Path: <linux-kernel+bounces-534696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B87A46A08
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAC227A727D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE2023771C;
	Wed, 26 Feb 2025 18:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JuRWl+/B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D477C237704
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740595574; cv=none; b=dn9NfgFSNUtRilbgXVMyqe+QnlLkkaPjaBypCPTPii09yuygX4x7l7JImlMlZRpr1kvVTwpQoIwlEY7BYrkIgjJgY+N7NAp1Q9YPLobrAqOkow13IFFStYE7fgUPT00nh9CFTd29+NuvLCOrSJoUiHSabCga3ukIbohHZfwcTD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740595574; c=relaxed/simple;
	bh=iDy1ce3F7we4lX8jz/NaLXQ09ocgZ3E0UyfAPaBRnbY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kPCufnh5RGHLcx5OLwKFGwuyA8TuxR2Jt+mwKPHDaRDg0RILJY3PGm8OEkB8FVguE35TaK/VUU4fNhoRrZkRLjMpVk5E76K0xYJNjlBbzBBXVWcKM1uEleLZ2YhhM6t+Pu+y/IN/JTZ1Hzra9sJug/yd+QtVQdN7NlpxEIePkCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JuRWl+/B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E094C4CEEA;
	Wed, 26 Feb 2025 18:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740595574;
	bh=iDy1ce3F7we4lX8jz/NaLXQ09ocgZ3E0UyfAPaBRnbY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JuRWl+/B4WCzstTtkvZLf/I4aJgPAooSP+pIq/dult31l3mOr3LI3736wiOjChTdq
	 JUQk0dJetQe5iz+C8zio3dQ4qJrMnSxj5uhkF4W9RA9jO3jAxgOFzgMO+DXq3+Nqla
	 GoB/iQFHxdqMmw+m7bqCNMGa9b6ZrMe7BVPzkYqekE8NlPVRWEhWAYyQLfaXeVvnB4
	 afL/E2fit8ogJ2Skj0p0JnPGRy7MAW3BfN5JmCN0BKhC/29Af/A0xAxcqnNaJsqdQw
	 jz4rYFH1KuXern7S9vZxxAzgMVUuC6tETY01DTeBUtG7Og5TlstW2LFXaBsU5C5EFt
	 qR5Yn49exu86g==
From: Daniel Wagner <wagi@kernel.org>
Date: Wed, 26 Feb 2025 19:45:59 +0100
Subject: [PATCH 07/11] nvmet-fc: update tgtport ref per assoc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-nvmet-fcloop-v1-7-c0bd83d43e6a@kernel.org>
References: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
In-Reply-To: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

We need to take for each unique association a reference.
nvmet_fc_alloc_hostport for each newly created association.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 3ef4beacde3257147a59321e8f13451326302de0..b807b4c05cac7fe4764df3df76f8fa50f4bab6ba 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1157,6 +1157,7 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 		goto out_ida;
 
 	assoc->tgtport = tgtport;
+	nvmet_fc_tgtport_get(tgtport);
 	assoc->a_id = idx;
 	INIT_LIST_HEAD(&assoc->a_list);
 	kref_init(&assoc->ref);
@@ -1258,6 +1259,8 @@ nvmet_fc_delete_target_assoc(struct nvmet_fc_tgt_assoc *assoc)
 	dev_info(tgtport->dev,
 		"{%d:%d} Association deleted\n",
 		tgtport->fc_target_port.port_num, assoc->a_id);
+
+	nvmet_fc_tgtport_put(tgtport);
 }
 
 static struct nvmet_fc_tgt_assoc *

-- 
2.48.1


