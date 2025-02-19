Return-Path: <linux-kernel+bounces-522437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDA2A3CA61
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3747616F54C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 20:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A5C24E4B7;
	Wed, 19 Feb 2025 20:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cmfkF9iV"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139E4247DE1
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 20:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739998352; cv=none; b=EaUZdLflr7+tCyt8bVfDr6oG0LAhNDnvG8b/908Ryp2CAHGZlie5rG28IKNWcxZA5xhEh118OAD6mFR0Jutyn2dwxBVT/XpJJjQZsLl4Q0wkPXzc9Ir5d4U2Q9tWgIGZxQ2BKN9nf8YoS5tlfCZlDchbDfjizW3wemtYIm2ReGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739998352; c=relaxed/simple;
	bh=yMxpbEFynCsR1qX3Wqi4EAsIur8l51VBZuB9k077bvs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t9RzXhdYAqaIFdYKyPktJn88tG1qm4R6LXt6Z6j/exc5PlY4+LbtOkDHww46waOE/jXKKqg/Cn+H8vBXvVzwoQLq6BC/7hSQwKK5YNXxbhZU/ZVjF5BaMiJHAeJ5HI/2x+zNbLSNSETUTSvMB16ZevTLpFw9Dgo9Wy9wUOf8m9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cmfkF9iV; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739998346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=y5CXcs0Zy2ncJTQugnSwFSyTZ09cYdvUi/pblL+134w=;
	b=cmfkF9iVMOKJvC2dGTZ0JqoW6hHPXybf11QB3pIkuT/c4UKgZiqUO3P3weY4R50LGZ0d+g
	yQkpBX55MDeyWyXtjOynQaEb9DhZ9zujt81HJJQ1Bef8gXJ2Nq87V8v29iKlk98K2rYHtb
	bYN8S76xznh42O4L7APxPFN5oiZqIro=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Itamar Gozlan <igozlan@nvidia.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net/mlx5: Use secs_to_jiffies() instead of msecs_to_jiffies()
Date: Wed, 19 Feb 2025 21:49:42 +0100
Message-ID: <20250219205012.28249-2-thorsten.blum@linux.dev>
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
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
index 3dbd4efa21a2..19dce1ba512d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
@@ -220,7 +220,7 @@ static int hws_bwc_queue_poll(struct mlx5hws_context *ctx,
 			      bool drain)
 {
 	unsigned long timeout = jiffies +
-				msecs_to_jiffies(MLX5HWS_BWC_POLLING_TIMEOUT * MSEC_PER_SEC);
+				secs_to_jiffies(MLX5HWS_BWC_POLLING_TIMEOUT);
 	struct mlx5hws_flow_op_result comp[MLX5HWS_BWC_MATCHER_REHASH_BURST_TH];
 	u16 burst_th = hws_bwc_get_burst_th(ctx, queue_id);
 	bool got_comp = *pending_rules >= burst_th;
-- 
2.48.1


