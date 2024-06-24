Return-Path: <linux-kernel+bounces-227549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70119915311
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E58C1B25197
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C3719D09F;
	Mon, 24 Jun 2024 16:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ou5VbYpi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0584C637;
	Mon, 24 Jun 2024 16:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719244820; cv=none; b=jPVKBOQfq7eoNwhldHnOsZ9Y+kLqQiSfoXwJwmUDWcPXQ6mxfJC+AjZbhFuCnjCJYXkpQS5yu41It6TihIzr34zVvKBi/XAYhUwhiEI26eP16HaUDR+CZf2L1UnLI5zSYCPVhahmP4JQQJ/GJ1VCu5ukSA3YOrxFcKzc047cNAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719244820; c=relaxed/simple;
	bh=MO2rJBHnqO9X7BXZpG+TvGojUWxWT0nnspUSRBCxPHE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N08tY7dprl3qSlNiFl/jMK+WJzR99DoQ0VS2BlGYCzZQRx8UKMBdb0Ey1Ofay1CV5pM/JbBudIvgbK+gi5O5YOUfdE5VB1hroC90cQnXibPSU+wbU3f9XL5eJKfJbqUI42EHsqhfWgR1M/sHjXoz3Kt5qARqc/yxrXAz1s7y/Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ou5VbYpi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD003C2BBFC;
	Mon, 24 Jun 2024 16:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719244819;
	bh=MO2rJBHnqO9X7BXZpG+TvGojUWxWT0nnspUSRBCxPHE=;
	h=From:To:Cc:Subject:Date:From;
	b=ou5VbYpiAxbXCp8MEeLMCjCJVXsi5CAApt0FTyMLmqNDiznVzNqaz4kWya0qKnBuP
	 Hcdq7sEnIK2eM7ARzuSTdYYzCBc1lxSOIAfVYXu+SwOQuvU18nV2mmgjTNwKBInS5o
	 hiLdpQufQkka0C+rH4qSGvijaYRzWsAHiG0VKz83o+q8sQ2+ukAjMPmKcsL68Uhhbm
	 QwSS7GCIbIwpYNsV93KygK9X+zPwFj7+QVy/QkM6iJg8gniwMiI7HPsSkXonvT8gbx
	 0lo4JcaUgnhqYojQc6vDuiW/NBPPYjwvq85rFNoz8u7byY4Td0mjOKGrLEhwKUGaw5
	 /uMHpzn61esnw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	Akiva Goldberger <agoldberger@nvidia.com>,
	Bernard Metzler <bmt@zurich.ibm.com>,
	Chengchang Tang <tangchengchang@huawei.com>,
	Cheng Xu <chengyou@linux.alibaba.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Kai Shen <kaishen@linux.alibaba.com>,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Long Li <longli@microsoft.com>,
	Michael Margolin <mrgolin@amazon.com>,
	Mustafa Ismail <mustafa.ismail@intel.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: [PATCH rdma-next v1 0/2] Extend mlx5 CQ creation with large UAR page index
Date: Mon, 24 Jun 2024 19:00:09 +0300
Message-ID: <cover.1719244483.git.leon@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Changelog:
v1:
 * Fixed compilation errors in first patch
 * Changed new attribute name as Jason suggested
v0: https://lore.kernel.org/all/cover.1718554263.git.leon@kernel.org/

------------------------------------------------------------------------

Hi,

This series from Akiva extends the mlx5 private field with the UAR page
index
which is larger than 16 bits as was before.

As this is first time, we extend ioctl API with private data field after
it already has UHW object, we need to change create CQ API signature to
support it.

Thanks

Akiva Goldberger (2):
  RDMA: Pass entire uverbs attr bundle to create cq function
  RDMA/mlx5: Send UAR page index as ioctl attribute

 drivers/infiniband/core/uverbs_cmd.c          |  2 +-
 drivers/infiniband/core/uverbs_std_types_cq.c |  2 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c      |  3 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.h      |  2 +-
 drivers/infiniband/hw/cxgb4/cq.c              |  3 +-
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h        |  2 +-
 drivers/infiniband/hw/efa/efa.h               |  2 +-
 drivers/infiniband/hw/efa/efa_verbs.c         |  3 +-
 drivers/infiniband/hw/erdma/erdma_verbs.c     |  3 +-
 drivers/infiniband/hw/erdma/erdma_verbs.h     |  2 +-
 drivers/infiniband/hw/hns/hns_roce_cq.c       |  3 +-
 drivers/infiniband/hw/hns/hns_roce_device.h   |  2 +-
 drivers/infiniband/hw/irdma/verbs.c           |  5 +--
 drivers/infiniband/hw/mana/cq.c               |  3 +-
 drivers/infiniband/hw/mana/mana_ib.h          |  2 +-
 drivers/infiniband/hw/mlx4/cq.c               |  3 +-
 drivers/infiniband/hw/mlx4/mlx4_ib.h          |  2 +-
 drivers/infiniband/hw/mlx5/cq.c               | 31 ++++++++++++++++---
 drivers/infiniband/hw/mlx5/main.c             |  1 +
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |  3 +-
 drivers/infiniband/hw/mthca/mthca_provider.c  |  3 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c   |  3 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.h   |  2 +-
 drivers/infiniband/sw/rdmavt/cq.c             |  6 ++--
 drivers/infiniband/sw/rdmavt/cq.h             |  2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c         |  3 +-
 drivers/infiniband/sw/siw/siw_verbs.c         |  5 +--
 drivers/infiniband/sw/siw/siw_verbs.h         |  2 +-
 include/rdma/ib_verbs.h                       |  2 +-
 include/uapi/rdma/ib_user_ioctl_cmds.h        |  7 ++---
 include/uapi/rdma/mlx5_user_ioctl_cmds.h      |  4 +++
 31 files changed, 80 insertions(+), 38 deletions(-)

-- 
2.45.2


