Return-Path: <linux-kernel+bounces-425395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 134759DC185
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 10:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69698165242
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 09:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925F9189B83;
	Fri, 29 Nov 2024 09:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYIU3kTc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F375018871F
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 09:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732872514; cv=none; b=BsH2PDTUB8lTiqDibDhX9bOe0YUCQRe9CiqnNOJsmcEBQ3B5vDRaT4V+qbVo2I58/Gbe3KMXryTwAYVtsktGBFDDwoiBI/uveA4Ow4JTy6+4n7LafWGmwpTXqwZ2d0rM+66lay3lkHMcR75i8RFxQ4UCxsbbLdPF+mRU8Nx8e8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732872514; c=relaxed/simple;
	bh=TgNLwVPj3jf02aA6QhpO9/SZFpU6FwXvEUCRi1VCNPU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WwGkXGEC2L63sptaH2LvnK1BPCt+ofxOBqY/iypL/AevNpT1wVEnZDhqMoPcxFFO5AsANicSiPhYDv3bp+IekJRolDvIKvNE0+07OnrNWCW1q9Ju30zCUmWzKE7UY+XAnfIcMdB11h+VjukbQES/U/cuZs4YS3JmV8ppBnSiyRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYIU3kTc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB91C4CED3;
	Fri, 29 Nov 2024 09:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732872513;
	bh=TgNLwVPj3jf02aA6QhpO9/SZFpU6FwXvEUCRi1VCNPU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VYIU3kTc6tberHp+R6HuYsH0bg3ouyE6ML+V+ahKQwZ8EPCopRnZ/smfIEbnDOyUA
	 FOM95jDoVeqJkaCRAfFPA6k9jLnj5BWIOdZhcAjvNuxmIl/7qsBtUvjyT/MkTQaLY0
	 miTXq7H4EUk7uaJEHwlgINI6rs9cgsRVlQ3jZVeWgBI4YMhKYQK2G7DzHUYXI+rlco
	 RHrsff97JiG1LHD+1t2jYxJoM1rNy8jFWF55rk+XzosSSY0byPtCpoVk/tpsgm1eKL
	 /730dRG7hZJ2VVXDXb5yrJRZWvjKHR7zXqRhsdZn2u0vxhN0NLvtlatfNySvA1iMT8
	 JL4vtk9oK4YyA==
From: Daniel Wagner <wagi@kernel.org>
Date: Fri, 29 Nov 2024 10:28:24 +0100
Subject: [PATCH v3 2/3] nvme: trigger reset when keep alive fails
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241129-nvme-fc-handle-com-lost-v3-2-d8967b3cae54@kernel.org>
References: <20241129-nvme-fc-handle-com-lost-v3-0-d8967b3cae54@kernel.org>
In-Reply-To: <20241129-nvme-fc-handle-com-lost-v3-0-d8967b3cae54@kernel.org>
To: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@suse.de>, Paul Ely <paul.ely@broadcom.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

nvme_keep_alive_work setups a keep alive command and uses
blk_execute_rq_nowait to send out the command in an asynchronously
manner. Eventually, nvme_keep_alive_end_io is called. If the status
argument is 0, a new keep alive is send out. When the status argument is
not 0, only an error is logged. The keep alive machinery does not
trigger the error recovery.

The FC driver is relying on the keep alive machinery to trigger recovery
when an error is detected. Whenever an error happens during the creation
of the association the idea is that the operation is aborted and retried
later. Though there is a window where an error happens and
nvme_fc_create_assocation can't detect the error.

         1) nvme nvme10: NVME-FC{10}: create association : ...
         2) nvme nvme10: NVME-FC{10}: controller connectivity lost. Awaiting Reconnect
            nvme nvme10: queue_size 128 > ctrl maxcmd 32, reducing to maxcmd
         3) nvme nvme10: Could not set queue count (880)
            nvme nvme10: Failed to configure AEN (cfg 900)
         4) nvme nvme10: NVME-FC{10}: controller connect complete
         5) nvme nvme10: failed nvme_keep_alive_end_io error=4

A connection attempt starts 1) and the ctrl is in state CONNECTING.
Shortly after the LLDD driver detects a connection lost event and calls
nvme_fc_ctrl_connectivity_loss 2). Because we are still in CONNECTING
state, this event is ignored.

nvme_fc_create_association continues to run in parallel and tries to
communicate with the controller and those commands fail. Though these
errors are filtered out, e.g in 3) setting the I/O queues numbers fails
which leads to an early exit in nvme_fc_create_io_queues. Because the
number of IO queues is 0 at this point, there is nothing left in
nvme_fc_create_association which could detected the connection drop.
Thus the ctrl enters LIVE state 4).

The keep alive timer fires and a keep alive command is send off but
gets rejected by nvme_fc_queue_rq and the rq status is set to
NVME_SC_HOST_PATH_ERROR. The nvme status is then mapped to a block layer
status BLK_STS_TRANSPORT/4 in nvme_end_req. Eventually,
nvme_keep_alive_end_io sees the status != 0 and just logs an error 5).

We should obviously detect the problem in 3) and abort there (will
address this later), but that still leaves a race window open. There is
a race window open in nvme_fc_create_association after starting the IO
queues and setting the ctrl state to LIVE.

Thus trigger a reset from the keep alive handler when an error is
reported.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/host/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index bfd71511c85f8b1a9508c6ea062475ff51bf27fe..2a07c2c540b26c8cbe886711abaf6f0afbe6c4df 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1320,6 +1320,12 @@ static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
 		dev_err(ctrl->device,
 			"failed nvme_keep_alive_end_io error=%d\n",
 				status);
+		/*
+		 * The driver reports that we lost the connection,
+		 * trigger a recovery.
+		 */
+		if (status == BLK_STS_TRANSPORT)
+			nvme_reset_ctrl(ctrl);
 		return RQ_END_IO_NONE;
 	}
 

-- 
2.47.0


