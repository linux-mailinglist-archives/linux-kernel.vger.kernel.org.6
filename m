Return-Path: <linux-kernel+bounces-555843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C44A5BD58
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 108B6188098F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9A5238166;
	Tue, 11 Mar 2025 10:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p2D1LHtT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52BB238161
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 10:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741687924; cv=none; b=jUk6ZiR9n00fXRLY2Vbkb93e8TMpECwm9AxhDSZ2yb5yrxjTfE9a68mTTb2CD+NTlTil5fjFC7co6tzW1fGikM/WiXWC7tM+4+I/6jO7DocjU/ModrZABIyUcgviQn4dNlTYcIeVcu4H6ugnioppiH4pOdX6jzKdfKE81pwLZlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741687924; c=relaxed/simple;
	bh=flQexbYF3QilRpaBp1cdduWN7JQejk/TogRhckVTrgQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qBWQ+K72B8vbfoPROhCxjyOXW4o+wBM+pGRzNv1G7RRbce9S6faLq3QuH+Wyik2covvVyVzhJCO4CNd+SpvywMHoJBD+iz4t9Ubur8ojX7tSwdkyAMoWj+dwXTlh6TPds8DCJhbqAVcOOqvy1EP/ReZHtcdAkttK1UR79nHAsu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p2D1LHtT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE0BDC4CEEB;
	Tue, 11 Mar 2025 10:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741687924;
	bh=flQexbYF3QilRpaBp1cdduWN7JQejk/TogRhckVTrgQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=p2D1LHtTuMyBgwVrL57gwsUWRkerZp34wJnjMKv2HjV6IHtMy3o61+Uq7f8Uq7lCx
	 QZEdl/KcKYfYaphPztRdChl5Ss+Bp88fXgdftUDboYvWKJ/XnrFzmIoej9opFhBaZA
	 7/9XQYqnzeT2nwYHiaF4HE2uE2d91prv5vmixDmTNBqGnBbmBuTEpIBE73R7QV2MHS
	 1AvSG5Q6EQxO8kHdTXqLGm4SM2vL0A+vObAMghRRq0N5G+e+19uF9KhnskBzyoelW5
	 QCE4Sel+KPPQAS2DqUDv0bIebpActlGkE49PZhL89NhY7ipEsXBK+frwBABIaoE9Q7
	 9NYnZ0jLq2RjA==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 11 Mar 2025 11:11:35 +0100
Subject: [PATCH v2 09/15] nvmet-fc: update tgtport ref per assoc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-nvmet-fcloop-v2-9-fc40cb64edea@kernel.org>
References: <20250311-nvmet-fcloop-v2-0-fc40cb64edea@kernel.org>
In-Reply-To: <20250311-nvmet-fcloop-v2-0-fc40cb64edea@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

We need to take for each unique association a reference.
nvmet_fc_alloc_hostport for each newly created association.

Reviewed-by: Hannes Reinecke <hare@suse.de>
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


