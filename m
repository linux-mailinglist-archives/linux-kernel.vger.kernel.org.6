Return-Path: <linux-kernel+bounces-565973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 480D9A671AE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 732103AB171
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339BF20C48E;
	Tue, 18 Mar 2025 10:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4xeDqZZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9094C20C034
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 10:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742294445; cv=none; b=im00HAVksgpzXjOlCsdYqk1J2aqsL1jIgHBiDuJ9UHcLMo5TluFVwMJ+V2aHj6CF/YlcRXvgh0I60Ugxd1qArEEb6y+RAtT4PHupgqwcvgLiCjoXuPqOxlMU4+9/XACmdzYYp6fEOJ3RzmOQkqhLlTt9Pp8h4Ww1ttsFOFo1bpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742294445; c=relaxed/simple;
	bh=xhWX+5IOa0crE05apLEVrNBm4agJvraayK65++Qyx48=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cduc5vFa3DfBkPig/O8x1fx3n/0w85tvqnoAUKIbmHXSErB92YBEsarPIKpfZfwROGgXCHXQXxLZDeuCx3gsWRdgUfJ4dgdiUDqLSpMWlTLQOpN0VqPpGoSViXmno5YnBFFmSlpzf3WKiVik5Lw3EDy6HHz2k4DTGwjj9kQM3i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4xeDqZZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B16C6C4CEDD;
	Tue, 18 Mar 2025 10:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742294445;
	bh=xhWX+5IOa0crE05apLEVrNBm4agJvraayK65++Qyx48=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=O4xeDqZZUSZGXxLJZa4WtR1HktQKziBrn+md4R62yJDqqFxcCzmUcafpI2spW60tK
	 lEYNm+Bd+Oi20KA4FHnbZ2aDyP5jW5j8qL99IqECooG0q/sBJPsMzog/DOTj7A1uA7
	 xW2/ece/dVgY8F4eLaqiphdAie1H9nPBs71fqa6yMMxTylVgGl4wRnH/TvD0RpBrdc
	 cqjGQACLxK+wXI624tnT+rSXp1LBz0b1HN53L4T0cylGPnxf81l3cq7mKVg5oXVHeg
	 Dg5VAQHkPqeFzCr7N9skzvgfPHIrAWFvvLDDNLHPNw2QYkGiWee9wRPEJ4zumSTGjE
	 J1rL2VNJgdD0A==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 18 Mar 2025 11:40:11 +0100
Subject: [PATCH v3 17/18] nvmet-fc: put ref when assoc->del_work is already
 scheduled
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-nvmet-fcloop-v3-17-05fec0fc02f6@kernel.org>
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
In-Reply-To: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

Do not leak the tgtport reference when the work is already scheduled.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 649afce908bbade0a843efc4b8b76105c164b035..e027986e35098acbe5f97dcbcc845b9d46b88923 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1087,7 +1087,8 @@ static void
 nvmet_fc_schedule_delete_assoc(struct nvmet_fc_tgt_assoc *assoc)
 {
 	nvmet_fc_tgtport_get(assoc->tgtport);
-	queue_work(nvmet_wq, &assoc->del_work);
+	if (!queue_work(nvmet_wq, &assoc->del_work))
+		nvmet_fc_tgtport_put(assoc->tgtport);
 }
 
 static bool

-- 
2.48.1


