Return-Path: <linux-kernel+bounces-387497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3DF9B51FA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 19:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8751DB2282B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 18:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F43201003;
	Tue, 29 Oct 2024 18:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVTiQCo5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE72206E9C
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 18:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730227218; cv=none; b=dYZ5RN/83k2xJOiTlv1SmSf/IQqiKkMtbX6+tVnlvMIfTLSI83sFh7K8qIOWFss0a8/mpzxb7SNAle/OP9j7ZD1CMKCHQReVuArAvQQ97j2eSbx7gSnxnOI0eAVpjDCjAVO0hRXBXCAZl+tghl+ZycIfE5pu+0Xn2LDnORXG20M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730227218; c=relaxed/simple;
	bh=VDZ0GWvuIDKmyjXw4HNBrgCTRGRRu8R8QLoqZy/Abbs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EwhRv7/Krs/uyo+Q15BEThuSUjgdMheRr8+06kKxA24gH4jzh+8AaitAShn8P//DpN0UM4LEab7SB7oobYqLdtPCiUCuv5E/r01L4GlvFJanjWnBDbkfmB06sNBOFy1qJjdSIawdaj6WbMrl5NcEp4uwuRM4zd4tCtgxCNNogGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVTiQCo5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C8EDC4CEEC;
	Tue, 29 Oct 2024 18:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730227217;
	bh=VDZ0GWvuIDKmyjXw4HNBrgCTRGRRu8R8QLoqZy/Abbs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hVTiQCo54748IXplr9fghSmm3UtWEbpWWa7I/JNYnKmqYvJZ9+WXdXG8Q+sQGMGpb
	 S3Ai73vp5dxIdtgGjH6XA4sj2R+S0IbwKZWdvO/+NPRXrnikgtbgBO4+gdIBRj5HnG
	 hQfkoyO/XB/rCrzCDvXZ0vZsLqdRRGxfZR6k/huHptj9AFNrtroLSmGMzjgjZeTKys
	 rsB3eH1YBImyunPOMxVQ7L7reg9FQtRSzZkKLih3JbrTrqb9gVyolXfTp2KJhl4W6U
	 JX7CnvnzHrM3KEVZj8496xjpmEIbrjxJlqNtZ3USCwd0t4PgJPiv4T4Nq7pZibSe7Z
	 xtZwc7b3sm5JQ==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 29 Oct 2024 19:40:11 +0100
Subject: [PATCH v2 1/2] nvme-fc: go straight to connecting state when
 initializing
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-nvme-fc-handle-com-lost-v2-1-5b0d137e2a0a@kernel.org>
References: <20241029-nvme-fc-handle-com-lost-v2-0-5b0d137e2a0a@kernel.org>
In-Reply-To: <20241029-nvme-fc-handle-com-lost-v2-0-5b0d137e2a0a@kernel.org>
To: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@suse.de>, Paul Ely <paul.ely@broadcom.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

The initial controller initialization mimiks the reconnect loop
behavior by switching from NEW to RESETTING and then to CONNECTING.

The transition from NEW to CONNECTING is a valid transition, so there is
no point entering the RESETTING state. TCP and RDMA also transition
directly to CONNECTING state.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/host/fc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index b81af7919e94c421387033bf8361a9cf8a867486..d45ab530ff9b7bd03bc311474278fc840f8786d5 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3579,8 +3579,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	list_add_tail(&ctrl->ctrl_list, &rport->ctrl_list);
 	spin_unlock_irqrestore(&rport->lock, flags);
 
-	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING) ||
-	    !nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
+	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
 		dev_err(ctrl->ctrl.device,
 			"NVME-FC{%d}: failed to init ctrl state\n", ctrl->cnum);
 		goto fail_ctrl;

-- 
2.47.0


