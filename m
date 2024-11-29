Return-Path: <linux-kernel+bounces-425396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C42A9DC186
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 10:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 781B0B24684
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 09:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0334C18A6C2;
	Fri, 29 Nov 2024 09:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qx3G+Cv8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DE1189F3B
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 09:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732872516; cv=none; b=P7WUOXLI/BE0IUcGQIPRMcINSLIDB0f5jTdcDEW/tLp2lAD1gHzjVotJockky6oKYZvExgYzn3cuoeTk+XzwOej6eagGjllaB3cKYXGioh9r8iKTiBhezCiBeAQL5cTMsDL1+ppbENv29+Z41ZAQOJnQeAI6ycnC+xQUxNiaQXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732872516; c=relaxed/simple;
	bh=zipAIlJ40bkL0Mod12OfQfmtAm7/0GgYfeae3gXItQM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UTYlkgFHYAJoC3GN+9vu7VeNWz+0mcSF1+aWJo9rrg4irPZYfCIpRLedhCIYnvTEIYyzX0dUjdjpTWUzCzPfLb6iZGhAnUFtFwsIceeoFbb3J2MCQH20xVfUs70dVMzhfVFVMzGqVgDUAdRWPCrqESYouZadZP7ZLzh/CutN5JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qx3G+Cv8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B3EC4CECF;
	Fri, 29 Nov 2024 09:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732872516;
	bh=zipAIlJ40bkL0Mod12OfQfmtAm7/0GgYfeae3gXItQM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Qx3G+Cv8fSe5QyR0gx7bjPbEP//SQQBAU9RNjl4LM0VuT25DVgdP0Keh27Bz63mxy
	 LccmaL88EB6Pn29OfsIheagaIHTU74NA1tn8nKEozPAiI2SdgnUbj2XZYdX/BBLOoE
	 CjLoAu/FsHnbnJpgsDASmGeM4rP4grBw4e6DuLEuWEqOY6iM1eBiC42g7HYOimbXQ4
	 QsvJX4R84PmMm/A+BeGzjp9e637sRQb5RK5gUhItH4eJDkgL55YmgYkotl3enoUQOU
	 TFI3+8dMsSRHCPUgaJk4TnUWhIohUj8tmppfkQVE/vdm2KFMqTDrmxxgs842eCVY+c
	 WILDpKTNuUsKA==
From: Daniel Wagner <wagi@kernel.org>
Date: Fri, 29 Nov 2024 10:28:25 +0100
Subject: [PATCH v3 3/3] nvme: handle connectivity loss in
 nvme_set_queue_count
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241129-nvme-fc-handle-com-lost-v3-3-d8967b3cae54@kernel.org>
References: <20241129-nvme-fc-handle-com-lost-v3-0-d8967b3cae54@kernel.org>
In-Reply-To: <20241129-nvme-fc-handle-com-lost-v3-0-d8967b3cae54@kernel.org>
To: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@suse.de>, Paul Ely <paul.ely@broadcom.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

When the set feature attempts fails with any NVME status code set in
nvme_set_queue_count, the function still report success. Though the
numbers of queues set to 0. This is done to support controllers in
degraded state (the admin queue is still up and running but no IO
queues).

Though there is an exception. When nvme_set_features reports an host
path error, nvme_set_queue_count should propagate this error as the
connectivity is lost, which means also the admin queue is not working
anymore.

Fixes: 9a0be7abb62f ("nvme: refactor set_queue_count")
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/host/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2a07c2c540b26c8cbe886711abaf6f0afbe6c4df..aa2a7c7d4d0ae7bd1f7fb704e55c0a8d724b9d56 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1677,7 +1677,12 @@ int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count)
 
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


