Return-Path: <linux-kernel+bounces-172388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2868BF1BE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 01:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 225EDB28BBA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 23:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79CF1465B2;
	Tue,  7 May 2024 23:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cqo8ySPw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030DC146597;
	Tue,  7 May 2024 23:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123393; cv=none; b=VxFgJiTSNe2i49Sp5H/og4ETPle5JkqkWDTJKxl/lHW/1xT1bPY/yRUtu5u292aiTTWfpiHtUF4ast53EfjHasF0EpEU7q51M3I38Pt6m5UwSaGGcJ7aA38gWL9esbpPQyRZPHYLShwIYvNmMFH1X+QFCSokXNef81yoA40l8+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123393; c=relaxed/simple;
	bh=eReVYF2BCrlIPA5oKYsRheyDizBUKVOYu2q3Y2uoyew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WHJL/li8JTT1aCkC0oznGstAHEB3OfjJixNb8xd+UZj/KhBaEFHtwkXQwgGwMreQEE1BYFdr0gKPmSXdjjJr3aMqKtJbzxk6VXzwucYF1xwH/dfXN+j7mkgc4Vw7kQZJwPAYgC8LGB1UXb61GShwawlPhaStEhKF3W/ycaG16d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cqo8ySPw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D779CC2BBFC;
	Tue,  7 May 2024 23:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123392;
	bh=eReVYF2BCrlIPA5oKYsRheyDizBUKVOYu2q3Y2uoyew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cqo8ySPwk3C0pG13Dmd+CcADEH/cn+FxaMYKxGqDRKs6SuZmm7Il0g70uW5wsfTFE
	 WSyYIc0bDCdYx8h5seI7L3MP20FaKBwHsTaHwLBrGKWMqRu26GA8QkvAZ+Sj7pTSs2
	 UClHaOCl+pRDCuWEmOgl/SHCwQJPyqYFLRqEV13WizCtk/ZyDv57V62tsmOIyN8GMY
	 rQSDiQ/I2+UmcJwPh3jX9QWQu8ZWdm0atYIcePiv85/QqbmyoYmatjFhgxdLyiS/qs
	 gqY56CnRzrtu1g9yo5kfZCn/Fv8xvkwy+z2JoWufQr/glGuMzJvlMhN9ftIwiwGJoZ
	 lW/8O6cGd67Jw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.8 45/52] nvme: find numa distance only if controller has valid numa id
Date: Tue,  7 May 2024 19:07:11 -0400
Message-ID: <20240507230800.392128-45-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507230800.392128-1-sashal@kernel.org>
References: <20240507230800.392128-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.9
Content-Transfer-Encoding: 8bit

From: Nilay Shroff <nilay@linux.ibm.com>

[ Upstream commit 863fe60ed27f2c85172654a63c5b827e72c8b2e6 ]

On system where native nvme multipath is configured and iopolicy
is set to numa but the nvme controller numa node id is undefined
or -1 (NUMA_NO_NODE) then avoid calculating node distance for
finding optimal io path. In such case we may access numa distance
table with invalid index and that may potentially refer to incorrect
memory. So this patch ensures that if the nvme controller numa node
id is -1 then instead of calculating node distance for finding optimal
io path, we set the numa node distance of such controller to default 10
(LOCAL_DISTANCE).

Link: https://lore.kernel.org/all/20240413090614.678353-1-nilay@linux.ibm.com/
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/multipath.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 74de1e64aeead..75386d3e0f981 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -247,7 +247,8 @@ static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
 		if (nvme_path_is_disabled(ns))
 			continue;
 
-		if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_NUMA)
+		if (ns->ctrl->numa_node != NUMA_NO_NODE &&
+		    READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_NUMA)
 			distance = node_distance(node, ns->ctrl->numa_node);
 		else
 			distance = LOCAL_DISTANCE;
-- 
2.43.0


