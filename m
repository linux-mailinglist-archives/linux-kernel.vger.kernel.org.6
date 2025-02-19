Return-Path: <linux-kernel+bounces-522441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C62BA3CA64
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7907E1893B98
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 20:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67342500B1;
	Wed, 19 Feb 2025 20:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uTBxcHeu"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5183324F5A0
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 20:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739998387; cv=none; b=NKXdWf47wSEGYhAQ4drfB5t67tsftevAHnCJ6puhqg5x6/x7EPRTkaSRfLxn6kR9nFm6sqSCh5aNCPDGpdTC15hqbKJmWct0l6Q9JXYMzwj7XnloqXZhpuelQ48Pau4CZrCvJkeXzGtCcsEFzhTowaH+8TVt8z1t7N8LBK9Fc1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739998387; c=relaxed/simple;
	bh=M83TtgbrER6UNWgXcPNxTgIFEIobEBu4z+QkHohiso8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gh78pLdsdpahtAAmaFbjw/y2GiZw+CuTS52fTTfzxxXL9xRBnfmsGIaLEuw1XFhrarFuQnR+IU62TFikdYJpLfL26pvS/3p8w2JECWc7QGiUhPyv56+W3xdV3KJDZBwYTHcTC45DEL/KyqArTvEInMP6GSF7pqZegMatgxgacfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uTBxcHeu; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739998381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=62TWYWfurD75dgItUwaw8GfL5rYSw4VdoP88WF6wNFM=;
	b=uTBxcHeuhkYZRT5PoH5+j3vBtLhfGq+9oPay8WwmzGWjvb6VNos6fgyvVmy4ooyXneBXQj
	SIIfAXzI0RWeLvh/FAONkNWvu7n1G4IoYoWlTzBUU0klJ4MAw053iSbM5jzNdQH51fp/I5
	fs4T5Kpm+qtEDYgHFl6kEGkx3eO1n0s=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/mlx5: Use secs_to_jiffies() instead of msecs_to_jiffies()
Date: Wed, 19 Feb 2025 21:52:35 +0100
Message-ID: <20250219205235.28361-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use secs_to_jiffies() and simplify the code.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/infiniband/hw/mlx5/mr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index bb02b6adbf2c..b526e322c7b0 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -2033,7 +2033,7 @@ static int mlx5_revoke_mr(struct mlx5_ib_mr *mr)
 		spin_lock_irq(&ent->mkeys_queue.lock);
 		if (ent->is_tmp && !ent->tmp_cleanup_scheduled) {
 			mod_delayed_work(ent->dev->cache.wq, &ent->dwork,
-					 msecs_to_jiffies(30 * 1000));
+					 secs_to_jiffies(30));
 			ent->tmp_cleanup_scheduled = true;
 		}
 		spin_unlock_irq(&ent->mkeys_queue.lock);
-- 
2.48.1


