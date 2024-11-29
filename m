Return-Path: <linux-kernel+bounces-425394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0DA9DC184
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 10:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B14FAB24299
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 09:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C73185E50;
	Fri, 29 Nov 2024 09:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YjVQ4pLY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEFF17DFFA
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 09:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732872511; cv=none; b=XQfqvbECceG7BJoexORVO+aHtbRyXO5eKg9hP4rcK8n3VMJlmtxSnocs7ycEsKQnS07i3QkcrsUCwOckgR+I8DWHTcsUZUF/3bMTJnZbT4mv3E4O4Xzb0vzSOokLhwaElq4xSxOEQKqMIvZnv2XGYNNJZjAZ1fBFlVHEaAUHHBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732872511; c=relaxed/simple;
	bh=tbD5dcEI7VBjbUSCchkwqpnKynf6J6/WxQxL5qjAEfE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rPzdFhj6m2/x/qmlYh+7cOhJ7jp50eSNQOA5XlDnvCvuft4LA7GeWDoz5XeoJEjTvpnHJJUo3s2lU/V2oKLfGuECtWt8nmQMdGItmVR9JqVzWgaXG0zuwCcHV4BrOE4+B4+bfJjhiMesjhV0ruaU2wGTE5AsUIP+cfjY2CSOUrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YjVQ4pLY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E2E9C4CED7;
	Fri, 29 Nov 2024 09:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732872511;
	bh=tbD5dcEI7VBjbUSCchkwqpnKynf6J6/WxQxL5qjAEfE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YjVQ4pLY298afkz41+jXgDBpuwB+S7Kkkdlhj+nslRycC0WBuiSHHzr9hxYW/Djts
	 OnTUlC14M7hSolyGk595IKGskjdtnL8Dy2QFhGJr+WjLpPU7JAa/6D0oOAfZAlRJdr
	 5HJnrVvVTgZOzVGVYm69PhJBdpj97sL8d/payYO1PHrc3LxJB+7sVI508FdjTzqiD0
	 0QQlwx/uaCxvDvOHj/be/HWo2AbRmK7ge2Y86bkx/CMNV9blSpvMVAZAa0XfkJ0YJL
	 3D/tp+68hVriPMHC4FVO6DzaywCdhvvyxNlP3gd5ArBhF3Dyg1S/TgJcBaz/hVJCNk
	 kRsscMJLKl0/A==
From: Daniel Wagner <wagi@kernel.org>
Date: Fri, 29 Nov 2024 10:28:23 +0100
Subject: [PATCH v3 1/3] nvme-fc: go straight to connecting state when
 initializing
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241129-nvme-fc-handle-com-lost-v3-1-d8967b3cae54@kernel.org>
References: <20241129-nvme-fc-handle-com-lost-v3-0-d8967b3cae54@kernel.org>
In-Reply-To: <20241129-nvme-fc-handle-com-lost-v3-0-d8967b3cae54@kernel.org>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
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


